"use client";

import { funcoesTexto, responsaveisDe, type CadernoItem, type Classe, type DesbEsp, type Desbravador, type Especialidade, type Profile, type Progresso } from "./types";
import { isoToBr } from "./format";

export interface ClassReportData {
  classe: Classe;
  itens: CadernoItem[];
  desbravadores: Desbravador[];
  progresso: Progresso[];
  especialidades: Especialidade[]; // especialidades a listar (da classe + concluídas)
  classEsp: Set<string>; // códigos da classe
  desbEsp: DesbEsp[];
  /** Ficha individual (caderno item a item + especialidades) de cada desbravador. */
  fichas?: boolean;
  /** Especialidade escolhida em cada item do caderno. */
  escolhas?: { desbravador_id: string; item_id: number; especialidade_codigo: string }[];
  /** Nome de qualquer especialidade pelo código (para as escolhidas). */
  nomeEsp?: (codigo: string) => string;
  /** Nome da área de cada especialidade. */
  areaEsp?: (codigo: string) => string;
}

const CLUBE = "Clube de Desbravadores Tigres do Riacho";
const hoje = () => new Date().toLocaleDateString("pt-BR");
const slug = (s: string) =>
  s
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-zA-Z0-9]+/g, "-")
    .toLowerCase();

async function logoDataUrl(): Promise<string | null> {
  try {
    const r = await fetch("/brand/logo-relatorio.png");
    const b = await r.blob();
    return await new Promise((res) => {
      const fr = new FileReader();
      fr.onload = () => res(fr.result as string);
      fr.readAsDataURL(b);
    });
  } catch {
    return null;
  }
}

function hexToArgb(hex: string) {
  return "FF" + hex.replace("#", "").toUpperCase();
}

function resumo(d: ClassReportData, desb: Desbravador) {
  const base = d.itens.filter((i) => !i.avancada);
  const av = d.itens.filter((i) => i.avancada);
  const feito = (it: CadernoItem) => d.progresso.some((p) => p.desbravador_id === desb.id && p.item_id === it.id && p.status === "feito");
  const fb = base.filter(feito).length;
  const fa = av.filter(feito).length;
  const esps = d.desbEsp.filter((e) => e.desbravador_id === desb.id && e.status === "concluida");
  const daClasse = esps.filter((e) => d.classEsp.has(e.especialidade_codigo)).length;
  return { fb, tb: base.length, fa, ta: av.length, pct: base.length ? Math.round((fb / base.length) * 100) : 0, esps, daClasse };
}

