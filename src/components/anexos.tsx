"use client";

import { useEffect, useRef, useState } from "react";
import { createPortal } from "react-dom";
import { Download, FileSpreadsheet, FileText, Film, Paperclip, X } from "lucide-react";
import { toast } from "sonner";
import { ANEXO_ACCEPT, ANEXO_MAX_MB, baixarAnexo, linksDosAnexos, problemaNoArquivo, tamanhoTexto, tipoAnexo } from "@/lib/anexos";
import { isoToBr } from "@/lib/format";
import type { Anexo } from "@/lib/types";
import { cn } from "./ui";

function IconeTipo({ tipo, className }: { tipo: ReturnType<typeof tipoAnexo>; className?: string }) {
  if (tipo === "video") return <Film className={className} />;
  if (tipo === "planilha") return <FileSpreadsheet className={className} />;
  return <FileText className={className} />;
}

/** Escolha dos comprovantes (imagem, vídeo, PDF ou Excel). */
export function AnexosPicker({
  files,
  onChange,
  obrigatorio,
  erro,
  titulo = "Comprovante",
}: {
  files: File[];
  onChange: (f: File[]) => void;
  obrigatorio?: boolean;
  erro?: string | null;
  titulo?: string;
}) {
  const ref = useRef<HTMLInputElement>(null);
  const [previews, setPreviews] = useState<Map<File, string>>(new Map());
  useEffect(() => {
    const m = new Map<File, string>();
    files.forEach((f) => tipoAnexo(f) === "imagem" && m.set(f, URL.createObjectURL(f)));
    setPreviews(m);
    return () => m.forEach((u) => URL.revokeObjectURL(u));
  }, [files]);

  function escolher(lista: FileList | null) {
    if (!lista?.length) return;
    const ok: File[] = [];
    for (const f of Array.from(lista)) {
      const p = problemaNoArquivo(f);
      if (p) toast.error(p);
      else ok.push(f);
    }
    onChange([...files, ...ok]);
    if (ref.current) ref.current.value = "";
  }

  return (
    <div>
      <div className="mb-1 text-sm font-medium text-ink-800">
        {titulo} {obrigatorio ? <span className="text-tiger-600">*</span> : <span className="font-normal text-ink-400">(opcional)</span>}
      </div>
      <p className="mb-2 text-xs text-ink-500">Foto, vídeo, PDF ou planilha do Excel, até {ANEXO_MAX_MB} MB cada. Fica guardado como prova da especialidade.</p>
      {files.length > 0 && (
        <ul className="mb-2 space-y-1.5">
          {files.map((f, i) => (
            <li key={i} className="flex items-center gap-3 rounded-xl border border-ink-200 bg-white p-2">
              {previews.get(f) ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={previews.get(f)} alt="" className="size-10 shrink-0 rounded-lg object-cover" />
              ) : (
                <span className="grid size-10 shrink-0 place-items-center rounded-lg bg-ink-100 text-ink-500">
                  <IconeTipo tipo={tipoAnexo(f)} className="size-5" />
                </span>
              )}
              <div className="min-w-0 flex-1">
                <div className="truncate text-sm font-medium">{f.name}</div>
                <div className="text-xs text-ink-400">{tamanhoTexto(f.size)}</div>
              </div>
              <button
                type="button"
                onClick={() => onChange(files.filter((_, j) => j !== i))}
                className="rounded-lg p-1.5 text-ink-400 hover:bg-red-50 hover:text-red-600"
                aria-label={`Tirar ${f.name}`}
              >
                <X className="size-4" />
              </button>
            </li>
          ))}
        </ul>
      )}
      <button
        type="button"
        onClick={() => ref.current?.click()}
        className={cn(
          "flex w-full items-center justify-center gap-2 rounded-xl border-2 border-dashed px-3 py-3 text-sm font-semibold transition-colors",
          erro ? "border-red-300 bg-red-50 text-red-700" : "border-ink-200 text-ink-600 hover:border-tiger-300 hover:bg-tiger-50 hover:text-tiger-700",
        )}
      >
        <Paperclip className="size-4" /> {files.length ? "Anexar mais arquivos" : "Anexar comprovante"}
      </button>
      <input ref={ref} type="file" multiple accept={ANEXO_ACCEPT} className="sr-only" tabIndex={-1} onChange={(e) => escolher(e.target.files)} />
      {erro && (
        <p className="mt-1.5 text-sm text-red-600" role="alert">
          {erro}
        </p>
      )}
    </div>
  );
}

