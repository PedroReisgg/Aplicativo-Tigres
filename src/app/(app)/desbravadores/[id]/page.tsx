"use client";

import Link from "next/link";
import { useParams, useRouter } from "next/navigation";
import { useMemo, useState } from "react";
import { ArrowLeft, Award, Check, Clock, Paperclip, Pencil, Plus, RotateCcw, Trash2, UserX } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Avatar, Badge, Button, Card, Confirm, EmptyState, ProgressBar, SearchInput, Sheet, Skeleton, Textarea } from "@/components/ui";
import { AnexosLista, AnexosPicker } from "@/components/anexos";
import { DesbravadorSheet, EspIcon, PhoneLink } from "@/components/domain";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData } from "@/lib/use-data";
import { adminIds, getCaderno, getClassEsp, getDesbEsp, getDesbravador, getEspecialidades, getMembros, getProgresso, notificar, staffIdsDaClasse } from "@/lib/api";
import { enviarArquivos, getAnexos, vincularAnexos } from "@/lib/anexos";
import { validacaoCaderno } from "@/lib/lancamentos";
import { isoToBr, normalize, timeAgo } from "@/lib/format";
import type { Anexo, DesbEsp, Desbravador, Especialidade, RegistroAtividade } from "@/lib/types";

export default function DesbravadorPage() {
  const { id } = useParams<{ id: string }>();
  const router = useRouter();
  const auth = useAuth();
  const sb = supabaseBrowser();
  const [editar, setEditar] = useState(false);
  const [addEsp, setAddEsp] = useState(false);
  const [detalhe, setDetalhe] = useState<string | null>(null);
  const [excluir, setExcluir] = useState(false);

  const { data, loading, reload } = useData(async () => {
    const d = await getDesbravador(id);
    if (!d) return null;
    const [itens, prog, esps, todas, classEsp, anexos, membros] = await Promise.all([
      d.class_id ? getCaderno(d.class_id) : Promise.resolve([]),
      getProgresso([d.id]),
      getDesbEsp([d.id]),
      getEspecialidades(),
      d.class_id ? getClassEsp(d.class_id) : Promise.resolve([]),
      getAnexos({ desbIds: [d.id] }),
      getMembros().catch(() => []),
    ]);
    return { d, itens, prog, esps, todas, classEsp, anexos, nomes: new Map(membros.map((m) => [m.id, m.nome])) };
  }, [id]);

  const espMap = useMemo(() => new Map((data?.todas || []).map((e) => [e.codigo, e])), [data?.todas]);

  if (loading)
    return (
      <div className="space-y-4">
        <Skeleton className="h-40" />
        <Skeleton className="h-64" />
      </div>
    );
  if (!data)
    return <EmptyState title="Desbravador não encontrado" description="Talvez você não tenha acesso a esta classe." action={<Button onClick={() => router.push("/desbravadores")}>Voltar</Button>} />;

  const { d, itens, prog, esps, classEsp } = data;
  const pode = auth.canManageClass(d.class_id);
  // instrutor da classe ou conselheiro da unidade lançam especialidades
  const podeEsp = auth.canRegistrarEsp(d);
  // o conselheiro da unidade também atualiza os dados do desbravador
  const podeEditar = pode || (!!d.unidade_id && auth.isActive && auth.unidadeIds.includes(d.unidade_id));
  const base = itens.filter((i) => !i.avancada);
  const feito = (itemId: number) => prog.find((p) => p.item_id === itemId);
  const pctBase = base.length ? (base.filter((i) => feito(i.id)?.status === "feito").length / base.length) * 100 : 0;
  const obrig = classEsp.map((c) => c.especialidade_codigo);
  const concluidas = esps.filter((e) => e.status === "concluida");

  async function toggleItem(itemId: number) {
    const atual = feito(itemId);
    if (atual && atual.validacao === "aprovada" && atual.status === "feito" && !auth.isAdmin) return toast.info("Este item já foi aprovado pelo diretor. Só ele pode desmarcar.");
    const r = atual
      ? await sb.from("caderno_progresso").delete().eq("desbravador_id", d.id).eq("item_id", itemId)
      : await sb
          .from("caderno_progresso")
          .upsert({
            desbravador_id: d.id,
            item_id: itemId,
            status: "feito",
            observacao: null,
            marcado_por: auth.userId,
            marcado_em: new Date().toISOString(),
            ...validacaoCaderno(auth.isAdmin, "feito", auth.userId),
          });
    if (r.error) return toast.error(r.error.message);
    reload(true);
  }

  return (
    <div>
      <Link
        href={d.classe_slug ? `/classes/${d.classe_slug}?aba=desbravadores` : "/desbravadores"}
        className="mb-4 inline-flex items-center gap-1.5 text-sm font-medium text-ink-500 hover:text-ink-800"
      >
        <ArrowLeft className="size-4" /> {d.classe_nome ? `Classe de ${d.classe_nome}` : "Desbravadores"}
      </Link>

      <Card className="relative mb-6 overflow-hidden p-5 sm:p-7">
        <span className="absolute inset-x-0 top-0 h-1.5" style={{ background: d.classe_cor || "#F26B1D" }} />
        <div className="flex flex-col gap-5 sm:flex-row sm:items-center">
          <Avatar nome={d.nome} color={d.classe_cor} size={72} />
          <div className="min-w-0 flex-1">
            <h1 className="font-display text-3xl font-semibold uppercase leading-tight tracking-wide">{d.nome}</h1>
            <div className="mt-1 flex flex-wrap gap-x-4 gap-y-1 text-sm text-ink-500">
              <span>{d.classe_nome ? `Classe de ${d.classe_nome}` : "Sem classe"}</span>
              {d.idade != null && <span>{d.idade} anos</span>}
              {d.unidade && <span>{/^unidade\b/i.test(d.unidade) ? d.unidade : `Unidade ${d.unidade}`}</span>}
              {!d.ativo && <Badge tone="red">Inativo</Badge>}
            </div>
          </div>
          {podeEditar && (
            <div className="flex gap-2">
              <Button variant="secondary" icon={<Pencil className="size-4" />} onClick={() => setEditar(true)}>
                Editar
              </Button>
              {auth.isAdmin && (
                <Button variant="ghost" aria-label="Excluir ou desativar" onClick={() => setExcluir(true)}>
                  <Trash2 className="size-4 text-red-600" />
                </Button>
              )}
            </div>
          )}
        </div>
        <div className="mt-6 grid gap-4 border-t border-ink-100 pt-5 text-sm sm:grid-cols-2 lg:grid-cols-3">
          <Info label="Mãe" value={d.nome_mae} />
          <Info label="Pai" value={d.nome_pai} />
          <div>
            <div className="text-xs font-semibold uppercase tracking-wide text-ink-400">Telefone dos pais</div>
            <div className="mt-1">
              <PhoneLink phone={d.telefone_responsavel} />
            </div>
          </div>
          <Info label="Nascimento" value={isoToBr(d.data_nascimento)} />
          <div>
            <div className="text-xs font-semibold uppercase tracking-wide text-ink-400">Telefone do desbravador</div>
            <div className="mt-1">
              <PhoneLink phone={d.telefone} />
            </div>
          </div>
          <Info label="E-mail" value={d.email} />
          {d.cpf && <Info label="CPF" value={d.cpf} />}
          {d.endereco && <Info label="Endereço" value={d.endereco} />}
          {d.observacoes && (
            <div className="sm:col-span-2 lg:col-span-3">
              <div className="text-xs font-semibold uppercase tracking-wide text-ink-400">Observações</div>
              <p className="mt-1 whitespace-pre-line rounded-xl bg-amber-50 p-3 text-amber-900">{d.observacoes}</p>
            </div>
          )}
        </div>
      </Card>

      <div className="grid gap-6 lg:grid-cols-2">
        {/* Caderno */}
        <section>
          <div className="mb-3 flex items-end justify-between">
            <h2 className="font-display text-xl font-semibold uppercase tracking-wide">Caderno</h2>
            <span className="text-sm text-ink-500">{Math.round(pctBase)}% da classe regular</span>
          </div>
          <Card className="p-4">
            <ProgressBar value={pctBase} color={d.classe_cor || undefined} />
            <ul className="mt-4 divide-y divide-ink-100">
              {itens.map((it) => {
                const p = feito(it.id);
                return (
                  <li key={it.id} className="flex gap-3 py-2.5">
                    <button
                      disabled={!pode}
                      onClick={() => toggleItem(it.id)}
                      className={`mt-0.5 grid size-6 shrink-0 place-items-center rounded-md border-2 ${p?.status === "feito" ? "border-tiger-500 bg-tiger-500 text-white" : p?.status === "refazer" ? "border-red-500 bg-red-50 text-red-600" : "border-ink-300 bg-white"} disabled:cursor-default`}
                      aria-label={p ? `Desmarcar ${it.codigo}` : `Marcar ${it.codigo} como feito`}
                    >
                      {p?.status === "feito" ? <Check className="size-3.5" strokeWidth={3} /> : p?.status === "refazer" ? <RotateCcw className="size-3" /> : null}
                    </button>
                    <div className="min-w-0 text-sm">
                      <span className="mr-1.5 font-mono text-xs font-semibold text-ink-400">{it.codigo}</span>
                      <span className={p?.status === "feito" ? "text-ink-500" : "text-ink-800"}>{it.texto}</span>
                      {p?.status === "refazer" && p.observacao && <p className="mt-1 rounded-lg bg-red-50 px-2 py-1 text-xs text-red-700">Refazer: {p.observacao}</p>}
                      {p?.status === "feito" && p.validacao === "pendente" && (
                        <span className="ml-1.5 inline-flex items-center gap-1 rounded-full bg-amber-50 px-1.5 py-px text-[11px] font-semibold text-amber-700">
                          <Clock className="size-3" /> aguardando o diretor
                        </span>
                      )}
                    </div>
                  </li>
                );
              })}
              {!itens.length && <li className="py-6 text-center text-sm text-ink-500">Sem classe definida.</li>}
            </ul>
          </Card>
        </section>

        {/* Especialidades */}
        <section>
          <div className="mb-3 flex items-end justify-between">
            <h2 className="font-display text-xl font-semibold uppercase tracking-wide">Especialidades</h2>
            {podeEsp && (
              <Button size="sm" icon={<Plus className="size-4" />} onClick={() => setAddEsp(true)}>
                Registrar
              </Button>
            )}
          </div>
          {obrig.length > 0 && (
            <Card className="mb-3 p-4">
              <div className="mb-2 text-sm font-semibold text-ink-700">
                Da classe ({obrig.filter((c) => concluidas.some((e) => e.especialidade_codigo === c)).length}/{obrig.length})
              </div>
              <div className="flex flex-wrap gap-2">
                {obrig.map((c) => {
                  const e = espMap.get(c);
                  const ok = concluidas.some((x) => x.especialidade_codigo === c);
                  return e ? (
                    <Link
                      key={c}
                      href={`/especialidades/e/${c}`}
                      className={`inline-flex items-center gap-1.5 rounded-full border py-0.5 pl-0.5 pr-2.5 text-xs font-medium ${ok ? "border-emerald-200 bg-emerald-50 text-emerald-800" : "border-ink-200 bg-white text-ink-500"}`}
                    >
                      <EspIcon esp={e} size={22} className={ok ? "" : "opacity-50 grayscale"} />
                      {e.nome}
                      {ok && <Check className="size-3" />}
                    </Link>
                  ) : null;
                })}
              </div>
            </Card>
          )}
          {!esps.length ? (
            <EmptyState
              icon={<Award className="size-6" />}
              title="Nenhuma especialidade registrada"
              description={podeEsp ? "Registre as especialidades que este desbravador concluiu, com o comprovante." : undefined}
            />
          ) : (
            <div className="grid grid-cols-2 gap-2 sm:grid-cols-3">
              {esps.map((x) => {
                const e = espMap.get(x.especialidade_codigo);
                if (!e) return null;
                const nAnexos = data.anexos.filter((a) => a.especialidade_codigo === x.especialidade_codigo).length;
                return (
                  <button key={x.especialidade_codigo} onClick={() => setDetalhe(x.especialidade_codigo)} className="text-left">
                    <Card className="flex h-full flex-col items-center p-3 text-center transition-shadow hover:shadow-lift">
                      <EspIcon esp={e} size={56} />
                      <div className="mt-2 line-clamp-2 text-xs font-semibold leading-snug">{e.nome}</div>
                      <div className="mt-1 flex flex-wrap items-center justify-center gap-1 text-[11px] text-ink-400">
                        {x.status === "refazer" ? (
                          <span className="font-semibold text-red-600">Refazer</span>
                        ) : x.validacao === "pendente" ? (
                          <span className="inline-flex items-center gap-1 font-semibold text-amber-700">
                            <Clock className="size-3" /> Aguardando
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 text-emerald-700">
                            <Check className="size-3" /> {isoToBr(x.concluida_em)}
                          </span>
                        )}
                        {nAnexos > 0 && (
                          <span className="inline-flex items-center gap-0.5" title={`${nAnexos} comprovante(s)`}>
                            <Paperclip className="size-3" />
                            {nAnexos}
                          </span>
                        )}
                      </div>
                    </Card>
                  </button>
                );
              })}
            </div>
          )}
        </section>
      </div>

      <DesbravadorSheet open={editar} onClose={() => setEditar(false)} desbravador={d} onSaved={() => reload(true)} />
      <RegistrarEspSheet
        open={addEsp}
        onClose={() => setAddEsp(false)}
        todas={data.todas}
        ja={new Map(esps.map((e) => [e.especialidade_codigo, e]))}
        obrig={obrig}
        desbravador={d}
        onSaved={() => reload(true)}
      />
      <EspDetalheSheet
        codigo={detalhe}
        onClose={() => setDetalhe(null)}
        desbravador={d}
        registro={esps.find((e) => e.especialidade_codigo === detalhe) || null}
        esp={detalhe ? espMap.get(detalhe) || null : null}
        anexos={data.anexos.filter((a) => a.especialidade_codigo === detalhe)}
        nomes={data.nomes}
        podeEsp={podeEsp}
        onSaved={() => reload(true)}
      />
      <ExcluirDialog
        open={excluir}
        nome={d.nome}
        ativo={d.ativo}
        onClose={() => setExcluir(false)}
        onDesativar={async () => {
          const { error } = await sb.from("desbravadores").update({ ativo: !d.ativo }).eq("id", d.id);
          if (error) return toast.error(error.message);
          toast.success(d.ativo ? "Desbravador desativado." : "Desbravador reativado.");
          setExcluir(false);
          reload(true);
        }}
        onExcluir={async () => {
          const { error } = await sb.from("desbravadores").delete().eq("id", d.id);
          if (error) return toast.error(error.message);
          toast.success("Cadastro excluído.");
          router.push("/desbravadores");
        }}
      />
    </div>
  );
}

