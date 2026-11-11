// Confere e completa os dados do MDA Wiki já extraídos (data/mda/*.json e public/esp/*.webp).
// - Releitura de TODAS as páginas de especialidade (requisitos, nível, ano, origem)
// - Corrige links quebrados do wiki procurando o link alternativo com o mesmo nome
// - Baixa as imagens que faltam (convertidas para .webp)
// - Inclui especialidades que só aparecem como link de texto nas páginas de área
// - Releitura dos 6 cartões de classe
// Gera data/mda/verificacao.json com o resumo.
// Uso: node scripts/conferir-mda.mjs   (precisa de "sharp" e "linkedom")
import fs from "node:fs/promises";
import path from "node:path";
import sharp from "sharp";
import { BASE, CATEGORIAS, get, doc, clean, abs, codeFromImg, scrapeEspecialidade, scrapeClasses, pool } from "./scrape-mda.mjs";

const OUT = path.resolve("data/mda");
const IMG = path.resolve("public/esp");
const key = (s) =>
  decodeURIComponent(String(s))
    .replace(BASE, "")
    .replace(/^Especialidade_de_|^Mestrado_em_/i, "")
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]/g, "");
function lev(a, b) {
  const d = Array.from({ length: a.length + 1 }, (_, i) => [i, ...Array(b.length).fill(0)]);
  for (let j = 1; j <= b.length; j++) d[0][j] = j;
  for (let i = 1; i <= a.length; i++)
    for (let j = 1; j <= b.length; j++) d[i][j] = Math.min(d[i - 1][j] + 1, d[i][j - 1] + 1, d[i - 1][j - 1] + (a[i - 1] === b[j - 1] ? 0 : 1));
  return d[a.length][b.length];
}
const nLinhas = (t) => (t || "").split("\n").filter((l) => l.trim()).length;
const exists = (f) => fs.access(f).then(() => true, () => false);

async function pageImage(url) {
  const d = await doc(url);
  if (!d) return null;
  const pc = d.querySelector("#page-content") || d.body;
  const img = [...pc.querySelectorAll("img")].map((i) => abs(i.getAttribute("src"))).find((s) => /imagem@/i.test(s) && !/emblema/i.test(s));
  return img || null;
}

async function baixarImagem(src, codigo) {
  const r = await get(src);
  if (!r) return null;
  const buf = Buffer.from(await r.arrayBuffer());
  const file = codigo.toLowerCase() + ".webp";
  await sharp(buf).resize(256, 256, { fit: "inside", withoutEnlargement: true }).webp({ quality: 82 }).toFile(path.join(IMG, file));
  return `/esp/${file}`;
}

