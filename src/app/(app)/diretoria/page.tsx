"use client";

import { useEffect, useMemo, useState } from "react";
import { Check, Clock, Eye, MessageSquare, ShieldCheck, UserCheck, UserPlus, UserX, Users } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Avatar, Badge, Button, Card, Checkbox, Confirm, EmptyState, Input, PageHeader, SearchInput, Select, Sheet, Skeleton, Tabs, Textarea } from "@/components/ui";
import { PhoneLink } from "@/components/domain";
import { EspecialidadesCompraPanel, RelacaoMembrosPanel } from "@/components/relatorios-clube";
import { BaixarArquivos } from "@/components/report-panel";
import { diretoriaExcel, diretoriaPDF } from "@/lib/reports";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData } from "@/lib/use-data";
import { getDesbravadores, getMembros, getUnidades, notificar } from "@/lib/api";
import { FuncoesPicker } from "@/components/funcoes-picker";
import { Validacoes } from "@/components/validacoes";
import { Historico } from "@/components/historico";
import { PasswordInput } from "@/components/auth-forms";
import { brToIso, isoToBr, isStrongPassword, isValidEmail, isValidPhone, maskDate, maskPhone, normalize, timeAgo } from "@/lib/format";
import { CARGOS_ADMIN, CARGO_CONSELHEIRO, CARGO_INSTRUTOR, funcoesDe, funcoesSolicitadas, type Profile, type Unidade } from "@/lib/types";

type Aba = "espera" | "validacoes" | "membros" | "historico" | "relacao";
const ABAS: Aba[] = ["espera", "validacoes", "membros", "historico", "relacao"];

