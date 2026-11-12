"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { Award, BookOpen, Check, Download, History, Minus, Paperclip, Plus, RotateCcw, Trash2 } from "lucide-react";
import { toast } from "sonner";
import { Button, Card, EmptyState, SearchInput, Select, Skeleton, cn } from "./ui";
import { supabaseBrowser } from "@/lib/supabase/client";
import { downloadBlob, fileName } from "@/lib/reports";
import type { RegistroAtividade } from "@/lib/types";

const POR_PAGINA = 60;

const ACOES: Record<RegistroAtividade["acao"], { texto: string; icon: typeof Check; cor: string }> = {
  registrou: { texto: "registrou", icon: Plus, cor: "bg-blue-50 text-blue-700" },
  marcou: { texto: "marcou", icon: Plus, cor: "bg-blue-50 text-blue-700" },
  aprovou: { texto: "validou", icon: Check, cor: "bg-emerald-50 text-emerald-700" },
  devolveu: { texto: "devolveu para refazer", icon: RotateCcw, cor: "bg-red-50 text-red-700" },
  removeu: { texto: "removeu", icon: Trash2, cor: "bg-ink-100 text-ink-600" },
  desmarcou: { texto: "desmarcou", icon: Minus, cor: "bg-ink-100 text-ink-600" },
  anexou: { texto: "anexou um comprovante em", icon: Paperclip, cor: "bg-amber-50 text-amber-700" },
};

const dataHora = (iso: string) => new Date(iso).toLocaleString("pt-BR", { day: "2-digit", month: "2-digit", year: "numeric", hour: "2-digit", minute: "2-digit" });

