"use client";

import { supabaseBrowser } from "./supabase/client";
import { must } from "./use-data";
import { downloadBlob } from "./reports";
import type { Emprestimo, Livro, LivroHistorico } from "./types";

const BUCKET = "biblioteca";
export const PDF_MAX_MB = 50;

const sb = () => supabaseBrowser();

const semTabela = (m: string) => /livros|livro_|relation|does not exist|schema cache/i.test(m);

export async function getLivros(): Promise<Livro[]> {
  const r = await sb().from("livros").select("*").order("titulo");
  if (r.error && semTabela(r.error.message)) throw new Error("A biblioteca ainda não foi ativada no banco. Peça ao diretor para rodar o SQL 0005.");
  return must(r) as Livro[];
}

export async function getEmprestimos(): Promise<Emprestimo[]> {
  return must(await sb().from("livro_emprestimos").select("*").order("emprestado_em", { ascending: false })) as Emprestimo[];
}

export async function getHistorico(livroId?: string, limite = 200): Promise<LivroHistorico[]> {
  let q = sb().from("livro_historico").select("*").order("created_at", { ascending: false }).limit(limite);
  if (livroId) q = q.eq("livro_id", livroId);
  return must(await q) as LivroHistorico[];
}

const limpar = (s: string) =>
  s
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-zA-Z0-9.]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(-80) || "arquivo";

/** Diminui a foto da capa (máx. 700 px de altura) para a página carregar rápido. */
async function reduzirCapa(f: File): Promise<Blob> {
  try {
    const bmp = await createImageBitmap(f);
    const escala = Math.min(1, 700 / bmp.height, 500 / bmp.width);
    const w = Math.round(bmp.width * escala);
    const h = Math.round(bmp.height * escala);
    const c = document.createElement("canvas");
    c.width = w;
    c.height = h;
    c.getContext("2d")!.drawImage(bmp, 0, 0, w, h);
    const blob = await new Promise<Blob | null>((res) => c.toBlob(res, "image/jpeg", 0.85));
    return blob || f;
  } catch {
    return f;
  }
}

export function problemaNoPdf(f: File): string | null {
  if (!(f.type === "application/pdf" || /\.pdf$/i.test(f.name))) return `"${f.name}" não é um arquivo PDF.`;
  if (f.size > PDF_MAX_MB * 1024 * 1024) return `"${f.name}" passa de ${PDF_MAX_MB} MB. Envie um PDF menor.`;
  return null;
}
export function problemaNaCapa(f: File): string | null {
  if (!/^image\/(jpeg|png|webp)$/.test(f.type) && !/\.(jpe?g|png|webp)$/i.test(f.name)) return "A capa precisa ser uma foto (JPG, PNG ou WEBP).";
  return null;
}

async function enviar(tipo: "capas" | "pdfs", f: File): Promise<string> {
  const ehCapa = tipo === "capas";
  const corpo: Blob = ehCapa ? await reduzirCapa(f) : f;
  const nome = ehCapa ? limpar(f.name).replace(/\.[a-z0-9]+$/i, "") + ".jpg" : limpar(f.name);
  const caminho = `${tipo}/${Date.now()}-${Math.random().toString(36).slice(2, 8)}-${nome}`;
  const contentType = ehCapa ? corpo.type || "image/jpeg" : "application/pdf";
  const { error } = await sb().storage.from(BUCKET).upload(caminho, corpo, { contentType, upsert: false });
  if (error)
    throw new Error(
      /payload too large|exceeded/i.test(error.message)
        ? `"${f.name}" é grande demais (máximo ${PDF_MAX_MB} MB).`
        : /bucket not found/i.test(error.message)
          ? "A biblioteca ainda não foi ativada no banco. Peça ao diretor para rodar o SQL 0005."
          : `Não foi possível enviar "${f.name}": ${error.message}`
    );
  return caminho;
}

async function apagarArquivos(caminhos: (string | null | undefined)[]) {
  const lista = caminhos.filter(Boolean) as string[];
  if (lista.length) await sb().storage.from(BUCKET).remove(lista); // se falhar, só sobra o arquivo velho guardado
}

