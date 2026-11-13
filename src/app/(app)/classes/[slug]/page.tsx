"use client";

import Link from "next/link";
import { useParams, useRouter, useSearchParams } from "next/navigation";
import { useMemo, useState } from "react";
import { ArrowLeft, Award, BookOpen, ChevronDown, Plus, Search, Trash2, UserPlus, Users } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Avatar, Badge, Button, Card, Checkbox, Confirm, EmptyState, Input, ProgressBar, SearchInput, Sheet, Skeleton, Spinner, Tabs, Textarea, cn } from "@/components/ui";
import { DesbravadorSheet, EspIcon, NivelBadge } from "@/components/domain";
import { StatusSheet, type Marca } from "@/components/status-sheet";
import { salvarEspecialidade, validacaoCaderno } from "@/lib/lancamentos";
import { ReportPanel } from "@/components/report-panel";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData } from "@/lib/use-data";
import { classePct, getCaderno, getCategorias, getClassEsp, getDesbEsp, getDesbravadores, getEspecialidades, getProgresso, getStaff, notificar, staffIdsDaClasse } from "@/lib/api";
import { getEscolhas, regraEscolha, type Escolha } from "@/lib/escolhas";
import { EscolhasTurmaSheet } from "@/components/escolha-especialidade";
import { classReportExcel, classReportPDF, type ClassReportData } from "@/lib/reports";
import { Opcoes } from "@/components/relatorios-clube";
import { normalize } from "@/lib/format";
import type { CadernoItem, Categoria, Classe, DesbEsp, Desbravador, Especialidade, Progresso } from "@/lib/types";

type Aba = "caderno" | "especialidades" | "desbravadores" | "relatorio";