function Info({ label, value }: { label: string; value?: string | null }) {
  return (
    <div className="min-w-0">
      <div className="text-xs font-semibold uppercase tracking-wide text-ink-400">{label}</div>
      <div className="mt-1 break-words text-ink-800">{value || "—"}</div>
    </div>
  );
}

/** Escolhe a especialidade concluída e anexa o comprovante. */
function RegistrarEspSheet({
  open,
  onClose,
  todas,
  ja,
  obrig,
  desbravador,
  onSaved,
}: {
  open: boolean;
  onClose: () => void;
  todas: Especialidade[];
  ja: Map<string, DesbEsp>;
  obrig: string[];
  desbravador: Desbravador;
  onSaved: () => void;
}) {
  const auth = useAuth();
  const sb = supabaseBrowser();
  const [q, setQ] = useState("");
  const [esp, setEsp] = useState<Especialidade | null>(null);
  const [files, setFiles] = useState<File[]>([]);
  const [saving, setSaving] = useState(false);
  const [tentou, setTentou] = useState(false);
  const fechar = () => {
    setEsp(null);
    setFiles([]);
    setQ("");
    setTentou(false);
    onClose();
  };
  const res = useMemo(() => {
    const n = normalize(q);
    const base = n ? todas.filter((e) => normalize(e.nome).includes(n) || e.codigo.toLowerCase().includes(n)) : todas.filter((e) => obrig.includes(e.codigo));
    return base.slice(0, 60);
  }, [q, todas, obrig]);
  const faltaAnexo = !auth.isAdmin && !files.length;

  async function salvar() {
    if (!esp) return;
    setTentou(true);
    if (faltaAnexo) return;
    setSaving(true);
    try {
      const arquivos = files.length ? await enviarArquivos(files, auth.userId!) : [];
      const agora = new Date().toISOString();
      const { error } = await sb.from("desbravador_especialidades").upsert({
        desbravador_id: desbravador.id,
        especialidade_codigo: esp.codigo,
        status: "concluida",
        observacao: null,
        registrado_por: auth.userId,
        concluida_em: agora.slice(0, 10),
        ...(auth.isAdmin ? { validacao: "aprovada", validado_por: auth.userId, validado_em: agora } : {}),
      });
      if (error) throw new Error(error.message);
      await vincularAnexos(arquivos, [desbravador.id], esp.codigo, auth.userId!);
      if (!auth.isAdmin) {
        notificar(auth.userId!, await adminIds(), {
          tipo: "validacao",
          titulo: `Especialidade para validar: ${esp.nome}`,
          mensagem: `${desbravador.nome}. ${arquivos.length} comprovante(s) anexado(s).`,
          link: "/diretoria?aba=validacoes",
        }).catch(() => {});
      }
      toast.success(auth.isAdmin ? `${esp.nome} registrada para ${desbravador.nome.split(" ")[0]}.` : `${esp.nome} enviada para a validação do diretor.`);
      onSaved();
      fechar();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setSaving(false);
    }
  }

  return (
    <Sheet
      open={open}
      onClose={fechar}
      title={esp ? esp.nome : "Registrar especialidade"}
      description={esp ? `Para ${desbravador.nome}` : "Busque a especialidade concluída."}
      footer={
        esp && (
          <>
            <Button variant="secondary" onClick={() => setEsp(null)}>
              Voltar
            </Button>
            <Button onClick={salvar} loading={saving} icon={<Check className="size-4" />}>
              {auth.isAdmin ? "Registrar" : "Enviar para validação"}
            </Button>
          </>
        )
      }
    >
      {esp ? (
        <div className="space-y-4">
          <div className="flex items-center gap-3 rounded-2xl bg-ink-50 p-3">
            <EspIcon esp={esp} size={48} />
            <div className="min-w-0 text-sm">
              <div className="font-semibold">{esp.nome}</div>
              <div className="text-ink-500">{auth.isAdmin ? "Você é da diretoria: o registro já sai aprovado." : "O diretor confere o comprovante e valida."}</div>
            </div>
          </div>
          <AnexosPicker files={files} onChange={setFiles} obrigatorio={!auth.isAdmin} erro={tentou && faltaAnexo ? "Anexe pelo menos um comprovante para enviar." : null} />
        </div>
      ) : (
        <div className="space-y-3">
          <SearchInput value={q} onChange={setQ} placeholder="Nome da especialidade…" />
          {!q && <p className="text-xs font-semibold uppercase tracking-wide text-ink-400">Especialidades da classe</p>}
          <ul className="divide-y divide-ink-100">
            {res.map((e) => {
              const r = ja.get(e.codigo);
              return (
                <li key={e.codigo} className="flex items-center gap-3 py-2.5">
                  <EspIcon esp={e} size={40} />
                  <div className="min-w-0 flex-1 truncate text-sm font-semibold">{e.nome}</div>
                  {r && r.status === "concluida" ? (
                    <Badge tone={r.validacao === "pendente" ? "amber" : "green"}>
                      {r.validacao === "pendente" ? <Clock className="size-3" /> : <Check className="size-3" />} {r.validacao === "pendente" ? "Aguardando" : "Registrada"}
                    </Badge>
                  ) : (
                    <Button size="sm" variant="secondary" onClick={() => setEsp(e)}>
                      {r ? "Registrar de novo" : "Concluiu"}
                    </Button>
                  )}
                </li>
              );
            })}
            {!res.length && <li className="py-6 text-center text-sm text-ink-500">Nenhuma especialidade encontrada.</li>}
          </ul>
        </div>
      )}
    </Sheet>
  );
}

