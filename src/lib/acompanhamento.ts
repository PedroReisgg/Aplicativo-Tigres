"use client";

import { supabaseBrowser } from "./supabase/client";

/** Endereço da página que os responsáveis abrem (sem login). */
export function urlAcompanhamento(token: string) {
  const base = typeof window !== "undefined" ? window.location.origin : "https://tigresapp.vercel.app";
  return `${base}/acompanhar/${token}`;
}

/** Devolve o link do desbravador, criando na primeira vez. */
export async function obterLink(desbravadorId: string, userId: string | null): Promise<string> {
  const sb = supabaseBrowser();
  const { data, error } = await sb.from("acompanhamento_links").select("token").eq("desbravador_id", desbravadorId).maybeSingle();
  if (error) throw new Error(/acompanhamento_links/.test(error.message) ? "O link dos responsáveis ainda não foi ativado no banco." : error.message);
  if (data?.token) return data.token as string;
  const r = await sb.from("acompanhamento_links").insert({ desbravador_id: desbravadorId, criado_por: userId }).select("token").single();
  if (r.error) throw new Error(/row-level|permission/i.test(r.error.message) ? "Só a equipe do desbravador pode gerar o link." : r.error.message);
  return r.data.token as string;
}

/** Troca o link: o anterior para de funcionar. */
export async function trocarLink(desbravadorId: string, userId: string | null): Promise<string> {
  const sb = supabaseBrowser();
  const { error } = await sb.from("acompanhamento_links").delete().eq("desbravador_id", desbravadorId);
  if (error) throw new Error(error.message);
  return obterLink(desbravadorId, userId);
}

export function mensagemWhatsApp(nomeDesbravador: string, nomeResponsavel: string | null, url: string) {
  const primeiro = nomeDesbravador.split(" ")[0];
  const ola = nomeResponsavel ? `Olá, ${nomeResponsavel.split(" ")[0]}!` : "Olá!";
  return `${ola} Este é o link para acompanhar o progresso de ${primeiro} no Clube Tigres do Riacho (caderno e especialidades). Pelo mesmo link dá para baixar os livros da biblioteca do clube e ver as vaquinhas: ${url}`;
}

export interface AcompanhamentoDados {
  nome: string;
  classe: string | null;
  classe_cor: string | null;
  unidade: string | null;
  unidade_cor: string | null;
  itens: { id: number; codigo: string; secao: string; texto: string; avancada: boolean; status: "feito" | "refazer" | null; validacao: "pendente" | "aprovada" | null }[];
  especialidades: {
    codigo: string;
    nome: string;
    imagem: string | null;
    categoria: string;
    cor: string;
    status: "concluida" | "refazer";
    validacao: "pendente" | "aprovada";
    concluida_em: string;
  }[];
  escolhas: { item_id: number; codigo: string; nome: string }[];
}

export async function carregarAcompanhamento(token: string): Promise<AcompanhamentoDados | null> {
  if (!/^[0-9a-f-]{36}$/i.test(token)) return null;
  const { data, error } = await supabaseBrowser().rpc("acompanhamento", { p_token: token });
  if (error) throw new Error(error.message);
  return (data as AcompanhamentoDados | null) || null;
}
