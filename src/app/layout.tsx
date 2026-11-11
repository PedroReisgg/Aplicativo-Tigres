import type { Metadata, Viewport } from "next";
import "@fontsource-variable/inter";
import "@fontsource/oswald/500.css";
import "@fontsource/oswald/600.css";
import "@fontsource/oswald/700.css";
import "./globals.css";
import { Toaster } from "sonner";
import { RegisterSW } from "@/components/register-sw";

export const metadata: Metadata = {
  title: { default: "Tigres do Riacho", template: "%s · Tigres do Riacho" },
  description: "Coordenação do Clube de Desbravadores Tigres do Riacho: classes, cadernos, especialidades e relatórios.",
  applicationName: "Tigres App",
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || "https://tigresapp.vercel.app"),
  manifest: "/manifest.webmanifest",
  appleWebApp: { capable: true, title: "Tigres", statusBarStyle: "black-translucent" },
  icons: { icon: "/icon-192.png", apple: "/apple-touch-icon.png" },
  openGraph: { title: "Tigres do Riacho", description: "App do Clube de Desbravadores Tigres do Riacho", images: ["/og.png"] },
  formatDetection: { telephone: false },
};

export const viewport: Viewport = {
  themeColor: "#1C130E",
  width: "device-width",
  initialScale: 1,
  viewportFit: "cover",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pt-BR">
      <body>
        {children}
        <Toaster position="top-center" richColors closeButton toastOptions={{ style: { fontFamily: "inherit" } }} />
        <RegisterSW />
      </body>
    </html>
  );
}
