"use client";

import Link from "next/link";
import { useMemo, useState } from "react";
import { BookOpen, Check, CheckCheck, Clock, RotateCcw } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "./auth-provider";
import { AnexosLista } from "./anexos";
import { EspIcon } from "./domain";
import { Avatar, Badge, Button, Card, EmptyState, Sheet, Skeleton, Textarea } from "./ui";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData, must } from "@/lib/use-data";
import { getDesbravadores, getEspecialidades, notificar, staffIdsDaClasse } from "@/lib/api";
import { getAnexos } from "@/lib/anexos";
import { plural, timeAgo } from "@/lib/format";
import type { CadernoItem, DesbEsp, Desbravador, Profile, Progresso } from "@/lib/types";

type Devolver = { tipo: "esp"; reg: DesbEsp } | { tipo: "cad"; reg: Progresso };

/** Aba do diretor: especialidades e itens do caderno lançados por instrutores/conselheiros, aguardando validação. */
export function Validacoes({ membros, onChange }: { membros: Profile[]; onChange?: () => void }) {
  const auth = useAuth();
  const sb = supabaseBrowser();
  const [devolver, setDevolver] = useState<Devolver | null>(null);
  const [msg, setMsg] = useState("");
  const [ocupado, setOcupado] = useState<string | null>(null);

  const { data, loading, reload } = useData(async () => {
    const [esps, cads, desb, todas] = await Promise.all([
      sb.from("desbravador_especialidades").select("*").eq("validacao", "pendente").eq("status", "concluida").order("updated_at"),
      sb.from("caderno_progresso").select("*").eq("validacao", "pendente").eq("status", "feito").order("marcado_em"),
      getDesbravadores({ ativos: false }),
      getEspecialidades(),
    ]);
    const pendEsp = (must(esps) || []) as DesbEsp[];
    const pendCad = (must(cads) || []) as Progresso[];
    const itensIds = [...new Set(pendCad.map((p) => p.item_id))];
    const itens = itensIds.length ? ((must(await sb.from("caderno_itens").select("*").in("id", itensIds)) || []) as CadernoItem[]) : [];
    const anexos = await getAnexos({ desbIds: [...new Set(pendEsp.map((p) => p.desbravador_id))] });
    return { pendEsp, pendCad, desb, todas, itens, anexos };
  }, []);

  const nomes = useMemo(() => new Map(membros.map((m) => [m.id, m.nome])), [membros]);
  const desbMap = useMemo(() => new Map((data?.desb || []).map((d) => [d.id, d])), [data?.desb]);
  const espMap = useMemo(() => new Map((data?.todas || []).map((e) => [e.codigo, e])), [data?.todas]);
  const itemMap = useMemo(() => new Map((data?.itens || []).map((i) => [i.id, i])), [data?.itens]);
  const cadPorDesb = useMemo(() => {
    const m = new Map<string, Progresso[]>();
    (data?.pendCad || []).forEach((p) => m.set(p.desbravador_id, [...(m.get(p.desbravador_id) || []), p]));
    return [...m.entries()].sort((a, b) => (desbMap.get(a[0])?.nome || "").localeCompare(desbMap.get(b[0])?.nome || ""));
  }, [data?.pendCad, desbMap]);

  if (loading)
    return (
      <div className="space-y-2">
        {Array.from({ length: 3 }).map((_, i) => (
          <Skeleton key={i} className="h-28" />
        ))}
      </div>
    );
  if (!data) return null;
  const total = data.pendEsp.length + data.pendCad.length;
  if (!total)
    return (
      <EmptyState
        icon={<CheckCheck className="size-6" />}
        title="Nada para validar"
        description="Quando um instrutor ou conselheiro lançar uma especialidade ou marcar o caderno, aparece aqui para você conferir."
      />
    );

  const agora = () => new Date().toISOString();
  const aprovados = { validacao: "aprovada", validado_por: auth.userId, validado_em: agora() };

  async function avisar(destino: (string | null | undefined)[], titulo: string, mensagem: string, link: string, tipo = "validacao") {
    try {
      await notificar(auth.userId!, destino.filter(Boolean) as string[], { tipo, titulo, mensagem, link });
    } catch {
      /* aviso é opcional */
    }
  }

  async function aprovarEsp(regs: DesbEsp[]) {
    setOcupado(regs.length > 1 ? "todas-esp" : `${regs[0].desbravador_id}:${regs[0].especialidade_codigo}`);
    try {
      for (const r of regs) {
        const { error } = await sb
          .from("desbravador_especialidades")
          .update({ ...aprovados, validado_em: agora() })
          .eq("desbravador_id", r.desbravador_id)
          .eq("especialidade_codigo", r.especialidade_codigo);
        if (error) throw error;
        const e = espMap.get(r.especialidade_codigo);
        await avisar(
          [r.registrado_por],
          `Especialidade validada: ${e?.nome || r.especialidade_codigo}`,
          `${desbMap.get(r.desbravador_id)?.nome || ""} teve a especialidade validada.`,
          `/desbravadores/${r.desbravador_id}`,
        );
      }
      toast.success(regs.length > 1 ? `${regs.length} especialidades validadas.` : "Especialidade validada.");
      reload(true);
      onChange?.();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setOcupado(null);
    }
  }

  async function aprovarCad(regs: Progresso[], chave: string) {
    setOcupado(chave);
    try {
      const porDesb = new Map<string, number[]>();
      regs.forEach((r) => porDesb.set(r.desbravador_id, [...(porDesb.get(r.desbravador_id) || []), r.item_id]));
      for (const [did, itens] of porDesb) {
        const { error } = await sb
          .from("caderno_progresso")
          .update({ ...aprovados, validado_em: agora() })
          .eq("desbravador_id", did)
          .in("item_id", itens)
          .eq("validacao", "pendente");
        if (error) throw error;
      }
      toast.success(`${plural(regs.length, "item validado", "itens validados")} no caderno.`);
      reload(true);
      onChange?.();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setOcupado(null);
    }
  }

  async function confirmarDevolver() {
    if (!devolver || !msg.trim()) return;
    setOcupado("devolver");
    const d = desbMap.get(devolver.reg.desbravador_id);
    const equipe = d?.class_id ? await staffIdsDaClasse(d.class_id).catch(() => []) : [];
    const volta = { status: "refazer", observacao: msg.trim(), validacao: "pendente", validado_por: null, validado_em: null };
    try {
      if (devolver.tipo === "esp") {
        const r = devolver.reg;
        const { error } = await sb.from("desbravador_especialidades").update(volta).eq("desbravador_id", r.desbravador_id).eq("especialidade_codigo", r.especialidade_codigo);
        if (error) throw error;
        await avisar(
          [r.registrado_por, ...equipe],
          `Refazer especialidade: ${espMap.get(r.especialidade_codigo)?.nome || ""}`,
          `${d?.nome || ""}: ${msg.trim()}`,
          `/desbravadores/${r.desbravador_id}`,
          "refazer",
        );
      } else {
        const r = devolver.reg;
        const { error } = await sb.from("caderno_progresso").update(volta).eq("desbravador_id", r.desbravador_id).eq("item_id", r.item_id);
        if (error) throw error;
        const it = itemMap.get(r.item_id);
        await avisar(
          [r.marcado_por, ...equipe],
          `Refazer item ${it?.codigo || ""} do caderno`,
          `${d?.nome || ""}: ${msg.trim()}`,
          d?.classe_slug ? `/classes/${d.classe_slug}` : "/classes",
          "refazer",
        );
      }
      toast.success("Devolvido para refazer.");
      setDevolver(null);
      setMsg("");
      reload(true);
      onChange?.();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setOcupado(null);
    }
  }

  const NomeDesb = ({ d }: { d?: Desbravador }) => (
    <Link href={d ? `/desbravadores/${d.id}` : "#"} className="font-semibold hover:text-tiger-700">
      {d?.nome || "Desbravador"}
    </Link>
  );

  return (
    <div className="space-y-8">
      <p className="text-sm text-ink-500">{plural(total, "lançamento aguardando", "lançamentos aguardando")} a sua validação. O que você mesmo lança já sai aprovado.</p>

      {data.pendEsp.length > 0 && (
        <section>
          <div className="mb-3 flex flex-wrap items-end justify-between gap-2">
            <h2 className="font-display text-xl font-semibold uppercase tracking-wide">Especialidades ({data.pendEsp.length})</h2>
            {data.pendEsp.length > 1 && (
              <Button size="sm" variant="secondary" icon={<CheckCheck className="size-4" />} loading={ocupado === "todas-esp"} onClick={() => aprovarEsp(data.pendEsp)}>
                Validar todas
              </Button>
            )}
          </div>
          <div className="grid grid-cols-1 gap-3 lg:grid-cols-2">
            {data.pendEsp.map((r) => {
              const d = desbMap.get(r.desbravador_id);
              const e = espMap.get(r.especialidade_codigo);
              const anexos = data.anexos.filter((a) => a.desbravador_id === r.desbravador_id && a.especialidade_codigo === r.especialidade_codigo);
              const chave = `${r.desbravador_id}:${r.especialidade_codigo}`;
              return (
                <Card key={chave} className="p-4">
                  <div className="flex items-start gap-3">
                    {e && <EspIcon esp={e} size={48} />}
                    <div className="min-w-0 flex-1">
                      <div className="font-semibold leading-snug">{e?.nome || r.especialidade_codigo}</div>
                      <div className="text-sm text-ink-600">
                        <NomeDesb d={d} />
                        {d?.classe_nome ? ` · ${d.classe_nome}` : ""}
                        {d?.unidade ? ` · ${d.unidade}` : ""}
                      </div>
                      <div className="mt-0.5 text-xs text-ink-400">
                        Lançada por {nomes.get(r.registrado_por || "") || "—"} {timeAgo(r.updated_at || r.created_at || r.concluida_em)}
                      </div>
                    </div>
                  </div>
                  <div className="mt-3">
                    {anexos.length ? <AnexosLista anexos={anexos} nomes={nomes} compacto /> : <p className="rounded-xl bg-amber-50 px-3 py-2 text-sm text-amber-800">Sem comprovante anexado.</p>}
                  </div>
                  <div className="mt-3 flex justify-end gap-2">
                    <Button size="sm" variant="secondary" icon={<RotateCcw className="size-4" />} onClick={() => setDevolver({ tipo: "esp", reg: r })}>
                      Refazer
                    </Button>
                    <Button size="sm" icon={<Check className="size-4" />} loading={ocupado === chave} onClick={() => aprovarEsp([r])}>
                      Validar
                    </Button>
                  </div>
                </Card>
              );
            })}
          </div>
        </section>
      )}

      {cadPorDesb.length > 0 && (
        <section>
          <div className="mb-3 flex flex-wrap items-end justify-between gap-2">
            <h2 className="font-display text-xl font-semibold uppercase tracking-wide">Caderno ({data.pendCad.length})</h2>
            {cadPorDesb.length > 1 && (
              <Button size="sm" variant="secondary" icon={<CheckCheck className="size-4" />} loading={ocupado === "todas-cad"} onClick={() => aprovarCad(data.pendCad, "todas-cad")}>
                Validar todo o caderno
              </Button>
            )}
          </div>
          <div className="grid grid-cols-1 gap-3 lg:grid-cols-2">
            {cadPorDesb.map(([did, regs]) => {
              const d = desbMap.get(did);
              return (
                <Card key={did} className="p-4">
                  <div className="mb-2 flex items-center gap-3">
                    <Avatar nome={d?.nome} color={d?.classe_cor} size={36} />
                    <div className="min-w-0 flex-1">
                      <NomeDesb d={d} />
                      <div className="text-xs text-ink-500">
                        <BookOpen className="mr-1 inline size-3" />
                        {d?.classe_nome ? `Caderno de ${d.classe_nome}` : "Caderno"} · {plural(regs.length, "item", "itens")}
                      </div>
                    </div>
                  </div>
                  <ul className="divide-y divide-ink-100 rounded-xl border border-ink-100">
                    {regs.map((r) => {
                      const it = itemMap.get(r.item_id);
                      return (
                        <li key={r.item_id} className="flex items-start gap-2 px-3 py-2 text-sm">
                          <Clock className="mt-0.5 size-3.5 shrink-0 text-amber-600" />
                          <div className="min-w-0 flex-1">
                            <span className="mr-1 font-mono text-xs font-semibold text-ink-400">{it?.codigo}</span>
                            <span className="text-ink-800">{it?.texto}</span>
                            <div className="text-xs text-ink-400">
                              {nomes.get(r.marcado_por || "") || "—"} · {timeAgo(r.marcado_em)}
                            </div>
                          </div>
                          <button
                            onClick={() => setDevolver({ tipo: "cad", reg: r })}
                            className="rounded-lg p-1.5 text-ink-400 hover:bg-red-50 hover:text-red-600"
                            aria-label={`Devolver ${it?.codigo || "item"} para refazer`}
                            title="Refazer"
                          >
                            <RotateCcw className="size-4" />
                          </button>
                        </li>
                      );
                    })}
                  </ul>
                  <div className="mt-3 flex justify-end">
                    <Button size="sm" icon={<Check className="size-4" />} loading={ocupado === did} onClick={() => aprovarCad(regs, did)}>
                      Validar {regs.length === 1 ? "item" : `${regs.length} itens`}
                    </Button>
                  </div>
                </Card>
              );
            })}
          </div>
        </section>
      )}

      <Sheet
        open={!!devolver}
        onClose={() => setDevolver(null)}
        title="Devolver para refazer"
        description={devolver ? desbMap.get(devolver.reg.desbravador_id)?.nome : undefined}
        footer={
          <>
            <Button variant="secondary" onClick={() => setDevolver(null)}>
              Cancelar
            </Button>
            <Button variant="danger" disabled={!msg.trim()} loading={ocupado === "devolver"} onClick={confirmarDevolver}>
              Devolver
            </Button>
          </>
        }
      >
        {devolver && (
          <div className="space-y-4">
            <div className="rounded-2xl bg-ink-50 p-3 text-sm">
              {devolver.tipo === "esp" ? (
                <Badge>{espMap.get(devolver.reg.especialidade_codigo)?.nome}</Badge>
              ) : (
                <>
                  <span className="mr-1 font-mono text-xs font-semibold text-ink-400">{itemMap.get(devolver.reg.item_id)?.codigo}</span>
                  {itemMap.get(devolver.reg.item_id)?.texto}
                </>
              )}
            </div>
            <Textarea
              label="O que precisa refazer? (obrigatório)"
              value={msg}
              onChange={(e) => setMsg(e.target.value)}
              placeholder="Ex.: Faltou a foto do trabalho pronto."
              hint="Vai para quem lançou e para a equipe da classe."
            />
          </div>
        )}
      </Sheet>
    </div>
  );
}
