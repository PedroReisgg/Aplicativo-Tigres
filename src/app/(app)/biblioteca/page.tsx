"use client";

import { useMemo, useRef, useState } from "react";
import { BookOpen, Download, FileText, History, ImagePlus, Library, Pencil, Plus, RotateCcw, Trash2, Undo2, Upload, UserRound } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Avatar, Badge, Button, Card, Confirm, EmptyState, Input, PageHeader, SearchInput, Sheet, Skeleton, Tabs, Textarea, cn } from "@/components/ui";
import { useData } from "@/lib/use-data";
import { getDesbravadores } from "@/lib/api";
import {
  baixarPdf,
  desfazerDevolucao,
  devolver,
  emprestar,
  excluirLivro,
  getEmprestimos,
  getHistorico,
  getLivros,
  linksDasCapas,
  problemaNaCapa,
  problemaNoPdf,
  salvarLivro,
} from "@/lib/biblioteca";
import { tamanhoTexto } from "@/lib/anexos";
import { isoToBr, normalize, timeAgo } from "@/lib/format";
import type { Desbravador, Emprestimo, Livro, LivroHistorico } from "@/lib/types";

type Aba = "livros" | "emprestimos" | "historico";

type Dados = {
  livros: Livro[];
  emprestimos: Emprestimo[];
  historico: LivroHistorico[];
  capas: Map<string, string>;
  desb: Desbravador[];
};

const hojeIso = () => {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
};

