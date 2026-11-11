"use client";

import Link from "next/link";
import { Suspense, useEffect, useMemo, useState } from "react";
import { useSearchParams } from "next/navigation";
import { UserPlus, Users } from "lucide-react";
import { useAuth } from "@/components/auth-provider";
import { Avatar, Button, Card, EmptyState, PageHeader, SearchInput, Select, Skeleton } from "@/components/ui";
import { DesbravadorSheet, PhoneLink } from "@/components/domain";
import { useData } from "@/lib/use-data";
import { getDesbravadores } from "@/lib/api";
import { normalize } from "@/lib/format";

function Lista() {
  const { classes, isAdmin, staffClassIds, isActive } = useAuth();
  const params = useSearchParams();
  const [novo, setNovo] = useState(false);
  const [q, setQ] = useState("");
  const [cls, setCls] = useState<string>("");
  const [inativos, setInativos] = useState(false);
  const { data, loading, reload } = useData(() => getDesbravadores({ ativos: inativos ? false : true }), [inativos]);

  useEffect(() => {
    if (params.get("novo") === "1" && isActive) setNovo(true);
  }, [params, isActive]);

  const visiveis = classes.filter((c) => isAdmin || staffClassIds.includes(c.id));
  const list = useMemo(
    () =>
      (data || []).filter(
        (d) =>
          (!cls || String(d.class_id) === cls) &&
          (!q || normalize(`${d.nome} ${d.nome_mae || ""} ${d.nome_pai || ""} ${d.unidade || ""}`).includes(normalize(q)))
      ),
    [data, cls, q]
  );

  if (!isActive)
    return <EmptyState icon={<Users className="size-6" />} title="Acesso pendente" description="Quando o diretor liberar seu acesso, você verá os desbravadores da sua classe." />;

  return (
    <div>
      <PageHeader
        eyebrow={isAdmin ? "Todo o clube" : "Suas classes"}
        title="Desbravadores"
        description={isAdmin ? "Relação completa dos desbravadores do clube, com contato dos pais." : "Desbravadores das classes em que você atua."}
        actions={
          <Button icon={<UserPlus className="size-4" />} onClick={() => setNovo(true)} disabled={!visiveis.length}>
            Novo desbravador
          </Button>
        }
      />
      <div className="mb-5 grid gap-3 sm:grid-cols-[1fr_220px]">
        <SearchInput value={q} onChange={setQ} placeholder="Buscar por nome, pais ou unidade…" />
        <Select value={cls} onChange={(e) => setCls(e.target.value)} aria-label="Filtrar por classe">
          <option value="">Todas as classes</option>
          {visiveis.map((c) => (
            <option key={c.id} value={c.id}>
              {c.nome}
            </option>
          ))}
        </Select>
      </div>
      {isAdmin && (
        <label className="mb-4 inline-flex items-center gap-2 text-sm text-ink-600">
          <input type="checkbox" className="accent-tiger-600" checked={inativos} onChange={(e) => setInativos(e.target.checked)} /> Mostrar também os inativos
        </label>
      )}

      {loading ? (
        <div className="space-y-2">{Array.from({ length: 5 }).map((_, i) => <Skeleton key={i} className="h-16" />)}</div>
      ) : !list.length ? (
        <EmptyState
          icon={<Users className="size-6" />}
          title={data?.length ? "Ninguém encontrado" : "Nenhum desbravador cadastrado"}
          description={data?.length ? "Mude a busca ou o filtro." : "Cadastre o primeiro desbravador do clube."}
          action={!data?.length && <Button onClick={() => setNovo(true)}>Cadastrar desbravador</Button>}
        />
      ) : (
        <>
          <p className="mb-2 text-sm text-ink-500">{list.length} desbravador(es)</p>
          {/* Tabela no desktop */}
          <Card className="hidden overflow-hidden md:block">
            <table className="w-full text-sm">
              <thead className="bg-ink-50 text-left text-xs uppercase tracking-wide text-ink-500">
                <tr>
                  <th className="px-4 py-3 font-semibold">Nome</th>
                  <th className="px-4 py-3 font-semibold">Classe</th>
                  <th className="px-4 py-3 font-semibold">Idade</th>
                  <th className="px-4 py-3 font-semibold">Responsáveis</th>
                  <th className="px-4 py-3 font-semibold">Contato dos pais</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-ink-100">
                {list.map((d) => (
                  <tr key={d.id} className="hover:bg-ink-50/70">
                    <td className="px-4 py-3">
                      <Link href={`/desbravadores/${d.id}`} className="flex items-center gap-3 font-semibold hover:text-tiger-700">
                        <Avatar nome={d.nome} color={d.classe_cor} size={34} />
                        <span>
                          {d.nome}
                          {!d.ativo && <span className="ml-2 rounded bg-ink-100 px-1.5 text-[11px] text-ink-500">inativo</span>}
                        </span>
                      </Link>
                    </td>
                    <td className="px-4 py-3">
                      <span className="inline-flex items-center gap-1.5">
                        <span className="size-2.5 rounded-full" style={{ background: d.classe_cor || "#ccc" }} />
                        {d.classe_nome || "—"}
                      </span>
                    </td>
                    <td className="px-4 py-3">{d.idade ?? "—"}</td>
                    <td className="max-w-[220px] truncate px-4 py-3 text-ink-600">{[d.nome_mae, d.nome_pai].filter(Boolean).join(" / ") || "—"}</td>
                    <td className="px-4 py-3">
                      <PhoneLink phone={d.telefone_responsavel} />
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </Card>
          {/* Cartões no celular */}
          <div className="space-y-2 md:hidden">
            {list.map((d) => (
              <Link key={d.id} href={`/desbravadores/${d.id}`}>
                <Card className="mb-2 flex items-center gap-3 p-3.5">
                  <Avatar nome={d.nome} color={d.classe_cor} />
                  <div className="min-w-0 flex-1">
                    <div className="truncate font-semibold">{d.nome}</div>
                    <div className="truncate text-xs text-ink-500">
                      {d.classe_nome || "Sem classe"} · {d.idade ?? "?"} anos{d.unidade ? ` · ${d.unidade}` : ""}
                    </div>
                  </div>
                </Card>
              </Link>
            ))}
          </div>
        </>
      )}
      <DesbravadorSheet open={novo} onClose={() => setNovo(false)} classId={cls ? Number(cls) : visiveis.length === 1 ? visiveis[0].id : null} onSaved={() => reload(true)} />
    </div>
  );
}

export default function DesbravadoresPage() {
  return (
    <Suspense>
      <Lista />
    </Suspense>
  );
}
