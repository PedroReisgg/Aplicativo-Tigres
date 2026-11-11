import { NextResponse } from "next/server";
import { admin, checkCode, findUserByEmail, issueVerifiedSession, type Proposito } from "@/lib/server/auth";

export async function POST(req: Request) {
  try {
    const b = await req.json();
    const email = String(b.email || "").trim().toLowerCase();
    const code = String(b.code || "");
    const password = String(b.password || "");
    const proposito: Proposito = b.proposito === "cadastro" ? "cadastro" : "login";
    if (!email || !password || code.replace(/\D/g, "").length !== 6) {
      return NextResponse.json({ error: "Digite o código de 6 números." }, { status: 400 });
    }
    const c = await checkCode(email, code, proposito);
    if (!c.ok) return NextResponse.json({ error: c.error }, { status: 400 });

    if (proposito === "cadastro") {
      const u = await findUserByEmail(email);
      if (u) await admin().auth.admin.updateUserById(u.id, { email_confirm: true });
    }
    const r = await issueVerifiedSession(email, password);
    if (!r.ok) return NextResponse.json({ error: r.error }, { status: 401 });
    return NextResponse.json({ session: r.session });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: (err as Error).message || "Erro inesperado." }, { status: 500 });
  }
}
