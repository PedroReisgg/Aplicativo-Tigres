// Extrai especialidades e cartões de classe do MDA Wiki (https://mda.wiki.br)
// Uso: node scripts/scrape-mda.mjs   (gera data/mda/*.json e public/esp/*.png)
import { parseHTML } from "linkedom";
import fs from "node:fs/promises";
import path from "node:path";

const BASE = "https://mda.wiki.br/";
const OUT = path.resolve("data/mda");
const IMG_OUT = path.resolve("public/esp");

const CATEGORIAS = [
  ["ADRA", "adra", "ADRA"],
  ["Artes_e_Habilidades_Manuais", "artes-e-habilidades-manuais", "Artes e Habilidades Manuais"],
  ["Atividades_Agrícolas", "atividades-agricolas", "Atividades Agrícolas"],
  ["Atividades_Missionárias_e_Comunitárias", "atividades-missionarias", "Atividades Missionárias e Comunitárias"],
  ["Atividades_Missionárias_e_Comunitárias_-_Ensinos_Biblicos", "ensinos-biblicos", "Ensinos Bíblicos"],
  ["Atividades_Profissionais", "atividades-profissionais", "Atividades Profissionais"],
  ["Atividades_Recreativas", "atividades-recreativas", "Atividades Recreativas"],
  ["Ciência_e_Saúde", "ciencia-e-saude", "Ciência e Saúde"],
  ["Estudos_da_Natureza", "estudos-da-natureza", "Estudos da Natureza"],
  ["Habilidades_Domésticas", "habilidades-domesticas", "Habilidades Domésticas"],
  ["Mestrados", "mestrados", "Mestrados"],
];
const CLASSES = ["Amigo", "Companheiro", "Pesquisador", "Pioneiro", "Excursionista", "Guia"];

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
async function get(url, tries = 4) {
  for (let i = 0; i < tries; i++) {
    try {
      const r = await fetch(encodeURI(decodeURI(url)), {
        headers: { "user-agent": "Mozilla/5.0 (compatible; TigresApp/1.0)" },
      });
      if (r.ok) return r;
      if (r.status === 404) return null;
    } catch {}
    await sleep(1000 * (i + 1));
  }
  return null;
}
async function doc(url) {
  const r = await get(url);
  if (!r) return null;
  const { document } = parseHTML(await r.text());
  return document;
}
const clean = (s) => (s || "").replace(/\s+/g, " ").trim();
const abs = (h) => {
  try {
    return decodeURI(new URL(h, BASE).href);
  } catch {
    return h;
  }
};

function liText(li) {
  const c = li.cloneNode(true);
  c.querySelectorAll("ol,ul").forEach((x) => x.remove());
  return clean(c.textContent);
}
function espOf(el) {
  return [...el.querySelectorAll("a")]
    .map((a) => abs(a.getAttribute("href")))
    .filter((h) => /Especialidade_de_|Mestrado_/.test(h));
}
function parseList(listEl) {
  const items = [];
  for (const ch of listEl.children) {
    if (ch.tagName === "LI") {
      const it = { t: liText(ch), sub: [], esp: espOf(ch) };
      for (const s of ch.children) if (s.tagName === "OL" || s.tagName === "UL") it.sub.push(...parseList(s));
      items.push(it);
    } else if ((ch.tagName === "OL" || ch.tagName === "UL") && items.length) {
      const sub = parseList(ch);
      const last = items[items.length - 1];
      last.sub.push(...sub);
    }
  }
  return items;
}
function listToText(listEl, depth = 0) {
  const out = [];
  let i = 0;
  let last = null;
  for (const ch of listEl.children) {
    if (ch.tagName === "LI") {
      i++;
      const marker = listEl.tagName === "OL" ? (depth % 2 === 0 ? `${i}.` : `${String.fromCharCode(96 + i)})`) : "•";
      out.push(`${"  ".repeat(depth)}${marker} ${liText(ch)}`);
      for (const s of ch.children) if (s.tagName === "OL" || s.tagName === "UL") out.push(...listToText(s, depth + 1));
      last = ch;
    } else if ((ch.tagName === "OL" || ch.tagName === "UL") && last) {
      out.push(...listToText(ch, depth + 1));
    }
  }
  return out;
}

function codeFromImg(src, fallback) {
  const m = /imagem@([a-z]+)(\d+)/i.exec(src || "");
  if (m) return `${m[1].toUpperCase()}-${m[2]}`;
  return fallback;
}

async function scrapeCategorias() {
  const list = [];
  for (const [page, slug, nome] of CATEGORIAS) {
    const d = await doc(BASE + page + "/");
    if (!d) {
      console.error("Falha categoria", page);
      continue;
    }
    const pc = d.querySelector("#page-content") || d.body;
    const seen = new Map();
    for (const a of pc.querySelectorAll("a")) {
      const href = abs(a.getAttribute("href"));
      if (!href.startsWith(BASE)) continue;
      if (!seen.has(href)) seen.set(href, { url: href, nome: "", img: "" });
      const o = seen.get(href);
      const img = a.querySelector("img");
      if (img) o.img = abs(img.getAttribute("src"));
      else if (clean(a.textContent)) o.nome = clean(a.textContent);
    }
    const items = [...seen.values()].filter((o) => o.img);
    for (const it of items) {
      if (!it.nome) {
        const raw = decodeURIComponent(it.url.replace(BASE, "")).replace(/^Especialidade_de_|^Mestrado_em_/, "");
        it.nome = raw.replace(/_/g, " ");
      }
      it.categoria = slug;
      it.tipo = slug === "mestrados" ? "mestrado" : "especialidade";
    }
    console.log(nome, items.length);
    list.push({ slug, nome, url: BASE + page + "/", items });
  }
  return list;
}