export default function ClassePage() {
  const { slug } = useParams<{ slug: string }>();
  const search = useSearchParams();
  const router = useRouter();
  const auth = useAuth();
  const classe = auth.classes.find((c) => c.slug === slug);
  const pode = auth.canManageClass(classe?.id);
  // secretaria, tesouraria e capelania consultam tudo (sem alterar)
  const ve = pode || auth.veTudo;
  const [aba, setAba] = useState<Aba>((search.get("aba") as Aba) || "caderno");
  const sb = supabaseBrowser();

  const { data, loading, reload } = useData(async () => {
    if (!classe) return null;
    const [itens, classEsp, todas, staff, categorias] = await Promise.all([
      getCaderno(classe.id),
      getClassEsp(classe.id),
      getEspecialidades(),
      auth.isActive ? getStaff(classe.id) : Promise.resolve([]),
      getCategorias().catch(() => [] as Categoria[]),
    ]);
    let desb: Desbravador[] = [];
    let prog: Awaited<ReturnType<typeof getProgresso>> = [];
    let desbEsp: Awaited<ReturnType<typeof getDesbEsp>> = [];
    let escolhas: Escolha[] = [];
    if (ve) {
      desb = await getDesbravadores({ classId: classe.id });
      const ids = desb.map((d) => d.id);
      [prog, desbEsp, escolhas] = await Promise.all([getProgresso(ids), getDesbEsp(ids), getEscolhas(ids)]);
    }
    return { itens, classEsp, todas, staff, desb, prog, desbEsp, escolhas, categorias };
  }, [classe?.id, ve]);

  const espMap = useMemo(() => new Map((data?.todas || []).map((e) => [e.codigo, e])), [data?.todas]);

  if (!classe) {
    return auth.classes.length ? <EmptyState title="Classe não encontrada" action={<Button onClick={() => router.push("/classes")}>Ver classes</Button>} /> : <Spinner />;
  }

  const abas: { value: Aba; label: string; count?: number }[] = [
    { value: "caderno", label: "Caderno", count: data?.itens.length },
    { value: "especialidades", label: "Especialidades", count: data?.classEsp.length },
    ...(ve
      ? [
          { value: "desbravadores" as Aba, label: "Desbravadores", count: data?.desb.length },
          { value: "relatorio" as Aba, label: "Relatório" },
        ]
      : []),
  ];

  return (
    <div>
      <Link href="/classes" className="mb-4 inline-flex items-center gap-1.5 text-sm font-medium text-ink-500 hover:text-ink-800">
        <ArrowLeft className="size-4" /> Classes
      </Link>

      {/* Cabeçalho da classe */}
      <section className="relative mb-6 overflow-hidden rounded-3xl p-6 text-white sm:p-8" style={{ background: classe.cor }}>
        <div className="absolute inset-0 bg-gradient-to-br from-black/0 via-black/5 to-black/35" />
        <span className="pointer-events-none absolute -bottom-8 -right-2 font-display text-[150px] font-bold uppercase leading-none text-white/10 sm:text-[200px]">{classe.nome.slice(0, 3)}</span>
        <div className="relative">
          <div className="text-xs font-semibold uppercase tracking-[.18em] text-white/80">Classe · a partir de {classe.idade_minima} anos</div>
          <h1 className="mt-1 font-display text-4xl font-semibold uppercase tracking-wide sm:text-5xl">{classe.nome}</h1>
          <p className="mt-1 text-white/85">Avançada: {classe.classe_avancada}</p>
          {data && data.staff.length > 0 && (
            <div className="mt-4 flex flex-wrap items-center gap-2">
              {data.staff.map((s) => (
                <span key={s.profile_id} className="inline-flex items-center gap-2 rounded-full bg-black/20 py-1 pl-1 pr-3 text-sm">
                  <Avatar nome={s.profiles?.nome} size={24} color="rgba(255,255,255,.25)" />
                  {s.profiles?.nome.split(" ")[0]} <span className="text-white/70">· {s.funcao}</span>
                </span>
              ))}
            </div>
          )}
          {ve && data && data.desb.length > 0 && (
            <div className="mt-5 max-w-md">
              <div className="mb-1 flex justify-between text-sm text-white/85">
                <span>Progresso médio do caderno</span>
                <span className="font-semibold">{Math.round(data.desb.reduce((s, d) => s + classePct(data.itens, data.prog, d.id), 0) / data.desb.length)}%</span>
              </div>
              <div className="h-2 overflow-hidden rounded-full bg-black/25">
                <div className="h-full rounded-full bg-white" style={{ width: `${data.desb.reduce((s, d) => s + classePct(data.itens, data.prog, d.id), 0) / data.desb.length}%` }} />
              </div>
            </div>
          )}
        </div>
      </section>

      {!pode && auth.isActive && (
        <p className="mb-4 rounded-2xl bg-ink-100 px-4 py-3 text-sm text-ink-600">Você está consultando esta classe. Só os instrutores da classe e o diretor marcam o caderno.</p>
      )}

      <div className="mb-5">
        <Tabs value={aba} onChange={setAba} items={abas} />
      </div>

      {loading || !data ? (
        <div className="space-y-3">
          <Skeleton className="h-24" />
          <Skeleton className="h-24" />
          <Skeleton className="h-24" />
        </div>
      ) : aba === "caderno" ? (
        <CadernoTab
          classeId={classe.id}
          itens={data.itens}
          desb={data.desb}
          prog={data.prog}
          pode={pode}
          ve={ve}
          espMap={espMap}
          todas={data.todas}
          categorias={data.categorias}
          escolhas={data.escolhas}
          desbEsp={data.desbEsp}
          onChange={() => reload(true)}
        />
      ) : aba === "especialidades" ? (
        <EspecialidadesTab classeId={classe.id} classEsp={data.classEsp} todas={data.todas} desb={data.desb} desbEsp={data.desbEsp} pode={pode} podeAtribuir={pode || auth.isCapelao} onChange={() => reload(true)} />
      ) : aba === "desbravadores" ? (
        <DesbravadoresTab
          pode={pode}
          classeId={classe.id}
          cor={classe.cor}
          desb={data.desb}
          itens={data.itens}
          prog={data.prog}
          desbEsp={data.desbEsp}
          classEsp={data.classEsp}
          onChange={() => reload(true)}
        />
      ) : (
        <div className="space-y-4">
          <RelatorioClasse classe={classe} data={data} espMap={espMap} />
          <MatrizPreview itens={data.itens} desb={data.desb} prog={data.prog} />
        </div>
      )}
    </div>
  );
}

