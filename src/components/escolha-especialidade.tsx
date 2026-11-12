"use client";

import { useEffect, useMemo, useState } from "react";
import { Check, Clock, Pencil, Plus, RotateCcw } from "lucide-react";
import { toast } from "sonner";
import { Avatar, Button, SearchInput, Sheet, cn } from "./ui";
import { EspIcon } from "./domain";
import { normalize } from "@/lib/format";
import { SITUACAO_TEXTO, salvarEscolha, situacaoEsp, type Escolha, type RegraEscolha, type SituacaoEsp } from "@/lib/escolhas";
import type { CadernoItem, Categoria, DesbEsp, Desbravador, Especialidade } from "@/lib/types";

const COR_SITUACAO: Record<SituacaoEsp, string> = {
  concluida: "text-emerald-700",
  aguardando: "text-amber-700",
  refazer: "text-red-600",
  "a-fazer": "text-ink-400",
};

function IconeSituacao({ s }: { s: SituacaoEsp }) {
  if (s === "concluida") return <Check className="size-3" />;
  if (s === "aguardando") return <Clock className="size-3" />;
  if (s === "refazer") return <RotateCcw className="size-3" />;
  return null;
}

/** Especialidade(s) escolhida(s) para um item, com a situação de cada uma. */
export function EscolhaChips({ codigos, espMap, desbEsp, desbravadorId }: { codigos: string[]; espMap: Map<string, Especialidade>; desbEsp: DesbEsp[]; desbravadorId: string }) {
  return (
    <span className="inline-flex flex-wrap gap-1.5">
      {codigos.map((c) => {
        const e = espMap.get(c);
        const s = situacaoEsp(desbEsp, desbravadorId, c);
        return (
          <span key={c} className="inline-flex items-center gap-1.5 rounded-full border border-tiger-200 bg-tiger-50/70 py-0.5 pl-0.5 pr-2.5 text-xs font-medium text-ink-800">
            {e && <EspIcon esp={e} size={20} />}
            {e?.nome || c}
            <span className={cn("inline-flex items-center gap-0.5 text-[11px] font-semibold", COR_SITUACAO[s])}>
              <IconeSituacao s={s} />
              {SITUACAO_TEXTO[s]}
            </span>
          </span>
        );
      })}
    </span>
  );
}

/** Escolhe (ou troca) a especialidade de um item do caderno para um desbravador. */
export function EscolherEspSheet({
  open,
  onClose,
  item,
  regra,
  desbravador,
  atuais,
  categorias,
  desbEsp,
  userId,
  onSaved,
}: {
  open: boolean;
  onClose: () => void;
  item: CadernoItem | null;
  regra: RegraEscolha | null;
  desbravador: Desbravador | null;
  atuais: string[];
  categorias: Categoria[];
  desbEsp: DesbEsp[];
  userId: string | null;
  onSaved: () => void;
}) {
  const [sel, setSel] = useState<string[]>([]);
  const [q, setQ] = useState("");
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (open) {
      setSel(atuais);
      setQ("");
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open, desbravador?.id, item?.id]);

  const grupos = useMemo(() => {
    if (!regra) return [];
    const lista = regra.opcoes.filter((e) => !q || normalize(`${e.nome} ${e.codigo}`).includes(normalize(q)));
    return categorias
      .filter((c) => regra.areas.includes(c.slug))
      .map((c) => ({ c, esps: lista.filter((e) => e.categoria_slug === c.slug).sort((a, b) => a.nome.localeCompare(b.nome, "pt-BR")) }))
      .filter((g) => g.esps.length);
  }, [regra, categorias, q]);

  if (!item || !regra || !desbravador) return null;
  const qtd = regra.quantidade;

  function alternar(codigo: string) {
    setSel((s) => (s.includes(codigo) ? s.filter((x) => x !== codigo) : qtd === 1 ? [codigo] : s.length >= qtd ? [...s.slice(1), codigo] : [...s, codigo]));
  }

  async function salvar(codigos: string[]) {
    if (!desbravador || !item) return;
    setSaving(true);
    try {
      await salvarEscolha(desbravador.id, item.id, codigos, userId);
      toast.success(codigos.length ? "Especialidade guardada no caderno." : "Escolha removida.");
      onSaved();
      onClose();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setSaving(false);
    }
  }

  const mudou = sel.length !== atuais.length || sel.some((c) => !atuais.includes(c));

  return (
    <Sheet
      open={open}
      onClose={onClose}
      title={atuais.length ? "Trocar especialidade" : "Escolher especialidade"}
      description={`${desbravador.nome} · item ${item.codigo}`}
      footer={
        <>
          {atuais.length > 0 && (
            <Button variant="ghost" className="mr-auto text-red-600" onClick={() => salvar([])} disabled={saving}>
              Remover escolha
            </Button>
          )}
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
          <Button onClick={() => salvar(sel)} loading={saving} disabled={!sel.length || !mudou}>
            {qtd > 1 ? `Guardar ${sel.length}/${qtd}` : "Guardar"}
          </Button>
        </>
      }
    >
      <p className="mb-3 rounded-2xl bg-ink-50 p-3 text-sm text-ink-700">{item.texto}</p>
      <p className="mb-3 text-sm text-ink-500">{qtd > 1 ? `Escolha ${qtd} especialidades.` : "Escolha uma especialidade."} Dá para trocar depois, se ele mudar de ideia.</p>
      <SearchInput value={q} onChange={setQ} placeholder="Buscar especialidade…" />
      <div className="mt-3 space-y-4">
        {grupos.map(({ c, esps }) => (
          <section key={c.slug}>
            {grupos.length > 1 && (
              <h3 className="sticky top-0 z-[1] mb-1.5 flex items-center gap-2 bg-white py-1 text-xs font-semibold uppercase tracking-[.12em] text-ink-500">
                <span className="size-2.5 rounded-full" style={{ background: c.cor }} />
                {c.nome}
              </h3>
            )}
            <ul className="space-y-1">
              {esps.map((e) => {
                const on = sel.includes(e.codigo);
                const s = situacaoEsp(desbEsp, desbravador.id, e.codigo);
                return (
                  <li key={e.codigo}>
                    <button
                      onClick={() => alternar(e.codigo)}
                      aria-pressed={on}
                      className={cn(
                        "flex w-full items-center gap-3 rounded-xl border px-2.5 py-2 text-left transition-colors",
                        on ? "border-tiger-400 bg-tiger-50" : "border-transparent hover:bg-ink-50",
                      )}
                    >
                      <EspIcon esp={e} size={36} />
                      <span className="min-w-0 flex-1">
                        <span className="block truncate text-sm font-semibold text-ink-900">{e.nome}</span>
                        <span className="text-xs text-ink-400">
                          {e.codigo}
                          {s !== "a-fazer" && <span className={cn("ml-1.5 font-semibold", COR_SITUACAO[s])}>· já {SITUACAO_TEXTO[s]}</span>}
                        </span>
                      </span>
                      <span className={cn("grid size-6 shrink-0 place-items-center rounded-full border-2", on ? "border-tiger-500 bg-tiger-500 text-white" : "border-ink-300")}>
                        {on && <Check className="size-3.5" strokeWidth={3} />}
                      </span>
                    </button>
                  </li>
                );
              })}
            </ul>
          </section>
        ))}
        {!grupos.length && <p className="py-6 text-center text-sm text-ink-500">Nenhuma especialidade encontrada.</p>}
      </div>
    </Sheet>
  );
}

