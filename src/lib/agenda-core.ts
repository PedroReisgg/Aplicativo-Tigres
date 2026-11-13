import type { AgendaEvento } from "./types";

/** Colunas que qualquer pessoa (sem login) pode ler. */
export const AGENDA_COLS = "id,titulo,descricao,inicio,fim,hora_inicio,hora_fim,cor,endereco,updated_at";

export const CORES_AGENDA = ["#F26B1D", "#D93A2B", "#C2185B", "#7B3FA0", "#2563A8", "#0E8C8C", "#2F7D4F", "#0B8043", "#C99A12", "#6B4A2E", "#475569", "#1C130E"];

export const pad2 = (n: number) => String(n).padStart(2, "0");
export const isoDia = (d: Date) => `${d.getFullYear()}-${pad2(d.getMonth() + 1)}-${pad2(d.getDate())}`;
export const hojeIso = () => isoDia(new Date());

/** "aaaa-mm-dd" -> Date ao meio-dia (evita pular de dia com fuso). */
export const dataLocal = (iso: string) => new Date(iso.slice(0, 10) + "T12:00:00");

export function somaDias(iso: string, n: number) {
  const d = dataLocal(iso);
  d.setDate(d.getDate() + n);
  return isoDia(d);
}

export const hhmm = (t: string | null | undefined) => (t ? t.slice(0, 5) : "");

/** Texto preto ou branco, o que ler melhor sobre a cor do card. */
export function textoSobre(hex: string) {
  const m = /^#?([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i.exec(hex || "");
  if (!m) return "#fff";
  const [r, g, b] = m.slice(1).map((x) => {
    const c = parseInt(x, 16) / 255;
    return c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4;
  });
  const L = 0.2126 * r + 0.7152 * g + 0.0722 * b;
  return L > 0.42 ? "#1C130E" : "#fff";
}

/** O evento acontece neste dia? */
export const noDia = (e: Pick<AgendaEvento, "inicio" | "fim">, dia: string) => e.inicio <= dia && (e.fim || e.inicio) >= dia;

const MESES = ["janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"];
const SEMANA = ["domingo", "segunda-feira", "terça-feira", "quarta-feira", "quinta-feira", "sexta-feira", "sábado"];
export const nomeMes = (m: number) => MESES[m];
export const diaSemana = (iso: string) => SEMANA[dataLocal(iso).getDay()];

/** "Sábado, 14 de novembro · 08:00 às 12:00" */
export function quando(e: Pick<AgendaEvento, "inicio" | "fim" | "hora_inicio" | "hora_fim">) {
  const d = (iso: string) => {
    const x = dataLocal(iso);
    return `${x.getDate()} de ${MESES[x.getMonth()]}${x.getFullYear() !== new Date().getFullYear() ? ` de ${x.getFullYear()}` : ""}`;
  };
  const dias = e.fim && e.fim !== e.inicio ? `${d(e.inicio)} a ${d(e.fim)}` : `${diaSemana(e.inicio).replace(/^./, (c) => c.toUpperCase())}, ${d(e.inicio)}`;
  const horas = e.hora_inicio ? (e.hora_fim ? `${hhmm(e.hora_inicio)} às ${hhmm(e.hora_fim)}` : `${hhmm(e.hora_inicio)}`) : "Dia inteiro";
  return `${dias} · ${horas}`;
}

export const linkGoogleMaps = (endereco: string) => `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(endereco)}`;
export const linkWaze = (endereco: string) => `https://waze.com/ul?q=${encodeURIComponent(endereco)}&navigate=yes`;

/* ---------- iCalendar (.ics) para Google Agenda e iPhone ---------- */

const esc = (s: string) => s.replace(/\\/g, "\\\\").replace(/;/g, "\;").replace(/,/g, "\\,").replace(/\r?\n/g, "\\n");

/** Quebra linhas em até 75 bytes, como pede o padrão. */
function dobrar(linha: string) {
  const enc = new TextEncoder();
  if (enc.encode(linha).length <= 75) return linha;
  const partes: string[] = [];
  let atual = "";
  for (const ch of linha) {
    if (enc.encode(atual + ch).length > (partes.length ? 74 : 75)) {
      partes.push(atual);
      atual = ch;
    } else atual += ch;
  }
  partes.push(atual);
  return partes.join("\r\n ");
}

