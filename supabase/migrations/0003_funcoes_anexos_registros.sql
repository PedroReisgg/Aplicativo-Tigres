-- =====================================================================
-- Tigres do Riacho: mais de uma função por membro, validação do diretor,
-- comprovantes (anexos) das especialidades e registro de atividades.
-- Pode rodar mais de uma vez (idempotente). Rode depois do 0002.
-- =====================================================================

-- ---------- Funções (cargos) múltiplas ----------
alter table public.profiles add column if not exists funcoes text[] not null default '{}';

create or replace function public.lista_funcoes()
returns text[] language sql immutable as $$
  select array['Diretor', 'Diretor Associado', 'Secretário(a)', 'Tesoureiro(a)', 'Capelão', 'Instrutor(a)', 'Conselheiro(a)']::text[]
$$;

-- remove repetidas e desconhecidas e põe na ordem de importância
create or replace function public.ordenar_funcoes(f text[])
returns text[] language sql immutable as $$
  select coalesce(array_agg(x order by array_position(public.lista_funcoes(), x)), '{}'::text[])
  from (select distinct x from unnest(coalesce(f, '{}'::text[])) x where x = any(public.lista_funcoes())) s
$$;

update public.profiles set funcoes = array[cargo]
where coalesce(array_length(funcoes, 1), 0) = 0 and cargo = any(public.lista_funcoes());

-- O cargo principal e o acesso de administrador saem das funções
create or replace function public.sync_funcoes()
returns trigger language plpgsql set search_path = public as $$
begin
  -- quem ainda muda só o "cargo" (ex.: telas antigas) troca a função principal
  if tg_op = 'UPDATE' and new.funcoes is not distinct from old.funcoes and new.cargo is distinct from old.cargo
     and new.cargo = any(public.lista_funcoes()) and not (new.cargo = any(new.funcoes)) then
    new.funcoes := array[new.cargo];
  end if;
  if tg_op = 'INSERT' and coalesce(array_length(new.funcoes, 1), 0) = 0 and new.cargo = any(public.lista_funcoes()) then
    new.funcoes := array[new.cargo];
  end if;
  new.funcoes := public.ordenar_funcoes(new.funcoes);
  if coalesce(array_length(new.funcoes, 1), 0) > 0 then
    new.cargo := new.funcoes[1];
    new.is_admin := new.funcoes && array['Diretor', 'Diretor Associado']::text[];
  end if;
  return new;
end $$;
-- o nome começa com "profiles_s" para rodar depois de "profiles_protect"
drop trigger if exists profiles_sync_funcoes on public.profiles;
create trigger profiles_sync_funcoes before insert or update on public.profiles
  for each row execute function public.sync_funcoes();

-- Só administradores mudam cargo, funções, status e admin
create or replace function public.protect_profile()
returns trigger language plpgsql set search_path = public as $$
begin
  if current_user in ('authenticated', 'anon') and not public.is_admin() then
    new.is_admin := old.is_admin;
    new.status := old.status;
    new.cargo := old.cargo;
    new.funcoes := old.funcoes;
    new.email := old.email;
  end if;
  return new;
end $$;

create or replace function public.tem_funcao(f text)
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from profiles where id = auth.uid() and status = 'ativo' and f = any(funcoes))
$$;

create or replace function public.is_leitor()
returns boolean language sql stable security definer set search_path = public as $$
  select public.is_admin() or (public.is_ativo() and exists (
    select 1 from profiles where id = auth.uid() and funcoes && array['Secretário(a)', 'Tesoureiro(a)', 'Capelão']::text[]
  ))
$$;

-- Classes só com quem tem a função de instrutor; unidades só com conselheiros
create or replace function public.check_class_staff()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if not exists (select 1 from profiles where id = new.profile_id and 'Instrutor(a)' = any(funcoes)) then
    raise exception 'Só quem tem a função de instrutor pode coordenar classes.';
  end if;
  new.funcao := 'Instrutor(a)';
  return new;
end $$;

create or replace function public.check_unidade_staff()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if not exists (select 1 from profiles where id = new.profile_id and 'Conselheiro(a)' = any(funcoes)) then
    raise exception 'Só quem tem a função de conselheiro pode coordenar unidades.';
  end if;
  new.funcao := 'Conselheiro(a)';
  return new;
end $$;

