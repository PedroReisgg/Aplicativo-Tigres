"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { Flag, Pencil, Plus, Trash2, Users } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Avatar, Button, Card, Checkbox, Confirm, EmptyState, Input, PageHeader, Sheet, Skeleton, Tabs, cn } from "@/components/ui";
import { PickDesbravadores } from "@/components/domain";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData } from "@/lib/use-data";
import { getDesbravadores, getMembros, getUnidades, getUnidadeStaff, notificar } from "@/lib/api";
import { plural } from "@/lib/format";
import { CARGO_CONSELHEIRO, CORES_UNIDADE, funcoesDe, type Desbravador, type Profile, type Unidade } from "@/lib/types";

type Dados = {
  unidades: Unidade[];
  staff: { unidade_id: string; profile_id: string }[];
  desb: Desbravador[];
  membros: Profile[];
};

const HEX = /^#[0-9A-F]{6}$/i;

export default function UnidadesPage() {
  const auth = useAuth();
  const [sel, setSel] = useState<Unidade | "nova" | null>(null);
  const { data, loading, reload } = useData<Dados>(async () => {
    const [unidades, staff, desb, membros] = await Promise.all([getUnidades(), getUnidadeStaff(), getDesbravadores(), getMembros()]);
    return { unidades, staff, desb, membros };
  }, []);

  if (!auth.isActive) return <EmptyState icon={<Flag className="size-6" />} title="Acesso pendente" description="Quando o diretor liberar seu acesso, você verá as unidades do clube." />;

  const minhas = (data?.unidades || []).filter((u) => auth.veTudo || auth.unidadeIds.includes(u.id));
  const outras = (data?.unidades || []).filter((u) => !minhas.includes(u));
  const membro = (id: string) => data?.membros.find((m) => m.id === id);

  const card = (u: Unidade) => {
    const desb = (data?.desb || []).filter((d) => d.unidade_id === u.id);
    const cons = (data?.staff || [])
      .filter((s) => s.unidade_id === u.id)
      .map((s) => membro(s.profile_id))
      .filter(Boolean) as Profile[];
    const podeVer = auth.veTudo || auth.unidadeIds.includes(u.id);
    return (
      <Card key={u.id} className="relative overflow-hidden">
        <span className="absolute inset-x-0 top-0 h-1.5" style={{ background: u.cor }} />
        <div className="p-4 pt-5">
          <div className="flex items-start justify-between gap-3">
            <div className="min-w-0">
              <h2 className="truncate font-display text-2xl font-semibold uppercase tracking-wide">{u.nome}</h2>
              <p className="text-sm text-ink-500">{podeVer ? plural(desb.length, "desbravador", "desbravadores") : "Unidade do clube"}</p>
            </div>
            {auth.isAdmin && (
              <Button size="sm" variant="secondary" icon={<Pencil className="size-3.5" />} onClick={() => setSel(u)}>
                Gerenciar
              </Button>
            )}
          </div>
          <div className="mt-3 text-xs font-semibold uppercase tracking-wide text-ink-400">Conselheiros</div>
          {cons.length ? (
            <div className="mt-1.5 flex flex-wrap gap-1.5">
              {cons.map((c) => (
                <span key={c.id} className="inline-flex items-center gap-1.5 rounded-full bg-ink-100 py-0.5 pl-0.5 pr-2.5 text-sm">
                  <Avatar nome={c.nome} size={22} color={u.cor} /> {c.nome.split(" ").slice(0, 2).join(" ")}
                </span>
              ))}
            </div>
          ) : (
            <p className="mt-1 text-sm text-ink-500">Nenhum conselheiro definido.</p>
          )}
          {podeVer && desb.length > 0 && (
            <div className="mt-3 flex items-center justify-between gap-3 border-t border-ink-100 pt-3">
              <div className="flex -space-x-2">
                {desb.slice(0, 6).map((d) => (
                  <span key={d.id} className="rounded-full ring-2 ring-white">
                    <Avatar nome={d.nome} size={28} color={d.classe_cor} />
                  </span>
                ))}
                {desb.length > 6 && <span className="grid size-7 place-items-center rounded-full bg-ink-100 text-[11px] font-semibold text-ink-600 ring-2 ring-white">+{desb.length - 6}</span>}
              </div>
              <Link href={`/desbravadores?unidade=${u.id}`} className="text-sm font-semibold text-tiger-700 hover:underline">
                Ver lista
              </Link>
            </div>
          )}
        </div>
      </Card>
    );
  };

  return (
    <div>
      <PageHeader
        eyebrow="Clube"
        title="Unidades"
        description={
          auth.isAdmin
            ? "Crie as unidades, coloque os desbravadores e escolha os conselheiros que coordenam cada uma."
            : auth.isConselheiro
              ? "As unidades que você coordena como conselheiro(a)."
              : "As unidades do clube e seus conselheiros."
        }
        actions={
          auth.isAdmin && (
            <Button icon={<Plus className="size-4" />} onClick={() => setSel("nova")}>
              Nova unidade
            </Button>
          )
        }
      />
      {loading ? (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {Array.from({ length: 3 }).map((_, i) => (
            <Skeleton key={i} className="h-44" />
          ))}
        </div>
      ) : !data?.unidades.length ? (
        <EmptyState
          icon={<Flag className="size-6" />}
          title="Nenhuma unidade ainda"
          description={
            auth.isAdmin ? "Crie a primeira unidade. Elas também são criadas sozinhas quando você importa a planilha de desbravadores." : "Quando o diretor criar as unidades, elas aparecem aqui."
          }
          action={auth.isAdmin && <Button onClick={() => setSel("nova")}>Criar unidade</Button>}
        />
      ) : (
        <div className="space-y-8">
          {minhas.length > 0 && <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">{minhas.map(card)}</div>}
          {outras.length > 0 && (
            <div>
              {minhas.length > 0 && <h2 className="mb-3 font-display text-xl font-semibold uppercase tracking-wide text-ink-500">Outras unidades</h2>}
              <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">{outras.map(card)}</div>
            </div>
          )}
        </div>
      )}
      {data && <UnidadeSheet alvo={sel} dados={data} onClose={() => setSel(null)} onSaved={() => reload(true)} />}
    </div>
  );
}

type Aba = "dados" | "desbravadores" | "conselheiros";

function UnidadeSheet({ alvo, dados, onClose, onSaved }: { alvo: Unidade | "nova" | null; dados: Dados; onClose: () => void; onSaved: () => void }) {
  const auth = useAuth();
  const sb = supabaseBrowser();
  const nova = alvo === "nova";
  const u = alvo && alvo !== "nova" ? alvo : null;
  const [aba, setAba] = useState<Aba>("dados");
  const [nome, setNome] = useState("");
  const [cor, setCor] = useState(CORES_UNIDADE[0]);
  const [hex, setHex] = useState(CORES_UNIDADE[0]);
  const [erroCor, setErroCor] = useState<string | null>(null);
  const [membros, setMembros] = useState<Set<string>>(new Set());
  const [cons, setCons] = useState<Set<string>>(new Set());
  const [saving, setSaving] = useState(false);
  const [excluir, setExcluir] = useState(false);
  const [erroNome, setErroNome] = useState<string | null>(null);

  useEffect(() => {
    if (!alvo) return;
    setAba("dados");
    setErroNome(null);
    setNome(u?.nome || "");
    const c0 = (u?.cor || CORES_UNIDADE[dados.unidades.length % CORES_UNIDADE.length]).toUpperCase();
    setCor(c0);
    setHex(c0);
    setErroCor(null);
    setMembros(new Set(dados.desb.filter((d) => u && d.unidade_id === u.id).map((d) => d.id)));
    setCons(new Set(dados.staff.filter((s) => u && s.unidade_id === u.id).map((s) => s.profile_id)));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [alvo]);

  const conselheiros = useMemo(() => dados.membros.filter((m) => m.status === "ativo" && funcoesDe(m).includes(CARGO_CONSELHEIRO)), [dados.membros]);
  const nomeUnidade = (id: string | null) => dados.unidades.find((x) => x.id === id)?.nome;

  async function salvar() {
    const n = nome.trim();
    if (n.length < 2) return setErroNome("Dê um nome para a unidade.");
    if (dados.unidades.some((x) => x.id !== u?.id && x.nome.toLowerCase() === n.toLowerCase())) return setErroNome("Já existe uma unidade com esse nome.");
    if (!HEX.test(cor)) {
      setAba("dados");
      return setErroCor("Use o formato #RRGGBB, por exemplo #F26B1D.");
    }
    setSaving(true);
    try {
      let id = u?.id;
      if (nova) {
        const r = await sb.from("unidades").insert({ nome: n, cor }).select("id").single();
        if (r.error) throw r.error;
        id = r.data.id as string;
      } else if (u && (u.nome !== n || u.cor !== cor)) {
        const r = await sb.from("unidades").update({ nome: n, cor }).eq("id", u.id);
        if (r.error) throw r.error;
      }
      // desbravadores
      const antes = new Set(dados.desb.filter((d) => u && d.unidade_id === u.id).map((d) => d.id));
      const entrar = [...membros].filter((x) => !antes.has(x));
      const sair = [...antes].filter((x) => !membros.has(x));
      if (entrar.length) {
        const r = await sb.from("desbravadores").update({ unidade_id: id }).in("id", entrar);
        if (r.error) throw r.error;
      }
      if (sair.length) {
        const r = await sb.from("desbravadores").update({ unidade_id: null }).in("id", sair);
        if (r.error) throw r.error;
      }
      // conselheiros
      const antesC = new Set(dados.staff.filter((s) => u && s.unidade_id === u.id).map((s) => s.profile_id));
      const entrarC = [...cons].filter((x) => !antesC.has(x));
      const sairC = [...antesC].filter((x) => !cons.has(x));
      if (entrarC.length) {
        const r = await sb.from("unidade_staff").insert(
          entrarC.map((profile_id) => ({
            unidade_id: id,
            profile_id,
            funcao: CARGO_CONSELHEIRO,
          })),
        );
        if (r.error) throw r.error;
        await notificar(auth.userId!, entrarC, {
          tipo: "acesso",
          titulo: `Você coordena a unidade ${n}`,
          mensagem: "Veja os desbravadores da sua unidade no app.",
          link: "/unidades",
        });
      }
      if (sairC.length) {
        const r = await sb.from("unidade_staff").delete().eq("unidade_id", id).in("profile_id", sairC);
        if (r.error) throw r.error;
      }
      toast.success(nova ? `Unidade ${n} criada!` : "Unidade atualizada.");
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
        open={!!alvo}
        onClose={onClose}
        title={nova ? "Nova unidade" : `Unidade ${u?.nome || ""}`}
        description={nova ? "Depois de criar, você já pode escolher os desbravadores e os conselheiros." : undefined}
        wide
        footer={
          <>
            {u && (
              <Button variant="ghost" className="mr-auto text-red-600" icon={<Trash2 className="size-4" />} onClick={() => setExcluir(true)}>
                Excluir
              </Button>
            )}
            <Button variant="secondary" onClick={onClose}>
              Cancelar
            </Button>
            <Button onClick={salvar} loading={saving}>
              {nova ? "Criar unidade" : "Salvar"}
            </Button>
          </>
        }
      >
        <div className="mb-5">
          <Tabs
            value={aba}
            onChange={setAba}
            items={[
              { value: "dados", label: "Nome e cor" },
              {
                value: "desbravadores",
                label: "Desbravadores",
                count: membros.size,
              },
              {
                value: "conselheiros",
                label: "Conselheiros",
                count: cons.size,
              },
            ]}
          />
        </div>
        {aba === "dados" ? (
          <div className="space-y-5">
            <Input
              label="Nome da unidade"
              placeholder="Ex.: Leões"
              value={nome}
              onChange={(e) => {
                setNome(e.target.value);
                setErroNome(null);
              }}
              error={erroNome}
              required
            />
            <div>
              <div className="mb-2 text-sm font-medium text-ink-800">Cor</div>
              <div className="flex flex-wrap gap-2">
                {CORES_UNIDADE.map((c) => (
                  <button
                    key={c}
                    type="button"
                    aria-label={`Cor ${c}`}
                    aria-pressed={cor.toUpperCase() === c}
                    onClick={() => {
                      setCor(c);
                      setHex(c);
                      setErroCor(null);
                    }}
                    className={cn("size-10 rounded-xl ring-offset-2 transition", cor.toUpperCase() === c ? "ring-2 ring-ink-900" : "hover:scale-105")}
                    style={{ background: c }}
                  />
                ))}
              </div>
              <div className="mt-3 flex items-start gap-3">
                <label
                  className="relative mt-7 grid size-11 shrink-0 cursor-pointer place-items-center overflow-hidden rounded-xl border border-ink-200"
                  style={{ background: HEX.test(cor) ? cor : "#fff" }}
                  title="Escolher qualquer cor"
                >
                  <input
                    type="color"
                    aria-label="Escolher qualquer cor"
                    value={HEX.test(cor) ? cor : "#F26B1D"}
                    onChange={(e) => {
                      const v = e.target.value.toUpperCase();
                      setCor(v);
                      setHex(v);
                      setErroCor(null);
                    }}
                    className="absolute inset-0 size-full cursor-pointer opacity-0"
                  />
                </label>
                <div className="flex-1">
                  <Input
                    label="Código hexadecimal"
                    value={hex}
                    maxLength={7}
                    spellCheck={false}
                    autoCapitalize="characters"
                    placeholder="#F26B1D"
                    className="font-mono uppercase"
                    onChange={(e) => {
                      let v = e.target.value
                        .trim()
                        .toUpperCase()
                        .replace(/[^#0-9A-F]/g, "");
                      if (v && !v.startsWith("#")) v = "#" + v.replace(/#/g, "");
                      setHex(v);
                      setErroCor(null);
                      if (HEX.test(v)) setCor(v);
                    }}
                    onBlur={() => !HEX.test(hex) && setErroCor("Use o formato #RRGGBB, por exemplo #F26B1D.")}
                    error={erroCor}
                    hint={!erroCor ? "Digite o código da cor ou toque no quadrado para escolher." : undefined}
                  />
                </div>
              </div>
            </div>
          </div>
        ) : aba === "desbravadores" ? (
          dados.desb.length ? (
            <div>
              <p className="mb-3 text-sm text-ink-500">Marque quem faz parte desta unidade. Quem estava em outra unidade muda para esta.</p>
              <PickDesbravadores
                desbravadores={dados.desb.map((d) => ({
                  ...d,
                  unidade: d.unidade_id && d.unidade_id !== u?.id ? `hoje em ${nomeUnidade(d.unidade_id)}` : d.unidade,
                }))}
                selected={membros}
                onToggle={(id, v) =>
                  setMembros((s) => {
                    const n = new Set(s);
                    if (v) n.add(id);
                    else n.delete(id);
                    return n;
                  })
                }
              />
            </div>
          ) : (
            <EmptyState icon={<Users className="size-6" />} title="Nenhum desbravador cadastrado" description="Cadastre ou importe os desbravadores na página Desbravadores." />
          )
        ) : conselheiros.length ? (
          <div className="space-y-2">
            <p className="mb-1 text-sm text-ink-500">Só quem tem a função de conselheiro pode coordenar unidades.</p>
            {conselheiros.map((m) => {
              const outras = (m.unidades || [])
                .filter((x) => x.unidade_id !== u?.id)
                .map((x) => nomeUnidade(x.unidade_id))
                .filter(Boolean);
              return (
                <div key={m.id} className={cn("flex items-center gap-3 rounded-xl border px-3 py-2.5", cons.has(m.id) ? "border-ink-300 bg-white" : "border-ink-200 bg-ink-50/50")}>
                  <Checkbox
                    checked={cons.has(m.id)}
                    onChange={(v) =>
                      setCons((s) => {
                        const n = new Set(s);
                        if (v) n.add(m.id);
                        else n.delete(m.id);
                        return n;
                      })
                    }
                    label={
                      <span>
                        <span className="block font-medium">{m.nome}</span>
                        {outras.length > 0 && <span className="text-xs text-ink-500">Também em: {outras.join(", ")}</span>}
                      </span>
                    }
                  />
                </div>
              );
            })}
          </div>
        ) : (
          <EmptyState
            icon={<Users className="size-6" />}
            title="Nenhum conselheiro ainda"
            description="Na página Diretoria, dê a função de conselheiro a alguém (pode ser junto com outra função)."
            action={
              <Link href="/diretoria" className="font-semibold text-tiger-700 hover:underline">
                Ir para Diretoria
              </Link>
            }
          />
        )}
      </Sheet>
      <Confirm
        open={excluir}
        title="Excluir unidade?"
        message={
          <>
            A unidade <strong>{u?.nome}</strong> deixa de existir. Os desbravadores dela continuam cadastrados, só ficam sem unidade.
          </>
        }
        confirmLabel="Excluir unidade"
        danger
        onClose={() => setExcluir(false)}
        onConfirm={async () => {
          if (!u) return;
          const { error } = await sb.from("unidades").delete().eq("id", u.id);
          if (error) toast.error(error.message);
          else toast.success(`Unidade ${u.nome} excluída.`);
          setExcluir(false);
          onSaved();
          onClose();
        }}
      />
    </>
  );
}