// ---------------------------------------------------------------- Excel
export async function classReportExcel(d: ClassReportData): Promise<Blob> {
  const ExcelJS = (await import("exceljs")).default;
  const wb = new ExcelJS.Workbook();
  wb.creator = "Tigres App";
  wb.created = new Date();
  const logo = await logoDataUrl();
  const logoId = logo ? wb.addImage({ base64: logo, extension: "png" }) : null;
  const cor = hexToArgb(d.classe.cor);
  const ORANGE = "FFF26B1D";
  const DARK = "FF1C130E";

  const thin = { style: "thin" as const, color: { argb: "FFE6DCD2" } };
  const border = { top: thin, left: thin, bottom: thin, right: thin };

  function cabecalho(ws: import("exceljs").Worksheet, subtitulo: string, cols: number) {
    ws.mergeCells(1, 2, 1, Math.max(cols, 6));
    ws.mergeCells(2, 2, 2, Math.max(cols, 6));
    ws.mergeCells(3, 2, 3, Math.max(cols, 6));
    ws.getRow(1).height = 26;
    ws.getRow(2).height = 22;
    const c1 = ws.getCell(1, 2);
    c1.value = CLUBE.toUpperCase();
    c1.font = { bold: true, size: 15, color: { argb: DARK } };
    const c2 = ws.getCell(2, 2);
    c2.value = `Classe de ${d.classe.nome} — ${subtitulo}`;
    c2.font = { bold: true, size: 12, color: { argb: ORANGE } };
    const c3 = ws.getCell(3, 2);
    c3.value = `Gerado em ${hoje()} · ${d.desbravadores.length} desbravador(es)`;
    c3.font = { size: 10, color: { argb: "FF7A6656" } };
    ws.getColumn(1).width = 9;
    if (logoId !== null) ws.addImage(logoId, { tl: { col: 0.15, row: 0.1 }, ext: { width: 52, height: 52 } });
    ws.addRow([]);
  }

  function headerRow(row: import("exceljs").Row, fill = cor) {
    row.height = 30;
    row.eachCell((c) => {
      c.font = { bold: true, color: { argb: "FFFFFFFF" }, size: 10 };
      c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: fill } };
      c.alignment = { vertical: "middle", horizontal: "center", wrapText: true };
      c.border = border;
    });
  }

  // --- Caderno
  const itens = d.itens;
  const ws = wb.addWorksheet("Caderno", { views: [{ state: "frozen", xSplit: 2, ySplit: 5 }], pageSetup: { orientation: "landscape", fitToPage: true, fitToWidth: 1 } });
  cabecalho(ws, "Caderno (cartão da classe)", itens.length + 5);
  const hr = ws.addRow(["#", "Desbravador", ...itens.map((i) => (i.avancada ? `AV ${i.codigo.replace("AV.", "")}` : i.codigo)), "Feitos", "% Regular", "Avançada"]);
  headerRow(hr);
  ws.getColumn(2).width = 32;
  itens.forEach((_, k) => (ws.getColumn(k + 3).width = 6));
  ws.getColumn(itens.length + 3).width = 9;
  ws.getColumn(itens.length + 4).width = 10;
  ws.getColumn(itens.length + 5).width = 10;
  d.desbravadores.forEach((desb, idx) => {
    const r = resumo(d, desb);
    const row = ws.addRow([
      idx + 1,
      desb.nome,
      ...itens.map((it) => {
        const p = d.progresso.find((x) => x.desbravador_id === desb.id && x.item_id === it.id);
        return p ? (p.status === "feito" ? "✔" : "↺") : "";
      }),
      `${r.fb}/${r.tb}`,
      r.pct / 100,
      `${r.fa}/${r.ta}`,
    ]);
    row.eachCell((c, col) => {
      c.border = border;
      c.alignment = { vertical: "middle", horizontal: col === 2 ? "left" : "center" };
      if (c.value === "✔") {
        c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FFDCFCE7" } };
        c.font = { color: { argb: "FF15803D" }, bold: true };
      } else if (c.value === "↺") {
        c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FFFEE2E2" } };
        c.font = { color: { argb: "FFB91C1C" }, bold: true };
      }
    });
    row.getCell(itens.length + 4).numFmt = "0%";
    if (idx % 2) row.getCell(2).fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FFFAF7F3" } };
  });
  ws.addRow([]);
  const leg = ws.addRow(["", "Legenda: ✔ feito · ↺ devolvido para refazer · AV = classe avançada"]);
  leg.getCell(2).font = { italic: true, size: 9, color: { argb: "FF7A6656" } };

  // --- Itens (legenda completa)
  const wi = wb.addWorksheet("Itens do caderno");
  cabecalho(wi, "Requisitos do caderno", 4);
  headerRow(wi.addRow(["Código", "Seção", "Requisito", "Concluíram"]));
  wi.getColumn(1).width = 10;
  wi.getColumn(2).width = 28;
  wi.getColumn(3).width = 90;
  wi.getColumn(4).width = 12;
  itens.forEach((it) => {
    const n = d.progresso.filter((p) => p.item_id === it.id && p.status === "feito").length;
    const det = (it.detalhes || []).map((x) => `   • ${x.t}`).join("\n");
    const row = wi.addRow([it.codigo, it.secao, it.texto + (det ? "\n" + det : ""), `${n}/${d.desbravadores.length}`]);
    row.eachCell((c) => {
      c.border = border;
      c.alignment = { vertical: "top", wrapText: true };
    });
  });

  // --- Especialidades
  const esps = d.especialidades;
  const we = wb.addWorksheet("Especialidades", { views: [{ state: "frozen", xSplit: 2, ySplit: 5 }], pageSetup: { orientation: "landscape", fitToPage: true, fitToWidth: 1 } });
  cabecalho(we, "Especialidades", esps.length + 4);
  const he = we.addRow(["#", "Desbravador", ...esps.map((e) => `${e.nome}${d.classEsp.has(e.codigo) ? " ★" : ""}`), "Da classe", "Total"]);
  headerRow(he, ORANGE);
  he.height = 90;
  he.eachCell((c, col) => {
    if (col > 2 && col <= esps.length + 2) c.alignment = { textRotation: 90, vertical: "bottom", horizontal: "center", wrapText: true };
  });
  we.getColumn(2).width = 32;
  esps.forEach((_, k) => (we.getColumn(k + 3).width = 5.5));
  d.desbravadores.forEach((desb, idx) => {
    const r = resumo(d, desb);
    const row = we.addRow([
      idx + 1,
      desb.nome,
      ...esps.map((e) => {
        const x = d.desbEsp.find((z) => z.desbravador_id === desb.id && z.especialidade_codigo === e.codigo);
        return x ? (x.status === "concluida" ? "✔" : "↺") : "";
      }),
      `${r.daClasse}/${d.classEsp.size}`,
      r.esps.length,
    ]);
    row.eachCell((c, col) => {
      c.border = border;
      c.alignment = { vertical: "middle", horizontal: col === 2 ? "left" : "center" };
      if (c.value === "✔") {
        c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FFDCFCE7" } };
        c.font = { color: { argb: "FF15803D" }, bold: true };
      } else if (c.value === "↺") {
        c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FFFEE2E2" } };
        c.font = { color: { argb: "FFB91C1C" }, bold: true };
      }
    });
  });
  we.addRow([]);
  we.addRow(["", "★ especialidade exigida pelo caderno da classe"]).getCell(2).font = { italic: true, size: 9, color: { argb: "FF7A6656" } };

  // --- Desbravadores
  const wd = wb.addWorksheet("Desbravadores");
  cabecalho(wd, "Cadastro dos desbravadores", 11);
  headerRow(wd.addRow(["#", "Nome", "Nascimento", "Idade", "Unidade", "Responsável 1", "Telefone 1", "Responsável 2", "Telefone 2", "Telefone", "E-mail"]), DARK);
  [6, 32, 12, 7, 14, 26, 18, 26, 18, 16, 28].forEach((w, i) => (wd.getColumn(i + 1).width = w));
  d.desbravadores.forEach((x, i) => {
    const [r1, r2] = responsaveisDe(x);
    const row = wd.addRow([
      i + 1,
      x.nome,
      isoToBr(x.data_nascimento),
      x.idade ?? "",
      x.unidade || "",
      r1.nome || "",
      r1.telefone || "",
      r2.nome || "",
      r2.telefone || "",
      x.telefone || "",
      x.email || "",
    ]);
    row.eachCell((c) => (c.border = border));
  });

  if (d.fichas) {
    const usados = new Set(wb.worksheets.map((w) => w.name));
    d.desbravadores.forEach((desb) => fichaExcel(wb, logoId, d, desb, usados, cor));
  }

  const buf = await wb.xlsx.writeBuffer();
  return new Blob([buf], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
}

// ---------------------------------------------------------------- PDF
async function pdfBase(titulo: string, subtitulo: string, cor: string) {
  const { jsPDF } = await import("jspdf");
  const autoTable = (await import("jspdf-autotable")).default;
  const doc = new jsPDF({ orientation: "landscape", unit: "pt", format: "a4" });
  const logo = await logoDataUrl();
  const W = doc.internal.pageSize.getWidth();
  const header = () => {
    doc.setFillColor(28, 19, 14);
    doc.rect(0, 0, W, 64, "F");
    const [r, g, b] = [1, 3, 5].map((i) => parseInt(cor.slice(i, i + 2), 16));
    doc.setFillColor(r, g, b);
    doc.rect(0, 64, W, 4, "F");
    if (logo) doc.addImage(logo, "PNG", 24, 8, 48, 48);
    doc.setTextColor(255, 255, 255);
    doc.setFont("helvetica", "bold");
    doc.setFontSize(15);
    doc.text(CLUBE.toUpperCase(), 84, 30);
    doc.setFont("helvetica", "normal");
    doc.setFontSize(10.5);
    doc.setTextColor(255, 196, 160);
    doc.text(`${titulo} · ${subtitulo}`, 84, 48);
    doc.setTextColor(199, 185, 172);
    doc.setFontSize(9);
    doc.text(`Gerado em ${hoje()}`, W - 24, 30, { align: "right" });
  };
  const footer = () => {
    const pages = doc.getNumberOfPages();
    for (let i = 1; i <= pages; i++) {
      doc.setPage(i);
      doc.setFontSize(8);
      doc.setTextColor(150, 140, 130);
      doc.text(`Tigres App · página ${i} de ${pages}`, W - 24, doc.internal.pageSize.getHeight() - 14, { align: "right" });
    }
  };
  return { doc, autoTable, header, footer, W };
}

