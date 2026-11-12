"use client";

import { CARGOS, DESCRICAO_CARGO } from "@/lib/types";
import { Checkbox, cn } from "./ui";

/** Escolha de uma ou mais funções no clube (ex.: Diretor e Instrutor). */
export function FuncoesPicker({
  value,
  onChange,
  label = "Funções no clube",
  hint = "Marque todas as funções que a pessoa tem. Elas se somam.",
  error,
  travadas = [],
  compacto,
}: {
  value: string[];
  onChange: (v: string[]) => void;
  label?: string;
  hint?: string;
  error?: string;
  /** Funções que não podem ser desmarcadas (ex.: o próprio diretor). */
  travadas?: string[];
  compacto?: boolean;
}) {
  const toggle = (c: string, on: boolean) => onChange(CARGOS.filter((x) => (x === c ? on : value.includes(x))));
  return (
    <fieldset>
      <legend className="mb-1 text-sm font-medium text-ink-800">
        {label} <span className="text-tiger-600">*</span>
      </legend>
      {hint && <p className="mb-2 text-xs text-ink-500">{hint}</p>}
      <div className="grid gap-2 sm:grid-cols-2">
        {CARGOS.map((c) => {
          const on = value.includes(c);
          const trava = travadas.includes(c) && on;
          return (
            <div
              key={c}
              className={cn("rounded-xl border px-3 py-2.5 transition-colors", on ? "border-tiger-300 bg-tiger-50/70" : "border-ink-200 bg-white", error && !value.length && "border-red-300")}
            >
              <Checkbox checked={on} disabled={trava} onChange={(v) => toggle(c, v)} label={<span className="font-semibold">{c}</span>} />
              {!compacto && <p className="ml-[34px] mt-0.5 text-xs leading-snug text-ink-500">{DESCRICAO_CARGO[c]}</p>}
            </div>
          );
        })}
      </div>
      {error && (
        <p className="mt-1.5 text-sm text-red-600" role="alert">
          {error}
        </p>
      )}
    </fieldset>
  );
}
