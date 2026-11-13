"use client";

import { useMemo, useRef, useState } from "react";
import { AlertTriangle, CalendarDays, Check, Download, FileUp, Link2, UserCog } from "lucide-react";
import { toast } from "sonner";
import { useAuth } from "@/components/auth-provider";
import { AgendaCalendario } from "@/components/agenda-calendario";
import { Avatar, Badge, Button, Checkbox, EmptyState, PageHeader, Sheet, Skeleton } from "@/components/ui";
import { supabaseBrowser } from "@/lib/supabase/client";
import { useData } from "@/lib/use-data";
import { getMembros } from "@/lib/api";
import { getEditores, getEventos, importarEventos, lerAgendaExcel, modeloAgenda, type LinhaAgenda } from "@/lib/agenda";
import { quando } from "@/lib/agenda-core";
import { downloadBlob } from "@/lib/reports";
import { funcoesTexto, type AgendaEvento, type Profile } from "@/lib/types";

export default function AgendaPage() {
  const auth = useAuth();
  const [importar, setImportar] = useState(false);
  const [editores, setEditores] = useState(false);
  const { data, loading, error, reload } = useData(async () => {
    const [eventos, ed] = await Promise.all([getEventos(), getEditores()]);
    return { eventos, editores: ed };
  }, [auth.isActive]);

  if (!auth.isActive) return <EmptyState icon={<CalendarDays className="size-6" />} title="Acesso pendente" description="Quando o diretor liberar seu acesso, você verá a agenda do clube." />;
  const pode = auth.isAdmin || !!(auth.userId && data?.editores.includes(auth.userId));

  async function copiarLink() {
    try {
      await navigator.clipboard.writeText(`${window.location.origin}/calendario`);
      toast.success("Link copiado. Mande para os desbravadores e as famílias.");
    } catch {
      toast.error("Não deu para copiar.");
    }
  }

  return (
    <div>
      <PageHeader
        eyebrow="Clube"
        title="Agenda"
        description={
          pode
            ? "Coloque as atividades do clube. Quem tem o link vê a agenda sem cadastro e pode sincronizar com o Google Agenda ou o iPhone."
            : "Todas as atividades do clube. Sincronize com o seu Google Agenda ou o iPhone."
        }
        actions={
          <>
            <Button variant="secondary" icon={<Link2 className="size-4" />} onClick={copiarLink}>
              Copiar link público
            </Button>
            {pode && (
              <Button variant="secondary" icon={<FileUp className="size-4" />} onClick={() => setImportar(true)}>
                Importar Excel
              </Button>
            )}
            {auth.isAdmin && (
              <Button variant="secondary" icon={<UserCog className="size-4" />} onClick={() => setEditores(true)}>
                Quem pode editar
              </Button>
            )}
          </>
        }
      />
      {loading ? (
        <div className="space-y-3">
          <Skeleton className="h-10" />
          <Skeleton className="h-[420px]" />
        </div>
      ) : error || !data ? (
        <EmptyState icon={<CalendarDays className="size-6" />} title="Não foi possível abrir a agenda" description={error || "Tente de novo."} action={<Button onClick={() => reload()}>Tentar de novo</Button>} />
      ) : (
        <AgendaCalendario eventos={data.eventos} podeEditar={pode} onMudou={() => reload(true)} />
      )}
      {pode && data && <ImportarSheet open={importar} existentes={data.eventos} onClose={() => setImportar(false)} onFeito={() => (setImportar(false), reload(true))} />}
      {auth.isAdmin && data && <EditoresSheet open={editores} atuais={data.editores} onClose={() => setEditores(false)} onFeito={() => reload(true)} />}
    </div>
  );
}