export interface DadosLivro {
  titulo: string;
  autor: string | null;
  descricao: string | null;
  categoria: string | null;
  exemplares: number;
}

/** Cria ou atualiza o livro. Envia a capa/PDF novos e só depois apaga os antigos. */
export async function salvarLivro(opts: {
  livro: Livro | null;
  dados: DadosLivro;
  capa?: File | null;
  pdf?: File | null;
  removerCapa?: boolean;
  removerPdf?: boolean;
}): Promise<Livro> {
  const { livro, dados } = opts;
  const novos: string[] = [];
  try {
    const campos: Partial<Livro> = { ...dados };
    if (opts.capa) {
      const p = await enviar("capas", opts.capa);
      novos.push(p);
      campos.capa_path = p;
    } else if (opts.removerCapa) campos.capa_path = null;
    if (opts.pdf) {
      const p = await enviar("pdfs", opts.pdf);
      novos.push(p);
      campos.pdf_path = p;
      campos.pdf_nome = opts.pdf.name;
      campos.pdf_tamanho = opts.pdf.size;
    } else if (opts.removerPdf) {
      campos.pdf_path = null;
      campos.pdf_nome = null;
      campos.pdf_tamanho = null;
    }
    const r = livro
      ? await sb().from("livros").update(campos).eq("id", livro.id).select("*").single()
      : await sb().from("livros").insert(campos).select("*").single();
    const salvo = must(r) as Livro;
    if (livro) {
      await apagarArquivos([
        "capa_path" in campos && livro.capa_path !== salvo.capa_path ? livro.capa_path : null,
        "pdf_path" in campos && livro.pdf_path !== salvo.pdf_path ? livro.pdf_path : null,
      ]);
    }
    return salvo;
  } catch (e) {
    await apagarArquivos(novos);
    throw e;
  }
}

export async function excluirLivro(livro: Livro) {
  must(await sb().from("livros").delete().eq("id", livro.id));
  await apagarArquivos([livro.capa_path, livro.pdf_path]);
}

/** Links temporários (1 hora) das capas. */
export async function linksDasCapas(livros: Livro[]): Promise<Map<string, string>> {
  const caminhos = [...new Set(livros.map((l) => l.capa_path).filter(Boolean) as string[])];
  if (!caminhos.length) return new Map();
  const { data } = await sb().storage.from(BUCKET).createSignedUrls(caminhos, 3600);
  return new Map((data || []).filter((d) => d.signedUrl && d.path).map((d) => [d.path as string, d.signedUrl as string]));
}

export const nomeDoPdf = (l: Pick<Livro, "titulo" | "pdf_nome">) => (l.pdf_nome && /\.pdf$/i.test(l.pdf_nome) ? l.pdf_nome : `${l.titulo}.pdf`);

export async function baixarPdf(l: Livro) {
  if (!l.pdf_path) throw new Error("Este livro ainda não tem PDF.");
  const { data, error } = await sb().storage.from(BUCKET).download(l.pdf_path);
  if (error || !data) throw new Error("Não foi possível baixar o PDF. Tente de novo.");
  await downloadBlob(new Blob([data], { type: "application/pdf" }), nomeDoPdf(l));
}

export async function emprestar(e: { livro_id: string; desbravador_id: string; devolver_ate: string | null; observacao: string | null }) {
  const r = await sb().from("livro_emprestimos").insert(e);
  if (r.error) throw new Error(r.error.message);
}

export async function devolver(id: string) {
  const hoje = new Date();
  const iso = `${hoje.getFullYear()}-${String(hoje.getMonth() + 1).padStart(2, "0")}-${String(hoje.getDate()).padStart(2, "0")}`;
  must(await sb().from("livro_emprestimos").update({ devolvido_em: iso }).eq("id", id).select("id"));
}

export async function desfazerDevolucao(id: string) {
  must(await sb().from("livro_emprestimos").update({ devolvido_em: null }).eq("id", id).select("id"));
}
