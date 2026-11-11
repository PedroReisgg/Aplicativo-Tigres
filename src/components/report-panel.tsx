"use client";

import { useState } from "react";
import { FileSpreadsheet, FileText, Mail, Send, Share2 } from "lucide-react";
import { toast } from "sonner";
import { Button, Card, Checkbox, Input, Sheet, Textarea, cn } from "./ui";
import { blobToBase64, downloadBlob, fileName, shareBlob } from "@/lib/reports";
import { supabaseBrowser } from "@/lib/supabase/client";

export function ReportPanel({
  titulo,
  base,
  excel,
  pdf,
  link,
  descricao,
}: {
  titulo: string;
  base: string;
  excel: () => Promise<Blob>;
  pdf: () => Promise<Blob>;
  link?: string;
  descricao?: string;
}) {
  const [busy, setBusy] = useState<string | null>(null);
  const [open, setOpen] = useState(false);
  const [destino, setDestino] = useState<"diretoria" | "outro">("diretoria");
  const [para, setPara] = useState("");
  const [msg, setMsg] = useState("");
  const [fmt, setFmt] = useState({ xlsx: true, pdf: true });

  async function baixar(tipo: "xlsx" | "pdf") {
    setBusy(tipo);
    try {
      const blob = tipo === "xlsx" ? await excel() : await pdf();
      await downloadBlob(blob, fileName(base, tipo));
    } catch (e) {
      toast.error("Erro ao gerar: " + (e as Error).message);
    } finally {
      setBusy(null);
    }
  }

  async function compartilhar() {
    setBusy("share");
    try {
      const blob = await pdf();
      const ok = await shareBlob(blob, fileName(base, "pdf"), titulo);
      if (!ok) {
        await downloadBlob(blob, fileName(base, "pdf"));
        toast.info("Seu navegador não compartilha arquivos; o PDF foi baixado.");
      }
    } catch (e) {
      if ((e as Error).name !== "AbortError") toast.error("Não foi possível compartilhar.");
    } finally {
      setBusy(null);
    }
  }

  async function enviar() {
    if (!fmt.xlsx && !fmt.pdf) return toast.error("Escolha ao menos um formato.");
    setBusy("send");
    try {
      const arquivos: { nome: string; base64: string }[] = [];
      if (fmt.xlsx) arquivos.push({ nome: fileName(base, "xlsx"), base64: await blobToBase64(await excel()) });
      if (fmt.pdf) arquivos.push({ nome: fileName(base, "pdf"), base64: await blobToBase64(await pdf()) });
      const {
        data: { session },
      } = await supabaseBrowser().auth.getSession();
      const r = await fetch("/api/relatorio/enviar", {
        method: "POST",
        headers: { "content-type": "application/json", authorization: `Bearer ${session?.access_token || ""}` },
        body: JSON.stringify({ destino, para, mensagem: msg, titulo, arquivos, link }),
      });
      const j = await r.json().catch(() => ({}));
      if (!r.ok) throw new Error(j.error || "Falha no envio.");
      toast.success(destino === "diretoria" ? "Relatório enviado para a diretoria!" : "Relatório enviado!");
      setOpen(false);
      setMsg("");
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setBusy(null);
    }
  }

  return (
    <Card className="p-5">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h3 className="font-display text-lg font-semibold uppercase tracking-wide">{titulo}</h3>
          <p className="text-sm text-ink-500">{descricao || "Planilha com caderno, especialidades e cadastro, pronta para imprimir ou enviar."}</p>
        </div>
        <div className="grid grid-cols-2 gap-2 sm:flex">
          <Button variant="secondary" icon={<FileSpreadsheet className="size-4 text-emerald-600" />} loading={busy === "xlsx"} onClick={() => baixar("xlsx")}>
            Excel
          </Button>
          <Button variant="secondary" icon={<FileText className="size-4 text-red-600" />} loading={busy === "pdf"} onClick={() => baixar("pdf")}>
            PDF
          </Button>
          <Button variant="secondary" icon={<Share2 className="size-4" />} loading={busy === "share"} onClick={compartilhar} className="sm:hidden">
            Compartilhar
          </Button>
          <Button icon={<Send className="size-4" />} onClick={() => setOpen(true)}>
            Enviar
          </Button>
        </div>
      </div>

      <Sheet
        open={open}
        onClose={() => setOpen(false)}
        title="Enviar relatório"
        description={titulo}
        footer={
          <>
            <Button variant="secondary" onClick={() => setOpen(false)}>
              Cancelar
            </Button>
            <Button icon={<Mail className="size-4" />} loading={busy === "send"} onClick={enviar} disabled={destino === "outro" && !para.trim()}>
              Enviar por e-mail
            </Button>
          </>
        }
      >
        <div className="space-y-5">
          <fieldset className="space-y-2">
            <legend className="mb-1 text-sm font-medium text-ink-800">Para quem?</legend>
            {(
              [
                ["diretoria", "Diretor e diretores associados", "Vai para o e-mail de todos os administradores e aparece nas notificações."],
                ["outro", "Outra pessoa", "Digite um ou mais e-mails (separados por vírgula)."],
              ] as const
            ).map(([v, l, d]) => (
              <label key={v} className={cn("flex cursor-pointer gap-3 rounded-2xl border p-3.5", destino === v ? "border-tiger-400 bg-tiger-50" : "border-ink-200")}>
                <input type="radio" name="destino" className="mt-1 accent-tiger-600" checked={destino === v} onChange={() => setDestino(v)} />
                <span>
                  <span className="block text-sm font-semibold">{l}</span>
                  <span className="block text-[13px] text-ink-500">{d}</span>
                </span>
              </label>
            ))}
          </fieldset>
          {destino === "outro" && <Input label="E-mail(s)" type="email" inputMode="email" value={para} onChange={(e) => setPara(e.target.value)} placeholder="nome@exemplo.com" />}
          <div>
            <div className="mb-2 text-sm font-medium text-ink-800">Formatos</div>
            <div className="flex gap-5">
              <Checkbox checked={fmt.xlsx} onChange={(v) => setFmt((f) => ({ ...f, xlsx: v }))} label="Excel (.xlsx)" />
              <Checkbox checked={fmt.pdf} onChange={(v) => setFmt((f) => ({ ...f, pdf: v }))} label="PDF" />
            </div>
          </div>
          <Textarea label="Mensagem (opcional)" value={msg} onChange={(e) => setMsg(e.target.value)} placeholder="Segue o relatório atualizado da classe." />
        </div>
      </Sheet>
    </Card>
  );
}
