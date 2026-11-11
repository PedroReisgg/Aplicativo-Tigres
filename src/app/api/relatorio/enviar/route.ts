import { NextResponse } from "next/server";
import { admin, sessionIdFrom, twoFactorEnabled } from "@/lib/server/auth";
import { emailLayout, sendEmail } from "@/lib/server/email";
import { isValidEmail } from "@/lib/format";

export const maxDuration = 30;

export async function POST(req: Request) {
  try {
    const token = (req.headers.get("authorization") || "").replace(/^Bearer\s+/i, "");
    if (!token) return NextResponse.json({ error: "Sessão expirada. Entre de novo." }, { status: 401 });
    const db = admin();
    const { data: u } = await db.auth.getUser(token);
    if (!u?.user) return NextResponse.json({ error: "Sessão expirada. Entre de novo." }, { status: 401 });

    const { data: perfil } = await db.from("profiles").select("id, nome, email, status").eq("id", u.user.id).single();
    if (!perfil || perfil.status !== "ativo") return NextResponse.json({ error: "Acesso não liberado." }, { status: 403 });
    if (twoFactorEnabled()) {
      const sid = sessionIdFrom(token);
      const { data: ok } = await db.from("sessoes_verificadas").select("session_id").eq("session_id", sid).maybeSingle();
      if (!ok) return NextResponse.json({ error: "Sessão não verificada. Entre de novo." }, { status: 401 });
    }

    const b = await req.json();
    const arquivos = (b.arquivos || []) as { nome: string; base64: string }[];
    if (!arquivos.length) return NextResponse.json({ error: "Nenhum arquivo." }, { status: 400 });
    const tamanho = arquivos.reduce((s, a) => s + a.base64.length * 0.75, 0);
    if (tamanho > 15 * 1024 * 1024) return NextResponse.json({ error: "Arquivos grandes demais para e-mail." }, { status: 400 });

    let destinos: string[] = [];
    let adminIds: string[] = [];
    if (b.destino === "diretoria") {
      const { data: adms } = await db.from("profiles").select("id, email").eq("is_admin", true).eq("status", "ativo");
      destinos = (adms || []).map((a) => a.email).filter(Boolean);
      adminIds = (adms || []).map((a) => a.id).filter((id) => id !== perfil.id);
    } else {
      destinos = String(b.para || "")
        .split(/[,;\s]+/)
        .map((s) => s.trim().toLowerCase())
        .filter(Boolean);
      if (!destinos.length || destinos.some((e) => !isValidEmail(e))) return NextResponse.json({ error: "Confira o(s) e-mail(s) de destino." }, { status: 400 });
      if (destinos.length > 10) return NextResponse.json({ error: "Máximo de 10 destinatários." }, { status: 400 });
    }
    if (!destinos.length) return NextResponse.json({ error: "Nenhum destinatário encontrado." }, { status: 400 });

    const titulo = String(b.titulo || "Relatório").slice(0, 120);
    const msg = String(b.mensagem || "").slice(0, 2000);
    const esc = (s: string) => s.replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]!);
    await sendEmail({
      to: destinos,
      replyTo: perfil.email,
      subject: `${titulo} · Tigres do Riacho`,
      html: emailLayout(
        titulo,
        `<p style="margin:0 0 12px"><strong>${esc(perfil.nome)}</strong> enviou um relatório pelo app do clube.</p>
         ${msg ? `<p style="margin:0 0 12px;padding:12px 14px;background:#FAF7F3;border-left:3px solid #F26B1D;border-radius:8px">${esc(msg).replace(/\n/g, "<br>")}</p>` : ""}
         <p style="margin:0;color:#7A6656;font-size:13px">Arquivo(s) em anexo: ${arquivos.map((a) => esc(a.nome)).join(", ")}</p>`
      ),
      text: `${perfil.nome} enviou um relatório: ${titulo}\n\n${msg}`,
      attachments: arquivos.map((a) => ({ filename: a.nome, content: Buffer.from(a.base64, "base64") })),
    });

    if (adminIds.length) {
      await db.from("notificacoes").insert(
        adminIds.map((id) => ({
          destinatario_id: id,
          remetente_id: perfil.id,
          tipo: "relatorio",
          titulo: `Relatório recebido: ${titulo}`,
          mensagem: `${perfil.nome} enviou o relatório para o seu e-mail.${msg ? " Mensagem: " + msg : ""}`,
          link: b.link || null,
        }))
      );
    }
    return NextResponse.json({ ok: true, enviados: destinos.length });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: (err as Error).message || "Erro ao enviar." }, { status: 500 });
  }
}
