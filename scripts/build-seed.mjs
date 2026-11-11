// Gera supabase/seed.sql a partir de data/mda/*.json
// Uso: node scripts/build-seed.mjs
import fs from "node:fs";

const classes = JSON.parse(fs.readFileSync("data/mda/classes.json", "utf8"));
const cats = JSON.parse(fs.readFileSync("data/mda/categorias.json", "utf8"));
const espsBrutas = JSON.parse(fs.readFileSync("data/mda/especialidades.json", "utf8"));

// A mesma especialidade aparece em duas áreas no wiki (ex.: Ensinos Bíblicos também está em
// Atividades Missionárias). Fica um registro só, na área mais específica.
const chave = (e) =>
  e.nome.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase().replace(/[^a-z0-9]/g, "") + "|" + e.codigo.replace(/^([A-Z]+-\d+)-\d+$/, "$1");
const MAIS_ESPECIFICA = ["ensinos-biblicos"];
const porChave = new Map();
const duplicadas = []; // [codigo duplicado, codigo mantido]
for (const e of espsBrutas) {
  const k = chave(e);
  const ja = porChave.get(k);
  if (!ja) {
    porChave.set(k, { ...e });
    continue;
  }
  duplicadas.push([e.codigo, ja.codigo]);
  if (MAIS_ESPECIFICA.includes(e.categoria)) ja.categoria = e.categoria;
  if ((e.requisitos || "").length > (ja.requisitos || "").length) ja.requisitos = e.requisitos;
}
const esps = [...porChave.values()];

const q = (v) => (v === null || v === undefined || v === "" ? "null" : `'${String(v).replace(/'/g, "''")}'`);
const n = (v) => (v === null || v === undefined || Number.isNaN(v) ? "null" : String(v));

const CLASSES = [
  [1, "amigo", "Amigo", 10, "#1D5FB4", "Amigo da Natureza"],
  [2, "companheiro", "Companheiro", 11, "#C8102E", "Companheiro de Excursionismo"],
  [3, "pesquisador", "Pesquisador", 12, "#2E7D32", "Pesquisador de Campo e Bosque"],
  [4, "pioneiro", "Pioneiro", 13, "#64748B", "Pioneiro de Novas Fronteiras"],
  [5, "excursionista", "Excursionista", 14, "#7B1E3A", "Excursionista na Mata"],
  [6, "guia", "Guia", 15, "#C99A06", "Guia de Exploração"],
];
const CAT_COR = {
  adra: "#0F766E",
  "artes-e-habilidades-manuais": "#B45309",
  "atividades-agricolas": "#4D7C0F",
  "atividades-missionarias": "#1D4ED8",
  "ensinos-biblicos": "#6D28D9",
  "atividades-profissionais": "#334155",
  "atividades-recreativas": "#DC2626",
  "ciencia-e-saude": "#0369A1",
  "estudos-da-natureza": "#15803D",
  "habilidades-domesticas": "#BE185D",
  mestrados: "#A16207",
};

const canon = new Map(duplicadas);
const byUrl = new Map(espsBrutas.map((e) => [e.url.normalize("NFC").toLowerCase(), canon.get(e.codigo) || e.codigo]));
const codeOf = (url) => byUrl.get(url.normalize("NFC").toLowerCase()) || null;

let sql = `-- Gerado por scripts/build-seed.mjs a partir do MDA Wiki (https://mda.wiki.br)\n-- Pode ser rodado mais de uma vez.\nbegin;\n\n`;

sql += `insert into public.classes (id, slug, nome, idade_minima, cor, classe_avancada, url_mda) values\n`;
sql += CLASSES.map(
  ([id, slug, nome, idade, cor, av]) =>
    `(${id}, ${q(slug)}, ${q(nome)}, ${idade}, ${q(cor)}, ${q(av)}, ${q(`https://mda.wiki.br/Cartão_de_${nome}/`)})`
).join(",\n");
sql += `\non conflict (id) do update set slug = excluded.slug, nome = excluded.nome, idade_minima = excluded.idade_minima, cor = excluded.cor, classe_avancada = excluded.classe_avancada, url_mda = excluded.url_mda;\n\n`;

sql += `insert into public.especialidade_categorias (slug, nome, cor, ordem, url_mda) values\n`;
sql += cats.map((c, i) => `(${q(c.slug)}, ${q(c.nome)}, ${q(CAT_COR[c.slug] || "#F26B1D")}, ${i + 1}, ${q(c.url)})`).join(",\n");
sql += `\non conflict (slug) do update set nome = excluded.nome, cor = excluded.cor, ordem = excluded.ordem, url_mda = excluded.url_mda;\n\n`;

const rows = esps.map(
  (e) =>
    `(${q(e.codigo)}, ${q(e.nome)}, ${q(e.categoria)}, ${q(e.tipo)}, ${n(e.nivel)}, ${n(e.ano)}, ${q(e.origem)}, ${q(e.imagem)}, ${q(e.url)}, '${String(e.requisitos || "").replace(/'/g, "''")}')`
);
for (let i = 0; i < rows.length; i += 100) {
  sql += `insert into public.especialidades (codigo, nome, categoria_slug, tipo, nivel, ano, origem, imagem, url_mda, requisitos) values\n`;
  sql += rows.slice(i, i + 100).join(",\n");
  sql += `\non conflict (codigo) do update set nome = excluded.nome, categoria_slug = excluded.categoria_slug, tipo = excluded.tipo, nivel = excluded.nivel, ano = excluded.ano, origem = excluded.origem, imagem = excluded.imagem, url_mda = excluded.url_mda, requisitos = excluded.requisitos;\n\n`;
}

