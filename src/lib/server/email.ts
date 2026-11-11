import "server-only";
import { Resend } from "resend";

const SITE = process.env.NEXT_PUBLIC_SITE_URL || "https://tigresapp.vercel.app";

export function emailLayout(titulo: string, corpo: string) {
  return `<!doctype html><html lang="pt-BR"><body style="margin:0;background:#F3EDE6;font-family:Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:#2A1D15">
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="padding:24px 12px"><tr><td align="center">
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:520px;background:#fff;border-radius:18px;overflow:hidden">
    <tr><td style="background:#1C130E;padding:22px 24px" align="left">
      <table role="presentation"><tr>
        <td><img src="${SITE}/brand/logo.png" width="52" height="52" alt="Tigres do Riacho" style="display:block"></td>
        <td style="padding-left:12px;color:#fff;font:600 18px/1.2 Segoe UI,Arial,sans-serif;text-transform:uppercase;letter-spacing:.5px">Tigres do Riacho<br><span style="font-weight:400;font-size:12px;color:#C7B9AC;text-transform:none;letter-spacing:0">Clube de Desbravadores</span></td>
      </tr></table>
    </td></tr>
    <tr><td style="height:4px;background:#F26B1D"></td></tr>
    <tr><td style="padding:28px 24px 30px;font-size:15px;line-height:1.55">
      <h1 style="margin:0 0 16px;font-size:20px;color:#1C130E">${titulo}</h1>
      ${corpo}
    </td></tr>
  </table>
  <p style="color:#9C8B7D;font-size:12px;margin:16px 0 0">Enviado pelo app do Clube Tigres do Riacho · ${SITE.replace(/^https?:\/\//, "")}</p>
  </td></tr></table></body></html>`;
}

type Mail = {
  to: string | string[];
  subject: string;
  html: string;
  text?: string;
  attachments?: { filename: string; content: Buffer | string }[];
  replyTo?: string;
};

// Envia por SMTP (ex.: Gmail com senha de app) quando SMTP_USER/SMTP_PASS existem;
// senão usa o Resend. O Gmail entrega para qualquer endereço sem precisar de domínio.
export async function sendEmail(opts: Mail) {
  if (process.env.SMTP_USER && process.env.SMTP_PASS) return sendSmtp(opts);
  const key = process.env.RESEND_API_KEY;
  const from = process.env.EMAIL_FROM || "Tigres do Riacho <onboarding@resend.dev>";
  if (!key) {
    console.warn("[email] sem SMTP_USER/SMTP_PASS nem RESEND_API_KEY — e-mail não enviado para", opts.to, "\n" + (opts.text || opts.subject));
    if (process.env.NODE_ENV !== "production") return { id: "dev" };
    throw new Error("Envio de e-mail não configurado.");
  }
  const resend = new Resend(key);
  const { data, error } = await resend.emails.send({
    from,
    to: opts.to,
    subject: opts.subject,
    html: opts.html,
    text: opts.text,
    attachments: opts.attachments,
    replyTo: opts.replyTo,
  });
  if (error) throw new Error(error.message);
  return data;
}

async function sendSmtp(opts: Mail) {
  const nodemailer = (await import("nodemailer")).default;
  const user = process.env.SMTP_USER!;
  const port = Number(process.env.SMTP_PORT || 465);
  const transport = nodemailer.createTransport({
    host: process.env.SMTP_HOST || "smtp.gmail.com",
    port,
    secure: port === 465,
    auth: { user, pass: process.env.SMTP_PASS!.replace(/\s+/g, "") },
  });
  const info = await transport.sendMail({
    from: `Tigres do Riacho <${user}>`,
    to: opts.to,
    subject: opts.subject,
    html: opts.html,
    text: opts.text,
    replyTo: opts.replyTo,
    attachments: opts.attachments?.map((a) => ({
      filename: a.filename,
      content: typeof a.content === "string" ? Buffer.from(a.content, "base64") : a.content,
    })),
  });
  return { id: info.messageId };
}