/** Relatório da classe: todos os desbravadores ou só os escolhidos, com a ficha de cada um. */
function RelatorioClasse({
  classe,
  data,
  espMap,
}: {
  classe: Classe;
  data: { itens: CadernoItem[]; desb: Desbravador[]; prog: Progresso[]; classEsp: { especialidade_codigo: string }[]; desbEsp: DesbEsp[]; escolhas: Escolha[]; categorias: Categoria[] };
  espMap: Map<string, Especialidade>;
}) {
  const [quem, setQuem] = useState<"todos" | "escolher">("todos");
  const [sel, setSel] = useState<string[]>([]);
  const [fichas, setFichas] = useState(true);
  const ordenados = useMemo(() => [...data.desb].sort((a, b) => a.nome.localeCompare(b.nome, "pt-BR")), [data.desb]);
  const escolhidos = quem === "todos" ? ordenados : ordenados.filter((d) => sel.includes(d.id));
  const area = useMemo(() => new Map(data.categorias.map((c) => [c.slug, c.nome])), [data.categorias]);

  const dados = (): ClassReportData => {
    if (!escolhidos.length) throw new Error("Escolha pelo menos um desbravador.");
    return {
      classe,
      itens: data.itens,
      desbravadores: escolhidos,
      progresso: data.prog,
      especialidades: reportEsps(data.classEsp, data.desbEsp, espMap),
      classEsp: new Set(data.classEsp.map((c) => c.especialidade_codigo)),
      desbEsp: data.desbEsp,
      fichas,
      escolhas: data.escolhas,
      nomeEsp: (c) => espMap.get(c)?.nome || c,
      areaEsp: (c) => area.get(espMap.get(c)?.categoria_slug || "") || "",
    };
  };
  const base = escolhidos.length === 1 && quem === "escolher" ? `classe-${classe.nome}-${escolhidos[0].nome}` : `classe-${classe.nome}`;

  return (
    <ReportPanel
      titulo={`Relatório da classe de ${classe.nome}`}
      base={base}
      link={`/classes/${classe.slug}?aba=relatorio`}
      descricao="Caderno e especialidades de cada desbravador, com a ficha individual item a item. Pronto para imprimir ou enviar."
      extra={
        <div className="space-y-3">
          <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
            <span className="text-sm font-medium text-ink-700">Quem entra no relatório:</span>
            <Opcoes
              label="Quem entra no relatório"
              value={quem}
              onChange={setQuem}
              items={[
                { value: "todos", label: `Todos (${data.desb.length})` },
                { value: "escolher", label: "Escolher desbravadores" },
              ]}
            />
          </div>
          {quem === "escolher" && (
            <div className="rounded-2xl border border-ink-200 p-3">
              <div className="mb-2 flex items-center justify-between gap-2 text-sm">
                <span className="text-ink-600">
                  <strong className="text-ink-900">{sel.length}</strong> de {data.desb.length} escolhido(s)
                </span>
                <button className="font-semibold text-tiger-700 hover:underline" onClick={() => setSel(sel.length === data.desb.length ? [] : data.desb.map((d) => d.id))}>
                  {sel.length === data.desb.length ? "Limpar" : "Marcar todos"}
                </button>
              </div>
              {ordenados.length ? (
                <div className="grid gap-2 sm:grid-cols-2">
                  {ordenados.map((d) => (
                    <Checkbox key={d.id} checked={sel.includes(d.id)} onChange={(v) => setSel((s) => (v ? [...s, d.id] : s.filter((x) => x !== d.id)))} label={d.nome} />
                  ))}
                </div>
              ) : (
                <p className="text-sm text-ink-500">Nenhum desbravador nesta classe.</p>
              )}
            </div>
          )}
          <Checkbox checked={fichas} onChange={setFichas} label="Incluir a ficha de cada um (todos os itens do caderno e especialidades, com situação e data)" />
        </div>
      }
      excel={async () => classReportExcel(dados())}
      pdf={async () => classReportPDF(dados())}
    />
  );
}

function reportEsps(classEsp: { especialidade_codigo: string }[], desbEsp: { especialidade_codigo: string }[], espMap: Map<string, Especialidade>) {
  const cods = [...new Set([...classEsp.map((c) => c.especialidade_codigo), ...desbEsp.map((d) => d.especialidade_codigo)])];
  return cods
    .map((c) => espMap.get(c))
    .filter(Boolean)
    .sort((a, b) => a!.nome.localeCompare(b!.nome)) as Especialidade[];
}

