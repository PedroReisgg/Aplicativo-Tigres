-- =====================================================================
-- Tigres do Riacho — esquema do banco (Supabase / Postgres)
-- Rode este arquivo inteiro no SQL Editor do Supabase (uma vez).
-- Depois rode supabase/seed.sql para carregar classes e especialidades.
-- =====================================================================

create extension if not exists pgcrypto;

-- ---------- Tipos ----------
do $$ begin
  create type public.status_membro as enum ('pendente', 'ativo', 'inativo');
exception when duplicate_object then null; end $$;

-- ---------- Funções utilitárias ----------
create or replace function public.idade(nasc date)
returns int language sql stable as $$
  select case when nasc is null then null else date_part('year', age(current_date, nasc))::int end
$$;

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end $$;

-- ---------- Diretoria / usuários ----------
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nome text not null default '',
  email text not null default '',
  telefone text,
  data_nascimento date,
  cargo text not null default 'Aguardando aprovação',
  is_admin boolean not null default false,
  status public.status_membro not null default 'pendente',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
drop trigger if exists profiles_updated on public.profiles;
create trigger profiles_updated before update on public.profiles
  for each row execute function public.set_updated_at();

-- ---------- Classes ----------
create table if not exists public.classes (
  id smallint primary key,
  slug text unique not null,
  nome text not null,
  idade_minima int not null,
  cor text not null,
  classe_avancada text,
  url_mda text
);

create table if not exists public.class_staff (
  class_id smallint not null references public.classes(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  funcao text not null default 'Instrutor',
  created_at timestamptz not null default now(),
  primary key (class_id, profile_id)
);

-- ---------- Itens do caderno (cartão da classe) ----------
create table if not exists public.caderno_itens (
  id serial primary key,
  class_id smallint not null references public.classes(id) on delete cascade,
  secao text not null,
  secao_ordem int not null default 0,
  ordem int not null default 0,
  codigo text not null,
  texto text not null,
  detalhes jsonb not null default '[]'::jsonb,
  especialidades text[] not null default '{}',
  avancada boolean not null default false,
  personalizado boolean not null default false,
  unique (class_id, codigo)
);
create index if not exists caderno_itens_class_idx on public.caderno_itens(class_id, secao_ordem, ordem);

-- ---------- Especialidades ----------
create table if not exists public.especialidade_categorias (
  slug text primary key,
  nome text not null,
  cor text not null default '#F26B1D',
  ordem int not null default 0,
  url_mda text
);

create table if not exists public.especialidades (
  codigo text primary key,
  nome text not null,
  categoria_slug text not null references public.especialidade_categorias(slug) on delete cascade,
  tipo text not null default 'especialidade',
  nivel int,
  ano int,
  origem text,
  imagem text,
  url_mda text,
  requisitos text not null default ''
);
create index if not exists especialidades_cat_idx on public.especialidades(categoria_slug);

-- Especialidades vinculadas à classe (obrigatórias do caderno + adicionadas pelo instrutor)
create table if not exists public.class_especialidades (
  class_id smallint not null references public.classes(id) on delete cascade,
  especialidade_codigo text not null references public.especialidades(codigo) on delete cascade,
  obrigatoria boolean not null default false,
  adicionada_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  primary key (class_id, especialidade_codigo)
);

-- ---------- Desbravadores ----------
create table if not exists public.desbravadores (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  data_nascimento date,
  sexo text check (sexo in ('M', 'F')),
  cpf text,
  nome_pai text,
  nome_mae text,
  telefone_responsavel text not null,
  telefone text,
  email text,
  endereco text,
  unidade text,
  class_id smallint references public.classes(id) on delete set null,
  observacoes text,
  ativo boolean not null default true,
  created_by uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists desbravadores_class_idx on public.desbravadores(class_id);
drop trigger if exists desbravadores_updated on public.desbravadores;
create trigger desbravadores_updated before update on public.desbravadores
  for each row execute function public.set_updated_at();

create table if not exists public.caderno_progresso (
  desbravador_id uuid not null references public.desbravadores(id) on delete cascade,
  item_id int not null references public.caderno_itens(id) on delete cascade,
  status text not null default 'feito' check (status in ('feito', 'refazer')),
  observacao text,
  marcado_por uuid references public.profiles(id) on delete set null,
  marcado_em timestamptz not null default now(),
  primary key (desbravador_id, item_id)
);

create table if not exists public.desbravador_especialidades (
  desbravador_id uuid not null references public.desbravadores(id) on delete cascade,
  especialidade_codigo text not null references public.especialidades(codigo) on delete cascade,
  status text not null default 'concluida' check (status in ('concluida', 'refazer')),
  concluida_em date not null default current_date,
  observacao text,
  registrado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  primary key (desbravador_id, especialidade_codigo)
);

-- ---------- Notificações ----------
create table if not exists public.notificacoes (
  id uuid primary key default gen_random_uuid(),
  destinatario_id uuid not null references public.profiles(id) on delete cascade,
  remetente_id uuid references public.profiles(id) on delete set null,
  tipo text not null default 'mensagem',
  titulo text not null,
  mensagem text,
  link text,
  lida_em timestamptz,
  created_at timestamptz not null default now()
);
create index if not exists notificacoes_dest_idx on public.notificacoes(destinatario_id, created_at desc);

-- ---------- Verificação em 2 etapas (só o servidor acessa) ----------
create table if not exists public.codigos_verificacao (
  id uuid primary key default gen_random_uuid(),
  email text not null,
  user_id uuid references auth.users(id) on delete cascade,
  proposito text not null check (proposito in ('login', 'cadastro', 'senha')),
  codigo_hash text not null,
  tentativas int not null default 0,
  expira_em timestamptz not null,
  usado_em timestamptz,
  created_at timestamptz not null default now()
);
create index if not exists codigos_email_idx on public.codigos_verificacao(email, created_at desc);

create table if not exists public.sessoes_verificadas (
  session_id uuid primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

-- =====================================================================
-- Funções de permissão (security definer para evitar recursão em RLS)
-- =====================================================================
-- A sessão só vale depois do código enviado por e-mail (2ª etapa)
create or replace function public.sessao_verificada()
returns boolean language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from sessoes_verificadas
    where user_id = auth.uid() and session_id = nullif(auth.jwt()->>'session_id', '')::uuid
  )
$$;

create or replace function public.is_ativo()
returns boolean language sql stable security definer set search_path = public as $$
  select public.sessao_verificada() and exists (select 1 from profiles where id = auth.uid() and status = 'ativo')
$$;

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public as $$
  select public.sessao_verificada() and exists (select 1 from profiles where id = auth.uid() and status = 'ativo' and is_admin)
$$;

create or replace function public.is_class_staff(cid smallint)
returns boolean language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from class_staff s join profiles p on p.id = s.profile_id
    where s.class_id = cid and s.profile_id = auth.uid() and p.status = 'ativo'
  ) and public.sessao_verificada()
$$;

create or replace function public.can_manage_class(cid smallint)
returns boolean language sql stable security definer set search_path = public as $$
  select public.is_admin() or public.is_class_staff(cid)
$$;

create or replace function public.can_manage_desbravador(did uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select public.is_admin() or exists (
    select 1 from desbravadores d where d.id = did and public.is_class_staff(d.class_id)
  )
$$;

-- =====================================================================
-- Gatilhos de cadastro
-- =====================================================================
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  primeiro boolean;
begin
  select not exists (select 1 from profiles) into primeiro;
  insert into profiles (id, nome, email, telefone, data_nascimento, cargo, is_admin, status)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'nome', ''),
    coalesce(new.email, ''),
    new.raw_user_meta_data->>'telefone',
    nullif(new.raw_user_meta_data->>'data_nascimento', '')::date,
    case when primeiro then 'Diretor' else 'Aguardando aprovação' end,
    primeiro,
    case when primeiro then 'ativo'::status_membro else 'pendente'::status_membro end
  );
  -- avisa os administradores
  if not primeiro then
    insert into notificacoes (destinatario_id, tipo, titulo, mensagem, link)
    select p.id, 'cadastro', 'Novo cadastro aguardando aprovação',
           coalesce(new.raw_user_meta_data->>'nome', new.email) || ' se cadastrou e está na lista de espera.',
           '/diretoria'
    from profiles p where p.is_admin and p.status = 'ativo';
  end if;
  return new;