export async function classReportPDF(d: ClassReportData): Promise<Blob> {
  const { doc, autoTable, header, footer } = await pdfBase(`Classe de ${d.classe.nome}`, "Relatório da classe", d.classe.cor);
  const [r, g, b] = [1, 3, 5].map((i) => parseInt(d.classe.cor.slice(i, i + 2), 16));
  const head = { fillColor: [r, g, b] as [number, number, number], textColor: 255, fontStyle: "bold" as const, fontSize: 8.5 };
  const common = {
    margin: { top: 84, left: 24, right: 24, bottom: 28 },
    didDrawPage: header,
    styles: { fontSize: 8.5, cellPadding: 4, lineColor: [230, 220, 210] as [number, number, number], lineWidth: 0.5 },
  };

  // 1. Resumo
  autoTable(doc, {
    ...common,
    startY: 84,
    head: [["#", "Desbravador", "Idade", "Unidade", "Caderno (regular)", "%", "Avançada", "Esp. da classe", "Total de especialidades"]],
    body: d.desbravadores.map((x, i) => {
      const s = resumo(d, x);
      return [i + 1, x.nome, x.idade ?? "", x.unidade || "", `${s.fb}/${s.tb}`, `${s.pct}%`, `${s.fa}/${s.ta}`, `${s.daClasse}/${d.classEsp.size}`, s.esps.length];
    }),
    headStyles: head,
    alternateRowStyles: { fillColor: [250, 247, 243] },
  });

  // 2. Matriz do caderno (em blocos de colunas)
  const itens = d.itens;
  const bloco = 26;
  for (let k = 0; k < itens.length; k += bloco) {
    const parte = itens.slice(k, k + bloco);
    autoTable(doc, {
      ...common,
      startY: (doc as unknown as { lastAutoTable: { finalY: number } }).lastAutoTable.finalY + 22,
      head: [["Desbravador", ...parte.map((i) => i.codigo)]],
      body: d.desbravadores.map((x) => [
        x.nome,
        ...parte.map((it) => {
          const p = d.progresso.find((z) => z.desbravador_id === x.id && z.item_id === it.id);
          return p ? (p.status === "feito" ? "OK" : "REF") : "";
        }),
      ]),
      headStyles: { ...head, fontSize: 7, halign: "center" },
      styles: { ...common.styles, fontSize: 7, halign: "center", cellPadding: 2.5 },
      columnStyles: { 0: { halign: "left", cellWidth: 150 } },
      didParseCell: (h) => {
        if (h.section === "body" && h.cell.raw === "OK") {
          h.cell.styles.fillColor = [220, 252, 231];
          h.cell.styles.textColor = [21, 128, 61];
          h.cell.styles.fontStyle = "bold";
        }
        if (h.section === "body" && h.cell.raw === "REF") {
          h.cell.styles.fillColor = [254, 226, 226];
          h.cell.styles.textColor = [185, 28, 28];
          h.cell.styles.fontStyle = "bold";
        }
      },
    });
  }

  // 3. Especialidades por desbravador
  autoTable(doc, {
    ...common,
    startY: (doc as unknown as { lastAutoTable: { finalY: number } }).lastAutoTable.finalY + 22,
    head: [["Desbravador", "Especialidades concluídas (★ = exigida pelo caderno)"]],
    body: d.desbravadores.map((x) => {
      const s = resumo(d, x);
      const nomes = s.esps
        .map((e) => {
          const esp = d.especialidades.find((z) => z.codigo === e.especialidade_codigo);
          return (esp?.nome || e.especialidade_codigo) + (d.classEsp.has(e.especialidade_codigo) ? " ★" : "");
        })
        .sort();
      return [x.nome, nomes.join(", ") || "—"];
    }),
    headStyles: { fillColor: [242, 107, 29], textColor: 255, fontStyle: "bold", fontSize: 8.5 },
    columnStyles: { 0: { cellWidth: 170, fontStyle: "bold" } },
  });

  // 4. Ficha de cada desbravador (uma página nova para cada)
  if (d.fichas) d.desbravadores.forEach((x) => fichaPDF(doc, autoTable, common, head, d, x));

  // 5. Legenda dos itens
  if (d.fichas) doc.addPage();
  autoTable(doc, {
    ...common,
    startY: d.fichas ? 84 : (doc as unknown as { lastAutoTable: { finalY: number } }).lastAutoTable.finalY + 22,
    head: [["Código", "Seção", "Requisito do caderno"]],
    body: itens.map((it) => [it.codigo, it.secao, it.texto]),
    headStyles: { fillColor: [28, 19, 14], textColor: 255, fontSize: 8 },
    styles: { ...common.styles, fontSize: 7.5 },
    columnStyles: { 0: { cellWidth: 44 }, 1: { cellWidth: 140 } },
  });
  footer();
  return doc.output("blob");
}

// ---------------------------------------------------------------- Relação geral do clube
export type IncluirRelacao = "ambos" | "desbravadores" | "diretoria";

const thinBorder = () => {
  const thin = { style: "thin" as const, color: { argb: "FFE6DCD2" } };
  return { top: thin, left: thin, bottom: thin, right: thin };
};

/** Aba com cabeçalho do clube, logo e tabela listrada. */
function abaSimples(
  wb: import("exceljs").Workbook,
  logoId: number | null,
  nome: string,
  sub: string,
  cols: string[],
  widths: number[],
  rows: (string | number)[][],
  cor = "FF1C130E",
) {
  const border = thinBorder();
  const ws = wb.addWorksheet(nome, { views: [{ state: "frozen", ySplit: 5 }] });
  ws.mergeCells(1, 2, 1, cols.length);
  ws.mergeCells(2, 2, 2, cols.length);
  ws.mergeCells(3, 2, 3, cols.length);
  ws.getCell(1, 2).value = CLUBE.toUpperCase();
  ws.getCell(1, 2).font = { bold: true, size: 15 };
  ws.getCell(2, 2).value = sub;
  ws.getCell(2, 2).font = { bold: true, size: 12, color: { argb: "FFF26B1D" } };
  ws.getCell(3, 2).value = `Gerado em ${hoje()} · ${rows.length} registro(s)`;
  ws.getCell(3, 2).font = { size: 10, color: { argb: "FF7A6656" } };
  ws.getRow(1).height = 26;
  if (logoId !== null) ws.addImage(logoId, { tl: { col: 0.15, row: 0.1 }, ext: { width: 52, height: 52 } });
  ws.addRow([]);
  const h = ws.addRow(cols);
  h.height = 26;
  h.eachCell((c) => {
    c.font = { bold: true, color: { argb: "FFFFFFFF" } };
    c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: cor } };
    c.alignment = { vertical: "middle", horizontal: "center", wrapText: true };
    c.border = border;
  });
  widths.forEach((w, i) => (ws.getColumn(i + 1).width = w));
  rows.forEach((r, i) => {
    const row = ws.addRow(r);
    row.eachCell((c) => {
      c.border = border;
      c.alignment = { vertical: "top", wrapText: true };
      if (i % 2) c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FFFAF7F3" } };
    });
  });
  ws.autoFilter = { from: { row: 5, column: 1 }, to: { row: 5, column: cols.length } };
  return ws;
}

