"use client";

import { useMemo, useState } from "react";
import { CalendarClock, HandCoins, Lock, Pencil, Plus, Trash2, Unlock } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { PixBox } from "@/components/pix-box";
import { Badge, Button, Card, Confirm, EmptyState, Input, PageHeader, ProgressBar, Sheet, Skeleton, Textarea, cn } from "@/components/ui";
import { supabaseBrowser } from "@/lib/supabase/client";
import { must, useData } from "@/lib/use-data";
import { getMembros } from "@/lib/api";
import { isoToBr, plural } from "@/lib/format";
import { NOME_TIPO_CHAVE, lerValor, reais, tipoDaChave } from "@/lib/pix";
import type { Profile, Vaquinha, VaquinhaEntrada } from "@/lib/types";

type Dados = { vaquinhas: Vaquinha[]; entradas: VaquinhaEntrada[]; membros: Profile[] };

const hojeIso = () => {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
};

export default function VaquinhasPage() {
  const auth = useAuth();
  const [editar, setEditar] = useState<Vaquinha | "nova" | null>(null);
  const [aberta, setAberta] = useState<string | null>(null);

  const { data, loading, error, reload } = useData<Dados>(async () => {
    const sb = supabaseBrowser();
    const r = await sb.from("vaquinhas").select("*").order("created_at", { ascending: false });
    if (r.error && /vaquinhas|does not exist|schema cache/i.test(r.error.message)) throw new Error("As vaquinhas ainda não foram ativadas no banco. Peça ao diretor para rodar o SQL 0005.");
    const [entradas, membros] = await Promise.all([sb.from("vaquinha_entradas").select("*").order("data", { ascending: false }), getMembros().catch(() => [])]);
    return { vaquinhas: must(r) as Vaquinha[], entradas: must(entradas) as VaquinhaEntrada[], membros };
  }, [auth.isActive]);

  const total = useMemo(() => {
    const m = new Map<string, { soma: number; n: number }>();
    (data?.entradas || []).forEach((e) => {
      const t = m.get(e.vaquinha_id) || { soma: 0, n: 0 };
      m.set(e.vaquinha_id, { soma: t.soma + Number(e.valor), n: t.n + 1 });
    });
    return m;
  }, [data]);

  if (!auth.isActive) return <EmptyState icon={<HandCoins className="size-6" />} title="Acesso pendente" description="Quando o diretor liberar seu acesso, você verá as vaquinhas do clube." />;

  const abertas = (data?.vaquinhas || []).filter((v) => !v.encerrada);
  const encerradas = (data?.vaquinhas || []).filter((v) => v.encerrada);
  const sel = data?.vaquinhas.find((v) => v.id === aberta) || null;

  const cartao = (v: Vaquinha) => <CartaoVaquinha key={v.id} v={v} soma={total.get(v.id)?.soma || 0} n={total.get(v.id)?.n || 0} onAbrir={() => setAberta(v.id)} />;

  return (
    <div>
      <PageHeader
        eyebrow="Clube"
        title="Vaquinhas"
        description={
          auth.isAdmin
            ? "Crie uma vaquinha com a meta e a chave Pix. A barra mostra quanto já entrou."
            : auth.podeFinanceiro
              ? "Registre o que entrou em cada vaquinha. A barra mostra quanto falta para a meta."
              : "As arrecadações do clube e quanto falta para cada meta."
        }
        actions={
          auth.isAdmin && (
            <Button icon={<Plus className="size-4" />} onClick={() => setEditar("nova")}>
              Nova vaquinha
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
        <EmptyState icon={<HandCoins className="size-6" />} title="Não foi possível abrir as vaquinhas" description={error || "Tente de novo em alguns instantes."} action={<Button onClick={() => reload()}>Tentar de novo</Button>} />
      ) : !data.vaquinhas.length ? (
        <EmptyState
          icon={<HandCoins className="size-6" />}
          title="Nenhuma vaquinha ainda"
          description={auth.isAdmin ? "Crie a primeira para juntar dinheiro para um acampamento, uniforme ou evento." : "Quando o diretor criar uma vaquinha, ela aparece aqui."}
          action={auth.isAdmin && <Button onClick={() => setEditar("nova")}>Criar vaquinha</Button>}
        />
      ) : (
        <div className="space-y-8">
          {abertas.length > 0 ? <div className="grid gap-4 md:grid-cols-2">{abertas.map(cartao)}</div> : <p className="text-sm text-ink-500">Nenhuma vaquinha aberta agora.</p>}
          {encerradas.length > 0 && (
            <section>
              <h2 className="mb-3 font-display text-xl font-semibold uppercase tracking-wide text-ink-500">Encerradas</h2>
              <div className="grid gap-4 md:grid-cols-2">{encerradas.map(cartao)}</div>
            </section>
          )}
        </div>
      )}
      {sel && data && (
        <DetalheVaquinha
          v={sel}
          entradas={data.entradas.filter((e) => e.vaquinha_id === sel.id)}
          membros={data.membros}
          onClose={() => setAberta(null)}
          onEditar={() => setEditar(sel)}
          onMudou={() => reload(true)}
        />
      )}
      <EditarVaquinha
        alvo={editar}
        temEntradas={!!(editar && editar !== "nova" && total.get(editar.id)?.n)}
        onClose={() => setEditar(null)}
        onSalvo={(id) => {
          setEditar(null);
          if (id) setAberta(id);
          reload(true);
        }}
        onExcluida={() => {
          setEditar(null);
          setAberta(null);
          reload(true);
        }}
      />
    </div>
  );
}

