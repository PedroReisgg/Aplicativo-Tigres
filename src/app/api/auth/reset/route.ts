import { NextResponse } from "next/server";
import { admin, checkCode, findUserByEmail, issueVerifiedSession } from "@/lib/server/auth";
import { isStrongPassword } from "@/lib/format";

export async function POST(req: Request) {
  try {
    const b = await req.json();
    const email = String(b.email || "").trim().toLowerCase();
    const code = String(b.code || "");
    const password = String(b.password || "");
    if (!isStrongPassword(password)) return NextResponse.json({ error: "A senha não atende aos requisitos." }, { status: 400 });
    const u = await findUserByEmail(email);
    if (!u) return NextResponse.json({ error: "Código incorreto." }, { status: 400 });
    const c = await checkCode(email, code, "senha");
    if (!c.ok) return NextResponse.json({ error: c.error }, { status: 400 });
    const { error } = await admin().auth.admin.updateUserById(u.id, { password, email_confirm: true });
    if (error) return NextResponse.json({ error: error.message }, { status: 400 });
    const r = await issueVerifiedSession(email, password);
    if (!r.ok) return NextResponse.json({ error: r.error }, { status: 401 });
    return NextResponse.json({ session: r.session });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: (err as Error).message || "Erro inesperado." }, { status: 500 });
  }
}
