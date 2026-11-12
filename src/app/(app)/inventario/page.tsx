"use client";

import { useMemo, useState } from "react";
import { Boxes, Minus, Pencil, Plus, Trash2 } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { BaixarArquivos } from "@/components/report-panel";
import { Badge, Button, Card, Confirm, EmptyState, Input, PageHeader, SearchInput, Select, Sheet, Skeleton, Textarea, cn } from "@/components/ui";
import { supabaseBrowser } from "@/lib/supabase/client";
import { must, useData } from "@/lib/use-data";
import { getMembros, getUnidades } from "@/lib/api";
import { tabelaExcel, tabelaPDF } from "@/lib/reports";
import { normalize, plural } from "@/lib/format";
import type { EstadoItem, ItemInventario, Profile, Unidade } from "@/lib/types";

const CATEGORIAS_PADRAO = ["Cozinha", "Unidade", "Secretaria", "Acampamento", "Outros"];

const ESTADOS: Record<EstadoItem, { nome: string; tone: "green" | "amber" | "red" | "blue" }> = {
  bom: { nome: "Bom", tone: "green" },
  regular: { nome: "Regular", tone: "amber" },
  ruim: { nome: "Ruim", tone: "red" },
  manutencao: { nome: "Em conserto", tone: "blue" },
};

type Dados = { itens: ItemInventario[]; unidades: Unidade[]; membros: Profile[] };