function Progresso({ v, soma, n, grande }: { v: Vaquinha; soma: number; n: number; grande?: boolean }) {
  const pct = v.meta > 0 ? (soma / Number(v.meta)) * 100 : 0;
  const falta = Math.max(0, Number(v.meta) - soma);
  return (
    <div>
      <div className="flex items-end justify-between gap-3">
        <div>
          <div className={cn("font-display font-semibold tracking-wide text-ink-900", grande ? "text-4xl" : "text-3xl")}>{reais(soma)}</div>
          <div className="text-sm text-ink-500">de {reais(Number(v.meta))}</div>
        </div>
        <div className={cn("font-display font-semibold", grande ? "text-4xl" : "text-3xl", pct >= 100 ? "text-emerald-600" : "text-tiger-600")}>{Math.floor(pct)}%</div>
      </div>
      <div className="mt-2.5">
        <ProgressBar value={pct} color={pct >= 100 ? "#059669" : undefined} />
      </div>
      <div className="mt-2 flex flex-wrap justify-between gap-x-3 text-xs text-ink-500">
        <span>{plural(n, "contribuição", "contribuições")}</span>
        <span>{pct >= 100 ? "Meta alcançada!" : `Faltam ${reais(falta)}`}</span>
      </div>
    </div>
  );
}

function Prazo({ v }: { v: Vaquinha }) {
  if (v.encerrada) return <Badge>Encerrada</Badge>;
  if (!v.prazo) return null;
  const passou = v.prazo < hojeIso();
  return (
    <Badge tone={passou ? "red" : "neutral"} className="shrink-0 whitespace-nowrap">
      <CalendarClock className="size-3" /> {passou ? "Prazo acabou em" : "Até"} {isoToBr(v.prazo)}
    </Badge>
  );
}

function CartaoVaquinha({ v, soma, n, onAbrir }: { v: Vaquinha; soma: number; n: number; onAbrir: () => void }) {
  return (
    <Card className={cn("flex min-w-0 flex-col p-5", v.encerrada && "opacity-80")}>
      <div className="flex items-start justify-between gap-3">
        <button onClick={onAbrir} className="min-w-0 text-left">
          <h2 className="font-display text-2xl font-semibold uppercase leading-tight tracking-wide hover:text-tiger-700">{v.titulo}</h2>
        </button>
        <Prazo v={v} />
      </div>
      {v.descricao && <p className="mt-1 line-clamp-2 text-sm text-ink-600">{v.descricao}</p>}
      <div className="mt-4">
        <Progresso v={v} soma={soma} n={n} />
      </div>
      {!v.encerrada && v.pix_chave && <PixBox className="mt-4" chave={v.pix_chave} nome={v.pix_nome} cidade={v.pix_cidade} descricao={v.titulo} />}
      <div className="mt-auto pt-4">
        <Button variant="secondary" size="sm" className="w-full" onClick={onAbrir}>
          Ver contribuições
        </Button>
      </div>
    </Card>
  );
}

