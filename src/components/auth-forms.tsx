"use client";

import { useState } from "react";
import { Check, Circle, Eye, EyeOff } from "lucide-react";
import { PASSWORD_RULES } from "@/lib/format";
import { cn, Input } from "./ui";
import { supabaseBrowser } from "@/lib/supabase/client";

export function PasswordInput({
  label = "Senha",
  value,
  onChange,
  error,
  autoComplete = "current-password",
  showRules,
  onBlur,
}: {
  label?: string;
  value: string;
  onChange: (v: string) => void;
  error?: string | null;
  autoComplete?: string;
  showRules?: boolean;
  onBlur?: () => void;
}) {
  const [show, setShow] = useState(false);
  return (
    <div>
      <div className="relative">
        <Input
          label={label}
          type={show ? "text" : "password"}
          value={value}
          onChange={(e) => onChange(e.target.value)}
          onBlur={onBlur}
          autoComplete={autoComplete}
          error={error}
          className="pr-12"
          required
        />
        <button
          type="button"
          onClick={() => setShow((s) => !s)}
          className="absolute right-1.5 top-[30px] rounded-lg p-2 text-ink-400 hover:bg-ink-100 hover:text-ink-700"
          aria-label={show ? "Ocultar senha" : "Mostrar senha"}
        >
          {show ? <EyeOff className="size-[18px]" /> : <Eye className="size-[18px]" />}
        </button>
      </div>
      {showRules && (
        <ul className="mt-2.5 grid grid-cols-1 gap-1 sm:grid-cols-2" aria-label="Requisitos da senha">
          {PASSWORD_RULES.map((r) => {
            const ok = r.test(value);
            return (
              <li key={r.id} className={cn("flex items-center gap-1.5 text-[13px]", ok ? "text-emerald-700" : "text-ink-500")}>
                {ok ? <Check className="size-3.5" strokeWidth={3} /> : <Circle className="size-3" />}
                {r.label}
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}

export function CodeInput({ value, onChange, error }: { value: string; onChange: (v: string) => void; error?: string | null }) {
  return (
    <Input
      label="Código de verificação"
      inputMode="numeric"
      autoComplete="one-time-code"
      pattern="[0-9]*"
      maxLength={6}
      value={value}
      onChange={(e) => onChange(e.target.value.replace(/\D/g, "").slice(0, 6))}
      error={error}
      className="h-14 text-center font-mono text-2xl tracking-[.5em]"
      placeholder="••••••"
      autoFocus
    />
  );
}

export async function postJSON<T = Record<string, unknown>>(url: string, body: unknown): Promise<T & { error?: string }> {
  const r = await fetch(url, { method: "POST", headers: { "content-type": "application/json" }, body: JSON.stringify(body) });
  let j: T & { error?: string };
  try {
    j = await r.json();
  } catch {
    j = { error: "Falha de conexão. Tente de novo." } as T & { error?: string };
  }
  if (!r.ok && !j.error) j.error = "Erro inesperado.";
  return j;
}

export async function applySession(session: { access_token: string; refresh_token: string }) {
  const sb = supabaseBrowser();
  const { error } = await sb.auth.setSession(session);
  if (error) throw error;
}