async function main() {
  const rel = { inicio: new Date().toISOString(), requisitosAtualizados: [], linksCorrigidos: [], imagensBaixadas: [], novas: [], semRequisitos: [], semImagem: [], classes: {} };
  const esps = JSON.parse(await fs.readFile(path.join(OUT, "especialidades.json"), "utf8"));
  const cats = JSON.parse(await fs.readFile(path.join(OUT, "categorias.json"), "utf8"));

  // 1) todos os links das páginas de área (com e sem imagem)
  const links = []; // {url, nome, img, categoria}
  for (const [page, slug] of CATEGORIAS) {
    const d = await doc(BASE + page + "/");
    if (!d) continue;
    const pc = d.querySelector("#page-content") || d.body;
    for (const a of pc.querySelectorAll("a")) {
      const href = abs(a.getAttribute("href"));
      if (!href.startsWith(BASE) || !/Especialidade_de_|Mestrado_em_/i.test(href)) continue;
      const img = a.querySelector("img");
      links.push({ url: href, nome: clean(a.textContent), img: img ? abs(img.getAttribute("src")) : "", categoria: slug });
    }
  }
  const conhecidas = new Set(esps.map((e) => key(e.url)));
  const conhecidasCod = new Set(esps.map((e) => e.codigo));

  // 2) especialidades que só aparecem como texto
  for (const l of links) {
    const k = key(l.url);
    if (conhecidas.has(k) || [...conhecidas].some((c) => lev(c, k) <= 2)) continue;
    const img = await pageImage(l.url);
    if (!img) continue;
    const codigo = codeFromImg(img, null);
    if (!codigo || conhecidasCod.has(codigo)) continue;
    const r = await scrapeEspecialidade({ url: l.url, nome: l.nome || decodeURIComponent(l.url.replace(BASE, "")).replace(/^Especialidade_de_|^Mestrado_em_/, "").replace(/_/g, " "), img, categoria: l.categoria, tipo: l.categoria === "mestrados" ? "mestrado" : "especialidade" });
    r.codigo = codigo;
    esps.push(r);
    conhecidas.add(k);
    conhecidasCod.add(codigo);
    rel.novas.push(`${codigo} ${r.nome}`);
  }

  // 3) releitura de todas as especialidades
  await pool(esps, 6, async (e, i) => {
    let r = await scrapeEspecialidade({ ...e });
    if (nLinhas(r.requisitos) < 2) {
      // link do wiki quebrado: tenta o link alternativo com nome parecido
      const k = key(e.url);
      const alts = [...new Set(links.filter((l) => l.url !== e.url && lev(key(l.url), k) <= 3).map((l) => l.url))];
      for (const u of alts) {
        const r2 = await scrapeEspecialidade({ ...e, url: u });
        if (nLinhas(r2.requisitos) >= 2) {
          rel.linksCorrigidos.push(`${e.codigo}: ${e.url} -> ${u}`);
          r = { ...r2, url: u };
          break;
        }
      }
    }
    if (nLinhas(r.requisitos) >= 2 && r.requisitos !== e.requisitos) {
      if (nLinhas(r.requisitos) >= nLinhas(e.requisitos)) {
        rel.requisitosAtualizados.push(`${e.codigo} ${e.nome} (${nLinhas(e.requisitos)} -> ${nLinhas(r.requisitos)} linhas)`);
        e.requisitos = r.requisitos;
        e.url = r.url;
      }
    }
    for (const f of ["nivel", "ano", "origem"]) if (r[f] != null && e[f] == null) e[f] = r[f];
    if (nLinhas(e.requisitos) < 2) rel.semRequisitos.push(`${e.codigo} ${e.nome} ${e.url}`);
    // imagem
    const file = path.join(IMG, e.codigo.toLowerCase() + ".webp");
    if (!(await exists(file))) {
      const src = (await pageImage(e.url)) || e.img;
      const im = src ? await baixarImagem(src, e.codigo).catch(() => null) : null;
      if (im) {
        e.imagem = im;
        rel.imagensBaixadas.push(e.codigo);
      } else rel.semImagem.push(`${e.codigo} ${e.nome}`);
    } else e.imagem = `/esp/${e.codigo.toLowerCase()}.webp`;
    if (i % 100 === 0) console.log("conferidas", i, "/", esps.length);
  });

  // 4) cartões de classe
  const antes = JSON.parse(await fs.readFile(path.join(OUT, "classes.json"), "utf8"));
  const novos = await scrapeClasses();
  const conta = (cl) => cl.secoes.reduce((n, s) => n + s.itens.length, 0);
  for (const c of novos) {
    const a = antes.find((x) => x.nome === c.nome);
    rel.classes[c.nome] = { secoes: c.secoes.length, itens: conta(c), antes: a ? conta(a) : null };
  }
  if (novos.length === 6 && novos.every((c) => conta(c) > 0)) await fs.writeFile(path.join(OUT, "classes.json"), JSON.stringify(novos, null, 1));

  // contagem por área
  for (const c of cats) c.total = esps.filter((e) => e.categoria === c.slug).length;
  await fs.writeFile(path.join(OUT, "categorias.json"), JSON.stringify(cats, null, 1));
  await fs.writeFile(path.join(OUT, "especialidades.json"), JSON.stringify(esps, null, 1));
  rel.total = esps.length;
  rel.fim = new Date().toISOString();
  await fs.writeFile(path.join(OUT, "verificacao.json"), JSON.stringify(rel, null, 1));
  console.log(JSON.stringify({ ...rel, requisitosAtualizados: rel.requisitosAtualizados.length }, null, 1));
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