export default function BibliotecaPage() {
  const auth = useAuth();
  const [aba, setAba] = useState<Aba>("livros");
  const [q, setQ] = useState("");
  const [cat, setCat] = useState("");
  const [aberto, setAberto] = useState<Livro | null>(null);
  const [editando, setEditando] = useState<Livro | "novo" | null>(null);
  const [emprestando, setEmprestando] = useState<Livro | "escolher" | null>(null);

  const { data, loading, error, reload } = useData<Dados>(async () => {
    const [livros, emprestimos, historico, desb] = await Promise.all([getLivros(), getEmprestimos(), getHistorico(undefined, 300), getDesbravadores().catch(() => [])]);
    return { livros, emprestimos, historico, desb, capas: await linksDasCapas(livros) };
  }, [auth.isActive]);

  const ativos = useMemo(() => (data?.emprestimos || []).filter((e) => !e.devolvido_em), [data]);
  const foraPorLivro = useMemo(() => {
    const m = new Map<string, number>();
    ativos.forEach((e) => m.set(e.livro_id, (m.get(e.livro_id) || 0) + 1));
    return m;
  }, [ativos]);
  const categorias = useMemo(() => [...new Set((data?.livros || []).map((l) => l.categoria?.trim()).filter(Boolean) as string[])].sort(), [data]);
  const lista = useMemo(
    () =>
      (data?.livros || []).filter(
        (l) => (!cat || l.categoria === cat) && (!q || normalize(`${l.titulo} ${l.autor || ""} ${l.categoria || ""}`).includes(normalize(q)))
      ),
    [data, q, cat]
  );

  if (!auth.isActive)
    return <EmptyState icon={<Library className="size-6" />} title="Acesso pendente" description="Quando o diretor liberar seu acesso, você verá a biblioteca do clube." />;

  const recarregar = () => reload(true);
  const livroAberto = aberto && data ? data.livros.find((l) => l.id === aberto.id) || null : null;

  return (
    <div>
      <PageHeader
        eyebrow="Clube"
        title="Biblioteca"
        description="Livros do clube: baixe o PDF, veja quem está com cada exemplar e quem mexeu em cada arquivo."
        actions={
          <>
            <Button variant="secondary" icon={<BookOpen className="size-4" />} onClick={() => setEmprestando("escolher")} disabled={!data?.livros.some((l) => l.exemplares > 0)}>
              Emprestar livro
            </Button>
            <Button icon={<Plus className="size-4" />} onClick={() => setEditando("novo")}>
              Novo livro
            </Button>
          </>
        }
      />

      <div className="mb-5">
        <Tabs<Aba>
          value={aba}
          onChange={setAba}
          items={[
            { value: "livros", label: "Livros" },
            { value: "emprestimos", label: "Emprestados", count: ativos.length },
            { value: "historico", label: "Histórico" },
          ]}
        />
      </div>

      {loading ? (
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-5">
          {Array.from({ length: 5 }).map((_, i) => (
            <Skeleton key={i} className="aspect-[2/3]" />
          ))}
        </div>
      ) : error || !data ? (
        <EmptyState icon={<Library className="size-6" />} title="Não foi possível abrir a biblioteca" description={error || "Tente de novo em alguns instantes."} action={<Button onClick={() => reload()}>Tentar de novo</Button>} />
      ) : aba === "livros" ? (
        <>
          {data.livros.length > 0 && (
            <div className="mb-4 space-y-3">
              <SearchInput value={q} onChange={setQ} placeholder="Buscar por título, autor ou assunto…" />
              {categorias.length > 0 && (
                <div className="-mx-4 flex gap-2 overflow-x-auto px-4 pb-1 sm:mx-0 sm:flex-wrap sm:px-0">
                  {["", ...categorias].map((c) => (
                    <button
                      key={c || "todas"}
                      onClick={() => setCat(c)}
                      className={cn(
                        "h-9 shrink-0 whitespace-nowrap rounded-full border px-3.5 text-sm font-medium transition-colors",
                        cat === c ? "border-ink-900 bg-ink-900 text-white" : "border-ink-200 bg-white text-ink-700 hover:border-ink-300"
                      )}
                    >
                      {c || "Todos"}
                    </button>
                  ))}
                </div>
              )}
            </div>
          )}
          {!data.livros.length ? (
            <EmptyState
              icon={<Library className="size-6" />}
              title="Nenhum livro ainda"
              description="Cadastre o primeiro livro com a foto da capa e o PDF. Qualquer membro da diretoria pode cadastrar."
              action={<Button onClick={() => setEditando("novo")}>Cadastrar livro</Button>}
            />
          ) : !lista.length ? (
            <EmptyState title="Nenhum livro encontrado" description="Tente outra palavra ou limpe o filtro." action={<Button variant="secondary" onClick={() => (setQ(""), setCat(""))}>Limpar busca</Button>} />
          ) : (
            <div className="grid grid-cols-2 gap-x-4 gap-y-6 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
              {lista.map((l) => (
                <CartaoLivro key={l.id} livro={l} capa={l.capa_path ? data.capas.get(l.capa_path) : undefined} fora={foraPorLivro.get(l.id) || 0} onAbrir={() => setAberto(l)} />
              ))}
            </div>
          )}
        </>
      ) : aba === "emprestimos" ? (
        <Emprestimos dados={data} onEmprestar={() => setEmprestando("escolher")} onMudou={recarregar} />
      ) : (
        <ListaHistorico itens={data.historico} vazio="Quando alguém cadastrar, trocar um PDF ou emprestar um livro, aparece aqui." />
      )}

      {livroAberto && data && (
        <DetalheLivro
          livro={livroAberto}
          capa={livroAberto.capa_path ? data.capas.get(livroAberto.capa_path) : undefined}
          dados={data}
          fora={foraPorLivro.get(livroAberto.id) || 0}
          onClose={() => setAberto(null)}
          onEditar={() => setEditando(livroAberto)}
          onEmprestar={() => setEmprestando(livroAberto)}
          onMudou={recarregar}
        />
      )}
      <EditarLivro
        alvo={editando}
        capaAtual={editando && editando !== "novo" && editando.capa_path ? data?.capas.get(editando.capa_path) : undefined}
        categorias={categorias}
        onClose={() => setEditando(null)}
        onSalvo={(l, novo) => {
          setEditando(null);
          if (novo) setAberto(l);
          recarregar();
        }}
        onExcluido={() => {
          setEditando(null);
          setAberto(null);
          recarregar();
        }}
      />
      {data && (
        <EmprestarSheet
          alvo={emprestando}
          dados={data}
          fora={foraPorLivro}
          onClose={() => setEmprestando(null)}
          onFeito={() => {
            setEmprestando(null);
            recarregar();
          }}
        />
      )}
    </div>
  );
}

/* ---------- capa ---------- */

const CORES_CAPA = ["#7a2a08", "#2F7D4F", "#2563A8", "#7B3FA0", "#6B4A2E", "#0E8C8C", "#D93A2B"];

function Capa({ livro, url, className }: { livro: Pick<Livro, "id" | "titulo" | "autor">; url?: string; className?: string }) {
  const cor = CORES_CAPA[[...livro.id].reduce((s, c) => s + c.charCodeAt(0), 0) % CORES_CAPA.length];
  return (
    <div className={cn("relative aspect-[2/3] overflow-hidden rounded-lg bg-ink-100 shadow-[0_1px_2px_rgba(0,0,0,.12),0_6px_16px_-6px_rgba(0,0,0,.35)]", className)}>
      {url ? (
        // eslint-disable-next-line @next/next/no-img-element
        <img src={url} alt={`Capa de ${livro.titulo}`} className="size-full object-cover" loading="lazy" />
      ) : (
        <div className="flex size-full flex-col justify-between p-3 text-white" style={{ background: `linear-gradient(160deg, ${cor}, #1f140d)` }}>
          <BookOpen className="size-5 opacity-70" aria-hidden />
          <div>
            <div className="line-clamp-4 font-display text-base font-semibold uppercase leading-tight tracking-wide">{livro.titulo}</div>
            {livro.autor && <div className="mt-1 line-clamp-2 text-[11px] text-white/75">{livro.autor}</div>}
          </div>
        </div>
      )}
      <span className="pointer-events-none absolute inset-y-0 left-0 w-1.5 bg-gradient-to-r from-black/25 to-transparent" aria-hidden />
    </div>
  );
}

