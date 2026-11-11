export default function Offline() {
  return (
    <main className="grid min-h-dvh place-items-center bg-ink-900 p-6 text-center text-white">
      <div>
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img src="/brand/logo.webp" alt="" width={120} height={120} className="mx-auto mb-6" />
        <h1 className="font-display text-3xl font-semibold uppercase tracking-wide">Sem conexão</h1>
        <p className="mt-2 text-ink-300">Verifique a internet e tente de novo.</p>
      </div>
    </main>
  );
}