end $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
  for each row execute function public.handle_new_user();

-- Só administradores podem mudar cargo, status e permissão de admin
create or replace function public.protect_profile()
returns trigger language plpgsql set search_path = public as $$
begin
  -- roda como o usuário da requisição; gatilhos internos (postgres) passam direto
  if current_user in ('authenticated', 'anon') and not public.is_admin() then
    new.is_admin := old.is_admin;
    new.status := old.status;
    new.cargo := old.cargo;
    new.email := old.email;
  end if;
  return new;
end $$;
drop trigger if exists profiles_protect on public.profiles;
create trigger profiles_protect before update on public.profiles
  for each row execute function public.protect_profile();

-- Mantém o e-mail do perfil sincronizado com o auth
create or replace function public.sync_email()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  update profiles set email = new.email where id = new.id;
  return new;
end $$;
drop trigger if exists on_auth_email_change on auth.users;
create trigger on_auth_email_change after update of email on auth.users
  for each row execute function public.sync_email();

-- =====================================================================
-- Views (idade calculada no banco)
-- =====================================================================
create or replace view public.membros_view with (security_invoker = true) as
  select p.*, public.idade(p.data_nascimento) as idade,
    coalesce((select json_agg(json_build_object('class_id', s.class_id, 'funcao', s.funcao))
              from class_staff s where s.profile_id = p.id), '[]'::json) as classes
  from profiles p;

