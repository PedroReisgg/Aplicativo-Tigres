import { NextResponse } from "next/server";
import { admin } from "@/lib/server/auth";

export const dynamic = "force-dynamic";

const nomePdf = (titulo: string, nome: string | null) => (nome && /\.pdf$/i.test(nome) ? nome : `${titulo}.pdf`);

/**
 * Biblioteca online e vaquinhas abertas para a página da família (/acompanhar/<token>).
 * Só responde para um link válido de um desbravador ativo. Os arquivos saem como links temporários (1 hora).
 */
export async function GET(_req: Request, { params }: { params: Promise<{ token: string }> }) {
  const { token } = await params;
  const vazio = NextResponse.json({ livros: [], vaquinhas: [] }, { headers: { "Cache-Control": "no-store" } });
  if (!/^[0-9a-f-]{36}$/i.test(token)) return NextResponse.json({ error: "Link inválido." }, { status: 404 });
  try {
    const db = admin();
    const { data: link } = await db.from("acompanhamento_links").select("desbravador_id, desbravadores!inner(ativo)").eq("token", token).maybeSingle();
    const ativo = (link as { desbravadores?: { ativo?: boolean } | { ativo?: boolean }[] } | null)?.desbravadores;
    if (!link || !(Array.isArray(ativo) ? ativo[0]?.ativo : ativo?.ativo)) return NextResponse.json({ error: "Link inválido." }, { status: 404 });

    const [livrosR, vaqR, entR] = await Promise.all([
      db.from("livros").select("id, titulo, autor, descricao, categoria, capa_path, pdf_path, pdf_nome, pdf_tamanho").not("pdf_path", "is", null).order("titulo"),
      db.from("vaquinhas").select("id, titulo, descricao, meta, prazo, pix_chave, pix_nome, pix_cidade").eq("encerrada", false).order("created_at", { ascending: false }),
      db.from("vaquinha_entradas").select("vaquinha_id, valor"),
    ]);
    if (livrosR.error && vaqR.error) return vazio; // banco ainda sem o SQL 0005

    const livros = livrosR.data || [];
    const bucket = db.storage.from("biblioteca");
    const capas = livros.map((l) => l.capa_path).filter(Boolean) as string[];
    const assinadas = capas.length ? (await bucket.createSignedUrls(capas, 3600)).data || [] : [];
    const capaUrl = new Map(assinadas.filter((a) => a.path && a.signedUrl).map((a) => [a.path as string, a.signedUrl as string]));
    const pdfs = await Promise.all(livros.map((l) => bucket.createSignedUrl(l.pdf_path as string, 3600, { download: nomePdf(l.titulo, l.pdf_nome) }).then((r) => r.data?.signedUrl || null)));

    const soma = new Map<string, { total: number; n: number }>();
    (entR.data || []).forEach((e) => {
      const t = soma.get(e.vaquinha_id) || { total: 0, n: 0 };
      soma.set(e.vaquinha_id, { total: t.total + Number(e.valor), n: t.n + 1 });
    });

    return NextResponse.json(
      {
        livros: livros
          .map((l, i) => ({
            id: l.id,
            titulo: l.titulo,
            autor: l.autor,
            descricao: l.descricao,
            categoria: l.categoria,
            capa: l.capa_path ? capaUrl.get(l.capa_path) || null : null,
            pdf: pdfs[i],
            pdf_tamanho: l.pdf_tamanho,
          }))
          .filter((l) => l.pdf),
        vaquinhas: (vaqR.data || []).map((v) => ({ ...v, meta: Number(v.meta), arrecadado: soma.get(v.id)?.total || 0, contribuicoes: soma.get(v.id)?.n || 0 })),
      },
      { headers: { "Cache-Control": "no-store" } }
    );
  } catch (e) {
    console.error("familia", e);
    return vazio;
  }
}