function Disponibilidade({ livro, fora }: { livro: Livro; fora: number }) {
  if (!livro.exemplares) return null;
  const livres = Math.max(0, livro.exemplares - fora);
  return <Badge tone={livres ? "green" : "amber"}>{livres ? `${livres} de ${livro.exemplares} para emprestar` : "Todos emprestados"}</Badge>;
}

function BotaoBaixar({ livro, size = "sm", className }: { livro: Livro; size?: "sm" | "md"; className?: string }) {
  const [baixando, setBaixando] = useState(false);
  if (!livro.pdf_path) return null;
  return (
    <Button
      size={size}
      className={className}
      icon={<Download className="size-4" />}
      loading={baixando}
      onClick={async (e) => {
        e.stopPropagation();
        setBaixando(true);
        try {
          await baixarPdf(livro);
        } catch (err) {
          toast.error((err as Error).message);
        } finally {
          setBaixando(false);
        }
      }}
    >
      Baixar PDF
    </Button>
  );
}

function CartaoLivro({ livro, capa, fora, onAbrir }: { livro: Livro; capa?: string; fora: number; onAbrir: () => void }) {
  return (
    <div className="flex min-w-0 flex-col">
      <button onClick={onAbrir} className="group rounded-lg text-left focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-tiger-500 focus-visible:ring-offset-2" aria-label={`Abrir ${livro.titulo}`}>
        <Capa livro={livro} url={capa} className="transition-transform duration-200 group-hover:-translate-y-0.5" />
      </button>
      <button onClick={onAbrir} className="mt-2.5 text-left">
        <h3 className="line-clamp-2 text-[15px] font-semibold leading-snug text-ink-900 hover:text-tiger-700">{livro.titulo}</h3>
      </button>
      {livro.autor && <p className="truncate text-sm text-ink-500">{livro.autor}</p>}
      <div className="mt-1.5 flex flex-wrap gap-1">
        {livro.pdf_path ? <Badge tone="tiger">PDF {tamanhoTexto(livro.pdf_tamanho)}</Badge> : <Badge>Sem PDF</Badge>}
        <Disponibilidade livro={livro} fora={fora} />
      </div>
      <div className="mt-auto pt-3">{livro.pdf_path ? <BotaoBaixar livro={livro} className="w-full" /> : null}</div>
    </div>
  );
}

/* ---------- detalhe ---------- */

function DetalheLivro({
  livro,
  capa,
  dados,
  fora,
  onClose,
  onEditar,
  onEmprestar,
  onMudou,
}: {
  livro: Livro;
  capa?: string;
  dados: Dados;
  fora: number;
  onClose: () => void;
  onEditar: () => void;
  onEmprestar: () => void;
  onMudou: () => void;
}) {
  const hist = dados.historico.filter((h) => h.livro_id === livro.id);
  const comQuem = dados.emprestimos.filter((e) => e.livro_id === livro.id && !e.devolvido_em);
  const ultimaPdf = hist.find((h) => /PDF/.test(h.acao));
  const livres = Math.max(0, livro.exemplares - fora);
  return (
    <Sheet
      open
      onClose={onClose}
      wide
      title={livro.titulo}
      description={livro.autor || undefined}
      footer={
        <>
          <Button variant="secondary" icon={<Pencil className="size-4" />} onClick={onEditar}>
            Editar livro
          </Button>
          {livro.exemplares > 0 && (
            <Button variant="secondary" icon={<BookOpen className="size-4" />} onClick={onEmprestar} disabled={!livres}>
              Emprestar
            </Button>
          )}
          <BotaoBaixar livro={livro} size="md" />
        </>
      }
    >
      <div className="flex flex-col gap-5 sm:flex-row">
        <Capa livro={livro} url={capa} className="mx-auto w-40 shrink-0 sm:mx-0" />
        <div className="min-w-0 flex-1 space-y-3">
          <div className="flex flex-wrap gap-1.5">
            {livro.categoria && <Badge tone="blue">{livro.categoria}</Badge>}
            {livro.pdf_path ? <Badge tone="tiger">PDF {tamanhoTexto(livro.pdf_tamanho)}</Badge> : <Badge>Sem PDF</Badge>}
            <Disponibilidade livro={livro} fora={fora} />
          </div>
          {livro.descricao ? <p className="whitespace-pre-line text-[15px] leading-relaxed text-ink-700">{livro.descricao}</p> : <p className="text-sm text-ink-500">Sem descrição.</p>}
          {livro.pdf_path && (
            <div className="rounded-xl bg-ink-50 p-3 text-sm">
              <div className="flex items-center gap-2 font-medium text-ink-800">
                <FileText className="size-4 text-tiger-600" aria-hidden />
                <span className="min-w-0 truncate">{livro.pdf_nome || "Arquivo PDF"}</span>
              </div>
              {ultimaPdf && (
                <p className="mt-1 text-ink-500">
                  {ultimaPdf.acao === "enviou o PDF" || ultimaPdf.acao === "cadastrou o livro" ? "Enviado" : "Atualizado"} por <b className="font-semibold text-ink-700">{ultimaPdf.autor_nome || "alguém da diretoria"}</b> em{" "}
                  {new Date(ultimaPdf.created_at).toLocaleDateString("pt-BR")}
                </p>
              )}
            </div>
          )}
        </div>
      </div>

      {livro.exemplares > 0 && (
        <section className="mt-6">
          <h3 className="mb-2 text-sm font-semibold uppercase tracking-wide text-ink-500">Com quem está ({comQuem.length})</h3>
          {comQuem.length ? (
            <ul className="divide-y divide-ink-100 rounded-2xl border border-ink-200">
              {comQuem.map((e) => (
                <LinhaEmprestimo key={e.id} e={e} desb={dados.desb} onMudou={onMudou} />
              ))}
            </ul>
          ) : (
            <p className="text-sm text-ink-500">Nenhum exemplar emprestado agora.</p>
          )}
        </section>
      )}

      <section className="mt-6">
        <h3 className="mb-2 text-sm font-semibold uppercase tracking-wide text-ink-500">Histórico deste livro</h3>
        <ListaHistorico itens={hist} semTitulo vazio="Nada registrado ainda." />
      </section>
    </Sheet>
  );
}

