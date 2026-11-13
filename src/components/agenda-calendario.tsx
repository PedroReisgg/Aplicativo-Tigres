"use client";

import { useMemo, useState } from "react";
import { CalendarPlus, ChevronLeft, ChevronRight, Clock, Copy, FileSpreadsheet, Link2, MapPin, Navigation, Pencil, Plus, RefreshCw, Smartphone, Trash2 } from "lucide-react";
import { toast } from "sonner";
import { Button, Confirm, EmptyState, Input, Sheet, Textarea, cn } from "./ui";
import {
  CORES_AGENDA,
  dataLocal,
  diaSemana,
  gerarIcs,
  hhmm,
  hojeIso,
  isoDia,
  linkGoogleEvento,
  linkGoogleMaps,
  linkWaze,
  linksAssinatura,
  noDia,
  nomeMes,
  quando,
  textoSobre,
} from "@/lib/agenda-core";
import { agendaExcel, excluirEvento, salvarEvento } from "@/lib/agenda";
import { downloadBlob, fileName } from "@/lib/reports";
import type { AgendaEvento } from "@/lib/types";

const SEMANA_CURTA = ["DOM.", "SEG.", "TER.", "QUA.", "QUI.", "SEX.", "SÁB."];

const origem = () => (typeof window !== "undefined" ? window.location.origin : "https://tigresapp.vercel.app");

async function copiar(texto: string, ok: string) {
  try {
    await navigator.clipboard.writeText(texto);
    toast.success(ok);
  } catch {
    toast.error("Não deu para copiar. Toque e segure o link para copiar.");
  }
}