export default function InventarioPage() {
  const auth = useAuth();
  const [cat, setCat] = useState("");
  const [q, setQ] = useState("");
  const [sel, setSel] = useState<ItemInventario | "novo" | null>(null);

  const { data, loading, error, reload } = useData<Dados>(async () => {
    const r = await supabaseBrowser().from("inventario").select("*").order("nome");
    if (r.error && /inventario|does not exist|schema cache/i.test(r.error.message)) throw new Error("O inventário ainda não foi ativado no banco. Peça ao diretor para rodar o SQL 0005.");
    const [unidades, membros] = await Promise.all([getUnidades().catch(() => []), getMembros().catch(() => [])]);
    return { itens: must(r) as ItemInventario[], unidades, membros };
  }, [auth.isActive]);

  const categorias = useMemo(() => {
    const extras = [...new Set((data?.itens || []).map((i) => i.categoria))].filter((c) => !CATEGORIAS_PADRAO.includes(c)).sort();
    return [...CATEGORIAS_PADRAO.slice(0, -1), ...extras, "Outros"];
  }, [data]);
  const conta = (c: string) => (data?.itens || []).filter((i) => i.categoria === c).length;
  const lista = useMemo(
    () => (data?.itens || []).filter((i) => (!cat || i.categoria === cat) && (!q || normalize(`${i.nome} ${i.local || ""} ${i.observacao || ""}`).includes(normalize(q)))),
    [data, cat, q]
  );
  const grupos = useMemo(() => categorias.map((c) => ({ c, itens: lista.filter((i) => i.categoria === c) })).filter((g) => g.itens.length), [categorias, lista]);

  if (!auth.isActive) return <EmptyState icon={<Boxes className="size-6" />} title="Acesso pendente" description="Quando o diretor liberar seu acesso, você verá o inventário do clube." />;

  const unidade = (id: string | null) => data?.unidades.find((u) => u.id === id);
  const linhas = () =>
    lista.map((i, n) => [n + 1, i.nome, i.categoria, i.quantidade, ESTADOS[i.estado]?.nome || i.estado, unidade(i.unidade_id)?.nome || "", i.local || "", i.observacao || ""]);
  const COLS = ["#", "Item", "Categoria", "Qtd.", "Estado", "Unidade", "Onde fica", "Observação"];
  const filtro = [cat, q && `busca "${q}"`].filter(Boolean).join(" · ");

  return (
    <div>
      <PageHeader
        eyebrow="Clube"
        title="Inventário"
        description="Todos os materiais do clube, separados por categoria. Qualquer membro da diretoria pode cadastrar e atualizar."
        actions={
          <Button icon={<Plus className="size-4" />} onClick={() => setSel("novo")}>
            Novo item
          </Button>
        }
      />

      {loading ? (
        <div className="space-y-3">
          <Skeleton className="h-11" />
          <Skeleton className="h-64" />
        </div>
      ) : error || !data ? (
        <EmptyState icon={<Boxes className="size-6" />} title="Não foi possível abrir o inventário" description={error || "Tente de novo em alguns instantes."} action={<Button onClick={() => reload()}>Tentar de novo</Button>} />
      ) : (
        <>
          <div className="mb-4 space-y-3">
            <div className="flex flex-col gap-3 sm:flex-row sm:items-center">
              <SearchInput value={q} onChange={setQ} placeholder="Buscar material…" className="sm:flex-1" />
              <div className="flex gap-2">
                <BaixarArquivos
                  size="sm"
                  base={`inventario${cat ? "-" + cat.toLowerCase() : ""}`}
                  disabled={!lista.length}
                  excel={() => tabelaExcel("Inventário", `Inventário do clube${filtro ? ` · ${filtro}` : ""}`, COLS, [6, 34, 16, 8, 14, 16, 24, 40], linhas())}
                  pdf={() => tabelaPDF("Inventário do clube", filtro || plural(lista.length, "item", "itens"), COLS, linhas())}
                />
              </div>
            </div>
            <div className="-mx-4 flex gap-2 overflow-x-auto px-4 pb-1 sm:mx-0 sm:flex-wrap sm:px-0">
              {["", ...categorias].map((c) => (
                <button
                  key={c || "todas"}
                  onClick={() => setCat(c)}
                  className={cn(
                    "inline-flex h-9 shrink-0 items-center gap-1.5 whitespace-nowrap rounded-full border px-3.5 text-sm font-medium transition-colors",
                    cat === c ? "border-ink-900 bg-ink-900 text-white" : "border-ink-200 bg-white text-ink-700 hover:border-ink-300"
                  )}
                >
                  {c || "Tudo"}
                  <span className={cn("rounded-full px-1.5 text-xs", cat === c ? "bg-white/20" : "bg-ink-100 text-ink-600")}>{c ? conta(c) : data.itens.length}</span>
                </button>
              ))}
            </div>
          </div>

          {!data.itens.length ? (
            <EmptyState
              icon={<Boxes className="size-6" />}
              title="Nenhum material cadastrado"
              description="Comece pela cozinha, pela secretaria ou pelo material de cada unidade."
              action={<Button onClick={() => setSel("novo")}>Cadastrar material</Button>}
            />
          ) : !grupos.length ? (
            <EmptyState
              title={q ? "Nada encontrado" : `Nada em ${cat} ainda`}
              description={q ? "Tente outra palavra ou mude a categoria." : "Cadastre o primeiro item desta categoria."}
              action={
                q ? (
                  <Button variant="secondary" onClick={() => setQ("")}>
                    Limpar busca
                  </Button>
                ) : (
                  <Button onClick={() => setSel("novo")}>Cadastrar item</Button>
                )
              }
            />
          ) : (
            <div className="space-y-6">
              {grupos.map((g) => (
                <section key={g.c}>
                  <h2 className="mb-2 flex items-baseline gap-2 font-display text-lg font-semibold uppercase tracking-wide text-ink-800">
                    {g.c} <span className="font-sans text-sm font-normal normal-case tracking-normal text-ink-500">{plural(g.itens.reduce((s, i) => s + i.quantidade, 0), "peça", "peças")}</span>
                  </h2>
                  <Card className="overflow-hidden">
                    <ul className="divide-y divide-ink-100">
                      {g.itens.map((i) => (
                        <LinhaItem key={i.id} item={i} unidade={unidade(i.unidade_id)} onEditar={() => setSel(i)} onMudou={() => reload(true)} />
                      ))}
                    </ul>
                  </Card>
                </section>
              ))}
            </div>
          )}
        </>
      )}
      {data && <ItemSheet alvo={sel} dados={data} categorias={categorias} categoriaInicial={cat} onClose={() => setSel(null)} onSalvo={() => (setSel(null), reload(true))} />}
    </div>
  );
}