// ------------------------------------------------------------------ Caderno
function CadernoTab({
  classeId,
  itens,
  desb,
  prog,
  pode,
  ve,
  espMap,
  todas,
  categorias,
  escolhas,
  desbEsp,
  onChange,
}: {
  classeId: number;
  itens: CadernoItem[];
  desb: Desbravador[];
  prog: { desbravador_id: string; item_id: number; status: Marca; validacao?: string }[];
  pode: boolean;
  ve: boolean;
  espMap: Map<string, Especialidade>;
  todas: Especialidade[];
  categorias: Categoria[];
  escolhas: Escolha[];
  desbEsp: DesbEsp[];
  onChange: () => void;
}) {
  const { isAdmin, userId, canRegistrarEsp } = useAuth();
  const [item, setItem] = useState<CadernoItem | null>(null);
  const [itemEscolha, setItemEscolha] = useState<CadernoItem | null>(null);
  const regras = useMemo(() => new Map(itens.map((i) => [i.id, regraEscolha(i, todas, categorias)])), [itens, todas, categorias]);
  const [aberto, setAberto] = useState<Record<string, boolean>>({});
  const [novo, setNovo] = useState(false);
  const [q, setQ] = useState("");
  const sb = supabaseBrowser();

  const secoes = useMemo(() => {
    const m = new Map<string, CadernoItem[]>();
    itens.filter((i) => !q || normalize(i.texto + " " + i.detalhes.map((d) => d.t).join(" ")).includes(normalize(q))).forEach((i) => m.set(i.secao, [...(m.get(i.secao) || []), i]));
    return [...m.entries()];
  }, [itens, q]);

  const initial = useMemo(() => {
    const m = new Map<string, Marca>();
    if (item) prog.filter((p) => p.item_id === item.id).forEach((p) => m.set(p.desbravador_id, p.status));
    return m;
  }, [item, prog]);

  const pendentesItem = useMemo(() => new Set(item ? prog.filter((p) => p.item_id === item.id && p.validacao === "pendente").map((p) => p.desbravador_id) : []), [item, prog]);

  async function salvar(estado: Map<string, Marca | null>, mensagem: string) {
    if (!item) return;
    const feitos: object[] = [];
    const refazer: object[] = [];
    const dels: string[] = [];
    const devolvidos: string[] = [];
    estado.forEach((v, id) => {
      const antes = initial.get(id) || null;
      if (v === antes && !(v === "refazer" && mensagem)) return;
      if (!v) dels.push(id);
      else {
        const row = {
          desbravador_id: id,
          item_id: item.id,
          status: v,
          observacao: v === "refazer" ? mensagem || null : null,
          marcado_por: userId,
          marcado_em: new Date().toISOString(),
          ...validacaoCaderno(isAdmin, v, userId),
        };
        (v === "feito" ? feitos : refazer).push(row);
        if (v === "refazer" && antes !== "refazer") devolvidos.push(id);
      }
    });
    for (const ups of [feitos, refazer]) {
      if (!ups.length) continue;
      const { error } = await sb.from("caderno_progresso").upsert(ups);
      if (error) {
        toast.error(error.message);
        throw error;
      }
    }
    if (dels.length) {
      const { error, count } = await sb.from("caderno_progresso").delete({ count: "exact" }).eq("item_id", item.id).in("desbravador_id", dels);
      if (error) {
        toast.error(error.message);
        throw error;
      }
      if (!isAdmin && count !== null && count < dels.length) toast.info("Itens já aprovados pelo diretor só podem ser desmarcados por ele.");
    }
    if (devolvidos.length || (isAdmin && mensagem)) {
      const nomes = desb.filter((d) => devolvidos.includes(d.id)).map((d) => d.nome.split(" ")[0]);
      try {
        await notificar(userId!, await staffIdsDaClasse(classeId), {
          tipo: "refazer",
          titulo: devolvidos.length ? `Refazer item ${item.codigo} do caderno` : `Mensagem sobre o item ${item.codigo}`,
          mensagem: `${nomes.length ? nomes.join(", ") + ": " : ""}${mensagem}`,
          link: `/classes/${desb[0]?.classe_slug || ""}`,
        });
      } catch {
        /* notificação é opcional */
      }
    }
    toast.success(!isAdmin && feitos.length ? "Caderno atualizado. O diretor vai validar os itens marcados." : "Caderno atualizado.");
    onChange();
  }

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-3 sm:flex-row">
        <SearchInput value={q} onChange={setQ} placeholder="Buscar no caderno…" className="flex-1" />
        {isAdmin && (
          <Button variant="secondary" icon={<Plus className="size-4" />} onClick={() => setNovo(true)}>
            Novo item
          </Button>
        )}
      </div>
      {secoes.length === 0 && <EmptyState icon={<Search className="size-6" />} title="Nada encontrado" description="Tente outra palavra." />}
      {secoes.map(([secao, its]) => {
        const avancada = its[0]?.avancada;
        return (
          <section key={secao}>
            <div className="mb-2.5 flex items-center gap-2">
              <h2 className="font-display text-lg font-semibold uppercase tracking-wide text-ink-800">{secao}</h2>
              {avancada && <Badge tone="amber">Avançada</Badge>}
            </div>
            <div className="space-y-2.5">
              {its.map((it) => {
                const feitos = prog.filter((p) => p.item_id === it.id && p.status === "feito").length;
                const refazer = prog.filter((p) => p.item_id === it.id && p.status === "refazer").length;
                const open = aberto[it.id] ?? true;
                return (
                  <Card key={it.id} className="p-4">
                    <div className="flex gap-3">
                      <span className="mt-0.5 h-fit shrink-0 rounded-lg bg-ink-100 px-2 py-0.5 font-mono text-xs font-semibold text-ink-600">{it.codigo}</span>
                      <div className="min-w-0 flex-1">
                        <p className="text-[15px] leading-relaxed text-ink-900">{it.texto}</p>
                        {it.especialidades.length > 0 && (
                          <div className="mt-2 flex flex-wrap gap-1.5">
                            {it.especialidades.map((c) => {
                              const e = espMap.get(c);
                              return (
                                <Link
                                  key={c}
                                  href={`/especialidades/e/${c}`}
                                  className="inline-flex items-center gap-1.5 rounded-full border border-ink-200 bg-white py-0.5 pl-0.5 pr-2.5 text-xs font-medium text-ink-700 hover:border-tiger-300 hover:bg-tiger-50"
                                >
                                  {e && <EspIcon esp={e} size={20} />}
                                  {e?.nome || c}
                                </Link>
                              );
                            })}
                          </div>
                        )}
                        {it.detalhes.length > 0 && (
                          <>
                            <button
                              onClick={() => setAberto((a) => ({ ...a, [it.id]: !open }))}
                              className="mt-2 inline-flex items-center gap-1 text-sm font-semibold text-tiger-700"
                              aria-expanded={!!open}
                            >
                              <ChevronDown className={cn("size-4 transition-transform", open && "rotate-180")} />
                              {open ? "Ocultar detalhes" : `Ver detalhes (${it.detalhes.length})`}
                            </button>
                            {open && (
                              <ul className="mt-2 space-y-1 border-l-2 border-tiger-200 pl-3 text-sm text-ink-600">
                                {it.detalhes.map((d, k) => (
                                  <li key={k}>
                                    {d.t}
                                    {d.sub && d.sub.length > 0 && (
                                      <ul className="ml-4 list-disc">
                                        {d.sub.map((s, j) => (
                                          <li key={j}>{s.t}</li>
                                        ))}
                                      </ul>
                                    )}
                                  </li>
                                ))}
                              </ul>
                            )}
                          </>
                        )}
                      </div>
                    </div>
                    {ve && regras.get(it.id) && desb.length > 0 && (
                      <button
                        onClick={() => setItemEscolha(it)}
                        className="mt-3 flex w-full items-center gap-2.5 rounded-xl border border-dashed border-tiger-300 bg-tiger-50/50 px-3 py-2 text-left text-sm hover:bg-tiger-50"
                      >
                        <Award className="size-4 shrink-0 text-tiger-600" />
                        <span className="min-w-0 flex-1">
                          <span className="font-semibold text-ink-900">Especialidade de cada um</span>
                          <span className="block text-xs text-ink-500">
                            {new Set(escolhas.filter((e) => e.item_id === it.id).map((e) => e.desbravador_id)).size} de {desb.length} já escolheram
                          </span>
                        </span>
                        <span className="shrink-0 text-xs font-semibold text-tiger-700">{pode ? "Escolher" : "Ver"}</span>
                      </button>
                    )}
                    {pode && (
                      <div className="mt-3 flex items-center gap-3 border-t border-ink-100 pt-3">
                        <div className="min-w-0 flex-1">
                          <ProgressBar value={desb.length ? (feitos / desb.length) * 100 : 0} />
                          <div className="mt-1 flex gap-2 text-xs text-ink-500">
                            <span>
                              {feitos}/{desb.length} fizeram
                            </span>
                            {refazer > 0 && <span className="font-semibold text-red-600">· {refazer} para refazer</span>}
                          </div>
                        </div>
                        <Button size="sm" variant={feitos ? "secondary" : "primary"} onClick={() => setItem(it)} disabled={!desb.length}>
                          Marcar
                        </Button>
                      </div>
                    )}
                  </Card>
                );
              })}
            </div>
          </section>
        );
      })}

      <StatusSheet
        open={!!item}
        onClose={() => setItem(null)}
        title={`Item ${item?.codigo || ""}`}
        description="Marque quem já fez este item do caderno."
        header={item && <p className="mb-4 rounded-2xl bg-ink-50 p-3 text-sm text-ink-700">{item.texto}</p>}
        desbravadores={desb}
        initial={initial}
        isAdmin={isAdmin}
        onSave={salvar}
        pendentes={pendentesItem}
      />
      <NovoItemSheet open={novo} onClose={() => setNovo(false)} classeId={classeId} onSaved={onChange} />
      <EscolhasTurmaSheet
        open={!!itemEscolha}
        onClose={() => setItemEscolha(null)}
        item={itemEscolha}
        regra={itemEscolha ? regras.get(itemEscolha.id) || null : null}
        desb={desb}
        escolhas={escolhas}
        espMap={espMap}
        categorias={categorias}
        desbEsp={desbEsp}
        userId={userId}
        podeEscolher={(d) => canRegistrarEsp(d)}
        onSaved={onChange}
      />
    </div>
  );
}

