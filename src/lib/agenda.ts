"use client";

import { supabaseBrowser } from "./supabase/client";
import { must } from "./use-data";
import { tabelaExcel } from "./reports";
import { AGENDA_COLS, CORES_AGENDA, hhmm, isoDia, pad2 } from "./agenda-core";
import { normalize } from "./format";
import type { AgendaEvento } from "./types";

const sb = () => supabaseBrowser();

export async function getEventos(): Promise<AgendaEvento[]> {
  const r = await sb().from("agenda_eventos").select(AGENDA_COLS).order("inicio").order("hora_inicio", { nullsFirst: true }).limit(3000);
  if (r.error && /agenda_eventos|does not exist|schema cache/i.test(r.error.message)) throw new Error("A agenda ainda não foi ativada no banco. Peça ao diretor para rodar o SQL 0006.");
  return must(r) as AgendaEvento[];
}

export async function getEditores(): Promise<string[]> {
  const r = await sb().from("agenda_editores").select("profile_id");
  if (r.error) return [];
  return (r.data || []).map((x) => x.profile_id as string);
}

export type DadosEvento = Omit<AgendaEvento, "id" | "updated_at">;

export async function salvarEvento(id: string | null, dados: DadosEvento) {
  const r = id ? await sb().from("agenda_eventos").update(dados).eq("id", id).select("id").single() : await sb().from("agenda_eventos").insert(dados).select("id").single();
  if (r.error) throw new Error(/row-level/i.test(r.error.message) ? "Você não tem permissão para mexer na agenda. Peça ao diretor." : r.error.message);
  return r.data.id as string;
}

export async function excluirEvento(id: string) {
  must(await sb().from("agenda_eventos").delete().eq("id", id).select("id"));
}

/* ---------- Excel ---------- */

const COLS = ["Data", "Data final (opcional)", "Hora início", "Hora fim", "Título", "Descrição", "Endereço", "Cor"];
const LARG = [13, 13, 11, 11, 30, 44, 36, 11];
const br = (iso: string | null) => (iso ? `${iso.slice(8, 10)}/${iso.slice(5, 7)}/${iso.slice(0, 4)}` : "");

/** A agenda em Excel. O mesmo arquivo pode ser editado e importado de volta. */
export function agendaExcel(eventos: AgendaEvento[], titulo = "Agenda do clube") {
  const linhas = eventos.map((e) => [br(e.inicio), br(e.fim && e.fim !== e.inicio ? e.fim : null), hhmm(e.hora_inicio), hhmm(e.hora_fim), e.titulo, e.descricao || "", e.endereco || "", e.cor]);
  return tabelaExcel("Agenda", titulo, COLS, LARG, linhas);
}