async function scrapeEspecialidade(it) {
  const d = await doc(it.url);
  if (!d) return { ...it, requisitos: "", erro: true };
  const pc = d.querySelector("#page-content") || d.body;
  const meta = {};
  const tb = pc.querySelector("table");
  if (tb) {
    const cells = [...tb.querySelectorAll("tr")].map((r) => [...r.children].map((c) => clean(c.textContent)));
    if (cells.length >= 2) meta.valores = cells[1];
    meta.cabecalho = cells[0];
  }
  const lines = [];
  const els = [...pc.querySelectorAll("ol, ul, p, h2, h3")].filter(
    (e) => !e.closest("li") && !e.closest("table") && !["OL", "UL"].includes(e.parentElement?.tagName)
  );
  for (const e of els) {
    if (e.tagName === "OL" || e.tagName === "UL") lines.push(...listToText(e, 0));
    else {
      const t = clean(e.textContent);
      if (t && t.length < 600) lines.push((e.tagName === "P" ? "" : "## ") + t);
    }
  }
  const v = meta.valores || [];
  // tabela: [Área(sigla)?, Código, Nível, Ano, Instituição]
  const nums = v.filter((x) => /^\d+$/.test(x));
  const nivel = nums.find((x) => x.length === 1) || null;
  const ano = nums.find((x) => x.length === 4) || null;
  const origem = v.find((x) => /[a-zA-Z]{4,}/.test(x) && !/^[A-Z]{1,5}$/.test(x)) || null;
  return {
    ...it,
    nivel: nivel ? Number(nivel) : null,
    ano: ano ? Number(ano) : null,
    origem,
    requisitos: lines.join("\n").trim(),
  };
}

async function scrapeClasses() {
  const out = [];
  for (const c of CLASSES) {
    const d = await doc(`${BASE}Cartão_de_${c}/`);
    if (!d) {
      console.error("Falha classe", c);
      continue;
    }
    const pc = d.querySelector("#page-content") || d.body;
    const secs = [];
    let cur = null;
    const els = [...pc.querySelectorAll("h2,h3,ol,ul,p")].filter(
      (e) => !e.closest("li") && !["OL", "UL"].includes(e.parentElement?.tagName) && !e.classList.contains("indice_1")
    );
    for (const e of els) {
      if (e.tagName === "H2" || e.tagName === "H3") {
        cur = { titulo: clean(e.textContent), itens: [], notas: [] };
        secs.push(cur);
        continue;
      }
      if (!cur) continue;
      if (e.tagName === "P") {
        const t = clean(e.textContent);
        if (t) cur.notas.push(t.slice(0, 600));
        continue;
      }
      cur.itens.push(...parseList(e));
    }
    console.log("Classe", c, secs.length);
    out.push({ nome: c, url: `${BASE}Cartão_de_${c}/`, secoes: secs });
  }
  return out;
}

async function pool(items, n, fn) {
  const res = new Array(items.length);
  let i = 0;
  await Promise.all(
    Array.from({ length: n }, async () => {
      while (i < items.length) {
        const k = i++;
        res[k] = await fn(items[k], k);
      }
    })
  );
  return res;
}

async function main() {
  await fs.mkdir(OUT, { recursive: true });
  await fs.mkdir(IMG_OUT, { recursive: true });
  const classes = await scrapeClasses();
  await fs.writeFile(path.join(OUT, "classes.json"), JSON.stringify(classes, null, 1));

  const cats = await scrapeCategorias();
  const all = cats.flatMap((c) => c.items);
  const usados = new Set();
  const det = await pool(all, 6, async (it, k) => {
    const r = await scrapeEspecialidade(it);
    let codigo = codeFromImg(it.img, `X-${k}`);
    if (usados.has(codigo)) codigo = `${codigo}-${k}`;
    usados.add(codigo);
    r.codigo = codigo;
    // baixa a imagem
    const file = codigo.toLowerCase() + ".png";
    try {
      const ir = await get(it.img);
      if (ir) {
        await fs.writeFile(path.join(IMG_OUT, file), Buffer.from(await ir.arrayBuffer()));
        r.imagem = `/esp/${file}`;
      }
    } catch {}
    if (k % 50 === 0) console.log("especialidades", k, "/", all.length);
    return r;
  });
  await fs.writeFile(
    path.join(OUT, "categorias.json"),
    JSON.stringify(cats.map(({ items, ...c }) => ({ ...c, total: items.length })), null, 1)
  );
  await fs.writeFile(path.join(OUT, "especialidades.json"), JSON.stringify(det, null, 1));
  console.log("OK", det.length, "erros:", det.filter((d) => d.erro).length);
}

export { BASE, CATEGORIAS, get, doc, clean, abs, codeFromImg, scrapeCategorias, scrapeEspecialidade, scrapeClasses, pool };

if (import.meta.url === `file://${process.argv[1]}`) {
  main().catch((e) => {
    console.error(e);
    process.exit(1);
  });
}
