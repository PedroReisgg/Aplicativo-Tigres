import { NextResponse } from "next/server";
import { createAndSendCode, issueVerifiedSession, stateless, traduzErro, twoFactorEnabled } from "@/lib/server/auth";

export async function POST(req: Request) {
  try {
    const { email: e, password } = await req.json();
    const email = String(e || "").trim().toLowerCase();
    if (!email || !password) return NextResponse.json({ error: "Informe e-mail e senha." }, { status: 400 });

    if (!twoFactorEnabled()) {
      const r = await issueVerifiedSession(email, password);
      if (!r.ok) return NextResponse.json({ error: r.error }, { status: 401 });
      return NextResponse.json({ session: r.session });
    }

    // 1ª etapa: confere a senha sem entregar a sessão ao navegador
    const sb = stateless();
    const { data, error } = await sb.auth.signInWithPassword({ email, password });
    if (error || !data.session) {
      return NextResponse.json({ error: traduzErro(error?.message), unconfirmed: /not confirmed/i.test(error?.message || "") }, { status: 401 });
    }
    await sb.auth.signOut({ scope: "local" });
    const nome = (data.user.user_metadata?.nome as string) || undefined;
    await createAndSendCode(email, "login", nome, data.user.id);
    return NextResponse.json({ step: "code" });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: (err as Error).message || "Erro inesperado." }, { status: 500 });
  }
}
