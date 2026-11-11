-- =====================================================================
-- Tigres do Riacho — cargos, permissões por cargo e unidades
-- Pode rodar mais de uma vez (idempotente). Rode depois do 0001_schema.sql.
-- =====================================================================

-- ---------- Cargo escolhido no cadastro ----------
alter table public.profiles add column if not exists cargo_solicitado text;

-- ---------- Unidades ----------
create table if not exists public.unidades (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  cor text not null default '#F26B1D',
  created_at timestamptz not null default now()
);
create unique index if not exists unidades_nome_idx on public.unidades (lower(nome));

-- Conselheiros que coordenam cada unidade
create table if not exists public.unidade_staff (
  unidade_id uuid not null references public.unidades(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  funcao text not null default 'Conselheiro(a)',
  created_at timestamptz not null default now(),
  primary key (unidade_id, profile_id)
);

alter table public.desbravadores add column if not exists unidade_id uuid references public.unidades(id) on delete set null;
create index if not exists desbravadores_unidade_idx on public.desbravadores(unidade_id);

-- Unidades que já estavam escritas à mão viram unidades de verdade
insert into public.unidades (nome)
select distinct on (lower(trim(unidade))) trim(unidade)
from public.desbravadores
where coalesce(trim(unidade), '') <> ''
on conflict do nothing;
update public.desbravadores d set unidade_id = u.id
from public.unidades u
where d.unidade_id is null and lower(trim(d.unidade)) = lower(u.nome);

-- O texto "unidade" do desbravador acompanha sempre o nome da unidade escolhida
create or replace function public.sync_desb_unidade()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if new.unidade_id is null then
    new.unidade := null;
  else
    select nome into new.unidade from unidades where id = new.unidade_id;
  end if;
  return new;
end $$;
drop trigger if exists desbravadores_unidade on public.desbravadores;
create trigger desbravadores_unidade before insert or update of unidade_id, unidade on public.desbravadores
  for each row execute function public.sync_desb_unidade();
-- padroniza o texto dos que já existiam (ex.: "leões" -> "Leões")
update public.desbravadores set unidade = unidade where unidade_id is not null;

create or replace function public.sync_unidade_nome()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  update desbravadores set unidade = new.nome where unidade_id = new.id;
  return new;
end $$;
drop trigger if exists unidades_nome on public.unidades;
create trigger unidades_nome after update of nome on public.unidades
  for each row execute function public.sync_unidade_nome();

-- ---------- Funções de permissão ----------
create or replace function public.meu_cargo()
returns text language sql stable security definer set search_path = public as $$
  select cargo from profiles where id = auth.uid() and status = 'ativo'
$$;

-- Diretoria que vê tudo (sem poder mudar): secretaria, tesouraria e capelania
create or replace function public.is_leitor()
returns boolean language sql stable security definer set search_path = public as $$
  select public.is_admin() or (public.is_ativo() and public.meu_cargo() in ('Secretário(a)', 'Tesoureiro(a)', 'Capelão'))
$$;

create or replace function public.is_unidade_staff(uid uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select uid is not null and exists (
    select 1 from unidade_staff s join profiles p on p.id = s.profile_id
    where s.unidade_id = uid and s.profile_id = auth.uid() and p.status = 'ativo'
  ) and public.sessao_verificada()
$$;

create or replace function public.can_view_desbravador(did uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select public.is_leitor() or exists (
    select 1 from desbravadores d
    where d.id = did and (public.is_class_staff(d.class_id) or public.is_unidade_staff(d.unidade_id))
  )
$$;

-- ---------- Classes só com instrutores, unidades só com conselheiros ----------
create or replace function public.check_class_staff()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if not exists (select 1 from profiles where id = new.profile_id and cargo = 'Instrutor(a)') then
    raise exception 'Só instrutores podem coordenar classes.';
  end if;
  new.funcao := 'Instrutor(a)';
  return new;
end $$;
drop trigger if exists class_staff_check on public.class_staff;
create trigger class_staff_check before insert or update on public.class_staff
  for each row execute function public.check_class_staff();

create or replace function public.check_unidade_staff()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if not exists (select 1 from profiles where id = new.profile_id and cargo = 'Conselheiro(a)') then
    raise exception 'Só conselheiros podem coordenar unidades.';
  end if;
  new.funcao := 'Conselheiro(a)';
  return new;
end $$;
drop trigger if exists unidade_staff_check on public.unidade_staff;
create trigger unidade_staff_check before insert or update on public.unidade_staff
  for each row execute function public.check_unidade_staff();

-- Quem muda de cargo sai das classes/unidades que não combinam mais com o cargo
create or replace function public.cargo_mudou()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if new.cargo is distinct from old.cargo then
    if new.cargo <> 'Instrutor(a)' then delete from class_staff where profile_id = new.id; end if;
    if new.cargo <> 'Conselheiro(a)' then delete from unidade_staff where profile_id = new.id; end if;
  end if;
  return new;
end $$;
drop trigger if exists profiles_cargo_mudou on public.profiles;
create trigger profiles_cargo_mudou after update of cargo on public.profiles
  for each row execute function public.cargo_mudou();

-- ---------- Cadastro: guarda o cargo escolhido ----------
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  primeiro boolean;
  pelo_diretor boolean := coalesce((new.raw_user_meta_data->>'criado_pelo_diretor')::boolean, false);
begin
  select not exists (select 1 from profiles) into primeiro;
  insert into profiles (id, nome, email, telefone, data_nascimento, cargo, cargo_solicitado, is_admin, status)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'nome', ''),
    coalesce(new.email, ''),
    new.raw_user_meta_data->>'telefone',
    nullif(new.raw_user_meta_data->>'data_nascimento', '')::date,
    case when primeiro then 'Diretor' else 'Aguardando aprovação' end,
    nullif(new.raw_user_meta_data->>'cargo', ''),
    primeiro,
    case when primeiro then 'ativo'::status_membro else 'pendente'::status_membro end
  );
  -- avisa os administradores (não quando o próprio diretor criou a conta)
  if not primeiro and not pelo_diretor then
    insert into notificacoes (destinatario_id, tipo, titulo, mensagem, link)
    select p.id, 'cadastro', 'Novo cadastro aguardando aprovação',
           coalesce(new.raw_user_meta_data->>'nome', new.email)
             || coalesce(' (' || nullif(new.raw_user_meta_data->>'cargo', '') || ')', '')
             || ' se cadastrou e está na lista de espera.',
           '/diretoria'
    from profiles p where p.is_admin and p.status = 'ativo';
  end if;
  return new;
end $$;

-- ---------- Views (recriadas: ganharam colunas novas) ----------
drop view if exists public.membros_view;
drop view if exists public.desbravadores_view;
create view public.membros_view with (security_invoker = true) as
  select p.*, public.idade(p.data_nascimento) as idade,
    coalesce((select json_agg(json_build_object('class_id', s.class_id, 'funcao', s.funcao))
              from class_staff s where s.profile_id = p.id), '[]'::json) as classes,
    coalesce((select json_agg(json_build_object('unidade_id', s.unidade_id, 'funcao', s.funcao))
              from unidade_staff s where s.profile_id = p.id), '[]'::json) as unidades
  from profiles p;

create view public.desbravadores_view with (security_invoker = true) as
  select d.*, public.idade(d.data_nascimento) as idade, c.nome as classe_nome, c.slug as classe_slug, c.cor as classe_cor,
    u.cor as unidade_cor
  from desbravadores d
  left join classes c on c.id = d.class_id
  left join unidades u on u.id = d.unidade_id;

grant select on public.membros_view to authenticated;
grant select on public.desbravadores_view to authenticated;

-- ---------- RLS ----------
alter table public.unidades enable row level security;
alter table public.unidade_staff enable row level security;

drop policy if exists unidades_select on public.unidades;
create policy unidades_select on public.unidades for select to authenticated using (public.is_ativo());
drop policy if exists unidades_admin on public.unidades;
create policy unidades_admin on public.unidades for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

drop policy if exists unidade_staff_select on public.unidade_staff;
create policy unidade_staff_select on public.unidade_staff for select to authenticated
  using (profile_id = auth.uid() or public.is_ativo());
drop policy if exists unidade_staff_admin on public.unidade_staff;
create policy unidade_staff_admin on public.unidade_staff for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- desbravadores: secretaria/tesouraria/capelania veem todos; conselheiro vê e edita os da sua unidade
drop policy if exists desb_select on public.desbravadores;
create policy desb_select on public.desbravadores for select to authenticated
  using (public.is_leitor() or public.is_class_staff(class_id) or public.is_unidade_staff(unidade_id));
drop policy if exists desb_insert on public.desbravadores;
create policy desb_insert on public.desbravadores for insert to authenticated
  with check (public.is_admin() or public.is_class_staff(class_id) or public.is_unidade_staff(unidade_id));
drop policy if exists desb_update on public.desbravadores;
create policy desb_update on public.desbravadores for update to authenticated
  using (public.is_admin() or public.is_class_staff(class_id) or public.is_unidade_staff(unidade_id))
  with check (public.is_admin() or public.is_class_staff(class_id) or public.is_unidade_staff(unidade_id));

-- progresso: quem pode ver o desbravador vê; só diretor e instrutor da classe marcam
drop policy if exists prog_all on public.caderno_progresso;
drop policy if exists prog_select on public.caderno_progresso;
create policy prog_select on public.caderno_progresso for select to authenticated
  using (public.can_view_desbravador(desbravador_id));
drop policy if exists prog_write on public.caderno_progresso;
create policy prog_write on public.caderno_progresso for insert to authenticated
  with check (public.can_manage_desbravador(desbravador_id));
drop policy if exists prog_update on public.caderno_progresso;
create policy prog_update on public.caderno_progresso for update to authenticated
  using (public.can_manage_desbravador(desbravador_id)) with check (public.can_manage_desbravador(desbravador_id));
drop policy if exists prog_delete on public.caderno_progresso;
create policy prog_delete on public.caderno_progresso for delete to authenticated
  using (public.can_manage_desbravador(desbravador_id));

drop policy if exists desb_esp_all on public.desbravador_especialidades;
drop policy if exists desb_esp_select on public.desbravador_especialidades;
create policy desb_esp_select on public.desbravador_especialidades for select to authenticated
  using (public.can_view_desbravador(desbravador_id));
drop policy if exists desb_esp_insert on public.desbravador_especialidades;
create policy desb_esp_insert on public.desbravador_especialidades for insert to authenticated
  with check (public.can_manage_desbravador(desbravador_id));
drop policy if exists desb_esp_update on public.desbravador_especialidades;
create policy desb_esp_update on public.desbravador_especialidades for update to authenticated
  using (public.can_manage_desbravador(desbravador_id)) with check (public.can_manage_desbravador(desbravador_id));
drop policy if exists desb_esp_delete on public.desbravador_especialidades;
create policy desb_esp_delete on public.desbravador_especialidades for delete to authenticated
  using (public.can_manage_desbravador(desbravador_id));