/* ---------- empréstimos ---------- */

function nomeDesb(desb: Desbravador[], id: string) {
  return desb.find((d) => d.id === id) || null;
}

function LinhaEmprestimo({ e, desb, livro, onMudou }: { e: Emprestimo; desb: Desbravador[]; livro?: Livro; onMudou: () => void }) {
  const [busy, setBusy] = useState(false);
  const d = nomeDesb(desb, e.desbravador_id);
  const atrasado = !e.devolvido_em && e.devolver_ate && e.devolver_ate < hojeIso();
  const acao = async (fn: () => Promise<void>, ok: string) => {
    setBusy(true);
    try {
      await fn();
      toast.success(ok);
      onMudou();
    } catch (err) {
      toast.error((err as Error).message);
    } finally {
      setBusy(false);
    }
  };
  return (
    <li className="flex items-center gap-3 px-3 py-3">
      <Avatar nome={d?.nome || "?"} color={d?.classe_cor} size={36} />
      <div className="min-w-0 flex-1">
        {livro && <div className="truncate text-sm font-semibold text-ink-900">{livro.titulo}</div>}
        <div className={cn("truncate text-sm", livro ? "text-ink-700" : "font-medium text-ink-900")}>{d?.nome || "Desbravador de outra turma"}</div>
        <div className="text-xs text-ink-500">
          {e.devolvido_em ? `Devolvido em ${isoToBr(e.devolvido_em)}` : `Desde ${isoToBr(e.emprestado_em)}`}
          {!e.devolvido_em && e.devolver_ate && <span className={cn(atrasado && "font-semibold text-red-600")}> · devolver até {isoToBr(e.devolver_ate)}</span>}
          {e.observacao && ` · ${e.observacao}`}
        </div>
      </div>
      {atrasado && <Badge tone="red">Atrasado</Badge>}
      {e.devolvido_em ? (
        <Button size="sm" variant="ghost" icon={<Undo2 className="size-4" />} loading={busy} onClick={() => acao(() => desfazerDevolucao(e.id), "Devolução desfeita.")}>
          Desfazer
        </Button>
      ) : (
        <Button size="sm" variant="secondary" icon={<RotateCcw className="size-4" />} loading={busy} onClick={() => acao(() => devolver(e.id), "Devolução registrada.")}>
          Devolveu
        </Button>
      )}
    </li>
  );
}

