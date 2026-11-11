"use client";

import Link from "next/link";
import { useParams, useRouter } from "next/navigation";
import { useMemo, useState } from "react";
import { ArrowLeft, Award, Check, Pencil, Plus, RotateCcw, Trash2, UserX } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Avatar, Badge, Button, Card, Confirm, EmptyState, ProgressBar, SearchInput, Sheet, Skeleton } from "@/components/ui";
import { DesbravadorSheet, EspIcon, PhoneLink } from "@/components/domain";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData } from "@/lib/use-data";
import { getCaderno, getClassEsp, getDesbEsp, getDesbravador, getEspecialidades, getProgresso } from "@/lib/api";
import { isoToBr, normalize } from "@/lib/format";
import type { Especialidade } from "@/lib/types";

export default function DesbravadorPage() {
  const { id } = useParams<{ id: string }>();
  const router = useRouter();
  const auth = useAuth();
  const sb = supabaseBrowser();
  const [editar, setEditar] = useState(false);
  const [addEsp, setAddEsp] = useState(false);
  const [excluir, setExcluir] = useState(false);

  const { data, loading, reload } = useData(async () => {
    const d = await getDesbravador(id);
    if (!d) return null;
    const [itens, prog, esps, todas, classEsp] = await Promise.all([
      d.class_id ? getCaderno(d.class_id) : Promise.resolve([]),
      getProgresso([d.id]),
      getDesbEsp([d.id]),
      getEspecialidades(),
      d.class_id ? getClassEsp(d.class_id) : Promise.resolve([]),
    ]);
    return { d, itens, prog, esps, todas, classEsp };
  }, [id]);

  const espMap = useMemo(() => new Map((data?.todas || []).map((e) => [e.codigo, e])), [data?.todas]);

  if (loading) return <div className="space-y-4"><Skeleton className="h-40" /><Skeleton className="h-64" /></div>;
  if (!data) return <EmptyState title="Desbravador não encontrado" description="Talvez você não tenha acesso a esta classe." action={<Button onClick={() => router.push("/desbravadores")}>Voltar</Button>} />;

  const { d, itens, prog, esps, classEsp } = data;
  const pode = auth.canManageClass(d.class_id);
  const base = itens.filter((i) => !i.avancada);
  const feito = (itemId: number) => prog.find((p) => p.item_id === itemId);
  const pctBase = base.length ? (base.filter((i) => feito(i.id)?.status === "feito").length / base.length) * 100 : 0;
  const obrig = classEsp.map((c) => c.especialidade_codigo);
  const concluidas = esps.filter((e) => e.status === "concluida");

  async function toggleItem(itemId: number) {
    const atual = feito(itemId);
    const r = atual
      ? await sb.from("caderno_progresso").delete().eq("desbravador_id", d.id).eq("item_id", itemId)
      : await sb.from("caderno_progresso").upsert({ desbravador_id: d.id, item_id: itemId, status: "feito", marcado_por: auth.userId, marcado_em: new Date().toISOString() });
    if (r.error) return toast.error(r.error.message);
    reload(true);
  }

  async function registrar(e: Especialidade) {
    const { error } = await sb.from("desbravador_especialidades").upsert({ desbravador_id: d.id, especialidade_codigo: e.codigo, status: "concluida", registrado_por: auth.userId });
    if (error) return toast.error(error.message);
    toast.success(`${e.nome} registrada para ${d.nome.split(" ")[0]}.`);
    reload(true);
  }
  async function remover(cod: string) {
    const { error } = await sb.from("desbravador_especialidades").delete().eq("desbravador_id", d.id).eq("especialidade_codigo", cod);
    if (error) return toast.error(error.message);
    reload(true);
  }

  return (
    <div>
      <Link href={d.classe_slug ? `/classes/${d.classe_slug}?aba=desbravadores` : "/desbravadores"} className="mb-4 inline-flex items-center gap-1.5 text-sm font-medium text-ink-500 hover:text-ink-800">
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
          {pode && (
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
            {pode && (
              <Button size="sm" icon={<Plus className="size-4" />} onClick={() => setAddEsp(true)}>
                Registrar
              </Button>
            )}
          </div>
          {obrig.length > 0 && (
            <Card className="mb-3 p-4">
              <div className="mb-2 text-sm font-semibold text-ink-700">Da classe ({obrig.filter((c) => concluidas.some((e) => e.especialidade_codigo === c)).length}/{obrig.length})</div>
              <div className="flex flex-wrap gap-2">
                {obrig.map((c) => {
                  const e = espMap.get(c);
                  const ok = concluidas.some((x) => x.especialidade_codigo === c);
                  return e ? (
                    <Link key={c} href={`/especialidades/e/${c}`} className={`inline-flex items-center gap-1.5 rounded-full border py-0.5 pl-0.5 pr-2.5 text-xs font-medium ${ok ? "border-emerald-200 bg-emerald-50 text-emerald-800" : "border-ink-200 bg-white text-ink-500"}`}>
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
            <EmptyState icon={<Award className="size-6" />} title="Nenhuma especialidade registrada" description={pode ? "Registre as especialidades que este desbravador concluiu." : undefined} />
          ) : (
            <div className="grid grid-cols-2 gap-2 sm:grid-cols-3">
              {esps.map((x) => {
                const e = espMap.get(x.especialidade_codigo);
                if (!e) return null;
                return (
                  <Card key={x.especialidade_codigo} className="group relative flex flex-col items-center p-3 text-center">
                    <EspIcon esp={e} size={56} />
                    <div className="mt-2 line-clamp-2 text-xs font-semibold leading-snug">{e.nome}</div>
                    <div className="mt-1 text-[11px] text-ink-400">{x.status === "refazer" ? <span className="font-semibold text-red-600">Refazer</span> : isoToBr(x.concluida_em)}</div>
                    {pode && (
                      <button
                        onClick={() => remover(x.especialidade_codigo)}
                        className="absolute right-1.5 top-1.5 rounded-lg p-1 text-ink-300 opacity-100 hover:bg-red-50 hover:text-red-600 sm:opacity-0 sm:group-hover:opacity-100"
                        aria-label={`Remover ${e.nome}`}
                      >
                        <Trash2 className="size-3.5" />
                      </button>
                    )}
                  </Card>
                );
              })}
            </div>
          )}
        </section>
      </div>

      <DesbravadorSheet open={editar} onClose={() => setEditar(false)} desbravador={d} onSaved={() => reload(true)} />
      <RegistrarEspSheet open={addEsp} onClose={() => setAddEsp(false)} todas={data.todas} ja={new Set(esps.map((e) => e.especialidade_codigo))} obrig={obrig} onPick={registrar} />
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

function RegistrarEspSheet({ open, onClose, todas, ja, obrig, onPick }: { open: boolean; onClose: () => void; todas: Especialidade[]; ja: Set<string>; obrig: string[]; onPick: (e: Especialidade) => void }) {
  const [q, setQ] = useState("");
  const res = useMemo(() => {
    const n = normalize(q);
    const base = n ? todas.filter((e) => normalize(e.nome).includes(n) || e.codigo.toLowerCase().includes(n)) : todas.filter((e) => obrig.includes(e.codigo));
    return base.slice(0, 60);
  }, [q, todas, obrig]);
  return (
    <Sheet open={open} onClose={onClose} title="Registrar especialidade" description="Busque a especialidade concluída.">
      <div className="space-y-3">
        <SearchInput value={q} onChange={setQ} placeholder="Nome da especialidade…" />
        {!q && <p className="text-xs font-semibold uppercase tracking-wide text-ink-400">Especialidades da classe</p>}
        <ul className="divide-y divide-ink-100">
          {res.map((e) => (
            <li key={e.codigo} className="flex items-center gap-3 py-2.5">
              <EspIcon esp={e} size={40} />
              <div className="min-w-0 flex-1 truncate text-sm font-semibold">{e.nome}</div>
              {ja.has(e.codigo) ? (
                <Badge tone="green">
                  <Check className="size-3" /> Registrada
                </Badge>
              ) : (
                <Button size="sm" variant="secondary" onClick={() => onPick(e)}>
                  Concluiu
                </Button>
              )}
            </li>
          ))}
        </ul>
      </div>
    </Sheet>
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