/** Calendário do mês (como o Google Agenda) + lista de eventos. Serve para o app e para o link público. */
export function AgendaCalendario({ eventos, podeEditar, onMudou }: { eventos: AgendaEvento[]; podeEditar?: boolean; onMudou?: () => void }) {
  const hoje = hojeIso();
  const [mes, setMes] = useState(() => ({ ano: Number(hoje.slice(0, 4)), mes: Number(hoje.slice(5, 7)) - 1 }));
  const [diaSel, setDiaSel] = useState<string | null>(null);
  const [aberto, setAberto] = useState<string | null>(null);
  const [editando, setEditando] = useState<AgendaEvento | { novo: string } | null>(null);
  const [sincronizar, setSincronizar] = useState(false);

  const dias = useMemo(() => {
    const primeiro = new Date(mes.ano, mes.mes, 1, 12);
    const inicio = new Date(primeiro);
    inicio.setDate(1 - primeiro.getDay());
    const ultimo = new Date(mes.ano, mes.mes + 1, 0, 12);
    const total = Math.ceil((primeiro.getDay() + ultimo.getDate()) / 7) * 7;
    return Array.from({ length: total }, (_, i) => {
      const d = new Date(inicio);
      d.setDate(inicio.getDate() + i);
      return isoDia(d);
    });
  }, [mes]);
  const doDia = (dia: string) => eventos.filter((e) => noDia(e, dia)).sort((a, b) => (a.hora_inicio || "").localeCompare(b.hora_inicio || ""));
  const prefixo = `${mes.ano}-${String(mes.mes + 1).padStart(2, "0")}`;
  const listaMes = useMemo(
    () => eventos.filter((e) => (diaSel ? noDia(e, diaSel) : e.inicio.slice(0, 7) <= prefixo && (e.fim || e.inicio).slice(0, 7) >= prefixo)),
    [eventos, diaSel, prefixo]
  );
  const ev = eventos.find((e) => e.id === aberto) || null;

  const mudarMes = (d: number) => {
    setDiaSel(null);
    setMes((m) => {
      const x = new Date(m.ano, m.mes + d, 1);
      return { ano: x.getFullYear(), mes: x.getMonth() };
    });
  };
  const irHoje = () => {
    setDiaSel(null);
    setMes({ ano: Number(hoje.slice(0, 4)), mes: Number(hoje.slice(5, 7)) - 1 });
  };

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div className="flex items-center gap-1">
          <Button variant="secondary" size="sm" onClick={irHoje}>
            Hoje
          </Button>
          <button onClick={() => mudarMes(-1)} className="grid size-9 place-items-center rounded-xl text-ink-600 hover:bg-ink-100" aria-label="Mês anterior">
            <ChevronLeft className="size-5" />
          </button>
          <button onClick={() => mudarMes(1)} className="grid size-9 place-items-center rounded-xl text-ink-600 hover:bg-ink-100" aria-label="Próximo mês">
            <ChevronRight className="size-5" />
          </button>
          <h2 className="ml-1 font-display text-xl font-semibold uppercase tracking-wide text-ink-900 sm:text-2xl" aria-live="polite">
            {nomeMes(mes.mes)} {mes.ano}
          </h2>
        </div>
        <div className="flex gap-2">
          <Button variant="secondary" size="sm" icon={<RefreshCw className="size-4" />} onClick={() => setSincronizar(true)}>
            Sincronizar
          </Button>
          {podeEditar && (
            <Button size="sm" icon={<Plus className="size-4" />} onClick={() => setEditando({ novo: diaSel || (prefixo === hoje.slice(0, 7) ? hoje : `${prefixo}-01`) })}>
              Novo evento
            </Button>
          )}
        </div>
      </div>

      <div className="overflow-hidden rounded-2xl border border-ink-200/80 bg-white shadow-card">
        <div className="grid grid-cols-7 border-b border-ink-100">
          {SEMANA_CURTA.map((s) => (
            <div key={s} className="py-2 text-center text-[11px] font-semibold text-ink-500">
              {s}
            </div>
          ))}
        </div>
        <div className="grid grid-cols-7">
          {dias.map((dia, i) => {
            const lista = doDia(dia);
            const fora = dia.slice(0, 7) !== prefixo;
            const sel = diaSel === dia;
            const ehHoje = dia === hoje;
            const dNum = Number(dia.slice(8, 10));
            return (
              <div
                key={dia}
                className={cn(
                  "group relative min-h-[54px] border-ink-100 sm:min-h-[118px]",
                  i % 7 !== 6 && "border-r",
                  i < dias.length - 7 && "border-b",
                  fora && "bg-ink-50/60",
                  sel && "bg-tiger-50"
                )}
              >
                <button
                  onClick={() => setDiaSel(sel ? null : dia)}
                  onDoubleClick={() => podeEditar && setEditando({ novo: dia })}
                  className="absolute inset-0 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-tiger-500"
                  aria-label={`${dNum} de ${nomeMes(dataLocal(dia).getMonth())}${lista.length ? `, ${lista.length} evento(s)` : ""}`}
                  aria-pressed={sel}
                />
                <div className="pointer-events-none relative flex justify-center pt-1.5">
                  <span
                    className={cn(
                      "grid size-7 place-items-center rounded-full text-[13px] font-medium",
                      ehHoje ? "bg-tiger-500 font-semibold text-white" : fora ? "text-ink-400" : "text-ink-800"
                    )}
                  >
                    {dNum === 1 ? <span className="whitespace-nowrap px-0.5 text-[12px]">{dNum}{!ehHoje && <span className="hidden sm:inline"> {nomeMes(dataLocal(dia).getMonth()).slice(0, 3)}.</span>}</span> : dNum}
                  </span>
                </div>
                {/* celular: tracinhos coloridos */}
                <div className="pointer-events-none relative mt-1 flex flex-wrap justify-center gap-0.5 px-1 sm:hidden">
                  {lista.slice(0, 3).map((e) => (
                    <span key={e.id} className="h-1.5 w-3 rounded-full" style={{ background: e.cor }} />
                  ))}
                </div>
                {/* computador: cards */}
                <div className="relative mt-1 hidden space-y-1 px-1 pb-1 sm:block">
                  {lista.slice(0, 3).map((e) => (
                    <button
                      key={e.id}
                      onClick={() => setAberto(e.id)}
                      className="block w-full truncate rounded-md px-2 py-0.5 text-left text-xs font-semibold shadow-sm transition-[filter] hover:brightness-95"
                      style={{ background: e.cor, color: textoSobre(e.cor) }}
                      title={e.titulo}
                    >
                      {e.hora_inicio && e.inicio === dia && <span className="mr-1 font-normal opacity-90">{hhmm(e.hora_inicio)}</span>}
                      {e.titulo}
                    </button>
                  ))}
                  {lista.length > 3 && (
                    <button onClick={() => setDiaSel(dia)} className="w-full rounded-md px-2 text-left text-xs font-semibold text-ink-600 hover:bg-ink-100">
                      +{lista.length - 3} mais
                    </button>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      </div>

      <section>
        <div className="mb-2 flex items-center justify-between gap-3">
          <h3 className="text-sm font-semibold uppercase tracking-wide text-ink-500">
            {diaSel ? `${diaSemana(diaSel)}, ${Number(diaSel.slice(8, 10))} de ${nomeMes(dataLocal(diaSel).getMonth())}` : `Eventos de ${nomeMes(mes.mes)}`}
          </h3>
          {diaSel && (
            <button className="text-sm font-semibold text-tiger-700 hover:underline" onClick={() => setDiaSel(null)}>
              Ver o mês todo
            </button>
          )}
        </div>
        {listaMes.length ? (
          <ul className="divide-y divide-ink-100 overflow-hidden rounded-2xl border border-ink-200/80 bg-white shadow-card">
            {listaMes.map((e) => (
              <li key={e.id}>
                <button onClick={() => setAberto(e.id)} className="flex w-full items-center gap-3 px-3 py-3 text-left hover:bg-ink-50 sm:px-4">
                  <span className="w-11 shrink-0 text-center">
                    <span className="block text-[11px] font-semibold uppercase text-ink-500">{diaSemana(e.inicio).slice(0, 3)}</span>
                    <span className="block font-display text-2xl font-semibold leading-none text-ink-900">{Number(e.inicio.slice(8, 10))}</span>
                  </span>
                  <span className="h-10 w-1.5 shrink-0 rounded-full" style={{ background: e.cor }} />
                  <span className="min-w-0 flex-1">
                    <span className="block truncate font-semibold text-ink-900">{e.titulo}</span>
                    <span className="block truncate text-sm text-ink-500">
                      {quando(e).split(" · ")[e.fim && e.fim !== e.inicio ? 0 : 1]}
                      {e.fim && e.fim !== e.inicio && e.hora_inicio ? ` · ${hhmm(e.hora_inicio)}` : ""}
                      {e.endereco ? ` · ${e.endereco}` : ""}
                    </span>
                  </span>
                  <ChevronRight className="size-4 shrink-0 text-ink-300" />
                </button>
              </li>
            ))}
          </ul>
        ) : (
          <EmptyState
            title={diaSel ? "Nada marcado neste dia" : "Nada marcado neste mês"}
            description={podeEditar ? "Toque em Novo evento para colocar uma atividade." : "Quando o clube marcar uma atividade, ela aparece aqui."}
            action={
              podeEditar && (
                <Button size="sm" onClick={() => setEditando({ novo: diaSel || `${prefixo}-${prefixo === hoje.slice(0, 7) ? hoje.slice(8, 10) : "01"}` })}>
                  Novo evento
                </Button>
              )
            }
          />
        )}
      </section>

      {ev && <DetalheEvento e={ev} podeEditar={podeEditar} onClose={() => setAberto(null)} onEditar={() => setEditando(ev)} onExcluido={() => (setAberto(null), onMudou?.())} />}
      {podeEditar && (
        <EditarEvento
          alvo={editando}
          onClose={() => setEditando(null)}
          onSalvo={(id) => {
            setEditando(null);
            setAberto(id);
            onMudou?.();
          }}
        />
      )}
      <Sincronizar open={sincronizar} onClose={() => setSincronizar(false)} eventos={eventos} />
    </div>
  );
}

function DetalheEvento({ e, podeEditar, onClose, onEditar, onExcluido }: { e: AgendaEvento; podeEditar?: boolean; onClose: () => void; onEditar: () => void; onExcluido: () => void }) {
  const [excluir, setExcluir] = useState(false);
  const [busy, setBusy] = useState(false);
  const [app, setApp] = useState<"google" | "waze">("google");
  async function apagar() {
    setBusy(true);
    try {
      await excluirEvento(e.id);
      toast.success("Evento excluído.");
      setExcluir(false);
      onExcluido();
    } catch (err) {
      toast.error((err as Error).message);
    } finally {
      setBusy(false);
    }
  }
  const baixarIcs = () => downloadBlob(new Blob([gerarIcs([e])], { type: "text/calendar" }), `${e.titulo.replace(/[^\p{L}\p{N}]+/gu, "-").slice(0, 40)}.ics`);
  return (
    <Sheet
      open
      onClose={onClose}
      title={e.titulo}
      footer={
        podeEditar ? (
          <>
            <Button variant="ghost" className="mr-auto text-red-600 hover:bg-red-50" icon={<Trash2 className="size-4" />} onClick={() => setExcluir(true)}>
              Excluir
            </Button>
            <Button variant="secondary" icon={<Pencil className="size-4" />} onClick={onEditar}>
              Editar
            </Button>
          </>
        ) : undefined
      }
    >
      <div className="space-y-5">
        <div className="rounded-2xl p-4" style={{ background: e.cor, color: textoSobre(e.cor) }}>
          <div className="font-display text-2xl font-semibold uppercase leading-tight tracking-wide">{e.titulo}</div>
          <div className="mt-1 flex items-center gap-1.5 text-sm opacity-90">
            <Clock className="size-4 shrink-0" /> {quando(e)}
          </div>
        </div>
        {e.descricao && <p className="whitespace-pre-line text-[15px] leading-relaxed text-ink-700">{e.descricao}</p>}

        {e.endereco && (
          <section className="rounded-2xl border border-ink-200 p-4">
            <div className="flex items-start gap-2 text-[15px] text-ink-900">
              <MapPin className="mt-0.5 size-4 shrink-0 text-tiger-600" /> <span className="min-w-0 break-words">{e.endereco}</span>
            </div>
            <div className="mt-3 text-xs font-semibold uppercase tracking-wide text-ink-500">Abrir no</div>
            <div role="tablist" aria-label="Aplicativo de mapa" className="mt-1.5 grid grid-cols-2 gap-1 rounded-xl bg-ink-100 p-1">
              {(
                [
                  ["google", "Google Maps"],
                  ["waze", "Waze"],
                ] as const
              ).map(([k, nome]) => (
                <button
                  key={k}
                  role="tab"
                  aria-selected={app === k}
                  onClick={() => setApp(k)}
                  className={cn("h-9 rounded-lg text-sm font-semibold transition-colors", app === k ? "bg-white text-ink-900 shadow-card" : "text-ink-500 hover:text-ink-800")}
                >
                  {nome}
                </button>
              ))}
            </div>
            <a
              href={app === "google" ? linkGoogleMaps(e.endereco) : linkWaze(e.endereco)}
              target="_blank"
              rel="noopener noreferrer"
              className="mt-2 flex h-11 items-center justify-center gap-2 rounded-xl bg-tiger-500 px-4 text-sm font-semibold text-white hover:bg-tiger-600"
            >
              <Navigation className="size-4" /> Como chegar pelo {app === "google" ? "Google Maps" : "Waze"}
            </a>
          </section>
        )}

        <section>
          <div className="mb-2 text-xs font-semibold uppercase tracking-wide text-ink-500">Salvar na minha agenda</div>
          <div className="grid grid-cols-2 gap-2">
            <a
              href={linkGoogleEvento(e)}
              target="_blank"
              rel="noopener noreferrer"
              className="flex h-11 items-center justify-center gap-2 rounded-xl border border-ink-200 bg-white px-3 text-sm font-semibold text-ink-800 hover:bg-ink-50"
            >
              <CalendarPlus className="size-4" /> Google Agenda
            </a>
            <button onClick={baixarIcs} className="flex h-11 items-center justify-center gap-2 rounded-xl border border-ink-200 bg-white px-3 text-sm font-semibold text-ink-800 hover:bg-ink-50">
              <Smartphone className="size-4" /> iPhone / outros
            </button>
          </div>
        </section>
      </div>
      <Confirm
        open={excluir}
        danger
        title={`Excluir "${e.titulo}"?`}
        message="O evento sai da agenda do clube para todo mundo, inclusive de quem sincronizou com o Google ou o iPhone."
        confirmLabel="Excluir evento"
        loading={busy}
        onConfirm={apagar}
        onClose={() => setExcluir(false)}
      />
    </Sheet>
  );
}

const HEX = /^#[0-9A-Fa-f]{6}$/;

function EditarEvento({ alvo, onClose, onSalvo }: { alvo: AgendaEvento | { novo: string } | null; onClose: () => void; onSalvo: (id: string) => void }) {
  const e = alvo && "id" in alvo ? alvo : null;
  const [aberto, setAberto] = useState<typeof alvo>(null);
  const [titulo, setTitulo] = useState("");
  const [inicio, setInicio] = useState("");
  const [fim, setFim] = useState("");
  const [variosDias, setVariosDias] = useState(false);
  const [diaInteiro, setDiaInteiro] = useState(true);
  const [hi, setHi] = useState("");
  const [hf, setHf] = useState("");
  const [cor, setCor] = useState(CORES_AGENDA[0]);
  const [corTxt, setCorTxt] = useState(CORES_AGENDA[0]);
  const [descricao, setDescricao] = useState("");
  const [endereco, setEndereco] = useState("");
  const [erros, setErros] = useState<Record<string, string>>({});
  const [busy, setBusy] = useState(false);
  if (alvo !== aberto) {
    setAberto(alvo);
    setTitulo(e?.titulo || "");
    setInicio(e?.inicio || (alvo && "novo" in alvo ? alvo.novo : hojeIso()));
    setFim(e?.fim || "");
    setVariosDias(!!(e?.fim && e.fim !== e.inicio));
    setDiaInteiro(!e?.hora_inicio);
    setHi(hhmm(e?.hora_inicio));
    setHf(hhmm(e?.hora_fim));
    setCor(e?.cor || CORES_AGENDA[0]);
    setCorTxt(e?.cor || CORES_AGENDA[0]);
    setDescricao(e?.descricao || "");
    setEndereco(e?.endereco || "");
    setErros({});
  }
  const escolherCor = (c: string) => {
    setCor(c.toUpperCase());
    setCorTxt(c.toUpperCase());
  };

  async function salvar() {
    const er: Record<string, string> = {};
    if (!titulo.trim()) er.titulo = "Escreva o título do evento.";
    if (!inicio) er.inicio = "Escolha o dia.";
    if (variosDias && (!fim || fim < inicio)) er.fim = "A data final precisa ser depois do primeiro dia.";
    if (!diaInteiro && !hi) er.hi = "Coloque a hora de início ou marque Dia inteiro.";
    if (!diaInteiro && hi && hf && hf <= hi && !variosDias) er.hf = "A hora de fim precisa ser depois do início.";
    if (!HEX.test(cor)) er.cor = "Use uma cor no formato #F26B1D.";
    setErros(er);
    if (Object.keys(er).length) return;
    setBusy(true);
    try {
      const id = await salvarEvento(e?.id || null, {
        titulo: titulo.trim(),
        inicio,
        fim: variosDias && fim !== inicio ? fim : null,
        hora_inicio: diaInteiro ? null : hi,
        hora_fim: diaInteiro || !hf ? null : hf,
        cor,
        descricao: descricao.trim() || null,
        endereco: endereco.trim() || null,
      });
      toast.success(e ? "Evento atualizado." : "Evento colocado na agenda.");
      onSalvo(id);
    } catch (err) {
      toast.error((err as Error).message);
    } finally {
      setBusy(false);
    }
  }

  return (
    <Sheet
      open={!!alvo}
      onClose={onClose}
      title={e ? "Editar evento" : "Novo evento"}
      footer={
        <>
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
          <Button loading={busy} onClick={salvar}>
            {e ? "Salvar alterações" : "Colocar na agenda"}
          </Button>
        </>
      }
    >
      <div className="space-y-4">
        <div className="truncate rounded-xl px-3 py-2 text-sm font-semibold shadow-sm" style={{ background: HEX.test(cor) ? cor : "#ccc", color: textoSobre(cor) }} aria-hidden>
          {hi && !diaInteiro && <span className="mr-1.5 font-normal opacity-90">{hi}</span>}
          {titulo || "Assim fica o card na agenda"}
        </div>
        <Input label="Título" required value={titulo} error={erros.titulo} onChange={(ev) => setTitulo(ev.target.value)} placeholder="Ex.: Reunião regular" maxLength={120} />
        <label className="inline-flex cursor-pointer items-center gap-2 text-sm text-ink-700">
          <input type="checkbox" className="size-4 accent-tiger-500" checked={variosDias} onChange={(ev) => setVariosDias(ev.target.checked)} /> Dura mais de um dia
        </label>
        <div className={cn("grid gap-4", variosDias && "grid-cols-2")}>
          <Input label={variosDias ? "Primeiro dia" : "Dia"} required type="date" value={inicio} error={erros.inicio} onChange={(ev) => setInicio(ev.target.value)} />
          {variosDias && <Input label="Último dia" type="date" value={fim} min={inicio} error={erros.fim} onChange={(ev) => setFim(ev.target.value)} />}
        </div>
        <div className="space-y-3 rounded-2xl border border-ink-200 p-3">
          <label className="inline-flex cursor-pointer items-center gap-2 text-sm font-medium text-ink-800">
            <input type="checkbox" className="size-4 accent-tiger-500" checked={diaInteiro} onChange={(ev) => setDiaInteiro(ev.target.checked)} /> Dia inteiro (sem horário)
          </label>
          {!diaInteiro && (
            <div className="grid grid-cols-2 gap-4">
              <Input label="Começa" type="time" value={hi} error={erros.hi} onChange={(ev) => setHi(ev.target.value)} />
              <Input label="Termina (opcional)" type="time" value={hf} error={erros.hf} onChange={(ev) => setHf(ev.target.value)} />
            </div>
          )}
        </div>
        <div>
          <div className="mb-1.5 text-sm font-medium text-ink-800">Cor do card</div>
          <div className="flex flex-wrap items-center gap-2">
            {CORES_AGENDA.map((c) => (
              <button
                key={c}
                type="button"
                onClick={() => escolherCor(c)}
                className={cn("size-8 rounded-full ring-offset-2 transition-shadow", cor.toUpperCase() === c.toUpperCase() ? "ring-2 ring-ink-900" : "hover:ring-2 hover:ring-ink-300")}
                style={{ background: c }}
                aria-label={`Cor ${c}`}
                aria-pressed={cor.toUpperCase() === c.toUpperCase()}
              />
            ))}
            <label className="relative grid size-8 cursor-pointer place-items-center rounded-full border-2 border-dashed border-ink-300 text-ink-500 hover:border-ink-500" title="Escolher outra cor">
              <Plus className="size-4" />
              <input type="color" value={HEX.test(cor) ? cor : "#F26B1D"} onChange={(ev) => escolherCor(ev.target.value)} className="absolute inset-0 cursor-pointer opacity-0" aria-label="Escolher outra cor" />
            </label>
            <input
              value={corTxt}
              onChange={(ev) => {
                const v = ev.target.value.trim();
                setCorTxt(v);
                const h = v.startsWith("#") ? v : "#" + v;
                if (HEX.test(h)) setCor(h.toUpperCase());
              }}
              className={cn("h-9 w-24 rounded-xl border px-2.5 font-mono text-sm uppercase", erros.cor ? "border-red-400" : "border-ink-200")}
              aria-label="Código da cor"
              maxLength={7}
            />
          </div>
          {erros.cor && <p className="mt-1 text-[13px] text-red-600">{erros.cor}</p>}
        </div>
        <Textarea label="Descrição (opcional)" value={descricao} onChange={(ev) => setDescricao(ev.target.value)} maxLength={2000} placeholder="O que vai acontecer, o que levar…" />
        <Input
          label="Endereço (opcional)"
          value={endereco}
          onChange={(ev) => setEndereco(ev.target.value)}
          placeholder="Ex.: Rua das Flores, 100, São Paulo"
          hint="Com endereço, quem abrir o evento escolhe ir pelo Google Maps ou pelo Waze."
          maxLength={200}
        />
      </div>
    </Sheet>
  );
}

function Sincronizar({ open, onClose, eventos }: { open: boolean; onClose: () => void; eventos: AgendaEvento[] }) {
  const l = linksAssinatura(origem());
  const pagina = `${origem()}/calendario`;
  const [baixando, setBaixando] = useState(false);
  async function excel() {
    setBaixando(true);
    try {
      await downloadBlob(await agendaExcel(eventos), fileName("agenda", "xlsx"));
    } catch (e) {
      toast.error("Não foi possível gerar o Excel: " + (e as Error).message);
    } finally {
      setBaixando(false);
    }
  }
  const linha = "flex h-12 w-full items-center gap-3 rounded-xl border border-ink-200 bg-white px-4 text-left text-sm font-semibold text-ink-800 hover:bg-ink-50";
  return (
    <Sheet open={open} onClose={onClose} title="Sincronizar a agenda" description="Coloque a agenda do clube no seu celular. Ela se atualiza sozinha quando o clube muda algo.">
      <div className="space-y-3">
        <a href={l.google} target="_blank" rel="noopener noreferrer" className={linha}>
          <CalendarPlus className="size-5 text-[#1a73e8]" /> Adicionar ao Google Agenda
        </a>
        <a href={l.webcal} className={linha}>
          <Smartphone className="size-5 text-ink-700" /> Adicionar no iPhone (Calendário)
        </a>
        <button onClick={() => copiar(l.https, "Link da agenda copiado.")} className={linha}>
          <Copy className="size-5 text-ink-500" /> Copiar o link da agenda (outros apps)
        </button>
        <button onClick={excel} disabled={baixando || !eventos.length} className={cn(linha, "disabled:opacity-50")}>
          <FileSpreadsheet className="size-5 text-emerald-600" /> {baixando ? "Gerando…" : "Baixar a agenda em Excel"}
        </button>
        <button onClick={() => copiar(pagina, "Link da página da agenda copiado.")} className={linha}>
          <Link2 className="size-5 text-tiger-600" /> Copiar o link para ver no navegador
        </button>
        <div className="rounded-xl bg-ink-50 p-3 text-[13px] leading-relaxed text-ink-600">
          <p>
            <b className="text-ink-800">Google Agenda:</b> abra pelo computador ou pelo navegador do celular e confirme em &quot;Adicionar&quot;. Depois ela aparece também no app do Google
            Agenda. O Google costuma levar algumas horas para mostrar as mudanças.
          </p>
          <p className="mt-2">
            <b className="text-ink-800">iPhone:</b> toque em &quot;Adicionar no iPhone&quot; e depois em &quot;Assinar&quot;.
          </p>
          <p className="mt-2">Não precisa ter cadastro no app: pode mandar o link da página para os desbravadores e as famílias.</p>
        </div>
      </div>
    </Sheet>
  );
}
