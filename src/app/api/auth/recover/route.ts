import { NextResponse } from "next/server";
import { createAndSendCode, findUserByEmail } from "@/lib/server/auth";

export async function POST(req: Request) {
  try {
    const b = await req.json();
    const email = String(b.email || "").trim().toLowerCase();
    const u = await findUserByEmail(email);
    if (u) await createAndSendCode(email, "senha", u.nome, u.id);
    // resposta igual exista ou não o e-mail
    return NextResponse.json({ ok: true });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: (err as Error).message || "Erro inesperado." }, { status: 500 });
  }
}
