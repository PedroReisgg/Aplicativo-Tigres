"use client";

import Link from "next/link";
import { useParams } from "next/navigation";
import { useMemo, useState } from "react";
import { ArrowLeft, Check, ExternalLink, Plus, UserCheck } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Badge, Button, Card, EmptyState, Select, Skeleton } from "@/components/ui";
import { EspIcon, NivelBadge } from "@/components/domain";
import { StatusSheet, type Marca } from "@/components/status-sheet";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData, must } from "@/lib/use-data";
import { getCategorias, getDesbEsp, getDesbravadores, getEspecialidade, notificar, staffIdsDaClasse } from "@/lib/api";
import type { Desbravador } from "@/lib/types";

function Requisitos({ texto }: { texto: string }) {
  const linhas = texto.split("\n").filter((l) => l.trim());
  if (!linhas.length) return <p className="text-ink-500">Requisitos não disponíveis. Consulte o MDA Wiki.</p>;
  return (
    <div className="space-y-2 text-[15px] leading-relaxed text-ink-800">
      {linhas.map((l, i) => {
        const nivel = (l.match(/^ */)?.[0].length || 0) / 2;
        const t = l.trim();
        if (t.startsWith("## ")) return <h3 key={i} className="pt-3 font-display text-base font-semibold uppercase tracking-wide text-tiger-700">{t.slice(3)}</h3>;
        const m = /^(\d+\.|[a-z]\)|•)\s+(.*)$/.exec(t);
        if (!m) return <p key={i} className="text-ink-600" style={{ marginLeft: nivel * 20 }}>{t}</p>;
        return (
          <div key={i} className="flex gap-2.5" style={{ marginLeft: nivel * 22 }}>
            <span className={nivel === 0 ? "mt-px grid size-6 shrink-0 place-items-center rounded-full bg-tiger-100 text-xs font-bold text-tiger-800" : "w-5 shrink-0 text-right text-sm font-semibold text-ink-400"}>
              {m[1] === "•" ? "•" : m[1].replace(".", "")}
            </span>
            <span className="min-w-0">{m[2]}</span>
          </div>
        );
      })}
    </div>
  );
}

