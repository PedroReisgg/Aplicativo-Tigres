"use client";

import { Suspense, useEffect, useMemo, useState } from "react";
import { useSearchParams } from "next/navigation";
import { ArrowDown, ArrowUp, Bell, ClipboardList, Copy, Pencil, Plus, Share2, Trash2, X } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Button, Card, Confirm, EmptyState, Input, PageHeader, Sheet, Skeleton, Textarea, cn } from "@/components/ui";
import { supabaseBrowser } from "@/lib/supabase/client";
import { must, useData } from "@/lib/use-data";
import { getMembros } from "@/lib/api";
import { dataLocal, diaSemana, hojeIso, isoDia, nomeMes } from "@/lib/agenda-core";
import type { Profile, Programacao, ProgramacaoItem } from "@/lib/types";

const dataLonga = (iso: string) => {
  const d = dataLocal(iso);
  return `${diaSemana(iso).replace(/^./, (c) => c.toUpperCase())}, ${d.getDate()} de ${nomeMes(d.getMonth())}`;
};

function proximoSabado() {
  const d = new Date();
  d.setHours(12);
  d.setDate(d.getDate() + ((6 - d.getDay() + 7) % 7));
  return isoDia(d);
}

const ordenar = (itens: ProgramacaoItem[]) => [...itens].sort((a, b) => (a.hora || "99").localeCompare(b.hora || "99"));

function textoWhatsApp(p: Programacao) {
  return [`*${p.titulo}*`, dataLonga(p.data), "", ...ordenar(p.itens).map((i) => `${i.hora || "--:--"}  ${i.atividade}`), ...(p.observacao ? ["", p.observacao] : [])].join("\n");
}

export default function Page() {
  return (
    <Suspense>
      <ProgramacaoPage />
    </Suspense>
  );
}

function ProgramacaoPage() {
  const auth = useAuth();
  const params = useSearchParams();
  const destaque = params.get("id");
  const [editar, setEditar] = useState<Programacao | "nova" | { copia: Programacao } | null>(null);
  const [verAntigas, setVerAntigas] = useState(false);

  const { data, loading, error, reload } = useData(async () => {
    const r = await supabaseBrowser().from("programacoes").select("*").order("data", { ascending: false }).limit(200);
    if (r.error && /programacoes|does not exist|schema cache/i.test(r.error.message)) throw new Error("A programação ainda não foi ativada no banco. Peça ao diretor para rodar o SQL 0006.");
    const membros = await getMembros().catch(() => [] as Profile[]);
    return { lista: must(r) as Programacao[], membros };
  }, [auth.isActive]);

  const hoje = hojeIso();
  const proximas = useMemo(() => (data?.lista || []).filter((p) => p.data >= hoje).sort((a, b) => a.data.localeCompare(b.data)), [data, hoje]);
  const antigas = useMemo(() => (data?.lista || []).filter((p) => p.data < hoje), [data, hoje]);
  const destaqueAntiga = !!destaque && antigas.some((p) => p.id === destaque);

  useEffect(() => {
    if (!destaque || !data) return;
    const el = document.getElementById(`prog-${destaque}`);
    el?.scrollIntoView({ behavior: "smooth", block: "start" });
  }, [destaque, data, verAntigas]);

  if (!auth.isActive) return <EmptyState icon={<ClipboardList className="size-6" />} title="Acesso pendente" description="Quando o diretor liberar seu acesso, você verá a programação do clube." />;

  const quem = (id: string | null) => data?.membros.find((m) => m.id === id)?.nome.split(" ").slice(0, 2).join(" ");
  const card = (p: Programacao) => (
    <CartaoProgramacao key={p.id} p={p} destaque={p.id === destaque} autor={quem(p.atualizado_por)} podeEditar={auth.isAdmin} onEditar={() => setEditar(p)} onCopiar={() => setEditar({ copia: p })} />
  );

  return (
    <div>
      <PageHeader
        eyebrow="Diretoria"
        title="Programação"
        description={
          auth.isAdmin
            ? "Monte a programação do sábado (ou de outro dia) com os horários. Toda a diretoria recebe uma notificação. Ela não vai para a agenda pública."
            : "O que vai acontecer em cada horário das próximas reuniões. Só a diretoria vê."
        }
        actions={
          auth.isAdmin && (
            <Button icon={<Plus className="size-4" />} onClick={() => setEditar("nova")}>
              Nova programação
            </Button>
          )
        }
      />
      {loading ? (
        <div className="grid gap-4 md:grid-cols-2">
          <Skeleton className="h-72" />
          <Skeleton className="h-72" />
        </div>
      ) : error || !data ? (
        <EmptyState icon={<ClipboardList className="size-6" />} title="Não foi possível abrir a programação" description={error || "Tente de novo."} action={<Button onClick={() => reload()}>Tentar de novo</Button>} />
      ) : !data.lista.length ? (
        <EmptyState
          icon={<ClipboardList className="size-6" />}
          title="Nenhuma programação ainda"
          description={auth.isAdmin ? "Crie a programação do próximo sábado com os horários de cada atividade." : "Quando o diretor publicar a programação, ela aparece aqui e você recebe uma notificação."}
          action={auth.isAdmin && <Button onClick={() => setEditar("nova")}>Criar programação</Button>}
        />
      ) : (
        <div className="space-y-8">
          {proximas.length ? <div className="grid items-start gap-4 md:grid-cols-2">{proximas.map(card)}</div> : <p className="text-sm text-ink-500">Nenhuma programação para os próximos dias.</p>}
          {antigas.length > 0 && (
            <section>
              {verAntigas || destaqueAntiga ? (
                <>
                  <h2 className="mb-3 font-display text-xl font-semibold uppercase tracking-wide text-ink-500">Anteriores</h2>
                  <div className="grid items-start gap-4 md:grid-cols-2">{antigas.map(card)}</div>
                </>
              ) : (
                <Button variant="secondary" onClick={() => setVerAntigas(true)}>
                  Ver programações anteriores ({antigas.length})
                </Button>
              )}
            </section>
          )}
        </div>
      )}
      {auth.isAdmin && <EditarProgramacao alvo={editar} onClose={() => setEditar(null)} onSalvo={() => (setEditar(null), reload(true))} />}
    </div>
  );
}

