"use client";

import Link from "next/link";
import { ArrowRight, Award, BookOpen, Clock, Hourglass, ShieldCheck, UserPlus, Users } from "lucide-react";
import { useAuth } from "@/components/auth-provider";
import { Card, ClawMarks, EmptyState, ProgressBar, Skeleton } from "@/components/ui";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData } from "@/lib/use-data";
import { timeAgo } from "@/lib/format";
import type { Notificacao } from "@/lib/types";

function saudacao() {
  const h = new Date().getHours();
  return h < 12 ? "Bom dia" : h < 18 ? "Boa tarde" : "Boa noite";
}

export default function PainelPage() {
  const { profile, isAdmin, isActive, isPending, classes, staffClassIds, userId } = useAuth();
  const sb = supabaseBrowser();

  const { data, loading } = useData(async () => {
    const [desb, pend, itens, prog, notif, esps] = await Promise.all([
      isActive ? sb.from("desbravadores").select("id, class_id").eq("ativo", true) : Promise.resolve({ data: [] }),
      isAdmin ? sb.from("profiles").select("id", { count: "exact", head: true }).eq("status", "pendente") : Promise.resolve({ count: 0 }),
      sb.from("caderno_itens").select("id, class_id").eq("avancada", false),
      isActive ? sb.from("caderno_progresso").select("desbravador_id, item_id").eq("status", "feito") : Promise.resolve({ data: [] }),
      sb.from("notificacoes").select("*").eq("destinatario_id", userId!).order("created_at", { ascending: false }).limit(5),
      isActive ? sb.from("desbravador_especialidades").select("desbravador_id", { count: "exact", head: true }).eq("status", "concluida") : Promise.resolve({ count: 0 }),
    ]);
    return {
      desb: (desb.data || []) as { id: string; class_id: number }[],
      pendentes: (pend as { count: number | null }).count || 0,
      itens: (itens.data || []) as { id: number; class_id: number }[],
      prog: (prog.data || []) as { desbravador_id: string; item_id: number }[],
      notif: (notif.data || []) as Notificacao[],
      especialidades: (esps as { count: number | null }).count || 0,
    };
  }, [isActive, isAdmin, userId]);

  const minhas = classes.filter((c) => (isAdmin ? true : staffClassIds.includes(c.id)));

  function progressoClasse(cid: number) {
    if (!data) return { n: 0, pct: 0 };
    const ds = data.desb.filter((d) => d.class_id === cid);
    const its = data.itens.filter((i) => i.class_id === cid);
    if (!ds.length || !its.length) return { n: ds.length, pct: 0 };
    const ids = new Set(ds.map((d) => d.id));
    const itemIds = new Set(its.map((i) => i.id));
    const feitos = data.prog.filter((p) => ids.has(p.desbravador_id) && itemIds.has(p.item_id)).length;
    return { n: ds.length, pct: (feitos / (ds.length * its.length)) * 100 };
  }

  return (
    <div className="space-y-8">
      {/* Boas-vindas */}
      <section className="relative overflow-hidden rounded-3xl bg-ink-900 px-6 py-7 text-white sm:px-8 sm:py-9">
        <ClawMarks className="pointer-events-none absolute -right-8 -top-10 h-56 w-56 rotate-[20deg] text-tiger-500/25 sm:h-72 sm:w-72" />
        <div className="relative">
          <div className="text-sm font-medium text-tiger-300">{saudacao()},</div>
          <h1 className="mt-1 font-display text-3xl font-semibold uppercase tracking-wide sm:text-4xl">{profile?.nome.split(" ")[0]}</h1>
          <p className="mt-2 max-w-xl text-ink-300">
            {isPending
              ? "Seu cadastro está na lista de espera. Enquanto isso, você já pode consultar os cadernos e as especialidades."
              : isAdmin
              ? "Você tem acesso completo ao clube: classes, desbravadores, diretoria e relatórios."
              : staffClassIds.length
              ? "Acompanhe sua classe, marque o caderno e registre as especialidades."
              : "Seu acesso está ativo. Peça ao diretor para vincular você a uma classe."}
          </p>
        </div>
      </section>

      {isPending && (
        <Card className="flex items-start gap-4 border-amber-200 bg-amber-50 p-5">
          <div className="grid size-11 shrink-0 place-items-center rounded-xl bg-amber-100 text-amber-700">
            <Hourglass className="size-5" />
          </div>
          <div>
            <h2 className="font-semibold text-amber-900">Aguardando aprovação do diretor</h2>
            <p className="mt-0.5 text-sm text-amber-800">
              Assim que o diretor escolher sua classe, você recebe uma notificação e passa a marcar o caderno e as especialidades dos desbravadores.
            </p>
          </div>
        </Card>
      )}

      {/* Números */}
      {isActive && (
        <section className="grid grid-cols-2 gap-3 lg:grid-cols-4">
          {[
            { label: "Desbravadores", value: data?.desb.length, icon: Users, href: "/desbravadores" },
            { label: "Especialidades concluídas", value: data?.especialidades, icon: Award, href: "/especialidades" },
            { label: isAdmin ? "Classes" : "Minhas classes", value: minhas.length, icon: BookOpen, href: "/classes" },
            ...(isAdmin ? [{ label: "Na lista de espera", value: data?.pendentes, icon: Clock, href: "/diretoria" }] : []),
          ].map((s) => (
            <Link key={s.label} href={s.href} className="group">
              <Card className="h-full p-4 transition-shadow group-hover:shadow-lift sm:p-5">
                <s.icon className="size-5 text-tiger-600" />
                <div className="mt-3 font-display text-3xl font-semibold text-ink-900">{loading ? <Skeleton className="h-8 w-12" /> : s.value ?? 0}</div>
                <div className="mt-0.5 text-sm text-ink-500">{s.label}</div>
              </Card>
            </Link>
          ))}
        </section>
      )}

      <div className="grid gap-8 lg:grid-cols-[1.4fr_1fr]">
        {/* Classes */}
        <section>
          <div className="mb-3 flex items-center justify-between">
            <h2 className="font-display text-xl font-semibold uppercase tracking-wide">{isAdmin || isPending ? "Classes" : "Minhas classes"}</h2>
            <Link href="/classes" className="text-sm font-semibold text-tiger-700 hover:underline">
              Ver todas
            </Link>
          </div>
          {(isPending ? classes : minhas).length === 0 ? (
            <EmptyState icon={<BookOpen className="size-6" />} title="Nenhuma classe vinculada" description="O diretor ainda não vinculou você a uma classe." />
          ) : (
            <div className="grid gap-3 sm:grid-cols-2">
              {(isPending ? classes : minhas).map((c) => {
                const p = progressoClasse(c.id);
                return (
                  <Link key={c.id} href={`/classes/${c.slug}`} className="group">
                    <Card className="relative overflow-hidden p-4 transition-shadow group-hover:shadow-lift">
                      <span className="absolute inset-y-0 left-0 w-1.5" style={{ background: c.cor }} />
                      <div className="flex items-center justify-between pl-2">
                        <div>
                          <div className="font-display text-lg font-semibold uppercase tracking-wide">{c.nome}</div>
                          <div className="text-xs text-ink-500">{isActive ? `${p.n} desbravador(es)` : `A partir de ${c.idade_minima} anos`}</div>
                        </div>
                        <ArrowRight className="size-4 text-ink-400 transition-transform group-hover:translate-x-0.5" />
                      </div>
                      {isActive && (
                        <div className="mt-3 pl-2">
                          <ProgressBar value={p.pct} color={c.cor} />
                          <div className="mt-1 text-xs text-ink-500">{Math.round(p.pct)}% do caderno concluído</div>
                        </div>
                      )}
                    </Card>
                  </Link>
                );
              })}
            </div>
          )}
        </section>

        {/* Notificações e atalhos */}
        <section className="space-y-6">
          <div>
            <div className="mb-3 flex items-center justify-between">
              <h2 className="font-display text-xl font-semibold uppercase tracking-wide">Recentes</h2>
              <Link href="/notificacoes" className="text-sm font-semibold text-tiger-700 hover:underline">
                Ver todas
              </Link>
            </div>
            <Card className="divide-y divide-ink-100">
              {loading && <div className="space-y-2 p-4"><Skeleton className="h-4 w-2/3" /><Skeleton className="h-4 w-1/2" /></div>}
              {!loading && !data?.notif.length && <p className="p-5 text-sm text-ink-500">Nenhuma notificação por enquanto.</p>}
              {data?.notif.map((n) => (
                <Link key={n.id} href={n.link || "/notificacoes"} className="flex gap-3 p-4 hover:bg-ink-50">
                  <span className={`mt-1.5 size-2 shrink-0 rounded-full ${n.lida_em ? "bg-transparent" : "bg-tiger-500"}`} />
                  <div className="min-w-0 flex-1">
                    <div className="truncate text-sm font-semibold">{n.titulo}</div>
                    {n.mensagem && <div className="line-clamp-2 text-sm text-ink-500">{n.mensagem}</div>}
                  </div>
                  <span className="shrink-0 text-xs text-ink-400">{timeAgo(n.created_at)}</span>
                </Link>
              ))}
            </Card>
          </div>
          {isActive && (
            <div className="grid gap-2">
              <Link href="/desbravadores?novo=1" className="flex items-center gap-3 rounded-2xl border border-ink-200 bg-white p-4 font-semibold hover:border-tiger-300 hover:bg-tiger-50">
                <UserPlus className="size-5 text-tiger-600" /> Cadastrar desbravador
              </Link>
              {isAdmin && (
                <Link href="/diretoria" className="flex items-center gap-3 rounded-2xl border border-ink-200 bg-white p-4 font-semibold hover:border-tiger-300 hover:bg-tiger-50">
                  <ShieldCheck className="size-5 text-tiger-600" /> Gerenciar diretoria e lista de espera
                </Link>
              )}
            </div>
          )}
        </section>
      </div>
    </div>
  );
}
