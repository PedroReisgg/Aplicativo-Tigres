export type Status = "pendente" | "ativo" | "inativo";

export interface Profile {
  id: string;
  nome: string;
  email: string;
  telefone: string | null;
  data_nascimento: string | null;
  cargo: string;
  /** Todas as funções da pessoa (o cargo é a principal). */
  funcoes?: string[] | null;
  is_admin: boolean;
  status: Status;
  created_at: string;
  idade?: number | null;
  classes?: { class_id: number; funcao: string }[];
  unidades?: { unidade_id: string; funcao: string }[];
  cargo_solicitado?: string | null;
}

export interface Unidade {
  id: string;
  nome: string;
  cor: string;
  created_at: string;
}

export interface Classe {
  id: number;
  slug: string;
  nome: string;
  idade_minima: number;
  cor: string;
  classe_avancada: string | null;
  url_mda: string | null;
}

export interface CadernoItem {
  id: number;
  class_id: number;
  secao: string;
  secao_ordem: number;
  ordem: number;
  codigo: string;
  texto: string;
  detalhes: { t: string; sub?: { t: string }[] }[];
  especialidades: string[];
  avancada: boolean;
  personalizado: boolean;
}

export interface Categoria {
  slug: string;
  nome: string;
  cor: string;
  ordem: number;
  url_mda: string | null;
}

export interface Especialidade {
  codigo: string;
  nome: string;
  categoria_slug: string;
  tipo: string;
  nivel: number | null;
  ano: number | null;
  origem: string | null;
  imagem: string | null;
  url_mda: string | null;
  requisitos?: string;
}

export interface Desbravador {
  id: string;
  nome: string;
  data_nascimento: string | null;
  sexo: "M" | "F" | null;
  cpf: string | null;
  /** Campos antigos (antes de "responsável 1 e 2"); só leitura. */
  nome_pai: string | null;
  nome_mae: string | null;
  responsavel1_nome?: string | null;
  /** Telefone do responsável 1. */
  telefone_responsavel: string;
  responsavel2_nome?: string | null;
  responsavel2_telefone?: string | null;
  telefone: string | null;
  email: string | null;
  endereco: string | null;
  unidade: string | null;
  unidade_id: string | null;
  class_id: number | null;
  observacoes: string | null;
  ativo: boolean;
  created_at: string;
  idade?: number | null;
  classe_nome?: string | null;
  classe_slug?: string | null;
  classe_cor?: string | null;
  unidade_cor?: string | null;
}

export interface Progresso {
  desbravador_id: string;
  item_id: number;
  status: "feito" | "refazer";
  observacao: string | null;
  marcado_por: string | null;
  marcado_em: string;
  validacao?: Validacao;
  validado_por?: string | null;
  validado_em?: string | null;
}

export type Validacao = "pendente" | "aprovada";

export interface DesbEsp {
  desbravador_id: string;
  especialidade_codigo: string;
  status: "concluida" | "refazer";
  concluida_em: string;
  /** hora em que fez (opcional, "HH:MM:SS") */
  concluida_hora?: string | null;
  observacao: string | null;
  registrado_por?: string | null;
  /** quando foi colocada no sistema */
  registrado_em?: string | null;
  created_at?: string;
  updated_at?: string;
  validacao?: Validacao;
  validado_por?: string | null;
  validado_em?: string | null;
}

export interface Anexo {
  id: string;
  desbravador_id: string;
  especialidade_codigo: string;
  caminho: string;
  nome_arquivo: string;
  tipo: string | null;
  tamanho: number | null;
  enviado_por: string | null;
  created_at: string;
}

export interface RegistroAtividade {
  id: number;
  created_at: string;
  autor_id: string | null;
  autor_nome: string | null;
  acao: "registrou" | "aprovou" | "devolveu" | "removeu" | "anexou" | "marcou" | "desmarcou" | "editou";
  tipo: "especialidade" | "caderno";
  desbravador_id: string | null;
  desbravador_nome: string | null;
  alvo: string | null;
  alvo_nome: string | null;
  detalhe: string | null;
}

export interface Notificacao {
  id: string;
  destinatario_id: string;
  remetente_id: string | null;
  tipo: string;
  titulo: string;
  mensagem: string | null;
  link: string | null;
  lida_em: string | null;
  created_at: string;
}

/** Cargos que a pessoa pode escolher no cadastro. */
export const CARGOS = ["Diretor", "Diretor Associado", "Secretário(a)", "Tesoureiro(a)", "Capelão", "Instrutor(a)", "Conselheiro(a)"];

/** Cargos com acesso de administrador (podem mudar tudo). */
export const CARGOS_ADMIN = ["Diretor", "Diretor Associado"];
/** Cargos que veem todo o clube e baixam planilhas, sem poder mudar. */
export const CARGOS_LEITURA = ["Secretário(a)", "Tesoureiro(a)", "Capelão"];
export const CARGO_INSTRUTOR = "Instrutor(a)";