/** Modelo pronto para preencher, com exemplos e uma aba "Como preencher". */
export async function modeloAgenda(): Promise<Blob> {
  const ExcelJS = (await import("exceljs")).default;
  const wb = new ExcelJS.Workbook();
  wb.creator = "Tigres App";
  const ws = wb.addWorksheet("Agenda", { views: [{ state: "frozen", ySplit: 1 }] });
  ws.columns = COLS.map((h, i) => ({ header: h, width: LARG[i] }));
  const h = ws.getRow(1);
  h.height = 24;
  h.eachCell((c) => {
    c.font = { bold: true, color: { argb: "FFFFFFFF" } };
    c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FFF26B1D" } };
    c.alignment = { vertical: "middle", horizontal: "center", wrapText: true };
  });
  // exemplos em sábados do próximo ano
  const ano = new Date().getFullYear() + 1;
  const sab = (mes: number, n: number) => {
    const d = new Date(ano, mes, 1, 12);
    d.setDate(1 + ((6 - d.getDay() + 7) % 7) + 7 * n);
    return `${pad2(d.getDate())}/${pad2(d.getMonth() + 1)}/${ano}`;
  };
  const domingoDepois = (s: string) => {
    const [d, m] = s.split("/").map(Number);
    const x = new Date(ano, m - 1, d + 1, 12);
    return `${pad2(x.getDate())}/${pad2(x.getMonth() + 1)}/${ano}`;
  };
  [
    [sab(2, 0), "", "08:00", "12:00", "Abertura do ano", "Reunião de abertura com as famílias", "Igreja Central, Rua das Flores 100", "#F26B1D"],
    [sab(2, 2), domingoDepois(sab(2, 2)), "", "", "Acampamento de unidades", "Levar barraca, lanterna e cantil", "Sítio Recanto Verde", "#2F7D4F"],
    [sab(3, 1), "", "14:00", "", "Investidura", "", "", "#7B3FA0"],
  ].forEach((r) => ws.addRow(r).eachCell((c) => (c.font = { color: { argb: "FF7A6656" }, italic: true })));
  for (let r = 2; r <= 300; r++) {
    ws.getCell(r, 1).numFmt = "@";
    ws.getCell(r, 2).numFmt = "@";
    ws.getCell(r, 3).numFmt = "@";
    ws.getCell(r, 4).numFmt = "@";
  }
  const info = wb.addWorksheet("Como preencher");
  info.getColumn(1).width = 100;
  [
    "COMO PREENCHER A AGENDA",
    "",
    "• Uma linha por atividade. Apague as 3 linhas de exemplo (em cinza) antes de importar, ou elas entram na agenda.",
    "• Data: dia da atividade, no formato dd/mm/aaaa (ex.: 14/03/2027). Obrigatório.",
    "• Data final: só para atividades de vários dias (acampamento, campori). Deixe vazio se for um dia só.",
    "• Hora início / Hora fim: no formato hh:mm (ex.: 08:00). Deixe vazio se for o dia inteiro.",
    "• Título: o nome da atividade. Obrigatório.",
    "• Descrição e Endereço: opcionais. Com endereço, o app mostra os botões do Google Maps e do Waze.",
    `• Cor: código da cor do card, como #F26B1D. Vazio usa laranja. Algumas cores prontas: ${CORES_AGENDA.slice(0, 8).join(", ")}.`,
    "",
    "Depois é só ir em Agenda → Importar Excel no app e escolher este arquivo.",
  ].forEach((t, i) => {
    const c = info.getCell(i + 1, 1);
    c.value = t;
    c.alignment = { wrapText: true };
    if (i === 0) c.font = { bold: true, size: 14, color: { argb: "FFF26B1D" } };
  });
  const buf = await wb.xlsx.writeBuffer();
  return new Blob([buf], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
}

function textoDe(v: unknown): string {
  if (v == null) return "";
  if (v instanceof Date) return v.toISOString();
  if (typeof v === "object") {
    const o = v as { text?: string; richText?: { text: string }[]; result?: unknown };
    if (o.richText) return o.richText.map((r) => r.text).join("");
    if (o.text != null) return String(o.text);
    if (o.result != null) return textoDe(o.result);
  }
  return String(v).trim();
}

/** Data do Excel, número de série, dd/mm/aaaa, dd/mm/aa ou aaaa-mm-dd. */
function dataDe(v: unknown): string | null {
  if (v == null || v === "") return null;
  if (v instanceof Date) return `${v.getUTCFullYear()}-${pad2(v.getUTCMonth() + 1)}-${pad2(v.getUTCDate())}`;
  if (typeof v === "number" && v > 20000 && v < 80000) return isoDia(new Date(Date.UTC(1899, 11, 30) + Math.round(v) * 86400000 + 12 * 3600000));
  const s = textoDe(v);
  let m = /^(\d{1,2})[/.-](\d{1,2})[/.-](\d{2,4})$/.exec(s);
  if (m) {
    let y = Number(m[3]);
    if (y < 100) y += 2000;
    const d = new Date(y, Number(m[2]) - 1, Number(m[1]), 12);
    if (d.getDate() !== Number(m[1]) || d.getMonth() !== Number(m[2]) - 1) return null;
    return isoDia(d);
  }
  if ((m = /^(\d{4})-(\d{2})-(\d{2})/.exec(s))) return `${m[1]}-${m[2]}-${m[3]}`;
  return null;
}

/** 8, "8h", "08:00", "8:30", data do Excel com hora ou fração do dia -> "08:00". */
function horaDe(v: unknown): string | null | "erro" {
  if (v == null || v === "") return null;
  if (v instanceof Date) return `${pad2(v.getUTCHours())}:${pad2(v.getUTCMinutes())}`;
  if (typeof v === "number" && v >= 0 && v < 1) {
    const min = Math.round(v * 24 * 60);
    return `${pad2(Math.floor(min / 60) % 24)}:${pad2(min % 60)}`;
  }
  const s = textoDe(v).toLowerCase().replace(/\s/g, "");
  if (!s) return null;
  const m = /^(\d{1,2})(?:[:h.](\d{2})?)?h?$/.exec(s);
  if (!m || Number(m[1]) > 23 || Number(m[2] || 0) > 59) return "erro";
  return `${pad2(Number(m[1]))}:${m[2] || "00"}`;
}

export interface LinhaAgenda {
  linha: number;
  dados: DadosEvento | null;
  erros: string[];
  repetido: boolean;
}

const CAMPOS: [keyof DadosEvento | "x", RegExp][] = [
  ["fim", /^data final|^ate|^termino|^fim da data/],
  ["inicio", /^data|^dia/],
  ["hora_inicio", /^hora inicio|^inicio|^horario|^hora$/],
  ["hora_fim", /^hora fim|^hora final|^fim|^termina/],
  ["titulo", /^titulo|^atividade|^evento|^programacao|^nome/],
  ["descricao", /^descricao|^detalhe|^obs/],
  ["endereco", /^endereco|^local/],
  ["cor", /^cor/],
];

export async function lerAgendaExcel(file: File, existentes: AgendaEvento[]): Promise<LinhaAgenda[]> {
  const ExcelJS = (await import("exceljs")).default;
  const wb = new ExcelJS.Workbook();
  await wb.xlsx.load(await file.arrayBuffer());
  const ws = wb.worksheets.find((w) => w.state !== "hidden" && w.actualRowCount > 0 && !/como preencher/i.test(w.name)) || wb.worksheets[0];
  if (!ws) throw new Error("A planilha está vazia.");
  const limpo = (s: string) => normalize(s).replace(/[^a-z0-9]+/g, " ").trim();

  let header = 0;
  const col = new Map<string, number>();
  for (let r = 1; r <= Math.min(10, ws.rowCount) && !header; r++) {
    const achados = new Map<string, number>();
    ws.getRow(r).eachCell((c, n) => {
      const t = limpo(textoDe(c.value));
      const campo = CAMPOS.find(([k, re]) => !achados.has(k) && re.test(t));
      if (campo) achados.set(campo[0], n);
    });
    if (achados.has("inicio") && achados.has("titulo")) {
      header = r;
      achados.forEach((v, k) => col.set(k, v));
    }
  }
  if (!header) throw new Error('Não achei as colunas "Data" e "Título". Use o modelo do app.');

  const chave = (dia: string, t: string) => `${dia}|${normalize(t).trim()}`;
  const jaTem = new Set(existentes.map((e) => chave(e.inicio, e.titulo)));
  const out: LinhaAgenda[] = [];
  const pegar = (row: import("exceljs").Row, k: string) => (col.has(k) ? row.getCell(col.get(k)!).value : null);
  for (let r = header + 1; r <= ws.rowCount; r++) {
    const row = ws.getRow(r);
    const bruto = ["inicio", "titulo", "descricao", "fim", "hora_inicio"].map((k) => textoDe(pegar(row, k)));
    if (bruto.every((x) => !x)) continue;
    const erros: string[] = [];
    const inicio = dataDe(pegar(row, "inicio"));
    if (!inicio) erros.push("data inválida (use dd/mm/aaaa)");
    let fim = dataDe(pegar(row, "fim"));
    if (textoDe(pegar(row, "fim")) && !fim) erros.push("data final inválida");
    if (fim && inicio && fim < inicio) erros.push("data final antes da data");
    if (fim === inicio) fim = null;
    const hi = horaDe(pegar(row, "hora_inicio"));
    const hf = horaDe(pegar(row, "hora_fim"));
    if (hi === "erro") erros.push("hora de início inválida (use 08:00)");
    if (hf === "erro") erros.push("hora de fim inválida (use 12:00)");
    const titulo = textoDe(pegar(row, "titulo")).slice(0, 120);
    if (!titulo) erros.push("sem título");
    const corTxt = textoDe(pegar(row, "cor")).replace(/^#?/, "#");
    const cor = /^#[0-9a-f]{6}$/i.test(corTxt) ? corTxt.toUpperCase() : "#F26B1D";
    if (textoDe(pegar(row, "cor")) && cor !== corTxt.toUpperCase()) erros.push("cor inválida (use #F26B1D)");
    const ok = !erros.length && inicio;
    out.push({
      linha: r,
      erros,
      repetido: !!(ok && jaTem.has(chave(inicio!, titulo))),
      dados: ok
        ? {
            titulo,
            inicio: inicio!,
            fim,
            hora_inicio: (hi as string | null) || null,
            hora_fim: hi ? (hf as string | null) || null : null,
            descricao: textoDe(pegar(row, "descricao")).slice(0, 2000) || null,
            endereco: textoDe(pegar(row, "endereco")).slice(0, 200) || null,
            cor,
          }
        : null,
    });
  }
  return out;
}

export async function importarEventos(lista: DadosEvento[]) {
  for (let i = 0; i < lista.length; i += 200) {
    const { error } = await sb().from("agenda_eventos").insert(lista.slice(i, i + 200));
    if (error) throw new Error(/row-level/i.test(error.message) ? "Você não tem permissão para mexer na agenda." : error.message);
  }
}
