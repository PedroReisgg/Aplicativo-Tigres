import { NextResponse } from "next/server";
import { admin, createAndSendCode, issueVerifiedSession, traduzErro, twoFactorEnabled } from "@/lib/server/auth";
import { brToIso, isStrongPassword, isValidEmail, isValidPhone } from "@/lib/format";
import { CARGOS } from "@/lib/types";

export async function POST(req: Request) {
  try {
    const b = await req.json();
    const nome = String(b.nome || "").trim();
    const email = String(b.email || "").trim().toLowerCase();
    const telefone = String(b.telefone || "").trim();
    const nascimento = brToIso(String(b.data_nascimento || ""));
    const password = String(b.password || "");
    const cargo = CARGOS.includes(String(b.cargo)) ? String(b.cargo) : "";

    if (nome.split(/\s+/).length < 2) return NextResponse.json({ error: "Informe nome e sobrenome." }, { status: 400 });
    if (!isValidEmail(email)) return NextResponse.json({ error: "E-mail inválido." }, { status: 400 });
    if (!cargo) return NextResponse.json({ error: "Escolha seu cargo no clube." }, { status: 400 });
    if (!isValidPhone(telefone)) return NextResponse.json({ error: "Telefone inválido." }, { status: 400 });
    if (!nascimento) return NextResponse.json({ error: "Data de nascimento inválida." }, { status: 400 });
    if (!isStrongPassword(password)) return NextResponse.json({ error: "A senha não atende aos requisitos." }, { status: 400 });

    const db = admin();
    const meta = { nome, telefone, data_nascimento: nascimento, cargo };
    const confirmar = !twoFactorEnabled();
    const { data, error } = await db.auth.admin.createUser({ email, password, email_confirm: confirmar, user_metadata: meta });

    let userId = data?.user?.id;
    if (error) {
      if (!/already|registered|exists/i.test(error.message)) return NextResponse.json({ error: traduzErro(error.message) }, { status: 400 });
      // cadastro anterior não confirmado: atualiza e reenvia o código
      const { data: prof } = await db.from("profiles").select("id").eq("email", email).maybeSingle();
      if (!prof) return NextResponse.json({ error: "Já existe um cadastro com este e-mail." }, { status: 409 });
      const { data: u } = await db.auth.admin.getUserById(prof.id);
      if (u?.user?.email_confirmed_at) return NextResponse.json({ error: "Já existe um cadastro com este e-mail. Use Entrar." }, { status: 409 });
      await db.auth.admin.updateUserById(prof.id, { password, user_metadata: meta });
      await db.from("profiles").update({ nome, telefone, data_nascimento: nascimento, cargo_solicitado: cargo }).eq("id", prof.id);
      userId = prof.id;
    }

    if (confirmar) {
      const r = await issueVerifiedSession(email, password);
      if (!r.ok) return NextResponse.json({ error: r.error }, { status: 400 });
      return NextResponse.json({ session: r.session });
    }
    await createAndSendCode(email, "cadastro", nome, userId);
    return NextResponse.json({ step: "code" });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: (err as Error).message || "Erro inesperado." }, { status: 500 });
  }
}