const situacaoMembro = (m: Profile) => (m.status === "ativo" ? "Ativo" : m.status === "pendente" ? "Lista de espera" : "Inativo");

// ---------------------------------------------------------------- Ficha individual (caderno + especialidades)
const situacaoItem = (p?: Progresso) => (!p ? "Falta" : p.status === "refazer" ? "Refazer" : p.validacao === "pendente" ? "Aguardando validação" : "Feito");
const situacaoEspDesb = (x?: DesbEsp) => (!x ? "Falta" : x.status === "refazer" ? "Refazer" : x.validacao === "pendente" ? "Aguardando validação" : "Concluída");

/** Linhas da ficha de um desbravador: cada item do caderno e cada especialidade. */
function dadosFicha(d: ClassReportData, desb: Desbravador) {
  const nome = (c: string) => d.nomeEsp?.(c) || d.especialidades.find((e) => e.codigo === c)?.nome || c;
  const itens = d.itens.map((it) => {
    const p = d.progresso.find((x) => x.desbravador_id === desb.id && x.item_id === it.id);
    const esc = (d.escolhas || []).filter((e) => e.desbravador_id === desb.id && e.item_id === it.id).map((e) => nome(e.especialidade_codigo));
    return {
      codigo: it.avancada ? `AV ${it.codigo.replace("AV.", "")}` : it.codigo,
      secao: it.secao,
      texto: it.texto + (esc.length ? `\nEspecialidade escolhida: ${esc.join(", ")}` : ""),
      situacao: situacaoItem(p),
      data: p ? isoToBr(p.marcado_em.slice(0, 10)) : "",
      obs: p?.observacao || "",
    };
  });
  const minhas = d.desbEsp.filter((e) => e.desbravador_id === desb.id);
  const cods = [...new Set([...minhas.map((e) => e.especialidade_codigo), ...d.classEsp])];
  const esps = cods
    .map((c) => {
      const x = minhas.find((e) => e.especialidade_codigo === c);
      return {
        nome: nome(c) + (d.classEsp.has(c) ? " ★" : ""),
        codigo: c,
        area: d.areaEsp?.(c) || "",
        situacao: situacaoEspDesb(x),
        data: x ? isoToBr(x.concluida_em) : "",
        obs: x?.observacao || "",
      };
    })
    .sort((a, b) => (a.situacao === "Falta" ? 1 : 0) - (b.situacao === "Falta" ? 1 : 0) || a.nome.localeCompare(b.nome, "pt-BR"));
  return { itens, esps, r: resumo(d, desb) };
}

const COR_SITUACAO: Record<string, [string, [number, number, number], [number, number, number]]> = {
  Feito: ["FF15803D", [21, 128, 61], [220, 252, 231]],
  Concluída: ["FF15803D", [21, 128, 61], [220, 252, 231]],
  "Aguardando validação": ["FFB45309", [180, 83, 9], [254, 243, 199]],
  Refazer: ["FFB91C1C", [185, 28, 28], [254, 226, 226]],
};

function nomeDeAba(nome: string, usados: Set<string>) {
  const base = nome.replace(/[\\/?*[\]:]/g, " ").replace(/\s+/g, " ").trim().slice(0, 28) || "Desbravador";
  let n = base;
  for (let i = 2; usados.has(n.toLowerCase()) || usados.has(n); i++) n = `${base.slice(0, 26)} ${i}`;
  usados.add(n);
  usados.add(n.toLowerCase());
  return n;
}

function fichaExcel(wb: import("exceljs").Workbook, logoId: number | null, d: ClassReportData, desb: Desbravador, usados: Set<string>, cor: string) {
  const border = thinBorder();
  const { itens, esps, r } = dadosFicha(d, desb);
  const ws = wb.addWorksheet(nomeDeAba(desb.nome, usados), { pageSetup: { orientation: "portrait", fitToPage: true, fitToWidth: 1, fitToHeight: 0 } });
  [9, 30, 70, 20, 13, 30].forEach((w, i) => (ws.getColumn(i + 1).width = w));
  ws.mergeCells(1, 2, 1, 6);
  ws.mergeCells(2, 2, 2, 6);
  ws.mergeCells(3, 2, 3, 6);
  ws.getRow(1).height = 26;
  ws.getCell(1, 2).value = desb.nome.toUpperCase();
  ws.getCell(1, 2).font = { bold: true, size: 15 };
  ws.getCell(2, 2).value = `Ficha do desbravador · Classe de ${d.classe.nome}${desb.unidade ? ` · Unidade ${desb.unidade}` : ""}${desb.idade != null ? ` · ${desb.idade} anos` : ""}`;
  ws.getCell(2, 2).font = { bold: true, size: 12, color: { argb: "FFF26B1D" } };
  ws.getCell(3, 2).value = `${CLUBE} · gerado em ${hoje()}`;
  ws.getCell(3, 2).font = { size: 10, color: { argb: "FF7A6656" } };
  if (logoId !== null) ws.addImage(logoId, { tl: { col: 0.15, row: 0.1 }, ext: { width: 52, height: 52 } });
  ws.addRow([]);
  const resumoLinhas: [string, string][] = [
    ["Caderno (regular)", `${r.fb} de ${r.tb} itens · ${r.pct}%`],
    ["Classe avançada", r.ta ? `${r.fa} de ${r.ta} itens` : "—"],
    ["Especialidades", `${r.esps.length} concluída(s) · ${r.daClasse} de ${d.classEsp.size} exigidas pela classe`],
  ];
  resumoLinhas.forEach(([a, b]) => {
    const row = ws.addRow(["", a, b]);
    row.getCell(2).font = { bold: true };
  });
  ws.addRow([]);

  const tabela = (titulo: string, cols: string[], linhas: (string | number)[][], fill: string, colSituacao: number) => {
    const t = ws.addRow(["", titulo]);
    t.getCell(2).font = { bold: true, size: 12 };
    const h = ws.addRow(cols);
    h.height = 22;
    h.eachCell((c) => {
      c.font = { bold: true, color: { argb: "FFFFFFFF" } };
      c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: fill } };
      c.alignment = { vertical: "middle", horizontal: "center", wrapText: true };
      c.border = border;
    });
    linhas.forEach((l) => {
      const row = ws.addRow(l);
      row.eachCell({ includeEmpty: true }, (c, col) => {
        c.border = border;
        c.alignment = { vertical: "top", wrapText: true, horizontal: col === 1 || col === colSituacao || col === 5 ? "center" : "left" };
      });
      const sit = COR_SITUACAO[String(l[colSituacao - 1])];
      if (sit) {
        const c = row.getCell(colSituacao);
        c.font = { bold: true, color: { argb: sit[0] } };
        c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FF" + sit[2].map((v) => v.toString(16).padStart(2, "0")).join("").toUpperCase() } };
      }
    });
    ws.addRow([]);
  };
  tabela("Caderno", ["Código", "Seção", "Requisito", "Situação", "Data", "Observação"], itens.map((i) => [i.codigo, i.secao, i.texto, i.situacao, i.data, i.obs]), cor, 4);
  tabela(
    "Especialidades (★ = exigida pela classe)",
    ["#", "Área", "Especialidade", "Situação", "Concluída em", "Observação"],
    esps.map((e, k) => [k + 1, e.area, `${e.nome} (${e.codigo})`, e.situacao, e.data, e.obs]),
    "FFF26B1D",
    4,
  );
}

