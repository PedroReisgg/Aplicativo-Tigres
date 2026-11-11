"use client";

import Link from "next/link";
import { useMemo, useState } from "react";
import { ArrowRight } from "lucide-react";
import { Card, PageHeader, SearchInput, Skeleton } from "@/components/ui";
import { EspIcon } from "@/components/domain";
import { useData } from "@/lib/use-data";
import { getCategorias, getEspecialidades } from "@/lib/api";
import { normalize } from "@/lib/format";

export default function EspecialidadesPage() {
  const { data, loading } = useData(async () => {
    const [cats, esps] = await Promise.all([getCategorias(), getEspecialidades()]);
    return { cats, esps };
  });
  const [q, setQ] = useState("");
  const res = useMemo(() => {
    if (!q || !data) return [];
    const n = normalize(q);
    return data.esps.filter((e) => normalize(e.nome).includes(n) || e.codigo.toLowerCase().includes(n)).slice(0, 40);
  }, [q, data]);

  return (
    <div>
      <PageHeader
        eyebrow="MDA Wiki"
        title="Especialidades"
        description={`${data?.esps.length || "Todas as"} especialidades e mestrados, com requisitos. Escolha uma área ou busque pelo nome.`}
      />
      <SearchInput value={q} onChange={setQ} placeholder="Buscar por nome ou código…" className="mb-6" />

      {q ? (
        <div className="grid gap-2 sm:grid-cols-2 lg:grid-cols-3">
          {res.map((e) => (
            <Link key={e.codigo} href={`/especialidades/e/${e.codigo}`}>
              <Card className="flex items-center gap-3 p-3 hover:shadow-lift">
                <EspIcon esp={e} size={44} />
                <div className="min-w-0">
                  <div className="truncate font-semibold">{e.nome}</div>
                  <div className="text-xs text-ink-500">{data?.cats.find((c) => c.slug === e.categoria_slug)?.nome}</div>
                </div>
              </Card>
            </Link>
          ))}
          {!res.length && <p className="col-span-full py-8 text-center text-ink-500">Nenhuma especialidade encontrada para “{q}”.</p>}
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {loading && Array.from({ length: 6 }).map((_, i) => <Skeleton key={i} className="h-40" />)}
          {data?.cats.map((c, i) => {
            const amostra = data.esps.filter((e) => e.categoria_slug === c.slug);
            return (
              <Link key={c.slug} href={`/especialidades/${c.slug}`} className="group animate-fade-up" style={{ animationDelay: `${i * 30}ms` }}>
                <Card className="relative h-full overflow-hidden p-5 transition-shadow group-hover:shadow-lift">
                  <span className="absolute inset-x-0 top-0 h-1.5" style={{ background: c.cor }} />
                  <div className="flex items-start justify-between gap-2">
                    <div>
                      <h2 className="font-display text-xl font-semibold uppercase leading-tight tracking-wide">{c.nome}</h2>
                      <p className="mt-0.5 text-sm text-ink-500">{amostra.length} {c.slug === "mestrados" ? "mestrados" : "especialidades"}</p>
                    </div>
                    <ArrowRight className="mt-1 size-5 shrink-0 text-ink-300 transition-transform group-hover:translate-x-0.5 group-hover:text-tiger-600" />
                  </div>
                  <div className="mt-4 flex -space-x-2">
                    {amostra.slice(0, 6).map((e) => (
                      <span key={e.codigo} className="grid size-11 place-items-center rounded-full bg-white ring-2 ring-white">
                        <EspIcon esp={e} size={40} />
                      </span>
                    ))}
                  </div>
                </Card>
              </Link>
            );
          })}
        </div>
      )}
    </div>
  );
}