function DetalheVaquinha({
  v,
  entradas,
  membros,
  onClose,
  onEditar,
  onMudou,
}: {
  v: Vaquinha;
  entradas: VaquinhaEntrada[];
  membros: Profile[];
  onClose: () => void;
  onEditar: () => void;
  onMudou: () => void;
}) {
  const auth = useAuth();
  const [valor, setValor] = useState("");
  const [nome, setNome] = useState("");
  const [data, setData] = useState(hojeIso());
  const [erro, setErro] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [apagar, setApagar] = useState<VaquinhaEntrada | null>(null);
  const soma = entradas.reduce((s, e) => s + Number(e.valor), 0);
  const quem = (id: string | null) => membros.find((m) => m.id === id)?.nome?.split(" ").slice(0, 2).join(" ");

  async function registrar() {
    const n = lerValor(valor);
    if (!n) return setErro("Digite o valor, por exemplo 50 ou 25,90.");
    setBusy(true);
    const { error } = await supabaseBrowser().from("vaquinha_entradas").insert({ vaquinha_id: v.id, valor: n, nome: nome.trim() || null, data: data || hojeIso() });
    setBusy(false);
    if (error) return toast.error(error.message);
    toast.success(`${reais(n)} registrado.`);
    setValor("");
    setNome("");
    onMudou();
  }

  async function confirmarApagar() {
    if (!apagar) return;
    setBusy(true);
    const { error } = await supabaseBrowser().from("vaquinha_entradas").delete().eq("id", apagar.id);
    setBusy(false);
    if (error) return toast.error(error.message);
    setApagar(null);
    toast.success("Entrada apagada.");
    onMudou();
  }

  async function alternar() {
    setBusy(true);
    const { error } = await supabaseBrowser().from("vaquinhas").update({ encerrada: !v.encerrada }).eq("id", v.id);
    setBusy(false);
    if (error) return toast.error(error.message);
    toast.success(v.encerrada ? "Vaquinha reaberta." : "Vaquinha encerrada.");
    onMudou();
  }

  return (
    <Sheet
      open
      onClose={onClose}
      wide
      title={v.titulo}
      description={v.prazo ? `Prazo: ${isoToBr(v.prazo)}` : undefined}
      footer={
        auth.isAdmin ? (
          <>
            <Button variant="secondary" icon={v.encerrada ? <Unlock className="size-4" /> : <Lock className="size-4" />} loading={busy} onClick={alternar}>
              {v.encerrada ? "Reabrir" : "Encerrar"}
            </Button>
            <Button variant="secondary" icon={<Pencil className="size-4" />} onClick={onEditar}>
              Editar
            </Button>
          </>
        ) : undefined
      }
    >
      <div className="space-y-6">
        {v.descricao && <p className="whitespace-pre-line text-[15px] text-ink-700">{v.descricao}</p>}
        <Progresso v={v} soma={soma} n={entradas.length} grande />
        {!v.encerrada && v.pix_chave && <PixBox chave={v.pix_chave} nome={v.pix_nome} cidade={v.pix_cidade} descricao={v.titulo} />}

        {auth.podeFinanceiro && (
          <section className="rounded-2xl border border-ink-200 p-4">
            <h3 className="mb-3 font-semibold text-ink-900">Registrar o que entrou</h3>
            <div className="grid gap-3 sm:grid-cols-[1fr_1.4fr_1fr]">
              <Input label="Valor (R$)" inputMode="decimal" value={valor} error={erro} onChange={(e) => (setValor(e.target.value), setErro(null))} placeholder="50,00" />
              <Input label="De quem (opcional)" value={nome} onChange={(e) => setNome(e.target.value)} placeholder="Ex.: Família da Bia" maxLength={80} />
              <Input label="Data" type="date" value={data} max={hojeIso()} onChange={(e) => setData(e.target.value)} />
            </div>
            <Button className="mt-3 w-full sm:w-auto" icon={<Plus className="size-4" />} loading={busy} onClick={registrar}>
              Registrar entrada
            </Button>
          </section>
        )}

        <section>
          <h3 className="mb-2 text-sm font-semibold uppercase tracking-wide text-ink-500">Contribuições ({entradas.length})</h3>
          {entradas.length ? (
            <ul className="divide-y divide-ink-100 rounded-2xl border border-ink-200">
              {entradas.map((e) => (
                <li key={e.id} className="flex items-center gap-3 px-3 py-2.5">
                  <div className="min-w-0 flex-1">
                    <div className="truncate text-sm font-medium text-ink-900">{e.nome || "Sem nome"}</div>
                    <div className="text-xs text-ink-500">
                      {isoToBr(e.data)}
                      {quem(e.registrado_por) && ` · registrado por ${quem(e.registrado_por)}`}
                    </div>
                  </div>
                  <span className="shrink-0 font-semibold tabular-nums text-emerald-700">{reais(Number(e.valor))}</span>
                  {auth.podeFinanceiro && (
                    <Button size="sm" variant="ghost" aria-label={`Apagar ${reais(Number(e.valor))} de ${e.nome || "sem nome"}`} onClick={() => setApagar(e)}>
                      <Trash2 className="size-4" />
                    </Button>
                  )}
                </li>
              ))}
            </ul>
          ) : (
            <p className="text-sm text-ink-500">{auth.podeFinanceiro ? "Quando um Pix cair, registre aqui para a barra andar." : "Nenhuma contribuição registrada ainda."}</p>
          )}
        </section>
      </div>
      <Confirm
        open={!!apagar}
        danger
        title="Apagar esta entrada?"
        message={apagar ? `${reais(Number(apagar.valor))}${apagar.nome ? ` de ${apagar.nome}` : ""} sai do total da vaquinha.` : ""}
        confirmLabel="Apagar entrada"
        loading={busy}
        onConfirm={confirmarApagar}
        onClose={() => setApagar(null)}
      />
    </Sheet>
  );
}