function NovoItemSheet({ open, onClose, classeId, onSaved }: { open: boolean; onClose: () => void; classeId: number; onSaved: () => void }) {
  const [texto, setTexto] = useState("");
  const [secao, setSecao] = useState("Atividades do clube");
  const [saving, setSaving] = useState(false);
  async function salvar() {
    if (texto.trim().length < 5) return toast.error("Descreva a atividade.");
    setSaving(true);
    const sb = supabaseBrowser();
    const { count } = await sb.from("caderno_itens").select("id", { count: "exact", head: true }).eq("class_id", classeId).eq("personalizado", true);
    const { error } = await sb.from("caderno_itens").insert({
      class_id: classeId,
      secao: secao.trim() || "Atividades do clube",
      secao_ordem: 50,
      ordem: (count || 0) + 1,
      codigo: `X.${(count || 0) + 1}`,
      texto: texto.trim(),
      personalizado: true,
    });
    setSaving(false);
    if (error) return toast.error(error.message);
    toast.success("Item adicionado ao caderno.");
    setTexto("");
    onSaved();
    onClose();
  }
  return (
    <Sheet
      open={open}
      onClose={onClose}
      title="Novo item do caderno"
      description="Para atividades extras do clube (fora do cartão oficial)."
      footer={
        <>
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
          <Button onClick={salvar} loading={saving}>
            Adicionar item
          </Button>
        </>
      }
    >
      <div className="space-y-4">
        <Input label="Seção" value={secao} onChange={(e) => setSecao(e.target.value)} />
        <Textarea label="Atividade" value={texto} onChange={(e) => setTexto(e.target.value)} placeholder="Ex.: Ajudar na cozinha do clube durante o acampamento." />
      </div>
    </Sheet>
  );
}

