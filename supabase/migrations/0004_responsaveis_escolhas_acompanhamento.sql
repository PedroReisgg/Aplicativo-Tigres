-- =====================================================================
-- 0004 · Responsáveis, especialidade escolhida no caderno e link de acompanhamento
-- Pode ser rodado mais de uma vez.
-- =====================================================================

-- ---------- Responsável 1 e Responsável 2 ----------
-- O telefone do responsável 1 continua na coluna telefone_responsavel.
alter table public.desbravadores add column if not exists responsavel1_nome text;
alter table public.desbravadores add column if not exists responsavel2_nome text;
alter table public.desbravadores add column if not exists responsavel2_telefone text;

-- Quem já estava cadastrado: mãe (ou pai) vira responsável 1 e o pai vira responsável 2.
update public.desbravadores
   set responsavel1_nome = coalesce(nome_mae, nome_pai),
       responsavel2_nome = case when nome_mae is not null then nome_pai end
 where responsavel1_nome is null and responsavel2_nome is null
   and (nome_mae is not null or nome_pai is not null);

-- A view guarda a lista de colunas de quando foi criada; recria para incluir as novas.
drop view if exists public.desbravadores_view;
create view public.desbravadores_view with (security_invoker = true) as
  select d.*, public.idade(d.data_nascimento) as idade, c.nome as classe_nome, c.slug as classe_slug, c.cor as classe_cor,
    u.cor as unidade_cor
  from desbravadores d
  left join classes c on c.id = d.class_id
  left join unidades u on u.id = d.unidade_id;
grant select on public.desbravadores_view to authenticated;

-- ---------- Especialidade escolhida nos itens do caderno ----------
-- Ex.: "Escolher e completar uma especialidade em uma das áreas abaixo". Cada desbravador
-- guarda qual especialidade vai fazer naquele item (e pode trocar).
create table if not exists public.caderno_escolhas (
  desbravador_id uuid not null references public.desbravadores(id) on delete cascade,
  item_id int not null references public.caderno_itens(id) on delete cascade,
  especialidade_codigo text not null references public.especialidades(codigo) on delete cascade,
  escolhido_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  primary key (desbravador_id, item_id, especialidade_codigo)
);
create index if not exists caderno_escolhas_item_idx on public.caderno_escolhas(item_id);
alter table public.caderno_escolhas enable row level security;

drop policy if exists escolhas_select on public.caderno_escolhas;
create policy escolhas_select on public.caderno_escolhas for select to authenticated
  using (public.can_view_desbravador(desbravador_id));
drop policy if exists escolhas_insert on public.caderno_escolhas;
create policy escolhas_insert on public.caderno_escolhas for insert to authenticated
  with check (public.can_registrar_especialidade(desbravador_id));
drop policy if exists escolhas_delete on public.caderno_escolhas;
create policy escolhas_delete on public.caderno_escolhas for delete to authenticated
  using (public.can_registrar_especialidade(desbravador_id));

-- ---------- Link para os responsáveis acompanharem ----------
-- Cada desbravador pode ter um link secreto (sem login) que mostra só o progresso:
-- caderno e especialidades. Gerar um link novo invalida o anterior.
create table if not exists public.acompanhamento_links (
  desbravador_id uuid primary key references public.desbravadores(id) on delete cascade,
  token uuid not null unique default gen_random_uuid(),
  criado_por uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now()
);
alter table public.acompanhamento_links enable row level security;

drop policy if exists acomp_select on public.acompanhamento_links;
create policy acomp_select on public.acompanhamento_links for select to authenticated
  using (public.can_view_desbravador(desbravador_id));
drop policy if exists acomp_insert on public.acompanhamento_links;
create policy acomp_insert on public.acompanhamento_links for insert to authenticated
  with check (public.can_registrar_especialidade(desbravador_id));
drop policy if exists acomp_update on public.acompanhamento_links;
create policy acomp_update on public.acompanhamento_links for update to authenticated
  using (public.can_registrar_especialidade(desbravador_id)) with check (public.can_registrar_especialidade(desbravador_id));
drop policy if exists acomp_delete on public.acompanhamento_links;
create policy acomp_delete on public.acompanhamento_links for delete to authenticated
  using (public.can_registrar_especialidade(desbravador_id));

-- Página pública /acompanhar/<token>: devolve só o progresso, nunca telefone, endereço ou CPF.
create or replace function public.acompanhamento(p_token uuid)
returns json language sql stable security definer set search_path = public as $$
  select json_build_object(
    'nome', d.nome,
    'classe', c.nome,
    'classe_cor', c.cor,
    'unidade', u.nome,
    'unidade_cor', u.cor,
    'itens', coalesce((
      select json_agg(json_build_object(
               'id', i.id, 'codigo', i.codigo, 'secao', i.secao, 'texto', i.texto, 'avancada', i.avancada,
               'status', p.status, 'validacao', p.validacao)
             order by i.secao_ordem, i.ordem)
        from caderno_itens i
        left join caderno_progresso p on p.item_id = i.id and p.desbravador_id = d.id
       where i.class_id = d.class_id), '[]'::json),
    'especialidades', coalesce((
      select json_agg(json_build_object(
               'codigo', e.codigo, 'nome', e.nome, 'imagem', e.imagem, 'categoria', cat.nome, 'cor', cat.cor,
               'status', x.status, 'validacao', x.validacao, 'concluida_em', x.concluida_em)
             order by x.concluida_em desc, e.nome)
        from desbravador_especialidades x
        join especialidades e on e.codigo = x.especialidade_codigo
        join especialidade_categorias cat on cat.slug = e.categoria_slug
       where x.desbravador_id = d.id), '[]'::json),
    'escolhas', coalesce((
      select json_agg(json_build_object('item_id', s.item_id, 'codigo', e.codigo, 'nome', e.nome))
        from caderno_escolhas s join especialidades e on e.codigo = s.especialidade_codigo
       where s.desbravador_id = d.id), '[]'::json)
  )
  from acompanhamento_links l
  join desbravadores d on d.id = l.desbravador_id and d.ativo
  left join classes c on c.id = d.class_id
  left join unidades u on u.id = d.unidade_id
  where l.token = p_token
$$;
revoke all on function public.acompanhamento(uuid) from public;
grant execute on function public.acompanhamento(uuid) to anon, authenticated;