type AutoTableFn = (doc: import("jspdf").jsPDF, opts: import("jspdf-autotable").UserOptions) => void;

function fichaPDF(
  doc: import("jspdf").jsPDF,
  autoTable: AutoTableFn,
  common: Partial<import("jspdf-autotable").UserOptions>,
  head: import("jspdf-autotable").Styles | Partial<import("jspdf-autotable").Styles>,
  d: ClassReportData,
  desb: Desbravador,
) {
  const { itens, esps, r } = dadosFicha(d, desb);
  doc.addPage();
  const corSit = (h: { section: string; column: { index: number }; cell: { raw: unknown; styles: Partial<import("jspdf-autotable").Styles> } }, col: number) => {
    const sit = h.section === "body" && h.column.index === col ? COR_SITUACAO[String(h.cell.raw)] : undefined;
    if (sit) {
      h.cell.styles.textColor = sit[1];
      h.cell.styles.fillColor = sit[2];
      h.cell.styles.fontStyle = "bold";
    }
  };
  autoTable(doc, {
    ...common,
    startY: 84,
    head: [[{ content: desb.nome.toUpperCase(), colSpan: 2 }]],
    body: [
      ["Classe / unidade", `${d.classe.nome}${desb.unidade ? ` · Unidade ${desb.unidade}` : ""}${desb.idade != null ? ` · ${desb.idade} anos` : ""}`],
      ["Caderno (regular)", `${r.fb} de ${r.tb} itens · ${r.pct}%`],
      ["Classe avançada", r.ta ? `${r.fa} de ${r.ta} itens` : "—"],
      ["Especialidades", `${r.esps.length} concluída(s) · ${r.daClasse} de ${d.classEsp.size} exigidas pela classe`],
    ],
    headStyles: { fillColor: [28, 19, 14], textColor: 255, fontStyle: "bold", fontSize: 11 },
    columnStyles: { 0: { cellWidth: 130, fontStyle: "bold" } },
  });
  const y = () => (doc as unknown as { lastAutoTable: { finalY: number } }).lastAutoTable.finalY + 16;
  autoTable(doc, {
    ...common,
    startY: y(),
    head: [["Código", "Requisito do caderno", "Situação", "Data", "Observação"]],
    body: itens.map((i) => [i.codigo, i.texto, i.situacao, i.data, i.obs]),
    headStyles: head as Partial<import("jspdf-autotable").Styles>,
    styles: { fontSize: 7.5, cellPadding: 3 },
    columnStyles: { 0: { cellWidth: 40 }, 2: { cellWidth: 92, halign: "center" }, 3: { cellWidth: 56, halign: "center" }, 4: { cellWidth: 140 } },
    didParseCell: (h) => corSit(h, 2),
  });
  autoTable(doc, {
    ...common,
    startY: y(),
    head: [["Especialidade (★ = exigida pela classe)", "Área", "Situação", "Concluída em", "Observação"]],
    body: esps.length ? esps.map((e) => [`${e.nome} (${e.codigo})`, e.area, e.situacao, e.data, e.obs]) : [["Nenhuma especialidade registrada.", "", "", "", ""]],
    headStyles: { fillColor: [242, 107, 29], textColor: 255, fontStyle: "bold", fontSize: 8.5 },
    styles: { fontSize: 7.5, cellPadding: 3 },
    columnStyles: { 1: { cellWidth: 150 }, 2: { cellWidth: 92, halign: "center" }, 3: { cellWidth: 64, halign: "center" }, 4: { cellWidth: 140 } },
    didParseCell: (h) => corSit(h, 2),
  });
}

// ---------------------------------------------------------------- Dados pessoais (lista completa)
const SEXO: Record<string, string> = { M: "Masculino", F: "Feminino" };

const COLS_DESB = ["#", "Nome", "Sexo", "Nascimento", "Idade", "CPF", "Classe", "Unidade", "Telefone do desbravador", "Endereço", "Responsável 1", "Telefone 1", "Responsável 2", "Telefone 2", "E-mail do responsável", "Observações", "Situação", "Cadastrado em"];
const LARG_DESB = [6, 30, 11, 12, 7, 15, 14, 14, 17, 36, 26, 17, 26, 17, 28, 36, 10, 13];

function linhasDesb(desb: Desbravador[], classes: Classe[]) {
  const nomeClasse = (id?: number | null) => classes.find((c) => c.id === id)?.nome || "";
  return [...desb]
    .sort((a, b) => a.nome.localeCompare(b.nome, "pt-BR"))
    .map((d, i) => {
      const [r1, r2] = responsaveisDe(d);
      return [
        i + 1,
        d.nome,
        SEXO[d.sexo || ""] || "",
        isoToBr(d.data_nascimento),
        d.idade ?? "",
        d.cpf || "",
        d.classe_nome || nomeClasse(d.class_id),
        d.unidade || "",
        d.telefone || "",
        d.endereco || "",
        r1.nome || "",
        r1.telefone || "",
        r2.nome || "",
        r2.telefone || "",
        d.email || "",
        d.observacoes || "",
        d.ativo ? "Ativo" : "Inativo",
        isoToBr(d.created_at?.slice(0, 10)),
      ];
    });
}