export default function DiretoriaPage() {
  const auth = useAuth();
  const [aba, setAba] = useState<Aba>("espera");
  const [sel, setSel] = useState<Profile | null>(null);
  const [novo, setNovo] = useState(false);
  const [q, setQ] = useState("");
  const { data, loading, reload } = useData(getMembros, []);
  const { data: unidades } = useData(() => (auth.veTudo ? getUnidades() : Promise.resolve([])), [auth.veTudo]);
  const { data: nValidar, reload: recontar } = useData(async () => {
    if (!auth.isAdmin) return 0;
    const sb = supabaseBrowser();
    const [a, b] = await Promise.all([
      sb.from("desbravador_especialidades").select("desbravador_id", { count: "exact", head: true }).eq("validacao", "pendente").eq("status", "concluida"),
      sb.from("caderno_progresso").select("desbravador_id", { count: "exact", head: true }).eq("validacao", "pendente").eq("status", "feito"),
    ]);
    return (a.count || 0) + (b.count || 0);
  }, [auth.isAdmin]);

  const pendentes = (data || []).filter((m) => m.status === "pendente");
  const membros = (data || []).filter((m) => m.status !== "pendente");
  useEffect(() => {
    if (loading || !data) return;
    // abre direto na aba pedida no link (ex.: /diretoria?aba=validacoes)
    const pedida = new URLSearchParams(window.location.search).get("aba") as Aba | null;
    const soAdmin: Aba[] = ["espera", "validacoes", "historico"];
    if (pedida && ABAS.includes(pedida) && (auth.isAdmin || !soAdmin.includes(pedida))) setAba(pedida);
    else if (!pendentes.length || !auth.isAdmin) setAba("membros");
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [loading]);

  if (!auth.veTudo)
    return (
      <EmptyState
        icon={<ShieldCheck className="size-6" />}
        title="Área da diretoria"
        description="Somente o diretor, os diretores associados, a secretaria, a tesouraria e a capelania acessam esta página."
      />
    );

  const lista = (aba === "espera" ? pendentes : membros).filter((m) => normalize(`${m.nome} ${m.email} ${funcoesDe(m).join(" ")} ${m.cargo_solicitado || ""}`).includes(normalize(q)));
  const nomeClasse = (id: number) => auth.classes.find((c) => c.id === id);
  const nomeUnidade = (id: string) => (unidades || []).find((u) => u.id === id);

  return (
    <div>
      <PageHeader
        eyebrow="Administração"
        title="Diretoria"
        description={auth.isAdmin ? "Aprove cadastros, valide o que a equipe lançou e defina funções, classes e unidades." : "Toda a diretoria do clube e as planilhas para baixar."}
        actions={
          auth.isAdmin && (
            <Button icon={<UserPlus className="size-4" />} onClick={() => setNovo(true)}>
              Criar acesso
            </Button>
          )
        }
      />
      {auth.isLeitor && (
        <p className="mb-4 inline-flex items-center gap-2 rounded-xl bg-ink-100 px-3 py-2 text-sm text-ink-600">
          <Eye className="size-4" /> Você vê tudo e baixa as planilhas, mas só o diretor faz alterações.
        </p>
      )}
      <div className="mb-5">
        <Tabs
          value={aba}
          onChange={setAba}
          items={[
            ...(auth.isAdmin
              ? [
                  { value: "espera" as Aba, label: "Lista de espera", count: pendentes.length },
                  { value: "validacoes" as Aba, label: "Validar", count: nValidar ?? undefined },
                ]
              : []),
            { value: "membros", label: "Membros", count: membros.length },
            ...(auth.isAdmin ? [{ value: "historico" as Aba, label: "Registro" }] : []),
            { value: "relacao", label: "Relação do clube" },
          ]}
        />
      </div>

      {aba === "relacao" ? (
        <RelacaoClube membros={data || []} />
      ) : aba === "validacoes" ? (
        <Validacoes membros={data || []} onChange={() => recontar(true)} />
      ) : aba === "historico" ? (
        <Historico />
      ) : (
        <>
          <div className="mb-4 flex flex-col gap-2 sm:flex-row sm:items-center">
            <SearchInput value={q} onChange={setQ} placeholder="Buscar por nome, e-mail ou função…" className="sm:flex-1" />
            {aba === "membros" && !!lista.length && (
              <div className="grid grid-cols-2 gap-2 sm:flex">
                <BaixarArquivos base="diretoria" excel={() => diretoriaExcel(lista, auth.classes, unidades || [])} pdf={() => diretoriaPDF(lista, auth.classes, unidades || [])} />
              </div>
            )}
          </div>
          {loading ? (
            <div className="space-y-2">
              {Array.from({ length: 4 }).map((_, i) => (
                <Skeleton key={i} className="h-20" />
              ))}
            </div>
          ) : !lista.length ? (
            <EmptyState
              icon={aba === "espera" ? <Clock className="size-6" /> : <Users className="size-6" />}
              title={aba === "espera" ? "Ninguém na lista de espera" : "Nenhum membro encontrado"}
              description={aba === "espera" ? "Quando alguém se cadastrar, aparece aqui. Só entra no app quem você aprovar." : undefined}
            />
          ) : (
            <div className="grid grid-cols-1 gap-3 md:grid-cols-2">
              {lista.map((m) => (
                <Card key={m.id} className="flex items-start gap-3 p-4">
                  <Avatar nome={m.nome} color={m.is_admin ? "#F26B1D" : "#3B2A1F"} size={44} />
                  <div className="min-w-0 flex-1">
                    <div className="flex flex-wrap items-center gap-2">
                      <span className="truncate font-semibold">{m.nome}</span>
                      {m.is_admin && <Badge tone="tiger">Admin</Badge>}
                      {m.status === "inativo" && <Badge tone="red">Inativo</Badge>}
                    </div>
                    <div className="mt-1 flex flex-wrap gap-1">
                      {m.status === "pendente" ? (
                        <>
                          <span className="mr-1 text-sm text-ink-500">Cadastrou-se {timeAgo(m.created_at)}, pediu:</span>
                          {(funcoesSolicitadas(m.cargo_solicitado).length ? funcoesSolicitadas(m.cargo_solicitado) : [m.cargo_solicitado || "—"]).map((f) => (
                            <Badge key={f} tone="blue">
                              {f}
                            </Badge>
                          ))}
                        </>
                      ) : (
                        funcoesDe(m).map((f) => <Badge key={f}>{f}</Badge>)
                      )}
                    </div>
                    <div className="mt-1.5 flex flex-wrap gap-x-3 gap-y-1 text-xs text-ink-500">
                      {m.idade != null && <span>{m.idade} anos</span>}
                      <PhoneLink phone={m.telefone} />
                    </div>
                    {(m.classes || []).length > 0 && (
                      <div className="mt-2 flex flex-wrap gap-1.5">
                        {(m.classes || []).map((c) => (
                          <span key={c.class_id} className="inline-flex items-center gap-1 rounded-full bg-ink-100 px-2 py-0.5 text-[11px] font-semibold text-ink-700">
                            <span className="size-2 rounded-full" style={{ background: nomeClasse(c.class_id)?.cor }} />
                            Classe {nomeClasse(c.class_id)?.nome}
                          </span>
                        ))}
                      </div>
                    )}
                    {(m.unidades || []).length > 0 && (
                      <div className="mt-2 flex flex-wrap gap-1.5">
                        {(m.unidades || []).map((u) => (
                          <span key={u.unidade_id} className="inline-flex items-center gap-1 rounded-full bg-ink-100 px-2 py-0.5 text-[11px] font-semibold text-ink-700">
                            <span className="size-2 rounded-full" style={{ background: nomeUnidade(u.unidade_id)?.cor }} />
                            Unidade {nomeUnidade(u.unidade_id)?.nome}
                          </span>
                        ))}
                      </div>
                    )}
                  </div>
                  {auth.isAdmin && (
                    <Button size="sm" variant={m.status === "pendente" ? "primary" : "secondary"} onClick={() => setSel(m)}>
                      {m.status === "pendente" ? "Aprovar" : "Gerenciar"}
                    </Button>
                  )}
                </Card>
              ))}
            </div>
          )}
        </>
      )}
      <MembroSheet membro={sel} unidades={unidades || []} onClose={() => setSel(null)} onSaved={() => reload(true)} />
      <NovoAcessoSheet open={novo} onClose={() => setNovo(false)} onSaved={() => reload(true)} />
    </div>
  );
}

function MembroSheet({ membro, unidades, onClose, onSaved }: { membro: Profile | null; unidades: Unidade[]; onClose: () => void; onSaved: () => void }) {
  const auth = useAuth();
  const sb = supabaseBrowser();
  const [funcoes, setFuncoes] = useState<string[]>([]);
  const [recusar, setRecusar] = useState(false);
  const [status, setStatus] = useState<Profile["status"]>("ativo");
  const [classes, setClasses] = useState<Set<number>>(new Set());
  const [unids, setUnids] = useState<Set<string>>(new Set());
  const [msg, setMsg] = useState("");
  const [saving, setSaving] = useState(false);
  const [remover, setRemover] = useState(false);

  useEffect(() => {
    if (!membro) return;
    const pendente = membro.status === "pendente";
    setFuncoes(pendente ? funcoesSolicitadas(membro.cargo_solicitado) : funcoesDe(membro));
    setStatus(pendente ? "ativo" : membro.status);
    setClasses(new Set((membro.classes || []).map((x) => x.class_id)));
    setUnids(new Set((membro.unidades || []).map((x) => x.unidade_id)));
    setMsg("");
  }, [membro]);

  const souEu = membro?.id === auth.userId;
  const ehInstrutor = funcoes.includes(CARGO_INSTRUTOR);
  const ehConselheiro = funcoes.includes(CARGO_CONSELHEIRO);
  const admin = funcoes.some((f) => CARGOS_ADMIN.includes(f));

  async function salvar() {
    if (!membro) return;
    if (!funcoes.length) return toast.error("Escolha pelo menos uma função.");
    if (souEu && !admin) return toast.error("Você não pode tirar o seu próprio acesso de diretor.");
    setSaving(true);
    try {
      // o banco define o cargo principal e o acesso de administrador a partir das funções
      const up = await sb
        .from("profiles")
        .update({ funcoes, cargo: funcoes[0], is_admin: admin, status: souEu ? "ativo" : status })
        .eq("id", membro.id);
      if (up.error) throw up.error;
      // classes: só para instrutores
      const antes = new Set((membro.classes || []).map((x) => x.class_id));
      const depois = ehInstrutor ? classes : new Set<number>();
      const remover = [...antes].filter((k) => !depois.has(k));
      if (remover.length) {
        const r = await sb.from("class_staff").delete().eq("profile_id", membro.id).in("class_id", remover);
        if (r.error) throw r.error;
      }
      const ups = [...depois].filter((k) => !antes.has(k)).map((class_id) => ({ class_id, profile_id: membro.id, funcao: CARGO_INSTRUTOR }));
      if (ups.length) {
        const r = await sb.from("class_staff").upsert(ups);
        if (r.error) throw r.error;
      }
      // unidades: só para conselheiros
      const antesU = new Set((membro.unidades || []).map((x) => x.unidade_id));
      const depoisU = ehConselheiro ? unids : new Set<string>();
      const removerU = [...antesU].filter((k) => !depoisU.has(k));
      if (removerU.length) {
        const r = await sb.from("unidade_staff").delete().eq("profile_id", membro.id).in("unidade_id", removerU);
        if (r.error) throw r.error;
      }
      const upsU = [...depoisU].filter((k) => !antesU.has(k)).map((unidade_id) => ({ unidade_id, profile_id: membro.id, funcao: CARGO_CONSELHEIRO }));
      if (upsU.length) {
        const r = await sb.from("unidade_staff").upsert(upsU);
        if (r.error) throw r.error;
      }
      const aprovado = membro.status === "pendente" && status === "ativo";
      const nomesClasses = [...depois].map((k) => auth.classes.find((c) => c.id === k)?.nome).filter(Boolean);
      const nomesUnidades = [...depoisU].map((k) => unidades.find((u) => u.id === k)?.nome).filter(Boolean);
      const mudouFuncoes = funcoes.join() !== funcoesDe(membro).join();
      if (aprovado || ups.length || remover.length || upsU.length || removerU.length || mudouFuncoes) {
        await notificar(auth.userId!, [membro.id], {
          tipo: "acesso",
          titulo: aprovado ? "Seu acesso foi liberado!" : "Seu acesso foi atualizado",
          mensagem: `${funcoes.length > 1 ? "Funções" : "Função"}: ${funcoes.join(", ")}.${nomesClasses.length ? ` Classe(s): ${nomesClasses.join(", ")}.` : ""}${nomesUnidades.length ? ` Unidade(s): ${nomesUnidades.join(", ")}.` : ""}`,
          link: "/painel",
        });
      }
      if (msg.trim()) await notificar(auth.userId!, [membro.id], { titulo: `Mensagem de ${auth.profile?.nome.split(" ")[0]}`, mensagem: msg.trim(), link: "/notificacoes" });
      toast.success(aprovado ? `${membro.nome.split(" ")[0]} foi aprovado(a)!` : "Alterações salvas.");
      onSaved();
      onClose();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setSaving(false);
    }
  }

  return (
    <>
      <Sheet
        open={!!membro}
        onClose={onClose}
        title={membro?.status === "pendente" ? "Aprovar cadastro" : "Gerenciar membro"}
        description={membro?.nome}
        wide
        footer={
          <>
            {!souEu && membro?.status !== "pendente" && (
              <Button variant="ghost" className="mr-auto text-red-600" onClick={() => setRemover(true)}>
                Remover acesso
              </Button>
            )}
            {membro?.status === "pendente" && (
              <Button variant="ghost" className="mr-auto text-red-600" icon={<UserX className="size-4" />} onClick={() => setRecusar(true)}>
                Recusar
              </Button>
            )}
            <Button variant="secondary" onClick={onClose}>
              Cancelar
            </Button>
            <Button icon={membro?.status === "pendente" ? <UserCheck className="size-4" /> : <Check className="size-4" />} loading={saving} onClick={salvar}>
              {membro?.status === "pendente" ? "Aprovar e salvar" : "Salvar"}
            </Button>
          </>
        }
      >
        {membro && (
          <div className="space-y-6">
            <div className="grid gap-3 rounded-2xl bg-ink-50 p-4 text-sm sm:grid-cols-2">
              <div>
                <div className="text-xs text-ink-400">E-mail</div>
                <div className="break-all font-medium">{membro.email}</div>
              </div>
              <div>
                <div className="text-xs text-ink-400">Telefone</div>
                <PhoneLink phone={membro.telefone} />
              </div>
              <div>
                <div className="text-xs text-ink-400">Nascimento</div>
                <div className="font-medium">
                  {isoToBr(membro.data_nascimento) || "—"} {membro.idade != null && `(${membro.idade} anos)`}
                </div>
              </div>
            </div>

            {membro.status === "pendente" && (
              <p className="rounded-2xl bg-blue-50 p-3 text-sm text-blue-900">
                No cadastro, pediu: <strong>{membro.cargo_solicitado || "nenhuma função"}</strong>. Confira se a pessoa é mesmo da diretoria antes de aprovar. Se não for, toque em Recusar.
              </p>
            )}
            <FuncoesPicker value={funcoes} onChange={setFuncoes} travadas={souEu ? CARGOS_ADMIN : []} hint="Marque todas as funções. Ex.: diretor que também é instrutor de uma classe." />
            {admin && (
              <p className="-mt-3 flex items-center gap-2 rounded-xl bg-tiger-50 px-3 py-2 text-sm text-tiger-800">
                <ShieldCheck className="size-4 shrink-0" /> Com a função de diretor, tem acesso de administrador: aprova cadastros, valida e mexe em tudo.
              </p>
            )}
            {membro.status !== "pendente" && (
              <Select label="Situação" value={status} onChange={(e) => setStatus(e.target.value as Profile["status"])} disabled={souEu}>
                <option value="ativo">Ativo</option>
                <option value="inativo">Inativo (sem acesso)</option>
              </Select>
            )}

            {ehInstrutor && (
              <div>
                <div className="mb-1 text-sm font-medium text-ink-800">Classes que coordena</div>
                <p className="mb-2 text-xs text-ink-500">Aparece porque a pessoa tem a função de instrutor.</p>
                <div className="grid gap-2 sm:grid-cols-2">
                  {auth.classes.map((c) => {
                    const on = classes.has(c.id);
                    return (
                      <div key={c.id} className={`flex items-center gap-3 rounded-xl border px-3 py-2 ${on ? "border-ink-300 bg-white" : "border-ink-200 bg-ink-50/50"}`}>
                        <Checkbox
                          checked={on}
                          onChange={(v) =>
                            setClasses((m) => {
                              const n = new Set(m);
                              if (v) n.add(c.id);
                              else n.delete(c.id);
                              return n;
                            })
                          }
                          label={
                            <span className="inline-flex items-center gap-2 font-medium">
                              <span className="size-2.5 rounded-full" style={{ background: c.cor }} /> {c.nome}
                            </span>
                          }
                        />
                      </div>
                    );
                  })}
                </div>
              </div>
            )}

            {ehConselheiro && (
              <div>
                <div className="mb-1 text-sm font-medium text-ink-800">Unidades que coordena</div>
                <p className="mb-2 text-xs text-ink-500">Aparece porque a pessoa tem a função de conselheiro.</p>
                {unidades.length ? (
                  <div className="grid gap-2 sm:grid-cols-2">
                    {unidades.map((u) => {
                      const on = unids.has(u.id);
                      return (
                        <div key={u.id} className={`flex items-center gap-3 rounded-xl border px-3 py-2 ${on ? "border-ink-300 bg-white" : "border-ink-200 bg-ink-50/50"}`}>
                          <Checkbox
                            checked={on}
                            onChange={(v) =>
                              setUnids((m) => {
                                const n = new Set(m);
                                if (v) n.add(u.id);
                                else n.delete(u.id);
                                return n;
                              })
                            }
                            label={
                              <span className="inline-flex items-center gap-2 font-medium">
                                <span className="size-2.5 rounded-full" style={{ background: u.cor }} /> {u.nome}
                              </span>
                            }
                          />
                        </div>
                      );
                    })}
                  </div>
                ) : (
                  <p className="rounded-xl bg-ink-50 px-3 py-2.5 text-sm text-ink-500">Nenhuma unidade criada ainda. Crie na página Unidades.</p>
                )}
              </div>
            )}

            <Textarea
              label="Mensagem para a pessoa (opcional)"
              value={msg}
              onChange={(e) => setMsg(e.target.value)}
              placeholder="Ex.: Bem-vindo(a) à classe de Excursionista!"
              hint={
                <span className="inline-flex items-center gap-1">
                  <MessageSquare className="size-3.5" /> Aparece nas notificações dela.
                </span>
              }
            />
          </div>
        )}
      </Sheet>
      <Confirm
        open={remover}
        title="Remover acesso?"
        message={
          <>
            <strong>{membro?.nome}</strong> perde o acesso ao app e sai de todas as classes. O cadastro continua salvo como inativo e pode ser reativado.
          </>
        }
        confirmLabel="Remover acesso"
        danger
        onClose={() => setRemover(false)}
        onConfirm={async () => {
          if (!membro) return;
          await sb.from("class_staff").delete().eq("profile_id", membro.id);
          await sb.from("unidade_staff").delete().eq("profile_id", membro.id);
          const { error } = await sb.from("profiles").update({ status: "inativo", is_admin: false }).eq("id", membro.id);
          if (error) toast.error(error.message);
          else toast.success("Acesso removido.");
          setRemover(false);
          onSaved();
          onClose();
        }}
      />
      <RecusarDialog
        membro={membro}
        open={recusar}
        onClose={() => setRecusar(false)}
        onDone={() => {
          setRecusar(false);
          onSaved();
          onClose();
        }}
      />
    </>
  );
}

function RecusarDialog({ membro, open, onClose, onDone }: { membro: Profile | null; open: boolean; onClose: () => void; onDone: () => void }) {
  const [loading, setLoading] = useState(false);
  return (
    <Confirm
      open={open}
      title="Recusar cadastro?"
      message={
        <>
          A conta de <strong>{membro?.nome}</strong> ({membro?.email}) é apagada e a pessoa não entra no app.
        </>
      }
      confirmLabel="Recusar e apagar"
      danger
      loading={loading}
      onClose={onClose}
      onConfirm={async () => {
        if (!membro) return;
        setLoading(true);
        try {
          const {
            data: { session },
          } = await supabaseBrowser().auth.getSession();
          const r = await fetch(`/api/admin/membros?id=${encodeURIComponent(membro.id)}`, { method: "DELETE", headers: { authorization: `Bearer ${session?.access_token || ""}` } });
          const j = await r.json().catch(() => ({}));
          if (!r.ok) throw new Error(j.error || "Não foi possível recusar.");
          toast.success("Cadastro recusado.");
          onDone();
        } catch (e) {
          toast.error((e as Error).message);
        } finally {
          setLoading(false);
        }
      }}
    />
  );
}

function RelacaoClube({ membros }: { membros: Profile[] }) {
  const { classes } = useAuth();
  const { data: desb } = useData(() => getDesbravadores(), []);
  const porClasse = useMemo(() => classes.map((c) => ({ c, n: (desb || []).filter((d) => d.class_id === c.id).length })), [classes, desb]);
  return (
    <div className="space-y-4">
      <RelacaoMembrosPanel membros={membros} classes={classes} desb={desb} />
      <EspecialidadesCompraPanel />
      <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-6">
        {porClasse.map(({ c, n }) => (
          <Card key={c.id} className="p-4">
            <span className="mb-2 block h-1.5 w-8 rounded-full" style={{ background: c.cor }} />
            <div className="font-display text-2xl font-semibold">{n}</div>
            <div className="text-sm text-ink-500">{c.nome}</div>
          </Card>
        ))}
      </div>
      <Card className="p-4 text-sm text-ink-600">
        <strong className="text-ink-900">{membros.filter((m) => m.status === "ativo").length}</strong> membros ativos na diretoria · <strong className="text-ink-900">{(desb || []).length}</strong>{" "}
        desbravadores ativos
      </Card>
    </div>
  );
}

type NovoForm = { nome: string; email: string; funcoes: string[]; telefone: string; data_nascimento: string; password: string };
const novoVazio: NovoForm = { nome: "", email: "", funcoes: [], telefone: "", data_nascimento: "", password: "" };

function validarNovo(f: NovoForm) {
  const e: Partial<Record<keyof NovoForm, string>> = {};
  if (f.nome.trim().split(/\s+/).length < 2) e.nome = "Informe nome e sobrenome.";
  if (!isValidEmail(f.email)) e.email = "Digite um e-mail válido (sem acentos).";
  if (!f.funcoes.length) e.funcoes = "Escolha pelo menos uma função.";
  if (f.telefone && !isValidPhone(f.telefone)) e.telefone = "Telefone com DDD, ex.: (11) 98765-4321.";
  if (f.data_nascimento && !brToIso(f.data_nascimento)) e.data_nascimento = "Data no formato dd/mm/aaaa.";
  if (!isStrongPassword(f.password)) e.password = "A senha não atende aos requisitos abaixo.";
  return e;
}

/** O diretor cria a conta de alguém da diretoria, já liberada, com a senha que ele escolher. */
function NovoAcessoSheet({ open, onClose, onSaved }: { open: boolean; onClose: () => void; onSaved: () => void }) {
  const [f, setF] = useState<NovoForm>(novoVazio);
  const [touched, setTouched] = useState<Partial<Record<keyof NovoForm, boolean>>>({});
  const [saving, setSaving] = useState(false);
  useEffect(() => {
    if (open) {
      setF(novoVazio);
      setTouched({});
    }
  }, [open]);
  const errors = validarNovo(f);
  const show = (k: keyof NovoForm) => (touched[k] ? errors[k] : undefined);
  const set = (k: keyof NovoForm) => (v: string | string[]) => setF((s) => ({ ...s, [k]: v }));
  const blur = (k: keyof NovoForm) => () => setTouched((t) => ({ ...t, [k]: true }));

  async function criar(outro: boolean) {
    setTouched({ nome: true, email: true, funcoes: true, telefone: true, data_nascimento: true, password: true });
    if (Object.keys(errors).length) return;
    setSaving(true);
    try {
      const {
        data: { session },
      } = await supabaseBrowser().auth.getSession();
      const r = await fetch("/api/admin/membros", {
        method: "POST",
        headers: { "content-type": "application/json", authorization: `Bearer ${session?.access_token || ""}` },
        body: JSON.stringify(f),
      });
      const j = await r.json().catch(() => ({}));
      if (!r.ok) throw new Error(j.error || "Não foi possível criar o acesso.");
      toast.success(`Acesso de ${f.nome.split(" ")[0]} criado. Já pode entrar com ${f.email}.`);
      onSaved();
      if (outro) {
        // mantém a senha para agilizar vários cadastros seguidos
        setF((s) => ({ ...novoVazio, password: s.password }));
        setTouched({});
      } else onClose();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setSaving(false);
    }
  }

  return (
    <Sheet
      open={open}
      onClose={onClose}
      title="Criar acesso"
      description="A conta já nasce liberada. Passe o e-mail e a senha para a pessoa."
      wide
      footer={
        <>
          <Button variant="secondary" className="mr-auto" onClick={() => criar(true)} loading={saving}>
            Criar e fazer outro
          </Button>
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
          <Button icon={<UserPlus className="size-4" />} onClick={() => criar(false)} loading={saving}>
            Criar acesso
          </Button>
        </>
      }
    >
      <div className="grid gap-4 sm:grid-cols-2">
        <div className="sm:col-span-2">
          <Input label="Nome completo" autoComplete="off" value={f.nome} onChange={(e) => set("nome")(e.target.value)} onBlur={blur("nome")} error={show("nome")} required />
        </div>
        <Input
          label="E-mail"
          type="email"
          inputMode="email"
          autoComplete="off"
          value={f.email}
          onChange={(e) => set("email")(e.target.value.trim())}
          onBlur={blur("email")}
          error={show("email")}
          required
        />
        <div className="sm:col-span-2">
          <FuncoesPicker value={f.funcoes} onChange={set("funcoes")} error={show("funcoes")} compacto />
        </div>
        <Input
          label="Telefone (opcional)"
          inputMode="tel"
          placeholder="(11) 98765-4321"
          value={f.telefone}
          onChange={(e) => set("telefone")(maskPhone(e.target.value))}
          onBlur={blur("telefone")}
          error={show("telefone")}
        />
        <Input
          label="Data de nascimento (opcional)"
          inputMode="numeric"
          placeholder="dd/mm/aaaa"
          value={f.data_nascimento}
          onChange={(e) => set("data_nascimento")(maskDate(e.target.value))}
          onBlur={blur("data_nascimento")}
          error={show("data_nascimento")}
        />
        <div className="sm:col-span-2">
          <PasswordInput label="Senha" value={f.password} onChange={set("password")} onBlur={blur("password")} error={show("password")} autoComplete="new-password" showRules />
        </div>
      </div>
      <p className="mt-4 text-sm text-ink-500">
        Depois de criar, abra a pessoa em <strong>Membros → Gerenciar</strong> para escolher as classes (instrutor) e as unidades (conselheiro).
      </p>
    </Sheet>
  );
}