-- Quem perde a função sai das classes/unidades correspondentes
create or replace function public.cargo_mudou()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if new.funcoes is distinct from old.funcoes then
    if not ('Instrutor(a)' = any(new.funcoes)) then delete from class_staff where profile_id = new.id; end if;
    if not ('Conselheiro(a)' = any(new.funcoes)) then delete from unidade_staff where profile_id = new.id; end if;
  end if;
  return new;
end $$;
drop trigger if exists profiles_cargo_mudou on public.profiles;
create trigger profiles_cargo_mudou after update of cargo, funcoes on public.profiles
  for each row execute function public.cargo_mudou();

-- a view ganha a coluna nova
drop view if exists public.membros_view;
create view public.membros_view with (security_invoker = true) as
  select p.*, public.idade(p.data_nascimento) as idade,
    coalesce((select json_agg(json_build_object('class_id', s.class_id, 'funcao', s.funcao))
              from class_staff s where s.profile_id = p.id), '[]'::json) as classes,
    coalesce((select json_agg(json_build_object('unidade_id', s.unidade_id, 'funcao', s.funcao))
              from unidade_staff s where s.profile_id = p.id), '[]'::json) as unidades
  from profiles p;
grant select on public.membros_view to authenticated;

-- Quem está na lista de espera não vê nada do clube (nem cadernos e especialidades)
do $$
declare t text;
begin
  foreach t in array array['classes', 'caderno_itens', 'especialidade_categorias', 'especialidades', 'class_especialidades'] loop
    execute format('drop policy if exists %1$s_select on public.%1$s', t);
    execute format('create policy %1$s_select on public.%1$s for select to authenticated using (public.is_ativo())', t);
  end loop;
end $$;
drop policy if exists class_esp_select on public.class_especialidades;

