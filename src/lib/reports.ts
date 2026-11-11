"use client";

import type { CadernoItem, Classe, DesbEsp, Desbravador, Especialidade, Profile, Progresso } from "./types";
import { isoToBr } from "./format";

export interface ClassReportData {
  classe: Classe;
  itens: CadernoItem[];
  desbravadores: Desbravador[];
  progresso: Progresso[];
  especialidades: Especialidade[]; // especialidades a listar (da classe + concluídas)
  classEsp: Set<string>; // códigos da classe
  desbEsp: DesbEsp[];
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
    const r = await fetch("/brand/logo.png");
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
  cabecalho(wd, "Cadastro dos desbravadores", 10);
  headerRow(wd.addRow(["#", "Nome", "Nascimento", "Idade", "Unidade", "Mãe", "Pai", "Telefone dos pais", "Telefone", "E-mail"]), DARK);
  [6, 32, 12, 7, 14, 26, 26, 18, 16, 28].forEach((w, i) => (wd.getColumn(i + 1).width = w));
  d.desbravadores.forEach((x, i) => {
    const row = wd.addRow([i + 1, x.nome, isoToBr(x.data_nascimento), x.idade ?? "", x.unidade || "", x.nome_mae || "", x.nome_pai || "", x.telefone_responsavel || "", x.telefone || "", x.email || ""]);
    row.eachCell((c) => (c.border = border));
  });

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
  const common = { margin: { top: 84, left: 24, right: 24, bottom: 28 }, didDrawPage: header, styles: { fontSize: 8.5, cellPadding: 4, lineColor: [230, 220, 210] as [number, number, number], lineWidth: 0.5 } };

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

  // 4. Legenda dos itens
  autoTable(doc, {
    ...common,
    startY: (doc as unknown as { lastAutoTable: { finalY: number } }).lastAutoTable.finalY + 22,
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
export async function clubReportExcel(membros: Profile[], desb: Desbravador[], classes: Classe[]): Promise<Blob> {
  const ExcelJS = (await import("exceljs")).default;
  const wb = new ExcelJS.Workbook();
  const logo = await logoDataUrl();
  const logoId = logo ? wb.addImage({ base64: logo, extension: "png" }) : null;
  const thin = { style: "thin" as const, color: { argb: "FFE6DCD2" } };
  const border = { top: thin, left: thin, bottom: thin, right: thin };
  const nomeClasse = (id?: number | null) => classes.find((c) => c.id === id)?.nome || "";

  const make = (nome: string, sub: string, cols: string[], widths: number[], rows: (string | number)[][]) => {
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
      c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FF1C130E" } };
      c.alignment = { vertical: "middle", horizontal: "center", wrapText: true };
      c.border = border;
    });
    widths.forEach((w, i) => (ws.getColumn(i + 1).width = w));
    rows.forEach((r, i) => {
      const row = ws.addRow(r);
      row.eachCell((c) => {
        c.border = border;
        if (i % 2) c.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FFFAF7F3" } };
      });
    });
  };

  make(
    "Diretoria",
    "Relação da diretoria",
    ["#", "Nome", "Cargo", "Classe(s)", "Idade", "Nascimento", "Telefone", "E-mail", "Situação"],
    [6, 30, 22, 26, 7, 12, 17, 30, 12],
    membros.map((m, i) => [
      i + 1,
      m.nome,
      m.cargo,
      (m.classes || []).map((c) => `${nomeClasse(c.class_id)} (${c.funcao})`).join(", "),
      m.idade ?? "",
      isoToBr(m.data_nascimento),
      m.telefone || "",
      m.email,
      m.status === "ativo" ? "Ativo" : m.status === "pendente" ? "Lista de espera" : "Inativo",
    ])
  );
  make(
    "Desbravadores",
    "Relação dos desbravadores",
    ["#", "Nome", "Classe", "Unidade", "Idade", "Nascimento", "Mãe", "Pai", "Telefone dos pais", "Telefone"],
    [6, 30, 15, 14, 7, 12, 26, 26, 18, 16],
    desb.map((d, i) => [i + 1, d.nome, nomeClasse(d.class_id), d.unidade || "", d.idade ?? "", isoToBr(d.data_nascimento), d.nome_mae || "", d.nome_pai || "", d.telefone_responsavel, d.telefone || ""])
  );
  const buf = await wb.xlsx.writeBuffer();
  return new Blob([buf], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
}

export async function clubReportPDF(membros: Profile[], desb: Desbravador[], classes: Classe[]): Promise<Blob> {
  const { doc, autoTable, header, footer } = await pdfBase("Relação geral do clube", "Diretoria e desbravadores", "#F26B1D");
  const nomeClasse = (id?: number | null) => classes.find((c) => c.id === id)?.nome || "";
  const common = { margin: { top: 84, left: 24, right: 24, bottom: 28 }, didDrawPage: header, styles: { fontSize: 8.5, cellPadding: 4 } };
  autoTable(doc, {
    ...common,
    startY: 84,
    head: [["#", "Diretoria", "Cargo", "Classe(s)", "Idade", "Telefone", "E-mail"]],
    body: membros
      .filter((m) => m.status !== "inativo")
      .map((m, i) => [i + 1, m.nome, m.status === "pendente" ? "Lista de espera" : m.cargo, (m.classes || []).map((c) => nomeClasse(c.class_id)).join(", "), m.idade ?? "", m.telefone || "", m.email]),
    headStyles: { fillColor: [28, 19, 14], textColor: 255 },
    alternateRowStyles: { fillColor: [250, 247, 243] },
  });
  autoTable(doc, {
    ...common,
    startY: (doc as unknown as { lastAutoTable: { finalY: number } }).lastAutoTable.finalY + 22,
    head: [["#", "Desbravador", "Classe", "Unidade", "Idade", "Responsáveis", "Telefone dos pais"]],
    body: desb.map((d, i) => [i + 1, d.nome, nomeClasse(d.class_id), d.unidade || "", d.idade ?? "", [d.nome_mae, d.nome_pai].filter(Boolean).join(" / "), d.telefone_responsavel]),
    headStyles: { fillColor: [242, 107, 29], textColor: 255 },
    alternateRowStyles: { fillColor: [250, 247, 243] },
  });
  footer();
  return doc.output("blob");
}

// ---------------------------------------------------------------- utilidades
export function fileName(base: string, ext: "xlsx" | "pdf") {
  return `tigres-${slug(base)}-${new Date().toISOString().slice(0, 10)}.${ext}`;
}

export function downloadBlob(blob: Blob, name: string) {
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = name;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(url), 4000);
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
