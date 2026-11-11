"use client";

import { AuthProvider, useAuth } from "@/components/auth-provider";
import { AppShell } from "@/components/app-shell";
import { Spinner } from "@/components/ui";

function Gate({ children }: { children: React.ReactNode }) {
  const { loading, profile } = useAuth();
  if (loading || !profile)
    return (
      <div className="grid min-h-dvh place-items-center paper">
        <Spinner />
      </div>
    );
  return <AppShell>{children}</AppShell>;
}

export default function AppLayout({ children }: { children: React.ReactNode }) {
  return (
    <AuthProvider>
      <Gate>{children}</Gate>
    </AuthProvider>
  );
}
