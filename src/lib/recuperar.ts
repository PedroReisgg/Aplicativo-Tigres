/** Erro de "arquivo do app não carregou" (deploy novo ou cache velho do service worker). */
export function erroDeCarregamento(e: unknown) {
  const msg = e instanceof Error ? `${e.name} ${e.message}` : String(e ?? "");
  return /ChunkLoadError|Loading (CSS )?chunk|dynamically imported module|Importing a module script failed/i.test(msg);
}

const CHAVE = "tigres-recarregou";

/** Limpa o cache do app e recarrega a página uma vez (no máximo a cada 30 s). */
export async function limparCacheERecarregar(forcar = false) {
  try {
    const ultima = Number(sessionStorage.getItem(CHAVE) || 0);
    if (!forcar && Date.now() - ultima < 30000) return false;
    sessionStorage.setItem(CHAVE, String(Date.now()));
  } catch {}
  try {
    if ("caches" in window) await Promise.all((await caches.keys()).map((k) => caches.delete(k)));
    const regs = (await navigator.serviceWorker?.getRegistrations()) || [];
    await Promise.all(regs.map((r) => r.update().catch(() => {})));
  } catch {}
  window.location.reload();
  return true;
}
