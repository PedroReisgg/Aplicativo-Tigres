"use client";

import { useEffect, useMemo, useState } from "react";
import { Award, Phone } from "lucide-react";
import { toast } from "sonner";
import { Avatar, Button, Checkbox, Input, SearchInput, Select, Sheet, Textarea, cn } from "./ui";
import { useAuth } from "./auth-provider";
import { supabaseBrowser } from "@/lib/supabase/client";
import { brToIso, isoToBr, isValidCPF, isValidEmail, isValidPhone, maskCPF, maskDate, maskPhone, normalize, onlyDigits, waLink } from "@/lib/format";
import type { Desbravador, Especialidade } from "@/lib/types";

export function EspIcon({ esp, size = 56, className }: { esp: Pick<Especialidade, "imagem" | "nome">; size?: number; className?: string }) {
  const [err, setErr] = useState(false);
  if (!esp.imagem || err)
    return (
      <span className={cn("grid shrink-0 place-items-center rounded-full bg-tiger-50 text-tiger-600", className)} style={{ width: size, height: size }}>
        <Award style={{ width: size * 0.5, height: size * 0.5 }} />
      </span>
    );
  return (
    // eslint-disable-next-line @next/next/no-img-element
    <img
      src={esp.imagem}
      alt=""
      width={size}
      height={size}
      loading="lazy"
      onError={() => setErr(true)}
      className={cn("shrink-0 object-contain drop-shadow-sm", className)}
      style={{ width: size, height: size }}
    />
  );
}

export function NivelBadge({ nivel }: { nivel: number | null }) {
  if (!nivel) return null;
  return (
    <span className="inline-flex items-center gap-0.5 text-[11px] font-semibold text-ink-500" title={`Nível ${nivel}`}>
      {Array.from({ length: Math.min(nivel, 3) }).map((_, i) => (
        <span key={i} className="size-1.5 rounded-full bg-tiger-500" />
      ))}
      <span className="ml-1">Nível {nivel}</span>
    </span>
  );
}

export function PhoneLink({ phone, label }: { phone?: string | null; label?: string }) {
  if (!phone) return <span className="text-ink-400">—</span>;
  const wa = waLink(phone);
  return (
    <span className="inline-flex flex-wrap items-center gap-2">
      <a href={`tel:${onlyDigits(phone)}`} className="inline-flex items-center gap-1 font-medium text-ink-800 hover:text-tiger-700">
        <Phone className="size-3.5" /> {label ? `${label}: ` : ""}
        {phone}
      </a>
      {wa && (
        <a href={wa} target="_blank" rel="noreferrer" className="rounded-full bg-emerald-50 px-2 py-0.5 text-xs font-semibold text-emerald-700 hover:bg-emerald-100">
          WhatsApp
        </a>
      )}
    </span>
  );
}

type DForm = {
  nome: string;
  data_nascimento: string;
  sexo: string;
  cpf: string;
  nome_pai: string;
  nome_mae: string;
  telefone_responsavel: string;
  telefone: string;
  email: string;
  endereco: string;
  unidade: string;
  class_id: string;
  observacoes: string;
};

function toForm(d?: Partial<Desbravador> | null, classId?: number | null): DForm {
  return {
    nome: d?.nome || "",
    data_nascimento: isoToBr(d?.data_nascimento),
    sexo: d?.sexo || "",
    cpf: d?.cpf || "",
    nome_pai: d?.nome_pai || "",
    nome_mae: d?.nome_mae || "",
    telefone_responsavel: d?.telefone_responsavel || "",
    telefone: d?.telefone || "",
    email: d?.email || "",
    endereco: d?.endereco || "",
    unidade: d?.unidade || "",
    class_id: String(d?.class_id ?? classId ?? ""),
    observacoes: d?.observacoes || "",
  };
}

