"use client";

import { useMemo, useState } from "react";
import { useParams } from "next/navigation";
import { Award, BookOpen, Check, ChevronDown, Clock, Download, HandCoins, Library, RotateCcw } from "lucide-react";
import { Card, ClawMarks, ProgressBar, Skeleton, cn } from "@/components/ui";
import { EspIcon } from "@/components/domain";
import { useData } from "@/lib/use-data";
import { carregarAcompanhamento, type AcompanhamentoDados } from "@/lib/acompanhamento";
import { isoToBr } from "@/lib/format";
import { tamanhoTexto } from "@/lib/anexos";
import { reais } from "@/lib/pix";
import { PixBox } from "@/components/pix-box";

type Item = AcompanhamentoDados["itens"][number];

const situacao = (i: Pick<Item, "status" | "validacao">) => (i.status === "feito" ? (i.validacao === "pendente" ? "aguardando" : "feito") : i.status === "refazer" ? "refazer" : "falta");

/** Página que os responsáveis abrem pelo link (sem login): só o progresso do desbravador. */
export default function AcompanharPage() {
  const { token } = useParams<{ token: string }>();
  const { data, loading, error } = useData(() => carregarAcompanhamento(token), [token]);

  return (
    <main className="min-h-dvh bg-ink-50">
      <header className="relative overflow-hidden bg-gradient-to-br from-tiger-600 via-tiger-700 to-[#7a2a08] px-4 pb-20 pt-[max(1.5rem,env(safe-area-inset-top))] text-white">
        <ClawMarks className="pointer-events-none absolute -right-10 -top-6 h-[260px] w-[260px] rotate-[18deg] text-black/10" />
        <div className="relative mx-auto flex max-w-3xl items-center gap-3">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/brand/logo.webp" alt="Tigres do Riacho" width={56} height={56} className="size-14 drop-shadow-lg" />
          <div>
            <div className="font-display text-xl font-semibold uppercase leading-none tracking-wide">Tigres do Riacho</div>
            <div className="mt-1 text-sm text-white/75">Acompanhamento do desbravador</div>
          </div>
        </div>
      </header>
      <div className="relative mx-auto -mt-14 max-w-3xl px-4 pb-[max(2rem,env(safe-area-inset-bottom))]">
        {loading ? (
          <div className="space-y-4">
            <Skeleton className="h-36" />
            <Skeleton className="h-64" />
          </div>
        ) : error || !data ? (
          <Card className="p-6 text-center">
            <h1 className="font-display text-2xl font-semibold uppercase tracking-wide">Link indisponível</h1>
            <p className="mt-2 text-sm text-ink-600">
              {error ? "Não conseguimos carregar agora. Tente de novo em alguns minutos." : "Este link não existe mais ou foi trocado. Peça o link novo ao conselheiro ou à diretoria do clube."}
            </p>
          </Card>
        ) : (
          <Conteudo d={data} token={token} />
        )}
      </div>
    </main>
  );
}

