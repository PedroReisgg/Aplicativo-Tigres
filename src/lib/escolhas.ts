"use client";

import { supabaseBrowser } from "./supabase/client";
import { normalize } from "./format";
import type { CadernoItem, Categoria, DesbEsp, Especialidade } from "./types";

export interface Escolha {
  desbravador_id: string;
  item_id: number;
  especialidade_codigo: string;
}

export interface RegraEscolha {
  /** Quantas especialidades o item pede. */
  quantidade: number;
  opcoes: Especialidade[];
  /** Áreas (categorias) de onde vêm as opções, para agrupar na lista. */
  areas: string[];
}

const NUMEROS: Record<string, number> = { uma: 1, um: 1, duas: 2, dois: 2, tres: 3 };

/**
 * Itens do caderno que deixam o desbravador escolher a especialidade
 * (ex.: "Escolher e completar uma especialidade em uma das áreas abaixo").
 * Devolve null quando a especialidade já é definida pelo caderno.
 */
export function regraEscolha(item: CadernoItem, todas: Especialidade[], categorias: Categoria[]): RegraEscolha | null {
  const texto = normalize(item.texto);
  if (!/^(escolher|completar|fazer)\b/.test(texto) || !texto.includes("especialidade")) return null;
  const qtd = texto.match(/\b(uma|um|duas|dois|tres)\b(?= (das|especialidade|especialidades)\b)/);
  if (!qtd) return null; // "Completar a especialidade de …" ou "as seguintes": não há o que escolher
  const quantidade = NUMEROS[qtd[1]] || 1;

  // 1) o caderno lista as especialidades possíveis (pelo código ou pelo nome nos detalhes)
  const codigos = new Set(item.especialidades.filter((c) => !c.startsWith("ME-")));
  if (codigos.size) {
    const nomes = new Set(item.detalhes.map((d) => normalize(d.t)));
    const opcoes = todas.filter((e) => codigos.has(e.codigo) || (e.categoria_slug !== "mestrados" && nomes.has(normalize(e.nome))));
    if (opcoes.length > quantidade) return { quantidade, opcoes, areas: [...new Set(opcoes.map((e) => e.categoria_slug))] };
  }

  // 2) o caderno cita áreas: "Atividades Missionárias", "Artes e Habilidades Manuais"…
  const trechos = [texto, ...item.detalhes.map((d) => normalize(d.t))];
  const areas = categorias
    .filter((c) => c.slug !== "mestrados")
    .filter((c) => {
      const nome = normalize(c.nome);
      return trechos.some((t) => t.includes(nome) || (t.length > 8 && nome.startsWith(t)));
    })
    .map((c) => c.slug);
  if (areas.includes("atividades-missionarias") && !areas.includes("ensinos-biblicos")) areas.push("ensinos-biblicos");
  const validas = todas.filter((e) => e.categoria_slug !== "mestrados");
  const opcoes = areas.length ? validas.filter((e) => areas.includes(e.categoria_slug)) : validas;
  return { quantidade, opcoes, areas: areas.length ? areas : [...new Set(validas.map((e) => e.categoria_slug))] };
}

export async function getEscolhas(desbIds: string[]): Promise<Escolha[]> {
  if (!desbIds.length) return [];
  const { data, error } = await supabaseBrowser().from("caderno_escolhas").select("desbravador_id, item_id, especialidade_codigo").in("desbravador_id", desbIds);
  if (error) return []; // banco ainda sem a tabela
  return (data || []) as Escolha[];
}

/** Troca a(s) especialidade(s) escolhida(s) de um item para um desbravador. */
export async function salvarEscolha(desbravadorId: string, itemId: number, codigos: string[], userId: string | null) {
  const sb = supabaseBrowser();
  const del = await sb.from("caderno_escolhas").delete().eq("desbravador_id", desbravadorId).eq("item_id", itemId);
  if (del.error) throw new Error(/caderno_escolhas/.test(del.error.message) ? "A escolha de especialidade ainda não foi ativada no banco." : del.error.message);
  if (!codigos.length) return;
  const ins = await sb.from("caderno_escolhas").insert(codigos.map((c) => ({ desbravador_id: desbravadorId, item_id: itemId, especialidade_codigo: c, escolhido_por: userId })));
  if (ins.error) throw new Error(/row-level|permission/i.test(ins.error.message) ? "Só a equipe do desbravador pode escolher a especialidade." : ins.error.message);
}

export type SituacaoEsp = "concluida" | "aguardando" | "refazer" | "a-fazer";

export function situacaoEsp(desbEsp: DesbEsp[], desbravadorId: string, codigo: string): SituacaoEsp {
  const x = desbEsp.find((e) => e.desbravador_id === desbravadorId && e.especialidade_codigo === codigo);
  if (!x) return "a-fazer";
  if (x.status === "refazer") return "refazer";
  return x.validacao === "pendente" ? "aguardando" : "concluida";
}

export const SITUACAO_TEXTO: Record<SituacaoEsp, string> = {
  concluida: "concluída",
  aguardando: "aguardando validação",
  refazer: "refazer",
  "a-fazer": "a fazer",
};