/** Mostra os comprovantes guardados: fotos e vídeos abrem na hora; PDF e Excel baixam. */
export function AnexosLista({ anexos, nomes, compacto }: { anexos: Anexo[]; nomes?: Map<string, string>; compacto?: boolean }) {
  const [links, setLinks] = useState<Map<string, string>>(new Map());
  const [aberto, setAberto] = useState<Anexo | null>(null);
  const chave = anexos.map((a) => a.caminho).join("|");
  useEffect(() => {
    if (!aberto) return;
    const k = (e: KeyboardEvent) => e.key === "Escape" && (e.stopPropagation(), setAberto(null));
    document.addEventListener("keydown", k, true);
    return () => document.removeEventListener("keydown", k, true);
  }, [aberto]);
  useEffect(() => {
    let vivo = true;
    linksDosAnexos(anexos.map((a) => a.caminho)).then((m) => vivo && setLinks(m));
    return () => {
      vivo = false;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [chave]);

  if (!anexos.length) return <p className="text-sm text-ink-400">Nenhum comprovante anexado.</p>;

  async function baixar(a: Anexo) {
    try {
      await baixarAnexo(a);
    } catch (e) {
      toast.error((e as Error).message);
    }
  }

  return (
    <>
      <ul className={cn("grid gap-2", compacto ? "grid-cols-3 sm:grid-cols-4" : "grid-cols-2 sm:grid-cols-3")}>
        {anexos.map((a) => {
          const t = tipoAnexo(a);
          const url = links.get(a.caminho);
          return (
            <li key={a.id} className="min-w-0">
              <button
                type="button"
                onClick={() => (t === "imagem" || t === "video" ? setAberto(a) : baixar(a))}
                className="group block w-full overflow-hidden rounded-xl border border-ink-200 bg-white text-left hover:border-tiger-300"
                title={a.nome_arquivo}
              >
                <span className="relative grid aspect-[4/3] place-items-center bg-ink-50 text-ink-400">
                  {t === "imagem" && url ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img src={url} alt={a.nome_arquivo} className="absolute inset-0 size-full object-cover" loading="lazy" />
                  ) : (
                    <IconeTipo tipo={t} className="size-8" />
                  )}
                  {t !== "imagem" && t !== "video" && (
                    <span className="absolute bottom-1.5 right-1.5 rounded-full bg-white/90 p-1 text-ink-600 shadow-sm">
                      <Download className="size-3.5" />
                    </span>
                  )}
                </span>
                {!compacto && (
                  <span className="block px-2 py-1.5">
                    <span className="block truncate text-xs font-medium text-ink-800">{a.nome_arquivo}</span>
                    <span className="block truncate text-[11px] text-ink-400">
                      {isoToBr(a.created_at.slice(0, 10))}
                      {a.enviado_por && nomes?.get(a.enviado_por) ? ` · ${nomes.get(a.enviado_por)!.split(" ")[0]}` : ""}
                    </span>
                  </span>
                )}
              </button>
            </li>
          );
        })}
      </ul>
      {aberto &&
        createPortal(
          <div className="fixed inset-0 z-[80] grid place-items-center bg-ink-900/85 p-4" role="dialog" aria-modal="true" aria-label={aberto.nome_arquivo} onClick={() => setAberto(null)}>
            <div className="relative max-h-full w-full max-w-3xl" onClick={(e) => e.stopPropagation()}>
              <div className="mb-2 flex items-center gap-2 text-white">
                <span className="min-w-0 flex-1 truncate text-sm">{aberto.nome_arquivo}</span>
                <button onClick={() => baixar(aberto)} className="rounded-lg p-2 hover:bg-white/10" aria-label="Baixar">
                  <Download className="size-5" />
                </button>
                <button onClick={() => setAberto(null)} className="rounded-lg p-2 hover:bg-white/10" aria-label="Fechar" autoFocus>
                  <X className="size-5" />
                </button>
              </div>
              {tipoAnexo(aberto) === "video" ? (
                <video src={links.get(aberto.caminho)} controls autoPlay playsInline className="max-h-[80dvh] w-full rounded-xl bg-black" />
              ) : (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={links.get(aberto.caminho)} alt={aberto.nome_arquivo} className="mx-auto max-h-[80dvh] rounded-xl object-contain" />
              )}
            </div>
          </div>,
          document.body,
        )}
    </>
  );
}
