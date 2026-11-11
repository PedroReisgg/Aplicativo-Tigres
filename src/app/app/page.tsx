"use client";

import Image from "next/image";
import Link from "next/link";
import { useEffect, useState } from "react";
import { Download, PlusSquare, Share, Smartphone } from "lucide-react";
import { Card, ClawMarks } from "@/components/ui";

type BIP = Event & { prompt: () => Promise<void> };

export default function InstalarPage() {
  const [so, setSo] = useState<"ios" | "android" | "outro">("outro");
  const [bip, setBip] = useState<BIP | null>(null);
  useEffect(() => {
    const ua = navigator.userAgent;
    setSo(/iphone|ipad|ipod/i.test(ua) ? "ios" : /android/i.test(ua) ? "android" : "outro");
    const h = (e: Event) => {
      e.preventDefault();
      setBip(e as BIP);
    };
    window.addEventListener("beforeinstallprompt", h);
    return () => window.removeEventListener("beforeinstallprompt", h);
  }, []);

  return (
    <main className="min-h-dvh paper">
      <section className="relative overflow-hidden bg-ink-900 px-6 pb-14 pt-[max(2.5rem,env(safe-area-inset-top))] text-center text-white">
        <ClawMarks className="pointer-events-none absolute -right-10 -top-6 h-64 w-64 rotate-12 text-tiger-500/25" />
        <Image src="/brand/logo.png" alt="Tigres do Riacho" width={120} height={120} className="relative mx-auto size-28" priority />
        <h1 className="relative mt-4 font-display text-3xl font-semibold uppercase tracking-wide">Instale o app</h1>
        <p className="relative mx-auto mt-2 max-w-md text-ink-300">O mesmo app no Android, no iPhone e no computador. Tudo fica sincronizado.</p>
      </section>
      <div className="mx-auto -mt-8 grid max-w-3xl gap-4 px-4 pb-12 sm:grid-cols-2">
        <Card className={`p-6 ${so === "android" ? "ring-2 ring-tiger-500" : ""}`}>
          <div className="mb-3 flex items-center gap-2 font-display text-xl font-semibold uppercase tracking-wide">
            <Smartphone className="size-5 text-tiger-600" /> Android
          </div>
          <p className="text-sm text-ink-600">Baixe o APK e abra o arquivo. Se o Android pedir, permita “instalar apps desta fonte”.</p>
          <a href="/download/tigres-do-riacho.apk" className="mt-4 flex h-12 items-center justify-center gap-2 rounded-xl bg-tiger-500 font-semibold text-white hover:bg-tiger-600">
            <Download className="size-5" /> Baixar APK
          </a>
          {bip && (
            <button onClick={() => bip.prompt()} className="mt-2 h-11 w-full rounded-xl border border-ink-200 text-sm font-semibold hover:bg-ink-50">
              Ou instalar direto pelo Chrome
            </button>
          )}
        </Card>
        <Card className={`p-6 ${so === "ios" ? "ring-2 ring-tiger-500" : ""}`}>
          <div className="mb-3 flex items-center gap-2 font-display text-xl font-semibold uppercase tracking-wide">
            <Smartphone className="size-5 text-tiger-600" /> iPhone
          </div>
          <ol className="space-y-3 text-sm text-ink-700">
            <li className="flex gap-3">
              <span className="grid size-6 shrink-0 place-items-center rounded-full bg-tiger-100 text-xs font-bold text-tiger-800">1</span>
              Abra <strong>tigresapp.vercel.app</strong> no <strong>Safari</strong>.
            </li>
            <li className="flex gap-3">
              <span className="grid size-6 shrink-0 place-items-center rounded-full bg-tiger-100 text-xs font-bold text-tiger-800">2</span>
              <span>
                Toque em <Share className="inline size-4 align-text-bottom" /> <strong>Compartilhar</strong>.
              </span>
            </li>
            <li className="flex gap-3">
              <span className="grid size-6 shrink-0 place-items-center rounded-full bg-tiger-100 text-xs font-bold text-tiger-800">3</span>
              <span>
                Escolha <PlusSquare className="inline size-4 align-text-bottom" /> <strong>Adicionar à Tela de Início</strong>.
              </span>
            </li>
          </ol>
        </Card>
        <p className="text-center text-sm text-ink-500 sm:col-span-2">
          <Link href="/entrar" className="font-semibold text-tiger-700 hover:underline">
            Entrar no app
          </Link>
        </p>
      </div>
    </main>
  );
}