function CartaoProgramacao({ p, destaque, autor, podeEditar, onEditar, onCopiar }: { p: Programacao; destaque: boolean; autor?: string; podeEditar: boolean; onEditar: () => void; onCopiar: () => void }) {
  const passou = p.data < hojeIso();
  async function compartilhar() {
    const texto = textoWhatsApp(p);
    try {
      if (navigator.share) await navigator.share({ text: texto });
      else {
        await navigator.clipboard.writeText(texto);
        toast.success("Programação copiada. Cole no WhatsApp.");
      }
    } catch {
      /* cancelou */
    }
  }
  return (
    <Card id={`prog-${p.id}`} className={cn("scroll-mt-24 overflow-hidden", destaque && "ring-2 ring-tiger-500", passou && "opacity-80")}>
      <div className="flex items-start justify-between gap-3 border-b border-ink-100 bg-ink-50/60 px-5 py-4">
        <div className="min-w-0">
          <div className="text-xs font-semibold uppercase tracking-[.12em] text-tiger-600">{dataLonga(p.data)}</div>
          <h2 className="mt-0.5 font-display text-2xl font-semibold uppercase leading-tight tracking-wide">{p.titulo}</h2>
        </div>
        <div className="flex shrink-0 gap-1">
          <button onClick={compartilhar} className="grid size-9 place-items-center rounded-xl text-ink-500 hover:bg-ink-100" aria-label="Compartilhar no WhatsApp" title="Compartilhar">
            <Share2 className="size-4" />
          </button>
          {podeEditar && (
            <>
              <button onClick={onCopiar} className="grid size-9 place-items-center rounded-xl text-ink-500 hover:bg-ink-100" aria-label="Usar como base para outro dia" title="Usar como base para outro dia">
                <Copy className="size-4" />
              </button>
              <button onClick={onEditar} className="grid size-9 place-items-center rounded-xl text-ink-500 hover:bg-ink-100" aria-label="Editar" title="Editar">
                <Pencil className="size-4" />
              </button>
            </>
          )}
        </div>
      </div>
      {p.itens.length ? (
        <ol className="relative px-5 py-4">
          {ordenar(p.itens).map((i, n, arr) => (
            <li key={n} className="relative flex gap-4 pb-4 last:pb-0">
              {n < arr.length - 1 && <span className="absolute left-[54px] top-6 h-[calc(100%-12px)] w-px bg-ink-200" aria-hidden />}
              <span className="w-11 shrink-0 pt-0.5 text-right font-mono text-sm font-semibold tabular-nums text-ink-900">{i.hora || "--:--"}</span>
              <span className="relative mt-1.5 size-2.5 shrink-0 rounded-full bg-tiger-500 ring-4 ring-tiger-100" aria-hidden />
              <span className="min-w-0 flex-1 whitespace-pre-line text-[15px] text-ink-800">{i.atividade}</span>
            </li>
          ))}
        </ol>
      ) : (
        <p className="px-5 py-4 text-sm text-ink-500">Sem horários.</p>
      )}
      {p.observacao && <p className="mx-5 mb-4 whitespace-pre-line rounded-xl bg-amber-50 px-3 py-2 text-sm text-amber-900">{p.observacao}</p>}
      {autor && <p className="border-t border-ink-100 px-5 py-2.5 text-xs text-ink-400">Atualizada por {autor} em {new Date(p.updated_at).toLocaleDateString("pt-BR")}</p>}
    </Card>
  );
}

