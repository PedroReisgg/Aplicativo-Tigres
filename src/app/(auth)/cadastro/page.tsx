"use client";

import Link from "next/link";
import { useState } from "react";
import { ArrowLeft, MailCheck } from "lucide-react";
import { toast } from "sonner";
import { Button, Input } from "@/components/ui";
import { FuncoesPicker } from "@/components/funcoes-picker";
import { applySession, CodeInput, PasswordInput, postJSON } from "@/components/auth-forms";
import { brToIso, isStrongPassword, isValidEmail, isValidPhone, maskDate, maskPhone } from "@/lib/format";

type Form = { nome: string; email: string; funcoes: string[]; telefone: string; data_nascimento: string; password: string; confirm: string };
const vazio: Form = { nome: "", email: "", funcoes: [], telefone: "", data_nascimento: "", password: "", confirm: "" };

function validar(f: Form): Partial<Record<keyof Form, string>> {
  const e: Partial<Record<keyof Form, string>> = {};
  if (f.nome.trim().split(/\s+/).length < 2) e.nome = "Informe nome e sobrenome.";
  if (!isValidEmail(f.email)) e.email = "Digite um e-mail válido.";
  if (!f.funcoes.length) e.funcoes = "Escolha pelo menos uma função.";
  if (!isValidPhone(f.telefone)) e.telefone = "Telefone com DDD, ex.: (11) 98765-4321.";
  if (!brToIso(f.data_nascimento)) e.data_nascimento = "Data no formato dd/mm/aaaa.";
  if (!isStrongPassword(f.password)) e.password = "A senha não atende aos requisitos abaixo.";
  if (f.confirm !== f.password) e.confirm = "As senhas não conferem.";
  return e;
}

export default function CadastroPage() {
  const [f, setF] = useState<Form>(vazio);
  const [touched, setTouched] = useState<Partial<Record<keyof Form, boolean>>>({});
  const [step, setStep] = useState<"dados" | "codigo">("dados");
  const [code, setCode] = useState("");
  const [err, setErr] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const errors = validar(f);
  const show = (k: keyof Form) => (touched[k] ? errors[k] : undefined);
  const set = (k: keyof Form) => (v: string | string[]) => setF((s) => ({ ...s, [k]: v }));
  const blur = (k: keyof Form) => () => setTouched((t) => ({ ...t, [k]: true }));

  async function enviar(e: React.FormEvent) {
    e.preventDefault();
    setTouched({ nome: true, email: true, funcoes: true, telefone: true, data_nascimento: true, password: true, confirm: true });
    if (Object.keys(errors).length) return;
    setErr(null);
    setLoading(true);
    const r = await postJSON<{ step?: string; session?: { access_token: string; refresh_token: string } }>("/api/auth/signup", f);
    setLoading(false);
    if (r.error) return setErr(r.error);
    if (r.session) {
      await applySession(r.session);
      window.location.href = "/painel";
      return;
    }
    setStep("codigo");
    toast.success("Enviamos um código para o seu e-mail.");
  }

  async function confirmar(e: React.FormEvent) {
    e.preventDefault();
    setErr(null);
    setLoading(true);
    const r = await postJSON<{ session?: { access_token: string; refresh_token: string } }>("/api/auth/verify", {
      email: f.email,
      password: f.password,
      code,
      proposito: "cadastro",
    });
    if (r.error || !r.session) {
      setLoading(false);
      return setErr(r.error || "Código inválido.");
    }
    await applySession(r.session);
    window.location.href = "/painel";
  }

  if (step === "codigo") {
    return (
      <form onSubmit={confirmar} className="space-y-5" noValidate>
        <button type="button" onClick={() => setStep("dados")} className="inline-flex items-center gap-1.5 text-sm font-medium text-ink-500 hover:text-ink-800">
          <ArrowLeft className="size-4" /> Voltar
        </button>
        <div>
          <div className="mb-3 grid size-12 place-items-center rounded-2xl bg-tiger-100 text-tiger-700">
            <MailCheck className="size-6" />
          </div>
          <h1 className="font-display text-3xl font-semibold uppercase tracking-wide">Confirme seu e-mail</h1>
          <p className="mt-1.5 text-ink-500">
            Digite o código de 6 números que enviamos para <strong className="text-ink-800">{f.email}</strong>.
          </p>
        </div>
        <CodeInput value={code} onChange={setCode} error={err} />
        <Button type="submit" size="lg" className="w-full" loading={loading} disabled={code.length !== 6}>
          Confirmar cadastro
        </Button>
        <p className="text-center text-sm text-ink-500">
          Não chegou?{" "}
          <button
            type="button"
            onClick={async () => {
              await postJSON("/api/auth/resend", { email: f.email, proposito: "cadastro" });
              toast.success("Novo código enviado.");
            }}
            className="font-semibold text-tiger-700 hover:underline"
          >
            Reenviar código
          </button>
        </p>
      </form>
    );
  }

  return (
    <form onSubmit={enviar} className="space-y-4" noValidate>
      <div className="mb-1">
        <h1 className="font-display text-3xl font-semibold uppercase tracking-wide">Cadastro da diretoria</h1>
        <p className="mt-1.5 text-ink-500">Só para quem faz parte da diretoria do clube. Desbravadores não precisam de conta. O diretor confere cada cadastro antes de liberar o acesso.</p>
      </div>
      <Input label="Nome completo" autoComplete="name" value={f.nome} onChange={(e) => set("nome")(e.target.value)} onBlur={blur("nome")} error={show("nome")} required />
      <Input label="E-mail" type="email" inputMode="email" autoComplete="email" value={f.email} onChange={(e) => set("email")(e.target.value)} onBlur={blur("email")} error={show("email")} required />
      <FuncoesPicker
        compacto
        value={f.funcoes}
        onChange={(v) => {
          set("funcoes")(v);
          setTouched((t) => ({ ...t, funcoes: true }));
        }}
        error={show("funcoes")}
        hint="Pode marcar mais de uma. O diretor confere e aprova antes de liberar o acesso."
      />
      <div className="grid gap-4 sm:grid-cols-2">
        <Input
          label="Telefone (WhatsApp)"
          inputMode="tel"
          autoComplete="tel-national"
          placeholder="(11) 98765-4321"
          value={f.telefone}
          onChange={(e) => set("telefone")(maskPhone(e.target.value))}
          onBlur={blur("telefone")}
          error={show("telefone")}
          required
        />
        <Input
          label="Data de nascimento"
          inputMode="numeric"
          autoComplete="bday"
          placeholder="dd/mm/aaaa"
          value={f.data_nascimento}
          onChange={(e) => set("data_nascimento")(maskDate(e.target.value))}
          onBlur={blur("data_nascimento")}
          error={show("data_nascimento")}
          required
        />
      </div>
      <PasswordInput label="Senha" value={f.password} onChange={set("password")} onBlur={blur("password")} error={show("password")} autoComplete="new-password" showRules />
      <PasswordInput label="Confirmar senha" value={f.confirm} onChange={set("confirm")} onBlur={blur("confirm")} error={show("confirm")} autoComplete="new-password" />
      {err && (
        <p className="rounded-xl bg-red-50 px-3 py-2.5 text-sm text-red-700" role="alert">
          {err}
        </p>
      )}
      <Button type="submit" size="lg" className="w-full" loading={loading}>
        Criar cadastro
      </Button>
      <p className="text-center text-sm text-ink-500">
        Já tem conta?{" "}
        <Link href="/entrar" className="font-semibold text-tiger-700 hover:underline">
          Entrar
        </Link>
      </p>
    </form>
  );
}
