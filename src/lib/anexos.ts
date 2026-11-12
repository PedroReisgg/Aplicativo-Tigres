"use client";

import { supabaseBrowser } from "./supabase/client";
import { must } from "./use-data";
import { downloadBlob } from "./reports";
import type { Anexo } from "./types";

const BUCKET = "anexos";
export const ANEXO_ACCEPT = "image/*,video/*,application/pdf,.pdf,.xls,.xlsx,.csv";
export const ANEXO_MAX_MB = 50;

export type TipoAnexo = "imagem" | "video" | "pdf" | "planilha" | "outro";

export function tipoAnexo(a: { tipo?: string | null; nome_arquivo?: string; name?: string; type?: string }): TipoAnexo {
  const mime = (a.tipo ?? a.type ?? "").toLowerCase();
  const nome = (a.nome_arquivo ?? a.name ?? "").toLowerCase();
  if (mime.startsWith("image/")) return "imagem";
  if (mime.startsWith("video/")) return "video";
  if (mime === "application/pdf" || nome.endsWith(".pdf")) return "pdf";
  if (/sheet|excel|csv/.test(mime) || /\.(xlsx?|csv)$/.test(nome)) return "planilha";
  return "outro";
}

/** Confere tamanho e tipo antes de enviar. Devolve a mensagem de erro, se houver. */
export function problemaNoArquivo(f: File): string | null {
  if (f.size > ANEXO_MAX_MB * 1024 * 1024) return `"${f.name}" passa de ${ANEXO_MAX_MB} MB. Envie um arquivo menor (para vídeos, grave mais curto ou em qualidade menor).`;
  if (tipoAnexo(f) === "outro") return `"${f.name}" não é imagem, vídeo, PDF nem planilha do Excel.`;
  return null;
}

export function tamanhoTexto(bytes?: number | null) {
  if (!bytes) return "";
  if (bytes < 1024 * 1024) return `${Math.max(1, Math.round(bytes / 1024))} KB`;
  return `${(bytes / 1024 / 1024).toFixed(1).replace(".", ",")} MB`;
}

const limpar = (s: string) =>
  s
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-zA-Z0-9.]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(-80) || "arquivo";

export interface ArquivoEnviado {
  caminho: string;
  nome_arquivo: string;
  tipo: string | null;
  tamanho: number;
}

/** Envia os arquivos para a pasta de quem está logado e devolve os caminhos. */
export async function enviarArquivos(files: File[], userId: string): Promise<ArquivoEnviado[]> {
  const sb = supabaseBrowser();
  const out: ArquivoEnviado[] = [];
  for (const f of files) {
    const erro = problemaNoArquivo(f);
    if (erro) throw new Error(erro);
    const caminho = `${userId}/${Date.now()}-${Math.random().toString(36).slice(2, 8)}-${limpar(f.name)}`;
    const { error } = await sb.storage.from(BUCKET).upload(caminho, f, { contentType: f.type || undefined, upsert: false });
    if (error)
      throw new Error(/payload too large|exceeded/i.test(error.message) ? `"${f.name}" é grande demais (máximo ${ANEXO_MAX_MB} MB).` : `Não foi possível enviar "${f.name}": ${error.message}`);
    out.push({ caminho, nome_arquivo: f.name, tipo: f.type || null, tamanho: f.size });
  }
  return out;
}

/** Liga os arquivos enviados à especialidade de cada desbravador (um arquivo pode valer para vários). */
export async function vincularAnexos(arquivos: ArquivoEnviado[], desbIds: string[], codigo: string, userId: string) {
  if (!arquivos.length || !desbIds.length) return;
  const rows = desbIds.flatMap((desbravador_id) => arquivos.map((a) => ({ ...a, desbravador_id, especialidade_codigo: codigo, enviado_por: userId })));
  const { error } = await supabaseBrowser().from("especialidade_anexos").insert(rows);
  if (error) throw new Error(error.message);
}

export async function getAnexos(opts: { desbIds?: string[]; codigo?: string }): Promise<Anexo[]> {
  let q = supabaseBrowser().from("especialidade_anexos").select("*").order("created_at");
  if (opts.desbIds) {
    if (!opts.desbIds.length) return [];
    q = q.in("desbravador_id", opts.desbIds);
  }
  if (opts.codigo) q = q.eq("especialidade_codigo", opts.codigo);
  try {
    return must(await q) as Anexo[];
  } catch {
    return []; // banco ainda sem a tabela de anexos
  }
}

/** Links temporários (1 hora) para mostrar os arquivos. */
export async function linksDosAnexos(caminhos: string[]): Promise<Map<string, string>> {
  const unicos = [...new Set(caminhos)];
  if (!unicos.length) return new Map();
  const { data } = await supabaseBrowser().storage.from(BUCKET).createSignedUrls(unicos, 3600);
  return new Map((data || []).filter((d) => d.signedUrl && d.path).map((d) => [d.path as string, d.signedUrl as string]));
}

export async function baixarAnexo(a: Pick<Anexo, "caminho" | "nome_arquivo">) {
  const { data, error } = await supabaseBrowser().storage.from(BUCKET).download(a.caminho);
  if (error || !data) throw new Error("Não foi possível baixar o arquivo.");
  await downloadBlob(data, a.nome_arquivo);
}