-- ---------- Quem lança especialidades: instrutor da classe ou conselheiro da unidade ----------
create or replace function public.can_registrar_especialidade(did uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select public.can_manage_desbravador(did) or exists (
    select 1 from desbravadores d where d.id = did and public.is_unidade_staff(d.unidade_id)
  )
$$;

-- ---------- Validação do diretor ----------
alter table public.desbravador_especialidades add column if not exists validacao text not null default 'aprovada'
  check (validacao in ('pendente', 'aprovada'));
alter table public.desbravador_especialidades add column if not exists validado_por uuid references public.profiles(id) on delete set null;
alter table public.desbravador_especialidades add column if not exists validado_em timestamptz;
alter table public.desbravador_especialidades add column if not exists updated_at timestamptz not null default now();

alter table public.caderno_progresso add column if not exists validacao text not null default 'aprovada'
  check (validacao in ('pendente', 'aprovada'));
alter table public.caderno_progresso add column if not exists validado_por uuid references public.profiles(id) on delete set null;
alter table public.caderno_progresso add column if not exists validado_em timestamptz;

-- Tudo o que instrutor/conselheiro lança fica "pendente" até o diretor aprovar.
-- O que o próprio diretor lança já nasce aprovado.
-- (sem "security definer": precisa saber quem está fazendo a mudança)
create or replace function public.validar_lancamento()
returns trigger language plpgsql set search_path = public as $$
declare
  concluido text := case when tg_table_name = 'caderno_progresso' then 'feito' else 'concluida' end;
begin
  if tg_table_name = 'desbravador_especialidades' then new.updated_at := now(); end if;
  if current_user in ('authenticated', 'anon') and not public.is_admin() then
    if tg_op = 'INSERT' or new.status is distinct from old.status then
      new.validacao := 'pendente';
      new.validado_por := null;
      new.validado_em := null;
    else
      -- só editou outra coisa: mantém a validação que já tinha
      new.validacao := old.validacao;
      new.validado_por := old.validado_por;
      new.validado_em := old.validado_em;
    end if;
  elsif new.status = concluido and new.validacao = 'aprovada'
        and (tg_op = 'INSERT' or old.validacao <> 'aprovada' or old.status <> concluido) then
    new.validado_por := coalesce(new.validado_por, auth.uid());
    new.validado_em := coalesce(new.validado_em, now());
  end if;
  return new;
end $$;
drop trigger if exists desb_esp_validar on public.desbravador_especialidades;
create trigger desb_esp_validar before insert or update on public.desbravador_especialidades
  for each row execute function public.validar_lancamento();
drop trigger if exists prog_validar on public.caderno_progresso;
create trigger prog_validar before insert or update on public.caderno_progresso
  for each row execute function public.validar_lancamento();

-- Especialidades: instrutor e conselheiro lançam; só o diretor apaga o que já foi aprovado
drop policy if exists desb_esp_insert on public.desbravador_especialidades;
create policy desb_esp_insert on public.desbravador_especialidades for insert to authenticated
  with check (public.can_registrar_especialidade(desbravador_id));
drop policy if exists desb_esp_update on public.desbravador_especialidades;
create policy desb_esp_update on public.desbravador_especialidades for update to authenticated
  using (public.can_registrar_especialidade(desbravador_id)) with check (public.can_registrar_especialidade(desbravador_id));
drop policy if exists desb_esp_delete on public.desbravador_especialidades;
create policy desb_esp_delete on public.desbravador_especialidades for delete to authenticated
  using (public.is_admin() or (public.can_registrar_especialidade(desbravador_id) and validacao <> 'aprovada'));

drop policy if exists prog_delete on public.caderno_progresso;
create policy prog_delete on public.caderno_progresso for delete to authenticated
  using (public.is_admin() or (public.can_manage_desbravador(desbravador_id) and validacao <> 'aprovada'));

-- ---------- Comprovantes das especialidades ----------
create table if not exists public.especialidade_anexos (
  id uuid primary key default gen_random_uuid(),
  desbravador_id uuid not null references public.desbravadores(id) on delete cascade,
  especialidade_codigo text not null references public.especialidades(codigo) on delete cascade,
  caminho text not null,
  nome_arquivo text not null,
  tipo text,
  tamanho bigint,
  enviado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now()
);
create index if not exists esp_anexos_idx on public.especialidade_anexos(desbravador_id, especialidade_codigo);
create index if not exists esp_anexos_caminho_idx on public.especialidade_anexos(caminho);
alter table public.especialidade_anexos enable row level security;

drop policy if exists anexos_select on public.especialidade_anexos;
create policy anexos_select on public.especialidade_anexos for select to authenticated
  using (public.can_view_desbravador(desbravador_id));
drop policy if exists anexos_insert on public.especialidade_anexos;
create policy anexos_insert on public.especialidade_anexos for insert to authenticated
  with check (enviado_por = auth.uid() and public.can_registrar_especialidade(desbravador_id));
drop policy if exists anexos_delete on public.especialidade_anexos;
create policy anexos_delete on public.especialidade_anexos for delete to authenticated
  using (public.is_admin());

-- Arquivos guardados no Storage (pasta = id de quem enviou)
create or replace function public.pode_ver_arquivo(caminho text)
returns boolean language sql stable security definer set search_path = public as $$
  select public.is_ativo() and (
    split_part(caminho, '/', 1) = auth.uid()::text
    or exists (select 1 from especialidade_anexos a where a.caminho = pode_ver_arquivo.caminho and public.can_view_desbravador(a.desbravador_id))
  )
$$;

do $$
begin
  insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
  values ('anexos', 'anexos', false, 52428800, array[
    'image/*', 'video/*', 'application/pdf', 'text/csv',
    'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  ])
  on conflict (id) do update set public = false, file_size_limit = excluded.file_size_limit, allowed_mime_types = excluded.allowed_mime_types;

  drop policy if exists tigres_anexos_select on storage.objects;
  create policy tigres_anexos_select on storage.objects for select to authenticated
    using (bucket_id = 'anexos' and public.pode_ver_arquivo(name));
  drop policy if exists tigres_anexos_insert on storage.objects;
  create policy tigres_anexos_insert on storage.objects for insert to authenticated
    with check (bucket_id = 'anexos' and split_part(name, '/', 1) = auth.uid()::text and public.is_ativo());
  drop policy if exists tigres_anexos_delete on storage.objects;
  create policy tigres_anexos_delete on storage.objects for delete to authenticated
    using (bucket_id = 'anexos' and public.is_admin());
exception when undefined_table or invalid_schema_name then
  raise notice 'Storage não encontrado: anexos desativados neste banco.';
end $$;

-- ---------- Registro de atividades (só o diretor vê) ----------
create table if not exists public.registro_atividades (
  id bigserial primary key,
  created_at timestamptz not null default now(),
  autor_id uuid references public.profiles(id) on delete set null,
  autor_nome text,
  acao text not null,
  tipo text not null check (tipo in ('especialidade', 'caderno')),
  desbravador_id uuid references public.desbravadores(id) on delete set null,
  desbravador_nome text,
  alvo text,
  alvo_nome text,
  detalhe text
);
create index if not exists registro_data_idx on public.registro_atividades(created_at desc);
create index if not exists registro_desb_idx on public.registro_atividades(desbravador_id, created_at desc);
alter table public.registro_atividades enable row level security;
drop policy if exists registro_select on public.registro_atividades;
create policy registro_select on public.registro_atividades for select to authenticated using (public.is_admin());

create or replace function public.registrar_atividade(
  p_acao text, p_tipo text, p_desb uuid, p_alvo text, p_alvo_nome text, p_detalhe text
) returns void language plpgsql security definer set search_path = public as $$
declare
  dnome text;
begin
  select nome into dnome from desbravadores where id = p_desb;
  if dnome is null then return; end if; -- o desbravador foi excluído junto
  insert into registro_atividades (autor_id, autor_nome, acao, tipo, desbravador_id, desbravador_nome, alvo, alvo_nome, detalhe)
  values (auth.uid(), coalesce((select nome from profiles where id = auth.uid()), 'Sistema'), p_acao, p_tipo, p_desb, dnome, p_alvo, p_alvo_nome, p_detalhe);
end $$;

create or replace function public.log_desb_esp()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  r record;
  enome text;
  acao text;
  det text;
begin
  if tg_op = 'DELETE' then r := old; else r := new; end if;
  select nome into enome from especialidades where codigo = r.especialidade_codigo;
  if tg_op = 'INSERT' then
    acao := case when new.status = 'refazer' then 'devolveu' else 'registrou' end;
    det := case when new.status = 'refazer' then new.observacao
                when new.validacao = 'aprovada' then 'Lançada pela diretoria (já aprovada)'
                else 'Aguardando validação do diretor' end;
  elsif tg_op = 'UPDATE' then
    if new.status = 'refazer' and old.status is distinct from 'refazer' then acao := 'devolveu'; det := new.observacao;
    elsif new.status = 'concluida' and old.status = 'refazer' then acao := 'registrou'; det := 'Registrada de novo depois de refazer';
    elsif new.validacao = 'aprovada' and old.validacao = 'pendente' then acao := 'aprovou';
    elsif new.validacao = 'pendente' and old.validacao = 'aprovada' then acao := 'registrou'; det := 'Voltou para validação';
    else return null;
    end if;
  else
    acao := 'removeu';
  end if;
  perform public.registrar_atividade(acao, 'especialidade', r.desbravador_id, r.especialidade_codigo, enome, det);
  return null;
end $$;
drop trigger if exists desb_esp_log on public.desbravador_especialidades;
create trigger desb_esp_log after insert or update or delete on public.desbravador_especialidades
  for each row execute function public.log_desb_esp();

create or replace function public.log_caderno()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  r record;
  inome text;
  icod text;
  acao text;
  det text;
begin
  if tg_op = 'DELETE' then r := old; else r := new; end if;
  select i.codigo, c.nome || ' · ' || i.codigo || ' ' || left(i.texto, 140) into icod, inome
  from caderno_itens i join classes c on c.id = i.class_id where i.id = r.item_id;
  if tg_op = 'INSERT' then
    acao := case when new.status = 'refazer' then 'devolveu' else 'marcou' end;
    det := case when new.status = 'refazer' then new.observacao
                when new.validacao = 'aprovada' then 'Marcado pela diretoria (já aprovado)'
                else 'Aguardando validação do diretor' end;
  elsif tg_op = 'UPDATE' then
    if new.status = 'refazer' and old.status is distinct from 'refazer' then acao := 'devolveu'; det := new.observacao;
    elsif new.status = 'feito' and old.status = 'refazer' then acao := 'marcou'; det := 'Marcado de novo depois de refazer';
    elsif new.validacao = 'aprovada' and old.validacao = 'pendente' then acao := 'aprovou';
    else return null;
    end if;
  else
    acao := 'desmarcou';
  end if;
  perform public.registrar_atividade(acao, 'caderno', r.desbravador_id, icod, inome, det);
  return null;
end $$;
drop trigger if exists prog_log on public.caderno_progresso;
create trigger prog_log after insert or update or delete on public.caderno_progresso
  for each row execute function public.log_caderno();

create or replace function public.log_anexo()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  perform public.registrar_atividade('anexou', 'especialidade', new.desbravador_id, new.especialidade_codigo,
    (select nome from especialidades where codigo = new.especialidade_codigo), new.nome_arquivo);
  return null;
end $$;
drop trigger if exists anexo_log on public.especialidade_anexos;
create trigger anexo_log after insert on public.especialidade_anexos
  for each row execute function public.log_anexo();
