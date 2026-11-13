import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Agenda do clube · Tigres do Riacho",
  description: "Todas as atividades do Clube de Desbravadores Tigres do Riacho. Sincronize com o Google Agenda ou o iPhone.",
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return children;
}
