"use client";

import Link from "next/link";
import { useState } from "react";
import { ArrowLeft, KeyRound } from "lucide-react";
import { toast } from "sonner";
import { Button, Input } from "@/components/ui";
import { applySession, CodeInput, PasswordInput, postJSON } from "@/components/auth-forms";
import { isStrongPassword, isValidEmail } from "@/lib/format";

export default function RecuperarPage() {
  const [step, setStep] = useState<"email" | "codigo">("email");
  const [email, setEmail] = useState("");
  const [code, setCode] = useState("");
  const [password, setPassword] = useState("");
  const [err, setErr] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function pedir(e: React.FormEvent) {
    e.preventDefault();
    if (!isValidEmail(email)) return setErr("Digite um e-mail válido.");
    setErr(null);
    setLoading(true);
    const r = await postJSON("/api/auth/recover", { email });
    setLoading(false);
    if (r.error) return setErr(r.error);
    setStep("codigo");
    toast.success("Se houver cadastro com este e-mail, o código chega em instantes.");
  }

  async function redefinir(e: React.FormEvent) {
    e.preventDefault();
    if (!isStrongPassword(password)) return setErr("A senha não atende aos requisitos.");
    setErr(null);
    setLoading(true);
    const r = await postJSON<{ session?: { access_token: string; refresh_token: string } }>("/api/auth/reset", { email, code, password });
    if (r.error || !r.session) {
      setLoading(false);
      return setErr(r.error || "Não foi possível redefinir.");
    }
    await applySession(r.session);
    toast.success("Senha alterada!");
    window.location.href = "/painel";
  }

  return (
    <div className="space-y-5">
      <Link href="/entrar" className="inline-flex items-center gap-1.5 text-sm font-medium text-ink-500 hover:text-ink-800">
        <ArrowLeft className="size-4" /> Voltar para entrar
      </Link>
      <div>
        <div className="mb-3 grid size-12 place-items-center rounded-2xl bg-tiger-100 text-tiger-700">
          <KeyRound className="size-6" />
        </div>
        <h1 className="font-display text-3xl font-semibold uppercase tracking-wide">Recuperar senha</h1>
        <p className="mt-1.5 text-ink-500">
          {step === "email" ? "Vamos enviar um código para o seu e-mail." : `Digite o código enviado para ${email} e escolha a nova senha.`}
        </p>
      </div>
      {step === "email" ? (
        <form onSubmit={pedir} className="space-y-5" noValidate>
          <Input label="E-mail" type="email" inputMode="email" autoComplete="email" value={email} onChange={(e) => setEmail(e.target.value)} error={err} required />
          <Button type="submit" size="lg" className="w-full" loading={loading} disabled={!email}>
            Enviar código
          </Button>
        </form>
      ) : (
        <form onSubmit={redefinir} className="space-y-5" noValidate>
          <CodeInput value={code} onChange={setCode} />
          <PasswordInput label="Nova senha" value={password} onChange={setPassword} autoComplete="new-password" showRules />
          {err && (
            <p className="rounded-xl bg-red-50 px-3 py-2.5 text-sm text-red-700" role="alert">
              {err}
            </p>
          )}
          <Button type="submit" size="lg" className="w-full" loading={loading} disabled={code.length !== 6 || !password}>
            Salvar nova senha
          </Button>
        </form>
      )}
    </div>
  );
}
