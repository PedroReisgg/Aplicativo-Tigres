"use client";

import "./globals.css";
import { useEffect } from "react";
import { erroDeCarregamento, limparCacheERecarregar } from "@/lib/recuperar";

/** Tela de erro geral: no lugar do "Application error" em branco, tenta se recuperar sozinha. */
export default function GlobalError({ error }: { error: Error & { digest?: string } }) {
  const carregamento = erroDeCarregamento(error);
  useEffect(() => {
    if (carregamento) limparCacheERecarregar();
  }, [carregamento]);

  return (
    <html lang="pt-BR">
      <body className="grid min-h-dvh place-items-center bg-ink-50 p-6 text-center text-ink-900">
        <div className="max-w-sm">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/brand/logo.webp" alt="" width={72} height={72} className="mx-auto mb-4 size-[72px]" />
          <h1 className="font-display text-2xl font-semibold uppercase tracking-wide">{carregamento ? "Atualizando o app…" : "Algo deu errado"}</h1>
          <p className="mt-2 text-sm text-ink-600">
            {carregamento ? "Saiu uma versão nova. Se a página não recarregar sozinha, toque no botão abaixo." : "Toque no botão abaixo para recarregar. Se continuar, avise a diretoria."}
          </p>
          <button
            onClick={() => limparCacheERecarregar(true)}
            className="mt-5 inline-flex h-11 items-center justify-center rounded-xl bg-tiger-600 px-5 text-sm font-semibold text-white hover:bg-tiger-700"
          >
            Recarregar o app
          </button>
        </div>
      </body>
    </html>
  );
}
