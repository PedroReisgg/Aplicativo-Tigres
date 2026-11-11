"use client";

import { useEffect, useRef, useState } from "react";
import { AlertTriangle, CheckCircle2, Download, FileSpreadsheet, RefreshCw, Upload, XCircle } from "lucide-react";
import { toast } from "sonner";
import { Badge, Button, Card, Sheet, cn } from "./ui";
import { useAuth } from "./auth-provider";
import { supabaseBrowser } from "@/lib/supabase/client";
import { getDesbravadores, getUnidades } from "@/lib/api";
import { downloadBlob } from "@/lib/reports";
import { idade, isoToBr, isValidEmail, isValidPhone, maskPhone, normalize, plural } from "@/lib/format";
import { CORES_UNIDADE, type Classe, type Desbravador, type Unidade } from "@/lib/types";

// ------------------------------------------------------------------ colunas da planilha
type Campo =
  | "nome"
  | "data_nascimento"
  | "sexo"
  | "nome_mae"
  | "nome_pai"
  | "telefone_responsavel"
  | "telefone"
  | "email"
  | "endereco"
  | "classe"
  | "unidade"
  | "observacoes";

const COLUNAS: { campo: Campo; titulo: string; largura: number; exemplo: string; nomes: string[] }[] = [
  { campo: "nome", titulo: "Nome completo *", largura: 34, exemplo: "Ana Beatriz Souza", nomes: ["nome", "nome completo", "nome do desbravador", "desbravador", "aluno"] },
  { campo: "data_nascimento", titulo: "Data de nascimento *", largura: 20, exemplo: "15/03/2014", nomes: ["data de nascimento", "nascimento", "data nascimento", "data nasc", "dt nascimento", "dn", "aniversario"] },
  { campo: "sexo", titulo: "Sexo (M/F)", largura: 11, exemplo: "F", nomes: ["sexo", "genero"] },
  { campo: "nome_mae", titulo: "Nome da mãe", largura: 28, exemplo: "Carla Souza", nomes: ["nome da mae", "mae"] },
  { campo: "nome_pai", titulo: "Nome do pai", largura: 28, exemplo: "Marcos Souza", nomes: ["nome do pai", "pai"] },
  {
    campo: "telefone_responsavel",
    titulo: "Telefone dos pais *",
    largura: 20,
    exemplo: "(11) 98765-4321",
    nomes: ["telefone dos pais", "contato dos pais", "telefone do responsavel", "telefone responsavel", "contato do responsavel", "whatsapp dos pais", "contato", "telefone pais", "celular dos pais"],
  },
  { campo: "telefone", titulo: "Telefone do desbravador", largura: 20, exemplo: "", nomes: ["telefone do desbravador", "celular do desbravador", "telefone", "celular"] },
  { campo: "email", titulo: "E-mail dos pais", largura: 26, exemplo: "carla@email.com", nomes: ["e-mail dos pais", "email dos pais", "e-mail", "email"] },
  { campo: "endereco", titulo: "Endereço", largura: 34, exemplo: "", nomes: ["endereco", "endereço"] },
  { campo: "classe", titulo: "Classe", largura: 16, exemplo: "Companheiro", nomes: ["classe", "classe atual"] },
  { campo: "unidade", titulo: "Unidade", largura: 18, exemplo: "Leões", nomes: ["unidade"] },
  { campo: "observacoes", titulo: "Observações", largura: 34, exemplo: "Alergia a amendoim", nomes: ["observacoes", "observacao", "obs", "saude", "alergias"] },
];

