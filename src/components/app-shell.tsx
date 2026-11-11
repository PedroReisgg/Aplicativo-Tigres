"use client";

import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect, useState, type ReactNode } from "react";
import { Award, Bell, BookOpen, Flag, Home, LogOut, Menu, ShieldCheck, UserRound, Users, X, Download } from "lucide-react";
import { useAuth } from "./auth-provider";
import { Avatar, cn } from "./ui";
import { supabaseBrowser } from "@/lib/supabase/client";

type Item = { href: string; label: string; icon: typeof Home; show?: (a: ReturnType<typeof useAuth>) => boolean };

const NAV: Item[] = [
  { href: "/painel", label: "Painel", icon: Home },
  { href: "/classes", label: "Classes", icon: BookOpen },
  { href: "/especialidades", label: "Especialidades", icon: Award },
  { href: "/desbravadores", label: "Desbravadores", icon: Users, show: (a) => a.isActive },
  { href: "/unidades", label: "Unidades", icon: Flag, show: (a) => a.isActive },
  { href: "/diretoria", label: "Diretoria", icon: ShieldCheck, show: (a) => a.veTudo },
];

function useUnread() {
  const { userId } = useAuth();
  const [n, setN] = useState(0);
  useEffect(() => {
    if (!userId) return;
    const sb = supabaseBrowser();
    const load = () =>
      sb
        .from("notificacoes")
        .select("id", { count: "exact", head: true })
        .eq("destinatario_id", userId)
        .is("lida_em", null)
        .then(({ count }: { count: number | null }) => setN(count || 0));
    load();
    const ch = sb
      .channel("unread-" + userId)
      .on("postgres_changes", { event: "*", schema: "public", table: "notificacoes", filter: `destinatario_id=eq.${userId}` }, load)
      .subscribe();
    const onFocus = () => load();
    window.addEventListener("focus", onFocus);
    window.addEventListener("tigres:notif", onFocus);
    return () => {
      sb.removeChannel(ch);
      window.removeEventListener("focus", onFocus);
      window.removeEventListener("tigres:notif", onFocus);
    };
  }, [userId]);
  return n;
}