type Linha = { k: number; hora: string; atividade: string };
let seq = 1;
const linha = (hora = "", atividade = ""): Linha => ({ k: seq++, hora, atividade });

function EditarProgramacao({ alvo, onClose, onSalvo }: { alvo: Programacao | "nova" | { copia: Programacao } | null; onClose: () => void; onSalvo: () => void }) {
  const p = alvo && alvo !== "nova" && !("copia" in alvo) ? alvo : null;
  const base = alvo && alvo !== "nova" && "copia" in alvo ? alvo.copia : p;
  const [aberto, setAberto] = useState<typeof alvo>(null);
  const [titulo, setTitulo] = useState("");
  const [data, setData] = useState("");
  const [linhas, setLinhas] = useState<Linha[]>([]);
  const [obs, setObs] = useState("");
  const [erros, setErros] = useState<Record<string, string>>({});
  const [busy, setBusy] = useState(false);
  const [excluir, setExcluir] = useState(false);
  if (alvo !== aberto) {
    setAberto(alvo);
    setTitulo(base?.titulo || "Reunião regular");
    setData(p?.data || proximoSabado());
    setLinhas(base?.itens.length ? ordenar(base.itens).map((i) => linha(i.hora, i.atividade)) : [linha("08:00"), linha("08:30"), linha("09:00")]);
    setObs(base?.observacao || "");
    setErros({});
  }
  const mudar = (k: number, campo: "hora" | "atividade", v: string) => setLinhas((ls) => ls.map((l) => (l.k === k ? { ...l, [campo]: v } : l)));
  const mover = (i: number, d: number) =>
    setLinhas((ls) => {
      const n = [...ls];
      const [x] = n.splice(i, 1);
      n.splice(i + d, 0, x);
      return n;
    });
  const proximaHora = () => {
    const ult = [...linhas].reverse().find((l) => l.hora)?.hora;
    if (!ult) return "";
    const [h, m] = ult.split(":").map(Number);
    const t = h * 60 + m + 30;
    return t >= 24 * 60 ? "" : `${String(Math.floor(t / 60)).padStart(2, "0")}:${String(t % 60).padStart(2, "0")}`;
  };

  async function salvar() {
    const itens = linhas.filter((l) => l.atividade.trim()).map((l) => ({ hora: l.hora, atividade: l.atividade.trim() }));
    const er: Record<string, string> = {};
    if (!titulo.trim()) er.titulo = "Dê um título.";
    if (!data) er.data = "Escolha o dia.";
    if (!itens.length) er.itens = "Coloque pelo menos uma atividade.";
    setErros(er);
    if (Object.keys(er).length) return;
    setBusy(true);
    const campos = { titulo: titulo.trim(), data, itens: ordenar(itens), observacao: obs.trim() || null };
    const sb = supabaseBrowser();
    const { error } = p ? await sb.from("programacoes").update(campos).eq("id", p.id) : await sb.from("programacoes").insert(campos);
    setBusy(false);
    if (error) return toast.error(error.message);
    toast.success(p ? "Programação atualizada. A diretoria foi avisada." : "Programação publicada. A diretoria foi avisada.");
    onSalvo();
  }

  async function apagar() {
    if (!p) return;
    setBusy(true);
    const { error } = await supabaseBrowser().from("programacoes").delete().eq("id", p.id);
    setBusy(false);
    if (error) return toast.error(error.message);
    setExcluir(false);
    toast.success("Programação excluída.");
    onSalvo();
  }

  return (
    <>
      <Sheet
        open={!!alvo}
        onClose={onClose}
        wide
        title={p ? "Editar programação" : "Nova programação"}
        footer={
          <>
            {p && (
              <Button variant="ghost" className="mr-auto text-red-600 hover:bg-red-50" icon={<Trash2 className="size-4" />} onClick={() => setExcluir(true)}>
                Excluir
              </Button>
            )}
            <Button variant="secondary" onClick={onClose}>
              Cancelar
            </Button>
            <Button loading={busy} icon={<Bell className="size-4" />} onClick={salvar}>
              {p ? "Salvar e avisar" : "Publicar e avisar"}
            </Button>
          </>
        }
      >
        <div className="space-y-4">
          <div className="grid gap-4 sm:grid-cols-[1.4fr_1fr]">
            <Input label="Título" required value={titulo} error={erros.titulo} onChange={(e) => setTitulo(e.target.value)} placeholder="Ex.: Reunião regular" maxLength={100} />
            <Input label="Dia" required type="date" value={data} error={erros.data} onChange={(e) => setData(e.target.value)} hint={data ? dataLonga(data) : undefined} />
          </div>
          <div>
            <div className="mb-1.5 text-sm font-medium text-ink-800">Horários</div>
            <ul className="space-y-2">
              {linhas.map((l, i) => (
                <li key={l.k} className="flex items-start gap-2">
                  <input
                    type="time"
                    value={l.hora}
                    onChange={(e) => mudar(l.k, "hora", e.target.value)}
                    className="h-11 w-[116px] shrink-0 rounded-xl border border-ink-200 bg-white px-2.5 text-[15px] focus:border-tiger-500 focus:outline-none focus:ring-2 focus:ring-tiger-500/35"
                    aria-label={`Horário ${i + 1}`}
                  />
                  <input
                    value={l.atividade}
                    onChange={(e) => mudar(l.k, "atividade", e.target.value)}
                    placeholder={["Abertura e hino", "Classes", "Especialidade", "Lanche", "Encerramento"][i] || "O que acontece neste horário"}
                    className="h-11 min-w-0 flex-1 rounded-xl border border-ink-200 bg-white px-3 text-[15px] placeholder:text-ink-400 focus:border-tiger-500 focus:outline-none focus:ring-2 focus:ring-tiger-500/35"
                    aria-label={`Atividade ${i + 1}`}
                    maxLength={200}
                  />
                  <div className="hidden shrink-0 sm:flex">
                    <button className="grid size-11 place-items-center rounded-xl text-ink-400 hover:bg-ink-100 disabled:opacity-30" disabled={i === 0} onClick={() => mover(i, -1)} aria-label="Subir">
                      <ArrowUp className="size-4" />
                    </button>
                    <button className="grid size-11 place-items-center rounded-xl text-ink-400 hover:bg-ink-100 disabled:opacity-30" disabled={i === linhas.length - 1} onClick={() => mover(i, 1)} aria-label="Descer">
                      <ArrowDown className="size-4" />
                    </button>
                  </div>
                  <button className="grid size-11 shrink-0 place-items-center rounded-xl text-ink-400 hover:bg-red-50 hover:text-red-600" onClick={() => setLinhas((ls) => ls.filter((x) => x.k !== l.k))} aria-label="Tirar este horário">
                    <X className="size-4" />
                  </button>
                </li>
              ))}
            </ul>
            {erros.itens && <p className="mt-1.5 text-[13px] text-red-600">{erros.itens}</p>}
            <Button className="mt-2" variant="secondary" size="sm" icon={<Plus className="size-4" />} onClick={() => setLinhas((ls) => [...ls, linha(proximaHora())])}>
              Adicionar horário
            </Button>
            <p className="mt-1.5 text-[13px] text-ink-500">Na hora de salvar, os horários ficam em ordem.</p>
          </div>
          <Textarea label="Observação (opcional)" value={obs} onChange={(e) => setObs(e.target.value)} maxLength={1000} placeholder="Ex.: Uniforme de gala. Trazer a Bíblia." />
          <p className="rounded-xl bg-tiger-50 px-3 py-2 text-[13px] text-tiger-900">Ao salvar, todos da diretoria recebem uma notificação com a programação.</p>
        </div>
      </Sheet>
      <Confirm open={excluir} danger title="Excluir esta programação?" message="Ela some para toda a diretoria." confirmLabel="Excluir programação" loading={busy} onConfirm={apagar} onClose={() => setExcluir(false)} />
    </>
  );
}
