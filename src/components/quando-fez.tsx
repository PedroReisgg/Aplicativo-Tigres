"use client";

import { Input } from "./ui";
import { hojeLocal } from "@/lib/format";

/** Dia (e hora, se quiser) em que o desbravador fez a especialidade. Pode ser antes do dia em que é registrada. */
export function QuandoFez({
  dia,
  hora,
  onDia,
  onHora,
  titulo = "Dia em que fez",
}: {
  dia: string;
  hora: string;
  onDia: (v: string) => void;
  onHora: (v: string) => void;
  titulo?: string;
}) {
  const erro = !dia ? "Informe o dia." : dia > hojeLocal() ? "Não pode ser depois de hoje." : null;
  return (
    <div>
      <div className="grid grid-cols-[minmax(0,1fr)_116px] gap-3">
        <Input type="date" label={titulo} value={dia} max={hojeLocal()} onChange={(e) => onDia(e.target.value)} error={erro} required />
        <Input type="time" label="Horário" value={hora} onChange={(e) => onHora(e.target.value)} hint="Opcional" />
      </div>
      <p className="mt-1.5 text-xs text-ink-500">Se fez antes de hoje, troque o dia. O app guarda também o dia e a hora em que foi colocada no sistema.</p>
    </div>
  );
}

/** true se o dia é válido para salvar */
export const quandoValido = (dia: string) => !!dia && dia <= hojeLocal();