export default function EspecialidadePage() {
  const { codigo } = useParams<{ codigo: string }>();
  const auth = useAuth();
  const sb = supabaseBrowser();
  const gerenciaveis = auth.classes.filter((c) => auth.canManageClass(c.id));
  const [classeSel, setClasseSel] = useState<number | "">(gerenciaveis[0]?.id ?? "");
  const [aberto, setAberto] = useState(false);

  const { data, loading, reload } = useData(async () => {
    const [esp, cats, vinc] = await Promise.all([
      getEspecialidade(decodeURIComponent(codigo)),
      getCategorias(),
      sb.from("class_especialidades").select("class_id, obrigatoria").eq("especialidade_codigo", decodeURIComponent(codigo)),
    ]);
    let desb: Desbravador[] = [];
    let feitos: Awaited<ReturnType<typeof getDesbEsp>> = [];
    if (auth.isActive && gerenciaveis.length) {
      desb = await getDesbravadores();
      feitos = (must(await sb.from("desbravador_especialidades").select("*").eq("especialidade_codigo", decodeURIComponent(codigo))) as typeof feitos) || [];
    }
    return { esp, cat: cats.find((c) => c.slug === esp?.categoria_slug), vinc: (vinc.data || []) as { class_id: number; obrigatoria: boolean }[], desb, feitos };
  }, [codigo, auth.isActive]);

  const desbDaClasse = useMemo(() => (data?.desb || []).filter((d) => d.class_id === classeSel), [data, classeSel]);
  const initial = useMemo(() => {
    const m = new Map<string, Marca>();
    (data?.feitos || []).forEach((f) => m.set(f.desbravador_id, f.status === "concluida" ? "feito" : "refazer"));
    return m;
  }, [data]);

  if (loading) return <div className="space-y-4"><Skeleton className="h-40" /><Skeleton className="h-80" /></div>;
  if (!data?.esp) return <EmptyState title="Especialidade não encontrada" action={<Link href="/especialidades" className="font-semibold text-tiger-700">Voltar</Link>} />;
  const esp = data.esp;
  const naClasse = (cid: number) => data.vinc.some((v) => v.class_id === cid);
  const concluiram = (data.feitos || []).filter((f) => f.status === "concluida");

  async function salvar(estado: Map<string, Marca | null>, mensagem: string) {
    const ups: object[] = [];
    const dels: string[] = [];
    const devolvidos: string[] = [];
    estado.forEach((v, id) => {
      if (!desbDaClasse.some((d) => d.id === id)) return;
      const antes = initial.get(id) || null;
      if (v === antes) return;
      if (!v) dels.push(id);
      else {
        ups.push({ desbravador_id: id, especialidade_codigo: esp.codigo, status: v === "feito" ? "concluida" : "refazer", observacao: v === "refazer" ? mensagem || null : null, registrado_por: auth.userId });
        if (v === "refazer") devolvidos.push(id);
      }
    });
    if (ups.length) {
      const { error } = await sb.from("desbravador_especialidades").upsert(ups);
      if (error) return void toast.error(error.message);
    }
    if (dels.length) {
      const { error } = await sb.from("desbravador_especialidades").delete().eq("especialidade_codigo", esp.codigo).in("desbravador_id", dels);
      if (error) return void toast.error(error.message);
    }
    if (devolvidos.length && classeSel) {
      try {
        await notificar(auth.userId!, await staffIdsDaClasse(Number(classeSel)), {
          tipo: "refazer",
          titulo: `Especialidade ${esp.nome}: refazer`,
          mensagem: mensagem,
          link: `/especialidades/e/${esp.codigo}`,
        });
      } catch {}
    }
    toast.success("Registro salvo.");
    reload(true);
  }

  async function addClasse() {
    if (!classeSel) return;
    const { error } = await sb.from("class_especialidades").insert({ class_id: classeSel, especialidade_codigo: esp.codigo, obrigatoria: false, adicionada_por: auth.userId });
    if (error) return toast.error(error.message);
    toast.success("Especialidade adicionada à classe.");
    reload(true);
  }

  return (
    <div>
      <Link href={data.cat ? `/especialidades/${data.cat.slug}` : "/especialidades"} className="mb-4 inline-flex items-center gap-1.5 text-sm font-medium text-ink-500 hover:text-ink-800">
        <ArrowLeft className="size-4" /> {data.cat?.nome || "Especialidades"}
      </Link>

      <div className="grid gap-6 lg:grid-cols-[1fr_340px]">
        <div className="space-y-6">
          <Card className="relative overflow-hidden p-6 sm:p-8">
            <span className="absolute inset-x-0 top-0 h-1.5" style={{ background: data.cat?.cor || "#F26B1D" }} />
            <div className="flex flex-col items-center gap-5 text-center sm:flex-row sm:text-left">
              <EspIcon esp={esp} size={120} />
              <div>
                <div className="text-xs font-semibold uppercase tracking-[.14em]" style={{ color: data.cat?.cor }}>
                  {data.cat?.nome}
                </div>
                <h1 className="mt-1 font-display text-3xl font-semibold uppercase leading-tight tracking-wide sm:text-4xl">{esp.nome}</h1>
                <div className="mt-2 flex flex-wrap items-center justify-center gap-x-4 gap-y-1 text-sm text-ink-500 sm:justify-start">
                  <span className="font-mono">{esp.codigo}</span>
                  <NivelBadge nivel={esp.nivel} />
                  {esp.ano && <span>Desde {esp.ano}</span>}
                  {esp.origem && <span>{esp.origem}</span>}
                </div>
              </div>
            </div>
          </Card>

          <Card className="p-6 sm:p-8">
            <h2 className="mb-4 font-display text-xl font-semibold uppercase tracking-wide">Requisitos</h2>
            <Requisitos texto={esp.requisitos || ""} />
            {esp.url_mda && (
              <a href={esp.url_mda} target="_blank" rel="noreferrer" className="mt-6 inline-flex items-center gap-1.5 text-sm font-semibold text-tiger-700 hover:underline">
                Ver no MDA Wiki <ExternalLink className="size-4" />
              </a>
            )}
          </Card>
        </div>

        <aside className="space-y-4 lg:sticky lg:top-6 lg:self-start">
          {gerenciaveis.length > 0 ? (
            <Card className="space-y-4 p-5">
              <h2 className="font-display text-lg font-semibold uppercase tracking-wide">Registrar</h2>
              {gerenciaveis.length > 1 && (
                <Select label="Classe" value={classeSel} onChange={(e) => setClasseSel(Number(e.target.value))}>
                  {gerenciaveis.map((c) => (
                    <option key={c.id} value={c.id}>
                      {c.nome}
                    </option>
                  ))}
                </Select>
              )}
              <Button className="w-full" icon={<UserCheck className="size-4" />} onClick={() => setAberto(true)} disabled={!desbDaClasse.length}>
                Marcar quem concluiu
              </Button>
              {!desbDaClasse.length && <p className="text-xs text-ink-500">A classe ainda não tem desbravadores cadastrados.</p>}
              {classeSel && naClasse(Number(classeSel)) ? (
                <p className="flex items-center gap-1.5 text-sm text-emerald-700">
                  <Check className="size-4" /> Já está nas especialidades da classe
                </p>
              ) : (
                <Button variant="secondary" className="w-full" icon={<Plus className="size-4" />} onClick={addClasse}>
                  Adicionar às especialidades da classe
                </Button>
              )}
            </Card>
          ) : (
            <Card className="p-5 text-sm text-ink-600">
              {auth.isPending ? "Quando o diretor liberar seu acesso, você poderá registrar esta especialidade para os desbravadores." : "Você pode consultar os requisitos. Só a equipe da classe registra especialidades."}
            </Card>
          )}

          {data.vinc.length > 0 && (
            <Card className="p-5">
              <h3 className="mb-2 text-sm font-semibold text-ink-800">Faz parte das classes</h3>
              <div className="flex flex-wrap gap-1.5">
                {data.vinc.map((v) => {
                  const c = auth.classes.find((x) => x.id === v.class_id);
                  return c ? (
                    <Link key={v.class_id} href={`/classes/${c.slug}?aba=especialidades`}>
                      <Badge>
                        <span className="size-2 rounded-full" style={{ background: c.cor }} /> {c.nome} {v.obrigatoria ? "· caderno" : ""}
                      </Badge>
                    </Link>
                  ) : null;
                })}
              </div>
            </Card>
          )}

          {concluiram.length > 0 && (
            <Card className="p-5">
              <h3 className="mb-2 text-sm font-semibold text-ink-800">Concluíram ({concluiram.length})</h3>
              <ul className="space-y-1.5 text-sm">
                {concluiram.slice(0, 12).map((f) => {
                  const d = data.desb.find((x) => x.id === f.desbravador_id);
                  return d ? (
                    <li key={f.desbravador_id}>
                      <Link href={`/desbravadores/${d.id}`} className="hover:text-tiger-700">
                        {d.nome} <span className="text-ink-400">· {d.classe_nome}</span>
                      </Link>
                    </li>
                  ) : null;
                })}
              </ul>
            </Card>
          )}
        </aside>
      </div>

      <StatusSheet
        open={aberto}
        onClose={() => setAberto(false)}
        title={esp.nome}
        description={`Desbravadores da classe de ${auth.classes.find((c) => c.id === classeSel)?.nome || ""}`}
        desbravadores={desbDaClasse}
        initial={initial}
        isAdmin={auth.isAdmin}
        onSave={salvar}
      />
    </div>
  );
}