const compacta = (iso: string) => iso.slice(0, 10).replace(/-/g, "");
/** Horário de Brasília (sem horário de verão desde 2019) -> UTC. */
function utc(dia: string, hora: string) {
  const [h, m] = hora.split(":").map(Number);
  const d = new Date(Date.UTC(Number(dia.slice(0, 4)), Number(dia.slice(5, 7)) - 1, Number(dia.slice(8, 10)), h + 3, m || 0));
  return `${d.getUTCFullYear()}${pad2(d.getUTCMonth() + 1)}${pad2(d.getUTCDate())}T${pad2(d.getUTCHours())}${pad2(d.getUTCMinutes())}00Z`;
}
const carimbo = (iso: string) => new Date(iso).toISOString().replace(/[-:]/g, "").replace(/\.\d{3}/, "");

export function gerarIcs(eventos: AgendaEvento[], nome = "Tigres do Riacho") {
  const L = [
    "BEGIN:VCALENDAR",
    "VERSION:2.0",
    "PRODID:-//Tigres do Riacho//Agenda do clube//PT-BR",
    "CALSCALE:GREGORIAN",
    "METHOD:PUBLISH",
    `X-WR-CALNAME:${esc(nome)}`,
    "X-WR-TIMEZONE:America/Sao_Paulo",
    "REFRESH-INTERVAL;VALUE=DURATION:PT1H",
    "X-PUBLISHED-TTL:PT1H",
  ];
  for (const e of eventos) {
    const ultimo = e.fim || e.inicio;
    L.push("BEGIN:VEVENT", `UID:${e.id}@tigresapp`, `DTSTAMP:${carimbo(e.updated_at)}`, `LAST-MODIFIED:${carimbo(e.updated_at)}`);
    if (e.hora_inicio) {
      const fimHora = e.hora_fim || `${pad2(Math.min(23, Number(e.hora_inicio.slice(0, 2)) + 1))}:${e.hora_inicio.slice(3, 5)}`;
      L.push(`DTSTART:${utc(e.inicio, e.hora_inicio)}`, `DTEND:${utc(ultimo, fimHora)}`);
    } else {
      L.push(`DTSTART;VALUE=DATE:${compacta(e.inicio)}`, `DTEND;VALUE=DATE:${compacta(somaDias(ultimo, 1))}`);
    }
    L.push(`SUMMARY:${esc(e.titulo)}`);
    if (e.descricao) L.push(`DESCRIPTION:${esc(e.descricao)}`);
    if (e.endereco) L.push(`LOCATION:${esc(e.endereco)}`);
    L.push("END:VEVENT");
  }
  L.push("END:VCALENDAR");
  return L.map(dobrar).join("\r\n") + "\r\n";
}

/** Link "adicionar este evento" no Google Agenda. */
export function linkGoogleEvento(e: AgendaEvento) {
  const ultimo = e.fim || e.inicio;
  const datas = e.hora_inicio
    ? `${utc(e.inicio, e.hora_inicio)}/${utc(ultimo, e.hora_fim || `${pad2(Math.min(23, Number(e.hora_inicio.slice(0, 2)) + 1))}:${e.hora_inicio.slice(3, 5)}`)}`
    : `${compacta(e.inicio)}/${compacta(somaDias(ultimo, 1))}`;
  const p = new URLSearchParams({ action: "TEMPLATE", text: e.titulo, dates: datas, ctz: "America/Sao_Paulo" });
  if (e.descricao) p.set("details", e.descricao);
  if (e.endereco) p.set("location", e.endereco);
  return `https://calendar.google.com/calendar/render?${p}`;
}

/** Endereço da agenda para assinar (Google Agenda / iPhone). */
export function linksAssinatura(origem: string) {
  const https = `${origem.replace(/\/$/, "")}/api/agenda.ics`;
  const webcal = https.replace(/^https?:/, "webcal:");
  return { https, webcal, google: `https://calendar.google.com/calendar/render?cid=${encodeURIComponent(webcal)}` };
}
