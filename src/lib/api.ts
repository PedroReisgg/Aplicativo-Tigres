"use client";

import { supabaseBrowser } from "./supabase/client";
import { must } from "./use-data";
import type { CadernoItem, Categoria, Classe, DesbEsp, Desbravador, Especialidade, Profile, Progresso } from "./types";

const sb = () => supabaseBrowser();

export const ESP_COLS = "codigo,nome,categoria_slug,tipo,nivel,ano,origem,imagem,url_mda";

export async function getClasses(): Promise<Classe[]> {
  return must(await sb().from("classes").select("*").order("id"));
}
export async function getClasse(slug: string): Promise<Classe | null> {
  return must(await sb().from("classes").select("*").eq("slug", slug).maybeSingle());
}
export async function getCategorias(): Promise<Categoria[]> {
  return must(await sb().from("especialidade_categorias").select("*").order("ordem"));
}

let espCache: Especialidade[] | null = null;
export async function getEspecialidades(): Promise<Especialidade[]> {
  if (espCache) return espCache;
  // a API limita 1000 linhas por chamada
  const all: Especialidade[] = [];
  for (let from = 0; ; from += 1000) {
    const page = must(await sb().from("especialidades").select(ESP_COLS).order("codigo").range(from, from + 999)) as Especialidade[];
    all.push(...page);
    if (page.length < 1000) break;
  }
  espCache = all;
  return all;
}
export async function getEspecialidade(codigo: string): Promise<Especialidade | null> {
  return must(await sb().from("especialidades").select("*").eq("codigo", codigo).maybeSingle());
}

export async function getCaderno(classId: number): Promise<CadernoItem[]> {
  return must(await sb().from("caderno_itens").select("*").eq("class_id", classId).order("secao_ordem").order("ordem"));
}

export async function getClassEsp(classId: number) {
  return must(
    await sb().from("class_especialidades").select("especialidade_codigo, obrigatoria, created_at").eq("class_id", classId)
  ) as { especialidade_codigo: string; obrigatoria: boolean; created_at: string }[];
}

export async function getDesbravadores(opts: { classId?: number | null; ativos?: boolean } = {}): Promise<Desbravador[]> {
  let q = sb().from("desbravadores_view").select("*").order("nome");
  if (opts.classId) q = q.eq("class_id", opts.classId);
  if (opts.ativos !== false) q = q.eq("ativo", true);
  return must(await q) as Desbravador[];
}
export async function getDesbravador(id: string): Promise<Desbravador | null> {
  return must(await sb().from("desbravadores_view").select("*").eq("id", id).maybeSingle());
}

export async function getProgresso(desbIds: string[]): Promise<Progresso[]> {
  if (!desbIds.length) return [];
  return must(await sb().from("caderno_progresso").select("*").in("desbravador_id", desbIds)) as Progresso[];
}
export async function getDesbEsp(desbIds: string[]): Promise<DesbEsp[]> {
  if (!desbIds.length) return [];
  return must(await sb().from("desbravador_especialidades").select("*").in("desbravador_id", desbIds)) as DesbEsp[];
}

export async function getMembros(): Promise<Profile[]> {
  return must(await sb().from("membros_view").select("*").order("nome")) as Profile[];
}

export async function getStaff(classId: number) {
  return must(
    await sb().from("class_staff").select("profile_id, funcao, profiles(id, nome, telefone, cargo)").eq("class_id", classId)
  ) as unknown as { profile_id: string; funcao: string; profiles: { id: string; nome: string; telefone: string | null; cargo: string } }[];
}

/** Envia notificação para uma lista de pessoas. */
export async function notificar(
  remetente: string,
  destinatarios: string[],
  n: { titulo: string; mensagem?: string; link?: string; tipo?: string }
) {
  const ids = [...new Set(destinatarios)].filter((d) => d && d !== remetente);
  if (!ids.length) return;
  const { error } = await sb()
    .from("notificacoes")
    .insert(ids.map((d) => ({ destinatario_id: d, remetente_id: remetente, tipo: n.tipo || "mensagem", titulo: n.titulo, mensagem: n.mensagem || null, link: n.link || null })));
  if (error) throw new Error(error.message);
}

export async function staffIdsDaClasse(classId: number): Promise<string[]> {
  const r = must(await sb().from("class_staff").select("profile_id").eq("class_id", classId)) as { profile_id: string }[];
  return r.map((x) => x.profile_id);
}

export async function adminIds(): Promise<string[]> {
  const r = must(await sb().from("profiles").select("id").eq("is_admin", true).eq("status", "ativo")) as { id: string }[];
  return r.map((x) => x.id);
}

export function classePct(itens: CadernoItem[], prog: Progresso[], desbId: string, incluirAvancada = false) {
  const base = itens.filter((i) => incluirAvancada || !i.avancada);
  if (!base.length) return 0;
  const ids = new Set(base.map((i) => i.id));
  const feitos = prog.filter((p) => p.desbravador_id === desbId && p.status === "feito" && ids.has(p.item_id)).length;
  return (feitos / base.length) * 100;
}
