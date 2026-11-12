"use client";

import { useMemo, useState } from "react";
import { Checkbox, Input, cn } from "./ui";
import { ReportPanel } from "./report-panel";
import { useData } from "@/lib/use-data";
import { getCategorias, getDesbravadores, getEspecialidades } from "@/lib/api";
import { supabaseBrowser } from "@/lib/supabase/client";
import { brToIso, isoToBr, maskDate } from "@/lib/format";
import { clubReportExcel, clubReportPDF, espReportExcel, espReportPDF, type EspReportLinha, type IncluirRelacao } from "@/lib/reports";
import type { Classe, DesbEsp, Desbravador, Profile } from "@/lib/types";

export function Opcoes<T extends string>({ value, onChange, items, label }: { value: T; onChange: (v: T) => void; items: { value: T; label: string }[]; label: string }) {
  return (
    <div role="radiogroup" aria-label={label} className="inline-flex flex-wrap gap-1 rounded-xl bg-ink-100 p-1">
      {items.map((i) => (
        <button
          key={i.value}
          role="radio"
          aria-checked={value === i.value}
          onClick={() => onChange(i.value)}
          className={cn(
            "h-9 rounded-lg px-3 text-sm font-semibold transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-tiger-500",
            value === i.value ? "bg-white text-ink-900 shadow-sm" : "text-ink-500 hover:text-ink-800",
          )}
        >
          {i.label}
        </button>
      ))}
    </div>
  );
}

/** Relação de membros: o diretor escolhe só desbravadores, só diretoria ou os dois. */
export function RelacaoMembrosPanel({ membros, classes, desb }: { membros: Profile[]; classes: Classe[]; desb: Desbravador[] | null }) {
  const [incluir, setIncluir] = useState<IncluirRelacao>("ambos");
  const base = incluir === "ambos" ? "relacao-clube" : incluir === "diretoria" ? "relacao-diretoria" : "relacao-desbravadores";
  const lista = () => membros.filter((m) => m.status !== "inativo");
  const desbs = async () => desb || (await getDesbravadores());
  return (
    <ReportPanel
      titulo="Relação dos membros do clube"
      base={base}
      descricao="Diretoria (funções, idade, contato) e desbravadores (classe, unidade, responsáveis e telefones)."
      link="/diretoria"
      extra={
        <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
          <span className="text-sm font-medium text-ink-700">Incluir na planilha:</span>
          <Opcoes
            label="Quem entra na planilha"
            value={incluir}
            onChange={setIncluir}
            items={[
              { value: "ambos", label: "Os dois" },
              { value: "desbravadores", label: "Só desbravadores" },
              { value: "diretoria", label: "Só diretoria" },
            ]}
          />
        </div>
      }
      excel={async () => clubReportExcel(lista(), await desbs(), classes, incluir)}
      pdf={async () => clubReportPDF(lista(), await desbs(), classes, incluir)}
    />
  );
}

async function todasConcluidas(): Promise<DesbEsp[]> {
  const sb = supabaseBrowser();
  const out: DesbEsp[] = [];
  for (let from = 0; from < 50000; from += 1000) {
    const { data, error } = await sb
      .from("desbravador_especialidades")
      .select("*")
      .eq("status", "concluida")
      .order("concluida_em")
      .range(from, from + 999);
    if (error) throw new Error(error.message);
    out.push(...((data || []) as DesbEsp[]));
    if ((data || []).length < 1000) break;
  }
  return out;
}

/** Relação de especialidades concluídas (por desbravador e total de cada uma), para comprar. */
export function EspecialidadesCompraPanel() {
  const [de, setDe] = useState("");
  const [ate, setAte] = useState("");
  const [pendentes, setPendentes] = useState(false);
  const { data, error } = useData(async () => {
    const [desb, todas, cats, feitas] = await Promise.all([getDesbravadores(), getEspecialidades(), getCategorias(), todasConcluidas()]);
    return { desb, todas, cats, feitas };
  }, []);

  const deIso = brToIso(de);
  const ateIso = brToIso(ate);
  const linhas = useMemo<EspReportLinha[]>(() => {
    if (!data) return [];
    const desb = new Map(data.desb.map((d) => [d.id, d]));
    const esp = new Map(data.todas.map((e) => [e.codigo, e]));
    const area = new Map(data.cats.map((c) => [c.slug, c.nome]));
    return data.feitas
      .filter((x) => (pendentes || x.validacao !== "pendente") && (!deIso || x.concluida_em >= deIso) && (!ateIso || x.concluida_em <= ateIso))
      .map((x) => {
        const d = desb.get(x.desbravador_id);
        const e = esp.get(x.especialidade_codigo);
        return d && e ? { desbravador: d, esp: e, area: area.get(e.categoria_slug) || "", concluida_em: x.concluida_em } : null;
      })
      .filter(Boolean) as EspReportLinha[];
  }, [data, deIso, ateIso, pendentes]);

  const periodo = deIso && ateIso ? `de ${isoToBr(deIso)} a ${isoToBr(ateIso)}` : deIso ? `desde ${isoToBr(deIso)}` : ateIso ? `até ${isoToBr(ateIso)}` : "todas as concluídas";
  const tipos = new Set(linhas.map((l) => l.esp.codigo)).size;
  const pessoas = new Set(linhas.map((l) => l.desbravador.id)).size;

  const gerar = (fn: typeof espReportExcel) => async () => {
    if (!data) throw new Error("Ainda carregando as especialidades. Tente de novo em instantes.");
    if (!linhas.length) throw new Error("Nenhuma especialidade concluída neste período.");
    return fn(linhas, periodo);
  };

  return (
    <ReportPanel
      titulo="Especialidades para comprar"
      base="especialidades-para-comprar"
      descricao="Cada desbravador com as especialidades concluídas, e o total de cada especialidade para fazer o pedido."
      link="/diretoria?aba=relacao"
      extra={
        <div className="space-y-3">
          <div className="grid grid-cols-2 gap-3 sm:max-w-md">
            <Input
              label="Concluídas a partir de"
              inputMode="numeric"
              placeholder="dd/mm/aaaa"
              value={de}
              onChange={(e) => setDe(maskDate(e.target.value))}
              error={de.length === 10 && !deIso ? "Data inválida." : undefined}
            />
            <Input
              label="Até"
              inputMode="numeric"
              placeholder="dd/mm/aaaa"
              value={ate}
              onChange={(e) => setAte(maskDate(e.target.value))}
              error={ate.length === 10 && !ateIso ? "Data inválida." : undefined}
            />
          </div>
          <Checkbox checked={pendentes} onChange={setPendentes} label="Incluir as que ainda aguardam a validação do diretor" />
          <p className="text-sm text-ink-600">
            {error ? (
              <span className="text-red-700">Não foi possível carregar as especialidades.</span>
            ) : !data ? (
              "Carregando…"
            ) : (
              <>
                <strong className="text-ink-900">{linhas.length}</strong> especialidade(s) concluída(s), de <strong className="text-ink-900">{tipos}</strong> tipo(s), para{" "}
                <strong className="text-ink-900">{pessoas}</strong> desbravador(es) · {periodo}.
              </>
            )}
          </p>
        </div>
      }
      excel={gerar(espReportExcel)}
      pdf={gerar(espReportPDF)}
    />
  );
}