function Conteudo({ d, token }: { d: AcompanhamentoDados; token: string }) {
  const [abertas, setAbertas] = useState<Record<string, boolean>>({});
  const regular = d.itens.filter((i) => !i.avancada);
  const avancada = d.itens.filter((i) => i.avancada);
  const pct = (lista: Item[]) => (lista.length ? (lista.filter((i) => situacao(i) === "feito").length / lista.length) * 100 : 0);
  const concluidas = d.especialidades.filter((e) => e.status === "concluida" && e.validacao === "aprovada");
  const escolhas = useMemo(() => {
    const m = new Map<number, string[]>();
    d.escolhas.forEach((e) => m.set(e.item_id, [...(m.get(e.item_id) || []), e.nome]));
    return m;
  }, [d.escolhas]);
  const secoes = useMemo(() => {
    const m = new Map<string, Item[]>();
    d.itens.forEach((i) => m.set(i.secao, [...(m.get(i.secao) || []), i]));
    return [...m.entries()];
  }, [d.itens]);

  return (
    <div className="space-y-6">
      <Card className="relative overflow-hidden p-5 sm:p-6">
        <span className="absolute inset-x-0 top-0 h-1.5" style={{ background: d.classe_cor || "#F26B1D" }} />
        <h1 className="font-display text-3xl font-semibold uppercase leading-tight tracking-wide">{d.nome}</h1>
        <div className="mt-1 flex flex-wrap gap-x-4 gap-y-1 text-sm text-ink-500">
          <span>{d.classe ? `Classe de ${d.classe}` : "Sem classe"}</span>
          {d.unidade && (
            <span className="inline-flex items-center gap-1.5">
              <span className="size-2.5 rounded-sm" style={{ background: d.unidade_cor || "#ccc" }} />
              Unidade {d.unidade}
            </span>
          )}
        </div>
        <div className="mt-5 grid gap-4 sm:grid-cols-3">
          <Resumo titulo="Caderno da classe" valor={`${Math.round(pct(regular))}%`} pct={pct(regular)} cor={d.classe_cor} />
          {avancada.length > 0 && <Resumo titulo="Classe avançada" valor={`${Math.round(pct(avancada))}%`} pct={pct(avancada)} cor={d.classe_cor} />}
          <div>
            <div className="text-xs font-semibold uppercase tracking-wide text-ink-400">Especialidades</div>
            <div className="mt-1 font-display text-3xl font-semibold">{concluidas.length}</div>
            <div className="text-xs text-ink-500">concluídas e validadas</div>
          </div>
        </div>
      </Card>

      <section>
        <h2 className="mb-3 font-display text-xl font-semibold uppercase tracking-wide">Especialidades</h2>
        {!d.especialidades.length ? (
          <Card className="p-6 text-center text-sm text-ink-500">
            <Award className="mx-auto mb-2 size-6 text-ink-300" />
            Nenhuma especialidade registrada ainda.
          </Card>
        ) : (
          <div className="grid grid-cols-2 gap-2 sm:grid-cols-4">
            {d.especialidades.map((e) => (
              <Card key={e.codigo} className="flex flex-col items-center p-3 text-center">
                <EspIcon esp={e} size={56} />
                <div className="mt-2 line-clamp-2 text-xs font-semibold leading-snug">{e.nome}</div>
                <div className="mt-1 text-[11px]">
                  {e.status === "refazer" ? (
                    <span className="font-semibold text-red-600">Em revisão</span>
                  ) : e.validacao === "pendente" ? (
                    <span className="inline-flex items-center gap-1 font-semibold text-amber-700">
                      <Clock className="size-3" /> Aguardando validação
                    </span>
                  ) : (
                    <span className="inline-flex items-center gap-1 text-emerald-700">
                      <Check className="size-3" /> {isoToBr(e.concluida_em)}
                    </span>
                  )}
                </div>
              </Card>
            ))}
          </div>
        )}
      </section>

      <section>
        <h2 className="mb-3 font-display text-xl font-semibold uppercase tracking-wide">Caderno</h2>
        {!secoes.length && <Card className="p-6 text-center text-sm text-ink-500">O desbravador ainda não está em uma classe.</Card>}
        <div className="space-y-2.5">
          {secoes.map(([secao, itens]) => {
            const feitos = itens.filter((i) => situacao(i) === "feito").length;
            const aberto = abertas[secao] ?? false;
            return (
              <Card key={secao} className="overflow-hidden">
                <button onClick={() => setAbertas((a) => ({ ...a, [secao]: !aberto }))} className="flex w-full items-center gap-3 px-4 py-3 text-left hover:bg-ink-50/70" aria-expanded={aberto}>
                  <div className="min-w-0 flex-1">
                    <div className="truncate font-semibold text-ink-900">{secao}</div>
                    <div className="text-xs text-ink-500">
                      {feitos} de {itens.length} concluídos
                    </div>
                  </div>
                  <div className="hidden w-28 sm:block">
                    <ProgressBar value={(feitos / itens.length) * 100} color={d.classe_cor || undefined} />
                  </div>
                  <ChevronDown className={cn("size-4 shrink-0 text-ink-400 transition-transform", aberto && "rotate-180")} />
                </button>
                {aberto && (
                  <ul className="divide-y divide-ink-100 border-t border-ink-100">
                    {itens.map((i) => {
                      const s = situacao(i);
                      return (
                        <li key={i.id} className="flex gap-3 px-4 py-2.5 text-sm">
                          <span
                            className={cn(
                              "mt-0.5 grid size-5 shrink-0 place-items-center rounded-md border-2",
                              s === "feito"
                                ? "border-tiger-500 bg-tiger-500 text-white"
                                : s === "aguardando"
                                  ? "border-amber-400 bg-amber-50 text-amber-600"
                                  : s === "refazer"
                                    ? "border-red-400 bg-red-50 text-red-600"
                                    : "border-ink-300 bg-white",
                            )}
                          >
                            {s === "feito" ? (
                              <Check className="size-3" strokeWidth={3} />
                            ) : s === "aguardando" ? (
                              <Clock className="size-3" />
                            ) : s === "refazer" ? (
                              <RotateCcw className="size-3" />
                            ) : null}
                          </span>
                          <div className="min-w-0">
                            <span className="mr-1.5 font-mono text-xs font-semibold text-ink-400">{i.codigo}</span>
                            <span className={s === "feito" ? "text-ink-500" : "text-ink-800"}>{i.texto}</span>
                            {escolhas.get(i.id) && <div className="mt-0.5 text-xs font-medium text-tiger-700">Especialidade escolhida: {escolhas.get(i.id)!.join(", ")}</div>}
                            {s === "aguardando" && <div className="mt-0.5 text-xs text-amber-700">Aguardando validação do diretor</div>}
                            {s === "refazer" && <div className="mt-0.5 text-xs text-red-700">Precisa ser refeito</div>}
                          </div>
                        </li>
                      );
                    })}
                  </ul>
                )}
              </Card>
            );
          })}
        </div>
      </section>
      <DoClube token={token} />
      <p className="text-center text-xs text-ink-400">Dúvidas? Fale com o conselheiro ou com a diretoria do clube.</p>
    </div>
  );
}

