import type { CapacitorConfig } from "@capacitor/cli";

// O app Android abre o site publicado, então web e app usam sempre a mesma versão e o mesmo banco.
const config: CapacitorConfig = {
  appId: "br.com.tigresdoriacho.app",
  appName: "Tigres do Riacho",
  webDir: "capacitor-www",
  server: {
    url: "https://tigresapp.vercel.app/painel",
    androidScheme: "https",
    allowNavigation: ["tigresapp.vercel.app", "*.supabase.co"],
    errorPath: "index.html",
  },
  android: { backgroundColor: "#1C130E" },
  plugins: {
    SplashScreen: { launchShowDuration: 1200, backgroundColor: "#1C130E", showSpinner: false, androidScaleType: "CENTER_INSIDE" },
    StatusBar: { backgroundColor: "#1C130E", style: "DARK" },
  },
};

export default config;