function Emprestimos({ dados, onEmprestar, onMudou }: { dados: Dados; onEmprestar: () => void; onMudou: () => void }) {
  const [verTodos, setVerTodos] = useState(false);
  const livro = (id: string) => dados.livros.find((l) => l.id === id);
  const ativos = dados.emprestimos.filter((e) => !e.devolvido_em).sort((a, b) => (a.devolver_ate || "9").localeCompare(b.devolver_ate || "9"));
  const devolvidos = dados.emprestimos.filter((e) => e.devolvido_em).sort((a, b) => (b.devolvido_em || "").localeCompare(a.devolvido_em || ""));
  return (
    <div className="space-y-6">
      {ativos.length ? (
        <Card className="overflow-hidden">
          <ul className="divide-y divide-ink-100">
            {ativos.map((e) => (
              <LinhaEmprestimo key={e.id} e={e} desb={dados.desb} livro={livro(e.livro_id)} onMudou={onMudou} />
            ))}
          </ul>
        </Card>
      ) : (
        <EmptyState
          icon={<BookOpen className="size-6" />}
          title="Nenhum livro emprestado"
          description={dados.livros.some((l) => l.exemplares > 0) ? "Quando um desbravador levar um livro, registre aqui para saber com quem ele está." : "Para emprestar, informe no livro quantos exemplares físicos o clube tem."}
          action={dados.livros.some((l) => l.exemplares > 0) && <Button onClick={onEmprestar}>Emprestar livro</Button>}
        />
      )}
      {devolvidos.length > 0 && (
        <section>
          <h2 className="mb-2 text-sm font-semibold uppercase tracking-wide text-ink-500">Já devolvidos</h2>
          <Card className="overflow-hidden">
            <ul className="divide-y divide-ink-100">
              {(verTodos ? devolvidos : devolvidos.slice(0, 8)).map((e) => (
                <LinhaEmprestimo key={e.id} e={e} desb={dados.desb} livro={livro(e.livro_id)} onMudou={onMudou} />
              ))}
            </ul>
          </Card>
          {devolvidos.length > 8 && !verTodos && (
            <button className="mt-2 text-sm font-semibold text-tiger-700 hover:underline" onClick={() => setVerTodos(true)}>
              Ver todos ({devolvidos.length})
            </button>
          )}
        </section>
      )}
    </div>
  );
}

function EmprestarSheet({ alvo, dados, fora, onClose, onFeito }: { alvo: Livro | "escolher" | null; dados: Dados; fora: Map<string, number>; onClose: () => void; onFeito: () => void }) {
  const [livroId, setLivroId] = useState("");
  const [desbId, setDesbId] = useState("");
  const [busca, setBusca] = useState("");
  const [ate, setAte] = useState("");
  const [obs, setObs] = useState("");
  const [busy, setBusy] = useState(false);
  const [aberto, setAberto] = useState<typeof alvo>(null);
  if (alvo !== aberto) {
    // abriu de novo: limpa o formulário
    setAberto(alvo);
    setLivroId(alvo && alvo !== "escolher" ? alvo.id : "");
    setDesbId("");
    setBusca("");
    setAte("");
    setObs("");
  }
  const livros = dados.livros.filter((l) => l.exemplares > 0);
  const lista = dados.desb.filter((d) => normalize(d.nome).includes(normalize(busca)));
  const livro = livros.find((l) => l.id === livroId);
  const livres = livro ? livro.exemplares - (fora.get(livro.id) || 0) : 0;

  async function salvar() {
    if (!livro || !desbId) return;
    setBusy(true);
    try {
      await emprestar({ livro_id: livro.id, desbravador_id: desbId, devolver_ate: ate || null, observacao: obs.trim() || null });
      toast.success(`${livro.titulo} emprestado para ${nomeDesb(dados.desb, desbId)?.nome.split(" ")[0] || "o desbravador"}.`);
      onFeito();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setBusy(false);
    }
  }

  return (
    <Sheet
      open={!!alvo}
      onClose={onClose}
      title="Emprestar livro"
      description="Escolha o livro e o desbravador que vai levar."
      footer={
        <>
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
          <Button loading={busy} disabled={!livro || !desbId || livres <= 0} onClick={salvar}>
            Registrar empréstimo
          </Button>
        </>
      }
    >
      <div className="space-y-5">
        <div className="flex flex-col gap-1.5">
          <label htmlFor="emp-livro" className="text-sm font-medium text-ink-800">
            Livro
          </label>
          <select
            id="emp-livro"
            value={livroId}
            onChange={(e) => setLivroId(e.target.value)}
            className="h-11 w-full rounded-xl border border-ink-200 bg-white px-3.5 text-[15px] focus:border-tiger-500 focus:outline-none focus:ring-2 focus:ring-tiger-500/35"
          >
            <option value="">Escolha o livro…</option>
            {livros.map((l) => {
              const n = l.exemplares - (fora.get(l.id) || 0);
              return (
                <option key={l.id} value={l.id} disabled={n <= 0}>
                  {l.titulo} {n > 0 ? `(${n} disponível${n > 1 ? "is" : ""})` : "(todos emprestados)"}
                </option>
              );
            })}
          </select>
          {livro && livres <= 0 && <p className="text-[13px] text-red-600">Todos os exemplares deste livro já estão emprestados.</p>}
        </div>

        <div className="space-y-2">
          <div className="text-sm font-medium text-ink-800">Desbravador</div>
          {dados.desb.length > 6 && <SearchInput value={busca} onChange={setBusca} placeholder="Buscar desbravador…" />}
          <ul className="max-h-[38dvh] divide-y divide-ink-100 overflow-y-auto rounded-2xl border border-ink-200" role="radiogroup" aria-label="Desbravador">
            {lista.map((d) => (
              <li key={d.id}>
                <button
                  role="radio"
                  aria-checked={desbId === d.id}
                  onClick={() => setDesbId(d.id)}
                  className={cn("flex w-full items-center gap-3 px-3 py-2.5 text-left", desbId === d.id ? "bg-tiger-50" : "hover:bg-ink-50")}
                >
                  <span className={cn("grid size-5 shrink-0 place-items-center rounded-full border-2", desbId === d.id ? "border-tiger-500" : "border-ink-300")}>
                    {desbId === d.id && <span className="size-2.5 rounded-full bg-tiger-500" />}
                  </span>
                  <Avatar nome={d.nome} color={d.classe_cor} size={30} />
                  <span className="min-w-0 flex-1">
                    <span className="block truncate text-sm font-medium text-ink-900">{d.nome}</span>
                    <span className="block truncate text-xs text-ink-500">{[d.classe_nome, d.unidade].filter(Boolean).join(" · ")}</span>
                  </span>
                </button>
              </li>
            ))}
            {!lista.length && <li className="px-3 py-6 text-center text-sm text-ink-500">Nenhum desbravador encontrado.</li>}
          </ul>
        </div>

        <Input label="Devolver até (opcional)" type="date" value={ate} min={hojeIso()} onChange={(e) => setAte(e.target.value)} />
        <Input label="Observação (opcional)" value={obs} onChange={(e) => setObs(e.target.value)} placeholder="Ex.: capa um pouco rasgada" maxLength={160} />
      </div>
    </Sheet>
  );
}

