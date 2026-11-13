"use client";

import Link from "next/link";
import { AgendaCalendario } from "@/components/agenda-calendario";
import { Button, ClawMarks, EmptyState, Skeleton } from "@/components/ui";
import { useData } from "@/lib/use-data";
import { getEventos } from "@/lib/agenda";

/** Agenda pública do clube: qualquer pessoa com o link vê (sem cadastro). */
export default function CalendarioPublico() {
  const { data, loading, error, reload } = useData(getEventos, []);
  return (
    <main className="min-h-dvh bg-ink-50">
      <header className="relative overflow-hidden bg-gradient-to-br from-tiger-600 via-tiger-700 to-[#7a2a08] px-4 pb-6 pt-[max(1.5rem,env(safe-area-inset-top))] text-white">
        <ClawMarks className="pointer-events-none absolute -right-10 -top-6 h-[260px] w-[260px] rotate-[18deg] text-black/10" />
        <div className="relative mx-auto flex max-w-5xl items-center gap-3">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/brand/logo.webp" alt="Tigres do Riacho" width={56} height={56} className="size-14 drop-shadow-lg" />
          <div className="min-w-0 flex-1">
            <div className="font-display text-xl font-semibold uppercase leading-none tracking-wide">Tigres do Riacho</div>
            <div className="mt-1 text-sm text-white/75">Agenda do clube</div>
          </div>
          <Link href="/entrar" className="shrink-0 rounded-xl bg-white/15 px-3 py-2 text-sm font-semibold hover:bg-white/25">
            Diretoria
          </Link>
        </div>
      </header>
      <div className="mx-auto max-w-5xl px-4 pb-[max(2rem,env(safe-area-inset-bottom))] pt-5">
        <div>
          {loading ? (
            <div className="space-y-3">
              <Skeleton className="h-10" />
              <Skeleton className="h-96" />
            </div>
          ) : error || !data ? (
            <EmptyState title="Não foi possível abrir a agenda" description="Tente de novo em alguns instantes." action={<Button onClick={() => reload()}>Tentar de novo</Button>} />
          ) : (
            <AgendaCalendario eventos={data} />
          )}
        </div>
      </div>
    </main>
  );
}
