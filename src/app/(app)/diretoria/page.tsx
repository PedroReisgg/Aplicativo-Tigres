"use client";

import { useEffect, useMemo, useState } from "react";
import { Check, Clock, MessageSquare, ShieldCheck, UserCheck, Users } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Avatar, Badge, Button, Card, Checkbox, Confirm, EmptyState, Input, PageHeader, SearchInput, Select, Sheet, Skeleton, Tabs, Textarea } from "@/components/ui";
import { PhoneLink } from "@/components/domain";
import { ReportPanel } from "@/components/report-panel";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData } from "@/lib/use-data";
import { getDesbravadores, getMembros, notificar } from "@/lib/api";
import { clubReportExcel, clubReportPDF } from "@/lib/reports";
import { isoToBr, normalize, timeAgo } from "@/lib/format";
import { CARGOS, FUNCOES_CLASSE, type Profile } from "@/lib/types";

type Aba = "espera" | "membros" | "relacao";

export default function DiretoriaPage() {
  const auth = useAuth();
  const [aba, setAba] = useState<Aba>("espera");
  const [sel, setSel] = useState<Profile | null>(null);
  const [q, setQ] = useState("");
  const { data, loading, reload } = useData(getMembros, []);

  const pendentes = (data || []).filter((m) => m.status === "pendente");
  const membros = (data || []).filter((m) => m.status !== "pendente");
  useEffect(() => {
    if (!loading && data && !pendentes.length) setAba("membros");
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [loading]);

  if (!auth.isAdmin) return <EmptyState icon={<ShieldCheck className="size-6" />} title="Área do diretor" description="Somente o diretor e os diretores associados acessam esta página." />;

  const lista = (aba === "espera" ? pendentes : membros).filter((m) => normalize(`${m.nome} ${m.email} ${m.cargo}`).includes(normalize(q)));
  const nomeClasse = (id: number) => auth.classes.find((c) => c.id === id);

  return (
    <div>
      <PageHeader eyebrow="Administração" title="Diretoria" description="Aprove novos cadastros, defina cargos, classes e permissões." />
      <div className="mb-5">
        <Tabs
          value={aba}
          onChange={setAba}
          items={[
            { value: "espera", label: "Lista de espera", count: pendentes.length },
            { value: "membros", label: "Membros", count: membros.length },
            { value: "relacao", label: "Relação do clube" },
          ]}
        />
      </div>

      {aba === "relacao" ? (
        <RelacaoClube membros={data || []} />
      ) : (
        <>
          <SearchInput value={q} onChange={setQ} placeholder="Buscar por nome, e-mail ou cargo…" className="mb-4" />
          {loading ? (
            <div className="space-y-2">{Array.from({ length: 4 }).map((_, i) => <Skeleton key={i} className="h-20" />)}</div>
          ) : !lista.length ? (
            <EmptyState
              icon={aba === "espera" ? <Clock className="size-6" /> : <Users className="size-6" />}
              title={aba === "espera" ? "Ninguém na lista de espera" : "Nenhum membro encontrado"}
              description={aba === "espera" ? "Quando alguém da diretoria se cadastrar, aparece aqui para você aprovar." : undefined}
            />
          ) : (
            <div className="grid gap-3 md:grid-cols-2">
              {lista.map((m) => (
                <Card key={m.id} className="flex items-start gap-3 p-4">
                  <Avatar nome={m.nome} color={m.is_admin ? "#F26B1D" : "#3B2A1F"} size={44} />
                  <div className="min-w-0 flex-1">
                    <div className="flex flex-wrap items-center gap-2">
                      <span className="truncate font-semibold">{m.nome}</span>
                      {m.is_admin && <Badge tone="tiger">Admin</Badge>}
                      {m.status === "inativo" && <Badge tone="red">Inativo</Badge>}
                    </div>
                    <div className="truncate text-sm text-ink-500">{m.status === "pendente" ? `Cadastrou-se ${timeAgo(m.created_at)}` : m.cargo}</div>
                    <div className="mt-1.5 flex flex-wrap gap-x-3 gap-y-1 text-xs text-ink-500">
                      {m.idade != null && <span>{m.idade} anos</span>}
                      <PhoneLink phone={m.telefone} />
                    </div>
                    {(m.classes || []).length > 0 && (
                      <div className="mt-2 flex flex-wrap gap-1.5">
                        {(m.classes || []).map((c) => (
                          <span key={c.class_id} className="inline-flex items-center gap-1 rounded-full bg-ink-100 px-2 py-0.5 text-[11px] font-semibold text-ink-700">
                            <span className="size-2 rounded-full" style={{ background: nomeClasse(c.class_id)?.cor }} />
                            {nomeClasse(c.class_id)?.nome} · {c.funcao}
                          </span>
                        ))}
                      </div>
                    )}
                  </div>
                  <Button size="sm" variant={m.status === "pendente" ? "primary" : "secondary"} onClick={() => setSel(m)}>
                    {m.status === "pendente" ? "Aprovar" : "Gerenciar"}
                  </Button>
                </Card>
              ))}
            </div>
          )}
        </>
      )}
      <MembroSheet membro={sel} onClose={() => setSel(null)} onSaved={() => reload(true)} />
    </div>
  );
}

function MembroSheet({ membro, onClose, onSaved }: { membro: Profile | null; onClose: () => void; onSaved: () => void }) {
  const auth = useAuth();
  const sb = supabaseBrowser();
  const [cargo, setCargo] = useState("");
  const [outroCargo, setOutroCargo] = useState("");
  const [admin, setAdmin] = useState(false);
  const [status, setStatus] = useState<Profile["status"]>("ativo");
  const [classes, setClasses] = useState<Map<number, string>>(new Map());
  const [msg, setMsg] = useState("");
  const [saving, setSaving] = useState(false);
  const [remover, setRemover] = useState(false);

  useEffect(() => {
    if (!membro) return;
    const c = membro.cargo === "Aguardando aprovação" ? "Instrutor(a)" : membro.cargo;
    setCargo(CARGOS.includes(c) ? c : "outro");
    setOutroCargo(CARGOS.includes(c) ? "" : c);
    setAdmin(membro.is_admin);
    setStatus(membro.status === "pendente" ? "ativo" : membro.status);
    setClasses(new Map((membro.classes || []).map((x) => [x.class_id, x.funcao])));
    setMsg("");
  }, [membro]);

  const souEu = membro?.id === auth.userId;
  const cargoFinal = cargo === "outro" ? outroCargo.trim() || "Membro" : cargo;

  async function salvar() {
    if (!membro) return;
    setSaving(true);
    try {
      const up = await sb.from("profiles").update({ cargo: cargoFinal, is_admin: souEu ? true : admin, status: souEu ? "ativo" : status }).eq("id", membro.id);
      if (up.error) throw up.error;
      const antes = new Map((membro.classes || []).map((x) => [x.class_id, x.funcao]));
      const remover = [...antes.keys()].filter((k) => !classes.has(k));
      if (remover.length) {
        const r = await sb.from("class_staff").delete().eq("profile_id", membro.id).in("class_id", remover);
        if (r.error) throw r.error;
      }
      const ups = [...classes.entries()].filter(([k, v]) => antes.get(k) !== v).map(([class_id, funcao]) => ({ class_id, profile_id: membro.id, funcao }));
      if (ups.length) {
        const r = await sb.from("class_staff").upsert(ups);
        if (r.error) throw r.error;
      }
      const aprovado = membro.status === "pendente" && status === "ativo";
      const nomesClasses = [...classes.keys()].map((k) => auth.classes.find((c) => c.id === k)?.nome).filter(Boolean);
      if (aprovado || ups.length || remover.length) {
        await notificar(auth.userId!, [membro.id], {
          tipo: "acesso",
          titulo: aprovado ? "Seu acesso foi liberado!" : "Seu acesso foi atualizado",
          mensagem: `Cargo: ${cargoFinal}.${nomesClasses.length ? ` Classe(s): ${nomesClasses.join(", ")}.` : ""}`,
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

            <div className="grid gap-4 sm:grid-cols-2">
              <Select label="Cargo no clube" value={cargo} onChange={(e) => setCargo(e.target.value)}>
                {CARGOS.map((c) => (
                  <option key={c}>{c}</option>
                ))}
                <option value="outro">Outro…</option>
              </Select>
              {cargo === "outro" ? (
                <Input label="Nome do cargo" value={outroCargo} onChange={(e) => setOutroCargo(e.target.value)} />
              ) : (
                <Select label="Situação" value={status} onChange={(e) => setStatus(e.target.value as Profile["status"])} disabled={souEu}>
                  <option value="ativo">Ativo</option>
                  <option value="inativo">Inativo (sem acesso)</option>
                </Select>
              )}
            </div>

            <label className={`flex cursor-pointer items-start gap-3 rounded-2xl border p-4 ${admin ? "border-tiger-300 bg-tiger-50" : "border-ink-200"}`}>
              <Checkbox checked={admin || souEu} onChange={setAdmin} disabled={souEu} />
              <span>
                <span className="block font-semibold">Acesso de administrador</span>
                <span className="text-sm text-ink-500">Para o diretor e diretores associados: vê todo o clube, aprova cadastros, mexe nas classes e pode mandar refazer.</span>
              </span>
            </label>

            <div>
              <div className="mb-2 text-sm font-medium text-ink-800">Classes em que atua</div>
              <div className="space-y-2">
                {auth.classes.map((c) => {
                  const on = classes.has(c.id);
                  return (
                    <div key={c.id} className={`flex items-center gap-3 rounded-xl border px-3 py-2 ${on ? "border-ink-300 bg-white" : "border-ink-200 bg-ink-50/50"}`}>
                      <Checkbox
                        checked={on}
                        onChange={(v) =>
                          setClasses((m) => {
                            const n = new Map(m);
                            if (v) n.set(c.id, FUNCOES_CLASSE[0]);
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
                      {on && (
                        <select
                          className="ml-auto h-9 rounded-lg border border-ink-200 bg-white px-2 text-sm"
                          value={classes.get(c.id)}
                          onChange={(e) => setClasses((m) => new Map(m).set(c.id, e.target.value))}
                          aria-label={`Função na classe ${c.nome}`}
                        >
                          {FUNCOES_CLASSE.map((f) => (
                            <option key={f}>{f}</option>
                          ))}
                        </select>
                      )}
                    </div>
                  );
                })}
              </div>
            </div>

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
          const { error } = await sb.from("profiles").update({ status: "inativo", is_admin: false }).eq("id", membro.id);
          if (error) toast.error(error.message);
          else toast.success("Acesso removido.");
          setRemover(false);
          onSaved();
          onClose();
        }}
      />
    </>
  );
}

function RelacaoClube({ membros }: { membros: Profile[] }) {
  const { classes } = useAuth();
  const { data: desb } = useData(() => getDesbravadores(), []);
  const porClasse = useMemo(() => classes.map((c) => ({ c, n: (desb || []).filter((d) => d.class_id === c.id).length })), [classes, desb]);
  return (
    <div className="space-y-4">
      <ReportPanel
        titulo="Relação geral do clube"
        base="relacao-clube"
        descricao="Toda a diretoria (cargo, idade, contato) e todos os desbravadores (classe, pais, telefone)."
        link="/diretoria"
        excel={async () => clubReportExcel(membros.filter((m) => m.status !== "inativo"), desb || (await getDesbravadores()), classes)}
        pdf={async () => clubReportPDF(membros.filter((m) => m.status !== "inativo"), desb || (await getDesbravadores()), classes)}
      />
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
        <strong className="text-ink-900">{membros.filter((m) => m.status === "ativo").length}</strong> membros ativos na diretoria ·{" "}
        <strong className="text-ink-900">{(desb || []).length}</strong> desbravadores ativos
      </Card>
    </div>
  );
}