function ImportarSheet({ open, existentes, onClose, onFeito }: { open: boolean; existentes: AgendaEvento[]; onClose: () => void; onFeito: () => void }) {
  const ref = useRef<HTMLInputElement>(null);
  const [linhas, setLinhas] = useState<LinhaAgenda[] | null>(null);
  const [arquivo, setArquivo] = useState("");
  const [pularRepetidos, setPularRepetidos] = useState(true);
  const [busy, setBusy] = useState(false);
  const validas = (linhas || []).filter((l) => l.dados && !(pularRepetidos && l.repetido));
  const comErro = (linhas || []).filter((l) => l.erros.length);
  const repetidos = (linhas || []).filter((l) => l.repetido);

  async function ler(f?: File) {
    if (!f) return;
    setBusy(true);
    try {
      setLinhas(await lerAgendaExcel(f, existentes));
      setArquivo(f.name);
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setBusy(false);
    }
  }
  async function confirmar() {
    setBusy(true);
    try {
      await importarEventos(validas.map((l) => l.dados!));
      toast.success(`${validas.length} evento(s) colocados na agenda.`);
      setLinhas(null);
      onFeito();
    } catch (e) {
      toast.error((e as Error).message);
    } finally {
      setBusy(false);
    }
  }
  const fechar = () => {
    setLinhas(null);
    onClose();
  };

  return (
    <Sheet
      open={open}
      onClose={fechar}
      wide
      title="Importar agenda do Excel"
      description="Baixe o modelo, preencha uma linha por atividade e envie aqui."
      footer={
        linhas ? (
          <>
            <Button variant="secondary" onClick={() => setLinhas(null)}>
              Escolher outro arquivo
            </Button>
            <Button loading={busy} disabled={!validas.length} onClick={confirmar}>
              Colocar {validas.length} na agenda
            </Button>
          </>
        ) : undefined
      }
    >
      {!linhas ? (
        <div className="space-y-4">
          <div className="rounded-2xl border border-ink-200 p-4">
            <div className="font-semibold text-ink-900">1. Baixe o modelo pronto</div>
            <p className="mt-1 text-sm text-ink-600">Colunas: Data, Data final, Hora início, Hora fim, Título, Descrição, Endereço e Cor. Tem exemplos e uma aba explicando cada uma.</p>
            <Button className="mt-3" variant="secondary" icon={<Download className="size-4" />} onClick={async () => downloadBlob(await modeloAgenda(), "modelo-agenda-tigres.xlsx")}>
              Baixar modelo
            </Button>
          </div>
          <div className="rounded-2xl border border-ink-200 p-4">
            <div className="font-semibold text-ink-900">2. Envie a planilha preenchida</div>
            <p className="mt-1 text-sm text-ink-600">Você confere tudo antes de colocar na agenda. A agenda baixada pelo app também pode ser editada e enviada de volta.</p>
            <Button className="mt-3" icon={<FileUp className="size-4" />} loading={busy} onClick={() => ref.current?.click()}>
              Escolher arquivo Excel
            </Button>
            <input ref={ref} type="file" accept=".xlsx,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" className="hidden" onChange={(e) => (ler(e.target.files?.[0]), (e.target.value = ""))} />
          </div>
        </div>
      ) : (
        <div className="space-y-4">
          <div className="flex flex-wrap gap-2 text-sm">
            <Badge tone="green">{validas.length} para colocar</Badge>
            {comErro.length > 0 && <Badge tone="red">{comErro.length} com problema</Badge>}
            {repetidos.length > 0 && <Badge tone="amber">{repetidos.length} já estão na agenda</Badge>}
            <span className="truncate text-ink-500">{arquivo}</span>
          </div>
          {repetidos.length > 0 && <Checkbox checked={pularRepetidos} onChange={setPularRepetidos} label="Pular os que já estão na agenda (mesmo dia e título)" />}
          <ul className="divide-y divide-ink-100 rounded-2xl border border-ink-200">
            {linhas.map((l) => (
              <li key={l.linha} className="flex items-start gap-3 px-3 py-2.5 text-sm">
                <span className="w-9 shrink-0 pt-0.5 text-xs text-ink-400">L{l.linha}</span>
                {l.dados ? (
                  <>
                    <span className="mt-1 size-3 shrink-0 rounded-full" style={{ background: l.dados.cor }} />
                    <div className="min-w-0 flex-1">
                      <div className="truncate font-medium text-ink-900">{l.dados.titulo}</div>
                      <div className="truncate text-ink-500">
                        {quando(l.dados)}
                        {l.dados.endereco ? ` · ${l.dados.endereco}` : ""}
                      </div>
                    </div>
                    {l.repetido ? <Badge tone="amber">Já existe</Badge> : <Check className="size-4 shrink-0 text-emerald-600" />}
                  </>
                ) : (
                  <div className="flex min-w-0 flex-1 items-start gap-2 text-red-700">
                    <AlertTriangle className="mt-0.5 size-4 shrink-0" /> <span>{l.erros.join(" · ")}</span>
                  </div>
                )}
              </li>
            ))}
            {!linhas.length && <li className="px-3 py-6 text-center text-ink-500">Nenhuma linha preenchida na planilha.</li>}
          </ul>
        </div>
      )}
    </Sheet>
  );
}

function EditoresSheet({ open, atuais, onClose, onFeito }: { open: boolean; atuais: string[]; onClose: () => void; onFeito: () => void }) {
  const auth = useAuth();
  const { data: membros } = useData(() => getMembros().catch(() => [] as Profile[]), [open]);
  const [busy, setBusy] = useState<string | null>(null);
  const ativos = useMemo(() => (membros || []).filter((m) => m.status === "ativo"), [membros]);
  async function alternar(m: Profile, v: boolean) {
    setBusy(m.id);
    const sb = supabaseBrowser();
    const { error } = v ? await sb.from("agenda_editores").insert({ profile_id: m.id, adicionado_por: auth.userId }) : await sb.from("agenda_editores").delete().eq("profile_id", m.id);
    setBusy(null);
    if (error) return toast.error(error.message);
    toast.success(v ? `${m.nome.split(" ")[0]} agora pode mexer na agenda.` : `${m.nome.split(" ")[0]} não mexe mais na agenda.`);
    onFeito();
  }
  return (
    <Sheet open={open} onClose={onClose} title="Quem pode editar a agenda" description="O diretor sempre pode. Marque quem mais da diretoria pode colocar, mudar e importar eventos.">
      <ul className="divide-y divide-ink-100 rounded-2xl border border-ink-200">
        {ativos.map((m) => (
          <li key={m.id} className="flex items-center gap-3 px-3 py-2.5">
            <Avatar nome={m.nome} size={34} />
            <div className="min-w-0 flex-1">
              <div className="truncate text-sm font-medium text-ink-900">{m.nome}</div>
              <div className="truncate text-xs text-ink-500">{funcoesTexto(m)}</div>
            </div>
            {m.is_admin ? <Badge tone="tiger">Diretor</Badge> : <Checkbox checked={atuais.includes(m.id)} disabled={busy === m.id} onChange={(v) => alternar(m, v)} />}
          </li>
        ))}
        {!ativos.length && <li className="px-3 py-6 text-center text-sm text-ink-500">Carregando…</li>}
      </ul>
    </Sheet>
  );
}
