-- =====================================================================
-- 0007 · Histórico na ficha do desbravador
--   * quem pode ver o desbravador vê o histórico dele
--     (quem marcou, aprovou ou devolveu cada item e especialidade, com dia e hora)
--   * especialidade guarda duas datas: quando o desbravador FEZ
--     (concluida_em + concluida_hora) e quando foi COLOCADA no sistema (registrado_em)
-- Rode depois da 0006. Pode rodar de novo sem problema.
-- =====================================================================

-- ---------- Quem vê o histórico ----------
-- O diretor continua vendo tudo (aba Registro). Quem cuida do desbravador
-- (instrutor da classe, conselheiro da unidade, secretaria, capelão) vê o dele.
drop policy if exists registro_select on public.registro_atividades;
create policy registro_select on public.registro_atividades for select to authenticated
  using (public.is_admin() or (desbravador_id is not null and public.can_view_desbravador(desbravador_id)));

-- ---------- Especialidade: quando fez x quando registrou ----------
alter table public.desbravador_especialidades add column if not exists concluida_hora time;
alter table public.desbravador_especialidades add column if not exists registrado_em timestamptz;
update public.desbravador_especialidades set registrado_em = created_at where registrado_em is null;
alter table public.desbravador_especialidades alter column registrado_em set default now();

-- quem colocou no sistema e a hora são carimbados pelo banco
create or replace function public.carimbo_registro_esp()
returns trigger language plpgsql set search_path = public as $$
declare
  hoje date := (now() at time zone 'America/Sao_Paulo')::date;
begin
  if tg_op = 'INSERT' or (new.status = 'concluida' and old.status is distinct from 'concluida') then
    new.registrado_em := now();
    if auth.uid() is not null then new.registrado_por := auth.uid(); end if;
  else
    new.registrado_em := old.registrado_em;
    new.registrado_por := old.registrado_por;
  end if;
  if (tg_op = 'INSERT' or new.concluida_em is distinct from old.concluida_em) and new.concluida_em > hoje then
    raise exception 'A data em que fez a especialidade não pode ser depois de hoje.';
  end if;
  return new;
end $$;
drop trigger if exists desb_esp_carimbo on public.desbravador_especialidades;
create trigger desb_esp_carimbo before insert or update on public.desbravador_especialidades
  for each row execute function public.carimbo_registro_esp();

-- ---------- Registro: mostra a data em que fez e registra mudança de data ----------
create or replace function public.log_desb_esp()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  r record;
  enome text;
  acao text;
  det text;
  fez text;
begin
  if tg_op = 'DELETE' then r := old; else r := new; end if;
  select nome into enome from especialidades where codigo = r.especialidade_codigo;
  fez := 'Fez em ' || to_char(r.concluida_em, 'DD/MM/YYYY') || coalesce(' às ' || to_char(r.concluida_hora, 'HH24:MI'), '');
  if tg_op = 'INSERT' then
    acao := case when new.status = 'refazer' then 'devolveu' else 'registrou' end;
    det := case when new.status = 'refazer' then new.observacao
                when new.validacao = 'aprovada' then fez || ' · lançada pela diretoria (já aprovada)'
                else fez || ' · aguardando validação do diretor' end;
  elsif tg_op = 'UPDATE' then
    if new.status = 'refazer' and old.status is distinct from 'refazer' then acao := 'devolveu'; det := new.observacao;
    elsif new.status = 'concluida' and old.status = 'refazer' then acao := 'registrou'; det := fez || ' · registrada de novo depois de refazer';
    elsif new.validacao = 'aprovada' and old.validacao = 'pendente' then acao := 'aprovou';
    elsif new.validacao = 'pendente' and old.validacao = 'aprovada' then acao := 'registrou'; det := 'Voltou para validação';
    elsif new.concluida_em is distinct from old.concluida_em or new.concluida_hora is distinct from old.concluida_hora then
      acao := 'editou';
      det := 'Mudou a data em que fez para ' || to_char(new.concluida_em, 'DD/MM/YYYY') || coalesce(' às ' || to_char(new.concluida_hora, 'HH24:MI'), '');
    else return null;
    end if;
  else
    acao := 'removeu';
  end if;
  perform public.registrar_atividade(acao, 'especialidade', r.desbravador_id, r.especialidade_codigo, enome, det);
  return null;
end $$;
