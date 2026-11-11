import Image from "next/image";
import { ClawMarks } from "@/components/ui";

export default function AuthLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex min-h-dvh flex-col bg-ink-50 lg:grid lg:grid-cols-[1.05fr_1fr]">
      {/* Lado da marca */}
      <section className="relative overflow-hidden bg-gradient-to-br from-tiger-600 via-tiger-700 to-[#7a2a08] px-6 pb-16 pt-[max(2.5rem,env(safe-area-inset-top))] text-white lg:flex lg:flex-col lg:justify-between lg:px-14 lg:py-14">
        <ClawMarks className="pointer-events-none absolute -right-10 -top-6 h-[340px] w-[340px] rotate-[18deg] text-black/10 lg:h-[560px] lg:w-[560px]" />
        <ClawMarks className="pointer-events-none absolute -bottom-24 -left-16 hidden h-[380px] w-[380px] -rotate-[24deg] text-white/[.06] lg:block" />
        <div className="relative flex items-center gap-3 lg:hidden">
          <Image src="/brand/logo.webp" alt="Tigres do Riacho" width={64} height={64} className="size-16 drop-shadow-xl" priority />
          <div>
            <div className="font-display text-2xl font-semibold uppercase leading-none tracking-wide">Tigres do Riacho</div>
            <div className="mt-1 text-sm text-white/75">Clube de Desbravadores · desde 2002</div>
          </div>
        </div>
        <div className="relative hidden lg:block">
          <div className="text-sm font-semibold uppercase tracking-[.2em] text-white/70">Desde 2002</div>
        </div>
        <div className="relative hidden flex-col items-center lg:flex">
          <Image src="/brand/logo.webp" alt="Tigres do Riacho" width={360} height={360} className="w-[min(360px,70%)] drop-shadow-[0_24px_40px_rgba(0,0,0,.35)]" priority />
        </div>
        <div className="relative hidden lg:block">
          <h2 className="font-display text-4xl font-semibold uppercase leading-[1.05] tracking-wide">
            Classes, cadernos e
            <br /> especialidades num só lugar.
          </h2>
          <p className="mt-3 max-w-md text-white/80">
            O app da diretoria para acompanhar cada desbravador, do Amigo ao Guia, e gerar relatórios em PDF e Excel.
          </p>
        </div>
      </section>

      {/* Formulário */}
      <section className="relative -mt-8 flex flex-1 justify-center rounded-t-[28px] bg-ink-50 px-5 pb-[max(2rem,env(safe-area-inset-bottom))] pt-8 lg:mt-0 lg:items-center lg:rounded-none lg:px-10">
        <div className="w-full max-w-[420px] animate-fade-up">{children}</div>
      </section>
    </div>
  );
}
