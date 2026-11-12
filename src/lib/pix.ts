import { isValidCPF, onlyDigits } from "./format";

/** Pix "copia e cola" (BR Code estático): quem paga digita o valor. */

const campo = (id: string, valor: string) => id + String(valor.length).padStart(2, "0") + valor;

const semAcento = (s: string) =>
  (s || "")
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-zA-Z0-9 .\-]/g, "")
    .trim();

function crc16(s: string) {
  let crc = 0xffff;
  for (let i = 0; i < s.length; i++) {
    crc ^= s.charCodeAt(i) << 8;
    for (let j = 0; j < 8; j++) crc = crc & 0x8000 ? ((crc << 1) ^ 0x1021) & 0xffff : (crc << 1) & 0xffff;
  }
  return crc.toString(16).toUpperCase().padStart(4, "0");
}

export type TipoChave = "copiaecola" | "email" | "cpf" | "cnpj" | "telefone" | "aleatoria" | "invalida";

export function tipoDaChave(chave: string | null | undefined): TipoChave {
  const c = (chave || "").trim();
  if (!c) return "invalida";
  if (c.startsWith("000201")) return "copiaecola";
  if (/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(c)) return "email";
  if (/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(c)) return "aleatoria";
  const d = onlyDigits(c);
  if (c.startsWith("+") && d.length >= 12) return "telefone";
  if (d.length === 11 && isValidCPF(d)) return "cpf";
  if (d.length === 14) return "cnpj";
  if (d.length === 10 || d.length === 11 || (d.length === 13 && d.startsWith("55"))) return "telefone";
  return "invalida";
}

export const NOME_TIPO_CHAVE: Record<TipoChave, string> = {
  copiaecola: "Pix copia e cola",
  email: "Chave e-mail",
  cpf: "Chave CPF",
  cnpj: "Chave CNPJ",
  telefone: "Chave celular",
  aleatoria: "Chave aleatória",
  invalida: "Chave não reconhecida",
};

/** Chave no formato que o Pix espera (telefone com +55, CPF só números…). */
export function chaveNormalizada(chave: string): string {
  const c = chave.trim();
  const t = tipoDaChave(c);
  const d = onlyDigits(c);
  if (t === "email") return c.toLowerCase();
  if (t === "cpf" || t === "cnpj") return d;
  if (t === "telefone") return "+" + (d.length >= 12 ? d : "55" + d);
  return c;
}

/** Monta o código "copia e cola". Se já colaram um código pronto, usa ele. */
export function pixCopiaECola(opts: { chave: string | null; nome: string | null; cidade: string | null; descricao?: string }): string | null {
  const chave = (opts.chave || "").trim();
  const tipo = tipoDaChave(chave);
  if (tipo === "copiaecola") return chave;
  if (tipo === "invalida") return null;
  const info = semAcento(opts.descricao || "").slice(0, 40);
  const conta = campo("00", "br.gov.bcb.pix") + campo("01", chaveNormalizada(chave)) + (info ? campo("02", info) : "");
  const nome = (semAcento(opts.nome || "") || "TIGRES DO RIACHO").toUpperCase().slice(0, 25);
  const cidade = (semAcento(opts.cidade || "") || "BRASIL").toUpperCase().slice(0, 15);
  const corpo =
    campo("00", "01") + campo("26", conta) + campo("52", "0000") + campo("53", "986") + campo("58", "BR") + campo("59", nome) + campo("60", cidade) + campo("62", campo("05", "***")) + "6304";
  return corpo + crc16(corpo);
}

export const reais = (v: number) => (Number(v) || 0).toLocaleString("pt-BR", { style: "currency", currency: "BRL" });

/** "1.234,56" ou "1234.56" -> 1234.56 */
export function lerValor(s: string): number | null {
  const t = (s || "").replace(/[^\d.,]/g, "");
  if (!t) return null;
  const n = /,\d{1,2}$/.test(t) ? Number(t.replace(/\./g, "").replace(",", ".")) : /\.\d{1,2}$/.test(t) ? Number(t.replace(/,/g, "")) : Number(t.replace(/[.,]/g, ""));
  return Number.isFinite(n) && n > 0 ? Math.round(n * 100) / 100 : null;
}
