"use client";

import Link from "next/link";
import { useParams } from "next/navigation";
import { useMemo, useState } from "react";
import { ArrowLeft, ExternalLink } from "lucide-react";
import { Card, EmptyState, PageHeader, SearchInput, Skeleton, cn } from "@/components/ui";
import { EspIcon, NivelBadge } from "@/components/domain";
import { useData } from "@/lib/use-data";
import { getCategorias, getEspecialidades } from "@/lib/api";
import { normalize } from "@/lib/format";

export default function CategoriaPage() {
  const { categoria } = useParams<{ categoria: string }>();
  const { data, loading } = useData(async () => {
    const [cats, esps] = await Promise.all([getCategorias(), getEspecialidades()]);
    return { cat: cats.find((c) => c.slug === categoria), esps: esps.filter((e) => e.categoria_slug === categoria) };
  }, [categoria]);
  const [q, setQ] = useState("");
  const [nivel, setNivel] = useState<number | null>(null);
  const list = useMemo(
    () =>
      (data?.esps || [])
        .filter((e) => (!q || normalize(e.nome).includes(normalize(q))) && (!nivel || e.nivel === nivel))
        .sort((a, b) => a.nome.localeCompare(b.nome)),
    [data, q, nivel]
  );

  return (
    <div>
      <Link href="/especialidades" className="mb-4 inline-flex items-center gap-1.5 text-sm font-medium text-ink-500 hover:text-ink-800">
        <ArrowLeft className="size-4" /> Especialidades
      </Link>
      <PageHeader
        eyebrow="Área"
        title={data?.cat?.nome || "…"}
        description={data ? `${data.esps.length} ${categoria === "mestrados" ? "mestrados" : "especialidades"}` : undefined}
        actions={
          data?.cat?.url_mda && (
            <a href={data.cat.url_mda} target="_blank" rel="noreferrer" className="inline-flex h-11 items-center gap-2 rounded-xl border border-ink-200 bg-white px-4 text-sm font-semibold hover:bg-ink-50">
              Ver no MDA Wiki <ExternalLink className="size-4" />
            </a>
          )
        }
      />
      <div className="mb-5 flex flex-col gap-3 sm:flex-row sm:items-center">
        <SearchInput value={q} onChange={setQ} placeholder="Filtrar nesta área…" className="flex-1" />
        {categoria !== "mestrados" && (
          <div className="flex gap-1 rounded-xl bg-ink-100 p-1" role="group" aria-label="Filtrar por nível">
            {[null, 1, 2, 3].map((n) => (
              <button
                key={String(n)}
                onClick={() => setNivel(n)}
                aria-pressed={nivel === n}
                className={cn("h-9 rounded-lg px-3 text-sm font-semibold", nivel === n ? "bg-white shadow-card" : "text-ink-500 hover:text-ink-800")}
              >
                {n ? `Nível ${n}` : "Todos"}
              </button>
            ))}
          </div>
        )}
      </div>
      {loading ? (
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4">{Array.from({ length: 8 }).map((_, i) => <Skeleton key={i} className="h-44" />)}</div>
      ) : !list.length ? (
        <EmptyState title="Nenhuma especialidade" description="Mude o filtro ou a busca." />
      ) : (
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4">
          {list.map((e) => (
            <Link key={e.codigo} href={`/especialidades/e/${e.codigo}`} className="group">
              <Card className="flex h-full flex-col items-center p-4 text-center transition-shadow group-hover:shadow-lift">
                <EspIcon esp={e} size={84} className="transition-transform duration-200 group-hover:scale-105" />
                <div className="mt-3 line-clamp-2 text-sm font-semibold leading-snug">{e.nome}</div>
                <div className="mt-auto pt-2">
                  <div className="text-[11px] text-ink-400">{e.codigo}</div>
                  <NivelBadge nivel={e.nivel} />
                </div>
              </Card>
            </Link>
          ))}
        </div>
      )}
    </div>
  );
}