function Resumo({ titulo, valor, pct, cor }: { titulo: string; valor: string; pct: number; cor: string | null }) {
  return (
    <div>
      <div className="text-xs font-semibold uppercase tracking-wide text-ink-400">{titulo}</div>
      <div className="mt-1 font-display text-3xl font-semibold">{valor}</div>
      <ProgressBar value={pct} color={cor || undefined} />
    </div>
  );
}

type LivroFamilia = { id: string; titulo: string; autor: string | null; descricao: string | null; categoria: string | null; capa: string | null; pdf: string; pdf_tamanho: number | null };
type VaquinhaFamilia = {
  id: string;
  titulo: string;
  descricao: string | null;
  meta: number;
  arrecadado: number;
  contribuicoes: number;
  prazo: string | null;
  pix_chave: string | null;
  pix_nome: string | null;
  pix_cidade: string | null;
};

/** Biblioteca online e vaquinhas abertas (vêm do servidor com links temporários). */
function DoClube({ token }: { token: string }) {
  const { data } = useData(async () => {
    const r = await fetch(`/api/familia/${token}`, { cache: "no-store" });
    if (!r.ok) return null;
    return (await r.json()) as { livros: LivroFamilia[]; vaquinhas: VaquinhaFamilia[] };
  }, [token]);
  const [todos, setTodos] = useState(false);
  if (!data || (!data.livros.length && !data.vaquinhas.length)) return null;
  const livros = todos ? data.livros : data.livros.slice(0, 8);
  return (
    <>
      {data.vaquinhas.length > 0 && (
        <section>
          <h2 className="mb-3 flex items-center gap-2 font-display text-xl font-semibold uppercase tracking-wide">
            <HandCoins className="size-5 text-tiger-600" /> Vaquinhas do clube
          </h2>
          <div className="space-y-3">
            {data.vaquinhas.map((v) => {
              const pct = v.meta > 0 ? (v.arrecadado / v.meta) * 100 : 0;
              return (
                <Card key={v.id} className="p-4 sm:p-5">
                  <h3 className="font-display text-xl font-semibold uppercase leading-tight tracking-wide">{v.titulo}</h3>
                  {v.descricao && <p className="mt-1 text-sm text-ink-600">{v.descricao}</p>}
                  <div className="mt-3 flex items-end justify-between gap-3">
                    <div>
                      <div className="font-display text-2xl font-semibold">{reais(v.arrecadado)}</div>
                      <div className="text-xs text-ink-500">
                        de {reais(v.meta)}
                        {v.prazo ? ` · até ${isoToBr(v.prazo)}` : ""}
                      </div>
                    </div>
                    <div className={cn("font-display text-2xl font-semibold", pct >= 100 ? "text-emerald-600" : "text-tiger-600")}>{Math.floor(pct)}%</div>
                  </div>
                  <div className="mt-2">
                    <ProgressBar value={pct} color={pct >= 100 ? "#059669" : undefined} />
                  </div>
                  {v.pix_chave && <PixBox className="mt-3" chave={v.pix_chave} nome={v.pix_nome} cidade={v.pix_cidade} descricao={v.titulo} />}
                </Card>
              );
            })}
          </div>
        </section>
      )}
      {data.livros.length > 0 && (
        <section>
          <h2 className="mb-1 flex items-center gap-2 font-display text-xl font-semibold uppercase tracking-wide">
            <Library className="size-5 text-tiger-600" /> Biblioteca do clube
          </h2>
          <p className="mb-3 text-sm text-ink-500">Livros em PDF para ler no celular ou imprimir.</p>
          <div className="grid grid-cols-2 gap-x-4 gap-y-5 sm:grid-cols-4">
            {livros.map((l) => (
              <div key={l.id} className="flex min-w-0 flex-col">
                <div className="aspect-[2/3] overflow-hidden rounded-lg bg-ink-100 shadow-[0_1px_2px_rgba(0,0,0,.12),0_6px_16px_-6px_rgba(0,0,0,.35)]">
                  {l.capa ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img src={l.capa} alt={`Capa de ${l.titulo}`} className="size-full object-cover" loading="lazy" />
                  ) : (
                    <div className="flex size-full flex-col justify-between bg-gradient-to-br from-tiger-700 to-[#1f140d] p-3 text-white">
                      <BookOpen className="size-5 opacity-70" aria-hidden />
                      <div className="line-clamp-4 font-display text-base font-semibold uppercase leading-tight">{l.titulo}</div>
                    </div>
                  )}
                </div>
                <h3 className="mt-2 line-clamp-2 text-sm font-semibold leading-snug">{l.titulo}</h3>
                {l.autor && <p className="truncate text-xs text-ink-500">{l.autor}</p>}
                <div className="mt-auto pt-2.5">
                  <a href={l.pdf} className="flex h-9 items-center justify-center gap-1.5 rounded-xl bg-tiger-500 px-3 text-sm font-semibold text-white hover:bg-tiger-600">
                    <Download className="size-4" /> Baixar PDF
                  </a>
                  {l.pdf_tamanho ? <div className="mt-1 text-center text-[11px] text-ink-400">{tamanhoTexto(l.pdf_tamanho)}</div> : null}
                </div>
              </div>
            ))}
          </div>
          {data.livros.length > livros.length && (
            <button className="mt-4 w-full rounded-xl border border-ink-200 bg-white py-2.5 text-sm font-semibold text-ink-700" onClick={() => setTodos(true)}>
              Ver todos os livros ({data.livros.length})
            </button>
          )}
        </section>
      )}
    </>
  );
}