/** Lista da turma para um item: quem já escolheu e qual especialidade. */
export function EscolhasTurmaSheet({
  open,
  onClose,
  item,
  regra,
  desb,
  escolhas,
  espMap,
  categorias,
  desbEsp,
  userId,
  podeEscolher,
  onSaved,
}: {
  open: boolean;
  onClose: () => void;
  item: CadernoItem | null;
  regra: RegraEscolha | null;
  desb: Desbravador[];
  escolhas: Escolha[];
  espMap: Map<string, Especialidade>;
  categorias: Categoria[];
  desbEsp: DesbEsp[];
  userId: string | null;
  podeEscolher: (d: Desbravador) => boolean;
  onSaved: () => void;
}) {
  const [quem, setQuem] = useState<Desbravador | null>(null);
  if (!item || !regra) return null;
  const doItem = (id: string) => escolhas.filter((e) => e.item_id === item.id && e.desbravador_id === id).map((e) => e.especialidade_codigo);
  const comEscolha = desb.filter((d) => doItem(d.id).length).length;

  return (
    <>
      <Sheet open={open && !quem} onClose={onClose} title={`Especialidades do item ${item.codigo}`} description={`${comEscolha} de ${desb.length} já escolheram`}>
        <p className="mb-4 rounded-2xl bg-ink-50 p-3 text-sm text-ink-700">{item.texto}</p>
        <ul className="divide-y divide-ink-100">
          {desb.map((d) => {
            const atuais = doItem(d.id);
            return (
              <li key={d.id} className="flex items-center gap-3 py-2.5">
                <Avatar nome={d.nome} color={d.classe_cor} size={34} />
                <div className="min-w-0 flex-1">
                  <div className="truncate text-sm font-semibold text-ink-900">{d.nome}</div>
                  {atuais.length ? (
                    <div className="mt-1">
                      <EscolhaChips codigos={atuais} espMap={espMap} desbEsp={desbEsp} desbravadorId={d.id} />
                    </div>
                  ) : (
                    <div className="text-xs text-ink-400">Ainda não escolheu</div>
                  )}
                </div>
                {podeEscolher(d) && (
                  <Button size="sm" variant={atuais.length ? "secondary" : "primary"} icon={atuais.length ? <Pencil className="size-3.5" /> : <Plus className="size-4" />} onClick={() => setQuem(d)}>
                    {atuais.length ? "Trocar" : "Escolher"}
                  </Button>
                )}
              </li>
            );
          })}
        </ul>
      </Sheet>
      <EscolherEspSheet
        open={open && !!quem}
        onClose={() => setQuem(null)}
        item={item}
        regra={regra}
        desbravador={quem}
        atuais={quem ? doItem(quem.id) : []}
        categorias={categorias}
        desbEsp={desbEsp}
        userId={userId}
        onSaved={onSaved}
      />
    </>
  );
}