// ------------------------------------------------------------------ Especialidades da classe
function EspecialidadesTab({
  classeId,
  classEsp,
  todas,
  desb,
  desbEsp,
  pode,
  podeAtribuir,
  onChange,
}: {
  classeId: number;
  /** instrutor/diretor, ou capelão (que entrega para qualquer desbravador) */
  podeAtribuir: boolean;
  classEsp: { especialidade_codigo: string; obrigatoria: boolean }[];
  todas: Especialidade[];
  desb: Desbravador[];
  desbEsp: { desbravador_id: string; especialidade_codigo: string; status: "concluida" | "refazer"; validacao?: string }[];
  pode: boolean;
  onChange: () => void;
}) {
  const { isAdmin, userId } = useAuth();
  const sb = supabaseBrowser();
  const [add, setAdd] = useState(false);
  const [esp, setEsp] = useState<Especialidade | null>(null);
  const [remover, setRemover] = useState<Especialidade | null>(null);
  const espMap = useMemo(() => new Map(todas.map((e) => [e.codigo, e])), [todas]);
  const lista = classEsp
    .map((c) => ({ ...c, esp: espMap.get(c.especialidade_codigo) }))
    .filter((c) => c.esp)
    .sort((a, b) => Number(b.obrigatoria) - Number(a.obrigatoria) || a.esp!.nome.localeCompare(b.esp!.nome));

  const initial = useMemo(() => {
    const m = new Map<string, Marca>();
    if (esp) desbEsp.filter((d) => d.especialidade_codigo === esp.codigo).forEach((d) => m.set(d.desbravador_id, d.status === "concluida" ? "feito" : "refazer"));
    return m;
  }, [esp, desbEsp]);

  const pendentesEsp = useMemo(() => new Set(esp ? desbEsp.filter((d) => d.especialidade_codigo === esp.codigo && d.validacao === "pendente").map((d) => d.desbravador_id) : []), [esp, desbEsp]);

  async function salvar(estado: Map<string, Marca | null>, mensagem: string, files: File[], quando: { dia: string; hora: string }) {
    if (!esp) return;
    try {
      const r = await salvarEspecialidade({ codigo: esp.codigo, nome: esp.nome, estado, initial, mensagem, files, userId: userId!, isAdmin, desbravadores: desb, quando });
      toast.success(r.pendentes ? "Enviado para a validação do diretor." : "Especialidade registrada.");
      onChange();
    } catch (e) {
      toast.error((e as Error).message);
      throw e;
    }
  }

  async function adicionar(e: Especialidade) {
    const { error } = await sb.from("class_especialidades").insert({ class_id: classeId, especialidade_codigo: e.codigo, obrigatoria: false, adicionada_por: userId });
    if (error) return toast.error(error.code === "23505" ? "Essa especialidade já está na classe." : error.message);
    toast.success(`${e.nome} adicionada à classe.`);
    onChange();
  }

  return (
    <div className="space-y-4">
      {pode && (
        <div className="flex justify-end">
          <Button icon={<Plus className="size-4" />} onClick={() => setAdd(true)}>
            Adicionar especialidade
          </Button>
        </div>
      )}
      {!lista.length && <EmptyState icon={<Award className="size-6" />} title="Nenhuma especialidade na classe" description="Adicione as especialidades que a classe vai fazer." />}
      <div className="grid gap-3 sm:grid-cols-2">
        {lista.map(({ esp: e, obrigatoria }) => {
          const n = desbEsp.filter((d) => d.especialidade_codigo === e!.codigo && d.status === "concluida").length;
          return (
            <Card key={e!.codigo} className="flex items-center gap-3 p-3.5">
              <Link href={`/especialidades/e/${e!.codigo}`} className="shrink-0">
                <EspIcon esp={e!} size={52} />
              </Link>
              <div className="min-w-0 flex-1">
                <Link href={`/especialidades/e/${e!.codigo}`} className="line-clamp-2 font-semibold leading-snug hover:text-tiger-700">
                  {e!.nome}
                </Link>
                <div className="mt-1 flex flex-wrap items-center gap-2">
                  {obrigatoria ? <Badge tone="tiger">Do caderno</Badge> : <Badge>Adicionada</Badge>}
                  {podeAtribuir && (
                    <span className="text-xs text-ink-500">
                      {n}/{desb.length} concluíram
                    </span>
                  )}
                </div>
              </div>
              {podeAtribuir && (
                <div className="flex shrink-0 flex-col items-end gap-1">
                  <Button size="sm" variant={n ? "secondary" : "primary"} onClick={() => setEsp(e!)} disabled={!desb.length}>
                    Atribuir
                  </Button>
                  {pode && !obrigatoria && (
                    <button onClick={() => setRemover(e!)} className="rounded-lg p-1.5 text-ink-400 hover:bg-red-50 hover:text-red-600" aria-label={`Remover ${e!.nome} da classe`}>
                      <Trash2 className="size-4" />
                    </button>
                  )}
                </div>
              )}
            </Card>
          );
        })}
      </div>

      <StatusSheet
        open={!!esp}
        onClose={() => setEsp(null)}
        title={esp?.nome || ""}
        description="Marque os desbravadores que concluíram esta especialidade."
        header={
          esp && (
            <div className="mb-4 flex items-center gap-3 rounded-2xl bg-ink-50 p-3">
              <EspIcon esp={esp} size={44} />
              <NivelBadge nivel={esp.nivel} />
            </div>
          )
        }
        desbravadores={desb}
        initial={initial}
        isAdmin={isAdmin}
        onSave={salvar}
        comAnexos
        pendentes={pendentesEsp}
      />
      <AddEspSheet open={add} onClose={() => setAdd(false)} todas={todas} jaTem={new Set(classEsp.map((c) => c.especialidade_codigo))} onAdd={adicionar} />
      <Confirm
        open={!!remover}
        title="Remover da classe?"
        message={
          <>
            A especialidade <strong>{remover?.nome}</strong> sai da lista da classe. Os registros dos desbravadores continuam salvos.
          </>
        }
        confirmLabel="Remover especialidade"
        danger
        onClose={() => setRemover(null)}
        onConfirm={async () => {
          const { error } = await sb.from("class_especialidades").delete().eq("class_id", classeId).eq("especialidade_codigo", remover!.codigo);
          if (error) toast.error(error.message);
          else toast.success("Removida da classe.");
          setRemover(null);
          onChange();
        }}
      />
    </div>
  );
}