const COLS_DIR = ["#", "Nome", "Funções", "Classe(s)", "Unidade(s)", "Nascimento", "Idade", "Telefone", "E-mail", "Situação", "Admin", "No app desde"];
const LARG_DIR = [6, 30, 32, 26, 22, 12, 7, 17, 30, 14, 8, 13];

function linhasDiretoria(membros: Profile[], classes: Classe[], unidades: { id: string; nome: string }[]) {
  const nomeClasse = (id?: number | null) => classes.find((c) => c.id === id)?.nome || "";
  const nomeUnidade = (id: string) => unidades.find((u) => u.id === id)?.nome || "";
  return [...membros]
    .sort((a, b) => a.nome.localeCompare(b.nome, "pt-BR"))
    .map((m, i) => [
      i + 1,
      m.nome,
      m.status === "pendente" ? `Pediu: ${m.cargo_solicitado || "—"}` : funcoesTexto(m).replace(/ · /g, ", "),
      (m.classes || []).map((c) => `${nomeClasse(c.class_id)} (${c.funcao})`).join(", "),
      (m.unidades || []).map((u) => `${nomeUnidade(u.unidade_id)} (${u.funcao})`).join(", "),
      isoToBr(m.data_nascimento),
      m.idade ?? "",
      m.telefone || "",
      m.email,
      situacaoMembro(m),
      m.is_admin ? "Sim" : "",
      isoToBr(m.created_at?.slice(0, 10)),
    ]);
}

