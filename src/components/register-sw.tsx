"use client";
import { useEffect } from "react";
import { erroDeCarregamento, limparCacheERecarregar } from "@/lib/recuperar";

export function RegisterSW() {
  useEffect(() => {
    if ("serviceWorker" in navigator && process.env.NODE_ENV === "production") {
      navigator.serviceWorker.register("/sw.js", { updateViaCache: "none" }).catch(() => {});
    }
    // se um arquivo do app falhar ao carregar (cache velho), limpa e recarrega sozinho
    const onError = (e: ErrorEvent) => erroDeCarregamento(e.error ?? e.message) && limparCacheERecarregar();
    const onRejection = (e: PromiseRejectionEvent) => erroDeCarregamento(e.reason) && limparCacheERecarregar();
    window.addEventListener("error", onError);
    window.addEventListener("unhandledrejection", onRejection);
    return () => {
      window.removeEventListener("error", onError);
      window.removeEventListener("unhandledrejection", onRejection);
    };
  }, []);
  return null;
}
