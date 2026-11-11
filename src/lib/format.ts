export const onlyDigits = (v: string) => (v || "").replace(/\D/g, "");

export function maskPhone(v: string) {
  const d = onlyDigits(v).slice(0, 11);
  if (d.length <= 2) return d.length ? `(${d}` : "";
  if (d.length <= 6) return `(${d.slice(0, 2)}) ${d.slice(2)}`;
  if (d.length <= 10) return `(${d.slice(0, 2)}) ${d.slice(2, 6)}-${d.slice(6)}`;
  return `(${d.slice(0, 2)}) ${d.slice(2, 7)}-${d.slice(7)}`;
}

export function maskCPF(v: string) {
  const d = onlyDigits(v).slice(0, 11);
  return d
    .replace(/(\d{3})(\d)/, "$1.$2")
    .replace(/(\d{3})\.(\d{3})(\d)/, "$1.$2.$3")
    .replace(/(\d{3})\.(\d{3})\.(\d{3})(\d{1,2})$/, "$1.$2.$3-$4");
}

export function maskDate(v: string) {
  const d = onlyDigits(v).slice(0, 8);
  if (d.length <= 2) return d;
  if (d.length <= 4) return `${d.slice(0, 2)}/${d.slice(2)}`;
  return `${d.slice(0, 2)}/${d.slice(2, 4)}/${d.slice(4)}`;
}

/** dd/mm/aaaa -> aaaa-mm-dd (ou null se inválida) */
export function brToIso(v: string): string | null {
  const m = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(v || "");
  if (!m) return null;
  const [, dd, mm, yy] = m;
  const dt = new Date(Number(yy), Number(mm) - 1, Number(dd));
  if (dt.getFullYear() !== Number(yy) || dt.getMonth() !== Number(mm) - 1 || dt.getDate() !== Number(dd)) return null;
  if (dt > new Date() || Number(yy) < 1900) return null;
  return `${yy}-${mm}-${dd}`;
}
export function isoToBr(v?: string | null) {
  if (!v) return "";
  const [y, m, d] = v.slice(0, 10).split("-");
  return `${d}/${m}/${y}`;
}

export function isValidPhone(v: string) {
  const d = onlyDigits(v);
  return d.length === 10 || d.length === 11;
}

export function isValidCPF(v: string) {
  const c = onlyDigits(v);
  if (c.length !== 11 || /^(\d)\1+$/.test(c)) return false;
  const calc = (n: number) => {
    let s = 0;
    for (let i = 0; i < n; i++) s += Number(c[i]) * (n + 1 - i);
    const r = (s * 10) % 11;
    return r === 10 ? 0 : r;
  };
  return calc(9) === Number(c[9]) && calc(10) === Number(c[10]);
}

export const isValidEmail = (v: string) => /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test((v || "").trim());

export const PASSWORD_RULES = [
  { id: "len", label: "Pelo menos 8 caracteres", test: (s: string) => s.length >= 8 },
  { id: "upper", label: "Uma letra maiúscula", test: (s: string) => /[A-ZÀ-Ý]/.test(s) },
  { id: "lower", label: "Uma letra minúscula", test: (s: string) => /[a-zà-ÿ]/.test(s) },
  { id: "special", label: "Um caractere especial (!@#$%…)", test: (s: string) => /[^A-Za-z0-9À-ÿ\s]/.test(s) },
];
export const isStrongPassword = (s: string) => PASSWORD_RULES.every((r) => r.test(s));

export function idade(iso?: string | null) {
  if (!iso) return null;
  const n = new Date(iso + "T12:00:00");
  const h = new Date();
  let a = h.getFullYear() - n.getFullYear();
  const m = h.getMonth() - n.getMonth();
  if (m < 0 || (m === 0 && h.getDate() < n.getDate())) a--;
  return a;
}

export function initials(nome?: string | null) {
  const p = (nome || "?").trim().split(/\s+/);
  return ((p[0]?.[0] || "") + (p.length > 1 ? p[p.length - 1][0] : "")).toUpperCase();
}

export function timeAgo(iso: string) {
  const s = Math.floor((Date.now() - new Date(iso).getTime()) / 1000);
  if (s < 60) return "agora";
  if (s < 3600) return `${Math.floor(s / 60)} min`;
  if (s < 86400) return `${Math.floor(s / 3600)} h`;
  if (s < 86400 * 7) return `${Math.floor(s / 86400)} d`;
  return new Date(iso).toLocaleDateString("pt-BR");
}

export const normalize = (s: string) =>
  (s || "")
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase();

export const waLink = (phone?: string | null) => {
  const d = onlyDigits(phone || "");
  return d ? `https://wa.me/55${d}` : null;
};