function validar(f: DForm) {
  const e: Partial<Record<keyof DForm, string>> = {};
  if (f.nome.trim().length < 3) e.nome = "Informe o nome do desbravador.";
  if (!brToIso(f.data_nascimento)) e.data_nascimento = "Data no formato dd/mm/aaaa.";
  if (!f.nome_pai.trim() && !f.nome_mae.trim()) e.nome_mae = "Informe o nome da mãe ou do pai.";
  if (!isValidPhone(f.telefone_responsavel)) e.telefone_responsavel = "Telefone com DDD, ex.: (11) 98765-4321.";
  if (f.telefone && !isValidPhone(f.telefone)) e.telefone = "Telefone inválido.";
  if (f.cpf && !isValidCPF(f.cpf)) e.cpf = "CPF inválido.";
  if (f.email && !isValidEmail(f.email)) e.email = "E-mail inválido.";
  if (!f.class_id) e.class_id = "Escolha a classe.";
  return e;
}

export function DesbravadorSheet({
  open,
  onClose,
  desbravador,
  classId,
  onSaved,
}: {
  open: boolean;
  onClose: () => void;
  desbravador?: Desbravador | null;
  classId?: number | null;
  onSaved: (d: Desbravador) => void;
}) {
  const { classes, isAdmin, staffClassIds, userId } = useAuth();
  const [f, setF] = useState<DForm>(toForm(desbravador, classId));
  const [touched, setTouched] = useState<Record<string, boolean>>({});
  const [saving, setSaving] = useState(false);
  useEffect(() => {
    if (open) {
      setF(toForm(desbravador, classId));
      setTouched({});
    }
  }, [open, desbravador, classId]);
  const errors = validar(f);
  const err = (k: keyof DForm) => (touched[k] ? errors[k] : undefined);
  const set = (k: keyof DForm, mask?: (v: string) => string) => ({
    value: f[k],
    onChange: (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) =>
      setF((s) => ({ ...s, [k]: mask ? mask(e.target.value) : e.target.value })),
    onBlur: () => setTouched((t) => ({ ...t, [k]: true })),
    error: err(k),
  });
  const opcoes = classes.filter((c) => isAdmin || staffClassIds.includes(c.id));

  async function salvar() {
    setTouched(Object.fromEntries(Object.keys(f).map((k) => [k, true])));
    if (Object.keys(errors).length) {
      toast.error("Confira os campos destacados.");
      return;
    }
    setSaving(true);
    const payload = {
      nome: f.nome.trim(),
      data_nascimento: brToIso(f.data_nascimento),
      sexo: f.sexo || null,
      cpf: f.cpf || null,
      nome_pai: f.nome_pai.trim() || null,
      nome_mae: f.nome_mae.trim() || null,
      telefone_responsavel: f.telefone_responsavel,
      telefone: f.telefone || null,
      email: f.email.trim() || null,
      endereco: f.endereco.trim() || null,
      unidade: f.unidade.trim() || null,
      class_id: Number(f.class_id),
      observacoes: f.observacoes.trim() || null,
    };
    const sb = supabaseBrowser();
    const r = desbravador
      ? await sb.from("desbravadores").update(payload).eq("id", desbravador.id).select("id").single()
      : await sb.from("desbravadores").insert({ ...payload, created_by: userId }).select("id").single();
    if (r.error) {
      setSaving(false);
      toast.error("Não foi possível salvar: " + r.error.message);
      return;
    }
    const { data } = await sb.from("desbravadores_view").select("*").eq("id", r.data.id).single();
    setSaving(false);
    toast.success(desbravador ? "Dados atualizados." : "Desbravador cadastrado!");
    onSaved(data as Desbravador);
    onClose();
  }

  return (
    <Sheet
      open={open}
      onClose={onClose}
      title={desbravador ? "Editar desbravador" : "Novo desbravador"}
      description="Campos com * são obrigatórios."
      wide
      footer={
        <>
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
          <Button onClick={salvar} loading={saving}>
            {desbravador ? "Salvar alterações" : "Cadastrar desbravador"}
          </Button>
        </>
      }
    >
      <div className="grid gap-4 sm:grid-cols-2">
        <div className="sm:col-span-2">
          <Input label="Nome completo" required autoComplete="off" {...set("nome")} />
        </div>
        <Input label="Data de nascimento" required inputMode="numeric" placeholder="dd/mm/aaaa" {...set("data_nascimento", maskDate)} />
        <Select label="Sexo" {...set("sexo")}>
          <option value="">Não informado</option>
          <option value="M">Masculino</option>
          <option value="F">Feminino</option>
        </Select>
        <Select label="Classe" required {...set("class_id")}>
          <option value="">Escolha…</option>
          {opcoes.map((c) => (
            <option key={c.id} value={c.id}>
              {c.nome} ({c.idade_minima} anos)
            </option>
          ))}
        </Select>
        <Input label="Unidade" placeholder="Ex.: Leões" {...set("unidade")} />
        <Input label="CPF" inputMode="numeric" placeholder="000.000.000-00" {...set("cpf", maskCPF)} />
        <Input label="Telefone do desbravador" inputMode="tel" placeholder="(11) 98765-4321" {...set("telefone", maskPhone)} />

        <div className="mt-2 border-t border-ink-100 pt-4 text-xs font-semibold uppercase tracking-[.12em] text-tiger-700 sm:col-span-2">Pais e responsáveis</div>
        <Input label="Nome da mãe" {...set("nome_mae")} />
        <Input label="Nome do pai" {...set("nome_pai")} />
        <Input label="Telefone dos pais/responsável" required inputMode="tel" placeholder="(11) 98765-4321" {...set("telefone_responsavel", maskPhone)} />
        <Input label="E-mail dos pais" type="email" inputMode="email" {...set("email")} />
        <div className="sm:col-span-2">
          <Input label="Endereço" {...set("endereco")} />
        </div>
        <div className="sm:col-span-2">
          <Textarea label="Observações" placeholder="Alergias, remédios, cuidados…" {...set("observacoes")} />
        </div>
      </div>
    </Sheet>
  );
}