function AddEspSheet({ open, onClose, todas, jaTem, onAdd }: { open: boolean; onClose: () => void; todas: Especialidade[]; jaTem: Set<string>; onAdd: (e: Especialidade) => void }) {
  const [q, setQ] = useState("");
  const res = useMemo(() => {
    const n = normalize(q);
    return (n ? todas.filter((e) => normalize(e.nome).includes(n) || e.codigo.toLowerCase().includes(n)) : todas).slice(0, 60);
  }, [q, todas]);
  return (
    <Sheet open={open} onClose={onClose} title="Adicionar especialidade" description="Busque entre todas as especialidades.">
      <div className="space-y-3">
        <SearchInput value={q} onChange={setQ} placeholder="Ex.: Mamíferos, Nós e amarras…" />
        <ul className="divide-y divide-ink-100">
          {res.map((e) => (
            <li key={e.codigo} className="flex items-center gap-3 py-2.5">
              <EspIcon esp={e} size={40} />
              <div className="min-w-0 flex-1">
                <div className="truncate text-sm font-semibold">{e.nome}</div>
                <div className="text-xs text-ink-500">{e.codigo}</div>
              </div>
              {jaTem.has(e.codigo) ? (
                <Badge tone="green">Na classe</Badge>
              ) : (
                <Button size="sm" variant="secondary" icon={<Plus className="size-3.5" />} onClick={() => onAdd(e)}>
                  Adicionar
                </Button>
              )}
            </li>
          ))}
        </ul>
        {!res.length && <p className="py-6 text-center text-sm text-ink-500">Nenhuma especialidade encontrada.</p>}
      </div>
    </Sheet>
  );
}

