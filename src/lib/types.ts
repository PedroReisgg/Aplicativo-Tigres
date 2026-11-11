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
  nome_pai: string | null;
  nome_mae: string | null;
  telefone_responsavel: string;
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

/** Cargos que a pessoa pode escolher no cadastro. */
export const CARGOS = [
  "Diretor",
  "Diretor Associado",
  "Secretário(a)",
  "Tesoureiro(a)",
  "Capelão",
  "Instrutor(a)",
  "Conselheiro(a)",
];

/** Cargos com acesso de administrador (podem mudar tudo). */
export const CARGOS_ADMIN = ["Diretor", "Diretor Associado"];
/** Cargos que veem todo o clube e baixam planilhas, sem poder mudar. */
export const CARGOS_LEITURA = ["Secretário(a)", "Tesoureiro(a)", "Capelão"];
export const CARGO_INSTRUTOR = "Instrutor(a)";
export const CARGO_CONSELHEIRO = "Conselheiro(a)";

export const DESCRICAO_CARGO: Record<string, string> = {
  Diretor: "Acesso total: aprova cadastros, cria unidades, importa desbravadores e mexe em tudo.",
  "Diretor Associado": "Acesso total, igual ao diretor.",
  "Secretário(a)": "Vê todo o clube e baixa todas as planilhas, sem poder alterar.",
  "Tesoureiro(a)": "Vê todo o clube e baixa todas as planilhas, sem poder alterar.",
  Capelão: "Vê todo o clube e baixa todas as planilhas, sem poder alterar.",
  "Instrutor(a)": "Coordena as classes que o diretor definir: marca o caderno e as especialidades.",
  "Conselheiro(a)": "Coordena as unidades que o diretor definir: acompanha e atualiza os desbravadores delas.",
};

export const CORES_UNIDADE = ["#F26B1D", "#D93A2B", "#2F7D4F", "#2563A8", "#7B3FA0", "#C99A12", "#0E8C8C", "#6B4A2E"];