/** Lista de desbravadores com caixas de seleção. */
export function PickDesbravadores({
  desbravadores,
  selected,
  onToggle,
  refazer,
}: {
  desbravadores: Desbravador[];
  selected: Set<string>;
  onToggle: (id: string, v: boolean) => void;
  refazer?: Set<string>;
}) {
  const [q, setQ] = useState("");
  const list = useMemo(() => desbravadores.filter((d) => normalize(d.nome).includes(normalize(q))), [desbravadores, q]);
  const all = list.length > 0 && list.every((d) => selected.has(d.id));
  return (
    <div className="space-y-3">
      {desbravadores.length > 6 && <SearchInput value={q} onChange={setQ} placeholder="Buscar desbravador…" />}
      <div className="flex items-center justify-between px-1 text-sm">
        <span className="text-ink-500">
          {selected.size} de {desbravadores.length} selecionado(s)
        </span>
        <button className="font-semibold text-tiger-700 hover:underline" onClick={() => list.forEach((d) => onToggle(d.id, !all))}>
          {all ? "Desmarcar todos" : "Marcar todos"}
        </button>
      </div>
      <ul className="divide-y divide-ink-100 overflow-hidden rounded-2xl border border-ink-200">
        {list.map((d) => (
          <li key={d.id} className={cn("flex items-center gap-3 px-3 py-2.5", selected.has(d.id) && "bg-tiger-50/60")}>
            <Checkbox checked={selected.has(d.id)} onChange={(v) => onToggle(d.id, v)} />
            <Avatar nome={d.nome} color={d.classe_cor} size={32} />
            <button className="min-w-0 flex-1 text-left" onClick={() => onToggle(d.id, !selected.has(d.id))}>
              <div className="truncate text-sm font-medium text-ink-900">{d.nome}</div>
              <div className="text-xs text-ink-500">
                {d.idade != null ? `${d.idade} anos` : ""}
                {d.unidade ? ` · ${d.unidade}` : ""}
              </div>
            </button>
            {refazer?.has(d.id) && <span className="rounded-full bg-red-100 px-2 py-0.5 text-[11px] font-semibold text-red-700">Refazer</span>}
          </li>
        ))}
        {!list.length && <li className="px-3 py-6 text-center text-sm text-ink-500">Nenhum desbravador encontrado.</li>}
      </ul>
    </div>
  );
}
