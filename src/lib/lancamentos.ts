"use client";

import { supabaseBrowser } from "./supabase/client";
import { adminIds, notificar, staffIdsDaClasse } from "./api";
import { enviarArquivos, vincularAnexos } from "./anexos";
import type { Desbravador } from "./types";

export type Marca = "feito" | "refazer";

const hoje = () => new Date().toISOString().slice(0, 10);

/**
 * Salva quem concluiu (ou deve refazer) uma especialidade, com os comprovantes.
 * Instrutor/conselheiro: fica aguardando a validação do diretor. Diretor: já sai aprovado.
 */
export async function salvarEspecialidade(o: {
  codigo: string;
  nome: string;
  estado: Map<string, Marca | null>;
  initial: Map<string, Marca>;
  mensagem: string;
  files: File[];
  userId: string;
  isAdmin: boolean;
  desbravadores: Desbravador[];
}) {
  const sb = supabaseBrowser();
  const concluidos: string[] = [];
  const refazer: string[] = [];
  const dels: string[] = [];
  o.estado.forEach((v, id) => {
    const antes = o.initial.get(id) || null;
    if (v === antes && !(v === "refazer" && o.mensagem)) return;
    if (!v) dels.push(id);
    else if (v === "feito") concluidos.push(id);
    else refazer.push(id);
  });
  if (concluidos.length && !o.isAdmin && !o.files.length) throw new Error("Anexe pelo menos um comprovante (foto, vídeo, PDF ou Excel).");

  // primeiro os arquivos: se falhar, nada é registrado pela metade
  const arquivos = o.files.length && concluidos.length ? await enviarArquivos(o.files, o.userId) : [];
  const agora = new Date().toISOString();

  if (concluidos.length) {
    const rows = concluidos.map((desbravador_id) => ({
      desbravador_id,
      especialidade_codigo: o.codigo,
      status: "concluida",
      observacao: null,
      registrado_por: o.userId,
      concluida_em: hoje(),
      ...(o.isAdmin ? { validacao: "aprovada", validado_por: o.userId, validado_em: agora } : {}),
    }));
    const { error } = await sb.from("desbravador_especialidades").upsert(rows);
    if (error) throw new Error(error.message);
    await vincularAnexos(arquivos, concluidos, o.codigo, o.userId);
  }
  if (refazer.length) {
    const rows = refazer.map((desbravador_id) => ({
      desbravador_id,
      especialidade_codigo: o.codigo,
      status: "refazer",
      observacao: o.mensagem || null,
      validacao: "pendente",
      validado_por: null,
      validado_em: null,
    }));
    const { error } = await sb.from("desbravador_especialidades").upsert(rows);
    if (error) throw new Error(error.message);
  }
  if (dels.length) {
    const { error } = await sb.from("desbravador_especialidades").delete().eq("especialidade_codigo", o.codigo).in("desbravador_id", dels);
    if (error) throw new Error(/row-level|permission/i.test(error.message) ? "Só o diretor pode tirar uma especialidade que já foi validada." : error.message);
  }

  // avisos (não impedem o registro se falharem)
  try {
    const nome = (id: string) => o.desbravadores.find((d) => d.id === id)?.nome.split(" ")[0] || "";
    if (concluidos.length && !o.isAdmin) {
      await notificar(o.userId, await adminIds(), {
        tipo: "validacao",
        titulo: `Especialidade para validar: ${o.nome}`,
        mensagem: `${concluidos.map(nome).join(", ")}. ${arquivos.length} comprovante(s) anexado(s).`,
        link: "/diretoria?aba=validacoes",
      });
    }
    if (refazer.length) {
      const classes = [
        ...new Set(
          o.desbravadores
            .filter((d) => refazer.includes(d.id))
            .map((d) => d.class_id)
            .filter(Boolean),
        ),
      ] as number[];
      const equipe = (await Promise.all(classes.map(staffIdsDaClasse))).flat();
      await notificar(o.userId, equipe, {
        tipo: "refazer",
        titulo: `Especialidade ${o.nome}: refazer`,
        mensagem: `${refazer.map(nome).join(", ")}: ${o.mensagem}`,
        link: `/especialidades/e/${o.codigo}`,
      });
    }
  } catch {
    /* aviso é opcional */
  }
  return { concluidos: concluidos.length, pendentes: o.isAdmin ? 0 : concluidos.length };
}

/** Campos de validação para o que o diretor marca no caderno (já sai aprovado). */
export function validacaoCaderno(isAdmin: boolean, status: Marca, userId: string | null) {
  if (!isAdmin) return {};
  return status === "feito" ? { validacao: "aprovada", validado_por: userId, validado_em: new Date().toISOString() } : { validacao: "pendente", validado_por: null, validado_em: null };
}
