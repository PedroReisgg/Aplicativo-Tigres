"use client";

import { useEffect, useMemo, useState } from "react";
import { Award, BookOpen, CalendarClock, Check, ChevronDown, Clock, History, Minus, Paperclip, Plus, RotateCcw, Trash2 } from "lucide-react";
import { Button, Card, Input, Skeleton, cn } from "./ui";
import { supabaseBrowser } from "@/lib/supabase/client";
import { dataHoraExtenso, hojeLocal } from "@/lib/format";
import type { RegistroAtividade } from "@/lib/types";

const POR_PAGINA = 40;
// ações seguidas da mesma pessoa em até 15 minutos viram um bloco só ("aprovou 3 itens")
const JANELA = 15 * 60 * 1000;

type Verbo = "aprovou" | "marcou" | "devolveu" | "desmarcou" | "registrou" | "removeu" | "anexou" | "editou";

const VERBOS: Record<Verbo, { icon: typeof Check; cor: string }> = {
  aprovou: { icon: Check, cor: "bg-emerald-50 text-emerald-700" },
  marcou: { icon: Plus, cor: "bg-blue-50 text-blue-700" },
  registrou: { icon: Plus, cor: "bg-blue-50 text-blue-700" },
  devolveu: { icon: RotateCcw, cor: "bg-red-50 text-red-700" },
  desmarcou: { icon: Minus, cor: "bg-ink-100 text-ink-600" },
  removeu: { icon: Trash2, cor: "bg-ink-100 text-ink-600" },
  anexou: { icon: Paperclip, cor: "bg-amber-50 text-amber-700" },
  editou: { icon: CalendarClock, cor: "bg-violet-50 text-violet-700" },
};

/** O que aparece no histórico: o diretor que marca já aprova na hora. */
function verboDe(r: RegistroAtividade): Verbo {
  if (r.acao === "marcou" && /já aprovad/i.test(r.detalhe || "")) return "aprovou";
  return r.acao as Verbo;
}

interface Grupo {
  id: number;
  autor: string;
  verbo: Verbo;
  tipo: RegistroAtividade["tipo"];
  quando: string;
  rows: RegistroAtividade[];
}

function agrupar(rows: RegistroAtividade[]): Grupo[] {
  const out: Grupo[] = [];
  for (const r of rows) {
    const verbo = verboDe(r);
    const autor = r.autor_nome || "Sistema";
    const g = out[out.length - 1];
    if (
      g &&
      r.tipo === "caderno" &&
      g.tipo === "caderno" &&
      g.verbo === verbo &&
      g.autor === autor &&
      verbo !== "devolveu" &&
      Math.abs(new Date(g.quando).getTime() - new Date(r.created_at).getTime()) <= JANELA
    ) {
      g.rows.push(r);
      continue;
    }
    out.push({ id: r.id, autor, verbo, tipo: r.tipo, quando: r.created_at, rows: [r] });
  }
  return out;
}

/** "Amigo · I.1 Ter, no mínimo, 10 anos" -> "Ter, no mínimo, 10 anos" */
function textoDoItem(r: RegistroAtividade) {
  const t = (r.alvo_nome || "").replace(/^[^·]*·\s*/, "");
  return r.alvo && t.startsWith(r.alvo) ? t.slice(r.alvo.length).trim() : t;
}

