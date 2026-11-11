import "server-only";
import crypto from "node:crypto";
import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import { sendEmail, emailLayout } from "./email";

export type Proposito = "login" | "cadastro" | "senha";

const URL = () => process.env.NEXT_PUBLIC_SUPABASE_URL!;
const ANON = () => process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

export function admin(): SupabaseClient {
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!key) throw new Error("SUPABASE_SERVICE_ROLE_KEY não configurada");
  return createClient(URL(), key, { auth: { persistSession: false, autoRefreshToken: false } });
}

export function stateless(): SupabaseClient {
  return createClient(URL(), ANON(), { auth: { persistSession: false, autoRefreshToken: false } });
}

/** 2ª etapa desligada (ex.: sem domínio de e-mail configurado). */
export const twoFactorEnabled = () => process.env.AUTH_2FA !== "off";

const hash = (code: string) =>
  crypto.createHmac("sha256", process.env.SUPABASE_SERVICE_ROLE_KEY || "tigres").update(code).digest("hex");

const TITULOS: Record<Proposito, string> = {
  login: "Seu código de acesso",
  cadastro: "Confirme seu cadastro",
  senha: "Redefinição de senha",
};

export async function createAndSendCode(email: string, proposito: Proposito, nome?: string, userId?: string) {
  const db = admin();
  // limite: 1 código a cada 45 s por e-mail
  const { data: ult } = await db
    .from("codigos_verificacao")
    .select("created_at")
    .eq("email", email)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();
  if (ult && Date.now() - new Date(ult.created_at).getTime() < 45_000) {
    return { ok: true, throttled: true };
  }
  const code = String(crypto.randomInt(0, 1_000_000)).padStart(6, "0");
  await db.from("codigos_verificacao").update({ usado_em: new Date().toISOString() }).eq("email", email).is("usado_em", null);
  const { error } = await db.from("codigos_verificacao").insert({
    email,
    user_id: userId || null,
    proposito,
    codigo_hash: hash(code),
    expira_em: new Date(Date.now() + 10 * 60_000).toISOString(),
  });
  if (error) throw error;

  const ola = nome ? `Olá, ${nome.split(" ")[0]}!` : "Olá!";
  const texto =
    proposito === "cadastro"
      ? "Use o código abaixo para confirmar seu e-mail e concluir o cadastro no app do clube."
      : proposito === "senha"
      ? "Use o código abaixo para criar uma nova senha."
      : "Use o código abaixo para concluir a entrada no app do clube.";
  await sendEmail({
    to: email,
    subject: `${code} é o seu código · Tigres do Riacho`,
    html: emailLayout(
      TITULOS[proposito],
      `<p style="margin:0 0 12px">${ola}</p><p style="margin:0 0 20px">${texto}</p>
       <div style="font:700 34px/1 'Courier New',monospace;letter-spacing:10px;background:#FFF5EE;border:1px dashed #F26B1D;border-radius:14px;padding:18px 0;text-align:center;color:#1C130E">${code}</div>
       <p style="margin:20px 0 0;color:#7A6656;font-size:13px">O código vale por 10 minutos. Se não foi você, ignore este e-mail.</p>`
    ),
    text: `${ola}\n${texto}\n\nCódigo: ${code}\n\nVale por 10 minutos.`,
  });
  return { ok: true };
}

export async function checkCode(email: string, code: string, proposito: Proposito) {
  const db = admin();
  const { data } = await db
    .from("codigos_verificacao")
    .select("*")
    .eq("email", email)
    .eq("proposito", proposito)
    .is("usado_em", null)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();
  if (!data) return { ok: false, error: "Código expirado. Peça um novo código." };
  if (new Date(data.expira_em).getTime() < Date.now()) return { ok: false, error: "Código expirado. Peça um novo código." };
  if (data.tentativas >= 5) return { ok: false, error: "Muitas tentativas. Peça um novo código." };
  if (data.codigo_hash !== hash(code.replace(/\D/g, ""))) {
    await db.from("codigos_verificacao").update({ tentativas: data.tentativas + 1 }).eq("id", data.id);
    return { ok: false, error: "Código incorreto. Confira o e-mail e tente de novo." };
  }
  await db.from("codigos_verificacao").update({ usado_em: new Date().toISOString() }).eq("id", data.id);
  return { ok: true };
}

/** Faz login com senha e marca a sessão como verificada (2ª etapa concluída). */
export async function issueVerifiedSession(email: string, password: string) {
  const sb = stateless();
  const { data, error } = await sb.auth.signInWithPassword({ email, password });
  if (error || !data.session) return { ok: false as const, error: traduzErro(error?.message) };
  const sid = sessionIdFrom(data.session.access_token);
  if (sid) {
    await admin().from("sessoes_verificadas").upsert({ session_id: sid, user_id: data.user.id });
  }
  return { ok: true as const, session: { access_token: data.session.access_token, refresh_token: data.session.refresh_token } };
}

export function sessionIdFrom(jwt: string): string | null {
  try {
    const payload = JSON.parse(Buffer.from(jwt.split(".")[1], "base64url").toString("utf8"));
    return payload.session_id || null;
  } catch {
    return null;
  }
}

export async function findUserByEmail(email: string) {
  const { data } = await admin().from("profiles").select("id, nome, email").eq("email", email.toLowerCase()).maybeSingle();
  return data as { id: string; nome: string; email: string } | null;
}

export function traduzErro(msg?: string) {
  if (!msg) return "Não foi possível entrar. Tente de novo.";
  if (/invalid login credentials/i.test(msg)) return "E-mail ou senha incorretos.";
  if (/email not confirmed/i.test(msg)) return "E-mail ainda não confirmado.";
  if (/already (been )?registered|already exists/i.test(msg)) return "Já existe um cadastro com este e-mail.";
  if (/rate limit|too many/i.test(msg)) return "Muitas tentativas. Aguarde um minuto e tente de novo.";
  if (/password/i.test(msg)) return "A senha não atende aos requisitos.";
  return msg;
}

/** Confere o token da requisição e devolve o perfil ativo (com sessão verificada). */
export async function perfilDaRequisicao(req: Request) {
  const token = (req.headers.get("authorization") || "").replace(/^Bearer\s+/i, "");
  if (!token) return { erro: "Sessão expirada. Entre de novo.", status: 401 } as const;
  const db = admin();
  const { data: u } = await db.auth.getUser(token);
  if (!u?.user) return { erro: "Sessão expirada. Entre de novo.", status: 401 } as const;
  const { data: perfil } = await db.from("profiles").select("id, nome, email, status, is_admin, cargo").eq("id", u.user.id).single();
  if (!perfil || perfil.status !== "ativo") return { erro: "Acesso não liberado.", status: 403 } as const;
  const sid = sessionIdFrom(token);
  const { data: ok } = await db.from("sessoes_verificadas").select("session_id").eq("session_id", sid).maybeSingle();
  if (!ok) return { erro: "Sessão não verificada. Entre de novo.", status: 401 } as const;
  return { perfil: perfil as { id: string; nome: string; email: string; status: string; is_admin: boolean; cargo: string } } as const;
}