const ACAO_TEXTO: Record<RegistroAtividade["acao"], string> = {
  registrou: "registrou",
  aprovou: "aprovou",
  devolveu: "devolveu para refazer",
  removeu: "removeu",
  anexou: "anexou",
  marcou: "marcou",
  desmarcou: "desmarcou",
};

/** Detalhes de uma especialidade do desbravador: comprovantes, validação e histórico. */
function EspDetalheSheet({
  codigo,
  onClose,
  desbravador,
  registro,
  esp,
  anexos,
  nomes,
  podeEsp,
  onSaved,
}: {
  codigo: string | null;
  onClose: () => void;
  desbravador: Desbravador;
  registro: DesbEsp | null;
  esp: Especialidade | null;
  anexos: Anexo[];
  nomes: Map<string, string>;
  podeEsp: boolean;
  onSaved: () => void;
}) {
  const auth = useAuth();
  const sb = supabaseBrowser();
  const [files, setFiles] = useState<File[]>([]);
  const [enviando, setEnviando] = useState(false);
  const [devolver, setDevolver] = useState(false);
  const [msg, setMsg] = useState("");
  const [acao, setAcao] = useState<string | null>(null);
  const [remover, setRemover] = useState(false);
  const { data: historico } = useData(
    async () =>
      auth.isAdmin && codigo
        ? (((await sb.from("registro_atividades").select("*").eq("desbravador_id", desbravador.id).eq("alvo", codigo).order("created_at", { ascending: false }).limit(30)).data ||
            []) as RegistroAtividade[])
        : [],
    [codigo, auth.isAdmin, anexos.length, registro?.validacao, registro?.status],
  );
  if (!codigo || !esp || !registro) return null;
  const pendente = registro.status === "concluida" && registro.validacao === "pendente";
  const podeRemover = auth.isAdmin || (podeEsp && registro.validacao !== "aprovada");
  const fechar = () => {
    setFiles([]);
    setDevolver(false);
    setMsg("");
    onClose();
  };

  async function anexar() {
    setEnviando(true);
    try {
      const arqs = await enviarArquivos(files, auth.userId!);
      await vincularAnexos(arqs, [desbravador.id], esp!.codigo, auth.userId!);
      toast.success("Comprovante anexado.");
      setFiles([]);
      onSaved();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setEnviando(false);
    }
  }

  async function validar(aprovar: boolean) {
    setAcao(aprovar ? "aprovar" : "devolver");
    const agora = new Date().toISOString();
    const { error } = await sb
      .from("desbravador_especialidades")
      .update(
        aprovar
          ? { validacao: "aprovada", validado_por: auth.userId, validado_em: agora }
          : { status: "refazer", observacao: msg.trim(), validacao: "pendente", validado_por: null, validado_em: null },
      )
      .eq("desbravador_id", desbravador.id)
      .eq("especialidade_codigo", esp!.codigo);
    setAcao(null);
    if (error) return toast.error(error.message);
    try {
      const destino = [registro!.registrado_por || "", ...(aprovar || !desbravador.class_id ? [] : await staffIdsDaClasse(desbravador.class_id))];
      await notificar(auth.userId!, destino, {
        tipo: aprovar ? "validacao" : "refazer",
        titulo: aprovar ? `Especialidade validada: ${esp!.nome}` : `Refazer especialidade: ${esp!.nome}`,
        mensagem: aprovar ? `${desbravador.nome} teve a especialidade validada pelo diretor.` : `${desbravador.nome}: ${msg.trim()}`,
        link: `/desbravadores/${desbravador.id}`,
      });
    } catch {}
    toast.success(aprovar ? "Especialidade validada." : "Devolvida para refazer.");
    setDevolver(false);
    setMsg("");
    onSaved();
  }

  return (
    <>
      <Sheet
        open
        onClose={fechar}
        title={esp.nome}
        description={desbravador.nome}
        wide
        footer={
          <>
            {podeRemover && (
              <Button variant="ghost" className="mr-auto text-red-600" icon={<Trash2 className="size-4" />} onClick={() => setRemover(true)}>
                Remover
              </Button>
            )}
            {auth.isAdmin && registro.status === "concluida" && !devolver && (
              <Button variant="secondary" icon={<RotateCcw className="size-4" />} onClick={() => setDevolver(true)}>
                Refazer
              </Button>
            )}
            {auth.isAdmin && devolver && (
              <Button variant="danger" loading={acao === "devolver"} disabled={!msg.trim()} onClick={() => validar(false)}>
                Devolver para refazer
              </Button>
            )}
            {auth.isAdmin && pendente && !devolver && (
              <Button icon={<Check className="size-4" />} loading={acao === "aprovar"} onClick={() => validar(true)}>
                Validar
              </Button>
            )}
            {!auth.isAdmin && (
              <Button variant="secondary" onClick={fechar}>
                Fechar
              </Button>
            )}
          </>
        }
      >
        <div className="space-y-5">
          <div className="flex items-center gap-4 rounded-2xl bg-ink-50 p-4">
            <EspIcon esp={esp} size={64} />
            <div className="min-w-0 space-y-1 text-sm">
              {registro.status === "refazer" ? (
                <Badge tone="red">
                  <RotateCcw className="size-3" /> Refazer
                </Badge>
              ) : pendente ? (
                <Badge tone="amber">
                  <Clock className="size-3" /> Aguardando validação do diretor
                </Badge>
              ) : (
                <Badge tone="green">
                  <Check className="size-3" /> Validada
                </Badge>
              )}
              <div className="text-ink-600">
                Concluída em {isoToBr(registro.concluida_em)}
                {registro.registrado_por && nomes.get(registro.registrado_por) ? ` · lançada por ${nomes.get(registro.registrado_por)}` : ""}
              </div>
              {registro.validacao === "aprovada" && registro.validado_em && registro.status === "concluida" && (
                <div className="text-ink-600">
                  Validada {timeAgo(registro.validado_em)}
                  {registro.validado_por && nomes.get(registro.validado_por) ? ` por ${nomes.get(registro.validado_por)}` : ""}
                </div>
              )}
              {registro.status === "refazer" && registro.observacao && <p className="rounded-lg bg-red-50 px-2 py-1 text-red-700">{registro.observacao}</p>}
            </div>
          </div>

          {devolver && (
            <Textarea
              label="O que precisa refazer? (obrigatório)"
              value={msg}
              onChange={(e) => setMsg(e.target.value)}
              placeholder="Ex.: A foto não mostra o nó pronto. Envie outra."
              hint="A mensagem vai para quem lançou e para a equipe da classe."
            />
          )}

          <section>
            <h3 className="mb-2 text-sm font-semibold text-ink-800">Comprovantes ({anexos.length})</h3>
            <AnexosLista anexos={anexos} nomes={nomes} />
            {podeEsp && (
              <div className="mt-3 space-y-2">
                <AnexosPicker files={files} onChange={setFiles} titulo="Adicionar comprovante" />
                {files.length > 0 && (
                  <Button className="w-full" onClick={anexar} loading={enviando} icon={<Paperclip className="size-4" />}>
                    Guardar {files.length === 1 ? "arquivo" : `${files.length} arquivos`}
                  </Button>
                )}
              </div>
            )}
          </section>

          {auth.isAdmin && (
            <section>
              <h3 className="mb-2 text-sm font-semibold text-ink-800">Histórico</h3>
              {!historico?.length ? (
                <p className="text-sm text-ink-400">Sem registros ainda.</p>
              ) : (
                <ol className="space-y-2 border-l-2 border-ink-100 pl-4">
                  {historico.map((h) => (
                    <li key={h.id} className="text-sm">
                      <span className="font-semibold text-ink-800">{h.autor_nome || "Sistema"}</span> <span className="text-ink-600">{ACAO_TEXTO[h.acao] || h.acao}</span>
                      {h.acao === "anexou" && h.detalhe ? <span className="text-ink-600"> “{h.detalhe}”</span> : null}
                      <span className="text-ink-400"> · {timeAgo(h.created_at)}</span>
                      {h.acao === "devolveu" && h.detalhe && <p className="text-xs text-red-700">{h.detalhe}</p>}
                    </li>
                  ))}
                </ol>
              )}
            </section>
          )}
        </div>
      </Sheet>
      <Confirm
        open={remover}
        title={`Remover ${esp.nome}?`}
        message="O registro sai da ficha do desbravador. Os comprovantes e o histórico continuam guardados para o diretor."
        confirmLabel="Remover"
        danger
        onClose={() => setRemover(false)}
        onConfirm={async () => {
          const { error } = await sb.from("desbravador_especialidades").delete().eq("desbravador_id", desbravador.id).eq("especialidade_codigo", esp.codigo);
          setRemover(false);
          if (error) return toast.error(error.message);
          toast.success("Especialidade removida.");
          fechar();
          onSaved();
        }}
      />
    </>
  );
}

