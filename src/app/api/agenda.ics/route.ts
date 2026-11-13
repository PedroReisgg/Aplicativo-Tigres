import { createClient } from "@supabase/supabase-js";
import { AGENDA_COLS, gerarIcs, hojeIso, somaDias } from "@/lib/agenda-core";
import type { AgendaEvento } from "@/lib/types";

export const dynamic = "force-dynamic";

/** Agenda do clube em formato de calendário: Google Agenda e iPhone assinam este endereço. */
export async function GET() {
  const sb = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!, { auth: { persistSession: false, autoRefreshToken: false } });
  // eventos de até 1 ano atrás em diante
  const { data, error } = await sb.from("agenda_eventos").select(AGENDA_COLS).gte("inicio", somaDias(hojeIso(), -365)).order("inicio").limit(2000);
  const ics = gerarIcs(error ? [] : ((data || []) as AgendaEvento[]));
  return new Response(ics, {
    headers: {
      "Content-Type": "text/calendar; charset=utf-8",
      "Content-Disposition": 'inline; filename="tigres-do-riacho.ics"',
      "Cache-Control": "public, max-age=0, s-maxage=600, stale-while-revalidate=3600",
    },
  });
}