function frase(g: Grupo) {
  const n = g.rows.length;
  if (g.tipo === "caderno") {
    const alvo = n > 1 ? `${n} itens do caderno` : `o item ${g.rows[0].alvo} do caderno`;
    switch (g.verbo) {
      case "aprovou":
        return `aprovou ${alvo}`;
      case "marcou":
        return `marcou como feito ${alvo}`;
      case "devolveu":
        return `devolveu para refazer ${alvo}`;
      case "desmarcou":
        return `desmarcou ${alvo}`;
      default:
        return `${g.verbo} ${alvo}`;
    }
  }
  const nome = g.rows[0].alvo_nome || g.rows[0].alvo || "";
  switch (g.verbo) {
    case "registrou":
      return `colocou no sistema a especialidade ${nome}`;
    case "aprovou":
      return `validou a especialidade ${nome}`;
    case "devolveu":
      return `devolveu para refazer a especialidade ${nome}`;
    case "removeu":
      return `tirou a especialidade ${nome}`;
    case "anexou":
      return `anexou um comprovante em ${nome}`;
    case "editou":
      return `mudou a data da especialidade ${nome}`;
    default:
      return `${g.verbo} ${nome}`;
  }
}

/**
 * Histórico da ficha do desbravador: quem marcou, aprovou ou devolveu cada item do caderno
 * e cada especialidade, com dia e hora. Vem do registro que o banco grava sozinho.
 */
