-- =====================================================================
-- 0005 · Biblioteca (livros físicos e PDFs), inventário, vaquinhas e
--        capelão entregando especialidades
-- Rode depois da 0004. Pode rodar de novo sem problema.
-- =====================================================================

-- ---------- Capelão também entrega especialidades (para qualquer desbravador) ----------
create or replace function public.can_registrar_especialidade(did uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select public.can_manage_desbravador(did)
      or exists (select 1 from desbravadores d where d.id = did and public.is_unidade_staff(d.unidade_id))
      or (public.is_ativo() and public.tem_funcao('Capelão') and exists (select 1 from desbravadores d where d.id = did))
$$;

-- =====================================================================
-- Biblioteca
-- =====================================================================
create table if not exists public.livros (
  id uuid primary key default gen_random_uuid(),
  titulo text not null check (length(trim(titulo)) > 0),
  autor text,
  descricao text,
  categoria text,
  capa_path text,
  pdf_path text,
  pdf_nome text,
  pdf_tamanho bigint,
  -- quantos exemplares físicos o clube tem (0 = só o PDF)
  exemplares int not null default 0 check (exemplares >= 0),
  criado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  atualizado_por uuid references public.profiles(id) on delete set null,
  updated_at timestamptz not null default now()
);

create table if not exists public.livro_emprestimos (
  id uuid primary key default gen_random_uuid(),
  livro_id uuid not null references public.livros(id) on delete cascade,
  desbravador_id uuid not null references public.desbravadores(id) on delete cascade,
  emprestado_em date not null default current_date,
  devolver_ate date,
  devolvido_em date,
  observacao text,
  emprestado_por uuid references public.profiles(id) on delete set null,
  devolvido_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now()
);
create index if not exists livro_emp_livro_idx on public.livro_emprestimos(livro_id) where devolvido_em is null;
create index if not exists livro_emp_desb_idx on public.livro_emprestimos(desbravador_id);

-- Histórico: quem cadastrou, enviou/trocou o PDF, a capa, editou, emprestou e recebeu de volta
create table if not exists public.livro_historico (
  id bigserial primary key,
  livro_id uuid references public.livros(id) on delete set null,
  livro_titulo text,
  acao text not null,
  detalhe text,
  autor_id uuid references public.profiles(id) on delete set null,
  autor_nome text,
  created_at timestamptz not null default now()
);
create index if not exists livro_hist_idx on public.livro_historico(livro_id, created_at desc);
create index if not exists livro_hist_data_idx on public.livro_historico(created_at desc);

alter table public.livros enable row level security;
alter table public.livro_emprestimos enable row level security;
alter table public.livro_historico enable row level security;

-- qualquer membro ativo da diretoria vê, cadastra e atualiza; só o diretor apaga
drop policy if exists livros_select on public.livros;
create policy livros_select on public.livros for select to authenticated using (public.is_ativo());
drop policy if exists livros_insert on public.livros;
create policy livros_insert on public.livros for insert to authenticated with check (public.is_ativo());
drop policy if exists livros_update on public.livros;
create policy livros_update on public.livros for update to authenticated using (public.is_ativo()) with check (public.is_ativo());
drop policy if exists livros_delete on public.livros;
create policy livros_delete on public.livros for delete to authenticated using (public.is_admin());

drop policy if exists livro_emp_select on public.livro_emprestimos;
create policy livro_emp_select on public.livro_emprestimos for select to authenticated using (public.is_ativo());
drop policy if exists livro_emp_insert on public.livro_emprestimos;
create policy livro_emp_insert on public.livro_emprestimos for insert to authenticated with check (public.is_ativo());
drop policy if exists livro_emp_update on public.livro_emprestimos;
create policy livro_emp_update on public.livro_emprestimos for update to authenticated using (public.is_ativo()) with check (public.is_ativo());
drop policy if exists livro_emp_delete on public.livro_emprestimos;
create policy livro_emp_delete on public.livro_emprestimos for delete to authenticated using (public.is_admin());

-- o histórico só é escrito pelos gatilhos abaixo
drop policy if exists livro_hist_select on public.livro_historico;
create policy livro_hist_select on public.livro_historico for select to authenticated using (public.is_ativo());

create or replace function public.nome_do_usuario()
returns text language sql stable security definer set search_path = public as $$
  select coalesce((select nome from profiles where id = auth.uid()), 'Sistema')
$$;

-- quem mexeu por último (não dá para forjar pelo app)
create or replace function public.livro_carimbo()
returns trigger language plpgsql set search_path = public as $$
begin
  if tg_op = 'INSERT' then
    new.criado_por := coalesce(auth.uid(), new.criado_por);
    new.created_at := now();
  else
    new.criado_por := old.criado_por;
    new.created_at := old.created_at;
  end if;
  new.atualizado_por := coalesce(auth.uid(), new.atualizado_por);
  new.updated_at := now();
  return new;
end $$;
drop trigger if exists livros_carimbo on public.livros;
create trigger livros_carimbo before insert or update on public.livros
  for each row execute function public.livro_carimbo();

create or replace function public.log_livro()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  quem text := public.nome_do_usuario();
  mud text[] := '{}';
  tam text;
begin
  if tg_op = 'INSERT' then
    insert into livro_historico (livro_id, livro_titulo, acao, detalhe, autor_id, autor_nome)
    values (new.id, new.titulo, 'cadastrou o livro',
            nullif(concat_ws(' · ',
              case when new.pdf_path is not null then 'com o PDF ' || coalesce(new.pdf_nome, '') end,
              case when new.exemplares > 0 then new.exemplares || ' exemplar(es) físico(s)' end), ''),
            auth.uid(), quem);
    return new;
  elsif tg_op = 'DELETE' then
    insert into livro_historico (livro_id, livro_titulo, acao, detalhe, autor_id, autor_nome)
    values (null, old.titulo, 'excluiu o livro', null, auth.uid(), quem);
    return old;
  end if;

  if new.pdf_path is distinct from old.pdf_path then
    tam := case when new.pdf_tamanho is not null then ' (' || round(new.pdf_tamanho / 1048576.0, 1) || ' MB)' else '' end;
    insert into livro_historico (livro_id, livro_titulo, acao, detalhe, autor_id, autor_nome)
    values (new.id, new.titulo,
            case when old.pdf_path is null then 'enviou o PDF' when new.pdf_path is null then 'removeu o PDF' else 'trocou o PDF (versão nova)' end,
            case when new.pdf_path is not null then coalesce(new.pdf_nome, '') || tam
                 else 'Arquivo anterior: ' || coalesce(old.pdf_nome, '') end,
            auth.uid(), quem);
  end if;
  if new.capa_path is distinct from old.capa_path then
    insert into livro_historico (livro_id, livro_titulo, acao, detalhe, autor_id, autor_nome)
    values (new.id, new.titulo, case when new.capa_path is null then 'removeu a capa' when old.capa_path is null then 'colocou a capa' else 'trocou a capa' end,
            null, auth.uid(), quem);
  end if;
  if new.titulo is distinct from old.titulo then mud := mud || ('título: "' || old.titulo || '" → "' || new.titulo || '"'); end if;
  if new.autor is distinct from old.autor then mud := mud || ('autor: ' || coalesce(new.autor, '—')); end if;
  if new.categoria is distinct from old.categoria then mud := mud || ('categoria: ' || coalesce(new.categoria, '—')); end if;
  if new.descricao is distinct from old.descricao then mud := mud || 'descrição'::text; end if;
  if new.exemplares is distinct from old.exemplares then mud := mud || ('exemplares: ' || old.exemplares || ' → ' || new.exemplares); end if;
  if array_length(mud, 1) > 0 then
    insert into livro_historico (livro_id, livro_titulo, acao, detalhe, autor_id, autor_nome)
    values (new.id, new.titulo, 'editou os dados', array_to_string(mud, ' · '), auth.uid(), quem);
  end if;
  return new;
end $$;
drop trigger if exists livros_log on public.livros;
create trigger livros_log after insert or update or delete on public.livros
  for each row execute function public.log_livro();

-- não deixa emprestar mais exemplares do que o clube tem
create or replace function public.checar_emprestimo()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  total int;
  fora int;
begin
  if tg_op = 'INSERT' or (old.devolvido_em is not null and new.devolvido_em is null) then
    select exemplares into total from livros where id = new.livro_id;
    select count(*) into fora from livro_emprestimos where livro_id = new.livro_id and devolvido_em is null and id <> new.id;
    if coalesce(total, 0) <= fora then
      raise exception 'Todos os exemplares deste livro já estão emprestados.';
    end if;
  end if;
  if tg_op = 'INSERT' then
    new.emprestado_por := coalesce(auth.uid(), new.emprestado_por);
  elsif new.devolvido_em is not null and old.devolvido_em is null then
    new.devolvido_por := coalesce(auth.uid(), new.devolvido_por);
  end if;
  return new;
end $$;
drop trigger if exists livro_emp_checar on public.livro_emprestimos;
create trigger livro_emp_checar before insert or update on public.livro_emprestimos
  for each row execute function public.checar_emprestimo();

create or replace function public.log_emprestimo()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  r record;
  dnome text;
  ltit text;
  acao text;
begin
  if tg_op = 'DELETE' then r := old; else r := new; end if;
  select nome into dnome from desbravadores where id = r.desbravador_id;
  select titulo into ltit from livros where id = r.livro_id;
  if ltit is null then return r; end if; -- o livro foi excluído junto
  if tg_op = 'INSERT' then acao := 'emprestou para ' || coalesce(dnome, 'desbravador');
  elsif tg_op = 'DELETE' then acao := 'apagou o empréstimo de ' || coalesce(dnome, 'desbravador');
  elsif new.devolvido_em is not null and old.devolvido_em is null then acao := 'recebeu de volta de ' || coalesce(dnome, 'desbravador');
  elsif new.devolvido_em is null and old.devolvido_em is not null then acao := 'desfez a devolução de ' || coalesce(dnome, 'desbravador');
  else return r;
  end if;
  insert into livro_historico (livro_id, livro_titulo, acao, detalhe, autor_id, autor_nome)
  values (r.livro_id, ltit, acao,
          case when tg_op = 'INSERT' and r.devolver_ate is not null then 'Devolver até ' || to_char(r.devolver_ate, 'DD/MM/YYYY') end,
          auth.uid(), public.nome_do_usuario());
  return r;
end $$;
drop trigger if exists livro_emp_log on public.livro_emprestimos;
create trigger livro_emp_log after insert or update or delete on public.livro_emprestimos
  for each row execute function public.log_emprestimo();

-- Arquivos da biblioteca (PDFs e capas). Privado: o app gera links temporários.
do $$
begin
  insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
  values ('biblioteca', 'biblioteca', false, 52428800, array['application/pdf', 'image/jpeg', 'image/png', 'image/webp'])
  on conflict (id) do update set public = false, file_size_limit = excluded.file_size_limit, allowed_mime_types = excluded.allowed_mime_types;

  drop policy if exists tigres_biblioteca_select on storage.objects;
  create policy tigres_biblioteca_select on storage.objects for select to authenticated
    using (bucket_id = 'biblioteca' and public.is_ativo());
  drop policy if exists tigres_biblioteca_insert on storage.objects;
  create policy tigres_biblioteca_insert on storage.objects for insert to authenticated
    with check (bucket_id = 'biblioteca' and public.is_ativo());
  -- arquivo antigo (que nenhum livro usa mais) pode ser apagado por quem trocou
  drop policy if exists tigres_biblioteca_delete on storage.objects;
  create policy tigres_biblioteca_delete on storage.objects for delete to authenticated
    using (bucket_id = 'biblioteca' and public.is_ativo()
           and (public.is_admin() or not exists (select 1 from public.livros l where l.pdf_path = name or l.capa_path = name)));
exception when undefined_table or invalid_schema_name then
  raise notice 'Storage não encontrado: biblioteca sem arquivos neste banco.';
end $$;

-- =====================================================================
-- Inventário
-- =====================================================================
create table if not exists public.inventario (
  id uuid primary key default gen_random_uuid(),
  nome text not null check (length(trim(nome)) > 0),
  categoria text not null default 'Outros',
  quantidade int not null default 1 check (quantidade >= 0),
  estado text not null default 'bom' check (estado in ('bom', 'regular', 'ruim', 'manutencao')),
  unidade_id uuid references public.unidades(id) on delete set null,
  local text,
  observacao text,
  criado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  atualizado_por uuid references public.profiles(id) on delete set null,
  updated_at timestamptz not null default now()
);
create index if not exists inventario_cat_idx on public.inventario(categoria, nome);
alter table public.inventario enable row level security;
drop policy if exists inventario_select on public.inventario;
create policy inventario_select on public.inventario for select to authenticated using (public.is_ativo());
drop policy if exists inventario_insert on public.inventario;
create policy inventario_insert on public.inventario for insert to authenticated with check (public.is_ativo());
drop policy if exists inventario_update on public.inventario;
create policy inventario_update on public.inventario for update to authenticated using (public.is_ativo()) with check (public.is_ativo());
drop policy if exists inventario_delete on public.inventario;
create policy inventario_delete on public.inventario for delete to authenticated using (public.is_admin());
drop trigger if exists inventario_carimbo on public.inventario;
create trigger inventario_carimbo before insert or update on public.inventario
  for each row execute function public.livro_carimbo();

-- =====================================================================
-- Vaquinhas (arrecadações com Pix)
-- =====================================================================
create or replace function public.pode_financeiro()
returns boolean language sql stable security definer set search_path = public as $$
  select public.is_admin() or (public.is_ativo() and public.tem_funcao('Tesoureiro(a)'))
$$;

create table if not exists public.vaquinhas (
  id uuid primary key default gen_random_uuid(),
  titulo text not null check (length(trim(titulo)) > 0),
  descricao text,
  meta numeric(12, 2) not null check (meta > 0),
  pix_chave text,
  pix_nome text,
  pix_cidade text,
  prazo date,
  encerrada boolean not null default false,
  criado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  atualizado_por uuid references public.profiles(id) on delete set null,
  updated_at timestamptz not null default now()
);
create table if not exists public.vaquinha_entradas (
  id uuid primary key default gen_random_uuid(),
  vaquinha_id uuid not null references public.vaquinhas(id) on delete cascade,
  valor numeric(12, 2) not null check (valor > 0),
  nome text,
  data date not null default current_date,
  registrado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now()
);
create index if not exists vaq_entr_idx on public.vaquinha_entradas(vaquinha_id, data desc);
alter table public.vaquinhas enable row level security;
alter table public.vaquinha_entradas enable row level security;

drop policy if exists vaquinhas_select on public.vaquinhas;
create policy vaquinhas_select on public.vaquinhas for select to authenticated using (public.is_ativo());
drop policy if exists vaquinhas_insert on public.vaquinhas;
create policy vaquinhas_insert on public.vaquinhas for insert to authenticated with check (public.is_admin());
drop policy if exists vaquinhas_update on public.vaquinhas;
create policy vaquinhas_update on public.vaquinhas for update to authenticated using (public.is_admin()) with check (public.is_admin());
drop policy if exists vaquinhas_delete on public.vaquinhas;
create policy vaquinhas_delete on public.vaquinhas for delete to authenticated using (public.is_admin());
drop trigger if exists vaquinhas_carimbo on public.vaquinhas;
create trigger vaquinhas_carimbo before insert or update on public.vaquinhas
  for each row execute function public.livro_carimbo();

drop policy if exists vaq_entr_select on public.vaquinha_entradas;
create policy vaq_entr_select on public.vaquinha_entradas for select to authenticated using (public.is_ativo());
drop policy if exists vaq_entr_insert on public.vaquinha_entradas;
create policy vaq_entr_insert on public.vaquinha_entradas for insert to authenticated with check (public.pode_financeiro());
drop policy if exists vaq_entr_delete on public.vaquinha_entradas;
create policy vaq_entr_delete on public.vaquinha_entradas for delete to authenticated using (public.pode_financeiro());

create or replace function public.vaq_entrada_autor()
returns trigger language plpgsql set search_path = public as $$
begin
  new.registrado_por := coalesce(auth.uid(), new.registrado_por);
  return new;
end $$;
drop trigger if exists vaq_entr_autor on public.vaquinha_entradas;
create trigger vaq_entr_autor before insert on public.vaquinha_entradas
  for each row execute function public.vaq_entrada_autor();
