"use client";

import { useState } from "react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Avatar, Badge, Button, Card, Input, PageHeader } from "@/components/ui";
import { funcoesDe } from "@/lib/types";
import { PasswordInput } from "@/components/auth-forms";
import { supabaseBrowser } from "@/lib/supabase/client";
import { brToIso, isoToBr, isStrongPassword, isValidPhone, maskDate, maskPhone } from "@/lib/format";

export default function PerfilPage() {
  const { profile, refresh, classes } = useAuth();
  const sb = supabaseBrowser();
  const [nome, setNome] = useState(profile?.nome || "");
  const [tel, setTel] = useState(profile?.telefone || "");
  const [nasc, setNasc] = useState(isoToBr(profile?.data_nascimento));
  const [senha, setSenha] = useState("");
  const [senha2, setSenha2] = useState("");
  const [saving, setSaving] = useState<string | null>(null);

  async function salvar() {
    if (nome.trim().split(/\s+/).length < 2) return toast.error("Informe nome e sobrenome.");
    if (!isValidPhone(tel)) return toast.error("Telefone inválido.");
    const iso = brToIso(nasc);
    if (!iso) return toast.error("Data de nascimento inválida.");
    setSaving("dados");
    const { error } = await sb.from("profiles").update({ nome: nome.trim(), telefone: tel, data_nascimento: iso }).eq("id", profile!.id);
    setSaving(null);
    if (error) return toast.error(error.message);
    toast.success("Perfil atualizado.");
    refresh();
  }

  async function trocarSenha() {
    if (!isStrongPassword(senha)) return toast.error("A senha não atende aos requisitos.");
    if (senha !== senha2) return toast.error("As senhas não conferem.");
    setSaving("senha");
    const { error } = await sb.auth.updateUser({ password: senha });
    setSaving(null);
    if (error) return toast.error(error.message);
    setSenha("");
    setSenha2("");
    toast.success("Senha alterada.");
  }

  return (
    <div className="max-w-2xl">
      <PageHeader title="Meu perfil" />
      <Card className="mb-6 flex items-center gap-4 p-5">
        <Avatar nome={profile?.nome} color="#F26B1D" size={60} />
        <div className="min-w-0">
          <div className="truncate text-lg font-semibold">{profile?.nome}</div>
          <div className="truncate text-sm text-ink-500">{profile?.email}</div>
          <div className="mt-1.5 flex flex-wrap gap-1.5">
            {profile?.status === "ativo" ? (
              funcoesDe(profile).map((f) => (
                <Badge key={f} tone="green">
                  {f}
                </Badge>
              ))
            ) : (
              <Badge tone="amber">{profile?.status === "inativo" ? "Acesso desativado" : "Lista de espera"}</Badge>
            )}
            {profile?.is_admin && <Badge tone="tiger">Administrador</Badge>}
            {(profile?.classes || []).map((c) => (
              <Badge key={c.class_id}>{classes.find((x) => x.id === c.class_id)?.nome}</Badge>
            ))}
          </div>
        </div>
      </Card>

      <Card className="mb-6 space-y-4 p-5">
        <h2 className="font-display text-lg font-semibold uppercase tracking-wide">Dados pessoais</h2>
        <Input label="Nome completo" value={nome} onChange={(e) => setNome(e.target.value)} />
        <div className="grid gap-4 sm:grid-cols-2">
          <Input label="Telefone" inputMode="tel" value={tel} onChange={(e) => setTel(maskPhone(e.target.value))} />
          <Input
            label="Data de nascimento"
            inputMode="numeric"
            placeholder="dd/mm/aaaa"
            value={nasc}
            onChange={(e) => setNasc(maskDate(e.target.value))}
            hint={profile?.idade != null ? `${profile.idade} anos` : undefined}
          />
        </div>
        <div className="flex justify-end">
          <Button onClick={salvar} loading={saving === "dados"}>
            Salvar dados
          </Button>
        </div>
      </Card>

      <Card className="space-y-4 p-5">
        <h2 className="font-display text-lg font-semibold uppercase tracking-wide">Trocar senha</h2>
        <PasswordInput label="Nova senha" value={senha} onChange={setSenha} autoComplete="new-password" showRules />
        <PasswordInput label="Confirmar nova senha" value={senha2} onChange={setSenha2} autoComplete="new-password" />
        <div className="flex justify-end">
          <Button variant="dark" onClick={trocarSenha} loading={saving === "senha"} disabled={!senha}>
            Trocar senha
          </Button>
        </div>
      </Card>
    </div>
  );
}
