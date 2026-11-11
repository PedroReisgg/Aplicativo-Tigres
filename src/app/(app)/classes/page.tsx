"use client";

import Link from "next/link";
import { ArrowRight, Lock } from "lucide-react";
import { useAuth } from "@/components/auth-provider";
import { Card, PageHeader } from "@/components/ui";

export default function ClassesPage() {
  const { classes, canManageClass, isActive } = useAuth();
  return (
    <div>
      <PageHeader
        eyebrow="Cartões de classe"
        title="Classes"
        description="Da classe de Amigo até Guia. Abra uma classe para ver o caderno, as especialidades obrigatórias e o progresso de cada desbravador."
      />
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {classes.map((c, i) => (
          <Link key={c.id} href={`/classes/${c.slug}`} className="group animate-fade-up" style={{ animationDelay: `${i * 40}ms` }}>
            <Card className="relative h-full overflow-hidden transition-shadow group-hover:shadow-lift">
              <div className="relative h-24 overflow-hidden" style={{ background: c.cor }}>
                <span className="absolute -bottom-6 right-3 font-display text-[92px] font-bold leading-none text-white/15">{String(i + 1).padStart(2, "0")}</span>
                <div className="absolute bottom-3 left-4 rounded-full bg-black/20 px-2.5 py-1 text-xs font-semibold text-white">{c.idade_minima} anos</div>
              </div>
              <div className="flex items-start justify-between gap-3 p-4">
                <div>
                  <h2 className="font-display text-2xl font-semibold uppercase tracking-wide">{c.nome}</h2>
                  <p className="text-sm text-ink-500">Avançada: {c.classe_avancada}</p>
                </div>
                {isActive && !canManageClass(c.id) ? (
                  <span className="mt-1 inline-flex items-center gap-1 rounded-full bg-ink-100 px-2 py-0.5 text-[11px] font-semibold text-ink-500">
                    <Lock className="size-3" /> Consulta
                  </span>
                ) : (
                  <ArrowRight className="mt-1.5 size-5 text-ink-400 transition-transform group-hover:translate-x-0.5" />
                )}
              </div>
            </Card>
          </Link>
        ))}
      </div>
    </div>
  );
}