function LinhaItem({ item, unidade, onEditar, onMudou }: { item: ItemInventario; unidade?: Unidade; onEditar: () => void; onMudou: () => void }) {
  const [qtd, setQtd] = useState(item.quantidade);
  const [base, setBase] = useState(item.quantidade);
  if (item.quantidade !== base) {
    // chegou o valor novo do banco
    setBase(item.quantidade);
    setQtd(item.quantidade);
  }
  async function mudar(d: number) {
    const nova = Math.max(0, qtd + d);
    if (nova === qtd) return;
    setQtd(nova);
    const { error } = await supabaseBrowser().from("inventario").update({ quantidade: nova }).eq("id", item.id);
    if (error) {
      setQtd(item.quantidade);
      return toast.error(error.message);
    }
    onMudou();
  }
  const e = ESTADOS[item.estado];
  return (
    <li className="flex items-center gap-3 px-3 py-3 sm:px-4">
      <button className="min-w-0 flex-1 text-left" onClick={onEditar}>
        <div className="flex flex-wrap items-center gap-x-2 gap-y-1">
          <span className="font-medium text-ink-900">{item.nome}</span>
          {item.estado !== "bom" && e && <Badge tone={e.tone}>{e.nome}</Badge>}
          {unidade && (
            <Badge>
              <span className="size-2 rounded-full" style={{ background: unidade.cor }} /> {unidade.nome}
            </Badge>
          )}
        </div>
        {(item.local || item.observacao) && <p className="mt-0.5 truncate text-sm text-ink-500">{[item.local, item.observacao].filter(Boolean).join(" · ")}</p>}
      </button>
      <div className="flex shrink-0 items-center rounded-xl border border-ink-200">
        <button className="grid size-9 place-items-center rounded-l-xl text-ink-600 hover:bg-ink-50 disabled:opacity-40" onClick={() => mudar(-1)} disabled={qtd <= 0} aria-label={`Tirar um de ${item.nome}`}>
          <Minus className="size-4" />
        </button>
        <span className="w-9 text-center text-sm font-semibold tabular-nums text-ink-900" aria-label="Quantidade">
          {qtd}
        </span>
        <button className="grid size-9 place-items-center rounded-r-xl text-ink-600 hover:bg-ink-50" onClick={() => mudar(1)} aria-label={`Somar um em ${item.nome}`}>
          <Plus className="size-4" />
        </button>
      </div>
      <Button size="sm" variant="ghost" onClick={onEditar} aria-label={`Editar ${item.nome}`} className="hidden sm:inline-flex">
        <Pencil className="size-4" />
      </Button>
    </li>
  );
}