// Remove registros duplicados, levando os vínculos para o registro mantido
if (duplicadas.length) {
  sql += `-- Especialidades duplicadas no wiki\n`;
  for (const [dup, keep] of duplicadas) {
    sql += `delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = ${q(dup)} and b.especialidade_codigo = ${q(keep)} and a.class_id = b.class_id;\n`;
    sql += `update public.class_especialidades set especialidade_codigo = ${q(keep)} where especialidade_codigo = ${q(dup)};\n`;
    sql += `delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = ${q(dup)} and b.especialidade_codigo = ${q(keep)} and a.desbravador_id = b.desbravador_id;\n`;
    sql += `update public.desbravador_especialidades set especialidade_codigo = ${q(keep)} where especialidade_codigo = ${q(dup)};\n`;
    sql += `update public.caderno_itens set especialidades = array_replace(especialidades, ${q(dup)}, ${q(keep)}) where ${q(dup)} = any(especialidades);\n`;
  }
  sql += `delete from public.especialidades where codigo in (${duplicadas.map(([d]) => q(d)).join(", ")});\n\n`;
}

// Caderno
const ROMAN = /^([IVX]+)\s*-\s*/;
const itens = [];
const classEsp = [];
for (const c of classes) {
  const cls = CLASSES.find((x) => x[2] === c.nome);
  if (!cls) continue;
  const cid = cls[0];
  c.secoes.forEach((s, si) => {
    const avancada = /avan/i.test(s.titulo);
    const m = ROMAN.exec(s.titulo);
    const prefix = avancada ? "AV" : m ? m[1] : String(si + 1);
    s.itens.forEach((it, ii) => {
      const codigos = [
        ...new Set(
          (it.esp || [])
            .concat((it.sub || []).flatMap((x) => (x.esp || []).concat((x.sub || []).flatMap((y) => y.esp || []))))
            .map(codeOf)
            .filter(Boolean)
        ),
      ];
      const detalhes = (it.sub || []).map((x) => ({ t: x.t, sub: (x.sub || []).map((y) => ({ t: y.t })) }));
      itens.push({
        cid,
        secao: s.titulo,
        secao_ordem: si + 1,
        ordem: ii + 1,
        codigo: `${prefix}.${ii + 1}`,
        texto: it.t,
        detalhes,
        codigos,
        avancada,
      });
      codigos.forEach((cod) => classEsp.push([cid, cod]));
    });
  });
}

sql += `-- Itens do caderno (não apaga itens personalizados)\n`;
sql += `delete from public.caderno_itens where personalizado = false and (class_id, codigo) not in (values ${itens
  .map((i) => `(${i.cid}::smallint, ${q(i.codigo)})`)
  .join(", ")});\n\n`;
for (let i = 0; i < itens.length; i += 80) {
  sql += `insert into public.caderno_itens (class_id, secao, secao_ordem, ordem, codigo, texto, detalhes, especialidades, avancada) values\n`;
  sql += itens
    .slice(i, i + 80)
    .map(
      (it) =>
        `(${it.cid}, ${q(it.secao)}, ${it.secao_ordem}, ${it.ordem}, ${q(it.codigo)}, ${q(it.texto)}, ${q(JSON.stringify(it.detalhes))}::jsonb, ${
          it.codigos.length ? `array[${it.codigos.map(q).join(", ")}]` : "'{}'"
        }::text[], ${it.avancada})`
    )
    .join(",\n");
  sql += `\non conflict (class_id, codigo) do update set secao = excluded.secao, secao_ordem = excluded.secao_ordem, ordem = excluded.ordem, texto = excluded.texto, detalhes = excluded.detalhes, especialidades = excluded.especialidades, avancada = excluded.avancada;\n\n`;
}

const uniq = [...new Map(classEsp.map((x) => [x.join("|"), x])).values()];
sql += `insert into public.class_especialidades (class_id, especialidade_codigo, obrigatoria) values\n`;
sql += uniq.map(([c, cod]) => `(${c}, ${q(cod)}, true)`).join(",\n");
sql += `\non conflict (class_id, especialidade_codigo) do update set obrigatoria = true;\n\ncommit;\n`;

fs.writeFileSync("supabase/seed.sql", sql);
console.log("duplicadas removidas:", duplicadas.length);
console.log("seed.sql:", (sql.length / 1024).toFixed(0), "KB |", itens.length, "itens |", esps.length, "especialidades |", uniq.length, "vínculos");
const semCodigo = classes
  .flatMap((c) => c.secoes.flatMap((s) => s.itens.flatMap((it) => (it.esp || []).concat((it.sub || []).flatMap((x) => x.esp || [])))))
  .filter((u) => !codeOf(u));
if (semCodigo.length) console.log("Links sem especialidade:", [...new Set(semCodigo)]);