export function AppShell({ children }: { children: ReactNode }) {
  const auth = useAuth();
  const path = usePathname();
  const unread = useUnread();
  const [menu, setMenu] = useState(false);
  const items = NAV.filter((i) => !i.show || i.show(auth));
  const active = (href: string) => path === href || path.startsWith(href + "/");

  useEffect(() => setMenu(false), [path]);

  return (
    <div className="min-h-dvh paper lg:pl-[264px]">
      {/* Sidebar desktop */}
      <aside className="fixed inset-y-0 left-0 z-40 hidden w-[264px] flex-col bg-ink-900 text-ink-100 lg:flex">
        <Link href="/painel" className="flex items-center gap-3 px-5 pb-6 pt-6">
          <Image src="/brand/logo.webp" alt="" width={48} height={48} className="size-12" priority />
          <div className="leading-tight">
            <div className="font-display text-lg font-semibold uppercase tracking-wide text-white">Tigres do Riacho</div>
            <div className="text-xs text-ink-400">Clube de Desbravadores</div>
          </div>
        </Link>
        <nav className="flex-1 space-y-1 px-3" aria-label="Principal">
          {items.map((i) => (
            <Link
              key={i.href}
              href={i.href}
              aria-current={active(i.href) ? "page" : undefined}
              className={cn(
                "group flex h-11 items-center gap-3 rounded-xl px-3 text-[15px] font-medium transition-colors",
                active(i.href) ? "bg-tiger-500 text-white" : "text-ink-300 hover:bg-white/5 hover:text-white"
              )}
            >
              <i.icon className="size-5" aria-hidden />
              {i.label}
            </Link>
          ))}
          <Link
            href="/notificacoes"
            aria-current={active("/notificacoes") ? "page" : undefined}
            className={cn(
              "flex h-11 items-center gap-3 rounded-xl px-3 text-[15px] font-medium transition-colors",
              active("/notificacoes") ? "bg-tiger-500 text-white" : "text-ink-300 hover:bg-white/5 hover:text-white"
            )}
          >
            <Bell className="size-5" aria-hidden />
            Notificações
            {unread > 0 && <span className="ml-auto rounded-full bg-tiger-500 px-2 text-xs font-bold text-white">{unread}</span>}
          </Link>
        </nav>
        <div className="border-t border-white/10 p-3">
          <Link href="/perfil" className="flex items-center gap-3 rounded-xl p-2 hover:bg-white/5">
            <Avatar nome={auth.profile?.nome} color="#F26B1D" size={38} />
            <div className="min-w-0 flex-1">
              <div className="truncate text-sm font-semibold text-white">{auth.profile?.nome || "…"}</div>
              <div className="truncate text-xs text-ink-400">{auth.profile?.cargo}</div>
            </div>
          </Link>
          <button
            onClick={auth.signOut}
            className="mt-1 flex h-10 w-full items-center gap-3 rounded-xl px-3 text-sm text-ink-400 hover:bg-white/5 hover:text-white"
          >
            <LogOut className="size-4" /> Sair
          </button>
        </div>
      </aside>

      {/* Topbar celular */}
      <header className="sticky top-0 z-30 border-b border-white/5 bg-ink-900/95 pt-safe text-white backdrop-blur lg:hidden">
        <div className="flex h-14 items-center gap-3 px-4">
          <Link href="/painel" className="flex min-w-0 items-center gap-2.5">
            <Image src="/brand/logo.webp" alt="" width={36} height={36} className="size-9" priority />
            <span className="truncate font-display text-[17px] font-semibold uppercase tracking-wide">Tigres do Riacho</span>
          </Link>
          <div className="ml-auto flex items-center gap-1">
            <Link href="/notificacoes" className="relative rounded-xl p-2.5 hover:bg-white/10" aria-label={`Notificações${unread ? `, ${unread} não lidas` : ""}`}>
              <Bell className="size-[22px]" />
              {unread > 0 && (
                <span className="absolute right-1 top-1 grid min-w-[18px] place-items-center rounded-full bg-tiger-500 px-1 text-[11px] font-bold leading-[18px]">
                  {unread > 9 ? "9+" : unread}
                </span>
              )}
            </Link>
            <button onClick={() => setMenu(true)} className="rounded-xl p-2.5 hover:bg-white/10" aria-label="Abrir menu">
              <Menu className="size-[22px]" />
            </button>
          </div>
        </div>
      </header>

      {/* Menu celular */}
      {menu && (
        <div className="fixed inset-0 z-[55] lg:hidden" role="dialog" aria-modal="true" aria-label="Menu">
          <div className="absolute inset-0 bg-ink-900/50" onClick={() => setMenu(false)} />
          <div className="absolute inset-x-0 bottom-0 rounded-t-3xl bg-white p-4 pb-[max(1rem,env(safe-area-inset-bottom))] shadow-lift animate-fade-up">
            <div className="mb-3 flex items-center gap-3 px-1">
              <Avatar nome={auth.profile?.nome} color="#F26B1D" size={44} />
              <div className="min-w-0 flex-1">
                <div className="truncate font-semibold">{auth.profile?.nome}</div>
                <div className="truncate text-sm text-ink-500">{auth.profile?.cargo}</div>
              </div>
              <button onClick={() => setMenu(false)} className="rounded-xl p-2 text-ink-500 hover:bg-ink-100" aria-label="Fechar menu">
                <X className="size-5" />
              </button>
            </div>
            <div className="grid gap-1">
              {[...items, { href: "/perfil", label: "Meu perfil", icon: UserRound }, { href: "/app", label: "Instalar o app", icon: Download }].map((i) => (
                <Link
                  key={i.href}
                  href={i.href}
                  className={cn("flex h-12 items-center gap-3 rounded-xl px-3 font-medium", active(i.href) ? "bg-tiger-50 text-tiger-700" : "text-ink-800 hover:bg-ink-50")}
                >
                  <i.icon className="size-5" /> {i.label}
                </Link>
              ))}
              <button onClick={auth.signOut} className="flex h-12 items-center gap-3 rounded-xl px-3 font-medium text-red-600 hover:bg-red-50">
                <LogOut className="size-5" /> Sair
              </button>
            </div>
          </div>
        </div>
      )}

      <main className="mx-auto w-full max-w-6xl px-4 pb-28 pt-5 sm:px-6 sm:pt-8 lg:px-10 lg:pb-12">{children}</main>

      {/* Barra inferior celular */}
      <nav
        className="fixed inset-x-0 bottom-0 z-30 border-t border-ink-200 bg-white/95 pb-safe backdrop-blur lg:hidden"
        aria-label="Navegação inferior"
      >
        <div className="mx-auto grid max-w-lg" style={{ gridTemplateColumns: `repeat(${Math.min(items.length, 4)}, minmax(0,1fr))` }}>
          {items.slice(0, 4).map((i) => (
            <Link
              key={i.href}
              href={i.href}
              aria-current={active(i.href) ? "page" : undefined}
              className={cn("flex h-16 flex-col items-center justify-center gap-1 text-[11px] font-semibold", active(i.href) ? "text-tiger-600" : "text-ink-500")}
            >
              <span className={cn("grid h-8 w-14 place-items-center rounded-full transition-colors", active(i.href) && "bg-tiger-100")}>
                <i.icon className="size-[22px]" aria-hidden />
              </span>
              {i.label}
            </Link>
          ))}
        </div>
      </nav>
    </div>
  );
}