function ItemSheet({
  alvo,
  dados,
  categorias,
  categoriaInicial,
  onClose,
  onSalvo,
}: {
  alvo: ItemInventario | "novo" | null;
  dados: Dados;
  categorias: string[];
  categoriaInicial: string;
  onClose: () => void;
  onSalvo: () => void;
}) {
  const auth = useAuth();
  const item = alvo && alvo !== "novo" ? alvo : null;
  const [aberto, setAberto] = useState<typeof alvo>(null);
  const [nome, setNome] = useState("");
  const [categoria, setCategoria] = useState("Cozinha");
  const [nova, setNova] = useState("");
  const [quantidade, setQuantidade] = useState("1");
  const [estado, setEstado] = useState<EstadoItem>("bom");
  const [unidadeId, setUnidadeId] = useState("");
  const [local, setLocal] = useState("");
  const [obs, setObs] = useState("");
  const [erro, setErro] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [excluir, setExcluir] = useState(false);
  if (alvo !== aberto) {
    setAberto(alvo);
    setNome(item?.nome || "");
    setCategoria(item?.categoria || categoriaInicial || "Cozinha");
    setNova("");
    setQuantidade(String(item?.quantidade ?? 1));
    setEstado(item?.estado || "bom");
    setUnidadeId(item?.unidade_id || "");
    setLocal(item?.local || "");
    setObs(item?.observacao || "");
    setErro(null);
  }
  const quem = (id: string | null) => dados.membros.find((m) => m.id === id)?.nome;

  async function salvar() {
    if (!nome.trim()) return setErro("Escreva o nome do material.");
    const cat = categoria === "__nova" ? nova.trim() : categoria;
    if (!cat) return toast.error("Escreva o nome da nova categoria.");
    setBusy(true);
    const campos = {
      nome: nome.trim(),
      categoria: cat,
      quantidade: Math.max(0, Math.floor(Number(quantidade) || 0)),
      estado,
      unidade_id: unidadeId || null,
      local: local.trim() || null,
      observacao: obs.trim() || null,
    };
    const sb = supabaseBrowser();
    const { error } = item ? await sb.from("inventario").update(campos).eq("id", item.id) : await sb.from("inventario").insert(campos);
    setBusy(false);
    if (error) return toast.error(error.message);
    toast.success(item ? "Item atualizado." : "Item cadastrado.");
    onSalvo();
  }

  async function apagar() {
    if (!item) return;
    setBusy(true);
    const { error } = await supabaseBrowser().from("inventario").delete().eq("id", item.id);
    setBusy(false);
    if (error) return toast.error(error.message);
    setExcluir(false);
    toast.success("Item excluído.");
    onSalvo();
  }

  return (
    <>
      <Sheet
        open={!!alvo}
        onClose={onClose}
        title={item ? "Editar material" : "Novo material"}
        description={item ? `Atualizado por ${quem(item.atualizado_por) || "alguém da diretoria"} em ${new Date(item.updated_at).toLocaleDateString("pt-BR")}` : undefined}
        footer={
          <>
            {item && auth.isAdmin && (
              <Button variant="ghost" className="mr-auto text-red-600 hover:bg-red-50" icon={<Trash2 className="size-4" />} onClick={() => setExcluir(true)}>
                Excluir
              </Button>
            )}
            <Button variant="secondary" onClick={onClose}>
              Cancelar
            </Button>
            <Button loading={busy} onClick={salvar}>
              {item ? "Salvar alterações" : "Cadastrar item"}
            </Button>
          </>
        }
      >
        <div className="space-y-4">
          <Input label="Material" required value={nome} error={erro} onChange={(e) => (setNome(e.target.value), setErro(null))} onBlur={() => !nome.trim() && setErro("Escreva o nome do material.")} placeholder="Ex.: Panela de pressão 7 L" maxLength={120} />
          <div className="grid grid-cols-2 gap-4">
            <Select label="Categoria" value={categoria} onChange={(e) => setCategoria(e.target.value)}>
              {categorias.map((c) => (
                <option key={c} value={c}>
                  {c}
                </option>
              ))}
              <option value="__nova">+ Nova categoria…</option>
            </Select>
            <Input label="Quantidade" type="number" inputMode="numeric" min={0} max={99999} value={quantidade} onChange={(e) => setQuantidade(e.target.value)} />
          </div>
          {categoria === "__nova" && <Input label="Nome da nova categoria" value={nova} onChange={(e) => setNova(e.target.value)} placeholder="Ex.: Fanfarra" maxLength={40} />}
          <div className="grid grid-cols-2 gap-4">
            <Select label="Estado" value={estado} onChange={(e) => setEstado(e.target.value as EstadoItem)}>
              {(Object.keys(ESTADOS) as EstadoItem[]).map((k) => (
                <option key={k} value={k}>
                  {ESTADOS[k].nome}
                </option>
              ))}
            </Select>
            <Select label="Unidade (opcional)" value={unidadeId} onChange={(e) => setUnidadeId(e.target.value)}>
              <option value="">Do clube</option>
              {dados.unidades.map((u) => (
                <option key={u.id} value={u.id}>
                  {u.nome}
                </option>
              ))}
            </Select>
          </div>
          <Input label="Onde fica (opcional)" value={local} onChange={(e) => setLocal(e.target.value)} placeholder="Ex.: Armário da secretaria" maxLength={80} />
          <Textarea label="Observação (opcional)" value={obs} onChange={(e) => setObs(e.target.value)} maxLength={500} />
        </div>
      </Sheet>
      <Confirm
        open={excluir}
        danger
        title={`Excluir "${item?.nome}"?`}
        message="O item sai do inventário de vez."
        confirmLabel="Excluir item"
        loading={busy}
        onConfirm={apagar}
        onClose={() => setExcluir(false)}
      />
    </>
  );
}
