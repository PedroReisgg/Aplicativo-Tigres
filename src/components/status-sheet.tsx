"use client";

import { useEffect, useMemo, useState, type ReactNode } from "react";
import { RotateCcw } from "lucide-react";
import { Avatar, Button, Checkbox, SearchInput, Sheet, Textarea, cn } from "./ui";
import { normalize } from "@/lib/format";
import type { Desbravador } from "@/lib/types";

export type Marca = "feito" | "refazer";

/**
 * Folha para marcar quais desbravadores concluíram algo (item do caderno ou especialidade).
 * Administradores também podem devolver para "refazer" com uma mensagem.
 */
export function StatusSheet({
  open,
  onClose,
  title,
  description,
  header,
  desbravadores,
  initial,
  isAdmin,
  onSave,
}: {
  open: boolean;
  onClose: () => void;
  title: string;
  description?: ReactNode;
  header?: ReactNode;
  desbravadores: Desbravador[];
  initial: Map<string, Marca>;
  isAdmin: boolean;
  onSave: (estado: Map<string, Marca | null>, mensagem: string) => Promise<void>;
}) {
  const [estado, setEstado] = useState<Map<string, Marca | null>>(new Map());
  const [q, setQ] = useState("");
  const [msg, setMsg] = useState("");
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (open) {
      setEstado(new Map(initial));
      setMsg("");
      setQ("");
    }
  }, [open, initial]);

  const list = useMemo(() => desbravadores.filter((d) => normalize(d.nome).includes(normalize(q))), [desbravadores, q]);
  const get = (id: string) => estado.get(id) ?? null;
  const set = (id: string, v: Marca | null) => setEstado((m) => new Map(m).set(id, v));
  const feitos = [...estado.values()].filter((v) => v === "feito").length;
  const novosRefazer = [...estado.entries()].filter(([id, v]) => v === "refazer" && initial.get(id) !== "refazer").length;
  const all = list.length > 0 && list.every((d) => get(d.id) === "feito");

  async function salvar() {
    setSaving(true);
    try {
      await onSave(estado, msg.trim());
      onClose();
    } finally {
      setSaving(false);
    }
  }

  return (
    <Sheet
      open={open}
      onClose={onClose}
      title={title}
      description={description}
      footer={
        <>
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
          <Button onClick={salvar} loading={saving} disabled={novosRefazer > 0 && !msg.trim()}>
            Salvar
          </Button>
        </>
      }
    >
      {header}
      <div className="space-y-3">
        {desbravadores.length > 6 && <SearchInput value={q} onChange={setQ} placeholder="Buscar desbravador…" />}
        <div className="flex items-center justify-between px-1 text-sm">
          <span className="text-ink-500">
            {feitos} de {desbravadores.length} {desbravadores.length === 1 ? "concluído" : "concluídos"}
          </span>
          {list.length > 0 && (
            <button className="font-semibold text-tiger-700 hover:underline" onClick={() => list.forEach((d) => set(d.id, all ? null : "feito"))}>
              {all ? "Desmarcar todos" : "Marcar todos"}
            </button>
          )}
        </div>
        <ul className="divide-y divide-ink-100 overflow-hidden rounded-2xl border border-ink-200">
          {list.map((d) => {
            const v = get(d.id);
            return (
              <li key={d.id} className={cn("flex items-center gap-3 px-3 py-2.5", v === "feito" && "bg-tiger-50/60", v === "refazer" && "bg-red-50")}>
                <Checkbox checked={v === "feito"} onChange={(c) => set(d.id, c ? "feito" : null)} />
                <Avatar nome={d.nome} color={d.classe_cor} size={32} />
                <button className="min-w-0 flex-1 text-left" onClick={() => set(d.id, v === "feito" ? null : "feito")}>
                  <div className="truncate text-sm font-medium text-ink-900">{d.nome}</div>
                  <div className="text-xs text-ink-500">{v === "refazer" ? "Devolvido para refazer" : d.unidade || (d.idade != null ? `${d.idade} anos` : "")}</div>
                </button>
                {isAdmin && (v === "feito" || v === "refazer" || initial.get(d.id)) && (
                  <button
                    onClick={() => set(d.id, v === "refazer" ? "feito" : "refazer")}
                    className={cn(
                      "inline-flex items-center gap-1 rounded-full px-2.5 py-1 text-xs font-semibold",
                      v === "refazer" ? "bg-red-600 text-white" : "bg-ink-100 text-ink-600 hover:bg-red-100 hover:text-red-700"
                    )}
                    aria-pressed={v === "refazer"}
                  >
                    <RotateCcw className="size-3" /> Refazer
                  </button>
                )}
              </li>
            );
          })}
          {!list.length && <li className="px-3 py-6 text-center text-sm text-ink-500">Nenhum desbravador nesta classe ainda.</li>}
        </ul>
        {isAdmin && (
          <Textarea
            label={novosRefazer ? "Mensagem para o instrutor (obrigatória)" : "Mensagem para o instrutor (opcional)"}
            placeholder="Ex.: O desbravador não fez esta página. Por favor, refazer."
            value={msg}
            onChange={(e) => setMsg(e.target.value)}
            hint="A mensagem aparece nas notificações da equipe da classe."
          />
        )}
      </div>
    </Sheet>
  );
}