async function planilha(build: (wb: import("exceljs").Workbook, logoId: number | null) => void) {
  const ExcelJS = (await import("exceljs")).default;
  const wb = new ExcelJS.Workbook();
  wb.creator = "Tigres App";
  const logo = await logoDataUrl();
  build(wb, logo ? wb.addImage({ base64: logo, extension: "png" }) : null);
  const buf = await wb.xlsx.writeBuffer();
  return new Blob([buf], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
}

/** Todos os dados cadastrais dos desbravadores (a lista que está na tela). */
export function desbravadoresExcel(desb: Desbravador[], classes: Classe[], filtro = "") {
  return planilha((wb, logoId) => abaSimples(wb, logoId, "Desbravadores", `Dados dos desbravadores${filtro ? ` · ${filtro}` : ""}`, COLS_DESB, LARG_DESB, linhasDesb(desb, classes), "FFF26B1D"));
}

export async function desbravadoresPDF(desb: Desbravador[], classes: Classe[], filtro = "") {
  const { doc, autoTable, header, footer } = await pdfBase("Dados dos desbravadores", filtro || `${desb.length} desbravador(es)`, "#F26B1D");
  const linhas = linhasDesb(desb, classes);
  // PDF deitado: as colunas mais longas (endereço, observações) vão numa segunda tabela
  autoTable(doc, {
    margin: { top: 84, left: 20, right: 20, bottom: 28 },
    didDrawPage: header,
    startY: 84,
    head: [["#", "Nome", "Sexo", "Nasc.", "Idade", "CPF", "Classe", "Unidade", "Telefone", "Responsável 1", "Telefone 1", "Responsável 2", "Telefone 2"]],
    body: linhas.map((l) => [l[0], l[1], l[2], l[3], l[4], l[5], l[6], l[7], l[8], l[10], l[11], l[12], l[13]]),
    styles: { fontSize: 7.5, cellPadding: 3 },
    headStyles: { fillColor: [242, 107, 29], textColor: 255, fontSize: 7.5 },
    alternateRowStyles: { fillColor: [250, 247, 243] },
    columnStyles: { 0: { cellWidth: 20 }, 1: { cellWidth: 110, fontStyle: "bold" } },
  });
  autoTable(doc, {
    margin: { top: 84, left: 20, right: 20, bottom: 28 },
    didDrawPage: header,
    startY: (doc as unknown as { lastAutoTable: { finalY: number } }).lastAutoTable.finalY + 22,
    head: [["#", "Nome", "Endereço", "E-mail do responsável", "Observações", "Situação"]],
    body: linhas.map((l) => [l[0], l[1], l[9], l[14], l[15], l[16]]),
    styles: { fontSize: 7.5, cellPadding: 3 },
    headStyles: { fillColor: [28, 19, 14], textColor: 255, fontSize: 7.5 },
    alternateRowStyles: { fillColor: [250, 247, 243] },
    columnStyles: { 0: { cellWidth: 20 }, 1: { cellWidth: 110, fontStyle: "bold" }, 5: { cellWidth: 50 } },
  });
  footer();
  return doc.output("blob");
}

/** Todos os dados da diretoria (funções, classes, unidades, contato). */
export function diretoriaExcel(membros: Profile[], classes: Classe[], unidades: { id: string; nome: string }[]) {
  return planilha((wb, logoId) => abaSimples(wb, logoId, "Diretoria", "Dados da diretoria", COLS_DIR, LARG_DIR, linhasDiretoria(membros, classes, unidades)));
}

export async function diretoriaPDF(membros: Profile[], classes: Classe[], unidades: { id: string; nome: string }[]) {
  const { doc, autoTable, header, footer } = await pdfBase("Dados da diretoria", `${membros.length} membro(s)`, "#F26B1D");
  autoTable(doc, {
    margin: { top: 84, left: 20, right: 20, bottom: 28 },
    didDrawPage: header,
    startY: 84,
    head: [COLS_DIR],
    body: linhasDiretoria(membros, classes, unidades),
    styles: { fontSize: 7.5, cellPadding: 3 },
    headStyles: { fillColor: [28, 19, 14], textColor: 255, fontSize: 7.5 },
    alternateRowStyles: { fillColor: [250, 247, 243] },
    columnStyles: { 0: { cellWidth: 20 }, 1: { cellWidth: 100, fontStyle: "bold" } },
  });
  footer();
  return doc.output("blob");
}


export async function clubReportExcel(membros: Profile[], desb: Desbravador[], classes: Classe[], incluir: IncluirRelacao = "ambos"): Promise<Blob> {
  const ExcelJS = (await import("exceljs")).default;
  const wb = new ExcelJS.Workbook();
  wb.creator = "Tigres App";
  const logo = await logoDataUrl();
  const logoId = logo ? wb.addImage({ base64: logo, extension: "png" }) : null;
  const nomeClasse = (id?: number | null) => classes.find((c) => c.id === id)?.nome || "";

  if (incluir !== "desbravadores")
    abaSimples(
      wb,
      logoId,
      "Diretoria",
      "Relação da diretoria",
      ["#", "Nome", "Funções", "Classe(s)", "Idade", "Nascimento", "Telefone", "E-mail", "Situação"],
      [6, 30, 30, 26, 7, 12, 17, 30, 14],
      membros.map((m, i) => [
        i + 1,
        m.nome,
        m.status === "pendente" ? `Pediu: ${m.cargo_solicitado || "—"}` : funcoesTexto(m).replace(/ · /g, ", "),
        (m.classes || []).map((c) => `${nomeClasse(c.class_id)} (${c.funcao})`).join(", "),
        m.idade ?? "",
        isoToBr(m.data_nascimento),
        m.telefone || "",
        m.email,
        situacaoMembro(m),
      ]),
    );
  if (incluir !== "diretoria")
    abaSimples(
      wb,
      logoId,
      "Desbravadores",
      "Relação dos desbravadores",
      ["#", "Nome", "Classe", "Unidade", "Idade", "Nascimento", "Responsável 1", "Telefone 1", "Responsável 2", "Telefone 2", "Telefone do desbravador", "E-mail"],
      [6, 30, 15, 14, 7, 12, 26, 17, 26, 17, 17, 28],
      desb.map((d, i) => {
        const [r1, r2] = responsaveisDe(d);
        return [i + 1, d.nome, nomeClasse(d.class_id), d.unidade || "", d.idade ?? "", isoToBr(d.data_nascimento), r1.nome || "", r1.telefone || "", r2.nome || "", r2.telefone || "", d.telefone || "", d.email || ""];
      }),
      "FFF26B1D",
    );
  const buf = await wb.xlsx.writeBuffer();
  return new Blob([buf], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
}

export async function clubReportPDF(membros: Profile[], desb: Desbravador[], classes: Classe[], incluir: IncluirRelacao = "ambos"): Promise<Blob> {
  const sub = incluir === "ambos" ? "Diretoria e desbravadores" : incluir === "diretoria" ? "Diretoria" : "Desbravadores";
  const { doc, autoTable, header, footer } = await pdfBase("Relação do clube", sub, "#F26B1D");
  const nomeClasse = (id?: number | null) => classes.find((c) => c.id === id)?.nome || "";
  const common = { margin: { top: 84, left: 24, right: 24, bottom: 28 }, didDrawPage: header, styles: { fontSize: 8.5, cellPadding: 4 } };
  let y = 84;
  if (incluir !== "desbravadores") {
    autoTable(doc, {
      ...common,
      startY: y,
      head: [["#", "Diretoria", "Funções", "Classe(s)", "Idade", "Telefone", "E-mail", "Situação"]],
      body: membros.map((m, i) => [
        i + 1,
        m.nome,
        m.status === "pendente" ? `Pediu: ${m.cargo_solicitado || "—"}` : funcoesTexto(m).replace(/ · /g, ", "),
        (m.classes || []).map((c) => nomeClasse(c.class_id)).join(", "),
        m.idade ?? "",
        m.telefone || "",
        m.email,
        situacaoMembro(m),
      ]),
      headStyles: { fillColor: [28, 19, 14], textColor: 255 },
      alternateRowStyles: { fillColor: [250, 247, 243] },
    });
    y = (doc as unknown as { lastAutoTable: { finalY: number } }).lastAutoTable.finalY + 22;
  }
  if (incluir !== "diretoria")
    autoTable(doc, {
      ...common,
      startY: y,
      head: [["#", "Desbravador", "Classe", "Unidade", "Idade", "Responsável 1", "Telefone 1", "Responsável 2", "Telefone 2"]],
      body: desb.map((d, i) => {
        const [r1, r2] = responsaveisDe(d);
        return [i + 1, d.nome, nomeClasse(d.class_id), d.unidade || "", d.idade ?? "", r1.nome || "", r1.telefone || "", r2.nome || "", r2.telefone || ""];
      }),
      headStyles: { fillColor: [242, 107, 29], textColor: 255 },
      alternateRowStyles: { fillColor: [250, 247, 243] },
    });
  footer();
  return doc.output("blob");
}

// ---------------------------------------------------------------- Especialidades concluídas (para a compra)
export interface EspReportLinha {
  desbravador: Desbravador;
  esp: Especialidade;
  area: string;
  concluida_em: string;
}

function agruparPorEsp(linhas: EspReportLinha[]) {
  const m = new Map<string, { esp: Especialidade; area: string; nomes: string[] }>();
  linhas.forEach((l) => {
    const g = m.get(l.esp.codigo) || { esp: l.esp, area: l.area, nomes: [] };
    g.nomes.push(l.desbravador.nome);
    m.set(l.esp.codigo, g);
  });
  return [...m.values()].sort((a, b) => a.area.localeCompare(b.area, "pt-BR") || a.esp.nome.localeCompare(b.esp.nome, "pt-BR"));
}

function agruparPorDesb(linhas: EspReportLinha[]) {
  const m = new Map<string, { d: Desbravador; itens: EspReportLinha[] }>();
  linhas.forEach((l) => {
    const g = m.get(l.desbravador.id) || { d: l.desbravador, itens: [] };
    g.itens.push(l);
    m.set(l.desbravador.id, g);
  });
  return [...m.values()].sort((a, b) => a.d.nome.localeCompare(b.d.nome, "pt-BR"));
}

export async function espReportExcel(linhas: EspReportLinha[], periodo: string): Promise<Blob> {
  const ExcelJS = (await import("exceljs")).default;
  const wb = new ExcelJS.Workbook();
  wb.creator = "Tigres App";
  const logo = await logoDataUrl();
  const logoId = logo ? wb.addImage({ base64: logo, extension: "png" }) : null;
  const porEsp = agruparPorEsp(linhas);

  const resumo = abaSimples(
    wb,
    logoId,
    "Para comprar",
    `Especialidades para comprar · ${periodo}`,
    ["#", "Especialidade", "Código", "Área", "Quantidade", "Desbravadores"],
    [6, 34, 12, 30, 12, 70],
    porEsp.map((g, i) => [i + 1, g.esp.nome, g.esp.codigo, g.area, g.nomes.length, g.nomes.join(", ")]),
  );
  const total = resumo.addRow(["", "Total", "", "", linhas.length, ""]);
  total.font = { bold: true };
  total.getCell(5).alignment = { horizontal: "center" };
  resumo.getColumn(5).alignment = { horizontal: "center", vertical: "top" };

  const ordenadas = agruparPorDesb(linhas).flatMap((g) => g.itens.sort((a, b) => a.esp.nome.localeCompare(b.esp.nome, "pt-BR")));
  abaSimples(
    wb,
    logoId,
    "Por desbravador",
    `Especialidades concluídas por desbravador · ${periodo}`,
    ["#", "Desbravador", "Classe", "Unidade", "Especialidade", "Código", "Área", "Concluída em"],
    [6, 30, 15, 14, 34, 12, 30, 14],
    ordenadas.map((l, i) => [i + 1, l.desbravador.nome, l.desbravador.classe_nome || "", l.desbravador.unidade || "", l.esp.nome, l.esp.codigo, l.area, isoToBr(l.concluida_em)]),
    "FFF26B1D",
  );
  const buf = await wb.xlsx.writeBuffer();
  return new Blob([buf], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
}

export async function espReportPDF(linhas: EspReportLinha[], periodo: string): Promise<Blob> {
  const { doc, autoTable, header, footer } = await pdfBase("Especialidades para comprar", periodo, "#F26B1D");
  const common = { margin: { top: 84, left: 24, right: 24, bottom: 28 }, didDrawPage: header, styles: { fontSize: 8.5, cellPadding: 4 } };
  const porEsp = agruparPorEsp(linhas);
  autoTable(doc, {
    ...common,
    startY: 84,
    head: [["#", "Especialidade", "Código", "Área", "Qtd.", "Desbravadores"]],
    body: [...porEsp.map((g, i) => [i + 1, g.esp.nome, g.esp.codigo, g.area, g.nomes.length, g.nomes.join(", ")]), ["", "Total", "", "", linhas.length, ""]],
    headStyles: { fillColor: [28, 19, 14], textColor: 255 },
    alternateRowStyles: { fillColor: [250, 247, 243] },
    columnStyles: { 0: { cellWidth: 26 }, 1: { cellWidth: 150 }, 2: { cellWidth: 56 }, 3: { cellWidth: 130 }, 4: { cellWidth: 34, halign: "center" } },
    didParseCell: (c) => {
      if (c.section === "body" && c.row.index === porEsp.length) c.cell.styles.fontStyle = "bold";
    },
  });
  autoTable(doc, {
    ...common,
    startY: (doc as unknown as { lastAutoTable: { finalY: number } }).lastAutoTable.finalY + 22,
    head: [["#", "Desbravador", "Classe", "Qtd.", "Especialidades concluídas"]],
    body: agruparPorDesb(linhas).map((g, i) => [
      i + 1,
      g.d.nome,
      g.d.classe_nome || "",
      g.itens.length,
      g.itens
        .map((l) => l.esp.nome)
        .sort((a, b) => a.localeCompare(b, "pt-BR"))
        .join(", "),
    ]),
    headStyles: { fillColor: [242, 107, 29], textColor: 255 },
    alternateRowStyles: { fillColor: [250, 247, 243] },
    columnStyles: { 0: { cellWidth: 26 }, 1: { cellWidth: 150 }, 2: { cellWidth: 80 }, 3: { cellWidth: 34, halign: "center" } },
  });
  footer();
  return doc.output("blob");
}

// ---------------------------------------------------------------- utilidades
export function fileName(base: string, ext: "xlsx" | "pdf") {
  return `tigres-${slug(base)}-${new Date().toISOString().slice(0, 10)}.${ext}`;
}

/** No app Android (Capacitor) o WebView não baixa arquivos: salva e abre o "Compartilhar/Salvar" do celular. */
function noAppAndroid() {
  const cap = (globalThis as { Capacitor?: { isNativePlatform?: () => boolean } }).Capacitor;
  return !!cap?.isNativePlatform?.();
}

async function salvarNoApp(blob: Blob, name: string) {
  const [{ Filesystem, Directory }, { Share }] = await Promise.all([import("@capacitor/filesystem"), import("@capacitor/share")]);
  const { uri } = await Filesystem.writeFile({ path: name, data: await blobToBase64(blob), directory: Directory.Cache });
  await Share.share({ title: name, dialogTitle: "Salvar ou enviar arquivo", files: [uri] });
}

export function downloadBlob(blob: Blob, name: string) {
  if (noAppAndroid()) {
    return salvarNoApp(blob, name).catch((e) => {
      if (!/cancel/i.test(String((e as Error)?.message))) console.error(e);
    });
  }
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = name;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(url), 4000);
  return Promise.resolve();
}

export async function shareBlob(blob: Blob, name: string, title: string) {
  const file = new File([blob], name, { type: blob.type });
  const nav = navigator as Navigator & { canShare?: (d: ShareData) => boolean };
  if (nav.canShare && nav.canShare({ files: [file] })) {
    await navigator.share({ files: [file], title });
    return true;
  }
  return false;
}

export async function blobToBase64(blob: Blob) {
  const buf = await blob.arrayBuffer();
  let s = "";
  const bytes = new Uint8Array(buf);
  for (let i = 0; i < bytes.length; i += 0x8000) s += String.fromCharCode(...bytes.subarray(i, i + 0x8000));
  return btoa(s);
}

/** Planilha simples (uma aba) para listas como o inventário. */
export function tabelaExcel(aba: string, titulo: string, cols: string[], larguras: number[], linhas: (string | number)[][]) {
  return planilha((wb, logoId) => abaSimples(wb, logoId, aba, titulo, cols, larguras, linhas, "FFF26B1D"));
}

export async function tabelaPDF(titulo: string, subtitulo: string, cols: string[], linhas: (string | number)[][]) {
  const { doc, autoTable, header, footer } = await pdfBase(titulo, subtitulo, "#F26B1D");
  autoTable(doc, {
    margin: { top: 84, left: 20, right: 20, bottom: 28 },
    didDrawPage: header,
    startY: 84,
    head: [cols],
    body: linhas,
    styles: { fontSize: 8.5, cellPadding: 4 },
    headStyles: { fillColor: [242, 107, 29], textColor: 255, fontSize: 8.5 },
    alternateRowStyles: { fillColor: [250, 247, 243] },
    columnStyles: { 0: { cellWidth: 24 }, 1: { fontStyle: "bold" } },
  });
  footer();
  return doc.output("blob");
}