/* ---------- histórico ---------- */

function ListaHistorico({ itens, vazio, semTitulo }: { itens: LivroHistorico[]; vazio: string; semTitulo?: boolean }) {
  const [mais, setMais] = useState(false);
  if (!itens.length)
    return semTitulo ? <p className="text-sm text-ink-500">{vazio}</p> : <EmptyState icon={<History className="size-6" />} title="Nada registrado ainda" description={vazio} />;
  const mostrar = mais ? itens : itens.slice(0, semTitulo ? 6 : 40);
  return (
    <div>
      <ul className={cn("divide-y divide-ink-100", semTitulo ? "rounded-2xl border border-ink-200" : "rounded-2xl border border-ink-200/80 bg-white shadow-card")}>
        {mostrar.map((h) => (
          <li key={h.id} className="flex gap-3 px-3 py-3">
            <span className="mt-0.5 grid size-8 shrink-0 place-items-center rounded-full bg-ink-100 text-ink-600">{iconeAcao(h.acao)}</span>
            <div className="min-w-0 flex-1 text-sm">
              <p className="text-ink-800">
                <b className="font-semibold text-ink-900">{h.autor_nome || "Alguém"}</b> {h.acao}
                {!semTitulo && h.livro_titulo && (
                  <>
                    {" "}
                    · <span className="font-medium">{h.livro_titulo}</span>
                  </>
                )}
              </p>
              {h.detalhe && <p className="mt-0.5 break-words text-ink-500">{h.detalhe}</p>}
            </div>
            <time className="shrink-0 text-xs text-ink-400" dateTime={h.created_at} title={new Date(h.created_at).toLocaleString("pt-BR")}>
              {timeAgo(h.created_at)}
            </time>
          </li>
        ))}
      </ul>
      {itens.length > mostrar.length && (
        <button className="mt-2 text-sm font-semibold text-tiger-700 hover:underline" onClick={() => setMais(true)}>
          Ver tudo ({itens.length})
        </button>
      )}
    </div>
  );
}

function iconeAcao(acao: string) {
  if (/PDF/.test(acao)) return <FileText className="size-4" />;
  if (/capa/.test(acao)) return <ImagePlus className="size-4" />;
  if (/emprest|devol|recebeu/.test(acao)) return <UserRound className="size-4" />;
  if (/exclu/.test(acao)) return <Trash2 className="size-4" />;
  if (/cadastrou/.test(acao)) return <Plus className="size-4" />;
  return <Pencil className="size-4" />;
}

/* ---------- cadastro / edição ---------- */

