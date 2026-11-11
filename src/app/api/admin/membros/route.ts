import { NextResponse } from "next/server";
import { admin, perfilDaRequisicao, traduzErro } from "@/lib/server/auth";
import { brToIso, isStrongPassword, isValidEmail, isValidPhone } from "@/lib/format";
import { CARGOS, CARGOS_ADMIN } from "@/lib/types";

/** O diretor cria a conta de acesso de alguém da diretoria (já liberada). */
export async function POST(req: Request) {
  try {
    const quem = await perfilDaRequisicao(req);
    if ("erro" in quem) return NextResponse.json({ error: quem.erro }, { status: quem.status });
    if (!quem.perfil.is_admin) return NextResponse.json({ error: "Só o diretor e os diretores associados criam contas." }, { status: 403 });

    const b = await req.json();
    const nome = String(b.nome || "").trim();
    const email = String(b.email || "").trim().toLowerCase();
    const cargo = String(b.cargo || "");
    const telefone = String(b.telefone || "").trim();
    const nascimento = b.data_nascimento ? brToIso(String(b.data_nascimento)) : null;
    const password = String(b.password || "");

    if (nome.split(/\s+/).length < 2) return NextResponse.json({ error: "Informe nome e sobrenome." }, { status: 400 });
    if (!isValidEmail(email)) return NextResponse.json({ error: "E-mail inválido." }, { status: 400 });
    if (!CARGOS.includes(cargo)) return NextResponse.json({ error: "Escolha o cargo." }, { status: 400 });
    if (telefone && !isValidPhone(telefone)) return NextResponse.json({ error: "Telefone inválido." }, { status: 400 });
    if (b.data_nascimento && !nascimento) return NextResponse.json({ error: "Data de nascimento inválida." }, { status: 400 });
    if (!isStrongPassword(password)) return NextResponse.json({ error: "A senha não atende aos requisitos." }, { status: 400 });

    const db = admin();
    const { data, error } = await db.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
      user_metadata: { nome, telefone, data_nascimento: nascimento || "", cargo, criado_pelo_diretor: true },
    });
    if (error || !data.user) return NextResponse.json({ error: traduzErro(error?.message) }, { status: 400 });

    const up = await db
      .from("profiles")
      .update({ cargo, is_admin: CARGOS_ADMIN.includes(cargo), status: "ativo" })
      .eq("id", data.user.id);
    if (up.error) return NextResponse.json({ error: up.error.message }, { status: 500 });

    await db.from("notificacoes").insert({
      destinatario_id: data.user.id,
      remetente_id: quem.perfil.id,
      tipo: "acesso",
      titulo: "Bem-vindo(a) ao app do clube!",
      mensagem: `${quem.perfil.nome.split(" ")[0]} criou seu acesso como ${cargo}.`,
      link: "/painel",
    });
    return NextResponse.json({ id: data.user.id });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: (err as Error).message || "Erro inesperado." }, { status: 500 });
  }
}
