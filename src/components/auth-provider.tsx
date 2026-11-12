"use client";

import { createContext, useCallback, useContext, useEffect, useMemo, useState, type ReactNode } from "react";
import { useRouter } from "next/navigation";
import { supabaseBrowser } from "@/lib/supabase/client";
import { CARGOS_LEITURA, CARGO_CONSELHEIRO, CARGO_INSTRUTOR, funcoesDe, type Classe, type Desbravador, type Profile } from "@/lib/types";

interface AuthCtx {
  userId: string | null;
  profile: Profile | null;
  classes: Classe[];
  staffClassIds: number[];
  /** Unidades que a pessoa coordena (conselheiro). */
  unidadeIds: string[];
  isAdmin: boolean;
  /** Secretaria, tesouraria e capelania: veem tudo, sem alterar. */
  isLeitor: boolean;
  /** Vê o clube inteiro (admin ou leitor). */
  veTudo: boolean;
  isInstrutor: boolean;
  isConselheiro: boolean;
  /** Capelão: entrega especialidades para qualquer desbravador. */
  isCapelao: boolean;
  /** Diretor ou tesouraria: registra o que entrou nas vaquinhas. */
  podeFinanceiro: boolean;
  /** Todas as funções da pessoa. */
  funcoes: string[];
  isActive: boolean;
  isPending: boolean;
  loading: boolean;
  canManageClass: (classId: number | null | undefined) => boolean;
  /** Pode lançar especialidades deste desbravador (instrutor da classe, conselheiro da unidade ou capelão). */
  canRegistrarEsp: (d: Pick<Desbravador, "class_id" | "unidade_id"> | null | undefined) => boolean;
  refresh: () => Promise<void>;
  signOut: () => Promise<void>;
}

const Ctx = createContext<AuthCtx | null>(null);

export function AuthProvider({ children }: { children: ReactNode }) {
  const sb = supabaseBrowser();
  const router = useRouter();
  const [userId, setUserId] = useState<string | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [classes, setClasses] = useState<Classe[]>([]);
  const [loading, setLoading] = useState(true);

  const load = useCallback(async () => {
    const {
      data: { user },
    } = await sb.auth.getUser();
    if (!user) {
      setUserId(null);
      setProfile(null);
      setLoading(false);
      router.replace("/entrar");
      return;
    }
    setUserId(user.id);
    const [{ data: p }, { data: cls }] = await Promise.all([sb.from("membros_view").select("*").eq("id", user.id).maybeSingle(), sb.from("classes").select("*").order("id")]);
    setProfile((p as Profile) || null);
    setClasses((cls as Classe[]) || []);
    setLoading(false);
  }, [sb, router]);

  useEffect(() => {
    load();
    const { data: sub } = sb.auth.onAuthStateChange((ev) => {
      if (ev === "SIGNED_OUT") {
        setProfile(null);
        router.replace("/entrar");
      }
    });
    return () => sub.subscription.unsubscribe();
  }, [load, sb, router]);

  // perfil atualizado em tempo real (ex.: diretor aprovou o cadastro)
  useEffect(() => {
    if (!userId) return;
    const ch = sb
      .channel("perfil-" + userId)
      .on("postgres_changes", { event: "*", schema: "public", table: "notificacoes", filter: `destinatario_id=eq.${userId}` }, () => load())
      .subscribe();
    return () => {
      sb.removeChannel(ch);
    };
  }, [userId, sb, load]);

  const value = useMemo<AuthCtx>(() => {
    const staffClassIds = (profile?.classes || []).map((c) => c.class_id);
    const isActive = profile?.status === "ativo";
    const isAdmin = !!profile?.is_admin && isActive;
    const funcoes = funcoesDe(profile);
    const isLeitor = isActive && !isAdmin && funcoes.some((f) => CARGOS_LEITURA.includes(f));
    const unidadeIds = (profile?.unidades || []).map((u) => u.unidade_id);
    const canManageClass = (cid: number | null | undefined) => !!cid && isActive && (isAdmin || staffClassIds.includes(cid));
    return {
      userId,
      profile,
      classes,
      staffClassIds,
      unidadeIds,
      isAdmin,
      isLeitor,
      veTudo: isAdmin || isLeitor,
      isInstrutor: isActive && funcoes.includes(CARGO_INSTRUTOR),
      isConselheiro: isActive && funcoes.includes(CARGO_CONSELHEIRO),
      isCapelao: isActive && funcoes.includes("Capelão"),
      podeFinanceiro: isAdmin || (isActive && funcoes.includes("Tesoureiro(a)")),
      funcoes,
      isActive,
      isPending: profile?.status === "pendente",
      loading,
      canManageClass,
      canRegistrarEsp: (d) =>
        !!d && (canManageClass(d.class_id) || (isActive && !!d.unidade_id && unidadeIds.includes(d.unidade_id)) || (isActive && funcoes.includes("Capelão"))),
      refresh: load,
      signOut: async () => {
        await sb.auth.signOut();
        router.replace("/entrar");
      },
    };
  }, [userId, profile, classes, loading, load, sb, router]);

  return <Ctx.Provider value={value}>{children}</Ctx.Provider>;
}

export function useAuth() {
  const c = useContext(Ctx);
  if (!c) throw new Error("useAuth fora do AuthProvider");
  return c;
}
