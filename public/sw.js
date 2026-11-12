// Service worker simples: cache de arquivos estáticos e página offline.
const CACHE = "tigres-v3";
const PRECACHE = ["/offline", "/brand/logo.webp", "/icon-192.png"];

self.addEventListener("install", (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(PRECACHE)).then(() => self.skipWaiting()));
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys().then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k)))).then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", (e) => {
  const req = e.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);
  if (url.origin !== location.origin) return;

  // imagens de especialidades e arquivos do Next: cache primeiro
  if (url.pathname.startsWith("/esp/") || url.pathname.startsWith("/_next/static/") || url.pathname.startsWith("/brand/")) {
    e.respondWith(
      caches.match(req).then(
        (hit) =>
          (hit && hit.ok && hit) ||
          fetch(req).then((res) => {
            // só guarda respostas boas: um 404 guardado travaria a página para sempre
            if (res.ok && res.type === "basic") {
              const copy = res.clone();
              caches.open(CACHE).then((c) => c.put(req, copy));
            }
            return res;
          })
      )
    );
    return;
  }

  // navegação: rede primeiro, cai para offline
  if (req.mode === "navigate") {
    e.respondWith(fetch(req).catch(() => caches.match("/offline")));
  }
});