/** Funções da pessoa, na ordem de importância (aceita perfis antigos só com "cargo"). */
export function funcoesDe(p: Pick<Profile, "cargo" | "funcoes"> | null | undefined): string[] {
  if (!p) return [];
  const f = p.funcoes?.length ? p.funcoes : CARGOS.includes(p.cargo) ? [p.cargo] : [];
  return CARGOS.filter((c) => f.includes(c));
}
/** Texto curto com todas as funções, ex.: "Diretor · Instrutor(a)". */
export function funcoesTexto(p: Pick<Profile, "cargo" | "funcoes"> | null | undefined): string {
  const f = funcoesDe(p);
  return f.length ? f.join(" · ") : p?.cargo || "";
}
/** Separa as funções que a pessoa escolheu no cadastro (texto "A, B"). */
export function funcoesSolicitadas(texto: string | null | undefined): string[] {
  const partes = (texto || "").split(",").map((s) => s.trim());
  return CARGOS.filter((c) => partes.includes(c));
}
export const CARGO_CONSELHEIRO = "Conselheiro(a)";

export const DESCRICAO_CARGO: Record<string, string> = {
  Diretor: "Acesso total: aprova cadastros, cria unidades, importa desbravadores e mexe em tudo.",
  "Diretor Associado": "Acesso total, igual ao diretor.",
  "Secretário(a)": "Vê todo o clube e baixa todas as planilhas, sem poder alterar.",
  "Tesoureiro(a)": "Vê todo o clube e baixa todas as planilhas, sem poder alterar.",
  Capelão: "Vê todo o clube e baixa todas as planilhas, sem poder alterar.",
  "Instrutor(a)": "Coordena as classes que o diretor definir: marca o caderno e lança as especialidades com comprovante.",
  "Conselheiro(a)": "Coordena as unidades que o diretor definir: acompanha os desbravadores e lança especialidades com comprovante.",
};

export const CORES_UNIDADE = ["#F26B1D", "#D93A2B", "#2F7D4F", "#2563A8", "#7B3FA0", "#C99A12", "#0E8C8C", "#6B4A2E"];

/** Responsável 1 e 2 do desbravador (com os campos antigos de mãe/pai como reserva). */
export function responsaveisDe(d: Pick<Desbravador, "nome_mae" | "nome_pai" | "responsavel1_nome" | "responsavel2_nome" | "telefone_responsavel" | "responsavel2_telefone">) {
  const novo = d.responsavel1_nome != null || d.responsavel2_nome != null;
  const r1 = novo ? d.responsavel1_nome || null : d.nome_mae || d.nome_pai || null;
  const r2 = novo ? d.responsavel2_nome || null : d.nome_mae ? d.nome_pai || null : null;
  return [
    { titulo: "Responsável 1", nome: r1, telefone: d.telefone_responsavel || null },
    { titulo: "Responsável 2", nome: r2, telefone: d.responsavel2_telefone || null },
  ];
}

export interface Livro {
  id: string;
  titulo: string;
  autor: string | null;
  descricao: string | null;
  categoria: string | null;
  capa_path: string | null;
  pdf_path: string | null;
  pdf_nome: string | null;
  pdf_tamanho: number | null;
  /** Quantos exemplares físicos o clube tem para emprestar. */
  exemplares: number;
  criado_por: string | null;
  created_at: string;
  atualizado_por: string | null;
  updated_at: string;
}

export interface Emprestimo {
  id: string;
  livro_id: string;
  desbravador_id: string;
  emprestado_em: string;
  devolver_ate: string | null;
  devolvido_em: string | null;
  observacao: string | null;
  emprestado_por: string | null;
  devolvido_por: string | null;
  created_at: string;
}

export interface LivroHistorico {
  id: number;
  livro_id: string | null;
  livro_titulo: string | null;
  acao: string;
  detalhe: string | null;
  autor_id: string | null;
  autor_nome: string | null;
  created_at: string;
}

export type EstadoItem = "bom" | "regular" | "ruim" | "manutencao";

export interface ItemInventario {
  id: string;
  nome: string;
  categoria: string;
  quantidade: number;
  estado: EstadoItem;
  unidade_id: string | null;
  local: string | null;
  observacao: string | null;
  criado_por: string | null;
  created_at: string;
  atualizado_por: string | null;
  updated_at: string;
}

export interface Vaquinha {
  id: string;
  titulo: string;
  descricao: string | null;
  meta: number;
  pix_chave: string | null;
  pix_nome: string | null;
  pix_cidade: string | null;
  prazo: string | null;
  encerrada: boolean;
  criado_por: string | null;
  created_at: string;
  atualizado_por: string | null;
  updated_at: string;
}

export interface VaquinhaEntrada {
  id: string;
  vaquinha_id: string;
  valor: number;
  nome: string | null;
  data: string;
  registrado_por: string | null;
  created_at: string;
}

export interface AgendaEvento {
  id: string;
  titulo: string;
  descricao: string | null;
  /** aaaa-mm-dd */
  inicio: string;
  /** último dia (eventos de vários dias) */
  fim: string | null;
  /** hh:mm:ss (vazio = dia inteiro) */
  hora_inicio: string | null;
  hora_fim: string | null;
  cor: string;
  endereco: string | null;
  updated_at: string;
}

export interface ProgramacaoItem {
  hora: string;
  atividade: string;
}

export interface Programacao {
  id: string;
  titulo: string;
  data: string;
  itens: ProgramacaoItem[];
  observacao: string | null;
  criado_por: string | null;
  created_at: string;
  atualizado_por: string | null;
  updated_at: string;
}
