import { NextResponse } from "next/server";
import { createAndSendCode, findUserByEmail, type Proposito } from "@/lib/server/auth";

export async function POST(req: Request) {
  try {
    const b = await req.json();
    const email = String(b.email || "").trim().toLowerCase();
    const proposito: Proposito = ["cadastro", "senha"].includes(b.proposito) ? b.proposito : "login";
    const u = await findUserByEmail(email);
    if (u) await createAndSendCode(email, proposito, u.nome, u.id);
    return NextResponse.json({ ok: true });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: (err as Error).message || "Erro inesperado." }, { status: 500 });
  }
}