function EditarLivro({
  alvo,
  capaAtual,
  categorias,
  onClose,
  onSalvo,
  onExcluido,
}: {
  alvo: Livro | "novo" | null;
  capaAtual?: string;
  categorias: string[];
  onClose: () => void;
  onSalvo: (l: Livro, novo: boolean) => void;
  onExcluido: () => void;
}) {
  const auth = useAuth();
  const livro = alvo && alvo !== "novo" ? alvo : null;
  const [aberto, setAberto] = useState<typeof alvo>(null);
  const [titulo, setTitulo] = useState("");
  const [autor, setAutor] = useState("");
  const [categoria, setCategoria] = useState("");
  const [descricao, setDescricao] = useState("");
  const [exemplares, setExemplares] = useState("0");
  const [capa, setCapa] = useState<File | null>(null);
  const [pdf, setPdf] = useState<File | null>(null);
  const [tirarCapa, setTirarCapa] = useState(false);
  const [tirarPdf, setTirarPdf] = useState(false);
  const [erroTitulo, setErroTitulo] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [excluir, setExcluir] = useState(false);
  const [preview, setPreview] = useState<string | null>(null);
  const capaRef = useRef<HTMLInputElement>(null);
  const pdfRef = useRef<HTMLInputElement>(null);

  if (alvo !== aberto) {
    setAberto(alvo);
    setTitulo(livro?.titulo || "");
    setAutor(livro?.autor || "");
    setCategoria(livro?.categoria || "");
    setDescricao(livro?.descricao || "");
    setExemplares(String(livro?.exemplares ?? 0));
    setCapa(null);
    setPdf(null);
    setTirarCapa(false);
    setTirarPdf(false);
    setErroTitulo(null);
    setPreview(null);
  }

  const escolherCapa = (f?: File) => {
    if (!f) return;
    const erro = problemaNaCapa(f);
    if (erro) return toast.error(erro);
    setCapa(f);
    setTirarCapa(false);
    setPreview(URL.createObjectURL(f));
  };
  const escolherPdf = (f?: File) => {
    if (!f) return;
    const erro = problemaNoPdf(f);
    if (erro) return toast.error(erro);
    setPdf(f);
    setTirarPdf(false);
  };

  async function salvar() {
    if (!titulo.trim()) {
      setErroTitulo("Escreva o nome do livro.");
      return;
    }
    setBusy(true);
    try {
      const salvo = await salvarLivro({
        livro,
        dados: {
          titulo: titulo.trim(),
          autor: autor.trim() || null,
          categoria: categoria.trim() || null,
          descricao: descricao.trim() || null,
          exemplares: Math.max(0, Math.floor(Number(exemplares) || 0)),
        },
        capa,
        pdf,
        removerCapa: tirarCapa,
        removerPdf: tirarPdf,
      });
      toast.success(livro ? "Livro atualizado." : "Livro cadastrado.");
      onSalvo(salvo, !livro);
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setBusy(false);
    }
  }

  async function apagar() {
    if (!livro) return;
    setBusy(true);
    try {
      await excluirLivro(livro);
      toast.success("Livro excluído.");
      setExcluir(false);
      onExcluido();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setBusy(false);
    }
  }

  const capaMostrada = preview || (!tirarCapa ? capaAtual : undefined);
  const temPdf = pdf || (livro?.pdf_path && !tirarPdf);

  return (
    <>
      <Sheet
        open={!!alvo}
        onClose={onClose}
        wide
        title={livro ? "Editar livro" : "Novo livro"}
        description="Fica registrado no histórico quem cadastrou, trocou o PDF ou mudou os dados."
        footer={
          <>
            {livro && auth.isAdmin && (
              <Button variant="ghost" className="mr-auto text-red-600 hover:bg-red-50" icon={<Trash2 className="size-4" />} onClick={() => setExcluir(true)}>
                Excluir
              </Button>
            )}
            <Button variant="secondary" onClick={onClose}>
              Cancelar
            </Button>
            <Button loading={busy} onClick={salvar}>
              {livro ? "Salvar alterações" : "Cadastrar livro"}
            </Button>
          </>
        }
      >
        <div className="grid gap-5 sm:grid-cols-[150px_1fr]">
          <div>
            <div className="mb-1.5 text-sm font-medium text-ink-800">Foto da capa</div>
            <button
              type="button"
              onClick={() => capaRef.current?.click()}
              className="group relative block w-32 overflow-hidden rounded-lg sm:w-full"
              aria-label={capaMostrada ? "Trocar a foto da capa" : "Colocar a foto da capa"}
            >
              {capaMostrada ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={capaMostrada} alt="" className="aspect-[2/3] w-full rounded-lg object-cover shadow-card" />
              ) : (
                <div className="grid aspect-[2/3] w-full place-items-center rounded-lg border-2 border-dashed border-ink-200 bg-ink-50 text-ink-500 group-hover:border-tiger-400 group-hover:text-tiger-700">
                  <span className="flex flex-col items-center gap-1.5 px-2 text-center text-xs font-medium">
                    <ImagePlus className="size-6" /> Colocar foto
                  </span>
                </div>
              )}
            </button>
            <input ref={capaRef} type="file" accept="image/jpeg,image/png,image/webp" className="hidden" onChange={(e) => (escolherCapa(e.target.files?.[0]), (e.target.value = ""))} />
            {capaMostrada && (
              <div className="mt-2 flex gap-3 text-sm">
                <button className="font-semibold text-tiger-700 hover:underline" onClick={() => capaRef.current?.click()}>
                  Trocar
                </button>
                <button
                  className="font-semibold text-ink-500 hover:text-red-600"
                  onClick={() => {
                    setCapa(null);
                    setPreview(null);
                    setTirarCapa(!!livro?.capa_path);
                  }}
                >
                  Tirar
                </button>
              </div>
            )}
          </div>

          <div className="space-y-4">
            <Input label="Nome do livro" required value={titulo} error={erroTitulo} onChange={(e) => (setTitulo(e.target.value), setErroTitulo(null))} onBlur={() => !titulo.trim() && setErroTitulo("Escreva o nome do livro.")} maxLength={160} />
            <Input label="Autor" value={autor} onChange={(e) => setAutor(e.target.value)} maxLength={120} />
            <div className="grid gap-4 sm:grid-cols-2">
              <Input label="Assunto" value={categoria} onChange={(e) => setCategoria(e.target.value)} list="categorias-livro" placeholder="Ex.: Devocional" maxLength={60} />
              <datalist id="categorias-livro">
                {[...new Set([...categorias, "Devocional", "Classes", "Especialidades", "Liderança", "Bíblia", "Histórias"])].map((c) => (
                  <option key={c} value={c} />
                ))}
              </datalist>
              <Input
                label="Exemplares físicos"
                type="number"
                inputMode="numeric"
                min={0}
                max={999}
                value={exemplares}
                onChange={(e) => setExemplares(e.target.value)}
                hint="Quantos o clube tem para emprestar. 0 = só o PDF."
              />
            </div>
            <Textarea label="Descrição" value={descricao} onChange={(e) => setDescricao(e.target.value)} maxLength={2000} placeholder="Sobre o que é o livro, para quem é indicado…" />

            <div>
              <div className="mb-1.5 text-sm font-medium text-ink-800">Arquivo PDF</div>
              {temPdf ? (
                <div className="flex items-center gap-3 rounded-xl border border-ink-200 p-3">
                  <span className="grid size-10 shrink-0 place-items-center rounded-lg bg-red-50 text-red-600">
                    <FileText className="size-5" />
                  </span>
                  <div className="min-w-0 flex-1 text-sm">
                    <div className="truncate font-medium text-ink-900">{pdf ? pdf.name : livro?.pdf_nome || "Arquivo PDF"}</div>
                    <div className="text-ink-500">{pdf ? `${tamanhoTexto(pdf.size)} · novo, envia ao salvar` : tamanhoTexto(livro?.pdf_tamanho)}</div>
                  </div>
                  <Button size="sm" variant="secondary" onClick={() => pdfRef.current?.click()}>
                    Trocar
                  </Button>
                  <Button
                    size="sm"
                    variant="ghost"
                    aria-label="Tirar o PDF"
                    onClick={() => {
                      setPdf(null);
                      setTirarPdf(!!livro?.pdf_path);
                    }}
                  >
                    <Trash2 className="size-4" />
                  </Button>
                </div>
              ) : (
                <button
                  type="button"
                  onClick={() => pdfRef.current?.click()}
                  className="flex w-full items-center justify-center gap-2 rounded-xl border-2 border-dashed border-ink-200 bg-ink-50 px-4 py-5 text-sm font-medium text-ink-600 hover:border-tiger-400 hover:text-tiger-700"
                >
                  <Upload className="size-4" /> Escolher o PDF (até 50 MB)
                </button>
              )}
              <input ref={pdfRef} type="file" accept="application/pdf,.pdf" className="hidden" onChange={(e) => (escolherPdf(e.target.files?.[0]), (e.target.value = ""))} />
              {tirarPdf && <p className="mt-1.5 text-[13px] text-amber-700">O PDF atual será tirado ao salvar.</p>}
              <p className="mt-1.5 text-[13px] text-ink-500">Coloque só livros que o clube pode compartilhar. Só membros e o link da família conseguem baixar.</p>
            </div>
          </div>
        </div>
      </Sheet>
      <Confirm
        open={excluir}
        danger
        title={`Excluir "${livro?.titulo}"?`}
        message="O livro, o PDF e os registros de empréstimo dele serão apagados de vez. O histórico continua mostrando que ele foi excluído."
        confirmLabel="Excluir livro"
        loading={busy}
        onConfirm={apagar}
        onClose={() => setExcluir(false)}
      />
    </>
  );
}