create or replace view public.desbravadores_view with (security_invoker = true) as
  select d.*, public.idade(d.data_nascimento) as idade, c.nome as classe_nome, c.slug as classe_slug, c.cor as classe_cor
  from desbravadores d left join classes c on c.id = d.class_id;

-- =====================================================================
-- RLS
-- =====================================================================
alter table public.profiles enable row level security;
alter table public.classes enable row level security;
alter table public.class_staff enable row level security;
alter table public.caderno_itens enable row level security;
alter table public.especialidade_categorias enable row level security;
alter table public.especialidades enable row level security;
alter table public.class_especialidades enable row level security;
alter table public.desbravadores enable row level security;
alter table public.caderno_progresso enable row level security;
alter table public.desbravador_especialidades enable row level security;
alter table public.notificacoes enable row level security;
alter table public.codigos_verificacao enable row level security;
alter table public.sessoes_verificadas enable row level security;
-- (sem políticas: apenas a chave de serviço do servidor acessa essas duas tabelas)

-- profiles
drop policy if exists profiles_select on public.profiles;
create policy profiles_select on public.profiles for select to authenticated
  using (id = auth.uid() or public.is_ativo());
drop policy if exists profiles_update on public.profiles;
create policy profiles_update on public.profiles for update to authenticated
  using (id = auth.uid() or public.is_admin()) with check (id = auth.uid() or public.is_admin());
drop policy if exists profiles_delete on public.profiles;
create policy profiles_delete on public.profiles for delete to authenticated
  using (public.is_admin() and id <> auth.uid());

-- conteúdo de referência: todos os logados leem, só admin altera
do $$
declare t text;
begin
  foreach t in array array['classes', 'caderno_itens', 'especialidade_categorias', 'especialidades'] loop
    execute format('drop policy if exists %1$s_select on public.%1$s', t);
    execute format('create policy %1$s_select on public.%1$s for select to authenticated using (true)', t);
    execute format('drop policy if exists %1$s_admin on public.%1$s', t);
    execute format('create policy %1$s_admin on public.%1$s for all to authenticated using (public.is_admin()) with check (public.is_admin())', t);
  end loop;
end $$;

-- equipe das classes
drop policy if exists class_staff_select on public.class_staff;
create policy class_staff_select on public.class_staff for select to authenticated
  using (profile_id = auth.uid() or public.is_ativo());
drop policy if exists class_staff_admin on public.class_staff;
create policy class_staff_admin on public.class_staff for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- especialidades da classe
drop policy if exists class_esp_select on public.class_especialidades;
create policy class_esp_select on public.class_especialidades for select to authenticated using (true);
drop policy if exists class_esp_write on public.class_especialidades;
create policy class_esp_write on public.class_especialidades for all to authenticated
  using (public.can_manage_class(class_id)) with check (public.can_manage_class(class_id));

-- desbravadores
drop policy if exists desb_select on public.desbravadores;
create policy desb_select on public.desbravadores for select to authenticated
  using (public.is_admin() or public.is_class_staff(class_id));
drop policy if exists desb_insert on public.desbravadores;
create policy desb_insert on public.desbravadores for insert to authenticated
  with check (public.is_admin() or public.is_class_staff(class_id));
drop policy if exists desb_update on public.desbravadores;
create policy desb_update on public.desbravadores for update to authenticated
  using (public.is_admin() or public.is_class_staff(class_id))
  with check (public.is_admin() or public.is_class_staff(class_id));
drop policy if exists desb_delete on public.desbravadores;
create policy desb_delete on public.desbravadores for delete to authenticated using (public.is_admin());

-- progresso do caderno e especialidades dos desbravadores
drop policy if exists prog_all on public.caderno_progresso;
create policy prog_all on public.caderno_progresso for all to authenticated
  using (public.can_manage_desbravador(desbravador_id)) with check (public.can_manage_desbravador(desbravador_id));
drop policy if exists desb_esp_all on public.desbravador_especialidades;
create policy desb_esp_all on public.desbravador_especialidades for all to authenticated
  using (public.can_manage_desbravador(desbravador_id)) with check (public.can_manage_desbravador(desbravador_id));

-- notificações
drop policy if exists notif_select on public.notificacoes;
create policy notif_select on public.notificacoes for select to authenticated using (destinatario_id = auth.uid());
drop policy if exists notif_insert on public.notificacoes;
create policy notif_insert on public.notificacoes for insert to authenticated
  with check (public.is_ativo() and remetente_id = auth.uid());
drop policy if exists notif_update on public.notificacoes;
create policy notif_update on public.notificacoes for update to authenticated
  using (destinatario_id = auth.uid()) with check (destinatario_id = auth.uid());
drop policy if exists notif_delete on public.notificacoes;
create policy notif_delete on public.notificacoes for delete to authenticated using (destinatario_id = auth.uid());

-- Grants (views)
grant select on public.membros_view to authenticated;
grant select on public.desbravadores_view to authenticated;

-- Realtime para o sino de notificações
do $$ begin
  alter publication supabase_realtime add table public.notificacoes;
exception when others then null; end $$;