/** Registro de quem lançou, validou ou devolveu especialidades e itens do caderno (só o diretor vê). */
export function Historico() {
  const sb = supabaseBrowser();
  const [tipo, setTipo] = useState("");
  const [acao, setAcao] = useState("");
  const [q, setQ] = useState("");
  const [busca, setBusca] = useState("");
  const [rows, setRows] = useState<RegistroAtividade[]>([]);
  const [fim, setFim] = useState(false);
  const [loading, setLoading] = useState(true);
  const [mais, setMais] = useState(false);
  const [baixando, setBaixando] = useState(false);

  useEffect(() => {
    const t = setTimeout(() => setBusca(q.trim()), 350);
    return () => clearTimeout(t);
  }, [q]);

  function consulta() {
    let c = sb.from("registro_atividades").select("*").order("created_at", { ascending: false }).order("id", { ascending: false });
    if (tipo) c = c.eq("tipo", tipo);
    if (acao) c = c.eq("acao", acao);
    if (busca) {
      const b = busca.replace(/[%,()*]/g, " ");
      c = c.or(`desbravador_nome.ilike.%${b}%,alvo_nome.ilike.%${b}%,autor_nome.ilike.%${b}%,alvo.ilike.%${b}%`);
    }
    return c;
  }

  useEffect(() => {
    let vivo = true;
    setLoading(true);
    consulta()
      .range(0, POR_PAGINA - 1)
      .then(({ data, error }: { data: RegistroAtividade[] | null; error: { message: string } | null }) => {
        if (!vivo) return;
        if (error) toast.error(/registro_atividades/.test(error.message) ? "O registro ainda não foi ativado no banco." : error.message);
        setRows(data || []);
        setFim((data || []).length < POR_PAGINA);
        setLoading(false);
      });
    return () => {
      vivo = false;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [tipo, acao, busca]);

  async function carregarMais() {
    setMais(true);
    const { data } = await consulta().range(rows.length, rows.length + POR_PAGINA - 1);
    setRows((r) => [...r, ...((data || []) as RegistroAtividade[])]);
    setFim((data || []).length < POR_PAGINA);
    setMais(false);
  }

  async function baixar() {
    setBaixando(true);
    try {
      const todos: RegistroAtividade[] = [];
      for (let from = 0; from < 20000; from += 1000) {
        const { data } = await consulta().range(from, from + 999);
        todos.push(...((data || []) as RegistroAtividade[]));
        if ((data || []).length < 1000) break;
      }
      const ExcelJS = (await import("exceljs")).default;
      const wb = new ExcelJS.Workbook();
      const ws = wb.addWorksheet("Registro");
      ws.columns = [
        { header: "Data e hora", key: "d", width: 18 },
        { header: "Quem", key: "a", width: 26 },
        { header: "O que fez", key: "o", width: 22 },
        { header: "Tipo", key: "t", width: 14 },
        { header: "Desbravador", key: "n", width: 28 },
        { header: "Especialidade / item", key: "i", width: 48 },
        { header: "Detalhe", key: "x", width: 40 },
      ];
      todos.forEach((r) =>
        ws.addRow({
          d: dataHora(r.created_at),
          a: r.autor_nome || "Sistema",
          o: ACOES[r.acao]?.texto || r.acao,
          t: r.tipo === "caderno" ? "Caderno" : "Especialidade",
          n: r.desbravador_nome,
          i: r.alvo_nome || r.alvo,
          x: r.detalhe || "",
        }),
      );
      ws.getRow(1).font = { bold: true };
      ws.views = [{ state: "frozen", ySplit: 1 }];
      const buf = await wb.xlsx.writeBuffer();
      await downloadBlob(new Blob([buf], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }), fileName("registro-de-atividades", "xlsx"));
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setBaixando(false);
    }
  }

  return (
    <div className="space-y-4">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end">
        <SearchInput value={q} onChange={setQ} placeholder="Buscar nome ou especialidade…" className="flex-1" />
        <div className="grid grid-cols-2 gap-3 sm:flex">
          <Select label="Tipo" value={tipo} onChange={(e) => setTipo(e.target.value)}>
            <option value="">Tudo</option>
            <option value="especialidade">Especialidades</option>
            <option value="caderno">Caderno</option>
          </Select>
          <Select label="Ação" value={acao} onChange={(e) => setAcao(e.target.value)}>
            <option value="">Todas</option>
            <option value="registrou">Registrou</option>
            <option value="marcou">Marcou (caderno)</option>
            <option value="aprovou">Validou</option>
            <option value="devolveu">Devolveu</option>
            <option value="anexou">Anexou</option>
            <option value="removeu">Removeu</option>
            <option value="desmarcou">Desmarcou</option>
          </Select>
        </div>
        <Button variant="secondary" icon={<Download className="size-4" />} loading={baixando} onClick={baixar} className="sm:mb-0">
          Baixar Excel
        </Button>
      </div>

      {loading ? (
        <div className="space-y-2">
          {Array.from({ length: 5 }).map((_, i) => (
            <Skeleton key={i} className="h-16" />
          ))}
        </div>
      ) : !rows.length ? (
        <EmptyState
          icon={<History className="size-6" />}
          title="Nenhum registro encontrado"
          description="Cada especialidade lançada, validada ou devolvida e cada item do caderno marcado aparece aqui, com quem fez e quando."
        />
      ) : (
        <Card className="divide-y divide-ink-100">
          {rows.map((r) => {
            const a = ACOES[r.acao] || ACOES.registrou;
            const Icone = r.tipo === "caderno" ? BookOpen : Award;
            return (
              <div key={r.id} className="flex items-start gap-3 px-4 py-3">
                <span className={cn("mt-0.5 grid size-8 shrink-0 place-items-center rounded-full", a.cor)}>
                  <a.icon className="size-4" />
                </span>
                <div className="min-w-0 flex-1 text-sm">
                  <p className="text-ink-700">
                    <span className="font-semibold text-ink-900">{r.autor_nome || "Sistema"}</span> {a.texto} {r.tipo === "caderno" ? "o item" : r.acao === "anexou" ? "" : "a especialidade"}{" "}
                    <span className="font-semibold text-ink-900">{r.tipo === "caderno" ? r.alvo : r.alvo_nome || r.alvo}</span> de{" "}
                    {r.desbravador_id ? (
                      <Link href={`/desbravadores/${r.desbravador_id}`} className="font-semibold text-ink-900 hover:text-tiger-700">
                        {r.desbravador_nome}
                      </Link>
                    ) : (
                      <span className="font-semibold text-ink-900">{r.desbravador_nome}</span>
                    )}
                  </p>
                  {r.tipo === "caderno" && r.alvo_nome && <p className="line-clamp-1 text-xs text-ink-500">{r.alvo_nome}</p>}
                  {r.detalhe && <p className={cn("text-xs", r.acao === "devolveu" ? "text-red-700" : "text-ink-500")}>{r.acao === "anexou" ? `Arquivo: ${r.detalhe}` : r.detalhe}</p>}
                  <p className="mt-0.5 flex items-center gap-1 text-xs text-ink-400 sm:hidden">
                    <Icone className="size-3.5" />
                    {dataHora(r.created_at)}
                  </p>
                </div>
                <span className="hidden shrink-0 items-center gap-1 text-xs text-ink-400 sm:flex">
                  <Icone className="size-3.5" />
                  <time dateTime={r.created_at}>{dataHora(r.created_at)}</time>
                </span>
              </div>
            );
          })}
        </Card>
      )}
      {!loading && !fim && (
        <div className="flex justify-center">
          <Button variant="secondary" loading={mais} onClick={carregarMais}>
            Carregar mais
          </Button>
        </div>
      )}
    </div>
  );
}