export function HistoricoDesbravador({ desbravadorId, versao }: { desbravadorId: string; versao: string }) {
  const sb = supabaseBrowser();
  const [rows, setRows] = useState<RegistroAtividade[]>([]);
  const [loading, setLoading] = useState(true);
  const [fim, setFim] = useState(true);
  const [mais, setMais] = useState(false);
  const [dia, setDia] = useState("");

  function consulta() {
    let c = sb.from("registro_atividades").select("*").eq("desbravador_id", desbravadorId).order("created_at", { ascending: false }).order("id", { ascending: false });
    if (dia) {
      // o dia escolhido no fuso de quem está vendo
      const ini = new Date(`${dia}T00:00:00`);
      const fimDia = new Date(ini.getTime() + 864e5);
      c = c.gte("created_at", ini.toISOString()).lt("created_at", fimDia.toISOString());
    }
    return c;
  }

  useEffect(() => {
    let vivo = true;
    consulta()
      .range(0, POR_PAGINA - 1)
      .then(({ data }: { data: RegistroAtividade[] | null }) => {
        if (!vivo) return;
        setRows(data || []);
        setFim((data || []).length < POR_PAGINA);
        setLoading(false);
      });
    return () => {
      vivo = false;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [desbravadorId, versao, dia]);

  async function carregarMais() {
    setMais(true);
    const { data } = await consulta().range(rows.length, rows.length + POR_PAGINA - 1);
    setRows((r) => [...r, ...((data || []) as RegistroAtividade[])]);
    setFim((data || []).length < POR_PAGINA);
    setMais(false);
  }

  const grupos = useMemo(() => agrupar(rows), [rows]);

  return (
    <section aria-labelledby="historico-titulo">
      <div className="mb-3 flex items-end justify-between gap-3">
        <h2 id="historico-titulo" className="font-display text-xl font-semibold uppercase tracking-wide">
          Histórico
        </h2>
        <div className="w-[150px]">
          <Input type="date" aria-label="Ver só um dia" value={dia} max={hojeLocal()} onChange={(e) => {
              setLoading(true);
              setDia(e.target.value);
            }} className="h-9 text-sm" />
        </div>
      </div>
      <Card className="p-4">
        {loading ? (
          <div className="space-y-3">
            {Array.from({ length: 3 }).map((_, i) => (
              <Skeleton key={i} className="h-12" />
            ))}
          </div>
        ) : !grupos.length ? (
          <div className="flex flex-col items-center px-4 py-6 text-center">
            <span className="grid size-10 place-items-center rounded-full bg-ink-100 text-ink-500">
              <History className="size-5" />
            </span>
            <p className="mt-3 text-sm font-semibold text-ink-800">{dia ? "Nada registrado neste dia" : "Nada no histórico ainda"}</p>
            <p className="mt-1 max-w-xs text-sm text-ink-500">
              {dia ? (
                <button className="font-semibold text-tiger-700 hover:underline" onClick={() => {
                    setLoading(true);
                    setDia("");
                  }}>
                  Ver todos os dias
                </button>
              ) : (
                "Quando alguém marcar um item do caderno ou registrar uma especialidade, aparece aqui com o nome, o dia e a hora."
              )}
            </p>
          </div>
        ) : (
          <ol className="space-y-4">
            {grupos.map((g) => (
              <BlocoHistorico key={g.id} g={g} />
            ))}
          </ol>
        )}
        {!loading && !fim && (
          <div className="mt-4 flex justify-center">
            <Button variant="secondary" size="sm" loading={mais} onClick={carregarMais}>
              Ver mais antigos
            </Button>
          </div>
        )}
      </Card>
    </section>
  );
}

function BlocoHistorico({ g }: { g: Grupo }) {
  const [aberto, setAberto] = useState(false);
  const v = VERBOS[g.verbo] || VERBOS.registrou;
  const Tipo = g.tipo === "caderno" ? BookOpen : Award;
  const LIMITE = 4;
  // na ordem em que foram feitos (I.1, I.2, …)
  const ordem = [...g.rows].reverse();
  const itens = g.tipo === "caderno" ? (aberto ? ordem : ordem.slice(0, LIMITE)) : [];
  const det = g.rows[0].detalhe;
  const aguardando = g.verbo === "marcou" || (g.verbo === "registrou" && /aguardando/i.test(det || ""));
  // detalhe da especialidade sem o "aguardando…", que já vira etiqueta
  const detEsp = g.tipo === "especialidade" && det ? det.replace(/\s*·\s*(aguardando validação do diretor|lançada pela diretoria \(já aprovada\))$/i, "") : "";

  return (
    <li className="flex gap-3">
      <span className={cn("mt-0.5 grid size-8 shrink-0 place-items-center rounded-full", v.cor)}>
        <v.icon className="size-4" />
      </span>
      <div className="min-w-0 flex-1 text-sm">
        <p className="text-ink-700">
          <span className="font-semibold text-ink-900">{g.autor}</span> {frase(g)}
        </p>
        {itens.length > 0 && (
          <ul className="mt-1 space-y-0.5">
            {itens.map((r) => (
              <li key={r.id} className="flex gap-1.5 text-xs text-ink-500">
                <span className="shrink-0 font-mono font-semibold text-ink-400">{r.alvo}</span>
                <span className="line-clamp-1">{textoDoItem(r)}</span>
              </li>
            ))}
          </ul>
        )}
        {g.tipo === "caderno" && g.rows.length > LIMITE && (
          <button onClick={() => setAberto((a) => !a)} className="mt-0.5 inline-flex items-center gap-0.5 text-xs font-semibold text-tiger-700 hover:underline" aria-expanded={aberto}>
            {aberto ? "Mostrar menos" : `Ver os ${g.rows.length} itens`}
            <ChevronDown className={cn("size-3.5 transition-transform", aberto && "rotate-180")} />
          </button>
        )}
        {g.verbo === "devolveu" && det && <p className="mt-1 rounded-lg bg-red-50 px-2 py-1 text-xs text-red-700">{det}</p>}
        {g.tipo === "especialidade" && g.verbo === "anexou" && det && <p className="text-xs text-ink-500">Arquivo: {det}</p>}
        {g.tipo === "especialidade" && g.verbo !== "anexou" && g.verbo !== "devolveu" && detEsp && <p className="text-xs text-ink-500">{detEsp}</p>}
        <p className="mt-1 flex flex-wrap items-center gap-x-2 gap-y-0.5 text-xs text-ink-400">
          <span className="inline-flex items-center gap-1">
            <Tipo className="size-3.5" />
            <time dateTime={g.quando}>{dataHoraExtenso(g.quando)}</time>
          </span>
          {aguardando && (
            <span className="inline-flex items-center gap-1 rounded-full bg-amber-50 px-1.5 py-px font-semibold text-amber-700">
              <Clock className="size-3" /> aguardava o diretor
            </span>
          )}
        </p>
      </div>
    </li>
  );
}