function ExcluirDialog({ open, nome, ativo, onClose, onDesativar, onExcluir }: { open: boolean; nome: string; ativo: boolean; onClose: () => void; onDesativar: () => void; onExcluir: () => void }) {
  const [confirmar, setConfirmar] = useState(false);
  if (!open) return null;
  return (
    <>
      <Sheet
        open={open && !confirmar}
        onClose={onClose}
        title={ativo ? "Desativar ou excluir" : "Reativar ou excluir"}
        description={nome}
        footer={
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
        }
      >
        <div className="space-y-3">
          <button onClick={onDesativar} className="flex w-full items-start gap-3 rounded-2xl border border-ink-200 p-4 text-left hover:bg-ink-50">
            <UserX className="mt-0.5 size-5 text-ink-600" />
            <span>
              <span className="block font-semibold">{ativo ? "Desativar (recomendado)" : "Reativar"}</span>
              <span className="text-sm text-ink-500">{ativo ? "Sai das listas e relatórios, mas o histórico fica guardado." : "Volta para as listas da classe."}</span>
            </span>
          </button>
          <button onClick={() => setConfirmar(true)} className="flex w-full items-start gap-3 rounded-2xl border border-red-200 p-4 text-left hover:bg-red-50">
            <Trash2 className="mt-0.5 size-5 text-red-600" />
            <span>
              <span className="block font-semibold text-red-700">Excluir definitivamente</span>
              <span className="text-sm text-ink-500">Apaga o cadastro, o caderno e as especialidades. Não dá para desfazer.</span>
            </span>
          </button>
        </div>
      </Sheet>
      <Confirm
        open={confirmar}
        title={`Excluir ${nome}?`}
        message="O cadastro, o caderno e as especialidades deste desbravador serão apagados para sempre."
        confirmLabel="Excluir desbravador"
        danger
        onClose={() => setConfirmar(false)}
        onConfirm={onExcluir}
      />
    </>
  );
}