/** Gera a planilha-modelo para o diretor preencher. */
async function gerarModelo(classes: Classe[], unidades: Unidade[]) {
  const ExcelJS = (await import("exceljs")).default;
  const wb = new ExcelJS.Workbook();
  wb.creator = "Tigres App";
  const ws = wb.addWorksheet("Desbravadores", { views: [{ state: "frozen", ySplit: 1 }] });
  ws.columns = COLUNAS.map((c) => ({ header: c.titulo, key: c.campo, width: c.largura }));
  const head = ws.getRow(1);
  head.height = 24;
  head.eachCell((cell) => {
    cell.font = { bold: true, color: { argb: "FFFFFFFF" } };
    cell.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FFF26B1D" } };
    cell.alignment = { vertical: "middle" };
  });
  ws.addRow(Object.fromEntries(COLUNAS.map((c) => [c.campo, c.exemplo])));
  ws.getRow(2).font = { italic: true, color: { argb: "FF8A7768" } };

  // listas para escolher classe, unidade e sexo
  const listas = wb.addWorksheet("Listas", { state: "hidden" });
  classes.forEach((c, i) => (listas.getCell(i + 1, 1).value = c.nome));
  unidades.forEach((u, i) => (listas.getCell(i + 1, 2).value = u.nome));
  const colDe = (campo: Campo) => COLUNAS.findIndex((c) => c.campo === campo) + 1;
  for (let r = 2; r <= 400; r++) {
    ws.getCell(r, colDe("classe")).dataValidation = { type: "list", allowBlank: true, formulae: [`Listas!$A$1:$A$${Math.max(classes.length, 1)}`] };
    if (unidades.length)
      ws.getCell(r, colDe("unidade")).dataValidation = {
        type: "list",
        allowBlank: true,
        showErrorMessage: false,
        formulae: [`Listas!$B$1:$B$${unidades.length}`],
      };
    ws.getCell(r, colDe("sexo")).dataValidation = { type: "list", allowBlank: true, formulae: ['"M,F"'] };
    ws.getCell(r, colDe("data_nascimento")).numFmt = "dd/mm/yyyy";
  }

  const ajuda = wb.addWorksheet("Como preencher");
  ajuda.getColumn(1).width = 110;
  [
    "COMO PREENCHER A PLANILHA DE DESBRAVADORES",
    "",
    "1. Uma linha por desbravador, a partir da linha 2 da aba Desbravadores. Apague a linha de exemplo (em cinza).",
    "2. Colunas com * são obrigatórias: nome completo, data de nascimento e telefone dos pais.",
    "3. Data de nascimento no formato dd/mm/aaaa. A idade é calculada sozinha pelo app.",
    "4. Classe: escolha na lista (Amigo, Companheiro, Pesquisador, Pioneiro, Excursionista, Guia).",
    "   Se deixar em branco, o app escolhe a classe pela idade.",
    "5. Unidade: escreva o nome da unidade. Se ela ainda não existir no app, ela é criada na importação.",
    "6. Quem já estiver cadastrado (mesmo nome e data de nascimento) é atualizado, não duplicado.",
    "7. No app, vá em Desbravadores → Importar planilha e escolha este arquivo.",
  ].forEach((t, i) => {
    const c = ajuda.getCell(i + 1, 1);
    c.value = t;
    if (i === 0) c.font = { bold: true, size: 14, color: { argb: "FFF26B1D" } };
  });

  const buf = await wb.xlsx.writeBuffer();
  return new Blob([buf], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
}

// ------------------------------------------------------------------ leitura
type Linha = {
  n: number; // linha na planilha
  nome: string;
  data_nascimento: string | null;
  sexo: "M" | "F" | null;
  nome_mae: string | null;
  nome_pai: string | null;
  telefone_responsavel: string;
  telefone: string | null;
  email: string | null;
  endereco: string | null;
  class_id: number | null;
  classePelaIdade: boolean;
  unidade: string | null;
  observacoes: string | null;
  erros: string[];
  avisos: string[];
  existente?: Desbravador;
};

function textoDe(v: unknown): string {
  if (v == null) return "";
  if (typeof v === "object") {
    const o = v as { text?: string; richText?: { text: string }[]; result?: unknown; hyperlink?: string };
    if (o.richText) return o.richText.map((r) => r.text).join("");
    if (o.text != null) return String(o.text);
    if (o.result != null) return textoDe(o.result);
    if (o.hyperlink) return o.hyperlink.replace(/^mailto:/, "");
  }
  return String(v).trim();
}

const pad = (n: number) => String(n).padStart(2, "0");

/** Aceita data do Excel, número de série, dd/mm/aaaa, dd/mm/aa e aaaa-mm-dd. */
function dataDe(v: unknown): string | null {
  let d: Date | null = null;
  if (v instanceof Date) d = new Date(Date.UTC(v.getUTCFullYear(), v.getUTCMonth(), v.getUTCDate()));
  else if (typeof v === "number" && v > 1000 && v < 80000) d = new Date(Date.UTC(1899, 11, 30) + Math.round(v) * 86400000);
  else {
    const s = textoDe(v);
    let m = /^(\d{1,2})[/.-](\d{1,2})[/.-](\d{2,4})$/.exec(s);
    if (m) {
      let y = Number(m[3]);
      if (y < 100) y += y > new Date().getFullYear() % 100 ? 1900 : 2000;
      d = new Date(Date.UTC(y, Number(m[2]) - 1, Number(m[1])));
      if (d.getUTCDate() !== Number(m[1]) || d.getUTCMonth() !== Number(m[2]) - 1) return null;
    } else if ((m = /^(\d{4})-(\d{2})-(\d{2})/.exec(s))) {
      d = new Date(Date.UTC(Number(m[1]), Number(m[2]) - 1, Number(m[3])));
    }
  }
  if (!d || isNaN(d.getTime())) return null;
  const y = d.getUTCFullYear();
  if (y < 1950 || d.getTime() > Date.now()) return null;
  return `${y}-${pad(d.getUTCMonth() + 1)}-${pad(d.getUTCDate())}`;
}

function telefoneDe(v: unknown): string {
  let dig = textoDe(v).replace(/\D/g, "");
  if (dig.startsWith("55") && dig.length >= 12) dig = dig.slice(2);
  if (dig.startsWith("0") && dig.length >= 11) dig = dig.slice(1);
  return dig ? maskPhone(dig) : "";
}

function classePorNome(nome: string, classes: Classe[]): Classe | null {
  const n = normalize(nome).replace(/^classe (de |do |da )?/, "").trim();
  if (!n) return null;
  return classes.find((c) => normalize(c.nome) === n) || classes.find((c) => n.startsWith(normalize(c.nome))) || null;
}

function classePorIdade(anos: number | null, classes: Classe[]): Classe | null {
  if (anos == null) return null;
  const ok = [...classes].sort((a, b) => a.idade_minima - b.idade_minima).filter((c) => c.idade_minima <= anos);
  return ok.length ? ok[ok.length - 1] : null;
}

/** "Data Nasc." -> "data nasc"; "Nome completo *" -> "nome completo" */
const limpo = (s: string) => normalize(s).replace(/[^a-z0-9]+/g, " ").trim();

async function lerPlanilha(file: File, classes: Classe[], existentes: Desbravador[]): Promise<Linha[]> {
  const ExcelJS = (await import("exceljs")).default;
  const wb = new ExcelJS.Workbook();
  const buf = await file.arrayBuffer();
  if (/\.csv$/i.test(file.name)) {
    const texto = new TextDecoder("utf-8").decode(buf);
    const sep = (texto.split("\n")[0].match(/;/g) || []).length >= (texto.split("\n")[0].match(/,/g) || []).length ? ";" : ",";
    const ws = wb.addWorksheet("csv");
    texto
      .split(/\r?\n/)
      .filter((l) => l.trim())
      .forEach((l) => ws.addRow(l.split(sep).map((x) => x.replace(/^"|"$/g, "").trim())));
  } else {
    await wb.xlsx.load(buf);
  }
  const ws = wb.worksheets.find((w) => w.state !== "hidden" && w.actualRowCount > 0 && !/como preencher|listas/i.test(w.name)) || wb.worksheets[0];
  if (!ws) throw new Error("A planilha está vazia.");

  // acha a linha do cabeçalho (até a 10ª linha)
  let headerRow = 0;
  const mapa = new Map<Campo, number>();
  for (let r = 1; r <= Math.min(10, ws.rowCount) && !headerRow; r++) {
    const row = ws.getRow(r);
    const tentativa = new Map<Campo, number>();
    row.eachCell((cell, col) => {
      const t = limpo(textoDe(cell.value));
      if (!t) return;
      for (const c of COLUNAS) {
        if (tentativa.has(c.campo)) continue;
        if (c.nomes.some((nome) => t === limpo(nome) || (limpo(nome).includes(" ") && t.startsWith(limpo(nome) + " "))) || limpo(c.titulo) === t) {
          tentativa.set(c.campo, col);
          break;
        }
      }
    });
    if (tentativa.has("nome")) {
      headerRow = r;
      tentativa.forEach((v, k) => mapa.set(k, v));
    }
  }
  if (!headerRow) throw new Error('Não achei a coluna "Nome" na planilha. Use o modelo para baixar.');

  const chave = (nome: string, nasc: string | null) => `${normalize(nome)}|${nasc || ""}`;
  const porChave = new Map(existentes.map((d) => [chave(d.nome, d.data_nascimento), d]));
  const vistos = new Set<string>();
  const linhas: Linha[] = [];

  for (let r = headerRow + 1; r <= ws.rowCount; r++) {
    const row = ws.getRow(r);
    const val = (c: Campo) => (mapa.has(c) ? row.getCell(mapa.get(c)!).value : null);
    const nome = textoDe(val("nome")).replace(/\s+/g, " ");
    const resto = COLUNAS.some((c) => c.campo !== "nome" && textoDe(val(c.campo)));
    if (!nome && !resto) continue;
    // ignora a linha de exemplo do modelo
    if (nome === COLUNAS[0].exemplo && telefoneDe(val("telefone_responsavel")) === COLUNAS[5].exemplo) continue;

    const erros: string[] = [];
    const avisos: string[] = [];
    if (nome.length < 3) erros.push("Sem nome");

    const brutoNasc = val("data_nascimento");
    const nasc = dataDe(brutoNasc);
    if (!nasc) (textoDe(brutoNasc) ? erros : avisos).push(textoDe(brutoNasc) ? `Data inválida: "${textoDe(brutoNasc)}"` : "Sem data de nascimento");
    const anos = idade(nasc);

    const tel = telefoneDe(val("telefone_responsavel"));
    if (!tel) avisos.push("Sem telefone dos pais");
    else if (!isValidPhone(tel)) avisos.push("Telefone dos pais incompleto");
    const telD = telefoneDe(val("telefone"));

    const sexoTxt = normalize(textoDe(val("sexo")));
    const sexo = /^(m|masc)/.test(sexoTxt) ? "M" : /^(f|fem)/.test(sexoTxt) ? "F" : null;

    const emailTxt = textoDe(val("email")).toLowerCase();
    const email = emailTxt && isValidEmail(emailTxt) ? emailTxt : null;
    if (emailTxt && !email) avisos.push("E-mail inválido (ignorado)");

    const classeTxt = textoDe(val("classe"));
    let classe = classePorNome(classeTxt, classes);
    let classePelaIdade = false;
    if (classeTxt && !classe) avisos.push(`Classe "${classeTxt}" não existe`);
    if (!classe) {
      classe = classePorIdade(anos, classes);
      classePelaIdade = !!classe;
      if (!classe) avisos.push("Sem classe");
    }

    const k = chave(nome, nasc);
    if (vistos.has(k)) erros.push("Repetido na planilha");
    vistos.add(k);

    linhas.push({
      n: r,
      nome,
      data_nascimento: nasc,
      sexo,
      nome_mae: textoDe(val("nome_mae")) || null,
      nome_pai: textoDe(val("nome_pai")) || null,
      telefone_responsavel: tel,
      telefone: telD || null,
      email,
      endereco: textoDe(val("endereco")) || null,
      class_id: classe?.id ?? null,
      classePelaIdade,
      unidade: textoDe(val("unidade")).replace(/^unidade\s+/i, "") || null,
      observacoes: textoDe(val("observacoes")) || null,
      erros,
      avisos,
      existente: porChave.get(k),
    });
  }
  return linhas;
}

// ------------------------------------------------------------------ componente
export function ImportarDesbravadores({ open, onClose, onDone }: { open: boolean; onClose: () => void; onDone: () => void }) {
  const { classes, userId } = useAuth();
  const input = useRef<HTMLInputElement>(null);
  const [arquivo, setArquivo] = useState<string | null>(null);
  const [linhas, setLinhas] = useState<Linha[] | null>(null);
  const [lendo, setLendo] = useState(false);
  const [salvando, setSalvando] = useState(false);
  const [baixando, setBaixando] = useState(false);
  const [unidades, setUnidades] = useState<Unidade[]>([]);

  useEffect(() => {
    if (!open) return;
    setLinhas(null);
    setArquivo(null);
    getUnidades().then(setUnidades).catch(() => setUnidades([]));
  }, [open]);

  async function baixarModelo() {
    setBaixando(true);
    try {
      await downloadBlob(await gerarModelo(classes, unidades), "tigres-modelo-desbravadores.xlsx");
    } catch (e) {
      toast.error("Não foi possível gerar o modelo: " + (e as Error).message);
    } finally {
      setBaixando(false);
    }
  }

  async function escolher(file?: File | null) {
    if (!file) return;
    setLendo(true);
    setArquivo(file.name);
    try {
      const existentes = await getDesbravadores({ ativos: false });
      const ls = await lerPlanilha(file, classes, existentes);
      if (!ls.length) toast.error("Não achei nenhum desbravador na planilha.");
      setLinhas(ls);
    } catch (e) {
      toast.error((e as Error).message || "Não foi possível ler a planilha.");
      setLinhas(null);
    } finally {
      setLendo(false);
      if (input.current) input.current.value = "";
    }
  }

  const validas = (linhas || []).filter((l) => !l.erros.length);
  const novos = validas.filter((l) => !l.existente);
  const atualizar = validas.filter((l) => l.existente);
  const comErro = (linhas || []).filter((l) => l.erros.length);
  const unidadesNovas = [
    ...new Set(validas.map((l) => l.unidade).filter((u): u is string => !!u && !unidades.some((x) => normalize(x.nome) === normalize(u)))),
  ];

  async function importar() {
    if (!validas.length) return;
    setSalvando(true);
    const sb = supabaseBrowser();
    try {
      // 1. cria as unidades que ainda não existem
      let todas = unidades;
      if (unidadesNovas.length) {
        const vistos = new Map<string, string>();
        unidadesNovas.forEach((u) => vistos.set(normalize(u), u));
        const novas = [...vistos.values()].map((nome, i) => ({ nome, cor: CORES_UNIDADE[(unidades.length + i) % CORES_UNIDADE.length] }));
        const r = await sb.from("unidades").insert(novas).select("*");
        if (r.error) throw new Error("Erro ao criar unidades: " + r.error.message);
        todas = [...unidades, ...(r.data as Unidade[])];
      }
      const idUnidade = (nome: string | null) => (nome ? todas.find((u) => normalize(u.nome) === normalize(nome))?.id ?? null : null);

      const payload = (l: Linha) => ({
        nome: l.nome,
        data_nascimento: l.data_nascimento,
        sexo: l.sexo,
        nome_mae: l.nome_mae,
        nome_pai: l.nome_pai,
        telefone_responsavel: l.telefone_responsavel,
        telefone: l.telefone,
        email: l.email,
        endereco: l.endereco,
        class_id: l.class_id,
        unidade_id: idUnidade(l.unidade),
        observacoes: l.observacoes,
      });

      // 2. novos, em lotes
      for (let i = 0; i < novos.length; i += 100) {
        const lote = novos.slice(i, i + 100).map((l) => ({ ...payload(l), created_by: userId, ativo: true }));
        const r = await sb.from("desbravadores").insert(lote);
        if (r.error) throw new Error("Erro ao cadastrar: " + r.error.message);
      }
      // 3. já cadastrados: atualiza só o que veio preenchido na planilha
      for (const l of atualizar) {
        const p = payload(l);
        const up = Object.fromEntries(Object.entries(p).filter(([k, v]) => v != null && v !== "" && !(k === "class_id" && l.classePelaIdade)));
        const r = await sb.from("desbravadores").update({ ...up, ativo: true }).eq("id", l.existente!.id);
        if (r.error) throw new Error(`Erro ao atualizar ${l.nome}: ` + r.error.message);
      }
      toast.success(
        [novos.length && plural(novos.length, "desbravador cadastrado", "desbravadores cadastrados"), atualizar.length && plural(atualizar.length, "atualizado", "atualizados")]
          .filter(Boolean)
          .join(" e ") + "!"
      );
      onDone();
      onClose();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setSalvando(false);
    }
  }

  const nomeClasse = (id: number | null) => classes.find((c) => c.id === id);

  return (
    <Sheet
      open={open}
      onClose={onClose}
      title="Importar desbravadores"
      description="Cadastre todos de uma vez a partir de uma planilha do Excel."
      wide
      footer={
        <>
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
          <Button icon={<Upload className="size-4" />} onClick={importar} loading={salvando} disabled={!validas.length}>
            {validas.length ? `Importar ${plural(validas.length, "desbravador", "desbravadores")}` : "Importar"}
          </Button>
        </>
      }
    >
      <div className="space-y-5">
        <Card className="flex flex-col gap-3 p-4 sm:flex-row sm:items-center">
          <span className="grid size-11 shrink-0 place-items-center rounded-2xl bg-emerald-50 text-emerald-700">
            <FileSpreadsheet className="size-6" />
          </span>
          <div className="min-w-0 flex-1 text-sm">
            <div className="font-semibold text-ink-900">1. Baixe o modelo e preencha</div>
            <div className="text-ink-500">Nome, nascimento (a idade é calculada sozinha), contato dos pais, classe e unidade.</div>
          </div>
          <Button variant="secondary" icon={<Download className="size-4" />} onClick={baixarModelo} loading={baixando}>
            Baixar modelo
          </Button>
        </Card>

        <div>
          <div className="mb-2 text-sm font-semibold text-ink-900">2. Envie a planilha preenchida</div>
          <label
            className={cn(
              "flex cursor-pointer flex-col items-center justify-center gap-2 rounded-2xl border-2 border-dashed px-4 py-8 text-center transition-colors",
              lendo ? "border-tiger-300 bg-tiger-50" : "border-ink-200 hover:border-tiger-300 hover:bg-tiger-50/40"
            )}
            onDragOver={(e) => e.preventDefault()}
            onDrop={(e) => {
              e.preventDefault();
              escolher(e.dataTransfer.files?.[0]);
            }}
          >
            {lendo ? <RefreshCw className="size-6 animate-spin text-tiger-600" /> : <Upload className="size-6 text-ink-400" />}
            <span className="text-sm font-medium text-ink-800">{arquivo ? arquivo : "Toque para escolher o arquivo .xlsx"}</span>
            <span className="text-xs text-ink-500">{arquivo ? "Toque para trocar de arquivo" : "Também aceita .csv. Pode ser a lista que vocês já usam."}</span>
            <input
              ref={input}
              type="file"
              accept=".xlsx,.csv,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,text/csv"
              className="sr-only"
              onChange={(e) => escolher(e.target.files?.[0])}
            />
          </label>
        </div>

        {linhas && linhas.length > 0 && (
          <div>
            <div className="mb-2 text-sm font-semibold text-ink-900">3. Confira antes de importar</div>
            <div className="mb-3 flex flex-wrap gap-2 text-xs">
              <Badge tone="green">{plural(novos.length, "novo", "novos")}</Badge>
              {atualizar.length > 0 && <Badge tone="tiger">{plural(atualizar.length, "já cadastrado (atualiza)", "já cadastrados (atualiza)")}</Badge>}
              {comErro.length > 0 && <Badge tone="red">{plural(comErro.length, "com erro (fica de fora)", "com erro (ficam de fora)")}</Badge>}
              {unidadesNovas.length > 0 && <Badge tone="blue">Unidades novas: {unidadesNovas.join(", ")}</Badge>}
            </div>
            <ul className="divide-y divide-ink-100 overflow-hidden rounded-2xl border border-ink-200">
              {linhas.map((l) => {
                const c = nomeClasse(l.class_id);
                const anos = idade(l.data_nascimento);
                return (
                  <li key={l.n} className={cn("flex items-start gap-3 px-3 py-2.5 text-sm", l.erros.length > 0 && "bg-red-50/60")}>
                    {l.erros.length ? (
                      <XCircle className="mt-0.5 size-4 shrink-0 text-red-600" />
                    ) : l.avisos.length ? (
                      <AlertTriangle className="mt-0.5 size-4 shrink-0 text-amber-600" />
                    ) : (
                      <CheckCircle2 className="mt-0.5 size-4 shrink-0 text-emerald-600" />
                    )}
                    <div className="min-w-0 flex-1">
                      <div className="flex flex-wrap items-center gap-x-2">
                        <span className="font-semibold text-ink-900">{l.nome || "(sem nome)"}</span>
                        {l.existente && <span className="text-xs font-medium text-tiger-700">já cadastrado</span>}
                        <span className="text-xs text-ink-400">linha {l.n}</span>
                      </div>
                      <div className="text-xs text-ink-500">
                        {[
                          l.data_nascimento && `${isoToBr(l.data_nascimento)}${anos != null ? ` (${anos} anos)` : ""}`,
                          c && `${c.nome}${l.classePelaIdade ? " (pela idade)" : ""}`,
                          l.unidade && `Unidade ${l.unidade}`,
                          l.telefone_responsavel,
                        ]
                          .filter(Boolean)
                          .join(" · ")}
                      </div>
                      {[...l.erros, ...l.avisos].length > 0 && (
                        <div className={cn("mt-0.5 text-xs", l.erros.length ? "text-red-700" : "text-amber-700")}>{[...l.erros, ...l.avisos].join(" · ")}</div>
                      )}
                    </div>
                  </li>
                );
              })}
            </ul>
          </div>
        )}
      </div>
    </Sheet>
  );
}
