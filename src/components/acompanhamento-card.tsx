"use client";

import { useEffect, useState } from "react";
import { Copy, ExternalLink, Link2, MessageCircle, RefreshCw } from "lucide-react";
import { toast } from "sonner";
import { Button, Card, Confirm, Skeleton } from "./ui";
import { mensagemWhatsApp, obterLink, trocarLink, urlAcompanhamento } from "@/lib/acompanhamento";
import { waLink } from "@/lib/format";
import { responsaveisDe, type Desbravador } from "@/lib/types";

const botao =
  "inline-flex h-9 items-center justify-center gap-1.5 rounded-xl px-3 text-sm font-semibold transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-tiger-500 focus-visible:ring-offset-2";

/** Link para os responsáveis acompanharem o caderno e as especialidades, sem login. */
export function AcompanhamentoCard({ d, userId }: { d: Desbravador; userId: string | null }) {
  const [url, setUrl] = useState<string | null>(null);
  const [erro, setErro] = useState<string | null>(null);
  const [trocar, setTrocar] = useState(false);
  const [trocando, setTrocando] = useState(false);
  const resp = responsaveisDe(d).filter((r) => r.telefone && waLink(r.telefone));

  useEffect(() => {
    let vivo = true;
    setUrl(null);
    setErro(null);
    obterLink(d.id, userId)
      .then((t) => vivo && setUrl(urlAcompanhamento(t)))
      .catch((e: Error) => vivo && setErro(e.message));
    return () => {
      vivo = false;
    };
  }, [d.id, userId]);

  async function copiar() {
    if (!url) return;
    try {
      await navigator.clipboard.writeText(url);
      toast.success("Link copiado. Cole no WhatsApp dos responsáveis.");
    } catch {
      toast.error("Não foi possível copiar. Segure o dedo no link para copiar.");
    }
  }

  return (
    <Card className="mb-6 p-5">
      <div className="flex items-start gap-3">
        <span className="grid size-10 shrink-0 place-items-center rounded-xl bg-tiger-50 text-tiger-700">
          <Link2 className="size-5" />
        </span>
        <div className="min-w-0 flex-1">
          <h2 className="font-display text-lg font-semibold uppercase tracking-wide">Acompanhamento dos responsáveis</h2>
          <p className="text-sm text-ink-500">Os responsáveis abrem o link sem senha e veem só o progresso do caderno e das especialidades.</p>
        </div>
      </div>
      {erro ? (
        <p className="mt-4 rounded-xl bg-amber-50 px-3 py-2 text-sm text-amber-800">{erro}</p>
      ) : !url ? (
        <Skeleton className="mt-4 h-9 w-full max-w-md" />
      ) : (
        <>
          <div className="mt-4 flex flex-wrap gap-2">
            {resp.map((r) => (
              <a
                key={r.titulo}
                href={`${waLink(r.telefone)}?text=${encodeURIComponent(mensagemWhatsApp(d.nome, r.nome, url))}`}
                target="_blank"
                rel="noreferrer"
                className={`${botao} bg-emerald-600 text-white hover:bg-emerald-700`}
              >
                <MessageCircle className="size-4" />
                Enviar para {r.nome ? r.nome.split(" ")[0] : r.titulo}
              </a>
            ))}
            <Button size="sm" variant="secondary" icon={<Copy className="size-4" />} onClick={copiar}>
              Copiar link
            </Button>
            <a href={url} target="_blank" rel="noreferrer" className={`${botao} border border-ink-200 bg-white text-ink-800 hover:bg-ink-50`}>
              <ExternalLink className="size-4" />
              Ver como eles veem
            </a>
            <Button size="sm" variant="ghost" icon={<RefreshCw className="size-4" />} onClick={() => setTrocar(true)}>
              Gerar novo link
            </Button>
          </div>
          {!resp.length && <p className="mt-2 text-xs text-ink-500">Cadastre o telefone de um responsável para enviar direto pelo WhatsApp.</p>}
        </>
      )}
      <Confirm
        open={trocar}
        onClose={() => setTrocar(false)}
        title="Gerar um novo link?"
        message="O link enviado antes para de funcionar. Depois, envie o novo link para os responsáveis."
        confirmLabel="Gerar novo link"
        loading={trocando}
        onConfirm={async () => {
          setTrocando(true);
          try {
            const novo = urlAcompanhamento(await trocarLink(d.id, userId));
            setUrl(novo);
            await navigator.clipboard.writeText(novo).catch(() => {});
            toast.success("Novo link gerado e copiado.");
            setTrocar(false);
          } catch (e) {
            toast.error((e as Error).message);
          } finally {
            setTrocando(false);
          }
        }}
      />
    </Card>
  );
}
