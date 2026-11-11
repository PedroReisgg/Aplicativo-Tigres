export type Status = "pendente" | "ativo" | "inativo";

export interface Profile {
  id: string;
  nome: string;
  email: string;
  telefone: string | null;
  data_nascimento: string | null;
  cargo: string;
  is_admin: boolean;
  status: Status;
  created_at: string;
  idade?: number | null;
  classes?: { class_id: number; funcao: string }[];
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
  nome_pai: string | null;
  nome_mae: string | null;
  telefone_responsavel: string;
  telefone: string | null;
  email: string | null;
  endereco: string | null;
  unidade: string | null;
  class_id: number | null;
  observacoes: string | null;
  ativo: boolean;
  created_at: string;
  idade?: number | null;
  classe_nome?: string | null;
  classe_slug?: string | null;
  classe_cor?: string | null;
}

export interface Progresso {
  desbravador_id: string;
  item_id: number;
  status: "feito" | "refazer";
  observacao: string | null;
  marcado_por: string | null;
  marcado_em: string;
}

export interface DesbEsp {
  desbravador_id: string;
  especialidade_codigo: string;
  status: "concluida" | "refazer";
  concluida_em: string;
  observacao: string | null;
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

export const CARGOS = [
  "Diretor",
  "Diretor Associado",
  "Secretário(a)",
  "Tesoureiro(a)",
  "Capelão",
  "Instrutor(a)",
  "Conselheiro(a)",
  "Conselheiro(a) Associado(a)",
  "Apoio",
];

export const FUNCOES_CLASSE = ["Instrutor(a)", "Conselheiro(a)", "Auxiliar"];
