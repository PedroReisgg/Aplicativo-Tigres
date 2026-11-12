"use client";

import { useEffect, useState } from "react";
import { Check, Copy, QrCode } from "lucide-react";
import { toast } from "sonner";
import { Button, cn } from "./ui";
import { NOME_TIPO_CHAVE, pixCopiaECola, tipoDaChave } from "@/lib/pix";

async function copiar(texto: string, ok: string) {
  try {
    await navigator.clipboard.writeText(texto);
    toast.success(ok);
    return true;
  } catch {
    toast.error("Não deu para copiar. Toque e segure o texto para copiar.");
    return false;
  }
}

/** Chave Pix com botão de copiar, código copia e cola e QR Code. */
export function PixBox({ chave, nome, cidade, descricao, className }: { chave: string | null; nome: string | null; cidade: string | null; descricao?: string; className?: string }) {
  const codigo = pixCopiaECola({ chave, nome, cidade, descricao });
  const tipo = tipoDaChave(chave);
  const [qr, setQr] = useState<string | null>(null);
  const [verQr, setVerQr] = useState(false);
  const [copiado, setCopiado] = useState<"chave" | "codigo" | null>(null);

  useEffect(() => {
    if (!verQr || !codigo || qr) return;
    import("qrcode").then((m) => m.toDataURL(codigo, { margin: 1, width: 440, errorCorrectionLevel: "M" }).then(setQr)).catch(() => toast.error("Não foi possível gerar o QR Code."));
  }, [verQr, codigo, qr]);
  useEffect(() => setQr(null), [codigo]);

  if (!chave) return null;
  const marcar = (k: "chave" | "codigo") => {
    setCopiado(k);
    setTimeout(() => setCopiado(null), 2000);
  };

  return (
    <div className={cn("min-w-0 rounded-xl border border-emerald-200 bg-emerald-50/60 p-3", className)}>
      {tipo !== "copiaecola" && (
        <div className="flex items-center gap-2">
          <div className="min-w-0 flex-1">
            <div className="text-[11px] font-semibold uppercase tracking-wide text-emerald-800">{NOME_TIPO_CHAVE[tipo]}</div>
            <div className="truncate font-mono text-sm text-ink-900" title={chave}>
              {chave}
            </div>
            {nome && <div className="truncate text-xs text-ink-500">Em nome de {nome}</div>}
          </div>
          <Button size="sm" variant="secondary" icon={copiado === "chave" ? <Check className="size-4 text-emerald-600" /> : <Copy className="size-4" />} onClick={async () => (await copiar(chave, "Chave Pix copiada.")) && marcar("chave")}>
            {copiado === "chave" ? "Copiada" : "Copiar chave"}
          </Button>
        </div>
      )}
      {codigo && (
        <div className={cn("flex flex-wrap gap-2", tipo !== "copiaecola" && "mt-3 border-t border-emerald-200/70 pt-3")}>
          <Button size="sm" className="flex-1 bg-emerald-600 shadow-none hover:bg-emerald-700 active:bg-emerald-800" icon={copiado === "codigo" ? <Check className="size-4" /> : <Copy className="size-4" />} onClick={async () => (await copiar(codigo, "Código Pix copiado. Cole no app do banco.")) && marcar("codigo")}>
            {copiado === "codigo" ? "Copiado" : "Pix copia e cola"}
          </Button>
          <Button size="sm" variant="secondary" icon={<QrCode className="size-4" />} onClick={() => setVerQr((v) => !v)} aria-expanded={verQr}>
            {verQr ? "Esconder QR" : "QR Code"}
          </Button>
        </div>
      )}
      {verQr && (
        <div className="mt-3 grid place-items-center">
          {qr ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={qr} alt="QR Code do Pix" width={220} height={220} className="size-[220px] rounded-lg bg-white p-2" />
          ) : (
            <div className="size-[220px] animate-pulse rounded-lg bg-white" />
          )}
          <p className="mt-2 text-center text-xs text-ink-500">Abra o app do banco, escolha Pix e leia o código. Você escolhe o valor.</p>
        </div>
      )}
    </div>
  );
}
