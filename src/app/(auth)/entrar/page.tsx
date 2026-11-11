"use client";

import Link from "next/link";
import { useState } from "react";
import { ArrowLeft, MailCheck } from "lucide-react";
import { toast } from "sonner";
import { Button, Input } from "@/components/ui";
import { applySession, CodeInput, PasswordInput, postJSON } from "@/components/auth-forms";
import { isValidEmail } from "@/lib/format";

export default function EntrarPage() {
  const [step, setStep] = useState<"senha" | "codigo">("senha");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [code, setCode] = useState("");
  const [err, setErr] = useState<string | null>(null);
  const [emailErr, setEmailErr] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function finish(session: { access_token: string; refresh_token: string }) {
    await applySession(session);
    window.location.href = "/painel";
  }

  async function submitSenha(e: React.FormEvent) {
    e.preventDefault();
    setErr(null);
    if (!isValidEmail(email)) return setEmailErr("Digite um e-mail válido.");
    setLoading(true);
    const r = await postJSON<{ step?: string; session?: { access_token: string; refresh_token: string }; unconfirmed?: boolean }>("/api/auth/login", { email, password });
    setLoading(false);
    if (r.error) return setErr(r.unconfirmed ? "Seu cadastro ainda não foi confirmado. Faça o cadastro de novo para receber o código." : r.error);
    if (r.session) return finish(r.session);
    setStep("codigo");
    toast.success("Enviamos um código para o seu e-mail.");
  }

  async function submitCodigo(e: React.FormEvent) {
    e.preventDefault();
    setErr(null);
    setLoading(true);
    const r = await postJSON<{ session?: { access_token: string; refresh_token: string } }>("/api/auth/verify", { email, password, code, proposito: "login" });
    if (r.error || !r.session) {
      setLoading(false);
      return setErr(r.error || "Código inválido.");
    }
    try {
      await finish(r.session);
    } catch {
      setLoading(false);
      setErr("Não foi possível iniciar a sessão. Tente de novo.");
    }
  }

  async function reenviar() {
    await postJSON("/api/auth/resend", { email, proposito: "login" });
    toast.success("Se o e-mail estiver certo, um novo código chega em instantes.");
  }

  if (step === "codigo") {
    return (
      <form onSubmit={submitCodigo} className="space-y-5" noValidate>
        <button type="button" onClick={() => setStep("senha")} className="inline-flex items-center gap-1.5 text-sm font-medium text-ink-500 hover:text-ink-800">
          <ArrowLeft className="size-4" /> Voltar
        </button>
        <div>
          <div className="mb-3 grid size-12 place-items-center rounded-2xl bg-tiger-100 text-tiger-700">
            <MailCheck className="size-6" />
          </div>
          <h1 className="font-display text-3xl font-semibold uppercase tracking-wide">Verificação em 2 etapas</h1>
          <p className="mt-1.5 text-ink-500">
            Digite o código de 6 números que enviamos para <strong className="text-ink-800">{email}</strong>.
          </p>
        </div>
        <CodeInput value={code} onChange={setCode} error={err} />
        <Button type="submit" size="lg" className="w-full" loading={loading} disabled={code.length !== 6}>
          Confirmar e entrar
        </Button>
        <p className="text-center text-sm text-ink-500">
          Não chegou?{" "}
          <button type="button" onClick={reenviar} className="font-semibold text-tiger-700 hover:underline">
            Reenviar código
          </button>
        </p>
      </form>
    );
  }

  return (
    <form onSubmit={submitSenha} className="space-y-5" noValidate>
      <div>
        <h1 className="font-display text-3xl font-semibold uppercase tracking-wide">Entrar</h1>
        <p className="mt-1.5 text-ink-500">Acesso da diretoria do clube.</p>
      </div>
      <Input
        label="E-mail"
        type="email"
        autoComplete="email"
        inputMode="email"
        value={email}
        onChange={(e) => {
          setEmail(e.target.value);
          setEmailErr(null);
        }}
        onBlur={() => email && !isValidEmail(email) && setEmailErr("Digite um e-mail válido.")}
        error={emailErr}
        required
      />
      <PasswordInput value={password} onChange={setPassword} />
      {err && (
        <p className="rounded-xl bg-red-50 px-3 py-2.5 text-sm text-red-700" role="alert">
          {err}
        </p>
      )}
      <div className="flex justify-end">
        <Link href="/recuperar" className="text-sm font-semibold text-tiger-700 hover:underline">
          Esqueci minha senha
        </Link>
      </div>
      <Button type="submit" size="lg" className="w-full" loading={loading} disabled={!email || !password}>
        Continuar
      </Button>
      <p className="text-center text-sm text-ink-500">
        É da diretoria e ainda não tem conta?{" "}
        <Link href="/cadastro" className="font-semibold text-tiger-700 hover:underline">
          Criar cadastro
        </Link>
      </p>
    </form>
  );
}
