"use client";

import Link from "next/link";
import { useState } from "react";
import { Bell, CheckCheck, MessageSquarePlus, RotateCcw, Trash2, UserCheck, FileText } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { Button, Card, EmptyState, PageHeader, Select, Sheet, Skeleton, Textarea, Input, cn } from "@/components/ui";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData, must } from "@/lib/use-data";
import { getMembros, notificar } from "@/lib/api";
import { plural, timeAgo } from "@/lib/format";
import type { Notificacao } from "@/lib/types";

const ICON: Record<string, typeof Bell> = { refazer: RotateCcw, acesso: UserCheck, cadastro: UserCheck, relatorio: FileText };

export default function NotificacoesPage() {
  const { userId, isActive } = useAuth();
  const sb = supabaseBrowser();
  const [nova, setNova] = useState(false);
  const { data, loading, reload } = useData(
    async () => must(await sb.from("notificacoes").select("*").eq("destinatario_id", userId!).order("created_at", { ascending: false }).limit(100)) as Notificacao[],
    [userId]
  );
  const naoLidas = (data || []).filter((n) => !n.lida_em);

  async function marcarTodas() {
    await sb.from("notificacoes").update({ lida_em: new Date().toISOString() }).eq("destinatario_id", userId!).is("lida_em", null);
    window.dispatchEvent(new Event("tigres:notif"));
    reload(true);
  }
  async function ler(n: Notificacao) {
    if (n.lida_em) return;
    await sb.from("notificacoes").update({ lida_em: new Date().toISOString() }).eq("id", n.id);
    window.dispatchEvent(new Event("tigres:notif"));
    reload(true);
  }
  async function apagar(n: Notificacao) {
    await sb.from("notificacoes").delete().eq("id", n.id);
    window.dispatchEvent(new Event("tigres:notif"));
    reload(true);
  }

  return (
    <div>
      <PageHeader
        title="Notificações"
        description={naoLidas.length ? plural(naoLidas.length, "não lida", "não lidas") : "Tudo em dia."}
        actions={
          <>
            {naoLidas.length > 0 && (
              <Button variant="secondary" icon={<CheckCheck className="size-4" />} onClick={marcarTodas}>
                Marcar todas como lidas
              </Button>
            )}
            {isActive && (
              <Button icon={<MessageSquarePlus className="size-4" />} onClick={() => setNova(true)}>
                Enviar mensagem
              </Button>
            )}
          </>
        }
      />
      {loading ? (
        <div className="space-y-2">{Array.from({ length: 4 }).map((_, i) => <Skeleton key={i} className="h-20" />)}</div>
      ) : !data?.length ? (
        <EmptyState icon={<Bell className="size-6" />} title="Nenhuma notificação" description="Avisos da diretoria, pedidos para refazer e aprovações aparecem aqui." />
      ) : (
        <Card className="divide-y divide-ink-100">
          {data.map((n) => {
            const Icon = ICON[n.tipo] || Bell;
            const body = (
              <>
                <span className={cn("grid size-10 shrink-0 place-items-center rounded-xl", n.tipo === "refazer" ? "bg-red-50 text-red-600" : "bg-tiger-50 text-tiger-700")}>
                  <Icon className="size-5" />
                </span>
                <div className="min-w-0 flex-1">
                  <div className="flex items-start gap-2">
                    <span className={cn("text-[15px]", n.lida_em ? "font-medium text-ink-700" : "font-semibold text-ink-900")}>{n.titulo}</span>
                    {!n.lida_em && <span className="mt-2 size-2 shrink-0 rounded-full bg-tiger-500" aria-label="Não lida" />}
                  </div>
                  {n.mensagem && <p className="mt-0.5 whitespace-pre-line text-sm text-ink-600">{n.mensagem}</p>}
                  <div className="mt-1 text-xs text-ink-400">{timeAgo(n.created_at)}</div>
                </div>
              </>
            );
            return (
              <div key={n.id} className={cn("group flex items-start gap-3 p-4", !n.lida_em && "bg-tiger-50/40")}>
                {n.link ? (
                  <Link href={n.link} onClick={() => ler(n)} className="flex min-w-0 flex-1 items-start gap-3">
                    {body}
                  </Link>
                ) : (
                  <button onClick={() => ler(n)} className="flex min-w-0 flex-1 items-start gap-3 text-left">
                    {body}
                  </button>
                )}
                <button onClick={() => apagar(n)} className="rounded-lg p-2 text-ink-300 hover:bg-ink-100 hover:text-ink-700" aria-label="Apagar notificação">
                  <Trash2 className="size-4" />
                </button>
              </div>
            );
          })}
        </Card>
      )}
      <NovaMensagem open={nova} onClose={() => setNova(false)} />
    </div>
  );
}

function NovaMensagem({ open, onClose }: { open: boolean; onClose: () => void }) {
  const { userId, profile, classes, isAdmin } = useAuth();
  const { data: membros } = useData(async () => (open ? getMembros() : []), [open]);
  const [para, setPara] = useState("");
  const [titulo, setTitulo] = useState("");
  const [msg, setMsg] = useState("");
  const [saving, setSaving] = useState(false);
  const ativos = (membros || []).filter((m) => m.status === "ativo" && m.id !== userId);

  async function enviar() {
    if (!para || !msg.trim()) return toast.error("Escolha o destinatário e escreva a mensagem.");
    setSaving(true);
    let ids: string[] = [];
    if (para === "todos") ids = ativos.map((m) => m.id);
    else if (para === "admins") ids = ativos.filter((m) => m.is_admin).map((m) => m.id);
    else if (para.startsWith("classe:")) {
      const cid = Number(para.split(":")[1]);
      ids = ativos.filter((m) => (m.classes || []).some((c) => c.class_id === cid)).map((m) => m.id);
    } else ids = [para];
    try {
      await notificar(userId!, ids, { titulo: titulo.trim() || `Mensagem de ${profile?.nome.split(" ")[0]}`, mensagem: msg.trim() });
      toast.success(`Mensagem enviada para ${plural(ids.length, "pessoa", "pessoas")}.`);
      setPara("");
      setTitulo("");
      setMsg("");
      onClose();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setSaving(false);
    }
  }

  return (
    <Sheet
      open={open}
      onClose={onClose}
      title="Enviar mensagem"
      description="Aparece na barra de notificações de quem receber."
      footer={
        <>
          <Button variant="secondary" onClick={onClose}>
            Cancelar
          </Button>
          <Button onClick={enviar} loading={saving}>
            Enviar mensagem
          </Button>
        </>
      }
    >
      <div className="space-y-4">
        <Select label="Para" value={para} onChange={(e) => setPara(e.target.value)} required>
          <option value="">Escolha…</option>
          {isAdmin && <option value="todos">Toda a diretoria</option>}
          <option value="admins">Diretor e associados</option>
          {isAdmin &&
            classes.map((c) => (
              <option key={c.id} value={`classe:${c.id}`}>
                Equipe da classe {c.nome}
              </option>
            ))}
          <optgroup label="Pessoas">
            {ativos.map((m) => (
              <option key={m.id} value={m.id}>
                {m.nome} — {m.cargo}
              </option>
            ))}
          </optgroup>
        </Select>
        <Input label="Assunto (opcional)" value={titulo} onChange={(e) => setTitulo(e.target.value)} />
        <Textarea label="Mensagem" value={msg} onChange={(e) => setMsg(e.target.value)} required />
      </div>
    </Sheet>
  );
}
