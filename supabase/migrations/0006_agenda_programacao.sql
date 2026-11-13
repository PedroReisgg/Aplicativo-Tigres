-- =====================================================================
-- 0006 · Agenda do clube (pública, com cores e endereço) e
--        programação do sábado (aviso para a diretoria)
-- Rode depois da 0005. Pode rodar de novo sem problema.
-- =====================================================================

-- ---------- Quem pode mexer na agenda (além do diretor) ----------
create table if not exists public.agenda_editores (
  profile_id uuid primary key references public.profiles(id) on delete cascade,
  adicionado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now()
);
alter table public.agenda_editores enable row level security;

create or replace function public.pode_agenda()
returns boolean language sql stable security definer set search_path = public as $$
  select public.is_admin()
      or (public.is_ativo() and exists (select 1 from agenda_editores e where e.profile_id = auth.uid()))
$$;

drop policy if exists agenda_ed_select on public.agenda_editores;
create policy agenda_ed_select on public.agenda_editores for select to authenticated using (public.is_ativo());
drop policy if exists agenda_ed_insert on public.agenda_editores;
create policy agenda_ed_insert on public.agenda_editores for insert to authenticated with check (public.is_admin());
drop policy if exists agenda_ed_delete on public.agenda_editores;
create policy agenda_ed_delete on public.agenda_editores for delete to authenticated using (public.is_admin());

-- ---------- Eventos da agenda ----------
create table if not exists public.agenda_eventos (
  id uuid primary key default gen_random_uuid(),
  titulo text not null check (length(trim(titulo)) > 0),
  descricao text,
  inicio date not null,
  fim date,
  hora_inicio time,
  hora_fim time,
  cor text not null default '#F26B1D' check (cor ~ '^#[0-9A-Fa-f]{6}$'),
  endereco text,
  criado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  atualizado_por uuid references public.profiles(id) on delete set null,
  updated_at timestamptz not null default now(),
  check (fim is null or fim >= inicio)
);
create index if not exists agenda_eventos_inicio_idx on public.agenda_eventos(inicio);
alter table public.agenda_eventos enable row level security;

drop trigger if exists agenda_eventos_carimbo on public.agenda_eventos;
create trigger agenda_eventos_carimbo before insert or update on public.agenda_eventos
  for each row execute function public.livro_carimbo();

-- a agenda é pública: qualquer pessoa com o link vê os eventos (sem login)
drop policy if exists agenda_ev_select on public.agenda_eventos;
create policy agenda_ev_select on public.agenda_eventos for select to anon, authenticated using (true);
drop policy if exists agenda_ev_insert on public.agenda_eventos;
create policy agenda_ev_insert on public.agenda_eventos for insert to authenticated with check (public.pode_agenda());
drop policy if exists agenda_ev_update on public.agenda_eventos;
create policy agenda_ev_update on public.agenda_eventos for update to authenticated using (public.pode_agenda()) with check (public.pode_agenda());
drop policy if exists agenda_ev_delete on public.agenda_eventos;
create policy agenda_ev_delete on public.agenda_eventos for delete to authenticated using (public.pode_agenda());

-- quem não entrou no app vê só os campos do evento (não vê quem cadastrou)
revoke select on public.agenda_eventos from anon;
grant select (id, titulo, descricao, inicio, fim, hora_inicio, hora_fim, cor, endereco, updated_at) on public.agenda_eventos to anon;

-- ---------- Programação do sábado (ou do dia escolhido) ----------
create table if not exists public.programacoes (
  id uuid primary key default gen_random_uuid(),
  titulo text not null check (length(trim(titulo)) > 0),
  data date not null,
  -- [{ "hora": "08:00", "atividade": "Abertura" }, ...]
  itens jsonb not null default '[]'::jsonb check (jsonb_typeof(itens) = 'array'),
  observacao text,
  criado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  atualizado_por uuid references public.profiles(id) on delete set null,
  updated_at timestamptz not null default now()
);
create index if not exists programacoes_data_idx on public.programacoes(data desc);
alter table public.programacoes enable row level security;

drop trigger if exists programacoes_carimbo on public.programacoes;
create trigger programacoes_carimbo before insert or update on public.programacoes
  for each row execute function public.livro_carimbo();

-- toda a diretoria ativa vê; o diretor cria, muda e apaga
drop policy if exists prog_select on public.programacoes;
create policy prog_select on public.programacoes for select to authenticated using (public.is_ativo());
drop policy if exists prog_insert on public.programacoes;
create policy prog_insert on public.programacoes for insert to authenticated with check (public.is_admin());
drop policy if exists prog_update on public.programacoes;
create policy prog_update on public.programacoes for update to authenticated using (public.is_admin()) with check (public.is_admin());
drop policy if exists prog_delete on public.programacoes;
create policy prog_delete on public.programacoes for delete to authenticated using (public.is_admin());

-- aviso para toda a diretoria ativa quando a programação é publicada ou muda
create or replace function public.avisar_programacao()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  dia text := to_char(new.data, 'DD/MM');
  dias text[] := array['domingo', 'segunda', 'terça', 'quarta', 'quinta', 'sexta', 'sábado'];
begin
  if tg_op = 'UPDATE' and new.titulo is not distinct from old.titulo and new.data is not distinct from old.data
     and new.itens is not distinct from old.itens and new.observacao is not distinct from old.observacao then
    return new;
  end if;
  insert into notificacoes (destinatario_id, remetente_id, tipo, titulo, mensagem, link)
  select p.id, auth.uid(), 'programacao',
         case when tg_op = 'INSERT' then 'Programação de ' else 'Programação atualizada: ' end
           || dias[extract(dow from new.data)::int + 1] || ', ' || dia,
         new.titulo || coalesce(' · ' || jsonb_array_length(new.itens) || ' horário(s)', ''),
         '/programacao?id=' || new.id
  from profiles p
  where p.status = 'ativo' and p.id is distinct from auth.uid();
  return new;
end $$;
drop trigger if exists programacoes_aviso on public.programacoes;
create trigger programacoes_aviso after insert or update on public.programacoes
  for each row execute function public.avisar_programacao();