function EditarVaquinha({
  alvo,
  temEntradas,
  onClose,
  onSalvo,
  onExcluida,
}: {
  alvo: Vaquinha | "nova" | null;
  temEntradas: boolean;
  onClose: () => void;
  onSalvo: (id: string | null) => void;
  onExcluida: () => void;
}) {
  const v = alvo && alvo !== "nova" ? alvo : null;
  const [aberto, setAberto] = useState<typeof alvo>(null);
  const [titulo, setTitulo] = useState("");
  const [descricao, setDescricao] = useState("");
  const [meta, setMeta] = useState("");
  const [prazo, setPrazo] = useState("");
  const [chave, setChave] = useState("");
  const [pixNome, setPixNome] = useState("");
  const [pixCidade, setPixCidade] = useState("");
  const [erros, setErros] = useState<Record<string, string>>({});
  const [busy, setBusy] = useState(false);
  const [excluir, setExcluir] = useState(false);
  if (alvo !== aberto) {
    setAberto(alvo);
    setTitulo(v?.titulo || "");
    setDescricao(v?.descricao || "");
    setMeta(v ? String(v.meta).replace(".", ",") : "");
    setPrazo(v?.prazo || "");
    setChave(v?.pix_chave || "");
    setPixNome(v?.pix_nome || "Clube Tigres do Riacho");
    setPixCidade(v?.pix_cidade || "");
    setErros({});
  }
  const tipo = tipoDaChave(chave);

  async function salvar() {
    const e: Record<string, string> = {};
    const m = lerValor(meta);
    if (!titulo.trim()) e.titulo = "Dê um nome para a vaquinha.";
    if (!m) e.meta = "Digite a meta em reais, por exemplo 1500.";
    if (chave.trim() && tipo === "invalida") e.chave = "Não reconheci esta chave. Use CPF, CNPJ, celular, e-mail, chave aleatória ou cole o Pix copia e cola.";
    setErros(e);
    if (Object.keys(e).length) return;
    setBusy(true);
    const campos = {
      titulo: titulo.trim(),
      descricao: descricao.trim() || null,
      meta: m,
      prazo: prazo || null,
      pix_chave: chave.trim() || null,
      pix_nome: pixNome.trim() || null,
      pix_cidade: pixCidade.trim() || null,
    };
    const sb = supabaseBrowser();
    const r = v ? await sb.from("vaquinhas").update(campos).eq("id", v.id).select("id").single() : await sb.from("vaquinhas").insert(campos).select("id").single();
    setBusy(false);
    if (r.error) return toast.error(r.error.message);
    toast.success(v ? "Vaquinha atualizada." : "Vaquinha criada.");
    onSalvo(v ? null : (r.data?.id as string));
  }

  async function apagar() {
    if (!v) return;
    setBusy(true);
    const { error } = await supabaseBrowser().from("vaquinhas").delete().eq("id", v.id);
    setBusy(false);
    if (error) return toast.error(error.message);
    setExcluir(false);
    toast.success("Vaquinha excluída.");
    onExcluida();
  }

  return (
    <>
      <Sheet
        open={!!alvo}
        onClose={onClose}
        title={v ? "Editar vaquinha" : "Nova vaquinha"}
        footer={
          <>
            {v && (
              <Button variant="ghost" className="mr-auto text-red-600 hover:bg-red-50" icon={<Trash2 className="size-4" />} onClick={() => setExcluir(true)}>
                Excluir
              </Button>
            )}
            <Button variant="secondary" onClick={onClose}>
              Cancelar
            </Button>
            <Button loading={busy} onClick={salvar}>
              {v ? "Salvar alterações" : "Criar vaquinha"}
            </Button>
          </>
        }
      >
        <div className="space-y-4">
          <Input label="Nome" required value={titulo} error={erros.titulo} onChange={(e) => setTitulo(e.target.value)} placeholder="Ex.: Acampamento de março" maxLength={80} />
          <Textarea label="Para que é (opcional)" value={descricao} onChange={(e) => setDescricao(e.target.value)} maxLength={600} />
          <div className="grid grid-cols-2 gap-4">
            <Input label="Meta (R$)" required inputMode="decimal" value={meta} error={erros.meta} onChange={(e) => setMeta(e.target.value)} placeholder="1.500,00" />
            <Input label="Prazo (opcional)" type="date" value={prazo} onChange={(e) => setPrazo(e.target.value)} />
          </div>
          <div className="space-y-4 rounded-2xl border border-ink-200 p-4">
            <h3 className="font-semibold text-ink-900">Pix para contribuir</h3>
            <Input
              label="Chave Pix ou Pix copia e cola"
              value={chave}
              error={erros.chave}
              onChange={(e) => setChave(e.target.value)}
              hint={chave.trim() ? (tipo === "invalida" ? "Chave não reconhecida." : `Reconhecida como: ${NOME_TIPO_CHAVE[tipo]}.`) : "Com a chave, o app gera o QR Code e o copia e cola."}
            />
            {tipo !== "copiaecola" && (
              <div className="grid grid-cols-2 gap-4">
                <Input label="Nome de quem recebe" value={pixNome} onChange={(e) => setPixNome(e.target.value)} maxLength={60} />
                <Input label="Cidade" value={pixCidade} onChange={(e) => setPixCidade(e.target.value)} maxLength={40} />
              </div>
            )}
          </div>
        </div>
      </Sheet>
      <Confirm
        open={excluir}
        danger
        title={`Excluir "${v?.titulo}"?`}
        message={temEntradas ? "A vaquinha e todas as contribuições registradas nela serão apagadas de vez. Se quiser só parar de receber, use Encerrar." : "A vaquinha será apagada de vez."}
        confirmLabel="Excluir vaquinha"
        loading={busy}
        onConfirm={apagar}
        onClose={() => setExcluir(false)}
      />
    </>
  );
}
