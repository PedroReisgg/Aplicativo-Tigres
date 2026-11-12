"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { Hourglass, UserX } from "lucide-react";
import { AuthProvider, useAuth } from "@/components/auth-provider";
import { AppShell } from "@/components/app-shell";
import { EmptyState, Spinner } from "@/components/ui";

/** Páginas que quem ainda não foi aprovado (ou perdeu o acesso) pode abrir. */
const LIVRES = ["/painel", "/perfil", "/notificacoes"];

function Gate({ children }: { children: React.ReactNode }) {
  const { loading, profile, isActive, isPending } = useAuth();
  const path = usePathname();
  if (loading || !profile)
    return (
      <div className="grid min-h-dvh place-items-center paper">
        <Spinner />
      </div>
    );
  const livre = LIVRES.some((p) => path === p || path.startsWith(p + "/"));
  return (
    <AppShell>
      {isActive || livre ? (
        children
      ) : (
        <EmptyState
          icon={isPending ? <Hourglass className="size-6" /> : <UserX className="size-6" />}
          title={isPending ? "Aguardando aprovação do diretor" : "Seu acesso está desativado"}
          description={
            isPending
              ? "Só quem o diretor aprovou vê as classes, os desbravadores e as especialidades. Você recebe uma notificação quando for liberado."
              : "Fale com o diretor do clube se acha que isso é um engano."
          }
          action={
            <Link href="/painel" className="font-semibold text-tiger-700 hover:underline">
              Ir para o início
            </Link>
          }
        />
      )}
    </AppShell>
  );
}

export default function AppLayout({ children }: { children: React.ReactNode }) {
  return (
    <AuthProvider>
      <Gate>{children}</Gate>
    </AuthProvider>
  );
}