// ------------------------------------------------------------------ Desbravadores da classe
function DesbravadoresTab({
  pode,
  classeId,
  cor,
  desb,
  itens,
  prog,
  desbEsp,
  classEsp,
  onChange,
}: {
  pode: boolean;
  classeId: number;
  cor: string;
  desb: Desbravador[];
  itens: CadernoItem[];
  prog: Awaited<ReturnType<typeof getProgresso>>;
  desbEsp: Awaited<ReturnType<typeof getDesbEsp>>;
  classEsp: { especialidade_codigo: string }[];
  onChange: () => void;
}) {
  const [novo, setNovo] = useState(false);
  const [q, setQ] = useState("");
  const codigos = new Set(classEsp.map((c) => c.especialidade_codigo));
  const list = desb.filter((d) => normalize(d.nome).includes(normalize(q)));
  return (
    <div className="space-y-4">
      <div className="flex flex-col gap-3 sm:flex-row">
        <SearchInput value={q} onChange={setQ} placeholder="Buscar desbravador…" className="flex-1" />
        {pode && (
          <Button icon={<UserPlus className="size-4" />} onClick={() => setNovo(true)}>
            Adicionar desbravador
          </Button>
        )}
      </div>
      {!desb.length ? (
        <EmptyState
          icon={<Users className="size-6" />}
          title="Nenhum desbravador nesta classe"
          description="Cadastre os desbravadores para começar a marcar o caderno."
          action={pode && <Button onClick={() => setNovo(true)}>Adicionar desbravador</Button>}
        />
      ) : (
        <Card className="divide-y divide-ink-100">
          {list.map((d) => {
            const pct = classePct(itens, prog, d.id);
            const esps = desbEsp.filter((e) => e.desbravador_id === d.id && e.status === "concluida");
            const daClasse = esps.filter((e) => codigos.has(e.especialidade_codigo)).length;
            return (
              <Link key={d.id} href={`/desbravadores/${d.id}`} className="flex items-center gap-3 p-4 hover:bg-ink-50">
                <Avatar nome={d.nome} color={cor} />
                <div className="min-w-0 flex-1">
                  <div className="truncate font-semibold">{d.nome}</div>
                  <div className="text-xs text-ink-500">
                    {d.idade != null ? `${d.idade} anos` : "Idade não informada"}
                    {d.unidade ? ` · ${d.unidade}` : ""}
                  </div>
                </div>
                <div className="hidden w-40 sm:block">
                  <ProgressBar value={pct} color={cor} />
                  <div className="mt-1 text-xs text-ink-500">{Math.round(pct)}% do caderno</div>
                </div>
                <div className="w-16 text-right sm:w-24">
                  <div className="font-display text-lg font-semibold">{sm(pct)}</div>
                  <div className="text-[11px] text-ink-500">
                    {daClasse}/{codigos.size} esp.
                  </div>
                </div>
              </Link>
            );
          })}
        </Card>
      )}
      <DesbravadorSheet open={novo} onClose={() => setNovo(false)} classId={classeId} onSaved={onChange} />
    </div>
  );
}
const sm = (pct: number) => `${Math.round(pct)}%`;

// ------------------------------------------------------------------ Prévia da matriz
function MatrizPreview({ itens, desb, prog }: { itens: CadernoItem[]; desb: Desbravador[]; prog: { desbravador_id: string; item_id: number; status: Marca }[] }) {
  if (!desb.length) return <EmptyState icon={<BookOpen className="size-6" />} title="Sem desbravadores" description="O relatório fica completo quando a classe tiver desbravadores." />;
  const base = itens;
  return (
    <Card className="overflow-hidden">
      <div className="border-b border-ink-100 px-4 py-3 text-sm font-semibold">Prévia do caderno</div>
      <div className="overflow-x-auto">
        <table className="w-max min-w-full border-collapse text-xs">
          <thead>
            <tr className="bg-ink-50">
              <th className="sticky left-0 z-10 bg-ink-50 px-3 py-2 text-left font-semibold">Desbravador</th>
              {base.map((i) => (
                <th key={i.id} className="px-1.5 py-2 font-mono font-semibold text-ink-500" title={i.texto}>
                  {i.codigo}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {desb.map((d) => (
              <tr key={d.id} className="border-t border-ink-100">
                <td className="sticky left-0 z-10 max-w-[180px] truncate bg-white px-3 py-2 font-medium">{d.nome}</td>
                {base.map((i) => {
                  const p = prog.find((x) => x.desbravador_id === d.id && x.item_id === i.id);
                  return (
                    <td key={i.id} className="px-1.5 py-2 text-center">
                      {p?.status === "feito" ? (
                        <span className="inline-block size-4 rounded bg-emerald-500" title="Feito" />
                      ) : p?.status === "refazer" ? (
                        <span className="inline-block size-4 rounded bg-red-500" title="Refazer" />
                      ) : (
                        <span className="inline-block size-4 rounded bg-ink-100" />
                      )}
                    </td>
                  );
                })}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <div className="flex gap-4 border-t border-ink-100 px-4 py-2.5 text-xs text-ink-500">
        <span className="inline-flex items-center gap-1.5">
          <span className="size-3 rounded bg-emerald-500" /> Feito
        </span>
        <span className="inline-flex items-center gap-1.5">
          <span className="size-3 rounded bg-red-500" /> Refazer
        </span>
        <span className="inline-flex items-center gap-1.5">
          <span className="size-3 rounded bg-ink-100" /> Pendente
        </span>
      </div>
    </Card>
  );
}
