-- Gerado por scripts/build-seed.mjs a partir do MDA Wiki (https://mda.wiki.br)
-- Pode ser rodado mais de uma vez.
begin;

insert into public.classes (id, slug, nome, idade_minima, cor, classe_avancada, url_mda) values
(1, 'amigo', 'Amigo', 10, '#1D5FB4', 'Amigo da Natureza', 'https://mda.wiki.br/Cartão_de_Amigo/'),
(2, 'companheiro', 'Companheiro', 11, '#C8102E', 'Companheiro de Excursionismo', 'https://mda.wiki.br/Cartão_de_Companheiro/'),
(3, 'pesquisador', 'Pesquisador', 12, '#2E7D32', 'Pesquisador de Campo e Bosque', 'https://mda.wiki.br/Cartão_de_Pesquisador/'),
(4, 'pioneiro', 'Pioneiro', 13, '#64748B', 'Pioneiro de Novas Fronteiras', 'https://mda.wiki.br/Cartão_de_Pioneiro/'),
(5, 'excursionista', 'Excursionista', 14, '#7B1E3A', 'Excursionista na Mata', 'https://mda.wiki.br/Cartão_de_Excursionista/'),
(6, 'guia', 'Guia', 15, '#C99A06', 'Guia de Exploração', 'https://mda.wiki.br/Cartão_de_Guia/')
on conflict (id) do update set slug = excluded.slug, nome = excluded.nome, idade_minima = excluded.idade_minima, cor = excluded.cor, classe_avancada = excluded.classe_avancada, url_mda = excluded.url_mda;

insert into public.especialidade_categorias (slug, nome, cor, ordem, url_mda) values
('adra', 'ADRA', '#0F766E', 1, 'https://mda.wiki.br/ADRA/'),
('artes-e-habilidades-manuais', 'Artes e Habilidades Manuais', '#B45309', 2, 'https://mda.wiki.br/Artes_e_Habilidades_Manuais/'),
('atividades-agricolas', 'Atividades Agrícolas', '#4D7C0F', 3, 'https://mda.wiki.br/Atividades_Agrícolas/'),
('atividades-missionarias', 'Atividades Missionárias e Comunitárias', '#1D4ED8', 4, 'https://mda.wiki.br/Atividades_Missionárias_e_Comunitárias/'),
('ensinos-biblicos', 'Ensinos Bíblicos', '#6D28D9', 5, 'https://mda.wiki.br/Atividades_Missionárias_e_Comunitárias_-_Ensinos_Biblicos/'),
('atividades-profissionais', 'Atividades Profissionais', '#334155', 6, 'https://mda.wiki.br/Atividades_Profissionais/'),
('atividades-recreativas', 'Atividades Recreativas', '#DC2626', 7, 'https://mda.wiki.br/Atividades_Recreativas/'),
('ciencia-e-saude', 'Ciência e Saúde', '#0369A1', 8, 'https://mda.wiki.br/Ciência_e_Saúde/'),
('estudos-da-natureza', 'Estudos da Natureza', '#15803D', 9, 'https://mda.wiki.br/Estudos_da_Natureza/'),
('habilidades-domesticas', 'Habilidades Domésticas', '#BE185D', 10, 'https://mda.wiki.br/Habilidades_Domésticas/'),
('mestrados', 'Mestrados', '#A16207', 11, 'https://mda.wiki.br/Mestrados/')
on conflict (slug) do update set nome = excluded.nome, cor = excluded.cor, ordem = excluded.ordem, url_mda = excluded.url_mda;

insert into public.especialidades (codigo, nome, categoria_slug, tipo, nivel, ano, origem, imagem, url_mda, requisitos) values
('AD-001', 'Alívio da Fome', 'adra', 'especialidade', 1, 2005, 'Associação Geral', '/esp/ad-001.webp', 'https://mda.wiki.br/Especialidade_de_Alívio_da_Fome', '1. Ler ou assistir um documentário ou uma matéria jornalística referente ao tema da fome no mundo e discutir com a sua unidade do Clube de Desbravadores as medidas que estão sendo tomados para reduzi-la e apontar como você, desbravador, pode contribuir para esse feito.
2. Entrevistar uma pessoa que realiza distribuição de alimentos em sua comunidade. Pode ser o líder da ASA de sua igreja, de outra igreja, ou de um centro / restaurante comunitário. Perguntar sobre que tipo de pessoas são atendidas, o que as levam a necessitarem de alimento e como essas necessidades estão sendo satisfeitas. Fazer anotações durante a entrevista e compartilhar os resultados com seu instrutor.
3. Descrever as causas da fome em seu país. Você poderá fazer isso através de uma redação (com, pelo menos, 500 palavras), uma apresentação audiovisual (de, pelo menos, 10 minutos), uma encenação ou produzindo um vídeo de cerca de 1 minuto.
4. Fazer uma coleta de itens alimentícios para a ASA da sua igreja, de outra igreja, ou centro/restaurante comunitário ou, se isso não for possível, escolher uma família que precisa de assistência e lhe entregar os itens coletados.
  • Obs.: A sugestão é que sejam arrecadados pelo menos 50 alimentos não perecíveis. Deve-se prestar muita atenção ao prazo de validade dos produtos coletados. Produtos com prazo de validade expirado ou com indício de deterioração, como lata estufada, caruncho nas farinhas e feijões, mofo no arroz, etc., não devem ser coletados. Também devem ser levados em consideração os costumes de cada país ou região. Produtos desconhecidos ou que não fazem parte da alimentação do dia a dia tendem a ser mal utilizados ou não utilizados.
5. Visitar um banco de alimentos, um centro de distribuição de alimentos ou um restaurante ou cozinha comunitária e dispor-se como voluntário para ajudar o pessoal que trabalha no estabelecimento. Conversar com eles para saber como os alimentos são obtidos e quais são alguns dos desafios para consegui-los, armazená-los e distribuí-los. Caso não exista nenhum dos estabelecimentos acima descritos em sua região, planejar e auxiliar a ASA na arrecadação de alimentos.'),
('AD-002', 'Avaliação da Comunidade', 'adra', 'especialidade', 1, 2005, 'Associação Geral', '/esp/ad-002.webp', 'https://mda.wiki.br/Especialidade_de_Avaliação_da_Comunidade', '1. Selecionar uma comunidade ou área urbana com a qual esteja familiarizado e descrever, da melhor forma possível, as seguintes informações:
  a) Localização em um mapa físico ou digital;
  b) Demografia (nº de habitantes, de preferência distribuídos por sexo e idade)
  c) Condições socioeconômicas
  d) Ocupações laborais mais comuns
  e) Acesso à rede educacional e de saúde
  f) Nível de educação
  g) Nível de segurança
  h) Outros dados que achar relevantes
2. Listar as necessidades que você vê em sua comunidade. Isso pode incluir melhor apoio a famílias de baixa renda, assistência a idosos que vivem sozinhos, melhora na limpeza das áreas públicas, etc.
3. Entrevistar um líder comunitário, professor, pastor de igreja ou oficial de polícia para saber como pessoas como você poderiam exercer impacto positivo em tal comunidade ou área. Fazer anotações.
4. Preparar um relatório para o seu Clube de Desbravadores apresentando suas descobertas e descrever o que você aprendeu especificamente a respeito da comunidade ou área que escolheu. Seja criativo.
5. Descrever as melhorias mais importantes necessárias à sua comunidade e o que você pode fazer para ajudar.'),
('AD-003', 'Serviço Comunitário', 'adra', 'especialidade', 1, 2005, 'Associação Geral', '/esp/ad-003.webp', 'https://mda.wiki.br/Especialidade_de_Serviço_Comunitário', '1. Ler os seguintes textos bíblicos e explicar o que eles ensinam a respeito do papel que Deus espera que cada cristão desempenhe para satisfazer as necessidades dos pobres e sofredores na comunidade.
  a) Isaías 58:3-12
  b) Lucas 10: 25-37
  c) Mateus 25:31-46
2. Explique o seguinte ao seu instrutor:
  a) Qual é o significado do acrônimo ADRA? Apresentar uma breve explanação do que cada letra representa e explicar a diferença entre "assistência" e "desenvolvimento".
  b) Qual o nome do serviço social prestado pela Igreja Adventista do Sétimo Dia local que ajuda os pobres e necessitados em seu entorno. Que tipos de serviços ele provê?
3. Reunir-se com o líder da Ação Solidária Adventista em sua área e perguntar a respeito dos projetos que sua unidade ou Clube de Desbravadores pode ajudar para satisfazer às necessidades da comunidade local.
4. Realizar um projeto de serviço comunitário com a unidade ou Clube de Desbravadores e concluí-lo. Este projeto deve focar certas necessidades que sua comunidade apresenta.'),
('AD-004', 'Resposta a Emergências e Desastres', 'adra', 'especialidade', 1, 2005, 'Associação Geral', '/esp/ad-004.webp', 'https://mda.wiki.br/Especialidade_de_Resposta_a_Emergências_e_Desastres', '1. Explicar os tipos de danos mais prováveis de ocorrer às casas, indivíduos e comunidades diante dos principais tipos de emergências e desastres e indicar em qual parte do mundo eles ocorrem com mais frequência. Você pode encontrar estas informações da Defesa Civil do seu Estado.
  a) Ciclones (furacões e tufões)
  b) Tornados
  c) Inundações
  d) Terremotos
  e) Tsunamis
  f) Incêndios
  g) Guerras/conflitos ou guerras civis
2. Descrever os tipos de serviços prestados pela ADRA ou por outros órgãos de resposta a emergências e desastres locais aos sobreviventes de tais eventos em seu país.
3. Ler um jornal ou notícias da ADRA referente a emergências e desastres recentes e discutir quais são algumas coisas importantes a se ter em mente ao responder a uma situação dessas.
4. Explicar o que significa cada letra do acrônimo da ADRA e descreva o papel dela na resposta a emergências e desastres.
5. Descrever, pelo menos, uma destas organizações de resposta a emergências e desastres e como ela pode trabalhar com a ADRA durante tais situações.
  a) Cruz Vermelha/Comitê Internacional da Cruz Vermelha (CICV)
  b) Ação Solidária Adventista (ASA)
  c) Alto Comissário das Nações Unidas para Refugiados ? ACNUR
  d) Programa Alimentar Mundial (PAM)
6. Explicar o papel do governo diante da ocorrência de uma emergência ou desastre e identificar a agência governamental chave em seu país que administra a resposta em tais situações.
7. Descobrir na Bíblia um texto que possa ser usado para confortar e animar uma pessoa que experimentou perda total de sua casa, e dizer-lhe porque você escolheu esse texto?.'),
('AD-005', 'Resposta a Emergências e Desastres - avançado', 'adra', 'especialidade', 2, 2009, 'Associação Geral', '/esp/ad-005.webp', 'https://mda.wiki.br/Especialidade_de_Resposta_a_Emergências_e_Desastres_-_avançado', '1. Ter a especialidade de Resposta a emergências e desastres.
2. Descrever as causas subjacentes de cada um desses cenários de desastres e dar um exemplo recente de, pelo menos, 6 desastres e seu impacto na comunidade ou país. Destacar, pelo menos, um no qual a ADRA respondeu.
  a) Ciclones (furacões e tufões)
  b) Tornados
  c) Enchentes/Inundações
  d) Secas
  e) Tsunamis
  f) Incêndios
  g) Guerras/conflitos ou guerras civis
  h) Erupções vulcânicas.
3. As 4 fases na gestão de emergências e desastres são: Prevenção / Mitigação, Preparo, Resposta e Recuperação. Em suas palavras, descrever para o seu instrutor o que cada um desses termos significa e porque são importantes.
4. O preparo é chave para o sucesso em uma emergência ou desastre. Se você fosse construir um kit para tais circunstâncias, descrever para o seu instrutor quais itens seriam incluídos. Discutir as vantagens de escolher itens movidos à bateria e não à eletricidade, e alimentos não perecíveis em vez de perecíveis.
5. Desenhar a planta do local onde você vive. Pensar no que faria em 3 dos desastres relacionadas no requisito 2. Traçar uma rota de fuga de sua casa e discuti-la com seu instrutor e família.
6. Encontrar 3 histórias na Bíblia que envolveram desastres naturais ou emergências políticas. Colocar-se no lugar das pessoas da história e descrever como esses eventos o afetariam. Discutir como as pessoas nas histórias sobreviveram a essas situações.
7. Apresentar um breve relatório para o seu Clube de Desbravadores a respeito do que você aprendeu sobre emergências e desastres e de estar preparado para agir nessas circunstâncias. Você pode fazer uma apresentação, encenação, mostrar um breve vídeo ou outro método que melhor transmita o que você aprendeu.'),
('AD-006', 'Alfabetização', 'adra', 'especialidade', 2, 2009, 'Associação Geral', '/esp/ad-006.webp', 'https://mda.wiki.br/Especialidade_de_Alfabetização', '1. Definir o termo alfabetização.
2. Quais são as principais diferenças existentes entre alfabetização e letramento?
3. Pesquisar e descrever com brevidade como 2 ou 3 organizações em sua comunidade ou país promovem a alfabetização ou proveem serviços de alfabetização a crianças e adultos.
4. Escrever um parágrafo explicando porque a alfabetização é importante.
5. Realizar 3 das seguintes atividades:
  a) Ajudar alguém a ler um pequeno livro ou uma breve história.
  b) Com um grupo de crianças, ler uma história em grupo, e em seguida resolver as dificuldades de compreensão.
  c) Fazer 10 cartelas de material pedagógico com palavras simples e ilustrações ou fotos e passá-las a alguém que esteja aprendendo a ler.
  d) Ler vários capítulos da Bíblia para uma pessoa idosa que você saiba que é cega ou incapaz de ler. Isso pode ser feito em uma ou várias visitas.
  e) Fazer uma apresentação de 5 minutos em sua escola, igreja ou Clube, sobre o que você aprendeu sobre alfabetização.
6. Escolher 3 palavras e explicar ao seu instrutor como você ensinaria alguém sobre o significado das palavras e como soletrá-las.'),
('AD-007', 'Resolução de Conflitos', 'adra', 'especialidade', 3, 2009, 'Associação Geral', '/esp/ad-007.webp', 'https://mda.wiki.br/Especialidade_de_Resolução_de_Conflitos', '1. O que é um conflito? Citar um exemplo de conflito em cada uma das seguintes configurações:
  a) Uma família
  b) Grupo de amigos
  c) Escola
  d) Entre bairros e comunidades
  e) Países
2. O que é resolução de conflitos?
3. Conversar com o seu instrutor ou conselheiro sobre 4 causas prováveis que podem levar a conflitos na escola ou no ambiente de trabalho.
4. Procurar informação sobre formas alternativas de resolução de conflitos: negociação, mediação, conciliação e arbitragem. Explique com suas próprias palavras cada conceito e dar um exemplo da cada alternativa.
5. Explicar em que consiste a dramatização como uma dinâmica útil na resolução de conflitos e quais podem ser seus benefícios. Dar um exemplo e representá-lo com sua unidade.
6. O que significa ouvir atentamente?
7. Aplicar o seguinte método de resolução de conflito em um exemplo do item número 1.
  a) Montar o cenário
  b) Reunir informações
  c) Identificar o problema
  d) Pensar nas soluções
  e) Negociar uma solução
8. Explicar como fazer encaminhamento a um conselheiro profissional ou pastor.
9. Que atitude Jesus recomenda em Mateus 18:15 para resolver um conflito entre seus seguidores?
  a) Qual papel de Jesus Cristo no conflito entre o bem e o mal de acordo com I Timóteo 2:5 e 6?
  b) Mencionar outro personagem bíblico que foi mediador entre autoridades e seu povo.'),
('AD-008', 'Reassentamento de Refugiados', 'adra', 'especialidade', 2, 2009, 'Associação Geral', '/esp/ad-008.webp', 'https://mda.wiki.br/Especialidade_de_Reassentamento_de_Refugiados', '1. Descrever algumas causas gerais porque as pessoas se deslocam para outros países como refugiados. Definir também os termos refugiado, deslocado interno e imigrante.
2. Listar as necessidades imediatas que um refugiado pode ter quando chega a um novo país. Descrever como você se sentiria se, subitamente, tivesse que enfrentar uma nova língua, cultura e ambiente.
3. Descobrir que organizações em sua comunidade, país ou no mundo ajudam os refugiados e deslocados internos. Pesquisar sobre o trabalho que eles realizam.
4. Descrever em poucas palavras como você poderia ajudar um refugiado ou um deslocado interno em sua comunidade.
5. Perguntar a uma pessoa de outro país, que vive em sua comunidade, como ela se ajustou ao novo ambiente. Pedir para que descreva os desafios e contrastes que experimentou durante o processo de adaptação à comunidade.
6. Fazer um breve relatório para o seu Clube de Desbravadores, igreja, escola sobre o que você aprendeu sobre refugiados e deslocados internos e que desafios eles enfrentam. Você pode levar a efeito este requisito através de uma apresentação audiovisual, encenação, vídeo ou qualquer outra forma que melhor transmita suas descobertas. Discutir porque é importante estar atento à situação dos refugiados e tentar encontrar soluções para esse problema.
7. Encontrar um refugiado e/ou deslocado interno e auxiliá-lo em parceria com a ASA local. Coloque foto e a descrição do auxílio prestado.'),
('AD-009', 'Desenvolvimento Comunitário', 'adra', 'especialidade', 1, 2009, 'Associação Geral', '/esp/ad-009.webp', 'https://mda.wiki.br/Especialidade_de_Desenvolvimento_Comunitário', '1. Definir desenvolvimento comunitário.
2. Explicar ao seu instrutor porque alguns países são considerados desenvolvidos enquanto outros são chamados de países em desenvolvimento.
3. Mencionar 5 países em desenvolvimento e listar 3 ações que a ADRA realiza neles e que poderiam ser consideradas ações de desenvolvimento e 2 que se caracterizam como ações assistenciais.
4. Ler a respeito de porque existem pobres entre nós no livro O Libertador ou Deseja de Todas as Nações, de Ellen G. White, capítulo 70 - "Cristo se identifica com os pobres e sofredores". Descrever ao seu instrutor o que você aprendeu.
5. Descrever, pelo menos, uma necessidade em seu bairro ou município que requeira atenção.
6. Escrever um breve plano de desenvolvimento comunitário que pode ser implementado por seu Clube de Desbravadores (plantio de árvores, limpeza de parques e ruas, pintura de muros, etc.). O plano deve descrever a atividade, o tamanho do grupo, a logística de transporte e materiais e o tempo para completar tal atividade.
7. Participar por, pelo menos, 4 horas em uma das seguintes atividades:
  a) O desbravador deverá contatar a Ação Solidária Adventista (ASA) de sua igreja e ver em que poderá ajudar. Talvez seja organizando itens doados ou participando de algum projeto por ela já estabelecido. Poderá envolver-se com a coleta e distribuição de alimentos, cobertores, agasalhos, sapatos e outros bens para moradores de rua ou para famílias cadastradas pela ASA. Ainda, poderá apoiar na reparação ou construção de casas para pessoas carentes.
  b) O desbravador deverá contatar a ADRA para ver a possibilidade de envolver-se como voluntário em algum projeto que esteja sendo implementado no seu bairro ou município.
  c) O desbravador deverá envolver-se com um "Mutirão Social". O alvo deste tipo de mutirão é proporcionar à população menos favorecida acesso a certos serviços de forma gratuita. Alguns destes serviços são: corte de cabelo, testes rápidos para identificar doenças como sífilis, hepatite e AIDS, aferição de pressão arterial, orientações de saúde e nutrição, palestras educativas sobre como economizar energia e gás, recreação infantil, emissão de documento como carteira de trabalho, encaminhamento para vagas de empregos, entre outros. O mutirão pode ser feito no pátio da igreja, num centro comunitário, num ginásio de esportes ou outro local sugerido e autorizado pelas autoridades locais.
  d) O desbravador deverá procurar saber o que sua igreja, outras igrejas, o governo ou organizações comunitárias estão fazendo pelos moradores de rua. Caso a comunidade já tenha esse programa, você poderá unir-se a ele.'),
('HM-001', 'Automodelismo', 'artes-e-habilidades-manuais', 'especialidade', 2, 1928, 'Associação Geral', '/esp/hm-001.webp', 'https://mda.wiki.br/Especialidade_de_Automodelismo', '1. Construir, pelo menos, um modelo de carro de plástico, a partir de um kit. O carro deve seguir, tanto quanto possível, o padrão original.
2. Escolha um:
  a) Construir um segundo modelo usando acessórios opcionais incluídos no kit, ou criar alterações usando massa de vidraceiro e/ou partes de outros kits. (Decalques não contam). Pintar o modelo
  b) Construir um modelo de corrida de acordo com as normas do Campeonato de Automodelismo e participar de uma corrida.
3. Escrever ou apresentar oralmente a história do automóvel. Não deixar de incluir passos interessantes no processo de desenvolvimento, como , por exemplo, tamanhos dos motores, transmissão automática, volantes, controles computadorizados, etc.
4. Mencionar 3 tipos diferentes de propulsão usados nos modelos de carros que estão à venda.'),
('HM-002', 'Trabalhos com Agulha', 'artes-e-habilidades-manuais', 'especialidade', 2, 1928, 'Associação Geral', '/esp/hm-002.webp', 'https://mda.wiki.br/Especialidade_de_Trabalhos_com_Agulha', '1. Apresentar artigos que tenham sido feitos por você usando os pontos a seguir:
  a) Ponto contorno
  b) Ponto margarida
  c) Ponto corrente (correntinha ou ponto cadeia)
  d) Ponto-cruz
  e) Bordado richelieu
  f) Ponto cheio
  g) Chuleio (chuleado)
  h) Nó francês
  i) Ponto caseado
  j) Ponto pena
  k) Ponto atrás
  l) Ponto espinha de peixe ou ponto folha
  m) Ponto matiz
  n) Ponto vagonite
2. Fazer duas das seguintes atividades:
  a) Bordar um dos itens a seguir: par de fronhas, pano de prato, ou outro artigo equivalente.
  b) Fazer uma capa de almofada
  c) Bordar um jogo de cozinha
  d) Fazer uma toalha ou caminho de mesa
  e) Fazer um artigo usando qualquer um dos métodos a seguir:
    • Patchwork
    • Franzido casa de abelha
    • Richelieu
    • Ponto russo
3. Quais são os tipos de renda mais comuns em sua região e quais os cuidados de conservação de cada uma delas?
4. Descrever um método satisfatório de manter seus utensílios para bordar em boas condições.
5. Explicar quais são os cuidados necessários com as peças bordadas em relação à limpeza e conservação.
6. Quais são os tipos de tecido mais adequados para se fazer os seguintes trabalhos:
  a) Bordado richelieu
  b) Franzido casa de abelha
  c) Patchwork
  d) Ponto russo
  e) Ponto cruz
  f) Ponto vagonite
  g) Ponto matiz
7. Demonstrar como engomar e passar corretamente um artigo bordado.'),
('HM-003', 'Desenho e Pintura', 'artes-e-habilidades-manuais', 'especialidade', 2, 1929, 'Associação Geral', '/esp/hm-003.webp', 'https://mda.wiki.br/Especialidade_de_Desenho_e_Pintura', '1. Fazer e apresentar um desenho à mão de um animal, demonstrando a distribuição equilibrada das cores.
2. Desenhar um objeto cilíndrico e outro retangular juntos, demonstrando perspectiva e equilíbrio de luz e sombras.
3. Preparar e apresentar um desenho de alguma paisagem da natureza que haja perto de sua casa ou que você ache interessante.
4. Fazer, em cores, um desenho decorativo, usando qualquer técnica e motivo. Mencionar o uso que pretende dar para ele.
5. Pintar um "tapete" de flores, ou de folhas, caídas no chão demonstrando riqueza de cores e detalhes.
6. Pintar uma cena ao ar livre em aquarela ou óleo.
7. Fazer um desenho ou pintura a sua escolha usando a técnica de pontilhismo ou hachura.
8. Organizar uma exposição dos trabalhos feitos no decorrer desta especialidade no Clube, Escola ou Igreja. Convidar os pais e apoiadores do Clube e presenteá-los com algum dos desenhos produzidos.'),
('HM-004', 'Música - básico', 'artes-e-habilidades-manuais', 'especialidade', 2, 1929, 'Associação Geral', '/esp/hm-004.webp', 'https://mda.wiki.br/Especialidade_de_Música_-_básico', '1. Qual a definição básica de música?
2. Explicar o que é harmonia, melodia e ritmo.
3. O que é Clave? Escrever uma escala completa (de Dó a Dó, por exemplo) nas claves de Sol, Fá e Dó.
4. Definir o que é timbre, altura, duração e intensidade de um som.
5. Saber o que significa a palavra "Intervalo" na música. Explicar o seguinte:
  a) Um intervalo de meio tom
  b) Um intervalo de um tom
  c) Um intervalo de uma terça
  d) Um intervalo de uma quinta
  e) Um intervalo de uma oitava
6. Conhecer os tons e semitons naturais. Com auxílio de uma partitura, ser capaz de reconhecer as notas de um verso ou coro de um hino da sua Igreja.
7. Definir o que é uma orquestra e citar, pelo menos, 2 instrumentos de cada classe de instrumentos usados em uma orquestra (Cordas, madeiras, metais, percussão e teclas).
8. Tocar ou cantar, com ou sem auxílio de partitura, um hino de sua igreja ou música sacra e apresentar satisfatoriamente para um grupo de pessoas.
9. Fazer um resumo bibliográfico de um famoso compositor de hinos e apresente em forma de palestra para um grupo de pessoas.'),
('HM-005', 'Música - intermediário', 'artes-e-habilidades-manuais', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/hm-005.webp', 'https://mda.wiki.br/Especialidade_de_Música_-_intermediário', '1. Ter a especialidade de Música - básico.
2. Tocar ou cantar um escala e citar todas as notas de sua composição.
3. O que é Semibreve? Mínima? Colcheia? Desenhar cada um dos símbolos.
4. Saber a diferença entre música sacra e secular e citar um grande compositor musical de cada tipo de música.
5. Saber o que é o compasso de uma música. Ser capaz de diferenciar uma marcha de uma valsa e dar o compasso de cada uma delas.
6. Citar 5 grandes compositores de música erudita e, pelo menos, uma composição de cada um deles, incluindo um Oratório, uma peça para piano e uma canção.
7. Tocar, com ou sem ajuda de um livro de partitura, ou cantar de memória 10 hinos ou corinhos de sua igreja, pelo menos, um verso ou estrofe e listar o compositor de cada um deles.
8. Tocar ou cantar de memória uma peça musical de qualidade, diferente das que foram apresentadas no requisito 7 e apresentá-la para um grupo de pessoas.
9. Saber a função do maestro de uma orquestra e compreender o significado dos principais gestos que ele faz, ou com uma batuta, ou com as mãos.
10. Ser capaz de ensinar um grupo pequeno de pessoas a tocar ou cantar um hino ou coro da sua igreja, com ou sem auxílio de partitura, e apresentar satisfatoriamente para um grupo de pessoas.'),
('HM-006', 'Música - avançado', 'artes-e-habilidades-manuais', 'especialidade', 3, null, null, '/esp/hm-006.webp', 'https://mda.wiki.br/Especialidade_de_Música_-_avançado', '1. Ter a especialidade de Música - intermediário.
2. Estudar a biografia de um compositor do Hinário Adventista à sua escolha. Dizer como se deu o início de sua vida musical, quais oportunidades teve, onde estudou música, qual instrumento dominava, principais obras, o que faz atualmente ou como foi sua morte.
3. Cumprir um dos itens abaixo:
  a) Para instrumentistas: com auxílio de uma partitura, tocar um trecho de música moderadamente difícil e saber todos os símbolos e termos contidos na partitura deste trecho.
  b) Para cantores: Demonstrar, usando uma batuta ou as mãos, como liderar um coral para interpretar, pelo menos, uma composição em 3/4 e uma em 4/4.
4. Ser capaz de tocar ou cantar, com ou sem auxílio de partitura, qualquer hino aleatoriamente a partir do hinário ou de algum livro de corinhos de sua igreja.'),
('HM-007', 'Letreiros e Cartazes', 'artes-e-habilidades-manuais', 'especialidade', 2, 1933, 'Associação Geral', '/esp/hm-007.webp', 'https://mda.wiki.br/Especialidade_de_Letreiros_e_Cartazes', '1. Escrever de memória o alfabeto completo, maiúsculas e minúsculas, de 2 dos seguintes tipos de fontes:
  a) Gótico
  b) Times New Roman
  c) Itálico
  d) Arial
  e) Calibri
  f) Verdana
2. Demonstrar os diferentes tipos de tamanhos de letras e canetas a serem utilizadas ao se fazer um cartaz.
3. Citar, pelo menos, 4 princípios básicos ao se fazer um cartaz atraente e diversificado.
4. Fazer, pelo menos, 3 cartazes para um departamento da igreja, demonstrando a variedade de tamanho das fontes a serem utilizadas.
5. Fazer 8 cartazes que representem os pontos da lei do desbravador, onde os mesmos serão avaliados de acordo com os seguintes critérios: capricho, criatividade e tipos de letra usados.
6. Praticar com precisão, todas as letras do nosso alfabeto até demonstrar um domínio da mesma.'),
('HM-008', 'Cestaria', 'artes-e-habilidades-manuais', 'especialidade', 2, 1937, 'Associação Geral', '/esp/hm-008.webp', 'https://mda.wiki.br/Especialidade_de_Cestaria', '1. Explicar como tratar o junco antes do trançamento.
2. Conhecer outros tipos de fibras vegetais que podem ser usadas na cestaria e que são comuns em sua região.
3. Que ferramentas você usaria para:
  a) Fazer cestas de junco?
  b) Fazer cestas de raffia?
4. Definir:
  a) Trançamento chamuscado
  b) Achatamento
5. Explicar como:
  a) Consertar uma estaca quebrada da roda de trançar
  b) Emendar o junco.
6. Citar 2 tipos de bases usadas em cestas e especificar em qual tipo de cesta cada base pode ser usada.
7. Descrever como fazer:
  a) Um trançamento duplo
  b) Uma tripla guarnição de raios
8. Fazer uma bandeja para lanches, com base de madeira.
9. Fazer algum objeto simples com base trançada.
10. Fazer um descanso de panelas redondo, de 15 centímetros de diâmetro, de Raffia ou similar.'),
('HM-009', 'Trabalhos em Metal', 'artes-e-habilidades-manuais', 'especialidade', 2, 1937, 'Associação Geral', '/esp/hm-009.webp', 'https://mda.wiki.br/Especialidade_de_Trabalhos_em_Metal', '1. Conhecer, pelo menos, 3 tipos de metais que são utilizados em trabalhos com metal.
2. Realizar um trabalho em metal utilizando as ferramentas apropriadas para o trabalho e escolhendo um dos acabamentos finais:
  a) Envelhecimento
  b) Repuxado ou cinzelado
3. Completar um projeto usando um perfurador de metal.
4. Completar um projeto usando perfuração, rebitagem e dobra de metal.
5. Demonstrar capacidade de usar corretamente os seguintes equipamentos com segurança:
  a) Esquadro
  b) Serra de joalheiro
  c) Martelo de bola
  d) Rebitadeira
  e) Morsa ou mini torno
  f) Suta
  g) Riscador e punção de bico
  h) Alicates de ponta redonda,chata e universal
  i) Tesoura de cortar metal
  j) Escopro
  k) Serrinha
  l) Cinzéis
  m) Lima
  n) Furadeira
6. Quais são os EPIs (equipamentos de proteção individual) necessários para se trabalhar com metais?
7. Fazer um dos seguintes projetos em metal:
  a) Peso de papel
  b) Ponta de Flecha
  c) Estaca/espeque para barraca
  d) Castiçal
  e) Cabide simples'),
('HM-010', 'Arte de Oleiro', 'artes-e-habilidades-manuais', 'especialidade', 2, 1938, 'Associação Geral', '/esp/hm-010.webp', 'https://mda.wiki.br/Especialidade_de_Arte_de_Oleiro', '1. Escrever ou explicar oralmente os diferentes tipos e usos da arte em louça e dos materiais usados em sua confecção.
2. Qual é o propósito de um vitrificado? Descreva os perigos específicos a serem evitados.
3. Projetar e desenhar 2 louças de barro, uma das quais deve ser decorada.
4. Fazer 3 dos objetos a seguir. Cada projeto deve ser decorado com, por exemplo, pintura, vitrificado ou entalhe.
  a) Um jarro ou vaso.
  b) Uma caixa.
  c) Outro objeto semelhante.
  d) Desenhar e fabricar quatro azulejos diferentes.
  e) Uma bandeja ou prato.
  f) Na roda do oleiro, fazer um vaso simples.'),
('HM-011', 'Entalhe em Madeira', 'artes-e-habilidades-manuais', 'especialidade', 2, 1938, 'Associação Geral', '/esp/hm-011.webp', 'https://mda.wiki.br/Especialidade_de_Entalhe_em_Madeira', '1. Explicar as características das madeiras de coníferas e folhosas. Fazer uma lista com, ao menos, 5 tipos de madeira ideais para trabalhos de entalhe.
2. Descrever os diferentes instrumentos usados no entalhe de madeira e explicar como afiá-los e quais os cuidados necessários ao usar os mesmos.
3. Explicar os melhores métodos de lidar com a fibra da madeira.
4. Desenhar e entalhar uma placa em baixo-relevo com o nome de seu clube ou unidade.
5. Desenhar e entalhar dois dos itens a seguir:
  a) Uma bandeja
  b) Suporte de livros
  c) Um arganéu para lenço
  d) Abridor de cartas
  e) Outro item equivalente de sua escolha'),
('HM-012', 'Ornamentação com Flores', 'artes-e-habilidades-manuais', 'especialidade', 2, 1938, 'Associação Geral', '/esp/hm-012.webp', 'https://mda.wiki.br/Especialidade_de_Ornamentação_com_Flores', '1. Citar o nome de seis espécies de flores perenes e seis de floração anual que sejam apropriadas para a ornamentação interna.
2. Citar o nome de, pelo menos três espécies que florescem na primavera ou no início do verão, que sejam apropriadas para ornamentação interna.
3. Citar o nome de, no mínimo, três flores que não se conservam bem após cortadas, e três que se conservam bem após o corte.
4. Apresentar seis sugestões para o corte de flores e cuidados após o corte, bem como quando cortar, como cortar e como mantê-las.
5. Em que estágio de seu desenvolvimento deve-se cortar as rosas, palmas e dálias?
6. Apresentar três sugestões sobre a relação dos recipientes com as flores usadas e três sobre a relação do arranjo de flores com a sala e os móveis da mesma.
7. Na ornamentação com flores, qual deveria ser a relação entre as cores mais escuras e mais claras, flores maiores e menores, abertas ou parcialmente abertas?
8. Fazer dois arranjos de flores para cada uma das áreas a seguir:
  • decoração de mesa
  • uso geral da casa
  • local público
9. Quais são algumas das flores silvestres que podem ser usadas na ornamentação de uma casa?'),
('HM-013', 'Pintura em Vidro', 'artes-e-habilidades-manuais', 'especialidade', 1, 1938, 'Associação Geral', '/esp/hm-013.webp', 'https://mda.wiki.br/Especialidade_de_Pintura_em_Vidro', '1. Listar e descrever, no mínimo, 3 técnicas distintas de pintura em vidro.
2. Listar, ao menos, 3 tipos de tintas que podem ser usadas para pintura em vidro.
3. Conhecer as cores primárias e as secundárias; saber como misturar as cores primárias para obter as cores secundárias.
4. Conhecer o material usado para pintar, montar e pendurar os vidros pintados.
5. Qual a importância de fazer uma boa limpeza e secagem do vidro antes de iniciar alguma técnica de pintura?
6. Explicar como é feita a técnica de transparência utilizada na pintura em vidro.
7. Fazer uma pintura a mão livre, num espelho.
8. Fazer e expor uma pintura em vidro para cada um dos temas a seguir:
  a) Animal
  b) Flor
  c) Paisagem
9. Completar pinturas em vidro utilizando 2 dos seguintes:
  a) Serigrafia
  b) Rolo e Pincel
  c) Mosaico'),
('HM-014', 'Tecelagem', 'artes-e-habilidades-manuais', 'especialidade', 2, 1938, 'Associação Geral', '/esp/hm-014.webp', 'https://mda.wiki.br/Especialidade_de_Tecelagem', '1. Definir o que é tecelagem. Qual a origem dessa antiga forma de artesanato?
2. Descrever e exemplificar os processos de preparação básicos para a tecelagem.
3. Citar, pelo menos, 3 matérias-primas que são muito usadas para a tecelagem.
4. Definir os seguintes termos:
  a) Teia ou Urdume
  b) Trama
  c) Lançadeira de tear
  d) Cilindro do tear
  e) Tear de pente liço (Fios que guiam o Urdume)
  f) Cilindro para Tecido
5. Por quais outros nomes o Urdume pode ser chamado?
6. O que é urdidura direta? Que processos e equipamentos são necessários para a sua realização?
7. Desenhar, pelo menos, 3 estruturas diferentes de tecidos, demonstrando como acontece o entrelaçamento do urdume com a trama.
8. Fazer um tear à mão em um papelão e em seguida desenvolver uma bolsa simples.
9. Desenhar e tecer uma toalha de mesa, utilizando, pelo menos, 3 cores diferentes.
10. Fazer um pegador de panela com alça.'),
('HM-015', 'Trabalhos em Madeira', 'artes-e-habilidades-manuais', 'especialidade', 2, 1938, 'Associação Geral', '/esp/hm-015.webp', 'https://mda.wiki.br/Especialidade_de_Trabalhos_em_Madeira', '1. Identificar, pelo menos, 5 tipos comuns de madeira, tais como: pinho, peroba, mogno, maçaranduba e jacarandá.
2. Conhecer as características das madeiras identificadas e conhecer, ao menos, uma utilidade para cada exemplo dado.
3. Quais as diferenças entre coníferas e folhosas? Essa classificação indica que espécies são melhores para trabalhos em madeira? Justifique sua resposta.
4. Saber como usar adequadamente as seguintes ferramentas em trabalhos com madeira:
  a) Serra tico-tico
  b) Lima ou grosa
  c) Plaina
  d) Faca
  e) Talhadeira/formão
  f) Lixas
  g) Serra
  h) Martelo
  i) Furadeira
5. Conhecer, pelo menos, 2 procedimentos de segurança para cada uma das ferramentas acima.
6. Conhecer uma técnica de pintura e envernizamento de madeira.
7. Cortar, montar e dar acabamento em um suporte de livros ou peso para portas.
8. Entalhar e terminar uma estaca de jardim ou uma placa para o gramado, dando alguma forma, tal como de uma criança, pássaro, flor ou árvore.
9. Fazer uma placa, uma bandeja, ou algum outro objeto útil em que a madeira é usada.'),
('HM-016', 'Aeromodelismo', 'artes-e-habilidades-manuais', 'especialidade', 2, 1944, 'Associação Geral', '/esp/hm-016.webp', 'https://mda.wiki.br/Especialidade_de_Aeromodelismo', '1. A partir de um kit, montar e fazer voar com sucesso um aeroplano de madeira leve, papel de seda e borracha ou outro material movido à gasolina.
2. Montar um planador a partir de um kit, observar suas características de voo e sua relação com as posições variáveis das asas.
3. Montar e fazer voar, com sucesso, dois diferentes estilos de aeroplanos usando folhas de papel entre 20 e 35 centímetros de comprimento e largura.
4. Definir, localizar e explicar o uso dos seguintes itens básicos:
  a) Fuselagem
  b) Asa
  c) Leme
  d) Estabilizador horizontal
  e) Tirante
  f) Cockpit
  g) Motor
  h) Trem de pouso
  i) Hélice'),
('HM-017', 'Cultura Indígena', 'artes-e-habilidades-manuais', 'especialidade', 2, 1944, 'Divisão Norte Americana', '/esp/hm-017.webp', 'https://mda.wiki.br/Especialidade_de_Cultura_Indígena', '1. Porque os povos originários das Américas foram chamados de indígenas pelos europeus?
2. Listar 5 utensílios domésticos e/ou peças de vestuários produzidos pelos indígenas de sua região, utilizando materiais naturais. Fazer um destes itens e demonstrar o uso para a seu instrutor.
3. Listar 15 alimentos ou pratos típicos introduzidos na cultura gastronômica de seus país.
4. Citar 5 hábitos culturais da atualidade em seu país herdados dos indígenas.
5. Listar 10 palavras de origem indígena incorporadas a língua oficial de seu país.
6. Relacionar 5 lugares(estados, cidades, etc.) em seu país que possuem nome indígena e dizer o significado de cada um deles.
7. Conhecer 5 rochas e/ou minerais e explicar como eram usados pelos povos indígenas.
8. Explicar como, e com quais materiais, os indígenas produziam seus arcos e flechas.
9. Listar 5 pratos da culinária indígena feitos com mandioca. Apresentar as receitas e demonstrar habilidade no preparo de, ao menos, 2 desses pratos.
10. O que são pinturas rupestres indígenas? E qual o lugar mais próximo onde podem ser encontradas?
11. Listar, ao menos, 10 materiais utilizados como matéria-prima pelos indígenas nativos de seu país na confecção de peças de artesanato e indicar o tipo de peça produzida com cada material citado.
12. Fazer uma peça de artesanato usando alguns materiais mencionados no requisito anterior.'),
('HM-018', 'Escultura', 'artes-e-habilidades-manuais', 'especialidade', 2, 1945, 'Associação Geral', '/esp/hm-018.webp', 'https://mda.wiki.br/Especialidade_de_Escultura', '1. Relacionar as ferramentas e materiais usados em esculturas simples.
2. Modelar dois ou mais exemplos de animais de brinquedos, empregando uma das técnicas de escultura em materiais como: argila, massa plástica, etc.
3. Fazer um modelo da mão ou pé humano usando uma das técnicas de escultura.
4. A partir de um modelo vivo, fazer uma escultura em relevo da cabeça, empregando uma das técnicas de escultura (Não precisa ser em tamanho natural).
5. Conhecer 5 técnicas para trabalhar diferentes materiais usados para fazer esculturas (madeira, mármore, pedra, bronze, gesso, etc), mencionando algumas ferramentas utilizadas em cada técnica.
6. Conhecer, por meio de fotografias, 10 esculturas famosas
7. Fazer uma exposição dos itens produzidos nesta especialidade em um evento de seu clube, igreja ou Campo.'),
('HM-019', 'Xilogravura', 'artes-e-habilidades-manuais', 'especialidade', 2, 1945, 'Associação Geral', '/esp/hm-019.webp', 'https://mda.wiki.br/Especialidade_de_Xilogravura', '1. Definir o que é xilogravura e onde surgiu essa arte contemporânea.
2. Explicar os princípios básicos da preparação de um desenho e leitura aplicada em uma xilogravura.
3. Fazer uma lista de ferramentas e equipamentos necessários para uma xilogravura.
4. Explicar a diferencia entre desenho e matriz. Que tipos de papeis são mais recomendados para a realização de uma xilogravura?
5. Identificar as ferramentas e materiais que podem ser usados para confeccionar uma matriz. Que preparos e cuidados devem ser tomados com o manuseio da mesma?
6. Como as modalidades de uma xilogravura são classificadas?
7. Que tintas são mais adequadas para uma boa impressão em xilogravura?
8. Pesquisar um tipo de arte ou literatura em que tenha sido utilizada e/ou propagada a xilogravura. Mencionar o local, período e importância histórica.
9. Usando as técnicas da Xilogravura (desenhar, esculpir e imprimir), fazer, pelo menos:
  a) Um cartão de saudação
  b) Uma capa de um livro
  c) Um objeto de livre escolha diferente dos anteriores'),
('HM-020', 'Cerâmica', 'artes-e-habilidades-manuais', 'especialidade', 2, 1956, 'Associação Geral', '/esp/hm-020.webp', 'https://mda.wiki.br/Especialidade_de_Cerâmica', '1. Definir o que é cerâmica e qual a sua origem. Dizer como ela pode ser classificada.
2. Descrever os seguintes termos:
  a) Cerâmica verde
  b) Esmalte
  c) Decalcar
  d) Forno
  e) Vitrificação
  f) Torneamento
  g) Colagem ou Fundição
3. Qual a diferença entre a cerâmica tradicional e a cerâmica avançada? Citar exemplos de cada uma delas.
4. Citar, pelo menos, 2 métodos mais comuns que são utilizados na formação da cerâmica.
5. Descrever o processo de tratamento do barro ou argila. Explicar como evitar que apareçam bolhas durante o cozimento de uma peça.
6. Explicar como são utilizados os cones nos fornos industriais.
7. Saber como e quando utilizar o processo de vitrificação.
8. Citar algumas ferramentas que podem ser usadas para os trabalhos em cerâmica.
9. Através do processo de fabricação da cerâmica, tirar alguma lição espiritual considerando o barro com o ser humano e Deus como o oleiro.
10. Fazer um objeto de sua escolha usando o processo de vitrificação.
11. Fazer 2 dos seguintes itens onde, pelo menos, um seja feito através do processo de vitrificação:
  a) Pote de biscoitos
  b) Vaso de flores
  c) Jarro
  d) Copo ou caneca
  e) Uma bandeja de frutas
  f) Travessa de porcelana
  g) Objeto de sua escolha'),
('HM-021', 'Pintura em Tecido', 'artes-e-habilidades-manuais', 'especialidade', 2, 1956, 'Associação Geral', '/esp/hm-021.webp', 'https://mda.wiki.br/Especialidade_de_Pintura_em_Tecido', '1. Listar os materiais utilizados para pintura em tecido.
2. Saber como preparar o material para a pintura.
3. Quais as vantagens e desvantagens dos diferentes tipos de cerdas de pinceis? E quais os tipos recomendáveis para a pintura em tecido?
4. Citar os diferentes usos dos diferentes tamanhos de pinceis.
5. Saber como misturar a tinta e limpar e armazenar os pincéis após terem sido usados.
6. Quanto tempo deve-se esperar para que a tintura seque?
7. Como deve ser feita a conservação e o armazenamento de uma peça pintada?
8. Saber como traçar e transferir uma figura para o tecido.
9. Demonstrar a centralização da estampa no tecido.
10. O que é um molde vazado ou estêncil?
11. Quais as diferenças entre as técnicas para pintura à mão livre e com molde vazado?
12. O que é necessário para fazer um molde vazado em casa?
13. Fazer um molde vazado a partir de uma figura de sua escolha.
14. Pintar uma estampa de 3 frutas (para aprender a realçar luz e sombras); 2 flores (para desenvolver um bom sombreado); e 1 animal detalhado (para aprender o uso do pincel fino).
15. Usando um estêncil, pintar algum objeto com, pelo menos, 2 cores.'),
('HM-022', 'Trabalhos em Feltro', 'artes-e-habilidades-manuais', 'especialidade', 1, 1956, 'Associação Geral', '/esp/hm-022.webp', 'https://mda.wiki.br/Especialidade_de_Trabalhos_em_Feltro', '1. A partir de que fibra é feito o feltro? O que lhe dá sua força elástica?
2. Mencionar 7 utilidades do feltro.
3. Apresentar 3 razões porque o feltro é um bom material para artesanato.
4. Mencionar os passos essenciais na fabricação do feltro.
5. Fazer 2 itens a seguir, usando, pelo menos, 3 cores diferentes de feltro:
  a) Figura para a Escola Sabatina
  b) Marca páginas
  c) Almofadas de alfinetes
  d) Bandeirola
  e) Imã de geladeira
6. Fazer 2 dos itens a seguir:
  a) Pequeno mural de parede
  b) Decoração temática para uma data especial
  c) Fantoche
  d) Pegadores de cozinha e descansos de panelas
7. Costurar, em feltro, as seguintes peças:
  a) Animal com enchimento
  b) Boneco ou outro brinquedo com enchimento
  c) Sacola'),
('HM-023', 'Trabalhos em Acrílico', 'artes-e-habilidades-manuais', 'especialidade', 2, 1961, 'Associação Geral', '/esp/hm-023.webp', 'https://mda.wiki.br/Especialidade_de_Trabalhos_em_Acrílico', '1. Fazer uma lista do material e equipamentos necessários para fazer pequenas peças de acrílico fundidas em moldes plásticos.
2. Saber como limpar e cuidar adequadamente dos moldes de plástico.
3. Que precauções de segurança devem ser tomadas ao trabalhar com acrílico?
4. Explicar como misturar resina para:
  a) Fundir
  b) Fazer camada colorida
5. Qual a finalidade dos seguintes materiais?
  a) Catalisador
  b) Temperador de superfície
  c) Pigmentos
6. O que significa polimerização?
7. Fazer 3 peças fundidas com, pelo menos, um item incrustado em cada uma delas.
8. Preparar e incrustar 2 itens da natureza que sejam apropriados para esta técnica. Os itens da natureza podem ser incrustados numa peça fundida ou mais.'),
('HM-024', 'Modelagem e Fabricação de Sabão', 'artes-e-habilidades-manuais', 'especialidade', 1, 1964, 'Associação Geral', '/esp/hm-024.webp', 'https://mda.wiki.br/Especialidade_de_Modelagem_e_Fabricação_de_Sabão', '1. Quais são os componentes básicos usados para se fazer sabão?
2. Qual é a diferença entre o sabão e o detergente?
3. O que causa a ação limpadora do sabão?
4. Mencionar 7 tipos de sabão. Explicar as vantagens e desvantagens de cada um deles.
5. O que é a espuma? Por que não necessariamente a quantidade de espuma determina a ação limpadora do sabão ou detergente?
6. Esculpir um objeto numa barra de sabão ou sabonete.
7. Decorar um sabonete para dar de presente.
8. Ser capaz de produzir um tipo de sabão (em pó, liquido ou em barra)'),
('HM-025', 'Modelagem e Fabricação de Sabão - avançado', 'artes-e-habilidades-manuais', 'especialidade', 2, 1964, 'Associação Geral', '/esp/hm-025.webp', 'https://mda.wiki.br/Especialidade_de_Modelagem_e_Fabricação_de_Sabão_-_avançado', '1. Ter a especialidade de Modelagem e fabricação de sabão.
2. Que tipos de gorduras e/ou óleos podem ser usadas para fazer sabão?
3. O que deve ser modificado na fórmula do sabão para que ele fique:
  a) Transparente
  b) Tão leve que boie na água
  c) Mais duro
4. Aprender e explicar os seguintes versos bíblicos: Jeremias 2:22; Malaquias 3:2.
5. Listar 4 técnicas diferentes de fazer sabão. Fazer uma medida de sabão usando 2 destas técnicas.
6. Fazer uma lista dos utensílios necessários para o cumprimento do requisito anterior.
7. Quais são os cuidados necessários durante a fabricação do sabão?
8. Cumprir um dos requisitos a seguir:
  a) Visitar uma fábrica de sabão.
  b) Obter informações de uma fábrica de sabão, sobre como o mesmo é feito.
  c) Fazer um relatório de, no mínimo, 2 páginas explicando o processo de fabricação do sabão e como ele age no processo de limpeza.'),
('HM-026', 'Arte de Fazer Esteiras', 'artes-e-habilidades-manuais', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/hm-026.webp', 'https://mda.wiki.br/Especialidade_de_Arte_de_Fazer_Esteiras', '1. Mencionar, pelo menos, 2 materiais que são usados em seu país para fazer esteiras.
2. Explicar e demonstrar como preparar estes materiais para a confecção de esteiras.
3. Dar o nome de, pelo menos, 2 plantas de seu país que podem ser usadas para fazer tintas. Dizer onde são encontradas e como é feito o preparo da tinta a partir delas.
4. Demonstrar como usar tintas naturais e sintéticas para colorir esteiras.
5. Fazer, pelo menos, 2 esteiras com, ao menos, 2 tipos de trançados diferentes. Uma delas deve ter um trançado bem fino.'),
('HM-027', 'Construção Nativa', 'artes-e-habilidades-manuais', 'especialidade', 3, null, 'Divisão do Sul do Pacífico', '/esp/hm-027.webp', 'https://mda.wiki.br/Especialidade_de_Construção_Nativa', '1. Ajudar no planejamento de uma casa simples, bem esquadrada e com precisão.
2. Ajudar na escolha e corte de madeiras adequadas no mato para uso no piso, vigas, placas da parede, pregos, degraus e portas.
3. Fazer o seguinte:
  a) Trançar materiais para paredes.
  b) Fazer seções para a parede, com medidas de 1 m x 1 m. Mostrar 2 padrões diferentes de tranças.
4. Mostrar capacidade para cobrir um telhado corretamente, usando sapé, folhas de palmeira, de coqueiro ou outro material.
5. Quando necessário, selecionar, preparar e usar cipós para amarração das vigas e estruturas.
6. Participar da construção de uma casa, com não menos que 4m x 2m com materiais nativos. Na construção da casa, praticar todos os requisitos anteriores (1 a 5). Enquanto construir a casa, mostrar o cuidado necessário para manter o material livre de cupins.
7. Demonstrar capacidade para identificar, usar e os cuidados quanto à segurança no manuseio das seguintes ferramentas: machado, serra, martelo, talhadeira, faca, régua, fita métrica e pá.'),
('HM-028', 'Ferreomodelismo', 'artes-e-habilidades-manuais', 'especialidade', 2, 1967, 'Associação Geral', '/esp/hm-028.webp', 'https://mda.wiki.br/Especialidade_de_Ferreomodelismo', '1. Apresentar a história e desenvolvimento do ferreomodelismo.
2. Identificar a diferença no funcionamento da força motriz dos seguintes protótipos:
  a) Vapor
  b) Diesel
  c) Elétrico
3. Saber o nome, escala e dimensão de quatro bitolas usadas no ferreomodelismo.
4. Conhecer os formatos e nomes de, pelo menos, 8 tipos de traçados de linhas em protótipos de estrada de ferro.
5. Conhecer, pelo menos, 6 pontos de verificação para a manutenção de um traçado de estrada de ferro.
6. Identificar e explicar o uso de:
  a) 5 tipos de vagões de carga
  b) 3 tipos de vagões de passageiros
  c) 3 tipos de locomotivas a vapor, de acordo com o tipo de rodas
  d) 2 tipos de mecanismos de alerta para cruzamentos em nível
  e) 2 tipos de sinais próprios para a estrada de ferro
  f) 2 tipos de construções ou estruturas ligadas à estrada de ferro
7. Conhecer o significado dos seguintes termos do ferreomodelismo:
  a) Balastro
  b) Dormente
  c) Secção
  d) Intersecção
  e) Chave intermediária
  f) Duplex ou múltipla unidade
  g) Equipamento de tração
  h) Patilha
  i) Cruzamento
  j) Intervalo
  k) Bitola
  l) Nível
  m) Campo de gravidade
  n) Rolamento superaquecido ou freio dinâmico
  o) Diário de bordo
  p) Traçado
  q) Linha-tronco ou principal
  r) Protótipo
  s) Junção de trilhos
  t) Curva em s
  u) Desvio
  v) Ramal
  w) Chave
  x) Máquina
  y) Vagão aberto
  z) Vagão fechado
  {) Desvio de linhas ou aparelho de mudança de via (amv)
  |) Trilhos duplos ou bitola mista
  }) Chave y
  ~) Pátio de manobras
8. Construir parte de um traçado de linha de trem, incluindo as seguintes atividades:
  a) Ajudar a montar a estrutura
  b) Instalar uma parte do balastro
  c) Instalar uma parte dos trilhos
  d) Instalar, pelo menos, um desvio de linhas, inclusive a instalação elétrica
  e) Ajudar na confecção de um cenário incluindo árvores, pedras, montanhas ou grama
9. Fazer funcionar um trem no traçado de trilhos que você ajudou a construir.'),
('HM-029', 'Herança Cultural', 'artes-e-habilidades-manuais', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/hm-029.webp', 'https://mda.wiki.br/Especialidade_de_Herança_Cultural', '1. Qual a importância de se conhecer sua herança cultural e também a de outros membros de sua comunidade?
2. Tendo os princípios bíblicos como base, listar 3 tradições negativas e 5 tradições positivas, encontradas em sua cultura.
3. Listar, ao menos, 5 datas que são feriados culturais oficiais em seu país/estado e informar: data do feriado, data de oficialização, costume para o dia, costume de sua família nesse dia, etc.
4. Fazer o seguinte:
  a) Detalhar as maneiras habituais de vestir-se para a vida cotidiana e para 2 ocasiões que, em sua cultura, se use vestimentas especiais (em termos de tradição, modelo, composição ou cor).
  b) Apresentar e explicar por meio de foto ou desenho essas vestimentas especiais.
5. Como funciona a estrutura familiar em sua cultura?
6. Explicar a estrutura política vigente em seu país e identificar a origem desse sistema.
7. Pesquisar e descrever os costumes, comemorações e/ou cerimônias realizados em sua cultura para as seguintes ocasiões:
  a) O nascimento de uma criança
  b) Tornar-se adulto (comemorações de idades especificas, ritos de passagem, etc.)
  c) Casamento
  d) Morte e sepultamento
8. Em sua cultura, como é o sistema de noivado e casamento? Analisar como é feito o pedido aos pais, o noivado, a cerimônia religiosa, a celebração, a legalidade, símbolos culturais utilizados, etc.
9. Escrever 300 palavras sobre um compositor, pintor ou escultor de seu país, que seja internacionalmente reconhecido por sua arte e apresentar em vídeo, áudio ou fotografia uma de suas obras mais conhecidas.
10. Listar os povos (nativos e colonizadores) que deram origem à sua sociedade atual. Indicar, ao menos, 2 expressões culturais herdadas de cada um desses povos.
11. Conhecer 10 diferentes formas de arte ou artesanato nativo comuns em seu país. Demonstrar habilidade em produzir 3 destes itens.
12. O que faz um povo perder sua cultura? Analisar se isto é benéfico ou prejudicial.
13. Citar 5 comidas típicas da sua cultura.
14. Citar exemplos de festas folclóricas do seu país.'),
('HM-030', 'Lapidação', 'artes-e-habilidades-manuais', 'especialidade', 3, 1967, 'Divisão do Norte do Americana', '/esp/hm-030.webp', 'https://mda.wiki.br/Especialidade_de_Lapidação', '1. Mencionar, pelo menos, 4 precauções de segurança a tomar ao serrar pedras.
2. Mencionar 2 tipos de lubrificação e refrigeração para serra de diamante e qual a finalidade.
3. Explicar:
  a) Como uma serra de diamante corta pedras
  b) Como ela perde o diamante
  c) Como pode ser afiada
  d) Quais são os tipos de máquinas usadas para corte de pedras
4. Descreva as 5 etapas básicas para se fazer um polimento em uma pedra ou uma superfície plana.
5. Que precaução deve ser tomada entre a fase de lixamento e polimento?
6. O que é um gabarito e como ele é usado?
7. O que é um cabochão e qual a espessura da placa que ela é feita?
8. Como você decide o melhor ângulo e/ou posição para polimento de pedra?
9. Mencionar, pelo menos, 2 métodos de lixamento úmido para se moldar e polir uma pedra.
10. De quais materiais são confeccionados os compostos para polimento?
  a) Se um arranhão aparece durante o polimento, como é removido?
11. Saber como afiar as ferramentas usadas para lapidar pedras.
12. Monte um cabochão em algum tipo de apoio, como um pino de madeira, alfinete de costura, porta-chaves, etc., com cimento.'),
('HM-031', 'Modelagem em Gesso', 'artes-e-habilidades-manuais', 'especialidade', 1, 1967, 'Associação Geral', '/esp/hm-031.webp', 'https://mda.wiki.br/Especialidade_de_Modelagem_em_Gesso', '1. Qual o principal ingrediente do gesso de Paris?
2. Explicar passo a passo os procedimentos necessários na preparação e pintura para se fazer um objeto em gesso.
3. Saber como remover bolhas de ar ao se colocar o gesso na forma.
4. Saber como o tempo pode contribuir para uma secagem rápida e eficaz na preparação do gesso.
5. Que precauções podem ser tomadas ao se limpar os utensílios para fazer os objetos de gesso?
6. O que é um selador? Qual sua utilidade para a modelagem em gesso e por quê?
7. Que tipo de tinta é mais conveniente para a arte em gesso?
8. Pintar 3 objetos que incluam os seguintes desenhos e técnicas, ou algo equivalente:
  a) Floral (para demonstrar técnica de sombreamento)
  b) Animal (para demonstrar técnica de detalhamento)
  c) Tema Religioso (para demonstrar técnica de realce nas letras)
  d) Fruta (para demonstrar técnica de realce entre luz e sobras)
9. Moldar e pintar 2 objetos adicionais, com desenhos diferentes da questão anterior.'),
('HM-032', 'Trabalhos em Couro', 'artes-e-habilidades-manuais', 'especialidade', 1, 1967, 'Associação Geral', '/esp/hm-032.webp', 'https://mda.wiki.br/Especialidade_de_Trabalhos_em_Couro', '1. Qual a utilidade do couro, e onde podemos encontrá-lo?
2. Fazer uma lista de materiais necessários para a realização do trabalho em couro e demonstrar como manusear cada um dos itens citados.
3. Saber diferenciar os diversos tipos de couro, como os bovinos, caprinos e imitações de couro. Saber qual couro é mais fácil de se trabalhar.
4. Como podemos classificar o couro bovino? Qual a parte do boi mais aproveitada?
5. Descrever os passos necessários para a preparação do couro.
6. Citar alguns dos defeitos mais comuns que encontramos no couro.
7. Desenhar ou colar figuras/fotos de algumas ferramentas utilizadas nos trabalhos em couro, como, por exemplo, carteira, capa de revista ou cinto.
8. Demonstrar como utilizar uma tintura em couro.
9. Demonstrar como fazer relevo em couro.
10. Demonstrar como inserir fechos, fivelas e acabamentos de metal em couro.
11. Conhecer 3 costuras básicas para trabalhar em couro.
12. Que acabamento é mais recomendado para a finalização de um trabalho em couro?'),
('HM-033', 'Crochê', 'artes-e-habilidades-manuais', 'especialidade', 2, 1970, 'Associação Geral', '/esp/hm-033.webp', 'https://mda.wiki.br/Especialidade_de_Crochê', '1. Saber executar os seguintes pontos e mencionar quais são as abreviaturas dos mesmos:
  a) Ponto alto
  b) Ponto alto duplo
  c) Ponto corrente
  d) Ponto baixo
  e) Meio ponto
  f) Ponto baixíssimo
2. Listas os materiais necessários para fazer uma peça em crochê mencionando quais tipos de linha são os mais adequados a cada tipo de trabalho.
3. Fazer um quadrado de 10X10 cm utilizando um dos pontos indicados no requisito 1.
4. Saber como cuidar de itens feitos de lã, nylon, acrílico e algodão.
5. Saber fazer um quadrado para crochê e mostrar algo que tenha feito usando o mesmo, por exemplo, um boné, cachecol, fronha de almofada.
6. Apresentar uma amostra de barra feita em linha.
7. Fazer, em fio de lã, um dos itens a seguir: boné, cachecol, colete ou um par de chinelos.
8. Fazer um dos itens a seguir:
  a) Barrinha de toalha ou de pano de prato com motivo de frutas
  b) Flor para cabelo
  c) Chaveiro'),
('HM-034', 'Crochê - avançado', 'artes-e-habilidades-manuais', 'especialidade', 3, 1970, 'Associação Geral', '/esp/hm-034.webp', 'https://mda.wiki.br/Especialidade_de_Crochê_-_avançado', '1. Ter a especialidade de Crochê.
2. Saber interpretar um gráfico que contenha, ao menos, 3 pontos diferentes.
3. Demonstrar como pregar uma barrinha de crochê em uma toalha.
4. Saber o que é um anel mágico. Fazer uma toalhinha de mesa redonda, de linha.
5. Fazer um rendado mais complexo para cobrir uma almofada, ou objeto semelhante.
6. Fazer um colete de crochê ou um conjunto completo pra bebê.
7. Fazer um xale ou uma passadeira de crochê.
8. Fazer uma peça de crochê à sua escolha usando, ao menos, 3 cores.'),
('HM-035', 'Espaçomodelismo', 'artes-e-habilidades-manuais', 'especialidade', 1, 1970, 'Associação Geral', '/esp/hm-035.webp', 'https://mda.wiki.br/Especialidade_de_Espaçomodelismo', '1. Explicar o código de segurança do espaçomodelismo.
2. Explicar a importância dos componentes básicos das miniaturas de foguetes.
3. Desenhar o seguinte:
  a) Os passos do voo de uma miniatura de foguete.
  b) Um corte transversal de um foguete em miniatura, identificando cada parte.
  c) Uma planta esquemática de um sistema simples de lançamento, usando os símbolos elétricos apropriados.
4. Definir o seguinte:
  a) Enchimento
  b) Planadores de impulso
  c) Simulador
  d) Carga útil
  e) Apogeu
  f) Centro de gravidade
  g) Centro de pressão
  h) Impulso
  i) Velocidade
  j) Ejeção
5. Nomear e descrever, pelo menos, 4 diferentes sistemas de resgate.
6. A partir de um kit, montar, fazer acabamento e pintar um foguete de estágio único, que tenha um comprimento mínimo de 15 cm. Lançar o foguete com paraquedas ou outro sistema de resgate.'),
('HM-036', 'Espaçomodelismo - avançado', 'artes-e-habilidades-manuais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/hm-036.webp', 'https://mda.wiki.br/Especialidade_de_Espaçomodelismo_-_avançado', '1. Ter a especialidade de Espaçomodelismo.
2. A partir de um kit, montar, lançar e resgatar um foguete em miniatura.
3. Projetar, construir (mas não a partir de um kit), fazer o acabamento e pintar um foguete de estágio único. Verifique se há estabilidade e, com sucesso, lançar e recuperar este foguete.
4. Faça um dos seguintes itens:
  a) A partir de um kit, construir, terminar e pintar um foguete de 2 estágios. Lançar com sucesso e recuperar este foguete.
  b) A partir de um kit, construir, terminar e pintar um motor de 3 estágios agrupados em um único estágio de foguete. Lançar com sucesso e recuperar este foguete.
5. Projetar um sistema de lançamento elétrico. Quando tiver sido aprovado pelo seu instrutor, construir este sistema e usá-lo para o lançamento de foguetes, pelo menos, 5 vezes.
6. Descrever e demonstrar controle de altitude de estação única. Com o auxílio de um instrutor, rastrear o mesmo foguete 3 vezes usando 3 diferentes tamanhos de motores e comparar altitudes com um localizador de altitude.
7. Comparar a velocidade e altitude de 2 pesos diferentes de foguetes usando o mesmo tamanho do motor.
## Código de Segurança do Missilmodelismo
1. Materiais: As miniaturas de foguetes deverão ser produzidas apenas através de materiais leves como papel, madeira, plástico e folhas de papel alumínio, com a exceção dos suportes de cargas e do mecanismo, feitos de arame ou semelhantes.
2. Mecanismos: Utilizar apenas mecanismos de miniaturas comprados prontos, e de acordo com as instruções do fabricante. Não mexer com estes motores e utilizá-los somente para fins recomendados pelo fabricante.
3. Sistema de ignição: Lançar os foguetes com um sistema de lançamento elétrico e ignitores de motores elétricos. O sistema de lançamento deverá possuir uma segurança de encravamento em série com o interruptor de lançamento que usa um interruptor de lançamento que retorne para a posição “OFF” quando lançado.
4. Falhas de ignição: Se o foguete não lançar quando for acionado o botão do sistema de lançamento elétrico, deve-se retirá-lo do lançador de bloqueio de segurança ou desconectar a bateria, e esperar 60 segundos após o último lançamento, antes de permitir que alguém se aproxime do foguete.
5. Lançamento de segurança: Iniciar uma contagem regressiva antes do lançamento para garantir que todos prestem atenção e mantenham uma distância segura de pelo menos 4,5 metros de distância para lançamentos de foguetes com motores D ou menor, e 9,5 metros para lançamentos de foguetes maiores. Caso o foguete não tenha sido testado e haja incerteza sobre sua segurança ou estabilidade, verificar a estabilidade de voo antes de permitir que espectadores acompanhem o lançamento.
6. Lançador: Lançar o foguete a partir de uma haste de lançamento, torre ou ferroviário, apontada a partir de 30 graus da vertical para assegurar que o foguete voe quase em linha reta, usando um defletor para impedir que a explosão escape do motor de bater no chão. Para evitar lesão acidental com os olhos, colocar os lançadores de modo que a extremidade da haste de lançamento esteja acima do nível do olho ou tapar a extremidade da haste, quando não estiver em uso.
7. Tamanho: O modelo de foguete não pesará mais de 1.500 gramas com o lançamento e não conterá mais de 125 gramas de propelente ou 71,9 segundos de impulso total. Se o modelo de foguete pesa mais de 453 gramas na decolagem ou tem mais de 113 gramas de propelente, verificar e cumprir com os regulamentos da Administração de Avaliação Federal antes de voar.
8. Segurança de voo: Não lançar o foguete contra ventos fortes, perto de prédios, fios de eletricidade, árvores altas, perto de aeroportos ou heliportos (onde passem aeronaves em voo baixo), ou em quaisquer condições que possam ser perigosas às pessoas ou propriedades, e não colocar qualquer carga inflamável ou explosiva no foguete.
9. Área de lançamento: Só lançar o foguete numa área aberta, pelo menos, tão grande como mostrado na tabela ( http://nar.org/NARmrsc.html), e em condições de tempo seguros, com velocidades de vento não superior a 32km/h . Assegurar-se de que não há capim seco próximo à plataforma de lançamento, e que o local de lançamento não apresenta risco de incêndios na grama.
10. Sistema de recuperação: Deve-se usar um sistema de recuperação como uma serpentina ou pára-quedas no foguete para que ele retorne com segurança e sem danos, e então possa ser usado novamente. Usar apenas enchimento resistente a chamas ou recuperação à prova de fogo no foguete.
11. Recuperação de forma segura: Não tentar recuperar o foguete caso ele caia em rede elétrica, árvores altas, ou outros lugares perigosos.'),
('HM-037', 'Tricô', 'artes-e-habilidades-manuais', 'especialidade', 2, 1970, 'Associação Geral', '/esp/hm-037.webp', 'https://mda.wiki.br/Especialidade_de_Tricô', '1. Saber executar os seguintes pontos e mencionar quais são as abreviaturas dos mesmos:
  a) Meia
  b) Tricô
  c) Laçada
  d) Mate simples
  e) Mate duplo
2. Listar 5 diferentes tipos de lãs e explicar quais são as vantagens e desvantagens de cada um.
3. Demonstrar como unir um novelo com outro e fazer com que o nó não seja notado em uma peça simples.
4. Demonstrar como arrematar uma peça de tricô.
5. Mencionar os cuidados necessários na lavagem e armazenamento das peças feitas com lã.
6. Fazer uma peça seguindo uma receita que tenha, ao menos, 3 diferentes pontos.
7. Fazer 1 peça em tricô, dentre as seguintes opções: luvas, sapatinhos de bebê, gorro, cachecol.'),
('HM-038', 'Tricô - avançado', 'artes-e-habilidades-manuais', 'especialidade', 2, 1970, 'Associação Geral', '/esp/hm-038.webp', 'https://mda.wiki.br/Especialidade_de_Tricô_-_avançado', '1. Ter a especialidade de Tricô.
2. Saber executar os seguintes pontos e mencionar quais são as abreviaturas dos mesmos:
  a) Dois pontos juntos em meia
  b) Mate duplo vertical
  c) Mate duplo à esquerda
  d) Mate duplo à direita
3. Saber fazer o seguinte:
  a) Aumento
  b) Diminuição
  c) Arremate
  d) Costura invisível
  e) Emendar fios com nós simples e nós com fio sobreposto
4. Saber unir 3 malhas de tricô.
5. Fazer, em tricô, um par de sapatos de adulto, sendo que as duas peças devem ser feitas simultaneamente no mesmo par de agulhas.
6. Fazer 2 peças das seguintes:
  a) Casaquinho de bebê
  b) Xale ou poncho
  c) Suéter adulto
  d) Vestido
  e) Casaco
7. Fazer uma peça de tricô usando, ao menos, 3 cores de lã diferentes.
8. Fazer uma peça de tricô à sua escolha que contenha motivo de tranças ou folhas.
9. Demonstrar habilidade em trabalhar com um dos seguintes instrumentos:
  a) Tear
  b) Agulha circular'),
('HM-039', 'Trabalhos em Vidro', 'artes-e-habilidades-manuais', 'especialidade', 1, 1970, 'Associação Geral', '/esp/hm-039.webp', 'https://mda.wiki.br/Especialidade_de_Trabalhos_em_Vidro', '1. Cite o nome de 10 tipos de vidro.
2. Saber que tipos de vidro são utilizados em móveis, isolamento, aviões e automóveis.
3. Coletar e preparar, pelo menos, 3 cores de vidro para fazer um quadro.
4. Saber os passos para fazer uma imagem com vidro e completar esse quadro usando, pelo menos, 3 cores.
5. Pesquisar sobre a história do vidro e como é o processo de fabricação. Escolher um dos seguintes:
  a) Relatório de, pelo menos, 300 palavras.
  b) Fazer uma apresentação oral de, pelo menos, 3 minutos.
6. Saber quais são as ferramentas necessárias e quais os cuidados que devemos ter ao trabalhar com vidros.
7. Pesquisar em sua região sobre o seguinte:
  a) Como funciona o processo de reciclagem de vidros?
  b) Que destino têm os retalhos de vidro em vidraçarias?
  c) Qual o destino mais indicado para vidros quebrados em casa?'),
('HM-040', 'Arte de Trançar', 'artes-e-habilidades-manuais', 'especialidade', 1, 1972, 'Associação Geral', '/esp/hm-040.webp', 'https://mda.wiki.br/Especialidade_de_Arte_de_Trançar', '1. Fazer uma trança de três pontas usando cabelo, corda ou cabo.
2. Fazer um puxador de zíper ou um chaveiro usando o trançado redondo ou quadrado de quatro cordões.
3. Fazer um projeto, que não seja um puxador de zíper ou um chaveiro, usando o trançado redondo ou quadrado de quatro cordões.
4. Fazer um cordão com alça usando um trançado redondo de quatro pontas.
5. Saber como iniciar e finalizar cada projeto.
6. Fazer um torçal, trançado com o nó de surrão na parte superior que envolve o braço e nó de surrão invertido no prolongamento até o apito.'),
('HM-041', 'Arte de Trançar - avançado', 'artes-e-habilidades-manuais', 'especialidade', 2, 1972, 'Associação Geral', '/esp/hm-041.webp', 'https://mda.wiki.br/Especialidade_de_Arte_de_Trançar_-_avançado', '1. Ter a especialidade de Arte de trançar.
2. Fazer um puxador de zíper ou chaveiro usando um trançado de 6 ou 8 cordões.
3. Fazer um puxador de zíper ou chaveiro usando de 6 ou 8 cordões, mostrando a técnica de ziguezague revertendo o sentido do trançado.
4. Fazer um dos seguintes:
  a) Cordão com alça de 6 fios ou cordões
  b) Marca página usando, pelo menos, 6 fios ou cordões
  c) Coleira de cachorro com trançado de quatro fios ou cordões em torno de um cordão ou cabo
  d) Rédea para cavalos com trançado de 4 fios ou cordões
5. Saber como iniciar e finalizar cada projeto.'),
('HM-042', 'Decoração de Bolos', 'artes-e-habilidades-manuais', 'especialidade', 2, 1972, 'Associação Geral', '/esp/hm-042.webp', 'https://mda.wiki.br/Especialidade_de_Decoração_de_Bolos', '1. Fazer uma lista de equipamentos necessários para decorar bolos.
2. Explicar brevemente a composição e melhor uso para cada uma das seguintes coberturas:
  a) Buttercream
  b) Chantilly
  c) Ganache
  d) Glacêreal
  e) Merengue
  f) Fondant
3. Preparar 2 coberturas de bolo e dizer que ingredientes foram utilizados em cada uma.
4. Demonstrar como converter e usar corretamente colheres, xícaras de medidas e a balança culinária (se houver). Qual a importância, na confeitaria, de se seguir a receita corretamente?
5. Fazer e descrever os procedimentos adequados para a construção de um saco de confeitar.
6. Demonstrar de maneira correta como:
  a) Encaixar o bico no saco de confeitar
  b) Misturar a cor
  c) Encher com glacê e dobrar a ponta
7. Qual o nome da dobra da ponta do saco de confeitar?
8. Citar 3 etapas essenciais para um bom trabalho em uma decoração de bolo.
9. Demonstrar habilidade e precisão ao desenhar os seguintes:
  a) Chuva de Estrelas
  b) Rosas
  c) Bordas em formato de conchas e zigue-zague
  d) Forma de "S"
  e) Laços
10. Descrever e explicar 4 técnicas utilizadas na decoração de um bolo.
11. Desenhar 4 flores diferentes, por exemplo: ervilha-de-cheiro, rosa, cravo, margarida, copo de leite, violeta, etc. Uma das 4 flores escolhida deve ser feita inteira.
12. Demonstrar técnicas e métodos de escrever em um bolo, usando 2 bicos de confeitar diferentes.
13. Fazer um bolo em uma fôrma de formato diferente e confeitá-lo.
14. Fazer uma decoração em um bolo para uma cerimônia especial, utilizando, pelo menos, 2 bordas diferentes e um arranjo floral.
15. Fazer um bolo em forma de coração, onde o mesmo deve ter:
  a) Bordas
  b) Flores
  c) Escrita
  d) Tranças ornamentais'),
('HM-043', 'Esmaltado em Cobre', 'artes-e-habilidades-manuais', 'especialidade', 1, 1972, 'Associação Geral', '/esp/hm-043.webp', 'https://mda.wiki.br/Especialidade_de_Esmaltado_em_Cobre', '1. Conhecer a diferença entre o esmaltado em baixa e em alta temperatura.
2. Citar os materiais que podem ser usados no processo de baixa temperatura.
3. Qual é o método apropriado para a limpeza de objetos que serão esmaltados? Por que esta limpeza é importante?
4. Que acabamento deve ser dado ao cobre para evitar a perda do brilho?
5. Citar o nome das ferramentas usadas para fazer o esmaltado.
6. Que fontes de calor podem ser usadas para o processo de baixa temperatura? Que medidas de segurança devem ser seguidas?
7. Como se prende alfinetes tipo broche e imãs atrás de objetos de metal?
8. Fazer, pelo menos, 3 objetos usando as seguintes técnicas:
  a) Espiral
  b) Estêncil
  c) Filamentos
  d) Mosaico
  e) Scraffito'),
('HM-044', 'Esmaltado em Cobre - avançado', 'artes-e-habilidades-manuais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/hm-044.webp', 'https://mda.wiki.br/Especialidade_de_Esmaltado_em_Cobre_-_avançado', '1. Ter a especialidade de Esmaltado em Cobre.
2. Explicar o uso de um tripé.
3. Que materiais podem ser usados para decorar ou ornamentar objetos esmaltados?
4. Fazer 4 dos seguintes projetos:
  a) Decoração de natal
  b) Decoração de cozinha
  c) Flor de metal
  d) Broche ou pin
  e) Porta livros de metal
  f) Placa de metal
  g) Objeto tridimensional
  h) Objeto semelhante de sua escolha'),
('HM-045', 'Estofamento', 'artes-e-habilidades-manuais', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/hm-045.webp', 'https://mda.wiki.br/Especialidade_de_Estofamento', '1. Conhecer os seguintes itens utilizados em estofamento. Descrever as ferramentas e dar seus usos:
  a) Pé de cabra
  b) Removedor de grampos
  c) Agulhas curvas
  d) Martelo magnético
  e) Estilete ou faca afiada
  f) Mesa de trabalho
  g) Máquina de costura Industrial
  h) Grampeador manual
2. Explicar o usodos seguintes itens:
  a) Cintas
  b) Grampos e tachinhas
  c) Espuma
  d) Algodão para tapecaria
3. Conhecer, pelo menos, 3 tipos de tecidos comuns em sua região que são utilizados no estofamento.
4. Explicar como encaixar a tampa traseira para acabamento em um sofá de 3 lugares.
5. Qual o nome do material utilizado para a base de um sofá de sala de estar e qual a sua finalidade?
6. Conhecer 2 métodos de fixação de capas para cadeiras.
7. Escolher 1 dos seguintes:
  a) Estofar uma poltrona ou sofá
  b) Estofar uma caixa de brinquedos
8. Fazer uma almofada para sofá.'),
('HM-046', 'Fabricação de Velas', 'artes-e-habilidades-manuais', 'especialidade', 2, 1972, 'Associação Geral', '/esp/hm-046.webp', 'https://mda.wiki.br/Especialidade_de_Fabricação_de_Velas', '1. Conhecer, pelo menos, 2 tipos de cera utilizados para fazer velas tradicionais e explique o uso de cada uma.
2. Saber a medida de um pavio e por quanto tempo ele ficará queimando.
3. Em qual circunstancia deve-se usar um pavio de metal?
4. Conhecer as medidas de segurança para a fabricação de uma vela.
5. Fazer, pelo menos, 3 dos itens a seguir:
  a) Vela de Areia de forma livre
  b) Vela em camadas coloridas
  c) Vela feita em um molde
  d) Vela de Gelo
  e) Vela Perfumada
  f) Um par de velas de cera de abelha'),
('HM-047', 'Serigrafia', 'artes-e-habilidades-manuais', 'especialidade', 2, 1974, 'Associação Geral', '/esp/hm-047.webp', 'https://mda.wiki.br/Especialidade_de_Serigrafia', '1. O que é serigrafia? Fazer uma lista das ferramentas e equipamentos necessários para fazer serigrafia e a utilidade de cada um deles.
2. Mencionar 3 tipos de tinta adequadas para o trabalho com serigrafia.
3. Relacionar, pelo menos, 3 usos industriais para a serigrafia.
4. Explicar como fazer serigrafia em garrafas e superfícies arredondadas.
5. Fazer uma estampa, transferi-la para uma tela e imprimir um dos projetos a seguir:
  a) Pelo menos 10 cartões
  b) Pelo menos 3 cartazes
  c) Estampar um desenho em tecido
  d) Um projeto semelhante, de sua escolha'),
('HM-048', 'Serigrafia - avançado', 'artes-e-habilidades-manuais', 'especialidade', 2, 1974, 'Associação Geral', '/esp/hm-048.webp', 'https://mda.wiki.br/Especialidade_de_Serigrafia_-_avançado', '1. Ter a especialidade de Serigrafia.
2. Estender e prender uma malha num bastidor para fazer uma tela de serigrafia.
3. Saber que tecidos podem ser usados para serigrafia e as vantagens de cada um. Que fatores influenciam na escolha da malha para a tela?
4. Compreender cada uma das seguintes técnicas de impressão em Serigrafia:
  a) Método filme estêncil
  b) Método fotográfico
  c) Método resistente
5. Usar duas das técnicas do requisito 4 para realizar o seguinte:
  a) Imprimir um desenho usando duas cores ou mais, de acordo com a tabela de cores
  b) Imprimir um desenho em repetição
  c) Imprimir um desenho em três cores, usando apenas duas cores de tinta
6. Imprimir, no mínimo, 10 camisetas iguais para sua unidade, Clube ou projeto da Igreja, usando ao menos 5 telas diferentes, sendo, pelo menos, 3 delas de um mesmo desenho (sobrepostas).
7. Imprimir em um material que não seja papel ou tecido, como, por exemplo, vidro, metal ou couro.'),
('HM-049', 'Arte com Barbante', 'artes-e-habilidades-manuais', 'especialidade', 1, 1975, 'Associação Geral', '/esp/hm-049.webp', 'https://mda.wiki.br/Especialidade_de_Arte_com_Barbante', '1. Descrever os itens a seguir: artesanato com barbante, simetria (symmography), ponto geométrico.
2. Desenhar e encordoar sobre papel cartão em pontos igualmente espaçados:
  a) Um ângulo reto
  b) Um ângulo agudo
  c) Um ângulo obtuso
3. Mencionar três maneiras de preparar a madeira para a arte com barbante.
4. Usando métodos de encordoar em madeira, fazer quatro dos seguintes:
  a) Círculo cheio
  b) Círculo vazado
  c) Estrela
  d) Beirada
  e) Curva de dentro para fora
  f) Curva de fora para dentro
  g) Enchimento
  h) Asa entrelaçada
5. Colocar em exposição um trabalho original de arte com barbante em madeira.
6. Além da madeira, que outros materiais podem ser usados em trabalhos de arte com barbante? Liste, ao menos, 5.'),
('HM-050', 'Decoupage', 'artes-e-habilidades-manuais', 'especialidade', 2, 1975, 'Associação Geral', '/esp/hm-050.webp', 'https://mda.wiki.br/Especialidade_de_Decoupage', '1. O que é Decoupage?
2. Apresentar a história desta técnica, incluindo país de origem, desenvolvimento e tantas curiosidades que puderem ser encontradas.
3. Fazer uma lista do material e equipamentos necessários para o decoupage.
4. Descreva a forma apropriada de limpeza de cada ferramenta utilizada.
5. Descrever como preparar a madeira ou objeto de metal para o decoupage.
6. Explique 3 maneiras pelas quais o material impresso pode ser usado no decoupage.
7. Explicar os 3 passos desta técnica. Se possível, produzir um vídeo com a explicação.
8. Seguindo os passos básicos, completar 2 dos objetos a seguir:
  a) Porta-lápis
  b) Suporte de livros
  c) Garrafa
  d) Caixa de madeira
  e) Objeto de sua escolha
9. Um dos objetos preparados durante o cumprimento do requisito 8 deve ser dado de presente a alguém.'),
('HM-051', 'Macramê', 'artes-e-habilidades-manuais', 'especialidade', 1, 1975, 'Associação Geral', '/esp/hm-051.webp', 'https://mda.wiki.br/Especialidade_de_Macramê', '1. Descrever a história do macramê.
2. O que é um fio de macramê?
3. Citar 3 tipos de fios utilizados no macramê e explicar a qualidade de cada um.
4. Conhecer os nós básicos que são usados no macramê. Saber 2 variações de cada um desses nós citados.
5. Qual a utilidade do nó simples no macramê?
6. Qual a quantidade necessária de material para se alcançar o comprimento desejado do produto final?
7. Fazer uma amostra de macramê para exposição ou apresentação em seu Clube, escola ou Igreja, usando os seguintes nós essenciais e, pelo menos, 2 variações: nó Chato, nó Cordonê ou nó Festonê. Fazer 2 outros itens de sua escolha usando os nós essenciais: nó quadrado, Josephine ou nó gravata.
8. Fazer 2 itens diferentes de sua escolha usando o nó quadrado, o ponto meia duplo e 2 variações de cada um em ambos os itens.'),
('HM-052', 'Telhados', 'artes-e-habilidades-manuais', 'especialidade', null, null, 'Divisão Centro Leste Africana', '/esp/hm-052.webp', 'https://mda.wiki.br/Especialidade_de_Telhados', '1. Fazer uma lista de ferramentas necessárias para se trabalhar em telhados, relacionando o uso e os cuidados de segurança de cada ferramenta.
2. Quais os equipamentos necessários para se fazer um telhado com "tesouras"? Descrever como você faria para erguê-las em seus lugares.
3. Citar os principais tipos de madeiras usadas em telhados em sua região e sua utilização em vários tipos de telhados, como: meia-água, duas águas, segmentadas, espigão, colonial, etc.
4. Responder o seguinte, com relação ao preparo do material:
  a) Como é feito o corte da madeira para telhados e como as madeiras são armazenadas?
  b) Como é feita a preparação da madeira utilizada em telhados?
  c) Como é feito um telhado com cabeamento? Quais são os materiais e equipamentos utilizados em sua região?
5. Responder o seguinte, com relação aos telhados de palha:
  a) Telhado de palha pode ser feito de qualquer modelo?
  b) Qual o modelo mais prático de se fazer um telhado de palha?
  c) Citar algumas vantagens e desvantagens de um telhado de palha.
  d) Quais são as intempéries que prejudicam um telhado de palha? Como a proteção deve ser feita?
6. Ter conhecimento prático em trabalho com palha e demonstrar capacidade em fazer alguns feixes para cobertura.
7. Responder o seguinte, com relação à mão de obra:
  a) Quantos trabalhadores são necessários para se construir um telhado com tesouras estilo 2 águas?
  b) Descrever como iniciar um trabalho na cobertura do item anterior.
  c) Dizer e demonstrar, se possível, como você faria um telhado redondo e um telhado colonial.'),
('HM-053', 'Cultura Indígena - avançado', 'artes-e-habilidades-manuais', 'especialidade', 3, 1976, 'Divisão Norte Americana', '/esp/hm-053.webp', 'https://mda.wiki.br/Especialidade_de_Cultura_Indígena_-_avançado', '1. Ter a especialidade Cultura indígena.
2. Pesquisar se em seu país existe alguma política pública de preservação da cultura indígena. Com base nessa pesquisa, escrever uma redação de 500 palavras sobre "Direitos das populações indígenas".
3. Identificar a etnia e apresentar a localização de, pelo menos, 10 tribos ou comunidades indígenas existentes o mais próximo possível de sua cidade, na atualidade.
4. Descobrir como os indígenas obtinham tintas/corantes vegetais e tentar obter, pelo menos, 2 tons de cores por esse método.
5. Listar 5 medicamentos ou plantas medicinais utilizadas pelos indígenas e que atualmente tenham sua eficácia comprovada pela ciência.
6. Aprender a contar, ao menos, 3 histórias tradicionais contadas por alguma etnia indígena de sua região, que ensine importantes lições para a vida do Desbravador.
7. Listar 5 diferentes línguas/dialetos indígenas e apresentar o significado de, ao menos, lo palavras em cada um deles.
8. Descobrir que etnia indígena vivia em sua cidade (ou a mais próxima) no período da colonização do seu país. Sobre esse grupo, pesquise as seguintes informações:
  a) Tamanho da população, na época e atualmente
  b) Habitações/moradia
  c) Artesanato nativo como cestaria, cerâmica, tapetes, entalhes, etc.
  d) Práticas religiosas
  e) Forma de Governo
  f) Vestimentas e adornos
9. Participar de uma refeição com diversos alimentos e pratos indígenas, onde tenham sido usados variados métodos de preparo.
10. Como são construídas as habitações indígenas? Com materiais naturais, fazer uma maquete de uma habitação indígena, utilizando os mesmos métodos de construção.
11. Realizar um dos seguintes:
  a) Visitar um museu indígena ou uma coleção pública/privada. Ao final da visita, preparar um relatório com fotos sobre todas as coisas interessantes que aprendeu.
  b) Recepcionar um indígena em uma reunião do Clube e aprender sobre seu povo e seus costumes. Pedir que ele ensine algum tipo de artesanato de seu grupo. Ao final, apresentar a seu instrutor a peça de artesanato que preparou.
  c) Fazer uma visita a um indígena e aprender sobre seu povo e seus costumes. Fazer um relatório sobre a experiência, contando o que aprendeu. Inserir fotos da visita.
  d) Visitar uma aldeia indígena ou reserva. Ao final, preparar um álbum de fotos da visita e apresentá-lo a seu instrutor, contando as histórias de cada foto.
12. Conhecer e explicar os métodos utilizados na elaboração dos seguintes:
  a) Armas de caça (por exemplo: arco e flecha)
  b) Potes
  c) Instrumentos musicais
  d) Tecidos
  e) Cestas'),
('HM-054', 'Bordado em Ponto Cruz', 'artes-e-habilidades-manuais', 'especialidade', 2, 1976, 'Associação Geral', '/esp/hm-054.webp', 'https://mda.wiki.br/Especialidade_de_Bordado_em_Ponto_Cruz', '1. Ter um estojo com material necessário para fazer o ponto cruz, incluindo pelo menos: agulhas para ponto cruz, linha de algodão mercerizada em várias cores, uma tesoura para bordado, retalhos de tecido para ponto cruz e vários gráficos para bordar.
2. Conhecer os tipos de tecido para bordar o ponto cruz que se encontram no mercado.
3. Conhecer os tipos de fios para bordar o ponto cruz que se encontram no mercado.
4. Conhecer, pelo menos, quatro pontos usados no ponto cruz e saber interpretar um gráfico.
5. Bordar em ponto cruz um desenho com, pelo menos, três cores em três amostras distintas de tecidos e identificá-los.
6. Fazer dois dos seguintes trabalhos em ponto cruz, usando gráfico:
  a) Pano de prato
  b) Toalha de rosto ou de lavabo
  c) Jogo americano
  d) Capa de almofada
  e) Caminho de mesa
7. Fazer um quadro em ponto cruz de, pelo menos, 30 x 50 pontos com desenho de sua escolha.
8. Fazer um quadro em ponto cruz de, pelo menos, 50 x 90 pontos de uma cena da natureza.'),
('HM-055', 'Biscuit', 'artes-e-habilidades-manuais', 'especialidade', 1, 1976, 'Associação Geral', '/esp/hm-055.webp', 'https://mda.wiki.br/Especialidade_de_Biscuit', '1. Fazer uma lista dos materiais necessários para a arte em biscuit.
2. Por que é importante estar com as mãos limpas, e usar creme para as mãos ao trabalhar com biscuit?
3. Explicar as diferentes técnicas de colorir e pintar a massa, e como devemos guardá-la para que não seque.
4. Que tipo de acabamento se usa para proteger e dar uma aparência brilhante aos artigos feitos com biscuit?
5. Fazer, pelo menos, dois objetos a seguir:
  a) Joaninha
  b) Flor
  c) pessoa articulada
  d) Chaveiro
  e) Porta recado
6. Fazer um dos itens a seguir usando massa tingida:
  a) Lembrança de casamento
  b) Lembrança de maternidade
  c) Topo de bolo temático
  d) Pequeno quadro de parede
7. Fazer um dos itens a seguir:
  a) Ímã de geladeira
  b) Vasinho de flor
  c) Pote para cozinha
  d) Porta treco
  e) Algo de sua escolha
8. Aprender a usar corretamente moldes de silicone e fazer, pelo menos, um modelo a sua escolha.
## Referências'),
('HM-056', 'Patchwork', 'artes-e-habilidades-manuais', 'especialidade', 2, 1976, 'Associação Geral', '/esp/hm-056.webp', 'https://mda.wiki.br/Especialidade_de_Patchwork', '1. O que é patchwork?
2. Fazer uma lista de materiais necessários para confeccionar uma peça em patchwork.
3. Quais são os passos básicos para a confecção de uma peça de patchwork?
4. Listar 5 tipos de tecidos utilizados para se fazer patchwork e quais as vantagens e desvantagens de cada um.
5. Demonstrar habilidade em medir e cortar corretamente os tecidos.
6. Demonstrar como combinar cores e estampas corretamente.
7. Saber costurar e arrematar corretamente suas peças à mão ou à máquina.
8. Qual a importância de um acabamento bem feito para o valor comercial do seu produto?
9. Fazer 3 dos seguintes.
  a) Trabalhos usando patchwork
  b) Avental
  c) Capa de almofada
  d) Bolsa
  e) Jogo americano
  f) Saco de dormir para bebê
  g) Toalha de mesa
  h) Tapete
10. Fazer uma peça de sua escolha usando 2 dos seguintes motivos:
  a) Animal
  b) Flor
  c) Formas geométricas
  d) Frutas
11. Qual tamanho deve ter uma colcha para as seguintes camas:
  a) Solteiro
  b) Casal
  c) King Size
12. Quais são os métodos mais comuns de desenho para uma colcha de retalhos?
13. Mostrar as 3 principais fibras usadas no enchimento (camada central) de uma colcha de retalhos.
14. Começar e terminar uma colcha de retalhos, seja como um projeto individual ou em grupo.'),
('HM-057', 'Nautimodelismo', 'artes-e-habilidades-manuais', 'especialidade', 2, 1977, 'Associação Geral', '/esp/hm-057.webp', 'https://mda.wiki.br/Especialidade_de_Nautimodelismo', '1. Apresentar um resumo sobre as linhas e desenhos de um projeto de um Nautimodelismo.
2. Cumprir dois dos itens abaixo:
  a) Comprar e montar um kit para barco à vela de 25 a 40 centímetros de comprimento e cerca de 4 a 5 centímetros de largura. Manobrar o barco na água durante, pelo menos, dois minutos.
  b) Construir um barco em miniatura, com motor elétrico, a partir de seu próprio projeto ou de um kit (tamanho: 25 a 45 cm de comprimento) e manobrar o barco durante três a cinco minutos.
  c) Construir um modelo de 45 a 80 centímetros de comprimento a partir de seu próprio projeto ou de um kit comprado. Instalar um motor de combustão interna 0,029 ou 0,049 e manobrar em uma corrida com duração de cinco minuto. Anotar por escrito as características do modelo e o que você fez para melhorar seu desempenho.
3. Identificar e definir as seguintes palavras:
  a) Deslocamento
  b) Centro de gravidade
  c) Nível de propulsão
  d) Impulso e suspensão
  e) Casco simples
  f) Energia hidráulica
  g) Proa
  h) Quilha
  i) Viga
  j) Cavitação
  k) Adernar
  l) Nivelar
  m) Draga'),
('HM-058', 'Trabalhos em Couro - avançado', 'artes-e-habilidades-manuais', 'especialidade', 3, 1977, 'Associação Geral', '/esp/hm-058.webp', 'https://mda.wiki.br/Especialidade_de_Trabalhos_em_Couro_-_avançado', '1. Ter a especialidade de Trabalhos em couro.
2. Demonstrar habilidade em fazer furos, colocar fechos, fazer costura em uma sela e fazer 2 tipos de laços.
3. Fazer uma bainha para uma machadinha, faca ou facão.
4. Fazer e esculpir um cinto, criando uma ferramenta adequada para essa atividade.
5. Desenhar, cortar o couro, furar e entrelaçar um dos modelos a seguir:
  a) Bolsa
  b) Sacola
  c) Pasta
  d) Objeto de sua escolha
6. Apresentar, pelo menos, 6 objetos em couro feitos por você.'),
('HM-059', 'Gravuras em Vidro', 'artes-e-habilidades-manuais', 'especialidade', 2, 1997, 'Associação Geral', '/esp/hm-059.webp', 'https://mda.wiki.br/Especialidade_de_Gravuras_em_Vidro', '1. Liste as ferramentas e itens necessários para o trabalho de gravura em vidros.
2. Quais são os passos para se fazer uma gravura em vidro?
3. Qual a técnica utilizada para a gravura aveludada?
4. Fazer um dos itens a seguir em vidro transparente:
  a) Verso bíblico
  b) Flores, animais ou pessoas
5. Fazer um trabalho em um espelho, com os seguintes itens:
  a) Letras, versos, flores, animais ou pessoas
  b) Concluir o trabalho com enquadramento em torno do espelho com fita adesiva colorida.
6. Fazer um projeto em um copo, jarra, ou objeto oval.'),
('HM-060', 'Origami', 'artes-e-habilidades-manuais', 'especialidade', 1, 1997, 'Associação Geral', '/esp/hm-060.webp', 'https://mda.wiki.br/Especialidade_de_Origami', '1. Definir o que é um origami. Conhecer sua história e desenvolvimento em diferentes países.
2. Definir quais são os principais usos do origami atualmente e qual a diferença em relação a como era usado no passado.
3. Explicar a importância e utilidade dos diagramas. Conhecer os principais símbolos usados neles.
4. Ser capaz de identificar os seguintes símbolos e executar o movimento correspondente, quando houver:
  a) Dobrar nessa direção
  b) Dobrar e desdobrar
  c) Dobrar para trás
  d) Dobrar para dentro
  e) Linha do vale
  f) Linha da montanha
  g) Frente
  h) Verso
  i) Vinco
  j) Segurar aqui
  k) Soprar
  l) Abrir
  m) Dobrar em cima da dobra
  n) Girar
5. Explicar a importância e utilidade das bases ou formas básicas. Demonstrar as seguintes:
  a) Base quadrada
  b) Base de peixe
  c) Base de balão
  d) Base de pássaro
  e) Base de sapo
6. Dobrar os seguintes modelos a partir de diagramas ou escolher modelos semelhantes:
  a) Tsuru
  b) Cachorro
  c) Flor
  d) Cigarra
  e) Sapo que pula
  f) Pombo correio
  g) Barco à vela
  h) Galinha
  i) Folha
  j) Pato
  k) Borboleta
  l) Pessoa
7. Dobrar 2 modelos de sua escolha, de memória.'),
('HM-061', 'Corrida de Carrinhos de Madeira', 'artes-e-habilidades-manuais', 'especialidade', 1, 1999, 'Divisão Norte Americana', '/esp/hm-061.webp', 'https://mda.wiki.br/Especialidade_de_Corrida_de_Carrinhos_de_Madeira', '1. Mencionar os 4 componentes básicos para se construir um carrinho de madeira para corrida.
2. Construir um carrinho de madeira com os seguintes requisitos como regras:
  a) Deverá ser feito durante o ano de atividades do clube de desbravadores.
  b) A largura do carro não deve ultrapassar 70 mm
  c) O comprimento do carro não deve ultrapassar 178 mm
  d) O peso do carro não deve ultrapassar 142 gramas
  e) A largura entre as rodas deve ser, no máximo, 44 mm
  f) A altura máxima do carro não deve ultrapassar 10 mm
  g) Rolamentos, arruelas e buchas são proibidos.
3. Saber usar as seguintes ferramentas com segurança, para a construção do seu projeto.
  a) Serra
  b) Grosa de madeira
  c) Lixadeira
  d) Lixa para acabamento
  e) Plaina
  f) Martelo
  g) Formão
4. Conhecer os passos básicos na construção de um carro:
  a) Projeto
  b) Transferência do projeto
  c) Construção do carro
  d) Eixos e rodas
  e) Adicionando peso
  f) Lubrificação
5. Projetar e construir um carro de madeira para corridas, a partir das instruções do requisito 2.
6. Participar de um evento em seu clube ou região usando o carro que você construiu no requisito 5.'),
('HM-062', 'Corrida de Carrinhos de Madeira - avançado', 'artes-e-habilidades-manuais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/hm-062.webp', 'https://mda.wiki.br/Especialidade_de_Corrida_de_Carrinhos_de_Madeira_-_avançado', '1. Ter a especialidade de Corrida de carrinhos de madeira.
2. Conhecer as seguintes regras:
  a) Os carros não devem possuir nenhum tipo de mola de fricção
  b) Não deve haver nenhum outro tipo de peça senão as que compõe o carro
  c) O número oficial deve estar bem visível.
3. Rever o item 3 da especialidade de Corrida de carrinhos de madeira, quanto à segurança no uso das ferramentas.
4. Conhecer as diversas maneiras de preparar e dar acabamento no seu carrinho:
  a) Acabamento com lixa de madeira
  b) Saber como corrigir defeitos da madeira
  c) Aplicar selador no carrinho
  d) Pintar
  e) Acabamento com verniz
  f) Acabamento com tinta esmaltada
  g) Tirar manchas da pintura
  h) Dar acabamento com cera
  i) Acabamento com tinta acrílica
  j) Acabamento com tinta a base d?água
  k) Acabamento em couro
  l) Decoupage
  m) Acabamento com folha de alumínio
5. Saber porque o atrito pode afetar de forma positiva ou negativa o desempenho de seu carrinho.
6. Conhecer e aplicar 3 formas de reduzir o atrito em seu carrinho:
  a) Manter os eixos lubrificados
  b) Design aerodinâmico
  c) Bom acabamento na madeira
  d) Folga nas rodas e eixos adequados
  e) Reduzir o balanço das rodas
7. Conhecer as 3 teorias de distribuição de peso e como elas podem afetar o desempenho do seu carrinho.
8. Projetar e construir um carrinho diferente do construído na especialidade de Corrida de carrinhos de madeira, usando um dos seguintes:
  a) Usar um kit básico com acabamento exterior
  b) Usar um kit luxo com acabamento exterior e adesivos
  c) Usar sua criatividade no acabamento de seu carrinho
9. Ser criativo no seu projeto colocando volante, motorista, adesivos, etc., observando para que não exceda o comprimento máximo nem o peso máximo especificado.
10. Organizar no seu clube, distrito ou região um campeonato de corrida de carrinhos de madeira, utilizando o projeto criado nesta especialidade.
11. Definir desportivismo. Como ele pode e deve ajudar na sua caminhada cristã?'),
('HM-063', 'Scrapbooking', 'artes-e-habilidades-manuais', 'especialidade', 1, 2004, 'Divisão Norte Americana', '/esp/hm-063.webp', 'https://mda.wiki.br/Especialidade_de_Scrapbooking', '1. Qual é a utilidade do scrapbook?
2. O que é journaling?
3. Quais os diferentes tipos de álbum utilizados para scrapbook?
4. Por que deve-se utilizar materiais livre de acidez (acid-free)?
5. Descrever os diferentes tipos de adesivos acid-free disponíveis no mercado.
6. Que ferramenta é utilizada para amolar tesouras e estiletes quando ficam cegos?
7. Citar 5 tipos diferentes de papéis acid-free utilizados para fazer scrapboking.
8. Fazer um scrapbook de, no mínimo, 5 páginas (20X20 cm ou maior) sobre um dos seguintes temas, utilizando papeis coloridos, adesivos, tesouras decorativas, título e journaling:
  a) Ano escolar
  b) Evento esportivo
  c) Férias
  d) Feriados
  e) Projetos
  f) Casamento
  g) Festas de aniversário
  h) Investidura
  i) Campori
  j) Tudo sobre mim (do nascimento até hoje).'),
('HM-064', 'Scrapbooking - avançado', 'artes-e-habilidades-manuais', 'especialidade', 2, 2004, 'Divisão Norte Americana', '/esp/hm-064.webp', 'https://mda.wiki.br/Especialidade_de_Scrapbooking_-_avançado', '1. Ter a especialidade de Scrapbooking.
2. O que é lignina? Por que ela é prejudicial?
3. Que tipo de plástico é seguro para ser utilizado em scrapbooks?
4. Que tipo de plástico não deve ser usado e por que não?
5. Como corrigir um erro escrito no trabalho final?
6. Completar um álbum com, no mínimo, 15 páginas (20x20 cm ou maior) usando as técnicas a seguir:
  a) Adicionar moldura em fotos
  b) Adicionar moldura dupla
  c) Design de bordas
  d) Caixa de texto
  e) Papel colorido
  f) Papel impresso
  g) Layout com duas folhas de papel diferentes
  h) Papel recortado (industrializado)
  i) Papel recortado (feito por você mesmo)
  j) Adesivos
  k) Pockets
  l) Tesouras decorativas
  m) Templates
  n) Fotos cortadas em círculo ou ovais'),
('HM-065', 'Fotografia Digital', 'artes-e-habilidades-manuais', 'especialidade', 2, 2006, 'Divisão Norte Americana', '/esp/hm-065.webp', 'https://mda.wiki.br/Especialidade_de_Fotografia_Digital', '1. Explicar o seguinte:
  a) Os princípios de construção e como funciona uma câmera digital
  b) Citar diferentes tamanhos de sensores e a importância do tamanho do sensores e a importância do tamanho do sensor. O que é fator de corte e qual é o fatos de cada um dos sensores?
  c) Como as imagens coloridas são criadas a partir da imagem do sensor? Explicar, ao menos, 2 maneiras pelas quais essa captura e conversão de cores é feita
  d) O que a lente da câmera faz e o que significa a distância focal
2. Como a abertura do diafragma e a velocidade do obturador estão relacionados?
3. Descrever e explicar a relação entre pixels, resolução e tamanho da imagem.
4. Quais são os dois tipos de compressão de imagem digital?
5. Explicar o que é formato RAW e qual a diferença entre outros formatos comuns.
6. Listar os principais usos da fotografia.
7. Tire fotos ilustrando, pelo menos, 8 das seguintes técnicas. Use imagens para ilustração de comparação:
  a) Enquadramento
  b) Estabilidade da câmera
  c) Direção da iluminação - frontal, lateral ou de fundo
  d) Qualidade da luz - a luz solar, sombra, e hora do dia
  e) Regra dos terços
  f) Ângulo - nível dos olhos, alto e baixo
  g) Nivelamento horizontal
  h) Distância do objeto - preencher o quadro
  i) Utilização de linhas guia
  j) Exposição de luz ? sub exposta, super exposta e corretamente exposta
  k) Uso do flash - distância adequada e atenção a objetos reflexivos
8. Identificar os vários símbolos e ícones presentes em câmeras digitais amadoras.
9. Citar, ao menos, 3 dos modelos de cartão de memória mais comuns utilizados em câmeras digitais.
10. Demonstrar habilidade na transferência de arquivos entre a câmera e um computador, utilizando cabos e conectores.
11. Aprender como colocar fotos em algum programa de criação/edição e exibição de apresentações gráficas. Em seguida, criar uma apresentação gráfica, exibindo as fotos e técnicas do requisito anterior.
12. Utilizando um programa de edição em um computador, demonstrar habilidade em cortar, corrigir a cor, nitidez, e ajustar o brilho/contraste de algumas fotos.
13. Completar, pelo menos, 3 projetos de criação fotográfica diferentes em um programa de edição de fotos, tais como uma capa de CD, capa/página de um álbum de fotos personalizado, montagens, página do livro de atos do clube, etc.
14. Compreender as técnicas de organização de arquivos.'),
('HM-066', 'Genealogia', 'artes-e-habilidades-manuais', 'especialidade', 3, 2006, 'Divisão Sul Americana', '/esp/hm-066.webp', 'https://mda.wiki.br/Especialidade_de_Genealogia', '1. Definir as seguintes palavras:
  a) Genealogia
  b) Ascendente
  c) Descendente
  d) Cônjuge
  e) Irmão
2. Leia a genealogia de Cristo:
  a) Ser capaz de dizer onde encontrá-la no Novo Testamento.
  b) Escrever a genealogia de Cristo, iniciando com Adão.
3. Enumerar cinco maneiras para obter informação da genealogia de uma família.
4. Conhecer, pessoalmente ou pela internet, pelo menos três instituições que ajudam com pesquisas genealógicas.
5. Estude quatro passos importantes para pesquisas genealógicas.
6. Qual é o propósito da documentação?
7. Defina uma fonte primária versus uma fonte secundária para a documentação.
8. Preparar um gráfico da genealogia de sua família contendo quatro gerações, iniciando com você.
9. Listar as maneiras usadas para registrar suas informações genealógicas.
10. Pesquise a história de sua família através de palavras ou escritos com seus familiares mais idosos. Pergunte o seguinte:
  a) Qual a sua primeira memória?
  b) Quando e onde você nasceu?
  c) Qual a primeira igreja que você lembra ter frequentado?
  d) Nome de escolas, e localização, que você frequentou?
  e) Onde você vivia quando tinha dez e quatorze anos de idade?
  f) De qual país seus ancestrais imigraram?
  g) Quando e onde você estava quando se casou?
  h) Se você tiver filhos, por favor, qual o nome deles, local e data de nascimento.
  i) No final, escrever um agradecimento a seu parente pelo tempo e inclua uma foto sua e pergunte se ele estaria disposto a compartilhar a cópia de uma foto antiga com você.
11. Faça um histórico de sua vida incluindo:
  a) Gráfico genealógico
  b) Registros que pertençam à sua vida
  c) Fotografias
  d) Histórias
  e) Compartilhe isto com seu grupo, clube e amigos de escola
12. Ter a Cópia de pelo menos 7 registros civis (identidade, certidão de nascimento, casamento, óbito, etc.) de membros da sua família. Obs.: Os seus registros e os dos seus irmãos não contam.
13. Visitar um cemitério e ler o que foi copiado sobre a lápide:
  a) O nome de três diferentes famílias.
  b) A data de nascimento e morte dos membros destas famílias.
  c) A média de tempo de vida dos membros desta família.'),
('HM-067', 'Plástico Canvas', 'artes-e-habilidades-manuais', 'especialidade', 1, 2006, 'Divisão Norte Americana', '/esp/hm-067.webp', 'https://mda.wiki.br/Especialidade_de_Plástico_Canvas', '1. O que é plástico canvas?
2. Citar 4 tipos de plástico canvas e descrever brevemente a utilidade de cada um deles.
3. Quais os tipos de fios mais adequados para bordar no plástico canvas?
4. Demonstrar como utilizar fios de diferentes espessuras.
5. Qual o tipo de agulha utilizada para trabalhar com plástico canvas? Demonstrar qual tamanho de agulha se adapta a cada tipo de plástico canvas.
6. Que instrumentos são utilizados para cortar o plástico canvas? Como deve ser feito o corte nos trabalhos?
7. Saber 10 tipos de pontos utilizados em trabalhos com plástico canvas e fazer uma amostra de cada um deles.
8. Fazer 2 dos seguintes itens, utilizando 3 pontos diferentes em cada modelo.
  a) Marca páginas
  b) Ímã de geladeira
  c) Enfeite de natal
  d) Moldura para quadro
  e) Descanso para copos
9. Fazer 1 dos seguintes itens, utilizando, ao menos, 4 pontos diferentes.
  a) Caixa
  b) Tapete
  c) Bolsa'),
('HM-068', 'Quilling', 'artes-e-habilidades-manuais', 'especialidade', 2, 2006, 'Divisão Norte Americana', '/esp/hm-068.webp', 'https://mda.wiki.br/Especialidade_de_Quilling', '1. Listar os materiais necessários para fazer quilling.
2. Listar 3 tipos de papel usados para fazer quilling. Demonstrar para quais técnicas são mais adequados e mencionar suas vantagens e desvantagens.
3. Executar corretamente cada um dos seguintes itens:
  a) Círculo apertado
  b) Círculo solto
  c) Gota
  d) Chama
  e) Folha
  f) Variação de folha
  g) Lua crescente
  h) Quadrado
  i) Retângulo
  j) Triângulo
  k) Orelha de coelho
  l) Meio círculo
  m) Seta
  n) Azevinho
4. Executar corretamente cada um dos seguintes itens:
  a) Rolinho aberto
  b) Coração aberto
  c) Letra V enrolada
  d) Letra S enrolada
  e) Letra C enrolada
5. Fazer um quadro demonstrando todas as formas aprendidas.
6. Fazer um motivo floral simples utilizando uma das formas aprendidas.
7. Fazer um cartão ornamentado com quilling.'),
('HM-069', 'Quilling - avançado', 'artes-e-habilidades-manuais', 'especialidade', 1, 2006, 'Divisão Norte Americana', '/esp/hm-069.webp', 'https://mda.wiki.br/Especialidade_de_Quilling_-_avançado', '1. Ter a especialidade de Quilling.
2. Executar corretamente cada uma das técnicas a seguir:
  a) Flor com franja
  b) Rolo uva
  c) Espiral
  d) Técnica Husking
  e) Técnica frame
  f) Rosa dobrada (Curled Flowers)
  g) Rosa curvada (Folded Roses)
  h) Rosa espiral (spiral rose)
  i) Tulipa (duck leg)
  j) Tiras trançadas (Weaving Paper)
3. Demonstrar como usar corretamente:
  a) Gabarito de círculos
  b) Papel milimetrado
  c) Gráfico polar
4. Demonstrar como impermeabilizar um trabalho em quilling e mencionar os cuidados para a conservação do trabalho.
5. Fazer 3 formas diferentes mesclando as cores.
6. Fazer uma ferramenta artesanal para quilling e utilizá-la no cumprimento dos requisitos abaixo.
7. Representar 4 dos seguintes animais usando as técnicas de sua preferência:
  a) Coelho
  b) Abelha
  c) Tucano
  d) Gato
  e) Urso
  f) Cachorro
  g) Leão
  h) Cisne
  i) Borboleta
8. Fazer os seguintes trabalhos em quilling:
  a) Cartão
  b) Personalizar uma capa de caderno
  c) Decorar a tam pa de uma caixa
  d) Porta retrato'),
('HM-070', 'Tie-dye', 'artes-e-habilidades-manuais', 'especialidade', 1, 2006, 'Divisão Norte Americana', '/esp/hm-070.webp', 'https://mda.wiki.br/Especialidade_de_Tie-dye', '1. Saber quais são os melhores tipos de materiais para se trabalhar com tie-dye. Saber como prepará-los para se iniciar os trabalhos.
2. Qual a função da soda cáustica no tie-dye? Por quanto tempo o tecido deve ficar de molho?
3. Saber a função da ureia usada no corante.
4. Quais equipamentos de segurança devem ser usados enquanto se tinge uma peça? Por quê?
5. Quais são as 3 cores primárias?
6. Descrever quais cores primárias de corante devem ser misturadas para dar origem às cores secundárias a seguir: laranja, verde e roxo.
7. Descrever o resultado de se misturar 2 cores secundárias.
8. Usando um lenço de tecido e um marcador colorido, demonstrar 2 tipos diferentes de estampa que podem ser feitos em uma camiseta.
9. Depois de ver os resultados de diferentes combinações de cores no tecido, amarrar e tingir uma das seguintes peças: bandana, camiseta, capa de almofada, etc. Lembrar-se que não há 2 colorações idênticas, cada uma será única.
10. Demonstrar os itens tingidos ao seu instrutor.'),
('HM-071', 'Apitos', 'artes-e-habilidades-manuais', 'especialidade', 1, 2007, 'Divisão Norte Americana', '/esp/hm-071.webp', 'https://mda.wiki.br/Especialidade_de_Apitos', '1. Relatar brevemente a história dos apitos e dizer por que eles foram inventados.
2. Explicar a importância da conservação ambiental durante a fabricação de um apito
3. Relacionar o uso sustentável de madeiras protegidas pela lei e a fabricação de apitos.
4. Listar cinco árvores de onde podem ser tiradas boas madeiras para a fabricação de um apito e por que.
5. Fazer uma breve descrição sobre os seguintes estilos de apitos:
  a) Apitos de tubo
  b) Flauta pan
  c) Flauta
  d) Pífaro.
6. Nomear 5 tipos de apitos modernos e seus usos.
7. Qual instrumento musical moderno é um apito sofisticado?
8. Como um apito funciona?
9. Qual o equipamento mais comum usado para a fabricação de apitos?
10. Explicar a importância da grã da madeira ao talhar um apito.
11. Por que o tamanho dos buracos e da câmara de ar têm que ser proporcionais ao fluxo de ar?
12. Como afinar um apito?
13. Demonstrar como apitar usando as duas mãos e um pedaço de grama.
14. Demonstrar a técnica e assobiar usando apenas as mãos.
15. Revisar e demonstrar as regras de segurança para o uso de uma faca ou canivete.
16. Saber como afiar um canivete usando uma pedra de amolar.
17. Faça dois dos seguintes apitos:
  a) Flauta pan ou apito de tubo
  b) Flauta
  c) Pífaro
18. Aprender como tocar uma música simples em algum apito que você fabricou.'),
('HM-072', 'Apitos - avançado', 'artes-e-habilidades-manuais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/hm-072.webp', 'https://mda.wiki.br/Especialidade_de_Apitos_-_avançado', '1. Ter a especialidade de Apitos.
2. O que é um apito de êmbolo e quem criou este tipo de apito?
3. O que acontece quando o galho para fabricação com apito de êmbolo é muito grande ou muito pequeno?
4. O que é uma flauta doce?
5. Fazer os seguintes apitos:
  a) Apito de êmbolo
  b) Flauta doce
6. Demonstrar sua habilidade no uso correto de cada um dos apitos que você fabricou.'),
('HM-073', 'Faróis', 'artes-e-habilidades-manuais', 'especialidade', 1, 2007, 'Divisão Norte Americana', '/esp/hm-073.webp', 'https://mda.wiki.br/Especialidade_de_Faróis', '1. Responder as seguintes questões relacionadas a faróis:
  a) Qual a função de um farol?
  b) Quais os primeiros faróis construídos de que se tem registro?
  c) Qual o nome do farol mais famoso do mundo antigo?
  d) Como é chamada a pessoa que estuda faróis?
  e) Todos os faróis têm um zelador? Se não, como eles funcionam de forma autônoma?
2. Fazer uma pesquisa sobre a estrutura e funcionamento das lentes de Fresnel e explique por que são tão eficazes.
3. Quais combustíveis têm sido usados em faróis no decorrer da história?
4. Todos os faróis ficam localizados próximos das costas oceânicas? Se não, liste outras localidades onde os faróis podem ser encontrados.
5. Como é chamado o indivíduo que trabalha em faróis no seu país? Qual órgão do governo é responsável pela manutenção e fiscalização dos faróis em seu país?
6. Os faróis que são visíveis no mar durante o dia possuem uma pintura específica em sua construção. Como essa pintura é chamada?
7. O que é um dispositivo de aviso sonoro de nevoeiro? Por que são usados em faróis? Quais são as 3 coisas que interferem em quão longe o aviso sonoro pode ser ouvido?
8. Uma vez que os faróis são comumente identificados por uma luz, pesquise o significado de Luz na Bíblia completando o seguinte:
  a) Encontre o tema "Luz" numa concordância bíblica, ler os textos relacionados e participar de uma discussão sobre o significado da luz na Bíblia
  b) Explicar por que a palavra de Deus pode ser comparada a um farol
  c) Memorizar e explicar o significado de João 8:12
9. Quais outros dispositivos em que a tecnologia de lentes Fresnel é usada?'),
('HM-074', 'Faróis - avançado', 'artes-e-habilidades-manuais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/hm-074.webp', 'https://mda.wiki.br/Especialidade_de_Faróis_-_avançado', '1. Ter a especialidade de Faróis.
2. Fazer um scrapbook, incluindo o seguinte:
  a) Fotos, impressões, cartões postais ou desenhos de 25 faróis com uma legenda contendo a localização, ano de construção, se ativo ou não ativo e a ordem das lentes. Pelo menos 5 das fotos devem ser tiradas por você.
  b) Um resumo da história de cada um dos faróis.
  c) Desenhos, fotos e as respostas de todos os requisitos desta especialidade.
3. Qual o nome do inventor da lente de Fresnel? Em que país e ano ela foi desenvolvida?
4. Demonstrar em um desenho:
  a) Como os prismas das lentes de Fresnel são usados para concentrar a luz
  b) O formato de uma lente olho de boi e descrever o seu propósito
5. Fazer um gráfico listando todos os tipos de lente de Fresnel, indicando:
  a) Ordem e classificação por tamanho
  b) O nome de, pelo menos, 1 farol que usa cada tipo de lente
6. Pesquise e descreva a história do mecanismo de rotação das lâmpadas.
7. Faça uma representação gráfica de 6 faróis, demonstrando as características de sua Luz noturna e diurna.
8. O que é um barco-farol? Por que e quando um barco farol é necessário?
9. Leia sobre faroleiros e liste alguns dos perigos que eles enfrentam para cumprir suas tarefas.
10. Procure citações de Ellen White que mencionem faróis e participe de uma discussão em grupo sobre o significado desses textos. Inclua uma cópia dessas citações no scrapbook que você criou o requisito 2.
11. Construa um modelo em miniatura de um farol verdadeiro, feito em madeira ou outro material resistente. Saiba o nome, localidade e a data em que o verdadeiro farol foi originalmente construído.'),
('HM-075', 'Balões de Ar Quente', 'artes-e-habilidades-manuais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/hm-075.webp', 'https://mda.wiki.br/Especialidade_de_Balões_de_Ar_Quente', '1. Descreva o papel que cada uma das personalidades abaixo teve no desenvolvimento de balões voadores:
  a) Joseph Michel Montgolfier e Jacques-Etienne Montgolfier
  b) Jean Francois Pilatre de Rozier e Francois Laurent Marquis d?Arlandes
  c) Jacques Alexandre Cesar Charles e Nicolas Louis Robert
  d) Ben L. Abruzzo, Maxie L. Anderson e Larry Newman
  e) Bertrand Piccard e Brian Jones
  f) (Os brasileiros) padre Bartolomeu de Gusmão e Alberto Santos Dumont
2. Cite o princípio de Arquimedes e descreva sucintamente como esse princípio se aplica às seguintes situações:
  a) Um pedaço de cortiça flutuando num recipiente com água
  b) Um barco flutuando no oceano
  c) Um balão de ar quente flutuando na atmosfera
3. Desenhar uma tabela que demonstre a composição do ar com informações de peso e volume.
4. Desenhar uma tabela que demonstre a comparação do número atômico, peso atômico e densidade dos componentes:
  a) Hidrogênio
  b) Hélio
  c) Oxigênio
5. Cite os 2 gases que são usados em balões a gás.
6. Explique como calor/temperatura afetam a densidade do ar e como isso faz com que os balões de ar quente voem.
7. Explique o a função de cada um dos itens abaixo na estrutura e no vôo de um balão de ar quente:
  a) Envelope de balão
  b) Maçarico
  c) Cesto
  d) Cilindro
  e) Ventoinha
8. Cite 2 materiais que podem ser usados na confecção do envelope de um balão de ar quente e compare as vantagens e desvantagens entre eles, devido a suas propriedades físicas.
9. Descreva como balões voadores foram úteis em:
  a) Campanhas militares
  b) Pesquisas científicas
10. A que horas do dia costumam acontecer os voos de balões esportivos? Explique o porquê.
11. Descreva como o piloto controla os movimentos verticais dos seguintes balões:
  a) Balão de ar quente
  b) Balão a gás
12. Descreva como o piloto controla os movimentos horizontais de um balão.
13. Faça uma pesquisa de, no mínimo, 250 palavras sobre a legislação para balões não tripulados em seu país.'),
('HM-076', 'Origami - avançado', 'artes-e-habilidades-manuais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/hm-076.webp', 'https://mda.wiki.br/Especialidade_de_Origami_-_avançado', '1. Ter a especialidade de Origami.
2. Definir quais os são os principais tipos de origami e a diferença entre eles.
3. Dobrar 2 origamis diferentes pra cada uma das categorias a seguir:
  a) Origami Modular
  b) Kusudama
  c) Block Folding
  d) Origami Tesselation
4. Definir o que é padrão de dobras (Crease Pattern) e como se dobra um origami a partir dele.
5. Ilustrar uma história da Bíblia usando vários modelos de origami.
6. Ter uma coleção pessoal de pelo menos 20 diagramas de origami ou um livro contendo 20 ou mais diagramas para dobrar.'),
('HM-077', 'Embalagem', 'artes-e-habilidades-manuais', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/hm-077.webp', 'https://mda.wiki.br/Especialidade_de_Embalagem', '1. Quando, onde e como surgiram as primeiras ideias a respeito de embalagem?
2. Defina o que é embalagem? Cite algumas matérias-primas que podemos usar para se fazer uma embalagem bonita e criativa?
3. Qual a importância da embalagem para a nossa vida cotidiana?
4. Oque é reciclagem? Como a embalagem se relaciona com a reciclagem?
5. Cite alguns equipamentos necessários para uma boa embalagem?
6. Fazer três embalagens com os objetos a seguir, usando métodos e formas diferentes para cada um:
  a) Papel Cartão, Jornal, Presente, Misto, Laminado, etc.
  b) Papelão
  c) Plástico
  d) TNT
  e) Tecido
  f) Couro
  g) Material de sua escolha'),
('HM-078', 'E.V.A.', 'artes-e-habilidades-manuais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/hm-078.webp', 'https://mda.wiki.br/Especialidade_de_E.V.A.', '1. O que é E.V.A.?
2. Quais são as principais características e utilidades do E.V.A.?
3. Quais os materiais utilizados para cortar e colar E.V.A.?
4. Qual ferramenta é mais adequada para se desenhar em um E.V.A.?
5. Explicar qual o procedimento de transferir moldes para o E.V.A.
6. Quais são as vantagens e desvantagens que o E.V.A. pode trazer para o meio ambiente?
7. Fazer 3 objetos confeccionados com E.V.A. e utilizá-los em algum departamento da igreja.
8. Escolher e fazer um dos itens abaixo (deve ser diferente dos itens feitos no requisito anterior):
  a) Flor ornamental
  b) Porta canetas
  c) Capa para livros
  d) Imã de geladeira
  e) Porta toalhas
  f) Chaveiro
  g) Porta retrato
  h) Objeto de sua escolha'),
('HM-079', 'Desenho vetorial', 'artes-e-habilidades-manuais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/hm-079.webp', 'https://mda.wiki.br/Especialidade_de_Desenho_vetorial', '1. O que é desenho vetorial?
2. Cite 3 programas especializados em desenho vetorial.
3. Cite os 5 formatos mais comuns de imagens vetoriais.
4. Quais as diferenças entre desenho vetorial e raster?
5. Explicar como o desenho vetorial pode manter a qualidade quando ampliado.
6. O que é Curva de Bézier? Qual sua importância para a estrutura de desenho vetorial?
7. Quais as principais diferenças entre um editor de imagem bitmaps e um editor de imagem vetorial? Citar 2 exemplos de cada tipo de editor.
8. Escolher um programa de desenho vetorial, explicar o porquê de tê-lo escolhido e, em seguida, demonstrar ao seu instrutor:
  a) 5 ou mais atalhos de mouse e/ou teclado, dentro do programa escolhido
  b) Apresentar e demonstrar o uso de, pelo menos, 20 ferramentas diferentes.
9. Completar 3 dos seguintes desenhos:
  a) O emblema Dl do Clube de Desbravadores, mostrando o uso de linhas guia e régua
  b) Um desenho de sua escolha, mostrando o uso da ferramenta "mãos livres"
  c) Um animal, mostrando o uso de detalhes
  d) Um banner, faixa ou cartaz de divulgação de algum evento de seu Clube ou Igreja
  e) Transformar uma foto de um rosto em um desenho vetorial, utilizando as ferramentas necessárias como rastreador de bitmap, filtro de transparência, etc.
  f) O emblema do clube e/ou unidade.
10. Submeter os desenhos feitos no cumprimento dessa especialidade à avaliação de profissionais da área. Após o cumprimento da atividade, apresentar a seu instrutor os comentários, avaliações e propostas feitas pelos profissionais de alteração em seu desenho.'),
('HM-080', 'Fuxico', 'artes-e-habilidades-manuais', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/hm-080.webp', 'https://mda.wiki.br/Especialidade_de_Fuxico', '1. Definir o que é fuxico? Qual a origem desta arte?
2. Qual o principal objetivo da arte do fuxico?
3. Explicar as etapas da técnica do fuxico.
4. Que materiais e equipamentos são necessários para a realização do fuxico?
5. Demonstrar e exemplificar as seguintes bases do fuxico?
  a) Base Tradicional
  b) Base de Bico
  c) Base Invertida
6. Escolher 2 dos objetos a seguir, e confeccioná-los colocando em prática as bases citadas no item 5 desta especialidade:
  a) Elástico para cabelo ou presilha
  b) Tapete
  c) Chaveiro
  d) Imã de geladeira
  e) Bolsa
  f) Chinelo ou sandália
  g) Objeto de sua escolha'),
('HM-081', 'História em Quadrinhos', 'artes-e-habilidades-manuais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/hm-081.webp', 'https://mda.wiki.br/Especialidade_de_História_em_Quadrinhos', '1. Escrever um relatório sobre história em quadrinhos, contendo seus principais fatos históricos, características e personagens, explicando porque ela é considerada a Nona Arte.
2. O que é uma tirinha/tira?
3. Descrever como elaborar um roteiro de uma história para HQ, citando e explicando quais seus principais passos e técnicas.
4. Montar um banco de imagens mostrando, no mínimo, 5 diferentes estudos e/ou traços de anatomia das personagens. Escolher um deles para apresentar uma série de diferentes posições desenhadas por você mesmo, utilizando personagens masculinos e femininos.
5. Explicar e dar exemplos desenhados a próprio punho dos seguintes itens:
  a) Pré-produção, produção e pós-produção.
  b) Composição: design de página, quadro, cena, adequação narrativa.
  c) Elementos gráficos de texto: recordatórios, balões, onomatopeias, "letreiramento", tipologia.
  d) Arte-final: tradicional, tratamentos especiais, técnicas mistas.
6. Criar uma personagem que será um dos 12 discípulos e escrever uma história de, pelo menos, 30 quadros sobre sua viagem missionária.
7. Montar uma HQ contando a história da Turma do Nosso Amiguinho, contendo autor, personagens e outras informações pertinentes.
8. Desenhar uma tirinha sobre um fato engraçado ocorrido no seu Clube ou unidade.
9. Criar uma capa colorida em tamanho A3 na linguagem HQ para o livro missionário do ano.'),
('HM-082', 'Ornamentação', 'artes-e-habilidades-manuais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/hm-082.webp', 'https://mda.wiki.br/Especialidade_de_Ornamentação', '1. Debater com o seu grupo sobre a importância de ornamentar ambientes onde serão realizados eventos especiais e como esse costume se relaciona com a valorização das pessoas convidadas para a programação.
2. Listar e explicar as várias formas de utilizar em ornamentação os seguintes itens:
  a) 5 espécies de plantas ornamentais
  b) 3 maneiras diferentes de expor fotografias do Clube
  c) 5 diferentes tipos de artesanato/habilidades que podem ser feitos pelo Clube
  d) 5 coleções distintas
  e) Banners e painéis
  f) 4 diferentes modelos de balões (bexigas)
  g) Tecidos, TNT, emborrachados, etc.
3. Durante o cumprimento desta especialidade, observar, ao menos, 5 ornamentações em programações promovidas por diferentes departamentos de sua Igreja ou Campo. Apresentar ao seu instrutor um relatório de suas observações (se possível, com fotografias), analisando os pontos positivos e negativos de cada uma e como poderiam ser melhoradas.
4. Ter um caderno com desenhos de ornamentação. Para cada desenho, fazer uma lista de todos os materiais necessários, orçamento, tempo estimado, etc. O caderno deverá ter, ao menos, 7 dos seguintes motivos de orna mentação:
  • Em sua Igreja
    1. Programa regular, noturno, realizado pelos desbravadores
    2. Programa especial de investidura
    3. Batismo de desbravadores
    4. Patriótico (independência, bandeira, etc.)
    5. Dia dos Desbravadores
  • Na sede (escola, ginásio, etc.) do seu Clube
    1. Programa de abertura do ano letivo
    2. Gincana ou dia esportivo
    3. Programa de recepção dos pais
    4. Programa pré-acampamento
    5. Um programa/evento de sua escolha, aprovado pelo instrutor
5. Realizar, ao menos, 4 das ornamentações contidas no caderno de desenhos pedido no requisito anterior. Apresentar fotografias dessas ornamentações ao instrutor.'),
('HM-083', 'Papercraft', 'artes-e-habilidades-manuais', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/hm-083.webp', 'https://mda.wiki.br/Especialidade_de_Papercraft', '1. Definir papercraft ou papel modelismo.
2. Listar, ao menos, 3 modalidades de papercraft.
3. Quais são os materiais necessários para fazer os modelos de papel?
4. Quais são as gramaturas mais indicadas para imprimir/desenhar os modelos? Por que papel couchê ou fotográfico não devem ser utilizados?
5. Quais são os melhores tipos de impressora/estilo de impressão para que os modelos tenham alta qualidade?
6. Definir os seguintes termos:
  a) Tabs ou flaps
  b) Fold lines
  c) Laminação
7. Construir 2 dos modelos a seguir:
  a) Meio de transporte (carro, avião, navio, etc.)
  b) Construção (casa, prédio, ponte, etc.)
  c) Animal
  d) Pessoa ou personagem
  e) Instrumentos musicais
8. Construir um cenário bíblico ou um cenário para um história/estória com fundo moral (pode ser de criação sua ou adquirido em revistas ou na internet). Utilizar os modelos para apresentar um devocional para sua unidade ou classe da escola sabatina.'),
('HM-084', 'Papel Machê', 'artes-e-habilidades-manuais', 'especialidade', 1, null, 'Divisão Centro-Oeste Africana', '/esp/hm-084.webp', 'https://mda.wiki.br/Especialidade_de_Papel_Machê', '1. Defina o que é a técnica do papel maché, onde teve origem essa arte.
2. O que é Papietagem? Como a papietagem se relaciona ao papel machê?
3. Dar o nome de algumas bases que podem ser feitas no papel machê.
4. Cite 2 tipos de papel machê e explicar como prepará-los.
5. Saber quais ingredientes são utilizados para a fabricação do papel machê.
6. Como conservar a massa e a polpa do papel machê?
7. Que materiais são utilizados para dar formas aos objetos feitos com papel machê?
8. Fazer 2 objetos usando as técnicas do papel machê. Pintar e envernizar os mesmos.'),
('HM-085', 'Pirografia', 'artes-e-habilidades-manuais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/hm-085.webp', 'https://mda.wiki.br/Especialidade_de_Pirografia', '1. Definir o que é pirografia. Qual a origem dessa arte milenar?
2. Que ferramentas e equipamentos são necessários para a pirografia?
3. Descrever, passo a passo, os procedimentos adequados para trabalhos em pirografia.
4. Mencionar alguns materiais onde a técnica da pirografia pode ser usada. Praticar o uso do pirógrafo em algum desses materiais.
5. Explicar como a temperatura pode influenciar no bom andamento do trabalho na pirografia.
6. Que cuidados e precauções devem ser tomados ao trabalhar com pirografia?
7. Fazer um desenho para cada um dos temas abaixo, em qualquer material de sua escolha:
  a) Animal
  b) Flor
  c) Paisagem'),
('HM-086', 'Plastimodelismo', 'artes-e-habilidades-manuais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/hm-086.webp', 'https://mda.wiki.br/Especialidade_de_Plastimodelismo', '1. Saber explicar e seguir um mapa de montagem de um kit de plastimodelismo.
2. Escolher e montar um kit de plastimodelismo. Ex: aviões, navios, carros, etc. Esse kit não poderá ser usado em outras especialidades de modelismo (ferreomodelismo, automodelismo, etc.).
3. Saber usar ferramentas para auxílio na montagem de um kit (lixas, pinças, lupas, pincéis apropriados, colas, etc.).
4. Colorir corretamente seu modelo, segundo o padrão original ou cores indicadas pelo fabricante.
5. Saber adesivar corretamente seu kit.
6. Fazer uma pesquisa sobre o original do modelo montado e depois responda o seguinte:
  a) Ano em que o original foi fabricado
  b) País fabricante ou originário
  c) Usos principais do veículo e história
  d) Curiosidades, se houver
  e) Significado das cores e símbolos, se houver'),
('HM-087', 'Violão', 'artes-e-habilidades-manuais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/hm-087.webp', 'https://mda.wiki.br/Especialidade_de_Violão', '1. Pesquisar sobre a história do violão e como ele chegou ao seu país?
2. Saber as diferenças entre melodia, harmonia e ritmo.
3. Diferenciar 3 tipos de violão, conforme cada grupo abaixo:
  a) Acústicos
  b) Elétricos
  c) Mais de 6 cordas
4. Conhecer as 3 divisões do violão e identificar 15 diferentes partes, explicando a função de cada uma.
5. Qual a postura correta para a prática do violão? Qual a importância de manter essa postura?
6. Saber os nomes dos dedos, cordas e posição das mãos.
7. O que são cifras e como são construídas? Escrever, de memória, uma lista contendo todos os acordes maiores e menores e suas determinadas cifras.
8. Os que são bemol e sustenido? Qual a diferença entre eles e como são representados em cifra?
9. Explicar o que são acordes. Demonstrar habilidade em executar de memória os acordes maiores e menores.
10. Definir a diferença entre cordas de náilon e aço e explicar a sua preferência por uma delas.
11. Executar uma música utilizando uma técnica de batida e outra utilizando um dedilhado.
12. Selecionar 3 músicas adventistas de cifras simples e tocá-las em uma reunião oficial do Clube ou unidade.'),
('HM-088', 'Violão - avançado', 'artes-e-habilidades-manuais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/hm-088.webp', 'https://mda.wiki.br/Especialidade_de_Violão_-_avançado', '1. Ter a especialidade de Violão.
2. Explicar o que são e como são formadas as tríades.
3. Saber montar notas derivadas a partir das tríades das notas maiores.
4. Explicar como realizar 2 diferentes métodos de afinação de violões.
5. O que é tablatura e como se lê uma?
6. Identificar os seguintes sinais utilizados em cifras:
  a) #
  b) B
  c) 6, 7, etc.
  d) 9m, 7m, etc.
  e) 5+, 11+, etc.
  f) dim (º)
7. Escolher 5 músicas do hinário que apresentem sinais do requisito anterior e tocá-las em um culto, reunião do Clube ou unidade, pequeno grupo ou JA.
8. Demonstrar como subir o tom (fazer a transposição de tonalidade) de uma música para adaptá-la ao alcance vocal do cantor.
9. Por que não existem as cifras Mi# e Si#?
10. O que são e qual a diferença entre acordes consonantes e dissonantes?
11. Conhecer, pelo menos, 2 escalas para solo (ex. pentatônica) e demonstrá-las no violão.
12. Montar uma pasta com mais de 30 músicas adventistas cifradas.
13. Cumprir o seguinte:
  a) Demonstrar capacidade de tocar uma melodia simples lendo uma partitura musical
  b) Saber os nomes das notas de todas as cordas até a 5º casa
  c) Executar as escalas diatônicas de Dó, Ré, Fá e Sol.'),
('HM-089', 'Amigurumi', 'artes-e-habilidades-manuais', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/hm-089.webp', 'https://mda.wiki.br/Especialidade_de_Amigurumi', '1. Explicar qual a origem do amigurumi.
2. Saber identificar o melhor tipo de fio e TEX adequada pra a confecção do amigurumi.
3. Identificar e exemplificar os modelos de agulhas para Amigurumi.
4. Qual a importância dos marcadores e da agulha de tapeçaria.
5. Explicar quais tipos de olhos, nariz e boca existem para a confecção de um amigurumi.
6. Dizer qual o material mais indicado para o enchimento.
7. Saber executar os seguintes pontos:
  a) Anel mágico;
  b) Ponto baixo;
  c) Aumento em ponto baixo;
  d) Diminuição em ponto baixo.
  e) Executar um dos seguintes amigurumis: chaveiro, fruta, almofada ou pingente.
  f) Confeccionar um amigurumi, de no mínimo 30 cm, com três ou mais cores diferentes e aplicar olhos, nariz e boca.
  g) Confeccionar um amigurumi em tricô, da sua preferência.
  h) Saber calcular e precificar um amigurumi de forma que possa ajudar na renda familiar.'),
('HM-090', 'Arte Digital', 'artes-e-habilidades-manuais', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/hm-090.webp', 'https://mda.wiki.br/Especialidade_de_Arte_Digital', '1. O que é a arte digital e por que ela pode ser chamada de arte eletrônica?
2. Fazer uma pesquisa sobre a história da arte digital.
3. Qual é o perfil do artista digital?
4. Quais carreiras um artista digital pode seguir?
5. Por que a arte digital é multidisciplinar?
6. Explicar os tipos de arte digital abaixo:
  a) Fractal;
  b) Interativa;
  c) Imersiva.
7. Por que a arte digital é tão abrangente e diversificada.
8. Apresentar as imagens de, pelo menos, 5 artes digitais e dizer o nome do autor e da obra.
9. Explicar cada uma das categorias de arte digital abaixo:
  a) Pintura digital;
  b) Digigravura;
  c) Modelagem digital;
  d) Fotografia digital;
  e) Animação digital;
  f) Vídeo digital;
  g) Ciberart;
  h) Arte digital 2D;
  i) Arte digital 3D;
  j) Pixel art;
  k) Desenho vetorial;
  l) Outra forma de arte digital de sua escolha.
10. Como as comunidades virtuais contribuem para a divulgação da arte digital?
11. Por que a arte digital só pode ser entendida no âmbito da arte contemporânea?
12. Como a fusão de arte, ciência e tecnologia tem contribuído para a ampliação da arte digital?
13. Fazer 2 dos projetos digitais abaixo. Os projetos precisam ser 100% de sua autoria:
  a) Desenho vetorial;
  b) Fotografia digital;
  c) Vídeo digital;
  d) Animação digital.'),
('HM-091', 'Lettering', 'artes-e-habilidades-manuais', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/hm-091.webp', 'https://mda.wiki.br/Especialidade_de_Lettering', '1. O que é lettering e qual o significado desta palavra?
2. Quais são os passos básicos para se fazer lettering?
3. Saber a diferença entre lettering e caligrafia.
4. Quais são os materiais necessários para a técnica do lettering?
5. Por que a técnica do lettering é considerada uma arte?
6. Quais softwares e aplicativos (apps) são usados para criar lettering?
7. Quais tipos de trabalhos podem ser feitos com lettering?
8. Explicar o que é a técnica do lettering em quadro-negro?
9. Para que serve o sketchbook, com relação a produção de lettering?
10. Por que é imprescindível fazer o esboço dos trabalhos em lettering?
11. Fazer um dos seguintes letterings:
  a) Seu nome completo;
  b) Um convite de aniversário ou de casamento;
  c) Uma frase famosa;
  d) Um versículo bíblico;
  e) Uma carta com a promessa da volta de Jesus para um amigo do clube.')
on conflict (codigo) do update set nome = excluded.nome, categoria_slug = excluded.categoria_slug, tipo = excluded.tipo, nivel = excluded.nivel, ano = excluded.ano, origem = excluded.origem, imagem = excluded.imagem, url_mda = excluded.url_mda, requisitos = excluded.requisitos;

insert into public.especialidades (codigo, nome, categoria_slug, tipo, nivel, ano, origem, imagem, url_mda, requisitos) values
('AA-001', 'Avicultura', 'atividades-agricolas', 'especialidade', 2, 1928, 'Associação Geral', '/esp/aa-001.webp', 'https://mda.wiki.br/Especialidade_de_Avicultura', '1. Ter a especialidade de Aves domésticas.
2. Identificar, por meio de imagens, e conhecer de forma geral o uso de:
  a) Incubadoras
  b) Poleiros
  c) Aviários
  d) Bebedouros
  e) Comedouros
  f) Ninhos
3. Identificar ao vivo ou a partir de fotos, pelo menos, 2 raças das seguintes espécies, destacando sua respectiva aptidão (carne, ovos, penas e ou pele):
  a) Pato
  b) Frango
  c) Ganso
  d) Codorna
  e) Peru
4. Descrever um programa de alimentação para aves domésticas, desde a eclosão dos ovos até a fase adulta.
5. Apresentar um relatório destacando os principais problemas de saúde que atingem as aves, apontando os sintomas e sinais, bem como preveni-los e tratá-los.
6. Qual a temperatura, umidade e número de dias necessários para chocar os seguintes ovos:
  a) Pato
  b) Frango
  c) Ganso
  d) Codorna
  e) Peru
7. Ser capaz de examinar, testar e acondicionar ovos para o mercado e/ou para o consumo doméstico.
8. Criar até seu completo desenvolvimento uma ninhada de, pelo menos, 6 aves de sua escolha.
9. Apresentar um relatório escrito de, no mínimo, 300 palavras, ou oral de 5 minutos sobre a importância da avicultura e referir suas principais características.
10. Visitar uma propriedade rural onde se pratica a criação de aves para uso próprio ou comércio e elaborar um relatório de, pelo menos, 300 palavras destacando as principais atividades desenvolvidas ali, bem como sobre a sua experiência vivida para o cumprimento dos requisitos desta especialidade.'),
('AA-002', 'Jardinagem e Horticultura', 'atividades-agricolas', 'especialidade', 1, 1928, 'Associação Geral', '/esp/aa-002.webp', 'https://mda.wiki.br/Especialidade_de_Jardinagem_e_Horticultura', '1. Preparar o solo e plantar um jardim ou horta. Cultivar, pelo menos, seis plantas diferentes: 3 a partir de sementes e 3 a partir de mudas.
2. Descrever formas de controlar insetos e outras pragas em sua horta ou jardim. Saber quando usar inseticidas e fungicidas e as regras de segurança que devem ser seguidas no manejo.
3. Por que e em que situações usa-se a palha ou terra para cobrir certos tipos de vegetação?
4. O que é uma planta resistente? Que plantas são consideradas resistentes em sua região?
5. Descrever ao menos 3 tipos diferentes de irrigação.
6. Completar uma das alternativas a seguir:
  a) Testar a germinação de 50 sementes do mesmo tipo
  b) Fazer e usar um viveiro ou estufa. Explicar os benefícios de estufa.
  c) Cultivar três verduras ou legumes, de sua escolha, que possam ser vendidos ou doados a pessoas necessitadas.'),
('AA-003', 'Agricultura Familiar de Subsistência', 'atividades-agricolas', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/aa-003.webp', 'https://mda.wiki.br/Especialidade_de_Agricultura_Familiar_de_Subsistência', '1. Participar na elaboração de uma horta cumprindo os seguintes requisitos:
  a) Escolha do local
  b) Limpeza da área, incluindo a eliminação das ervas daninhas
  c) Preparo do solo para o cultivo
  d) Realizar o plantio e o cultivo de, ao menos 2 variedades de plantas.
2. Relacionar as ferramentas básicas a serem utilizadas para os trabalhos na agricultura familiar de subsistência e descrever os principais cuidados que devemos ter ao manipular essas ferramentas.
3. Apresentar um relatório demonstrando e explanando os tipos de adubo, relatando ainda as principais características de cada material.
4. Demonstrar, através de uma atividade prática, o processo de adubação orgânica de sua horta.
5. Fazer um relatório descrevendo quais plantas você cultivará em sua horta, mencionando a que família elas pertencem. Citar, pelo menos, 3 espécies de cada uma das famílias abaixo e mencionar a melhor época do ano para o cultivo.
  a) Tubérculos
  b) Gramíneas
  c) Legumes
  d) Verduras
  e) Frutos
6. Demonstrar de maneira prática, e por meio de um desenho como você organizará sua horta para o cultivo das plantas de sua escolha.
7. Após a limpeza da área destinada ao plantio, quais plantas podem crescer melhor no local onde foram queimados tocos e troncos?
8. Apresentar um relatório demonstrando as principais pragas, doenças e ervas daninhas comuns às hortas. Demonstrar e explicar de que maneira você poderá controlar a incidência desses males.
9. Através de um planejamento de plantio, explicar de quais formas pode-se obter um fornecimento contínuo de alimentos.
10. Demonstrar como fazer a colheita para uso da família e para a comercialização.
11. O que é rotação de culturas e qual a importância dela para o cultivo na agricultura familiar de subsistência?
12. Apresentar através de um desenho, ou por meio prático, um programa em que você realizará a rotatividade do plantio cultivado, bem como do sistema de colheita.
13. Explicar o que você pode fazer com a área de sua horta após vários anos de cultivo.
14. Apresentar um relatório escrito de, no mínimo, 300 palavras, ou oral de 5 minutos sobre a importância da agricultura familiar de subsistência, referindo suas principais características.
15. Visitar uma propriedade rural onde uma família sobrevive da produção agrícola e elaborar relatório destacando as principais atividades desenvolvidas ali.'),
('AA-004', 'Apicultura', 'atividades-agricolas', 'especialidade', 2, 1929, 'Associação Geral', '/esp/aa-004.webp', 'https://mda.wiki.br/Especialidade_de_Apicultura', '1. Apresentar um relatório escrito de, no mínimo, 300 palavras, ou oral de 5 minutos sobre a história da apicultura.
2. Relacione 5 produtos derivados da Apicultura que são consumidos pelo homem e enumerar, ao menos, uma utilidade de cada um.
3. Qual a importância das abelhas para a agricultura? Nomear 10 alimentos que seriam muito difíceis de cultivar se não houvessem abelhas.
4. O que significam os termos a seguir:
  a) Caixas criatórias
  b) Favo atravessado
  c) Infestação
  d) Melgueira
5. O que é um fumegador? Que materiais produzem melhor combustível para o fumegador?
6. Descrever as diferenças físicas entre o zangão, as operárias e a abelha rainha e relacione os deveres específicos de cada um.
7. Explicar:
  a) O processo pelo qual as abelhas constroem os favos e como organizam a colméia
  b) Por que a colméia fica escura com o tempo?
  c) O que é espaço-abelha e qual a sua medida em milímetros?
  d) Por que é importante evitar a passagem da abelha rainha entre a câmara de cria e as melgueiras? Como isso pode ser feito?
8. Que pontos devem ser considerados ao escolher um local para as colméias?
9. Como as doenças em abelhas podem se espalhar de uma colméia para outra?
10. O que é pilhagem? Descreva o que uma abelha ladra faz.
11. Mencionar 4 maneiras de ajudar a prevenir a infestação nas colméias. Explicar por que ela deve ser evitada.
12. Que 3 exigências devem ser cumpridas para que uma colônia possa suportar as intempéries com sucesso?
13. Cite 3 modelos populares de colméias. Quais as vantagens de usar uma colméia tipo Americana ou Langstroth?
14. Como se sabe quando o quadro está pronto para a extração do mel?
15. Realizar as seguintes tarefas que acontecem num bom apiário:
  a) Demonstrar a técnica apropriada de fixação da placa de cera alveolada no quadro
  b) Estimular a produção da ninhada através da alimentação
  c) Evitar a infestação da colméia por meio das técnicas apropriadas
  d) Realizar a colheita do mel com total aproveitamento
  e) Realizar a colheita do própolis com total aproveitamento
16. Memorizar Provérbios 16:2 e explicar a relação entre o mel e as boas palavras na vida do cristão.'),
('AA-005', 'Agricultura', 'atividades-agricolas', 'especialidade', 2, 1929, 'Associação Geral', '/esp/aa-005.webp', 'https://mda.wiki.br/Especialidade_de_Agricultura', '1. Fazer uma lista dos componentes do solo. Por que o solo é importante para as plantas?
2. Explicar como as plantas obtém nutrientes e os convertem em alimento. Explicar a diferença entre nutrientes primários, secundários e micronutrientes.
3. Conhecer e apresentar um relatório dos modos em que podemos manter a terra fértil através da adubação com fertilizantes químicos e orgânicos, rotação de culturas e quando utilizá-los.
4. Explicar a diferença entre solos argilosos, arenosos e barrentos. Mencionar 3 tipos de plantas que se desenvolvem bem em cada um deles.
5. O que é erosão? Como pode ser prevenida?
6. Conhecer e apresentar um relatório acerca do manejo dos seguintes instrumentos de trabalho na agricultura: pá, enxada, ancinho e regador.
7. Identificar por meio de imagens e conhecer de forma geral as máquinas agrícolas, tradicionais e modernas, utilizadas no processo de produção agrícola.
8. Apresentar um relatório escrito de, no mínimo, 300 palavras ou oral de 5 minutos sobre a importância da agricultura, referindo suas principais características.
9. Testar a germinação de 3 variedades de sementes ? 100 sementes de cada variedade. Anotar a porcentagem após o 3°, 5° e 7° dia.
10. Identificar e nomear, pelo menos, 10 ervas daninhas comuns em sua região e explicar a melhor forma de eliminá-las usando métodos químicos ou orgânicos.
11. Identificar 6 pragas (insetos) e 6 doenças comuns às plantações. Especificar quais plantas elas geralmente atacam, relatando a melhor maneira para prevenir e eliminar sua ocorrência usando métodos mecânicos, químicos ou orgânicos.
12. Localizar, pelo menos, 2 fontes de informação em meteorologia e explicar como este método de informação pode ser útil ao agricultor.
13. Conhecer o propósito das seguintes atividades:
  a) Arar
  b) Gradear
  c) Drenar
  d) Capinar
14. Relacionar e identificar, através de fotografias ou imagens, pelo menos, 10 aves comuns em sua região e explicar a sua importância para o agricultor.
15. Auxiliar no plantio, cultivo e colheita de, pelo menos, 4 diferentes culturas, mantendo um relatório do trabalho realizado, bem como os problemas encontrados.
16. Visitar uma cooperativa em sua localidade ou instituição de apoio aos fazendeiros e descobrir como estes órgãos ajudam o agricultor. Escrever um relatório sobre sua visita.
17. Visitar uma propriedade rural onde se pratica a agricultura e elaborar relatório destacando as principais atividades desenvolvidas ali.'),
('AA-006', 'Pescaria', 'atividades-agricolas', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/aa-006.webp', 'https://mda.wiki.br/Especialidade_de_Pescaria', '1. Qual a diferença entre pesca e pescaria?
2. Explicar as seguintes modalidades:
  a) Pesca de subsistência
  b) Pesca esportiva
  c) Pesca comercial
3. Listar 5 diferentes métodos de pesca e demonstrar, ao menos, 2 a seu instrutor.
4. Qual a melhor maré para a pesca? Qual a relação entre a lua e os diferentes tipos de maré?
5. Fazer um quadro usando figuras, fotos ou desenhos das iscas e anzóis mais comuns em sua região, explicando as variações e indicações de cada um.
6. Participar de uma viagem ou passeio de pesca e pescar, ao menos, 2 peixes, cada um utilizando um método diferente, dentre os listados no requisito 3.
7. Fazer o seguinte:
  a) Uma coleção de fotos de 30 peixes comuns em sua região, identificando seus nomes, local de habitação, dieta, etc.
  b) Uma coleção de fotos de 10 peixes venenosos, tendo, no mínimo, 5 nativos de sua região ou país.
8. Ler Deuteronômio 14:9-l0. Após a leitura, separar os peixes do requisito 7 entre puros e impuros, explicando a importância de saber separá-los.
9. Ler Lucas 5:1 a 10. Em seguida, fazer uma lista apresentando, ao menos, 10 diferentes formas de demonstrar em sua vida como ser um "Pescador de Homens".'),
('AA-007', 'Criação de Gado Leiteiro', 'atividades-agricolas', 'especialidade', 2, 1929, 'Associação Geral', '/esp/aa-007.webp', 'https://mda.wiki.br/Especialidade_de_Criação_de_Gado_Leiteiro', '1. Quais pontos devem ser levados em consideração ao escolher uma vaca para a produção de leite?
2. Mencionar, pelo menos, 25 partes de uma vaca leiteira.
3. Identificar, ao vivo ou por meio de imagens, 3 raças de bovinos de corte e 3 raças de gado leiteiro.
4. Quais são as instalações necessárias para a criação de gado leiteiro?
5. Como uma novilha pode ser treinada de maneira que se torne uma vaca mansa?
6. Conhecer os cuidados, tratamento e alimentação para o gado leiteiro em cada um dos seguintes estágios:
  a) Bezerro
  b) Do desmame até os 6 meses de vida
  c) Dos 6 meses até os 15 meses de vida
  d) Dos 15 meses até a gestação
  e) Lactação
  f) Período seco
7. Saber como o leite é produzido na vaca.
8. Conhecer os passos necessários para ordenhar uma vaca tanto de maneira manual como mecânica.
9. Conhecer as principais partes de uma ordenhadeira mecânica.
10. O que é mastite? Quais medidas podem ser tomadas para prevenir a mastite?
11. Apresentar um relatório destacando os principais problemas de saúde que atingem o gado leiteiro, apontando os sintomas e sinais, bem como prevenir e/ou tratá-los.
12. Conhecer o significado dos seguintes termos:
  a) Concentrados
  b) Proteína bruta
  c) Seleção
  d) Período seco
13. Explicar a pasteurização do leite e os cuidados necessários com os utensílios e equipamentos usados nos laticínios.
14. Apresentar um relatório escrito de, no mínimo, 300 palavras ou oral de 5 minutos sobre a importância da pecuária leiteira e referir suas principais características.
15. Auxiliar no cuidado e ordenha de um rebanho de vacas leiteiras por um período de, pelo menos, 1 semana.
16. Visitar uma propriedade rural onde se pratica a criação de gado leiteiro e elaborar um relatório de, pelo menos, 300 palavras destacando as principais atividades ali desenvolvidas, bem como sobre a sua experiência vivida para o cumprimento dos requisitos desta especialidade.'),
('AA-008', 'Pomicultura', 'atividades-agricolas', 'especialidade', 2, 1929, 'Associação Geral', '/esp/aa-008.webp', 'https://mda.wiki.br/Especialidade_de_Pomicultura', '1. Qual a diferença entre um viveiro e uma estufa?
2. Citar, pelo menos, 5 características que devem ser consideradas para se realizar a produção de mudas, bem como as principais necessidades a se levar em conta ao escolher uma determinada variedade de planta frutífera.
3. Apresentar um relatório demonstrando os cuidados necessários para o plantio e cultivo de, pelo menos, 2 árvores frutíferas de sua escolha, apontando as técnicas básicas de preparo do solo, espaçamento, período do ano mais favorável para o plantio e esquema de adubação.
4. Por meio de um relatório escrito (o relatório deve conter fotos das plantas adultas e dos frutos), apontar as condições de local, solo e época do ano mais adequado para se cultivar, pelo menos, 3 das seguintes variedades:
  a) Abacateiro
  b) Ameixeira
  c) Bananeira
  d) Cajazeira
  e) Coqueiro
  f) Goiabeira
  g) Laranjeira
  h) Limoeiro
  i) Macieira
  j) Mamoeiro
  k) Mangueira
  l) Pereira
  m) Outra variedade frutífera da sua escolha
5. Fazer um pequeno viveiro para a produção de mudas.
6. Apresentar, por meio de um relatório, o nome de, pelo menos, 3 tipos de fertilizantes, demonstrando a importância, necessidade e sugerir a melhor maneira de uso para cada um.
7. O que é uma árvore frutífera anã? Como chegou a este tamanho?
8. O que é enxertia? Por que se faz enxerto em árvores frutíferas?
9. O que é resistência? O que isso significa? Citar, pelo menos, 3 plantas que são consideradas resistentes em sua região?
10. Na presença do avaliador, demonstrar habilidade em plantar, podar e tratar de, pelo menos, 2 árvores frutíferas, por um período de, pelo menos, uma estação, ou cuidar de uma árvore existente pelo mesmo período.
11. Responder as perguntas a seguir:
  a) O que é polinização? Como esse processo acontece?
  b) O que é um polinizador? Citar por meio de um relatório, apresentando fotos ou ao vivo, pelo menos um agente responsável pela polinização.
  c) Citar, pelo menos, 3 plantas frutíferas que necessitam de um agente polinizador.
12. Apresentar um relatório identificando, através de fotografias ou imagens, as principais pragas, doenças e ervas daninhas comuns aos pomares em sua região. Especificar quais plantas elas geralmente atacam, relatando a melhor maneira para prevenir e/ou eliminar sua ocorrência.
13. Demonstrar como fazer a colheita dos frutos para uso da família ou para comercialização. Apresentar aos examinadores uma amostra dos frutos colhidos e comparar as qualidades de sabor, textura e aparência de 2 variedades diferentes da mesma fruta.
14. Apresentar um relatório escrito de, no mínimo, 300 palavras ou oral de 5 minutos sobre a importância da Fruticultura (produção de frutos exigidos nos requisitos dessa especialidade) e referir suas principais características.
15. Visitar uma propriedade rural onde se pratica a fruticultura e elaborar um relatório de, pelo menos, 300 palavras destacando as principais atividades ali desenvolvidas, bem como sobre a sua experiência vivida para o cumprimento dos requisitos desta especialidade.'),
('AA-009', 'Pomicultura II - Frutas Pequenas', 'atividades-agricolas', 'especialidade', 2, 1929, 'Associação Geral', '/esp/aa-009.webp', 'https://mda.wiki.br/Especialidade_de_Pomicultura_II_-_Frutas_Pequenas', '1. Qual a diferença entre um viveiro e uma estufa?
2. Fazer um pequeno viveiro para a produção de mudas.
3. Citar, pelo menos, 5 características que devem ser consideradas ao se realizar a produção de mudas, bem como as principais necessidades a serem levadas em conta ao se escolher uma determinada variedade de planta frutífera.
4. Apresentar um relatório demonstrando os cuidados necessários para o plantio e cultivo de, pelo menos, 4 variedades de plantas de sua escolha, apontando as técnicas básicas de preparo do solo, espaçamento, período do ano mais favorável para o plantio e esquema de adubação.
5. Por meio de um relatório escrito (o relatório deve conter fotos das plantas adultas e dos frutos), apontar as condições de local, solo e época do ano mais adequados para se cultivar, pelo menos, 3 variedades de frutas pequenas das citadas abaixo ou que crescem em sua região:
  a) Abacaxizeiros
  b) Aceroleiras
  c) Amoreiras
  d) Cerejeiras
  e) Figueiras
  f) Framboeseiras
  g) Gravioleiras
  h) Maracujazeiros
  i) Morangueiros
  j) Pitangueiras
  k) Romanzeiras
  l) Umbuzeiros
  m) Vinhas
  n) Outra variedade frutífera da sua escolha
6. Escrever um relatório de 1 página referindo como cultivar as frutas selecionadas no requisito anterior. Neste relatório, incluir o seguinte:
  a) Variedade de seleção
  b) Preparo do solo
  c) Técnicas de plantio
  d) Fertilização
  e) Poda
  f) Irrigação
  g) Controle de pragas
  h) Colheita
7. Apresentar, por meio de fotos ou imagens, as variedades de frutas pequenas que nascem com facilidade ou existem na região em que você vive.
8. Demonstrar, ao avaliador, a maneira adequada de podar, pelo menos, 2 arbustos ou vinhas de pequenas frutas em alguma horta ou pomar.
9. O que é uma cultura perecível?
10. Por quanto tempo as frutas mencionadas no requisito 5 podem ser guardadas?
11. Apresentar um relatório identificando, através de fotografias ou imagens, as principais pragas, doenças e ervas daninhas comuns aos pomares em sua região. Especificar quais plantas elas geralmente atacam e referir a melhor maneira para prevenir e/ou eliminar sua ocorrência.
12. Apresentar, por meio de um relatório, o nome de, pelo menos, 3 tipos de fertilizantes, demonstrando a importância, necessidade e sugerir a melhor maneira de uso para cada um.
13. Fazer um teste do solo de um pomar e determinar quais frutos poderão crescer ali. Pedir recomendações de fertilizantes para as culturas escolhidas para serem plantadas e determinar o custo do fertilizante necessário para 6 fileiras de 10 metros.
14. Qual é o propósito do teste de solo?
15. O que é drenagem? Qual a sua importância? Como se faz a drenagem?
16. O que é resistência? O que isso significa? Citar, pelo menos, 3 plantas que são consideradas resistentes em sua região.
17. Responder as perguntas a seguir:
  a) O que é polinização? Como esse processo acontece?
  b) O que é um polinizador? Citar pelo menos um agente responsável pela polinização.
  c) Citar, pelo menos, 3 plantas frutíferas que necessitam de um agente polinizador.
18. Demonstrar como fazer a colheita dos frutos para uso da família ou para comercialização. Apresentar aos examinadores uma amostra dos frutos colhidos e comparar as qualidades de sabor, textura e aparência de 2 variedades diferentes da mesma fruta.
19. Apresentar um relatório escrito de, no mínimo, 300 palavras ou oral de 5 minutos sobre a importância da fruticultura (produção de frutos exigidos nos requisitos dessa especialidade) e referir suas principais características.
20. Visitar uma propriedade rural onde se pratica a fruticultura e elaborar um relatório de, pelo menos, 300 palavras destacando as principais atividades ali desenvolvidas, bem como sobre a sua experiência vivida para o cumprimento dos requisitos desta especialidade.'),
('AA-010', 'Floricultura', 'atividades-agricolas', 'especialidade', 1, 1938, 'Associação Geral', '/esp/aa-010.webp', 'https://mda.wiki.br/Especialidade_de_Floricultura', '1. O que são flores perenes, flores anuais e flores bienais? Dar um exemplo de cada.
2. Apresentar as instruções para fazer um viveiro. Qual a diferença entre um viveiro e uma estufa?
3. O que é drenagem e qual a sua importância? Como se faz a drenagem?
4. Liste três pragas que atingem as plantas em sua região, descrevendo os danos causados por cada uma e explicar como controlá-las.
5. Descrever as instruções para fazer uma floreira e especificar seu uso.
6. Dar o nome de três tipos de fertilizantes e sugerir o melhor uso para cada um.
7. Preparar o solo, plantar e cultivar até a maturidade, três tipos distintos de flores anuais.
8. Quais são os três nutrientes de plantas mais importantes para a floração?
9. Cultivar duas ou mais flores perenes em um canteiro ao ar livre, durante uma estação. Manter um relatório escrito com registro semanal do trabalho feito.
10. Qual é o propósito do teste de solo?
11. Mencionar três flores que melhor se adaptam a cada uma das condições a seguir:
  a) Sombra
  b) Solo seco
  c) Luz solar direta
  d) Solo úmido'),
('AA-011', 'Criação de Cavalos', 'atividades-agricolas', 'especialidade', 1, 1944, 'Associação Geral', '/esp/aa-011.webp', 'https://mda.wiki.br/Especialidade_de_Criação_de_Cavalos', '1. Identificar, ao vivo ou a partir de fotografias, pelo menos 4 raças de cavalos e especificar quais são as principais características e aptidões de cada uma.
2. Quais são as instalações necessárias para a criação de cavalos?
3. Qual a alimentação necessária a ser utilizada para os seguintes períodos da vida dos animais?
  a) Primeiro mês
  b) Primeiro ano
  c) Gestação
  d) Fêmea com filhote
  e) Animal adulto
4. Qual é a melhor idade para desmamar os potros?
5. Quando os filhotes devem ser apartados de suas mães e por quê?
6. Citar 2 linhas de lucro que são determinadas pelo uso de éguas especialmente selecionadas.
7. Por que é preferível criar potros de puro sangue ao invés de espécies comuns?
8. Citar, pelo menos, 5 características que devem ser consideradas ao se escolher um cavalo.
9. Que espécie de adestramento ajudará os potros a se desenvolverem de forma a tornarem-se cavalos mansos e dóceis?
10. Conhecer as partes do cabresto, rédeas, arreios e sela.
11. Saber e demonstrar aos avaliadores como colocar de maneira correta um cabresto, rédeas e sela no cavalo.
12. Saber como cuidar adequadamente dos cascos de um cavalo.
13. Cuidar de um ou mais potros ou cavalos por um período de, pelo menos, 1 mês.
14. Apresentar um relatório destacando os principais problemas de saúde que atingem os cavalos, apontando os principais sinais e sintomas, bem como prevenir e/ou tratá-los.
15. Apresentar um relatório escrito de, no mínimo, 300 palavras ou oral de 5 minutos sobre a importância da equinocultura e referir suas principais características.
16. Visitar uma propriedade rural onde se pratica a criação de cavalos e elaborar um relatório de, pelo menos, 300 palavras destacando as principais atividades ali desenvolvidas, bem como sobre a sua experiência vivida para o cumprimento dos requisitos desta especialidade.'),
('AA-012', 'Criação de Pombos', 'atividades-agricolas', 'especialidade', 2, 1944, 'Associação Geral', '/esp/aa-012.webp', 'https://mda.wiki.br/Especialidade_de_Criação_de_Pombos', '1. Identificar ao vivo ou a partir de fotos, pelo menos, 3 espécies de pombos, referindo sua respectiva aptidão (pombo-correio ou ornamentação).
2. Descrever e identificar por meio de fotografias as seguintes instalações e equipamentos necessários para a criação de Pombos:
  a) Pombal
  b) Poleiros
  c) Alçapão
  d) Ninho em caixa
  e) Bebedouros
  f) Comedouros
3. Quais características devem ser levadas em conta ao se escolher uma espécie de pombo?
4. Qual o tamanho mínimo ideal do plantel para um criador inexperiente iniciar a atividade na criação pombos?
5. Descrever um programa de alimentação para aves domésticas, desde a eclosão dos ovos até a fase adulta.
6. Saber e apresentar uma boa fórmula de sementes, grãos e alimentos triturados para serem utilizados na alimentação dos pombos e em que proporções eles devem ser misturados e administrados. Por que se deve usar menos milho em climas quentes?
7. Citar as principais partes de um pombo. Referir e demonstrar, por meio de fotografias, as partes da asa do pombo, bem como a importância dessa estrutura.
8. Qual a importância de uma correta mudança de penas? Como se pode controlar este período?
9. Criar, pelo menos, 2 pares de pombo por, no mínimo, 1 mês.
10. Apresentar um relatório destacando os principais problemas de saúde que atingem as aves, apontando os sintomas e sinais, bem como prevenir e/ou tratá-los.
11. Visitar uma propriedade onde se pratica a criação de pombos e elaborar um relatório de, pelo menos, 300 palavras destacando as principais atividades ali desenvolvidas, bem como sobre a sua experiência vivida para o cumprimento dos requisitos desta especialidade.'),
('AA-013', 'Criação de Ovelhas', 'atividades-agricolas', 'especialidade', 1, 1944, 'Associação Geral', '/esp/aa-013.webp', 'https://mda.wiki.br/Especialidade_de_Criação_de_Ovelhas', '1. Identificar ao vivo ou a partir de fotografias, pelo menos, 4 raças de ovinos e especificar se esses animais são criados para produção de leite, carne, pele ou lã.
2. Quais são as instalações necessárias para a criação de ovelhas?
3. Quais os cuidados básicos devem ser providos para a criação de ovelhas?
4. Qual é o espaçamento necessário para a criação de ovelhas nas situações a seguir
  a) Ovelhas adultas soltas em um estábulo
  b) Ovelhas adultas soltas ao ar livre
  c) Filhotes soltos em um estábulo
  d) Pastagem para gestantes
  e) Cocho para ovelhas adultas
  f) Cocho para gestantes
  g) Parto
5. Qual a alimentação necessária a ser utilizada para os seguintes períodos da vida dos animais?
  a) Primeiro mês
  b) Terceiro mês
  c) Gestação
  d) Fêmea com filhote pequeno
  e) Animal adulto
6. Em que tipo de regiões as ovelhas costumam habitar?
7. Qual período do ano é mais favorável para iniciar a criação de ovelhas?
8. Quais características devem ser levadas em conta ao se escolher uma determinada variedade de raça?
9. Qual é a melhor idade para desmamar os burregos?
10. Quando os filhotes devem ser apartados de suas mães e por quê?
11. Citar e apresentar por meio de fotografias, pelo menos 6 objetos oriundos da criação de ovelhas.
12. Apresentar um relatório destacando os principais problemas de saúde que atingem os ovinos, apontando os principais sinais e sintomas, bem como prevenir e/ou tratá-los.
13. Qual o tamanho mínimo ideal do rebanho para um criador inexperiente iniciar a atividade na criação ovelhas?
14. Conhecer o significado dos seguintes termos:
  a) Castração
  b) Comercialização
  c) Concentrado
  d) Cruzar
  e) Ovelha
  f) Purgante ou Lavagem
  g) Forragens
  h) Volumosos
  i) Ganhar ou Parir
  j) Gestação
  k) Peso de gordura
  l) Lactação
  m) Mocho
  n) De raça pura
  o) Carneiro
  p) Ração
  q) Registrado
  r) Castrado
  s) Raça híbrida
  t) Cio
  u) Burregos
15. Quais pontos devem ser levados em consideração ao se escolher um bom cordeiro?
16. Cuidar de 1 ou mais cordeiros até a comercialização ou até 6 meses de idade.
17. Apresentar um relatório escrito de, no mínimo, 300 palavras ou oral de 5 minutos sobre a importância da ovinocultura e referir suas principais características.
18. Visitar uma propriedade rural onde se pratica a criação de ovelhas e elaborar um relatório de, pelo menos, 300 palavras destacando as principais atividades ali desenvolvidas, bem como sobre a sua experiência vivida para o cumprimento dos requisitos desta especialidade.'),
('AA-014', 'Pecuária', 'atividades-agricolas', 'especialidade', 2, 1944, 'Associação Geral', '/esp/aa-014.webp', 'https://mda.wiki.br/Especialidade_de_Pecuária', '1. Citar, pelo menos, 4 características que se deve observar para a escolha de um bom novilho.
2. Mencionar pelo menos, 25 partes de um boi.
3. Conhecer o significado dos seguintes termos:
  a) Forragem
  b) Arroba
  c) Curral
  d) Cruzar
  e) Brete
  f) Ferro de marcação
  g) Garrote
  h) Novilho
  i) Brachiara
  j) Napiêr
  k) Quicuio
  l) Prenhez
  m) Ordenha
  n) Mocho
  o) De raça pura
  p) Lactação
  q) Pasto
  r) Cerca
  s) Ração
  t) Área
  u) Cio
4. Apresentar um relatório destacando os principais problemas de saúde que atingem os bovinos, apontando os sintomas e sinais, bem como preveni-los e tratá-los.
5. O que é castração e qual o seu propósito?
6. O que é descorna? Por que os chifres são extraídos? Qual a melhor idade para a realização deste procedimento?
7. Qual o melhor período para o desmame dos bezerros?
8. Quais são as instalações necessárias para a criação de gado?
9. Por que é melhor colocar alimento e água em lados opostos do estábulo?
10. Identificar ao vivo ou por meio de imagens, 3 raças de bovinos de corte e 3 raças de gado leiteiro.
11. Relatar os cuidados, manejo e tipo de alimentação necessária para o gado nas seguintes situações:
  a) Primeiros 90 dias
  b) De 90 a 180 dias
  c) De 180 dias até o momento da venda
12. Como uma novilha pode ser treinada de maneira que se torne uma vaca mansa?
13. Cuidar de 1 ou mais bezerros por um período mínimo de 1 mês.
14. Visitar uma propriedade rural onde se pratica a pecuária e elaborar um relatório de, pelo menos, 300 palavras destacando as principais atividades ali desenvolvidas, bem como sobre a sua experiência vivida para o cumprimento dos requisitos desta especial idade.'),
('AA-015', 'Criação de Cabras', 'atividades-agricolas', 'especialidade', 2, 1986, 'Associação Geral', '/esp/aa-015.webp', 'https://mda.wiki.br/Especialidade_de_Criação_de_Cabras', '1. Identificar ao vivo ou a partir de fotografias, pelo menos, 4 raças de caprinos e especificar se esses animais são criadas para produção de leite, carne ou lã.
2. Quais são as instalações necessárias para a criação de cabras?
3. Qual a alimentação necessária a ser utilizada para os seguintes períodos da vida dos animais?
  a) Primeiro mês
  b) Segundo mês
  c) Gestação
  d) Fêmea com filhote pequeno
  e) Animal adulto
4. Nomear e apresentar, por meio de fotos, 3 plantas venenosas para as cabras.
5. Qual é a melhor idade para desmamar os cabritos?
6. Quando os filhotes devem ser apartados de suas mães e por quê?
7. Como os cascos das cabras devem ser aparados e por quê?
8. Por que as cabras são boas para limpar o mato?
9. Citar e apresentar, por meio de fotografias, pelo menos 6 objetos feitos de peles de cabra.
10. O que é barbilhões?
11. Cuidar de 1 cabra por, pelo menos, 1 mês.
12. Sobre cabras leiteiras, responder às seguintes perguntas:
  a) Quais os pontos devem ser levados em consideração ao se escolher uma boa cabra leiteira?
  b) Como é feita a pasteurização do leite e qual seu objetivo?
13. Fazer o seguinte:
  a) Ordenhar uma cabra de manhã ou à tarde, durante, pelo menos, 1 semana.
  b) Manter um registro diário da produção de leite.
14. Apresentar um relatório destacando os principais problemas de saúde que atingem os caprinos, apontando os principais sinais e sintomas, bem como prevenir e/ou tratá-los.
15. Apresentar um relatório escrito de, no mínimo, 300 palavras ou oral de 5 minutos sobre a importância da caprinocultura e referir suas principais características.
16. Visitar uma propriedade rural onde se pratica a criação de caprinos e elaborar um relatório de, pelo menos, 300 palavras destacando as principais atividades ali desenvolvidas, bem como sobre a sua experiência vivida para o cumprimento dos requisitos desta especialidade.'),
('AA-016', 'Paisagismo', 'atividades-agricolas', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/aa-016.webp', 'https://mda.wiki.br/Especialidade_de_Paisagismo', '1. O que é paisagismo?
2. Fazer uma lista básica dos materiais usados em paisagismo.
3. O que são plantas tropicais? Dar exemplos.
4. O que são plantas anuais? Dar exemplos.
5. O que são plantas de sol pleno, meia sombra e sombra? Citar, pelo menos, dois exemplos de cada.
6. O que são plantas suculentas? Cultivar dois tipos de suculentas em sua casa.
7. O que é manta de bidim e para que ela serve?
8. O que são plantas ornamentais?
9. Para que serve o separador de grama? Fazer um pequeno jardim usando grama, separador de grama e plantas ornamentais.
10. Citar 10 espécies de palmeiras usadas em jardim.
11. O que acontece com as samambaias quando ficam expostas ao sol e ao vento?
12. Quais técnicas são usadas no plantio de grama?
13. Como são chamadas as plantas ornamentais que não possuem flores? Dar exemplos.'),
('AM-001', 'Arte de Contar Histórias Cristãs', 'atividades-missionarias', 'especialidade', 2, 1928, 'Associação Geral', '/esp/am-001.webp', 'https://mda.wiki.br/Especialidade_de_Arte_de_Contar_Histórias_Cristãs', '1. Contar uma história para cada uma das categorias abaixo, citando as fontes de pesquisa:
  a) História Bíblica.
  b) História da sua Igreja.
  c) História da Natureza.
  d) História com algum fundo moral.
  e) História com ajuda de recursos visuais.
  f) História de um missionário em terras estrangeiras.
  g) História com princípios de saúde e temperança.
1. Contar duas das histórias pesquisadas no item 1 no momento de adoração infantil na Igreja, adequadas para a ocasião.
2. Usando sua criatividade, criar cinco histórias próprias que ensinem práticas morais, amor à natureza, preservação do ambiente, demonstração de fé em Deus ou algum assunto que seja útil na construção do caráter dos desbravadores. Entregá-las por escrito.
3. Usando uma dessas histórias que você criou no item anterior, demonstrar a seu líder ou conselheiro como modificá-las nas seguintes circunstâncias:
  a) Saber contar a história na primeira e terceira pessoa do singular.
  b) Demonstrar suas técnicas de contar a história de forma a torná-la ainda interessante para as diferentes faixas etárias:
• Crianças pequenas (idade de aventureiros)
• Adolescentes ou Jovens
• Adultos
• Saber encurtá-la, sem perder o conteúdo e aplicação
• Saber torná-la mais longa
  a) Identificar, em uma das histórias criadas do item 3, as partes que compõe uma boa história (começo - introdução, meio, clímax e fim - conclusão) através de um esboço. Entregar por escrito.
  b) Obter um livro, em formato físico ou digital, com ilustrações para sermões.'),
('AM-002', 'Arte em Fantoches', 'atividades-missionarias', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/am-002.webp', 'https://mda.wiki.br/Especialidade_de_Arte_em_Fantoches', '1. Possuir, pelo menos, 3 fantoches. Pelo menos 1 deles deve ser confeccionada manualmente por você.
2. Desenvolver 3 personagens com vozes características para cada um de seus fantoches.
3. Escrever 3 roteiros de 2 a 3 minutos.
4. Fazer, pelo menos, 3 apresentações dos roteiros acima a qualquer público (não pode ser amigos ou familiares).
5. Ser avaliado, em cada apresentação, por um dos espectadores. Este avaliador não pode ser familiar ou amigo direto do titereiro.'),
('AM-003', 'Arte em Fantoches - avançado', 'atividades-missionarias', 'especialidade', 3, null, 'Divisão do Sul do Pacífico', '/esp/am-003.webp', 'https://mda.wiki.br/Especialidade_de_Arte_em_Fantoches_-_avançado', '1. Ter a especialidade de Arte em fantoches.
2. Acrescentar à sua coleção, pelo menos, mais 2 fantoches diferentes desenvolvidos manualmente por você.
3. Desenvolver personagens e vozes para os novos fantoches.
4. Escrever um roteiro de, pelo menos, 10 minutos.
5. Construir um cenário para encenação dos fantoches.
6. Fazer, pelo menos, uma encenação na igreja ou para outro público.'),
('AM-004', 'Etnologia Missionária', 'atividades-missionarias', 'especialidade', 2, 1928, 'Associação Geral', '/esp/am-004.webp', 'https://mda.wiki.br/Especialidade_de_Etnologia_Missionária', '1. Definir cultura e diversidade cultural.
2. Definir o que são estereótipos e identificar como você pode ter estereotipado alguém no passado.
3. Estudar os seguintes textos bíblicos e responder às perguntas:
  a) 1 Corintios 9:20. Como este texto pode explicar a importância do cristão ter uma consciência da diversidade cultural?
  b) Gálatas 3:27.0 que este texto diz sobre todos os que estão na família de Cristo?
  c) Efésios 2:14. Qual deve ser o resultado de aceitar a Cristo Jesus em nossas vidas? Como você pretende aplicar esta mensagem para sua vida cotidiana?
4. Fazer um estudo sobre a vida de qualquer grupo racial ou nacionalidade que não sejam os seus, e com os quais tem a oportunidade de entrar em contato. O objetivo é adquirir uma compreensão e simpatia por suas virtudes, hábitos, defeitos e necessidades, e também para apresentar-lhes o evangelho. Os pontos a seguir devem ser observados neste estudo:
  a) Sua história no país de origem, ou em seu país, caso a ocupação exceda 100 anos.
  b) Sua literatura, com menção dos principais escritores e familiarização com os melhores exemplos de prosa e verso.
  c) Seus hábitos sociais na comunidade e em família; por exemplo, se são fechados ou se gostam de estar em contato com outras pessoas, e quais os costumes da família, e como a mesma é governada.
5. Entrevistar uma pessoa cuja cidadania ou raiz cultural (no caso de indígenas) é diferente da sua. Fazer as seguintes perguntas:
  a) Qual a origem da sua cultura?
  b) Qual língua é falada?
  c) Quais as religiões que se destacam na sociedade?
  d) Quais os alimentos que normalmente são consumidos no:
    • Café da manhã
    • Almoço
    • Jantar/Ceia
  e) Como os hábitos alimentares influenciam a sociedade?
  f) Há tradições culturais que são diferentes das do nosso pais? Quais são?
  g) As pessoas desta cultura comemoram os mesmos feriados que celebramos? Como eles celebram os feriados diferentes do nosso?
  h) Que costumes e tradições da cultura original foram mantidos pela família neste país?
  i) Sua forma de vestir-se é diferente da de nossa cultura?
  j) Identificar, pelo menos, 5 coisas (alimentos, costumes, vestimentas, hábitos, etc.) que nossa cultura tem similar à do entrevistado e, pelo menos, 5 diferentes. Qual sua atitude ou sentimentos para com pessoas de culturas diferentes? Como estas descobertas afetou você? O que você sente sobre estas diferenças?
6. Comparar a sua língua materna com a língua materna do grupo estudado. Qual a origem de cada uma? Há alguma semelhança de estrutura gramatical? Aprender a falar algumas frases nesta língua, adquirindo um vocabulário de, no mínimo, 100 palavras.'),
('AM-005', 'Colportagem', 'atividades-missionarias', 'especialidade', 3, 1938, 'Associação Geral', '/esp/am-005.webp', 'https://mda.wiki.br/Especialidade_de_Colportagem', '1. Participar de um Curso ou Treinamento promovido pelo departamento de Publicações do Campo Local ou Campanhas de Colportagem em sua igreja, sobre a Arte Cristã de Vendas.
2. Ler o livro Mensageiro da Esperança, de Ellen White, e fazer uma reação à leitura de 1 página.
3. Pesquisar os termos abaixo e escrever o que aprendeu a respeito:]
  a) Colportor efetivo
  b) Sonhando alto
  c) Campanha de estudante
4. Descrever técnicas de:
  a) Vendas
  b) Persuasão
  c) Despertar interesse na compra dos livros e revistas
  d) Reagir às objeções
5. Pesquisar e apresentar um resumo de, no mínimo, 250 palavras sobre a importância do trabalho da Colportagem no começo da história da Igreja Adventista no seu pais:
  a) Quem foram os Pioneiros da Colportagem em seu país?
  b) Como eles usaram a Colportagem como meio de Evangelização?
  c) Qual foi a importância desse ministério na propagação do Evangelho em seu país?
6. Fazer 1 dos itens a seguir:
  a) Participar de um projeto de Colportagem de, pelo menos, 1 més, no qual você tenha conseguido vender e entregar o material.
  b) Distribuir livros religiosos a autoridades - pelo menos 6 pessoas - do governo de sua cidade, estado ou país.
  c) Oferecer um ano de assinatura da revista Vida & Saúde ou Nosso Amiguinho a pelo menos 2 médicos ou educadores de seu bairro, ou cidade.
  d) Coletar doações e enviar literaturas e/ou Bíblias aos campos missionários, projetos de plantio de Igreja ou Missão Global de seu Campo.
7. Simular ao seu orientador, conselheiro ou instrutor uma venda de um livro e revista, testando suas técnicas aprendidas na pesquisa do item 3.'),
('AM-006', 'Cidadania Cristã', 'atividades-missionarias', 'especialidade', 1, 1938, 'Associação Geral', '/esp/am-006.webp', 'https://mda.wiki.br/Especialidade_de_Cidadania_Cristã', '1. Definir o termo Cidadania.
2. Descrever as seguintes bandeiras:
  a) Do seu país
  b) Do seu Estado
  c) Do seu Município
  d) Dos Desbravadores
3. Pesquisar e relatar o significado das cores, símbolos, significado, curiosidades e história (se houver) das bandeiras do item 2.
4. Demonstrar como dobrar a bandeira nacional. Explicar como e onde deve ser guardada.
5. Fazer o seguinte:
  a) Selecionar e pesquisar o significado das palavras do hino nacional que você não conhece
  b) Decorar e cantar corretamente o hino nacional
  c) Explicar o significado do hino dos Desbravadores
  d) Explicar o significado da posição Maranata
6. Explicar o significado da declaração que Jesus fez em Mateus 22:21: "Deem a César o que é de César e a Deus o que é de Deus".
7. Por que as leis são importantes? Por que um país precisa de leis? Qual foi o objetivo de Deus ao nos dar a Lei?
8. Explicar o sistema de governo em seu país.
9. Faça uma pesquisa sobre uma pessoa famosa de seu país. Cite o que ela fez para se destacar diante da sociedade. Apresentar o resultado da sua pesquisa de uma Redação com, pelo menos, 15 linhas
10. Descrever o que você pode fazer como cidadão para ajudar sua igreja e seu país.'),
('AM-007', 'Estudo de Línguas - Avançado', 'atividades-missionarias', 'especialidade', 2, 1938, 'Associação Geral', '/esp/am-007.webp', 'https://mda.wiki.br/Especialidade_de_Estudo_de_Línguas_-_Avançado', '1. Completar a especialidade de Estudo de línguas.
2. Ler e traduzir, à primeira vista, um texto de, pelo menos, 300 palavras de um livro ou revista em uma língua não nativa para você.
3. Ser capaz de manter uma conversação nesta outra língua, por um período de, no mínimo, 5 minutos.
4. Ouvir parte de um discurso ou declaração de, no mínimo 2 minutos, feito por alguém cuja língua materna seja a língua estrangeira que você escolheu, e traduza o mesmo para a sua língua.
5. Escrever uma carta simples na língua estrangeira de sua escolha e dizer os contatos que você tem sido capaz de fazer com pessoas cuja língua nativa é o idioma que você escolheu.
6. Conhecer e repetir de memória o Voto e a Lei dos Desbravadores nesta língua estrangeira.
7. Escrever ou apresentar oralmente informações sobre alguma população estrangeira, cuja língua materna é a língua de sua escolha, que more em seu bairro, cidade, região ou Estado e que oportunidades você tem de conversar com pessoas nativas nessa língua.'),
('AM-008', 'Evangelismo Pessoal', 'atividades-missionarias', 'especialidade', 1, 1938, 'Associação Geral', '/esp/am-008.webp', 'https://mda.wiki.br/Especialidade_de_Evangelismo_Pessoal', '1. Ter uma coleção de 5 estudos bíblicos (formato físico e/ou digital), que podem ser usados na pregação bíblica.
2. Ter uma coleção de, pelo menos, 10 citações do Espírito de Profecia com relação ao Evangelismo Pessoal. Guardar essas citações em forma de fichas ou anotadas em sua bíblia de estudo.
3. Fazer 1 das atividades abaixo:
  a) Para quem tem 18 anos ou mais, ser o diretor do Ministério Pessoal de sua Igreja ou grupo durante um ano, executando, pelo menos, 5 atividades com foco missionário e tendo a colaboração da igreja.
  • Apresentar relatório completo das atividades planejadas e executadas.
  a) Executar os requisitos abaixo:
    1. Através do estudo da Bíblia e do Espírito de Profecia, aprender como Jesus tratava as pessoas de forma pessoal.
      • Fazer uma apresentação oral de 5 minutos sobre o que você aprendeu.
      • Pregar no Sábado Missionário de sua Igreja sobre o que pesquisou.
    • Apresentar relatório ou esboço do sermão.
    1. Desenvolver uma vida devocional diariamente por, pelo menos, 3 meses através do Estudo da Bíblia, leitura do Ano Bíblico e Leitura da Devoção pessoal.
    2. Escolher e executar 2 atividades descritas abaixo:
      • Reuniões Evangelísticas
      • Reuniões do Ministério Jovem
      • Atividades da Assistência Social (ASA) de sua igreja
      • Seminários de cozinha saudável
      • Cursos Como Deixar de Fumar
      • Seminários sobre Perda de Peso
      • Seminários sobre o Controle do Estresse
      • Seminário sobre Hipertensão ou Diabetes
    • Na opção que tiver escolhido acima, realizar o seguinte:
      • Tomar parte na organização da atividade
      • Tomar parte na escolha do local para a realização do evento
      • Ajudar na divulgação
      • Fazer um orçamento das despesas e ajudar a levantar fundos para um projeto evangelístico.
      • Estar regularmente envolvido na operação e organização do projeto
    1. Ajudar na organização e planejamento de um dos projetos evangelísticos a seguir e participar no projeto durante, no mínimo, 10 horas:
    • Observação: Esses itens devem ser feitos em projetos evangelísticos da Igreja, em Semanas de Colheita, em Evangelismo Público, Plantio de igreja, etc.
      • Projetos de melhorias no seu bairro ou no bairro onde o Clube atua, em jardins, praças e outras áreas públicas.
      • Participar dos momentos de história para crianças, encenações bíblicas ou apresentação de fantoches.
      • Distribuição de alimentos e/ou roupas aos necessitados.
      • Programas e visitas a um asilo, orfanato ou ala pediátrica de um hospital.
      • Jardinagem e trabalho doméstico gratuito na casa de pessoas de idade.
      • Ser professor/professora numa das divisões infantis do departamento de Escola Sabatina de uma igreja ou grupo em formação.
      • Palestras sobre temperança.
      • Aulas de reforço para alunos mais novos, com dificuldade.
      • Trabalho voluntário em hospital ou asilo, projetos de levantamento de fundos e fornecer livros e jogos.
      • Ajudar na reabilitação de uma pessoa com deficiência física.
      • Fazer cartazes e projetos de arte para um hospital, asilo ou orfanato.
      • Adotar um Avô / Avó em um asilo.
      • Projeto semelhante com aprovação de seu diretor de Desbravadores.'),
('AM-009', 'Liderança Juvenil', 'atividades-missionarias', 'especialidade', 3, 1945, 'Associação Geral', '/esp/am-009.webp', 'https://mda.wiki.br/Especialidade_de_Liderança_Juvenil', '1. Se envolver diretamente em um dos seguintes departamentos da Igreja por, no mínimo, 1 ano, em um cargo de liderança ou de associado:
  a) Ministério Jovem ou Ministério da Música.
  b) Ministério da Criança ou do Adolescente (coordenação ou um dos professores das Classes da Escola Sabatina)
  c) Clube de Desbravadores (secretaria, tesouraria, diretor, diretor associado ou capelão)
  d) Secretaria de algum outro departamento da Igreja (Ministério Pessoal, Ministério da Mulher, Assistência Social)
  e) Liderar ou ser associado dos ministérios: Coordenação de Interessados, Recepção ou Oração Intercessora.
  • Fazer um relatório de sua atividade e ter uma carta de recomendação do diretor do departamento em que atuou (ou da Comissão da Igreja, caso você tenha sido o diretor).
2. Ler um livro sobre desenvolvimento dos adolescentes e outro sobre liderança. Para cada um, apresentar uma reação à leitura de pelo menos 1 página.
3. Preparar um grupo de Desbravadores para a investidura durante o ano atual, atuando como instrutor ou instrutor associado ativo de uma das Classes Regulares, sendo que, deste grupo, pelo menos 1 desbravador deve ser investido. Ajudar no planejamento e execução da cerimônia de investidura.
4. Juntamente com o seu líder, ou grupo da classe de líder, discutir e apresentar, pelo menos, 10 qualidades de um bom líder de pré-adolescentes e adolescentes.
5. Apresentar um relatório descritivo, ressaltando as diferenças entre os pré-adolescentes (10-12 anos) e os adolescentes (13-15 anos) nas áreas física, emocional e mental. Apresentar em um Culto Jovem ou Reunião de Pais suas considerações sobre sua pesquisa realizada.
6. Conhecer os princípios para ministrar adequadamente a disciplina aos pré-adolescentes e adolescentes. Aprender as seguintes áreas de disciplina:
  a) disciplina interna
  b) disciplina externa
  c) 10 maneiras de prevenir a necessidade de uma disciplina externa
  d) 5 tipos de procedimentos disciplinantes
  • Citar fonte de pesquisa e criar um conjunto de regras usando sua visão sobre o assunto para seu Clube de Desbravador e apresentá-lo à diretoria do Clube para apreciação e, se possível, aproveitamento nas atividades do Clube.
7. Com base nas leis de seu país e nas orientações do Ministério de Desbravadores da DSA, apresentar um breve relatório sobre cada um dos requisitos abaixo:
  a) Conhecer as implicações legais para a condução de pré-adolescentes e adolescentes a eventos e/ou reuniões sem a companhia de seus pais.
  b) Saber as precauções a serem tomadas, como, por exemplo, a necessidade de autorização dos pais.
  c) Quais os cuidados que devem ser tomados para evitar situações que possam ser mal interpretadas por parte de outrem? Por exemplo, jamais estar sozinho em ambiente fechado com um pré-adolescente ou adolescente.
  d) Descobrir o que a legislação vigente de seu país trata sobre cuidados especiais com pré-adolescentes e Adolescentes.
  • Citar fonte de pesquisa.
8. Pesquisar nos escritos do Espírito de Profecia, pelo menos, 10 citações a respeito de disciplina, educação, crescimento etc. de grupos de Juvenis e Adolescentes, que fazem parte de nosso Clube.'),
('AM-010', 'Testemunho Juvenil', 'atividades-missionarias', 'especialidade', 2, 1970, 'Associação Geral', '/esp/am-010.webp', 'https://mda.wiki.br/Especialidade_de_Testemunho_Juvenil', '1. Trazer para um Culto da Igreja, Escola Sabatina, pequeno grupo ou reunião do clube de desbravadores pelo menos 5 pessoas, não adventistas, de seu círculo de amizade escolar, vizinhança, amigos em geral ou familiares.
2. Com seu Clube ou Unidade:
  a) Participar de 2 atividades missionárias;
  b) Assistir, pelo menos, 10 Classes Bíblicas promovidas pelo Clube
  c) Participar de 1 campanha de arrecadação de alimentos ou roupas
3. Relatar em sua classe da Escola Sabatina pelo menos 15 atividades de testificação durante o ano, como Contatos Missionários, pessoas auxiliadas com Remédios, Roupas ou Alimento, Literatura Distribuída, Horas de Ajuda Humanitária etc.
4. Participar de uma Campanha de Distribuição de Literatura Denominacional (Impacto Esperança, por exemplo).
5. Saber de memória pelo menos 2 textos chaves para cada ensinamento bíblico a seguir
  a) Segunda Vinda de Cristo
  b) Sábado
  c) Estado dos mortos
  d) Lei e graça
  e) Conversão
  f) Juízo
  g) Inspiração da Bíblia
  h) Espírito de Profecia
  i) A recompensa dos santos
  • Apresentar ao seu orientador oralmente esse requisito.
6. Ter a sua Lição da Escola Sabatina do ano e estudá-la regularmente.'),
('AM-011', 'Asseio e Cortesia Cristã', 'atividades-missionarias', 'especialidade', 2, 1975, 'Associação Geral', '/esp/am-011.webp', 'https://mda.wiki.br/Especialidade_de_Asseio_e_Cortesia_Cristã', '1. Parte I - Cortesia Cristã
2. Parte II - Asseio Cristão
## Parte I - Cortesia Cristã
1. Estudar Lucas 2:52. Como foi o desenvolvimento juvenil de Jesus e como você pode alcançar também essa combinação?
2. De acordo com o Salmo 8, que estima Deus atribui ao seu valor pessoal? Envie 5 cartões feitos à mão, com mensagens pessoais, poemas ou versos bíblicos para pessoas que estejam precisando de encorajamento em sua vizinhança ou igreja.
3. Com seu líder ou seu grupo de estudo para as especialidades, discutir sobre cada um dos itens abaixo:
  • Maneira apropriada de falar com pessoas mais velhas em público.
  • Como abordar as pessoas e fazer as apresentações necessárias.
  • Perguntas que devem ser evitadas.
  • Como demonstrar preocupação pelos sentimentos dos outros.
  • O que dizer ao atender à porta.
  • Como atender o telefone corretamente.
  • Como evitar fofocas e conversas que podem prejudicar as pessoas.
4. Colocar em prática a discussão do item anterior com um grupo de desbravadores.
5. Ler o Salmo 19:14. Escrever uma pequena oração sobre como você deseja usar seu dom da fala para a glória de Deus.
6. Fazer uma lista de 10 coisas que você deseja praticar no que diz respeito ao seu relacionamento com seus semelhantes.
## Parte II - Asseio Cristão
1. Ler o livro Educação, página 198, parágrafo 3, e citar os benefícios mencionados que lhe advirão resultados de uma postura correta.
2. Com seu líder ou seu grupo de estudo para as especialidades, cumprir o seguinte:
  • Fazer uma lista de pontos que demonstrem o poder de uma postura correta. Verificar sua postura e perfil físico. Demonstrar a posição correta para ficar em pé e para sentar-se.
  • Apresentar duas razões pelas quais a boa forma física é importante. Explicar a relação entre um regime adequado, exercícios e controle de peso.
  • Mencionar a importância de um asseio adequado:
    • Banho.
    • Higiene corporal.
    • Hálito e higiene bucal.
    • Cuidado apropriado das roupas.
    • Asseio com os cabelos.
    • Cuidado adequado com as mãos e unhas.
  • Discutir as orientações bíblicas que o ajudarão a lidar com sua sexualidade e a manter seus pensamentos puros. Discutir inteligentemente aquilo que se pode ou não se pode fazer ao namorar.
  • Conhecer as regras de etiqueta à mesa. Saber como ser um convidado agradável e uma alegria para seu anfitrião ou anfitriã.
  • Saber a importância de uma higiene diária da alma, de desenvolver um caráter cristão, e por que pertencer a Cristo faz diferença em sua maneira de vestir-se e agir.
  • Relacionar 10 princípios que podem ajudá-lo a superar a inibição e a vergonha.'),
('AM-012', 'Vida Familiar', 'atividades-missionarias', 'especialidade', 1, 1975, 'Associação Geral', '/esp/am-012.webp', 'https://mda.wiki.br/Especialidade_de_Vida_Familiar', '1. Usando o Livro "O Lar Adventista" de Ellen G. White, como base de suas pesquisas, resuma em um paragrafo o papel dos membros de uma família:
  a) Pai/Mãe
  b) Filhos
2. Pesquisar o papel da família na sociedade de 20-30 anos atrás (na época de seus pais ou avós) em contraste com os dias atuais em relação a:
  a) Moral
  b) Costumes
  c) Respeito com os mais velhos
  d) Educação escolar
  e) Namoro, noivado e casamento
  • Citar a bibliografia e fontes usadas.
3. Relatar, em forma de um diário, durante uma semana algumas características do relacionamento familiar dos seus pais ou responsáveis, de sua própria pessoa, de seus irmãos (se tiver) e dos parentes próximos os quais você convive.
  a) Conflitos e tensões
  b) Respeito para com os mais velhos
  c) Autoridade dos pais ou responsáveis
4. Escrever um parágrafo sobre alguma das coisas positivas em sua família. Incluir as coisas das quais você se orgulha e as boas qualidades e realizações de sua família.
5. Fazer uma lista de algumas coisas nas quais sua família gasta dinheiro. Explicar sua responsabilidade nas finanças da família.
6. Fazer uma lista de atividades familiares que você acha que sua família gostaria. Fazer pelo menos uma dessas atividades em cumprimento da especialidade.
7. Durante 1 mês, com o máximo possível de membros de sua família, criar uma rotina para o Culto Familiar, Matutino (pela manhã) ou Vespertino (à tarde ou noite), assim como os Cultos de Pôr-do-sol de Sexta Feira.
8. Mencionar 5 maneiras de demonstrar atenção, interação e interesse por seus vizinhos. Colocar uma dessas maneiras em prática. Fazer um relatório do resultado.
9. Cite pelo menos 5 atividades sabáticas que podem ser realizadas por sua família que estejam de acordo com o Bíblia. Se possível, realizar pelo menos uma dessas atividades e relatar o resultado.'),
('AM-013', 'Temperança', 'atividades-missionarias', 'especialidade', 3, 1976, 'Associação Geral', '/esp/am-013.webp', 'https://mda.wiki.br/Especialidade_de_Temperança', '1. Memorizar e assinar o Voto de Temperança: "Consciente de que o uso do álcool e fumo e o uso de drogas não recomendadas por médicos não é compatível com um viver saudável, comprometo-me a não apenas me abster do uso dessas substâncias e viver de acordo com os princípios da Temperança Cristã, mas também a ajudar os outros a compreender e aceitar esse estilo mais saudável de vida"; ou criar seu próprio voto.
2. Explicar 3 citações em cada uma das categorias: Bíblia e Espírito de Profecia.
  • Bíblia
    1. Romanos 12:1, 2
    2. I Coríntios 10:31
    3. I Coríntios 6:19, 20
    4. Provérbios 20:1
    5. Gálatas 5:22, 23
    6. III João 2
    7. Um verso de sua escolha que ressalte a importância da temperança em nossa vida espiritual.
  • Espírito de Profecia
    1. "A verdadeira temperança nos ensina a abstermo-nos inteiramente daquilo que é prejudicial, e usar com parcimônia apenas alimentos saudáveis e nutritivos" Temperança, pág. 138.
    2. O único caminho seguro é não tocar, não provar, não manusear chá, café, vinhos, o fumo, ópio e bebidas alcoólicas" Conselhos Sobre Regime Alimentar, pág. 428.
    3. "... a temperança por si só é o fundamento de todas as graças que vêm de Deus, o fundamento de todas as vitórias a serem alcançadas." Temperança, pág. 201.
    4. "Uma vida pura e nobre, uma vida de vitória sobre o apetite e o desejo, é possível a todos que unirem a fraca vontade humana à onipotente e Inabalável vontade de Deus." Temperança, pág. 113.
    5. O tabaco é um lento, porém maligno veneno. Em quaisquer das formas que é usado, depõe contra a constituição; e torna-se mais perigoso porque seus efeitos são lentos, e, à primeira vista, imperceptíveis." - Medicina e Salvação, pág. 327, 328.
    6. Uma citação de sua escolha que ressalte a importância da temperança em nossa vida espiritual.
3. Escolher e executar 2 das atividades abaixo:
  a) Escrever e apresentar um discurso de 5 a 8 minutos sobre a temperança.
  b) Escrever um trabalho de 150 a 200 palavras sobre estilo de vida saudável, a importância do exercício físico e abordar a necessidade de evitar o uso de álcool, tabaco e drogas.
  c) Escrever um verso sobre o tópico da prevenção das drogas.
  d) Desenhar/fazer um cartaz ou publicar um material em suas redes sociais sobre os efeitos prejudiciais das drogas, tabaco e álcool.
  e) Realizar uma exposição sobre o perigo das drogas num shopping, biblioteca ou escola.
  f) Fazer um caderno de, pelo menos, 20 páginas, com anúncios antidrogas colados nas páginas do mesmo.
  g) Compartilhar com, pelo menos, 5 pessoas o que você conseguiu aprender a partir da lista acima, e convencê-los a assinar o Voto de Temperança (familiares mais próximos não podem ser incluídos).
4. Sobre o Cigarro, Drogas e Álcool:
  a) Saber e explicar a razão por trás da advertência contida nos maços de cigarro: "Fumar é prejudicial à saúde"
  b) O que é fumante passivo?
  c) Pesquisar sobre quantas pessoas morrem anualmente no seu país vítimas do cigarro e quanto o governo gasta com a saúde de pacientes.
  d) Pesquise sobre 4 dos seguintes ingredientes da fumaça do tabaco:
    1. Nicotina
    2. Arsênico
    3. Formaldeído
    4. Monóxido de carbono
    5. Cianeto
    6. Fenolbenzofrina
    7. Amônia
  e) Pesquisar sobre 2 das doenças relacionadas ao cigarro:
    1. Enfisema
    2. Câncer
    3. Dependência
    4. Cirrose
  f) Pesquisar sobre quantas pessoas morrem anualmente no seu país vítimas do álcool (de acidentes ou em decorrência do uso exagerado).
  g) Pesquisar quais os efeitos do tabaco, álcool e drogas na gravidez.
  h) Leia o capitulo "Estimulantes e Narcóticos, no livro Medicina e Salvação (de Ellen White). Ser capaz de discutir com seus desbravadores (ou unidade) sobre o que aprendeu.
5. Dramatizar em uma reunião do clube, acampamento ou evento que o clube venha a participar, o que você faria se:
  a) Seu melhor amigo lhe pedisse para experimentar um cigarro?
  b) Um colega de classe lhe oferecesse dinheiro para vender maconha?
  c) Um parente mais velho lhe oferecesse um gole de cerveja?
  d) A fumaça do cigarro de um estranho o estivesse incomodando?
  e) Um amigo o convidasse para fumar maconha?
  f) Você fosse a uma festa com um amigo, ele ficasse bêbado e insistisse em dirigir na hora de voltar para casa?
6. Pesquise sobre as leis anti-fumo e anti-álcool criadas pelo governo do seu pais. Faça um pequeno relatório sobre sua pesquisa.'),
('AM-014', 'Língua de Sinais', 'atividades-missionarias', 'especialidade', 1, 1978, 'Associação Geral', '/esp/am-014.webp', 'https://mda.wiki.br/Especialidade_de_Língua_de_Sinais', '1. Aprender e demonstrar ao seu instrutor o alfabeto (letras e números) da língua de sinais do seu pais.
2. Ter, no mínimo, 3 horas de aula da língua de sinais do seu país, ministradas por um instrutor fluente nela.
3. Usando o alfabeto manual, enviar e receber sinais numa velocidade de 5 palavras por minuto, usando um mínimo de 30 letras.
4. Aprender, pelo menos, 100 sinais a partir de um instrutor fluente na língua de sinais.
5. Aprender e apresentar na língua de sinais do seu país pelo menos duas músicas com, no mínimo, 2 minutos cada. As músicas devem ser apresentadas usando-se sinais e não o alfabeto.
6. Cumprir dois dos seguintes itens:
  a) Saber e explicar a diferença entre sinais e gestos.
  b) Saber e explicar a diferença entre surdo e deficiente auditivo.
  c) Visitar uma escola de ensino fundamental que trabalhe com surdos e perguntar como funciona o sistema de inclusão do aluno surdo.'),
('AM-016', 'Aventuras com Cristo', 'atividades-missionarias', 'especialidade', 1, 1989, 'Associação Geral', '/esp/am-016.webp', 'https://mda.wiki.br/Especialidade_de_Aventuras_com_Cristo', '1. Escolher 2 dos itens a seguir a realizá-los com constância:
  a) Ler o Devocional Teen (ou equivalente para sua idade) diariamente.
  b) Estudar regularmente a lição da Escola Sabatina
  c) Seguir o plano de leitura do ano bíblico dos desbravadores.
  d) Desenvolver um diário de oração pessoal, listando pessoas e pedidos pelos quais está orando e as respostas a estas orações.
  e) Planejar e realizar, pelo menos, 1 culto familiar por semana
2. Escolher 3 dos itens a seguir a realizá-los:
  a) Por meio físico ou digital, enviar mensagens pessoais, poemas ou versos bíblicos para pessoas que estão precisando de encorajamento.
  b) Visitar 5 ou mais pessoas e convidá-las para um evento especial da igreja ou do clube de Desbravadores.
  c) Escolher um amigo e visitar alguém que tem estado ausente da Escola Sabatina, Igreja ou Clube de Desbravadores. Levar um cartão e um presente feito em casa. Compartilhar esta experiência com sua família e ore por esta pessoa.
  d) Enviar mensagens, via rede social, para pessoas que você conheça, convidando-os a participar de um curso bíblico online, ou convidando-os a participar de um evento ou culto de sua igreja.
  e) Enviar mensagens ou sermões adventistas, via redes sociais, para 10 pessoas.
  f) Ligar para o pastor, primeiro ancião ou diácono e oferecer-se para ajudá-lo com quaisquer tarefas que você possa ajudar.
  g) Levar alimentos, juntamente com uma mensagem bíblica ou livro missionário a uma família carente.
  h) Gravar um vídeo e enviar, via redes sociais, a 10 pessoas falando o quanto Jesus é importante para você.
3. Escolher um dos itens a seguir e realizá-los com seu clube, unidade ou grupo de estudo da especialidade:
  a) Procurar jardins ou praças que precisam de uma limpeza e recolher a sujeira em sacos plásticos.
  b) Planejar uma festa de aniversário para uma criança ou idoso com jogos, presentes e diversões em um orfanato ou asilo.
  c) Participar de um projeto de testemunho como dar estudo bíblicos, distribuir exemplares de livros missionários, adotar uma família necessitada, ou ajudar uma pessoa idosa que necessite de ajuda e casa.
  d) Ajudar pessoas que sofreram alguma tragédia ocorrida em sua cidade ou proximidades.'),
('AM-017', 'Aventuras com Cristo - avançado', 'atividades-missionarias', 'especialidade', 2, 1989, 'Associação Geral', '/esp/am-017.webp', 'https://mda.wiki.br/Especialidade_de_Aventuras_com_Cristo_-_avançado', '1. Ter a Especialidade de Aventuras com Cristo.
2. Criar seu próprio empreendimento missionário.
  • Instruções:
    1. Você deve se envolver com o projeto, pelo menos, 4 vezes em um período de 1 mês.
    2. O projeto pode ser individual ou com sua unidade ou grupo de estudo para essa especialidade.
    3. Projetos do Clube não devem valer para o cumprimento dessa especialidade.
    4. Você deve relatar cada passo do projeto, desde o planejamento, até a execução e seus resultados. Tirar fotos e registrar na internet (redes sociais).
3. Projetar e executar 3 novas aventuras:
  • Instruções:
    1. Cada uma das atividades deve ter, pelo menos, 2 horas.
    2. Elas devem ser atividades distintas, isto é, não podem estar diretamente relacionadas umas às outras.
    3. Cada atividade deve ser feita em uma data diferente e alcançar objetivos diferentes.
4. Participar de, pelo menos, 1 dos projetos do Ministério Jovem ou de outros Ministérios de sua Igreja, como projetos Calebe, Colportagem, Vida por Vidas, Mutirão de Natal, campanhas de conscientização sobre dengue, doenças, vida saudável, contra as drogas e etc., atividades do Ministério da Criança, Ministério do Adolescente, Ministério da Mulher, etc. Apresentar fotos e relatório da atividade em que você se envolveu.'),
('AM-018', 'Língua de sinais - avançado', 'atividades-missionarias', 'especialidade', 3, 1991, 'Associação Geral', '/esp/am-018.webp', 'https://mda.wiki.br/Especialidade_de_Língua_de_sinais_-_avançado', '1. Ter a especialidade de Língua de sinais.
2. Ter, no mínimo, 5 horas de aula (além das 3 horas da especialidade básica) da língua de sinais do seu país, ministradas por um instrutor fluente nela.
3. Ser capaz de manter uma conversa com um surdo, usando sinais, por, no mínimo, 2 minutos.
4. Aprender, pelo menos, 300 sinais a partir de um instrutor fluente na língua de sinais.
5. Conhecer, entender e demonstrar as seguintes estruturas gramaticais da língua de sinais:
  a) Expressão facial
  b) Configuração das mãos
  c) Movimento
  d) Localização do sinal
6. Interpretar, pelo menos, 4 músicas a um surdo.
7. Sinalizar a um surdo uma das opções abaixo:
  a) O Pai Nosso - Mateus 6:8-17
  b) As Bem-Aventuranças - Mateus 5:3-12
  c) Os Dez Mandamentos - Êxodo 20:3-17'),
('AM-019', 'Marcação Bíblica', 'atividades-missionarias', 'especialidade', 1, null, 'Divisão do Sul do Pacífico', '/esp/am-019.webp', 'https://mda.wiki.br/Especialidade_de_Marcação_Bíblica', '1. Fazer um relatório contendo:
  a) O nome de cinco métodos diferentes de marcar a Bíblia.
  b) Uma explanação de como cada método deve ser usado.
  c) As vantagens e desvantagens de cada método.
2. Relacionar cinco orientações que você deve observar antes de iniciar a marcação de sua Bíblia.
3. Fazer o seguinte:
  a) Qual método você usaria para marcar sua Bíblia de estudo e por quê?
  b) Marcar sua Bíblia para dois assuntos/temas usando este método.
4. Fazer o seguinte:
  a) Quais métodos você usaria para fazer um curso ou estudo devocional e por quê?
  b) Marcar sua Bíblia para dois assuntos/temas usando este método, com no mínimo de 10 textos para cada assunto ou tema.'),
('AM-020', 'Marcação Bíblica - avançado', 'atividades-missionarias', 'especialidade', 3, null, 'Divisão do Sul do Pacífico', '/esp/am-020.webp', 'https://mda.wiki.br/Especialidade_de_Marcação_Bíblica_-_avançado', '1. Ter a especialidade de Marcação bíblica.
2. Marcar dois estudos adicionais em sua Bíblia de estudo usando no mínimo 20 textos cada.
3. Usando uma concordância, marcar dez textos para um estudo devocional.
4. Descrever as diretrizes para se manter um claro processo de marcação fornecer uma chave para o entendimento da sua Bíblia marcada.
5. Dar uma lição de estudo bíblico usando a sua Bíblia marcada.'),
('AM-021', 'Pregador Evangelista', 'atividades-missionarias', 'especialidade', 2, null, 'Divisão Norte Americana', '/esp/am-021.webp', 'https://mda.wiki.br/Especialidade_de_Pregador_Evangelista', '1. O que é preparação espiritual?
2. Discutir com o seu instrutor a importância da preparação espiritual para o evangelismo.
3. O que significa o termo Discípulo?
4. Qual método de Cristo para discipular?
5. Relacionar, pelo menos, 5 coisas que a igreja pode fazer para discipular um novo crente.
1. Demonstrar e/ou explicar, pelo menos, 3 maneiras de convidar alguém para uma reunião evangelística.
1. Relacionar os equipamentos necessários para uma campanha evangelística com uso de multimídia.
2. Detalhar os cuidados necessários que cada equipamento necessita (cuidados com poeira, limpeza, manutenção básica).
  a) Computador;
  b) Equipamentos de vídeo;
  c) Equipamentos de som.
1. Desenvolver um orçamento com o pastor ou com o líder de uma equipe evangelística.
2. Saber quanto dinheiro você terá disponível e como ajustar seu planejamento ao seu orçamento.
3. Pesquisar o custo do seguinte:
  a) Equipamentos(no caso do local da reunião não dispor deles)
  b) Materiais impressos
  c) Custos de envio e postagem
  d) Publicidade
  e) Aluguel do prédio
1. Conhecer as Leis que regulamentam a realização de reuniões públicas em sua região.
1. Usar um programa próprio para montagem e apresentação de slides
  a) Demonstrar habilidade para editar os slides
  b) Usar o primeiro slide para apresentar o tema
  c) Praticar o sermão em voz alta com o instrutor
  d) Discutir com seu instrutor sobre a apresentação, pedindo conselhos de como melhorá-la
1. O que é um apelo feito no altar?
2. Quais os principais ingredientes para fazer um apelo do altar?
1. Apresentar um sermão de, pelo menos, 5 minutos que você tenha montado.'),
('AM-022', 'Pregador Evangelista - avançado', 'atividades-missionarias', 'especialidade', 3, null, 'Divisão Norte Americana', '/esp/am-022.webp', 'https://mda.wiki.br/Especialidade_de_Pregador_Evangelista_-_avançado', '1. Ter a especialidade de Pregador evangelista.
2. Participar de uma série evangelística pregando, pelo menos 6 sermões nesta série de conferências.
3. Ler o capitulo "O Trabalhador e suas qualificações do livro Evangelismo, de Ellen White. Fazer uma apresentação para um grupo que está cumprindo a especialidade de Pregador evangelista sobre o que você aprendeu.'),
('AM-023', 'Santuário', 'atividades-missionarias', 'especialidade', 2, 2004, 'Divisão Norte Americana', '/esp/am-023.webp', 'https://mda.wiki.br/Especialidade_de_Santuário', '1. Sobre o santuário responder:
  a) Qual o nome das 3 partes em que o santuário era dividido?
  b) Descrever o que tinha em cada parte (móveis/objetos);
  c) Descrever o que cada móvel/objeto disposto no santuário representava.
2. Desenhar um modelo em escada do santuário, do pátio e da posição dos objetos.
3. Quantos revestimentos cobriam o Santuário?
4. Participar de um debate sobre I João 1:9, Daniel 8:14 e Êxodo 25:8.
5. De qual das 12 tribos pertencia o Sacerdote? Por quê?
6. Descrever as vestimentas do:
  a) Sacerdote
  b) Sumo-Sacerdote
7. Ler a pagina 488 do livro ''O Grande Conflito'' e Hebreus 4:14 a 16 e participar de um debate sobre o assunto.
8. Quais animais eram trazidos diariamente ao pátio? E quais animais eram trazidos no Dia da Expiação?
9. Escrever em um parágrafo como o santuário e seus rituais apontavam para Cristo e Seu ministério.
10. Apresentar um relatório comparando a obra realizada no santuário terrestre com a obra realizada no santuário celestial. Apontar também a relação com a segunda vinda de Cristo.'),
('AM-024', 'Dramatização Cristã', 'atividades-missionarias', 'especialidade', 2, 2006, 'Divisão Norte Americana', '/esp/am-024.webp', 'https://mda.wiki.br/Especialidade_de_Dramatização_Cristã', '1. Memorizar e aplicar os princípios contidos em 1 Coríntios 10:31.
2. Descrever cada uma das seguintes categorias de Dramatização:
  a) Esquetes
  b) Pantomima
  c) Leitura dramática (declamação), em monólogo, dueto ou grupo
  d) Musical
3. Descrever de que forma e onde cada uma das áreas de dramatização do requisito anterior pode ser usada para evangelizar pessoas.
4. Conhecer e explicar as seguintes regras sobre representação:
  a) Nunca virar as costas para a plateia
  b) O tempo de leitura e sequência do script deve ser lento durante uma linha falada e rápido entre as linhas (sem espaço morto entre os personagens falando)
  c) Falar claramente as palavras (exceto quando indicado pelo diretor de palco)
  d) Não consumir produtos lácteos ou doces (chocolate, refrigerante) antes de falar ou cantar
  e) Manter a postura/concentração (não sorrir, salvo quando indicado pelo diretor de palco)
  f) Ficar no seu espaço (salvo quando indicado pelo diretor de palco)
  g) Não bloquear a visão da plateia dos outros personagens
  h) Usar as mãos e os olhos
  i) Demonstrar presença e contracenar com um objeto imaginário
  j) Não ter nada bloqueando a boca (chiclete, etc)
5. Conhecer e explicar por que as seguintes regras são importantes para a pantomima. Praticar essas regras em uma história bíblica.
  a) A pantomima usada como um ministério evangelístico nunca deve ser um jogo de adivinhação, deve indicar claramente o tema e objetivo.
  b) E importante lembrar que na obra dramática, o pensamento vem em primeiro lugar. Deixe os olhos responderem primeiro, depois o rosto e a cabeça e, finalmente, o resto do corpo. isso é chamado de sequência motivada.
  c) As ações devem ser sempre simples e claras.
  d) Cada movimento e expressão deve ser sempre visível.
  e) Deve haver uma razão para cada gesto ou movimento.
  f) Apenas um gesto ou movimento deve ser feito ao mesmo tempo.
  g) Ensaiar até que você tenha criado uma caracterização clara.
6. No ambiente de atuação, conhecer os seguintes termos:
  a) Improviso
  b) Bastidores
  c) Marcação
  d) Deixa
  e) Boca de cena
  f) Saída de palco
  g) Leitura de mesa
  h) Imóvel
  i) Esquerda e Direita do palco
  j) Centro da esquerda e centro da direita do palco
  k) Set
  l) Tempo
  m) Caco
  n) Engolir em cena
7. A partir das dramatizações listadas no requisito 2, planejar e executar 2 das categorias em 2 dos seguintes ambientes: culto, igreja, acampamento, campori, reunião do clube.
8. Como um grupo, criar uma nova dramatização e apresentá-la.'),
('AM-025', 'Desfile com Carros Alegóricos', 'atividades-missionarias', 'especialidade', 2, 2009, 'Divisão Norte Americana', '/esp/am-025.webp', 'https://mda.wiki.br/Especialidade_de_Desfile_com_Carros_Alegóricos', '1. Aprender e aplicar as regras de segurança na criação de um carro alegórico.
2. Listar, pelo menos, cinco materiais que podem ser usados na construção e decoração de um carro alegórico.
3. Ajudar a construir um carro alegórico:
  a) Colaborar no design do carro alegórico para seu clube desbravadores, ou grupo de jovens.
  b) Auxiliar no planejamento do material necessário e se envolver na coleta destes materiais.
  c) Participar da decoração por, pelo menos, 4 horas.
4. Participar de um desfile com o carro alegórico que você ajudou a construir e decorar e, quando apropriado, distribuir panfletos que expliquem sobre os Desbravadores e o Ministério Jovem.
5. Fotografar seu carro alegórico durante a criação e durante o desfile e compartilhar a experiência com sua unidade, clube, classe da escola sabatina ou igreja.
6. Memorizar Marcos 16:15 e discutir com um grupo como a especialidade Desfile com Carros Alegóricos ajuda a cumprir este mandamento bíblico.'),
('AM-026', 'Desfile com Carros Alegóricos - avançado', 'atividades-missionarias', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2026', '/esp/am-026.webp', 'https://mda.wiki.br/Especialidade_de_Desfile_com_Carros_Alegóricos_-_avançado', '1. Ter a especialidade de Desfile com carros alegóricos.
2. Veja com sua equipe os requisitos básicos de segurança sobre o uso de escadas, ferramentas manuais, facas e outros equipamentos elétricos usados para completar esta especialidade. Demonstrar segurança em todos os aspectos para criar seu carro alegórico.
3. Construa um carro alegórico (com seu clube de Desbravadores ou grupo de jovens), não usado anteriormente para completar a especialidade básica, com no mínimo as seguintes especificações:
  a) Base de 2 metros por 3 metros.
  b) Partes móveis movidas mecanicamente (não incluindo as partes usadas para transportar o carro, como eixo, rodas, volante, etc.).
4. Estar envolvido no design de um carro alegórico. Como parte deste envolvimento:
  a) Planejar materiais necessários e delegar representantes para coletar estes itens.
  b) Decorar um carro alegórico por, pelo menos, seis horas.
  c) Estar envolvido na direção do desenvolvimento e criação de pelo menos uma parte do carro alegórico.
5. Usar um carro alegórico em pelo menos dois desfiles. Um deles pode ser em uma feira de desbravadores ou algo equivalente.'),
('AM-027', 'Pacificador', 'atividades-missionarias', 'especialidade', 1, 2009, 'Divisão Norte Americana', '/esp/am-027.webp', 'https://mda.wiki.br/Especialidade_de_Pacificador', '1. Identificar quatro causas de conflito descritas na bíblia. Leia as seguintes passagens como ponto de partida.
  a) Gálatas 2:11-14
  b) I Coríntios 12:12-31
  c) Gênesis 13:1-12
  d) Tiago 4:1-3
2. Explicar as seguintes formas de abordar uma contradição e discutir com seu conselheiro ou unidade usando exemplos bíblicos e suas próprias experiências.
  a) Negação
    1. Acusações mútuas
    2. Fuga
  b) Ataque
    1. Luta
    2. Fofoca
    3. Ridicularização
  c) Conciliação
    1. Identificar o conflito
    2. Conversar em particular com cada uma das partes
    3. Negociação
3. Dramatizar uma situação de conflito ocorrida com você e analisar o seu comportamento na contradição e quais as opções de conciliação possíveis.'),
('AM-028', 'Pacificador - avançado', 'atividades-missionarias', 'especialidade', 3, 2009, 'Divisão Norte Americana', '/esp/am-028.webp', 'https://mda.wiki.br/Especialidade_de_Pacificador_-_avançado', '1. Ter, no mínimo, 15 anos.
2. Ter a especialidade de Pacificador.
3. Definir mediação e arbitragem e discutir as semelhanças e diferenças entre elas.
4. Explicar a função e responsabilidades de um mediador e de um árbitro.
5. Comparar litígio (conflito em que a decisão é dada por um terceiro) e conciliação e discutir as vantagens e desvantagens de cada uma.
6. Identificar quais tipos de conflitos podem ser:
  a) Mediados
  b) Arbitrados
  c) Litigados
  d) Conciliados
7. Cumprir um dos seguintes:
  a) Participar de uma arbitragem de conflito entre duas pessoas ou grupos. Discutir o processo, identificando o que funcionou, o que não funcionou.
  b) Participar de uma mediação de conflito entre duas pessoas ou grupos. Discutir o processo, identificando o que funcionou, o que não funcionou.
  c) Assistir a uma audiência de conciliação (em que as partes tenham chegado a um acordo), a uma audiência de instrução e julgamento e apresentar um relatório mencionando qual dessas duas formas soluciona o conflito mais satisfatoriamente.
  • Observação: as audiências do Juizado Especial Cível e das Varas Cíveis são abertas ao público. Para assisti-las basta conversar na secretaria da Vara ou com o chefe de gabinete.
  a) Atuar como conciliador voluntário em um Juizado Especial por, no mínimo, 6 meses.'),
('AM-029', 'Adoração Cristã', 'atividades-missionarias', 'especialidade', 3, 2011, 'Divisão do Sul do Pacífico', '/esp/am-029.webp', 'https://mda.wiki.br/Especialidade_de_Adoração_Cristã', '1. Para ajudar a apreciar o caráter e a majestade do Deus cristão, discutir o que as escrituras dizem sobre os seguintes temas:
  a) O orgulho de Satanás, o conflito no céu, Satanás expulso do céu
  b) A criação da Terra e seus habitantes
  c) Adão e Eva no Jardim do Éden e sua expulsão
  d) As deficiências da raça humana
  e) A promessa de Deus de enviar o seu filho para a raça humana
  f) O nascimento do Messias, Jesus Cristo
  g) O ministério de Jesus Cristo
  h) A morte de Jesus Cristo na cruz
  i) A ressurreição de Jesus, Sua ascensão ao céu e a promessa de retorno
  j) O Espírito Santo é recebido e o evangelho é pregado em todo o mundo
  k) Cristo volta para reivindicar sua criação, O que acontece com aqueles que estão vivos e com aqueles que estão mortos?
  l) Povo de Cristo no céu e nova terra para todo o sempre
2. Descrever o significado moderno da palavra adoração. Pesquisar as palavras no idioma original das Escrituras que foram traduzidas como adoração.
3. Escolher, pelo menos, 3 passagens das Escrituras que se referem ao verdadeiro culto a Deus. Descrever brevemente como cada um pode ser aplicado à sua vida.
4. Estudar, pelo menos, 2 dos seguintes acontecimentos e discutir onde cada um não estava de acordo com a vontade de Deus.
  a) O sacrifício de Caim (fruto da terra) (Gênesis 4:2-8)
  b) A adoração do bezerro de ouro pelos israelitas (Êxodo 32)
  c) O grande erro de Nadabe e Abiú (Levítico 10:1-7)
  d) A oração do fariseu e a do coletor de impostos (Lucas 18:9-14)
5. Discutir como as instruções e ilustrações nas Escrituras podem ser aplicadas ao culto cristão de hoje. Ter em conta a localidade de sua igreja.
  a) Local e horário adequado para o culto
  b) Que temas utilizar nos cultos de adoração
  c) Qual tipo de louvor deve ser utilizado para os cultos de adoração
6. Preparar um Esboço sobre como dirigir um culto de adoração, tendo como base os seguintes temas:
  a) Preparação da congregação e oração
  b) O tema adoração e a música apropriada ao culto
  c) Equipe de adoração (músicos, sonoplastia, diáconos, diretores departamentos, ancionato)
  d) A congregação (divisão por idades, a linguagem, questões pessoais, expectativas das visitas, fundo cultural nos cultos, vestimentas para a adoração)
7. Conversar com o responsável pelo departamento de música de sua Igreja sobre como são selecionados os louvores para os cultos e apresentar um relatório sobre a importância da música nos cultos de adoração a Deus.
8. Completar2 das seguintes atividades e preparar um relatório apresentando como estas atividades mudaram sua maneira de adoração a Deus:
  a) Realizar uma série de estudo pessoal sobre adoração cristã (incluindo estudo da Bíblia, do Espírito de Profecia e da lição da escola sabatina).
  b) Participar da organização e auxilio de um culto semanal durante, pelo menos, 1 mês em sua igreja.
  c) Participar de uma equipe de louvor em sua igreja.
  d) Levar, pelo menos, 5 visitas aos cultos de sua igreja durante, pelo menos, 1 mês. (As visitas podem ser em cultos distintos).'),
('AM-030', 'Arte da Pregação Cristã', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-030.webp', 'https://mda.wiki.br/Especialidade_de_Arte_da_Pregação_Cristã', '1. Pesquisar sobre o que significa oratória:
  a) Citar sua fonte de pesquisa.
  b) Pesquisar sobre grandes oradores de nossa história, citando brevemente o histórico de:
    1. Um orador da antiguidade
    2. Um orador da nossa história moderna
    3. Um orador de destaque em seu país
2. Pesquisar sobre o que significa Homilética (citar fonte de pesquisa).
3. Pesquisar sobre o que significa Exegese (citar fonte de pesquisa).
4. Preparar um esboço detalhado de um sermão cristão e apresentá-lo ao seu avaliador por escrito.
5. Fazer um dos seguintes itens:
  a) Participar de um curso de Oratória Cristã (obter certificado)
  b) Pregar em um culto da Igreja (entregar esboço do sermão)
  c) Em um evento que o Clube ou Igreja participe fora de sua cidade, apresentar uma breve meditação (entregar esboço)
6. Saber descrever o seguinte sobre um Sermão Cristão:
  • Características:
    1. Sermão Temático
    2. Sermão Expositivo
    3. Sermão Textual
  • Partes:
    1. Introdução
    2. Corpo do Sermão
    3. Ilustração
    4. Conclusão
    5. Apelo
7. Saber manusear, apresentando suas habilidades ao seu orientador ou conselheiro:
  a) Dicionário Bíblico
  b) Concordância Bíblica
  c) Cadeia temática de estudos Bíblicos
8. Ter o esboço de pelo menos 5 Sermões Cristãos.
9. Pregar, pelo menos, 4 vezes no período de um ano em sua igreja ou em uma igreja do seu distrito.
10. Obter, para sua coleção particular, um livro com ilustrações para sermões.
11. Confeccionar um sermão utilizando um comentário bíblico como um dos materiais de apoio'),
('AM-031', 'Arte da Pregação Cristã - avançado', 'atividades-missionarias', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/am-031.webp', 'https://mda.wiki.br/Especialidade_de_Arte_da_Pregação_Cristã_-_avançado', '1. Ter a especialidade de Arte da pregação cristã.
2. Saber a diferença básica entre as versões bíblicas:
  a) ARA
  b) ARC
  c) NVI
  d) NTLH
  e) Jerusalém
  f) A MENSAGEM
  g) NVT
  h) NAA
  • Responda o seguinte:
  a) Qual é a versão mais fiel ao original bíblico?
  b) Quais são as línguas originais da Bíblia?
  c) Citar pelo menos três versos que diferem grandemente o sentido nas versões pesquisadas acima. Procure saber qual é a tradução mais fiel ao texto original Bíblico.
3. Criar uma pequena coleção de 25 sermões cristãos, organizadas em formato de uma apostila:
  a) 10 deles devem ser de sua autoria
  b) Os demais (15) podem ser de terceiros
  c) Os sermões devem estar agrupados nas seguintes categorias:
    • I. Salvação
    • II. Vida Cristã / Santificação
    • III. Volta de Jesus
    • IV. Lei de Deus / Mandamentos
4. Fazer para, pelo menos, 5 dos seus sermões (compilados no item anterior), uma apresentação usando recursos audiovisuais ou sua criatividade.
5. Ter uma coleção de pelo menos 15 Meditações Bíblicas curtas (5-10 minutos) e usar pelo menos 5 delas em ocasiões especiais que o Clube venha a participar. Como no item 3, compilar as meditações em uma pequena apostila.
6. Fazer 1 dos seguintes itens:
  a) Apresentar uma série de estudos bíblicos (pelo menos 10 apresentações) a um grupo de pessoas reunidas na Igreja, numa classe bíblica ou série de evangelismo bíblico
  b) Estar na lista de pregação de sua igreja durante um ano, pregando, pelo menos, 10 vezes em todos os cultos da Igreja.
  c) Ser responsável por um período de, pelo menos, 3 meses da parte de pregação bíblica em um Pequeno Grupo
7. Selecionar 2 áreas abaixo e ler um livro em cada área escolhida:
  a) Arte da Pregação Bíblica
  b) Ilustrações para sermões
  c) Biografia de um grande Evangelista ou Pregador
  d) Concordância e Referencias Bíblicas
  e) Livros do Espirito de Profecia
8. Ter uma Bíblia com referências, concordância e preferencialmente comentada. Manuseá-la adequadamente para seu orientador ou conselheiro.
9. Quais problemas podem ocorrer ao não escolher adequadamente os materiais para a elaboração do sermão?'),
('AM-032', 'Arqueologia Bíblica', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-032.webp', 'https://mda.wiki.br/Especialidade_de_Arqueologia_Bíblica', '1. Definir arqueologia, diferenciando-a da paleontologia.
2. Defina os seguintes termos:
  a) Papirólogo
  b) Egiptólogo
  c) Assiriólogo
  d) Orientalista
  e) Escrita Cuneiforme
  f) Hieróglifo
  g) Paleografia
  h) Antiquário
  i) Sitio arqueológico
  j) Estratigrafia
  k) Tel, tell e Khirbet
  l) Réplica
3. Citar 5 ferramentas utilizadas por um arqueólogo numa escavação.
4. Quais são as principais técnicas de datação de um artefato arqueológico? Explicá-las.
5. Citar 3 benefícios que a arqueologia bíblica pode trazer ao estudante da Bíblia.
6. Redigir um relatório sobre a história da arqueologia bíblica com, pelo menos, 300 palavras.
7. O que é Maximalismo e Minimalismo?
8. Montar e manter uma pasta com 10 descobertas arqueológicas que colaboram a história bíblica tanto do Antigo como do Novo Testamento. A pasta deverá ter as seguintes características:
  a) Dados em ordem cronológica ou geográfica
  b) Organizados por Antigo e Novo Testamento
  c) Fotos
  d) Textos
  e) Fontes bibliográficas
  f) Comentário pessoal sobre cada artefato ou descoberta
9. Listar 5 escavações em andamento hoje, ao redor do mundo, que sejam relevantes para a compreensão do texto bíblico. Explicar porque cada escavação é relevante para a compreensão do texto bíblico.'),
('AM-033', 'Cerimônias', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-033.webp', 'https://mda.wiki.br/Especialidade_de_Cerimônias', '1. O que são cerimônias e quais as suas principais finalidades?
2. Descrever as seguintes cerimônias de um Clube de Desbravadores:
  a) Abertura (anual)
  b) Admissão
  c) Investidura
  d) Encerramento
  e) Dia do Desbravador
  f) Fogo do Conselho
1. De quem são as prerrogativas para a entrega dos seguintes emblemas:
  a) Classes
  b) Lenço
  c) Especialidades
  d) Insígnia de excelência
2. Quais os cuidados necessários em relação ao fogo dentro da igreja (tocha e pira)?
3. Como se prepara uma tocha? Mencionar os materiais adequados, incluindo segurança com os materiais inflamáveis.
4. Citar uma cerimônia que pode ser feita na natureza. Fazer o planejamento de como você faria essa cerimônia.
5. Mencionar e justificar 6 pontos fundamentais para realizar uma cerimônia de qualidade.
6. Participar no planejamento e organização de uma cerimônia de investidura ou admissão, incluindo:
  a) Tema
  b) Local adequado
  c) Ornamentação
  d) Divulgação
  e) Preparo do material com antecedência
  f) Trilha sonora
  g) Apresentações musicais
  h) Premiações (se houver)
  i) Projeção do hino e dos ideais dos desbravadores (ou entrega desses em folhetos)
  j) Inspeção de uniforme
7. Em um acampamento, dirigir uma cerimônia do fogo do conselho.
8. Qual a função de um mestre de cerimônias?
9. Explicar o significado do lema "uma cerimônia deve ser simples, breve e digna".'),
('AM-034', 'Braile', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-034.webp', 'https://mda.wiki.br/Especialidade_de_Braile', '1. O que é Braile?
2. Escrever uma biografia de Louis Braille de, pelo menos, 1 página.
3. O que é sensibilidade epicrítica?
4. O que são papel braile, regletes e punções?
5. Que elementos são necessários para a escrita manual em braile? O que é máquina "perkins"?
6. O que é uma cela braile?
7. Quais sãos e o que significam os graus 1, 2 e 3 do sistema braile?
8. Participar de um curso para escrever e ler em braile. O curso poderá ser virtual ou presencial.
  • Nota: Este site, http://www.braillevirtual.fe.usp.br/, apresenta um curso interessante e interativo, adequado para juvenis, em português, espanhol e inglês.
9. Traduzir, na presença do instrutor, o texto bíblico de Marcos 10:46-52.
10. Ler, em braile, no mínimo 90 palavras por minuto.
11. Escrever um pequeno cartão com uma mensagem bíblica para um deficiente visual.
12. Discutir o evangelho contido em João 9 com o seu instrutor.'),
('AM-035', 'Criacionismo', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-035.webp', 'https://mda.wiki.br/Especialidade_de_Criacionismo', '1. O que é modelo e teoria científica?
2. Quais as principais diferenças entre o modelo criacionista e o evolucionista?
3. Escrever uma redação com o tema: porque ser criacionista.
4. Sob a mediação do instrutor, participar de um debate sobre como é possível harmonizar ciência e fé.
5. Ler e responder o seguinte:
  a) 1 Timóteo 6:20 e 21. Que relação pode existir entre essa passagem e o evolucionismo?
  b) Gênesis 1 e 2. Pode alguém discordar destes textos e manter-se membro do povo remanescente? Justifique sua resposta.
6. Citar, ao menos, 5 passagens do Espírito de Profecia que façam menção à idade "jovem" da Terra.
7. Pesquisar sobre a crença fundamental ?a criação", da Igreja Adventista do Sétimo Dia. Demonstrar de forma satisfatória como fundamentar essa crença fundamental através da Bíblia, encontrando de memória, no mínimo, 5 passagens bíblicas que abonam essa ideia.
8. Citar, ao menos, 5 objeções feitas pelos evolucionistas às crenças criacionistas. Escrever, ao menos, um parágrafo explicando de maneira bíblica e/ou científica como refutar cada uma dessas objeções.
9. Ler os capítulos 6 a 9 de Gênesis. Após a leitura completar um dos seguintes:
  a) Realizar uma pesquisa e elaborar um cronograma detalhado sobre alguma teoria aceita por cientistas criacionistas sobre como aconteceram os fatos.
  b) Fazer uma lista com, pelo menos, 5 menções bíblicas ao dilúvio e dar, ao menos, 5 evidências histórico-científicas do dilúvio.
10. Pesquisar e demonstrar como argumentar em favor do criacionismo, utilizando 3 das seguintes questões:
  a) Do ponto de vista da biologia, o que são sistemas de complexidade irredutível? Como esses sistemas contradizem a teoria evolucionista?
  b) Do ponto de vista da geologia, pesquisar e desenhar um modelo criacionista da coluna geológica e compará-la com o modelo evolucionista. Explicar como as lacunas em ambos os modelos são completadas com bases filosóficas (não comprovadas cientificamente).
  c) Do ponto de vista da oceanografia, como a sedimentação oceânica tem indicado que os oceanos são "jovens"?
  d) Do ponto de vista da astronomia, como o afastamento progressivo da Lua, em relação ao centro gravitacional da Terra (levando-se em conta o "limite de Roche") indica uma Terra (e Lua) jovem?
  e) Do ponto de vista da arqueologia, o que são fósseis de transição? Como a ausência deles argumenta em favor do criacionismo?'),
('AM-036', 'Criacionismo - avançado', 'atividades-missionarias', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/am-036.webp', 'https://mda.wiki.br/Especialidade_de_Criacionismo_-_avançado', '1. Ter as seguintes especialidades:
  a) Criacionismo
  b) Geologia
  c) Fósseis
2. Explicar os seguintes termos:
  a) Cosmologia
  b) Cosmogênese
  c) Teoria do Design Inteligente
  d) Espécie de transição ou elo perdido
  e) Fóssil vivo
  f) Teoria do Big Bang
3. Fazer uma pesquisa e relatar por escrito, pelo menos 500 palavras, aspectos do poder criador de Deus na natureza que demonstre propósito e planejamento.
4. Diferenciar evolução (em seu sentido macro ou micro) de adaptação ao ambiente.
5. Reler o relato bíblico do dilúvio e descrever sua influência sobre os seguintes:
  a) Deriva continental
  b) Relevo e clima
  c) Extinção em massa e formação dos fósseis
6. Na interpretação criacionista, qual é a origem do homem e quem foram os homens da caverna?
7. Qual é o argumento do relojoeiro de Paley?
8. Relatar brevemente a experiência de Pascal e explicar porque "vida somente provém de vida".
9. Fazer uma lista pessoal de 10 evidências científicas da criação (diferentes das abordadas nessa especialidade e na básica) e apresentar a seu Clube.
10. Estudar a vida e contribuições de um cientista criacionista e contar esta história a um grupo de desbravadores durante um fogo de conselho ou outra reunião espiritual.
11. Completar uma das seguintes atividades:
  a) Participar de forma ativa de um debate sobre: criacionismo x evolucionismo.
  b) Apresentar uma palestra em audiovisual de, ao menos, 30 minutos sobre algumas das evidências do requisito 9 desta especialidade para um grupo de desbravadores, ou igreja, ou evento criacionista.
  c) Participar de um encontro de cunho criacionista e apresentar o certificado.
  d) Organizar um evento sobre criacionismo, com palestrante qualificado e reconhecido.'),
('AM-037', 'Espírito de Profecia', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-037.webp', 'https://mda.wiki.br/Especialidade_de_Espírito_de_Profecia', '1. O que é o dom profético?
2. Quais são as principais características de um profeta verdadeiro?
3. Como se pode definir que uma profecia é verdadeira?
4. Como se caracteriza um falso profeta?
5. Quem foi Ellen White? Qual sua importância para a Igreja Adventista do Sétimo Dia?
6. Ler e apresentar relatório de, pelo menos, 1 dos seguintes grupos de livros do Espírito de Profecia:
  a) Grande Conflito: História da Redenção, O Grande Conflito/Os Resgatados e Eventos Finais.
  b) História: Patriarcas e Profetas ou Os Escolhidos, Profetas e Reis ou Os Ungidos, e Atos dos Apóstolos ou Os Embaixadores.
  c) Série Testemunhos para Igreja: Três livros da série de sua escolha.
  d) Reeducação Alimentar: Ciência do Bom Viver, Conselhos sobre o regime alimentar, Temperança e Conselhos sobre Saúde.
  e) Serviço Beneficente: Serviço Cristão, Obreiros Evangélicos, Beneficência Social e Medicina da Salvação.
  f) Séries Missionárias: Fé e Obras, Caminho a Cristo, Serviço Cristão e Primeiros Escritos.
  g) Educação: Educação - Conselhos aos Pais Professores e Mestres, Fundamentos da Educação Cristã, Mente Caráter e Personalidade I ou II, O Lar Adventista e Mensagem aos Jovens.
  h) Meditações Matinais: Minha Consagração Hoje, Nossa Alta Vocação, Olhando para o Alto e Para Conhecê-Lo.
  i) Vida de Cristo: Parábolas de Jesus, O Desejado de Todas as Nações ou O Libertador e O maior Discurso de Cristo.
  j) Outra sequência de livros de sua preferência, contendo, no mínimo, 3 livros.
7. Descubrir em livros do Espírito de Profecia citações sobre, pelo menos, 2 temas abaixo:
  a) Histórias bíblicas
  b) Volta de Jesus
  c) Reforma de saúde
  d) Hábitos saudáveis
  e) Estrutura familiar
  f) Liderança
  g) Organização da Igreja
8. Como o estudo do Espírito de Profecia pode auxiliar no entendimento da Bíblia?
9. Como Deus manifesta em seus servos o Espírito de Profecia?'),
('AM-038', 'Escatologia', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-038.webp', 'https://mda.wiki.br/Especialidade_de_Escatologia', '1. Ler Mateus 24:3 a 14. Após completar a leitura, fazer uma pesquisa encontrando, ao menos, 20 sinais que indicam a proximidade da 2ª vinda de Cristo acontecidos nos últimos 5 anos.
2. Saber localizar na Bíblia, de memória, ao menos 5 passagens diferentes das encontradas nesta especialidade que apresentem promessas referentes à segunda vinda de Jesus.
3. Representar uma das parábolas bíblicas que tratam sobre a segunda vinda de Jesus, por meio de um dos seguintes: música, desenho, poesia ou dramatização.
4. Organizar um cronograma de, no mínimo, 1 página relacionando os principais eventos finais que culminarão com a 2 vinda de Jesus. Acrescentar também o que acontecerá nos 1000 anos seguintes.
5. Estudar a história da ascensão de Jesus ao Céu, após Sua ressurreição. Em seguida, fazer uma lista das semelhanças e diferenças entre este evento e a Sua segunda vinda.
6. Explicar a relação das citações "Venho como um ladrão" de Apocalipse 16:15, com "e todo olho o verá" de Apocalipse 1:7.
7. Ler as seguintes passagens da Bíblia e do Espírito de Profecia:
  a) II Timóteo 4:8.
  b) Apocalipse 2:10.
  c) Mateus 24:36.
  d) Eventos Finais, pág. 244.
  e) Primeiros Escritos, pág. 15 e 16.
  f) O Grande Conflito, pág. 640 a 646.
  • A partir do conhecimento adquirido no estudo destas e das outras passagens abordadas nesta especialidade, responder:
  a) Por que é possível afirmar que a 2 vinda de Jesus está tão próxima?
  b) Como podemos abreviar a volta de Jesus?
  c) Qual deve ser o nosso foco em relação à coroa celeste? A quantidade de estrelas?
  d) Quem sabe o dia e hora exatos da volta de Jesus?
  e) Quais serão os primeiros sinais vistos no Céu, momentos antes da vinda de Jesus?'),
('AM-039', 'Historiador Eclesiástico', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-039.webp', 'https://mda.wiki.br/Especialidade_de_Historiador_Eclesiástico', '1. Entrevistar um professor de história e apresentar a entrevista ao examinador:
  a) O que o motivou na escolha para tornar-se um historiador ou professor de história?
  b) O que mais lhe chama atenção ao estudar a história?
  c) Qual seria o aspecto mais interessante de sua profissão e o mais difícil?
  d) O que é história?
  e) O que é historiografia?
  f) Qual a importância do estudo de história?
  g) Qual é o trabalho de um historiador e seu campo de trabalho?
  h) Quais são as principais técnicas de levantamento e pesquisa histórica?
  i) O que é Cronologia e Periodização?
  j) Qual a diferença entre Conhecimento Histórico e Reflexão Histórica?
2. Listar as principais fontes para a pesquisa sobre história da Igreja. (Escritas: documentos, jornais, livros, cartas, etc.; Não escritas: orais, monumentos, fotografias, músicas, vestuários, etc.).
3. Citar, ao menos, 1 fonte que trate sobre a história denominacional da IASD em seu país.
4. Fazer um relatório com, pelo menos, 400 palavras sobre o surgimento do movimento adventista.
5. Utilizando técnicas de levantamento histórico (bibliográfico; documental; entrevistas, etc.), redigir uma biografia detalhada de um:
  a) Pioneiro da Igreja Adventista no mundo
  b) Pioneiro da Igreja Adventista em seu país ou região
6. Como a mensagem adventista chegou em sua região?
7. Como se organizou a igreja do clube que você frequenta?
  a) Entrevistar alguém, se possível mais de uma pessoa, que seja um pioneiro da igreja local
  b) Conseguir fotos dos primeiros membros da igreja
  c) Ter a cópia de algumas fontes escritas sobre a fundação da igreja (ata da comissão, compra do terreno)
  d) Ter fotos da construção da igreja, inauguração e dedicação, etc.
8. Usando o material levantado pelo requisito 5, elaborar um relatório final sobre a história da Igreja em sua região e Congregação local. (Este relatório pode ser apresentado em comemorações da igreja e do campo, bem como pode ser doado cópias para as autoridades e bibliotecas municipais).
9. Com o auxílio do diretor do Clube, fazer um detalhado histórico sobre a existência do seu Clube de Desbravadores.
10. Elaborar um mural sobre a história da igreja e expô-lo na igreja por, pelo menos, 2 sábados (se a especialidade for feita em grupo, deve-se repartir as tarefas e o mural deve ser exposto em mais de um lugar, por pelo menos 2 sábados em cada lugar). O mural deverá seguir o seguinte padrão:
  a) Estilo linha do tempo da história da igreja.
  b) Abarcar desde o Desapontamento até o último campori de seu clube.
  c) Apresentar imagens para a maioria dos eventos.
  d) Todos os eventos devem ser datados.
  e) Destacar eventos de sua Divisão, igreja e clube.
  f) Deve apresentar, pelo menos, 20 eventos históricos ao todo, destacando a relevância global, regional e local destes fatos.
11. Após todos os trabalhos serem realizados, discutir com seu instrutor o sentido de herança, legado, tradição e pertinência.'),
('AM-040', 'Evangelismo Web', 'atividades-missionarias', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/am-040.webp', 'https://mda.wiki.br/Especialidade_de_Evangelismo_Web', '1. Relacione 10 formas diferentes de evangelizar utilizando a internet.
2. Liste, no mínimo 2 sites diferentes para cada um dos temas a seguir, que possam auxiliar um instrutor bíblico adventista em sua classe:
  a) Jesus
  b) Salvação
  c) Bíblia
  d) Família
  e) Saúde
  f) Sábado
  g) Conduta cristã
3. Possuir contas nos seguintes meios de relacionamento virtual, procurando alcançar amigos que ainda não conhecem a Jesus.
  a) Rede social - Tendo relacionamento com no mínimo 50 amigos.
  b) Email - Com uma lista de ao menos 15 contatos.
  c) Micro-blog - Com temas cristãos e com pelo menos 25 seguidores e postagens semanais por dois meses.
  • Utilizando seus próprios perfis nas redes sociais descritas acima, elaborar um projeto evangelístico com datas e passagens bíblicas pré-escolhidas, onde durante 1 mês, 3 vezes por semana, enviar para todas as pessoas com quem se relaciona em cada uma das contas, um verso bíblico ou uma citação dos livros de Ellen White, ou imagens com mensagens cristãs, ou link para conteúdos sobre dos temas do requisito 2.
4. Mencionar a importância de manter também um plano de evangelismo pessoal como parte de sua rotina e relacionar as vantagens e desvantagens de evangelizar apenas digitalmente.
5. Que cuidados um cristão deve ter ao navegar na internet? Com base em Filipenses 4:8, elabore urna lista de critérios para a escolha de sites. Escreva um voto e assinar, comprometendo-se a seguir sua lista de critérios.
6. Liste 10 sites ou blogs de diferentes Clubes de Desbravadores e avalie-os com base no seguinte:
  a) Quais trazem, além de conteúdo técnico, conteúdo evangelístico?
  b) Quais possuem um formato mais agradável à sua navegação?
  c) Quais possuem links direcionando para sites evangelísticos?
  d) Quais são mais indicados para uma apresentação do Clube a algum interessado?
7. Explicar como a internet pode nos auxiliar no cumprimento da ordem de Jesus encontrada em Marcos 16:15?
8. Identificar as redes sociais e sites oficiais do seu clube , igreja, Associação/Missão, União e Divisão. Fazer parte ativa nestas comunidades, curtindo, compartilhando, comentando, etc.
9. Participar de um projeto de evangelismo web promovido pela Divisão Sul Americana, União ou Campo local (Associação/Missão).'),
('AM-041', 'Evangelismo Web - avançado', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-041.webp', 'https://mda.wiki.br/Especialidade_de_Evangelismo_Web_-_avançado', '1. Ter a especialidade de Evangelismo web.
2. Criar um site ou blog, pessoal ou para seu clube. Utilizando-se desse site/blog, durante o período de 3 meses, você deverá postar semanalmente conteúdos relacionados a pelo menos três dos temas abaixo:
  a) Como a Bíblia e seu ensinos se se aplicam à vida do Desbravador.
  b) Noticias de seu Clube de Desbravadores.
  c) Artigos ou entrevistas que abordem as vantagens de participar de um Clube de Desbravadores.
  d) Conteúdo de referência criado por você (tutorial, guias, apostilas, fotos, vídeos, artigo, testemunho) relacionados a classes e especialidades de Desbravadores que possam ajudar outros Desbravadores.
  e) Conteúdos sobre projetos Sociais desenvolvidos pelo seu Clube, pela ADRA ou relacionadas aos projetos contra violência domestica, doação de sangue ou Missão Calebe.
  f) Em suas postagens, inserir ao menos 3 links direcionando para sites oficiais da Igreja Adventista do Sétimo Dia ou sites de voluntários que possuam conteúdos relacionados ao tema postado.
3. Divulgar semanalmente seu site/blog criado no requisito 2, utilizando o seu próprio perfil nas redes sociais.
4. Elaborar um gráfico com os dados de acesso semanal, analisando a variação da quantidade de acessos e conteúdos mais acessados (páginas do site).
5. Listar pelo menos 3 sites que disponibilizem a Bíblia em diversas traduções, com campo de pesquisa de palavras. Fazer um balanço sobre os diferentes recursos oferecidos por cada um e suas vantagens.
6. Utilizando-se dos sites listados no requisito 5 desta especialidade, realizar uma pesquisa sobre um dos temas do requisito 2 da especialidade de Evangelismo web, listando no mínimo 15 passagens bíblicas sobre o tema escolhido. Escrever um pequeno parágrafo explicativo para cada uma das passagens e envie cada dia uma dessas passagens, por 15 dias, junto ao texto explicativo, para ao menos 20 contatos.
7. Qual a importância da Internet como ferramenta na pregação do evangelho aos povos que vivem em regimes fechados e onde não existe liberdade religiosa? Listar ao menos 5 países que não possuem liberdade religiosa. Discutir com seu instrutor sobre como a Internet pode nos auxiliar no cumprimento da ordem de Jesus encontrada em Marcos 16:15.
8. Disponibilizar uma opção de tradução automática em seu site para pelo menos 1 língua falada nos países sem liberdade religiosa identificados no requisito 7.
9. Durante o período de cumprimento desta especialidade, completar uma das seguintes atividades:
  a) Participar como voluntário de um projeto de evangelismo web promovido pela Divisão Sul-Americana, União ou Campo local (Associação/Missão).
  b) Participar de um fórum presencial ou on-line promovido pela Divisão, União ou Associação/Missão com o tema de evangelismo web.
  c) Produzir um vídeo original apresentando um dos temas do requisito 2 da especialidade de evangelismo web e postar este vídeo no youtube.
  d) Participar de alguma modalidade de colaboradores (intercessor, conselheiro, instrutor) do site Biblia.com.br'),
('AM-042', 'Intercessor', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-042.webp', 'https://mda.wiki.br/Especialidade_de_Intercessor', '1. Definir com suas palavras:
  a) O que é um intercessor
  b) O que é oração Intercessora
2. Pesquisar na Bíblia e em livros do Espirito de Profecia sobre o ministério intercessor de Cristo no Santuário celestial.
3. Citar, ao menos, 3 versos bíblicos diferentes dos citados nesta especialidade, que incentivam as pessoas a orarem umas pelas outras.
4. Citar, ao menos, 3 histórias bíblicas onde um personagem tenha intercedido por outro(s).
5. Porque é importante ser um intercessor? Quais os benefícios de orar por outros?
6. Debater com seu grupo de oração intercessora as seguintes passagens:
  a) João 17:9 - De quem Jesus estava falando?
  b) Tiago 5:13 a 16 - Por que a Bíblia nos deixou esses conselhos?
  c) Mateus 6:5 a 1 5 - 0 que essa passagem ensina sobre oração e intercessão?
7. Fazer dois dos seguintes:
  a) Fazer uma pesquisa em seu bairro ou comunidade levantando interessados em receber orações de seu grupo. Manter uma relação de endereços desses e, ao final do período de pelo menos 2 semanas, oferecer um estudo bíblico e convidá-los para uma programação especial de sua Igreja.
  b) Manter uma relação de e-mails e telefones de membros de seu Clube e Igreja. Durante os cultos de oração de sua Igreja, listar cada novo pedido e enviar mensagens aos membros da relação para que orem, a fim de formar uma rede de oração.
  c) Criar um canal (site, blog, perfil em rede social, lista de WhatsApp, etc) que possa receber pedidos de oração. Divulgá-lo em sua comunidade e para seus amigos. Fazer com que todos os pedidos recebidos sejam encaminhados a pessoas que possam orar pelos mesmos, incluindo você.
8. Durante, ao menos, 2 reuniões de seu Clube, participar de um momento de oração intercessora, onde os membros possam expressar seus pedidos de oração, orar uns pelos outros e anotar os pedidos dos demais para orar durante a semana.
9. Em consulta com seu Diretor, fazer uma lista de desbravadores ausentes de seu Clube e orar por eles pelo período mínimo de 30 dias. Em conjunto com seu grupo que está cumprindo a especialidade, visitá-los ou, na impossibilidade, enviar uma mensagem informando o fato de terem orado por eles por esse período. Perguntar se sentem o desejo de regressar e convidá-los a retornar ao Clube.
10. Estabelecer um horário bem definido para suas orações. Explicar por que escolheu esse horário. Em uma entrevista com o seu Pastor ou Ancião, descubrir como é possível seguir a recomendação de 1 Tessalonicenses 5:17.
11. Fazer um relatório sobre suas experiências ao realizar os requisitos dessa especialidade. Citar os pontos positivos encontrados e observados. O que melhorou em sua vida durante esse período? Você gostaria de continuar intercedendo por outros? Por quê?
12. Durante o período dessa especialidade, incluir em sua lista de oração os membros do grupo de oração intercessora que estão cumprindo a especialidade.'),
('AM-043', 'Pioneiros Adventistas', 'atividades-missionarias', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/am-043.webp', 'https://mda.wiki.br/Especialidade_de_Pioneiros_Adventistas', '1. Descobrir o que foi o Movimento Milerita e qual seu papel fundamental para o início da Igreja Adventista do Sétimo Dia.
2. Explicar o grande desapontamento com base na profecia de Daniel 8.
3. Estudar sobre Ellen White e qual o papel de seus ensinos dentro da nossa Igreja.
4. Conhecer a estrutura organizacional da Igreja Adventista do Sétimo Dia. Preparar um organograma eclesiástico.
5. Apresentar um resumo biográfico dos seguintes líderes:
  a) Guilherme Miller
  b) Tiago White
  c) Ellen White
  d) José Bates
  e) J. N. Andrews
  f) Harry Fenner
  g) Luther Warren
  h) Outro pioneiro de sua preferência
6. Quais líderes podem ser considerados os pioneiros dos desbravadores no mundo, em sua Divisão e em seu pais? Elaborar uma apresentação audiovisual sobre eles e apresentar ao seu Clube ou em alguma ocasião oportuna, decidida entre você e seu instrutor.
7. Escolher outro departamento da IASD e descobrir dados sobre sua fundação. Dar especial atenção à atuação dos pioneiros deste departamento. Apresentar relatório.
8. Descobrir como se iniciou o movimento adventista em seus pais. Dar especial atenção à atuação dos pioneiros no processo.'),
('AM-044', 'Patriotismo', 'atividades-missionarias', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/am-044.webp', 'https://mda.wiki.br/Especialidade_de_Patriotismo', '1. Descobrir a origem do nome e da língua oficial do seu país.
2. Mencionar quem foram os primeiros habitantes do seu país e como a cultura deles influenciou sua nação.
3. O que é miscigenação? Descrever as principais etnias que formaram a população do seu país e em qual delas sua família se encaixa.
4. Conhecer, cantar e explicar o significado de do hino nacional de seu país e de dois outros hinos oficiais como, por exemplo, hino da independência, hino da bandeira, hino da proclamação da república, etc.
5. Explicar a origem da bandeira nacional e o seu significado.
6. Saber como é o sistema de defesa do seu país e como funciona o alistamento militar.
7. Explicar a forma de governo do seu país e como os representantes são escolhidos.
8. Saber o nome dos 5 últimos presidentes do seu país.
9. Participar de um evento cívico/patriótico, onde participem oficiais ou representantes do governo de seu país.
10. Saber o que é um embaixador e como é a sua atuação em terras estrangeiras.
11. Por que podemos ser considerados embaixadores de Cristo?
12. Explicar a frase: "Estamos aqui neste mundo só de passagem, nossa verdadeira pátria está além rio".
13. Citar 3 passagens bíblicas que retratem a pátria celeste.'),
('AM-045', 'Sonoplastia', 'atividades-missionarias', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/am-045.webp', 'https://mda.wiki.br/Especialidade_de_Sonoplastia', '1. Defina o que é sonoplastia.
2. Quais as qualidades de um sonoplasta?
3. Conhecer e mencionar a utilização dos equipamentos a seguir:
  a) Mesa de som
  b) Microfone
  c) Fones de ouvido
  d) Multicabo
  e) Equalizador
  f) Retorno
  g) Compressor
  h) Caixa de som
4. Qual a função de uma mesa de som? Utilizando a mesa de som de sua igreja, mencionar suas principais entradas e saídas e dizer o que faz cada botão.
5. Quais os tipos de cabos mais usados na sonoplastia? Definir os usos de cada um.
6. Quais os tipos de microfones mais utilizados?
7. O que pode atrapalhar o bom funcionamento de um microfone sem fio?
8. O que é equalização?
9. Qual a função de um compressor?
10. Como se dá a reverberação e como evitá-la?
11. Qual a importância de se possuir o cronograma do culto para poder operar o som?
12. Operar a mesa de som em, pelo menos, 2 programas, sob orientação do sonoplasta de sua igreja.
13. Auxiliar a equipe de sonoplastia da sua Igreja por, ao menos, 1 mês.'),
('AM-046', 'Sonoplastia - avançado', 'atividades-missionarias', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/am-046.webp', 'https://mda.wiki.br/Especialidade_de_Sonoplastia_-_avançado', '1. Ter a especialidade de Sonoplastia.
2. Ter um certificado de curso de sonoplastia de, no minimo, 4 horas, ministrado por um profissional, com data inferior a 2 anos.
3. Atuar como operador de áudio em sua igreja por, no mínimo, 3 meses.
4. O que significa e qual a importância de observar a compatibilidade de potencia dos componentes da aparelhagem de som?
5. Listar 10 cuidados que devem ser seguidos para manter a aparelhagem de som em bom estado.
6. Explicar o que causa e como é possível evitar a microfonia.
7. Explicar a importância de utilizar músicas apropriadas para cada situação. Em seguida fazer uma lista com, no mínimo, 5 hinos congregacionais indicados para as seguintes ocasiões:
  a) Programa do Clube de Desbravadores
  b) Batismo
  c) Doxologia
  d) Funeral
  e) Ação de Graças
  • Para cada hino, citar o porquê de tê-lo escolhido.
8. Realizar uma pesquisa e listar as vantagens de um sistema integrado a um computador que utiliza algum programa de mixagem digital.
9. Ser capaz de desconectar e conectar toda a aparelhagem de som (mesa, amplificador, computador, etc.). Em seguida, ligar, demonstrar o funcionamento do sistema de som e desligar, indicando e explicando a sequencia correta de encerramento.
10. Operar sozinho a mesa de som de sua Igreja, identificando, explicando e demonstrando a função de cada um dos seguintes:
  a) Canais de entrada
  b) Canais de saída
  c) Volume (geral e de canais individuais)
  d) Ganho
  e) Grave, médio e agudo
  f) Efeito
11. Explicar como utilizar corretamente diferentes tipos de microfone. Que cuidados devem ser observados quando guardados ou em uso?'),
('AM-047', 'Investigador Bíblico I', 'atividades-missionarias', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/am-047.webp', 'https://mda.wiki.br/Especialidade_de_Investigador_Bíblico_I', '1. Ter completado pelo menos uma vez a leitura completa da Bíblia.
2. Falar de memória o nome dos livros do Velho Testamento e do Novo Testamento.
3. Pesquisar a historia de, pelo menos 10 personagens Bíblicos, apresentando um trabalho escrito sobre cada um com suas próprias palavras.
4. Apresentar oralmente para seu instrutor a história de três personagens de sua escolha, usando apenas uma Bíblia, incluindo as lições a serem aprendidas do personagem.
5. Ser capaz de dizer em que Livros da Bíblia se encontram as histórias de Adão, Noé, Moisés, Davi, Elias, Pedro e Jesus.
6. Ter lido pelo menos um livro sobre histórias de personagens Bíblicos (sugestões: Vida de Jesus, Patriarcas e Profetas, Profetas e Reis, Os Escolhidos, OS Ungidos, Os Embaixadores e O Libertador).'),
('AM-048', 'Boa Conduta Escolar', 'atividades-missionarias', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/am-048.webp', 'https://mda.wiki.br/Especialidade_de_Boa_Conduta_Escolar', '1. Estar cursando um dos anos do ensino fundamental ou médio.
2. Apresentar um relatório explicando com suas palavras, o que é ter uma boa conduta escolar, mínimo 200 e máximo 500 palavras.
3. Apresentar, os 3 últimos boletins escolares, que mostrem 60% das notas gerais acima de 8 ou 80 pontos.
4. Apresentar um relatório do orientador, coordenador(a) professor(a), dizendo que você tem sido um aluno exemplar, assíduo e participativo nas obrigações escolares.
5. Apresentar alguma atividade desenvolvida na escola, em que mostre sua participação direta como líder ou vice-líder do grupo.
6. Resolver um questionário de conhecimentos gerais envolvendo todas as disciplinas e tirar média acima de 80 ou 8 pontos.'),
('AM-049', 'Mensageira de Deus', 'atividades-missionarias', 'especialidade', null, 2015, 'Associação Geral', '/esp/am-049.webp', 'https://mda.wiki.br/Especialidade_de_Mensageira_de_Deus', '1. Escrever um resumo sobre a vida de Ellen White. Incluir:
  a) Quem foram os seus pais.
  b) Ano de seu nascimento e nome da sua irmã gêmea.
  c) Com quantos anos foi batizada.
  d) Qual acidente marcante aconteceu com ela e quantos anos tinha na ocasião.
  e) Quando casou, o nome do seu marido e filhos.
  f) Quando e com quantos anos faleceu.
2. Sobre 22 de outubro de 1844:
  a) O que significava a data?
  b) Como foi chamado o que ocorreu nesse dia?
3. Quando e onde a Igreja Adventista do Sétimo dia foi oficialmente organizada?
4. Quais os sinais de um verdadeiro profeta? Usar por base os seguintes versos:
  a) Isaías 8:19 e 20
  b) Mateus 7:15-20
  c) Jeremias 28:9
  d) 1 João 4:1-3
5. Qual foi a primeira visão de Ellen White? Quando aconteceu? Aproximadamente quantos sonhos e visões proféticas ela teve?
6. Por que Ellen White chamou seus ensinamentos de "luz menor"?
7. Quantos livros Ellen White escreveu? Selecionar um dentre os títulos originais, ler e apresentar uma reação à leitura de, pelo menos, uma página.
• Ellen White Estate: http://www.whiteestate.org/books/bhp/bhpc06.html
• Andrews University: http://www.andrews.edu/~fortind/EGWTest.htm'),
('AM-050', 'Estudo de Línguas', 'atividades-missionarias', 'especialidade', 1, 2018, 'Divisão Sul Americana', '/esp/am-050.webp', 'https://mda.wiki.br/Especialidade_de_Estudo_de_Línguas', '1. Ser capaz de se apresentar, mencionando nome, idade e onde mora em uma língua não nativa para você.
2. Saber, no idioma escolhido, o seguinte:
  a) Dias da semana;
  b) Meses do ano;
  c) Estações do ano;
  d) Números de 1 a 20.
3. Ouvir parte de um discurso, sermão ou declaração, de dois minutos, cuja língua materna seja a língua estrangeira que você escolheu e explicar em suas palavras o que você entendeu.
4. Ser capaz de perguntar e compreender instruções de como se chega a algum lugar no idioma escolhido.
5. Dramatizar uma das situações a seguir, dialogando na língua escolhida:
  a) Comprando roupas;
  b) Comendo em um restaurante;
  c) Perguntando horário de funcionamento de uma loja.
6. Cantar o hino dos desbravadores na língua escolhida.'),
('AM-051', 'Cultura Sul Americana', 'atividades-missionarias', 'especialidade', 1, 2018, 'Divisão Sul Americana', '/esp/am-051.webp', 'https://mda.wiki.br/Especialidade_de_Cultura_Sul_Americana', '1. Citar quais os países que fazem parte da Divisão Sul Americana da IASD e mencionar 3 ou 4 características típicas da cultura de cada país, que podem ser língua, bandeira, comida típica, costumes e roupas típicas.
2. Escolher uma tipo de civilização nativa sul americana e faça uma apresentação visual com cerca de 5 fotos por cartaz, vídeo ou power point sobre sua história e costumes.
3. Descrever em 25 e 35 linhas, como se deu a colonização espanhola e portuguesa na América do Sul e como se deu a independência dos países sul americanos. Descrever a contribuição dada por outros povos e imigrantes na formação dos povos sul americanos em seu país.
4. Descrever pelo menos 5 religiões que são encontradas e crescem na América do Sul e como a Igreja Adventista chegou a este continente e desenvolveu seu trabalho. Citar o ano em que a IASD chegou em cada país e descrever em 10 linhas como ela chegou no seu país.
5. Qual é o nome e qual a localização do deserto mais seco do mundo?
6. Qual é a maior montanha da América do Sul? Qual sua altura e localização?
7. Qual é a maior floresta da América do Sul? Citar pelo menos 3 espécies animais características desta floresta.
8. Escolha um bioma (entre os listados abaixo) da América do Sul e descrever o clima, fauna, flora e características geográficas:
  • Pantanal
  • Cerrado
  • Pampa
  • Mata Atlântica
  • Caatinga
  • Mangue
  • Diferentes tipos de litorais sul americanos
  • Cordilheira dos Andes
  • Patagônia
9. Citar cinco espécies de animais que só encontramos na América do Sul.
10. Entrevistar pessoalmente ou pela internet, um Desbravador (10-15 anos) de um país sul americano diferente do seu e pergunte: Como são os Desbravadores de seu país e que especialidades mais gostam de fazer? O que ele mais gosta no país dele? Que lugares da América do Sul ele gostaria de conhecer?'),
('AM-052', 'Apocalipse', 'atividades-missionarias', 'especialidade', 1, 2018, 'Divisão Sul Americana', '/esp/am-052.webp', 'https://mda.wiki.br/Especialidade_de_Apocalipse', '1. O que significa a palavra apocalipse? Por que o Apocalipse foi enscrito em símbolos?
2. Elabore uma tabela com pelo menos cinco símbolos do Apocalipse e o significado de cada um. Levar em conta o princípio que as chaves para compreender o Apocalipse estão na própria Bíblia.
3. O que é, no Apocalipse, o Selo de Deus? E a marca da besta?
4. Quem é digno de abrir os sete Selos? Por quê?
5. Faça um desenho encaixando os seguintes eventos num diagrama de linha do tempo: volta de Jesus, Primeira ressureição dos mortos, milênio, segunda ressureição e nova Terra.
6. Quais são as sete igrejas do Apocalipse e o que representam? Qual delas representa a nossa época e qual a mensagem que Deus tem para esta igreja?
7. Quais são as mensagens dos três anjos? Por que estas mensagens são importantes e devem ser proclamadas?
8. Citar três promessas do Apocalipse relacionadas ao noco Céu e à nova Terra.'),
('AM-053', 'Crítico de Mídia', 'atividades-missionarias', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/am-053.webp', 'https://mda.wiki.br/Especialidade_de_Crítico_de_Mídia', '1. Quem foi o primeiro ser do universo a usar o poder da palavra em benefício próprio e quais eram seus planos?
2. Quais os objetivos da propagando e como ela pode ser usada para o mal?
3. Cumprir um dos seguintes:
  a) Ler três capítulos do livro "Nos bastidores da mídia" (CPB);
  b) Assistir um documentário sobre a influência da mídia e/ou das redes sociais;
  c) Com a ajuda do seu conselheiro ou instrutor, escolher e ler um livro sobre a influência da mídia e/ou das redes sociais;
  d) Assistir uma palestra sobre a influência da mídia e/ou das redes sociais.
4. O que são fake news? Como podemos verificar se uma notícia é falsa ou verdadeira?
5. Assistir ou ler duas reportagens sobre o mesmo assunto em dois jornais/revistas/sites diferentes. Analisar se há discrepâncias entre as informações apresentadas pelos jornalistas.
6. Como é o sistema de classificação indicativa dos programas de televisão do seu país?
7. Quais os princípios o cristão deve utilizar para escolher um filme/série para assistir?
8. Analisar os seguintes gêneros e descrever como, geralmente, os filmes de cada um deles contradizem os princípios da vida cristã:
  a) Terror;
  b) Drama;
  c) Comédia;
  d) Ação/Aventura;
  e) Animação.
9. Analisar os personagens de desenho animado que você costuma/costumava assistir. Quais são as principais características da "personalidade" deles? (Por exemplo: violentos, ladrões, preguiçosos, vingativos, invocadores de forças das trevas, etc.). Que tipo de influência esses personagens podem trazer para a mente das crianças?
10. Quais princípios o cristão deve utilizar para escolher músicas para ouvir?
11. Quais princípios o cristão deve utilizar para escolher jogos (eletrônicos/tabuleiro)?
12. Qual deve ser a postura de um cristão nas redes sociais em relação ao que ele publica, lê, comenta e compartilha? Esta postura deve ser diferente no dia de sábado?
13. Fazer por uma semana um diário de quanto tempo você utilizou nas seguintes atividades:
  a) Assistir/ler notícias;
  b) Assistir filmes/séries/desenhos animados;
  c) Assistir outros programas de televisão;
  d) Ouvir música;
  e) Ler literatura ficcional;
  f) Jogar jogos eletrônicos;
  g) Utilizar redes sociais.
1. Memorizar e explicar Filipenses 4:8.'),
('AM-054', 'Livro de Daniel', 'atividades-missionarias', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/am-054.webp', 'https://mda.wiki.br/Especialidade_de_Livro_de_Daniel', '1. Por que é tão importante estudarmos atentamente o livro do profeta Daniel?
2. Citar, pelo menos, três textos bíblicos que expliquem por que os judeus foram levados como cativos para a Babilônia.
3. Qual é o significado dos nomes de Daniel, Misael, Azarias e Ananias.
4. Ler Daniel 6:3, 4, 10 e 23 e dizer quais as virtudes de Daniel.
5. Apresentar uma ilustração da estátua do sonho de Nabucodonosor descrita no capítulo 2 do livro de Daniel e explicar o significado de cada uma das partes.
6. O que podemos aprender com a história de Misael, Azarias e Ananias a respeito da firme decisão de não adorar a estátua de ouro de Nabucodonosor?
7. Quem apareceu na fornalha de fogo e na cova dos lões para proteger Daniel e seus amigos?
8. Quem escreveu o capítulo 4 do livro de Daniel?
9. Qual foi a mensagem esrita em uma parede e qual a explicação de cada uma das palavras? Por que aquela mensagem foi escrita naquela ocasião?
10. Fazer desenhos ou mostrar imagens ilustrativas dos animais de Daniel 7 e 8 e dizer qual a relação entre estes animais com a estátua do capítulo 2. Qual é o significado do chifre pequeno do quarto animal de Daniel 7?
11. Que relação existe entre Danie 7:25, Apocalipse 12:6, 14; 13:5-7?
12. Qual o sentido da visão do carneiro e do bode do capitulo 8 de Daniel?
13. Decorar e dizer qual a importância de Daniel 8:14 para a história do adventismo.
14. Preparar um diagrama explicativo de Daniel 9:24-27.
15. Ler Daniel 12:4. Em que ano teve início o tempo do fim e que evento culimou para o início desse tempo?'),
('AM-055', 'Educação Inclusiva', 'atividades-missionarias', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/am-055.webp', 'https://mda.wiki.br/Especialidade_de_Educação_Inclusiva', '1. Conhecer e explicar os seguintes conceitos de acordo com a Organição Mundial da Saúde (OMS):
  a) Deficiência;
  b) A Convenção sobre os Direitos das Pessoas com Deficiência (CDPD);
  c) A Classificação Internacional de Funcionalidade, Incapacidade e Saúde (CIF).
2. Descrever os tipos de deficiência existentes.
3. Descrever o conceito de discriminação e discutir as diferentes formas de discriminação que existem hoje.
4. Definir a palavra bullying e descrever as diferentes formas de bullying observadas em seu cotidiano.
5. Ler, analisar e debater a Convenção Interamericana para a Eliminação de Todas as Formas de Discriminação contra as Pessoas com Deficiência, promovida pela OMS e assinada por 17 países, apresentando um resumo de pelo menos uma página sobre ela.
6. Ler e analisar João 5:1-18, Aplicar os conceitos desenvolvidos ao descrever o cenário apresentado nestes versículos, identificando:
  a) Tipo de deficiência apresentada;
  b) Contexto de vida vivido por pessoas com deficiência;
  c) Possíveis cenários de discriminação ou intimidação que enfrentaram;
  d) Discutir e refletir sobre: reação e ação de Jesus quando se deparou com o homem que por 38 anos estivera paralisado e reação e ação dos judeus;
  e) Faça uma lista dos ensinamentos que extraímos do exemplo de Jesus e dos versículos analisados.
7. Ler e analisar 2 Samuel 9:1-13, aplicar os conceitos desenvolvidos descrevendo o cenário apresentado nestes versículos, identificando:
  a) A atitude e determinação de Davi ao perguntar e aprender sobre Mefibosete;
  b) Refletir sobre como Davi aplicou a inclusão em suas ações e como você, hoje poderia fazer o mesmo em sua realidade.
  c) Primeira reação e resposta do Mefibosete. Como você acha que ele estava se sentindo? Por quê?
  d) Fazer uma lista de ensinamentos que extraímos do exemplo de Jesus e dos versículos analisados.
8. Ler e analisar a história da escritora Helen Keller. A sua deficiência impediu o progresso na vida?
9. Conhecer a Lei de Inclusão em vigor no país. Apresentar um resumo dos aspectos mais importantes a serem considerados.
10. Analisar e propor como seu Clube de Desbravadores pode ser considerado inclusivo e enviar as propostas ao seu Diretor.'),
('AM-056', 'Inteligência Emocional', 'atividades-missionarias', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/am-056.webp', 'https://mda.wiki.br/Especialidade_de_Inteligência_Emocional', '1. Definir inteligência emocional.
2. Citar os vários tipos de sentimentos e emoções humanas. Fazer uma lista e escrever um exemplo de quando você os experimentou em sua vida.
3. Procurar exemplos de personagens na Bíblia que sentiram:
  a) Raiva;
  b) Tristeza;
  c) Alegria;
  d) Decepção;
  e) Arrependimento;
  f) Gratidão;
  g) Empatia.
4. Ler Gálatas 5:22 e 23, e escrever uma lista dos atributos do fruto do Espírito. Explicar com suas palavras por que é importante desenvolver o fruto do Espírito em nossas vidas.
5. Participar de um debate em grupo sobre autoestima.
6. Ler Isaías 43:1-5 e responder:
  a) A quem pertencemos?
  b) Que promessas Jesus nos dá nesses versículos?
7. O que devemos fazer quando experimentamos sentimentos como:
  a) Ira: Leia Provérbios 15:1, Tiago 1:19 e 20, Efésios 4:26
  b) Medo: Salmo 34:17-18
  c) Ansiedade: 1 Pedro 5:7, Filipenses 4:6-8
8. Ler Romanos 12:15 e explicar em suas palavras
  a) Como esse versículo se aplica à "regra de ouro"?
  b) Por que está relacionado à empatia?
9. Ler Mateus 22:36-40 e conversar com seu instrutor ou conselheiro sobre a importância do amor-próprio para que mais tarde você possa amar os outros.
10. Fazer uma lista de desafios que você deve trabalhar para gerenciar melhor suas emoções.
11. Fazer um vídeo e compartilhar em suas redes sociais, falando sobre como tratar as emoções, baseado no capítulo 84, do livro "Mente, Caráter e Personalidade (Vol. 2)".'),
('AM-057', 'Interpretação Bíblica', 'atividades-missionarias', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/am-057.webp', 'https://mda.wiki.br/Especialidade_de_Interpretação_Bíblica', '1. Por que é importante interpretar corretamente a Bíblia?
2. Com o auxílio de seu pastor ou ancião, estudar o que significa:
  a) Revelação;
  b) Inspiração;
  c) Iluminação.
3. Definir o que é exegese.
4. Como a exegese se aplica ao estudo da Bíblia?
5. Definir hermenêutica.
6. Como a hemenêutica se aplica ao estudo da Bíblia?
7. Com o auxílio de seu pastor ou ancião, fazer exegese e hermenêutica dos seguintes textos:
  a) Êxodo 3:5;
  b) Atos 10:12, 13;
  c) Colossenses 2:16.
8. Escolher um dos textos do requisito anterior e explicá-lo, utilizando a exegese e hermenêutica, para um de seus amigos ou familiares.
9. Quanto aos métodos de interpretação bíblica, definir:
  a) Método pretista;
  b) Método futurista;
  c) Método historicista;
  d) Método idealista.
10. Escrever um texto de, pelo menos, 500 palavras, identificando qual dos métodos anteriores é utilizado pela Igreja Adventista do Sétimo Dia, o porquê de sua utilização e se, em sua opinião é o método mais coerente.'),
('AM-058', 'Lives - Transmissão de Cultos Online', 'atividades-missionarias', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/am-058.webp', 'https://mda.wiki.br/Especialidade_de_Lives_-_Transmissão_de_Cultos_Online', '1. O que é uma transmissão ao vivo (Live)?
2. Citar cinco plataformas de transmissão ao vivo.
3. Quais equipamentos físicos são utilizados para realizar uma transmissão ao vivo (Live)?
4. Quais são os métodos para realizar uma transmissão ao vivo?
5. O que é um codificador? E para que serve?
6. O que você pode e não pode transmitir? Explicar as regras e termos das redes sociais.
7. O que é enquadramento?
8. Ilustrar com fotos de autoria própria os seguintes planos:
  a) Plano aberto;
  b) Plano médio;
  c) Plano fechado.
9. Ajudar a sua igreja ou clube a realizar pelo menos oito transmissões ao vivo.
10. Fazer uma redação explicando como podemos utilizar uma transmissão ao vivo para espalhar o amor de Jesus.'),
('AM-059', 'Parábolas de Jesus', 'atividades-missionarias', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/am-059.webp', 'https://mda.wiki.br/Especialidade_de_Parábolas_de_Jesus', '1. Por que é comparado a um homem prudente que edificou sua casa sobre a rocha, todo aquele que ouve as palavras de Cristo e as pratica?
2. Por que na parábola do semeador, a mensagem da palavra do reino é comparada a uma semeadura? Como fazer para se tornar a semente lançada em boa terra?
3. Por que não foi permitido arrancar o joio que foi plantado no campo de trigo?
4. Que similaridade existe entre a parábola do grão de mostarda e a parábola do fermento?
5. Explicar 1 das seguintes parábolas:
  a) Parábola do tesouro escondido;
  b) Parábola da pérola;
  c) Parábola da rede;
  d) Parábola das 10 virgens;
  e) Parábola dos talentos.
6. Por que os discípulos consideram as palavras ditas por Cristo escritas em Mateus 15:11 como sendo uma parábola? O que significa este verso?
7. Qual o pontochave da parábola do credor incompassivo?
8. Na parábola dos trabalhadores na vinha, o que significa o fato de todos os trabalhadores receberem o mesmo salário, sendo que uns trabalham mais tempo que outros?
9. Explicar a parábola dos dois filhos. Como podemos aplicá-la aos nosso dias?
10. Na parábola dos lavradores maus, quem representa o filho do dono da vinha?
11. Explicar a parábola das bodas. O que representa o homem sem veste nupcial?
12. A que se refere a parábola do bom servo e do mau?
13. Encenar uma parábola de Jesus à sua escolha.'),
('AM-060', 'Relacionamentos Saudáveis', 'atividades-missionarias', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/am-060.webp', 'https://mda.wiki.br/Especialidade_de_Relacionamentos_Saudáveis', '1. Descrever a importância dos relacionamentos para o ser humano.
2. Compreender a definição de relacionamento tóxico e relacionamento saudável.
3. Compreender o sentido da frase: "Dize-me com quem andas que te direi quem és" e relacionar com o texto de 1º Coríntios 15:33.
4. Identificar de que forma uma relação de amizade pode ser abusiva.
5. Listar pelo menos cinco referências bíblicas que falam de relação de amizade.
6. Descrever os níveis de relacionamenos.
7. Conhecer as características de uma relação abusiva em suas diferentes manifestações a seguir:
  a) Física;
  b) Patrimonial;
  c) Moral;
  d) Psicológica;
  e) Sexual;
  f) Social.
8. Saber o que pode ser feito diante de uma situação de abuso com testemunha e/ou como vítima.
9. Conhecer os mecanismos legais disponíveis em seu país, estado ou município para proteção e auxilio de vítimas de relacionamento abusivo e as devidas penas.
10. Compreender o plano de Deus para os relacionamentos en seus diversos níveis, tendo como base Efésios 5:22-23 e 6:1-4.
11. Compartilhar com cinco familiares e amigos as principais lições aprendidas nesta especialidade.
12. Compreender a relação de baixa autoestima e relacionamento abusivo.
13. Saber o momento certo para iniciar uma relação de namoro e como a idade pode interferi nesse momento.
14. Elaborar uma lista de critérios, limites e condições para um relacionamento amoroso pessoal.
15. Conhecer qual a importância dos pais de ambas as partes numa relação amorosa dos filhos.
16. Compreender o plano de Deus para o sexo e fazer um voto pessoal de honrar esse plano.'),
('AMEB-001', 'Escrituras Sagradas', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-001.webp', 'https://mda.wiki.br/Especialidade_de_Escrituras_Sagradas', '1. Saber quem é o autor da Bíblia, como foi escrita e por que devemos acreditar nela. (2 Pedro 1:20-21; Jeremias 1:4-5; 2 Timóteo 3:16 e 17)
2. Entender qual é a diferença entre revelação especial e revelação geral, considerando a maneira com que Deus se revela para a humanidade. (Hebreus 1:1-2; Romanos 1:20)
3. Explicar por que as orientações bíblicas são mais importantes do que as tradições e as opiniões das pessoas. (Marcos 7:7-9)
4. Conhecer quem é o personagem principal da Bíblia. (João 1:1-4)
5. Definir a maneira como podem ser testados os autores dos livros da Bíblia, se aquilo que está dizendo é realmente a palavra de Deus. (Mateus 7:16; Isaías 8:20)
6. Memorizar e recitar na ordem correta os nomes dos 66 livros da Bíblia.
7. Compartilhar com um amigo qual é o propósito da mensagem que a Bíblia apresenta. (2 Timóteo 3:16-17; João 5:39)
8. Escolher alguém e dar de presente uma Bíblia e um estudo bíblico.'),
('AMEB-002', 'Trindade', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-002.webp', 'https://mda.wiki.br/Especialidade_de_Trindade', '1. Identificar as palavras no plural encontradas nos versos de Gênesis 1:26; 3:22; 11:7 onde podemos claramente perceber que a Bíblia apresenta um Deus triúno, ou seja, que a Divindade é composta por três pessoas distintas.
2. Definir quem é o Deus único apresentado por Jesus em João 10:30 e 1º Timóteo 1:17 identificando cada uma das três pessoas da Divindade encontradas nos versos de Mateus 28:19 e Lucas 3:21-22.
3. Entender quais são os atributos incomunicáveis de Deus, ou seja, aquilo que exclusivamente Ele é e é capaz de fazer. (João 5:26; Efésios 1:5; 1º João 3:20; Salmo 139:7-12; Salmo 90:2)
4. Explicar quais são os atributos comunicáveis que Deus, ou seja, as características ou virtudes que ele possui e que compartilha com os seres humanos. (Romanos 3:24; 5:8; Salmo 145:9; 2º Pedro 3:15; Salmo 99:9; João 17:25; Salmo 31:5)
5. Saber qual foi a maneira que Deus escolheu para se revelar ao ser humano. (1º João 5:20)
6. Memorizar e recitar 2º Coríntios 13:13 (13:14 na Nova Versão Internacional e Nova Versão Transformadora).
7. Compartilhar com um amigo como é possível conhecer a Deus. (Salmo 19:1; Hebreus 11:6)
8. Mencionar um episódio ou verso da Bíblia em que seja possível identificar a presença das três pessoas da Trindade.
9. Fazer um desenho ou pintura que represente a Trindade de Acordo com o que foi aprendido nesta especialidade.'),
('AMEB-003', 'Deus Pai', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-003.webp', 'https://mda.wiki.br/Especialidade_de_Deus_Pai', '1. Saber por qual motivo Deus pode ser considerado nosso Pai. (Gênesis 1:27; Isaías 64:8)
2. Entender qual foi a maior demonstração de amor por nós dada por Deus Pai. (Romanos 5:8)
3. Definir qual a importância, para nós, das duas virtudes de Deus Pai encontradas nos seguintes versos: Lucas 6:36; Mateus 5:48.
4. Identificar na oração ensinada por Jesus, a quem devemos nos dirigir quando falamos com Deus. (Mateus 6:9-13)
5. Explicar por que devemos considerar Jesus como a melhor forma de revelação de Deus Pai. (João 1:18; Mateus 11:27)
6. Memorizar e recitar Efésios 1:3.
7. Compartilhar com um amigo sobre o grande amor demonstrado por Deus, o Pai. (1 João 3:1-2)
8. Se você tivesse que escolher um símbolo ou objeto para representar a Deus, qual seria? Mostrar e explicar à sua unidade.'),
('AMEB-004', 'Deus Filho', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-004.webp', 'https://mda.wiki.br/Especialidade_de_Deus_Filho', '1. Saber por que Deus Filho recebeu o nome Jesus. (Mateus 1:21)
2. Entender qual foi a participação de Jesus na criação do mundo, ao ser Ele identificado por João como o "Verbo" ou "Palavra" de Deus. (João 1:2-3; Colossenses 1:16-17)
3. Explicar qual foi a participação de Jesus, no plano de Deus, para salvar o ser humano da morte. (Lucas 19:10)
4. Conhecer o que a Bíblia diz sobre a natureza divina de Jesus. (João 10:30; Hebreus 1:3; João 1:1; Colossenses 2:9)
5. Estudar o que a Bíblia ensina sobre a natureza humana de Jesus. (João 1:14; Hebreus 4:15; 1 João 4:2; Filipenses 2:6-8)
6. Memorizar e recitar os nomes ou títulos que o profeta Isaías usa para Jesus. (Isaías 9:6; 7:14)
7. Compartilhar com um amigo quais são as promessas que Jesus faz aos que creem Nele. (João 11:25-26; 14:1-3)'),
('AMEB-005', 'Deus Espírito Santo', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-005.webp', 'https://mda.wiki.br/Especialidade_de_Deus_Espírito_Santo', '1. Entender como a Bíblia descreve o Espírito Santo como uma das três pessoas distintas da Trindade. (2 Coríntios 13:14; Mat. 28:19; João 16:14-15)
2. Saber se o Espírito Santo participou ou não da criação do mundo. (Gênesis 1:1-2)
3. Definir como os cristãos primitivos identificavam o Espírito Santo como uma pessoa distinta na Divindade. (Atos 5:3; 13:2; 15:28)
4. Conhecer a promessa feita por Jesus em João 14:16-17.
5. Explicar qual é a missão do Espírito Santo no trabalho de salvação das pessoas. (João 16:7-11)
6. Memorizar e recitar Gálatas 5:22-23.
7. Compartilhar com um amigo o que uma pessoa precisa fazer para receber o Espírito Santo. (Atos 5:32)'),
('AMEB-006', 'Criação do Mundo', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-006.webp', 'https://mda.wiki.br/Especialidade_de_Criação_do_Mundo', '1. Saber como a Bíblia descreve a origem de todas as coisas e quem foi que fez o nosso mundo. (Gênesis 1:1 e 2; João 1:1-3)
2. Compreender o que Hebreus 11:3 ensina sobre como Deus criou o universo, mesmo sem usar matéria visível ou preexistente.
3. Conhecer a forma como Deus criou todas as coisas. (Salmo 33:9)
4. Citar qual foi a ordem dada por Deus aos primeiros seres humanos criados por Ele. (Gênesis 1:27-28)
5. Explicar quanto tempo Deus levou para criar o mundo e tudo o que nele existe. (Gênesis 1:2:1-2; Êxodo 20:11)
6. Memorizar e falar quais foram as coisas criadas por Deus em cada um dos seis dias da criação. (Gênesis 1)
7. Compartilhar com um amigo como Paulo expressa a dependência total que todos nós temos de Deus. (Atos 17:28)
8. Escolher, durante um acampamento ou caminhada, três elementos da natureza que representem, na sua compreensão, Deus como Criador, e apresentar ao grupo uma aplicação prática de cada um deles.
9. Conhecer e cantar, individualmente ou com sua unidade, um hino que fale sobre a criação ou sobre o Criador.'),
('AMEB-007', 'Natureza da Humanidade', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-007.webp', 'https://mda.wiki.br/Especialidade_de_Natureza_da_Humanidade', '1. Saber qual é a origem da vida humana e citar qual material foi usado para a criação do homem. (Gênesis 1:27; 2:7)
2. Explicar por que os nossos primeiros pais, que foram criados para viver para sempre, perderam essa condição de imortalidade. (Gênesis 2:16-17; 3:22)
3. Definir o que é o pecado. (1 João 3:4; Tiago 4:17; Romanos 14:23)
4. Entender qual é a consequência do pecado. (Romanos 6:23; Ezequiel 18:4, 20)
5. Reconhecer a mentira contada pela serpente no Éden, que muitos ainda acreditam hoje, e saber quem é o único ser imortal. (Gênesis 3:4; 1 Timóteo 6:15-16)
6. Memorizar e recitar 1 João 5:11-12.
7. Compartilhar com um amigo o que Deus fez para resolver o problema do pecado. (João 3:16)
8. Demonstrar de forma prática, para sua unidade ou outro grupo, os elementos que Deus utilizou na criação do ser humano (pode ser por meio de dramatização ou outra forma ilustrativa).'),
('AMEB-008', 'Grande Conflito', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-008.webp', 'https://mda.wiki.br/Especialidade_de_Grande_Conflito', '1. Saber como a Bíblia descreve a origem, a glória e a queda do anjo Lúcifer, usando as figuras dos reis de Tiro e Babilônia como ilustrações. (Ezequiel 28:12, 15; Isaías 14:12-14)
2. Conhecer quantos anjos se uniram a Lúcifer em sua rebelião contra Deus. (Apocalipse 12:4)
3. Entender o que aconteceu no céu entre os anjos fiéis e os anjos rebeldes. (Apocalipse 12:7-9)
4. Explicar como Satanás introduziu o pecado na Terra. (Gênesis 3:1-6)
5. Definir quais foram os efeitos do pecado na humanidade. (Gênesis 6:5)
6. Memorizar e recitar Deuteronômio 1:30.
7. Compartilhar com um amigo como podemos estar preparados para enfrentar o mal. (Efésios 6:13-18)
8. Escolher uma história bíblica envolvendo a atuação dos anjos e, com o apoio da sua unidade ou grupo, encenar a história durante um acampamento, devocional, escola sabatina, culto jovem, etc.:
  a) Daniel 6 - Daniel protegido pelos anjos na cova dos leões;
  b) Mateus 4 - Jesus no Deserto fortalecido pelos anjos;
  c) Atos 5 - Apóstolos libertos da prisão pelos anjos.
9. Fazer um desenho ou ilustração representando o Grande Conflito e explicar seu significado.'),
('AMEB-009', 'Vida, morte e ressureição de Cristo', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-009.webp', 'https://mda.wiki.br/Especialidade_de_Vida,_Morte_e_Ressurreição_de_Cristo', '1. Saber como 1 Pedro 2:22-23 descreve a vida perfeita que Cristo viveu.
2. Reconhecer quem foi o único ser humano que nunca pecou. (Hebreus 4:15)
3. Conhecer o que Cristo conquistou por meio da sua morte. (Romanos 5:10; Apocalipse 5:9)
4. Explicar por que Jesus precisou morrer mesmo sem ter cometido nenhum pecado. (1 Timóteo 1:15; Romanos 5:8)
5. Definir qual é a importância da ressurreição de Jesus para a nossa salvação. (1 Coríntios 15:20-23)
6. Memorizar e recitar Isaías 53:4-5.
7. Compartilhar com um amigo qual foi o propósito da vinda, morte e ressurreição de Jesus. (Lucas 19:10; João 3:16-17; Hebreus 7:25; Atos 4:12)'),
('AMEB-010', 'Experiência da Salvação', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-010.webp', 'https://mda.wiki.br/Especialidade_de_Experiência_da_Salvação', '1. Saber o que é necessário fazer para receber a salvação que Deus oferece a todos os seres humanos. (Atos 16:31; Romanos 10:9; Efésios 2:8-9)
2. Entender por que devemos obedecer a Deus mesmo sabendo que não somos salvos pelas nossas boas ações. (João 14:15, 21, 23)
3. Conhecer o que Jesus fez para garantir o perdão e a salvação da humanidade. (Lucas 23:46; Isaías 53:5; Apocalipse 5:9)
4. Explicar o que precisamos fazer para receber o perdão dos nossos pecados. (1 João 1:9)
5. Definir o que Jesus nos orienta a fazer depois que somos perdoados. (João 5:14; 8:11)
6. Memorizar e recitar Marcos 16:15-16.
7. Compartilhar com um amigo qual é a maior vitória que podemos alcançar, segundo a Bíblia. (1 Coríntios 15:51-54)'),
('AMEB-011', 'Crescimento em Cristo', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-011.webp', 'https://mda.wiki.br/Especialidade_de_Crescimento_em_Cristo', '1. Saber o que Cristo conquistou por meio de sua morte e ressurreição. (1 Coríntios 15:20-21)
2. Entender o que acontece na vida de quem mantém comunhão com Jesus. (1 João 1:5-7)
3. Conhecer qual é o plano de Deus para a nossa vida, seguindo o exemplo do que se cumpriu na vida de Jesus. (Lucas 2:52)
4. Explicar os resultados que aparecem na vida de quem segue a Jesus e recebe o Espírito Santo. (Gálatas 5:22-25)
5. Definir a importância de manter comunhão com Deus por meio da oração. (Efésios 6:18)
6. Memorizar e recitar Salmo 1:1-2 e Lucas 2:52.
7. Compartilhar com um amigo como a vida de uma pessoa é transformada quando ela aceita Jesus como Senhor. (2 Coríntios 5:17)'),
('AMEB-012', 'Igreja', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-012.webp', 'https://mda.wiki.br/Especialidade_de_Igreja', '1. Saber quem estabeleceu a Igreja cristã e qual é o seu único fundamento. (Mateus 16:18; 1 Coríntios 3:11; Efésios 2:19-20)
2. Reconhecer a quem pertence a Igreja. (Atos 20:28)
3. Entender por que é importante que a Igreja preserve e ensine as verdades sobre Deus. (1 Timóteo 3:15; Mateus 28:19-20; João 17:17; 2 Timóteo 4:2-4)
4. Explicar por que a Igreja é apresentada na Bíblia como o corpo de Cristo. (1 Coríntios 12:12, 27; Romanos 12:4-5; Colossenses 1:18)
5. Definir o significado das palavras de Jesus sobre a importância da unidade entre os membros da Igreja. (Mateus 18:19-20; João 17:20-21)
6. Memorizar e recitar Hebreus 10:25.
7. Compartilhar com um amigo porque é importante participar dos cultos e envolver-se nos ministérios da Igreja. (Hebreus 10:24-25)
8. Entrevistar o pastor ou ancião da sua igreja e apresentar por escrito ao seu instrutor as seguintes respostas:
  a) Como são feitas as nomeações dos líderes da igreja local?
  b) Quais ministérios a sua igreja possui?
  c) O que é a comissão da igreja?
  d) Como a comissão da igreja funciona?'),
('AMEB-013', 'Remanescente e sua Missão', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-013.webp', 'https://mda.wiki.br/Especialidade_de_Remanescente_e_sua_Missão', '1. Conhecer a profecia em que o apóstolo Paulo anuncia a apostasia da Igreja. (2 Tessalonicenses 2:3-4)
2. Entender quais fatores levaram a Igreja a afastar-se das verdades sobre Deus. (Apocalipse 2:4; 2 Tessalonicenses 2:9-12)
3. Saber quais são as características dos cristãos fiéis à verdade em todas as épocas. (Apocalipse 12:17; 14:12)
4. Explicar qual é a missão do povo remanescente de Deus nos últimos dias. (Mateus 24:14; Apocalipse 14:6)
5. Definir qual é o sinal ou selo de Deus que identifica a Igreja verdadeira nos últimos dias. (Apocalipse 7:2; Ezequiel 20:20)
6. Memorizar e recitar Mateus 28:19.
7. Compartilhar com um amigo qual é a missão de todo aquele que crê em Jesus. (Marcos 16:15-16)'),
('AMEB-014', 'Unidade no Corpo de Cristo', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-014.webp', 'https://mda.wiki.br/Especialidade_de_Unidade_no_Corpo_de_Cristo', '1. Saber qual é o testemunho mais importante que a Igreja deve dar ao mundo. (João 17:21-23)
2. Conhecer quais atitudes devemos cultivar para manter a unidade da Igreja. (Efésios 4:2-3)
3. Definir quem é o principal elo que une os membros da Igreja. (João 15:5)
4. Entender como Jesus espera que seja o relacionamento entre os seus seguidores. (João 15:12-13, 17)
5. Explicar quais atitudes causam divisão entre os membros da Igreja. (2 Timóteo 3:2-5; Tiago 3:16; Tiago 4:1-2)
6. Memorizar e recitar Salmo 133:1.
7. Compartilhar com um amigo qual deve ser a principal atitude de um cristão para promover a união na Igreja. (1 Coríntios 1:10)'),
('AMEB-015', 'Batismo', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-015.webp', 'https://mda.wiki.br/Especialidade_de_Batismo', '1. Compreender o significado espiritual do batismo e o que ele representa para quem aceita Jesus. (Romanos 6:3-5)
2. Saber qual é o requisito essencial para que alguém seja batizado. (Marcos 16:16)
3. Definir outro requisito importante para o batismo, segundo a Bíblia. (Atos 2:38)
4. Explicar o que a pessoa batizada deve fazer após entregar sua vida a Jesus. (Mateus 28:19-20)
5. Entender o que é necessário para que um batismo seja realizado, de acordo com a Bíblia. (Mateus 3:6; João 3:23; Atos 8:38-39)
6. Memorizar e recitar Mateus 3:16-17.
7. Compartilhar com um amigo sobre a importância do batismo e convidá-lo a tomar essa decisão. (Atos 22:16)'),
('AMEB-016', 'Ceia do Senhor', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-016.webp', 'https://mda.wiki.br/Especialidade_de_Ceia_do_Senhor', '1. Entender qual é a mensagem que anunciamos ao participar da Ceia do Senhor. (1 Coríntios 11:26)
2. Conhecer o significado do pão e do suco de uva como símbolos na Ceia. (Mateus 26:26-29; João 6:35; João 15:1)
3. Saber quem estabeleceu o lava-pés como parte da Ceia. (João 13:3-5)
4. Explicar os dois significados do lava-pés ensinados por Jesus. (João 13:12-16; Mateus 6:14-15)
5. Saber quando Jesus prometeu que voltará a celebrar a Ceia com os seus discípulos. (Mateus 26:29)
6. Memorizar e recitar Lucas 22:19-20.
7. Compartilhar com um amigo a importância da Ceia do Senhor, explicando a promessa de Jesus para os que participam. (João 6:54)'),
('AMEB-017', 'Dons e Ministérios Espirituais', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-017.webp', 'https://mda.wiki.br/Especialidade_de_Dons_e_Ministérios_Espirituais', '1. Saber qual foi a missão que Jesus confiou aos seus discípulos. (Marcos 16:15-16)
2. Explicar de que forma os discípulos seriam capacitados para cumprir essa missão. (Atos 1:4, 8)
3. Conhecer o resultado imediato da atuação do Espírito Santo na vida dos primeiros cristãos. (Atos 2)
4. Entender como o Espírito Santo distribui os dons espirituais entre os membros da Igreja. (1 Coríntios 12:7-11)
5. Definir qual é o propósito pelo qual os dons espirituais são concedidos. (Efésios 4:12-13)
6. Memorizar e recitar 1 Pedro 2:9.
7. Compartilhar com um amigo como é possível receber os dons espirituais. (Tiago 1:5-6)'),
('AMEB-018', 'Dom de Profecia', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-018.webp', 'https://mda.wiki.br/Especialidade_de_Dom_de_Profecia', '1. Saber por meio de quem Deus transmite suas mensagens aos seres humanos. (Amós 3:7)
2. Conhecer quem são as pessoas que serviram de fundamento para o estabelecimento da Igreja. (Efésios 2:20-21)
3. Entender qual é o propósito do dom de profecia dentro da Igreja. (1 Coríntios 14:4)
4. Explicar quais são as duas principais características da igreja verdadeira nos últimos dias. (Apocalipse 12:17; 19:10)
5. Definir quais são as marcas de um profeta verdadeiro. (Isaías 8:20; Mateus 7:16, 18-20; Gálatas 5:19-23)
6. Memorizar e recitar 2 Pedro 1:20-21.
7. Compartilhar com um amigo quais são os benefícios para quem confia nos profetas de Deus. (2 Crônicas 20:20)'),
('AMEB-019', 'Lei de Deus', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-019.webp', 'https://mda.wiki.br/Especialidade_de_Lei_de_Deus', '1. Conhecer os 10 Mandamentos da Lei de Deus. (Êxodo 20:3-17; Deuteronômio 5:7-21)
2. Descobrir se Jesus aboliu ou confirmou a importância da obediência à Lei de Deus para a Igreja cristã. (Mateus 5:17-18)
3. Entender por que devemos obedecer aos mandamentos de Deus. (João 14:15; 15:10; 1 João 2:3-4)
4. Explicar por que devemos guardar todos os 10 Mandamentos e não apenas alguns. (Tiago 2:10-11)
5. Definir quais são os dois grandes princípios que resumem os 10 Mandamentos. (Lucas 10:27)
6. Memorizar e recitar em ordem os 10 Mandamentos.
7. Compartilhar com um amigo quais são os benefícios prometidos àqueles que obedecem à Lei de Deus. (Salmos 119:98-99, 165; 1 João 3:22)'),
('AMEB-020', 'Sábado', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-020.webp', 'https://mda.wiki.br/Especialidade_de_Sábado', '1. Entender por que, quando e por quem o sábado foi estabelecido como um dia especial de repouso e adoração a Deus. (Gênesis 2:1-3; Êxodo 20:8-11)
2. Conhecer qual era o dia que Jesus costumava santificar e ir à igreja para adorar a Deus, o Pai. (Lucas 4:16)
3. Explicar qual era o dia que os seguidores de Jesus costumavam santificar e ir à igreja para adorar a Deus. (Atos 13:14, 27, 42, 44; 17:2; 18:4)
4. Saber qual será o dia da semana em que os salvos se reunirão para adorar a Deus na nova Terra. (Isaías 66:22-23)
5. Definir qual é o valor do sábado como sinal do nosso relacionamento com Deus. (Ezequiel 20:20)
6. Memorizar e recitar Gênesis 2:2-3.
7. Compartilhar com um amigo como devemos guardar o sábado e quais são os benefícios prometidos àqueles que obedecem a esse mandamento. (Isaías 58:13-14)'),
('AMEB-021', 'Mordomia', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-021.webp', 'https://mda.wiki.br/Especialidade_de_Mordomia', '1. Com base em Salmo 24:1 e 1 Coríntios 6:20, quem é o legítimo proprietário deste mundo e das pessoas que nele habitam?
2. De acordo com Deuteronômio 8:18 e Tiago 1:17, quem nos capacita a adquirir os recursos financeiros necessários para vivermos bem?
3. Segundo 1 Coríntios 6:19-20, por que precisamos cuidar bem do nosso corpo?
4. O que Efésios 5:15-16 ensina sobre o cuidado com a nossa maneira de viver e com o uso do tempo?
5. Ler a parábola dos talentos (Mateus 25:14-30) e explicar o que ela ensina sobre como devemos usar os dons e talentos que Deus nos confiou.
6. Qual é o percentual da nossa renda que Deus nos ordenou devolver como reconhecimento de que tudo provém Dele? (Levítico 27:30; Deuteronômio 14:22)
7. De acordo com a Bíblia, qual deve ser o destino dos dízimos? (Números 18:21; 1 Coríntios 9:13-14)
8. Ainda segundo a Bíblia, qual deve ser o destino das ofertas? (Êxodo 36:3; 2 Reis 12:4-5; 2 Crônicas 24:5)
9. Qual deve ser a nossa atitude ao entregarmos as nossas ofertas a Deus? (2 Coríntios 9:7)
10. Comparar os textos de Malaquias 3:8 e os outros estudados nesta especialidade para diferenciar dízimos e ofertas.
11. Conversar com o tesoureiro, ancião e/ou pastor da sua igreja para entender o que é feito com os recursos recebidos de dízimos e ofertas e descobrir como as ofertas são usadas em sua igreja.
12. Memorizar e recitar Malaquias 3:10.
13. Compartilhar com um amigo sobre a importância de sermos fiéis a Deus nos dízimos e nas ofertas.
14. Fazer uma simulação de orçamento mensal com base no valor da sua mesada ou de um salário-mínimo, com categorias como dízimos e ofertas, alimentação, roupas, transporte, entretenimento, etc.
15. Após o estudo desta especialidade, explicar o que significa ser um mordomo cristão.'),
('AMEB-022', 'Conduta Cristã', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-022.webp', 'https://mda.wiki.br/Especialidade_de_Conduta_Cristã', '1. Estudar como é possível viver no mundo sem se contaminar com práticas e valores contrários aos ensinos bíblicos. (Romanos 12:2; João 17:15-16; 1 João 2:15-17)
2. Identificar quais foram os alimentos originalmente dados por Deus ao ser humano na criação. (Gênesis 1:29)
3. Distinguir entre os animais puros e impuros mencionados na Bíblia, explicando por que alguns não são apropriados para consumo. (Levítico 11; Deuteronômio 14)
4. Explicar os princípios bíblicos sobre a maneira cristã de se vestir. (1 Pedro 3:3-4)
5. Compreender os princípios bíblicos sobre a pureza sexual e escrever um voto pessoal de se manter puro. (1 Coríntios 6:18-20; Mateus 5:27-28)
6. Memorizar e recitar Filipenses 4:8.
7. Compartilhar com um amigo os benefícios de viver segundo os princípios bíblicos e adotar práticas saudáveis.'),
('AMEB-023', 'Matrimônio e Família', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-023.webp', 'https://mda.wiki.br/Especialidade_de_Matrimônio_e_Família', '1. Compreender o propósito pelo qual Deus criou a mulher para viver com o homem, segundo o plano da criação. (Gênesis 2:18-24)
2. Conhecer como o casamento é descrito na Bíblia. (Gênesis 2:24; Mateus 19:6; Hebreus 13:4)
3. Entender como deve ser o relacionamento entre marido e esposa de acordo com os princípios bíblicos. (Efésios 5:21-33)
4. Identificar quanto tempo deve durar um casamento, segundo o plano de Deus. (Mateus 19:6; Romanos 7:1-2)
5. Explicar as consequências que a infidelidade conjugal traz para a família, mostrando como isso fere o sétimo mandamento da Lei de Deus. (Êxodo 20:14; Provérbios 6:32-33)
6. Memorizar e recitar 1 Coríntios 13:4-8.
7. Compartilhar com um amigo como é possível ser verdadeiramente feliz no casamento, seguindo os ensinamentos da Bíblia. (Eclesiastes 4:9-12)'),
('AMEB-024', 'Ministério de Cristo no Santuário Celestial', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-024.webp', 'https://mda.wiki.br/Especialidade_de_Ministério_de_Cristo_no_Santuário_Celestial', '1. Saber a ordem dada por Deus a Moisés para a construção do santuário terrestre e identificar qual modelo deveria ser seguido. (Êxodo 25:8-9, 40; Hebreus 9:24)
2. Compreender qual é o ministério de Jesus no céu após Sua morte e ressurreição. (Hebreus 8:1-2)
3. Saber como Jesus foi identificado durante Seu ministério na Terra. (João 1:29; Isaías 53:4-7)
4. Relacionar o trabalho do sacerdote no santuário terrestre com o ministério de Cristo no santuário celestial. (Levítico 16:9, 15; Hebreus 9:1-28)
5. Explicar a ordem dos principais eventos do ministério de Cristo em favor da salvação dos seres humanos. (1 Coríntios 15:3; Romanos 6:9; 1 Timóteo 2:5; Mateus 25:31-32; 1 Tessalonicenses 4:16-17; Apocalipse 20:12-15)
6. Memorizar e recitar 1 Timóteo 2:5.
7. Compartilhar com um amigo o que Jesus está fazendo hoje no céu e como isso se relaciona com a nossa salvação e futuro. (Hebreus 4:14-16)'),
('AMEB-025', 'Segunda Vinda de Cristo', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-025.webp', 'https://mda.wiki.br/Especialidade_de_Segunda_Vinda_de_Cristo', '1. Conhecer a maior promessa que Jesus fez aos Seus seguidores. (João 14:1-3; Apocalipse 22:20)
2. Entender como será a volta de Jesus, segundo a Bíblia. (Atos 1:11; Apocalipse 1:7; Mateus 16:27; 1 Tessalonicenses 5:2-3)
3. Estudar o que acontecerá com os salvos e com os que rejeitaram a salvação no momento da volta de Cristo. (Mateus 24:30-31; 1 Tessalonicenses 4:16-17; Apocalipse 6:16-17; Apocalipse 20:5-6)
4. Compreender o que a Bíblia ensina sobre o dia da volta de Jesus. (Mateus 24:36, 42)
5. Listar alguns dos sinais que mostram que a volta de Jesus está próxima. (Apocalipse 6:12-13; Lucas 21:10-11; Mateus 24:12, 14; 2 Timóteo 3:1-5)
6. Memorizar e recitar Isaías 25:9.
7. Compartilhar com um amigo a esperança da volta de Jesus e o que devemos fazer para estarmos preparados para esse grande dia. (Tito 2:11-14)')
on conflict (codigo) do update set nome = excluded.nome, categoria_slug = excluded.categoria_slug, tipo = excluded.tipo, nivel = excluded.nivel, ano = excluded.ano, origem = excluded.origem, imagem = excluded.imagem, url_mda = excluded.url_mda, requisitos = excluded.requisitos;

insert into public.especialidades (codigo, nome, categoria_slug, tipo, nivel, ano, origem, imagem, url_mda, requisitos) values
('AMEB-026', 'Morte e Ressurreição', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-026.webp', 'https://mda.wiki.br/Especialidade_de_Morte_e_Ressurreição', '1. Saber quem é o único ser imortal, de acordo com a Bíblia. (1 Timóteo 6:15-16)
2. Estudar como Deus criou o ser humano e qual foi a advertência dada a respeito da morte. (Gênesis 2:7, 16-17)
3. Explicar como a morte passou a fazer parte da realidade humana. (Gênesis 3:4, 6, 19)
4. Compreender o que a Bíblia explica sobre o tempo de vida dos seres humanos. (Romanos 5:12; Tiago 4:14; Jó 14:1-2)
5. Definir qual é o meio pelo qual podemos receber a vida eterna. (Romanos 6:23; 2 Timóteo 1:10; 1 Coríntios 15:22)
6. Memorizar e recitar João 5:28-29.
7. Compartilhar com um amigo a solução que a Bíblia apresenta para o problema da morte. (1 Coríntios 15:51-54)'),
('AMEB-027', 'Milênio e Fim do Pecado', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-027.webp', 'https://mda.wiki.br/Especialidade_de_Milênio_e_Fim_do_Pecado', '1. Saber para onde irão as pessoas salvas por Jesus após a Sua segunda vinda. (1 Tessalonicenses 4:16-17; João 14:2-3)
2. Explicar o que acontecerá com os ímpios (aqueles que rejeitaram a salvação) no momento da volta de Jesus. (Apocalipse 6:15-17; Apocalipse 20:5)
3. Compreender como será a condição da Terra durante o período de mil anos iniciado após o retorno de Jesus. (Jeremias 4:23-25)
4. Estudar o que a Bíblia diz que os salvos farão durante o milênio. (Apocalipse 20:4-6; 1 Coríntios 6:2-3)
5. Entender como terminará o grande conflito entre o bem e o mal, e qual será o destino final de Satanás e do pecado. (Apocalipse 21:2, 8; 20:5, 7-15)
6. Memorizar e recitar Apocalipse 20:6.
7. Compartilhar com um amigo como será o fim do pecado e o que acontecerá durante o milênio descrito em Apocalipse 20.'),
('AMEB-028', 'Nova Terra', 'ensinos-biblicos', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ameb-028.webp', 'https://mda.wiki.br/Especialidade_de_Nova_Terra', '1. Saber qual é a grande esperança dos filhos de Deus quanto ao destino da humanidade. (2 Pedro 3:13; Mateus 5:5; Apocalipse 21:1)
2. Descrever o que acontecerá com a cidade santa, a Nova Jerusalém. (Apocalipse 21:2-3)
3. Identificar quem serão os habitantes da nova Terra, segundo a Bíblia. (Apocalipse 22:3-4; 21:7)
4. Identificar quem não fará parte da nova Terra. (Apocalipse 21:8; 22:15; 1 Coríntios 6:9-10; Gálatas 5:19-21)
5. Refletir sobre como será viver com Jesus por toda a eternidade. (Apocalipse 5:13; 11:15; 21:4)
6. Memorizar e recitar Mateus 5:5.
7. Compartilhar com um amigo como será a vida na nova Terra, conforme as promessas bíblicas. (Salmo 16:11; Isaías 65:17-25)'),
('AP-001', 'Conserto de Sapatos', 'atividades-profissionais', 'especialidade', 3, 1928, 'Associação Geral', '/esp/ap-001.webp', 'https://mda.wiki.br/Especialidade_de_Conserto_de_Sapatos', '1. Mencionar, pelo menos, 5 partes essenciais de um sapato e explicar suas utilidades.
2. Citar 3 diferentes tipos de solado de sapato. Qual o mais fácil para consertar?
3. Encerar uma linha e, com 2 agulhas ou pontas enceradas, consertar um par de sapatos que esteja esgarçado. Usar o método de ponto duplo para costurar o couro.
4. Fazer um molde de papel para meia-sola e usá-lo para cortar meias-solas de couro ou composição de borracha para um par de sapatos.
5. Fazer meia-sola de um par de sapatos fixando-a com pregos de sapateiro, certificando-se de que são do comprimento adequado.
6. Encaixar e prender um par de saltos de borracha.
7. Que tipo de couro deve ser usado para consertar solas de sapatos? Como, geralmente, é curtido este tipo de couro?
8. Especificar, pelo menos, 3 fatores que devem ser levados em consideração na seleção de sapatos.
9. Escrever ou apresentar aos examinadores os métodos apropriados de limpar e cuidar dos sapatos.'),
('AP-002', 'Fotografia', 'atividades-profissionais', 'especialidade', 2, 1928, 'Associação Geral', '/esp/ap-002.webp', 'https://mda.wiki.br/Especialidade_de_Fotografia', '1. Explicar os princípios da construção de uma máquina fotográfica, o que faz a lente da câmera e o efeito da luz sobre a foto.
2. O que significa ASA/lSO?
3. Como a velocidade do diafragma, a abertura da lente e o índice ASA/ISO estão interligados?
4. Apresentar os principais usos da fotografia.
5. Explicar o que quer dizer "Pintar com a Luz".
6. Escolher fotos em papel ou slide, que ilustrem pelo menos oito das seguintes técnicas. Use outras fotos para fazer uma comparação:
  a) Enquadramento
  b) Balanço de branco
  c) Direção da luz - frente, iluminação traseira, lateral
  d) Foco e profundidade de campo
  e) Regra dos terços
  f) Ângulo - nível dos olhos, alto e baixo
  g) Nível do horizonte
  h) Distância focal
  i) Uso de linhas guia
  j) Qualidade da luz - sombra, luz do sol, hora do dia
  k) Exposição correta - pouca exposição, exposição excessiva
  l) Uso do flash - objetos à distância, e objetos que refletem luz
7. Explicar como fazer fotografia noturna e apresentar, no mínimo, 3 fotografias utilizando essa técnica.
8. Contar uma história utilizando as técnicas de fotografia com até 10 fotos.'),
('AP-003', 'Mecânica Automotiva', 'atividades-profissionais', 'especialidade', 2, 1928, 'Associação Geral', '/esp/ap-003.webp', 'https://mda.wiki.br/Especialidade_de_Mecânica_Automotiva', '1. Demonstrar como ligar um carro. Explicar porque é necessário verificar periodicamente o óleo, água, combustível, pneus, freios e bateria.
2. Trocar um pneu de forma adequada e demonstrar como consertar um furo no mesmo.
3. Explicar o princípio dos motores de 4 e 2 ciclos e a diferença entre os motores a gasolina, diesel e etanol. Explicar as principais diferenças entre o sistema de carburador e o de injeção eletrônica.
4. Descrever a construção de um motor a gasolina e explicar resumidamente as funções das partes a seguir:
  a) Motor virabrequim, bielas, pistões, eixo, válvulas, bomba de óleo, carburador, injetor de combustível, distribuidor da ignição, distribuidor do combustível, sistema elétrico, incluindo alternador, bateria e regulador.
  b) Diferença entre a transmissão manual e a automática e como o torque do motor é transmitido em ambos os casos.
  c) Diferença entre carros de tração dianteira e tração traseira.
  d) Diferença entre o freio a disco, ABS, freio de mão e freio hidráulico.
  e) Trocar um conjunto de pneu/roda
  f) Lubrificar o chassi de acordo com o manual do veiculo
5. Com que frequência deve-se trocar óleo do motor, óleo da transmissão e o fluido do ar condicionado?
6. Apresentar algumas sugestões de cuidados do veículo, tanto interna como externamente.
7. Explicar como funciona:
  a) Um carro hibrido
  b) Um carro eletrico'),
('AP-004', 'Radioamadorismo', 'atividades-profissionais', 'especialidade', 3, 1928, 'Associação Geral', '/esp/ap-004.webp', 'https://mda.wiki.br/Especialidade_de_Radioamadorismo', '1. Receber e enviar corretamente pelo menos 5 palavras por minuto, durante 5 minutos, usando o Código Internacional Fonético e o Código Q (25 palavras de 5 letras no mínimo, 25 letras corretas consecutivas).
2. Explicar, pelo menos, 8 regras que regulamentam as atividades dos operadores de rádio.
3. Explicar os termos abaixo e informar qual equipamento usado para medição:
  a) Energia elétrica
  b) Corrente elétrica
  c) Potência elétrica
4. Quais as abreviaturas para:
  a) Greenwich Mean Time
  b) Megaciclos
  c) Onda contínua
  d) Modulação de amplitude
  e) Modulação de frequência
  f) Kilociclos
  g) Eastern Standard Time
5. Dar a fórmula algébrica da Lei de Ohm e sua utilidade.
6. Explicar os seguintes termos:
  a) Amplificação
  b) Modulação
  c) Detecção
  d) Atenuação
7. Qual a relação entre uma frequência fundamental e sua segunda, terceira ou quarta harmônica?
8. Alguma transmissão pode ser feita sem a identificação da estação?
9. A que intervalos a estação amadora deveria transmitir seu sinal de chamada (CQ)?
10. Qual a função do filtro RFI (radio frequency interference)? Explicar como uma frequência de radio pode sofrer interferências.
11. Explicar a função dos seguintes componentes:
  a) Modulador RF
  b) Amplificador
  c) Retificador
  d) Filtro
12. Explicar o que são oscilações parasíticas (feedback).
13. Qual deve ser a potência para as válvulas que fornecem energia para a antena de um radioamador?
14. Explicar o termo estado sólido? em radioamadorismo.
15. Por que retificadores e filtros são necessários no sistema de abastecimento de placa de energia quando operado a partir de corrente alternada? Quais são as regulamentações em sua área que regem operadores de radioamador?'),
('AP-005', 'Datilografia', 'atividades-profissionais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ap-005.webp', 'https://mda.wiki.br/Especialidade_de_Datilografia', '1. Mostrar como limpar, escrever corretamente e mudar a fita numa máquina de escrever.
2. Saber a diferença entre um tecido e uma fita de carbono.
3. Conhecer as partes de uma máquina de escrever e saber a função de todas as suas teclas.
4. Saber como fazer tabulação. Datilografar uma página usando tabulação com, pelo menos, 4 colunas.
5. Demonstrar como centralizar o texto horizontal e verticalmente.
6. Demonstrar como fazer letras em itálico e negrito.
7. Operar uma máquina de escrever a uma velocidade de 40 palavras por minuto (mínimo) em material novo, durante 5 minutos, com não mais de 5 erros.'),
('AP-006', 'Eletricidade', 'atividades-profissionais', 'especialidade', 2, 1929, 'Associação Geral', '/esp/ap-006.webp', 'https://mda.wiki.br/Especialidade_de_Eletricidade', '1. Ser capaz de explicar e ilustrar um experimento através do qual as leis de atração e repulsão elétricas são demonstradas.
2. Explicar a diferença entre correntes continua e alternada e demonstrar as utilidades de cada uma. Apresentar um método para determinar que tipo de fluxo tem cada circuito.
3. Fazer um eletroímã simples, ou ligar uma campainha ou lâmpada a uma bateria, usando um interruptor em linha.
4. Montar e colocar para funcionar um motor elétrico simples, a partir de um kit, ou desmontar um motor elétrico e identificar as partes e explicar como funcionam.
5. Ser capaz de construir uma bateria elétrica.
6. O que é um fusível e qual sua finalidade? Demonstrar habilidade para substituir fusíveis e rearmar disjuntores e mostrar a forma correta de emendar fios elétricos.
7. Fazer um diagrama do sistema de iluminação de um automóvel.
8. Fazer um diagrama que mostre como lâmpadas, interruptores e tomadas são controlados por cada fusível ou disjuntor em uma casa.
9. Ler um medidor (relógio) de eletricidade corretamente e calcular a conta de energia de uma residência com as taxas cobradas em sua região.
10. Qual a relação entre intensidade e tensão de uma corrente elétrica descrita na lei de Ohm?
11. Demonstrar como usar uma chave de teste e quais as medidas de segurança que devem ser tomadas ao manusear uma rede elétrica.
12. Qual a diferença entre Watt e Volt?
13. Explique oque é efeito joule ou efeito térmico.'),
('AP-007', 'Carpintaria', 'atividades-profissionais', 'especialidade', 2, 1929, 'Associação Geral', '/esp/ap-007.webp', 'https://mda.wiki.br/Especialidade_de_Carpintaria', '1. Demonstrar a maneira apropriada de pregar, assentar e dobrar um prego, e arrancá-lo com martelo de orelhas.
2. Explicar para que tipo de trabalho são indicadas as seguintes ferramentas e demonstrar o uso de cada uma:
  a) Caixa de corte
  b) Serra circular
  c) Serrote
  d) Plaina
  e) Esquadro
  f) Pregos e parafusos de diversos tamanhos e espessuras
  g) Formões
  h) Nível
  i) Prumo
  j) Furadeira
  k) Marreta de borracha
3. Fazer um retângulo usando as seguintes dimensões: 6 cm, 8 cm, 10 cm e provar por sua diagonal que as medidas são equivalentes.
4. Descrever o uso e distinguir 5 diferentes tipos de pregos.
5. Construir um dos objetos a seguir, com tamanho mínimo de 1,20 m por 1,20 m:
  a) Armário de ferramentas
  b) Casa de bonecas
  c) Casa de cachorro
6. Descrever a diferença para uso e aplicação entre pregos e parafusos.'),
('AP-008', 'Corte e Costura', 'atividades-profissionais', 'especialidade', 2, 1929, 'Associação Geral', '/esp/ap-008.webp', 'https://mda.wiki.br/Especialidade_de_Corte_e_Costura', '1. Identificar amostras de diferentes tecidos, incluindo algodão, linho, lá, seda, cetim, nylon, flanela, brim, microfi bra, oxford, lycra, malha.
2. Ter uma caixa de costura para o seu material, incluindo: almofada para alfinetes, fita métrica, alfinetes, agulhas, linha, tesoura, lápis e giz.
3. Demonstrar como endireitar o tecido antes do uso.
4. Demonstrar como colocar o molde sobre o tecido, de acordo com o desenho do molde.
5. Demonstrar como usar um abridor de casas.
6. Demonstrar as seguintes técnicas de costura:
  a) Overlocar
  b) Franzir
  c) Chulear
  d) Pespontar
  e) Fazer nervura
7. Fazer uma das opções a seguir:
  a) Uma saia, colocando zíper e costura no cós. A barra da saia deve ser feita de forma que a mesma não tenha pontas.
  b) Uma blusa. Explicar como faria para ajustar os ombros para pessoas de diferentes tipos físicos.'),
('AP-009', 'Taquigrafia', 'atividades-profissionais', 'especialidade', 3, 1929, 'Associação Geral', '/esp/ap-009.webp', 'https://mda.wiki.br/Especialidade_de_Taquigrafia', '1. O que é taquigrafia?
2. Onde essa profissão é mais praticada e qual a sua importância?
3. Ter um dicionário de taquigrafia disponível (geralmente fornecido pelos editores do curso).
4. Ser capaz de anotar um ditado, ao ritmo de 60 palavras por minuto, durante 3 minutos consecutivos e transcrever corretamente as anotações feitas.'),
('AP-010', 'Tipografia', 'atividades-profissionais', 'especialidade', 2, 1929, 'Associação Geral', '/esp/ap-010.webp', 'https://mda.wiki.br/Especialidade_de_Tipografia', '1. Conhecer os princípios e funcionamento dos seguintes equipamentos:
  a) Prensa rotativa
  b) Máquina de offset
  c) Copiadora
  d) Impressora tipográfica
2. Saber como é determinado o peso do papel, conhecer os 4 tipos diferentes de papel e dizer para que são usados.
3. Fazer uma visita a uma gráfica ou à sede de um jornal de sua cidade. Escrever um relatório de 300 palavras ou apresentar ou relatório oral, de 3 minutos, sobre os passos que você observou no processo de impressão.
4. Fazer uma pesquisa para aprender sobre a história da impressão tipográfica. Traçar o desenvolvimento da impressão e como o equipamento tipográfico evoluiu até o presente.
5. Conhecer as diferentes tintas existentes para a impressão e suas características.
6. Saber o significado dos seguintes termos:
  a) Degoladura
  b) Negrito
  c) Cabeçalho
  d) Fonte
  e) Entalho
  f) Acabamento
  g) Negativo
  h) Clipart
  i) Colagem
  j) Separação de cores
  k) Contato
  l) baixo relevo
  m) Alto relevo
  n) Gravação
  o) Padrão
  p) Registro
  q) Termografia
  r) Marca d''água
  s) Realçar
  t) Impressão
  u) Comparar
  v) Apagado
  w) Desgravação
  x) Gravação (alto relevo)
  y) Gravação (baixo relevo)
7. Saber a diferença entre meios tons, duplos tons e o processo de 4 cores.
8. Entrevistar um tipógrafo para descobrir o seguinte:
  a) Que formação é necessária para entrar no campo da tipografia?
  b) Que oportunidades de crescimento existem nessa área?
  c) Que futuro o setor de gráficas pode esperar?
  d) O que faz, em sua empresa, para deixar os clientes satisfeitos?
  e) Que oportunidades de carreira existem, relacionados à tipografia?'),
('AP-011', 'Marcenaria', 'atividades-profissionais', 'especialidade', 2, 1934, 'Associação Geral', '/esp/ap-011.webp', 'https://mda.wiki.br/Especialidade_de_Marcenaria', '1. Explicar como os processos a seguir estão relacionados ao trabalho com madeira e como cada um deles é feito:
  a) Cultivo de árvores
  b) Extração
  c) Corte da madeira
  d) Tratamento
  e) Cura
  f) Aplanamento
2. Coletar e classificar cinco diferentes tipos de madeira usados no trabalho de marcenaria. Explicar as vantagens e desvantagens de cada um.
3. Explicar a função de cada um dos equipamentos abaixo. Explicar as regras de segurança de cada uma delas, os cuidados de conservação, demonstrando, na prática, sua utilidade:
  a) Plaina manual
  b) Serra esquadrejadeira
  c) Desengrossadeira
  d) Lima
  e) Tupia
  f) Coladeira de Bordo
  g) Trena
  h) Formão
  i) Esquadro
  j) Furadeira
4. Explicar os encaixes a seguir:
  a) Rabo de andorinha
  b) Espiga
  c) Meia esquadria
  d) Encaixe de toco
  e) Chanfro
5. Conhecer as características e saber trabalhar com os seguintes materiais:
  a) Compensado
  b) Aglomerado
  c) Madeira bruta
6. Conhecer, pelo menos, duas técnicas de acabamento para MDF.
7. Demonstrar a técnica apropriada de colar e fixar madeira.
8. Fazer um objeto de mobília para uma casa, como uma mesa de cabeceira, um banquinho, escrivaninha ou estante de livros. Relacionar o material necessário para o seu projeto.
9. Conhecer e praticar os passos adequados para fazer um acabamento num objeto de madeira, com polimento simples ou com pintura.
10. Fazer dois dos seguintes:
  a) Fazer uma porta ou tampo com dobradiças internas
  b) Fazer uma maquete de casa ou prédio com uma seção que mostre detalhes do interior
  c) Ajudar a fazer e/ou consertar brinquedos de madeira
  d) Fazer um projeto usando um dos encaixes mencionados no item 4'),
('AP-012', 'Encadernação', 'atividades-profissionais', 'especialidade', 3, 1935, 'Associação Geral', '/esp/ap-012.webp', 'https://mda.wiki.br/Especialidade_de_Encadernação', '1. Identificar os seguintes termos:
  a) Miolo
  b) Guardas
  c) Brochuras
  d) Folha de rosto
  e) Dorso
  f) Assinatura
  g) Capa dura
2. Descrever a diferença entre os seguintes métodos de encadernação:
  a) Ligação perfeita
  b) Capa dura
  c) Assinatura simples
  d) Espiral (metal e plástico)
  e) Grampeamento
3. Realizar o seguinte:
  a) Encadernar um "manuscrito" de um caderno só.
  b) Encadernar um livro em branco, usando, pelo menos, 4 cadernos.
  c) Demonstrar a maneira correta de agrupar novas encadernações.
  d) Fazer uma capa para seu livro de, pelo menos, 4 cadernos.
4. Identificar e descrever as utilidades das seguintes ferramentas de encadernação:
  a) Máquina de costura de caderno
  b) Máquina de lombada quadrada
  c) Furadores
5. Definir a diferença de peso de papel em relação a uma resma de papel.
6. Descrever a cor e as propriedades de 2 tipos de adesivos usados no processo de encadernação e onde são usados:
  a) Cola quente
  b) Cola de resina
7. Conhecer e relacionar os 5 principais estágios da encadernação à mão.
  a) Preparação dos cadernos
  b) Costura dos cadernos
  c) Cola
  d) Fixação das capas
  e) Acabamento'),
('AP-013', 'Alvenaria', 'atividades-profissionais', 'especialidade', 3, 1937, 'Associação Geral', '/esp/ap-013.webp', 'https://mda.wiki.br/Especialidade_de_Alvenaria', '1. Citar, pelo menos, 6 materiais de construção usados por pedreiros na edificação de paredes ou construções.
2. Demonstrar habilidade para usar corretamente o prumo, nível, colher de pedreiro, martelo de pedreiro, desempeno (desenpenadeira, flatache) linha e mangueira de nível.
3. Conhecer as características do cimento usado na construção (CP II e CP III) e saber como evitar que ele fique ralo, que tenha rachaduras, que encolha ou esfarele.
4. Escrever um parágrafo descrevendo o comportamento do cimento: o que é, sua reação à água, suas qualidades adesivas, quanto tempo demora para secar, etc.
5. Fazer argamassa e explicar a proporção adequada dos ingredientes, como cal, areia, pedra, água, etc., em 2 das seguintes aplicações:
  a) Assentamento de tijolos ou blocos
  b) Argamassa para contrapiso
  c) Concretagem de laje ou baldrame
6. Construir um muro reto de pedras, tijolos ou blocos de, pelo menos, 1,20 m de altura e 3 metros de comprimento. O muro deve ter um canto (esquina). A superfície deve ser alisada.
7. Construir uma escada com, pelo menos, 2 degraus bem nivelados, usando argamassa misturada por você mesmo e os reforços apropriados, como caixaria e ferragens.
8. Fazer as fôrmas e fazer um pedaço de calçada ou chão de concreto, usando argamassa comprada pronta ou fazer a argamassa. Fazer o acabamento e verificar se ficou bem nivelado.
9. Saber como tirar o esquadro de um determinado local (terreno, sala, etc.).
10. Descrever so processos de fabricação dos tijolos da sua região. Quais os tipos existentes em sua região? Informar um tamanho e a quantidade de furos dos mesmos.
11. Qual a diferença entre cal virgem e cal hidratada? Quais os cuidados que devemos ter ao lidar com esses materiais?
12. Pesquisar na Bíblia como deve ser a edificação de uma casa? A que Jesus a compara?'),
('AP-014', 'Barbearia', 'atividades-profissionais', 'especialidade', 3, 1938, 'Associação Geral', '/esp/ap-014.webp', 'https://mda.wiki.br/Especialidade_de_Barbearia', '1. Passar um mínimo de 2 horas observando um barbeiro/cabeleireiro enquanto este trabalha.
2. Mencionar 3 cuidados essenciais no tratamento de cabelos.
3. Como descartar a lâmina usada de uma navalha?
4. Demonstrar habilidade de lavar cabelos com xampu corretamente.
5. Explicar e demonstrar, pelo menos, 2 métodos de cortar cabelos.
6. Explicar e demonstrar o propósito de, pelo menos, 2 tipos diferentes de pentes usados em cortes de cabelos.
7. Explicar e demonstrar o propósito de 2 tipos diferentes de tesouras.
8. Explicar e demonstrar, pelo menos, 2 propósitos para o uso da máquina de cortar cabelo.
9. Realizar um estágio em barbearia ou salão de cabeleireiro por pelo menos duas semanas.'),
('AP-015', 'Colocação de Papel de Parede', 'atividades-profissionais', 'especialidade', 3, 1938, 'Associação Geral', '/esp/ap-015.webp', 'https://mda.wiki.br/Especialidade_de_Colocação_de_Papel_de_Parede', '1. Descrever o preparo adequado de uma parede para a colocação de papel de parede.
2. Explicar como prender o papel de parede, descrevendo, pelo menos, 2 métodos.
3. Usando um método citado na questão anterior, colocar um papel de parede em, pelo menos, 2 paredes.
4. Demonstrar como encaixar bem um desenho na parede que será trabalhada.
5. Usar a sua criatividade desenhando algumas combinações de papel de parede para o seguinte:
  a) Sala
  b) Cozinha
  c) Banheiro
  d) Quarto
  e) Salão de Jogos
  f) Igreja'),
('AP-016', 'Contabilidade', 'atividades-profissionais', 'especialidade', 3, 1938, 'Associação Geral', '/esp/ap-016.webp', 'https://mda.wiki.br/Especialidade_de_Contabilidade', '1. O que é contabilidade e qual o seu principal objetivo? Quem são os principais usuários das informações contábeis? Como ela se aplica dentro do contexto social?
2. O Método das partidas dobradas é um dos pilares da contabilidade e é universalmente aceito. Escrever em que consiste este método e como ele é utilizado dentro da contabilidade das entidades de forma geral. Pesquisar sobre como ele surgiu e por que é o método aceito para registro dos fatos contábeis.
3. O que é balanço patrimonial?
4. Demonstrar a estrutura do balanço patrimonial em conformidade com as Normas Internacionais de contabilidade (IFRS - International Financial Reporting Standard).
5. Explicar o que é: Ativo, passivo e patrimônio líquido.
6. Ser capaz de classificar corretamente itens de um balanço com ativos de curto e longo prazo, passivos de curto e longo prazo e lucro líquido.
7. Explicar o que são créditos e débitos na contabilidade. Por que as contas dos ativos são chamadas de contas devedoras e do passivo de credores?
8. Ser capaz de escrever um extrato de rendimentos a partir de um balancete.
9. Ser capaz de encaixar as informações de um extrato de banco em contas correntes, incluindo: taxas de serviços, juros e cheques que ainda não foram depositados.
10. Quais são os principais demonstrativos contábeis? Quais demonstrações contábeis são obrigatórias e qual a relevância de cada uma delas para uma entidade?'),
('AP-017', 'Evangelismo', 'atividades-profissionais', 'especialidade', 2, 1938, 'Associação Geral', '/esp/ap-017.webp', 'https://mda.wiki.br/Especialidade_de_Evangelismo', '1. Manter uma regularidade em sua devoção pessoal durante, pelo menos, 3 meses.
2. Entrevistar seu pastor distrital e obter as seguintes informações de seu serviço ministerial junto à Igreja:
  • I. Trabalho Pastoral
    1. Como ele faz as visitas.
    2. Qual é seu trabalho junto à Comissão da Igreja.
    3. Como ele monta seu itinerário pastoral.
    4. Como ele usufrui sua folga semanal.
    5. Como ele monta seu calendário de pregaçôes (homilético)..
  • II. Pessoal
    1. Como conheceu o evangelho.
    2. Como se tornou um evangelista.
    3. Qual a parte mais gratificante de seu ministério.
    4. Qual é a parte mais difícil de seu ministério.
    5. Como soube que Deus o chamara para o ministério.
    6. Que conselho daria a alguém que estivesse pensando em tornar-se um ministro.
    7. Qual sua rotina de estudo pessoal da Bíblia.
    8. Uma história que marcou a sua vida de evangelista.
  • III. Evangelizador
    1. Como ele alcança pessoas para Jesus.
    2. Como se forma seu alvo batismal.
    3. Como está planejado seu programa de evangelismo para esse ano.
3. Através do estudo da Bíblia e do Espírito de Profecia, aprender como Jesus tratava as multidões que O procuravam. Citar, pelo menos, 2 passagens bíblicas e mais 2 do Espírito de Profecia.
4. Participar de 3 atividades práticas na área de Evangelismo:
  a) Participar numa série ou semana de evangelismo.
  b) Dar estudos bíblicos a alguem que esteja se preparando para o batismo;
  c) Fazer 4 visitas a hospitais, fazendo um pequeno momento devocional e uma oração em cada uma delas.
  d) Elaborar e pregar um sermão de, pelo menos, 20 minutos de duração.
  e) Fazer os momentos devocionais em 2 cultos noturnos e em 2 matutinos num acampamento.
  f) Em 5 dias diferentes, realizar momentos devocionais na escola ou no seu trabalho.
  g) Assistir 75% das reuniões de uma série de conferências de sua igreja local, obter as seguintes informações cada noite:
    • Comparar o número de presentes em cada um dos assuntos apresentados.
    • Fazer uma lista dos temas apresentados e entender o porquê foi usado nessa sequência.
    • Fazer, pelo menos, 10 visitas a interessados.
5. Pesquisar a biografia de, pelo menos, 3 grandes evangelistas cristãos, sendo pelo menos um deles adventista.
6. Ter uma coleção de sermões para uma serie ou semana evangelisticas, sendo pelo menos um deles elaborado por você.'),
('AP-018', 'Hidráulica', 'atividades-profissionais', 'especialidade', 3, 1938, 'Associação Geral', '/esp/ap-018.webp', 'https://mda.wiki.br/Especialidade_de_Hidráulica', '1. Fazer um diagrama mostrando o sistema de encanamento de uma casa de 4 cômodos, incluindo saídas de água para a cozinha, banheiro e área de serviço.
2. Demonstrar como consertar dois canos de aço galvanizado de forma correta.
3. Demonstrar como consertar um cano de pvc e um cano de cobre.
4. Demonstrar habilidade para consertar uma torneira de pia que apresente vazamento e trocar ou consertar a válvula de fluxo do vaso sanitário.
5. Descrever o sistema de drenagem adequado para a casa do item 1 e explicar onde se usam e qual a utilidade dos sifões e a ventilação.
6. Saber como funciona o sistema de água quente e fria de uma casa fazendo um esquema hidráulico e definindo cada tipo de tubulação utilizada em cada sistema.
7. Fazer um diagrama de aquecimento de água utilizando a energia solar e aplicá-la em um acampamento de seu clube.'),
('AP-019', 'Jornalismo', 'atividades-profissionais', 'especialidade', 3, 1938, 'Associação Geral', '/esp/ap-019.webp', 'https://mda.wiki.br/Especialidade_de_Jornalismo', '1. Discutir com seu instrutor as seguintes frases e fazer um relatório com as conclusões obtidas:
  a) "O jornalismo é o oxigênio da Democracia" José Marques de Melo, professor de Jornalismo.
  b) "Se tivesse que decidir se devemos ter governo sem jornais ou jornais sem governo, eu não vacilaria um instante em preferir o último." Thomas Jefferson, presidente norte-americano.
  c) "Sem a plena vigência da liberdade de expressão, a democracia é uma ficção" Carlos Pérez Giménez, jornalista argentino.
2. Quais são as principais áreas de atuação de uma pessoa formada em jornalismo?
3. Que tipos de empregos estão à disposição para aqueles que se interessam pelo jornalismo?
4. Ler a história de II Samuel 18:9-32. Discutir com seu instrutor as características das 2 formas de se dar uma notícia apresentadas nesta história. Qual a importância das palavras, da ética e da fidelidade aos fatos?
5. O que é mídia e quais os principais meios de comunicação utilizados no jornalismo atualmente? Citar as principais diferenças entre eles.
6. Descrever o significado básico destas expressões utilizadas pelos jornalistas:
  a) Pauta
  b) Redação
  c) Lauda
  d) Fonte
  e) Nota
  f) Lead
  g) Intertítulo
  h) Foto-legenda
  i) Artigo
  j) Reportagem
  k) Editorial
  l) Coluna
  m) Escalada
  n) Furo
7. Descrever os elementos de um bom parágrafo de abertura e a utilidade e importância das manchetes ou chamadas de uma notícia.
8. Quais os passos essenciais para se escrever uma boa história?
9. Escrever uma história sobre um dos assuntos a seguir:
  a) Sua família. Como sua família aceitou a Cristo? Você foi o primeiro, seus pais ou seus avós? Etc.
  b) Experiências com Deus. Experiências pessoais de orações atendidas ou momentos que você viu a mão de Deus guiando seus passos e decisões bem de perto.
  c) Bichinhos de Estimação. Contar alguma história interessante que tenha acontecido com algum animalzinho de estimação que você teve/tem.
  d) Acampamentos. Alguma experiência inesquecível que você teve em algum acampamento.
  e) Conversão. Contar sobre quando Deus tornou-se real para você como amigo e Salvador pessoal.
  f) Ser Cristão. Escrever sobre o que você acha mais difícil para um cristão atualmente.
10. Responder o seguinte:
  a) Quais os elementos básicos para se escrever uma notícia?
11. Escrever uma noticia com, pelo menos, 3 parágrafos, usando um bom parágrafo de abertura sobre algo interessante que aconteceu em sua igreja, escola, em casa ou no Clube de Desbravadores.
12. Cumprir um dos seguintes itens:
  a) Marcar uma visita a um dos veículos de comunicação de sua cidade: jornal, editora de revista, rádio, emissora ou retransmissora de TV, etc. Conhecer o funcionamento da redação de jornalismo deste veículo. Como funciona o dia a dia de trabalho de um jornalista nele?
  b) Publicar uma noticia em um veiculo de comunicação (impresso, eletrônico ou digital)> Pode ser em um blog, página do seu clube ou igreja, um jornal do bairro ou revista. Podem ser veículos seculares ou da Igreja Adventista do Sétimo Dia. Saber como escrever uma carta de apresentação para o editor a quem vai enviar a sua noticia.'),
('AP-020', 'Ofício de Alfaiate', 'atividades-profissionais', 'especialidade', 3, 1938, 'Associação Geral', '/esp/ap-020.webp', 'https://mda.wiki.br/Especialidade_de_Ofício_de_Alfaiate', '1. Identificar os tecidos a seguir:
  a) Lã
  b) Microfibra
  c) Algodão
  d) Linho
  e) Seda
  f) Cambraia de linho
  g) Algodão egípcio
  h) Gabardine
  i) Tricoline
2. Como são usados os itens a seguir:
  a) Entretela
  b) Alinhavos
  c) Tecido para forrar
  d) Feltro
3. Explicar os pontos que devem ser observados para que um traje vista bem e demonstre o toque de um alfaiate.
4. Saber como utilizar os instrumentos de passar roupas de acordo com a peça e com o tecido trabalhado.
5. Saber fazer casas de botões.
6. Fazer um bolso sem aba e outro com aba.
7. Demonstrar suas habilidades como alfaiate, medindo, cortando e confeccionando um traje masculino (blazer ou paletó e calça social) ou feminino (Blazer e saia ou vestido) que tenha bom caimento.'),
('AP-021', 'Pintura de Paredes Exteriores', 'atividades-profissionais', 'especialidade', 3, 1938, 'Associação Geral', '/esp/ap-021.webp', 'https://mda.wiki.br/Especialidade_de_Pintura_de_Paredes_Exteriores', '1. Explicar a diferença entre tintas para paredes externas e internas.
2. Explicar como preparar uma parede para pintura, incluindo passos para a remoção de pintura velha, primeira demão de tinta, aplicação de massa corrida, acabamento, etc.
3. Relacionar 10 combinações de cores para pintura de uma casa (se possível, usar uma tabela de marca conhecida).
4. Explicar e demonstrar como preparar e pintar uma peça em metal, ex: porta, janela.
5. Citar, pelo menos, 3 tipos de solventes (thinner) e explicar o uso específico de cada um.
6. Demonstrar habilidade para pintar usando corretamente pincel, rolo e spray.
7. Pintar a parte externa de uma casa de, pelo menos, 4 cômodos (se possível, transformar esta tarefa num projeto em grupo, para ajudar alguém da igreja ou comunidade que esteja precisando deste serviço).
8. Quais medidas tomar nas seguintes ocasiões?
  a) Quando a pintura descasca
  b) Quando a tinta fica com aparência de couro de jacaré
  c) Surgimento de bolhas
  d) Mofos
  e) Tinta que não seca
9. Quais os EPI''s necessários para trabalhar com pinturas em exteriores e materiais químicos?'),
('AP-022', 'Pintura de Paredes Interiores', 'atividades-profissionais', 'especialidade', 3, 1938, 'Associação Geral', '/esp/ap-022.webp', 'https://mda.wiki.br/Especialidade_de_Pintura_de_Paredes_Interiores', '1. Explicar como preparar a madeira para receber verniz.
2. Explicar e demonstrar como preparar e dar o acabamento em madeira usando as seguintes técnicas:
  a) Clareamento
  b) Verniz
  c) Pintura
3. Mencionar 2 métodos de fazer textura em paredes.
4. Em que situação se deve usar um revólver de tinta (pistola de pintura) e saber como regular a pressão correta para a pintura.
5. Descrever os métodos adequados de limpar e cuidar de pincéis usados em pinturas com diferentes tipos de tintas e pinceis usados com verniz.
6. Demonstrar como usar corretamente a massa corrida.
7. Explicar a diferença de tintas para pintura externa e interna.
8. Fazer uma lista de 10 combinações de cores para pintura de interiores, usando tabela de cores de alguma marca conhecida. Por que as cores fortes não são aconselháveis?
9. Explicar a composição das seguintes tintas e em que situações devem ser usadas:
  a) Tinta com brilho
  b) Tinta fosca
  c) Tinta solúvel em água
10. Pintar as partes de madeira de, pelo menos, 4 cômodos.
11. Pintar, pelo menos, 1 cômodo inteiro.
12. Qual a diferença entre massa corrida e cal fina?
13. Saber a proporção correta para diluição dos seguintes tipos de tintas:
  a) Látex ou PVA
  b) Acrílica
  c) Esmalte
  d) Verniz
  e) Óleo
  f) Epóxi
14. Saber quais cuidados ter e os EPI''s necessários para se trabalhar com pintura interna.'),
('AP-023', 'Radioeletrônica', 'atividades-profissionais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ap-023.webp', 'https://mda.wiki.br/Especialidade_de_Radioeletrônica', '1. Explicar, com diagramas, quando necessário, os dispositivos de entrada utilizados em rádios, por exemplo, antena, terra; ou, dispositivos eletrônicos, tais como sinalizador FM, fotocélula, captador de fotos e microfone.
2. Construir uma antena receptora de rádio; OU construir um toca-discos, fotocélula ou microfone.
3. Explicar o uso e operação de vários componentes importantes de um aparelho receptor simples (bobinas, capacitores variáveis, capacitores fixos, resistores, transistores ou válvulas, diodos e transformadores).
4. Identificar o valor de resistores pelo código de cores.
5. Conhecer a lei de Ohm e como a mesma é aplicada.
6. Construir um rádio simples (com válvula ou transistor) incluindo fonte, que deverá sintonizar estações a 160 quilômetros de distância, ou construir um amplificador de alta fidelidade.
7. Desenhar de memória, usando símbolos apropriados, um esquema completo do dispositivo construído no item anterior.
8. Mostrar fluência na resolução de problemas em sintonizadores simples ou dispositivos eletrônicos de 3 a 6 válvulas ou transistores, demonstrando aptidão para seguir testes de rotina assim como: retirar válvulas ou transistores e testá-los, substituí-los corretamente, verificando se os capacitores estão em curto e se há outros problemas.'),
('AP-024', 'Magistério', 'atividades-profissionais', 'especialidade', 2, 1944, 'Associação Geral', '/esp/ap-024.webp', 'https://mda.wiki.br/Especialidade_de_Magistério', '1. Ter, no mínimo, 15 anos ou estar no 1° ano do Ensino Médio.
2. Que formação é necessária para lecionar no(a):
  a) Educação infantil
  b) Ensino fundamental
  c) Ensino médio
  d) Ensino técnico
  e) Graduação
  f) Especialização (Pós-graduação lato sensu)
  g) Mestrado
  h) Doutorado
3. Qual a diferença entre licenciatura e bacharelado?
4. O que é necessário para a habilitação profissional do professor no seu Estado/País?
5. O que é formação continuada e qual a sua importância para os professores?
6. Entrevistar um professor com as seguintes perguntas:
  a) Por que decidiu tornar-se professor?
  b) Que parte do magistério mais lhe agrada?
  c) Que parte do magistério menos lhe agrada?
  d) Que tipos de preparativos faz antes de começar o ano letivo?
  e) Que tipo de preparativos faz antes de um dia de aula?
  f) Que atividades relacionadas ao seu trabalho você faz após o horário de trabalho?
  g) Quais algumas qualidades de um bom professor?
  h) Quais as responsabilidades e deveres de um professor?
7. Pesquisar na Bíblia e no livro Educação os métodos de ensino que Jesus usava. Apresentar os resultados dessa pesquisa num relatório escrito de, no mínimo, 1 página ou oral de, no mínimo, 10 minutos.
8. Cumprir 3 dos seguintes:
  a) Ajudar um professor, durante o período mínimo de um mês:
    • Planejar materiais audiovisuais para o ensino de um conteúdo na sala de aula.
    • Preparar o plano de aula.
    • Ensinar, pelo menos, um aspecto de um determinado tópico a uma criança ou a uma classe inteira.
  b) Ensinar uma classe de Escola Sabatina ? crianças ou adultos ? durante, no mínimo, 1 trimestre.
  c) Ensinar 2 especialidades a um grupo de desbravadores. Para as especialidades preparar:
    • Plano de aula
    • Materiais didáticos
    • Avaliação.
  d) Ser instrutor ativo de uma classe regular. Preparar:
    • Planejamento de instruções
    • Plano de aula para todos os requisitos
    • Material didático
  e) Ser professor de Educação Infantil, Ensino Fundamental, Ensino Médio, Ensino Técnico ou Ensino Superior por, no mínimo, 6 meses.
9. Realizar uma apresentação em seu clube ou unidade sobre estratégias para o ensino virtual (online) para adolescentes e/ou crianças.'),
('AP-025', 'Corte e Costura - avançado', 'atividades-profissionais', 'especialidade', 3, 1956, 'Associação Geral', '/esp/ap-025.webp', 'https://mda.wiki.br/Especialidade_de_Corte_e_Costura_-_avançado', '1. Ter a especialidade em Corte e costura.
2. Explicar como fazer, pelo menos, 4 tipos das alterações a seguir:
  a) Encurtar o corpo
  b) Aumentar o comprimento do corpo
  c) Aumentar a manga
  d) Tamanho da cintura
  e) Aumentar ou diminuir o comprimento de saia ou calça
  f) Encurtar barra de calça
3. Selecionar, a partir de fotos de revistas ou desenhar, uma roupa para si mesmo que demonstre harmonia de cores e que combine com seu tipo físico.
4. Demonstrar como pregar um zíper invisível.
5. Saber como combinar o tipo de decido com o modelo da roupa.
6. Fazer uma casa de botão à máquina.
7. Fazer uma camisa com manga e gola.
8. Fazer uma calça ou shorts com bom caimento.
9. Fazer um dos seguintes:
  a) Saia godé com barra
  b) Blazer
  c) Saia de prega
10. Fazer um uniforme de gala completo, de acordo com o Regulamento de Uniformes do Ministério Jovem da Divisão Sul Americana.'),
('AP-026', 'Radioamadorismo - avançado', 'atividades-profissionais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ap-026.webp', 'https://mda.wiki.br/Especialidade_de_Radioamadorismo_-_avançado', '1. Ter a especialidade de Radioamadorismo.
2. Ter a especialidade de Código Morse.
3. Ter a licença de Radioamadorismo Classe C.'),
('AP-027', 'Mecânica Automotiva - avançado', 'atividades-profissionais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ap-027.webp', 'https://mda.wiki.br/Especialidade_de_Mecânica_Automotiva_-_avançado', '1. Ter a especialidade de Mecânica automotiva.
2. Desmontar, verificar e montar outra vez um motor de automóvel, ou de um pequeno caminhão. Substituir quaisquer peças que apresentem defeito ou desgaste. Recolocar o motor no lugar, dar partida e dirigir o veículo. Manter um relato completo de tudo que foi feito no motor.
3. Remover e substituir um sistema de transmissão manual ou automático.
4. Reconstruir o sistema de freios de um automóvel ou pequeno caminhão, seguindo as medidas de segurança adequadas. Demonstrar o ajuste adequado de freios.
5. Regular o motor, incluindo a troca de velas, se for o caso.'),
('AP-028', 'Mecânica de Pequenos Motores', 'atividades-profissionais', 'especialidade', 2, 1975, 'Associação Geral', '/esp/ap-028.webp', 'https://mda.wiki.br/Especialidade_de_Mecânica_de_Pequenos_Motores', '1. Descrever o projeto e operação do motor 2 tempos e do motor 4 tempos.
2. Nomear as peças do motor de 2 tempos e dizer para que serve cada parte.
3. Listar os tipos de combustível utilizados em pequenos motores e explicar seu funcionamento.
4. Mostrar os cuidados de segurança no manuseio e armazenamento do combustível.
5. Descrever 2 tipos de sistema de ignição.
6. Listar 2 fluidos de limpeza aceitáveis para os pequenos motores. Por que a gasolina é um fluido de limpeza impróprio?
7. Listar e contar como 3 sistemas de lubrificação básicos operam.
8. Listar, por ordem, os procedimentos adequados para a resolução de problemas em geral.
9. Demonstrar como rever, limpar, inspecionar, montar e ajustar adequadamente qualquer pequeno motor.
10. Demonstrar como testar e limpar velas e velas de incandescência.'),
('AP-029', 'Cães - Cuidado e Treinamento', 'atividades-profissionais', 'especialidade', 1, 1976, 'Associação Geral', '/esp/ap-029.webp', 'https://mda.wiki.br/Especialidade_de_Cães_-_Cuidado_e_Treinamento', '1. Descrever os cuidados necessários para a adoção de um cão. Explicar o seguinte:
  a) Como selecionar um cão (o que é necessário para uma escolha responsável)
  b) Registro (para cães de canil, "pedigree")
  c) Cuidados veterinários/vermifugação/vacinação
2. Fazer, pelo menos, 2 dos seguintes:
  a) Descrever o que pode ser feito para remover ectoparasitas (pulgas, carrapatos e outros) de seu cão.
  b) Mencionar algumas doenças, pragas e pestes que os cães podem adquirir.
  c) Explicar o que você deve fazer após uma mordida de cão.
3. Descrever as maneiras de como educar um filhote (necessidades fisiológicas, destruição de objetos).
4. Explicar em detalhes como se deve dar banho em um cão e quais os cuidados gerais para sua higiene.
5. Assumir a responsabilidade e compromisso de alimentar e dar água a um cão durante o período de, pelo menos, duas semana.
6. Treinar seu cão até que vocês possam demonstrar com sucesso o seguinte*:
  a) Junto: Seu cão deve andar ao seu lado esquerdo e sentar quando você parar. Seu cão deve ficar sentado sem interesses alheios (pessoas, outros animais e alimentos em gerais).
  b) Parado para exame: Seu cão deve permitir que juízes e médicos o toquem.
  c) Chamado: Seu cão vem quando chamado (pelo nome), senta-se diretamente à sua frente e se move para seu lado esquerdo ao comando de junto.
  d) Ficar: o cão fica sentado ou deitado por tempo indeterminado, saindo somente sob comando.'),
('AP-030', 'Serviço Rádio do Cidadão', 'atividades-profissionais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ap-030.webp', 'https://mda.wiki.br/Especialidade_de_Serviço_Rádio_do_Cidadão', '1. Onde e com que finalidade foi criado o Serviço Rádio do Cidadão (ou PX)?
2. Estar familiarizado com os requisitos para obter a licença de operador de estação PX.
3. Conhecer as frequências superiores e inferiores de rádios de AF/HF (Alta Frequência) e UAF/UHF (Ultra Alta Frequência) de PX. Conhecer as seguintes frequências:
  a) Canais de emergência (AF e UAF)
  b) Canais de rodovia
  c) Canais de chamada e escuta (AF, AM, SSB e UAF)
  d) Chamada de emergência marítima
4. Conhecer a função dos seguintes controles:
  a) Seletor de canais
  b) Volume
  c) Ganho (amplificador) de RF
  d) Squelch (atenuador/silenciador)
  e) Chave de filtro NB
5. Instalar corretamente um Serviço Rádio do Cidadão fixo ou móvel, incluindo a antena.
6. O que é Código Fonético Internacional e qual sua importância para os operadores PX? Citar de memória 15 termos desse código, dentre os mais utilizados.
7. Demonstrar habilidade em responder corretamente a uma chamada e transmissão PX, por AF ou UAF, utilizando o código fonético internacional.'),
('AP-031', 'Soldagem', 'atividades-profissionais', 'especialidade', 2, 1978, 'Associação Geral', '/esp/ap-031.webp', 'https://mda.wiki.br/Especialidade_de_Soldagem', '1. Definir o que é soldagem e qual a diferença entre soldagem e soldadura?
2. Conhecer os equipamentos de proteção (EPIs) necessários e explicar sua utilidade
3. Identificar todos os itens a seguir:
  a) Tochas de solda e corte
  b) Sobre os gases Oxigênio e Acetileno identificar e explicar suas diferenças:
    • Válvulas reguladoras
    • Mangueiras e explicar suas diferenças
    • Tanques
4. O que é brasagem? Onde essa técnica é mais utilizada atualmente?
5. Quais as vantagens de uma solda feita corretamente?
6. Explicar os processos de cada uma das seguintes soldas:
  a) Mig-Mag
  b) Tig
  c) Plasma
  d) Arco manual
  e) Oxicombustivel
  f) Arco com arame tubular
  g) Eletrodo
7. Como podem ser divididas as várias áreas da solda?
8. Demonstrar como utilizar um processo de solda Oxiacetileno, incluindo tanques, válvulas, mangueiras e troca de canetas (solda e corte). Acender o maçarico utilizando óculos escuros de proteção (é como estar de olhos vendados).
9. Com ajuda de seu instrutor, utilizando o processo de sua escolha, soldar duas chapas de aço ou metal, com medidas de 250 X 200 X 3 mm, na horizontal, vertical (subindo e descendo) e na superfície (por cima e por baixo [sobre-cabeça]).
10. Demonstrar sua habilidade com o maçarico executando os seguintes cortes:
  a) Em linha reta, pelo menos, 300 mm
  b) Circular com, pelo menos, 50 mm de raio
  c) Uma estrela de seis pontas com 50 mm de raio
  • Obs.: Os cortes devem ser feitos numa chapa de aço ou metal de 6 mm ou 1/4 de espessura, podendo utilizar equipamentos como régua, cinzel e etc.
11. Demonstrar habilidade para soldar ferro fundido, unindo 2 objetos chanfrados com um comprimento mínimo de 50 mm de solda, utilizando o processo de sua escolha.
12. Explicar as precauções, cuidados e armazenamento dos processos de soldagem:
  a) Eletrodos e varetas de solda
  b) Alicates e cabos de solda
  c) Tochas e canetas de solda e ou corte
  d) Válvulas reguladoras e válvulas de segurança. Em especial, por que as mesmas não devem ser lubrificadas?
13. Explicar a diferença entre as soldagens de oxiacetileno e de arco elétrico.
14. Demonstrar habilidade em selecionar um eletrodo e adequar a amperagem para vários tipos e espessuras de metal.'),
('AP-032', 'Produção de Vídeo', 'atividades-profissionais', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/ap-032.webp', 'https://mda.wiki.br/Especialidade_de_Produção_de_Vídeo', '1. Saber quais são os tipos de fitas videos disponíveis atualmente. Saber diferenciar as fitas VHS, miniDV, super8e H18.
2. Identificar as seguintes partes de uma câmera de vídeo e saber como usá-las:
  a) Visor
  b) Botão de gravação
  c) Lentes
  d) Botão de zoom
  e) Botão de ligar e desligar
  f) Foco manual e anéis de zoom
  g) Compartimento para colocar a fita, dvd ou cartão de memória
3. Identificar os símbolos do menu da filmadora.
4. Identificar e trocar a bateria da filmadora. Saber o momento de recarregar a bateria e como fazê-lo. Quais os procedimentos para que uma bateria de níquel-cádmio dure o máximo possível e quais os cuidados que devemos ter com baterias quando descartadas?
5. Identificar outras fontes de energia de uma câmera de vídeo.
6. Fazer uma filmagem de uma reportagem do seu clube ou igreja de 5 minutos e depois assisti-la com seu instrutor. Discutir sobre sua técnica, incluindo pontos a seguir e corrigindo erros, se necessário:
  a) Zoom
  b) Iluminação
  c) Movimento panorâmico
  d) Firmeza da câmera
7. Saber utilizar um tripé em diferentes tipos de relevo.
8. Editar sua reportagem do item 6 usando um programa de computador ou celular.
9. Saber como fazer legendas. Criar sua própria legenda e usá-la em sua reportagem do item 6.
10. Completar um dos projetos a seguir e apresentá-lo num local público. A duração do vídeo deve ser de 4 a 7 minutos.
  a) Parábola
  b) Vídeo clipe (musical)
  c) História da Bíblia (teatro, fantoches, etc.)
  d) Natureza
  e) Dilemas da vida moderna
  f) Comercial para um programa ou publicação da igreja, etc.
11. Ter o conhecimento dos equipamentos necessários, programas para computador e quantidade de pessoas envolvidas para a transmissão de um culto ao vivo em um telão.'),
('AP-033', 'Vendas', 'atividades-profissionais', 'especialidade', 2, 2001, 'Associação Geral', '/esp/ap-033.webp', 'https://mda.wiki.br/Especialidade_de_Vendas', '1. Explicar as responsabilidades de um vendedor cristão em relação à maneira como trata seus clientes e seu chefe.
2. Relacionar os passos envolvidos numa venda.
3. Explicar como enfrentar objeções.
4. De que maneira os itens a seguir são úteis a um vendedor:
  a) Pesquisa de mercado para checar a aceitação do produto a ser negociado
  b) Treinamento e conhecimento sobre o produto ou serviço a ser vendido
  c) Uma visita à fábrica ou escritório sede da empresa que fabrica o produto ou oferece o serviço
  d) Visitas subsequentes a clientes novos
5. Usando informações reais ou hipotéticas sobre formação e experiência, escrever um currículo indicado para quem tem interesse em conseguir um emprego na área de vendas.
6. Descobrir que formação é mais indicada para uma carreira em vendas. Que aspectos da área de vendas estão disponíveis ao vendedor cristão?
7. Concluir um dos seguintes:
  a) Ajudar a levantar fundos através de algum tipo de venda para alguma atividade dos Desbravadores, Ministério Jovem, ou sua escola.
  b) Ganhar seu próprio dinheiro vendendo um produto ou serviço
8. Fazer uma apresentação prática de vendas a seu instrutor sobre o produto ou serviço escolhido no cumprimento do requisito anterior.
9. Entrevistar um vendedor e um comerciante cristãos fazendo as seguintes perguntas:
  • Para o Vendedor
    1. É preciso viajar muito na profissão de vendedor?
    2. De que maneiras o trabalho de vendedor afeta sua vida familiar?
    3. Como os vendedores são pagos?
    4. Que oportunidades de crescimento há na área de vendas?
    5. Que futuro há na carreira de vendedor?
    6. Como você consegue clientes?
    7. O que mais lhe agrada em seu trabalho? O que menos lhe agrada?
    8. Ser cristão faz diferença na forma como faz o seu trabalho?
  • Para o comerciante
    1. Que tipo de formação e treinamento pode ajudar na carreira de comerciante?
    2. Que oportunidades de crescimento existem no comércio?
    3. Quando você faz um pedido, em que se baseia mais, no serviço do vendedor, no preço, características do mercado ou qualidade do produto?
    4. O que faz quando um cliente reclama de um erro que, na opinião dele, sua loja cometeu, quando, na verdade, ele é o culpado?
    5. O que mais lhe agrada em seu trabalho? O que menos lhe agrada?'),
('AP-034', 'Internet', 'atividades-profissionais', 'especialidade', 2, 2007, 'Divisão Norte Americana', '/esp/ap-034.webp', 'https://mda.wiki.br/Especialidade_de_Internet', '1. Definir os seguintes termos:
  a) Internet
  b) World Wide Web (www)
  c) Download
  d) Upload
  e) Website ou site
  f) E-mail
  g) Vírus
2. Definir os seguintes termos e dê exemplos de cada um:
  a) Webmail / POP3 / IMAP e-mail
  b) Streaming Media
  c) Site de Busca
  d) Antivírus
3. Completar uma das seguintes atividades:
  a) Escrever uma breve história da internet com 250 a 300 palavras
  b) Fazer uma apresentação no clube, igreja ou escola de 2 a 3 minutos sobre a história da internet
4. Qual a importância do antivírus? Incluir na sua resposta:
  a) Alguns exemplos de como seu computador pode receber vírus através da internet;
  b) A importância de manter seu antivírus sempre atualizado;
  c) Como um vírus é compartilhado a partir de um computador sem antivírus;
  d) Quais prejuízos um vírus pode fazer no seu computador ou de outras pessoas.
5. De que forma os filtros de conteúdo podem proteger a sua família? Com sua família, desenvolver e assinar um pacto de uso da internet, incluindo os seguintes elementos:
  a) Nunca revelar informações pessoais
  b) Lembrar-se que as pessoas podem não ser o que dizem ser
  c) Nunca se encontrar com um amigo virtual pela primeira vez sem a presença dos pais ou responsável
  d) Nunca responder a chamadas de desconhecidos
  e) Parar imediatamente se perceber alguma coisa fora do normal
  f) Estabelecer um tempo para cada membro da família usar a internet por semana.
  g) Tipos de sites que são aceitáveis/inaceitáveis para ver. Quais são os princípios que sua família vai usar para determinar o que são aceitáveis?
  h) Quais as redes sociais mais conhecidas atualmente? Escolher no máximo 2 que serão usadas controladamente
  i) Definir qual sera o máximo de minutos por dia a ser usado em redes sociais.
6. Demonstrar a sua capacidade para navegar na internet e cumprir os seguintes requisitos:
  a) Visitar 3 sites diferentes e mostrar a primeira página de cada site para o seu instrutor
  b) Usar um site de busca para encontrar um site de Bíblia on-line. Ir ao site, procurar pelo menos 3 diferentes textos da Bíblia em três versões diferentes e mostrar seus resultados para o seu instrutor.
  c) Fazer download de um arquivo
7. Demonstrar sua capacidade de usar e-mail e cumprir os seguintes requisitos:
  a) Escrever e enviar um e-mail
  b) Receber e abrir um e-mail
  c) Fazer download de um anexo no e-mail e abri-lo
  d) Conhecer princípios de segurança ao se enviar e receber/abrir e-mails
8. Memorize Filipenses 4:8. Como este texto bíblico orienta o cristão a usar a internet?'),
('AP-035', 'Internet - avançado', 'atividades-profissionais', 'especialidade', 3, null, 'Divisão Norte Americana', '/esp/ap-035.webp', 'https://mda.wiki.br/Especialidade_de_Internet_-_avançado', '1. Ter a especialidade de Especialidade de Internet.
2. Definir os seguintes termos (ou seus equivalentes) e informar quando e como eles são usados:
  a) HTTP
  b) Hyperlink
  c) HTML/PHP
  d) Navegadores seguros e códigos de cores hexadecimals
  e) URL
  f) GIF/PNG
  g) JPEG
3. Aprender e demonstrar o uso dessas TAG''s HTML ou demonstrar comandos equivalentes de construção de sites em uma das linguagens atuais de desenvolvimento de sites (PHP, XML JSP, ASP, etc.).
  a) <html> </html>
  b) <head> </head>
  c) <body> </body>
  d) <b> </b>
  e) <i> </i>
  f) <a href="URL"> </a>
  g) <p>
  h) <br> </br>
  i) <img src="name"/>
  j) <hr> </hr>
  k) <table> </table>
  l) <tr> </tr>
  m) <td></td>
4. Fazer uma tabela simples - incluir texto, um gráfico, uma regra horizontal e um link. Usar códigos hexadecimais para colorir o texto. Fazer o seu título maior e, depois, o texto do documento principal.
5. Saber mais sobre:
  a) Gráficos para a Web e ser capaz de explicar o processo utilizado para baixá-los rapidamente.
  b) Cores seguras da WEB e saber quando usá-las. Usar esse conhecimento para criar um JPG e um GIF/ PNG que estão ambos sob 15k, mas que ainda são facilmente visíveis em um site e criar, pelo menos, 5 botões de navegação gráfica e um header para o seu site.
6. Desenvolver um site. Todas as páginas do site devem ser interligadas, para que alguém que visitar sua homepage possa clicar em cada uma das outras páginas do seu site. O web-site deve ser composto de, pelo menos, 4 páginas. O site deve incluir:
  a) Página de boas-vindas, que indica a razão para que o site foi criado e incluir, pelo menos, uma imagem ou fotografia.
  b) Uma página de fotos que mostra as atividades e eventos que você, sua família, ou grupo têm desfrutado.
  c) Um livro de visitas ou página de contato, onde as pessoas podem assinar comprovando que elas visitaram ou deixar um endereço de e-mail de contato, para que as pessoas possam enviar e-mails quando elas visitarem seu site.
7. O que é inteligência artificial: Quais são os benefícios e os problemas do uso de IA?
8. Produzir utilizando a inteligência artificial:
  a) Texto sobre a importância do Clube de Desbravadores
  b) Uma imagem do seu clube de desbravadores acampando
  c) Um logo usando o nome do seu clube'),
('AP-036', 'Silvicultura', 'atividades-profissionais', 'especialidade', 2, 2008, 'Divisão Norte Americana', '/esp/ap-036.webp', 'https://mda.wiki.br/Especialidade_de_Silvicultura', '1. Ter a especialidade de Arvores (EN 006).
2. O que é silvicultura?
3. Aprender o uso apropriado dos seguintes instrumentos florestais e praticar usando-os em árvores em uma floresta. Registrar as informações e o nome popular de cada árvore.
  a) Fita diamétrica - medir o DAP (diâmetro na altura do peito) das árvores [ou medir a CAP (circunferéncia na altura do peito) das árvores e calcular o diâmetro]
  b) Hipsômetro ou clinômetro ? medir a altura das árvores
4. Saber o que é verruma ou trado (increment borer) e para o que serve. Saber como funciona a determinação da idade da árvore pela contagem do número de anéis de crescimento. Por que esta técnica não é recomendada para árvores de regiões tropicais?
5. Usar as informações coletadas no requisito 3 para determinar o volume em cm3 das árvores da floresta que você mediu.
6. Calcular a área basal de uma árvore a partir da medição do diâmetro (DAP) ou da circunferência (CAP). Saber o que é área basal por hectare e que instrumentos podem ser utilizados para estimá-la.
7. Estudar cinco espécies de árvore importantes para a silvicultura em sua área e dar as seguintes informações sobre cada:
  a) Nome comum e nome científico
  b) Área de distribuição da árvore
  c) Altura e diâmetro da árvore na idade adulta
  d) Uso comum e importância da árvore
  e) Habitat da árvore e altitude
8. Listar os benefícios da floresta para o meio ambiente, qualidade da água, qualidade do ar, animais selvagens e recreação.
9. Listar os usos da madeira produzida nas florestas de sua área e citar, pelo menos, duas espécies que são importantes para cada uso?
10. Descobrir e discutir o seguinte:
  a) Como as florestas são manejadas para reduzir os danos por insetos e doenças?
  b) Que fatores influenciam o comportamento do fogo?
  c) Considerando que incêndios produzem tanto benefícios quanto destruição, que tratamentos podem reduzir a gravidade dos incêndios?
11. Fazer um dos seguintes em uma regeneração florestal:
  a) Visitar um viveiro de mudas florestais
  b) Fazer um plantio de mudas florestais ou sementes florestais'),
('AP-037', 'Administração', 'atividades-profissionais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ap-037.webp', 'https://mda.wiki.br/Especialidade_de_Administração', '1. Definir administração e qual a sua importância nos aspectos da vida humana.
2. Definir os seguintes elementos da administração:
  a) Previsão
  b) Organização
  c) Comando
  d) Coordenação
  e) Controle
3. Diferenciar eficiência de eficácia.
4. Segundo a teoria da motivação humana de Maslow, as necessidades humanas estão organizadas e dispostas em níveis, numa hierarquia de importância e de influência. Explicar essas necessidades, também conhecidas como Pirâmide de Maslow.
5. A liderança está presente em muitos momentos de nossa vida. Fazer um texto (de 20 a 40 linhas) descrevendo a importância da liderança na administração.
6. Fazer um organograma do funcionamento do Clube de Desbravadores, em todos os seus níveis, destacando o seu Clube.
7. Definir planejamento e sua importância dentro do Clube de Desbravadores
8. Elaborar o planejamento anual das atividades do seu Clube, inclusive o planejamento das Classes Regulares e Avançadas, contendo metas, estratégias, planos de ação e formas de controle das etapas do planejamento. Executar esse planejamento por, pelo menos, 3 meses.
9. Definir método MASP e discorra sobre a importância da constante análise dos problemas que enfrentamos no Clube e a busca por soluções.
10. Encontrar uma história bíblica que mostre a importância da administração.'),
('AP-038', 'Bandeiras Náuticas', 'atividades-profissionais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ap-038.webp', 'https://mda.wiki.br/Especialidade_de_Bandeiras_Náuticas', '1. Por que existe, para que serve e onde é usado o Código Internacional de Bandeiras Náuticas?
2. Saber o significado de galhardete.
3. Usando desenhos ou fotografias, fazer um quadro exibindo as bandeiras náuticas, com seus respectivos significados alfabéticos e numéricos, bem como a mensagem que a bandeira transmite quando usada isoladamente.
4. Definir 10 exemplos de combinações das bandeiras náuticas.
5. Identificar as 4 cornetas substitutas e explicar o seu uso.
6. Com 2 grupos, manter um diálogo utilizando bandeiras náuticas, explorando seus significados singulares e somatórios, com uma distância mínima de 300 metros entre os grupos.'),
('AP-039', 'Blogs', 'atividades-profissionais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ap-039.webp', 'https://mda.wiki.br/Especialidade_de_Blogs', '1. Ter a especialidade de Internet.
2. Explicar a diferença entre um site e um blog.
3. Quais os principais sistemas gratuitos de blogs disponíveis e quais as diferenças entre eles?
4. Explicar os termos abaixo
  a) Domínio
  b) Diferenças entre .org; .com; .net; .edu; .gov; .br
  c) Hospedagem
  d) Código HTML
  e) Incorporação
  f) Servidor
  g) Upload
  h) Download
5. Criar um blog (pode ser da unidade, Clube, Igreja ou pessoal com informações sobre desbravadores ou sobre a Igreja Adventista do Sétimo Dia) e atualizá-lo, no mínimo, 2 vezes por semana durante, pelo menos, 3 meses, O instrutor deve acompanhar as postagens, para certificar se estão condizentes com a filosofia adventista.
6. Demonstrar, no blog, maneiras de fazer upload de imagens e arquivos, incorporação de vídeos, adicionar links para os sites http://desbravadores.org.br/ e http://www.esperanca.com.br/ e/ou seus equivalentes em espanhol.
7. Qual o cuidado (em relação a direitos autorais e sites não confiáveis) que deve-se ter ao copiar conteúdos da internet em seu blog?'),
('AP-040', 'Biblioteconomia', 'atividades-profissionais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ap-040.webp', 'https://mda.wiki.br/Especialidade_de_Biblioteconomia', '1. O que é biblioteconomia?
2. Qual é o papel do profissional bibliotecário?
3. Definir os processos abaixo:
  a) Empréstimo
  b) Devolução
  c) Tombamento
4. Conhecer as partes fundamentais de um livro.
5. Saiba qual é o critério usado para dividir os livros dentro de uma biblioteca.
6. Visitar duas ou mais bibliotecas e descobrir:
  a) Como é feita a pesquisa de assuntos em livros
  b) Como são desenvolvidos os processos de organização de livros
  c) Como são complementadas as pesquisas com auxílio da internet.
7. Saber onde conseguir livros novos e usados.
8. Apresentar uma lista de 5 indicações de livros em cada uma das seguintes categorias e registrar as informações catalográficas de cada livro.
  a) Livros Religiosos
  b) Literatura Infantil
  c) Literatura Jovem
  d) Livros Científicos
9. De acordo com as normas técnicas de seu país (ou normas internacionais), citar as referências bibliográficas de 2 exemplos de cada um dos seguintes:
  a) Livros
  b) Revistas
  c) Páginas da internet
  d) Dicionário
10. O que é biblioteca digital?
11. Desenvolver e acompanhar um projeto de leitura em seu Clube/Unidade e avaliar os resultados.
12. Fazer uma campanha de arrecadação de livros e criar ou auxiliar no aumento do acervo de uma biblioteca para seu Clube. Nesta biblioteca deve conter, no mínimo:
  a) 10 livros científicos ou de conhecimentos gerais
  b) 10 revistas
  c) 2 manuais de desbravadores
  d) 10 livros do Espirito de Profecia
  e) 5 livros úteis no cumprimento de classes e/ou especialidades
  f) 10 sobre outros temas que achar interessante'),
('AP-041', 'Computação I - básico', 'atividades-profissionais', 'especialidade', 1, 1986, 'Associação Geral', '/esp/ap-041.webp', 'https://mda.wiki.br/Especialidade_de_Computação_I_-_básico', '1. Pesquisar a história dos computadores e escrever um relatório de, pelo menos, 250 palavras com os resultados da pesquisa.
2. Definir os seguintes termos:
  a) Hardware;
  b) Software;
  c) Sistema operacional;
  d) Driver;
  e) Disco rígido (HD) e SSD;
  f) Memória RAM;
  g) Memória ROM.
3. Apresentar ao examinador:
  a) Como proteger seu computador da sujeira;
  b) O que é manutenção preventiva do computador?;
  c) Saber ligar e desligar corretamente um computador
4. Descrever a função dos seguintes equipamentos:
  a) Teclado;
  b) Mouse;
  c) Monitor;
  d) Impressora;
  e) Scanner;
  f) CPU;
  g) Cabos;
  h) Modem;
  i) Roteador.
5. Demonstrar o seguinte:
  a) Criar uma pasta na área de trabalho e renomeá-la;
  b) Copiar uma pasta de um local para outro;
  c) Mover uma pasta de um local para outro;
  d) Criar um atalho de um arquivo ou pasta;
  e) Excluir um arquivo e esvaziar a lixeira;
  f) Organizar os arquivos em uma pasta por nome, data de modificação e tamanho.'),
('AP-042', 'Computação II - médio', 'atividades-profissionais', 'especialidade', 2, 1991, 'Associação Geral', '/esp/ap-042.webp', 'https://mda.wiki.br/Especialidade_de_Computação_II_-_médio', '1. Ter a especialidade de Computação I
2. Definir os seguintes termos:
  a) Netbook;
  b) Notebook;
  c) Micromputador;
  d) Tablet;
  e) Smartphone;
  f) Servidor.
3. Utilizando um software editor de texto, escrever um texto usando os recursos de formatação disponíveis. Demonstrar como:
  a) Ajustar as margens, o tamanho e a orientação do papel;
  b) Copiar e colar textos;
  c) Alterar a fonte e o tamanho da fonte;
  d) Usar negrito, itálico e sublinhado;
  e) Alinhar o texto (esquerda, centralizado, direita e justificado);
  f) Ajustar o espaçamento do parágrafo;
  g) Utilizar marcadores e numeração.
4. Ao escolher um computador para se comprar, é importante estar atento a algumas informações. Saber como avaliar as informações abaixo:
  a) Quantidade de memória;
  b) HD ou SSD;
  c) Tipo de processador;
  d) Velocidade do processador;
  e) Tipo de monitor.
5. Como proteger o computador de oscilações de energia?
6. Demonstrar o seguinte:
  a) Comprimir e descomprimir arquivos;
  b) Salvar um arquivo de texto, planilha ou apresentação em pdf;
  c) Instalar e desinstalar um software;
  d) Imprimir um documento, sabendo utilizar corretamente a quantidade de cópias, agrupamento, qualidade da impressão, ajustar o tamanho e modo múltiplo.'),
('AP-043', 'Computação III - regular', 'atividades-profissionais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ap-043.webp', 'https://mda.wiki.br/Especialidade_de_Computação_III_-_regular', '1. Ter a especialidade de Computação II.
2. Definir os seguintes termos:
  a) Placa mãe;
  b) Placa de vídeo;
  c) Placa de som;
  d) Porta VGA e HDMI;
  e) Porta USB;
  f) Fonte de alimentação;
  g) Banco de dados.
3. O que significa backup e por que é importante fazê-lo? Citar algumas formas de como se fazia backup no passado e atualmente.
4. Utilizando um software editor de texto, escrever um texto usando os recursos de formatação disponíveis. Demonstrar como:
  a) Inserir uma tabela e saber adicionar e excluir colunas e linhas, bem como formatá-las;
  b) Inserir uma imagem e saber ajustá-la ao texto;
  c) Inserir cabeçalho e rodapé e saber editá-los;
  d) Inserir numeração de páginas.
5. Utilizando um software editor de planilha eletrônica, fazer uma planilha usando os recursos de formatação disponíveis. Exemplos de opções de planilhas: orçamento familiar, planejamento de atividades, acompanhamento de trabalhos/instruções. Demonstrar como:
  a) Ajustar o tamanho das linhas e colunas;
  b) Alinhar o texto à célula (acima, meio, abaixo; esquerda, centralizar, direita);
  c) Mesclar células e desfazer mesclagem de células;
  d) Inserir e excluir linhas e colunas;
  e) Formatar o layout da tabela (de forma automática e manual);
  f) Utilizar as funções soma e média.
6. O que significa compatibilidade de equipamentos e versões?
7. Como os computadores podem estar conectados num escritório ou empresa? Quais os tipos de redes existentes?
8. Demonstrar o seguinte:
  a) Consultar as informações técnicas do computador (memória, armazenamento, processador, sistema operacional, etc.);
  b) Consultar os detalhes de um arquivo;
  c) Adicionar itens à área de trabalho;
  d) Fazer um print da tela;
  e) Ajustar a data e a hora do computador.'),
('AP-044', 'Computação IV - avançado', 'atividades-profissionais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ap-044.webp', 'https://mda.wiki.br/Especialidade_de_Computação_IV_-_avançado', '1. Ter a especialidade de Computação III.
2. Definir os seguintes termos:
  a) Bit;
  b) Kilobyte;
  c) Megabyte;
  d) Gigabyte;
  e) Terabyte.
3. O que são vírus e como podemos nos proteger deles?
4. O que é a internet e como ela influencia a vida moderna?
5. Acessar e descrever o conteúdo de cinco sites da internet com conteúdo educativo.
6. Montar um banco de dados para cadastrar, em forma de uma agenda, o nome de, no mínimo, 25 pessoas, contendo nome, endereço, telefone e e-mail de cada uma delas.
7. Utilizando um software editor de texto, escrever um texto usando os recursos de formatação disponíveis. Demonstrar como:
  a) Utilizar e formatar estilos para títulos, ênfase e citação;
  b) Colar um texto mantendo a formatação original;
  c) Colar um texto usando a formatação do destino;
  d) Utilizar sobrescrito e subscrito;
  e) Destacar textos com cores;
  f) Alternar maiúsculas e minúsculas;
  g) Fazer colunas;
  h) Inserir uma nota de rodapé;
  i) Criar um sumário.
8. Utilizando um software editor de planilha eletrônica, fazer uma planilha usando os recursos de formatação disponíveis. Demonstrar como:
  a) Criar e usar filtros;
  b) Congelar linhas/colunas;
  c) Criar um gráfico.
9. Utilizando um software editor de apresentações, fazer uma apresentação usando os recursos de formatação disponíveis. Demonstrar como:
  a) Criar uma apresentação com base em um modelo (template);
  b) Alterar o layout do slide;
  c) Criar, duplicar, reorganizar e excluir slides;
  d) Inserir imagens e organizá-las adequadamente no slide;
  e) Inserir um vídeo;
  f) Inserir um áudio;
  g) Salvar a apresentação em formato pdf.
10. Citar uma ou duas opções de softwares atuais para as seguintes funções:
  a) Editores de texto;
  b) Planilhas eletrônicas;
  c) Banco de dados;
  d) Linguagem de programação;
  e) Editores de imagens;
  f) Editores de vídeo.
11. Escrever um e-mail, demonstrando o seguinte:
  a) Adicionar um destinatário;
  b) Adicionar destinatário em cópia;
  c) Adicionar destinatário em cópia oculta;
  d) Inserir um arquivo;
  e) Personalizar uma assinatura;
  f) Enviar o e-mail;
  g) Arquivar um e-mail;
  h) Responder um e-mail;
  i) Encaminhar um e-mail.
12. Que princípios de segurança devemos ter ao enviar e receber/abrir e-mails.
13. Demonstrar o seguinte:
  a) Fazer uma limpeza de disco e desfragmentação do disco;
  b) Abrir um arquivo usando um software diferente do padrão;
  c) Definir um software padrão para abrir tipos de arquivo;
  d) Definir uma impressora padrão;
  e) Criar um usuário.'),
('AP-045', 'Computação V - especialista', 'atividades-profissionais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ap-045.webp', 'https://mda.wiki.br/Especialidade_de_Computação_V_-_especialista', '1. Ter a especialidade de Computação IV.
2. Apresentar um relatório sobre a evolução da computação nas áreas de inteligência artificial, mundo virtual, internet e intranets de, no mínimo, 350 palavras.
3. Definir os seguintes termos:
  a) Usuário;
  b) Programador;
  c) Analista de sistemas;
  d) Help Desk;
  e) Hacker;
  f) Hiperlink;
  g) World wide web (www).
4. Saber a diferença e aplicação das seguintes impressoras:
  a) Matricial;
  b) Laser;
  c) Plotter;
  d) Jato de tinta.
5. Saber explicar o funcionamento de informações entre periféricos e a CPU, usando o código binário 1 e 0. Montar um diagrama.
6. Pesquisar em sites especializados e apresentar um relatório a respeito do que foi o bug do milênio.
7. O que significa upgrade e update?
8. Citar três sistemas operacionais e suas semelhanças e diferenças.
9. O que é catfishing e como se proteger dele?
10. Ensinar a especialidade de Computação I ou Computação II a um grupo de desbravadores.'),
('AP-046', 'Código Semafórico', 'atividades-profissionais', 'especialidade', 2, 1953, 'Associação Geral', '/esp/ap-046.webp', 'https://mda.wiki.br/Especialidade_de_Código_Semafórico', '1. O que é código semafórico e quais são as características?
2. Pesquisar a história do Código Semafórico, por quem inicialmente usado, o motivo da sua criação e utilização. Escrever um texto de, no mínimo, 200 palavras, com o resultado da pesquisa.
3. Individualmente ou com a sua unidade, completar um dos seguintes itens:
  a) Criar um par de bandeiras tamanho padrão (45 x 45 cm) com duas cores predominantes.
  b) Confeccionar um par de cones de lanterna.
  c) Criar um par de sinalizadores com materiais naturais.
4. Transmitir um dos itens abaixo levando, com no ritmo mínimo de um caractere a cada 5 segundos, tendo uma distância mínima de 100m de um grupo para o outro:
  a) Um verso bíblico
  b) Um dos ideais do Clube de Desbravadores
  c) Um texto (dialogo) surpresa definido pelo instrutor
5. Definir os seguintes sinais:
  a) Atenção
  b) Erro
  c) Numeral
  d) Alfabeto
  e) Pausa
  f) Fim de frase
  g) Fim da mensagem
6. Individualmente ou com a sua unidade, elaborar um quadro criativo mostrando todos os caracteres numerais, alfabéticos e de sinalização.'),
('AP-047', 'Código Morse', 'atividades-profissionais', 'especialidade', 2, 1956, 'Associação Geral', '/esp/ap-047.webp', 'https://mda.wiki.br/Especialidade_de_Código_Morse', '1. O que é código Morse e quais são as suas características?
2. Quais os instrumentos que podem ser usados para a comunicação com Código Morse?
3. Pesquisar como foi criado o código Morse, por quem foi inicialmente usado, o motivo de sua criação e sua utilização. Escrever um texto de, no mínimo, 200 palavras com os resultados da pesquisa.
4. Detalhar a transmissão dos seguintes sinais:
  a) Ponto (.)
  b) Traço (-)
  c) Espaço
  d) SOS
  e) Fim da mensagem
5. Enviar e receber pelo Código Morse Internacional, um texto ou um verso bíblico ao ritmo mínimo de 1 letra a cada 5 segundos, usando uma chave, lanterna, apito, espelho ou buzina. (Mínimo de 10 palavras).
6. Fazer um quadro criativo para a apresentação do Código Morse e seus respectivos caracteres, contendo numerais, alfabeto e pontuação.'),
('AP-048', 'Cuidados e Manutenção de Violões', 'atividades-profissionais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ap-048.webp', 'https://mda.wiki.br/Especialidade_de_Cuidados_e_Manutenção_de_Violões', '1. O que é um luthir? Citar um grande profissional dessa área.
2. Criar um violão ou desmontar e montar um violão, guitarra ou baixo, identificando, separando e informando as funções das seguintes peças:
  a) Tarraxas
  b) Pestana
  c) Rastilho
  d) Cordas
  e) Trastes
  f) Cavalete
  g) Cabeça
  h) Braço
  i) Tróculo
  j) Corpo
  k) Fundo
  l) Tampo dianteiro
  m) Lateral
  n) Abertura
  o) Escala
  p) Capacitor
  q) Elementos decorativos
  • Os quesitos para serem separados são os de "a" a "e"; os outros são opcionais para separação.
3. Saber distinguir tarraxas para cordas de náilon e aço e, em seguida, desmontá-las. limpá-las, lubrificá-las e montá-las.
4. Identificar as cordas pela sua espessura e afiná-las.
5. Saber as matérias-primas da pestana e rastilho. Fazer um rastilho ou pestana.
6. Explicar porque podemos baixar as cordas e saber as precauções para fazer esse procedimento.
7. Que cuidados devem ser tomados para evitar a ferrugem das cordas e de outras peças do violão, guitarra ou baixo?
8. Demonstrar (se possível) e explicar como colar fissuras em um instrumento de cordas, especificando que tipo de cola usar.
9. Como se põe enxertos em um instrumento danificado?
10. Pintar um violão, guitarra ou baixo demonstrando os cuidados com o lixamento, escolha da tinta e secagem.'),
('AP-049', 'Desenvolvimento de Software', 'atividades-profissionais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ap-049.webp', 'https://mda.wiki.br/Especialidade_de_Desenvolvimento_de_Software', '1. Citar o que é um software e quais as suas funcionalidades para o controle e manipulação das informações.
2. Definir linguagem de programação e descobrir a diferença entre programação de alto e baixo nível.
3. Definir os seguintes tipos de estudos de programação:
  a) Programação estruturada
  b) Programação funcional
  c) Programação orientada a objetos
  d) Programação orientada a eventos
4. Definir os termos abaixo:
  a) Código binário
  b) Escopo
  c) Fluxograma
  d) Programação
  e) Base de dados
  f) Compilação
5. Saber quais os principais passos para se criar um software.
6. Descrever o uso da UML para as fases de desenvolvimento de um software.
7. Que técnicas são melhor aplicadas em desenvolvimento ágil? Apresentar um estudo de caso sobre essa técnica.
8. Em quais projetos de desenvolvimento é possível aplicar o RUP e quais são suas fases.'),
('AP-050', 'Eletrônica', 'atividades-profissionais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ap-050.webp', 'https://mda.wiki.br/Especialidade_de_Eletrônica', '1. O que é carga elétrica? Qual é a unidade da carga elétrica?
2. Explicar o que é corrente elétrica e como ela é medida.
3. O que é tensão elétrica e qual a unidade de medida da tensão?
4. Quais são os componentes eletrônicos básicos e qual é a função de cada um deles?
5. Explicar a Lei de Ohm e descrever a relação que há entre tensão, corrente e resistência em um circuito.
6. Qual é a diferença entre circuitos em série e circuitos em paralelo?
7. Explicar o Teorema de Thévenin e como ele pode ser aplicado na analise de circuitos.
8. O que são circuitos RC, RL r RLC? Como eles influenciam o comportamento de um circuito?
9. Explicar o que são filtros passa-baixa e passa-alta e como eles são utilizados em circuitos eletrônicos.
10. Descrever o sistema numérico binário e como ele é utilizado na eletrônica digital.
11. O que são portas logicas e qual é a função de cada uma delas?
12. Explicar a diferença entre circuitos combinacionais e circuitos sequenciais na eletrônica digital.
13. Explicar o funcionamento dos transistores e sua importância na eletrônica. Descrever os diferentes tipos de transistores.
14. O que são diodos e qual é a sua função em um circuito eletrônico?
15. Descrever um exemplo de um aparelho de medição eletrônica, como um multímetro, e explicar sua utilização e importância.
16. Montar um circuito simples de porta lógica AND utilizando componentes eletrônicos. Descrever os materiais necessários e as etapas para a montagem. OBS: Esse requisito pode ser adaptado para ser realizado fisicamente ou em um simulador, dependendo dos recursos disponíveis.'),
('AP-051', 'Intérprete de Língua de Sinais', 'atividades-profissionais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ap-051.webp', 'https://mda.wiki.br/Especialidade_de_Intérprete_de_Língua_de_Sinais', '1. Fazer uma pesquisa sobre a história mundial da comunidade surda, a partir de Pedro Ponce de León, e escrever uma redação de, pelo menos, 350 palavras ou fazer uma apresentação oral de 5 minutos.
2. O que é Classificador? Qual a importância desta estrutura gramatical na língua de sinais?
3. Fazer uma pesquisa sobre a legislação em seu país que trata sobre surdez e/ou língua de sinais. Quais são os direitos e deveres dos surdos contidos nesses documentos legais/normativos?
4. Por que não se deve usar a expressão surdo-mudo, mas apenas surdo?
5. Sobre a profissão de intérprete, pesquisar os seguintes tópicos:
  a) O que é necessário para se tornar um intérprete de língua de sinais?
  b) Quais são as oportunidades de trabalho, em sua região ou Estado?
  c) Quais instituições, em sua região ou Estado, oferecem cursos nesta área?
  d) Existem cursos de graduação e/ou pós-graduação em língua de sinais em seu país? Qual o perfil profissional dos alunos formados nestes cursos?
6. Como funciona a certificação de proficiência na língua de sinais em seu pais? Quais são os critérios para se obter este certificado? Quais as vantagens de se obtê-lo?
7. Cumprir um dos seguintes:
  a) Ser intérprete em sua Igreja, interpretando, pelo menos, 3 vezes ao mês durante, no mínimo, 3 meses.
  b) Trabalhar como intérprete em qualquer instituição ou empresa por, pelo menos, 3 meses.
  c) Atuar como monitor de uma disciplina de língua de sinais por, pelo menos, 3 meses.'),
('AP-052', 'Informática Programável', 'atividades-profissionais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ap-052.webp', 'https://mda.wiki.br/Especialidade_de_Informática_Programável', '1. Pesquisar a história das linguagens de programação e presentar um relatório com os resultados obtidos.
2. Definir Lógica de Programação.
3. Definir e conceituar os seguintes tópicos:
  a) Código fonte
  b) Código de máquina
  c) Compiladores
  d) Interpretadores
  e) Programação Linear
  f) Programação Modular
  g) Programação Estruturada
  h) Programação Orientada a Objetos
  i) Estruturas de tipos
  j) Programação de alto nível
  k) Programação de médio nível
  l) Programação de baixo nível
  m) Quantas gerações de linguagens existem e quais são elas
  n) Linguagem compilada
  o) Linguagem de script
  p) Linguagem interpretada
  q) Paradigma de programação
  r) Sintaxe de linguagens de programação
4. programar um software que possa ser útil para alguma atividade do seu clube, igreja ou região.'),
('AP-053', 'Manutenção de Bicicletas', 'atividades-profissionais', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ap-053.webp', 'https://mda.wiki.br/Especialidade_de_Manutenção_de_Bicicletas', '1. Explicar os tipos de bicicleta para cada situação abaixo
  a) Urbano
  b) Estrada asfaltada
  c) Estrada de terra batida
  d) Praias ou zonas arenosas
2. Identificar e explicar as funções de cada peça a seguir:
  a) Quadro
  b) Roda
  c) Garfo
  d) Guidão
  e) Selim
  f) Corrente
  g) Freio
  h) Pneu
  i) Câmbio dianteiro
  j) Câmbio traseiro
  k) Cassete
  l) Roda
  m) Conduíte flexível ou cabo de aço
  n) Manete do freio
  o) Garfo com amortecedor
  p) Manopla
  q) Mesa
  r) Movimento central
  s) Pedal
  t) Pedivela
  u) Coroa
  v) Cubo da roda
  w) Raio
  x) Canote de selim
  y) Amortecedor
3. Trocar as pastilhas de freio e diferenciar cada modelo de freio baixo:
  a) Espora
  b) V-Blade
  c) Disco
4. Qual a importância de manter os cabos dos freios lubrificados e ajustados?
5. Instalar um sistema de macha em uma bicicleta ou retirar, lubrificar e ajustar em uma que já tenha. Em seguida, explicar o motivo da lubrificação e ajuste.
6. Identificar 3 tipos diferentes de aro e explicar suas diferenças e qualidades para cada tipo de bicicleta e terreno.
7. Enraiar corretamente um aro e alinhá-lo.
8. Demonstrar como encontrar furos na câmara de ar. Colá-los, mostrando o equipamento adequado para tal serviço.
9. Explicar como os amortecedores dianteiro e traseiro de uma bicicleta funciona e relacionar a perda de velocidade devido a eles.
10. Que tipo de óleo deve ser passado nas correntes, catracas e coroas?
11. Existem 2 tipos de pé-de-vela, o com coroa acoplada e o sem coroa. Explicar e demonstrar as diferenças, modo de troca, lubrificação e cuidados para cada tipo.
12. Como a caneta prende o guidão ao garfo? Demonstrar os diferentes tipos de guidão e caneta.
13. Saber o tamanho de bicicleta e altura adequada do banco e guidão para cada pessoa.'),
('AP-054', 'Marketing', 'atividades-profissionais', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ap-054.webp', 'https://mda.wiki.br/Especialidade_de_Marketing', '1. O que é marketing?
2. Como você pode aplicar os conceitos de marketing para alcançar seus objetivos?
3. O que é criatividade e como ela pode te ajudar no dia a dia?
4. Como você pode utilizar sua criatividade para alcançar pessoas para Deus?
5. Faça uma entrevista com um profissional de Comunicação Social (Publicidade e Propaganda). Explicar a ele o funcionamento do Clube de Desbravadores e descubra qual a melhor maneira de divulgar o seu Clube.
6. Desenvolver um planejamento estratégico de marketing para divulgar seu Clube ou Unidade. Neste planejamento deve constar:
  a) Público Alvo
  b) Estratégia de divulgação
  c) Ferramentas necessárias
  d) Objetivos
  e) Prazos
7. Desenvolver um projeto de marketing para angariar fundos para seu Clube sem infringir os princípios básicos da Igreja Adventista do Sétimo Dia.'),
('AP-055', 'Marketing - avançado', 'atividades-profissionais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ap-055.webp', 'https://mda.wiki.br/Especialidade_de_Marketing_-_avançado', '1. Ter a especialidade de Marketing.
2. Explique as seguintes fases do processo criativo:
  a) Percepção do problema
  b) Teorização do problema
  c) Produzira solução
3. O que é Brainstorming? Como podemos utilizá-lo no Clube de Desbravadores?
4. Pesquisar e fazer um relatório sobre os 4 P?s do composto de marketing e explicar como eles podem ser adaptados para uso no seu Clube de Desbravadores.
5. Conhecer algumas técnicas de posicionamento e estratégia de marketing como:
  a) Swot
  b) Forças de Porter
  c) Matriz BCG
  d) Outras que julgar interessante
6. Utilizar sua criatividade para produzir uma apresentação do seu Clube para seu bairro. Utilizar nesta apresentação, pelo menos, 2 dos recursos abaixo:
  a) Vídeo ou vinheta
  b) Site
  c) Música ou poema
  d) Cartazes ou panfletos
  e) Redes sociais
7. Fazer um planejamento para divulgar o seu Clube em uma rede social.
8. Realizar uma assessoria de marketing completa em 2 dos seguintes departamentos e descobrir como aplicar os recursos de marketing para pregar o evangelho em seu bairro.
  a) Ministério Jovem
  b) Desbravadores
  c) Aventureiros
  d) Música
  e) Evangelismo
  f) Publicações
  g) Temperança
  h) Mordomia Cristã
  i) Ministério da Mulher
  j) Ministério da Criança
  k) Ministério do Adolescente
  l) Escola Sabatina
  m) Ministério Pessoal
  n) Ministério da Família
  o) Ação Solidária Adventista - ASA
  p) Ministério da Saúde e Temperança
  q) Missão Global
  r) Educação'),
('AP-056', 'Modelagem Têxtil', 'atividades-profissionais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ap-056.webp', 'https://mda.wiki.br/Especialidade_de_Modelagem_Têxtil', '1. Definir o que é uma modelagem básica. Como ela foi influenciada ao longo da história? Por que atualmente faz-se necessário vestir roupas com padrões técnicos?
2. O que é um gabarito? Que materiais podem ser utilizados para a fabricação do mesmo?
3. Qual a diferença entre moldes simétricos e assimétricos?
4. O que é protótipo ou peça piloto? Por que é de suma importância a sua existência em uma indústria de produção?
5. Explicar o seguinte:
  a) Urdume ou urdimento
  b) Trama
  c) Ourela
  d) Encaixe
  e) Risco
  f) Enfesto
  g) Corte
  h) Graduação
6. Explicar a diferença entre tecido e malha.
7. Como se classificam os tipos de risco? Demonstrar, através de desenho, cada um deles.
8. Que materiais podem ser utilizados para a fabricação de uma modelagem básica? Explicar cada um deles.
9. O que é modelagem base? Como ela pode auxiliar um modelista em suas criações?
10. Qual a importância de se utilizar as tabelas de medidas? Existe um padrão para isso?
11. Citar, pelo menos, 2 tipos de cortes que podemos fazer em um enfesto pronto. Dar exemplos de máquinas que podem ser utilizadas para realizar esses cortes.
12. Fazer, desenvolver e explicar de forma criativa uma ficha técnica. Escolher uma peça qualquer de seu vestuário e descrever com todos os detalhes os procedimentos básicos de sua criação.
13. Fazer uma graduação de uma peça de sua escolha com, no mínimo, 3 tamanhos diferentes.
14. Com a ajuda de um instrutor ou modelista, fazer a modelagem base das peças a seguir:
  a) Camiseta
  b) Saia
  c) Calça Jeans'),
('AP-057', 'Montagem e Manutenção de Computadores', 'atividades-profissionais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ap-057.webp', 'https://mda.wiki.br/Especialidade_de_Montagem_e_Manutenção_de_Computadores', '1. Que ferramentas são necessárias para a montagem e manutenção de computadores?
2. O que é placa de teste?
3. Que cuidados são necessários ao manusear os componentes internos de computadores?
4. O que é energia estática? Que riscos ela oferece? Como evitar que ela danifique os componentes do computador?
5. Definir o que é, e que processos realiza:
  a) Bios;
  b) Post;
  c) Boot.
6. Por que a placa-mãe é considerada o coração do computador e o processador, o cérebro?
7. Com uma placa-mãe ao vivo ou por fotografia, identificar e indicar a função:
  a) Soquete do processador;
  b) Soquete de memória e informar o tipo;
  c) Conector da fonte;
  d) Slots presentes e informar o tipo de barramento;
  e) Chipsets;
  f) Interface IDE e/ou SATA;
  g) Conectores do gabinete para o painel frontal, áudio, USB.
8. Indicar que modelos de placa de memória RAM (DDR2, DDR3, etc.) são mais usados atualmente e quais possuem maior capacidade potencial?
9. Explicar a relação do uso de memórias com grande capacidade em computadores de baixo desempenho.
10. No HD, o que são trilhas, setores, cilindros, cluster e bad blocks?
11. O que são sistemas (de armazenamento) de arquivos? Citar, pelo menos, três e dizer quais as principais diferenças existentes entre eles.
12. Quais as principais diferenças entre gabinetes AT e ATX?
13. O que é CPU?
14. O que é clock do processador?
15. O que são e como são calculados os Hertz?
16. Citar, pelo menos, cinco fatores que definem a capacidade do processador.
17. Quais as vantagens adquiridas na mudança dos componentes de barramento paralelo (PATA) para o barramento serial (SATA)?
18. Explicar o que é a tela do setup, como acessá-la e quais as principais funções dentro da área de montagem e manutenção.
19. Demonstrar o seguinte:
  a) Desmontar e montar um computador, identificando cada componente interno, informando sua função e manuseando de forma adequada;
  b) Fazer uso correto da pasta térmica e explicar a sua função;
  c) Conectar uma placa off-board e executar o funcionamento mostrando a melhora de desempenho naquela área;
  d) Formatar um computador;
  e) Particionar o disco de armazenamento formatado em três partições;
  f) Instalar no disco de armazenamento formatado um sistema operacional, configurar e deixar pronto para o uso;
  g) Combinar (fundir) duas das três partições;
  h) Listar a importância de cada um e, em seguida, instalar todos os programas básicos, necessários para a utilização doméstica de um computador.
20. Explicar como prevenir, diagnosticar e/ou corrigir os seguintes problemas:
  a) Placa de memória suja;
  b) Aquecimento do processador;
  c) Computador sem áudio;
  d) Não passa da "tela preta";
  e) Reinicia repetidamente;
  f) Vírus.'),
('AP-058', 'Noções de Economia', 'atividades-profissionais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ap-058.webp', 'https://mda.wiki.br/Especialidade_de_Noções_de_Economia', '1. O que é economia e como ela influencia diretamente nossas vidas?
2. Definir:
  a) Microeconomia
  b) Macroeconomia
3. Definir os seguintes medidores da economia e saber os dados atualizados de seu país:
  a) Taxa de câmbio
  b) Produto interno bruto
  c) PIB per capita
  d) Produto Nacional Bruto
  e) Taxa de juros
  f) Dívida nacional
  g) Taxa de Inflação
  h) Desemprego
  i) Balança comercial
4. Conhecer a história da economia mundial e qual modelo econômico é adotado em seus pais.
5. Conhecer as seguintes teorias econômicas:
  a) Economia clássica
  b) Economia marxiana
  c) Economia neoclássica
  d) Economia keynesiana
6. Conhecer os ciclos econômicos enfrentados pelo seu país.
7. Descobrir a relação direta entre economia e política.
8. Saber como está estruturada a economia do seu país.
9. Saber como a economia de um país pode afetar no atraso ou no avanço da pregação do evangelho.
10. Descobrir, pelo menos, 3 registros bíblicos de atividades econômicas.
11. Realizar uma das atividades abaixo:
  a) Visitar uma bolsa de valores e conhecer seu funcionamento.
  b) Entrevistar um economista ou administrador e descobrir como os princípios econômicos podem auxiliar seu Clube/unidade.'),
('AP-059', 'Operação e Manutenção de Impressoras', 'atividades-profissionais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ap-059.webp', 'https://mda.wiki.br/Especialidade_de_Operação_e_Manutenção_de_Impressoras', '1. Citar quais foram os criadores da primeira impressora e da fotocopiadora, as causas que os levaram a inventá-la e como foi o início de sua utilização.
2. Explicar o funcionamento, a alimentação de tinta e o preço de cada tipo de impressora abaixo:
  a) Impressora de impacto
  b) Impressora jato de tinta
  c) Impressora a laser
  d) Impressora térmica
  e) Impressora solvente
  f) Impressora plotter
  g) Impressoras de cera térmica
  h) Impressoras dye-sublimation
  i) Impressoras de tinta sólida
  j) Impressora de sublimação
  k) Impressora de cartão PVC
3. Quais os cuidados adequados que devemos tomar com o manuseio de tonner e de um cartucho de tinta comum?
4. Demonstrar como recarregar um cartucho de uma impressora jato de tinta.
5. Listar, no mínimo, 5 das causas que impedem a impressão e o que fazer para solucionar cada uma delas.
6. Descrever o tipo de papel e impressoras adequadas para os tipos de impressões abaixo:
  a) Foto
  b) Documento comum
  c) Transparência
7. Instalar e configurar uma impressora em um computador, pô-la em rede e em modo wireless.
8. Escolher um tipo de impressora, desmontá-la, limpá-la e montá-la, explicando como se faz o método de limpeza.
9. Saber como desmontar superficialmente uma impressora para limpeza e manutenção.
10. Fazer um projeto ou algum tipo de propaganda sobre o uso consciente e reciclagem de papel e cartuchos de impressão.
11. Pesquisar e anexar, pelo menos, 5 fotos de impressoras antigas.'),
('AP-060', 'Restauro e Conservação Documental', 'atividades-profissionais', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ap-060.webp', 'https://mda.wiki.br/Especialidade_de_Restauro_e_Conservação_Documental', '1. Definir:
  a) Preservação
  b) Conservação
  c) Restauração
  d) Patrimônio Cultural
  e) Bens tangíveis
  f) Bens intangíveis
  g) Bens móveis
  h) Bens imóveis
  i) Tombamento
  j) Patrimônio
2. Explicar quais cuidados devem ser tomados na conservação de livros e documentos, levando em consideração os seguintes itens:
  a) Higienização
  b) Acomodação
  c) Equipamento de proteção individual (EPI)
  d) Equipamento
  e) Diferentes tipos de material dos documentos ou livros
  f) Climatização
  g) Raios ultravioletas
  h) Livro "empastelado" e como tratá-lo
3. Como preservar jornais ou mapas antigos?
4. O que são Câmaras de Expurgo?
5. O que é e como utilizar o Ácido Bórico?
6. Como tratar um livro que tenha sido encharcado de água?
7. O que é liofilização?
8. O que é um higrotermógrafo?
9. Por que o papelão pode ser mais apropriado que o plástico para a preservação de livros?
10. Explicar o seguinte:
  a) Como tratar um livro que tenha sido encharcado de água?
  b) Como preservar jornais ou mapas antigos?
  c) O que fazer com documentos e páginas dobradas e ressecadas?
11. Cumprir uma das opções abaixo:
  a) Procurar um documento com mais de 50 anos e restaurá-lo, se for o caso, e guardá-lo de maneira apropriada. (Exemplo: certidões, páginas de jornais, receitas culinárias, cartas ou revistas, etc.).
  b) Procurar um livro com mais de 50 anos, restaurá-lo, se for o caso, e guardá-lo de maneira apropriada.
  c) Ir a uma biblioteca e ajudar o bibliotecário na restauração de um material por ele indicado e supervisionado.
12. Por que é importante manusear documentos antigos e relevantes usando luvas?
13. Quais os critérios básicos para se considerar um livro ou documento raro e de valor?
14. O que são os manuscritos do Mar Morto e por que a conservação deles é tão importante?'),
('AP-061', 'Secretariado', 'atividades-profissionais', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ap-061.webp', 'https://mda.wiki.br/Especialidade_de_Secretariado', '1. Qual é o papel do secretário dentro de uma instituição?
2. Ter a função de secretário do clube (ou secretario associado) por, no mínimo, 3 meses. Durante esse período, manter os livros e relatórios da unidade em dia e bem organizados, bem como atualizar e manter atualizado o cadastro de todos os membros no Sistema de Gerenciamento de Clubes (SGC).
3. Fazer estágio em um escritório ou escola durante um mínimo de 1 semana na função de secretário ou auxiliar. Neste período, realizar 3 das tarefas abaixo:
  a) Conhecer a organização de um escritório.
  b) Saber organizar um arquivo.
  c) Conhecer noções básicas de atendimento ao público.
  d) Organizar a agenda pessoal de compromissos de outras pessoas.
  e) Saber operar uma mesa telefônica simples e usar adequadamente um e-mail para envio e recebimento de informações
4. Ter conhecimento básico de técnicas de redação:
  a) Ofícios
  b) Memorandos
  c) Cartas
  d) E-mails
5. Saber como montar uma ata e uma pauta para reuniões.
6. Saber como os conceitos de contabilidade são importantes para o serviço do secretário.'),
('AP-062', 'Torno Mecânico', 'atividades-profissionais', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ap-062.webp', 'https://mda.wiki.br/Especialidade_de_Torno_Mecânico', '1. Defina o que é um torno mecânico?
2. Qual objetivo e a finalidade de um torno mecânico?
3. O que é operação de torneamento? Explique seu processo de funcionamento.
4. Quais as principais operações fundamentais que podem ser realizadas em um torno mecânico?
5. Quais os materiais usados na fabricação das ferramentas utilizadas no torno? Cite exemplos de ferramentas com esses materiais.
6. Identificar e demonstrar, através de desenhos ou fotos, quais são os componentes básicos de um torno mecânico?
7. Cite alguns acessórios (peças) que compõem o torno e a função de cada um deles.
8. Identifique, no mínimo, 2 ferramentas que podem ser usadas para medir peças feita no torno. Explique a funcionalidade de cada uma delas.
9. Descreva a função de cada um dos seguintes tornos citados abaixo:
  a) Torno CNC
  b) Torno revólver
  c) Torno vertical
  d) Torno horizontal universal
  e) Tomo de face
  f) Torno copiador
10. Explique o que é um Desenho Técnico Industrial. Como interpretá?lo de forma objetiva e de fácil compreensão?
11. Que cuidados devemos ter ao manusear um torno? Que equipamentos de proteção individual (EPIs) poderão ser utilizados?
12. Qual a influência da velocidade de corte, do avanço e da profundidade de corte na vida de uma ferramenta?
13. Com ajuda de um técnico ou especialista na área de torno, fazer uma peça cilíndrica qualquer, tendo em vista o aprendizado obtido nas operações básicas do torno. Fazer um relatório de, no mínimo, 300 palavras descrevendo como foi desenvolvida essa peça.'),
('AP-063', 'Web Designer', 'atividades-profissionais', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ap-063.webp', 'https://mda.wiki.br/Especialidade_de_Web_Designer', '1. Definir os seguintes termos:
  a) Layout
  b) HTML
  c) CSS
  d) Java Script
  e) Tags
  f) Body
  g) Página Estática
  h) Página Dinâmica
  i) Links
  j) World wide web (www)
2. Apresentar em forma de ilustração ou multimídia a função das principais ferramentas do mercado para produção de uma website, tais como:
  a) Visual estudio code
  b) Figma
3. Criar uma página estática simples, usando apenas o bloco de notas e com o código rodar no browser com os seguintes elementos:
  a) <title>
  b) <header>
  c) <body>
  d) <menu>
  e) <rooter>
  f) Formulário com os campos:
    • Nome
    • E-mail
    • Telefone
    • Mensagem'),
('AP-064', 'Web Designer - avançado', 'atividades-profissionais', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ap-064.webp', 'https://mda.wiki.br/Especialidade_de_Web_Designer_-_avançado', '1. Possuir as especialidades de Especialidade de Web design.
2. Definir os seguintes termos:
  a) Bitmap Image
  b) Animation
  c) DNS
  d) Drop-Down Menu
  e) Mysql
  f) Webmaster
  g) W3C
  h) UX/UI
  i) CMS
  j) FTP
  k) Hyperlink
  l) JPEG
  m) PNG
  n) Resolution
  o) GIF
3. Quais os passos necessários para a criação de um domínio e como registrar o mesmo para funcionar na rede?
4. Apresentar de forma escrita uma página estática simples, usando apenas linguagem HTML, CSS e JS com os seguintes elementos:
  a) <title>
  b) <body>
  c) <menu>
  d) Centro
  e) <rooter>
  f) Formulário incluindo validação do e-mail com um alerta no final
5. Usando alguma ferramenta gráfica, apresentar uma pagina de internet estática simples usando o CSS e carregar no browser para visualizar a pagina, com os mesmos elementos mencionados no requisito anterior.
6. Criar e apresentar uma pagina dinâmica para o seu clube, contando sistema de cadastro de usuário, e formulário de contatos usando PHP ou uma linguagem de sua preferencia.
7. Apresentar um projeto escrito deum site, contendo todos os elementos necessários para o desenvolvimento do site, com capa, justificativa, objetivo e conclusão. (Usar o projeto do site do clube como prática).
8. Criar sites pode ajudar na pregação do evangelho? Como? Citar alguns exemplos que já existem na rede.'),
('AP-065', 'Logística', 'atividades-profissionais', 'especialidade', 2, 2024, 'Divisão Sul Americana', '/esp/ap-065.webp', 'https://mda.wiki.br/Especialidade_de_Logística', '1. Definir logística e explicar em quais atividades realizadas pelo Clube de Desbravadores ela pode ser aplicada.
2. Explicar os aspectos internos e externos com os quais a logística trabalha.
3. Quais são as atividades primárias e secundárias da logística?
4. Mencionar as diferenças entre armazenagem e estoque.
5. Explicar as seguintes funções do armazenamento:
  a) Recepção;
  b) Controle de qualidade;
  c) Controle de inventário;
  d) Preparação dos pedidos;
  e) Despacho.
6. Definir logística reversa. Explicar e exemplificar como esse processo é realizado. Como a logística reversa pode ser aplicada a um acampamento ou campori?
7. Como funciona a cadeia de suprimentos na logística?
8. Qual é a diferença entre logística de distribuição e logística de transporte?
9. O que é a gestão de inventário? Qual é a sua importância na cozinha do seu clube em um campori?
10. Relatar uma história bíblica em que a logística e a gestão de inventário desempenharam um papel importante.'),
('AP-066', 'Noções de Direito', 'atividades-profissionais', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/ap-066.webp', 'https://mda.wiki.br/Especialidade_de_Noções_de_Direito', '1. Definir o que é direito ou ciências jurídicas.
2. Definir os seguintes termos:
  a) Constituição;
  b) Lei;
  c) Decreto;
  d) Poder Judiciário;
  e) Poder Executivo;
  f) Poder Legislativo.
3. Desenhar a Pirâmide de Kelsen e explicar por que ela é importante.
4. Quais são as principais funções dos seguintes profissionais:
  a) Advogado;
  b) Juiz;
  c) Promotor.
5. O que são direitos fundamentais? Citar, pelo menos, cinco direitos fundamentais dos cidadãos do seu país.
6. O que deve ser feito se um direito seu (ou de alguém próximo a você) estiver sendo desrespeitado?
7. Explicar, de forma resumida, como são criadas as leis no seu país. Como a população pode participar no processo legislativo?
8. O que é uma sentença? É possível pedir para que uma sentença seja revisada por outros juízes?
9. Explicar o que é uma decisão salomônica. Por que essas decisões têm esse nome?
10. Por que ninguém pode ser condenado sem ser ouvido e passar pelo devido processo legal?
11. Ler sobre o julgamento de Jesus em João 18:19-24; 28-40; 19:1-16 (caso necessário, consultar também Mateus 26:57-68; 27:11-26; Marcos 14:53-65; 15:1-15; Lucas 22:66-71; 23:1-25). Jesus teve um julgamento justo? Justificar sua resposta.
12. Imaginar uma situação dentro do seu clube em que você pode defender alguém que foi acusado de transgredir o regimento interno por mau comportamento. Como você procederia? Como essa atitude pode ser comparada à atuação de um advogado?
13. O que é uma testemunha? Por que ela é obrigada a dizer a verdade?
14. Escrever um texto de 10 linhas explicando por que Jesus é um advogado, segundo a Bíblia. Citar, pelo menos, dois textos bíblicos.'),
('AP-067', 'Segurança Nas Redes Sociais', 'atividades-profissionais', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ap-067.webp', 'https://mda.wiki.br/Especialidade_de_Segurança_Nas_Redes_Sociais', '1. O que são redes sociais?
2. O que é interatividade digital?
3. Quais são as principais características das redes sociais?
4. Como as redes sociais têm mudado o comportamento das pessoas?
5. Explicar o que significa ter uma boa convivência nas redes sociais?
6. O que é oversharing? Por que é importante evitar compartilhar informações excessivas sobre a nossa vida pessoal nas redes sociais?
7. Fazer uma lista de cinco informações pessoais que não devem ser compartilhadas publicamente nas redes sociais.
8. Listar três maneiras de proteger sua privacidade online.
9. Quais são as consequências de publicar fotos ou informações constrangedoras de outras pessoas nas redes sociais?
10. Por que um perfil falso em uma rede social pode ser um risco às pessoas, principalmente às crianças e adolescentes?
11. Desenvolver um conjunto de diretrizes para lidar com mensagens de ódio ou comentários desrespeitosos nas redes sociais. Incluir estratégias para bloquear, denunciar e manter a calma diante dessas situações.
12. Por que é importante que os pais estejam atentos às atividades dos filhos nas redes sociais? Listar três motivos.
13. Como as redes sociais têm auxiliado na pregação do evangelho de Cristo?
14. De acordo com os ensinamentos de Jesus, como podemos demonstrar amor e bondade nas interações online? Dar exemplos de atitudes que refletem o amor de Jesus ao interagir com outras pessoas nas redes sociais.'),
('AP-068', 'Segurança Contra Incêndios', 'atividades-profissionais', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ap-068.webp', 'https://mda.wiki.br/Especialidade_de_Segurança_Contra_Incêndios', '1. Sobre o fogo:
  a) Quais elementos são necessários para se iniciar uma combustão?
  b) Explicar o que é o tetraedro do fogo?
  c) Quais são os três pontos de temperatura?
  d) Quais são as fases do incêndio?
  e) Que precauções devemos tomar ao iniciar e apagar um incêndio?
  f) Como podemos prevenir incêndios florestais?
2. Sobre os extintores de incêndio:
  a) Conhecer e compreender as diferentes classes de incêndios;
  b) Conhecer e compreender as diferentes classes de extintores de incêndio e para que tipos de incêndios devem ser usados;
  c) Onde extintores de incêndio podem ser adquiridos?
  d) Como e onde deve ser instalado um extintor de incêndio?
  e) Explicar a diferença entre um extintor de incêndios de veículos e um convencional;
  f) Saber quando desistir de tentar apagar um incêndio e evacuar.
3. Sobre os detectores de fumaça e de monóxido de carbono:
  a) O que é um detector de fumaça e como ele funciona?
  b) Onde os detectores de fumaça devem ser instalados em uma casa?
  c) O que é um detector de monóxido de carbono e como ele funciona?
  d) Onde os detectores de monóxido de carbono devem ser instalados em uma casa?
4. Realizar duas das seguintes atividades:
  a) Visitar um Corpo de Bombeiros e aprender sobre a rotina de combate a incêndios e os equipamentos utilizados;
  b) Organizar um simulado de incêndio no seu clube, igreja, escola ou outro edifício;
  c) Realizar a inspeção dos extintores de incêndio da sua igreja, verificando os níveis, se estão instalados corretamente, bem-identificados e dentro do prazo de validade;
  d) Ter um certificado de um curso de brigadista;
  e) Fornecer baterias de reposição para detectores de fumaça para sua vizinhança ou comunidade;
  f) Ajudar uma pessoa a tornar a sua casa segura contra incêndios;
  g) Participar de uma campanha de conscientização sobre segurança contra incêndios na sua vizinhança ou comunidade.'),
('AR-001', 'Arte de Acampar', 'atividades-recreativas', 'especialidade', 1, 1929, 'Associação Geral', '/esp/ar-001.webp', 'https://mda.wiki.br/Especialidade_de_Arte_de_Acampar', '1. Explicar como e porque as condições do tempo, a estação do ano e as fontes de água devem ser consideradas ao se escolher um local de acampamento.
2. Saber oito coisas que se pode/deve fazer quando perdido.
3. Relacionar os objetos pessoais necessários para um acampamento de final de semana. Descrever a roupa apropriada para dormir e como manter-se aquecido durante a noite.
4. Saber organizar adequadamente a sua mochila de acampamento.
5. Citar opções de equipamentos para dormir (colchonete, colchão inflável, saco de dormir, etc.) e tipos de barraca (iglu, canadense, etc.). Descrever as vantagens e desvantagens de cada um.
6. Paticipar de um acampamento de final de semana.
7. Completar o seguinte enquanto estiver no acampamento:
  a) Escolher um bom local para montar a barraca;
  b) Preparar o chão abaixo da barraca, para proporcionar um bom sono;
  c) Montar corretamente uma barraca
  d) Preparar uma área para fazer a fogueira
  e) Demonstrar como proteger o acampamento de animais, insetos, e mau tempo ou chuva;
  f) Demonstrar como preservar a natureza durante o acampamento e deixar o local como se ninguém tivesse estado ali.
8. Saber usar corretamente 2 das ferramentas a seguir e demonstrar regras de segurança no uso destas ferramentas:
  a) Canivete
  b) Machadinha
  c) Machado
  d) Facão
  e) Cavadeira
  f) Picareta
9. Construir um móvel simples de acampamento, usando nós e amarras (miniatura ou tamanho real).'),
('AR-002', 'Cultura Física', 'atividades-recreativas', 'especialidade', 2, 1929, 'Associação Geral', '/esp/ar-002.webp', 'https://mda.wiki.br/Especialidade_de_Cultura_Física', '1. Fazer um relatório citando, pelo menos, 10 benefícios de se manter um bom condicionamento físico.
2. Definir os seguintes exercícios. Citar alguns exemplos em cada modalidade:
  a) Isométrico
  b) Isotônico
  c) Isocinético
  d) Anaeróbio
  e) Aeróbio
3. Fazer um relatório explicando porque os procedimentos abaixo são Importantes em um programa de exercícios, Citar exemplos de cada um.
  a) Alongamento
  b) Aquecimento
  c) Exercícios aeróbios
  d) Relaxamento
  e) Exercícios localizados
4. Demonstrar como verificar sua frequência cardíaca em repouso e após a atividade física.
5. Saber calcular sua frequência cardíaca máxima. Qual a importância de controlá-la durante a prática esportiva? Em qual faixa há um melhor aproveitamento durante exercícios aeróbios? Qual aparelho pode ajudar no controle e como ele funciona?
6. Fazer um programa de exercícios regulares para ser praticado, pelo menos, 3 vezes por semana por um período mínimo de 1 mês. Fazer um quadro (ou tabela) do desenvolvimento de cada atividade diariamente. Este quadro deve conter:
  a) Tipo de exercícios de alongamento
  b) Frequência cardíaca em repouso
  c) Tipo de exercícios de aquecimento
  d) Tipo de exercícios aeróbios
  e) Tempo na prática de exercícios aeróbios
  f) Frequência cardíaca após o exercício
  g) Tipos de ginástica localizada
  h) Exercícios de alongamento
  i) Frequência cardíaca 3 minutos após os exercícios aeróbios'),
('AR-003', 'Natação Principiante I', 'atividades-recreativas', 'especialidade', 1, 1944, 'Divisão do Sul do Pacífic', '/esp/ar-003.webp', 'https://mda.wiki.br/Especialidade_de_Natação_Principiante_I', '1. Ter a especialidade de Segurança básica na água.
2. Com a água no nível do peito, buscar um objeto no fundo, sem ajuda e com os olhos abertos.
3. Saltar da borda lateral, na parte mais profunda da piscina.
4. Dando um impulso, deslizar de barriga para baixo à distância de dois corpos.
5. Nado crawl - 25 metros.
6. Nado de costas - 25 metros.
7. Mudar de direção no nado livre de frente.
8. Mudar de direção no nado de costas.
9. Permanecer boiando por 1 minuto.
10. Deslocar-se na água por 25 metros usando camiseta.
11. Realizar perna de crawl e costas com prancha por 10 minutos.'),
('AR-004', 'Natação Principiante II', 'atividades-recreativas', 'especialidade', 1, 1963, 'Associação Geral', '/esp/ar-004.webp', 'https://mda.wiki.br/Especialidade_de_Natação_Principiante_II', '1. Ter a especialidade de Natação principiante I.
2. Demonstrar as várias posições nas quais se pode boiar.
3. Demonstrar a respiração alternada no nado crawl.
4. Nado crawl -50 metros sem intervalos.
5. Nado costas - 50 metros sem intervalos.
6. Demonstrar a pernada de peito sem intervalo e sem prancha por 25 metros.
7. Demonstrar a virada olímpica de crawl e costas.
8. Manter-se flutuando durante 2 minutos com movimentos de pernas e braços.
9. Deslocar-se na água por 25 metros sem intervalo, usando camiseta e bermuda.'),
('AR-005', 'Natação Intermediário I', 'atividades-recreativas', 'especialidade', 2, 1929, 'Associação Geral', '/esp/ar-005.webp', 'https://mda.wiki.br/Especialidade_de_Natação_Intermediário_I', '1. Ter a especialidade de Natação principiante II.
2. Realizar a virada olímpica.
3. Demonstrar o salto do bloco de partida em uma piscina.
4. Nado de peito - 50 metros.
5. Nado crawl - 100 metros.
6. Nado de costas - 100 metros.
7. Demonstrar o movimento de perna do nado borboleta (golfinho) - 12,5 metros.
8. Deslocar-se na água por 25 metros usando camiseta, bermuda e meias.
9. Manter-se flutuando por 3 minutos com movimento de pernas e braços.'),
('AR-006', 'Natação Intermediário II', 'atividades-recreativas', 'especialidade', 2, 1929, 'Associação Geral', '/esp/ar-006.webp', 'https://mda.wiki.br/Especialidade_de_Natação_Intermediário_II', '1. Ter a especialidade de Natação intermediário I.
2. Nado peito - 100 metros.
3. Nado costas - 150 metros.
4. Nado de borboleta -25 metros.
5. Nado crawl - 150 metros.
6. Nado em velocidade estilo livre - 25 metros em 40 segundos.
7. Realizar a virada dupla do nado borboleta.
8. Flutuar na água durante 3 minutos (1 minuto com as mãos para fora da água).
9. Deslocar-se na água 50m usando camiseta de manga comprida, bermuda e meias.'),
('AR-007', 'Natação - avançado', 'atividades-recreativas', 'especialidade', 3, 1961, 'Associação Geral', '/esp/ar-007.webp', 'https://mda.wiki.br/Especialidade_de_Natação_-_avançado', '1. Ter a especialidade de Natação intermediário II.
2. Nadar continuamente 500 metros, em quaisquer combinações de estilo de nado.
3. Nado crawl - 200 metros sem intervalo.
4. Nadar em baixo da água em apneia (sem respirar) por 25 metros.
5. Nado de costas - 200 metros sem intervalo.
6. Nado peito - 150 metros.
7. Nado borboleta - 50 metros.
8. Demonstrar virada olímpica no nado de costas, peito, borboleta e crawl.
9. Falar sobre os princípios do bom condicionamento e demonstrá-los verificando seu ritmo cardíaco.
10. Revisar as normas de segurança na água.
11. Flutuar ou manter-se na superfície durante 5 minutos. (1 minuto com a mão fora da água).
12. Simular um resgate com prancha ou corda para socorrer vítimas.'),
('AR-008', 'Salvamento de Afogados', 'atividades-recreativas', 'especialidade', 2, 1929, 'Associação Geral', '/esp/ar-008.webp', 'https://mda.wiki.br/Especialidade_de_Salvamento_de_Afogados', '1. Fazer um curso de salvamento de afogados, oferecido por uma instituição autorizada e credenciada para isto, com, pelos menos, 6 horas de prática.
2. Tirar a roupa em águas profundas e nadar 100 metros.
3. Mergulhar em águas com profundidade de 2 metros, retirando 3 objetos quaisquer do fundo, sendo que um deles deve pesar 4,5 Kg.
4. Fazer a aproximação correta, nadando 9 metros, e carregar a "vítima" com o braço em torno do peito por 9 metros.
5. Fazer a aproximação correta por baixo d''água, em mergulho, e carregar a "vítima" por 9 metros.
6. Fazer a aproximação correta, nadando 9 metros, e carregar a "vítima" pelo cabelo ou pelo braço por 9 metros.
7. Logo após nadar 50 metros, aproxime-se da "vítima" e a carregue por 9 metros.
8. Libertar-se corretamente de uma "vítima" que esteja segurando seu punho (repetir o método para ambos os punhos). Demonstrar como fazê-lo dentro e fora d''água.
9. Libertar-se corretamente de uma "vítima" que esteja lhe agarrando pelo pescoço (libertar-se escapando pela direita e, posteriormente, pela esquerda). Demonstrar como fazê-lo dentro e fora d''água.
10. Demonstrar a maneira correta de se fazer a reanimação cardiopulmonar num afogado.'),
('AR-009', 'Ciclismo', 'atividades-recreativas', 'especialidade', 1, 1933, 'Associação Geral', '/esp/ar-009.webp', 'https://mda.wiki.br/Especialidade_de_Ciclismo', '1. Nomear as peças de uma bicicleta e descrever o propósito de cada uma.
2. Conhecer e praticar as regras de cortesia e segurança do ciclismo.
3. Por que é necessário utilizar equipamentos de proteção no ciclismo, tais como: capacete, luvas e proteção para joelhos e cotovelos, óculos. etc.
4. Limpar e lubrificar uma bicicleta.
5. Ajustar os freios traseiro e dianteiro corretamente.
6. Consertar um pneu de bicicleta furado.
7. Percorrer 30 quilómetros em um dia.'),
('AR-010', 'Excursionismo Pedestre', 'atividades-recreativas', 'especialidade', 1, 1933, 'Associação Geral', '/esp/ar-010.webp', 'https://mda.wiki.br/Especialidade_de_Excursionismo_Pedestre', '1. Explicar porque os pontos abaixo são considerados importantes durante uma caminhada:
  a) Passada apropriada
  b) Velocidade
  c) Intervalo de descanso
  d) Regras de comportamento
  e) Cuidado com a natureza
2. Explicar porque é importante ter cuidado com os pés. Qual a influência que a limpeza, unhas cortadas e limpas, meias e calçados fazem?
3. Quais os primeiros socorros devem se prestados a uma pessoa com bolhas nos pés(calosidades)?
4. Fazer uma lista do vestiário e calçados apropriados para uma caminhada em cada uma das seguintes situações:
  a) Clima quente
  b) Clima frio
  c) Tempo chuvoso
5. Fazer uma lista do material necessário para uma caminhada em uma região silvestre para:
  a) Caminhada de 24 horas
  b) Caminhada de 12 horas
  c) Caminhada de 6 horas
6. Relacionar, pelo menos, cinco regras de segurança durante uma caminhada, citar alguns cuidados especiais nos seguintes locais:
  a) Trilhas
  b) Rodovias
  c) Área urbana
  d) Área rural
  e) Estrada
  f) Área desabitada
  g) Florestas
7. Explicar a importância de comer e beber água adequadamente durante uma caminhada.
8. Calcular quantos litros de água você deve tomar em uma caminhada de 16 quilômetros.
9. Fazer um planejamento de uma caminhada de 16 quilômetros para entregar ao seu instrutor. Incluir no planejamento:
  a) Mapa com detalhamento do percurso
  b) Lista de equipamentos
  c) Vestimentas
  d) Quantidade de alimentação e água
  e) Postos de socorro no caso de emergência (polícia, pronto socorro, etc.)
  f) Tempo previsto para o percurso e horário previsto para chegada
10. Fazer as seguintes caminhadas:
  a) 8 quilômetros em área rural ou urbana
  b) 8 quilômetros por trilha em região de mata, floresta ou agreste
  c) 2 caminhadas de 10 quilômetros em percursos e datas diferentes
  d) 16 quilômetros por trilha em região de mata, floresta ou agreste
11. Apresentar um relatório de cada caminhada contendo:
  a) Datas
  b) Mapa com detalhamento do percurso
  c) Tempo de caminhada
  d) Condições climáticas
  e) Considerações interessantes
  f) Pontos interessantes observados
  g) Se possível, foto do grupo que participou'),
('AR-011', 'Filatelia', 'atividades-recreativas', 'especialidade', 2, 1933, 'Associação Geral', '/esp/ar-011.webp', 'https://mda.wiki.br/Especialidade_de_Filatelia', '1. Relatar, sucintamente, a história do serviço postal do seu país.
2. Como a história do seu país é contada através dos selos?
3. Quais são os preços para carta comum em seu país?
4. Qual o país que não tem seu nome nos selos e por quê?
5. Saber o significado dos seguintes termos:
  a) Dentado
  b) Intervalo entre picotes
  c) Classificador
  d) Odontômetro
  e) Selos Definitivos
  f) Selos Comemorativos
  g) Charneira
  h) Havid ou Maximaphil
6. Saber como retirar os selos que estão colados em papel e como secá-los.
7. Fazer uma coleção de, pelo menos, 750 selos, não incluindo repetidos na contagem.
8. Classificar devidamente os selos:
  a) Por países
  b) Por séries, de acordo com o ano e o design
9. Montar seus selos em classificador ou Havid. (O Havid é mais indicado para selos novos).
10. Escolher um tema e desenvolver uma exposição de, pelo menos, 9 páginas, incluindo uma página título, para ser apresentada em algum evento do Clube de Desbravadores. A apresentação deve ser artística, com etiquetas para classificar cada selo e demonstrar cuidadosa pesquisa.'),
('AR-012', 'Filatelia - avançado', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-012.webp', 'https://mda.wiki.br/Especialidade_de_Filatelia_-_avançado', '1. Ter a especialidade de Filatelia.
2. Conhecer o significado dos seguintes termos:
  a) Carimbo
  b) Pertin
  c) Bloco
  d) Molde
  e) Pré-carimbado
  f) Marca Característica
  g) Marca d?água
  h) Pinça
3. Expor, pelo menos, 16 páginas numa exposição de selos do Clube. Os selos devem ser apresentados de forma artística, com etiquetas para classificar cada um deles, demonstrando cuidadosa pesquisa.
4. Fazer uma coleção de 750 selos com, pelo menos, 50 selos para cada país estrangeiro; no mínimo 5 países estrangeiros.
5. Citar 2 catálogos diferentes que podem ser usados para identificar selos.
6. Usando um catálogo de selos, identificar e montar sua coleção de acordo com o número do catálogo e país.'),
('AR-013', 'Esqui Downhill', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-013.webp', 'https://mda.wiki.br/Especialidade_de_Esqui_Downhill', '1. Relacionar os 4 materiais mais usados na construção de esquis. Qual as diferenças e benefícios destes materiais?
2. Executar corretamente e demonstrar habilidade fazendo o seguinte:
  a) Ficar em pé sobre os esquis
  b) Deslizar por, pelo menos, 10 metros
  c) Chutar enquanto esquia (levantar um dos pés à altura da cintura)
  d) Usar corretamente os bastões
3. Fazer um dos seguintes:
  a) Demonstrar habilidade para efetuar um salto de, pelo menos, 25 metros de extensão corretamente. Deverá ser avaliado de acordo com as normas regulares de saltos de esqui.
  b) Percorrer um percurso Slalon, com dificuldade moderada, com, pelo menos, 2 saltos e 6 curvas no percurso.
4. Fazer um relatório ou explicar oralmente a seu instrutor o seguinte sobre a prática do esqui:
  a) Roupa adequada
  b) Equipamentos
  c) Suas razões para escolher o esqui como um hobby saudável
  d) Quais emoções você já experimentou enquanto esquiava'),
('AR-014', 'Arco e Flecha', 'atividades-recreativas', 'especialidade', 2, 1945, 'Associação Geral', '/esp/ar-014.webp', 'https://mda.wiki.br/Especialidade_de_Arco_e_Flecha', '1. Ter, no mínimo, 14 anos de idade.
2. Conhecer e explicar as regras de segurança de arco e flecha.
3. Identificar as partes de uma flecha, explicando a função de cada uma.
4. Identificar e explicar as partes que compõe o:
  a) Arco composto
  b) Arco recurvo
5. Descrever e mostrar como usar os seguintes acessórios:
  a) Protetor de braço (braçadeira)
  b) Protetor de peito
  c) Dedeira
  d) Aljava
  e) Sling(pulseira ou bandoleira)
  f) Kisser (beijador)
6. Entender as zonas e as regras de pontuação do alvo padrão para arco e flecha.
7. Por que é necessário ter o Nock Point (ponto de encaixe) da flecha posicionado corretamente na corda do arco?
8. Demonstrar de forma básica as seguintes técnicas de tiro:
  a) Postura
  b) Encaixe da flecha
  c) Retesar o arco
  d) Ancoragem
  e) Empunhadura e mira
  f) Largada
9. Demonstrar habilidade em encordar corretamente um arco recurvo.
10. Usando um arco recurvo, alcançar uma das seguintes pontuações:
  a) Indoor: 30 flechas (6 séries de 5 flechas) a 18 metros de distância, marcar 50 pontos em um alvo de 60 cm.
  b) Outdoor: 30 flechas (6 séries de 5 flechas) a 25 metros de distância, marcar 150 pontos em um alvo de 122 cm.'),
('AR-015', 'Caiaque', 'atividades-recreativas', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/ar-015.webp', 'https://mda.wiki.br/Especialidade_de_Caiaque', '1. Explicar os diferentes tipos de caiaques (para rio, corredeiras, mar e turismo), detalhando como é o uso de cada um e qual o equipamento de segurança necessário para a prática do esporte (capacete, salva-vidas, calçados, presilhas de segurança, etc.).
2. Fazer um passeio de caiaque.
3. Demonstrar habilidade em ajustar o caiaque.
4. Demonstrar habilidade para entrar e sentar-se no caiaque.
5. Demonstrar habilidade para sair de um caiaque
6. Demonstrar habilidade para completar o seguinte:
  a) Remando, conduza o caiaque para frente e para trás
  b) Remando, vire o caiaque para a esquerda, e depois à direita, tanto seguindo em frente quando indo de ré
  c) Seguir um percurso estabelecido pelo instrutor
  d) Usar o remo como apoio para evitar acidentes
7. Explicar as etapas envolvidas no movimento de rolamento do caiaque e demonstrar este método na prática.'),
('AR-016', 'Canoagem', 'atividades-recreativas', 'especialidade', 2, 1945, 'Associação Geral', '/esp/ar-016.webp', 'https://mda.wiki.br/Especialidade_de_Canoagem', '1. Demonstrar de forma prática ao seu instrutor:
  a) As regras de segurança da canoagem
  b) Colocar, ajustar e usar o colete salva-vidas
  c) Competência para levar outros na canoa
2. Primeiro sozinho, e depois com um companheiro, em um píer e em uma praia/rio/lago, demonstrar o seguinte:
  a) Entrar numa canoa e dar o primeiro impulso para colocá-la na água
  b) Atracar a canoa e depois sair dela
3. Acompanhado de um instrutor, fazer as seguintes manobras corretamente, a partir da popa e da proa:
  a) Demonstrar oito formas de remar
  b) Virar o barco à esquerda e depois à direita, sem avançar ou recuar
4. Sozinho em uma canoa, mantendo o remo do mesmo lado, fazer o seguinte:
  a) Remar, pelo menos, l00 metros
  b) Virar à esquerda
  c) Virar à direita
  d) Repetir dois itens acima estando de joelhos enquanto rema
5. Fazer uma simulação de resgate de um companheiro que tenha tido o barco emborcado longe da praia ou ancoradouro. Na simulação fazer o seguinte:
  a) Esvaziar a canoa que estava virada e rebocá-la de volta ao ancoradouro
  b) Equilibrar a canoa enquanto seu companheiro entra nela novamente
  c) Dar um novo impulso para a canoa na água'),
('AR-017', 'Numismática', 'atividades-recreativas', 'especialidade', 2, 1945, 'Associação Geral', '/esp/ar-017.webp', 'https://mda.wiki.br/Especialidade_de_Numismática', '1. Relatar sucintamente a história do dinheiro, sua evolução e as mais variadas formas de dinheiro? da atualidade, como o cartão de crédito, etc.
2. Contar resumidamente a história do dinheiro em seu país, mencionando as datas de estabelecimento de casas da moeda e fábricas de cunhagem. Mencionar também as mudanças das cédulas e moedas de seu país ao longo do tempo.
3. Explicar como o dinheiro é distribuído pelo governo em seu país.
4. Definir quaisquer dos termos a seguir, caso se apliquem ao sistema monetário de seu país:
  a) Mescla de metais
  b) Cunhagem revestida
  c) Moeda comemorativa
  d) Cunho
  e) Fundo
  f) Inscrição
  g) Borda marcada com letras
  h) Anverso
  i) Reverso
  j) Série
  k) Impressão sobreposta
  l) Tira magnética
  m) Tinta fluorescente
  n) Controle de inflação
  o) Numeração das notas
  p) Papel-moeda
5. Descrever o anverso e o reverso das cédulas usadas atualmente em seu país.
6. Saber como a qualidade das moedas é avaliada pelos colecionadores.
7. Ter moedas ou notas de dez diferentes países. Descrever o que há em cada uma delas, dar os nomes de pessoas ou objetos retratados nas mesmas e, quando possível, mencionar as datas de cada uma.
8. Cumprir um dos seguintes itens:
  a) Colecionar, pelo menos, cinco moedas ou notas de seu país que não estejam mais em circulação.
  b) Colecionar uma série datada de moedas de seu país, começando com o ano de seu nascimento (não é necessário incluir moedas raras ou caras).
9. Relacionar as características de segurança contra falsificação das cédulas vigentes em seu país e as apresentar para sua unidade ou Clube.
10. Contar uma história bíblica que envolva dinheiro, convertendo e comparando o valor com o dinheiro atual de seu país.'),
('AR-018', 'Navegação', 'atividades-recreativas', 'especialidade', 2, 1953, 'Associação Geral', '/esp/ar-018.webp', 'https://mda.wiki.br/Especialidade_de_Navegação', '1. Saber, pelo menos, 20 termos náuticos usados na navegação.
2. Cite, pelo menos, três tipos de pedido de socorro em navegação e suas características. Em uma situação de perigo, por quem esses pedidos são feitos?
3. Nomear 6 tipos de boias na navegação. Dizer para que servem e como são usadas. Dar as cores dos 6 tipos que você nomeou. Como as boias são numeradas? Como fazer as marcações em canais?
4. Por que a bússola é tão importante na navegação? Onde ela deve ficar localizada na embarcação e por quê?
5. Citar o nome de 4 dos nós mais utilizados em navegação. Saber como amarrá-los e explicar suas funções.
6. Saber ler e interpretar uma carta náutica, saber por que ela é de suma importância quanto à navegação em águas desconhecidas. Citar alguns itens que se pode encontrar na carta, seus símbolos e marcação de boias.
7. Quando estiver no comando de uma navegação, quais são as três regras de segurança para melhor navegar?
8. O que significa estar devidamente equipado? Demonstrar ao vivo ou através de ilustrações.
9. O que significam as expressões "regras de condução" e "ética marítima"?'),
('AR-019', 'Vela', 'atividades-recreativas', 'especialidade', 2, 1953, 'Associação Geral', '/esp/ar-019.webp', 'https://mda.wiki.br/Especialidade_de_Vela', '1. Conhecer e explicar as regras de navegação para veleiros.
2. Saber como as condições meteorológicas e as condições marítimas afetam o desempenho do barco à vela e a segurança da embarcação.
3. Que medidas de segurança devem ser tomadas ao velejar?
4. Fazer o seguinte:
  a) Afastar o barco à vela do ancoradouro ou praia
  b) Saber como ajustar as velas de acordo com as seguintes situações:
    • Contra o vento
    • Toda-vela
    • Curva aberta
    • Curva fechada
    • A favor do vento
  c) Mudar de rumo usando as velas
  d) Aproximar-se da doca, praia ou ancoradouro, parar o barco e preparar o barco para ser guardado
5. Saber fazer os seguintes nós e como utilizá-los ao velejar:
  a) Nó direito
  b) Lais de guia
  c) Volta do fiel
  d) Figura em oito
  e) Laçada dupla
6. Relacionar as maneiras para cuidar e preservar seu equipamento de navegação durante o ano.
7. Conhecer, pelo menos, 20 termos utilizados na navegação e seus significados.
8. Ser capaz de identificar, pelo menos, 15 partes de um veleiro.
9. Explicar:
  a) Como deve ser feito o resgate de uma pessoa que tenha caído na água?
10. O que fazer quando um veleiro vira?'),
('AR-020', 'Fogueiras e Cozinha ao Ar Livre', 'atividades-recreativas', 'especialidade', 2, 1956, 'Associação Geral', '/esp/ar-020.webp', 'https://mda.wiki.br/Especialidade_de_Fogueiras_e_Cozinha_ao_Ar_Livre', '1. Demonstrar como preparar e cortar, com segurança, madeira e gravetos para uma fogueira.
2. Preparar, com segurança, cinco das fogueiras e saber o uso específico de cada uma. Duas das escolhidas devem ser próprios para cozinhar alimentos:
  a) Fogo do Conselho
  b) Altar de Cozinha
  c) Fogo de Trincheira
  d) Cercadura de Pedra
  e) Cama Rápida
  f) Fogo Estrela
  g) Fogo de Caçador
  h) Fogo Refletor
3. Demonstrar habilidades em:
  a) Começar uma fogueira
  b) Alimentar o fogo
  c) Finalizar uma fogueira
  d) Começar uma fogueira em tempo chuvoso
4. Elaborar um cardápio ovolactovegetariano e balanceado para 6 refeições de um acampamento.
5. Demonstrar habilidades em:
  a) Refogar, cozinhar, fritar e assar alimentos.
  b) Preparar os alimentos com segurança
  c) Dispor do lixo adequadamente e lavar os utensílios
  d) Manter os alimentos gelados/frios enquanto estiver acampando com um método natural que nao seja o uso do gelo.
  e) Manter os alimentos e os utensílios a salvo de ataque de animais.
6. Por que é importante manter limpos os utensílios usados para cozinhar e comer?'),
('AR-021', 'Mapa e Bússola', 'atividades-recreativas', 'especialidade', 3, 1956, 'Associação Geral', '/esp/ar-021.webp', 'https://mda.wiki.br/Especialidade_de_Mapa_e_Bússola', '1. Quais são 8 os pontos cardeais?
2. O que é um mapa topográfico e quais são as suas principais utilidades?
3. Como as distâncias são definidas?
4. O que é um mapa ortofoto?
5. Conhecer e explicar o seguinte:
  a) O que é azimute
  b) O que é desvio e como corrigir isto?
6. Saber chegar aos seguintes pontos na bússola:
  a) Norte
  b) Sul
  c) Leste
  d) Oeste
7. Seguir uma pista usando mapa e bússola com, pelo menos, 10 leituras ou pontos de controle.'),
('AR-022', 'Pioneirismo', 'atividades-recreativas', 'especialidade', 2, 1956, 'Associação Geral', '/esp/ar-022.webp', 'https://mda.wiki.br/Especialidade_de_Pioneirismo', '1. Conhecer as 4 amarras básicas (quadrada, circular, diagonal e continua) e construir um móvel usando algumas dessas amarras.
2. Ter uma das seguintes especialidades:
  a) Cestaria
  b) Trabalhos em couro
  c) Tricô
  d) Tecelagem
3. Pesquisar sobre o processo de interiorização de seu país. Escrever 300 palavras sobre como os pioneiros que dedicaram suas vidas à abertura de caminhos rumo ao centro de seu país satisfaziam as seguintes necessidades:
  a) Habitação e mobília
  b) Vestimenta
  c) Alimentação
  d) Cozinha
  e) Formas de iluminação
  f) Ferramentas
  g) Saneamento
  h) Transporte
4. Pesquisar sobre uma forma artesanal de fazer farinha de, pelo menos, uma planta. Apresentar um relatório detalhado sobre todo o processo.
5. Explicar a necessidade de fogo para a sobrevivência do homem. Fazer uma breve reflexão sobre o uso e dificuldades de produção de fogo encontrados pelos expedicionários do passado. Completar o seguinte:
  a) Fazer uma fogueira utilizando produtos naturais na construção e também na produção da faísca inicial. Manter o fogo aceso por 5 minutos. Escolher um dentre os seguintes para começar:
    • Pedra e aço
    • Atrito
    • Vidro curvo
    • Ar comprimido
  b) Fazer uma fogueira utilizando produtos naturais na construção. Utilizar um dos métodos modernos para a produção da faísca inicial e manter o fogo aceso por 5 minutos. Escolher um dentre os seguintes para começar:
    • Faísca elétrica
    • Pederneira
    • Palha (Esponja) de aço e bateria
    • Outro método definido pelo instrutor
6. Demonstrar habilidade no uso do machado, completando os seguintes requisitos:
  a) Descrever os melhores tipos de machados
  b) Demonstrar como afiar um machado corretamente
  c) Listar e seguir 10 regras de segurança no uso de um machado
  d) Demonstrar a técnica apropriada de manuseio de um machado
  e) Utilizando as técnicas aprendidas para uso do machado, preparar madeira para os seguintes:
    • Fogueira (iscas, gravetos, troncos)
    • Abrigo (bases, paredes, cobertura)
7. Completar 2 dos seguintes itens:
  a) Fazer uma corda de 3 metros a partir de material natural ou barbante.
  b) Fazer 10 nós úteis para os pioneiros e contar como eram utilizados.
  c) Usando corda e materiais naturais, fazer um dispositivo para mover objetos pesados.
  d) Construir uma latrina adequada e confortável.
8. Explicar a importante relação entre a higiene (como banho, cuidados com a louça e eliminação apropriada de resíduos sólidos [lixo]) e a manutenção da saúde.
9. Ajudar na construção de uma ponte, de corda ou madeira, de 3 metros de comprimento, usando amarras.
10. Participar de um debate sobre a importância da conservação do meio ambiente. Conhecer e por em prática 4 maneiras de conservar a beleza da mata.
11. Explicar a importância das seguintes atividades na vida dos pioneiros e demonstrar como fazer 2 delas:
  a) Fazer uma vela de cera ou outra forma de fonte de luz utilizada pelos pioneiros
  b) Fazer uma barra de sabão
  c) Ordenhar uma vaca ou cabra
  d) Bater manteiga
  e) Fazer uma caneta de pena e escrever com ela
  f) Construir um brinquedo simples usado pelos pioneiros
  g) Participar da confecção de uma colcha
12. Conhecer 5 remédios caseiros utilizados pelos pioneiros, obtidos a partir de plantas silvestres, que tenham sua eficácia comprovada e explicar suas indicações.
13. Completar uma das seguintes opções:
  a) Auxiliar na construção de uma jangada, usando amarras. Fazer uma viagem de 5 km em um rio com essa jangada.
  b) Com um vaqueiro experiente, participar de uma viagem de 2 dias, a cavalo, pelo percurso de 25 km, levando todos os suprimentos necessários em um cavalo de carga que você aprendeu a equipar.
  c) Com um líder experiente, participar de uma viagem de canoa de um dia, percorrendo 25 km, levando todos os suprimentos necessários corretamente. Um pequeno transporte pela terra pode ser realizado.
  d) Com um líder experiente, participar de uma caminhada de 2 dias, viajando por 25 km, levando todos os suprimentos necessários na mochila.'),
('AR-023', 'Remo', 'atividades-recreativas', 'especialidade', 2, 1956, 'Associação Geral', '/esp/ar-023.webp', 'https://mda.wiki.br/Especialidade_de_Remo', '1. Explicar os princípios básicos da prática do remo, ressaltando os seguintes tópicos:
  a) Ajustando o finca-pé
  b) Entrando no barco
  c) Fixando os pés
  d) Posição das mãos
  e) Posição na ré
  f) Posição na pegada
2. Sob supervisão de seu instrutor, realizar o seguinte:
  a) Conduzir o barco remando em linha reta por 500 metros, parar, fazer uma volta pivô e retornar ao ponto de partida
  b) Conduzir o barco remando por 200 metros, fazer uma curva em curso usando apoio do remo e retornar ao ponto de partida, plainando o remo a cada braçada.
3. Demonstrar como:
  a) Como lançar o barco na água, e trazê-lo de volta ao ancoradouro
  b) Ajudar uma pessoa a entrar com segurança dentro do barco ao lado de um cais
  c) Ancorar o barco no cais, usando o nó volta do fiel, ou fateixa ou um nó bolina
4. Sozinho, ou com a ajuda de uma pessoa que saiba nadar, desvirar um barco, colocando o lado correto para cima, entrar, e com as mãos ou um remo conduzi-lo por dez metros. Explicar como ficar pendurado ou entrar em um barco inundado.
5. A partir de um cais, sozinho em um barco a remo, abordar um nadador, manobrar o barco e rebocá-lo em segurança até a terra.
6. Nomear e identificar pelo menos cinco diferentes tipos de barcos que podem ser usados com remos. Explicar onde cada um é mais indicado para ser usado.
7. Identificar e descrever dois dos seguintes tipos de suportes de remo:
  a) Suporte aberto com cavilha (Tholepin)
  b) Forquilha de encaixe (Box rowlock)
  c) Suporte em anel (Ring rowlock)
  d) Forquilha aberta (Open-top rowlock)
8. Explicar as vantagens obtidas ao se plainar o remo fora d?água durante a prática do remo.
9. Como você agiria se uma tempestade súbita ou vento forte o pegasse enquanto estivesse navegando em um barco a remo?
10. Como você calcula o número de pessoas que podem ser transportadas com segurança em qualquer barco a remo salva-vidas?
11. Que luzes são necessárias em um barco à noite?
12. Como você retira, transporta e armazena um barco a remo no período que não será usado?'),
('AR-024', 'Vida Silvestre', 'atividades-recreativas', 'especialidade', 2, 1956, 'Associação Geral', '/esp/ar-024.webp', 'https://mda.wiki.br/Especialidade_de_Vida_Silvestre', '1. Participar de, pelo menos, dois acampamentos, com no mínimo dois pernoites cada, durante os quais possa praticar as habilidades necessárias para esta especialidade.
2. Mencionar 8 coisas que devem ser feitas quando se está perdido numa floresta/mata. Conhecer três métodos de identificar os pontos cardeais sem o uso de uma bússola.
3. Explicar como encontrar água na floresta/mata e demonstrar três maneiras de purificar água para beber.
4. Explicar os primeiros socorros que devem ser prestados para as seguintes situações:
  a) Hipotermia
  b) Mordida de cobra peçonhenta
  c) Insolação
  d) Exaustão
  e) Ferimentos
  f) Náuseas
  g) Desidratação
5. Demonstrar, na prática, pelo menos dois dos itens abaixo:
  a) Avaliar a altura de uma árvore
  b) Avaliar a largura de um riacho
  c) Avaliar a profundidade de um rio
6. Demonstrar duas formas de sinalizar pedidos de socorro
7. Usando uma bússola, seguir um percurso (previamente montado pelo instrutor) com no mínimo três azimutes e mais de 300 metros, com margem de erro de no máximo 5% da distância do percurso (por exemplo: para um percurso de 300 metros, margem de erro de 15 metros).
8. Identificar, preparar e comer 3 variedades de plantas silvestres.
9. Explicar como preparar-se e providenciar abrigo nas seguintes condições:
  a) Muita neve
  b) Área rochosa
  c) Pântano
  d) Floresta
10. Ter um estojo pessoal de sobrevivência com pelo menos 10 itens e saber usar cada um deles.'),
('AR-025', 'Equitação', 'atividades-recreativas', 'especialidade', 1, 1961, 'Associação Geral', '/esp/ar-025.webp', 'https://mda.wiki.br/Especialidade_de_Equitação', '1. Identificar 10 partes de uma sela e 5 de um bridão ou freio.
2. Explicar como limpar e cuidar adequadamente de um arreio ou sela.
3. Descrever a importância do capacete e botas enquanto se trabalha com cavalos ou na hora de cavalgar.
4. Descrever e demonstrar 5 regras de segurança que devem ser observadas no momento de aproximação e captura de um cavalo.
5. Escolher um local seguro para amarrar um cavalo manso e depois demonstrar os tipos de nó que podem ser usados para amarrar o animal, o comprimento correto da corda e a altura adequada para fazer a amarra.
6. Explicar como se deve cuidar corretamente de um cavalo.
7. Demonstrar e explicar como colocar a sela e o bridão num cavalo de forma correta e segura.
8. Demonstrar e explicar como montar e desmontar um cavalo adequadamente e com segurança.
9. Demonstrar e explicar o procedimento correto ao montar em um cavalo sem sela que esteja parado. Cavalgar, com equilíbrio, e em pelo, durante, no mínimo, 30 minutos (podem ser cumulativos).
10. Demonstrar e explicar regras de segurança para cavalgar em grupo, cavalgando em companhia de, no mínimo, mais um cavaleiro. Demonstrar espaçamento correto, mudança de direção e ultrapassagem de outros cavaleiros em marcha numa arena.
11. Cavalgar um cavalo em passo de marcha, em trilha, durante um mínimo de quatro horas cumulativas.'),
('AR-026', 'Esqui Aquático', 'atividades-recreativas', 'especialidade', 2, null, '1961 Origem', '/esp/ar-026.webp', 'https://mda.wiki.br/Especialidade_de_Esqui_Aquático', '1. Conhecer a história da origem do esqui aquático.
2. Explicar as seguintes regras de segurança:
  a) Nunca esquiar à noite
  b) Nunca esquiar durante uma tempestade com raios
  c) Usar sempre colete salva-vidas ao esquiar
  d) Verificar se a presilha do colete está bem fechada
  e) Verificar se a corda está em boas condições
  f) Verificar se os esquis estão em boas condições
  g) Ter instalado um espelho retrovisor no barco que puxa o esquiador
  h) Manter distância de objetos ou pessoas como, por exemplo, outros esquiadores, nadadores, ancoradouros ou objetos flutuantes
  i) Se cair, soltar a corda
  j) Depois da queda, levantar os braços para indicar que está bem
  k) Não ficar em pé no barco/lancha enquanto o mesmo estiver em movimento
3. Conhecer os seguintes sinais de mão:
  a) Mais devagar
  b) Velocidade ok
  c) Mais rápido
  d) Voltar ao embarcadouro
4. Colocar os esquis em águas profundas. Arrancar em águas profundas com esquis duplo e uma corda de extensão longa.
5. Passar por cima da trilha do barco mantendo o equilíbrio.
6. Explicar as seguintes modalidades:
  a) Slalom
  b) Truques
  c) Rampas'),
('AR-027', 'Esqui Aquático - avançado', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-027.webp', 'https://mda.wiki.br/Especialidade_de_Esqui_Aquático_-_avançado', '1. Ter a especialidade de Esqui aquático.
2. Largar em águas profundas e esquiar satisfatoriamente.
3. Passar por cima da trilha do barco sem perder o equilíbrio.
4. Fazer um giro completo de 360 graus.
5. Fazer o percurso de uma prova de Slalom satisfatoriamente.'),
('AR-028', 'Mergulho Livre', 'atividades-recreativas', 'especialidade', 2, 1961, 'Associação Geral', '/esp/ar-028.webp', 'https://mda.wiki.br/Especialidade_de_Mergulho_Livre', '1. Ter a especialidade de Natação principiante I.
2. Mencionar 3 pré-requisitos para uma pessoa que deseja fazer mergulho livre.
3. Descrever regras de segurança para a prática do mergulho livre.
4. Que equipamentos são essenciais para se fazer mergulho livre?
5. Descrever os cuidados e procedimentos necessários para fazer mergulho livre em cada um dos ambientes abaixo:
  a) Praia
  b) Rio
  c) Lago
6. Fazer um teste prático sobre as técnicas de mergulho livre (este teste pode ser feito em uma piscina).
7. Demonstrar, em águas abertas, seus conhecimentos no mergulho livre.
8. Registrar um mergulho realizado, incluindo data, local, fauna observada, tempo de mergulho, etc.'),
('AR-029', 'Salvamento de Afogados - avançado', 'atividades-recreativas', 'especialidade', 3, 1963, 'Associação Geral', '/esp/ar-029.webp', 'https://mda.wiki.br/Especialidade_de_Salvamento_de_Afogados_-_avançado', '1. Ter a especialidade de Salvamento de afogados.
2. Fazer um curso de salvamento de afogados, com carga horária mínima de 50 horas, em instituição que emita um certificado com selo da International Life Saving Fedaration (ILS) ou de instituição equivalente em seu país.')
on conflict (codigo) do update set nome = excluded.nome, categoria_slug = excluded.categoria_slug, tipo = excluded.tipo, nivel = excluded.nivel, ano = excluded.ano, origem = excluded.origem, imagem = excluded.imagem, url_mda = excluded.url_mda, requisitos = excluded.requisitos;

insert into public.especialidades (codigo, nome, categoria_slug, tipo, nivel, ano, origem, imagem, url_mda, requisitos) values
('AR-030', 'Saltos Ornamentais', 'atividades-recreativas', 'especialidade', 3, 1964, 'Associação Geral', '/esp/ar-030.webp', 'https://mda.wiki.br/Especialidade_de_Saltos_Ornamentais', '1. Demonstrar os seguintes saltos:
  a) Frente
  b) Trás
  c) Ponta pé à lua
2. Realizar 2 dos seguintes saltos: parafuso (grupado, carpado ou esticado), equilíbrio grupado ou carpado, salto revirado grupado ou carpado.
3. Explicar a profundidade segura da água para saltos em trampolim de 1 metro e 3 metros. A qual distância o trampolim deve estar projetado sobre a piscina? Que trampolim são recomendáveis?
4. Fazer um breve relatório sobre a história da origem dos Saltos ornamentais.'),
('AR-031', 'Mergulho Autônomo', 'atividades-recreativas', 'especialidade', 3, 1967, 'Associação Geral', '/esp/ar-031.webp', 'https://mda.wiki.br/Especialidade_de_Mergulho_Autônomo', '1. Passar em um curso padrão e ser certificado em nível internacional.
2. Registrar 2 dos mergulhos realizados, incluindo data, local, fauna observada, tempo de mergulho, etc.
3. Ter atestado médico atualizado para a prática do mergulho.'),
('AR-032', 'Mergulho Autônomo - avançado', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-032.webp', 'https://mda.wiki.br/Especialidade_de_Mergulho_Autônomo_-_avançado', '1. Ter a especialidade de Mergulho autônomo.
2. Realizar, no mínimo, 10 mergulhos a 10 metros.
3. Ter atestado médico atualizado para a prática do mergulho.'),
('AR-033', 'Acampamento em Baixas Temperaturas', 'atividades-recreativas', 'especialidade', 2, 1970, 'Associação Geral', '/esp/ar-033.webp', 'https://mda.wiki.br/Especialidade_de_Acampamento_em_Baixas_Temperaturas', '1. Fazer uma lista completa de equipamentos necessários para se acampar em baixas temperaturas em diversas situações, como temperaturas abaixo de zero, tempestades e neve.
2. Explicar como manter o corpo quente e seco por meio do uso adequado de roupas e equipamentos de dormir sob todas as temperaturas abaixo de zero, durante a viagem, descanso e sono.
3. Listar e explicar as características de um bom acampamento em baixas temperaturas.
4. Conhecer 5 regras de segurança para um acampamento em baixas temperaturas.
5. Descrever ou demonstrar como preparar um local para montar seu acampamento em situação de neve ou de frio intenso.
6. Preparar um cardápio equilibrado de 3 dias para ser usado em seu acampamento em baixas temperaturas.
7. Participar de um acampamento com pelo menos 3 pernoites, com tempo frio:
  a) Todas as noites devem ter temperatura abaixo de 10ºC
  b) Uma noite deve ter temperatura abaixo de 0ºC
  c) Todas as noites devem ser passadas em barracas, lonas, ou ao ar livre
8. Cumprir o seguinte durante o acampamento:
  a) Saber como obter água na neve
  b) Explicar 3 formas de conseguir fogo na neve por meios naturais e/ou artificiais.
  c) Demonstrar como cuidar dos fósforos em baixas temperaturas e como conseguir madeira e isca para fazer fogo. Iniciar uma fogueira e mantê-la acesa por, no mínimo, 30 minutos.
9. Descrever como reconhecer e cuidar de uma leve hipotermia, cegueira da neve e desidratação. Como podemos prevenir estas condições?'),
('AR-034', 'Escalada', 'atividades-recreativas', 'especialidade', 2, 1970, 'Associação Geral', '/esp/ar-034.webp', 'https://mda.wiki.br/Especialidade_de_Escalada', '1. Conhecer e praticar as regras de segurança que devem ser seguidas em escaladas.
2. Conhece e demonstrar habilidade nos seguintes equipamentos de escalada:
  a) Mosquetão
  b) Martelo
  c) Pinos
  d) Grampos
  e) Ganchos
  f) Corda de nylon
3. Que cuidados devem-se ter com a corda durante o uso e armazenamento? Qual tipo ideal de corda para rapel e para escalada? Por quê?
4. Demonstrar habilidade para fazer os seguintes nós:
  a) Lais de guia
  b) Volta do fiel
  c) Pescador duplo
  d) Nó figura de oito
  e) Nó figura de oito duplo
  f) Prussik
5. Relacionar os diferentes níveis de dificuldade de locais de escalada. Incluir observações de como identificar cada nível.
6. Fazer o seguinte, durante uma escalada:
  a) Demonstrar habilidade para "içar" dois escaladores, usando corretamente a corda, mosquetão e grampos
  b) Demonstrar o posicionamento correto do corpo
  c) Descrever as superfícies adequadas para "frear"
  d) Enrolar a corda durante a subida
7. Conhecer e demonstrar os sinais usados para comunicação entre escaladores.
8. Mostrar habilidade para subir, pelo menos, 10 metros por uma corda na vertical.
9. Fazer uma escalada livre, com nível entre 4 e 5 de dificuldade. Durante a mesma, por em prática os seguintes conceitos: ritmo, olhar para frente, peso sobre os pés e equilíbrio.
10. Conhecer locais próximos a sua região onde é possível praticar escalada (naturais e artificiais).'),
('AR-035', 'Escalada - avançado', 'atividades-recreativas', 'especialidade', 3, 1970, 'Associação Geral', '/esp/ar-035.webp', 'https://mda.wiki.br/Especialidade_de_Escalada_-_avançado', '1. Ter as especialidades de Escalada.
2. Fazer um relatório baseado em uma pesquisa pessoal sobre o uso de, pelo menos, seis equipamentos usados em escaladas. Citar os prós, contras e forma de uso.
3. Faça uma escalada com nível 5.6 de dificuldade. Durante a mesma, demonstrar habilidade nas manobras de escalada livre.
4. Durante uma escalada, fazer o apoio de segurança do instrutor ou líder da escalada. Conseguir segurar o instrutor durante uma queda simulada.
5. Durante uma escalada, prender os pinos de maneira firme e adequada. Participar de um debate sobre ética na colocação dos grampos de forma a não quebrar a rocha, preservar a natureza, etc.
6. Liderar uma escalada de nível 5.5 de dificuldade.
7. Participar de uma escalada livre com, pelo menos, nível A2 de dificuldade.
8. Montar um planejamento para salvamento e retirada de um alpinista ferido.
9. Participar de uma escalada de dois lances, com nível 5.4 de dificuldade. Liderar um dos lances.'),
('AR-036', 'Escalada em Árvores', 'atividades-recreativas', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/ar-036.webp', 'https://mda.wiki.br/Especialidade_de_Escalada_em_Árvores', '1. Treinar sua habilidade de escalada em árvores algumas vezes em uma árvore de 3 a 4,5 metros.
2. Subir em um coqueiro de, no mínimo, 4 metros. Demonstrar a maneira de voltar ao chão com segurança.
3. Descrever os seguintes métodos de escalada em árvores:
  a) Escalada livre
  b) Técnica de corda única (single rope technique - SRT)
  c) Técnica de corda dupla (double rope technique - DRT)
  d) Técnica de escalada guiada (lead climb technique)
4. Fazer o seguinte:
  a) Subir em uma árvore usando qualquer um dos métodos do requisito 3.
  b) Descrever em detalhes, no mínimo, um método diferente dos descritos no requisito 3.
5. Demonstrar como aplicar dois diferentes métodos de escalada livre em cada uma das situações a seguir (escolhidas pelo instrutor):
  a) Arvore com muitos galhos
  b) Coqueiro
6. Demonstrar como transportar com segurança uma faca do mato e um machado em uma árvore.
7. Saber como remover uma pessoa ferida de uma árvore.
8. Fazer um resumo de uma história bíblica em que a escalada em árvores apareça. Citar personagens, livro, capítulo e versículos. Tirar uma lição dessa história.
9. Quais equipamentos de segurança são necessários para a prática desta atividade?'),
('AR-037', 'Exploração de Cavernas', 'atividades-recreativas', 'especialidade', 2, 1973, 'Associação Geral', '/esp/ar-037.webp', 'https://mda.wiki.br/Especialidade_de_Exploração_de_Cavernas', '1. Fazer o seguinte:
  a) Listar, pelo menos, 3 fontes de luz que podem ser usadas na exploração de cavernas, informando as vantagens e desvantagens para cada tipo;
  b) Explicar a importância de ter suprimentos de reserva para a iluminação;
  c) Pedir que uma pessoa com experiência em exploração de cavernas lhe ensine como usar uma carbureteira.
2. Relacionar o equipamento necessário para a exploração de cavernas (exceto equipamento vertical) e listar aqueles que você acha serem os mais importantes para uma exploração segura.
3. Com a ajuda de um guia experiente, ter ao menos 10 horas acumuladas de exploração de cavernas.
4. Registrar essas explorações, anotando datas, locais das cavernas, condições, características, horas gastas em cada exploração, nome dos outros membros do seu grupo e do líder da expedição.
5. Aprender e praticar as regras de segurança na exploração de cavernas.
6. Praticar a subida de um paredão íngreme, puxando a si mesmo com uma corda.
7. Citar pelo menos, 5 tipos de formações rochosas encontradas no interior de cavernas e de, pelo menos 3 animais que usam cavernas como seu principal habitat.
8. Escrever um relatório com, pelo menos, 300 palavras sobre a sua experiência na exploração, incluindo tudo o que você aprendeu ao completar os requisitos anteriores, incluindo relato dos espeleotemas ou animais que tenha observado.'),
('AR-038', 'Exploração de Cavernas - avançado', 'atividades-recreativas', 'especialidade', 3, 1973, 'Associação Geral', '/esp/ar-038.webp', 'https://mda.wiki.br/Especialidade_de_Exploração_de_Cavernas_-_avançado', '1. Ter a especialidade de Exploração de cavernas.
2. Obter mapas geológicos da região onde você explora cavernas. Marque no mapa a localização de todas as cavernas que você já explorou.
3. Ser capaz de dar uma explicação sobre como estas cavernas se formaram, o que têm em comum e o que se pode esperar das mesmas em termos de características físicas, tais como tipo e tamanho das formações, efeitos da ação da água, presença e natureza de fósseis, presença e natureza de formas de vida, incluindo morcegos.
4. Planejar e fazer, em grupo e na companhia de adultos, uma exploração de caverna onde seja necessário descer, pelo menos, 12 metros por rapel e depois subir de volta. Caso tenha pouca ou nenhuma experiência em rapel, pratique antes da expedição.
5. Conduzir uma pequena pesquisa biológica nas 3 zonas da caverna: zona fótica ou de entrada, zona disfótica ou de penumbra e zona afótica, analisando as paredes e o teto nesta última zona. Fotografar cada espécime e identificar todas as formas de vida animal e vegetal em cada uma das zonas da caverna. Classificar os animais encontrados em trogloxenos, troglófilos ou troglóbios.
6. Participar no processo de mapeamento de uma pequena caverna que você tenha explorado.
7. Registre 100 horas de experiência na exploração de cavernas. Mantenha relatórios precisos de cada exploração.
8. Conduzir um curso de exploração de cavernas para crianças, juvenis ou adolescentes de seu clube, igreja ou comunidade, cujo ponto alto deve ser a visitação a, pelo menos, 1 caverna.
9. Conversando com um guia de exploração de cavernas ou membro de um grupo de espeleologia, descobrir que comportamentos devem ser obedecidos durante uma expedição.'),
('AR-039', 'Barco a Motor', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-039.webp', 'https://mda.wiki.br/Especialidade_de_Barco_a_Motor', '1. Ter a especialidade de Natação - Avançado .
2. Conhecer as leis que regulamentam a posse de embarcações em seu país.
3. Conhecer quais perigos do tempo podem afetar a segurança e o desempenho da navegação.
4. Conhecer as regras náuticas de canais e vias que ajudam a navegação.
5. Conhecer quais equipamentos de segurança, dispositivos de sinalização e luzes são requeridas na Classe A e Classe 1 de botes.
6. Conhecer e praticar as regras de segurança em embarcações.
7. O que os passageiros devem fazer se o barco virar?
8. Qual a regra geral prudencial?
9. Conhecer o significado dos seguintes termos:
  a) À popa
  b) A bordo
  c) Popa
  d) Boca
  e) Escota
  f) Bartedouro
  g) Proa
  h) Antepara
  i) Cunho
  j) Calado
  k) Altura do Bordo
  l) Patilhão
  m) Sotavento
  n) Bombordo
  o) Estibordo
  p) Popa
  q) Calado
  r) Barlavento
10. Mostrar a maneira correta de operar um barco a motor, fazendo o seguinte:
  a) Ajudar a colocar o barco na água a partir de um reboque.
  b) Verificar todos os equipamentos de segurança, verificar combustível e motor.
  c) Ligar o motor e iniciar a navegação a partir de uma praia ou porto.
  d) Conduzir o barco em linha reta por uma milha, virar 90° à direita e depois à esquerda, depois fazer uma volta de 1800.
  e) Parar, ancorar e depois subir a âncora.
  f) Ancorar em uma doca ou praia adequadamente.
  g) Auxiliar a colocar o barco em um reboque.
11. Saber como preparar e guardar um barco a motor para períodos impróprios à navegação.'),
('AR-040', 'Nós e Amarras', 'atividades-recreativas', 'especialidade', 1, 1975, 'Associação Geral', '/esp/ar-040.webp', 'https://mda.wiki.br/Especialidade_de_Nós_e_Amarras', '1. Explicar e ilustrar como é feita uma corda de 3 fios e uma corda com trançado triplo. Citar exemplos de fontes naturais de fibras que são usadas para fazer cordas.
2. Definir os seguintes termos:
  a) Seio (laçada)
  b) Ponta corrediça (vivo)
  c) Corda restante (ponta fixa)
  d) Nó superior
  e) Alça de azelha (laçada com nó)
  f) Volta (laço)
  g) Curva (dobra)
  h) Amarra
  i) União de cordas
  j) Chicote (ponta de trabalho)
3. Descrever as diferença entre uma corda estática e uma corda dinâmica. Saber identificar e dizer os principais usos dos seguintes tipos de cordas:
  a) Poliéster
  b) Sisal
  c) Nylon
  d) Polipropileno
4. Quais são algumas vantagens e desvantagens da corda sintética?
5. Conhecer os cuidados para a conservação de cordas.
6. Segundo Eclesiastes 4:12, que tipo de corda é mais resistente? Qual o significado desse versículo?
7. Fazer de memória, pelo menos 20 dos nós abaixo, falando ao avaliador o nome, para que serve e sua limitações:
  a) Nó simples
  b) Nó Direito
  c) Nó Torto (Nó cego, ou Nó Esquerdo)
  d) Lais de Guia (nó bolina)
  e) Lais de Guia de Correr (Lais de Guia Corrediço)
  f) Lais de Guia Duplo
  g) Nó de azelha
  h) Nó Borboleta
  i) Catau
  j) Nó de Correr (nó corrediço)
  k) Nó de Carrasco (de Forca)
  l) Nó Cirurgião
  m) Nó Cirurgião duplo
  n) Nó de Escota
  o) Nó de Espia (nó ordinário ou nó de ajuste ou calabrote dobrado)
  p) Nó de Espia Duplo (nó ordinário duplo)
  q) Nó gancho dobrado
  r) Nó gravata
  s) Nó de Pescador
  t) Nó de Pescador Duplo
  u) Nó encapeladura (nó de algema)
  v) Nó Fateixa
  w) Nó Oito
  x) Nó Oito duplo
  y) Nó Volta do Gato (nó Pata de Gato)
  z) Nó Prussik
  {) Nó Quadrado
  |) Nó UIAA (Nó meia volta do fiel)
  }) Volta de Fiel
  ~) Constritor (nó de contração ou volta da fiel duplo)
  ) Volta da Ribeira
  ) Volta do salteador
  ) Volta esticada
  ) Volta paradora
  ) Nó de caminhoneiro
  ) Cadeira de Bombeiro (catau de marinheiro)
8. Quais nós podem ser usados para se iniciar uma amarra?
9. Fazer corretamente as seguintes amarras:
  a) Amarra quadrada
  b) Amarra diagonal
  c) Amarra paralela ou redonda
  d) Amarra simples
10. Fazer um quadro com, pelo menos, 25 nós.
## Referências'),
('AR-041', 'Arco e Flecha - avançado', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-041.webp', 'https://mda.wiki.br/Especialidade_de_Arco_e_Flecha_-_avançado', '1. Ter a especialidade de Arco e flecha.
2. Identificar visualmente e saber apenas a função principal destes componentes:
  a) Esquadro do arco
  b) Bow Sight (mira do arco)
  c) Peep Sight (alça de mira)
  d) Estabilizador
  e) Cliker bow (clicador)
  f) Bow Level (nivelador)
  g) Penas Plásticas
  h) Flip Rest (descanso de Flecha regulável)
3. Em desenho simples, mostrar a influência da flexibilidade da flecha (arrow spine) durante o disparo.
4. Demonstrar como encordoar corretamente um arco. Explicar, pelo menos, 2 técnicas para encordoar o arco com segurança.
5. Conhecer, pelo menos, 3 diferentes técnicas para retesar o arco e demonstrar 2 destas com 3 disparos para cada técnica.
6. Consultando os manuais ou técnicos de arco e flecha disponíveis, pesquisar sobre a correção de problemas nos seguintes tópicos:
  a) Postura Corporal
  b) Empunhadura
  c) Largada
  d) Ancoragem
7. Estabelecer uma rotina de prática de tiro com arco e flecha, no mínimo 3 horas por dia, 3 vezes por semana, durante 8 semanas seguidas, mantendo um controle de sua pontuação.
8. Relacionar as diferenças e as normas de segurança para competições Indoor e Outdoor.
9. Usando um arco Recurvo, alcançar uma das seguintes pontuações:
  a) Indoor: 30 flechas (6 séries deS flechas)a 18 metros de distância, marcar l00 pontos em um alvo de 40 cm.
  b) Outdoor: 30 flechas (6 séries de 5 flechas) a 25 metros de distância, marcar 150 pontos em um alvo de 60 cm.'),
('AR-042', 'Ciclismo - avançado', 'atividades-recreativas', 'especialidade', 2, 1976, 'Associação Geral', '/esp/ar-042.webp', 'https://mda.wiki.br/Especialidade_de_Ciclismo_-_avançado', '1. Ter a especialidade de Ciclismo.
2. Descrever como selecionar o tamanho certo de quadro e guidom e altura do selim, de forma que se adapte da melhor forma ao tamanho do ciclista.
3. Descrever as características de uma bicicleta usada para percursos de longa distância.
4. Revisar as regras de segurança que devem ser observadas no ciclismo.
5. Conhecer o vestuário e equipamento de segurança usados no ciclismo, e as vantagens de cada um.
6. Fazer uma lista dos equipamentos que devem ser levados em uma excursão ciclística de mais de um dia.
7. Desmontar, limpar e montar novamente os apoios das rodas traseira e dianteira.
8. Alinhar a roda traseira, certificando-se de que está montada adequadamente.
9. Selecionar a melhor combinação de rodas dentadas para corrente traseira e dianteira, de forma a obter os melhores resultados nas condições a seguir:
  a) Rodar em terreno montanhoso
  b) Carregar pacotes na bicicleta
  c) Rodar em terreno plano
10. Explicar como as características de rodagem de uma bicicleta são afetadas pela:
  a) Geometria do quadro da bicicleta, incluindo:
    1. Ângulos do cano dianteiro e do selim
    2. Tamanho do garfo
    3. Ajuste do guidom
    4. Peso máximo para a garupa
    5. Tamanho da base da roda
  b) O tipo de rodas usadas, incluindo:
    1. Pneus tubulares ou denteados
    2. Eixos de rodas grandes ou pequenos
    3. Número de raios utilizados em cada roda
    4. Número de raios que cada raio cruza
11. Cumprir um dos seguintes:
  a) Fazer três passeios de 35 quilômetros cada, em locais diferentes.
  b) Rodar 160 quilômetros consecutivos em um dia;
  c) Fazer um passeio ciclístico de, pelo menos, 200 quilômetros, em três dias e escrever um relatório sobre a viagem.'),
('AR-043', 'Ginástica Acrobática', 'atividades-recreativas', 'especialidade', 2, 1976, 'Associação Geral', '/esp/ar-043.webp', 'https://mda.wiki.br/Especialidade_de_Ginástica_Acrobática', '1. Relacionar as precauções de segurança que devem ser seguidas por cada ginasta.
2. Descrever as posições básicas:
  a) Agache
  b) Tronco flexionado
  c) Hiperextensão
  d) Posição com as pernas abertas
  e) Extensão
  f) Grupada
  g) Carpada
3. Realizar as seguintes acrobacias com técnica e movimentos elegantes:
  a) Agachado, fazer rolamento de frente, na posição grupada
  b) Fazer rolamento de frente, na posição carpada
  c) Rolamento com salto (igual à altura do ginasta)
  d) Rolamento de costas, partindo da posição com pernas abertas
  e) Parada sobre cabeça
  f) Parada sobre as mãos
4. Executar 6 dos seguintes exercícios, com movimentos elegantes, com uma segunda pessoa:
  a) Parada de pé sobre os joelhos
  b) Parada com apoio no tronco
  c) Parada com apoio duplo
  d) Parada sobre ombros
  e) Apoio horizontal combinado
  f) Prancha alta (extensão horizontal acima das mãos da pessoa em hiper extensão).'),
('AR-044', 'Ginástica Acrobática - avançado', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-044.webp', 'https://mda.wiki.br/Especialidade_de_Ginástica_Acrobática_-_avançado', '1. Ter a especialidade de Ginástica acrobática.
2. Exercitar com boa forma os seguintes exercícios individuais:
  a) Kippe
  b) Roda (2 mãos e 1 mão)
  c) Reversão simples
  d) Flic-flac
  e) Rodante
3. Realizar 4 das acrobacias individuais a seguir, com técnica e movimentos elegantes:
  a) Mortal para frente
  b) Salto para frente com apoio de cabeça
  c) Flic-flac com um braço
  d) Roda sem as mãos
  e) Reversão com uma perna
  f) Ponte de frente
  g) Ponte de costas
  h) Reversão livre
  i) Mortal com parafuso
  j) Rolamento saindo da parada de 2 apoios (parada de mão)
  k) Ponte simples saindo da parada de 2 apoios (parada de mão)
4. Realizar 3 dos exercícios de equilíbrio a seguir, com técnica e movimentos elegantes:
  a) Parada de 2 apoios (parada de mão) saindo da posição de parada de 3 apoios (parada de cabeça)
  b) Parada com uma mão (alternativa para moças: ponte de costas com parada de 3 apoios - parada de cabeça)
  c) Rolamento, parada de 2 apoios (de mão) e giro de 360°
  d) Prancha com dois braços (alternativa para moças: posição de parada de 2 apoios de mãos - descer ao apoio livre-esquadro em ângulo agudo)
  e) Prancha com um braço (alternativa para moças: giro de 360° na parada de 2 apoios - parada de mãos)
  f) Parada de 2 apoios (parada de mãos) com pernas cruzadas (yoga)
  g) Parada de 2 apoios (parada de mãos) iniciada de apoios de frente (alternativa para moças: parada de 2 apoios (parada de mãos) com esquadro afastado)
5. Executar com boa forma 3 dos seguintes exercícios duplos (no caso de duplo masculo-feminino, o homem deve servir de base).
  a) Lançamento de costas
  b) Parada sobre braços (baixo)
  c) Parada sobre braços (alto)
  d) Parada sobre mãos (baixo)
  e) Parada sobre mãos (alto)
  f) Esquadra em ângulo sobre mãos (baixo)
6. Executar qualquer uma das seguintes combinações, com boa forma.
  a) Rodante, flic-flac, rolamento de costas
  b) Rodante - dois flic-flac
  c) Mortal para frente - flic-flac
  d) Rodante - rolamento de costas - flic-flac
  e) Mortal com parafuso - rolamento de frente
  f) Rolamento de costas'),
('AR-045', 'Liderança na Selva', 'atividades-recreativas', 'especialidade', 2, 1976, 'Associação Geral', '/esp/ar-045.webp', 'https://mda.wiki.br/Especialidade_de_Liderança_na_Selva', '1. Ter as seguintes especialidades de Primeiros socorros - intermediário e Resgate básico
2. Descrever quais princípios de saúde, de segurança e regras de conduta devem ser usados durante uma atividade em ambiente silvestre. Colocar em pratica estes princípios em uma atividade (acampamento, caminhada, etc.) com um grupo de jovens ou desbravadores.
3. Conhecer e demonstrar pelo menos três métodos de sinalizar quando em perigo.
4. Ajudar no planejamento e execução de uma simulação, em meio a floresta ou mata, do seguinte:
  a) Resgate de uma pessoa ferida
  b) Resgate de uma pessoa perdida
5. Demonstrar as habilidades necessárias para a liderança na selva e em uma das regiões a seguir:
  a) Tropical
  b) Desértica
  c) Pantanosa
  d) Montanhosa
  e) Floresta temperada
  f) Ártica
6. Qual a diferença entre acampamento na selva e acampamento em campo aberto? Que cuidados especiais devem ser tomados com relação à preservação da natureza? Fazer um relatório da atividade prática deste requisito.
7. Conhecer e saber como preparar e comer, pelo menos, 3 plantas silvestres comestíveis encontradas na sua região.
8. Fazer um relatório baseado na vida de dois dos personagens abaixo, destacando algumas qualidades de liderança manifestada na vida deles:
  a) Moisés
  b) Davi
  c) Elias
  d) Josué
  e) João Batista
9. Liderar um grupo num acampamento de fim de semana em meio à mata(floresta), aplicando os princípios e habilidades aprendidos nesta especialidade.'),
('AR-046', 'Liderança na Selva - avançado', 'atividades-recreativas', 'especialidade', 3, 1976, 'Associação Geral', '/esp/ar-046.webp', 'https://mda.wiki.br/Especialidade_de_Liderança_na_Selva_-_avançado', '1. Ter a especialidade de Liderança na selva.
2. Ter as seguintes especialidades:
  a) Plantas silvestres comestíveis
  b) Vida silvestre
  c) Liderança campestre
3. Durante um acampamento na mata, demonstrar como se camuflar e rastrear uma trilha deixada por seu instrutor.
4. Antes de iniciar uma expedição na selva, quais os preparativos físicos e mentais são necessários? Montar um programa para o período de preparo. Fazer um relatório de como você se preparou a cada dia contendo período de preparação, tipos de exercícios e tempo gasto.
5. Demonstraras habilidades necessárias para a liderança na selva em duas das regiões a seguir - as regiões escolhidas devem ser diferentes das que você optou na especialidade Liderança na Selva.
  a) Tropical
  b) Desértica
  c) Pantanosa
  d) Montanhosa
  e) Floresta temperada
  f) Ártica
6. Fazer um desenho ou maquete de dois tipos de armadilhas ou ciladas. Construí-las em tamanho real demonstrando seu funcionamento.
7. Relacionar quais preparativos deve-se tomar para empreender um acampamento em cada um dos lugares a seguir, considerar equipamento, vestimenta, alimentação, etc.:
  a) Em montanhas
  b) Na água
  c) Glacial
  d) Na neve
8. Fazer uma redação citando os princípios para o desenvolvimento de uma fé na liderança divina, similar ao que o salmista demonstrou no Salmo 91.
9. Saber quais providências devem ser tomadas para a sobrevivência na selva.
10. Ensinar uma das especialidades mencionadas no item 1 da especialidade Liderança na Selva.
11. Construir um abrigo a partir de material natural, mas não vivo (por exemplo, uma cabana feita de galhos secos) e passar pelo menos um pernoite nela.
12. Planejar e participar de pelo menos dois acampamentos na selva, com pelo menos 2 pernoites cada, aplicando os princípios e habilidades aprendidos nesta especialidade.'),
('AR-047', 'Ordem Unida', 'atividades-recreativas', 'especialidade', 1, 1976, 'Associação Geral', '/esp/ar-047.webp', 'https://mda.wiki.br/Especialidade_de_Ordem_Unida', '1. Explicar, pelo menos, cinco objetivos da ordem unida.
2. Definir os seguintes termos:
  a) Formação
  b) Linha
  c) Fila / Fileira
  d) Distância
  e) Intervalo
  f) Coluna
  g) Alinhamento
  h) Cobertura
  i) Cerra-fila
  j) Homem base
  k) Coluna base
  l) Testa
  m) Retaguarda ou Cauda
  n) Cadência
  o) Última forma
3. Descrever os quatro tipos de passos a seguir. Saber executar corretamente todos eles:
  a) Passo estrada
  b) Passo ordinário
  c) Passo acelerado
  d) Sem cadência
4. Quais são as três etapas da voz de comando?
5. Executar corretamente os seguintes movimentos a pé firme:
  a) Atenção
  b) Sentido
  c) Cobrir
  d) Firme
  e) Sentado / de pé 1,2
  f) Perfilar
  g) Direita volver
  h) Olhar à Direita
  i) Olhar à Esquerda
  j) Olhar Frente
  k) Esquerda volver
  l) Meia volta volver
  m) Sem intervalo, cobrir
  n) Firme
  o) Descansar
  p) Frente para a retaguarda
  q) Frente para a esquerda
  r) Frente para a direita
  s) Fora de forma, Marche
  t) A vontade / atenção
6. Executar corretamente os seguintes movimentos em deslocamento (passo ordinário):
  a) Ordinário marche
  b) Alto
  c) Marcar passo
  d) Em frente
  e) Em direção à direita, marche
  f) Em direção à esquerda, marche
  g) Olhar à direita
  h) Olhar frente
  i) Olhar à esquerda
  j) Direita volver
  k) Esquerda volver
  l) Meia volta volver
  m) Trocar passo
  n) Alto
  o) 5 passos em frente, marche'),
('AR-048', 'Ordem Unida - avançado', 'atividades-recreativas', 'especialidade', 2, 1976, 'Associação Geral', '/esp/ar-048.webp', 'https://mda.wiki.br/Especialidade_de_Ordem_Unida_-_avançado', '1. Ter a especialidade de Ordem unida.
2. Saber como e quando usar as posições básicas do banderim de unidade na execução dos comandos de ordem unida.
3. Com um bandeirim de unidade, executar corretamente a seguinte sequência de comandos:
  a) Sentido
  b) Cobrir
  c) Firme
  d) Direita volver
  e) Esquerda volver
  f) Ordinário marche
  g) Alto
  h) Descansar
4. Cumprir o seguinte:
  a) Ser membro ativo de um pelotão de ordem unida por, pelo menos, 1 mês
  b) Ter participado de, pelo menos, 2 apresentações de ordem unida nos últimos 12 meses, em um evento do clube, igreja ou da comunidade
5. Demonstrar habilidade para manter o passo quando em forma com um pelotão em deslocamento demonstrando completo sincronismo com o grupo, em todos os momentos.
6. Como membro de pelotão de ordem unida, fazer 4 séries de exercícios de precisão (evolução). Os comandos devem ser baseados nos comandos regulamentares de ordem unida. Incluir comandos combinados.
7. Revisar as 3 etapas da voz de comando.
8. Ensinar a um grupo de pelo menos 4 pessoas os comandos básicos de ordem unida (movimentos a pé firme e em deslocamento)
9. Comandar todos os membros de um Clube de Desbravadores em, pelo menos, 10 movimentos de ordem unida.
10. Participar de uma cerimonia de hasteamento e arriamento da bandeira nacional com ajuda de uma unidade.'),
('AR-049', 'Atletismo', 'atividades-recreativas', 'especialidade', 2, 1978, 'Associação Geral', '/esp/ar-049.webp', 'https://mda.wiki.br/Especialidade_de_Atletismo', '1. Fazer um relatório contendo as regras básicas, orientações de segurança e exercícios de aquecimento.
2. Responder o seguinte:
  a) Quais as roupas apropriadas, incluindo tênis, para corridas de longas distâncias?
  b) Em média, qual o comprimento de uma pista de corrida?
  c) Qual a distância percorrida numa maratona?
  d) Qual a posição apropriada dos braços e cabeça durante uma prova de distância?
  e) Qual a maneira correta de respirar?
  f) Quais as diferenças de correr numa pista e correr numa trilha ou estrada?
  g) Durante uma corrida rápida, qual parte do pé deve tocar o chão primeiro durante a passada? Qual é a posição correta dos braços e da cabeça?
3. Participar das seguintes competições de atletismo:
  a) Correr 50 metros rasos no tempo correspondente ao seu sexo e idade:
1. Ler I Coríntios 9:24-27. Por que o apostolo Paulo compara o cristão com um atleta?'),
('AR-050', 'Acampamento I', 'atividades-recreativas', 'especialidade', 1, 1986, 'Associação Geral', '/esp/ar-050.webp', 'https://mda.wiki.br/Especialidade_de_Acampamento_I', '1. Explicar e praticar o lema: "não levar nada além de fotos, não deixar nada além de pegadas, não matar nada além do tempo".
2. Relacionar os objetos pessoais necessários para um acampamento de fim de semana. Descrever a roupa apropriada para dormir e como manter-se aquecido durante a noite.
3. Saber organizar adequadamente a sua mochila de acampamento.
4. Descrever as vantagens e desvantagens das opções de equipamentos para dormir (colchonete, colchão inflável, saco de dormir, etc.).
5. Participar de um acampamento de final de semana, com no mínimo 2 pernoites.
6. Montar uma barraca corretamente. Conhecer as regras de segurança sobre o local de montar o acampamento.
7. Conhecer e praticar os princípios de higiene em um acampamento.
8. Cumprir o seguinte durante o acampamento:
  a) Demonstrar habilidade para escolher o local e preparar uma fogueira.
  b) Conhecer e praticar as regras de segurança para mexer com fogo.
  c) Fazer e acender uma fogueira sem uso de combustíveis
  d) Demonstrar como proteger a lenha que será usada em fogueiras, em caso de chuva ou mau tempo.
  e) Descrever como manter os utensílios de cozinha limpos.
  f) Fazer e comer pão no espeto em uma das refeições do acampamento.
9. Saber usar corretamente um canivete e uma machadinha. Conhecer e demonstrar regras de segurança no uso destas ferramentas.'),
('AR-051', 'Acampamento II', 'atividades-recreativas', 'especialidade', 1, 1986, 'Associação Geral', '/esp/ar-051.webp', 'https://mda.wiki.br/Especialidade_de_Acampamento_II', '1. Ter, no mínimo, 11 anos.
2. Participar num acampamento de um final de semana com no mínimo 2 noites.
3. Demonstrar como escolher um local adequado para montar uma barraca e depois montá-la corretamente.
4. Cumprir o seguinte durante o acampamento:
  a) Conhecer as opções de fogueira para se cozinhar e montar uma dessas fogueiras.
  b) Explicar como manter os alimentos frescos sem o uso de equipamentos elétricos.
  c) Preparar, no mínimo, uma refeição principal (exceto café da manhã) em um acampamento de final de semana.
5. Saber usar corretamente um machado ou facão. Conhecer e demonstrar regras de segurança no uso destas ferramentas.
6. Participar em um culto durante o acampamento em uma das seguintes atividades:
  a) Devocional
  b) Louvor
  c) Pôr do Sol'),
('AR-052', 'Acampamento III', 'atividades-recreativas', 'especialidade', 1, 1986, 'Associação Geral', '/esp/ar-052.webp', 'https://mda.wiki.br/Especialidade_de_Acampamento_III', '1. Ter, no mínimo, 12 anos.
2. Revisar seis pontos importantes na seleção de um bom local de acampamento.
3. Participar de um acampamento de final de semana com no mínimo 2 pernoites.
4. Demonstrar habilidade para montar e prender firmemente uma barraca. Explicar como ocorrer a condensação numa barraca e como preveni-la.
5. Cumprir o seguinte durante um acampamento:
  a) Construir as seguintes fogueiras e explicar seu uso: estrela, caçador, refletor. Rever as normas de segurança para a construção de fogueiras;
  b) Conhecer 3 maneiras de acender uma fogueira sem uso de fósforos e acender uma fogueira usando um dos seguintes métodos: Pedra de fogo, Fricção, Centelha, Lente de vidro, Fósforo de metal, Ar comprimido, pederneira.
  c) Preparar, no mínimo, 2 refeições principais diferentes em um acampamento de final de semana.
6. Saber usar corretamente uma cavadeira ou picareta. Conhecer e demonstrar regras de segurança no uso destas ferramentas.
7. Demonstrar quatro amarras básicas e construir 2 moveis de acampamento usando estas amarras. Exemplo de moveis: mesa, banco/banquinho, lixeira, varal, sapateira, latrina, chuveiro, pia, prateleira, etc.
8. Participar, em um culto durante o acampamento, em uma das seguintes atividades:
  a) Devocional
  b) Estudo da lição da Escola Sabatina
  c) História
  d) Testemunho
  e) Louvor
  f) Sermão/sermonete
  g) Pôr do Sol'),
('AR-053', 'Acampamento IV', 'atividades-recreativas', 'especialidade', 2, 1986, 'Associação Geral', '/esp/ar-053.webp', 'https://mda.wiki.br/Especialidade_de_Acampamento_IV', '1. Ter, no mínimo, 13 anos.
2. Escrever uma redação de 200 palavras sobre como preservar a natureza em acampamento.
3. Participar de um acampamentos de final de semana, com no mínimo 2 pernoites.
4. Demonstrar habilidade para montar e prender firmemente uma barraca, bem como limpá-la, dobrá-la e guardá-la. Praticar as regras de segurança ao escolher o local para se montar uma barraca.
5. Cumprir o seguinte durante o acampamento:
  a) Explicar como iniciar um fogo sob chuva, onde conseguir material para a "mecha" que acenderá o fogo e como manter o fogo aceso.
  b) Explicar quais madeiras são mais adequadas para se acender rapidamente uma fogueira e para fazer brasas para cozinhar.
  c) Demonstrar como cortar lenha.
  d) Planejar um cardápio ovolactovegetariano para um acampamento de 2 dias.
  e) Preparar, no mínimo, 4 refeições principais em um acampamento de final de semana
  f) Demonstrar como cuidar adequadamente dos alimentos e como protegê-los de animais.
6. Explicar, pelo menos, 3 maneiras de se purificar a água em um acampamento. Purificar um pouco de água no acampamento usando uma dessas maneiras.
7. Saber afiar uma faca/canivete e um machado/Machadinha. Conhecer e demonstrar regaras de segurança ao manusear e afiar estas ferramentas.
8. Revisar as 4 amarras básicas e construir 2 moveis de acampamento usando estas amarras. Exemplo de moveis: mesa, banco/banquinho, lixeira, varal, sapateira, latrina, chuveiro, pia, prateleira, etc.
9. Planejar e conduzir uma atividade criativa apropriada para o sábado.'),
('AR-054', 'Esqui Cross Country', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-054.webp', 'https://mda.wiki.br/Especialidade_de_Esqui_Cross_Country', '1. Relacionar e descrever as principais características, qualidades e tamanhos dos seguintes equipamentos de esqui cross country:
  a) Esquis
  b) Prendedores
  c) Calçados
2. Descrever os cuidados necessários para usar os equipamentos do requisito anterior, tanto quanto à armazenagem como ao uso durante o percurso.
3. Que consideração deve ser feita ao selecionar as roupas para serem usadas enquanto pratica esqui cross country? Quais são as características que você deve procurar quando seleciona um pacote de turismo que inclui esqui cross country?
4. Explicar o propósito de encerar os esquis. Explicar a necessidade de diferentes tipos de ceras para diferentes tipos de neve e temperatura.
5. Explicar as precauções básicas de segurança para esquiar ne5ta modalidade.
6. Conhecer e explicar as regras oficiais de equi cross country.
7. Demonstrar capacidade de esquiar, fazendo o seguinte:
  a) Participar de 3 trilhas com diferentes percursos de 6 Km cada, com outro indivíduo. Se possível, com diferentes condições de neve.
  b) Fazer um percurso de 10 Km com diversos tipos de terreno.
  c) Durante todos os passeios, transportar com segurança o equipamento necessário, usar vestuário adequado para as condições climáticas, comprovar capacidade de manter a temperatura corporal adequada, o corpo seco e condição saudável.'),
('AR-055', 'Excursionismo Pedestre - avançado', 'atividades-recreativas', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/ar-055.webp', 'https://mda.wiki.br/Especialidade_de_Excursionismo_Pedestre_-_avançado', '1. Ter a especialidade de Excursionismo pedestre.
2. Participar na formação de um grupo de desbravadores na especialidade de Excursionismo Pedestre, ensinando, pelo menos, 2 requisitos.
3. Auxiliar na organização e acompanhar uma pessoa (ou um grupo) no cumprimento de pelo menos duas das caminhadas do requisito 10 da especialidade de Excursionismo Pedestre.
4. Fazer um conjunto de anotações para a especialidade de Excursionismo Pedestre que podem ser usadas por quem estiver fazendo aquela especialidade.
5. Fazer uma apresentação de, no mínimo, 10 minutos sobre as habilidades que você adquiriu enquanto participava de caminhadas de excursionismo pedestre com os desbravadores.
6. Completar um dos itens abaixo:
  a) 3 caminhadas de 16 quilômetros em percurso e datas diferentes
  b) 2 caminhadas de, no mínimo, 24 quilômetros e duração de 2 dias e 1 noite, em região de mata, floresta ou agreste
  c) Uma caminhada de, no mínimo, 42 quilômetros e duração de 3 dias e 2 noites em região de mata, floresta ou agreste
7. Apresentar um relatório de cada caminhada contendo:
  a) Datas
  b) Mapa com detalhamento do percurso
  c) Tempo de caminhada
  d) Condições climáticas
  e) Considerações interessantes
  f) Pontos interessantes observados
  g) Se possível, foto do grupo que participou
8. Fazer, pelo menos, 2 breves apresentações sobre caminhadas em história bíblicas.'),
('AR-056', 'Excursionismo Pedestre com Mochila', 'atividades-recreativas', 'especialidade', 2, 1986, 'Associação Geral', '/esp/ar-056.webp', 'https://mda.wiki.br/Especialidade_de_Excursionismo_Pedestre_com_Mochila', '1. Explique o Lema dos Excursionistas: "Da natureza nada se tira além de fotos; não deixar nada a não ser pegadas; não matar nada, a não ser o tempo".
2. Descrever qual tipo de vestuário, calçado e equipamentos que devem ser levados em uma excursão em:
  a) Clima chuvoso
  b) Clima quente
  c) Clima frio
3. Descrever o que se deve levar em consideração na hora de escolher uma mochila. Em caso de emergência, o que poderá ser usado no lugar da mochila?
4. Relacionar os objetos essenciais para a prática do excursionismo.
5. Relacione, pelo menos, cinco modelos de sacos de dormir. Descreva para qual tipo de clima o mesmo é mais adequado.
6. Demonstrar como arrumar uma mochila adequadamente.
7. Faça o seguinte:
  a) Relacione qual o melhor tipo de alimento para um excursionista.
  b) Dos alimentos do item anterior, quais são encontrados em supermercado?
  c) Preparar um cardápio adequado para uma excursão de dois dias com um pernoite.
  d) Demonstrar como embalar os alimentos que serão colocados na mochila de forma a ocupar pouco espaço.
  e) Preparar um lanche para a caminhada.
8. Conhecer os métodos de prevenção e tratamento para:
  a) Queimadura de sol;
  b) Bolhas (calosidades);
  c) Hipotermia;
  d) Insolação;
  e) Exaustão;
  f) Picadas de cobra;
  g) Cólicas;
  h) Desidratação;
  i) Câimbra.
9. Relacionar os itens necessários para um kit de primeiros socorros a ser levado em uma excursão. Ter esse kit disponível na excursão realizada no cumprimento desta especialidade.
10. De acordo com seu peso, qual o peso máximo que você deveria carregar?
11. Sem o uso de uma bússola, saber pelo menos três métodos de encontrar os pontos cardeais. Demonstrar dois destes métodos na prática.
12. Demonstrar o jeito correto de colocar e tirar uma mochila sozinho e com a ajuda de um companheiro.
13. Participar numa excursão de fim de semana com caminhada de pelo menos oito quilômetros. As refeições deverão ser cozidas durante a excursão (Use o conhecimento adquirido no item 7)'),
('AR-057', 'Liderança Campestre', 'atividades-recreativas', 'especialidade', 2, 1986, 'Associação Geral', '/esp/ar-057.webp', 'https://mda.wiki.br/Especialidade_de_Liderança_Campestre', '1. Ter duas das especialidades a seguir:
  a) Acampamento IV;
  b) Fogueiras e cozinha ao ar livre;
  c) Mapa e bússola;
  d) Pioneirismo;
  e) Pioneirias;
  f) Primeiros socorros - básico.
2. Através do estudo da Bíblia e do Espírito de Profecia, aprender como as atividades ao ar livre influenciaram os seguintes personagens bíblicos:
  a) Moisés;
  b) Davi;
  c) Elias;
  d) João Batista;
  e) Jesus.
3. Ensinar a um grupo de desbravadores como preservar e cuidar da natureza, abordando os seguintes tópicos:
  a) Segurança do acampamento;
  b) Segurança contra incêndios;
  c) Saneamento;
  d) Descarte correto do lixo;
  e) Segurança no uso das fontes de água;
  f) Regras de conduta.
4. Conhecer pelo menos 10 qualidades de um bom líder de desbravadores.
5. Saber o que fazer para superar o medo quando estiver perdido. Conhecer pelo menos quatro maneiras de sinalizar pedidos de socorro se estiver perdido.
6. Descrever pelo menos quatro atividades seculares e quatro atividades específicas para o sábado, para serem usadas ao ar livre, inclusive em um dia chuvoso.
7. Completar o seguinte ao ar livre:
  a) Planejar, organizar e ensinar uma das seguintes especialidades a um grupo de desbravadores: Acampamento I, Acampamento II, Acampamento III, Acampamento IV, Arte de acampar ou Fogueiras e cozinha ao ar livre;
  b) Saber onde fica o hospital mais próximo;
  c) Saber onde fica o posto policial/delegacia de polícia mais próximo, ou sede de fiscais em um parque que está sendo visitado.'),
('AR-058', 'Liderança Campestre - avançado', 'atividades-recreativas', 'especialidade', 3, 1986, 'Associação Geral', '/esp/ar-058.webp', 'https://mda.wiki.br/Especialidade_de_Liderança_Campestre_-_avançado', '1. Ter a especialidade de Liderança campestre.
2. Ter as especialidades de Primeiros socorros - intermediário e Reanimação cardiopulmonar.
3. Esboçar sua filosofia de conduta na natureza. Participar num projeto de conservação da natureza de uma a três horas.
4. Conhecer as características do desenvolvimento das crianças e adolescentes, por faixa etária, em cada uma das áreas a seguir:
  a) Física;
  b) Emocional;
  c) Mental;
  d) Espiritual.
5. Ensinar uma especialidade do Mestrado em vida campestre a um grupo de desbravadores.
6. Planejar, organizar e realizar duas das atividades a seguir durante um final de semana, com um grupo de desbravadores:
  a) Retiro espiritual ao ar livre;
  b) Passeio de canoa;
  c) Passeio ciclístico;
  d) Passeio a cavalo;
  e) Caminhada com mochila.
7. Preparar esboços e apresentar seis diferentes cultos/momentos de meditação criativos a serem apresentados em acampamentos.
8. Desenvolver um plano de busca e resgate para um local específico. Relacionar equipamentos específicos que podem ser necessários para a comunicação, primeiros socorros e transporte apropriado das vítimas para o local escolhido.'),
('AR-059', 'Pipas', 'atividades-recreativas', 'especialidade', 1, 1986, 'Associação Geral', '/esp/ar-059.webp', 'https://mda.wiki.br/Especialidade_de_Pipas', '1. Responda o seguinte:
  a) Quando foram inventadas as pipas?
  b) Qual a primeira vez que alguém empinou uma pipa?
  c) Citar pelo menos três maneiras através das quais as pipas ajudaram pesquisas científicas e contar como cada uma delas afetou o mundo em que vivemos.
  d) Contar a história de Benjamim Franklin e sua pipa.
2. Mencionar algumas formas pelas quais as pipas podem ser utilizadas hoje em dia.
3. Explicar como as pipas ficam no ar.
4. Defina os seguintes termos:
  a) pipa
  b) linha
  c) vento bom
  d) estirante
  e) rabiola
  f) armação
  g) carretel
5. Qual é uma causa comum das pipas apresentarem defeitos?
6. O que deve ser feito quando uma pipa não para de dar voltas enquanto está sendo empinada?
7. Por que às vezes é necessário ter uma rabiola na pipa?
8. Conhecer pelo menos três regras de segurança para empinar pipas. Saber em seu país se existe lei proibindo uso de cerol (cortante) e o porquê.
9. Citar pelo menos 3 tipos de acidentes que podem ser provocados por causa do uso do cerol(cortante).
10. Patricar como enrolar a linha num pedaço de madeira. Saber emendar a linha com o nó de pescador.
11. Fazer dois dos seguintes tipos de pipas e empiná-las.
  a) Pipa trenó
  b) Pipa Asa Delta
  c) Pipa Diamante
  d) Pipa Arraia
  e) Pipa Tetraédrica
  f) Pipa Plana
  g) Pipa Caixote'),
('AR-060', 'Skate', 'atividades-recreativas', 'especialidade', 2, 1986, 'Divisão do Sul do Pacífico', '/esp/ar-060.webp', 'https://mda.wiki.br/Especialidade_de_Skate', '1. Saber usar corretamente os equipamentos a seguir e porque eles devem ser usados quando se pratica skate:
  a) Capacete
  b) Cotoveleiras
  c) Joelheiras
  d) Calçados
  e) Luvas
  f) Munhequeira
2. Identificar e nomear cada parte e peça de um skate.
3. Desmontar e remontar completamente um skate, recolocar os rolamentos e apertar as porcas das rodas e porcas do pivô central na tensão correta.
4. Demonstrar, pelo menos, 10 manobras de skate das relacionadas abaixo. As manobras deverão ser feitas diante de um instrutor que as conheça, o qual deverá avaliar a correta execução. Executar, pelo menos, 5 manobras diferentes das primeiras em uma rampa de skate.
  a) Ollie
  b) Wheelie (manual) por 10 metros
  c) Nose Wheelie (nose manual) por 10 metros
  d) C-Turn
  e) 180 graus
  f) 180° varial corpo
  g) 360 Spin
  h) Grab Rail
  i) Leap Board
  j) Vire downhill
  k) Kickflip
  l) Impossible Duplo
  m) No Comply Kickflip
  n) Kickflip Fakie
  o) Kickflip Switch
  p) Fakie Bigspin
  q) Nollie Kickflip
  r) Nollie Heelflip
  s) Nollie Frontside 180 bigspin
  t) Varial Kickflip
  u) Heelflip Varial
  v) Backside Kickflip 180
  w) Frontside Heelflip 180
  x) Frontside Kickflip 180
  y) 360 e Kickflip
  z) Frontside duplo'),
('AR-061', 'Windsurf', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-061.webp', 'https://mda.wiki.br/Especialidade_de_Windsurf', '1. Ter a especialidade de Natação intermediário I.
2. Aprender o significado dos seguintes termos:
  a) Linha do vento
  b) Vento pelo través
  c) Vento aparente
  d) Controle da prancha
  e) Barlavento
  f) Sotavento
  g) Posição de mastro
  h) Arribar
  i) Jibe
  j) Bolina
  k) Empopada
  l) Linha de centro
  m) Frente
  n) Orçar
  o) Mão de mastro
  p) Panejo da vela
  q) Auto salvamento
  r) Técnica tesoura
  s) Corda
  t) Uphaul
  u) Decoração do barco
  v) Ponto de referência visual
3. Conhecer as partes da prancha e demonstrar como montar a vela.
4. Explicar os passos básicos da atividade de velejar.
5. Definir e demonstrar a posição inicial básica.
6. Definir e demonstrar 4 passos necessários para bordejar.
7. Definir e demonstrar 4 passos necessários para marcar ou bandear.
8. Relacionar os 7 passos iniciais usados para fazer com que a prancha movimente-se sobre a água.
9. Responder as seguintes perguntas sobre segurança:
  a) Que equipamento de segurança deve ser usado ao se praticar o windsurf?
  b) Por que é importante saber a previsão do tempo antes de entrar na água?
  c) Ao começar a aprender o windsurf, por que é importante estar numa área fechada?
  d) Quais os sinais de mão que significam "está tudo bem" e "preciso de ajuda"?
10. Que cuidados devem ser dispensados à vela e à prancha para melhor conservá-las?
11. Velejar com uma prancha de windsurf até um ponto de referência que esteja à vista e, em seguida, voltar à posição inicial.'),
('AR-062', 'Numismática - avançado', 'atividades-recreativas', 'especialidade', 3, 1998, 'Associação Geral', '/esp/ar-062.webp', 'https://mda.wiki.br/Especialidade_de_Numismática_-_avançado', '1. Ter a especialidade de Numismática.
2. Selecionar uma moeda ou cédula de sua coleção e apresentar um relatório oral ou escrito da história e do significado da(s) pessoa(s), lugar(es), item(s) ou símbolo(s) encontrados dos dois lados do objeto.
3. Participar de uma reunião de um clube de colecionadores de moedas ou evento organizado por algum centro numismático de seu país e relatar suas experiências. Considerar os itens a seguir:
  a) Nível de conhecimento dos membros, demonstrados pelos diálogos e apresentações.
  b) Idade média dos participantes.
  c) Ideias que poderão ajudar o clube a ampliar seu interesse para um público maior.
  d) Como a organização é para um principiante.
  e) Sugestões sobre como essas pessoas podem ser alcançadas com o evangelho através de uma maneira que eles acham atraente.
4. Selecionar uma das três categorias da sua coleção, conforme previstos nos itens 7 e 8 da especialidade de Numismática e ampliar sua coleção, adquirindo espécimes para dobrá-la.
5. Adicionar para sua coleção, pelo menos, um dos diferentes tipos de "dinheiro" tratados no item 1 da especialidade de Numismática e escrever um parágrafo sobre como, quando e onde isto foi usado como dinheiro.'),
('AR-063', 'Mountain Biking', 'atividades-recreativas', 'especialidade', 5, 1998, 'Divisão Norte Americana', '/esp/ar-063.webp', 'https://mda.wiki.br/Especialidade_de_Mountain_Biking', '1. Ter a especialidade de Ciclismo.
2. Usando uma bicicleta tradicional e uma própria de montanhas, descreva as diferenças entre ambas. Acrescente uma foto ou imagem de cada uma.
3. Demonstrar as funções e vantagens dos seguintes equipamentos:
  a) Chuteiras
  b) Amortecedores
  c) Bar end
4. Relacionar, pelo menos, três tipos de materiais usados na fabricação de quadros de montam bikes. Explicar por que estes materiais são sempre testados.
5. Explicar a diferença entre vias de faixa única, faixa dupla e alta rodagem.
6. Descrever as características de bicicletas com amortecedores (Full Suspension) e rígidas (Hardtail) e explicar as vantagens e desvantagens de um modelo comparado com outro.
7. Descrever que regras básicas de cortesia devem ser seguidas quando se faz trilhas.
8. Relacionar três peças básicas de segurança que devem ser usadas quando praticamos montam biking.
9. Conhecer os ossos que são mais quebrados em acidentes por quem pratica montam biking e saber como prevenir que estes acidentes ocorram.
10. Demonstrar como fazer corretamente a limpeza, polimento e lubrificação de sua bicicleta após usá-la.
11. Completar 2 dos seguintes:
  a) Três corridas de 8 quilômetros
  b) Duas corridas de 15 quilômetros
  c) Uma corrida de 30 quilômetros'),
('AR-064', 'Basquete', 'atividades-recreativas', 'especialidade', 1, 1999, 'Divisão Norte Americana', '/esp/ar-064.webp', 'https://mda.wiki.br/Especialidade_de_Basquete', '1. Conhecer o regulamento atualizado da FIBA (Federação Internacional de Basquete) e relacionar as 8 regras principais do basquete.
2. O que significa a expressão "flair play"?
3. Quais são as diferentes posições no basquete e quais habilidades especificas são necessárias para cada uma delas?
4. Definir ou demonstrar na prática os seguintes termos:
  a) Bola ao ar ou air ball
  b) Tabela
  c) Zona de defesa
  d) Zona de ataque
  e) Linha de fundo
  f) Bloqueio
  g) Passe quicado
  h) Duplo drible
  i) Drible
  j) Finta
  k) Contra-ataque
  l) Cesta
  m) Cinco faltas ? fora
  n) Tabela ou 1,2
  o) Falta de ataque
  p) Falta intencional
  q) Bola ao alto
  r) Garrafão
  s) Falta sem bola
  t) Marcação homem a homem
  u) Perímetro
  v) Cortina
  w) Pressão
  x) Rebote
  y) Arremesso
  z) Roubar a bola
  {) Faltas coletivas
  |) Armadilha ou trap
  }) Andar com a bola
  ~) Bola perdida
  ) Marcação por zona
  ) Pivô
  ) Alas
  ) Armadores
  ) Arremesso com salto
  ) Bandeja
  ) Arremesso de tabela
  ) Enterrada
  ) Gancho
  ) Lance livre
  ) Falta pessoal
  ) Obstrução
  ) Falta técnica
  ) Ponte aérea
  ) Regra dos 3 segundos
  ) Regra dos 8 segundos
  ) Violação de voltar a bola
  ) Violação de entrada
  ) Liga ou campeonato
  ) Arremesso de três pontos
5. Explicar e ilustrar os sinais utilizados pelo arbitro para as seguintes ações no basquete:
  a) Marcação de 1 ponto
  b) Marcação de 2 pontos
  c) Sinalização de tentativa de arremesso de 3 pontos
  d) Marcação de 3 pontos convertidos
  e) Sinal de obstrução
  f) Sinal de agarrar
  g) Sinal de falta dupla
  h) Sinal de falta técnica
  i) Sinal de falta antidesportiva
  j) Sinal de falta desqualificante
  k) Sinal de um lance livre
  l) Sinal de dois lances livres
  m) Sinal de três lances livres
6. Demonstrar habilidade razoável nas seguintes áreas:
  a) Arremessando da linha de lance livre
  b) Arremessando em diferentes posições ao redor da cesta
  c) Driblando
  d) Passando
7. Desenhar em escala uma quadra de basquete com seus limites adequadamente definidos. Informar as dimensões oficiais da tabela e a altura do aro em seu país.
8. Jogar ao menos cinco partidas com a família ou amigos. Mostrar "flair play" durante seus treinos e jogos.'),
('AR-065', 'Futebol', 'atividades-recreativas', 'especialidade', 1, 1999, 'Divisão Norte Americana', '/esp/ar-065.webp', 'https://mda.wiki.br/Especialidade_de_Futebol', '1. Escrever um relatório d uma pagina sobre a historia do futebol em seu país.
2. Escrever um relatório de uma página sobre a história do futebol feminino em seu país.
3. Conhecer o regulamento atualizado da FIFA (Federação Internacional de Futebol) e relacionar as 17 regras principais do futebol.
4. Listar os equipamentos obrigatórios para a prática do esporte.
5. O que significa a expressão "fair play"?
6. Desenhar em escala um campo de futebol com suas linhas e dimensões. Informar as dimensões máximas e mínimas oficiais do campo de futebol em seu país.
7. Quais são as posições do futebol e descrever as habilidades necessárias para cada posição.
8. Conhecer o significado e os sinais dos árbitros para os seguintes:
  a) Impedimento
  b) Agarrão
  c) Pênalti
  d) Escanteio
  e) Tiro livre indireto
  f) Tiro livre direto
  g) Gol
9. Definir os seguintes termos:
  a) Advertência e Expulsão
  b) Artilheiro
  c) Barreira
  d) Bicicleta
  e) Bobinho
  f) Bola ao chão
  g) Bola fora
  h) Cabecear
  i) Caneta
  j) Carrinho
  k) Chapéu ou lençol
  l) Chute de primeira
  m) Craque
  n) Cruzamento
  o) Dominara bola
  p) Drible
  q) Elástico
  r) Embaixadinha
  s) Grande área
  t) Isolar a bola
  u) Lateral
  v) Letra
  w) Marca de escanteio
  x) Marcação
  y) Passe
  z) Passe 1,2 ou tabela
  {) Pedalada
  |) Peixinho
  }) Tiro de canto (escanteio)
  ~) Tiro de meta
  ) Vantagem
  ) Voleio
10. Explicar o que é Video Assistent Referee (VAR - Arbitro Assistente de Vídeo) e em quais situações pode haver intervenção.
11. Realizar as seguintes atividades:
  a) Receber um passe, dominar a bola e devolver ao companheiro
  b) Fazer 10 chutes a gol com um goleiro e ter um aproveitamento de 50%
  c) Correr toda a extensão do campo carregando a bola com os pés
12. Jogar ao menos cinco partidas com a família ou amigos. Mostrar "fair play" durante seus treinos e jogos.'),
('AR-066', 'Equitação - avançado', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-066.webp', 'https://mda.wiki.br/Especialidade_de_Equitação_-_avançado', '1. Ter a especialidade de Equitação.
2. Identificar em desenho de um cavalo, ou ao vivo, pelo menos 30 diferentes partes de um cavalo.
3. Identificar em desenho ou em uma sela e freio:
  a) Western, no mínimo, de 10 peças da sela
  b) Inglês ou Húngara, no mínimo, de 9 partes da sela
  c) Bridão ou Freio, no mínimo, 7 partes
4. Demonstrar e explicar como montar e desmontar um cavalo adequadamente e com segurança, e demonstrar segurança e equilíbrio, permanecendo sentado no cavalo que esteja em pé sobre as patas traseiras.
5. Preparar uma trilha simples, de 3 obstáculos colocados ao nível do chão. Escolher a partir do seguinte:
  a) Passar sobre o tronco ou poste deitado, com altura máxima de 42 centímetros.
  b) Passar entre barrais ou fardos de feno colocados com distância de 120 cm entre si.
  c) Ziguezaguear entre postes colocados a intervalos de 3,6 metros.
  d) Caminhar ao redor de um círculo grande (4,5 m), sair sem pisar ou cruzar quaisquer linhas.
6. Cavalgar um cavalo em passo de marcha, em trilha, durante um mínimo de 8 horas cumulativas.
7. Demonstrar e explicar os 3 tipos de marcha: Trotada, Picada e Batida.'),
('AR-067', 'Geocaching', 'atividades-recreativas', 'especialidade', 2, 2005, 'Divisão Norte Americana', '/esp/ar-067.webp', 'https://mda.wiki.br/Especialidade_de_Geocaching', '1. Definir os seguintes termos:
  a) Geocaching
  b) Receptor GPS
  c) Cache tradicional
  d) Micro-cache
  e) Cache virtual
  f) Multi-caches
  g) Travel bug
2. Conhecer e praticar regras de etiqueta em relação aos Travel Bugs.
3. Quais itens podem ser deixados em um cache e quais não podem?
4. Procurar três caches (pelo menos um deles deve ser um cache tradicional) Localizar o cache por meio de uma das opções abaixo:
  a) Site Geocaching ( http://www.geocaching.com/).
  b) Inserindo as coordenadas em um aparelho GPS
5. Escrever sobre o cache encontrado em seu diário de bordo no site Geocaching.
6. Discutir as medidas de segurança que você deve considerar quando estiver praticando geocaching.'),
('AR-068', 'Geocaching - avançado', 'atividades-recreativas', 'especialidade', 3, 2005, 'Divisão Norte Americana', '/esp/ar-068.webp', 'https://mda.wiki.br/Especialidade_de_Geocaching_-_avançado', '1. Ter a especialidade de Geocaching.
2. Descrever brevemente a origem dos satélites de posicionamento global.
3. Definir os seguintes termos:
  a) Latitude
  b) Longitude
  c) Graus, minutos e segundos
4. Quais são as leis, regras e regulamentos para a colocação de caches nas seguintes localidades:
  a) Parques Estaduais/Nacionais
  b) Rodovias e autoestradas
  c) Durante uma viagem
  d) Áreas desertas
  e) Florestas
5. Localizar, no minimo, 10 geocaches, incluindo:
  a) Um cache tradicional com nível 3 de dificuldade
  b) Um multi-caches
  c) Um cache virtual
6. Completar dois dos itens a seguir:
  a) Estabelecer e manter um novo cache em sua região por, no mínimo, um mês.
  b) Enviar e seguir um travel bug por um mês.
  c) Encontre dois Travel Bugs e sigui-los por um mês.
  d) Participar em um encontro de geocachers'),
('AR-069', 'Construção de Canoas', 'atividades-recreativas', 'especialidade', 3, null, 'Divisão do Sul do Pacífico', '/esp/ar-069.webp', 'https://mda.wiki.br/Especialidade_de_Construção_de_Canoas', '1. Quais árvores são usadas para construir canoas? Coníferas ou folhosas?
2. Quais árvores em seu país costumam ser usadas para construções de canoas? Quais os nomes populares delas?
3. Que ferramentas são usadas para construir canoas?
4. Descrever como uma tora é preparada para construir uma canoa.
5. Com a ajuda de alguém, moldar corretamente a parte externa de uma canoa e escavar seu interior. Corrigir ambas as superfícies, interna e externa, para ficarem lisas.
6. Auxiliar na construção de remos, acentos, postes e acessórios para a canoa.
7. Auxiliar na construção de um deck, mastro e vela de uma canoa de casco duplo ou um tipo de canoa polinésia.
8. Construir um modelo em madeira (galho ou tronco) de um tipo de canoa usada em sua região.'),
('AR-070', 'Cozinha com Forno Holandês', 'atividades-recreativas', 'especialidade', 1, 2006, 'Divisão Norte Americana', '/esp/ar-070.webp', 'https://mda.wiki.br/Especialidade_de_Cozinha_com_Forno_Holandês', '1. Apresentar um breve histórico sobre os fornos holandeses.
2. Conhecer a diferença entre um forno de pão, um forno para cozinhar, fogão para panelas e um forno de acampamento.
3. Responder os itens a seguir:
  a) Que tipos de combustíveis são usados para cozinhar com um forno?
  b) Quais as vantagens do carvão vegetal em relação à lenha como combustível?
  c) Como a temperatura do fogão deve ser controlada?
  d) Qual é o papel das cinzas na eficiência do carvão?
  e) Se usar lenha, que tipos são melhores para cozinhar?
4. Citar 6 diferentes maneiras de se cozinhar em um novo forno holandês.
5. Demonstrar as seguintes habilidades:
  a) Colocar fogo em um forno holandês e manusear com segurança o equipamento;
  b) Preparar corretamente um novo forno holandês;
  c) Limpar corretamente um forno holandês após cada uso;
  d) Transportar o forno holandês;
  e) Guardar corretamente o forno holandês para períodos longos e curtos.
6. Cozinhar um item de cada categoria usando um forno holandês:
  a) Sopa/ensopado
  b) Caçarola
  c) Vegetal
  d) Pão
  e) Sobremesa
7. Completar um dos seguintes itens:
  a) Cozinhar usando a tampa como se fosse uma forma redonda de bolo;
  b) Cozinhar em forno holandês usando empilhamento de panelas.'),
('AR-071', 'Fanfarra', 'atividades-recreativas', 'especialidade', 2, 2006, 'Divisão Norte Americana', '/esp/ar-071.webp', 'https://mda.wiki.br/Especialidade_de_Fanfarra', '1. Explicar a diferença entre fanfarra e banda marcial.
2. Quais são os instrumentos que compõem uma fanfarra?
3. Responder o seguinte sobre os rudimentos:
  a) Quais são as quatro famílias de rudimentos?
  b) Dar o nome de cinco rudimentos de cada uma das quatro famílias de rudimentos;
  c) Quais são os rudimentos essenciais? Por que eles são considerados essenciais?
4. Demonstrar conhecimento a respeito dos acessórios usados em fanfarras:
  a) Qual é a diferença entre suporte para tambores (bumbos) e talabartes?
  b) Quais são os vários tipos e tamanhos de baquetas usadas na fanfarra?
  c) Qual a diferença entre baquetas usadas para os bumbos, para caixas e para os surdos?
  d) Conhecer quais os equipamentos e ferramentas usados na manutenção de uma fanfarra;
  e) Citar exemplos de dispositivos de proteção usados para a segurança dos instrumentos da fanfarra.
5. Qual a diferença entre toque aberto e toque fechado? Usando o método aberto/fechado, demonstrar seu conhecimento dos rudimentos essenciais. Começar tocando devagar, aumentar a velocidade gradualmente e, em seguida, diminuir a velocidade novamente.
6. Qual a diferença entre a pegada tradicional e pegada moderna, no uso das baquetas? Demonstrar cada estilo de pegada tocando uma sequencia consistente com não menos de três rudimentos.
7. Demonstrar habilidade para manter o passo em uma fanfarra, tomando parte, no mínimo, em um programa demonstrativo (exemplos: Dia Mundial dos Desbravadores, congresso ou outro evento patrocinado pela igreja local).
8. Escrever um texto de 300 palavras sobre como uma fanfarra pode ser usada para servir em sua igreja local, em seu clube ou em sua comunidade.'),
('AR-072', 'Rapel', 'atividades-recreativas', 'especialidade', 1, null, 'Divisão do Sul do Pacífico', '/esp/ar-072.webp', 'https://mda.wiki.br/Especialidade_de_Rapel', '1. Fazer o seguinte:
  a) Explicar as regras de segurança com à relação condição física e mental do praticante, roupas e equipamentos adequados, acompanhamento e instrutores, condições meteorológicas, checagem do equipamento, verificação do local, verificação dos pontos de ancoragem e velocidade de descida
  b) Explicar a placa de sinalização: "perigo de queda"
2. Explicar o uso dos seguintes nós:
  a) Nó de fita
  b) Nó borboleta
  c) Figura de oito
  d) Pescador duplo
  e) Prussik
  f) Lais de Guia
3. Desenhar um diagrama para descidas por rapel nos seguinte casos:
  a) Técnica de corda única
  b) Rapel positivo e negativo
4. Explicar o que é selo de certificação do equipamento e o significado das siglas UIAA, CE, EN, ISO.
1. Explicar os princípios de amarração e três métodos usados, citar as vantagens e desvantagens de cada método.
  a) Amarração no corpo
  b) Amarração mecânica
  c) Amarração em uma base
1. Listar as regras para cuidar das cordas.
2. Explicar a diferença entre cordas dinâmicas e cordas estáticas.
3. Conhecer os tipos corretos de equipamentos necessários para rapel.
4. Conhecer a melhor maneira para armazenar sua corda. Exemplo: enrolando e encurtando.
1. Conhecer cada dispositivo usado para diferentes descidas com rapel, compreendendo as suas características considerando fatores como: Tempo, segurança, calor, versatilidade. etc.
1. Saber os primeiros socorros que devem ser prestados a uma pessoa com:
  a) Entorse
  b) Concussão
  c) Hipotermia
  d) Fratura
  e) Choque
1. Explicar como proceder nos seguintes resgates:
  a) Usando um sistema de roldanas
  b) Como mudar de método durante o resgate
1. Responder o seguinte:
  a) Citar seis nós usados em rapel e suas funções
  b) Citar vantagens e desvantagens dos seguintes freio: oito, oito resgate, ATC e Descensor autoblocante (Gri-gri)
  c) Explicar como fixar uma corda corretamente
  d) Citar sete regas de segurança para rapel
  e) Citar os procedimentos de primeiros socorros em caso de entorse, concussão, hipotermia, fratura e choque
  f) Citar cinco maneiras de detectar falhas na corda
1. Executar as seguintes tarefas:
  a) Atar seis nós diferentes usados em rapel
  b) Configurar uma instalação de corda única e outra para penhasco (paredão)
  c) Enrolar e diminuir uma corda corretamente
  d) Demonstrar métodos de amarração
1. De uma altura mínima de 10 metros, completar dois rapéis.
2. Explicar como fazer o rapel básico ou militar e o de ombro ou de corpo, para uso emergencial.
3. Ser capaz de usar o prussik em um penhasco de 10 metros.'),
('AR-073', 'Rapel - avançado', 'atividades-recreativas', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/ar-073.webp', 'https://mda.wiki.br/Especialidade_de_Rapel_-_avançado', '1. Ter a especialidade de Rapel.
2. Repetir toda a teoria e prática requerida pela especialidade Rapel.
3. Fazer rapel com um nó na corda.
4. Fazer rapel em uma saliência ou caverna.
5. Demonstrar o método da polia em um resgate em penhasco.'),
('AR-074', 'Rapel - instrutor', 'atividades-recreativas', 'especialidade', 3, null, 'Divisão do Sul do Pacífico', '/esp/ar-074.webp', 'https://mda.wiki.br/Especialidade_de_Rapel_-_instrutor', '1. Ter a especialidade de Rapel - avançado.
2. Instruir a especialidade de Rapel a um grupo de desbravadores
3. Conhecer os principais riscos de um praticante de rapel e saber os primeiros socorros que devem ser prestados em cada situação.
4. Liderar pelo menos duas expedições de rapel, checando a segurança de cada indivíduo.
5. Te um certificado do curso NR 35 - Técnicas Verticais, com carga mínima de 8 horas.'),
('AR-075', 'Triathlon', 'atividades-recreativas', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/ar-075.webp', 'https://mda.wiki.br/Especialidade_de_Triathlon', '1. Apresentar um relatório sobre o regime alimentar correto para manter-se em excelentes condições físicas e explicar como isto foi mantido durante todo o tempo de treinamento para o triathlon. Incluir a quantidade de liquido que deve ser ingerida antes e durante a competição e os alimentos ingeridos durante a competição.
  a) Apresentar as orientações gerais para um preparo adequado, incluindo exercícios de aquecimento, alongamento, prevenção de contusões, prevenção de exaustão, etc.
  b) Apresentar seu programa de treinamento.
  c) Relacionar o equipamento adequado, incluindo bicicleta, calçados e vestimenta.
2. Demonstrar conhecimento das técnicas usadas na natação, ciclismo e corrida.
3. Competir, individualmente ou como parte de uma equipe, num evento de triathlon reconhecido. O triathlon deverá cobrir distâncias semelhantes a: natação: 500 m; ciclismo: 15 km; corrida: 10 km. O percurso deve ser feito, no máximo, em 4 horas e meia.'),
('AR-076', 'Triathlon - avançado', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-076.webp', 'https://mda.wiki.br/Especialidade_de_Triathlon_-_avançado', '1. Ter a especialidade de Triathlon.
2. Desenvolver uma agenda de treinamento para si mesmo(a).
3. Manter um diário do treinamento durante 2 meses.
4. Participar de um evento importante de triathlon, individualmente. A competição deverá cobrir distâncias semelhantes a: natação: 1,5 km; ciclismo: 40 km; corrida: 10 km. O percurso deve ser feito, no máximo, em 4 horas e meia.'),
('AR-077', 'Telecartofilia', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-077.webp', 'https://mda.wiki.br/Especialidade_de_Telecartofilia', '1. Quais as diferenças entre a telecartofilia, a filatelia e a numismática?
2. Dizer que fatores influenciam um cartão a tornar-se raro e quais fatores tornam um cartão valioso para um colecionador.
3. Mencionar cinco países que fazem uso do cartão telefônico e quais os tipos de cartões utilizados.
4. Conhecer e adquirir os objetos necessários para o início de uma coleção de cartões telefônicos.
5. Saber quando e onde surgiu o primeiro cartão telefônico no mundo. Saber também quando ele começou a ser usado em seu país.
6. Escrever uma redação de 25 linhas sobre os parâmetros de uma coleção temática.
7. Fazer um cartaz, apresentação ou redação contando a história do cartão telefônico em seu país.
8. Fazer uma coleção de, pelo menos, 100 cartões, não incluindo repetidos na contagem.'),
('AR-078', 'Telecartofilia - avançado', 'atividades-recreativas', 'especialidade', 2, null, null, '/esp/ar-078.webp', 'https://mda.wiki.br/Especialidade_de_Telecartofilia_-_avançado', '1. Ter a especialidade de Telecartofilia.
2. Conhecer o funcionamento do cartão indutivo.
3. Onde é feita a impressão e a emissão dos cartões telefônicos em seu país?
4. Os cartões mais antigos possuem um código. O que ele significa e como interpretá-lo? (Ex: <96 07(2N IT 00)4 (MU Fi >).
5. Conhecer a história do cartão telefônico de algum país que não seja o seu.
6. Fazer uma coleção de, pelo menos, 300 cartões, contendo, no mínimo, um de chip, um magnético, um óptico e um pré-pago. Não incluir os repetidos na contagem.'),
('AR-079', 'Wakeboard', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-079.webp', 'https://mda.wiki.br/Especialidade_de_Wakeboard', '1. Conhecer e praticar as normas de segurança a seguir:
  a) Nunca praticar Wakeboard à noite
  b) Nunca praticar Wakeboard durante uma tempestade
  c) Sempre usar um colete salva-vidas enquanto estiver praticando Wakeboard
  d) Certifique-se que a corda está em boas condições
  e) Certifique-se que as ligaçôes estão em boas condições
  f) Ter sempre um spotter e bandeira no barco
  g) Mantenha-se afastado de objetos, tais como outros esquiadores, nadadores, plantas aquáticas, docas, ou outros objetos flutuantes
  h) Se você cair, solte a corda
  i) Depois de uma queda, levantar a mão para indicar que você está bem
  j) Não fique pendurado no barco enquanto ele está se movendo
2. Conhecer os seguintes sinais:
  a) Desacelere
  b) A velocidade está ok
  c) Acelere
  d) Volte para a doca
  e) Pare
  f) Retorne
3. Ser capaz de, sozinho, colocar a prancha de Wakeboard e remover o esqui em águas profundas.
4. Execute um deep-water (flutuar na água pedalando) iniciando o Wakeboard com a corda esticada.
5. Atravessar com sucesso a onda formada pelo barco a motor e retornar ao centro sem cair.
6. Fazer um pequeno salto usando a onda formada pelo barco como rampa e chegar à margem sem cair.'),
('AR-080', 'Softbol', 'atividades-recreativas', 'especialidade', 1, 2006, 'Divisão Norte Americana', '/esp/ar-080.webp', 'https://mda.wiki.br/Especialidade_de_Softbol', '1. Descrever as regra básicas do softbol.
2. Explicar o significado de esportividade e jogo limpo.
3. Citar e demonstrar seu conhecimento sobre as habilidades necessárias às 10 posições de jogo do softbol.
4. Saber identificar o seguinte:
  a) Bastão
  b) On deck circle
  c) Box do rebatedor
  d) Outfield
  e) Box do treinador
  f) Pitcher place
  g) Diamond Bags
  h) Pitching rubber
  i) Luva
  j) Right field
  k) Home base
  l) Left field
  m) Infield
  n) Softball (bola)
5. Definir e explicar os seguintes termos de jogo:
  a) Bases cheias
  b) Time da casa
  c) Bunt
  d) Innings
  e) Fielder''s choice
  f) Line up
  g) Fly Ball
  h) Popup
  i) Force Play
  j) Run
  k) Foul tip
  l) Score - ponto
  m) Grand Slam
  n) Zona de Strike
  o) Grounder
  p) The count
  q) Home run
  r) Andar
6. Explicar as seguintes regras do Softbol:
  a) Double Play
  b) Ground rule double
  c) Erro
  d) Regras de Infield fly
  e) Fair ball
  f) Out
  g) Foul ball
  h) Safe
7. Demonstrar habilidade em ler um cartão de pontuação de um jogo do qual você participou.
8. Listar 5 responsabilidades de um árbitro.
9. Citar 5 atributos mentais e físicos que podem ser desenvolvidos com a prática do softbol.
10. Juntamente com um time ou individualmente, desenvolver um plano de treinamento enquanto completa os requisitos desta especialidade. Opcionalmente, poderá incluir os seguintes itens ao plano:
  a) Convidar 3 amigos que não sejam de sua igreja para jogar uma partida.
  b) Fazer uma oração antes de cada partida.
  c) Demonstrar esportividade e jogo limpo.
11. Jogar 3 partidas de softbol em campo de dimensão oficial com um árbitro e demonstrar habilidades razoáveis no esporte.'),
('AR-081', 'Letterboxing', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-081.webp', 'https://mda.wiki.br/Especialidade_de_Letterboxing', '1. Defina o seguinte:
  a) Cache
  b) Letterbox
  c) Apelido (Trail name)
  d) Livro de registro pessoal
  e) Selo ou carimbo
  f) Cache carona
  g) Caixa de híbridos
  h) Caixa de bônus
  i) Troca
2. Liste, pelo menos, cinco comportamentos que você deve ter enquanto pratica letterboxing.
3. Demonstrar as seguintes habilidades de orientação:
  a) Converter o valor de uma escala para o valor real e calcular os passos necessários para percorrera distância (Pacing)
  b) Utilização da bússola
  c) Encontrar os pontos cardeais sem o uso de uma bússola
4. Projetar, criar e esculpir seu próprio selo pessoal.
5. Com uma unidade, clube, ou membro da família, encontrar as pistas e, em seguida, localizar, pelo menos, 10 letterboxes, se possível, pelo menos quatro deles devem ser parte de uma série. Carimbe seu selo individual no livro de visita e carimbe seu livro de registro com o carimbo do cache. Registrar seu achado no site.'),
('AR-082', 'Letterboxing - avançado', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-082.webp', 'https://mda.wiki.br/Especialidade_de_Letterboxing_-_avançado', '1. Ter a especialidade de Letterboxing.
2. Criar um carimbo de letterbox, postar pistas em um site, estabelecer e manter um letterbox por, no mínimo, seis meses.
3. Como uma unidade, clube, ou um membro de sua família, encontrar as pistas e, em seguida, localizar 20 caches diferentes dos que foram encontrados para a especialidade Básica, se possível, oito deles devem ser parte de uma coleção. Carimbar o livro do Letterbox e usar o carimbo do letterbox para carimbar seu livro de registro. Registre seu achado no site.
4. Projetar, criar e esculpir seu próprio carimbo caroneiro. Esconder em um letterbox, postar uma mensagem em um site e acompanhar a viagem do carimbo caroneiro por, no mínimo, seis meses.
5. Participar de um intercâmbio com letterboxers que não pertencem ao seu clube e obter um mínimo de 20 selos.'),
('AR-083', 'Monociclo', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-083.webp', 'https://mda.wiki.br/Especialidade_de_Monociclo', '1. Saber o nome e propósito de cada parte do monociclo.
2. Defina os seguintes termos relacionados a monociclos:
  a) Montagem livre
  b) Idle (equilíbrio)
  c) UPD (desmontagem não planejada)
3. Saiba quais equipamentos de segurança devem ser usados e porque devem ser usados.
4. Dê o nome de cinco tipos diferentes de monociclos e explique o que os torna únicos.
5. Conte a história da criação do monociclo.
6. Reparar o pneu furado de um monociclo.
7. Ser capaz de montar um monociclo, andar por 50 metros, virar à direita e à esquerda e desmontar graciosamente, tudo sem cair.'),
('AR-084', 'Acampamento Seguro', 'atividades-recreativas', 'especialidade', 2, 2009, 'Divisão Norte Americana', '/esp/ar-084.webp', 'https://mda.wiki.br/Especialidade_de_Acampamento_Seguro', '1. Por que é importante conhecer o que as leis de seu País/Estado falam sobre fogueiras em acampamento ou áreas silvestres? Onde obter estas informações?
2. Relacionar, pelo menos, cinco coisas que você pode fazer para prevenir a entrada de animais na área de acampamento.
3. Demonstrar uma maneira de purificar água no acampamento.
4. Por que uma fogueira nunca deve ficar sozinha? Relacionar, pelo menos, 10 regras de segurança relacionadas a fogueira em acampamento.
5. Descrever a temperatura ideal para se conservar alimentos quentes e frios, como devem ser mantidos e explicar por que isto é importante.
6. Discutir regras de segurança para manuseio dos seguintes itens:
  a) Faca
  b) Machado/machadinha
  c) Serrote ou serras
  d) Facão
  e) Combustíveis
7. Quais as precauções de segurança devem ser consideradas ao construir uma latrina?
8. Realizar uma inspeção de acampamento, utilizando um formulário para gerenciamento de segurança e riscos no acampamento. Ser capaz de explicar a pontuação determinada no relatório sobre a segurança no acampamento.'),
('AR-085', 'Acampamento Seguro - avançado', 'atividades-recreativas', 'especialidade', 3, 2009, 'Divisão Norte Americana', '/esp/ar-085.webp', 'https://mda.wiki.br/Especialidade_de_Acampamento_Seguro_-_avançado', '1. Ter a especialidade de Acampamento Seguro
2. Relacionar, pelo menos, 5 itens para se manter a higiene em um acampamento, cujo o local não haja água corrente (ou seja, sem chuveiros, torneiras, lavatórios, etc)
3. Fazer uma lista e itens necessários em kit de primeiros socorros. Inspecionar o kit de primeiros socorros do seu clube e recomendar a aquisição de itens faltantes.
4. Realizar inspeções em 3 acampamentos usando o formulário de inspeção de segurança.
5. Instruir a Acampamento Seguro a um grupo de desbravadores.'),
('AR-086', 'Viagem e Turismo', 'atividades-recreativas', 'especialidade', 1, 2009, 'Divisão Norte Americana', '/esp/ar-086.webp', 'https://mda.wiki.br/Especialidade_de_Viagem_e_Turismo', '1. Listar todos os tipos de transporte que você possa pensar que as pessoas usam ao redor do mundo. Diminuir esta lista anterior para os cinco meios de transporte mais comuns. Listar os prós e os contras de cada um dos cinco.
2. Liste alguns dos prós e contras dos seguintes tipos de hospedagem:
  a) Hotel
  b) Albergue da Juventude
  c) Amigos / família
  d) Trailer/acampamentos
  e) Resorts
3. Quais documentos são necessários para os seguintes tipos de viagens? Em quais casos é necessária uma autorização dos pais?
  a) Viagens intermunicipais
  b) Viagens interestaduais
  c) Viagens internacionais (para países que pertençam e não pertençam ao mesmo bloco econômico)
4. Cumprir um dos seguintes:
  a) Assistir a um programa diário de viagem, ou uma reportagem ou vídeo promocional, que mostra paisagens de viagens e geografia de uma única localização.
  b) Pesquisar, através de atlas, livros ou internet, uma cidade ou região que você queria visitar.
1. O que é necessário para se viajar ao exterior? Discuta em grupo como um turista deve se comportar quando estiver em outro país.
2. Quais as regras sobre o que se pode levar na mala despachada e na bagagem de mão? Por que é importante respeitar as leis a respeito de levar elementos de origem animal e vegetal de um país a outro?
3. Criar um plano simples de viagem para sete dias de férias familiares, ou para duas viagens de 4 dias cada. Como parte de seu planejamento, incluir os seguintes locais para visita:
  a) Detalhes sobre um lugar histórico
  b) Detalhes sobre dois parques naturais
  c) Detalhes sobre uma área de recreação
  • Observação: O primeiro e o último dia devem ser dias de viagem.
4. Listar algumas maneiras diferentes que as pessoas usavam para viajar no tempo bíblico.'),
('AR-087', 'Viagem e Turismo - avançado', 'atividades-recreativas', 'especialidade', 2, 2009, 'Divisão Norte Americana', '/esp/ar-087.webp', 'https://mda.wiki.br/Especialidade_de_Viagem_e_Turismo_-_avançado', '1. Ter a especialidade de Viagem e turismo.
2. Que considerações de segurança você deve pensar quando viaja?
3. Quais recomendações ou requerimentos de saúde são recomendados e/ou exigidos pelo departamento de saúde de seu país para viagens internacionais?
4. Criar um orçamento para as férias familiares, incluindo projeções de valores para o grupo e para você:
  a) Passagens de ida e volta
  b) Despesas com transportes
  c) Despesas com hospedagem
  d) Despesas com alimentação
  e) Custo orçado para visitar locais planejados
  f) Gastos com lembrancinhas
  g) Incluir 10% para despesas diversas'),
('AR-088', 'Excursionismo Pedestre na Neve', 'atividades-recreativas', 'especialidade', 2, 2010, 'Divisão Norte Americana', '/esp/ar-088.webp', 'https://mda.wiki.br/Especialidade_de_Excursionismo_Pedestre_na_Neve', '1. Descrever a forma e o tamanho de 3 tipos de raquetes de neve e quando / como elas podem ser usadas (aeróbio / corrida, recreação, montanhismo).
2. Descrever os seguintes acessórios para raquetes de neve e sua utilidade enquanto caminhando na neve:
  a) Bastão de caminhada
  b) Botas de caminhada
  c) Gaiters
3. Demonstrar a técnica adequada de usar raquetes de neve nas seguintes situações:
  a) Ao virar-se (conversão)
  b) Subidas
  c) Descidas
  d) Trilhas
4. Explicar como manter o corpo quente e seco através do uso de vestimentas apropriadas, sob condição de vento de inverno enquanto viaja e descansa. Saber como evitar e como tratar hipotermia durante o inverno.
5. Explicar o valor das seguintes regras de segurança:
  a) Conhecer como ler um mapa, como usar uma bússola ou GPS em caminhadas
  b) Deixar um plano de viagem com alguém enquanto você estiver caminhando na neve
  c) Caminhar na neve sempre com um parceiro
  d) Portar água e alimentos suficientes
  e) Ter um kit de primeiros socorros, sobrevivência e reparo
6. Usando um par de raquetes de neve, demonstrar como se levantar após uma queda na neve.
7. Demonstrar a importância de unir e fixar corretamente suas botas nas raquetes de neve.
8. Participar de uma série de 3 caminhadas ? uma de 1 Km, uma de 2 Km e uma de 4 Km. Fazer um relatório detalhado descrevendo a profundidade aproximada dos passos na neve e condição da neve, plantas e animais e da velocidade média de deslocamento.
9. Explicar o significado da expressão "mais branca que a neve" encontrada no Salmo 51:7. Que outras metáforas naturais você poderia usar para demonstrar o significado deste versículo?'),
('AR-089', 'Excursionismo Pedestre na Neve - avançado', 'atividades-recreativas', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/ar-089.webp', 'https://mda.wiki.br/Especialidade_de_Excursionismo_Pedestre_na_Neve_-_avançado', '1. Ter a especialidade de Excursionismo pedestre na neve.
2. Explicar sobre os diferentes tipos de flocos de neve e qual influência exerce sobre as raquetes.
3. Utilizando um dos recursos a seguir, criar uma palestra sobre o uso de raquetes de neve. Incluir o uso entre os povos nativos. Citar todas as fontes pesquisadas.
  a) Apresentação eletrônica
  b) Relatório verbal
  c) Relatório escrito (mínimo de 1 página)
  d) Cartaz (expô-lo na sede do clube)
4. Rever os conceitos de segurança descritos na especialidade básica.
5. Fazer um dos seguintes:
  a) Fazer um par de raquetes de sobrevivência, usando materiais nativos e de primeiros socorros, que possivelmente estará disponível para você em meio à natureza.
  b) Fazer um conjunto de sapatos de neve usando materiais naturais ou sintéticos.
6. Completar com sucesso 2 caminhadas de 3 Km usando raquetes de neve. Fazer um relatório descrevendo detalhes da caminhada, como profundidade dos passos, condição da neve, plantas e animais e velocidade média de deslocamento.
7. Após uma de suas caminhas, escrever, pelo menos, um parágrafo explorando a dimensão espiritual da neve. Citar, pelo menos, 3 referências bíblicas onde a neve é mencionada.'),
('AR-090', 'Segurança Básica na Água', 'atividades-recreativas', 'especialidade', 1, 2010, 'Divisão Norte Americana', '/esp/ar-090.webp', 'https://mda.wiki.br/Especialidade_de_Segurança_Básica_na_Água', '1. Demonstrar como entrar e sair da água de forma segura.
2. Enquanto segura a respiração, submergir completamente seu rosto na água por cinco segundos.
3. Respirar pela boca e, alternadamente, com o rosto submerso, soltar o ar, ora pela boca e ora pelo nariz, no mínimo, sete vezes de forma contínua e rítmica.
4. Abrir os olhos embaixo d''água e recuperar alguns objetos submersos.
5. Boiar de frente por cinco segundos.
6. Boiar de frente, por um percurso de dois corpos.
7. Voltar flutuando por 15 segundos.
8. Segurando a borda da piscina, bater os pés alternadamente por vinte segundos.
9. Usando os braços e o movimento das pernas, nadar por um percurso de cinco corpos.
10. Aprenda a colocar um colete salva-vidas e flutuar por trinta segundos.
11. Demonstrar segurança para executar o seguinte, estando dentro d''água:
  a) Como pedir ajuda em caso de emergência
  b) Como se livrar de uma cãibra
  c) Aprender, pelo menos, dez regras de segurança quando próximos à água'),
('AR-091', 'Boliche', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-091.webp', 'https://mda.wiki.br/Especialidade_de_Boliche', '1. Descrever a pista de boliche. Mencionar o tamanho, material usado na construção e porque e como a pista deve ser lubrificada diariamente.
2. Definir os seguintes termos:
  a) Strike
  b) Spare
  c) Approach
  d) Grip
  e) Leitura de pista
  f) Canaletas
  g) 1001
  h) 2002
  i) Back up
  j) Baby split
  k) Blind
  l) Bola morta
  m) Broche de ouro
  n) Encarar
  o) Frame
  p) Fritar ou furar
  q) Five bagger (ou "quina-ligue")
3. Explicar resumidamente como é cada partida.
4. Explicar o sistema de contagem de pontos. Qual a pontuação máxima?
5. Qual o diâmetro da bola e o peso mínimo e máximo?
6. Qual a medida dos pinos e qual a distância entre eles?
7. Explicar porque são necessários calçados próprios para a prática do boliche.
8. Fazer um diagrama da pista de boliche.
9. Demonstrar a maneira correta de segurar a bola.
10. Participar de, pelo menos, 3 partidas de boliche conseguindo, pelo menos, 150 pontos em cada.'),
('AR-092', 'Carrinho de Rolimã', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-092.webp', 'https://mda.wiki.br/Especialidade_de_Carrinho_de_Rolimã', '1. Com auxilio de um adulto responsável, manusear ferramentas como martelo, serrote, furadeira e saber os cuidados necessários ao se usar cada uma delas.
2. Qual a diferença dos freios laterais dos freios centrais? Em que eles implicam na hora da frenagem? Por que não é aconselhável adaptar os freios nas rodas?
3. Saber como o atrito, aderência e lubrificação dos rolamentos afetam o desempenho do carrinho.
4. Saber quais locais são apropriados para treinar e testar seus carrinhos.
5. Criar um projeto para confeccionar um carrinho de rolimã (rolamentos) dentro das seguintes dimensões:
  a) Comprimento: 80 a l00 cm
  b) Largura: 25 a 35 cm
  c) Espessura: 2 a 3 cm
6. Cumprir um dos seguintes itens:
  a) Concluir seu projeto, dando acabamento com tinta , adesivo, fitas adesivas e/ou algo de sua criatividade;
  b) Participar de um evento em seu Clube ou distrito/região ou escola, observando as regras de segurança como local apropriado, equipamentos de proteção individual e também a desportividade.'),
('AR-093', 'Colecionador', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-093.webp', 'https://mda.wiki.br/Especialidade_de_Colecionador', '1. Explicar o que um colecionador faz e por que essa atividade pode ser um hobbie interessante.
2. Listar, ao menos, 10 itens que as pessoas colecionam na atualidade.
3. O que faz com que um item de uma coleção (ou toda uma coleção) adquira um grande valor monetário? Esse valor sempre é o mais importante para o colecionador?
4. Visitar uma exposição de artes ou feira de artesanato e listar os diversos objetos colecionáveis encontrados ali.
5. Iniciar uma coleção interessante com no mínimo de 15 itens. Demonstrar habilidade em classificar, catalogar e identificar os itens, especificando (caso seja aplicável): data, hora, local de origem, valor estimado, local onde encontrou e os demais detalhes específicos inerentes à coleção escolhida.
6. Completar um dos seguintes:
  a) Iniciar uma coleção interessante para seu Clube. Ajudar na escolha do tipo de coleção, elaborar um expositor criativo, fazer uma lista com o que deve constar na descrição dos itens e contribuir com, no mínimo, cinco itens diferentes;
  b) Em uma coleção do Clube já existente, ajudar na conservação e organização e contribuir com o acréscimo de, pelo menos, 5 itens. Discutir com o instrutor o estado atual da coleção e sugerir como ela poderia ser melhorada.
  c) Participar de uma exposição de coleções em seu Clube, escola ou Igreja, dispondo os objetos devidamente e bem identificados e prestando os devidos esclarecimentos aos visitantes.'),
('AR-094', 'Esportes Adaptados', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-094.webp', 'https://mda.wiki.br/Especialidade_de_Esportes_Adaptados', '1. O que são esportes adaptados?
2. Descobrir como a prática de esportes influencia no desenvolvimento e/ou reabilitação de pessoas com deficiência.
3. Qual a importância da prática de esportes por pessoas com deficiências físicas?
4. Citar, pelo menos, 10 modalidades de esportes adaptados.
5. Citar, pelo menos, 2 competições internacionais que realizam esportes adaptados. Apresentar a história de, pelo menos, uma delas.
6. Entrevistar uma pessoa com deficiência física e descobrir se ele pratica algum esporte.
7. Visitar uma instituição que trabalhe esportes adaptados e descobrir:
  a) Visão e missão desta instituição
  b) Quantas pessoas são beneficiadas por esse trabalho
  c) Quais são as maiores dificuldades
  d) Como é realizado o incentivo à prática de esportes
8. Assistir a um esporte coletivo realizado por deficientes e apresentar um relatório desta experiência.
9. O que você faria se no seu Clube entrasse um desbravador com deficiência e ele quisesse praticar algum esporte com sua unidade?
10. Fazer uma pesquisa sobre os Jogos Paraolímpicos. Apresentar um relatório escrito de, pelo menos, 300 palavras ou um relatório oral de, no mínimo, 5 minutos sobre o histórico e a importância do evento para a inclusão dos deficientes físicos na sociedade e o incentivo ao esporte.'),
('AR-095', 'Excursionismo Pedestre com Mochila - avançado', 'atividades-recreativas', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ar-095.webp', 'https://mda.wiki.br/Especialidade_de_Excursionismo_Pedestre_com_Mochila_-_avançado', '1. Ter a especialidade de Excursionismo pedestre com mochila.
2. O que significa trekking?
3. Descrever os pontos positivos e negativos do uso dos seguintes tecidos em caminhadas:
  a) Algodão
  b) Tecidos sintéticos que respiram (Dry)
  c) Felpa ou pelo
  d) Lã
4. Descrever como deve ser usada e para que serve cada tipo de mochila abaixo:
  a) Cargueira
  b) Ataque
  c) Multifuncional
  d) Pochete
5. Explicar a importância de cada item abaixo em uma caminhada:
  a) Mochila
  b) Bota de caminhada
  c) Bastão de caminhada
  d) Chapéu australiano
  e) Óculos escuros
  f) Cantil
  g) Bolsinha ou pochete de primeiros socorros
6. Além do saco de dormir, que outros acessórios são ideais para se garantir uma boa noite de sono?
7. Explicar os seguintes tipos de calçados, ressaltando o uso em diferentes terrenos, preço e diferenças entre eles. Em seguida, explicar como limpá-los e impermeabilizá-los.
  a) Tênis
  b) Bota de tecido
  c) Bota de couro
  d) Bota plástica de neve
  e) Bota de selva
  f) Bota de deserto
8. Explicar os seguintes tipos de meia e identificar as meias adequadas à sua região e estação.
  a) Meias de verão
  b) Meias compridas
  c) Meias de inverno
  d) Meias tricotadas
9. O que são polainas e por que e como devem ser usadas?
10. Explicar e demonstrar a maneira adequada de se alongar antes de uma caminhada e explicar porque isto é necessário.
11. Explicar porque um grupo de caminhada não pode ficar separado ou deixar um membro para trás.
12. Participar de uma excursão de fim de semana com caminhada de, no mínimo, 24 quilômetros, em que o acampamento seja armado em locais diferentes a cada noite. As refeições deverão ser cozidas durante a excursão.'),
('AR-096', 'Futebol de Botão', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-096.webp', 'https://mda.wiki.br/Especialidade_de_Futebol_de_Botão', '1. Definir o que é o futebol de botão. Contar uma breve história de como esse esporte surgiu.
2. Saber, pelo menos, 2 modalidades que podemos praticar com o futebol de botão.
3. Conhecer e explicar algumas regras básicas antes de iniciar uma partida de futebol de botão.
4. Fazer uma lista dos equipamentos necessários para a realização de uma partida de futebol de botão.
5. Citar alguns tipos de matérias-primas que podem ser usadas na fabricação de uma peça de botão.
6. Descrever os seguintes termos no futebol de botão:
  a) Botonista
  b) Batedeira
  c) Ônibus
  d) Furada
  e) Lateral
  f) Pênalti
  g) Tiro livre direto e indireto
  h) Falta
  i) Bola Prensada
7. Quanto tempo dura, em média, uma partida de futebol de botão?
8. Qual a medida oficial da mesa para o futebol de botão? Fazer um diagrama demonstrativo do campo, citando as marcações e medidas que são necessariamente obrigatórias para a realização desse jogo.
9. Confeccionar um time completo de futebol de botão com qualquer material de sua escolha. Desenhar um emblema de identificação para seu time.
10. Participar de, pelo menos, uma partida ou se inscrever em uma competição de futebol de botão organizada pela sua região, fazendo um breve relatório do que ocorreu no(s) jogo(s).'),
('AR-097', 'Futsal', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-097.webp', 'https://mda.wiki.br/Especialidade_de_Futsal', '1. De acordo com as regras internacionais de futsal, responder o seguinte:
  a) O que é futsal?
  b) Qual o objetivo do jogo?
  c) Como se joga uma partida de futsal?
  d) Como é a divisão dos tempo na partida de futsal?
  e) Onde se pratica a modalidade de futsal?
  f) Qual a dimensão padrão de uma quadra para a prática do futsal?
2. Fazer um relatório sobre a história do futsal, abordando o seu desenvolvimento histórico.
3. Quais as diferenças entre futsal e futebol em relação aos seguintes aspectos?
  a) Duração da partida
  b) Regras de impedimento
  c) Execução do tiro livre direto após a sexta falta
  d) Cobrança lateral
4. Definir os seguintes fundamentos do futsal:
  a) Passe
  b) Drible
  c) Finta
  d) Cabeceio
  e) Chute
  f) Recepção
  g) Condução
  h) Domínio de bola
  i) Chute a gol
5. Quais as categorias oficiais do futsal? Citar a faixa etária de cada uma.
6. Descrever as seguintes posições:
  a) Goleiro
  b) Fixo
  c) Ala
  d) Pivô
7. Descrever as regras básicas do futsal, explicando cada uma delas.
8. Participar de, no mínimo, 3 partidas de futsal, descrevendo todo o andamento do jogo. Nestas partidas você pode atuar como:
  a) Técnico
  b) Jogador
  c) Árbitro ou assistente'),
('AR-098', 'Handebol', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-098.webp', 'https://mda.wiki.br/Especialidade_de_Handebol', '1. Conhecer o regulamento atualizado da Federação Internacional de Handebol (IHF) e relacionar as 18 regras principais do Handebol.
2. O que significa a expressão fair play?
3. Definir os seguintes termos:
  a) Arremesso com apoio;
  b) Arremesso em suspensão;
  c) Arremesso com queda;
  d) Arremesso com rolamento;
  e) Passes acima do ombro;
  f) Passes em pronação;
  g) Passes por trás da cabeça;
  h) Passes por trás do corpo;
  i) Passe para trás;
  j) Passe quicado;
  k) Vaselina;
  l) Rosqueta;
  m) Bloquear;
  n) Condução;
  o) Contra-ataque;
  p) Cruzamento;
  q) Engajamento;
  r) Flutuação;
  s) Infiltração;
  t) Rebote;
  u) Marcação por zona;
  v) Marcação mista;
  w) Interceptação;
  x) Marcação individual;
  y) Oito;
  z) Ponte aérea;
  {) Desqualificação;
  |) Dois minutos;
  }) Exclusão;
  ~) Linha de quatro metros;
  ) Linha de seis metros;
  ) Linha dos sete metros;
  ) Tiro de sete metros;
  ) Tiro livre.
4. Demonstrar e compreender as diferentes habilidades exigidas nas diferentes posições ofensivas e defensivas do handebol.
5. Demonstrar habilidade razoável nas seguintes áreas:
  a) Empunhadura;
  b) Recepção;
  c) Passe;
  d) Arremesso;
  e) Drible;
  f) Ritmo trifásico;
  g) Duplo ritmo trifásico;
  h) Progressão;
  i) Finta.
6. Passar pelo menos 4 horas ajudando uma pessoa menos habilidosa ou mais jovem a melhorar suas habilidades no handebol.
7. Jogar ao menos 5 partidas de handebol com a família ou amigos. Mostrar fair play durante seus treinos e jogos.
8. Desenhar em escala uma quadra de handebol com seus limites adequadamente definidos. Informar as dimensões da trave.'),
('AR-099', 'Nós e Amarras - avançado', 'atividades-recreativas', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ar-099.webp', 'https://mda.wiki.br/Especialidade_de_Nós_e_Amarras_-_avançado', '1. Ter a especialidade de Nós e amarras.
2. Fazer, pelo menos, 10 dos seguintes nós decorativos:
  a) Pinha de saco dupla ou pinha com alça dupla
  b) Pinha de saco singela
  c) Coxim de Rosa
  d) Coxim da Vitória
  e) Coxim de tecer
  f) Coxim singelo
  g) Coxim em oito
  h) Nós Chato
  i) Nó Chato Torcido, ou nó de espiral
  j) Nó de gacheta triangular
  k) Nó de gacheta quadrada
  l) Nó de gacheta redonda
  m) Nó de peso
  n) Nó anel de três
  o) Pinha de vassoura ou trança de oito
  p) Pinha Cruzada ou pinha de retinida
  q) Pinha de Boça
  r) Pinha de Arganel ou nó do sultão
  s) Coxim Turco
  t) Coxim Sueco
  u) Coxim turco prolongado
  v) Pinha de cesto
  w) Coxim de anel de três
  x) Coxim de tear
  y) Coxim de esquadria
  z) Coxim de encapeladura dupla
3. Fazer de memória, pelo menos, 40 dos nós abaixo, falando ao avaliador o nome, para que serve e suas limitações. Fazer um relatório descrevendo cada um, citando para que serve e situações em que deve ser usado:
  a) Nó simples
  b) Nó Aselha
  c) Nó Direito
  d) Nó Cego
  e) Nó direito alceado
  f) Nó direito andino
  g) Nó de escota
  h) Nó de escota alceado
  i) Volta da fiel
  j) Volta da fiel duplo
  k) Nó corrediço
  l) Nó oitavo corrediço
  m) Nó catau
  n) Nó catau com trava
  o) Nó fateixa
  p) Nó pescador
  q) Nó pescador duplo
  r) Nó oito
  s) Nó corrente de oito
  t) Nó oito duplo
  u) Nó nove
  v) Nó nove duplo
  w) Volta da ribeira
  x) Volta do salteador
  y) Lais de guia
  z) Lais de guia duplo
  {) Volta paradora
  |) Nó de forca ou carrasco
  }) Nó de frade
  ~) Balso pelo seio
  ) Nó cadeira de bombeiro
  ) Nó moringa
  ) Nó de caminhoneiro
  ) Nó de cirurgião
  ) Nó de cirurgião duplo
  ) Nó arnez
  ) Nó de escada
  ) Nó de estribo
  ) Nó encapeladura
  ) Nó encapeladura dobrada
  ) Nó de barril
  ) Nó pata de gato
  ) Nó de trança
  ) Torniquete espanhol
  ) Nó cabeça de pássaro ou cabeça de cotovia
  ) Nó de ajuste
  ) Nó ordinário duplo
  ) Nó Josefina
  ) Nó vitória
  ) Nó de tecelão
  ) Nó quadrado
  ) Nó de gravata
  ) Nó de fita ou nó aquático
  ) Volta sobre o cabo
  ) Nó borboleta
  ) Nó corrente
  ) Nó de bombeiro espanhol
  ) Nó prussik
  ) Falcaça simples
  ) Falcaça americana
  ) Falcaça meias voltas mordidas
  ) Nó UIAA
  ) Nó UIAA duplo
   ) Nó tensor de barraca
  ¡) Nó em cadeia
  ¢) Amarra de andaime
  £) Volta da alça ou machard
  ¤) Nó espiral
  ¥) Lais de guia em elos
  ¦) Lais de Guia corrediço
  §) Trapa morrediça
  ¨) Laçada encavilhada
  ©) Nó de cote
  ª) Nó sangue
  «) Nó de estacha
  ¬) Nó de amarrar sapatos
  ­) Nó espinha de peixe
  ®) Nó de arreio
  ¯) Nó de cabresto (guntline)
  °) Volta esticada
  ±) Nó de Hunter ou Nó de caçador
  ²) Nó de estivador
  ³) Pinha de rosa simples
  ´) Amor perfeito
  µ) Nó trevo
  ¶) Nó 88
  ·) Volta de gancho
  ¸) Nó de gancho dobrado
  ¹) Volta apertada
  º) Nó diamante
  ») Punho de adriça singela
  ¼) Nó cabeça de turco
  ½) Nós de entrançar cabelo
  ¾) Nó costeleta
  ¿) Nó aventureiro
  À) Nó desbravador
  Á) Nó viúva negra
  Â) Nó menino
4. Fazer as seguintes amarras:
  a) Amarra Quadrada Japonesa
  b) Amarra em Forma de Oito
  c) Amarra Contínua Diagonal
  d) Amarra Contínua Diagonal Dupla
5. Explicar por que alguns móveis, passado alguns dias da sua confecção, ficam com as amarras frouxas. Como evitar isso?
6. Fazer um quadro com, pelo menos; 60 nós. Destes, pelo menos 10 devem ser decorativos.'),
('AR-100', 'Ordem Unida - instrutor', 'atividades-recreativas', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ar-100.webp', 'https://mda.wiki.br/Especialidade_de_Ordem_Unida_-_instrutor', '1. Ter a especialidade de Ordem unida - avançado.
2. Relacionar algumas regras de segurança para se praticar ordem unida. Considerar tipo de solo, calçados, etc.
3. Saber os primeiros socorros prestados a uma vitima com torção e com insolação.
4. Identificar as três etapas da voz de comando nos comandos a seguir:
  a) Clube, sentido
  b) Direita volver
  c) Frente para a retaguarda
  d) Marcar passo
  e) Em frente
  f) Em direção à esquerda
  g) Fora de forma, marche
5. Utilizando-se do método de ensino de execução por tempos, explicar como se desenvolve cada parte da execução dos seguintes comandos:
  • A pé firme:
    1. Esquerda volver
    2. Direita volver
    3. Meia volta volver
  • Em deslocamento:
    1. Esquerda volver
    2. Direita volver
    3. Meia volta volver
6. Como deve ser a inserção de novatos nos exercícios de ordem unida? Explicar qual a importância das instruções individuais e da divisão inicial do grupo por nível de habilidade.
7. Descrever como deve ser a postura de um instrutor de ordem unida para que os exercícios de ordem unida atinjam as suas finalidades.
8. Em qual posição/postura o instrutor deverá permanecer enquanto comanda um grupo em ordem unida, parado e em deslocamento?
9. Comandar um grupo por, pelo menos, 30 minutos. Neste período deverão ser efetuados comandos a pé firme e em passo ordinário. Devem ser avaliados o posicionamento, a postura, a energia e execução correta das etapas de voz de quem comanda.
10. Treinar um grupo de desbravadores a realizar movimentos com bandeirins.
11. Participar de um desfile como instrutor de pelotão.
12. Explicar as diferenças entre a forma de condução de bandeiras e bandeirins em desfiles e passeatas.
13. Criar uma evolução usando os comandos e movimentos padrões de ordem unida e ensiná-la a um grupo de desbravadores.
14. Que princípios de ordem unida podem ser aprendidos na Bíblia através da leitura de Joel 2: 7 e 8?'),
('AR-101', 'Pioneirias', 'atividades-recreativas', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ar-101.webp', 'https://mda.wiki.br/Especialidade_de_Pioneirias', '1. Ter, no mínimo, 12 anos de idade.
2. Saber usar as seguintes ferramentas:
  a) Facão
  b) Serrote
  c) Canivete
  d) Serra de arco
3. Demonstrar conhecimento das regras de segurança no manuseio de ferramentas.
4. Qual a importância de manter as ferramentas de trabalho em pioneirias afiadas? Quais os principais cuidados na manutenção dessas ferramentas. Afiar as ferramentas do requisito 2.
5. Demonstrar habilidade em amarrar objetos usando as seguintes amarras:
  a) Amarra quadrada
  b) Amarra diagonal
  c) Amarra paralela ou redonda;
  d) Amarra contínua.
6. Fazer cinco dos seguintes móveis de acampamento:
  a) Um tripé com, no mínimo, 2 metros para lampião
  b) Uma mesa usando um tripé
  c) Uma mesa usando dois tripés
  d) Uma mesa com quatro bases e, pelo menos, 4 amarras
  e) Uma sapateira com duas bases
  f) Estrutura para um fogão suspenso
  g) Uma pia de louça contendo coletor de água até uma fossa séptica'),
('AR-102', 'Pioneirias - avançado', 'atividades-recreativas', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/ar-102.webp', 'https://mda.wiki.br/Especialidade_de_Pioneirias_-_avançado', '1. Ter a especialidade de Pioneirias
2. Ter, no mínimo, 14 anos de idade.
3. Qual a importância de fazer cavas na madeira antes de fazer amarras em pontaletes?
4. Qual a importância de se fazer projeto (desenho com medidas) para pioneira?
5. Fazer um projeto (desenho com medidas) para cada estrutura descrita no requisito 7 da especialidade Pioneirias. Especificar a quantidade de madeira e cordas ou sisal para construir cada uma delas.
6. Usando amarras e varetas, fazer uma miniatura em escala de quatro projetos.
7. Construir cinco das seguintes estruturas:
  a) Um portal com, pelo menos, oito bases e 20 amarras;
  b) Um portal sem furar o chão;
  c) Uma mesa de acampamento com, pelo menos, quatro bases e oito amarras;
  d) Uma ponte com, pelo menos, 4 bases e 2 metros de extensão;
  e) Uma torre com, pelo menos, 2 metros de altura e 10 amarras;
  f) Um abrigo suspenso a, pelo menos, 1 metro do solo;
  g) Uma cozinha de acampamento contendo mesa multiuso, pia/sumidouro, mesa e cadeiras ou bancos para refeição.'),
('AR-103', 'Patins', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-103.webp', 'https://mda.wiki.br/Especialidade_de_Patins', '1. Fazer um resumo da história da criação e evolução dos patins.
2. Descrever os equipamentos de segurança usados na patinação.
3. Citar, pelo menos, 3 modalidades esportivas que usam patins.
4. Descreva a diferença entre os seguintes tipos de patins:
  a) In-line
  b) Tradicional
  c) Gelo
5. Para cada um dos tipos de patins citado no requisito 4, citar:
  a) Local apropriado para uso
  b) Pelo menos 3 modalidades em que cada tipo é usado
  c) Vantagens que o modelo proporciona
  d) Desvantagens
6. Saber e explicar como deve ser feita a manutenção do Patins (escolha um tipo que possa ser usado em usa região).
7. Executar o seguinte, enquanto patina:
  a) Saber aumentar velocidade
  b) Saber frear rapidamente
  c) Patinar de costas
  d) Aumentar a velocidade e deslizar, pelo menos, 5 metros agachado
  e) Mudar de direção (direita e esquerda)
  f) Pegar velocidade e pular um objeto
  g) Fazer um giro de 360° sob um dos pés
8. Fazer uma pesquisa sobre uma das modalidades esportivas pesquisada no requisito 3, mencionando o regulamento, nível das competições, categorias e informações interessantes sobre o esporte.'),
('AR-104', 'Orientação com GPS', 'atividades-recreativas', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ar-104.webp', 'https://mda.wiki.br/Especialidade_de_Orientação_com_GPS', '1. Ter a especialidade de Mapa e bússola.
2. O que significam as siglas GPS e DGPS?
3. Conhecer a história do surgimento do GPS e fazer um breve relato.
4. Quais são os fatores que podem interferir no sinal do GPS?
5. O que é a previsão de erros do GPS?
6. Qual a finalidade de um receptor GPS? Quais modalidades de receptores GPS existem atualmente? Descrever a utilidade de cada um.
7. Saber manusear um GPS adequadamente. Quais são os cuidados que devemos ter ao manuseá-lo?
8. Quais as aplicações de um receptor GPS e quais suas limitações?
9. Utilizar um software de transferência de arquivos e conectá-lo corretamente ao GPS.
10. Instalar mapas no GPS e no software de transferência de mapas.
11. Quais os tipos de mapas que podemos utilizar em um GPS? Dar exemplos.
12. Demonstrar habilidade em:
  a) Localizar um ponto no GPS
  b) Marcar um ponto no GPS
  c) Calcular uma rota
  d) Marcar uma trilha percorrida
  e) Percorrer uma trilha e mapeá-la
  f) Transferir mapas e dados do GPS
  g) Transferir mapas e dados para o GPS
  h) Selecionar mapas a serem utilizados
13. Percorrer uma trilha que você ainda não tenha feito de, no mínimo, 15 km e mapear esta trilha. Fazer o seguinte:
  a) Marcar, pelo menos, 10 pontos de interesse ou importantes desta trilha em seu GPS
  b) Fazer um registro de campo contendo:
    • Cópia impressa do mapa
    • Trajeto percorrido
    • Anotações e coordenadas dos pontos marcados'),
('AR-105', 'Rafting', 'atividades-recreativas', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/ar-105.webp', 'https://mda.wiki.br/Especialidade_de_Rafting', '1. Ter a especialidade de Segurança básica na água.
2. Citar quantos são os níveis de dificuldade de corredeiras e explique como é feita essa classificação.
3. Com um grupo de, no mínimo, 4 pessoas, demonstrar a forma correta de embarcar e sair do bote num pier na beira de um rio.
4. Num bote carregado com, no mínimo, 4 pessoas, demonstrar as manobras a seguir:
  a) Remada frente
  b) Remada ré
  c) Remada direita ré
  d) Remada esquerda ré
5. Num bote carregado com, no mínimo, 4 pessoas, durante cruzamento de uma corredeira, demonstrar os seguintes movimentos de segurança:
  a) Segurar
  b) Dentro (ou piso)
6. Citar, pelo menos, 3 itens de segurança necessários à prática do rafting e descrever a utilidade de cada um.
7. Descrever a posição correta que se deve ficar no caso de cair no rio e estar sendo levado(a) pela correnteza através de corredeiras.
8. Num bote com, no mínimo, 4 pessoas, demonstrar o resgate de um pessoa em águas profundas das seguinte maneiras:
  a) Pessoa próxima a uma distância de 2m do bote, utilizando-se a zona "T"do remo
  b) Pessoa a mais de 3m do bote, utilizado a corda de resgate
9. Com um grupo de, no mínimo, 4 pessoas, demonstrar:
  a) Como desvirar um bote
  b) Como subir novamente no bote sem ajuda de outra pessoa
10. Percorrer, no mínimo, 10 km num rio com corredeiras de nível III ou maior, demonstrando conhecimento nas regras de segurança do rafting.
11. Pesquisar 2 rios próximos da sua região que sejam adequados para a prática do rafting e coletar as seguintes informações:
  a) Local da nascente e desembocadura do rio
  b) Trecho onde a prática do rafting é adequada
  c) Épocas do ano em que o rio está favorável à prática do rafting
  d) Nível de dificuldade mínimo e máximo do rio
  e) Profundidade mínima e máxima do rio
  f) Altura da maior queda (corredeira)
  g) Nível de poluição das águas'),
('AR-106', 'Pião', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-106.webp', 'https://mda.wiki.br/Especialidade_de_Pião', '1. Realizar e apresentar uma pesquisa com cerca de 200 palavras sobre a história dos piões.
2. De que materiais eram feitos os piões da antiguidade? E de que diferentes materiais eles são feitos hoje em dia?
3. Explicar cada um dos seguintes métodos de impulsionar um pião:
  a) Fricção
  b) Corda ou fieira
  c) Mola
  d) Dedos
4. Desenhar um pião identificando as seguintes partes:
  a) Castelo, selo ou tacha
  b) Ponteira, bico, garrocha ou ferrão
  c) Corpo ou massa
5. Desenhar e explicar como funcionam os seguintes tipos de pião:
  a) Pião tradicional de madeira
  b) Pião de dedo, carrapeta, ou pião de haste-longa
  c) Tippe Top
  d) Brummkreisel
  e) Perinola
6. Sobre o uso de fieira (ou cordel) explicar:
  a) Qual o tamanho ideal da fieira?
  b) Qual a importância de prender a extremidade no dedo?
  c) Cite 3 formas de prender a fieira no dedo.
7. Qual a utilidade da tampografia nos piões tradicionais?
8. Explicar a relação entre a estabilidade, movimentação e queda do pião, com os seguintes conceitos físicos:
  a) Velocidade angular
  b) Efeito giroscópio
  c) Centro de gravidade
  d) Princípio da dinâmica (lª lei de Newton)
9. Estabelecer e seguir junto a seu instrutor um código de segurança para a prática de jogos com piões, com no mínimo 5 regras.
10. Utilizando um pião tradicional, demonstrar habilidade em completar as seguintes atividades:
  a) Força e Equilíbrio: enrolar corretamente a fieira e lançá-lo de modo que gire pelo tempo mínimo de 20 segundos antes de perder o equilíbrio;
  b) Técnica Apurada: lançar o pião, em seguida pegá-lo do chão para mão e, depois de alguns instantes, devolvê-lo ao chão ainda girando;
  c) Pôr pra Dormir. fazer com que o pião gire de modo que, por 10 segundos, ele permaneça no mesmo lugar e aparente estar parado;
  d) Girada de Castelo: girar o pião invertido (de "cabeça para baixo") apoiado apenas no castelo;
  e) Deslizamento: enquanto o pião gira, com a ajuda da fieira, movimentar o pião de um lugar para outro sem derrubá-lo;
  f) Precisão: lançar o pião de forma a acertar um alvo pré-determinado, como uma linha ou círculo no chão.
11. Completar ao menos uma das manobras:
  a) Fisgada no Ar: consiste em lançar o pião e antes que ele atinja o chão e a fieira se desenrole totalmente, fisgá-lo de volta, fazendo com que o pião gire na mão;
  b) Ponte ou Teleférico: com uma mão, segura os dois extremos da fieira e com a outra mão, a outra ponta que se forma. Estica-se então a fieira e na ponte que é formada recupera-se o pião ainda girando e, ao levantar uma das mãos, pode-se inclinar a fieira de tal maneira que o pião escorregue de um lado para o outro, enquanto permanece a girar.
  c) Lançamento: enquanto o pião gira no chão, fazer um seio à sua ponteira e fazê-lo pular, puxando as pontas da fieira com agilidade e força, servindo de impulso. Realizar a manobra duas vezes, uma vez com o pião saltando e caindo no chão, e outra com ele saltando e caindo na mão.
12. Conhecer ou criar, ao menos, 4 jogos coletivos com piões Convidar seus companheiros de unidade para participar de cada um dos jogos. Ao final, conversar com o instrutor sobre como se sentiu durante a atividade e sobre as vantagens da prática de recreação ao ar livre.'),
('AR-107', 'Tênis de Mesa', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-107.webp', 'https://mda.wiki.br/Especialidade_de_Tênis_de_Mesa', '1. Escrever um parágrafo de, pelo menos, 10 linhas explicando como começou a prática do tênis de mesa em seu país.
2. Qual a diferença entre o pingue-pongue e o tênis de mesa?
3. Quais são os equipamentos necessários para a realização de uma partida?
4. Quantas e quais são os tipos de empunhaduras?
5. Qual a organização é responsável pela regulamentação da prática do tênis de mesa em nível mundial? E a nível nacional?
6. Citar, pelo menos, 15 regras oficiais do tênis de mesa adotadas em seu país.
7. Quais os padrões oficiais para raquetes, mesas, bolas e redes?
8. Ter uma raquete de acordo com as regras e saber como mantê-la limpa e conservada.
9. Participar de um campeonato usando as regras adotadas pela instituição oficial responsável pelo tênis de mesa em seu país.'),
('AR-108', 'Vôlei', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-108.webp', 'https://mda.wiki.br/Especialidade_de_Vôlei', '1. Conhecer o regulamento atualizado da FIVB (Federação Internacional de Vôlei) e relacionar as 8 regras principais do vôlei.
2. O que significa a expressão "fair play"?
3. Definir os seguintes termos:
  a) Ace
  b) Antena
  c) Aquecimento
  d) Barreira
  e) Bloqueio
  f) Bola de graça
  g) Bola dentro
  h) Bola fora
  i) Bola presa
  j) Dois toques
  k) Golpe de ataque
  l) Jornada nas estrelas
  m) Levantador
  n) Líbero
  o) Manchete
  p) Match point
  q) Peixinho
  r) Quatro toques
  s) Rally
  t) Rede
  u) Rodízio
  v) Saque
  w) Saque viagem
  x) Set
  y) Set point
  z) Tempo técnico
  {) Toque Apoiado
4. Demonstrar e compreender as diferentes habilidades exigidas em cada posição do vôlei.
5. Demonstrar habilidade razoável nas seguintes áreas:
  a) Empunhadura
  b) Saque
  c) Passe
  d) Levantamento
  e) Ataque
  f) Bloqueio
6. Passar pelo menos 4 horas ajudando uma pessoa menos habilidosa ou mais jovem a melhorar suas habilidades no vôlei.
7. Jogar ao menos 5 partidas de vôlei com a família ou amigos. Mostrar "fair play" durante seus treinos e jogos.
8. Escrever um relatório de uma página sobre um famoso jogador de vôlei. Discutir porque ele é ou não é um bom modelo Cristão.
9. Discutir com seu líder, pastor ou instrutor os problemas enfrentados pela juventude Adventista do Sétimo Dia no ensino fundamental, ensino médio e faculdade. Que alternativas existem para permitir uma atividade esportiva contínua?
10. Desenhar, em escala, uma quadra de vôlei com seus limites adequadamente definidos. Informar as dimensões da rede de vôlei e respectiva altura de instalação.'),
('AR-109', 'Waveboarding', 'atividades-recreativas', 'especialidade', 1, 1986, 'Divisão do Sul do Pacífico', '/esp/ar-109.webp', 'https://mda.wiki.br/Especialidade_de_Waveboarding', '1. Qual a diferença entre skate e waveboarding?
2. Explicar porque o waveboarding é considerado a junção de 3 esportes radicais. Que esportes são esses?
3. Explicar sobre os seguintes equipamentos de segurança:
  a) Capacete
  b) Joelheira
  c) Caneleira
  d) Luvas
4. Desmontar e remontar corretamente seu waveboarding, identificando e nomeando cada parte.
5. Relacionar os tipos de rodas que existe, explicando a diferença entre elas e onde seus usa é mais indicado.
6. Fazer, pelo menos, 15 das seguintes manobras, sendo que 5 delas deverão ser em rampa:
  a) Olhe
  b) Wheehie (manual) por 10 metros
  c) Nose Wheelie (nose manual) por 10 metros
  d) C-Turn
  e) 1800 graus
  f) 180 varial corpo
  g) 360 Spin
  h) Grab Rail
  i) Leap Board
  j) Vire downhill
  k) Kickflip
  l) Impossible Duplo
  m) No Comply Kickflip
  n) Kickfkip Fakie
  o) Kickflip Switch
  p) Fakie Bigspin
  q) Nolhie Kckflip
  r) Nollie Hellflip
  s) Nolhie Frontside 180 bigspin
  t) Varial Kickflip
  u) Hellplip''Varial
  v) Backside Kickphip 180
  w) Frontside Hellphip 180
  x) Frontside Kickflip 180
  y) 360 e Kickflip
  z) Frontside duplo'),
('AR-110', 'Evolução em Ordem Unida', 'atividades-recreativas', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/ar-110.webp', 'https://mda.wiki.br/Especialidade_de_Evolução_em_Ordem_Unida', '1. Ter a especialidade de ordem unida básica
2. Definir o termo EVOLUÇÃO.
3. Apresentar cinco passos para desenvolver ou criar uma evolução.
4. Citar e explicar algum exemplo bíblico que usou o conceito de evolução para conquistar um território.
5. Criar 3 evoluções, praticar com um grupo e apresentá-las em uma ou mais cerimonias. Registrar com fotos e/ou vídeo.'),
('AR-111', 'Campori Seguro', 'atividades-recreativas', 'especialidade', 1, 2019, 'Divisão Sul Americana', '/esp/ar-111.webp', 'https://mda.wiki.br/Especialidade_de_Campori_Seguro', '1. Cite, pelo menos, 5 situações de riscos e perigos de acidentes em um Campori.
2. Defina o que é prevenção de acidentes.
3. Memorizar os conselhos de prevenção do acróstico abaixo:
  • S - Seja cuidadoso
  • E - Esteja sempre acompanhado com a sua Unidade
  • G - Garrafa de água sempre à mão
  • U - Use boné, protetor solar e repelente
  • R - Respeite o próximo
  • O - Observe o perigo
4. Citar duas maneiras de como você pode ser um agente de prevenção para um Campori Seguro.'),
('AR-112', 'Acampamento Consciente', 'atividades-recreativas', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ar-112.webp', 'https://mda.wiki.br/Especialidade_de_Acampamento_Consciente', '1. Pesquisar e listar os princípios para a realização de um acampamento sem rastros.
2. Qual a importância de um bom planejamento para realizar um acampamento consciente?
3. Explicar a importância de se preservar sítios e parques históricos e por que não podemos acampar nessas áreas.
4. Participar de um acampamento de final de semana utilizando técnicas para minimizar o impacto na natureza.
5. Descrever os princípios para se cozinhar em um acampamento consciente. Explicar que tipo(s) de fogueira causa(m) menos impacto e por que. Utilizá-la no acampamento e limpar seus rastros corretamente após o uso.
6. Eliminar corretamente o lixo produzido no acampamento.
7. Eliminar corretamente os dejetos humanos. Explicar os riscos de não eliminar corretamente para animais selvagens, campistas e fontes de água.
8. Explicar e demonstrar qual deve ser a postura do desbravador em relação a:
  a) Outros campistas e visitantes;
  b) Fauna e a flora;
  c) Habitantes e moradores do local.
9. Citar três versos da Bíblia que falam sobre o cuidado que devemos ter com a natureza.'),
('AR-113', 'Artes Mateiras', 'atividades-recreativas', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/ar-113.webp', 'https://mda.wiki.br/Especialidade_de_Artes_Mateiras', '1. Pesquisar e descrever o significado do termo Bushcraft.
2. Preparar uma lista com espécimes silvestres comestíveis da sua região.
3. Explicar por que não devemos consumir vegetais/cogumelos encontrados na natureza sem conhecê-los.
4. Conhecer métodos de encontrar os pontos cardeais em diferentes situações como noite, dia e céu nublado.
5. Participar de um acampamento com estilo Bushcraft.
6. Montar e utilizar no acampamento um kit de sobrevivência com no mínimo 10 itens.
7. Completar o seguinte enquanto estiver no acampamento:
  a) Coletar, armazenar e purificar água para consumo no acampamento;
  b) Utilizar dois tipos diferentes de fogueiras para preparar os alimentos;
  c) Utilizar três dos seguintes métodos para acender uma das fogueiras: arco, broca manual, pedra e aço, lupa ou pedaço de vidro, saco com água, bombril e pilha;
  d) Utilizar um fogareiro para cozinhar uma das refeições;
  e) Coletar e preparar alimentos encontrados na natureza;
  f) Improvisar utensílios de cozinha e utilizá-los em um dos dias do acampamento.
8. Completar três dos seguintes requisitos:
  a) Construir uma cama suspensa;
  b) Preparar um abrigo natural e usar durante uma noite no acampamento;
  c) Fazer uma corda utilizando materiais naturais;
  d) Construir uma mesa em pioneiria;
  e) Fazer tochas e utilizar à noite;
  f) Construir um chuveiro improvisado.'),
('AR-114', 'Bolinha de Gude', 'atividades-recreativas', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ar-114.webp', 'https://mda.wiki.br/Especialidade_de_Bolinha_de_Gude', '1. O que é bolinha de gude? Contar como essa brincadeira surgiu.
2. Citar alguns tipos de matéria-prima que podem ser usadas na fabricação de uma bolinha de gude.
3. Mencionar as etapas da fabricação de uma bolinha de gude na atualidade.
4. Descrever os seguintes termos na brincadeira de bolinha de gude:
  a) Triângulo;
  b) Buraco;
  c) Estrela;
  d) Bolicão;
  e) Leiteira;
  f) Chinesinha;
  g) Cela;
  h) Burca, burquinha;
  i) Mata-mata.
5. Saber, pelo menos, cinco modalidades que podemos praticar com a bolinha de gude.
6. Conhecer e explicar algumas regras básicas antes de iniciar uma partida de bolinha de gude.
1. Desenhar no chão uma pista para jogar uma partida:
2. Participar de uma rápida competição de bolinha de gude.'),
('AR-115', 'Comida Mateira', 'atividades-recreativas', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ar-115.webp', 'https://mda.wiki.br/Especialidade_de_Comida_Mateira', '1. Ter a especialidade de Fogueiras e cozinha ao ar livre.
2. O que é comida mateira?
3. Participar em um acampamento que ao menos três refeições sejam de comida mateira. Preparar um cardápio balanceado para estas refeições.
4. Preparar três dos seguintes alimentos (anexar as receitas contendo ingredientes e modo de fazer):
  a) Bolo de fubá na folha de bananeira;
  b) Pão de caçador;
  c) Pão na brasa;
  d) Ovo no espeto;
  e) Ovo na caixa de papel;
  f) Ovo frito na forquilha;
  g) Ovo no barro ou na laranja;
  h) Banana doce na brasa;
  i) Batata recheada;
  j) Arroz mateiro;
  k) Sopa.
5. Improvisar e utilizar panelas, copos, pratos e talheres artesanais.'),
('AR-116', 'Construções Rústicas de Grande Porte', 'atividades-recreativas', 'especialidade', 3, 2025, 'Divisão Sul Americana', '/esp/ar-116.webp', 'https://mda.wiki.br/Especialidade_de_Construções_Rústicas_de_Grande_Porte', '1. Quais os melhores tipos de madeiras e/ou bambus para se construir estruturas rústicas de grande porte? Descrever suas características físicas e de resistência.
2. Conhecer pelo menos três tipos de tratamentos preventivos da madeira que podem ser aplicados para prolongar sua vida útil ao ar livre.
3. Explicar por que as madeiras e bambus devem estar o mais seco possível para esse tipo de construções.
4. Saber quais são as normas locais que regem a construção de estruturas rústicas de grande porte e as normas de segurança que devem ser observadas.
5. Definir o que é uma estrutura fixa ou enterrada e uma autoportante ou autossustentada, mencionar que porcentagem da estrutura deve ser enterrada em relação à sua altura e quais são as medidas de segurança adicionais necessárias para uma estrutura autoportante.
6. Demonstrar como decompor uma força e qual é a utilidade desse conhecimento na hora de projetar uma estrutura de grande porte.
7. Demonstrar habilidade para utilizar ferramentas necessárias na construção de estruturas rústicas de grande porte, como facão, machado de mão, faca, serra de arco, amoladora, plaina elétrica e manual, formões, maços ou martelos grandes, chaves combinadas, chaves de tubo, furadeira elétrica com brocas para madeira de diferentes diâmetros.
8. Como deve ser feito para alcançar uma vertical perfeita em uma estrutura de pelo menos quatro metros, seja ela enterrada ou não?
9. Demonstrar habilidade para fazer um encaixe e amarrar com amarras a interseção de duas madeiras de diâmetro superior a 10 cm em ângulos de 90° e 45°.
10. Demonstrar como fazer uniões com ferragens como varas roscadas, pregos, parafusos e arames. Explicar por que esses elementos devem ser utilizados em alguns casos em estruturas de grande porte.
11. Saber como desenhar (à mão ou por meio de programas de computador) um plano em escala com vistas frontal, superior e lateral de um projeto de grande porte, detalhando todas as suas características e colocando todas as cotas necessárias e especificações para poder ser realizado. (Este requisito deve ser cumprido para pelo menos dois dos projetos solicitados no requisito 13).
12. Escolher um dos projetos que realizará no requisito seguinte e realizá-lo previamente em uma maquete realista utilizando uma escala entre 1:20 a 1:50. A maquete deve ser confeccionada com o máximo de detalhes, tentando ser o mais parecido possível com a realidade, incluindo decoração com bandeiras, iluminação e cartazes de identificação.
13. Completar pelo menos três dos seguintes projetos. Em todos os casos, deve-se ter decoração própria com elementos do clube, iluminação, correta localização das bandeiras e símbolos patrióticos, cartaz/placa de identificação do clube/campo/união:
  a) Uma torre de pelo menos 4 metros de altura, sem contar a altura dos mastros, com uma superfície de pelo menos 2 x 2, para um acampamento do seu clube;
  b) Um pórtico de entrada para seu Clube de Desbravadores em um evento de Associação ou Missão de pelo menos 4.5 metros de altura, sem contar a altura dos mastros, com uma superfície de pelo menos 2 x 3 metros;
  c) Um pórtico, torre ou mangrulho para hasteamento de bandeiras em um evento da Associação/Missão de pelo menos 5 metros de altura, sem contar a altura dos mastros, e com uma superfício de pelo menos 9m²;
  d) Um portico, torre ou mangrulho para a sua Associação/Missão em um evento de União de pelo menos 5.5 metros de altura, sem contar a altura dos mastros, e com uma superfície de pelo menos 10m²;
  e) Estrutura de grande porte para a sua União em um evento de Divisão de pelo menos 6 metros de altura, sem contar a altura dos mastros, e de pelo menos 12m².'),
('AR-117', 'Cozinha Segura', 'atividades-recreativas', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/ar-117.webp', 'https://mda.wiki.br/Especialidade_de_Cozinha_Segura', '1. Explicar a importância de manter segura a cozinha do acampamento e do campori e preparar um checklist de cuidados que devem ser tomados em cada caso.
2. Ler o voto "Orientações sobre alimentação em instituições ou programas oficiais da Igreja Adventista" e explicar a importância de se seguir esse voto nos acampamentos do Clube de Desbravadores e em camporis.
3. Saber como evitar intoxicação por alimentos/água em um acampamento ou campori.
4. Sobre as possíveis urgências e emergências que podem ocorrer em uma cozinha de acampamento ou campori, cumprir os seguintes itens:
  a) Saber os primeiros socorros prestados a vítimas de queimaduras;
  b) Demonstrar a manobra adequada caso uma vítima esteja engasgada;
  c) Saber os telefones de emergência pelos quais podem ser acionados o Corpo de Bombeiros e o serviço médico móvel, em caso de urgências/emergências;
  d) Explicar qual tipo de extintor é indicado para possíveis incêndios em acampamentos e camporis e explicar o porquê.
  e) Verificar se há produtos inflamáveis na cozinha do acampamento ou campori e armazená-los corretamente.
5. Conhecer e demonstrar quais cuidados devem ser tomados ao se preparar a fogueira para a cozinha de um acampamento, incluindo:
  a) Coleta da lenha;
  b) Preparação do local da fogueira;
  c) Acendimento;
  d) Vento;
  e) Fixação da base para panela;
  f) Preparação do alimento;
  g) Retirada da panela do fogo;
  h) Descarte da fogueira.
6. Completar os seguintes itens:
  a) Conhecer os cuidados que se deve ter com a mangueira, regulador e botijão de gás;
  b) Explicar quais os riscos de se transportar botijão de gás;
  c) Explicar a importância de se fazer manutenção periódica nos fogões e fornos;
  d) Explicar quais cuidados devemos ter com panelas de pressão para se evitar acidentes.
7. Saber usar corretamente um fogareiro e citar os cuidados com o seu uso.
8. Aplicar o checklist elaborado no requisito 1 em uma cozinha de acampamento ou campori.'),
('AR-118', 'Cubo Mágico', 'atividades-recreativas', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/ar-118.webp', 'https://mda.wiki.br/Especialidade_de_Cubo_Mágico', '1. Possuir um cubo de Rubik (3x3x3).
2. Fazer um breve relato sobre a história do cubo de Rubik e mencionar a origem do seu nome.
3. Quais são as cores opostas que um cubo de Rubik, que segue um padrão de cores tradicional, sempre terá? Se seu cubo não segue o padrão de cores tradicional, quais são as cores opostas que seu cubo apresenta?
4. Explicar a diferença entre montar e resolver o cubo mágico.
5. Quais são os movimentos básicos possíveis de se fazer no cubo mágico? Em quais sentidos esses movimentos podem aparecer?
6. Existe forma e posição correta para se segurar o cubo mágico para resolvê-lo? Qual é a importância de segurá-lo corretamente ao executar um algoritmo?
7. Citar os principais métodos de resolução do cubo mágico. Qual é o método de resolução mais indicado para iniciantes? Descrever o passo a passo deste método.
8. Existem casos impossíveis de serem resolvidos no cubo mágico? Por qual motivo isso pode acontecer? Citar quais são estes casos e descrever como resolver.
9. Explicar os itens abaixo:
  a) O que é algoritmo e qual é a relação do algoritmo com o cubo mágico?
  b) O que é scramble?
  c) O que significa o termo look ahead? Por que é de extrema importância treinar o look ahead?
  d) O que são fingertricks? Por que é importante desenvolver estas técnicas para melhorar o seu desempenho no cubo mágico?
  e) Definir o termo twisty puzzle e qual a sua relação com o cubo mágico.
10. O cubo mágico é considerado um esporte? Quando isso foi oficializado? Podemos chamar de atletas aqueles que praticam e participam de competições de cubo mágico?
11. Ser capaz de resolver um cubo mágico 3x3x3 usando o método de camadas em menos de cinco minutos.
12. Demonstrar como limpar e lubrificar um cubo de Rubik.'),
('AR-119', 'Slackline', 'atividades-recreativas', 'especialidade', 3, 2025, 'Divisão Sul Americana', '/esp/ar-119.webp', 'https://mda.wiki.br/Especialidade_de_Slackline', '1. Saber onde e como surgiu o Slackline no mundo e no Brasil.
2. Conhecer e explicar as regras de segurança para a prática segura do Slackline.
3. Citar pelo menos duas variações ou modalidades de Slackline e descrever as suas características.
4. Citar alguns benefícios que a prática do Slackline pode trazer para quem o pratica.
5. Fazer o trajeto de ida e vinda numa fita de no mínimo 5 metros de comprimento, com meio metro de altura do chão em até 30 segundos.
6. Fazer o trajeto, e no meio da fita realizar um "butt bounce" (sentar-se, pular e continuar andando na fita) e continuar o trajeto.
7. Fazer um "walking backwards" (andar de costas sobre a fita) em 30 segundos.
8. Fazer um "turn around" (andar e girar) sem perder o equilíbrio.
9. Realizar um "Sit Down" (sentar-se na fita) e manter o equilíbrio por pelo menos 15 segundos.'),
('AR-120', 'Trilha de Sinais', 'atividades-recreativas', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/ar-120.webp', 'https://mda.wiki.br/Especialidade_de_Trilha_de_Sinais', '1. Demonstrar habilidade para localizar azimutes.
2. Descrever as regras de segurança necessárias para seguir uma trilha.
3. Descrever oito ações que devem ser seguidas quando estiver perdido.
4. Quais cuidados devemos ter com a natureza ao seguirmos uma pista?
5. Citar os cuidados que devem ser tomados ao seguir os sinais de pista, considerando que outras pessoas seguirão a pista após você.
6. Saber identificar, pelo menos, 20 sinais de pista. Ter um material de apoio com a ilustração, foto ou desenho do sinal, o seu significado e quais materiais podem ser usados para fazê-lo.
7. Participar de um grupo de uma atividade de trilha em um acampamento, utilizando sinais de pista e bússola.
8. Ler Êxodo 13:21-22 e explicar como Deus guiou Seu povo no deserto.'),
('AR-121', 'Troca de Pins', 'atividades-recreativas', 'especialidade', 1, 2014, 'Divisão Norte Americana', '/esp/ar-121.webp', 'https://mda.wiki.br/Especialidade_de_Troca_de_Pins', '1. Explicar a origem do pin trading (troca de pins) e como essa prática começou no Clube de Desbravadores.
2. Definir os seguintes termos:
  a) Botton;
  b) Pino;
  c) Etiqueta;
  d) Lanyard;
  e) Pin.
3. Identificar dois tipos comuns de fechos para pins e demonstrar ou descrever como colocá-los e retirá-los com segurança.
4. Saber onde é possível conseguir pins para trocar, incluindo pins gratuitos ou baratos. Conseguir, pelo menos, três pins para trocar.
5. Discutir, pelo menos, cinco diferentes métodos de exibir seus pins para trocar. Escolher um método que você gostou e organizar seus pins para trocar.
6. Nomear três lugares ou eventos onde o pin trading é uma atividade popular.
7. Explicar os seguintes princípios da etiqueta do pin trading:
  a) Diversão;
  b) Justiça;
  c) Amizade.
8. Trocar pins com, pelo menos, cinco pessoas que você não conheça em um lugar ou evento, usando os princípios de etiqueta diversão, justiça e amizade. Compartilhar com sua unidade, classe ou conselheiro/líder uma história interessante ou sobre alguém que você conheceu enquanto trocava pins.'),
('CS-001', 'Saúde e Cura', 'ciencia-e-saude', 'especialidade', 1, 1928, 'Associação Geral', '/esp/cs-001.webp', 'https://mda.wiki.br/Especialidade_de_Saúde_e_Cura', '1. Aprender, através da Bíblia e/ou do Espírito de Profecia, como Jesus curou os doentes e o procedimento usado pelos anciãos da igreja para ungir o doente e pedir a Deus pela cura. Apresentar um relatório oral sobre o que você aprendeu ou escrever um relatório com, no mínimo, 250 palavras.
2. Qual a importância da educação contínua para os profissionais de saúde?
3. Entrevistar pelo menos duas pessoas que trabalham na área de saúde. Uma delas deve ter outra profissão que não médico(a) ou enfermeiro (a), como por exemplo, dentista, fisioterapeuta, psicólogo, nutricionista, etc. Em suas entrevistas, fazer as seguintes perguntas:
  a) Por que escolheu esta profissão?
  b) Que faculdade (ou cursos) é preciso fazer para trabalhar em sua profissão?
  c) Além da conclusão da faculdade/curso, que outros requisitos são necessários para exercer a sua profissão?
  d) Qual é o aspecto que você mais gosta em seu trabalho? O que gosta menos?
  e) Que dias da semana, e quantas horas diárias, você tem que trabalhar?
  f) Que tipos de promoção você pode ter em sua carreira?
  g) Que outros cursos você poderia fazer para completar seus conhecimentos sobre sua profissão?
  h) Quais algumas instituições em sua cidade que oferecem cursos na sua área?
4. Completar uma das seguintes atividades:
  a) Visitar um consultório médico ou odontológico e fazer o seguinte:
    • Observar as áreas de operação, tais como a área administrativa, laboratório, salas de exames, salas de raios-X, etc.
    • Pedir ajuda para alguém lhe apresentar o equipamento usado naquele consultório.
    • Aprender os passos de uma consulta, desde o momento em que em que o paciente chega à sala de espera até o momento em que deixa o consultório.
    • Aprender como o médico/dentista examina o paciente, desde as anotações da história clínica até o diagnóstico e conduta.
  b) Fazer uma visita com um enfermeiro(a) que trabalhe a domicílio, e:
    • Aprender os passos de uma visita em domicílio, desde quando o enfermeiro/técnico de enfermagem descobre algo sobre o paciente, até o momento em que relata o caso a um médico.
    • Observar o enfermeiro/técnico de enfermagem aferir os sinais vitais do paciente.
    • Observar o enfermeiro/técnico de enfermagem dando instruções e administrando medicamentos.
  c) Visitar um laboratório ou qualquer instituição que realize exames complementares (como radiografia, ultrassonografia, eletrocardiograma) e fazer o seguinte:
    • Observar as diferentes áreas de atuação do laboratório;
    • Quais exames são realizados?
    • Quais as orientações aos pacientes para realizarem estes exames?
    • Pedir que alguem lhe apresente o equipamento usado no laboratório, e como funciona;
    • Aprender os passos dados por um paciente quando vai àquele laboratório;
    • Quantas pessoas trabalham no laboratório?
    • O laboratório funciona a noite?
5. Através de pesquisa na internet ou visita a uma faculdade/universidade da sua cidade ou estado, descobrir algumas matérias e a duração dos seguintes cursos da área da saúde:
  a) Biomedicina
  b) Enfermagem
  c) Farmácia
  d) Medicina
  e) Nutrição
  f) Odontologia
  g) Psicologia'),
('CS-002', 'Química', 'ciencia-e-saude', 'especialidade', 2, 1937, 'Associação Geral', '/esp/cs-002.webp', 'https://mda.wiki.br/Especialidade_de_Química', '1. Definir o seguinte:
  a) Compostos
  b) Soluções
  c) Transformação Química
  d) Transformação Física
  e) Átomos
  f) Próton
  g) Nêutron
  h) Elétron
  i) Molécula
  j) Ácido
  k) Sal
  l) Destilação
  m) Destilação fracionada
  n) Filtragem
  o) Combustão
  p) Dissolução fracionada
  q) Indicadores Ácido/Base
  r) Base
  s) Óxido
2. Responder as seguintes questões:
  a) O que são elementos químicos?
  b) O que é tabela periódica e qual a sua importância?
  c) Como os elementos estão agrupados na tabela?
  d) O que é número atômico?
  e) De que forma os elementos são representados na tabela?
3. Quais gases podem causar morte? Como?
4. Mencionar 2 fontes comuns de monóxido de carbono. Por que é uma substância perigosa?
5. Quais os estados físicos da matéria?
6. Explicar o fenômeno químico que está envolvido em 5 das alternativas a seguir:
  a) Tentar acender um cubo de açúcar, primeiro sem e depois com algumas cinzas aplicadas ao cubo, demonstrando a ação catalisadora.
  b) Colocar um cubo de gelo num copo com água, colocar um barbante de 10 centímetros em cima do gelo no copo, então solucionar o problema de tirar o cubo de gelo da água sem tocá-lo.
  c) Usando água, aguarrás e sabão, transferir uma foto de jornal para uma folha de papel em branco.
  d) Usando uma bacia de água, fósforos de madeira, um torrão de açúcar e um pouco de sabão, demonstrar a ação do açúcar e do sabão sobre fósforos que boiam na água.
  e) Colocar um ovo fresco em água doce e depois salgar a mesma, anotando a diferença.
  f) Fazer uma tinta invisível
  g) Usando 3 pedaços de velas de tamanhos diferentes e um recipiente de vidro, explicar correntes de convenção e densidade dos gases.
  h) Usando uma vela, um pedaço de papel e um anteparo de vidro, explicar a combustão incompleta através do composto formado. Quantos e quais fenômenos estão envolvidos quando uma vela está acessa?
  i) Demonstrar a capacidade térmica da água usando alguns dos seguintes materiais: uma vela, um balão ou bexiga, água, álcool 20%, acetona, papel, tripé de arame, papel pregueado.
  j) Usando raspas de magnésio, vela e indicador ácido/base, indicar o tipo de reação envolvida e demonstrar a acidez ou a basicidade do composto formado.
  k) Usando 2 tubos de vidro, 2 espetos de madeira, bicarbonato de sódio, vinagre, iodeto de potássio e água oxigenada, demonstrar a combustão em presença e na ausência de oxigênio.
  l) Utilizando alguns indicadores ácido/base, demonstrar a acidez ou basicidade de alguns produtos encontrado em nosso dia a dia. E também demonstrar uma reação reversível.
  m) Em um acampamento, por um descuido, um desbravador derramou o açúcar que deveria ser utilizado para adoçar o suco da refeição na areia. Utilizando-se do que se tem no acampamento, proponha os passos de um método para separar os componentes da mistura em questão. Em seguida, informe se houve alguma transformação química ou física.
  n) Quantos e quais fenômenos estão envolvidos quando uma vela está acesa?'),
('CS-003', 'Primeiros Socorros - básico', 'ciencia-e-saude', 'especialidade', 1, 1951, 'Associação Geral', '/esp/cs-003.webp', 'https://mda.wiki.br/Especialidade_de_Primeiros_Socorros_-_básico', '1. Definir primeiros socorros e descrever a sua finalidade.
2. Saber como obter ajuda em uma emergência.
3. Demonstrar a manobra adequada caso uma vítima esteja engasgada.
4. Saber os primeiros socorros prestados a uma vítima de envenenamento/intoxicação.
5. Saber quais situações podem levar a uma intoxicação por monóxido de carbono(CO). Descrever a forma de resgate e os primeiros socorros para este tipo de intoxicação.
6. Quais os primeiros socorros prestados a uma pessoa que esteja com as roupas em chamas?
7. Quais são os princípios básicos para a prevenção de incêndios em sua casa?
8. Saber os primeiros socorros prestados a uma vitima com hemorragia externa.
9. Saber os primeiros socorros prestados a vítima de queimaduras de primeiro, segundo e terceiro graus. Através de desenhos ou modelos, demonstrar a porcentagem de área corporal das seguintes partes do corpo: cabeça, membros superiores, membros inferiores, dorso, tórax e abdome.
10. Saber os primeiros socorros a uma vítima de queimadura química.
11. Saber os primeiros socorros a uma vítima que foi picada por uma serpente. Saber qual o centro de saúde referência em acidentes ofídicos em sua região.
12. Saber os primeiros socorros a uma vítima que foi mordida por um animal. Definir o que é raiva e qual a classe de animais que podem transmitir a raiva.
13. Saber os primeiros socorros a uma vítima que foi picada por insetos ou aranhas.
14. Saber os primeiros socorros a vítimas com ferimentos internos.
15. Quais os princípios básicos de segurança em rios, mares e piscinas?
16. Quais as maneiras de salvar uma vítima de afogamento sem nadar?'),
('CS-004', 'Primeiros Socorros - intermediário', 'ciencia-e-saude', 'especialidade', 2, 1938, 'Associação Geral', '/esp/cs-004.webp', 'https://mda.wiki.br/Especialidade_de_Primeiros_Socorros_-_intermediário', '1. Ter a especialidade de Primeiros Socorros - básico
2. O que são EPIs (Equipamentos de proteção individual)? Qual a sua importância para os atendimentos de primeiros socorros?
3. O que significa o protocolo ABCDE? Quando deve ser usado?
4. Conhecer os primeiros socorros que devem ser prestados nas seguintes situações:
  a) Ferimentos na cabeça
  b) Hemorragia interna
  c) Ferimentos à bala
  d) Ferimentos no olho
  e) Desmaio e convulsão
  f) Efeitos do calor ou frio extremos
5. Qual a diferença entre desidratação e insolação? Quais os primeiros socorros devem ser prestados em cada situação?
6. Saber como aplicar adequadamente as seguintes ataduras: Nota: Demonstrar habilidade aplicando as ataduras acima nas seguintes regiões do corpo: cabeça, antebraço, mão, joelho e tornozelo.
  a) Espiral
  b) Cruzada ou em oito
  c) Frontal, para a cabeça
7. Quais materiais podem ser usados como talas em situações de emergência? Saber como aplicar talas às seguintes partes do corpo:
  a) Braço
  b) Antebraço
  c) Joelho
  d) Tornozelo
8. O que é torniquete? Por que seu uso pode ser tão prejudicial? Quando esta técnica poderá ou não ser usada?
9. O que é choque? Quais são os principais tipos? Quais as principais causas? Quais primeiros socorros devem ser prestados a vitimas com choque hipovolêmico? E anafilático?
10. Qual é a diferença entre infarto agudo do miocárdio (IAM) e acidente vascular encefálico (AVE)? Quais os primeiros socorros devem ser prestados em cada situação?
11. Saber os primeiros socorros que devem ser prestados a uma vitima de acidente com eletricidade.
12. Quais são os princípios básicos de segurança com eletricidade?
13. Saber como escapar de um incêndio?'),
('CS-005', 'Primeiros Socorros - avançado', 'ciencia-e-saude', 'especialidade', 3, 1963, 'Associação Geral', '/esp/cs-005.webp', 'https://mda.wiki.br/Especialidade_de_Primeiros_Socorros_-_avançado', '1. Ter a especialidade de Primeiros Socorros - intermediário
2. Quais primeiros socorros devem ser prestados a vítimas de acidente de trânsito? Quais os cuidados com o local do acidente? Quais os cuidados com as vítimas?
3. Ensinar a especialidade de Primeiros Socorros - básico ou Primeiros Socorros - intermediário a um grupo de desbravadores ou alunos.
4. Montar um portfólio de materiais de primeiros socorros, para deixar na biblioteca do seu Clube.
5. Quais são os aspectos éticos e legais, em seu país, envolvidos na prestação de primeiros socorros?
6. Definir os seguintes termos:
  a) Omissão de socorro
  b) Abandono
  c) Negligência
  d) Imperícia
  e) Imprudência'),
('CS-006', 'Enfermagem Básica', 'ciencia-e-saude', 'especialidade', 2, 1938, 'Associação Geral', '/esp/cs-006.webp', 'https://mda.wiki.br/Especialidade_de_Enfermagem_Básica', '1. Quem é Florence Nightingale e qual a sua contribuição para a enfermagem?
2. Entrevistar um enfermeiro ou um técnico/auxiliar de enfermagem e fazer as seguintes perguntas:
  a) Por que escolheu esta profissão?
  b) Que faculdade/curso é preciso fazer para trabalhar em sua profissão?
  c) Além da conclusão da faculdade/curso, que outros requisitos são necessários para exercer a sua profissão?
  d) Qual é o aspecto que você mais gosta em seu trabalho? O que menos gosta?
  e) Que dias da semana, e quantas horas diárias, você tem que trabalhar?
  f) Citar algumas instituições em sua cidade ou Estado que oferecem cursos na sua área.
3. Quais são os sinais vitais? Quais são os valores de normalidade de cada sinal vital (para um adulto)?
4. Praticar aferir o pulso, a respiração e a temperatura de um amigo do seu clube.
5. O que é febre? Conhecer os sinais e sintomas da febre. É necessário usar medicamentos sempre que se tem febre? Por que?
6. O que é uma doença contagiosa? Quais são as vias de transmissão? Que precauções devem ser seguidas para evitar a transmissão dessas doenças? Relacionar medidas de segurança a serem observadas ao cuidar de alguém que esteja com uma doença contagiosa.
7. Saber quando e como lavar as mãos quando estiver cuidando de alguém doente.
8. Qual a importância da mudança de decúbito para uma pessoa que está acamada? Como ela é feita e com que frequência deve ser feita?
9. Demonstrar como se aplica uma compressa quente/fria. Quando é indicado usar compressas quentes? Quando é indicado usar compressas frias?'),
('CS-007', 'Ótica', 'ciencia-e-saude', 'especialidade', 2, 1962, 'Associação Geral', '/esp/cs-007.webp', 'https://mda.wiki.br/Especialidade_de_Ótica', '1. Definir e desenhar um gráfico dos seguintes sistemas ópticos:
  a) Centro óptico
  b) Foco
  c) Distância focal
  d) Ponto antiprincipal
  e) Lente convergente (positiva)
  f) Lente divergente (negativa)
  g) Lentes esféricas
  h) Aberração cromática
  i) Refração da luz
  j) Reflexão da luz
  k) Reflexão total
2. Explicar como a luz se comporta quando atinge ou atravessa água, óleo, metais e um espelho.
3. Mencionar o nome e fazer diagramas de 3 tipos de lentes convergentes e 3 tipos de lentes divergentes.
4. Fazer a construção geométrica das imagens em lentes convergentes, informando a natureza da imagem, sua localização, tamanho, orientação e dê exemplos:
  a) Objeto antes do ponto antiprincipal objeto (Ao)
  b) Objeto sobre o ponto antiprincipal objeto (Ao)
  c) Objeto entre o ponto antiprincipal objeto e o foco objeto (Ao e fo)
  d) Objeto sobre o foco objeto (fo)
  e) Objeto entre o foco objeto e o centro óptico (fo e O)
5. Fazer a construção geométrica das imagens em lentes divergentes.
  a) Objeto sobre o ponto antiprincipal objeto (Ao)
  b) Objeto entre o ponto antiprincipal objeto e o foco objeto (Ao e fo)
  c) Objeto sobre o foco objeto (fo)
  d) Objeto entre o foco objeto e o centro óptico (fo e O)
6. Demonstrar, através de gráficos, como funciona um prisma. Marcar os ângulos em que as cores aparecem e desaparecem.
7. Demonstrar o que acontece quando a luz atravessa um vidro translúcido.
8. Com uma lente convergente e os raios solares, acender uma fogueira e explicar o porquê isso acontece. Explicar também o porquê não é possível acender uma fogueira com uma lente divergente.
9. Construir um instrumento óptico usando espelhos ou lentes, tais como um periscópio, um projetor de slides ou um telescópio simples.
10. Explicar o que significa o termo 6x35 e 7x50 aplicado a binóculos.
11. Definir o termo "número-f" usado em conexão com câmeras fotográficas.'),
('CS-008', 'Nutrição', 'ciencia-e-saude', 'especialidade', 2, 1981, 'Associação Geral', '/esp/cs-008.webp', 'https://mda.wiki.br/Especialidade_de_Nutrição', '1. O que são nutrientes?
2. O que são e quais são os macronutrientes? Quais as princípios funções de cada um? Citar exemplos de alimentos em cada grupo.
3. O que são micronutrientes?
4. Qual a função das seguintes vitaminas? Fazer uma lista de, pelo menos, 3 alimentos fontes dos seguintes nutrientes:
  a) Vitamina A
  b) Vitamina B12
  c) Vitamina C
  d) Vitamina D
  e) Vitamina E
  f) Vitamina K
5. Qual a função dos seguintes minerais no nosso organismo? Fazer uma lista de, pelo menos, 3 alimentos fontes de cada um:
  a) Ferro
  b) Iodo
  c) Cálcio
  d) Sódio
  e) Potássio
  f) Zinco
6. Desenhar e descrever a pirâmide alimentar. Mencionar o número de porções diárias recomendadas de cada grupo.
7. O que são Valores diários de Referência (VDR) e qual sua importância?
8. O que é uma dieta balanceada?
9. Explicar as diferenças entre as seguintes dietas:
  a) Ovolactovegetariano
  b) Ovo-vegetariano
  c) Vegetariano estrita
10. Comparar as informações nutricionais dos seguintes alimentos:
  a) Leite integral e leite desnatado
  b) Farinha de trigo branca e Farinha de trigo integral
  c) Pão integral e pão branco
  d) Arroz integral e arroz branco
11. Qual é a diferença entre alimentos diet e alimentos light?
12. Porque é importante beber bastante água diariamente? Qual a quantidade recomendável para cada dia?
13. Citar o nome de 3 doenças comuns que podem ser controladas/evitadas com uma dieta apropriada.
14. Por que o Governo de alguns países determina a inclusão de iodo, ferro, ácido fólico e flúor em alimentos básicos como farináceos, sal e água? Qual o impacto desta medida na saúde da população?
15. Planejar e executar um cardápio para dois dias, contendo uma dieta ovo-lacto-vegetariana balanceada, utilizando as informações da pirâmide alimentar. Utilizar vegetais comuns em sua região e de acordo com a época do ano.
16. Quais foram as vantagens que Daniel e seus amigos tiveram por escolherem uma alimentação saudável e vegetariana?')
on conflict (codigo) do update set nome = excluded.nome, categoria_slug = excluded.categoria_slug, tipo = excluded.tipo, nivel = excluded.nivel, ano = excluded.ano, origem = excluded.origem, imagem = excluded.imagem, url_mda = excluded.url_mda, requisitos = excluded.requisitos;

insert into public.especialidades (codigo, nome, categoria_slug, tipo, nivel, ano, origem, imagem, url_mda, requisitos) values
('CS-009', 'Alerta Vermelho', 'ciencia-e-saude', 'especialidade', 1, 1986, 'Associação Geral', '/esp/cs-009.webp', 'https://mda.wiki.br/Especialidade_de_Alerta_Vermelho', '1. Explicar o que deve ser feito para evitar ferimentos e/ou morte cinco das situações a seguir:
  a) Incêndio em sua casa, ou na casa de um vizinho, ou em prédio público
  b) Se estiver perdido, de carro, num lugar ermo ou deserto
  c) Acidente automobilístico
  d) Terremoto
  e) Enchente
  f) Ciclone
  g) Furacão
  h) Tempestade
  i) Acidente nuclear
  j) Desmoronamento
  k) Se barco ou canoa vira em mar aberto
2. Ao telefonar pedindo ajuda numa emergência, que informações essenciais devem ser dadas, e quem deve desligar o telefone por último? Quais são os principais números de emergência em seu país?
3. Demonstrar que medidas de primeiros socorros você deveria tomar numa emergência nas seguintes circunstâncias:
  a) A roupa de alguém pega fogo
  b) Alguém está engasgado
  c) Alguém engoliu veneno
4. Fazer o seguinte:
  a) Desenhar uma rota de escape para sua família em caso de incêndio em sua casa, para o caso das saídas normais estarem bloqueadas.
  b) Fazer com sua família um treinamento para o caso de incêndios;
  c) Discutir com seu instrutor os procedimentos para retirar pessoas da igreja e/ou escola em caso de incêndio. (Obs: deve-se analisar alternativas para prevenir o pânico).
5. O que você e seus pais devem fazer para prevenir o sequestro de crianças em sua família? O que você deveria fazer se fosse sequestrado?'),
('CS-010', 'Nutrição - avançado', 'ciencia-e-saude', 'especialidade', 3, 1986, 'Associação Geral', '/esp/cs-010.webp', 'https://mda.wiki.br/Especialidade_de_Nutrição_-_avançado', '1. Ter a especialidade Nutrição.
2. O que é dieta? Explicar os seguintes tipos e em quais casos são indicados:
  a) Hipossódica
  b) Hipocalórica
  c) Diabética
  d) Cetogênica
  e) Restrição de gorduras
  f) Rica em fibras
  g) Livre de glúten
3. Qual vitamina não faz parte da dieta vegetariana estrita? Quais as principais funções desta vitamina? O que um vegetariano estrito deve fazer para obter esta vitamina?
4. Qual é a diferença entre gorduras saturadas, gorduras insaturadas e gorduras trans? Qual delas é mais saudável e por quê?
5. Qual a diferença entre os colesteróis HDL e LDL? Quais alimentos são ricos em cada um deles?
6. Definir ômega 3 e ômega 6 e explicar seus benefícios para a saúde.
7. Fazer um quadro listando as frutas, verduras e legumes comuns em sua região e em quais meses do ano ocorre sua safra. Qual a importância de se dar preferência aos vegetais da estação?
8. O que são nutrição enteral e nutrição parenteral? Quais os casos em que elas são indicadas?
9. Realizar o seguinte:
  a) Manter um diário alimentar baseado em sua própria alimentação durante 1 semana.
  b) Qual a porção diária recomendada dos seguintes nutrientes para o sua idade e sexo?
    • Calorias
    • Carboidratos
    • Proteínas
    • Gorduras
    • Sódio
    • Fibra alimentar
    • Ferro
    • Cálcio
  c) Com base no diário feito no item ?a?, comparar a quantidade diária recomendada dos nutrientes acima com a quantidade que você ingere. O que precisa/deve ser mudado em sua dieta?
10. Ler Levítico 11 e explicar por que Deus classificou os animais entre puros e imundos.
11. As seguintes doenças são causadas por que tipo de deficiência nutricional?
  a) Raquitismo
  b) Anemia hemolítica
  c) Anemia megaloblástica
  d) Anemia ferropriva
  e) Bócio
  f) Escorbuto
  g) Marasmo
  h) Kwashiorkor
12. Quais prejuízos à saúde os seguintes hábitos alimentares podem causam?
  a) Uso excessivo do sal
  b) Uso excessivo do açúcar
  c) Dieta rica em gorduras
  d) Uso excessivo de condimentos
  e) Uso de alimentos processados
  f) Alimentos estimulantes, como: chá preto/mate/verde, café, xarope de guaraná/guaraná em pó
  g) Refrigerantes e sucos artificiais
  h) Comer no intervalo das refeições
  i) Comer em grandes quantidades
  j) Dietas restritivas (por exemplo low carb)
13. Estudar 3 das seguintes doenças e, sobre cada uma, explicar: como ocorre, sinais e sintomas, como preveni-las (quando for o caso) e quais as alterações necessárias na dieta de uma pessoa que as possui:
  a) Diabetes
  b) Hipertensão arterial sistêmica (pressão alta)
  c) Osteoporose
  d) Doença celíaca
  e) Intolerância à lactose
1. O que são suplementos alimentares? Com a ajuda de um profissional, indicar os mais comuns e explicar em quais casos são realmente necessários. Mencionar quais os riscos de se utilizar cada um deles sem a devida orientação de um nutricionista ou médico.'),
('CS-011', 'Reanimação Cardiopulmonar', 'ciencia-e-saude', 'especialidade', 2, 1986, 'Associação Geral', '/esp/cs-011.webp', 'https://mda.wiki.br/Especialidade_de_Reanimação_Cardiopulmonar', '1. Através de desenhos ou modelo, identificar o coração e os pulmões e descrever a função de cada um. Saber onde se localizam em seu corpo.
2. Definir reanimação cardiopulmonar e mencionar quando deve ser utilizada.
3. Completar um curso ministrado por um instrutor qualificado para aprender corretamente, e demonstrar, o processo de reanimação cardiopulmonar. Isso deve ser feito no máximo um ano antes desta especialidade.
4. Saber como manter o coração saudável. Relacionar cinco coisas que uma pessoa pode fazer para manter um coração saudável.
5. Aprender o significado das cores e desenho utilizados na insígnia desta especialidade, de acordo com o seguinte:
  a) A pessoa que precisa de reanimação cardiopulmonar pode estar pálida (branca), o que significa que não há circulação.
  b) A pessoa que está fazendo a reanimação cardiopulmonar está vermelha, o que significa que está bem ativa.
  c) A borda dourada representa o valor da vida humana.
  d) Um coração é formado pela cabeça, ombros e braços da pessoa que está fazendo a reanimação cardiopulmonar, o que significa compaixão pelo próximo.'),
('CS-012', 'Resgate Básico', 'ciencia-e-saude', 'especialidade', 1, 1986, 'Associação Geral', '/esp/cs-012.webp', 'https://mda.wiki.br/Especialidade_de_Resgate_Básico', '1. O que é resgate de emergência?
2. Demonstrar como resgatar, com segurança, uma pessoa em 3 das seguintes situações:
  a) Em contato com cabo elétrico
  b) Em ambiente cheio de fumaça ou gás
  c) Com as roupas em chamas
  d) Afogando-se, sem qualquer equipamento de resgate
  e) Um acidente no gelo
3. Conhecer três maneiras de atrair e comunicar-se com um resgate aéreo.
4. Conhecer seis indicadores de necessidade de resgate imediato.
5. Conhecer o procedimento a se seguir antes de remover uma vítima de situação que apresenta risco de morte.
6. Conhecer as maneiras apropriadas de ajudar uma vítima, em perigo, nas seguintes situações:
  a) Puxar a vítima
  b) Içar/levantar a vítima
  c) Ajudar a vítima a caminhar
7. Conhecer a forma adequada de ajudar uma vítima, com ajuda de outros, em 3 das seguintes situações:
  a) Carregar uma pessoa sentada
  b) Carregar uma pessoa deitada
  c) Carregar com cobertor
  d) Transportar uma vitima em uma rede
  e) Carregar em três ou quatro pessoas
8. Fazer uma maca improvisada e carregar uma pessoa nela.
9. Cumprir os seguintes itens:
  a) Atar, pelo menos, 3 nós para juntar cordas
  b) Atar um nó para diminuir corda
  c) Atar um nó para usar ao redor de alguém num resgate
  d) Enrolar e jogar corretamente uma corda leve e uma pesada, de 15 metros cada.
10. Que passos devem ser dados antes de comunicar que alguém está desaparecido? Que informações serão necessárias ao informar à polícia o desaparecimento de alguém?'),
('CS-013', 'Física', 'ciencia-e-saude', 'especialidade', 2, 1989, 'Associação Geral', '/esp/cs-013.webp', 'https://mda.wiki.br/Especialidade_de_Física', '1. O que é física?
2. Qual o objetivo principal da física?
3. Quais são as principais áreas de estudo da física?
4. Explicar a diferença entre a física clássica e a física moderna.
5. Quais são as 3 leis de Newton?
6. Aprender como calcular a velocidade média. Calcular a velocidade média de cada desbravador em um percurso e classificá-los do mais rápido ao mais lento.
7. Demonstrar a experiência de Galileu - queda de um corpo - derrubando duas garrafas de plástico (uma cheia de água e a outra pela metade) ao mesmo tempo, de uma altura de 2 metros. Registrar os resultados e retirar uma aplicação espiritual da experiência.
8. Demonstrar a vantagem mecânica da alavanca, retirando um prego grande, pregado bem fundo numa madeira, usando apenas um martelo. Puxar um segundo prego usando um martelo e um pequeno bloco de madeira, localizado perto do prego, sob a cabeça do martelo. Anotar a diferença de força exigida para puxar o prego com as diferentes posições do martelo no bloco (fulcro) e tirar uma aplicação espiritual desta experiência.
9. O que é temperatura? Como ela está relacionada com energia térmica de um objeto?
10. Explicar o que é dilatação térmica e dar um exemplo prático de um objeto que sofre dilatação quando aquecido.
11. Qual é a principal diferença entre campo elétrico e campo magnético?
12. Qual é a diferença fundamental entre resistores e capacitores em um circuito elétrico?
13. O que é a Teoria da Relatividade de Albert Einstein e qual foi a sua contribuição para a física moderna?
14. O que é o efeito fotoelétrico e qual sua importância na física moderna?'),
('CS-014', 'Microscopia', 'ciencia-e-saude', 'especialidade', 3, 1994, 'Associação Geral', '/esp/cs-014.webp', 'https://mda.wiki.br/Especialidade_de_Microscopia', '1. Conhecer os microscópios abaixo, identificando-os pessoalmente ou através de figuras e fotos. Informar as principais características de cada um.
  a) Microscópio óptico
  b) Microscópio eletrônico de varredura
  c) Microscópio eletrônico de transmissão
  d) Microscópio de força atômica
2. Ser capaz de identificar as seguintes partes de um microscópio e explicar e demonstrar a função de cada uma: ocular, objetiva, revólver, platina, condensador, base, foco (parafuso micrométrico e parafuso macrométrico) e braço.
3. Saber como calcular a ampliação em um microscópio ótico composto. Calcular a ampliação do microscópio que você está usando para esta especialidade.
4. Definir os seguintes termos microscópicos:
  a) Lâmina
  b) Lamela
  c) Exame direto a fresco (ou exame direto ou exame fresco)
  d) Fixador
  e) Corantes
  f) Óleo de imersão
5. Coletar amostras de água (de lagoas, riachos, rios, lagos, poças), prepará-las corretamente e procurar micro-organismos usando um microscópio com, pelo menos, 100x de ampliação. Desenhar, ao menos, 2 desses organismos. No desenho, rotular as estruturas identificadas (incluindo a ampliação usada).
6. Citar, pelo menos, um exemplo de como a microscopia é importante para:
  a) A alimentação humana
  b) A saúde humana
  c) Os medicamentos
  d) Outros organismos
7. Citar um hábito de saúde que foi estabelecido após a invenção dos microscópios.'),
('CS-015', 'Digestão', 'ciencia-e-saude', 'especialidade', 2, 1999, 'Associação Geral', '/esp/cs-015.webp', 'https://mda.wiki.br/Especialidade_de_Digestão', '1. O que é digestão e onde ela inicia?
2. Onde é formada a saliva? Quais são as três principais funções dela?
3. Qual é o papel do dente na digestão?
4. Ser capaz de identificar, através de figuras, os seguintes órgãos que participam do processo digestivo, descrevendo cada um: Boca, esôfago, estômago, fígado, pâncreas, intestino delgado, intestino grosso e ânus.
5. Qual é a diferença entre bolo alimentar e quimo?
6. O que é a bile? Onde é formada? Qual é a sua função e onde é liberada?
7. O que são microvilosidades intestinais? Por que elas fazem o alimento ser absorvido com maior velocidade?
8. O que são fibras alimentares? Qual a importância delas para o processo digestivo? O que acontece se os alimentos permanecerem por mais tempo dentro do trato gastrointestinal?
9. Demonstrar a digestão do amido em açúcar, utilizando o teste do iodo.
10. Onde ocorre a digestão/absorção dos seguintes elementos: carboidratos, proteínas, lipídios, vitaminas, minerais e água?'),
('CS-016', 'Ossos, Músculos e Articulações', 'ciencia-e-saude', 'especialidade', 2, 1999, 'Associação Geral', '/esp/cs-016.webp', 'https://mda.wiki.br/Especialidade_de_Ossos_Músculos_e_Articulações', '1. Qual a diferença entre endoesqueleto e exoesqueleto? Qual desses tipos de esqueleto os humanos têm?
2. Citar, pelo menos, três funções do sistema muscoesquelético.
3. Definir:
  a) Esqueleto axial
  b) Esqueleto apendicular
4. Descrever a classificação dos ossos de acordo com o seu formato, ilustrando-os.
5. Quantos ossos um ser humano adulto tem?
6. Desenhar ou colar uma figura de esqueleto humano, identificando, no mínimo, 10 ossos, sem repeti-los.
7. Definir diáfise, metáfise e epífise, ilustrando-os.
8. O que é disco epifisário e qual a sua importância?
9. O que são articulações? Descrever os 3 tipos com as suas subdivisões, ilustrando todas.
10. Fazer um modelo de uma das 6 articulações sinoviais.
11. O que é fratura óssea? Como é feita a correção médica?
12. Ilustrar, com desenho ou gravuras, a coluna vertebral, dividindo-a em suas 5 regiões. Quantas vértebras formam cada região?
13. O que é osteoporose? Quais os locais mais comuns de fratura? Qual é a idade de risco? Quem é o público mais afetado? Qual o melhor exame para detectá-la? Citar alguns cuidados que ajudam a prevenir a osteoporose.
14. Quais são as principais funções dos músculos esqueléticos?
15. Identificar os seguintes músculos: trapézio, deltoide, peitoral maior, bíceps, quadríceps, tríceps, reto abdominal, serratil anterior, glúteo máximo, grande dorsal, gastrocnêmio e sóleo.
16. Descrever o mecanismo de contração muscular.'),
('CS-017', 'Sistema Nervoso', 'ciencia-e-saude', 'especialidade', 3, 1999, 'Associação Geral', '/esp/cs-017.webp', 'https://mda.wiki.br/Especialidade_de_Sistema_Nervoso', '1. Fazer um diagrama ou modelo do sistema nervoso humano central, incluindo as seguintes partes: cérebro, cerebelo, ponte, medula espinhal. Descrever a função básica de cada um.
2. O que é um neurônio? Desenhar um neurônio e identificar as suas partes. O que é sinapse?
3. Quais são as principais diferenças do sistema nervoso somático e sistema nervoso autônomo? Diferenciar Sistema Nervoso Autônomo Simpático e Sistema Nervoso Autônomo Parassimpático, descrevendo as principais atividades relacionadas a cada um deles.
4. Explicar como as drogas afetam a função dos neurônios, especialmente a sinapse. Fazer um compromisso de nunca usar drogas.
5. O que é reflexo? Fazer o teste do reflexo patelar em alguém. (Instruções: peça para alguém ficar sentado com os pés sem encostar no chão. Gentilmente dê uma pequena batida abaixo do joelho). Explicar porque esse reflexo ocorre (usar no seu relatório os seguintes termos: neurônio sensorial, neurônio motor, medula espinhal). Porque os médicos usam esse teste num exame físico?
6. O que são neurônios sensoriais? O que é adaptação? Demonstrar o que é adaptação fazendo o seguinte:
  a) Descansar o seu braço numa mesa e colocar uma tampa (ou algo muito leve) sobre ele. Notar o que você está sentindo naquele momento e um minuto depois, sem mover o braço de lugar.
  b) Colocar um dedo de uma mão numa tigela com água fria e outro dedo de outra mão numa com água morna. Depois de 30 segundos, colocar os dois dedos numa tigela com água em temperatura ambiente. O que você sentiu em cada dedo?
  c) Qual a lição espiritual que você pode tirar do conceito de adaptação?
7. Fazer uma das seguintes atividades:
  a) Observar um eletroencefalograma e explicar a sua função;
  b) Observar uma ressonância nuclear magnética ou uma tomografia computadorizada do encéfalo ou da coluna vertebral e explicar a sua função;
  c) Explicar como uma anestesia funciona.
8. Listar, pelo menos, cinco coisas que você pode fazer para proteger o seu cérebro de danos.
9. Escolher 2 dos seguintes, detalhando como ocorre, fatores de risco, sinais e sintomas e tratamento:
  a) Doença de Alzheimer
  b) Doença de Parkinson
  c) Esclerose múltipla
  d) Epilepsia
  e) Acidente vascular encefálico
  f) Enxaqueca
  g) Síndrome de Down
  h) Tetraplegia
  i) Paraplegia.'),
('CS-018', 'Sangue e Defesas do Corpo', 'ciencia-e-saude', 'especialidade', 3, 2000, 'Associação Geral', '/esp/cs-018.webp', 'https://mda.wiki.br/Especialidade_de_Sangue_e_Defesas_do_Corpo', '1. Nomear os 2 componentes do sangue. Qual a porcentagem de cada um?
2. Desenhar ou colar fotos dos seguintes tipos celulares do sangue, identificando todos: hemácia, plaqueta, neutrófilo, linfócito, eosinófilo, basófilo e monócito. Qual(ais) a(s) principal(ais) função(ões) de cada um?
3. Onde as células sanguíneas são produzidas? Onde são hemolisadas? Qual é o tempo médio que uma hemácia vive?
4. Fazer uma das seguintes opções:
  a) Observar algum profissional de saúde retirando o sangue de alguém e descreva quais são os cuidados necessários.
  b) Visitar um laboratório onde são feitos exames de sangue. Se informar sobre quais exames são realizados lá e quais os procedimentos necessários para pelo menos 3 deles.
  c) Visitar um banco de sangue. Perguntar como é feito o armazenamento do sangue, qual é o prazo de validade e quais os tipos com menor estoque.
5. Quais gases são transportados pelas hemácias?
6. Explicar o processo de coagulação do sangue. Qual é o primeiro socorro utilizado em caso de hemorragia externa?
7. O que é hemofilia?
8. O que é preciso para ser um doador de sangue? Quais são os cuidados e recomendações principais? Quem não pode doar sangue?
9. Fazer uma tabela mostrando a compatibilidade sanguínea entre todos os tipos sanguíneos.
10. Além das células estudadas no item 2, quais são as outras células envolvidas na defesa do nosso organismo? Ilustrar cada uma delas.
11. O que são anticorpos? Como eles atuam? São produzidos por quais células?
12. Citar 2 textos bíblicos em que o sangue está envolvido. Depois de estudar sobre o sangue, por que você acha que a Bíblia usa o sangue como símbolo do poder salvador de Deus?
13. Listar 10 hábitos de saúde que podem ajudar o seu corpo a se manter saudável e combater infecções.
14. Descrever como funcionam as vacinas e os soros.'),
('CS-019', 'Hereditariedade', 'ciencia-e-saude', 'especialidade', 3, 2004, 'Divisão Norte Americana', '/esp/cs-019.webp', 'https://mda.wiki.br/Especialidade_de_Hereditariedade', '1. O que é hereditariedade?
2. Desenhar uma célula animal e identifique as seguintes partes: membrana plasmática, citoplasma, núcleo, carioteca e ribossomos.
3. Explicar o seguinte:
  a) O que é um cromossomo e onde está localizado?
  b) O que é gene e onde ele é encontrado?
4. Explicar o seguinte:
  a) O que é alelo?
  b) Qual a diferença entre alelo dominante e alelo recessivo?
  c) Determinar que tipo de alelo se tem nos seguintes traços genéticos (fenótipos): bico de viúva,lóbulo da orelha solto, covinhas, língua enrolada, miopia, ser canhoto e furo no queixo.
  d) Usando o quadrado de Punnet, preveja a proporção dos seguintes cruzamentos: TT (alto) com tt (baixo); Tt (alto) com Tt (alto); Tt (alto) com tt (baixo).
5. Explicar o seguinte:
  a) O que é mitose? Qual a sua função?
  b) Desenhar uma sequência de células mostrando o processo de mitose, incluindo: prófase, metáfase, anáfase e telófase.
  c) Explicar como o DNA é copiado no cromossomo durante este processo.
6. Explicar o seguinte:
  a) O que é meiose? Qual a diferença entre mitose e meiose?
  b) Desenhar uma sequência de células mostrando o processo da meiose, incluindo: intérfase, prófase I, Metáfase I, Anáfase I, Telófase I, Prófase II, Metáfase II, Anáfase II e Telófase II.
  c) As células resultantes da meiose permanecem diplóides? Explicar.
7. Quais são os nucleotídeos envolvidos no processo de replicação do DNA? Descrever como ocorre a replicação de um DNA. Demonstrar seu conhecimento sobre esse assunto usando um diagrama ou modelo.
8. O que é mutação? Usando o diagrama ou modelo criado na questão anterior, ilustrar o efeito de uma mutação no código genético.
9. Descrever, pelo menos, 3 doenças genéticas e quais são as suas manifestações.
10. A genética é o único fator que contribui para as suas características (físicas, mentais, sociais e espirituais)? Que outros fatores influenciam a sua vida e a sua personalidade?
11. Encontrar três citações da Bíblia ou do Espírito de Profecia que se relacionem com a sua resposta da questão anterior.'),
('CS-020', 'Coração e Circulação', 'ciencia-e-saude', 'especialidade', 1, 2006, 'Divisão Norte Americana', '/esp/cs-020.webp', 'https://mda.wiki.br/Especialidade_de_Coração_e_Circulação', '1. Quais são as estruturas que formam o sistema circulatório? Ilustrar e descrever as principais funções de cada uma.
2. Descrever os tipos de vasos que compõem o sistema circulatório, ilustrando cada um deles.
3. Saber localizar os seguintes pontos de pulso: carotídeo, braquial e radial. Saber aferir a frequência de pulso de uma pessoa, usando um dos pontos acima.
4. Registrar seu pulso em repouso, em seguida fazer exercícios (correr, nadar, subir escadas, etc.) por 10 minutos. Aferir novamente o seu pulso imediatamente e 5 minutos após o exercício. O exercício afetou os batimentos do seu coração? Por que isso ocorre?
5. Usar um estetoscópio para auscultar os batimentos cardíacos de uma criança menor de cinco anos de idade e de adulto. Ambas as aferições devem durar exatos 60 segundos. Anotar os resultados e explicar o porquê da diferença na quantidade de batimentos cardíacos de uma criança em relação a um adulto.
6. Quais são as 4 câmaras do coração? Quais são as suas 4 principais valvas?
7. Qual é a diferença entre pequena circulação e grande circulação?
8. Qual o nome dos vasos que irrigam o próprio coração? Qual o nome da principal artéria do corpo?
9. Listar, pelo menos, 5 coisas que ajudam a manter o sistema cardiovascular saudável.
10. O que é colesterol e como ele está relacionado à aterosclerose? Como a aterosclerose afeta o sistema cardiovascular?
11. O que é um eletrocardiograma e para que serve?
12. Explicar o que é o aparelho marcapasso cardíaco e dizer qual a sua função.
13. O que é o sistema linfático? Quais as suas funções?
14. Descrever as principais estruturas do sistema linfático.'),
('CS-021', 'Bioquímica', 'ciencia-e-saude', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/cs-021.webp', 'https://mda.wiki.br/Especialidade_de_Bioquímica', '1. Definir os seguintes termos:
  a) Carboidrato
  b) Lipídio
  c) Ácido graxo
  d) Proteína
  e) Peptídeo
  f) Enzima
  g) Aminoácido
  h) Ácido Nucleico
  i) Hidrofífico e hidrofóbico
  j) Triglicerídeo
2. Qual a importância da água nos organismos? Quais as principais características físicas e químicas da molécula de água?
3. O que significa metabolismo?
4. Bioquimicamente, por que sentimos fome?
5. Explicar como ocorre a via da glicólise. Qual a sua importância para o metabolismo?
6. Quais células humanas são dependentes apenas dessa via para obter energia?
7. Qual molécula une a via da glicólise e o ciclo do ácido cítrico (Ciclos de Krebs)?
8. Qual a importância do ciclo do ácido cítrico (Ciclos de Krebs)?
9. Quais as funções dos lipídeos?
10. Por que os lipídeos são insolúveis em água?
11. Por que os lipídeos, e não a glicose, são utilizados para o armazenamento de energia?
12. O que é beta oxidação? Por que essa via recebe esse nome?
13. O que são aminoácidos essenciais e não essenciais?
14. O que são corpos cetônicos, onde são produzidos e quais as consequências do excesso de sua produção?
15. Que compostos são formados pela união dos aminoácidos? Quais as principais funções desses compostos?
16. Qual a importância dos ácidos nucleicos? Como é sua estrutura e quais são seus componentes?
17. A partir de uma imagem (desenho) de uma molécula de DNA, identificar seus 4 nucleotídeos e dizer como se dão as ligações entre eles.'),
('CS-022', 'Bioquímica - avançado', 'ciencia-e-saude', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/cs-022.webp', 'https://mda.wiki.br/Especialidade_de_Bioquímica_-_avançado', '1. Ter a especialidade de Bioquímica.
2. Definir os seguintes termos:
  a) Síntese
  b) Anabolismo
  c) Catabolismo
  d) Redução
  e) Oxidação
  f) Fotossíntese
  g) Hormônio
3. Além do fornecimento de energia, que outras funções os carboidratos tem?
4. Como é feita a classificação dos carboidratos?
5. Quais as consequências da falta de glicose no organismo?
6. Para manter as taxas de glicose constantes, no período de jejum, o organismo é capaz de produzir esse carboidrato. Como ocorre a via da gliconeogênese ou neoglicogênese?
7. Qual a importância dos hormônios insulina e glucagon no organismo humano? Onde são produzidos?
8. Como é o metabolismo de um indivíduo em jejum?
9. Como é o metabolismo de um indivíduo bem alimentado?
10. Que doença decorre da falta de produção de insulina pelos seres humanos? Quais as principais características dessa doença?
11. O excesso de carboidratos e aminoácidos é estocado no organismo através de sua conversão em lipídeo. Como são sintetizados lipídeos no organismo? Onde os lipídeos são armazenados?
12. Quais são os tipos de lipídeos existentes nos seres humanos?
13. Os aminoácidos são produzidos pelos seres vivos. Os chamados produtores são capazes de sintetizar os 20 aminoácidos essenciais, os mamíferos podem sintetizar apenas alguns. Quais são os precursores usados para a síntese desses aminoácidos? Como os mamíferos obtêm os aminoácidos que não são capazes de sintetizar?
14. Fazer uma tabela com as famílias biossintéticas dos aminoácidos de acordo com os precursores metabólicos.
15. O grupo amino é muito importante para a síntese de aminoácidos. Como esse grupamento amino é obtido? Explicar o ciclo do nitrogênio.
16. A fixação de nitrogênio é muito importante, ela é realizada por bactérias. Algumas bactérias vivem em simbiose com as leguminosas. Explicar como ocorre a simbiose entre bactérias e leguminosas. Associar as leguminosas e a fixação de nitrogênio com a rotação de cultura.
17. Como ocorre a fotossíntese e qual sua importância para a vida na terra?
18. Que fatores afetam a fotossíntese?
19. Quais os organismos capazes de realizar fotossíntese?
20. O carbono é um átomo muito importante para todas as formas de vida. Explicar o ciclo do carbono.
21. Qual a relação entre DNA, RNA e proteínas?
22. Quais as aplicações do estudo do DNA?'),
('CS-023', 'Higiene Oral', 'ciencia-e-saude', 'especialidade', 1, null, null, '/esp/cs-023.webp', 'https://mda.wiki.br/Especialidade_de_Higiene_Oral', '1. Definir higiene oral.
2. Por quantas dentições um ser humano passa?
3. Para que servem os dentes de leite?
4. Quais são os tipos de dentes? Descrever as funções de cada tipo.
5. A partir de que idade deve-se iniciar a higiene oral? Como? Por quê?
6. Que prejuízos a má escovação ou a falta de escovação podem trazer?
7. Quais os meios de utilização do flúor? Em que formas ele é encontrado?
8. O que é evidenciador?
9. O que deve ser usado para fazer uma higiene oral completa?
10. Demonstrar ao seu instrutor a forma correta de:
  a) Fazer a escovação
  b) Usar fio dental
11. Por que devemos usar dentifrício fluoretado?
12. Como se contrai a cárie?'),
('CS-024', 'Higiene Oral - avançado', 'ciencia-e-saude', 'especialidade', 2, null, null, '/esp/cs-024.webp', 'https://mda.wiki.br/Especialidade_de_Higiene_Oral_-_avançado', '1. Ter a especialidade de Higiene oral.
2. Saber identificar as seguintes partes do dente, descrevendo a função de cada uma: esmalte, dentina, polpa, gengiva, cemento e ligamento periodontal.
3. Descrever os seguintes problemas bucais:
  a) Placa
  b) Tártaro
  c) Gengivite
  d) Periodontite
4. O que é pasta profilática?
5. Descrever como realizar a fluoretação, explicando cada um dos passos a serem seguidos.
6. O que fazer quando há um trauma em um dente por ocasião de uma queda?
7. O que causa sensibilidade nos dentes? Como este problema pode ser resolvido?
8. Quais os cuidados adicionais na higiene bucal uma pessoa que usa aparelho ortodôntico deve ter?
9. Quais os cuidados adicionais na higiene bucal uma pessoa que usa prótese dentária deve ter?
10. Criar uma História que ilustre as formas de prevenir a cárie dentária e apresentá-la, de forma criativa, a um grupo de crianças.'),
('CS-025', 'Metodologia de Estudo', 'ciencia-e-saude', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/cs-025.webp', 'https://mda.wiki.br/Especialidade_de_Metodologia_de_Estudo', '1. Descrever como os seguintes itens contribuem para o estudo:
  a) Escolha do lugar e ambiente ideal
  b) Dicionário
  c) Domínio do tempo de estudo
  d) Pesquisa bibliográfica como complemento do estudo
  e) Técnicas de assimilação e memorização
  f) Uso da internet
2. Fazer uma ficha com seu cronograma diário, incluindo nela o tempo de estudo. Segui-la durante duas semanas.(Preencher a ficha com o tempo a ser gasto nas seguintes atividades):
  a) Sono
  b) Escola
  c) Transporte
  d) Alimentação
  e) Estudo
  f) Lazer, atividades sociais e esportes
  g) Outros
3. Descrever maneiras que ajudam o estudante a se concentrar durante os estudos:
  a) Em casa
  b) Na biblioteca
  c) Na escola
4. Demonstrar qual a melhor postura para se estudar e listar quais posições o estudante deve evitar ao estudar.
5. Apresentar 5 dicas para o estudante que quer tirar a nota máxima em avaliações e trabalhos.
6. Que atividades ajudam o estudante a melhorar sua capacidade de aprendizado?
7. Escrever uma redação de 25 a 30 linhas com um dos seguintes temas:
  a) Onde vou estar e o que farei daqui 5 anos?
  b) Qual carreira gostaria de seguir? Por quê?
  c) Como farei para seguir a profissão que escolhi?
  d) O que ainda quero aprender e como posso alcançar esse objetivo?
8. Saber a diferença entre resumo e resenha, apresentando ambas em forma de esboço.
9. Ler algum livro de sua escolha que trate sobre técnicas e metodologias de estudo e apresentar um esboço de, no mínimo, 30 linhas.'),
('CS-026', 'Prevenção de Doenças Tropicais', 'ciencia-e-saude', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/cs-026.webp', 'https://mda.wiki.br/Especialidade_de_Prevenção_de_Doenças_Tropicais', '1. O que são doenças tropicais?
2. Listar, pelo menos, 5 doenças tropicais comuns em sua região.
3. Pesquisar e explicar as seguintes doenças, informando: transmissão, sinais e sintomas, tratamento, como preveni-las e combatê-las:
  a) Malária
  b) Febre amarela
  c) Leishmaniose
  d) Dengue
  e) Doença de Chagas
4. Explicar como eliminar os seguintes depósitos, evitando proliferação dos mosquitos:
  a) Pneus
  b) Garrafas
  c) Vasilhas de animais
  d) Caixa d''água
  e) Bromélias ou plantas que acumulam água
  f) Pratinho de vasos de planta
  g) Tonel ou dorna
  h) Calhas
  i) Tampinhas, latas e pequenas vasilhas descartáveis
  j) Bandeja externa de geladeira
5. Completar duas das seguintes atividades:
  a) Participar, junto com o Clube, unidade ou escola, de uma campanha contra a dengue (ou outra doença tropical) em seu comunidade.
  b) Fazer uma coleta de recipientes que possam acumular água parada em praças e ruas da sua comunidade e eliminá-los corretamente.
  c) Adquirir ou confeccionar folhetos com informações sobre as principais doenças tropicais e distribuir em seu bairro ou escola.
  d) Eliminar corretamente o lixo de sua casa por uma semana.
  e) Ajudar uma pessoa de seu bairro a manter sua residência livre de depósitos que acumulem água, realizando as seguintes tarefas:
    • Orientar como manter a residência livre de possíveis focos de mosquitos.
    • Informar sobre cuidados e sintomas das doenças pesquisadas
    • Fazer limpeza da residência, coletar e eliminar depósitos inservíveis.
6. Com a ajuda de seu instrutor ou conselheiro, fazer uma apresentação, debate ou encenação para seu Clube ou unidade sobre as doenças tropicais estudadas nesta especialidade.'),
('CS-027', 'Patrimônio Histórico', 'ciencia-e-saude', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/cs-027.webp', 'https://mda.wiki.br/Especialidade_de_Patrimônio_Histórico', '1. Definir o conceito de patrimônio histórico.
2. Citar a diferença entre história e memória.
3. Qual a importância do patrimônio histórico para:
  a) A identidade dos povos?
  b) A preservação da memória?
  c) A constituição humana?
4. Explicar como se forma um patrimônio histórico e quais são os benefícios de sua criação.
5. Como a história pode influenciar as decisões de uma sociedade?
6. Definir as categorias abaixo:
  a) Patrimônio histórico material
  b) Patrimônio histórico imaterial
7. Qual o papel humano como agente ativo na construção da história?
8. Investigar 3 elementos de uma cultura imaterial em sua comunidade.
9. Entrevistar uma pessoa com mais idade sobre suas memórias em relação à sua comunidade.
10. Fazer um levantamento dos monumentos que existem na região que você mora. Descobrir a razão de eles estarem lá e qual a história que os monumentos pretendem preservar.
11. Monte uma coleção de 10 elementos que tenham valor necessário para se tornarem históricos para você.'),
('CS-028', 'Saúde Mental', 'ciencia-e-saude', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/cs-028.webp', 'https://mda.wiki.br/Especialidade_de_Saúde_Mental', '1. O que são transtornos mentais?
2. Definir os seguintes termos:
  a) Cognitivo
  b) Terapia
  c) Fator de proteção
  d) Fator de risco
  e) Psicologia
  f) Psiquiatria
3. O que é saúde mental e qual a sua importância? Citar algumas práticas que colaboram com a saúde mental.
4. O que é ansiedade? O que você pode fazer para ajudar alguém que sofre desse transtorno?
5. O que é depressão? O que você pode fazer para ajudar alguém que sofre desse transtorno?
6. Que versos bíblicos ou citações do Espírito de Profecia você pode utilizar para ajudar uma pessoa com ansiedade ou depressão?
7. Escolher um transtorno mental e preparar uma apresentação com recurso audiovisuais para apresentá-lo em sua igreja, escola, clube ou comunidade. Incluir as seguintes informações:
  a) Características diagnosticas
  b) Desenvolvimento e curso
  c) Fatores de risco
  d) Tratamento
  e) Prognóstico
8. O que são psicofármacos e quando são indicados?
9. Que relação existe entre o 4° mandamento da Lei do Desbravador e a saúde mental? Fazer um voto prometendo cuidar e manter sua mente livre das influências perturbadoras dos dias atuais.'),
('CS-029', 'Sexualidade Humana', 'ciencia-e-saude', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/cs-029.webp', 'https://mda.wiki.br/Especialidade_de_Sexualidade_Humana', '1. O que é sexualidade humana?
2. Qual é o modelo divino para a sexualidade?
3. O que é sexo biológico? Quantos tipos existem?
4. Através de desenhos ou figuras escolhidas previamente e trazidas pelo seu instrutor, representar os órgãos sexuais masculinos e femininos e responder:
  a) Quais são os órgãos sexuais/reprodutivos internos?
  b) Quais são os órgãos sexuais/reprodutivos externos?
  c) Qual é a função de cada um desses órgãos?
  d) Por que é tão importante chamar esses órgãos pelos nomes corretos?
5. O que é puberdade? Quando ela se inicia nos homens e nas mulheres? Quais as mudanças físicas e psicológicas que ocorrem?
6. O que é menstruação e polução noturna? Em que idade se iniciam e quando terminam?
7. Por que a higiene genital, tanto masculina quanto feminina, é importante?
8. O que é gravidez, como ela ocorre e quanto tempo dura?
9. O que é a aborto? Quais são as consequências físicas e psicológicas envolvidas? Em quais casos o aborto é aconselhável e permitido em seu país?
10. Como reconhecer e se proteger de possíveis abusos sexuais e seus perigos? A quem devemos recorrer em caso de alguém (desconhecido, amigo ou familiar) ter sido abusado? Por que é importante não ficar calado?
11. O que são Infecções Sexualmente Transmissíveis (ISTs)? Responder o seguinte:
  a) O que é HIV?
  b) O que é AIDS?
  c) Como se contrai o HIV?
  d) Quanto tempo leva do contágio até o início dos sintomas?
  e) Que testes ou exames médicos podem ser feitos para saber se uma pessoa está infectada?
  f) Quais cuidados uma pessoa soro positiva necessita? Quais e quantos medicamentos toma por dia?
  g) Pesquisar outras 5 Infecções Sexualmente transmissíveis e responder sobre cada uma delas: forma(s) de contágio(s), sintomas, agente etiológico e se há tratamento.
12. Quando temos uma dúvida sobre sexualidade, a quem devemos procurar ajuda? Por que amigos da minha idade são "pouco confiáveis" para o assunto?
13. O que é paixão e o que é namoro? Quando são saudáveis? Quando estão distorcidos e são prejudiciais? Como saber o momento correto para se terminar um namoro? Como terminar uma relação adequadamente?'),
('CS-030', 'Sistema Respiratório', 'ciencia-e-saude', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/cs-030.webp', 'https://mda.wiki.br/Especialidade_de_Sistema_Respiratório', '1. Quais são as estruturas que formam o sistema respiratório? Ilustrar e descrever as principais funções de cada uma.
2. Quais são os 2 principais gases do nosso organismo? O que é troca gasosa? Descrever as vias condutoras do ar até o momento da troca gasosa.
3. O que é alvéolo e qual a sua função? Através de desenhos ou figuras, ilustrar um alvéolo demonstrando o momento da troca gasosa.
4. Qual a principal função das células ciliadas, com cílios móveis?
5. Qual a relação entre respiração celular e a respiração pulmonar?
6. Explicar como os sistemas circulatório e respiratório estão intimamente ligados.
7. Qual a importância da hemoglobina e do ferro para a oxigenação do organismo?
8. Descrever os movimentos de inspiração e expiração. Qual a importância do músculo diafragma para estes movimentos?
9. Qual órgão do sistema nervoso central controla a respiração? Por quê?
10. Qual é a frequência respiratória normal dos seguintes:
  a) Recém-nascidos
  b) Crianças
  c) Adultos
11. Definir os seguintes termos:
  a) Eupneia
  b) Taquipneia
  c) Bradipneia
  d) Dispneia
  e) Apneia
12. Estudar duas das seguintes doenças respiratórias e dizer, sobre cada uma, como ocorre, como é adquirida, transmissão (se for o caso), tratamento e prevenção:
  a) Asma
  b) Tuberculose pulmonar
  c) Pneumonia
  d) Gripe
  e) Bronquiolite viral aguda
  f) Enfisema pulmonar
  g) Tromboembolismo pulmonar
  h) Fibrose cística
  i) Covid-19
13. Pesquisar os efeitos do cigarro no sistema respiratório. Apresentar seus resultados de uma das seguintes maneiras:
  a) Relatório escrito, com no mínimo 250 palavras
  b) Apresentação oral, de no mínimo 5 minutos
  c) Exposição de cartazes e faixas
  d) Poema ou música'),
('CS-031', 'Habilidades em Matemática I', 'ciencia-e-saude', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/cs-031.webp', 'https://mda.wiki.br/Especialidade_de_Habilidades_em_Matemática_I', '1. O que é o sistema decimal e por que ele é importante na matemática?
2. Identificar e classificar os algarismos do sistema decimal (0 a 9) e explicar a importância da posição de cada um.
3. Explicar e exemplificar o algoritmo para as quatro operações básicas: adição, subtração, multiplicação e divisão.
4. Elaborar quatro situações práticos onde você usaria as quatro operações básicas para resolver problemas do dia a dia.
5. Pesquisar e apresentar a origem histórica dos símbolos matemáticos para raiz quadrada, divisão, adição e subtração em forma de desenhos ou escrita.
6. Demonstrar, por meio de exemplos práticos, a resolução de três problemas de potenciação e três exemplos de expressões numéricas utilizando parênteses, colchetes e chaves.
7. Apresentar e resolver três situações práticas envolvendo frações nas operações de adição, subtração, multiplicação e divisão, utilizando o cálculo do mínimo múltiplo comum (MMC) para adição e subtração.
8. Apresentar e demonstrar a resolução de três problemas que envolvem cálculos de porcentagem, como descontos em compras e vendas de produtos.
9. Apresentar e demonstrar a resolução de 4 exemplos de operações com números decimais, incluindo adição, subtração, multiplicação e divisão, utilizando métodos práticos de resolução.'),
('CS-032', 'Habilidades em Matemática II', 'ciencia-e-saude', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/cs-032.webp', 'https://mda.wiki.br/Especialidade_de_Habilidades_em_Matemática_II', '1. Ter a especialidade de Habilidades em matemática I.
2. Quais são as características de um polígono regular? Citar exemplos.
3. Fazer o desenho dos seguintes polígonos regulares: quadrado, retângulo, pentágono, hexágono, heptágono e octógono.
4. Qual é a diferença entre os triângulos equilátero, isósceles e escaleno?
5. Qual é a diferença entre perímetro e área?
6. Calcular o perímetro e a área de 4 polígonos do requisito 2.
7. O que são sólidos geométricos? Citar exemplos.
8. Pegar um copo cilíndrico, fazer as medições do raio e de altura e calcular o seu volume em ml.
9. O que é o Sistema Internacional de Unidade (SI)?
10. Qual é a principal diferença na medição entre polígonos regulares e sólidos geométricos?
11. Sobre a arca de Noé na Bíblia diz:'),
('CS-033', 'Habilidades em Matemática III', 'ciencia-e-saude', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/cs-033.webp', 'https://mda.wiki.br/Especialidade_de_Habilidades_em_Matemática_III', '1. Ter a especialidade Habilidades em matemática II.
2. 2. Resolver as seguintes operações usando o algoritmo tradicional:
  a) 641 + 135
  b) 845 - 124
  c) 34 x 125
  d) 856 : 24
3. Identificar e classificar os conjuntos numéricos.
4. Demonstrar habilidade de resolver as seguintes equações:
  a) 2x - 10 = - 4x + 14
  b) 18x - 43 = 65
  c) 23x - 16 = 14 - 17x
  d) 10y - 5 (1 + y) = 3 (2y - 2) - 20
  e) x(x + 4) + x(x + 2) = 2x² + 12
  f) (x - 5)/10 + (1 - 2x)/5 = (3-x)/4
  g) 4x (x + 6) - x² = 5x²
5. Demonstrar habilidade de resolver os seguintes produtos notáveis:
  a) (x + 3y)
  b) (a5 + 2bc)2
  c) (3x + y2)2
  d) (1 + 5m) (1 - 5m)
  e) (ab - c)2
  f) (m - 1)3
  g) (a3 - b3) (a3 + b3)
6. Calcular a área das seguintes figuras planas:
7. Na especialidade de orientação, o desbravador precisa ter conhecimentos de ângulo, para saber usar carta cartográfica e usar uma bússola: Demonstrar habilidade de converter ângulos para minutos, minutos para segundos, mostrando três exemplos práticos.
8. Na especialidade de pioneiria aprendemos a construir móveis de campanha, que por sua vez tem toda uma relação matemática. Desenhar e apresentar alguns móveis de campanha onde aparecem formas geométricas e classificar cada um. Citar três exemplos.
9. Apresentar um cartaz mostrando dez exemplos práticos de figuras geométricas usadas no dia a dia. Pode ser em forma de figuras recortadas, fotos ou desenho.
10. Demonstre habilidade para resolver a solução dos seguintes problemas de proporção:
  a) A 60 km/h faço o percurso entre duas cidades em duas horas. Trafegando a 80 km/h qual o tempo estimado para percorrer este trajeto?
  b) À média de 90 km/h faço um trajeto em três horas. Para que eu faça este percurso em apenas duas horas, qual deve ser a minha velocidade média?
  c) Se 20 homens trabalhando durante 15 dias constroem 500 metros de um muro, quantos homens serão necessários para construir mais 1000 metros deste muro em 30 dias?
11. Demonstre habilidade para resolver situações problemas envolvendo equações:
  a) Tenho a seguinte escolha: Ou compro 20 unidades de um produto com todo o dinheiro que tenho, ou compro apenas 14 unidades e ainda me sobra um troco de R$ 30,00. Qual o valor unitário deste produto?
  b) Qual é a raiz da equação 7x - 2 = -4x + 5?
  c) Se eu adicionar 8 à quantidade de carrinhos que possuo, ficarei com a mesma quantidade de carrinhos de meu irmão, se dos 28 que ele possui, for retirada a quantidade que eu possuo. Quantos carrinhos eu tenho?'),
('CS-034', 'Habilidades em Matemática IV', 'ciencia-e-saude', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/cs-034.webp', 'https://mda.wiki.br/Especialidade_de_Habilidades_em_Matemática_IV', '1. Ter a especialidade Habilidades em matemática III.
2. Apresentar um relatório bibliográfico com pelo menos cinco personalidades que contribuíram para o desenvolvimento da matemática no decorrer da historia da humanidade.
3. Desenvolver e apresentar os cálculos das seguintes equações:
  a) 5x² - 3x - 2 = 0
  b) 3x² + 55 = 0
  c) x² - 10x + 25 = 0
4. Apresentar e desenvolver os cálculos de porcentagem dos seguintes problemas:
  a) 3% de 450
  b) 25% de 1440
  c) 30% de 2500
5. Apresentar três situações práticas de forma escrita de situações onde usamos a porcentagem no nosso dia a dia.
6. Apresentar e desenvolver três situações pratica de problemas do dia a dia em que usamos a equação do segundo grau.
7. Resolver e apresentar o desenvolvimento das seguintes funções:Sendo f(x) = x - 3 e g(x) = -3x + 4, determinar:
  a) f(f(0))
  b) f(f(1)) + g(f(3))
8. Representar no gráfico cartesiano as seguintes funções:
  a) y = 3x - 1
  b) f(x) = 2x + 3
9. Demonstrar a habilidade em resolver problemas envolvendo círculos, como calcular a circunferência e a área usando a fórmula de cada um. Apresentar dois exemplos de cada.
10. Apresentar a habilidade de calcular a área de polígonos regulares, como hexagonal inscrito em um círculo, área da superfície do cilindro, volume do prisma e o volume da pirâmide.
11. Em nosso dia a dia, lidamos o tempo todo com taxa de juros. Demonstre a habilidade para resolver as duas situações mais comuns de juros.
  a) Luciana fez uma aplicação de R$ 200,00 a juros simples de 2% ao mês. Quanto ele terá, no total, após 8 meses de aplicação?
  b) Davi fez um empréstimo bancário de R$ 3.000,00 e pagará em 6 meses com taxa de juro composto de 1,5% ao mês. Calcule o total que ele deverá pagar ao banco após esses 6 meses.'),
('CS-035', 'Biossegurança', 'ciencia-e-saude', 'especialidade', 1, 2020, 'Divisão Sul Americana', '/esp/cs-035.webp', 'https://mda.wiki.br/Especialidade_de_Biossegurança', '1. Definir os seguintes termos:
  a) Aerossóis
  b) Agente de risco
  c) Biossegurança
  d) Material biológico
  e) Acidente químico ou biológico
  f) Incidente químico ou biológico
  g) Patogênico
2. O que são EPIs (Equipamentos de Proteção Individual)? Para que eles servem? Quais são os EPIs que os profissionais da saúde costumam usar?
3. Diferenciar surto, epidemia, pandemia e endemia.
4. Em meio a uma epidemia/pandemia, quais os principais cuidados que devem ser tomados?
5. Qual a diferença de isolamento e quarentena?
6. Escolher duas doenças da lista abaixo e responder: quando aconteceu? quantos foram infectados? qual era a maneira de contágio? quais eram os sintomas? encontraram cura? quais foram os cuidados de biossegurança?
  a) Peste negra
  b) Varíola
  c) Gripe espanhola
  d) Tifo
  e) Gripe suína
7. Escolher uma das doenças abaixo e responder: Quais são os sintomas? Como é a forma de contágio? Existe cura atualmente? Onde e quando já houve surto/epidemia/pandemia? Existe prevenção dessa doença?
  a) Cólera
  b) Tuberculose
  c) Febre amarela
  d) Sarampo
  e) Malária
  f) AIDS
  g) Covid-19
8. Como as vacinas funcionam? Qual a importância de estar com as vacinas em dia?
9. Sobre a lavagem das mãos:
  a) Apresentar ao seu instrutor, pessoalmente, por vídeo ou por imagens, como deve ser feita a lavagem correta das mãos. Explicar por que é importante seguir cada passo.
  b) Por qual motivo não é recomendável usar toalhas que serão usadas várias vezes por várias pessoas e sim toalhas de papel?
10. Por que o adequado é usar álcool 70% e não outros tipos de álcool? Qual a forma correta de utilizá-lo?
11. Que atitudes devem ser tomadas ao tossir e espirrar para evitar contaminar outras pessoas?
12. De acordo com Mateus 24 e Apocalipse 6, o que a Bíblia fala sobre as doenças no fim dos tempos?
13. De acordo com I Coríntios 15 e Apocalipse 21 e 22, o que acontecerá com os doentes e com as doenças quando formos ao céu?'),
('CS-036', 'Anatomia Humana Básica', 'ciencia-e-saude', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/cs-036.webp', 'https://mda.wiki.br/Especialidade_de_Anatomia_Humana_Básica', '1. O que é anatomia humana?
2. Como se iniciou o estudo da anatomia humana? Quais são as técnicas usadas atualmente para o estudo de anatomia?
3. O que é, como é e qual é a importância da posição anatômica? Ilustrar.
4. Quais os componentes básicos e as principais funções de cada um dos sistemas abaixo? Apresentar imagens que ilustrem cada um deles.
  a) Sistema circulatório;
  b) Sistema respiratório;
  c) Sistema digestório;
  d) Sistema esquelético.
5. O que são variações anatômicas?
6. Fazer um glossário com os seguintes termos anatômicos:
  a) Superficial e profundo;
  b) Medial e lateral;
  c) Posterior e anterior;
  d) Caudal e cranial;
  e) Distal e proximal;
  f) Médio;
  g) Dorso;
  h) Abdome;
  i) Flexão e extensão;
  j) Abdução e adução;
  k) Oposição;
  l) Rotação;
  m) Circundução;
7. O que a Bíblia fala sobre o cuidado com o corpo? I Coríntios 6:19-20.'),
('CS-037', 'Cientistas Cristãos', 'ciencia-e-saude', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/cs-037.webp', 'https://mda.wiki.br/Especialidade_de_Cientistas_Cristãos', '1. Por que a verdadeira ciência não se opõe à Bíblia?
2. Explicar sobre a relação dos cientistas abaixo com sua fé em Deus.
  a) Nicolau Copérnico;
  b) Johannes Kepler;
  c) Galileu Galilei;
  d) Isaac Newton;
  e) Robert Boyle;
  f) Michael Faraday;
  g) Gregor Mendel;
  h) Lord Kelvin (William Thompson);
  i) Max Planck;
  j) Albert Einstein;
  k) Louis Pasteur.
3. Citar uma frase referente a Deus de cada cientista apresentado abaixo:
  a) Arthur Eddington;
  b) Allan Sandage;
  c) Charles Townes;
  d) Werner Von Braun;
  e) Max Planck;
  f) Antoine Henri Becquerel;
  g) Andrews Millikan;
  h) Erwin Schrödinger;
  i) Edward Mitchell;
  j) Louis Pasteur;
  k) Isaac Newton;
  l) Albert Einstein.'),
('CS-038', 'Experimentos Científicos', 'ciencia-e-saude', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/cs-038.webp', 'https://mda.wiki.br/Especialidade_de_Experimentos_Científicos', '1. Para que servem os experimentos científicos?
2. Explicar a primeira lei de Newton utilizando um ovo de galinha não cozido.
3. Com uma muda de feijão, uma caixa e luz solar, explicar sobre a fotossíntese.
4. Explicar a oxidação de frutos utilizando uma banana. O que pode ser usado para impedir essa oxidação?
5. Usando um copo transparente, água, açúcar e óleo de cozinha, explicar sobre misturas homogêneas e heterogêneas.
6. Usando um pente de plástico, flanela de lã e papel picado, explicar sobre eletricidade estática.
7. Mostrar que o ar é constituído de matéria, utilizando uma seringa descartável.
8. Usando um barbante e duas laranjas, explicar sobre energia cinética.
9. Explicar sobre a alteração de pressão fazendo o experimento do submarino de garrafa, usando uma garrafa PET transparente, tampa de caneta, tubo de caneta, água e massa de modelar.
10. Explicar sobre óptica fazendo o experimento da câmara escura, usando uma lata ou caixa, prego e vela.
11. Com um copo de vidro transparente e um canudo, explicar sobre a refração.
12. Explicar sobre a força eletromagnética da Terra, usando uma agulha, ímã, cortiça, água e copo.
13. Descobrir na Bíblia uma história sobre alguém fazendo um experimento. O que foi a única coisa que fez esse experimento dar certo?'),
('CS-039', 'Plantas Medicinais', 'ciencia-e-saude', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/cs-039.webp', 'https://mda.wiki.br/Especialidade_de_Plantas_Medicinais', '1. O que são plantas medicinais?
2. Por que é importante identificar as plantas medicinais pelo seu nome científico e não pelo nome popular?
3. O que é tratamento fitoterápico?
4. Citar uma planta medicinal para cada parte a ser utilizada:
  a) Flor;
  b) Raiz;
  c) Caule;
  d) Folha;
  e) Fruto/semente.
5. Falar sobre os benefícios para a saúde de cada planta abaixo:
  a) Allium sativum;
  b) Matricaria recutita;
  c) Annona muricata;
  d) Anacardium occidentale;
  e) Melissa officinalis;
  f) Cinnamomum zeylanicum;
  g) Schinus terebinthifolius;
  h) Bauhinia forfiticata;
  i) Maytenus spp;
  j) Fragaria vesca;
  k) Phyllanthus spp;
  l) Punica granatum;
  m) Aloe vera.
6. Citar três formas de preparo caseiro de chá medicinal e preparar um chá utilizando uma dessas formas.
7. Qual rei na Bíblia teve a saúde restabelecida após ter usado uma pasta de figos?
8. Qual a função das folhas da árvore da vida (Apocalipse 22:2)?'),
('CS-040', 'Remédios da Natureza', 'ciencia-e-saude', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/cs-040.webp', 'https://mda.wiki.br/Especialidade_de_Remédios_da_Natureza', '1. Conhecer os oito remédios da natureza.
1. Desenhar e descrever a pirâmide alimentar. Mencionar o número de porções diárias recomendadas de cada grupo.
2. Qua importância de uma alimentação saudável para o nosso organismo? Quais os prejuízos de uma alimentação não balanceada?
1. Qual a importância da água para o nosso organismo? Quais cuidados devemos ter com a água que ingerimos e que usamos para higiene e limpeza?
2. Qual quantidade de água deve ser ingerida por dia?
1. Qual a importância de se respirar ar puro? Que fatores podem influenciar na qualidade do ar?
1. Quais os benefícios de uma exposição adequada à luz solar?
2. Quais cuidados devemos ter ao nos expormos à luz solar?
1. Qual a importância de se praticar exercícios físicos regularmente? Preparar um plano para uma semana, com 30 minutos de exercícios físicos por dia.
1. Quanto tempo devemos dormir por dia? Qual a importância de uma boa noite de sono? Quais os prejuízos de não dormir bem?
2. Que fatores podem influenciar na qualidade do sono?
1. O que é temperança e qual a sua importância para a saúde?
2. Fazer um voto de se abster de álcool, cigarro e outras drogas.
1. Qual a importância da confiança em Deus para a nossa saúde?
2. Preparar e colocar em prática um plano diário de comunhão com Deus, iniciando nas primeiras horas da manhã.'),
('CS-041', 'Trânsito Seguro', 'ciencia-e-saude', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/cs-041.webp', 'https://mda.wiki.br/Especialidade_de_Trânsito_Seguro', '1. Definir o que é direção defensiva.
2. Quais são os cinco fundamentos da direção defensiva?
3. O que deve ser verificado em um automóvel antes de colocá-lo em circulação?
4. Como se deve conduzir um veículo automotor prudentemente (automóvel e motocicleta)?
5. Qual a responsabilidade hierárquica no trânsito?
6. Explicar por onde e como o pedestre deve circular nas vias públicas e nas estradas.
7. Quais são os equipamentos obrigatórios para os condutores de motocicletas, motonetas ou ciclomotores?
8. Qual a idade mínima para se transportar passageiros em motocicletas e similares?
9. Qual a idade mínima para se transportar um passageiro no banco dianteiro de um automóvel?
10. Em relação às crianças, quais os dispositivos auxiliares de segurança para automóveis?
11. Por que é importante manter os pneus dos veículos automotores em bom estado de conservação?
12. Como ajudar uma vítima de acidente de trânsito?
13. Fazer um projeto com seu Clube de Desbravadores com o título "Trânsito Seguro", produzindo e distribuindo folhetos explicativos sobre o tema ou apresentando qualquer outro material de divulgação.'),
('CS-042', 'Vacinas', 'ciencia-e-saude', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/cs-042.webp', 'https://mda.wiki.br/Especialidade_de_Vacinas', '1. Explicar como as vacinas funcionam e qual o significado da palavra vacina.
2. Contar a história do surgimento da primeira vacina.
3. Explicar as características, vantagens e desvantagens das vacinas abaixo:
  a) Atenuada;
  b) Inativada;
  c) Vetor viral;
  d) Subunidades;
  e) RNA.
4. Qual a primeira doença erradicada no mundo em decorrência da vacinação?
5. Fazer uma tabela com as vacinas disponibilizadas pelo serviço público de saúde do seu país. Quais doenças elas previnem e quando elas devem ser aplicadas?
6. Explicar as etapas para o desenvolvimento de uma nova vacina.
7. Qual a importância de ter um número grande de pessoas vacinadas? O que é imunidade de rebanho ou imunidade coletiva?'),
('CS-043', 'Zoonoses', 'ciencia-e-saude', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/cs-043.webp', 'https://mda.wiki.br/Especialidade_de_Zoonoses', '1. O que são zoonoses?
2. O que é um Centro de Controle de Zoonoses? Quais suas atribuições?
3. Qual a diferença entre zoonoses e arboviroses? Dar exemplos de cada tipo.
4. Citar duas zoonoses que podem ser transmitidas por ratos e citar medidas preventivas.
5. A raiva pode ser transmitida por quais animais? O que deve ser feito ao ser mordido por um animal?
6. O que é toxoplasmose e quais os principais grupos de risco dessa zoonose? Como ela é transmitida?
7. Explicar como as seguintes zoonoses são transmitidas e como podemos evitá-las:
  a) Tuberculose;
  b) Brucelose;
  c) Leishmaniose;
  d) Criptococose.
8. Fazer um esquema mostrando o ciclo da teníase/cisticercose, demonstrando as formas de contaminação, os hospedeiros e formas de prevenção.
9. O que é febre maculosa e como é transmitida? Como ela pode ser evitada?
10. Quais cuidados precisamos ter com nossos animais de estimação para que tenham uma vida saudável e para evitar que fiquem doentes?'),
('EN-001', 'Aranhas', 'estudos-da-natureza', 'especialidade', 2, 1928, 'Associação Geral', '/esp/en-001.webp', 'https://mda.wiki.br/Especialidade_de_Aranhas', '1. Quais são as principais características das aranhas? Quais são as principais diferenças entre as aranhas e os insetos?
2. Qual a utilidade da teia para as aranhas? Qual a utilidade da teia de aranha para o ser humano?
3. Fazer um desenho de uma teia esférica.
4. Descrever outros tipos de teia existente além da esférica ou orbicular
5. Do que se alimentam as aranhas? Observar teias de aranhas e listar as presas encontradas.
6. Quais são os principais predadores das aranhas? Além de seus predadores, qual o principal inimigo das aranhas e por quê?
7. Qual é a maior aranha do mundo?
8. Fazer um dos seguintes:
  a) Coletar, identificar e preservar, pelo menos, 16 espécies de aranhas. Cada vidro deve conter uma etiqueta com o local e data de captura, nome do coletor e nome da aranha. (Ao cumprir este requisito, esteja certo de não estar infringindo nenhuma lei de seu país).
  b) Desenhar e identificar, pelo menos, 16 espécies de aranhas, com suas cores naturais e em tamanho real ou ampliado.
  c) Tirar fotografias coloridas e identificar, pelo menos 16 espécies de aranha conhecida em sua região ou País.
9. Escrever uma descrição de, pelo menos, 40 palavras sobre uma espécie de aranha conhecida em sua região ou País.
10. Quantas espécies de aranhas venenosas existem no mundo? E em sua região? O que fazer em caso de picada de aranha?
11. Como as aranhas podem ser benéficas ao homem? Como as aranhas podem ser prejudiciais ao homem?
12. Encontrar 2 referências bíblicas às aranhas e suas teias.'),
('EN-002', 'Astronomia', 'estudos-da-natureza', 'especialidade', 2, 1928, 'Associação Geral', '/esp/en-002.webp', 'https://mda.wiki.br/Especialidade_de_Astronomia', '1. O que é astronomia?
2. O que é um corpo celeste? Sobre o corpo celeste mais próximo da Terra, responder o seguinte:
  a) Qual o seu nome?
  b) Qual a sua distância da Terra?
  c) Qual a sua influência nas marés?
3. Responder as seguintes perguntas:
  a) O que causa um eclipse?
  b) O que é uma estrela cadente?
  c) Qual a velocidade da luz?
4. Fazer um diagrama do sistema solar, nomeando os planetas na ordem correta a partir do Sol.
5. Fazer um diagrama mostrando as posições da Terra, Sol e Lua nos eclipses lunares e solares.
6. O que é uma constelação? Identificar no céu e nomear pelo menos 5 constelações.
7. Ilustrar, com fotos, imagens ou desenho, as constelações Cruzeiro do Sul, Órion e Escorpião.
8. Responder as seguintes perguntas:
  a) O que é Via Láctea e como podemos observá-la no céu noturno?
  b) O que é a estrela da manhã ou estrela vespertina? Por que ela recebe esses nomes?
  c) que é aurora austral? O que causa esse fenômeno?
## Links de Ajuda
1. Eclipse - https://mundoeducacao.uol.com.br/geografia/eclipse.htm
2. O que são estrelas cadentes? - https://canaltech.com.br/espaco/o-que-sao-estrelas-cadentes-207083/
3. Velocidade da Luz - https://www.todoestudo.com.br/fisica/velocidade-da-luz
4. Qual é a distância da Terra à Lua? - https://canaltech.com.br/espaco/qual-e-a-distancia-da-terra-a-lua-222304/
5. Tudo sobre as marés - https://www.oceanoparaleigos.com/post/marés]]
6. Como funciona a influência da Lua nas marés - https://www.youtube.com/watch?v=sYss-N7EnEw]]
7. Comparação do eclipse solar e lunar - https://pt.dreamstime.com/ilustra%C3%A7%C3%A3o-stock-compara%C3%A7%C3%A3o-do-eclipse-solar-e-lunar-image92184195]]
8. Como diferenciar estrelas, planetas e satélites no céu noturno? - https://canaltech.com.br/espaco/como-diferenciar-estrelas-planetas-e-satelites-no-ceu-noturno-212862/
9. Constelações - https://brasilescola.uol.com.br/fisica/constelacoes.htm
10. Você perguntou: Quais são as 3 constelações que são facilmente visíveis nas noites de inverno - https://planetariodevitoria.org/espaco/voce-perguntou-quais-sao-as-3-constelacoes-que-sao-facilmente-visiveis-nas-noites-de-inverno.html
11. As Constelações - https://planetario.ufsc.br/as-constelacoes/
12. Esfera Celeste:Definições de planos e pontos importantes - http://www.if.ufrgs.br/~fatima/fis2016/aulas/aula2.htm]]
13. Via Láctea - https://brasilescola.uol.com.br/geografia/via-lactea.htm/'),
('EN-003', 'Aves', 'estudos-da-natureza', 'especialidade', 1, 1928, 'Associação Geral', '/esp/en-003.webp', 'https://mda.wiki.br/Especialidade_de_Aves', '1. Apresentar 4 características usadas para diferenciar as aves dos outros animais.
2. Citar 3 espécies de aves que não voam. Mencionar o que comem e dar o nome do país ou continente na qual cada uma delas vive.
3. Mencionar o dia da semana em que as aves foram criadas. Descobrir na Bíblia os nomes de 5 aves. Ser capaz de mencionar 3 histórias bíblicas onde, através das aves, Deus mostrou seu cuidado e amor por nós.
4. Fazer uma lista de 10 aves que foram observadas pessoalmente. Incluir imagens de cada uma.
5. Fazer uma lista de 5 espécies de aves que você identificou pelo som, ao ar livre.
6. Fazer umas das tarefas a seguir (apresentar fotos):
  a) Montar um posto de alimentação e relatar que aves vieram até ali durante uma semana;
  b) Descobrir um ninho de passarinho e identificar a espécie do pássaro que o construiu. Descrever o ninho com detalhes.
  c) Montar um bebedouro para beija-flor e usá-lo durante uma semana. Responder:
    • Do que é feito o néctar utilizado?
    • Por que não se deve usar corante ou mel?
    • Quando o fluído do bebedouro deve ser trocado?
    • Como deve-se cuidar do bebedouro?
7. Identificar, por meio de figuras ou fotos, 20 espécies de aves. Pelos menos 10 delas devem ser típicas do seu país. Dizer o nome popular e o nome cientifico de cada ave.'),
('EN-004', 'Aves Domésticas', 'estudos-da-natureza', 'especialidade', 2, 1928, 'Associação Geral', '/esp/en-004.webp', 'https://mda.wiki.br/Especialidade_de_Aves_Domésticas', '1. Identificar por meio de fotografias ou ao natural, pelo menos 5 raças de galinhas, como por exemplo:
  a) Plymouth (de qualquer cor)
  b) Wyandotte (de qualquer cor)
  c) Rhode Island Vermelha
  d) Orpington (de qualquer cor)
  e) Leghorn (de qualquer cor)
  f) Índio Gigante
  g) Turken
2. Para cada uma das galinhas escolhidas, descrever o seguinte:
  a) Origem
  b) Características físicas (peso, altura, cor das penas)
  c) Finalidade (poedeiras, ornamentais, etc)
3. Identificar, através de fotografias ou ao natural, 2 raças de cada uma das aves a seguir:
  a) Pato
  b) Marreco
  c) Ganso
  d) Peru
  e) Codorna
4. Demonstrar como descobrir se um ovo está fecundado.
5. Qual o período médio de incubação dos ovos das seguintes aves:
  a) Codorna
  b) Galinha d´angola
  c) Galinha
  d) Pato
  e) Marreco
  f) Peru
6. O que é rinha ? Quais as implicações legais de se envolver com esse tipo de atividade ?
7. Completar um dos seguintes e apresentar um relatório de no mínimo 1 página:
  a) Cuidar de uma ave doméstica por, ao menos, 1 mês.
  b) Acompanhar o processo de incubação (natural ou artificial) de uma ninhada de ovos até a eclosão.
  c) Visitar uma fazenda de avicultura e observar as rotinas de cuidados (Alimentação, vacinação, etc) das aves.'),
('EN-005', 'Flores', 'estudos-da-natureza', 'especialidade', 2, 1928, 'Associação Geral', '/esp/en-005.webp', 'https://mda.wiki.br/Especialidade_de_Flores', '1. Qual o grande grupo de plantas que possui flores?
2. Qual a função de uma flor em uma planta?
3. Fotografar, desenhar ou colecionar imagens de 15 tipos de flores e identificá-las com seu nome popular e, se possível, científico.
4. Saber as funções das seguintes partes de uma flor:
  a) Pétala
  b) Sépala
  c) Androceu
  d) Gineceu
5. Desenhar e classificar corretamente, tendo por base uma flor natural, as seguintes partes: pedúnculo, receptáculo, sépalas, pétalas, cálice, corola, androceu, gineceu, estame (filete e antera), carpelo (ovário, estigma, estilete).
6. Descrever o ciclo de vida de uma flor em particular, incluindo o papel dos insetos ou vento na polinização.
7. Explicar o que é polinização.
8. Fazer 2 dos itens a seguir:
  a) Desenhar, colecionar imagens ou fotografar uma série de, pelo menos, 7 flores, mostrando, na ordem, as cores do arco-íris vermelho, alaranjado, amarelo, verde, azul, violeta.
  b) Apresentar flores frescas, secas ou prensadas que tenham: cinco pétalas, quatro pétalas, três pétalas, nenhuma pétala.
  c) De olhos vendados, distinguir e dar o nome de 2 entre 5 flores silvestres ou cultivadas, usando apenas o sentido do olfato.
  d) Fazer uma lista de flores que você observou e foram visitadas por diferentes animais.
  e) Observar uma flor durante, pelo menos, 10 minutos, à luz do sol e, pelo menos, 10 minutos após o anoitecer e relatar os insetos que a visitaram. Mencionar o número de visitantes e o nome da flor.
1. Citar 1 exemplo de flores que são polinizadas por:
  a) Insetos
  b) Vento
  c) Aves'),
('EN-006', 'Árvores', 'estudos-da-natureza', 'especialidade', 1, 1928, 'Associação Geral', '/esp/en-006.webp', 'https://mda.wiki.br/Especialidade_de_Árvores', '1. Descrever as diferenças entre árvores e arbustos.
2. Conhecer o nome científico das 2 grandes divisões de árvores e saber as diferenças entre elas.
3. Descrever a função das folhas na vida de uma árvore.
4. Esquematizar as partes de uma folha completa. Identificar nas folhas coletadas as partes existentes.
5. Coletar e identificar corretamente as folhas de 15 espécies diferentes de árvores e armazená-las adequadamente. Os rótulos deverão conter o nome científico, família, nome popular e características da árvore.
6. Conhecer de memória as espécies do requisito anterior e ser capaz de identificar outros indivíduos da mesma espécie no campo.
7. Citar 2 exemplos de cada árvore que recebeu seu nome devido:
  a) Ao seu uso comum
  b) Ao ambiente em que cresce
  c) A alguma característica especifica
  d) À região geográfica onde é encontrada
  e) Às primeiras pessoas a descobri-la e descrevê-la
8. Escrever um texto argumentativo sobre a importância da conservação da vegetação do ecossistema onde você mora.
9. Dar 2 exemplos de árvores que:
  a) Crescem melhor em lugares úmidos e alagados
  b) Crescem melhor em altitudes elevadas em montanhas
10. Contar 3 historias bíblicas de árvores que tiveram papel importante.'),
('EN-007', 'Insetos', 'estudos-da-natureza', 'especialidade', 1, 1933, 'Associação Geral', '/esp/en-007.webp', 'https://mda.wiki.br/Especialidade_de_Insetos', '1. Quais são as principais características dos insetos?
2. Fazer um dos seguintes:
  a) Fazer desenhos ou pinturas coloridas de 20 espécies de insetos, contendo espécies de, pelo menos, 6 ordens diferentes. Os desenhos ou pinturas precisam ser do tamanho natural ou maior, para mostrar os detalhes de pequenos insetos e em coloração natural. Identificar a ordem e a família dos espécimes retratados.
  b) Tirar fotografias de 20 espécies de insetos, contendo espécies de, pelo menos, 6 ordens diferentes. Cada imagem deve estar em foco e devidamente identificada, contendo local e data onde a foto foi tirada e ordem e família do espécime fotografado.
3. Dar o nome de 5 espécies de insetos benéficos e que benefícios eles trazem.
4. Dar o nome de 5 espécies de insetos prejudiciais, citando os prejuízos eles causam e explicar como controlá-los.
5. Citar 3 exemplos de insetos que podem ser considerados tanto benéficos quanto prejudiciais.
6. Contar 2 historias bíblicas nas quais os insetos tiveram um papel importante.'),
('EN-008', 'Mariposas e Borboletas', 'estudos-da-natureza', 'especialidade', 1, 1933, 'Associação Geral', '/esp/en-008.webp', 'https://mda.wiki.br/Especialidade_de_Mariposas_e_Borboletas', '1. Que características podem ser usadas para diferenciar mariposas e borboletas?
2. Definir os seguintes termos:
  a) Antena
  b) Ovo
  c) Larva
  d) Pupa
  e) Crisálida
  f) Casulo
  g) Imago
3. Distinguir 3 espécies diferentes a partir de seus casulos.
4. O que é o pó colorido que fica grudado nas mãos ao pegar nas asas de uma borboleta ou mariposa? Examinar o pó da asa de uma borboleta ou mariposa com lentes de aumento e descrever o que foi observado.
5. Que benefícios as mariposas e borboletas trazem ao homem e ao meio ambiente?
6. Que danos as mariposas e borboletas podem causar? Em que estágio da vida elas podem causar danos? Citar 3 exemplos de mariposas e/ou borboletas que causem danos.
7. Que borboleta é famosa por seu ciclo migratório?
8. Completar um dos seguintes:
  a) Identificar por meio de fotografias, 20 espécies de mariposas e borboletas. Identificar a ordem e família de cada espécime.
  b) Fazer desenhos ou pinturas coloridas de 15 espécies de mariposas e borboletas. Os desenhos ou pinturas precisam ser do tamanho natural ou maior e em coloração natural. Identificar a ordem e a família dos espécimes retratados.
9. Descrever o ciclo de vida de uma mariposa ou borboleta e aprender uma lição relacionada com o batismo.'),
('EN-009', 'Fungos', 'estudos-da-natureza', 'especialidade', 3, 1937, 'Associação Geral', '/esp/en-009.webp', 'https://mda.wiki.br/Especialidade_de_Fungos', '1. Citar 3 características do Reino Fungi.
2. Dar o nome de 3 classes de fungos e dar 3 exemplos de cada uma.
3. Identificar, ao natural ou através de imagens, 15 fungos comuns em seu país.
4. Dar o nome de 3 fungos que têm valor económico e dizer qual é a utilidade de cada um.
5. Pesquisar e esquematizar o ciclo de vida de 3 classes de fungos.
6. Citar 5 doenças causadas por fungos em seres humanos, plantas ou animais.
7. Quais cuidados devemos ter ao observarmos e manusearmos diferentes tipos de fungos?
8. Identificar, pessoalmente ou por meio de imagens/fotografias, a diferença entre um bolor, uma orelha de pau e um cogumelo.
9. Identificar, pessoalmente ou por meio de imagens/fotografias, as principais partes de um basidiomiceto.
10. Qual é a importância ambiental de alguns fungos?
11. Geralmente, quais condições ambientais são ideais para um fungo se desenvolver?
12. Como um fungo se alimenta?
13. Encontrar, pelo menos, uma referência bíblica a fungos.'),
('EN-010', 'Mamíferos', 'estudos-da-natureza', 'especialidade', 1, 1937, 'Associação Geral', '/esp/en-010.webp', 'https://mda.wiki.br/Especialidade_de_Mamíferos', '1. Quais são as características dos mamíferos?
2. Em que dia da criação foram criados os mamíferos?
3. Apresentar uma ou mais características peculiares de cada um dos seguintes grupos de mamíferos e mencionar uma ou mais espécies de mamíferos encontradas em cada:
  a) Marsupiais (Marsupialia)
  b) Sirênios (Sirenia)
  c) Xenartros (Xenarthra)
  d) Primatas (Primates)
  e) Roedores (Rodentia)
  f) Lagomorfos (Lagomorpha)
  g) Quirópteros (Chiroptera)
  h) Carnívoros (Carnivora)
  i) Pinípedes (Pinnipedia)
  j) Perissodáctilos (Perissodactyla)
  k) Artiodátilos (Artiodactyla
  l) Cetáceos (Cetacea)
4. Citar:
  a) 4 mamíferos domesticados e explicar a sua utilidade ao ser humano;
  b) 4 coisas que os mamíferos fazem que são prejudiciais ao ser humano;
  c) 4 mamíferos que são completamente aquáticos e indicar sua área de distribuição.
5. Qual é o maior mamífero do mundo? Onde ele vive, como se alimenta e o que come?
6. Relacione oito espécies de mamíferos silvestres que você já observou e identificou pessoalmente na natureza ou em um zoológico.
7. Escrever ou contar uma história sobre "Mamíferos Silvestres que já observei".'),
('EN-011', 'Répteis', 'estudos-da-natureza', 'especialidade', 1, 1937, 'Associação Geral', '/esp/en-011.webp', 'https://mda.wiki.br/Especialidade_de_Répteis', '1. Quais são as principais características dos répteis?
2. Qual o nome da substância que impermeabiliza a pele dos répteis?
3. Quais são as principais ordens em que a classe dos répteis é dividida? Citar 2 exemplos para cada ordem.
4. Dar o nome de 10 répteis encontrados em sua região. Dizer onde vivem, seus hábitos alimentares.
5. Citar 5 répteis peçonhentos que habitam seu país.
6. Quais são os primeiros socorros que devem ser prestados a uma vitima picada por uma serpente peçonhenta? E por uma serpente não peçonhenta?
7. Identificar, pessoalmente ou por imagens, um cágado, tartaruga marinha e jabuti.
8. Ser capaz de contar 2 histórias da Bíblia nas quais um réptil teve papel importante.'),
('EN-012', 'Rochas e minerais', 'estudos-da-natureza', 'especialidade', 2, 1937, 'Associação Geral', '/esp/en-012.webp', 'https://mda.wiki.br/Especialidade_de_Rochas_e_minerais', '1. Saber distinguir entre rochas e minerais.
2. Explicar as características básicas dos três grupos de rochas: sedimentar, ígnea e metamórfica
3. Definir as seguintes características de um mineral: cor, brilho, cor do traço, clivagem, fratura, dureza, densidade e sistema cristalino.
4. Qual o significado da escala de Mohs? Citar os minerais de acordo com essa escala.
5. Mencionar quatro utilidades das rochas e quatro utilidades dos minerais. Citar um exemplo para cada um deles.
6. Coletar ou adquirir, pelo menos, 10 rochas ou minerais. No Caso de ter coletado, classificar as espécies com o nome da pessoa que a encontrou, data e local em que foi encontrada. No caso de ter adquirido, escrever o seguinte:
  a) Para rochas: pesquisar e escrever a mineralogia da rocha e classificá-la segundo os três grupos de rochas;
  b) Para minerais: pesquisar e descrever as seguintes características dos minerais: cor, brilho, cor do traço.
7. Contar quatro incidentes da Bíblia nos quais uma rocha foi importante.
8. Quais pedras ornamentam cada um dos fundamentos do muro da Nova Jerusalém?'),
('EN-013', 'Rochas e Minerais - avançado', 'estudos-da-natureza', 'especialidade', 1, 1937, 'Associação Geral', '/esp/en-013.webp', 'https://mda.wiki.br/Especialidade_de_Rochas_e_Minerais_-_avançado', '1. Ter a especialidade de Rochas e minerais.
2. Definir os seguintes termos:
  a) Estalagmite
  b) Estalactite
  c) Geodo
  d) Veio
  e) Brecha de falha
  f) Lava
  g) Caliche
  h) Formação ferrífera bandada
  i) Kimberlito
  j) Laterita
3. Conhecer os 7 sistemas cristalinos e colar uma figura ou desenhar uma estrutura com cada um dos sistemas. Citar 2 minerais que pertençam a cada um desses grupos.
4. Citar exemplos de metais que são frequentemente encontrados em forma de rocha.
5. Quais tipos de rocha originam-se do magma? Descrever os processos e citar exemplos.
6. Adicionar, pelo menos, 10 rochas ou minerais à sua coleção. No caso de ter coletado, classificar as espécies com o nome da pessoa que a encontrou, data e local em que foi encontrada. No caso de ter adquirido, escrever o seguinte:
  a) Para rochas: pesquisar e escrever a mineralogia da rocha e classificá-la segundo os 3 grupos de rochas;
  b) Para minerais: pesquisar e descrever as seguintes características dos minerais: cor, brilho, cor do traço, clivagem, fratura, dureza, densidade e sistema cristalino.'),
('EN-014', 'Moluscos', 'estudos-da-natureza', 'especialidade', 2, 1938, 'Associação Geral', '/esp/en-014.webp', 'https://mda.wiki.br/Especialidade_de_Moluscos', '1. O que significa o termo molusco?
2. Em relação aos moluscos das classes dos gastrópodes, cefalópodes e bivalves citar:
  a) Suas principais características
  b) Pelo menos um representante de cada classe
3. Quais são os únicos moluscos terrestres? A que classe eles pertencem?
4. Citar 3 características dos moluscos.
5. Identificar e compreender as seguintes estruturas:
  a) Em bivalves
    • Concha
    • Cicatriz do Músculo
    • Umbo
  b) Em gastrópodes
    • Concha
    • Columela
    • Ápice
    • Pé
    • Tentáculos
    • Olhos
6. Todas as conchas podem ser encontradas nas praias? Onde podem ser encontradas? Que áreas do mundo fornecem maior variedade de conchas?
7. Descrever 3 maneiras diferentes utilizadas pelos moluscos para sua locomoção.
8. Como os moluscos se protegem?
9. De que forma as conchas são produzidas pela maioria dos moluscos? Do que são feitas?
10. Citar 5 utilidades das conchas e dos moluscos para o homem.
11. Fazer uma coleção de 20 conchas diferentes. Estas devem ser identificadas com data de coleta ou aquisição e local de origem.
12. De onde vêm as pérolas? Que incrível lição a pérola nos ensina? (Leia parábolas de Jesus, págs 115-118)
13. Abra a sua Bíblia e encontre o texto correspondente para cada uma das seguintes afirmações:
  a) As criaturas aquáticas foram criadas no quinto dia.
  b) A quantidade de criaturas aquáticas é inumerável.
  c) As criaturas das águas perecem fora da água.
  d) Salomão tinha conhecimentos sobre a vida marinha.
  e) Jesus usou um produto de conchas 2 vezes para ensinar uma lição espiritual.
  f) Uma mulher de negócios vendia as famosas tintas da cor púrpura, retiradas de múrice de conchas do Mar Mediterrâneo.
  g) Moluscos não são apropriados para comer.
  h) As 12 portas da Cidade Santa são 12 pérolas.'),
('EN-015', 'Cactos', 'estudos-da-natureza', 'especialidade', 1, 1944, 'Associação Geral', '/esp/en-015.webp', 'https://mda.wiki.br/Especialidade_de_Cactos', '1. Citar as principais características de um cacto.
2. A qual família pertencem os cactos?
3. O que são os espinhos presentes nos cactos? Por que os cactos apresentam essas estruturas?
4. Mencionar 3 utilidades dos cactos ao homem e/ou ao ambiente.
5. Em que região há mais quantidade de cactos? Por quê?
6. Qual a diferença e a relação entre cactos e suculentas?
7. Esquematizar um cacto e identificar suas partes.
8. Conhecer e identificar, ao natural ou em fotografias, 10 espécie de cactos.
9. Cultivar pelo menos, 1 espécie de cactos durante 1 mês. Explicar os cuidados necessários'),
('EN-016', 'Climatologia', 'estudos-da-natureza', 'especialidade', 2, 1944, 'Associação Geral', '/esp/en-016.webp', 'https://mda.wiki.br/Especialidade_de_Climatologia', '1. Explicar como os seguintes fenômenos se formam: neblina, chuva, orvalho, neve, granizo e geada.
2. Identificar no céu, ou em fotografias, os seguintes tipos de nuvens: cirros, cúmulos, nimbos e estratos. Que tipo de tempo está associado a cada uma delas?
3. Explicar como funciona um termômetro de mercúrio, barômetro de mercúrio, barômetro aneróide e pluviômetro.
4. Por que é possível haver chuva de um lado de uma montanha, e estar seco o outro lado? Dar uma ilustração em seu país ou região.
  a) Por que é mais fresco e úmido nas montanhas, do que nos vales?
  b) De que direção geralmente vem a chuva e o tempo bom em sua região?
5. Demonstrar, com ajuda de um diagrama, como a relação entre a Terra e o Sol produz as diferentes estações.
6. O que causa os raios e trovões? Quais os tipos diferentes de raios existentes?
7. Com auxílio de um diagrama, demonstrar o que é convecção e qual sua relação com o vento.
8. Explicar como radares, satélites e computadores são usados na previsão do tempo.
9. Explicar como os itens a seguir podem afetar o tempo:
  a) Correntes de jato
  b) Erupções vulcânicas
10. Fazer um desenho mostrando o ciclo de água na meteorologia.
11. Fazer um cata-vento simples ou pluviômetro.
12. Manter um quadro meteorológico durante uma semana e registrar a leitura do tempo em intervalos de 12 horas. Incluir o seguinte:
  a) Temperatura
  b) Umidade (orvalho, neblina, chuva, geada ou neve)
  c) Formação de nuvens
  d) Direção do vento
13. Completar a leitura das seguintes passagens: Gênesis 1, Jonas 1 e 2, e Mateus 8:23-27. Após a leitura, participar de um debate sobre o porquê da criação do clima, qual a relação entre o clima e a vontade de Deus e como o clima pode ser usado por Deus como ferramenta de Salvação.'''),
('EN-017', 'Fósseis', 'estudos-da-natureza', 'especialidade', 2, 1944, 'Associação Geral', '/esp/en-017.webp', 'https://mda.wiki.br/Especialidade_de_Fósseis', '1. O que são fósseis?
2. Descrever, pelo menos, 3 processos de fossilização.
3. Qual a diferença entre fóssil, Somatofóssil e icnofóssil?
4. Definir as seguintes palavras:
  a) Geologia
  b) Fósseis
  c) Catastrofismo
  d) Pelecípode
  e) Graptolite
  f) Trilobita
  g) Dinossauro
  h) Mamute
  i) Mastodonte
  j) Crinoite
  k) Lingula
  l) Foraminífera
  m) Radiolário
  n) Paleozoico
  o) Mesozoico
  p) Cenozoico
  q) Pleistoceno
  r) Paleontologia
  s) Paleobotânica
  t) Braquiópode
5. Que explicação há para a existência de animais congelados nas regiões árticas? Qual explicação se dá para sua condição e quando, provavelmente, viveram na terra?
6. Qual a relação direta entre o dilúvio citado na Bíblia e a quantidade de fósseis encontrados no planeta?
7. Citar textos da Bíblia e do Espírito de Profecia para explicar a origem dos seguintes itens:
  a) Carvão
  b) Petróleo
  c) Fósseis
  d) Calcário
8. Visitar um museu onde há fósseis em exibição e fazer um relatório da excursão.
9. Responder as perguntas abaixo por pesquisa pessoal ou com auxílio de um arqueólogo ou paleontólogo:
  a) Dizer como o esqueleto de um dinossauro ou outro fóssil de proporções gigantescas deveria ser removido.
  b) Por que principiantes não devem retirar estes espécimes?
  c) O que um principiante deve fazer se encontrar um fóssil?
  d) Descrever o processo de limpeza dos espécimes assim que são retirados, para prepara-los para o museu.
10. Explicar a diferença entre as teorias apresentadas por evolucionistas e criacionistas diante da presença de fósseis.
11. Pesquisar sobre a ocorrência de fósseis em sua região/país e descobrir onde está o sítio paleontólogo mais próximo.'),
('EN-018', 'Samambaias', 'estudos-da-natureza', 'especialidade', 2, 1944, 'Associação Geral', '/esp/en-018.webp', 'https://mda.wiki.br/Especialidade_de_Samambaias', '1. Qual a diferença entre as samambaias, árvores e flores?
2. Onde fica o caule das samambaias? Que parte da mesma cresce acima da terra? Em que ambiente é mais viável uma samambaia crescer?
3. Explicar como acontece a reprodução de uma samambaia. Localizar e descrever 3 tipos de soros a partir de 3 tipos de samambaias.
4. Como os esporos viajam da planta mãe para um novo local? Quanto tempo leva para um esporo se desenvolver em uma planta adulta? Demonstrar, através de fotografias ou ao natural, como as samambaias jovens são diferentes das samambaias adultas.
5. Citar 3 tipos de samambaias que podemos utilizar como remédio medicinal.
6. Além das samambaias comuns, existem plantas semelhantes a samambaias que são conhecidas como licopódio e cavalinha. Ser capaz de reconhecer 2 licopodiáceas e 1 cavalinha. Explicar as suas semelhanças com as samambaias.
7. Desenhar, fotografar e identificar, pelo menos, 10 tipos de samambaias contendo: Nome científico, classificação e onde pode ser encontrada.'),
('EN-019', 'Arbustos', 'estudos-da-natureza', 'especialidade', 1, 1945, 'Associação Geral', '/esp/en-019.webp', 'https://mda.wiki.br/Especialidade_de_Arbustos', '1. Descrever as diferenças entre arbustos e árvores.
2. Em que estação do ano a maioria dos arbustos floresce? Dar o nome de um arbusto que floresce antes das folhas aparecerem.
3. Que arbusto parasita, muito usado para decoração de interiores, cresce nos galhos mais altos de diferentes tipos de árvores?
4. Mencionar um arbusto cuja flor atraia os pássaros.
5. Em que tipos de arbustos os pássaros preferem construir seus ninhos?
6. Por que uma parreira, às vezes é considerada um arbusto?
7. Dar o nome de um arbusto que produz castanhas comestíveis.
8. Mencionar 2 arbustos cultivados e 2 arbustos silvestres da sua região que produzem flores vistosas.
9. Coletar e identificar corretamente as flores de 10 arbustos silvestres. Armazená-las adequadamente.'),
('EN-020', 'Aves de Estimação', 'estudos-da-natureza', 'especialidade', 1, 1945, 'Associação Geral', '/esp/en-020.webp', 'https://mda.wiki.br/Especialidade_de_Aves_de_Estimação', '1. Quais são as leis do seu estado ou país com respeito à captura, criação e exportação de pássaros em gaiolas? Certifique-se que está agindo de acordo com a lei enquanto cumpre as exigências desta Especialidade.
2. Cuidar de um pássaro, ou de um casal de pássaros por, pelo menos, um mês.
3. Completar um dos itens a seguir:
  a) Se tiver um pássaro em gaiola, fazer um registro dos cuidados dispensados a ele durante, pelo menos, 1 mês. Incluir descrição de hábitos alimentares, necessidade de água, limpeza de gaiola, etc.
  b) Se não tiver um pássaro em gaiola atualmente, mas tiver completado o item 1 no passado, cuidar do pássaro de alguém durante, pelo menos, 1 semana, enquanto esteja viajando, etc. , e fazer o registro dos cuidados necessários.
4. Canários:
  a) Citar o nome de 4 variedades de canários.
  b) Apresentar uma breve história da origem e desenvolvimento dos canários.
  c) Dar o nome e ser capaz de distinguir 5 sementes usadas na alimentação de canários.
  d) Descrever resumidamente os cuidados gerais dos canários.
5. Periquitos:
  a) De que país são originários os periquitos?
  b) Descrever brevemente seus hábitos de alimentação, ninho e comportamento em geral.
6. Pesquisar na sua região qual o tipo de ave de estimação mais comum, diferente das citadas acima e citar suas características, variedades e cuidados quando domesticados.'),
('EN-021', 'Gramíneas', 'estudos-da-natureza', 'especialidade', 3, 1945, 'Associação Geral', '/esp/en-021.webp', 'https://mda.wiki.br/Especialidade_de_Gramíneas', '1. Citar 4 características que a planta precisa possuir para ser considerada uma gramínea.
2. Uma gramínea apresenta qual tipo de raiz?
3. Qual o nome da família das gramíneas? Quantas espécies existem atualmente desta família?
4. Uma gramínea é considerada monocotiledônea ou dicotiledônea?
5. Que característica única no crescimento das gramíneas torna possível o crescimento constante, mesmo que sirva de pasto ou que seja cortada?
6. O que são gramíneas anuais? Citar 3 exemplos.
7. O que são gramíneas perenes? Citar 3 exemplos.
8. Dar exemplos de gramíneas que são utilizadas para produzir:
  a) Pão (3 gramíneas)
  b) Vassoura
  c) Vara de Pescar
  d) Glúten
  e) Álcool de grãos (2 gramíneas)
  f) Palha
  g) Canjica
  h) Melado
  i) Mingau de aveia
  j) Amido
  k) Açúcar
  l) Farinha branca
9. Completar as atividades a seguir:
  a) Escolher uma semente de gramínea, plantá-la e cultivá-la por 1 mês. Fazer um relatório sobre o que observou.
  b) Fazer uma coleção com as folhas e sementes e, se possível, flores de 10 gramíneas de sua região.
10. Qual a importância econômica das gramíneas?
11. Em qual ecossistema a família das gramíneas está entre as principais famílias?
12. Citar 2 passagens bíblicas que façam referência a gramíneas.'),
('EN-022', 'Peixes', 'estudos-da-natureza', 'especialidade', 2, 1945, 'Associação Geral', '/esp/en-022.webp', 'https://mda.wiki.br/Especialidade_de_Peixes', '1. Aproximadamente, quantas espécies de peixes existem ao redor do mundo?
2. Por que os peixes são considerados animais pecilotérmicos?
3. Dar o nome de 10 famílias de peixes.
4. Quais as principais diferenças entre peixes condrictes e peixes osteíctes? Citar 5 exemplos de cada um.
5. O que são peixes diádromos? Dar, ao menos, 5 exemplos.
6. Definir as seguintes partes de um peixe:
  a) Barbatana dorsal
  b) Barbatana peitoral
  c) Barbatana pélvica
  d) Barbatana anal
  e) Barbatana caudal
  f) Linha lateral
  g) Opérculo
  h) Barbilhos
  i) Guelras
7. Responder as seguintes perguntas:
  a) Qual o maior peixe do mundo? A que tamanho pode chegar? Onde ele vive? Do que se alimenta? Qual sua relação com o ser humano?
  b) O que é e qual a utilidade da bolsa olfatória?
  c) O que é e como funciona a bexiga natatória?
  d) Como é o funcionamento da linha lateral dos peixes? Listar 3 de suas utilidades.
  e) Como funciona a respiração branquial presente na maioria dos peixes?
8. Identificar, por meio de desenhos ou fotos, 15 peixes típicos do seu país. Mencionar seu habitat, alimentação e tipo de procriação.
9. Citar 2 historias bíblicas onde os peixes tiveram um papel de destaque.'),
('EN-023', 'Anfíbios', 'estudos-da-natureza', 'especialidade', 2, 1945, 'Associação Geral', '/esp/en-023.webp', 'https://mda.wiki.br/Especialidade_de_Anfíbios', '1. Quais as características dos anfíbios?
2. Dar o nome das 3 ordens pertencentes à classe Anphibia e citar as principais diferenças entre elas.
3. Como os anfíbios se protegem?
4. Onde os anfíbios passam o inverno ou a estação seca?
5. Por meio de imagens, fotos, desenhos ou pessoalmente, identificar sapos, rãs e pererecas. Como diferenciá-los?
6. Descrever ou esquematizar o ciclo de vida de um anuro.
7. Qual parte do corpo é utilizada para amplificar o som que os anuros produzem? Tanto machos quanto fêmeas são capazes de coaxar? Para que os anuros utilizam seus coaxos?
8. Explicar do que e como a maioria dos anuros se alimenta.
9. Identificar, por meio de fotos ou imagens, 10 diferentes espécies de anfíbios encontrados em seu estado ou país.
10. Observar um anfíbio em seu habitat natural ou cativeiro, ao vivo ou em vídeo, por alguns minutos e escrever um relatório sobre o que observou.'),
('EN-024', 'Felinos', 'estudos-da-natureza', 'especialidade', 1, 1945, 'Associação Geral', '/esp/en-024.webp', 'https://mda.wiki.br/Especialidade_de_Felinos', '1. Qual é o nome da família dos gatos na classificação taxonômica (biológica)? Quais são as características comuns dessa família?
2. Como a estrutura da pata é semelhante em todos os felinos?
3. De que maneira os olhos de todos os felinos são semelhantes?
4. Qual o principal alimento da família dos gatos? De que forma os dentes dos gatos estão preparados para isso?
5. Para que servem os bigodes dos gatos?
6. Como os ouvidos dos gatos são protegidos?
7. Identificar, a partir de fotografias, ilustrações ou observação pessoal, 4 raças de gatos domésticos. Descrever o temperamento de cada um.
8. Quais os benefícios, para o homem, dos gatos domésticos?
9. Identificar, a partir de fotografias, ilustrações ou observação pessoal, 7 espécies de felinos selvagens. Dizer em que parte do mundo são encontrados.
10. Responder o seguinte sobre felinos:
  a) Qual é o maior felino do mundo?
  b) Qual é o maior felino da América do Sul?
  c) Qual é o felino mais veloz do mundo?
  d) Qual felino é popularmente conhecido como "rei dos animais"? Como é seu real temperamento?
11. Contar 4 histórias bíblicas nas quais um membro da família dos felinos é mencionado.'),
('EN-025', 'Rebanhos Domésticos', 'estudos-da-natureza', 'especialidade', 2, 1945, 'Associação Geral', '/esp/en-025.webp', 'https://mda.wiki.br/Especialidade_de_Rebanhos_Domésticos', '1. Saber as principais diferenças entre cavalos de tração e cavalos de corrida.
2. Relacionar, pelo menos, 4 caraterísticas físicas da mula.
3. Conhecer as qualidades de produção de leite das raças Jersey, Guernsey e Holandesa.
4. Diferenciar entre as cabras Angorá e leiteiras. Mencionar as cores distintas de, pelo menos, 3 cabras, tais como a Saanon, Toggenburg, Nubiana e Mambrina.
5. Visitar uma fazenda e identificar 3 das seguintes raças de cavalos, listando suas principais características, como altura, peso, cor e disposição de pelos (Caso em sua região crie apenas um tipo, as demais poderão ser por fotos).
  a) Normando
  b) Belga
  c) Apoloosa
  d) Árabe
  e) Manga larga
  f) Crioulo
6. Identificar um burro a partir de foto ou observação ao natural. Mencionar a cor, o tamanho e utilidade.
7. Visitar uma fazenda e observar 4 tipos de gado leiteiro e 4 tipos de gado de corte (Caso em sua região se crie apenas um tipo, as demais poderão ser por fotos).
8. Identificar ao natural 3 raças de ovelhas, tais como Merino, Ramboilet, Hampshire, Sufok e Lincoln. Relatar o processo de produção de lã e carne, tamanho, traços peculiares e aparência geral de cada uma das raças identificadas. (Caso em sua região se crie apenas um tipo, as demais poderão ser por fotos).'),
('EN-026', 'Astronomia - avançado', 'estudos-da-natureza', 'especialidade', 3, 1949, 'Associação Geral', '/esp/en-026.webp', 'https://mda.wiki.br/Especialidade_de_Astronomia_-_avançado', '1. Ter a especialidade Astronomia.
2. Explicar os seguintes termos:
  a) Planeta
  b) Satélite
  c) Cometa
  d) Meteoro
  e) Nebulosa
  f) Mancha solar
  g) Esfera celeste
  h) Pólo celeste
  i) Equador celeste
  j) Horizonte
  k) Ascensão reta
  l) Declinação
  m) Trânsito astronômico
  n) Conjunção
  o) Eclíptica
  p) Zênite
  q) Nadir
3. Qual a relação entre a eclíptica e os equinócios primavera e de outono? Quais datas são, normalmente, associadas aos equinócios ?
4. Sobre os planetas do sistema solar, responder:
  a) Características peculiares de cada planeta;
  b) Quais desses planetas não podem ser vistos sem a ajuda de um telescópio?
  c) Quais 2 planetas são vistos perto do amanhecer ou perto do anoitecer?
5. Identificar no céu e nomear as constelações símbolos da primavera ou do outono no hemisfério sul.
6. O que são constelações circumpolares e constelações sazonais? Dar exemplos.
7. Nomear cinco constelações que são visíveis entre o pôr-do-sol e meia-noite no hemisfério sul nos meses de verão e nos meses de inverno.
8. Como as letras do alfabeto grego são usadas para nomear as estrelas de uma constelação?
9. Em qual época do ano a constelação de Orion é melhor vista? Dar o nome e localizar no céu, as três estrelas mais brilhantes desta constelação.
10. Explicar as principais diferenças entre um telescópio refrator e um telescópio refletor.
11. Construir um relógio solar e saber ver as horas através dele.
12. Onde e de que maneira a Bíblia se refere à Ursa Maior, a Órion (3 Marias), às Plêiades (sete-estrelo/sete-cabrinhas) e às recâmaras do sul(estrelas do sul)?'),
('EN-027', 'Aves - avançado', 'estudos-da-natureza', 'especialidade', 3, 1949, 'Associação Geral', '/esp/en-027.webp', 'https://mda.wiki.br/Especialidade_de_Aves_-_avançado', '1. Ter a especialidade de Aves.
2. Conhecer as leis de proteção às aves em seu país. Apresentar este item através de relatório.
3. Através de imagens, identificar as principais partes anatômicas e morfológicas de uma ave.
4. Qual a importância das penas para as aves? Apresentar uma imagem (ilustração ou foto) de uma pena ampliada, onde possa ser analisada com precisão a estrutura da mesma. Por que as penas das aves aquáticas são impermeáveis em agua mais do que as das aves não aquáticas?
5. Qual a importância das aves terem sido criadas com certas características, especialmente nos pés, pernas e bicos, como uma forma de se adaptar ao meio ambiente?
6. Identificar, através de imagens, aves que apresentem:
  a) Patas apropriadas para nadar
  b) Patas apropriadas para andar ou saltar
  c) Patas apropriadas para escalar
  d) Patas apropriadas para empoleirar
  e) Bico apropriado para furar madeira
  f) Bico e línguas longos para retirar néctar de flores
  g) Bico apropriado para arrancar pedaços
7. Sobre os beija-flores, saber:
  a) O que os beija-flores comem na natureza e com que frequência?
  b) Por que os beija-flores não têm medo de grandes mamíferos ou pássaros?
  c) Qual a diferença dos movimentos de suas asas, comparadas a outros pássaros?
  d) Como conseguem voar para trás?
  e) Quão rápido são capazes de voar?
  f) Com que rapidez batem as asas e o coração?
  g) Qual o formato da língua?
8. Por qual motivo as aves migram?
9. O que é anilhamento? Como ele contribui para informações a respeito de migrações, comportamento e estrutura social? Que outros mecanismos são utilizados para monitorar as aves?
10. Mencionar a origem e o destino final de 10 espécies migratórias que ocorram em seu continente, de preferência em seu país ou região.
11. Descrever, pelo menos, 3 diferentes formas utilizadas pelas aves para se orientar em suas viagens.
12. Fazer uma lista de 30 espécies de aves que você já tenha observado pessoalmente. Para cada espécie desta lista, notar o seguinte:
  a) Nome
  b) Data de observação
  c) Local de observação
  d) Habitat (ou seja, campo, bosque, rio, lago, etc.)
13. Confeccionar uma coleção com nome popular e científico de 60 aves (imagens ou fotos), onde, pelo menos, 30 devem ser típicas de seu país.
14. Participar de uma caminhada em grupo para observar aves. Realizar um relatório sobre a caminhada e listar os materiais necessários para uma boa caminhada de observação de aves.'),
('EN-028', 'Climatologia - avançado', 'estudos-da-natureza', 'especialidade', 3, 1949, 'Associação Geral', '/esp/en-028.webp', 'https://mda.wiki.br/Especialidade_de_Climatologia_-_avançado', '1. Ter a especialidade de Climatologia.
2. Explicar o que são áreas ciclonais e anticiclonais e mostrar quais as mudanças que elas provocam no tempo.
3. O que são frentes frias e frentes quentes? Como se movem e que condições meteorológicas produzem?
4. Explicar os seguintes fenômenos meteorológicos: vento adiabático, ventos alísios, zona de calmaria, furacão, linha de instabilidade, tornado e nevasca.
5. Explicar a ação dos registros termométricos, barográficos, higrométricos e anemométricos.
6. Ler corretamente um mapa do tempo diário, como o publicado pelo Serviço Meteorológico, explicando os símbolos e dizendo como as previsões são feitas.
7. O que significa umidade relativa do ar e ponto de condensação?
8. Desenhar um corte transversal da atmosfera, mostrando suas cinco camadas e descrevendo cada uma delas.
9. Fazer um diagrama do tempo durante três semanas. Incluir o seguinte:
  a) Precipitação pluviométrica (conseguir esta informação em seu próprio pluviômetro caseiro, ou a partir de relatórios oficiais)
  b) Leitura de barômetro
  c) Formação de nuvens
  d) Direção e velocidade dos ventos
  e) Temperaturas (altas e baixas)
  f) Umidade (orvalho, neblina, chuva, geada ou neve)
  g) Previsões de tempo e comparação com a realidade
10. Explicar o que são os fenômenos "El Niño" e "La Niña" e quais são as principais consequências para a América do Sul.
11. Realizar uma pesquisa sobre as diferenças entre os ventos anabático e catabático. Descobrir as características peculiares de cada um, como são formados e a que tipo de processo termodinâmico cada um está associado.
12. Debater o seguinte junto ao grupo da especialidade de Climatologia (básico ou avançado):
  a) Alguns benefícios para o homem adquiridos através da criação do clima
  b) Qual a relação entre o clima e a vontade de Deus
  c) Quais os efeitos do pecado sobre o clima
  d) Como o clima pode ser usado por Deus, como ferramenta de Salvação.'),
('EN-029', 'Flores - avançado', 'estudos-da-natureza', 'especialidade', 3, 1949, 'Associação Geral', '/esp/en-029.webp', 'https://mda.wiki.br/Especialidade_de_Flores_-_avançado', '1. Ter a especialidade de Flores.
2. Fazer uma coleção com imagens ou fotografias de 50 espécies de flores. Identifique-as com o nome popular e científico.
3. Demonstrar habilidade em utilizar uma chave de identificação de plantas que possuam flores.
4. Citar exemplos e saber a diferença entre:
  a) Flores perfeitas e flores imperfeitas
  b) Pistilada e estaminada
5. As Angiospermas são divididas entre monocotiledóneas (Liliopsida) e dicotiledóneas (Magnoliopsida). Dentro das 2 classes existem muitas famílias. Escolher 6 famílias da classe das dicotiledóneas e 4 famílias da classe das monocotiledóneas. Realizar uma pesquisa destacando suas principais características e exemplos de espécies dessas famílias.
6. Usando a Bíblia, apresentar 2 lições espirituais nas quais os escritores bíblicos usaram as flores como ilustrações.
7. Dar o nome e descrever 8 plantas que possuam flores que são venenosas, comentando a parte especifica da planta que é venenosa.
8. Fazer um dos itens a seguir:
  a) Escolher 2 sementes de flores, plantá-las e cultivá-las. Anotar as mudanças ocorridas do decorrer de 1 mês.
  b) Escolher 4 espécies diferentes de flores, cuidar destas durante 1 mês. Realizar uma pesquisa para descobrir quais são os seus polinizadores mais comuns e gerar um relatório contendo essas informações e também os cuidados necessários para cuidar dessas plantas.
  c) Cuidar, com seu Clube ou unidade, de um jardim, floreira grande ou praça durante, pelo menos, 1 mês.
9. Citar 3 diferenças existentes entre monocotiledóneas e dicotiledóneas, entre elas a formação floral.'),
('EN-030', 'Insetos - avançado', 'estudos-da-natureza', 'especialidade', 2, 1949, 'Associação Geral', '/esp/en-030.webp', 'https://mda.wiki.br/Especialidade_de_Insetos_-_avançado', '1. Ter a especialidade de Insetos.
2. Fazer um dos seguintes:
  a) Acrescentar 30 desenhos ou pinturas coloridas de espécies de insetos ao seu álbum da especialidade de insetos. O álbum completo deverá conter espécies de, pelo menos, 10 ordens diferentes. Os desenhos ou pinturas precisam ser do tamanho natural ou maior, para mostrar os detalhes de pequenos insetos, e em coloração natural. Identificar a ordem e a família dos espécimes retratados.
  b) Acrescentar 30 fotografias de espécies de insetos ao seu álbum da especialidade de insetos. O álbum completo deverá conter espécies de, pelo menos, 10 ordens diferentes. Cada imagem deve estar em foco e devidamente identificada, contendo local e data onde a foto foi tirada e ordem do espécime fotografado.
3. Como as estruturas especiais e hábitos dos insetos os deixam tão notavelmente capacitados para a vida?
4. Diferenciar insetos ametábolos, hemimetábolos e holometábolos e citar 2 exemplos de cada. Ilustrar o ciclo de vida de 4 insetos de ordens diferentes, sendo 2 hemimetábolos e 2 holometábolos.
5. O que são insetos eusociais? Como eles diferem dos insetos insociais e dos subsociais? Citar 2 exemplos de insetos eusociais.
6. Dar o nome de, pelo menos, 4 insetos que transmitem doenças ao homem e dar o nome de, pelo menos, uma doença transmitida por cada um desses insetos.
7. Construir uma rede entomológica. A rede pode ser uma rede aérea, de arrasto ou aquática.
8. Construir uma armadilha para insetos noturnos, utilizá-la e fazer um relatório sobre os insetos que foram capturados.
9. Fazer um dos seguintes:
  a) Mencionar, pelo menos, um inseto correspondente a cada um dos seguintes:
    • Aquáticos
    • Minadores
    • Broqueadores
    • Galhadores
    • Sugadores de seiva
    • Comedores de papel
    • Parasita de mamíferos ou aves
  b) Descrever as castas de cupins e abelhas
  c) Comparar os graus de inteligência exibidos por um gafanhoto ou besouro, com a formiga, abelha ou vespa.
10. Citar 3 exemplos de insetos que podem ser considerados tanto benéficos quanto prejudiciais.'),
('EN-031', 'Mamíferos - avançado', 'estudos-da-natureza', 'especialidade', 2, 1949, 'Associação Geral', '/esp/en-031.webp', 'https://mda.wiki.br/Especialidade_de_Mamíferos_-_avançado', '1. Ter a especialidade de Mamíferos.
2. Que mamíferos de sua região são protegidos por lei? Por quê?
3. Como o processo de nascimento e cuidado dos filhotes difere os monotremos e marsupiais de todas as outras ordens de mamíferos?
4. Mencionar cinco maneiras diferentes pelas quais os mamíferos protegem a si mesmos e aos seus filhotes e dar um exemplo de cada uma.
5. Conhecer as seguintes zoonoses: febre maculosa, leishmaniose tegumentar americana, leptospirose, hantavirose, raiva, toxoplasmose e doença de Chagas. Sobre cada uma delas dizer:
  a) Sinais e sintomas
  b) Vetor/reservatório/hospedeiro
  c) Transmissão
  d) Prevenção
6. Relacionar 15 espécies de mamíferos silvestres que você já observou e identificou pessoalmente na natureza ou um zoológico. Para cada um, dizer:
  a) Nome popular
  b) Nome científico
  c) Habitat
  d) Hábito
  e) Comportamento'),
('EN-032', 'Moluscos - avançado', 'estudos-da-natureza', 'especialidade', 3, 1949, 'Associação Geral', '/esp/en-032.webp', 'https://mda.wiki.br/Especialidade_de_Moluscos_-_avançado', '1. Ter a especialidade Moluscos
2. Conhecer 7 classes de moluscos e saber distinguir as principais características de cada uma. Conhecer, pelo menos, 2 representantes de cada classe.
3. Distinguir entre moluscos univalves de bivalves, considerando o seguinte:
  a) Concha
  b) Corpo do molusco
  c) Reprodução
  d) Movimentos
  e) Busca por alimentação
  f) Autopreservação
4. Identificar, a partir das conchas ou de desenhos, e conhecer os seguintes termos conquiliológicos:
  a) Válvula
  b) Vértice
  c) Abertura
  d) Bisso
  e) Pé
  f) Manto
  g) Opérculo
  h) Madrepérola
  i) Lábios
  j) Epiderme
  k) Costela
  l) Dentes
  m) Linhas concêntricas
  n) Canal
  o) Espinhas
  p) Espiras
  q) Lábios
5. Quanto tempo vivem os moluscos?
6. Apresentar alguns fatos sobre a vida de um Strombus pugilis (Concha-de-briga) e explicar porque esta concha tem esse nome.
7. Identificar e explicar as atividades do Teredo.
8. Dar o nome de 2 moluscos que não têm concha.
9. Encontrar respostas para as intrigantes perguntas a seguir:
  a) Como animais bivalves e univalves se prendem às suas conchas?
  b) Como se controla a cor de uma concha?
  c) Que molusco tem 4 guelras?
  d) A partir de que animal marinho fazia-se a tinta na Índia?
  e) Que molusco deixa um rastro brilhante?
  f) Que conchas eram usadas como dinheiro por tribos antigas?
  g) Que concha é considerada sagrada pelos tibetanos?
  h) A tinta púrpura dos tempos antigos era retirada da excreção de que molusco?
10. Citar 6 usos comerciais das conchas.
11. Fazer uma coleção de 40 conchas diferentes. Identificá-las de acordo com a data de coleta, local, habitat do molusco que a possuía e o nome da classe pertencente. Caso tenha ganhado ou sido presenteado, indicar o nome da pessoas que o presenteou, data, classe a que pertence e, se possível, qual era o habitat do molusco que possuía esta concha.'),
('EN-033', 'Árvores - avançado', 'estudos-da-natureza', 'especialidade', 3, 1949, 'Associação Geral', '/esp/en-033.webp', 'https://mda.wiki.br/Especialidade_de_Árvores_-_avançado', '1. Ter a especialidade Árvores.
2. Colocar e identificar corretamente as folhas de 30 espécies diferentes de árvores e armazená-las adequadamente. Os rótulos deverão conter o nome científico, família, nome popular da árvore.
3. Classificar as folhas dos espécimes da coleção do requisito anterior quanto à composição da folha (simples ou composta), quanto ao pecíolo (peciolada, peltada, séssil), quanto à forma do limbo foliar e quanto ao tipo de margem.
4. Fazer o seguinte:
  a) Descrever as vantagens de usar os nomes científicos.
  b) Explicar para que servem os dois termos de um nome científico e o porquê de alguns nomes científicos aparecerem expressos com 3 termos.
5. Dar o nome de 6 famílias de árvores da divisão angiosperma e de 3 famílias de árvores da divisão gimnosperma.
6. Definir os termos a seguir:
  a) Estípula
  b) Resina
  c) Cerne
  d) Alburno
  e) Fibra
  f) Câmbio
  g) Xilema
  h) Floema
7. Identificar 10 plantas comuns por suas características (que não sejam as folhas), tais como gavinhas, espinhos, acúleos, casca, flores, frutos, interações planta-animal, formato característico e hábitos de crescimento.'),
('EN-034', 'Cães', 'estudos-da-natureza', 'especialidade', 1, 1950, 'Associação Geral', '/esp/en-034.webp', 'https://mda.wiki.br/Especialidade_de_Cães', '1. Dar o nome científico do cão doméstico.
2. Citar 5 características peculiares da família Canidae.
3. Identificar, a partir de fotografias/figuras, ou observação natural, 5 membros selvagens da família Canidae.
4. Identificar, a partir de fotografias/figuras, ou observação natural, 15 diferentes raças de cães.
5. Mencionar 5 contribuições da família dos cães ao homem.
6. Escrever ou descrever oralmente a importância, para o homem, dos seguintes grupos de cães e mencionar algumas raças equivalentes:
  a) Cães-guia
  b) Cães farejadores
  c) Cães pastores
  d) Cães companheiros para crianças
  e) Cães guardas
  f) Cães que auxiliam polícia e bombeiros em sua região
7. Dar o nome da menor e da maior raça de cães.
8. Identificar, pessoalmente ou por fotografias/figuras, 5 cães que são classificados como "toy" (anões).
9. Quais as duas raças de cão que tem a língua inteiramente azul ou preta?
10. Qual a raça mais rápida?
11. Quais cuidados deve-se tomar com os cães para que tenham uma vida saudável.
12. Ajudar a cuidar de um cão por, pelo menos, 1 mês.
13. Qual a importância das vacinas em cães domésticos?'),
('EN-035', 'Areia', 'estudos-da-natureza', 'especialidade', 2, 1956, 'Associação Geral', '/esp/en-035.webp', 'https://mda.wiki.br/Especialidade_de_Areia', '1. O que significa a palavra areia? Dar o nome de 2 tipos de areia.
2. Qual a diferença entre areia e solo?
3. Como a areia é formada?
4. O que se entende a partir do tamanho, forma, superfície e fragmentação do grão de areia?
5. Definir e explicar a utilidade de cada uma:
  a) Glaciar
  b) Calcária
  c) Areia Movediça
  d) Areia para fazer vidro
  e) Areia de Modelagem
  f) Areia para polir
  g) Areia para construção
  h) Areia para filtrar
  i) Areia para fornalha
  j) Areia de praia
6. Cumprir uma das opções abaixo:
  a) Examinar 5 tipos de areia com lentes de aumento e observar as suas várias características;
7. Fazer uma coleção de 10 variedades de areias coloridas e dar o nome da localidade de onde as tirou. (Observação: Levar saquinhos pequenos, um lápis e uma pequena colher ou concha para retirar a areia. Apresentar em pequenos vidros/garrafas ou saquinhos plásticos).'),
('EN-036', 'Algas', 'estudos-da-natureza', 'especialidade', 3, 1961, 'Associação Geral', '/esp/en-036.webp', 'https://mda.wiki.br/Especialidade_de_Algas', '1. Definir o que são algas. Qual a sua importância para o ecossistema?
2. Onde as algas podem ser encontradas?
3. Como é chamado o órgão de fixação do substrato? Que diferenças e semelhanças podem ser encontradas entre uma alga e uma planta?
4. Explicar porque há uma variação de tamanho entre as algas marinhas.
5. Citar, pelo menos, 4 grupos de algas marinhas. Para cada grupo mencionar as seguintes informações:
  a) Nome popular
  b) Nome científico
  c) Estrutura (unicelular, pluricelular, ou ambos)
6. O que são diatomáceas? Onde são encontradas?
7. Onde as algas marinhas crescem com mais frequência: zona polar, temperada ou tropical? Explicar.
8. Onde as algas marrons ou pardas são mais comumente encontradas, em água doce ou salgada?
9. Qual a maior profundidade em que as algas marinhas crescem no oceano? Explicar o motivo das algas não se desenvolverem em águas profundas.
10. Nomear 3 partes de uma alga marinha de grande porte. Como elas podem ser comparadas a uma folha, a um caule e a uma raiz de uma planta?
11. Explicar, pelo menos, 2 formas de reprodução das algas marinhas.
12. Citar algumas vantagens comerciais que as algas marinhas podem contribuir ao homem.
13. Montar um álbum de fotografias/imagens contendo, pelo menos, 20 espécimes de algas. Identificá-las pelo nome popular e, se possível, o nome científico.'),
('EN-037', 'Cetáceos', 'estudos-da-natureza', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/en-037.webp', 'https://mda.wiki.br/Especialidade_de_Cetáceos', '1. De que maneira a ordem dos cetáceos é diferente da maioria dos outros seres marinhos?
2. Explicar a diferença entre baleias verdadeiras (misticetos) e baleias com dentes (odontocetos).
3. De que formas as baleias e os golfinhos têm sido um benefício para o homem?
4. Sabendo que as baleias são animais homeotérmicos (de sangue quente), assim como os seres humanos, explicar como as baleias que se reproduzem nas águas quentes dos trópicos também podem sobreviver nas águas geladas da Antártida, para onde elas vão para se alimentar.
5. Escrever e ler para um grupo, ou contar de memória, a história de Jonas.
6. Desenhar, com sucesso, uma baleia verdadeira e identificar onde ficam as seguintes partes do corpo:
  a) Barbatanas
  b) Orifícios respiratórios (espiráculos)
  c) Nadadeira dorsal
  d) Ouvido
  e) Olho
  f) Sulcos ventrais
  g) Lobos caudais
  h) Nadadeiras peitorais
  i) Abertura genital
  j) Intersecção dos lobos caudais
  k) Pedúnculo caudal
7. Ser capaz de identificar, pelo menos, 15 espécies de cetáceos, ao vivo, por fotografia, ilustração ou documentário.'),
('EN-038', 'Ervas', 'estudos-da-natureza', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/en-038.webp', 'https://mda.wiki.br/Especialidade_de_Ervas', '1. Relacionar 25 ervas culinárias e o uso de cada uma.
2. Relacionar 25 ervas medicinais e o uso de cada uma.
3. Preparar um prato ou bebida (suco ou chá) usando ervas.
4. Usando ervas conhecidas da sua região, fazer 2 dos produtos a seguir:
  a) Creme
  b) Almofada ou travesseiro .com enchimento de ervas)
  c) Sabonete
  d) Papel
  e) Vela decorativa
  f) Sachê
5. Fazer um pote decorativo com mistura de ervas secas.
6. Fazer uma caixa com substâncias aromáticas.
7. Citar e identificar 5 ervas silvestres que crescem na região que você mora.
8. Citar 5 ervas que podem ser usadas como tintura e mencionar a cor que produzem.
9. Citar 5 ervas que podem ser usadas no controle de insetos.
10. Cultivar 5 ervas culinárias durante, pelo menos, 3 meses.
11. Citar 5 ervas que atraem abelhas.
12. Citar 5 ervas mencionadas na Bíblia. Mencionar os textos bíblicos onde podem ser encontradas e quais as finalidades de seu uso.'),
('EN-039', 'Eucaliptos', 'estudos-da-natureza', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/en-039.webp', 'https://mda.wiki.br/Especialidade_de_Eucaliptos', '1. Quantas espécies diferentes de eucaliptos existem em seu país?
2. Qual a origem do nome eucalipto?
3. Os eucaliptos pertencem a que família?
4. Em que partes do mundo os eucaliptos podem ser encontrados? Em quais dos países listados eles são considerados plantas nativas?
5. Responder o seguinte:
  a) Qual país tem as angiospermas mais altas?
  b) Onde elas crescem?
  c) Que altura elas alcançam?
6. Como os eucaliptos estão adaptados a:
  a) Frequentes incêndios florestais?
  b) Regiões áridas?
7. Responder o seguinte, com relação à extração de óleo:
  a) De que espécies se extraem óleos de eucalipto?
  b) Existe extração de óleo em seu país? Que espécie é utilizada? Onde esse processo é realizado em seu país?
  c) Que finalidades os óleos de eucalipto possuem?
8. Que utilidades o eucalipto possui para o homem? Além de seu uso, que outros benefícios ele pode trazer ao homem e ao meio ambiente?
9. Fazer um dos seguintes:
  a) Coletar, prensar e identificar ramos de 5 espécies diferentes de eucaliptos. Anotar quaisquer características importantes para a identificação e ser capaz de identificar outros indivíduos das espécies coletadas.
  b) Desenhar ou fotografar 10 espécies diferentes de eucaliptos, mostrando os ramos e outras características importantes para a identificação e ser capaz de identificar outros indivíduos das espécies retratadas.'),
('EN-040', 'Sementes', 'estudos-da-natureza', 'especialidade', 1, 1961, 'Associação Geral', '/esp/en-040.webp', 'https://mda.wiki.br/Especialidade_de_Sementes', '1. Qual o principal objetivo de uma semente?
2. Que alimentos foram os primeiros a serem dados ao ser humano no Jardim do Éden?
3. A partir de uma semente ou desenho, identificar e saber o propósito dos seguintes: tegumento, cotilédone e embrião (germe).
4. Conhecer 4 diferentes métodos pelos quais as sementes são dispersadas pelas plantas. Mencionar exemplos de plantas que espalham suas sementes por cada método.
5. Citar:
  a) 10 tipos de sementes que usamos como alimento;
  b) 5 tipos de sementes que são usadas como fonte de óleo;
  c) 5 tipos de sementes que são usadas como condimentos.
6. Quais as condições para que uma planta germine?
7. Fazer uma coleção de 25 diferentes tipos de sementes, 15 das quais tenham sido encontradas por você mesmo. Identificar cada uma com o nome, data e local em que foi encontrada, e nome da pessoa que a encontrou.
8. Plantar uma semente de feijão, milho e soja. Fazer uma análise do tempo que demorou para cada uma delas germinar. Fazer um relatório diário do que ocorreu com a planta e observar as diferenças entre o feijão e o milho.'),
('EN-041', 'Sementes - avançado', 'estudos-da-natureza', 'especialidade', 1, 1961, 'Associação Geral', '/esp/en-041.webp', 'https://mda.wiki.br/Especialidade_de_Sementes_-_avançado', '1. Ter a especialidade Sementes.
2. Identificar, a partir de desenhos, e conhecer o propósito de cada uma das seguintes partes de uma semente: endosperma, radícula, gêmula, micrópila.
3. Explicar o seguinte:
  a) As diferenças entre a semente monocotiledônea e a dicotiledônea;
  b) A diferença entre uma semente e um esporo?
4. Com as sementes da sua própria coleção, demonstrar as semelhanças entre sementes de plantas da mesmas família.
5. Adicionar à sua coleção 15 tipos de sementes. Classificar cada uma delas com o nome, data e local em que foi encontrada, e nome da pessoa que a encontrou.
6. Escrever ou apresentar oralmente, 2 lições que podemos aprender das sementes. Você poderá encontrar as informações que procura no livro Parábolas de Jesus, pág. 33 a 89.
7. Explicar os propósitos e utilidades de um aparato para testar as sementes. Testar a germinação de 100 sementes de uma planta silvestre, e 100 sementes de uma planta doméstica. Relatar os resultados de cada teste.'),
('EN-042', 'Orquídeas', 'estudos-da-natureza', 'especialidade', 1, 1964, 'Associação Geral', '/esp/en-042.webp', 'https://mda.wiki.br/Especialidade_de_Orquídeas', '1. Definir as características de uma orquídea.
2. Quais são os 2 principais grupos de orquídeas? Dar o nome e mostrar exemplos de cada, a partir das próprias plantas ou de fotografias.
3. Quais as diferenças entre as orquídeas epífitas, rupícolas, terrestres e humícolas? Citar exemplos.
4. Discorrer sobre a distribuição de orquídeas. Qual a sua origem? Fazer uma referência especial às espécies comuns em sua região.
5. Citar o principal gênero de orquídeas cultivadas. Identificar 3 espécies pessoalmente ou fotografias.
6. Quais as principais utilidades das orquídeas? Que orquídea é mais popular comercialmente falando?
7. Discutir os seguintes pontos a serem observados no cultivo de orquídeas:
  a) Luz
  b) Temperatura
  c) Umidade
  d) Nutrientes
  e) Ventilação
  f) Vasos e substratos
8. Cultivar uma orquídea durante, no mínimo, 1 mês.
9. Identificar, por meio de imagens, fotos ou pessoalmente, 10 espécies de orquídeas.'),
('EN-043', 'Plantas Silvestres Comestíveis', 'estudos-da-natureza', 'especialidade', 2, 1970, 'Associação Geral', '/esp/en-043.webp', 'https://mda.wiki.br/Especialidade_de_Plantas_Silvestres_Comestíveis', '1. Fotografar, desenhar ou identificar pessoalmente, no mínimo, 15 plantas silvestres comestíveis. Informar o hábito (erva, trepadeira, arbusto ou árvore) e as partes comestíveis de cada uma das plantas.
2. Cumprir os itens a seguir:
  a) Explicar a importância de não se comer cogumelos silvestres
  b) Qual raiz de planta pode ser seca e moída para se fazer farinha?
  c) Conhecer, pelo menos, 3 famílias de plantas que tem plantas venenosas ou duvidosas
  d) Qual é a principal regra para determinar se uma planta é comestível?
  e) Citar 15 Plantas Alimentícias Não Convencionais (PANCs) que são comuns para cultivar em casa.
3. Identificar, preparar e comer 5 tipos de frutas silvestres, 3 tipos de bebidas, 3 plantas de saladas, 3 ervas e 2 raízes ou tubérculos.
4. Preparar um alimento que tenha, como ingredientes, uma planta silvestre comestível típica da sua região.
5. Demonstrar a preparação de alimentos silvestres em cada uma das maneiras a seguir:
  a) Ferver
  b) Tostar
  c) Fritar
  d) Assar
6. Elaborar um manual com fotos das plantas utilizadas para o cumprimento dos requisitos anteriores, acrescentando as seguintes informações para cada uma delas:
  a) Nome pela qual é conhecida na região e, se possível, o nome científico.
  b) Hábito(árvore, arbusto, erva, trepadeira, etc.)
  c) Partes comestíveis
  d) Onde é encontrada (habitat)
  e) Tipo de toxinas
  f) Valores medicinais
  g) Outras utilidades, fora a alimentação
  h) Receitas que possam ser feitas com essa planta'),
('EN-044', 'Ecologia', 'estudos-da-natureza', 'especialidade', 2, 1972, 'Associação Geral', '/esp/en-044.webp', 'https://mda.wiki.br/Especialidade_de_Ecologia', '1. Saber o significado dos seguintes termos:
  a) Ecologia
  b) Plâncton
  c) Populações
  d) Comunidade
  e) Ecossistemas
  f) Conservação
  g) Cadeia alimentar
  h) Comunidade Clímax
  i) Comensalismo
  j) Autotrofismo
  k) Sucessão Ecológica
  l) Bioma
  m) Habitat
2. O que é uma pirâmide ecológica? Por que ela tem esse formato? Escolher um mamífero, um pássaro, um réptil e um anfíbio comuns na região em que você mora e construir para cada um deles um diagrama de sua pirâmide ecológica.
3. Definir o que é ecossistema. Falar sobre os fatores biológicos e físicos que o mantém equilibrado.
4. Utilizando-se de fotografias ou figuras, elaborar um cartaz ou quadro formando um diagrama ilustrando um ecossistema de um pequeno lago de água doce.
5. Pesquisar sobre como se faz a coleta de lixo em seu bairro e qual o destino do lixo coletado. Elaborar um relatório com as informações de quanto lixo sua família joga por dia e como poderiam lidar melhor com isto.
6. Pesquisar nos jornais ou em algum site especializado, por uma semana, os níveis de poluição atmosférica de uma cidade grande (a mais perto da sua, se você não morar numa cidade grande). Fazer um gráfico demonstrando a curva deste nível durante semana. Descobrir o que causa os pontos altos de sua curva do gráfico.
7. Relacionar 10 maneiras de trabalhar ativamente em favor do meio ambiente de sua comunidade e cidade. Colocar 4 delas em prática.
8. Pesquisar um texto do Espírito de Profecia e um texto bíblico relacionado à ecologia. Apresentar uma explicação sobre sua relevância e aplicação aos nossos dias.'),
('EN-045', 'Ecologia - avançado', 'estudos-da-natureza', 'especialidade', 3, 1972, 'Divisão do Sul do Pacífico', '/esp/en-045.webp', 'https://mda.wiki.br/Especialidade_de_Ecologia_-_avançado', '1. Ter a especialidade de Ecologia.
2. Definir os seguintes termos:
  a) Matéria-prima;
  b) Fotossíntese;
  c) Quimiossíntese;
  d) Autotrófico;
  e) Heterotrófico;
  f) Equilíbrio ecológico;
  g) Saprófagos;
  h) Decompositores;
  i) Produtor;
  j) Consumidor;
  k) Fator limitante.
3. Explicar o que são níveis tróficos e dar exemplos de organismos para cada nível.
4. Citar a primeira e a segunda leis da termodinâmica e explicar como são importantes para a ecologia.
5. Apresentar um diagrama que contenha os passos básicos do fluxo de energia através do sistema biótico de um ecossistema. Começar o diagrama pelo sol.
6. Elaborar um diagrama dos três tipos de pirâmides ecológicas existentes na rede alimentar. Apresentar, pelo menos, um exemplo em cada camada da pirâmide.
7. Explicar o que são os ciclos bioquímicos e fazer um diagrama sobre todos os componentes básicos do ciclo.
8. Cumprir um dos itens abaixo:
  a) Escolher uma comunidade biológica de sua região como, por exemplo, uma floresta ou bosque, pântano, lago ou açude, pasto ou campo, desfiladeiro ou riacho, etc, que esteja de alguma forma alterado ecologicamente. Descrever o local, incluindo como se deu e até que ponto o equilíbrio foi alterado. Depois, apresentar recomendações sobre como aquela comunidade pode ser melhorada e direcionar seus esforços para o acompanhamento e ajuda no trabalho de melhoria;
  b) Participar ativamente em um projeto ecológico. Isto pode ser feito individualmente ou em grupo. Elaborar um esboço do projeto e seus objetivos, bem como relatar detalhadamente a parte que você desempenhou no mesmo.
9. Encontrar um trecho do Espírito de Profecia e um texto bíblico, diferentes dos utilizados na especialidade Ecologia, relacionados à ecologia e explicar sua relevância e aplicação aos nossos dias.'),
('EN-046', 'Conservação Ambiental', 'estudos-da-natureza', 'especialidade', 3, 1973, 'Associação Geral', '/esp/en-046.webp', 'https://mda.wiki.br/Especialidade_de_Conservação_Ambiental', '1. Explicar a diferença entre ecologia e conservação ambiental.
2. Escrever uma redação com, no mínimo, 500 palavras com o tema: O aumento da população humana e como isso é uma ameaça à sua própria existência na Terra.
3. O que significa o termo "morte" de um lago ou rio? Há algum lago ou rio em sua região ou cidade que é classificado como "morto"?
4. Realizar um estudo num pequeno riacho ou corpo hídrico que passe dentro ou perto de sua cidade. Apresentar um relatório de, no mínimo, 300 palavras sobre sua observação nos seguintes itens:
  • Sinais de pureza
    1. Abundância de pequenos peixes
    2. Água visivelmente clara e com odor agradável
    3. Margens do riacho, ou corpo hídrico, cobertas de vegetação até perto da água
    4. Pequenas quantidades de microalgas verdes na água
    5. Existência de algumas plantas aquáticas como a taboa, erva do campo ou pontedéria
    6. Existência de animais aquáticos (como lagostins sob as pedras, tartarugas, etc)
    7. Crescimento de ervas daninhas na areia das margens, indicando um nível de água relativamente estável
  • Sinais de deterioração e morte
    1. Presença de grandes massas de microalga azul-verde
    2. Margens marcadas por nível de água durante as chuvas
    3. Água com odor pútrido
    4. Presença de espuma de detergentes/agentes químicos
    5. Lixo nas margens e dentro da água, perto das margens
    6. Água repleta de sedimentos
    7. Ausência de insetos aquáticos e peixes
    8. Presença de esgoto
    9. Presença de óleo na superfície da água
    10. Resíduos jogados nas águas do riacho ou corpo hídrico por depósitos ou fábricas
5. Após a investigação do requisito anterior, realizar um dos itens abaixo:
  a) Se o riacho ou corpo hídrico demonstrar sinais de pureza, descrever quais são as medidas que devem ser tomadas para a sua preservação
  b) Se o riacho ou corpo hídrico demonstrar sinais de deterioração, fazer, pelo menos, 2 dos itens abaixo:
    • Realizar um projeto comunitário para despoluí-lo
    • Em grupo, recolher o lixo das margens do riacho ou corpo hídrico
    • Conseguir o fornecimento de caminhões ou pick-ups para ajudar na despoluição
    • Descobrir qual a posição e projetos que sua prefeitura/administração tem para despoluir este local e cobrar as providências
6. Realizar um dos itens abaixo:
  a) Visitar uma usina ou aterro sanitário. Nesta visita, realizar os itens abaixo:
    • Desenhar um diagrama detalhado do que acontece ao lixo líquido e sólido, do momento em que entram na usina até saírem.
    • Em que estado sai o lixo desta usina?
    • Há qualquer outra utilidade para este lixo?
  b) Visitar um depósito de lixo e ver como o lixo é tratado. Descobrir:
    • Quantas toneladas de lixo são jogadas diariamente
    • Que tentativas são feitas para se reciclar parte desse lixo
    • Parte do lixo é queimada ou é todo enterrado?
    • O que acontece com os carros abandonados que não servem mais para nada em sua região
  c) Visitar uma usina de purificação de água:
    • Construir um diagrama dos passos para purificação da água, do momento em que entra na usina até sair para ser distribuído em residências e estabelecimentos comerciais.
    • Descobrir como você e sua comunidade podem preservar a reduzir o consumo de água.
    • Fazer uma campanha com seu Clube/unidade para evitar o desperdício de água.
    • Ter a especialidade de Reciclagem e Reciclagem - avançado'),
('EN-047', 'Geologia', 'estudos-da-natureza', 'especialidade', 1, 1975, 'Associação Geral', '/esp/en-047.webp', 'https://mda.wiki.br/Especialidade_de_Geologia', '1. Apresentar o significado geológico dos seguintes termos:
  a) Litologia
  b) Camada
  c) Dobra
  d) Falha
  e) Delta
  f) Rio meandrante
  g) Rio entrelaçado
  h) Rio retilíneo
  i) Rio anastomosado
  j) Morena
  k) Leque aluvial
  l) Anticlinal
  m) Sinclinal
  n) Antiforme
  o) Sinforme
  p) Capa ou teto
  q) Lapa ou muro
  r) Falha transcorrente
  s) Falha transformante
  t) Falha normal
  u) Falha reversa
  v) Falha de empurrão
2. Descrever:
  a) Como uma geleira se move e quais evidências deixa em seu rastro.
  b) Por que as margens de um rio ou riacho frequentemente ficam mais cavadas do lado de fora de uma curva.
  c) Como se forma uma cordilheira.
3. Saber em que grupo de rochas (sedimentar, metamórfica ou ígnea) as seguintes rochas estão classificadas:
  a) Granito
  b) Mármore
  c) Arenito
  d) Conglomerado
  e) Basalto
  f) Ardósia
  g) Xisto
  h) Argilito
  i) Gnaisse
  j) Quartzito
4. Tirar uma fotografia ou desenhar cada uma das características geológicas a seguir:
  a) Marcas de ondulação na areia ou lama (Se possível, mostrar com uma seta a direção da corrente)
  b) Erosão
  c) Gretas de ressecamento (estas geralmente são encontradas após uma forte chuva ou alagamento, quando a lama começa a secar)
  d) Perfil do solo ao longo das margens de um rio ou de uma estrada (perceba como o solo varia a cor e a granulometria em cada uma das camadas)
  e) Banco de areia (os mesmos geralmente podem ser encontrados ao longo de riachos, rios ou do mar)
  f) Dolina
  g) Falha com deslocamento das litologias'),
('EN-048', 'Geologia - avançado', 'estudos-da-natureza', 'especialidade', null, null, 'Nota: Esta especialidade não faz mais parte do manual de especialidades da Divisão Sul-Americana, pois foi revisada como obsoleta, ou foi substituída, ou não está dentro da realidade dos desbravadores de nossa divisão.Especialidade descontinuada em 2025', '/esp/en-048.webp', 'https://mda.wiki.br/Especialidade_de_Geologia_-_avançado', '1. Ter a especialidade de Geologia.
2. Providenciar as seguintes informações:
  a) De que forma os terremotos revelam como é o interior da terra? Citar e explicar as características dos diferentes tipos de ondas que causam os terremotos.
  b) Os efeitos de uma quantidade muito grande de água (como o Dilúvio do tempo de Noé) em poucos meses, comparados aos efeitos de pouca água em milhares e milhões de anos.
  c) Por que se têm evidências de geleiras em zonas de clima temperado, onde não existem geleiras atualmente?
  d) Como os criacionistas que acreditam num dilúvio universal e numa idade relativamente jovem da terra, desde a criação, compreendem e usam o quadro de tempo geológico?
  e) Qual é a teoria da deriva continental (placa tectônica) e como os criacionistas podem inserir tal atividade geológica no tempo desde a criação?
3. Em que lugar do mundo você provavelmente poderia ver:
  a) Grandes ge eiras
  b) Vulcões ativos
  c) Dunas de areia
  d) Mineralização de diamante
  e) Fossas oceânicas
4. Escrever um trabalho de, pelo menos, 500 palavras sobre um aspecto geológico interessante que você tenha observado numa viagem recente. Se possível, descreva a rocha (cor, granulometria, textura, estrutura). Caso seja um perfil litológico, desenhá-lo com escala.'),
('EN-049', 'Plantas Caseiras', 'estudos-da-natureza', 'especialidade', 2, 1976, 'Associação Geral', '/esp/en-049.webp', 'https://mda.wiki.br/Especialidade_de_Plantas_Caseiras', '1. O que caracteriza uma planta como ornamental?
2. Citar:
  a) 5 plantas ornamentais cultivadas por causa de sua folhagem.
  b) 5 plantas ornamentais cultivadas por causa de suas flores.
  c) 5 plantas cultivadas por causa do seu aroma.
  d) 5 trepadeiras ornamentais
3. Dar o nome de 3 plantas caseiras adaptadas:
  a) À luz direta do sol
  b) Solo seco
  c) Solo muito úmido
4. Qual a importância da umidade para as plantas?
5. Responder o seguinte:
  a) A maioria das plantas caseiras se dá bem em temperaturas de 18 a 22 graus. Citar uma que exige ambiente mais frio (7 a 13 graus).
  b) De quanta luminosidade uma violeta precisa? Que lugar da casa é o melhor para cultivá-la?
  c) Todos os gerânios precisam aproximadamente das mesmas condições de crescimento. De onde eles vieram originalmente? Que tipo de temperatura, luz e umidade eles precisam?
6. Preparar uma mistura de solo incluindo, pelo menos, 3 ingredientes diferentes. Selecionar 2 plantas caseiras e cultivá-las neste solo durante o mínimo 2 meses.
7. Mencionar 2 plantas caseiras que podem ser propagadas a partir de folhas, ramos ou divisões. Germinar uma planta usando um desses métodos e continuar a cuidar de seu crescimento por, pelo menos, 2 meses.
8. Cultivar, pelo menos, 5 das plantas a seguir:
  a) Açafrão
  b) Begônia
  c) Antúrio
  d) Aspidistra
  e) Avenca
  f) Caládio
  g) Cóleo
  h) Fícus
  i) Filodendro
  j) Gerânio
  k) Gloxínia
  l) Íris
  m) Jacinto
  n) Melindro
  o) Narciso
  p) Planta alumínio
  q) Samambaia
  r) Sanseviéria
  s) Trepadeiras
  t) Tulipa
  u) Violeta
  v) Uma flor à sua escolha
  w) Uma folhagem à sua escolha'),
('EN-050', 'Rastreio de Animais', 'estudos-da-natureza', 'especialidade', 2, 1976, 'Associação Geral', '/esp/en-050.webp', 'https://mda.wiki.br/Especialidade_de_Rastreio_de_Animais', '1. Citar, pelo menos, 3 coisas que os rastros de animais nos dizem.
2. Identificar, pelo menos, 4 sinais da presença de mamíferos.
3. Saber distinguir entre pegadas de canídeos, felídeos e outros carnívoros comuns em sua região.
4. Relacionar, pelo menos, 2 grupos de animais (mamíferos, aves, insetos, etc) que deixam odores pela trilha que fazem para que outros da mesma espécie possam seguir.
5. Além das pegadas, mencionar 2 outros sinais da presença de Aves.
6. Saber identificar, pelo menos, 10 tipos de pegadas de animais, incluindo 2 de aves. Fazer, pelo menos, 3 moldes em alto relevo em gesso da pegada de diferentes animais.
7. Observar rastros, trilhas ou pegadas de 1 ou mais dos seguintes animais:
  a) Sapo ou rã
  b) Cobra
  c) Tartaruga, cágado ou jabuti
  d) Molusco
  e) Minhoca
  f) Roedores'),
('EN-051', 'Mamíferos Marinhos', 'estudos-da-natureza', 'especialidade', 2, 1991, 'Associação Geral', '/esp/en-051.webp', 'https://mda.wiki.br/Especialidade_de_Mamíferos_Marinhos', '1. Mencionar, pelo menos, 3 ordens de mamíferos marinhos, dando exemplos de cada uma.
2. Citar algumas características que diferenciam os mamíferos marinhos dos demais mamíferos tradicionais que conhecemos.
3. Identificar, através de fotografias ou desenhos, pelo menos, uma espécie de cada um dos seguintes mamíferos marinhos, contendo sua localização (região onde vive) e nome científico de cada animal:
  a) Baleia
  b) Golfinho
  c) Foca
  d) Peixe-Boi
4. Qual o maior mamífero do mar? Descrever suas características naturais de acordo com os seguintes termos:
  a) Onde está localizado
  b) Medida e Peso
  c) Alimentação
5. Explicar as seguintes expressões:
  a) Salto
  b) Ecolocalização
  c) Cardume
  d) Barbatanas
  e) Harém
  f) Plâncton
6. Desenhar a cadeia alimentar de 2 mamíferos marinhos diferentes de sua escolha.
7. Qual a principal importância da gordura para os cetáceos?
8. Saber 2 motivos pelos quais as focas ainda são caçadas.
9. Explicar porque as focas e golfinhos se movem tão rapidamente na água.
10. Escolher uma das tarefas a seguir:
  a) Visitar um aquário de sua região. Observar e descrever a alimentação diária de um dos mamíferos marinhos existentes naquele local;
  b) Fazer um relatório de, no mínimo, 300 palavras falando de um mamífero marinho de sua escolha.'),
('EN-052', 'Pequenos Mamíferos de Estimação', 'estudos-da-natureza', 'especialidade', 2, 1997, 'Associação Geral', '/esp/en-052.webp', 'https://mda.wiki.br/Especialidade_de_Pequenos_Mamíferos_de_Estimação', '1. Completar uma das seguintes tarefas:
  a) Cuidar de um pequeno mamífero de estimação por, pelo menos, 1 mês. (Cães e gatos não estão incluídos). Antes da compra do animal, pesquisar o seguinte: país de origem, hábitos alimentares (variedades, frequência, quantidade), necessidade de vacinas, doenças mais comuns (que sofre e que pode transmitir ao homem), preço de mercado, necessidade de espaço, necessidade de atenção diária, clínica veterinária especializada mais próxima e estimativa de tempo de vida. Ao final do período, fazer um relatório dos cuidados com seu pequeno animal. Incluir tópicos como alimentos favoritos, sua história preferida sobre o animal, alguns de seus hábitos, horários em que é mais ativo, etc.
  b) Se você não possui um pequeno mamífero de estimação, mas já teve um no passado, cuidar do animalzinho de alguém durante, pelo menos, uma semana. Fazer um relatório dos cuidados com os horários de dar água, comida, limpar a gaiola, etc. Incluir em seu relatório um tópico comparando esse animal emprestado ou que criou no passado em termos de horários de maior atividade, espécie e hábitos gerais.
2. Completar o seguinte
  a) Ser capaz de distinguir entre os seguintes (grupos) de pequenos animais de estimação:
    • Hamster
    • Furão
    • Gerbo
    • Porquinho da índia
    • Chinchila
    • Esquilo-da-mongólia
    • Coelho
  b) Descrever os cuidados básicos para 2 dos animais da lista acima e listar as semelhanças e diferenças de cuidado entre eles.
  c) Quais dos animais listados não são roedores?
3. Por que não se deve adotar pequenos mamíferos encontrados na natureza como animais de estimação?
4. Escrever uma redação de 250 palavras sobre a história e importância de um dos animais listados no requisito 2 e que características eles têm que os tornam bons animais de estimação.
5. Encontrar 3 referências bíblicas de animais que agora consideramos pequenos mamíferos de estimação. De acordo com a Bíblia, são considerados animais limpos ou imundos?'),
('EN-053', 'Cactos - avançado', 'estudos-da-natureza', 'especialidade', 3, 1999, 'Associação Geral', '/esp/en-053.webp', 'https://mda.wiki.br/Especialidade_de_Cactos_-_avançado', '1. O que são suculentas?
2. Identificar ao natural ou por fotografia cinco suculentas que não sejam cactos. Como elas se diferenciam dos cactos?
3. Explicar os seguintes termos referentes aos cactos/suculentas:
  a) Aréola ou auréola
  b) Cefálio
  c) Cochonilha
  d) Corimbo
  e) Diurno
  f) Epífita
  g) Estolão ou Estolho
  h) Gloquídeo
  i) Noturno
  j) Panícula
  k) Ramo
  l) Zigomórfica
4. Quando as suculentas (incluindo os cactos) crescem, elas podem ser atacadas por doenças. Quais são as mais comuns e como você pode prevenir ou curar os problemas?
5. Propagar, pelo menos, uma planta usando um dos seguintes métodos:
  a) A partir de sementes
  b) Por estacas
  c) Por enxertia'),
('EN-054', 'Anfíbios - avançado', 'estudos-da-natureza', 'especialidade', 3, 2001, 'Associação Geral', '/esp/en-054.webp', 'https://mda.wiki.br/Especialidade_de_Anfíbios_-_avançado', '1. Ter a especialidade de Anfíbios.
2. Como é chamado o estudo dos Anfíbios?
3. Qual a diferença entre animais peçonhentos e animais venenosos? Os anfíbios podem ser classificados em qual desses grupos? Todos os anfíbios possuem toxinas?
4. Realizar uma pesquisa simples com base na observação natural ou em cativeiro de um ou mais anfíbios selecionados e uma redação de, no mínimo, 500 palavras com os resultados da sua observação.'),
('EN-055', 'Felinos - avançado', 'estudos-da-natureza', 'especialidade', 2, 2001, 'Associação Geral', '/esp/en-055.webp', 'https://mda.wiki.br/Especialidade_de_Felinos_-_avançado', '1. Ter a especialidade de Felinos.
2. Qual o nome científico do gato doméstico?
3. Manter um gato por, pelo menos, 3 meses e fazer uma das seguintes opções:
  a) Se você tem um gato atualmente, mantenha um registro dos cuidados com o seu gato por 1 mês. Incluir em seus registros quando você o hidrata e alimenta e com que frequência e com que suprimentos você cuida da caixa de areia. Por que não se deve permitir que seu gato circule livremente pela vizinhança?
  b) Se você não tem um gato atualmente, mas já teve um no passado por, pelo menos, 3 meses, cuidar do gato de alguém por, pelo menos, 1 semana. Registrar o cuidado que foi necessário e explicar a relação de gatos domésticos com o ambiente e porque é melhor não permitir que se tornem selvagens.
  c) Participar em um projeto de sua escolha relacionado a gatos em prol de uma sociedade humanitária ou organização similar.
4. Quais são as principais doenças dos gatos e quais são facilmente transmissíveis ao homem? Como podemos evitá-las?
5. Em comparação com o cão, o que podemos esperar de um gato, como animal de estimação, com relação ao seu comportamento?
6. Identificar, a partir de fotografias/ilustrações, ou ao natural, 8 raças de gatos domésticos. Descrever o temperamento de cada um.
7. Dar o nome popular de 4 felinos comuns em sua região ou País.
8. Discorrer sobre as principais causas para o declínio mundial da população de felinos. Citar 3 espécies que correm risco de extinção, preferencialmente de sua região, e quais razões os colocam nessa condição.'),
('EN-056', 'Rastreio de Animais - avançado', 'estudos-da-natureza', 'especialidade', 2, 2001, 'Associação Geral', '/esp/en-056.webp', 'https://mda.wiki.br/Especialidade_de_Rastreio_de_Animais_-_avançado', '1. Ter a especialidade de Rastreio de animais.
2. Citar, pelo menos, 2 animais para cada grupo:
  a) Com pés chatos;
  b) Que andam na ponta dos pés;
  c) Que andam na ponta dos dedos;
  d) Com unhas ou garras.
3. Citar, pelo menos, 2 pássaros que, pelos seus rastros, eles:
  a) Saltam;
  b) Andam.
4. Qual a diferença entre um molde em alto revelo e em baixo relevo de um rastro de animal?
5. Fazer, pelo menos, 1 molde em baixo relevo a partir de um em alto relevo ou de um molde de borracha.
6. O que é coprologia e por que isto é importante no estudo de animais?
7. Através de cuidadosa observação e análise, encontrar o maior número possível de evidências da passagem de 1 ou mais animais por uma trilha.
8. Seguir a trilha deixada por um animal. Se possível, identificar o animal, dizer se estava correndo ou andando.
9. Montar e manter uma área de rastreamento por, pelo menos, 3 dias, observando o seguinte:
  a) Selecionar um local aberto em um lugar tranquilo perto do seu acampamento, casa ou área rural;
  b) Alisar o chão, deixando-o propício a registrar as marcas dos animais que passarem por ali;
  c) Colocar comida para animais selvagens;
  d) Verificar diariamente se o local foi visitado e repor os alimentos, se necessário.'),
('EN-057', 'Répteis - avançado', 'estudos-da-natureza', 'especialidade', 3, 2001, 'Associação Geral', '/esp/en-057.webp', 'https://mda.wiki.br/Especialidade_de_Répteis_-_avançado', '1. Ter a especialidade de Répteis.
2. Como é chamado o estudo dos Répteis?
3. Como os répteis se protegem?
4. Quais são os dois principais tipos de peçonha de répteis e como eles afetam sua presa ou inimigo?
5. Identificar na natureza pelo menos oito répteis de espécies diferentes.
6. Completar uma das tarefas a seguir:
  a) Comparar lagartos, cobras, tartarugas e crocodilos quanto ao modo de vida, variações nos olhos e orelhas, dentes, coração, pulmões, membros, rabo e escamas;
  b) Encontrar um réptil na natureza e registrar as observações das suas atividades durante as horas do dia de um ou mais dias;
  c) Manter um pequeno réptil num terrário e fazer um relatório dos seus cuidados durante, pelo menos, um mês.'),
('EN-058', 'Animais Ameaçados de Extinção', 'estudos-da-natureza', 'especialidade', 2, 2004, 'Divisão Norte Americana', '/esp/en-058.webp', 'https://mda.wiki.br/Especialidade_de_Animais_Ameaçados_de_Extinção', '1. Definir os seguintes termos:
  a) Habitat;
  b) Bioma;
  c) Cadeia alimentar;
  d) Caçador ilegal.
2. Qual é a lista de espécies ameaçadas mundialmente mais conhecida? Descrever as categorias existentes nesta lista e citar uma espécie para cada categoria.
3. Listar quatro fatores que fazem os animais se tornarem ameaçados de extinção.
4. Dar o nome de quatro animais que estão extintos agora, preferencialmente espécies do seu estado ou país.
5. Listar quatro coisas que estão sendo feitas para salvar animais ameaçados de extinção em seu país. Caso seu país não esteja fazendo pelo menos quatro coisas para salvar espécies ameaçadas, pesquisar medidas adotadas em países próximos e que poderiam ser adotadas no seu país.
6. Listar quatro atividades que você pode fazer para ajudar animais silvestres.
7. Listar 10 espécies de animais ameaçados, sendo no mínimo quatro do seu estado ou país. Dizer onde eles vivem, por que se tornaram ameaçados de extinção e o que você pode fazer para ajudá-los.
8. Fazer duas das seguintes atividades:
  a) Visitar um zoológico que tenha um ou mais animais ameaçados residentes no local. Listar que animais você viu, onde eles vivem normalmente e por que eles se tornaram ameaçados de extinção;
  b) Assistir a um vídeo sobre um animal ameaçado de extinção. Listar qual animal ou quais animais você viu, onde eles normalmente vivem e por que ele se tornou ameaçado de extinção;
  c) Escolher um animal ameaçado de extinção e escrever ou apresentar oralmente um curto relatório sobre o assunto. Dizer onde ele vive normalmente, por que se tornou ameaçado de extinção, o que está sendo feito para salvá-lo e qualquer outro detalhe especial que você aprendeu sobre este animal em particular;
  d) Fazer um álbum de recortes sobre animais ameaçados de extinção. Isso pode incluir artigos de jornais, histórias, fotos, selos ou desenhos. Este pode ser um projeto em grupo;
  e) Fazer uma teia da vida, ou outra dinâmica de grupo sobre ecossistemas.
9. Conhecer as principais leis relacionadas às espécies ameaçadas de extinção em seu país. Essas leis podem ser encontradas na seção de legislação dos sites da Presidência da República e do Ministériodo Meio Ambiente.
10. Explicar Gênesis 1:26-28 e Gênesis 2:15 com suas próprias palavras.'),
('EN-059', 'Morcegos', 'estudos-da-natureza', 'especialidade', 1, 2004, 'Divisão Norte Americana', '/esp/en-059.webp', 'https://mda.wiki.br/Especialidade_de_Morcegos', '1. Por que os morcegos são classificados como mamíferos e não como aves?
2. Qual é a principal característica que separa os morcegos dos outros mamíferos?
3. Qual o nome da ordem a qual os morcegos pertencem e o que significa?
4. Qual é o sexto sentido dos morcegos e como ele funciona?
5. Quais são o maior e o menor morcego e onde eles vivem?
6. Quantas espécies diferentes de morcego existem no mundo? E no seu país?
7. Os morcegos são divididos em duas subordens. Quais são os seus nomes?
8. Qual subordem dos morcegos usa ecolocalização e qual usa a visão para encontrar seu alimento? Qual a dieta comum de cada subordem?
9. Quantos filhotes um morcego tem por ano e qual o período médio de gestação?
10. Encontrar três textos bíblicos que mencionam morcegos. Qual texto usa morcegos em uma profecia do tempo do fim?
11. Os morcegos hibernam ou migram no inverno?
12. Dar o nome das partes de um morcego.
13. Quantos insetos um micromorcego pode comer em uma hora?
14. Quais são os três principais benefícios que os morcegos proporcionam para o homem?
15. Saber o que é uma casa (ou caixa) de morcegos e qual a sua importância.
16. O que fazer se for mordido por um morcego?'),
('EN-060', 'Morcegos - avançado', 'estudos-da-natureza', 'especialidade', 2, 2004, 'Divisão Norte Americana', '/esp/en-060.webp', 'https://mda.wiki.br/Especialidade_de_Morcegos_-_avançado', '1. Ter a especialidade de Morcegos.
2. Como são chamadas as cavernas, sótãos, pontes ou túneis onde os morcegos hibernam?
3. Quais as duas formas de organização social encontradas em morcegos?
4. O que significa “implantação atrasada”?
5. Quanto tempo é o período de gestação de morcegos?
6. O que é guano? Que utilidades o guano possui?
7. Que doença pode ser contraída a partir de grandes quantidades de guano? Como ela pode ser evitada?
8. Qual é o tempo de vida de um morcego?
9. Todos os morcegos têm raiva? Como evitar ser infectado por morcegos?
10. Quão boa é a visão de microchiroptera e megachiroptera?
11. Que tecnologias foram desenvolvidas a partir da ecolocalização dos morcegos?'),
('EN-061', 'Marsupiais', 'estudos-da-natureza', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/en-061.webp', 'https://mda.wiki.br/Especialidade_de_Marsupiais', '1. O que são marsupiais? Quais as diferenças entre eles e os outros mamíferos?
2. Distinguir entre os mamíferos: placentários, marsupiais e monotremados.
3. Explicar a diferença entre a reprodução dos monotremados, dos marsupiais e dos mamíferos verdadeiros (ou seja, placentários).
4. Descrever a distribuição, habitat, dieta, comportamento reprodutivo, assim como quaisquer outras informações interessantes de uma espécie de cada uma das sete ordens de marsupiais e das duas de monotremados.
5. Descrever a distribuição, habitat, dieta, comportamento reprodutivo, assim como quaisquer outras informações interessantes de quatro espécies que ocorram em seu país.
6. Dizer por que os marsupiais são considerados tão importantes na Austrália.
7. Fazer um dos seguintes:
  a) Observar um marsupial (ou um grupo de marsupiais) em seu habitat natural. Escrever um relatório de no mínimo 100 palavras, sobre as suas observações.
  b) Visitar um museu de história natural, zoológico, etc. Escrever um relatório de no mínimo 100 palavras, sobre os marsupiais que foram observados.
  c) Falar por pelo menos três minutos para um grupo de pessoas sobre marsupiais ou um marsupial em particular.
  d) Guiar (ou ajudar a guiar) um grupo de desbravadores em uma visita a um museu ou zoológico onde existam marsupiais.
8. Explicar a necessidade de proteger os marsupiais de seu país.'),
('EN-062', 'Orquídeas - avançado', 'estudos-da-natureza', 'especialidade', 2, 2006, null, '/esp/en-062.webp', 'https://mda.wiki.br/Especialidade_de_Orquídeas_-_avançado', '1. Ter a especialidade de Orquídeas.
2. Desenhar ou prensar uma orquídea e identificar o seguinte:
  a) Sépalas
  b) Pétalas
  c) Coluna
  d) Antera
  e) Polínias
  f) Labelo
  g) Estigma
3. Qual a principal diferença entre orquídeas monopodiais e simpodiais?
4. O que são "cultivares"?
5. Como funciona a "reprodução" por meristema? Com que objetivo ela é praticada?
6. O que são Keikis?
7. Listar 3 utilidades das orquídeas para o ser humano.
8. Conhecer os elementos essenciais ao crescimento de orquídeas.
9. Nomear, pelo menos, 2 espécies de orquídeas que podem crescer nas seguintes condições na região em que vive:
  a) Ao ar livre, em um jardim comum ou uma rocha.
  b) À sombra ou meia luz
  c) Em uma estufa não aquecida
  d) Em uma estufa aquecida
10. Citar alguns fatores que podem contribuir para que uma espécie de orquídea entre em risco de extinção.
11. Explicar os requisitos de quarentena exigidos em seu país em relação à importação de orquídeas.
12. Explicar o processo de crescimento de sementes de orquídeas nas condições existentes em um vaso de vidro.
13. Descrever a distribuição mundial das orquídeas e analise como o conhecimento da altura acima do nível do mar, do habitat nativo de uma orquídea são importante para quem a cultiva.
14. Cultivar uma pequena coleção de orquídeas (de, pelo menos, 2 gêneros) até que floresçam (mínimo 4 diferentes orquídeas). Ao final do período, apresentar um histórico fotográfico, acompanhado de anotações sobre o desenvolvimento e cuidados necessários, com a evolução de cada planta.
15. Identificar, por meio de imagens, fatos ou pessoalmente, 20 espécies de orquídeas.'),
('EN-063', 'Palmeiras', 'estudos-da-natureza', 'especialidade', 2, null, 'Divisão do Sul do Pacífico', '/esp/en-063.webp', 'https://mda.wiki.br/Especialidade_de_Palmeiras', '1. Qual o nome da família das Palmeiras?
2. Apresentar as características gerais de uma palmeira, especialmente a respeito das seguintes partes:
  a) Tronco ou caule
  b) Raízes
  c) Folhas
  d) Inflorescência, ou flores
  e) Frutas
3. O que acontece quando a coroa de uma palmeira é cortada?
4. O que acontece quando o tronco da palmeira é danificado?
5. Identificar 5 diferentes tipos de palmeiras que crescem na região em que você vive.
6. Desenhar e dar o nome de 8 palmeiras que você já tenha identificado na natureza.
7. Quais partes de uma palmeira podem ser usadas como alimento? Citar 5 exemplos de exemplos obtidos de palmeiras.'),
('EN-064', 'Solos', 'estudos-da-natureza', 'especialidade', 2, 2006, 'Divisão Norte Americana', '/esp/en-064.webp', 'https://mda.wiki.br/Especialidade_de_Solos', '1. Definir o que significa solo.
2. Onde, na Terra, está localizado o solo?
3. Quais são os cinco fatores chave para formação do solo?
4. Definir os seguintes termos:
  a) Horizonte A
  b) Horizonte B
  c) Horizonte C
  d) Camada orgânica
  e) Camada mineral
  f) Argila
  g) Lixiviação
  h) Húmus
  i) Perfil do solo
  j) Material de origem
  k) Pedólogo
5. Por que os solos são classificados?
6. Discutir as diferenças entre os seguintes tipos de solos:
  a) Deserto
  b) Temperado
  c) Tropical
7. Examinar uma seção vertical de 60 cm de solo. Rotular os diferentes tipos de matéria orgânica encontrada, identificar os diferentes horizontes do solo e marcar a transição entre a camada de solo e a camada de minerais.
8. Desenhar, fotografar ou coletar e rotular corretamente cinco diferentes tipos de solo.'),
('EN-065', 'Vermes', 'estudos-da-natureza', 'especialidade', 1, 2006, 'Divisão Norte Americana', '/esp/en-065.webp', 'https://mda.wiki.br/Especialidade_de_Vermes', '1. Explicar o seguinte:
  a) O que é um verme;
  b) Onde os vermes vivem;
  c) O que os vermes comem;
  d) Em que reinos os vermes são encontrados.
2. O que significam os termos vida livre e parasita?
3. Dar o nome dos três principais filos (segunda maior categoria de classificação) que contêm vermes e descrevê-los. Quais são de vida livre e quais são de parasitas?
4. Responder as seguintes perguntas sobre minhocas:
  a) Onde elas vivem?
  b) O que elas comem ?
  c) Como elas são benéficas ao ser humano?
  d) Qual o tamanho mínimo e máximo que elas podem ter?
  e) Quantas espécies existem?
  f) O que é o clitelo?
5. Encontrar uma minhoca e fazer o seguinte:
  a) Ser capaz de distinguir as seguintes partes: extremidade anterior, extremidade posterior e clitelo.
  b) Observar e descrever como ela se move.
  c) Observar quanto tempo ela leva para percorrer 10 cm.
6. Responder as seguintes perguntas sobre sanguessugas:
  a) Onde elas vivem?
  b) O que elas comem?
  c) Como elas são prejudiciais ao ser humano?')
on conflict (codigo) do update set nome = excluded.nome, categoria_slug = excluded.categoria_slug, tipo = excluded.tipo, nivel = excluded.nivel, ano = excluded.ano, origem = excluded.origem, imagem = excluded.imagem, url_mda = excluded.url_mda, requisitos = excluded.requisitos;

insert into public.especialidades (codigo, nome, categoria_slug, tipo, nivel, ano, origem, imagem, url_mda, requisitos) values
('EN-066', 'Vermes - avançado', 'estudos-da-natureza', 'especialidade', 2, 2006, 'Divisão Norte Americana', '/esp/en-066.webp', 'https://mda.wiki.br/Especialidade_de_Vermes_-_avançado', '1. Ter a especialidade de Vermes.
2. Descrever as três principais classes de platelmintos.
3. Dar um exemplo de nematóide e descrever seu ciclo de vida.
4. Quais são as três principais classes de anelídeos? Como eles se movem?
5. Fazer o seguinte:
  a) Distinguir entre as seguintes estruturas corporais: celomados, pseudocelomados e acelomados.
  b) Que estruturas corporais são comuns em cada um dos três filos de vermes?
6. Completar um dos itens a seguir:
  a) A partir do que você aprendeu sobre os vermes, fazer uma apresentação sobre por que a disponibilidade de água potável é tão importante para a saúde humana, especialmente em países em desenvolvimento.
  b) Organizar uma angariação de fundos para apoiar alguma organização que trabalhe para fornecer água potável para países subdesenvolvidos.'),
('EN-067', 'Quedas d''água', 'estudos-da-natureza', 'especialidade', null, 2011, 'Divisão Norte Americana', '/esp/en-067.webp', 'https://mda.wiki.br/Especialidade_de_Quedas_d''água', '1. Como se formam as quedas d''água?
2. Definir os seguintes tipos de quedas d''água e dar um exemplo de cada:
  a) Catarata
  b) Cascata
  c) Cachoeira
3. Escolher 10 quedas d''água, incluindo 2 próximas à área ou estado em que você vive, e listar as seguintes informações sobre elas:
  a) Nome
  b) Altura total
  c) Tipo de queda d''água
  d) Nome do curso de água
  e) Localização
4. Completar duas das seguintes atividades:
  a) Visitar uma queda d''água e escrever um parágrafo contando sobre sua experiência;
  b) Escolher uma queda d''água do seu interesse, que não tenha sido escolhida no requisito 3, e relatar fatos e informações interessantes sobre ela;
  c) Assistir a um vídeo sobre uma queda d''água;
  d) Fazer um álbum de recortes sobre quedas d''água. Incluir imagens das quedas d''água e informações importantes sobre cada uma;
  e) Criar um jogo da memória, palavras-cruzadas ou caça-palavras sobre 10 quedas d''água.
5. A água é mencionada em cada um dos seguintes versos. Descrever o que aconteceu em cada deles e dizer o que a água simboliza:
  a) Mateus 3:16
  b) João 4:10-13
  c) João 9:11
  d) João 13:14-15'),
('EN-068', 'Aquarismo', 'estudos-da-natureza', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/en-068.webp', 'https://mda.wiki.br/Especialidade_de_Aquarismo', '1. Ter a especialidade de Peixes.
2. O que é aquarismo ou aquariofilia?
3. Apresentar a história do aquarismo, primeiros povos a praticar, desenvolvimento das técnicas, evidencias históricas, etc.
4. Explicar o que é, como funciona e qual a utilidade dos seguintes:
  a) Termostato
  b) Cascalho
  c) Substrato
  d) Ração de férias
  e) Placa biológica
  f) Bio Ball
  g) Rede coletora
  h) Filtro fluidizado
  i) Filtro externo
  j) Filtro UV
  k) Ozonizadores
  l) Reator de cálcio
  m) Skimmer
  n) Incentivadores bacterianos ("aceleradores de biologia")
  o) Alimentador automático
5. Citar algumas vantagens e desvantagens de um aquário de água salgada em relação a um de água doce.
6. Identificar, ao vivo ou por foto, 10 peixes ornamentais de água salgada e 15 peixes ornamentais de água doce, comumente utilizados em aquários.
7. Conhecer 10 plantas aquáticas de água doce, comumente utilizadas em aquários. Identificá-las por meio de foto ou ao vivo.
8. Identificar, ao vivo ou por fotos, 5 corais utilizados em aquários marinhos.
9. Listar e identificar, ao vivo ou por fotos, 5 animais comuns em aquários marinhos. (Não incluir peixes ou corais na lista).
10. Listar e identificar, ao vivo ou por fotos, 5 animais comuns em aquários de água doce. (Não incluir peixes na lista).
11. Listar 5 diferentes testes de água, explicar a importância de utilizá-los e demonstrar o uso de, ao menos, um destes.
12. Completar o seguinte:
  a) Montar um aquário de, ao menos, 20 litros, com quantidade equilibrada de plantas e peixes e mantê-lo por, no mínimo, um mês.
  b) Durante a montagem, observar o seguinte:
    • Demonstrar habilidade em montar e explicar o funcionamento de um sistema de filtragem adequado
    • Explicar a escolha e instalar um sistema de iluminação compatível
    • Escolher o tipo de solo mais indicado para o ambiente desejado
    • Plantas: analisar as espécies que melhor se adequam ao modelo
    • Peixes: explicar sobre as espécies escolhidas, a reação espaço versus tamanho adulto e quantidade de espécimes; temperatura ideal para o crescimento, temperamento, tipo de ração, reprodução, principais doenças e problemas.
  c) Durante o período, tomar nota dos efeitos, nos peixes e no aquário em geral, das seguintes condições:
    • Luz demais
    • Luz de menos
    • Alimento demais
    • Mudanças na temperatura da água
    • Poucas plantas para muitos peixes'),
('EN-069', 'Animais Peçonhentos', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-069.webp', 'https://mda.wiki.br/Especialidade_de_Animais_Peçonhentos', '1. O que são animais peçonhentos?
2. Descobrir a quantidade de acidentes causados por animais peçonhentos em seu país ou região no último ano (caso esse dado não esteja disponível, pegar o último ano disponível).
3. Escolher e apresentar as seguintes características de 2 animais peçonhentos:
  a) Habitat
  b) Alimentação
  c) Danos causados aos seres humanos
  d) Forma de prevenção
4. Citar, pelo menos, três animais peçonhentos em cada uma das Classes abaixo:
  a) Répteis
  b) Insetos
  c) Aracnídeos
5. Saber como os animais peçonhentos são importantes para o equilíbrio do ecossistema.
6. Aprender 4 maneiras de se proteger contra animais peçonhentos que são encontrados em casas, empresas ou acampamentos.
7. Os animais peçonhentos geralmente atacam por maldade ou por defesa?
8. Aprender os primeiros socorros que devem ser prestados às vítimas de picadas de animais peçonhentos.
9. O que é soroterapia?
10. Saber para qual picada de animal serve cada tipo de soro abaixo:
  a) Antibotrópico
  b) Anticrotálico
  c) Antibotrópico-laquético
  d) Antilapídico
  e) Antiaracnídico
  f) Antiescorpiônico
  g) Anilonômico
11. Realizar uma das atividades abaixo:
  a) Visitar um zoológico ou local de pesquisa em que você possa observar animais peçonhentos e apresentar um relatório.
  b) Com a orientação do seu líder, identificar, no mínimo, 10 animais peçonhentos e apresentar uma relação com: nome científico, nome popular, foto e local de origem.
12. Descobrir, no mínimo, 2 versos que citem animais peçonhentos na Bíblia.'),
('EN-070', 'Animais Noturnos', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-070.webp', 'https://mda.wiki.br/Especialidade_de_Animais_Noturnos', '1. O que são animais noturnos?
2. Como os animais noturnos são influenciados pelo clima em que estão inseridos?
3. Escolher e apresentar as seguintes características de 2 animais noturnos:
  a) Habitat
  b) Forma de reprodução
  c) Alimentação
  d) Hábitos
4. Ser capaz de identificar, pelo menos, 3 animais noturnos das classes abaixo:
  a) Mamíferos
  b) Insetos
  c) Anfíbios
  d) Aves
  e) Répteis
5. Realizar uma das atividades abaixo:
  a) Observar por, no mínimo, 2 dias um animal noturno doméstico e fazer um relatório do seu comportamento.
  b) Realizar uma visita noturna em um aquário ou zoológico e apresentar um relatório do seu contato com os animais noturnos.
  c) Assistir a um documentário sobre um ou mais animais noturnos e apresentar um relatório do que aprendeu.
6. O que são quirópteros e quais seus benefícios e malefícios para o ser humano?
7. Descubrir, pelo menos, 3 versos que citem animais noturnos citados na Bíblia.'),
('EN-071', 'Animais Nocivos', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-071.webp', 'https://mda.wiki.br/Especialidade_de_Animais_Nocivos', '1. O que são animais nocivos?
2. Qual a diferença entre animais nocivos e animais peçonhentos?
3. Saber como alguns animais nocivos podem estar diretamente ligados a alguns tipos de surtos, epidemias e pandemias. Citar 3 exemplos.
4. Conhecer, no mínimo, 4 tipos de doenças transmitidas por animais nocivos.
5. Como os animais podem prejudicar plantações e a vida de outros animais?
6. Escolher e apresentar as seguintes características de 2 animais nocivos:
  a) Habitat
  b) Forma de reprodução
  c) Alimentação
  d) Doenças ou danos causados aos seres humanos
  e) Forma de prevenção
7. Citar, pelo menos, 3 animais nocivos em cada uma das Classes abaixo:
  a) Mamíferos
  b) Insetos
  c) Répteis
  d) Anfíbios
8. Descobrir como alguns animais nocivos são importantes para o equilíbrio do ecossistema.
9. Aprender 4 maneiras de se proteger contra animais nocivos que são encontrados em casas ou empresas.
10. Realizar uma das atividades abaixo:
  a) Visitar um zoológico ou local de pesquisa em que você possa observar animais nocivos e apresentar um relatório.
  b) Com a orientação do seu líder, identificar, no mínimo, 10 animais nocivos e apresentar uma relação com: nome científico, nome popular, foto e local onde foi encontrado.
11. Descobrir 3 animais nocivos citados na Bíblia, com seus respectivos versos.'),
('EN-072', 'Arbustos - avançado', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-072.webp', 'https://mda.wiki.br/Especialidade_de_Arbustos_-_avançado', '1. Ter a especialidade de Arbustos
2. Saber o que são arbustos ornamentais e descobrir, no mínimo, uma técnica de ornamentação de arbustos.
3. Cuidar de um arbusto por, no mínimo, 1 mês e relatar seus métodos de cuidado.
4. Citar 3 exemplos dos seguintes tipos de arbustos:
  a) Arbustos floridos
  b) Arbustos Frutíferos
5. Observar algum arbusto que esteja florido e relacionar a maior quantidade de insetos possível (pelo menos 3) que venham buscar pólen ou néctar em suas flores.
6. Dar o nome de 3 importantes alimentos silvestres ou cultivados encontrados em arbustos de sua localidade.
7. Relacionar, no mínimo, 30 tipos diferentes de arbustos e reunir, preservar e identificar corretamente as flores, folhas, sementes, vagem de sementes ou ramos com botões de, no mínimo, 20 arbustos citados em sua listagem.'),
('EN-073', 'Araras, Papagaios e Periquitos', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul do Pacífico', '/esp/en-073.webp', 'https://mda.wiki.br/Especialidade_de_Araras,_Papagaios_e_Periquitos', '1. As araras, os papagaios e os periquitos pertencem a qual ordem e qual família de aves? Quais são as principais características que diferenciam esta ordem dos outros pássaros.
2. Dar o nome de 15 espécies de araras, papagaios e periquitos comuns em seu país e ser capaz de identificá-los ao ar livre, em cativeiro ou em fotos.
3. Onde as araras, os papagaios e os periquitos constroem seus ninhos?
4. Quais são as características destas aves chamam atenção e os tornam bons animais de estimação? Quais aves deste grupo são as mais criadas em seu país?
5. Quais são as maiores ameaças enfrentadas pelas araras, papagaios e periquitos? Citar quatro espécies que estão ameaçadas de extinção.
6. Escolher uma espécie entre as ameaçadas de extinção e dizer:
  a) Nome popular e nome científico;
  b) Habitat e distribuição geográfica;
  c) Alimentação;
  d) Principais ameaças;
  e) Estratégias de conservação.
7. Escolher uma espécie não ameaçada de extinção e dizer:
  a) Nome popular e nome científico;
  b) Habitat e distribuição geográfica;
  c) Alimentação.
8. Onde é possível adquirir uma arara, um papagaio ou periquito com origem legal? Por que não se recomenda comprar animais que não tenham origem legal?'),
('EN-074', 'Briófitas', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-074.webp', 'https://mda.wiki.br/Especialidade_de_Briófitas', '1. O que significa a palavra briófita?
2. Citar 4 características desse grupo de plantas
3. Através de figuras ou ao natural, identificar os rizoides, cauloides e filoides
4. Pesquisar e esquematizar o ciclo de vida de uma briófita.
5. Por qual motivo as briófitas apresentam grande dependência da água?
6. Em qual tipo de ambiente é comum encontrarmos briófitas?
7. Qual nome popular é usado para identificar o grupo?
8. Como ocorre a absorção de água em briófitas? Qual a relação existente entre o tamanho da planta e a absorção de água?
9. Realizar as atividades a seguir:
  a) Observar, ao natural, pelo menos um tipo de briófita com lupa. Fazer um relatório sobre o observado.
  b) Possuir uma coleção de imagens ou figuras de, pelo menos, 10 tipos diferentes de briófitas.'),
('EN-075', 'Bactérias', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-075.webp', 'https://mda.wiki.br/Especialidade_de_Bactérias', '1. Quais as principais características de uma bactéria que a colocam num reino separado dos demais seres vivos?
2. Através de desenhos ou figuras, identificar as principais estruturas de uma célula bacteriana.
3. Esquematize as 4 principais formas de bactérias.
4. O que são bactérias gram negativas e gram positivas?
5. Explicar as formas de reprodução das bactérias. Quais as principais condições ambientais para uma bactéria se reproduzir?
6. Como ocorre a alimentação e respiração das bactérias?
7. Citar:
  a) 3 bactérias benéficas ao ser humano e explicar o porquê;
  b) 3 bactérias que podem trazer prejuízos ao ser humano e explicar o porquê;
  c) Uma história bíblica que apresenta uma doença bacteriana.
8. Nomear 5 doenças bacterianas e descrever alguns cuidados que temos que ter para evitá-las.
9. Qual a importância de não se usar antimicrobianos sem prescrição médica?'),
('EN-076', 'Camelos', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-076.webp', 'https://mda.wiki.br/Especialidade_de_Camelos', '1. Explicar as diferenças entre o dromedário e o camelo-bactriano. Por que ambos são reconhecidos e importantes?
2. Descrever as seguintes características dos camelos:
  a) 3 utilidades que lhe são atribuídas
  b) Quantidade de água que bebem
  c) 3 qualidades de sobrevivência
  d) Procedência
3. Mencionar 3 camelos sul-americanos e analisar o seguinte:
  a) Região onde vivem
  b) Utilidade que lhe é atribuída
  c) Características físicas
  d) Tipo de alimentação
4. Fazer uma pesquisa sobre a predação dos camelos sul-americanos. Por que esses animais estão em risco de extinção?
5. Fazer um estudo do texto de Mateus 19:24 dando ênfase nas palavras de Jesus. Escrever um relatório do que você aprendeu com essa lição (usar comentários bíblicos para entender o contexto; é necessário ler todo o capítulo de Mateus 19).'),
('EN-077', 'Citologia', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-077.webp', 'https://mda.wiki.br/Especialidade_de_Citologia', '1. Dizer quais são as 3 partes de uma célula eucarionte e citar sua principais funções.
2. O que é uma célula procarionte?
3. Citar 3 diferenças entre uma célula animal e uma célula vegetal.
4. O que são células-tronco? Qual sua importância?
5. Citar 3 funções da membrana plasmática.
6. Explicar as seguintes formas de permeabilidade seletiva: osmose e difusão.
7. Explicar as seguintes formas de permeabilidade não seletiva: fagocitose e pinocitose.
8. O que é transporte ativo e transporte passivo?
9. Quais as 4 partes de um núcleo celular? Qual a importância de cada um?
10. Citar as funções das seguintes organelas citoplasmáticas:
  a) Mitocôndria
  b) Centríolo
  c) Complexo de Golgi
  d) Reticulo Endoplasmático Rugoso
  e) Reticulo Endoplasmático Liso
  f) Lisossomo
  g) Ribossomo
  h) Peroxissomo
11. Qual a importância dos cílios e dos flagelos?
12. Identificar, por meio de fotos ou desenhos, 5 diferentes tipos de células (como muscular, óssea, cartilaginosa, adiposa, leucócito, hemácia, neurónio, etc.).'),
('EN-078', 'Crustáceos', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-078.webp', 'https://mda.wiki.br/Especialidade_de_Crustáceos', '1. Citar, pelo menos, 4 características de um crustáceo.
2. O que é um exoesqueleto?
3. A qual Filo pertence este grupo?
4. Como é dividido o corpo destes animais?
5. Em qual livro da Bíblia, capítulo e versículo encontramos informações para não nos alimentarmos de crustáceos?
6. Como podemos diferenciar um siri de um caranguejo? Em quais ambientes encontramos esses animais?
7. Citar um exemplo de crustáceo terrestre.
8. Como podemos diferenciar entre siris (ou caranguejos) machos e fêmeas? Por que isso é importante?
9. Qual a importância dos microcrustáceos para o ambiente?
10. Realizar 2 dos itens a seguir, apresentado relatório ilustrado:
  a) Por meio de imagens/fotografias/desenho, indicar as principais partes morfológicas de uma camarão
  b) Assistir a um vídeo sobre diversas espécies de crustáceos e esquematizar, pelo menos, 2 espécies diferentes
  c) Fazer uma observação de, pelo menos, 3 espécies de crustáceos em seus ambientes naturais, durante um período mínimo de 10 minutos
  d) Conseguir diferenciar entre caranguejo e siri e saber diferenciar entre macho e fêmea.
11. Ser capaz de identificar, pessoalmente ou através de imagens, os seguintes animais:
  a) Cracas
  b) Paguro (ermitão)
  c) Tatu de jardim
  d) Lagosta
  e) Camarão
  f) Caranguejo
  g) Siri'),
('EN-079', 'Dinossauros', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-079.webp', 'https://mda.wiki.br/Especialidade_de_Dinossauros', '1. Qual o significado do termo dinossauro? Quem usou este termo pela primeira vez?
2. Quais os indícios de que estas criaturas realmente existiram?
3. Explique o surgimento e desaparecimento dos dinossauros de acordo com as seguintes teorias:
  a) Evolucionista
  b) Criacionista
4. Quais evidencias apontam para a morte dos dinossauros através do dilúvio? Identificar e listar trechos da Bíblia que falem sobre a criação de répteis.
5. Explicar porque os répteis marinhos e voadores não são considerados dinossauros. Dar exemplos destas criaturas.
6. De que maneira os dinossauros nasciam? Em que ano e onde isso foi comprovado?
7. Como supostamente seria a pele dos dinossauros?
8. Definir e caracterizar cada um dos grupos de dinossauros abaixo:
  a) Saurópodes
  b) Terópodes
  c) Ceratopsídeos
  d) Anquilosaurídeos
9. Fazer um diagrama da suposta cadeia alimentar dos Dinossauros. Quem supostamente está no topo? Por que este dinossauro supostamente se encontra lá?
10. O que são sauropodomorfos? Quais os 2 grupos em que se dividem?
11. Quem é considerado o rei dos dinossauros?
12. Escolher um dinossauro e escrever, no mínimo, 150 palavras sobre ele, onde seus fósseis foram achados, que hábitos possuía, como se alimentava e tudo o que puder saber sobre este animal.
13. Fazer uma coleção de 10 imagens de fósseis de dinossauros, identificando:
  a) Nome
  b) Local onde o fóssil foi encontrado
  c) Ano de descoberta
  d) Características gerais'),
('EN-080', 'Equinodermos', 'estudos-da-natureza', 'especialidade', 2, 1956, 'Associação Geral', '/esp/en-080.webp', 'https://mda.wiki.br/Especialidade_de_Equinodermos', '1. O que significa a palavra Echinodermata, nome que caracteriza o Filo dos equinodermos?
2. Citar 4 características pertencentes ao filo Echinodermata.
3. Qual tipo de simetria os equinodermos possuem? O que isso significa?
4. Em qual ambiente podemos encontrar os equinodermos?
5. Como as estrelas do mar se alimentam?
6. Citar as principais características e exemplos das 5 classes dos equinodermos:
  a) Asteroidea
  b) Echinoidea
  c) Ophiuroidea
  d) Holothuroidea
  e) Crinoidea
7. O que fazer em caso de acidente com ouriços?
8. Identificar, esquematizar e explicar a função das seguintes estruturas:
  a) Em estrelas do mar:
    • Pódios ou pés ambulacrários
    • Placa madrepórica
    • Boca
    • Ânus
  b) Em ouriços do mar:
    • Lanterna de Aristóteles
    • Espinhos
    • Boca
    • Endoesqueleto
9. Identificar, por meio de figuras, fotos ou pessoalmente 10 espécies diferentes de equinodermos. Além do nome popular, citar o nome cientifico e a qual classe pertencem.'),
('EN-081', 'Energias Renováveis', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-081.webp', 'https://mda.wiki.br/Especialidade_de_Energias_Renováveis', '1. O que são energias renováveis? Qual é o seu papel na conservação do meio ambiente?
2. Definir os seguintes tipos de energia, citando as vantagens e desvantagens para cada um deles:
  a) Energia solar
  b) Energia eólica
  c) Hidrogênio
  d) Biocombustíveis
  e) Energia hidráulica
  f) Energia maremotriz
  g) Energia azul
  h) Energia geotérmica
  i) Biomassa
  j) Biogás
3. O que é energia não renovável? Como esse tipo de energia pode prejudicar o meio ambiente?
4. Qual o papel da energia solar na obtenção de outros tipos de energia?
5. Para algumas energias renováveis a localização da usina é um fator de grande influência no rendimento. Como essa localização pode influenciar no rendimento?
6. Que impactos sociais e ambientais podem ser causados pela implementação de usinas de algumas energias renováveis?
7. Escolher uma usina de uma energia renovável que esteja em atividade e faça um relatório contendo o seguinte:
  a) Nome e localização
  b) Capacidade de geração de energia
  c) Tipo de energia
  d) Vantagens e desvantagens do tipo de energia
  e) Impacto ambiental e social da implementação
8. Pesquisar e praticar, pelo menos, 3 formas de economizar energia em seu lar, escola ou trabalho.
9. Segundo Apocalipse 11:18, qual é o futuro dos que destroem a terra?'),
('EN-082', 'Estuário', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-082.webp', 'https://mda.wiki.br/Especialidade_de_Estuário', '1. O que é um estuário?
2. Listar 3 tipos de estuário e dar um exemplo pra cada tipo.
3. Como é definido o comprimento de um estuário?
4. Que fatores tornam o estuário um dos biomas mais vulneráveis do mundo?
5. Explicar as razões da grande produtividade e diversidade ecológica nos estuários.
6. Qual a importância dos estuários para o equilíbrio do ecossistema?
7. Citar, ao menos, um processo de formação de estuário.
8. Conhecer, no mínimo, 3 benefícios dos estuários aos homens.
9. Em estuários existe a presença de água doce e salgada. Qual o nome dado aos peixes que têm a capacidade de sobreviver nesses dois ambientes? Citar 5 exemplos.
10. Listar 3 pássaros e 1 mamífero comuns nos estuários de sua região ou país.
11. Citar, ao menos, 2 fatores que tornam a vegetação de mangue indicada e presente nos estuários tropicais.
12. Listar, ao menos, 3 géneros de mangue comuns em estuários tropicais.
13. Citar 5 atividades recreativas que podem ser realizadas em regiões estuarias, sem lhes causar dano ou prejuízo.
14. Qual o estuário mais próximo de sua cidade?
15. Completar uma das seguintes atividades:
  a) Fazer uma visita a um estuário. Durante a visita, observar sinais de conservação ou de degradação desse ambiente. Em conjunto com o grupo, sob a orientação de seu líder, organizar um projeto de preservação desse estuário e colocar o projeto em prática.
  b) Ler um livro, ou assistir a um vídeo sobre estuários. Realizar uma pesquisa e escrever um relatório sobre 8 diferentes estuários ao redor do mundo. Nessa pesquisa devem constar: nome do estuário, localização, estado de conservação atual e possíveis motivos para esse estado, fotos, etc. Citar as fontes de pesquisa.'),
('EN-083', 'Fauna Marinha', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-083.webp', 'https://mda.wiki.br/Especialidade_de_Fauna_Marinha', '1. Pesquisar e descrever a importância da fauna marinha para o equilíbrio do ecossistema marinho.
2. Qual é o efeito da grande concentração de plástico na fauna marinha?
3. Descubrir como você pode ajudar na preservação da vida nos mares.
4. Definir as principais características dos grupos abaixo e dar 3 exemplos de cada um deles:
  a) Crustáceos
  b) Celenterado
  c) Moluscos
  d) Cetáceos
  e) Equinodermos
  f) Peixes
5. Selecionar 3 espécies de invertebrados e 3 de vertebrados da fauna marinha e responda:
  a) Nome popular
  b) Nome científico
  c) Distribuição geográfica
  d) Habitat
  e) Tipos de alimentos
  f) Papel na fauna marinha
  g) Tipo de reprodução
6. O que são poríferos e por que são chamados de animais filtradores?
7. Citar a diferença entre corais e esponjas do mar. Qual a importância deles para o meio ambiente?
8. Explicar o que são bentos, plâncton e nécton.
9. Cumprir um dos itens a seguir:
  a) Observar um animal marinho por cerca de 30 minutos. Fazer um relatório descrevendo o que observou.
  b) Assistir a um vídeo de, pelo menos, 30 minutos que fale a respeito da vida marinha. Fazer um relatório sobre o vídeo.'),
('EN-084', 'Fisiologia Vegetal', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-084.webp', 'https://mda.wiki.br/Especialidade_de_Fisiologia_Vegetal', '1. Quais características classificam um ser vivo como sendo um vegetal (Reino Metaphyta)?
2. Cite os 4 grandes grupos de plantas e suas características distintivas. Quais são consideradas mais simples e quais são mais completas?
3. Citar as funções das partes da planta:
  a) Raiz
  b) Caule
  c) Folha
  d) Fruto
  e) Flor
4. O que é fotossíntese e qual o seu objetivo? Quais seres vivos são capazes de fazer fotossíntese? Qual a fórmula química da fotossíntese?
5. O que é xilema e floema? Qual sua função?
6. Citar 5 hormônios vegetais e suas funções.
7. Como ocorre a transpiração nas plantas? Qual a sua importância para o seu desenvolvimento?
8. Falar sobre o gineceu e o androceu, citando suas partes e funções.
9. Citar, pelo menos, 1 história bíblica que compara uma planta com a vida espiritual. Explicar.'),
('EN-085', 'Formigas', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-085.webp', 'https://mda.wiki.br/Especialidade_de_Formigas', '1. As formigas pertencem a qual ordem e família? Descobrir a quantidade de espécies catalogadas em seu país.
2. Ilustrar e descrever o ciclo de vida de uma formiga.
3. Ilustrar e descrever a anatomia básica de uma formiga.
4. Descobrir espécies de formigas que não vivem em formigueiros. Relacionar:
  a) Habitat ou sociedade
  b) Forma de reprodução
  c) Alimentação
5. Descobrir, no mínimo, 3 características que diferenciam as formigas dos demais insetos.
6. Citar, no mínimo, 2 benefícios e 2 malefícios que as formigas causam ao ser humano.
7. Qual a principal forma de comunicação entre as formigas?
8. Conhecer, no mínimo, 10 espécies de formigas que vivem em seu país. Relacionar:
  a) Habitat ou sociedade
  b) Forma de reprodução
  c) Alimentação
9. Com seu grupo ou individualmente, realizar um dos seguintes:
  a) Construir uma fazenda de formigas. Saber os passos para construir e manter esta fazenda.
  b) Observar, diariamente, um formigueiro por uma semana e descobrir seu funcionamento e rotina.
10. Apresentar, em formato de encenação, relatório, música ou poema o significado de Provérbios 6:6-11.'),
('EN-086', 'Liquens', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-086.webp', 'https://mda.wiki.br/Especialidade_de_Liquens', '1. O que são liquens? Eles se encaixam em algum dos reinos de seres vivos que conhecemos? Por quê?
2. Ilustrar e descrever o ciclo de vida de um líquen.
3. Explique o que é simbiose e mutualismo.
4. O que determina a coloração de um líquen?
5. Qual a relação entre os organismos que constituem um líquen?
6. Quais são os principais grupos de fungos que se associam com algas?
7. Citar, pelo menos, 2 benefícios dos liquens para o homem e para o ambiente.
8. Encontrar, identificar e fotografar liquens fruticosos, crostosos e folhosos.'),
('EN-087', 'Odonata', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-087.webp', 'https://mda.wiki.br/Especialidade_de_Odonata', '1. O que significa o nome Odonata?
2. Quais as principais diferenças entre libélulas (Anisoptera) e donzelinhas (Zygoptera)?
3. Aproximadamente quantas espécies de libélulas existem no mundo?
4. Citar 5 nomes pelos quais as libélulas são conhecidas em diferentes partes de seu país.
5. Desenhar o ciclo de vida de uma libélula e indicar onde ela vive em cada fase.
6. Descrever as 5 partes principais da anatomia das libélulas.
7. Qual o tempo médio de vida das libélulas, no estado larval e na fase adulta?
8. Por que as libélulas são consideradas excelentes bioindicadores?
9. Citar 5 diferentes presas naturais das libélulas. Aproximadamente que porcentagem de seu peso ela chega a comer diariamente?
10. Citar 5 predadores naturais das libélulas.
11. Descrever os olhos das libélulas e sua funcionalidade.
12. Quantas vezes por segundo uma libélula pode bater suas asas?
13. Em média, por quantas horas diárias uma libélula pode voar?
14. Qual a velocidade máxima estimada do voo das libélulas?
15. Listar 3 utilidades das libélulas, para o homem.'),
('EN-088', 'Plantas Carnívoras', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-088.webp', 'https://mda.wiki.br/Especialidade_de_Plantas_Carnívoras', '1. Quais são as características de uma planta carnívora que as diferem das plantas normais?
2. Quais são os cuidados especiais que devem ser tomados no manuseio e conservação das plantas carnívoras?
3. Realizar uma pesquisa e estabelecer a relação existente entre as flores das plantas carnívoras, o processo de polinização e os insetos que elas se alimentam.
4. Descrever as características das quatro principais famílias de plantas carnívoras abaixo, descrevendo sobre suas espécies, nomes de alguns exemplares, locais originários e características que as definem:
  a) Nepenthaceaei
  b) Sarraceniaceae;
  c) Droseraceae;
  d) Lentibulariaceae.
5. Um mecanismo interessante das plantas carnívoras é como elas utilizam armadilhas para capturar suas presas. Descrever cada uma delas, identificando as espécies citadas no item anterior:
  a) Armadilhas tipo "jaula";
  b) Armadilhas de sucção;
  c) Folhas colantes;
  d) Ascídios;
  e) Outras formas.
6. Como é o processo de "digestão" dessas plantas e como elas obtêm, dos insetos, os nutrientes necessários?
7. Fazer um dos seguintes itens:
  a) Ter uma coleção devidamente catalogada de, no mínimo, três espécies (naturais) diferentes, mencionando para cada uma delas nome popular, nome científico, família e outros detalhes sobre a espécie;
  b) Montar um álbum com fotos de, no mínimo, 10 espécies diferentes, mencionando para cada uma delas nome popular, nome científico, família e outros detalhes sobre a espécie. Elas podem estar catalogadas em formato digital ou em cópia física;
  c) Cultivar uma planta carnívora de qualquer espécie por, no mínimo, um mês e fazer um relatório indicando quais são os cuidados diários.'),
('EN-089', 'Preservação de Recursos Hídricos', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-089.webp', 'https://mda.wiki.br/Especialidade_de_Preservação_de_Recursos_Hídricos', '1. O que são recursos hídricos? Citar 10 atividades em que o uso da água é essencial.
2. O que é energia hidroelétrica e qual a sua importância no seu país?
3. Saber como funciona o abastecimento público de água em sua cidade/estado.
4. Citar, no mínimo, 5 fatores que provocam desperdício de água e como poderiam ser evitados.
5. Saber como os seguintes fatores influenciam diretamente no desperdício de água potável:
  a) Desmatamento
  b) Poluição
  c) Ocupação e uso desordenado de solo
  d) Falta de saneamento básico
6. Pesquisar a média de consumo de água em seu país nas seguintes atividades:
  • Doméstico
    1. Banho
    2. Escovação dentária
    3. Descarga sanitária
    4. Lavar roupa
    5. Torneira gotejando
  • Indústria
    1. Produção de 1 kg de carne bovina
    2. Produção de 1 Kg de queijo
    3. Produção de 1 litro de leite
    4. Produção de 1 Kg de tomate
    5. Produção de 1 computador
7. Descobrir, pelo menos, 10 maneiras que você e sua família podem preservar os recursos hídricos disponíveis e colocá-los em prática.
8. Saber o que é hidrologia e descobrir como seu estudo é fundamental para a preservação dos recursos hídricos.
9. Conhecer, pelo menos, 3 maneiras de purificação de água.
10. Fazer um dos itens abaixo:
  a) Participar de um projeto de preservação de alguma fonte de água potável;
  b) Criar um projeto criativo de conscientização sobre o uso inadequado da água em sua escola, igreja, local de trabalho ou comunidade;
  c) Ter a especialidade de Conservação ambiental ou Energias renováveis'),
('EN-090', 'Poríferos e Cnidários', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-090.webp', 'https://mda.wiki.br/Especialidade_de_Poríferos_e_Cnidários', '1. Citar as principais características das esponjas. Por que elas são consideradas filtradores?
2. Por que as esponjas são consideradas animais?
3. O que significa o nome cnidário e quais animais fazem parte deste grupo? Citar as principais características dos animais deste grupo.
4. O que são ctenóforos? Quais são as diferenças dos animais deste grupo em comparação com os cnidários?
5. Esquematizar uma água-viva (medusa), indicando suas principais partes.
6. Quais cuidados devemos tomar ao encontrarmos uma água-viva (medusa)? Quais são os primeiros socorros que devem ser prestados a uma vítima com queimadura por uma água-viva?
7. Em qual ambiente as esponjas e os cnidários vivem?
8. Qual é a importância dos recifes de corais?
9. Qual é o maior recife de coral do mundo?'),
('EN-091', 'Protozoários', 'estudos-da-natureza', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/en-091.webp', 'https://mda.wiki.br/Especialidade_de_Protozoários', '1. Quais as principais características dos protozoários que os colocam no reino protista? Quais as semelhanças e diferenças que eles têm em relação aos demais protistas (algas)?
2. Descrever a classificação dos protozoários, dizendo suas características distintivas e, pelo menos, um exemplo em cada grupo e sua importância.
3. O que são pseudópodes? Qual sua função?
4. Como ocorre a reprodução dos protozoários? Como eles podem alterar suas características genéticas e tornarem-se mais resistentes a agressores?
5. Como ocorre a alimentação e respiração dos protozoários?
6. A amebíase e a giardíase são doenças gastrointestinais causadas por protozoários que são muito semelhantes. Citar 3 diferenças que as distinguem e como nós podemos preveni-las.
7. O que é leishmaniose? Como os cães estão relacionados com a propagação dessa doença protozoária?
8. A malária é uma doença que causa muitas mortes na região amazónica e na África. Descrever qual sua forma de contágio, quais os seus principais sintomas e como podemos nos prevenir e tratar essa doença.
9. Desenhar o ciclo da Doença de Chagas, explicando cada fase. O que ela causa no ser humano? Como é transmitida? Como podemos preveni-la? Há tratamento?
10. Ser capaz de identificar, por meio de desenhos ou figuras, 5 protozoários comuns, dando o seu nome cientifico.'),
('EN-092', 'Reciclagem e Sustentabilidade', 'estudos-da-natureza', 'especialidade', 1, 2012, 'Divisão Sul Americana', '/esp/en-092.webp', 'https://mda.wiki.br/Especialidade_de_Reciclagem_e_Sustentabilidade', '1. Definir a palavra Reciclagem.
2. Qual o significado dos 5RS da Educação Ambiental?
3. Definir os seguintes termos:
  a) Sustentabilidade
  b) Impacto Ambiental
  c) Preservação
  d) Biodegradável
4. Quais as cores usadas para separar o lixo para reciclagem? E quais lixos são separados de acordo com cada cor?
5. Fazer um relatório de 300 palavras sobre por que é importante reciclar o lixo no contexto social e ambiental nos dias atuais.
6. Elaborar e demonstrar em forma de cartaz ou apresentação digital, uma tabela contendo os resíduos naturais e artificiais com o tempo de decomposição de cada um.
7. Pesquisar e apresentar em forma de desenho, escrito ou multimídia uma perspectiva de futuro, na qual se demonstre quais os impactos ambientais que o lixo irá causar ao homem e ao meio ambiente caso não haja a reciclagem do lixo.
8. Pesquisar em seu município, quais são as medidas públicas que estão sendo adotadas para o trabalho de coleta seletiva da cidade. Apresentar um relatório.
9. Criar dois brinquedos feitos com material reciclado. Procurar fazê-los dando o melhor acabamento possível.
10. Encontrar um texto bíblico que mencione a importância do cristão se conscientizar sobre a conservação, orientação, preservação e sensibilização no meio ambiente.'),
('EN-093', 'Reciclagem e Sustentabilidade - avançado', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-093.webp', 'https://mda.wiki.br/Especialidade_de_Reciclagem_e_Sustentabilidade_-_avançado', '1. Ter a especialidade de Reciclagem e sustentabilidade.
2. Em localidades onde há um sistema de coleta seletiva são usadas lixeiras em cores diferenciadas. Mencione que tipo de material é identificado por cada cor:
  a) Azul
  b) Vermelho
  c) Amarelo
  d) Marrom
  e) Verde
3. Como funciona a coleta seletiva de resíduo sólido nos locais abaixo:
  a) Residências
  b) Empresas
4. Como a reciclagem influencia no contexto social se transformando em renda alternativa para diversas famílias?
5. Como deve ser o descarte de pilhas e lâmpadas fluorescentes? Onde se encontra o posto de coleta mais próximo em sua cidade?
6. Descubrir como funciona a estrutura de um aterro sanitário. Citar os principais benefícios e malefícios.
7. Restaurar um objeto que iria ser jogado fora em algo útil.
8. Cumprir um dos itens abaixo:
  a) Desenvolver uma técnica para reciclar restos de madeiras, cordas ou bambus de forma efetiva após acampamentos. Adotar es técnica em pelo menos um acampamento;
  b) Produzir um vídeo ou encenação de ao menos 5 minutos apresentando dicas de como melhorar o planeta usando a reciclagem;
  c) Visitar uma cooperativa de tratamento de resíduos sólidos e descubrir quais os métodos utilizados para reaproveitar os materiais.'),
('EN-094', 'Tubarões', 'estudos-da-natureza', 'especialidade', 2, 2012, 'Divisão Sul Americana', '/esp/en-094.webp', 'https://mda.wiki.br/Especialidade_de_Tubarões', '1. Quais as principais diferenças entre peixes ósseos e cartilaginosos?
2. Citar 2 exemplos de peixes cartilaginosos que não sejam tubarões.
3. Explicar o seguinte:
  a) A dentição dos tubarões e a diversidade de alimentos que consomem.
  b) Como ocorre a respiração dos tubarões.
  c) Qual a importância da Ampola de Lorenzini?
  d) Qual o menor e qual o maior tubarão que existem.
4. Saber identificar, por meio de figuras, 5 espécies de tubarões.
5. Identificar as principais estruturas morfológicas de um tubarão através de um esquema.
6. Saber identificar, por meio de figuras, fotos ou pessoalmente, 5 espécies de tubarões.
7. Fazer uma das atividades abaixo:
  a) Visitar um aquário e observar peixes cartilaginosos. Fazer um relatório sobre o que você aprendeu;
  b) Assistir a um vídeo sobre peixes cartilaginosos. Fazer um relatório sobre o que você aprendeu.'),
('EN-095', 'Vírus', 'estudos-da-natureza', 'especialidade', 3, 2012, 'Divisão Sul Americana', '/esp/en-095.webp', 'https://mda.wiki.br/Especialidade_de_Vírus', '1. O que significa a palavra vírus? Explicar por que há uma controvérsia se ele é um ser vivo ou não.
2. Citar as características distintivas dos vírus e por que eles não são incluídos em nenhum reino.
3. Citar algumas formas morfológicas de vírus e dar exemplos.
4. Descrever as formas de replicação viral e como pode ocorrer a diferenciação genética que promove as mutações e resistência viral.
5. Diferenciar as seguintes doenças exantemáticas:
  a) Rubéola;
  b) Sarampo;
  c) Catapora (Varicela).
6. Escolher três das doenças virais abaixo e descrever a forma de contágio, os sintomas e formas de prevenção:
  a) Raiva;
  b) Herpes;
  c) AIDS/SIDA;
  d) Caxumba;
  e) Poliomielite;
  f) Meningite;
  g) Hepatite;
  h) Dengue;
  i) Covid-19.
7. Diferenciar gripe e resfriado. Por que o vírus Influenza causa epidemias periódicas (como a gripe espanhola, gripe aviária, gripe A, etc.)?
8. Qual a diferença entre vírus e príon? Citar uma doença causada por um príon.
9. Explicar a importância das vacinas no combate aos vírus. Como elas funcionam?
10. Alguma doença viral já foi erradicada? Por que é tão difícil o tratamento de doenças virais?
11. Fazer um breve relatório sobre uma pandemia viral e o impacto que ela causou ao mundo.'),
('EN-096', 'Abelhas e Vespas', 'estudos-da-natureza', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/en-096.webp', 'https://mda.wiki.br/Especialidade_de_Abelhas_e_Vespas', '1. A que ordem pertencem as abelhas, vespas e marimbondos? Quais as características dessa ordem? Que outro inseto comum pertence a essa mesma ordem?
2. O que significa o termo holometábolo? Ilustrar o ciclo de vida de um inseto holometábolo.
3. Qual o nome científico da abelha conhecida como Europa?
4. Como as abelhas são classificadas em uma colônia?
5. Responder o seguinte sobre abelhas:
  a) Qual a maior espécie de abelha?
  b) Por que as abelhas são tão sociáveis entre si e as vespas não?
  c) Qual o nome da profissão de criador de abelhas?
  d) Por que a abelha morre logo após ferroar uma pessoa ou animal?
  e) De onde foi trazida a espécie de abelha Apis Mellifera Ligustica para a América do Sul?
  f) O que faz as abelhas seguirem sua rainha?
  g) O que as abelhas coletam nas flores?
6. Citar cinco espécies de abelhas que não possuem ferrão.
7. Quais os possíveis benefícios e malefícios das abelhas ao ser humano e à natureza?
8. Como as abelhas realizam a polinização das flores? Ilustrar.
9. Quais as diferenças entre vespas e marimbondos?
10. Descrever as características das vespas e dos marimbondos, incluindo hábitos, alimentação e reprodução.
11. Ilustrar e descrever o ciclo de vida da vespa Pepsis Formosa Pationii.
12. Quais os possíveis benefícios e malefícios das vespas e marimbondos ao ser humano e à natureza?
13. Qual espécie de ave só constrói seus ninhos onde há casas de marimbondos/vespas?
14. Completar os requisitos a seguir:
  a) Encontrar um texto bíblico contendo a palavra vespa;
  b) Citar três personagens bíblicos que comeram mel;
  c) A que povo pertenciam os dois reis que foram expulsos de suas terras por vespões?
  d) Segundo a Bíblia, o que é mais doce do que o mel?
  e) Qual a responsabilidade do ser humano com a natureza?(Gênesis 1:27 e 28; 2:15)'),
('EN-097', 'Animais Migratórios', 'estudos-da-natureza', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/en-097.webp', 'https://mda.wiki.br/Especialidade_de_Animais_Migratórios', '1. Qual a diferença entre migração, imigração e emigração?
2. Por quais motivos os animais migram?
3. Quais os perigos encontrados no curso da migração?
4. Citar um exemplo de animal migratório para cada uma das seguintes classes:
  a) Mamíferos;
  b) Insetos;
  c) Peixes;
  d) Aves.
5. Para cada animal do requisito 4, descrever todo o processo de migração, o motivo da migração, os perigos encontrados, etc.
6. Qual a maior e a menor espécie de animais migratórios?
7. Qual espécie realiza a maior distância de migração?
8. Fazer um pequeno estudo sobre o animal que concentra a maior quantidade de indivíduos em migração.'),
('EN-098', 'Aves de Rapina', 'estudos-da-natureza', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/en-098.webp', 'https://mda.wiki.br/Especialidade_de_Aves_de_Rapina', '1. Quais as características das aves de rapina? Quais as vantagens do formato do bico das aves de rapina?
2. O que é hábito saprófago ou necrófago? Qual espécie de abutre não tem esse hábito?
3. Quais as vantagens da visão ultravioleta para as aves que dispõem dessa capacidade? Citar uma espécie de ave de rapina que tem visão ultravioleta.
4. Por que as aves de rapinas de hábitos noturnos são tão eficientes com predadoras?
5. Dar um exemplo de espécie para cada um dos itens abaixo, citando os nomes populares e científicos:
  a) Acipitrídeos (Accipitridae);
  b) Catartídeos (Cathartidae);
  c) Falconídeos (Falconidae);
  d) Pandionídeos (Pandionidae);
  e) Estrigídeos (Strigidae).
6. Descrever as técnicas de caça das ordens abaixo:
  a) Accipitriforme;
  b) Falconiforme;
  c) Strigiforme.
7. Quais as diferenças morfológicas entre as águias, gaviões e falcões? Ilustrar.
8. Identificar, por meio de imagens, fotos ou pessoalmente, pelo menos 10 espécies de aves de rapina.
9. Citar espécies de aves de rapina que estão ameaçadas de extinção. Quais as principais causas de morte de espécies de aves de rapina de médio e grande porte?
10. Explicar como a presença das aves de rapina é um indicador da biodiversidade em uma região.
11. Qual ave de rapina tem o voo mais rápido do mundo?
12. Explicar Isaías 40:31'),
('EN-099', 'Ciência Planetária', 'estudos-da-natureza', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/en-099.webp', 'https://mda.wiki.br/Especialidade_de_Ciência_Planetária', '1. Ter a especialidade de Astronomia.
2. Quais são as três unidades de medida de distância astronômica classicamente utilizadas?
3. Qual é o nome e o tamanho da galáxia em que vivemos? Qual é a galáxia mais próxima da nossa?
4. O que é nuvem cósmica e qual a sua relação com a formação de novas estrelas e planetas?
5. O que é a nuvem de Oort?
6. Dar as seguintes características dos planetas do sistema solar:
  a) Revolução sideral;
  b) Gravidade relativa;
  c) Quantidade de luas.
7. Qual é a importância dos meteoritos para o estudo do universo?
8. Utilizando um telecópio (que pode ser caseiro ou construído a partir de um kit), oversar o céu noturno e identificar os planetas visíveis.'),
('EN-100', 'Cigarras', 'estudos-da-natureza', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/en-100.webp', 'https://mda.wiki.br/Especialidade_de_Cigarras', '1. Quais são os nomes da ordem e da família das cigarras?
2. Ilustrar o ciclo de vida da cigarra.
3. Onde ficam localizados os aparelhos estridulatórios (órgãos sonoros) das cigarras?
4. Onde ficam localizados os ouvidos das cigarras?
5. Responder as seguintes perguntas:
  a) De qual idioma é derivada a palavra cigarra?
  b) Onde a cigarra passa a maior parte da sua vida?
  c) Quais os principais predadores da cigarra enquanto ela vive no subsolo?
  d) Quantos anos, em média, as cigarras vivem?
  e) Do que as cigarras se alimentam?
  f) Qual o principal motivo do canto das cigarras?
  g) É correto afirmar que apenas o macho da cigarra canta? Por quê?
6. Como as cigarras podem causar prejuízos nas lavouras? Que animal pode ajudar no combate às ninfas das cigarras?
7. Apresentar fotos das seguintes espécies de cigarras:
  a) Quesada gigas;
  b) Neotibicen linnei.
8. Que relação existe entre a vida da cigarra e o texto de Salmo 150:6?'),
('EN-101', 'Compostagem Doméstica', 'estudos-da-natureza', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/en-101.webp', 'https://mda.wiki.br/Especialidade_de_Compostagem_Doméstica', '1. O que é compostagem? Qual a importância da compostagem para as grandes cidades?
2. Como acontece o processo da compostagem? Qual o papel dos microrganismos nesse processo? Qual a importância da aeração adequada?
3. Ao realizar uma compostagem doméstica, quais elementos são essenciais para que a decomposição do resíduo aconteça de forma correta?
4. Quais elementos não devem fazer parte de uma composteira caseira?
5. Montar uma compostagem doméstica utilizando materiais reutilizáveis e apresentar relatório fotográfico com todo o processo desenvolvido por no mínimo 45 dias.
6. Citar duas formas de como se pode acelerar o processo de compostagem.
7. Relatar a utilidade do composto formado após o processo de compostagem.
8. Explicar como utilizar o chorume coletado durante o processo.'),
('EN-102', 'Mimetismo e Camuflagem', 'estudos-da-natureza', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/en-102.webp', 'https://mda.wiki.br/Especialidade_de_Mimetismo_e_Camuflagem', '1. O que é mimetismo, o que é camuflagem e para o que servem?
2. Citar, pelo menos, um exemplo de mimetismo para cada:
  a) Insetos;
  b) Aves;
  c) Répteis.
3. Dar, pelo menos, um exemplo de camuflagem para cada:
  a) Insetos;
  b) Répteis;
  c) Animais marinhos.
4. Responder as seguintes perguntas:
  a) Qual a vantagem da cobra coral-falsa em apresentar cores praticamente idênticas às da coral-verdadeira?
  b) No mundo animal, quais os reis da camuflagem na terra e no mar?
  c) Qual a forma dos ovos do bicho-pau (Phibalosoma Phyllinum)?
  d) Como é o andar dos insetos especialistas em mimetismo?
  e) Quais as vantagens e desvantagens dos insetos que se assemelham a folhas?
  f) Como o inseto-assassino (Acanthaspis petax) faz para se esconder dos predadores?
5. Dar exemplos de animais que apresentam características contrárias ao mimetismo, e explicar por que isso acontece na natureza.
6. Ilustrar o mimetismo das seguintes espécies:
  a) Louva-a-deus orquídea (Hymenopus coronatus);
  b) Urutau-comum (Nyctibius griséus);
  c) Sapo-de-chifres ou sapo-folha (Proceratophrys boiei).
7. Ver vídeos ou fotografias/imagens que registrem a camuflagem das seguintes espécies:
  a) Polvo-mímico (Mimic octopus);
  b) Goniurellia tridens;
  c) Jequitiranaboia (Fulgora laternaria).'),
('EN-103', 'Peixes Ornamentais', 'estudos-da-natureza', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/en-103.webp', 'https://mda.wiki.br/Especialidade_de_Peixes_Ornamentais', '1. Quais os peixes de água doce mais conhecidos do mundo?
2. Os peixes carpas foram sendo modificados geneticamente e deram origem a qual tipo de peixe ornamental?
3. Qual a origem dos seguintes peixes?
  a) Danio rerio;
  b) Symphysodon discus;
  c) Pterophyllum scalare;
  d) Poecilia reticulata.
4. Citar:
  a) Três espécies de peixes que não precisam, obrigatoriamente, de aquecimento no aquário;
  b) Peixes de água doce ideais para aquários comunitários;
  c) Peixes de aquário de água doce que são identificados para iniciantes;
  d) Peixes de aquário de água doce que não são recomendados para iniciantes;
  e) Peixes de água salgada que são indicados para iniciantes;
  f) Peixes de aquarismo marinho que são aconselhados para pessoas experientes no ramo.
5. Responder os seguintes itens:
  a) Por que o peixe Betta splendens também é conhecido pelo nome de peixe de briga?
  b) Qual peixe é conhecido como peixe anjo?
  c) Qual peixe de água doce tem como característica a cabeça vermelha?
  d) Por que o peixe neon recebe este nome?
  e) Por que o peixe beijador recebe este nome?
  f) Por que o peixe espada recebe este nome?
  g) Quais os outros nomes do peixe Poecilia reticulata?
  h) Qual o tipo mais comum do peixe molinésia?
6. Sobre a criação dos peixes, responder o seguinte:
  a) Por que não é apropriado criar o peixe Symphysodon discus junto com outras espécies de peixes no mesmo aquário?
  b) Por que o peixe Poecilia reticulada não deve ser criado com peixes maiores que ele no meio ambiente?
  c) Por que os filhotes de Poecilia reticulada devem ser separados dos adultos logo após o nascimento?
  d) Por que não deve fazer uso de criadeira nos aquários?
7. De um só cruzamento, quantas vezes a fêmea lebiste pode dar crias?
8. Qual a função do peixe Liposarcus spp em um aquário?
9. Criar pelo menos uma espécie de peixe ornamental no período mínimo de um mês. Apresentar relatório com fotos.'),
('EN-104', 'Primatas', 'estudos-da-natureza', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/en-104.webp', 'https://mda.wiki.br/Especialidade_de_Primatas', '1. Quais são as principais características dos primatas?
2. Responder os itens abaixo:
  a) Qual a maior espécie de primata do mundo? Qual a maior em seu país? Apresentar fotos/imagens;
  b) Quantas espécies de macacos existem em seu país?
  c) Quais são as menores espécies de lêmures do mundo? Apresentar fotos/imagens;
  d) Quais são os nomes populares do macaco Brachyteles arachnoides?
  e) Quais são os três tipos de macaco-aranha?
  f) Que espécie de macaco brasileiro foi quase extinta pelo fato de serem mortos para se extrair suas caudas para fazer espanadores que eram exportados para a europa?
  g) Qual o único primata das Américas capaz de usar objetos como ferramentas para obter comida?
  h) Qual o percentual de primatas existentes na Amazônia em comparação com o mundo?
3. Explicar a etimologia da palavra macaco.
4. Citar os nomes das espécies de macacos típicas do seu país.
5. Qual é a principal diferença entre macacos e símios?
6. Quais são os benefícios e malefícios dos macacos para o ser humano?
7. Qual o nome do campo da ciência que estuda os primatas?'),
('EN-105', 'Quelônios', 'estudos-da-natureza', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/en-105.webp', 'https://mda.wiki.br/Especialidade_de_Quelônios', '1. Descrever as principais características dos quelônios e dizer por que os quelônios são classificados como répteis.
2. Por quais outros nomes os quelônios são conhecidos?
3. Quais são as duas linhagens (subordens) de quelônios?
4. Fazer uma ilustração da anatomia interna de uma tartaruga.
5. Citar:
  a) Cinco espécies de quelônios terrestres;
  b) Cinco espécies de quelônios de água doce;
  c) Três espécies de quelônios gigantes.
6. Escolher uma espécie de cada uma das opções do item anterior e descrever, de cada uma, os nomes populares e o nome científico, as características físicas, hábitos, alimentação, reprodução e outras curiosidades.
7. Responder as seguintes perguntas:
  a) Qual o principal fator para o desenvolvimento dos ovos dos quelônios?
  b) Qual a alimentação dos quelônios terrestres e aquáticos?
  c) Como é a respiração dos quelônios?
  d) Qual a principal ameaça para esses répteis?
  e) Quantos anos viveu o quelônio mais velho do mundo?
  f) Como é feita a diferenciação entre jabuti macho e fêmea?
  g) Qual a maior espécie de tartaruga marinha do mundo?
  h) Entre mil filhotes de tartarugas marinhas, quantos chegam à idade adulta?
  i) Quais são os fatores que fazem com que muitas tartarugas ao nascer não cheguem ao mar?
  j) Qual a espécie de tartaruga marinha mais ameaçada de extinção?
8. Por que a preservação dos quelônios é importante para o ser humano? Como a poluição do mar se torna prejudicial para as tartarugas?
9. Como as tartarugas marinhas fazem uso do olfato, audição e visão em relação ao seu ciclo de reprodução?
10. Como as tartarugas marinha fêmeas conseguem retornar à praia onde nasceram para desovar?
11. O que é responsável pela maioria das mortes acidentais dos quelônios marinhos em todo o mundo?
12. Cumprir um dos itens abaixo:
  a) Visitar uma instituição que atua no cuidado, preservação e prevenção de extinção de tartarugas. Fazer um relatório registrando como é a atuação daquela instituição e quais os pontos que você mais achou interessante;
  b) Pesquisar na internet sobre uma instuição que atua no cuidado, preservação e prevenção de extinção de tartarugas. Fazer um relatório de pelo menos 300 palavras descrevendo a história da instituição, como ela atua e quais resultados já foram observados até hoje;
  c) Participar de uma campanha de conscientização na sua comunidade sobre a preservação e a prevenção da extinção de tartarugas.'),
('EN-106', 'Vulcões', 'estudos-da-natureza', 'especialidade', 2, 2025, 'Divisão Sul Americana', '/esp/en-106.webp', 'https://mda.wiki.br/Especialidade_de_Vulcões', '1. O que é vulcanismo? Ilustrar o ciclo natural dos vulcões.
2. Desenhar um diagrama da anatomia de um vulcão.
3. Qual a relação entre o vulcanismo e a tectônica de placas?
4. Definir os seguintes termos:
  a) Magma;
  b) Lava;
  c) Ponto quente (hotspot);
  d) Fluxo piroclástico;
  e) Rocha ígnea;
  f) Xenólito;
  g) Dique;
  h) Estratovulcões;
  i) Vulcões-escudo;
  j) Caldeira;
  k) Necks;
  l) Lahar;
  m) Círculo de fogo.
5. Quais são as três principais categorias de lava e suas características?
6. Como são formadas as ilhas vulcânicas?
7. O que é obsidiana? Por que ela não é considerada um mineral?
8. Por que um vulcão pode se tornar explosivo?
9. Como os vulcões podem ser benéficos para a natureza e para o homem?
10. Quais são os parâmetros para prever uma erupção vulcânica?
11. Qual é o maior vulcão do mundo? E qual é o maior vulcão do sistema solar?
12. Escolher 10 vulcões, incluido pelo menos très que estejam em seu continente, e listar as seguintes informações sobre eles:
  a) Nome;
  b) Imagem;
  c) Localização;
  d) Tamanho;
  e) Última erupção'),
('EN-107', 'Bromélias', 'estudos-da-natureza', 'especialidade', 1, 2025, 'Divisão Sul Americana', '/esp/en-107.webp', 'https://mda.wiki.br/Especialidade_de_Bromélias', '1. Quais as principais características das bromélias?
2. Por que as bromélias receberam esse nome e como elas eram chamadas?
3. A que família pertencem as bromélias?
4. Fazer um desenho de uma bromélia indicando suas partes.
5. As bromélias epífitas podem ser consideradas como parasitas? Explicar.
6. Qual o habitat das bromélias? As bromélias são nativas de quais continentes?
7. Citar exemplos de espécies de bromélias:
  a) Epífitas;
  b) Rupestres;
  c) Terrestres;
  d) Ornamentais;
  e) Carnívoras;
  f) Comestíveis;
  g) Medicinais.
8. Qual a relação entre as bromélias e os pernilongos e entre as bromélias e os anuros que vivem em florestas/matas?
9. Por que a bromélia-imperial (Alcantarea imperialis) é tão resistente, a ponto de sobreviver mesmo se tiver suas raízes cortadas?
10. A que tamanho pode chegar a maior bromélia do mundo?
11. Quais os principais polinizadores das bromélias?
12. Quais os principais problemas no cultivo das bromélias e como solucioná-los?
13. Por que não se deve coletar as bromélias na natureza? Qual a importância ecológica das bromélias?
14. Fazer uma coleção de fotos de, no mínimo, 15 espécies diferentes de bromélias, com seus respectivos nomes populares e científicos.'),
('HD-001', 'Arte Culinária', 'habilidades-domesticas', 'especialidade', 2, 1928, 'Associação Geral', '/esp/hd-001.webp', 'https://mda.wiki.br/Especialidade_de_Arte_Culinária', '1. Saber operar devidamente o tipo de fogão que há em sua casa. Saber como prevenir pequenos incêndios por óleo ou gordura em seu fogão e saber como apagá-los. Conhecer as medidas de segurança enquanto estiver cozinhando, incluindo a preocupação com crianças pequenas.
2. Saber como usar devidamente utensílios de medidas (colheres, xícaras e copo medidor), batedor de claras, peneiras de farinha, e, se tiver, balança, batedeira ou mixer elétrico e liquidificador.
3. Explicar as seguintes técnicas de preparo de alimentos:
  a) Cozer
  b) Grelhar
  c) Fritar
  d) Refogar
  e) Assar
4. Quais as maneiras mais saudáveis de cozinhar alimentos? E as menos saudáveis? Por quê?
5. Preparar corretamente: 2 tipos de mingau de cereais cozidos , 1 bebida quente saudável, ovos feitos de 2 maneiras que não a fritura.
6. Preparar o seguinte, de maneira saudável:
  a) Batata, 2 maneiras
  b) 3 vegetais de sua escolha
7. Preparar um almoço vegetariano balanceado, incluindo alimentos construtores, reguladores e energéticos, contendo:
  a) 1 prato principal
  b) 3 acompanhamentos
  c) 1 salada crua
8. Colocar a mesa corretamente e servir essa refeição para a sua família.
9. Qual a importância de ingerir verduras cruas diariamente?
10. Fazer um caderno (ou pasta) de receitas contendo, no mínimo, 10 receitas que você tenha feito.'),
('HD-002', 'Técnicas de Lavanderia', 'habilidades-domesticas', 'especialidade', 3, 1928, 'Associação Geral', '/esp/hd-002.webp', 'https://mda.wiki.br/Especialidade_de_Técnicas_de_Lavanderia', '1. Saber interpretar os símbolos usados em etiquetas de roupas. Desenhar os símbolos correspondentes a:
  a) Temperatura máxima de lavagem
  b) Lavar à mão
  c) Não lavar
  d) Temperatura máxima da base do ferro de passar a 200°
  e) Temperatura máxima da base do ferro de passar a 150°
  f) Temperatura máxima da base do ferro de passar a 110°
  g) Não passar
  h) Secagem em varal
  i) Secagem na horizontal
  j) Secagem por gotejamento
  k) Permitido alvejante com cloro
  l) Não alvejar / não branquear
  m) Não limpara seco
2. Saber preparar e separar as roupas para lavar. Quais tipos de tecido não podem ser lavados à máquina?
3. Saber como identificar se um tecido desbota. Caso desbote, quais os cuidados necessários ao lavá-lo e secá-lo?
4. Por que não se deve deixar as roupas sujas guardadas, especialmente se estiverem úmidas?
5. Descrever os principais cuidados ao utilizar os seguintes alvejantes ou substâncias para tirar manchas:
  a) Cloro (água sanitária)
  b) Produtos à base de peróxido de hidrogênio (água oxigenada)
  c) Amônia
  d) Tiner
  e) Aguarrás
  f) Vinagre
6. Por que não se deve usar, numa mesma lavagem, mais de um tipo das substâncias acima?
7. Quais aspectos devem ser considerados ao se escolher uma máquina de lavar roupas para a sua família?
8. Saber como lavar os seguintes tipos de tecidos:
  a) Lã
  b) Couro natural ou artificial
  c) Camurça
  d) Renda
9. Saber como remover manchas de: tinta, frutas, ferrugem, grama, chocolate, gordura, sangue, chiclete. Por que as manchas devem ser totalmente removidas antes da roupa ser lavada?
10. Por que é importante retirar as roupas de uma máquina de lavar/secadora imediatamente após o ciclo de lavagem/secagem terminar?
11. Comparar um ferro de passar comum e um ferro a vapor. Quais as vantagens e desvantagens de cada um deles?
12. Passar, dobrar e guardar corretamente os seguintes tipos de roupas:
  a) Roupas de cama
  b) Calça jeans
  c) Calça social
  d) Saia
  e) Camisa
  f) Camiseta
  g) Uniforme oficial
13. Cumprir os seguintes requisitos:
  a) Lavar, dobrar e guardar as roupas de sua família por um mês (caso use máquina de lavar) ou por uma semana (caso seja à mão).
  b) Lavar à mão (no tanque, na bacia, no rio) corretamente, pelo menos, duas peças de roupa (peças íntimas não contam).
  c) Passar, dobrar e guardar corretamente as suas roupas durante, pelo menos, duas semanas.
  d) Manter o seu guarda-roupa ou cômoda organizados por, no mínimo, um mês.
14. Apresentar relatório com suas observações sobre facilidades e dificuldades no processo.'),
('HD-003', 'Cuidado de Bebês', 'habilidades-domesticas', 'especialidade', 2, null, 'Divisão Euro-Africana', '/esp/hd-003.webp', 'https://mda.wiki.br/Especialidade_de_Cuidado_de_Bebês', '1. Até que idade uma criança é considerada um bebê?
2. Ser capaz de cuidar de um bebé durante, no mínimo, 5 horas em, pelo menos, 3 dias de 1 semana.
3. Quais alimentos não devem ser dados a um bebê menor que 1 ano? Relacionar todas as precauções que devem ser tomadas ao se preparar alimentos para um bebê. Preparar um alimento e alimentar o bebê.
4. Preparar o banho, dar banho, trocar o bebê, e vesti-lo. Explicar quais os cuidados são recomendados para vestir um bebe. Que tipos de tecidos devem ser evitados com contato com pele e por quê?
5. Explicar quais são as recomendações dos especialistas para garantir um sono seguro para o bebê. Preparar o berço do bebê, e colocá-lo para dormir.
6. Qual é o peso normal de um bebê ao nascer? Qual é o esperado para 6 e 12 meses? Veja a curva de crescimento do bebê que você está cuidando(disponível na sua caderneta de saúde) e compare com os valores esperados. O que se deve fazer para que um bebê tenha um crescimento adequado? (Caso não tenha acesso à caderneta de saúde do bebê que esta cuidando, você pode analisar a sua própria curva de crescimento, ou de algum familiar ou amigo próximo).
7. Responder o seguinte:
  a) Quais são os benefícios da amamentação para a mãe e seu bebê?
  b) Quanto tempo um bebê deve manter exclusivamente no seio da mãe? O que é desmamar?
  c) Quais são as recomendações da Organização Mundial de Saúde e da UNICEF sobre amamentação?
  d) Por que mamadeiras e chupetas devem ser evitadas?
8. O que é fontanela (moleira)? Por volta de que idade ela desaparece?
9. Entrevistar funcionários de uma creche e perguntar a respeito do trabalho ali, e da ajuda oferecida às mães.
10. Conhecer o cartão da criança do seu país e dizer quais as informações básicas são encontradas nele.
11. Conhecer o calendário de vacinação básica do seu país. Quais as vacinas fazem parte dele? Elas previnem quais doenças? Quando devem ser administradas? Conferir o seu cartão de vacinação e o do bebê que você está cuidado. Caso esteja incompleto, comunique à sua mãe e/ou à mãe do bebê para procurarem um centro de saúde e atualizá-lo.
12. Citar 4 dificuldades ou sinais de alarme que um bebê pode apresentar e indicar a necessidade de uma consulta em um posto de saúde ou pronto socorro.
13. Conhecer os principais números de emergência do seu país, como, por exemplo, polícia, bombeiros e serviço médico.'),
('HD-004', 'Cuidados da Casa', 'habilidades-domesticas', 'especialidade', 3, 1929, 'Associação Geral', '/esp/hd-004.webp', 'https://mda.wiki.br/Especialidade_de_Cuidados_da_Casa', '1. Fazer uma lista dos produtos e utensílios de limpeza usados em uma casa.
2. Descrever como manter fogões, fornos micro-ondas e/ou elétricos e geladeiras limpos.
3. Sob que condições os micro-organismos e pragas de insetos se desenvolvem? Saber limpar cada um dos itens a seguir: armário de roupas, armário de cozinha, pias e sanitários.
4. Descrever a maneira adequada de preparar a louça para ser lavada, quer na pia quer na máquina lava-louças. Lavar corretamente a louça da sua casa diariamente por, no mínimo, 1 mês.
5. Saber como limpar tapetes, carpetes, travesseiros, móveis estofados, paredes com acabamento de papel de parede, paredes pintadas, pisos e janelas.
6. Saber como é o sistema de coleta de lixo em sua região. Separar corretamente o lixo em sua casa.
7. Como manter uma casa segura para crianças? Cite, pelo menos, 5 atitudes, envolvendo cuidados com eletricidade, produtos químicos, objetos perfurocortantes e cuidados ao cozinhar.
8. Manter a sua casa limpa e organizada por, no mínimo, 1 mês, incluindo:
  a) Lavar o chão
  b) Tirar o pó
  c) Trocar as roupas de cama, capas de almofadas e forros e toalhas de mesa
  d) Arrumar as camas
  e) Guardar tudo em seu devido lugar
  f) Lavar o banheiro
  g) Tirar o lixo'),
('HD-005', 'Técnicas de Fazer Conserva', 'habilidades-domesticas', 'especialidade', 3, 1929, 'Associação Geral', '/esp/hd-005.webp', 'https://mda.wiki.br/Especialidade_de_Técnicas_de_Fazer_Conserva', '1. Descrever os seguintes métodos para a conservação de alimentos:
  a) Pasteurização
  b) Esterilização
  c) Tindalização
  d) Apertização
  e) Solução salina (salinização)
  f) Compota
2. Listar os utensílios necessários para preparar conservas domésticas.
3. Quais são as técnicas para a higienização de:
  a) Alimentos
  b) Utensílios
  c) Superfície de trabalho
4. Fazer uma lista dos alimentos comuns em sua região que são bons para fazer conservas.
5. Demonstrar como selecionar, descascar e picar os alimentos para preparar a conserva.
6. Demonstrar como esterilizar, encher, fechar e testar para ver se os frascos estão bem fechados.
7. Como fechar hermeticamente ou a vácuo um pote de conserva em casa?
8. O que é pectina? Quando ela deve ser utilizada?
9. Quais são os sinais de que uma conserva não está mais adequada para o consumo?
10. O que é botulismo? Pelo que é causado? Quais são os sinais e sintomas dessa doença?
11. Fazer duas das seguintes conservas e apresentar ao instrutor para degustação:
  a) Suco de frutas
  b) Verdura ou legume
  c) Fruta
  d) Doce ou geleia'),
('HD-006', 'Orçamento Familiar', 'habilidades-domesticas', 'especialidade', 2, 1935, 'Associação Geral', '/esp/hd-006.webp', 'https://mda.wiki.br/Especialidade_de_Orçamento_Familiar', '1. O que é Orçamento Familiar e qual a importância de fazê-lo?
2. Fazer uma lista das despesas de sua família e classificá-las em necessárias, úteis e supérfluas.
3. Verificar a lista de compras de mantimentos e produtos de higiene e limpeza de sua família. Escrever quais itens você considera extremamente importantes e que não podem ser esquecidos e quais não são tão significativos e que poderiam ser trocados ou mesmos excluídos.
4. Descobrir qual é o melhor dia e local para se adquirir hortaliças, frutas e verduras em seu bairro.
5. O que você e sua família podem fazer para economizar água e energia elétrica?
6. Que impostos sua família precisa pagar? Em qual mês eles devem ser pagos?
7. Que tipos de compras nunca deveriam ser feitas a prazo? por quê?
8. O que são juros? Como devem ser calculados?
9. Pesquisar qual a taxa de juros e encargos financeiros nas linhas de crédito a seguir:
  a) Cartão de crédito
  b) Empréstimo pessoal
10. Que medidas devem ser tomadas quando a família está endividada?
11. Qual porcentagem da renda de uma família deve ser poupada? E por quê?
12. Pesquisar ao menos 2 métodos, além da caderneta de poupança, para investir o dinheiro poupado. Quais as vantagens e desvantagens de cada um?
13. Saber fazer o seguinte:
  a) Preencher recibos
  b) Pagar boletos e/ou faturas em um terminal de autoatendimento ou por smartphones
  c) Arquivar recibos de pagamentos
  d) Interpretar um extrato de conta corrente/poupança
  e) Pagar contas e fazer compras pela internet
14. Manter um Orçamento pessoal e relatório de entrada e saída de dinheiro durante, pelo menos, 1 mês.
15. Montar um orçamento familiar e manter um relatório preciso de entradas e saídas durante 1 mês (desbravadores mais jovens podem fazer isto em conjunto com os pais); os garotos e garotas que vivem em fazendas, podem fazer relatório ligados a agricultura, laticínios ou gado.
16. Ler Malaquias 3:8-12 e escrever, no mínimo, 250 palavras sobre o que significa, para você, ser um mordomo fiel.'),
('HD-007', 'Panificação', 'habilidades-domesticas', 'especialidade', 3, 1945, 'Associação Geral', '/esp/hd-007.webp', 'https://mda.wiki.br/Especialidade_de_Panificação', '1. Explicar a diferença entre o valor nutricional da farinha integral e da farinha branca.
2. Comparar o fermento biológico e o fermento químico. Como é a ação de cada um deles na massa? Para quais receitas cada um deles é mais indicado?
3. Citar uma passagem do Velho Testamento e uma do Novo Testamento onde o fermento é mencionado. Explicar qual o significado do fermento na celebração da páscoa.
4. Preparar um pão com grãos inteiros (pode ser trigo, centeio, aveia, linhaça, etc.).
5. Preparar 2 das opções a seguir:
  a) Biscoitos salgados
  b) Biscoitos doces
  c) Pães asmos (sem fermento)
  d) Baguetes
  e) Pão italiano
  f) Pão sovado
6. Explicar por que a mistura de leite, açúcar e ovos é prejudicial à saúde.
7. Como testar se um bolo está pronto? Como evitar que o bolo abaixe”?
8. Preparar 2 das opções a seguir:
  a) Bolo de ingredientes básicos (qualquer sabor)
  b) Bolo feito com mistura pronta de bolo (qualquer sabor)
  c) Bolo de frutas ou castanha
  d) Bolo sem a utilização de leite ou derivados
  e) Bolo que não contenha glúten
9. Fazer uma torta em cada uma das categorias a seguir (não usar muito açúcar, creme de leite ou leite condensado):
  a) Assada, de qualquer fruta, incluindo limão
  b) Não assada (apenas de massa assada no forno): frutas frescas, gelatina, etc.
  c) Salgada (vegetariana de qualquer sabor)
10. Fazer e assar uma receita de biscoitos. Usar ingredientes saudáveis como frutas, aveia, castanhas, etc.
11. Demonstrar como utilizar corretamente colheres e xícaras de medida. Por que é importante seguir atentamente as receitas na panificação?
12. Preparar um arquivo de receitas para todos os itens exigidos acima e quaisquer outros que desejar. Veja quantas receitas é capaz de encontrar que usem frutas sem grandes quantidades de açúcar.'),
('HD-008', 'Arte Culinária - avançado', 'habilidades-domesticas', 'especialidade', 3, 1956, 'Associação Geral', '/esp/hd-008.webp', 'https://mda.wiki.br/Especialidade_de_Arte_Culinária_-_avançado', '1. Ter a especialidade de Arte Culinária.
2. 1 litro contém quantos ml? 1 xícara contém quantas colheres de sopa? 1 colher de sopa contém quantas colheres de chá?
3. Conhecer os diferentes tipos de forno disponíveis no mercado e as vantagens e desvantagens de cada um.
4. O que é intoxicação alimentar? Como preveni-la?
5. Saber por quanto tempo os seguintes alimentos podem ser guardados na geladeira:
  a) Leite
  b) Ovos crus
  c) Ovos cozidos
  d) Maionese
  e) Carne
  f) Sobras de comida
  g) Hortaliças
6. Conhecer e praticar as boas práticas de higiene ao preparar/manipular alimentos.
7. Preparar 3 tipos de saladas. Como se faz para manter as verduras das saladas frescas?
8. Planejar cardápios contendo café da manhã, almoço e jantar para 1 semana, escolhendo, pelo menos, três pratos nos quais sobras de outras refeições possam ser utilizados.
9. Preparar 1 desjejum equilibrado.
10. Preparar o almoço ou o jantar balanceado para sua família durante, pelo menos, 5 dias. (Podem ser dias seguidos ou finais de semana).
11. Saber cozinhar arroz integral e soja corretamente.
12. Explicar por que devemos ter cuidado ao utilizar ingredientes pouco saudáveis, como:
  a) Vinagre
  b) Shoyu ou molho de soja
  c) Glutamato monossódico (presente em temperos prontos)
  d) Enlatados
  e) Embutidos
13. O que a cafeína faz ao corpo? Fazer uma lista de, pelo menos, 5 alimentos que contêm cafeína.
14. Preparar 15 receitas, sendo que, no máximo, 5 poderão ser de doces ou sobremesas. Adicioná-las ao seu caderno (ou pasta) de receitas. Obs.: As receitas preparadas na especialidade de Arte culinária não contam para esse requisito.'),
('HD-009', 'Costura Básica', 'habilidades-domesticas', 'especialidade', 2, 1976, 'Associação Geral', '/esp/hd-009.webp', 'https://mda.wiki.br/Especialidade_de_Costura_Básica', '1. Descrever o uso apropriado do seguinte:
  a) Fita métrica
  b) Tesouras
  c) Agulhas de vários tamanhos e tipos (para costurar à mão ou à maquina)
  d) Giz
2. Familiarizar-se com uma máquina de costura. Identificar:
  a) Puxador de linha
  b) Pé calçador
  c) Levantador de pé calçador
  d) Alimentador da bobina (se estiver visível)
  e) Serrilha
  f) Regulador ou tensor de ponto
3. Demonstrar como colocar a linha na máquina e fazê-la funcionar corretamente.
4. Fazer barra numa toalha de mesa ou lençol, em que os pontos fiquem bem feitos e por igual.
5. Saber pregar botões, fazer casas de botões, pregar colchetes e ganchos, bainha com ponto invisível e alinhavar.
6. Dizer o significado de:
  a) Orla
  b) Viés
  c) Direção do fio
  d) Enviesado
  e) Nesga
7. Saber como cerzir (remendar) corretamente.
8. Fazer um dos seguintes:
  a) Avental
  b) Par de fronhas
  c) Sacola de pano'),
('HD-010', 'Comidas Típicas', 'habilidades-domesticas', 'especialidade', 3, null, 'Associação Geral', '/esp/hd-010.webp', 'https://mda.wiki.br/Especialidade_de_Comidas_Típicas', '1. Pesquisar ao menos um ingrediente originário para cada região do seu país.
2. Conhecer alguns dos diferentes temperos utilizados em cada região do seu país.
3. Conhecer, ao menos, 3 métodos peculiares de preparação de alimentos (ex. cozimento em folha de bananeira).
4. Citar, ao menos, uma comida típica de cada um dos países que compõem a Divisão Sul-Americana.
5. Descrever os ingredientes e o modo de preparo de cada uma das comidas típicas do requisito anterior.
6. Preparar e servir, para sua unidade, uma comida típica que não seja do seu país.
7. Conhecer, ao menos, uma comida típica de cada região de seu país e preparar 2 delas para sua família ou unidade.'),
('HD-011', 'Congelamento de Alimentos', 'habilidades-domesticas', 'especialidade', 3, 1986, 'Associação Geral', '/esp/hd-011.webp', 'https://mda.wiki.br/Especialidade_de_Congelamento_de_Alimentos', '1. Quais são as vantagens e desvantagens dos alimentos congelados?
2. Definir os termos a seguir:
  a) Escaldar/branquear
  b) Congelamento rápido
  c) Queimadura de congelamento
3. Fazer uma lista de ao menos 5 alimentos que podem ser congelados.
4. Quais os recipientes mais indicados para congelar alimentos? Por que não deve ser utilizado recipiente de vidro ou isopor?
5. Que pontos essenciais devem ser considerados quando se seleciona alimentos para serem congelados?
6. Demonstrar como fazer a correta higienização do freezer/congelador onde os alimentos serão armazenados.
7. Por que é importante etiquetar os recipientes dos alimentos congelados? Que materiais devem ser utilizados para esse fim? Quais informações devem conter na etiqueta?
8. O que é ácido ascórbico e qual sua utilidade no congelamento de frutas?
9. Como se deve descongelar e servir os seguintes alimentos:
  a) Frutas
  b) Verduras
  c) Legumes
  d) Massas
10. Congelar 2 tipos de legumes e depois prepará-los e servi-los como demonstração.
11. Congelar um tipo de fruta em calda.
12. Congelar um tipo de fruta sem utilizar nenhuma espécie de adoçante.
13. Congelar 2 tipos de pratos prontos (ex. lasanha, estrogonofe, etc.). Que precauções especiais devem ser tomadas durante o preparo desses alimentos?
14. Apresentar o período de validade de cada um dos alimentos dos requisitos 10 a 13.'),
('HD-012', 'Desidratação de Alimentos', 'habilidades-domesticas', 'especialidade', 3, 1986, 'Associação Geral', '/esp/hd-012.webp', 'https://mda.wiki.br/Especialidade_de_Desidratação_de_Alimentos', '1. O que é desidratação de alimentos? Quais suas vantagens?
2. Relacionar e descrever, pelo menos, 3 maneiras diferentes de desidratar alimentos.
3. Demonstrar como selecionar os alimentos para a desidratação.
4. Descrever como armazenar corretamente os alimentos desidratados.
5. Como se faz a reconstituição de alimentos desidratados?
6. Desidratar os seguintes alimentos e fornecer amostras para degustação:
  a) Fruta
  b) Vegetal
  c) Carne vegetal
  d) Ervas
7. Reconstituir uma fruta ou legume e prepará-lo para degustação.'),
('HD-013', 'Produção de Pizza', 'habilidades-domesticas', 'especialidade', 1, 2014, 'Divisão Intereuropeia', '/esp/hd-013.webp', 'https://mda.wiki.br/Especialidade_de_Produção_de_Pizza', '1. Fazer uma breve pesquisa sobre a história da pizza.
2. Fazer uma lista dos ingredientes básicos da massa de pizza.
3. Descrever o processo de fermentação.
4. Qual é a diferença entre a pizza napoliana e a romana?
5. Quais são as três maneiras diferentes de assar uma pizza. Descrever as diferenças em detalhes.
6. Qual é a temperatura ideal para assar uma pizza em: forno à lenha e em forno elétrico?
7. Preparar uma pizza margherita.'),
('ME-001', 'ADRA', 'mestrados', 'mestrado', 2, 2012, 'Associação Geral', '/esp/me-001.webp', 'https://mda.wiki.br/Mestrado_em_ADRA', '1. Ter 7 especialidades em ADRA (AD).'),
('ME-002', 'Artes e Habilidades Manuais', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-002.webp', 'https://mda.wiki.br/Mestrado_em_Artes_e_Habilidades_Manuais', '1. Ter sete especialidades em Artes e habilidades manuais (HM).'),
('ME-003', 'Atividades Agrícolas', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-003.webp', 'https://mda.wiki.br/Mestrado_em_Atividades_Agrícolas', '1. Ter sete especialidades em Atividades agrícolas e afins (AA).'),
('ME-004', 'Testificação', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-004.webp', 'https://mda.wiki.br/Mestrado_em_Testificação', '1. Ter sete das seguintes especialidades:
  • Adoração cristã (AM 029)
  • Apocalipse (AM 052)
  • Arqueologia bíblica (AM 032)
  • Arte da pregação cristã (AM 030)
  • Arte da pregação cristã - avançado (AM 031)
  • Arte de contar histórias cristãs (AM 001)
  • Arte em fantoches (AM 002)
  • Arte em fantoches - avançado (AM 003)
  • Asseio e cortesia cristã (AM 011)
  • Aventuras com Cristo (AM 016)
  • Aventuras com Cristo - avançado (AM 017)
  • Braile (AM 034)
  • Cidadania cristã (AM 006)
  • Colportagem (AM 005)
  • Criacionismo (AM 035)
  • Criacionismo - avançado (AM 036)
  • Crítico de mídia (AM 053)
  • Dramatização cristã (AM 024)
  • Escatologia (AM 038)
  • Espírito de profecia (AM 037)
  • Etnologia missionária (AM 004)
  • Evangelismo pessoal (AM 008)
  • Evangelismo web (AM 040)
  • Evangelismo web - avançado (AM 041)
  • Historiador eclesiástico (AM 039)
  • Intercessor (AM 042)
  • Interpretação bíblica (AM 057)
  • Investigador bíblico I (AM 047)
  • Liderança juvenil (AM 009)
  • Língua de sinais (AM 014)
  • Língua de sinais - avançado (AM 018)
  • Lives - transmissão de cultos online (AM 058)
  • Livro de Daniel (AM 054)
  • Marcação bíblica (AM 019)
  • Marcação bíblica - avançado (AM 020)
  • Mensageira de Deus (AM 049)
  • Mordomia (AM 015)
  • Padificador (AM 027)
  • Padificador- avançado (AM 028)
  • Parábolas de Jesus (AM 059)
  • Pioneiros adventistas (AM 043)
  • Pregador evangelista (AM 021)
  • Pregador evangelista - avançado (AM 022)
  • Relacionamentos saudáveis (AM 060)
  • Santuário (AM 023)
  • Sonoplastia (AM 045)
  • Sonoplastia - avançado (AM 046)
  • Temperança (AM 013)
  • Testemunho juvenil (AM 010)
  • Vida familiar (AM 012)'),
('ME-005', 'Atividades Profissionais', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-005.webp', 'https://mda.wiki.br/Mestrado_em_Atividades_Profissionais', '1. Ter sete das seguintes especialidades:
  • Administração (AP 037)
  • Alvenaria (AP 013)
  • Barbearia (AP 014)
  • Biblioteconomia (AP 040)
  • Cães - cuidado e treinamento (AP 029)
  • Carpintaria (AP 007)
  • Colocação de papel de parede (AP 015)
  • Conserto de sapatos (AP 001)
  • Contabilidade (AP 016)
  • Corte e costura (AP 008)
  • Corte e costura - avançado (AP 025)
  • Cuidados e manutenção de violões (AP 048)
  • Desenvolvimento de software (AP 049)
  • Eletricidade (AP 006)
  • Eletrônica (AP 050)
  • Encadernação (AP 012)
  • Evangelismo (AP 017)
  • Fotografia (AP 002)
  • Hidráulica (AP 018)
  • Informática programável (AP 052)
  • Intérprete de língua de sinais (AP 051)
  • Jornalismo (AP 019)
  • Logística (AP 065)
  • Magistério (AP 024)
  • Manutenção de bicicletas (AP 053)
  • Marcenaria (AP 011)
  • Marketing (AP 054)
  • Marketing - avançado (AP 055)
  • Mecânica automotiva (AP 003)
  • Mecânica de pequenos motores (AP 028)
  • Modelagem têxtil (AP 056)
  • Montagem e manutenção de computadores (AP 057)
  • Noções de Direito (AP 066)
  • Noções de economia (AP 058)
  • Ofício de alfaiate (AP 020)
  • Operação e manutenção de impressoras (AP 059)
  • Pintura de paredes exteriores (AP 021)
  • Pintura de paredes interiores (AP 022)
  • Produção de vídeo (AP 032)
  • Radioamadorismo (AP 004)
  • Restauro e conservação documental (AP 060)
  • Secretariado (AP 061)
  • Segurança contra incêndios (AP 068)
  • Silvicultura (AP 036)
  • Soldagem (AP 031)
  • Taquigrafia (AP 009)
  • Tipografia (AP 010)
  • Vendas (AP 033)
  • Web designer (AP 063)
  • Web designer - avançado (AP 064)'),
('ME-006', 'Ciência e Tecnologia', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-006.webp', 'https://mda.wiki.br/Mestrado_em_Ciência_e_Tecnologia', '1. Ter sete das seguintes especialidades:
  • Computação I - básico (AP 041)
  • Computação II - médio (AP 042)
  • Computação III - regular (AP 043)
  • Computação IV - avançado (AP 044)
  • Computação V - especialista (AP 045)
  • Desenvolvimento de software (AP 049)
  • Eletrônica (AP 050)
  • Experimentos científicos (CS 038)
  • Física (CS 013)
  • Habilidades em matemática I (CS 031)
  • Habilidades em matemática II (CS 032)
  • Informática programável (AP 052)
  • Internet (AP 034)
  • Internet - avançado (AP 035)
  • Metodologia de estudo (CS 025)
  • Ótica (CS 007)
  • Química (CS 002)
  • Segurança nas redes sociais (AP 067)
  • Web designer (AP 063)
  • Web designer - avançado (AP 064)'),
('ME-007', 'Aquática', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-007.webp', 'https://mda.wiki.br/Mestrado_em_Aquática', '1. Ter sete das seguintes especialidades:
  • Caiaque (AR 015)
  • Canoagem (AR 016)
  • Esqui aquático (AR 026)
  • Mergulho autônomo (AR 031)
  • Mergulho livre (AR 028)
  • Natação principiante I (AR 003)
  • Natação principiante II (AR 004)
  • Natação intermediário I (AR 005)
  • Natação intermediário II (AR 006)
  • Natação - avançado (AR 007)
  • Navegação (AR 018)
  • Rafting (AR 105)
  • Remo (AR 023)
  • Saltos ornamentais (AR 030)
  • Salvamento de afogados (AR 008)
  • Salvamento de afogados - avançado (AR 029)
  • Segurança básica na água (AR 090)
  • Vela (AR 019)'),
('ME-008', 'Esportes', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-008.webp', 'https://mda.wiki.br/Mestrado_em_Esportes', '1. Ter sete das seguintes especialidades:
  • Arco e flecha (AR 014)
  • Atletismo (AR 049)
  • Basquetebol (AR 064)
  • Ciclismo (AR 008)
  • Ciclismo - avançado (AR 042)
  • Cultura física (AR 002)
  • Equitação (AR 025)
  • Escalada (AR 034)
  • Escalada - avançado (AR 035)
  • Esportes adaptados (AR 094)
  • Esqui aquático (AR 026)
  • Exploração de cavernas (AR 037)
  • Exploração de cavernas - avançado (AR 038)
  • Futebol (AR 065)
  • Futsal (AR 097)
  • Ginástica acrobática (AR 043)
  • Handebol (AR 098)
  • Mountain biking (AR 063)
  • Rapel (AR 072)
  • Rapel - avançado (AR 073)
  • Rapel - instrutor (AR 074)
  • Softbol (AR 080)
  • Tênis de mesa (AR 107)
  • Triathlon (AR 075)
  • Vôlei (AR 108)'),
('ME-009', 'Vida Campestre', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-009.webp', 'https://mda.wiki.br/Mestrado_em_Vida_Campestre', '1. Ter sete das seguintes especialidades:
  • Acampamento consciente (AR 112)
  • Acampamento em baixas temperaturas (AR 033)
  • Acampamento I (AR 050)
  • Acampamento II (AR 051)
  • Acampamento III (AR 052)
  • Acampamento IV (AR 053)
  • Acampamento seguro (AR 084)
  • Acampamento seguro - avançado (AR 085)
  • Arte de acampar (AR 001)
  • Artes mateiras (AR 113)
  • Comida mateira (AR 115)
  • Construções rústicas de grande porte (AR 116)
  • Cozinha com forno holandês (AR 070)
  • Escalada em árvores (AR 036)
  • Excursionismo pedestre (AR 010)
  • Excursionismo pedestre - avançado (AR 055)
  • Excursionismo pedestre com mochila (AR 056)
  • Excursionismo pedestre com mochila - avançado (AR 095)
  • Excursionismo pedestre na neve (AR 088)
  • Fogueiras e cozinha ao ar livre (AR 020)
  • Liderança campestre (AR 057)
  • Liderança campestre - avançado (AR 058)
  • Liderança na selva (AR 045)
  • Liderança na selva - avançado (AR 046)
  • Mapa e bússola (AR 021)
  • Nós e amarras (AR 040)
  • Nós e amarras - avançado (AR 099)
  • Orientação com GPS (AR 104)
  • Pioneirias (AR 101)
  • Pioneirias - avançado (AR 102)
  • Pioneirismo (AR 022)
  • Plantas silvestres comestíveis (EN 043)
  • Trilha de sinais (AR 120)
  • Vida silvestre (AR 024)'),
('ME-010', 'Atividades Recreativas', 'mestrados', 'mestrado', null, 1986, 'Associação Geral', '/esp/me-010.webp', 'https://mda.wiki.br/Mestrado_em_Atividades_Recreativas', '1. Ter sete das seguintes especialidades:
  • Aquarismo (EN 068)
  • Boliche (AR 091)
  • Bolinha de gude (AR 114)
  • Carrinho de rolimã (AR 092)
  • Colecionador (AR 093)
  • Cubo mágico (AR 118)
  • Evolução em ordem unida (AR 110)
  • Fanfarra (AR 071)
  • Filatelia (AR 011)
  • Futebol de botão (AR 096)
  • Geocaching (AR 067)
  • Geocaching - avançado (AR 068)
  • Nós e amarras (AR 040)
  • Nós e amarras - avançado (AR 099)
  • Numismática (AR 017)
  • Numismática - avançado (AR 062)
  • Ordem unida (AR 047)
  • Ordem unida - avançado (AR 048)
  • Ordem unida - instrutor (AR 100)
  • Patins (AR 103)
  • Pião (AR 106)
  • Pipas (AR 059)
  • Segurança básica na água (090)
  • Skate (AR 060)
  • Slackline (AR 119)
  • Troca de pins (AR 121)
  • Viagem e turismo (AR 086)
  • Viagem e turismo - avançado (AR 087)'),
('ME-011', 'Saúde', 'mestrados', 'mestrado', null, 1997, 'Associação Geral', '/esp/me-011.webp', 'https://mda.wiki.br/Mestrado_em_Saúde', '1. Ter sete das seguintes especialidades:
  • Alerta vermelho (CS 009)
  • Anatomia humana básica (CS 036)
  • Bactérias (EN 075)
  • Bioquímica (CS 021)
  • Biossegurança (CS 035)
  • Citologia (EN 077)
  • Coração e circulação (CS 020)
  • Digestão (CS 015)
  • Enfermagem básica (CS 006)
  • Hereditariedade (CS 019)
  • Higiene oral (CS 023)
  • Higiene oral - avançado (CS 024)
  • Inteligência emocional (AM 056)
  • Microscopia (CS 014)
  • Nutrição (CS 008)
  • Nutrição - avançado (CS 010)
  • Ossos, músculos e articulações (CS 016)
  • Plantas medicinais (CS 039)
  • Prevenção de doenças tropicais (CS 026)
  • Primeiros socorros - básico (CS 003)
  • Primeiros socorros - intermediário (CS 004)
  • Primeiros socorros - avançado (CS 005)
  • Protozoários (EN 091)
  • Reanimação cardiopulmonar (CS 011)
  • Remédios da natureza (CS 040)
  • Resgate básico (CS 012)
  • Sangue e defesas do corpo (CS 018)
  • Saúde e cura (CS 001)
  • Saúde mental (CS 028)
  • Sexualidade humana (CS 029)
  • Sistema nervoso (CS 017)
  • Sistema respiratório (CS 030)
  • Vacinas (CS 042)
  • Vírus (EN 095)
  • Zoonoses (CS 043)'),
('ME-012', 'Zoologia', 'mestrados', 'mestrado', null, null, 'Divisão do Sul do Pacífico', '/esp/me-012.webp', 'https://mda.wiki.br/Mestrado_em_Zoologia', '1. Ter sete das seguintes especialidades:
  • Abelhas e vespas (EN 096)
  • Anfíbios (EN 023}
  • Anfíbios - avançado (EN 054)
  • Animais migratórios (EN 097)
  • Animais nocivos (EN 071 )
  • Animais noturnos (EN 070)
  • Animais peçonhentos (EN 069)
  • Aranhas (EN 001)
  • Araras, papagaios e periquitos (EN 073)
  • Aves (EN 003)
  • Aves - avançado (EN 027)
  • Aves de estimação (EN 020)
  • Aves de rapina (EN 098)
  • Aves domésticas (EN 004)
  • Cães (EN 034)
  • Camelos (EN 076)
  • Cetáceos (EN 037)
  • Cigarras (EN 100)
  • Crustáceos (EN 078}
  • Equinodermos (EN 080)
  • Fauna marinha (EN 083)
  • Felinos (EN 024)
  • Felinos - avançado (EN 055)
  • Formigas (EN 085)
  • Insetos (EN 007)
  • Insetos - avançado (EN 030)
  • Mamíferos (EN 010)
  • Mamíferos - avançado (EN 031)
  • Mamíferos marinhos (EN 051)
  • Mariposas e borboletas (EN 008)
  • Marsupiais (EN 061)
  • Mimetismo e camuflagem (EN 102)
  • Moluscos (EN 014)
  • Moluscos - avançado (EN 032)
  • Morcegos (EN 059)
  • Morcegos - avançado (EN 060)
  • Odonata (EN 087)
  • Peixes (EN 022)
  • Peixes ornamentais (EN 103)
  • Pequenos mamíferos de estimação (EN 052)
  • Poríferos e cnidários (EN 090)
  • Primatas (EN 104)
  • Quelônios (EN 0105)
  • Rastreio de animais (EN 050)
  • Rastreio de animais - avançado (EN 056)
  • Rebanhos domésticos (EN 025)
  • Répteis (EN 011)
  • Répteis - avançado (EN 057)
  • Tubarões (EN 094)
  • Vermes (EN 065)
  • Vermes - avançado (EN 066)
  • Zoonoses (CS 043)'),
('ME-013', 'Ecologia', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-013.webp', 'https://mda.wiki.br/Mestrado_em_Ecologia', '1. Ter sete das especialidades:
  • Animais ameaçados de extinção (EN 058)
  • Araras, papagaios e periquitos (EN 073)
  • Compostagem doméstica (EN 101)
  • Conservação ambiental (EN 046)
  • Ecologia (EN 044)
  • Ecologia - avançado (EN 045)
  • Energias renováveis (EN 081)
  • Estuário (EN 082)
  • Preservação de recursos hídricos (EN 089)
  • Quedas d''água (EN 067)
  • Quelônios (EN 105)
  • Reciclagem e sustentabilidade (EN 092)
  • Reciclagem e sustentabilidade - avançado (EN 093)'),
('ME-014', 'Botânica', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-014.webp', 'https://mda.wiki.br/Mestrado_em_Botânica', '1. Ter sete das seguintes especialidades:
  • Algas (EN 036)
  • Arbustos (EN 019)
  • Arbustos - avançado (EN 072)
  • Árvores (EN 006)
  • Árvores - avançado (EN 033)
  • Briófitas (EN 074)
  • Bromélias (EN107)
  • Cactos (EN 015)
  • Cactos - avançado (EN 053)
  • Ervas (EN 038)
  • Eucaliptos (EN 039)
  • Fisiologia vegetal (EN 084)
  • Flores (EN 005)
  • Flores - avançado (EN 029)
  • Gramíneas (EN 021)
  • Liquens (EN 086)
  • Orquídeas (EN 042)
  • Orquídeas - avançado (EN 062)
  • Palmeiras (EN 063)
  • Plantas carnívoras (EN 088)
  • Plantas caseiras (EN 049)
  • Samambaias (EN 018)
  • Sementes (EN 040)
  • Sementes - avançado (EN 048)'),
('ME-015', 'Habilidades Domésticas', 'mestrados', 'mestrado', null, 1976, 'Associação Geral', '/esp/me-015.webp', 'https://mda.wiki.br/Mestrado_em_Habilidades_Domésticas', '1. Ter sete especialidades em Habilidades domésticas (HD).'),
('ME-016', 'Ensinos Bíblicos', 'mestrados', 'mestrado', null, 2025, 'Divisão Sul Americana', '/esp/me-016.webp', 'https://mda.wiki.br/Mestrado_em_Ensinos_Bíblicos', '1. Ter 14 especialidades em Ensinos bíblicos (AM-EB).')
on conflict (codigo) do update set nome = excluded.nome, categoria_slug = excluded.categoria_slug, tipo = excluded.tipo, nivel = excluded.nivel, ano = excluded.ano, origem = excluded.origem, imagem = excluded.imagem, url_mda = excluded.url_mda, requisitos = excluded.requisitos;

-- Especialidades duplicadas no wiki
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-001-203' and b.especialidade_codigo = 'AMEB-001' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-001' where especialidade_codigo = 'AMEB-001-203';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-001-203' and b.especialidade_codigo = 'AMEB-001' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-001' where especialidade_codigo = 'AMEB-001-203';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-001-203', 'AMEB-001') where 'AMEB-001-203' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-002-204' and b.especialidade_codigo = 'AMEB-002' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-002' where especialidade_codigo = 'AMEB-002-204';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-002-204' and b.especialidade_codigo = 'AMEB-002' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-002' where especialidade_codigo = 'AMEB-002-204';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-002-204', 'AMEB-002') where 'AMEB-002-204' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-003-205' and b.especialidade_codigo = 'AMEB-003' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-003' where especialidade_codigo = 'AMEB-003-205';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-003-205' and b.especialidade_codigo = 'AMEB-003' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-003' where especialidade_codigo = 'AMEB-003-205';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-003-205', 'AMEB-003') where 'AMEB-003-205' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-004-206' and b.especialidade_codigo = 'AMEB-004' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-004' where especialidade_codigo = 'AMEB-004-206';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-004-206' and b.especialidade_codigo = 'AMEB-004' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-004' where especialidade_codigo = 'AMEB-004-206';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-004-206', 'AMEB-004') where 'AMEB-004-206' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-005-207' and b.especialidade_codigo = 'AMEB-005' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-005' where especialidade_codigo = 'AMEB-005-207';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-005-207' and b.especialidade_codigo = 'AMEB-005' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-005' where especialidade_codigo = 'AMEB-005-207';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-005-207', 'AMEB-005') where 'AMEB-005-207' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-006-208' and b.especialidade_codigo = 'AMEB-006' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-006' where especialidade_codigo = 'AMEB-006-208';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-006-208' and b.especialidade_codigo = 'AMEB-006' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-006' where especialidade_codigo = 'AMEB-006-208';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-006-208', 'AMEB-006') where 'AMEB-006-208' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-007-209' and b.especialidade_codigo = 'AMEB-007' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-007' where especialidade_codigo = 'AMEB-007-209';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-007-209' and b.especialidade_codigo = 'AMEB-007' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-007' where especialidade_codigo = 'AMEB-007-209';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-007-209', 'AMEB-007') where 'AMEB-007-209' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-008-210' and b.especialidade_codigo = 'AMEB-008' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-008' where especialidade_codigo = 'AMEB-008-210';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-008-210' and b.especialidade_codigo = 'AMEB-008' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-008' where especialidade_codigo = 'AMEB-008-210';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-008-210', 'AMEB-008') where 'AMEB-008-210' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-009-211' and b.especialidade_codigo = 'AMEB-009' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-009' where especialidade_codigo = 'AMEB-009-211';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-009-211' and b.especialidade_codigo = 'AMEB-009' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-009' where especialidade_codigo = 'AMEB-009-211';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-009-211', 'AMEB-009') where 'AMEB-009-211' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-010-212' and b.especialidade_codigo = 'AMEB-010' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-010' where especialidade_codigo = 'AMEB-010-212';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-010-212' and b.especialidade_codigo = 'AMEB-010' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-010' where especialidade_codigo = 'AMEB-010-212';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-010-212', 'AMEB-010') where 'AMEB-010-212' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-011-213' and b.especialidade_codigo = 'AMEB-011' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-011' where especialidade_codigo = 'AMEB-011-213';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-011-213' and b.especialidade_codigo = 'AMEB-011' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-011' where especialidade_codigo = 'AMEB-011-213';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-011-213', 'AMEB-011') where 'AMEB-011-213' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-012-214' and b.especialidade_codigo = 'AMEB-012' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-012' where especialidade_codigo = 'AMEB-012-214';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-012-214' and b.especialidade_codigo = 'AMEB-012' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-012' where especialidade_codigo = 'AMEB-012-214';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-012-214', 'AMEB-012') where 'AMEB-012-214' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-013-215' and b.especialidade_codigo = 'AMEB-013' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-013' where especialidade_codigo = 'AMEB-013-215';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-013-215' and b.especialidade_codigo = 'AMEB-013' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-013' where especialidade_codigo = 'AMEB-013-215';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-013-215', 'AMEB-013') where 'AMEB-013-215' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-014-216' and b.especialidade_codigo = 'AMEB-014' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-014' where especialidade_codigo = 'AMEB-014-216';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-014-216' and b.especialidade_codigo = 'AMEB-014' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-014' where especialidade_codigo = 'AMEB-014-216';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-014-216', 'AMEB-014') where 'AMEB-014-216' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-015-217' and b.especialidade_codigo = 'AMEB-015' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-015' where especialidade_codigo = 'AMEB-015-217';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-015-217' and b.especialidade_codigo = 'AMEB-015' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-015' where especialidade_codigo = 'AMEB-015-217';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-015-217', 'AMEB-015') where 'AMEB-015-217' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-016-218' and b.especialidade_codigo = 'AMEB-016' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-016' where especialidade_codigo = 'AMEB-016-218';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-016-218' and b.especialidade_codigo = 'AMEB-016' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-016' where especialidade_codigo = 'AMEB-016-218';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-016-218', 'AMEB-016') where 'AMEB-016-218' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-017-219' and b.especialidade_codigo = 'AMEB-017' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-017' where especialidade_codigo = 'AMEB-017-219';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-017-219' and b.especialidade_codigo = 'AMEB-017' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-017' where especialidade_codigo = 'AMEB-017-219';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-017-219', 'AMEB-017') where 'AMEB-017-219' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-018-220' and b.especialidade_codigo = 'AMEB-018' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-018' where especialidade_codigo = 'AMEB-018-220';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-018-220' and b.especialidade_codigo = 'AMEB-018' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-018' where especialidade_codigo = 'AMEB-018-220';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-018-220', 'AMEB-018') where 'AMEB-018-220' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-019-221' and b.especialidade_codigo = 'AMEB-019' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-019' where especialidade_codigo = 'AMEB-019-221';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-019-221' and b.especialidade_codigo = 'AMEB-019' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-019' where especialidade_codigo = 'AMEB-019-221';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-019-221', 'AMEB-019') where 'AMEB-019-221' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-020-222' and b.especialidade_codigo = 'AMEB-020' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-020' where especialidade_codigo = 'AMEB-020-222';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-020-222' and b.especialidade_codigo = 'AMEB-020' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-020' where especialidade_codigo = 'AMEB-020-222';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-020-222', 'AMEB-020') where 'AMEB-020-222' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-021-223' and b.especialidade_codigo = 'AMEB-021' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-021' where especialidade_codigo = 'AMEB-021-223';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-021-223' and b.especialidade_codigo = 'AMEB-021' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-021' where especialidade_codigo = 'AMEB-021-223';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-021-223', 'AMEB-021') where 'AMEB-021-223' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-022-224' and b.especialidade_codigo = 'AMEB-022' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-022' where especialidade_codigo = 'AMEB-022-224';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-022-224' and b.especialidade_codigo = 'AMEB-022' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-022' where especialidade_codigo = 'AMEB-022-224';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-022-224', 'AMEB-022') where 'AMEB-022-224' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-023-225' and b.especialidade_codigo = 'AMEB-023' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-023' where especialidade_codigo = 'AMEB-023-225';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-023-225' and b.especialidade_codigo = 'AMEB-023' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-023' where especialidade_codigo = 'AMEB-023-225';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-023-225', 'AMEB-023') where 'AMEB-023-225' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-024-226' and b.especialidade_codigo = 'AMEB-024' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-024' where especialidade_codigo = 'AMEB-024-226';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-024-226' and b.especialidade_codigo = 'AMEB-024' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-024' where especialidade_codigo = 'AMEB-024-226';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-024-226', 'AMEB-024') where 'AMEB-024-226' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-025-227' and b.especialidade_codigo = 'AMEB-025' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-025' where especialidade_codigo = 'AMEB-025-227';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-025-227' and b.especialidade_codigo = 'AMEB-025' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-025' where especialidade_codigo = 'AMEB-025-227';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-025-227', 'AMEB-025') where 'AMEB-025-227' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-026-228' and b.especialidade_codigo = 'AMEB-026' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-026' where especialidade_codigo = 'AMEB-026-228';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-026-228' and b.especialidade_codigo = 'AMEB-026' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-026' where especialidade_codigo = 'AMEB-026-228';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-026-228', 'AMEB-026') where 'AMEB-026-228' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-027-229' and b.especialidade_codigo = 'AMEB-027' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-027' where especialidade_codigo = 'AMEB-027-229';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-027-229' and b.especialidade_codigo = 'AMEB-027' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-027' where especialidade_codigo = 'AMEB-027-229';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-027-229', 'AMEB-027') where 'AMEB-027-229' = any(especialidades);
delete from public.class_especialidades a using public.class_especialidades b where a.especialidade_codigo = 'AMEB-028-230' and b.especialidade_codigo = 'AMEB-028' and a.class_id = b.class_id;
update public.class_especialidades set especialidade_codigo = 'AMEB-028' where especialidade_codigo = 'AMEB-028-230';
delete from public.desbravador_especialidades a using public.desbravador_especialidades b where a.especialidade_codigo = 'AMEB-028-230' and b.especialidade_codigo = 'AMEB-028' and a.desbravador_id = b.desbravador_id;
update public.desbravador_especialidades set especialidade_codigo = 'AMEB-028' where especialidade_codigo = 'AMEB-028-230';
update public.caderno_itens set especialidades = array_replace(especialidades, 'AMEB-028-230', 'AMEB-028') where 'AMEB-028-230' = any(especialidades);
delete from public.especialidades where codigo in ('AMEB-001-203', 'AMEB-002-204', 'AMEB-003-205', 'AMEB-004-206', 'AMEB-005-207', 'AMEB-006-208', 'AMEB-007-209', 'AMEB-008-210', 'AMEB-009-211', 'AMEB-010-212', 'AMEB-011-213', 'AMEB-012-214', 'AMEB-013-215', 'AMEB-014-216', 'AMEB-015-217', 'AMEB-016-218', 'AMEB-017-219', 'AMEB-018-220', 'AMEB-019-221', 'AMEB-020-222', 'AMEB-021-223', 'AMEB-022-224', 'AMEB-023-225', 'AMEB-024-226', 'AMEB-025-227', 'AMEB-026-228', 'AMEB-027-229', 'AMEB-028-230');

-- Itens do caderno (não apaga itens personalizados)
delete from public.caderno_itens where personalizado = false and (class_id, codigo) not in (values (1::smallint, 'I.1'), (1::smallint, 'I.2'), (1::smallint, 'I.3'), (1::smallint, 'I.4'), (1::smallint, 'I.5'), (1::smallint, 'I.6'), (1::smallint, 'II.1'), (1::smallint, 'II.2'), (1::smallint, 'II.3'), (1::smallint, 'III.1'), (1::smallint, 'III.2'), (1::smallint, 'IV.1'), (1::smallint, 'IV.2'), (1::smallint, 'V.1'), (1::smallint, 'V.2'), (1::smallint, 'V.3'), (1::smallint, 'VI.1'), (1::smallint, 'VII.1'), (1::smallint, 'VII.2'), (1::smallint, 'VII.3'), (1::smallint, 'VIII.1'), (1::smallint, 'VIII.2'), (1::smallint, 'VIII.3'), (1::smallint, 'VIII.4'), (1::smallint, 'IX.1'), (1::smallint, 'AV.1'), (1::smallint, 'AV.2'), (1::smallint, 'AV.3'), (1::smallint, 'AV.4'), (1::smallint, 'AV.5'), (1::smallint, 'AV.6'), (1::smallint, 'AV.7'), (1::smallint, 'AV.8'), (1::smallint, 'AV.9'), (2::smallint, 'I.1'), (2::smallint, 'I.2'), (2::smallint, 'I.3'), (2::smallint, 'I.4'), (2::smallint, 'I.5'), (2::smallint, 'I.6'), (2::smallint, 'II.1'), (2::smallint, 'II.2'), (2::smallint, 'II.3'), (2::smallint, 'II.4'), (2::smallint, 'III.1'), (2::smallint, 'III.2'), (2::smallint, 'V.1'), (2::smallint, 'V.2'), (2::smallint, 'V.3'), (2::smallint, 'V.4'), (2::smallint, 'VI.1'), (2::smallint, 'VI.2'), (2::smallint, 'VII.1'), (2::smallint, 'VII.2'), (2::smallint, 'VII.3'), (2::smallint, 'VIII.1'), (2::smallint, 'VIII.2'), (2::smallint, 'VIII.3'), (2::smallint, 'IX.1'), (2::smallint, 'AV.1'), (2::smallint, 'AV.2'), (2::smallint, 'AV.3'), (2::smallint, 'AV.4'), (2::smallint, 'AV.5'), (2::smallint, 'AV.6'), (2::smallint, 'AV.7'), (2::smallint, 'AV.8'), (2::smallint, 'AV.9'), (2::smallint, 'AV.10'), (2::smallint, 'AV.11'), (2::smallint, 'AV.12'), (3::smallint, 'I.1'), (3::smallint, 'I.2'), (3::smallint, 'I.3'), (3::smallint, 'I.4'), (3::smallint, 'I.5'), (3::smallint, 'I.6'), (3::smallint, 'II.1'), (3::smallint, 'II.2'), (3::smallint, 'II.3'), (3::smallint, 'II.4'), (3::smallint, 'III.1'), (3::smallint, 'III.2'), (3::smallint, 'IV.1'), (3::smallint, 'IV.2'), (3::smallint, 'V.1'), (3::smallint, 'VI.1'), (3::smallint, 'VI.2'), (3::smallint, 'VII.1'), (3::smallint, 'VII.2'), (3::smallint, 'VIII.1'), (3::smallint, 'VIII.2'), (3::smallint, 'VIII.3'), (3::smallint, 'IX.1'), (3::smallint, 'AV.1'), (3::smallint, 'AV.2'), (3::smallint, 'AV.3'), (3::smallint, 'AV.4'), (3::smallint, 'AV.5'), (3::smallint, 'AV.6'), (3::smallint, 'AV.7'), (3::smallint, 'AV.8'), (3::smallint, 'AV.9'), (3::smallint, 'AV.10'), (3::smallint, 'AV.11'), (4::smallint, 'I.1'), (4::smallint, 'I.2'), (4::smallint, 'I.3'), (4::smallint, 'I.4'), (4::smallint, 'I.5'), (4::smallint, 'II.1'), (4::smallint, 'II.2'), (4::smallint, 'II.3'), (4::smallint, 'II.4'), (4::smallint, 'II.5'), (4::smallint, 'II.6'), (4::smallint, 'III.1'), (4::smallint, 'III.2'), (4::smallint, 'IV.1'), (4::smallint, 'V.1'), (4::smallint, 'V.2'), (4::smallint, 'VI.1'), (4::smallint, 'VI.2'), (4::smallint, 'VII.1'), (4::smallint, 'VII.2'), (4::smallint, 'VIII.1'), (4::smallint, 'VIII.2'), (4::smallint, 'VIII.3'), (4::smallint, 'IX.1'), (4::smallint, 'AV.1'), (4::smallint, 'AV.2'), (4::smallint, 'AV.3'), (4::smallint, 'AV.4'), (4::smallint, 'AV.5'), (4::smallint, 'AV.6'), (4::smallint, 'AV.7'), (4::smallint, 'AV.8'), (4::smallint, 'AV.9'), (4::smallint, 'AV.10'), (5::smallint, 'I.1'), (5::smallint, 'I.2'), (5::smallint, 'I.3'), (5::smallint, 'I.4'), (5::smallint, 'I.5'), (5::smallint, 'II.1'), (5::smallint, 'II.2'), (5::smallint, 'II.3'), (5::smallint, 'II.4'), (5::smallint, 'II.5'), (5::smallint, 'II.6'), (5::smallint, 'III.1'), (5::smallint, 'III.2'), (5::smallint, 'III.3'), (5::smallint, 'IV.1'), (5::smallint, 'IV.2'), (5::smallint, 'V.1'), (5::smallint, 'VI.1'), (5::smallint, 'VI.2'), (5::smallint, 'VI.3'), (5::smallint, 'VII.1'), (5::smallint, 'VII.2'), (5::smallint, 'VIII.1'), (5::smallint, 'VIII.2'), (5::smallint, 'IX.1'), (5::smallint, 'AV.1'), (5::smallint, 'AV.2'), (5::smallint, 'AV.3'), (5::smallint, 'AV.4'), (5::smallint, 'AV.5'), (5::smallint, 'AV.6'), (5::smallint, 'AV.7'), (5::smallint, 'AV.8'), (5::smallint, 'AV.9'), (5::smallint, 'AV.10'), (5::smallint, 'AV.11'), (6::smallint, 'I.1'), (6::smallint, 'I.2'), (6::smallint, 'I.3'), (6::smallint, 'I.4'), (6::smallint, 'I.5'), (6::smallint, 'II.1'), (6::smallint, 'II.2'), (6::smallint, 'II.3'), (6::smallint, 'II.4'), (6::smallint, 'II.5'), (6::smallint, 'II.6'), (6::smallint, 'III.1'), (6::smallint, 'III.2'), (6::smallint, 'IV.1'), (6::smallint, 'V.1'), (6::smallint, 'V.2'), (6::smallint, 'VI.1'), (6::smallint, 'VI.2'), (6::smallint, 'VI.3'), (6::smallint, 'VII.1'), (6::smallint, 'VII.2'), (6::smallint, 'VIII.1'), (6::smallint, 'VIII.2'), (6::smallint, 'VIII.3'), (6::smallint, 'VIII.4'), (6::smallint, 'IX.1'), (6::smallint, 'AV.1'), (6::smallint, 'AV.2'), (6::smallint, 'AV.3'), (6::smallint, 'AV.4'), (6::smallint, 'AV.5'), (6::smallint, 'AV.6'), (6::smallint, 'AV.7'), (6::smallint, 'AV.8'), (6::smallint, 'AV.9'), (6::smallint, 'AV.10'));

insert into public.caderno_itens (class_id, secao, secao_ordem, ordem, codigo, texto, detalhes, especialidades, avancada) values
(1, 'I - Geral', 1, 1, 'I.1', 'Ter, no mínimo, 10 anos de idade.', '[]'::jsonb, '{}'::text[], false),
(1, 'I - Geral', 1, 2, 'I.2', 'Ser membro ativo do Clube de Desbravadores.', '[]'::jsonb, '{}'::text[], false),
(1, 'I - Geral', 1, 3, 'I.3', 'Memorizar e explicar o Voto e a Lei do Desbravador.', '[]'::jsonb, '{}'::text[], false),
(1, 'I - Geral', 1, 4, 'I.4', 'Ler o livro do Clube do livro Juvenil do ano em curso.', '[]'::jsonb, '{}'::text[], false),
(1, 'I - Geral', 1, 5, 'I.5', 'Ler o livro "Vaso de barro".', '[]'::jsonb, '{}'::text[], false),
(1, 'I - Geral', 1, 6, 'I.6', 'Participar ativamente da classe bíblica do seu clube.', '[]'::jsonb, '{}'::text[], false),
(1, 'II - Descoberta Espiritual', 2, 1, 'II.1', 'Memorizar e demonstrar seu conhecimento:', '[{"t":"Criação: o que Deus criou em cada dia da Criação.","sub":[]},{"t":"10 pragas: quais as pragas que caíram sobre o Egito.","sub":[]},{"t":"12 Tribos: o nome de cada uma das 12 tribos de Israel.","sub":[]},{"t":"39 livros do Antigo Testamento e demonstre habilidade para encontrar qualquer um deles.","sub":[]}]'::jsonb, '{}'::text[], false),
(1, 'II - Descoberta Espiritual', 2, 2, 'II.2', 'Ler e explicar os versos abaixo:', '[{"t":"João 3:16","sub":[]},{"t":"Efésios 6:1-3","sub":[]},{"t":"II Timóteo 3:16","sub":[]},{"t":"Salmo 1","sub":[]}]'::jsonb, '{}'::text[], false),
(1, 'II - Descoberta Espiritual', 2, 3, 'II.3', 'Leitura Bíblica:', '[{"t":"Gênesis: 1, 2, 3, 4:1-16, 6:11-22, 7, 8, 9:1-19, 11:1-9, 12:1-10, 13, 14:18-24, 15, 17:1-8; 15-22, 18:1-15, 18: 16-33, 19:1-29, 21:1-21, 22:1-19, 23, 24:1-46, 48, 24:52-67, 27, 28, 29, 30:25-31; 31:2-3, 17-18, 32, 33, 37, 40, 41, 42, 43, 44, 45, 47, 50","sub":[]},{"t":"Êxodo: 1, 2, 3, 4:1-17; 27-31, 5, 7, 8, 9, 10; 11, 12, 13:17-22; 14, 15:22-27; 16, 17, 18, 19, 20, 24, 32, 33, 34:1-14; 29-35, 35:4-29 e 40","sub":[]}]'::jsonb, '{}'::text[], false),
(1, 'III - Servindo a Outros', 3, 1, 'III.1', 'Dedicar duas horas ajudando alguém em sua comunidade, através de duas das seguintes atividades:', '[{"t":"Visitar alguém que precisa de amizade e orar com essa pessoa.","sub":[]},{"t":"Oferecer alimento a alguém carente.","sub":[]},{"t":"Participar de um projeto ecológico ou educativo.","sub":[]}]'::jsonb, '{}'::text[], false),
(1, 'III - Servindo a Outros', 3, 2, 'III.2', 'Escrever uma redação explicando como ser um bom cidadão no lar e na escola.', '[]'::jsonb, '{}'::text[], false),
(1, 'IV - Desenvolvendo Amizade', 4, 1, 'IV.1', 'Mencionar dez qualidades de um bom amigo e apresentar quatro situações diárias onde você praticou a Regra Áurea de Mateus 7:12.', '[]'::jsonb, '{}'::text[], false),
(1, 'IV - Desenvolvendo Amizade', 4, 2, 'IV.2', 'Saber cantar o Hino Nacional de seu país e conhecer sua história. Saber o nome do autor da letra e da música do hino.', '[]'::jsonb, '{}'::text[], false),
(1, 'V - Saúde e Aptidão Física', 5, 1, 'V.1', 'Completar uma das seguintes especialidades:', '[{"t":"Natação principiante I","sub":[]},{"t":"Cultura física","sub":[]},{"t":"Nós e amarras","sub":[]},{"t":"Segurança básica na água","sub":[]}]'::jsonb, array['AR-003', 'AR-002', 'AR-040', 'AR-090']::text[], false),
(1, 'V - Saúde e Aptidão Física', 5, 2, 'V.2', 'Utilizando a experiência de Daniel:', '[{"t":"Explicar os princípios de temperança que ele defendeu ou participar em uma apresentação ou encenação sobre Daniel 1.","sub":[]},{"t":"Memorizar e explicar Daniel 1:8.","sub":[]},{"t":"Escrever seu compromisso pessoal de seguir um estilo de vida saudável.","sub":[]}]'::jsonb, '{}'::text[], false),
(1, 'V - Saúde e Aptidão Física', 5, 3, 'V.3', 'Aprender os princípios de uma dieta saudável e ajudar a preparar um quadro com os grupos básicos de alimentos.', '[]'::jsonb, '{}'::text[], false),
(1, 'VI - Organização e Liderança', 6, 1, 'VI.1', 'Através da observação, acompanhar todo o processo de planejamento até a execução de uma caminhada de 5 quilômetros.', '[]'::jsonb, '{}'::text[], false),
(1, 'VII - Estudo da Natureza', 7, 1, 'VII.1', 'Completar uma das seguintes especialidades:', '[{"t":"Felinos","sub":[]},{"t":"Cães","sub":[]},{"t":"Mamíferos","sub":[]},{"t":"Sementes","sub":[]},{"t":"Aves de Estimação","sub":[]}]'::jsonb, array['EN-024', 'EN-034', 'EN-010', 'EN-040', 'EN-020']::text[], false),
(1, 'VII - Estudo da Natureza', 7, 2, 'VII.2', 'Aprender e demonstrar uma maneira para purificar a água e escrever um parágrafo destacando o significado de Jesus como a água da vida.', '[]'::jsonb, '{}'::text[], false),
(1, 'VII - Estudo da Natureza', 7, 3, 'VII.3', 'Aprender e montar uma barraca em local apropriado.', '[]'::jsonb, '{}'::text[], false),
(1, 'VIII - Arte de Acampar', 8, 1, 'VIII.1', 'Demonstrar como cuidar corretamente de uma corda. Fazer e explicar o uso prático dos seguintes nós:', '[{"t":"Simples","sub":[]},{"t":"Cego","sub":[]},{"t":"Direito","sub":[]},{"t":"Cirurgião","sub":[]},{"t":"Lais de guia","sub":[]},{"t":"Lais de guia duplo","sub":[]},{"t":"Escota","sub":[]},{"t":"Catau","sub":[]},{"t":"Pescador","sub":[]},{"t":"Fateixa","sub":[]},{"t":"Volta da fiel","sub":[]},{"t":"Nó de gancho","sub":[]},{"t":"Volta da ribeira","sub":[]},{"t":"Ordinário","sub":[]}]'::jsonb, '{}'::text[], false),
(1, 'VIII - Arte de Acampar', 8, 2, 'VIII.2', 'Completar a especialidade de Acampamento I.', '[]'::jsonb, array['AR-050']::text[], false),
(1, 'VIII - Arte de Acampar', 8, 3, 'VIII.3', 'Apresentar 10 regras para uma caminhada e explicar o que fazer quando estiver perdido.', '[]'::jsonb, '{}'::text[], false),
(1, 'VIII - Arte de Acampar', 8, 4, 'VIII.4', 'Aprender os sinais para seguir uma pista. Preparar e seguir uma pista de no mínimo 10 sinais, que também possa ser seguida por outros.', '[]'::jsonb, '{}'::text[], false),
(1, 'IX - Estilo de Vida', 9, 1, 'IX.1', 'Completar uma especialidade na área de Artes e Habilidades Manuais.', '[]'::jsonb, '{}'::text[], false),
(1, 'Classe Avançada - Amigo da Natureza', 10, 1, 'AV.1', 'Memorizar, cantar ou tocar o Hino dos Desbravadores e conhecer a história do hino.', '[]'::jsonb, '{}'::text[], true),
(1, 'Classe Avançada - Amigo da Natureza', 10, 2, 'AV.2', 'Em consulta com o seu líder, escolher um dos seguintes personagens do Antigo Testamento e conversar com seu grupo sobre o amor e cuidado de Deus e o livramento demonstrado na vida do personagem escolhido.', '[{"t":"José","sub":[]},{"t":"Jonas","sub":[]},{"t":"Ester","sub":[]},{"t":"Rute","sub":[]}]'::jsonb, '{}'::text[], true),
(1, 'Classe Avançada - Amigo da Natureza', 10, 3, 'AV.3', 'Levar pelo menos dois amigos não adventistas à Escola Sabatina ou ao Clube de Desbravadores.', '[]'::jsonb, '{}'::text[], true),
(1, 'Classe Avançada - Amigo da Natureza', 10, 4, 'AV.4', 'Conhecer os princípios de higiene, de boas maneiras à mesa e como se comportar diante de pessoas que tenham diferentes idades. Demonstrar e explicar como essas boas maneiras podem ser úteis nas reuniões e acampamentos do clube.', '[]'::jsonb, '{}'::text[], true),
(1, 'Classe Avançada - Amigo da Natureza', 10, 5, 'AV.5', 'Fazer a especialidade de Arte de acampar.', '[]'::jsonb, array['AR-001']::text[], true),
(1, 'Classe Avançada - Amigo da Natureza', 10, 6, 'AV.6', 'Conhecer e identificar 10 flores silvestres e 10 insetos de sua região.', '[]'::jsonb, '{}'::text[], true),
(1, 'Classe Avançada - Amigo da Natureza', 10, 7, 'AV.7', 'Começar uma fogueira com apenas um fósforo, usando materiais naturais, e mantê-la acesa.', '[]'::jsonb, '{}'::text[], true),
(1, 'Classe Avançada - Amigo da Natureza', 10, 8, 'AV.8', 'Usar corretamente uma faca, facão e uma machadinha e conhecer dez regras para usá-los com segurança.', '[]'::jsonb, '{}'::text[], true),
(1, 'Classe Avançada - Amigo da Natureza', 10, 9, 'AV.9', 'Escolher e completar uma especialidade em uma das áreas abaixo:', '[{"t":"Atividades missionárias","sub":[]},{"t":"Atividades agrícolas","sub":[]}]'::jsonb, '{}'::text[], true),
(2, 'I - Geral', 1, 1, 'I.1', 'Ter, no mínimo, 11 anos de idade.', '[]'::jsonb, '{}'::text[], false),
(2, 'I - Geral', 1, 2, 'I.2', 'Ser membro ativo do Clube de Desbravadores.', '[]'::jsonb, '{}'::text[], false),
(2, 'I - Geral', 1, 3, 'I.3', 'Ilustrar de forma criativa o significado do Voto dos Desbravadores.', '[]'::jsonb, '{}'::text[], false),
(2, 'I - Geral', 1, 4, 'I.4', 'Ler o livro do Clube do Livro Juvenil do ano em curso e escrever um parágrafo sobre o que mais lhe chamou a atenção ou considerou importante.', '[]'::jsonb, '{}'::text[], false),
(2, 'I - Geral', 1, 5, 'I.5', 'Ler o livro "Um simples lanche".', '[]'::jsonb, '{}'::text[], false),
(2, 'I - Geral', 1, 6, 'I.6', 'Participar ativamente da classe bíblica do seu clube.', '[]'::jsonb, '{}'::text[], false),
(2, 'II - Descoberta Espiritual', 2, 1, 'II.1', 'Memorizar e demonstrar seu conhecimento:', '[{"t":"10 Mandamentos: A Lei de Deus dada a Moisés.","sub":[]},{"t":"27 livros do Novo Testamento e demonstrar habilidade para encontrar qualquer um deles.","sub":[]}]'::jsonb, '{}'::text[], false),
(2, 'II - Descoberta Espiritual', 2, 2, 'II.2', 'Ler e explicar os versos abaixo:', '[{"t":"Isa. 41:9-10","sub":[]},{"t":"Heb. 13:5","sub":[]},{"t":"Prov. 22:6","sub":[]},{"t":"I João 1:9","sub":[]},{"t":"Salmo 8","sub":[]}]'::jsonb, '{}'::text[], false),
(2, 'II - Descoberta Espiritual', 2, 3, 'II.3', 'Leitura Bíblica:', '[{"t":"Levítico: 11","sub":[]},{"t":"Números: 9: 15-23, 11, 12, 13, 14:1-38, 16, 17, 20:1-13; 22-29, 21:4-9, 22, 23; 24:1-10","sub":[]},{"t":"Deuteronômio: 1:1-17, 32:1-43, 33, 34","sub":[]},{"t":"Josué: 1, 2, 3, 4, 5:10; 6, 7, 9, 24:1-15; 29","sub":[]},{"t":"Juízes: 6, 7, 13:1-18; 14, 15, 16","sub":[]},{"t":"Rute: 1, 2; 3, 4","sub":[]},{"t":"1 Samuel: 1, 2, 3, 4, 5, 6, 8, 9, 10; 11:12-15, 12, 13, 15, 16, 17, 18:1-19, 20, 21:1-7; 22, 24, 25, 26, 31","sub":[]},{"t":"2 Samuel: 1, 5, 6, 7, 9, 11; 12:1-25, 15, 18","sub":[]}]'::jsonb, '{}'::text[], false),
(2, 'II - Descoberta Espiritual', 2, 4, 'II.4', 'Em consulta com o seu conselheiro, escolher um dos seguintes temas:', '[{"t":"Uma parábola de Jesus","sub":[]},{"t":"Um milagre de Jesus","sub":[]},{"t":"O sermão da montanha","sub":[]},{"t":"Um sermão sobre a Segunda Vinda de Cristo","sub":[]},{"t":"Escolher um item abaixo para demonstrar seu conhecimento sobre o tema escolhido:","sub":[]},{"t":"Troca de ideias com seu conselheiro","sub":[]},{"t":"Atividade que integre todo o grupo","sub":[]},{"t":"Redação","sub":[]}]'::jsonb, '{}'::text[], false),
(2, 'III - Servindo a Outros', 3, 1, 'III.1', 'Planejar e dedicar pelo menos duas horas servindo sua comunidade e demonstrando companheirismo para alguém, de maneira prática.', '[]'::jsonb, '{}'::text[], false),
(2, 'III - Servindo a Outros', 3, 2, 'III.2', 'Dedicar pelo menos cinco horas participando de um projeto que beneficiará sua comunidade ou igreja.', '[]'::jsonb, '{}'::text[], false),
(2, 'V - Saúde e Aptidão Física', 5, 1, 'V.1', 'Memorizar e explicar I Coríntios 9:24-27.', '[]'::jsonb, '{}'::text[], false),
(2, 'V - Saúde e Aptidão Física', 5, 2, 'V.2', 'Conversar com seu líder sobre a aptidão física e os exercícios físicos regulares que se relacionam com uma vida saudável.', '[]'::jsonb, '{}'::text[], false),
(2, 'V - Saúde e Aptidão Física', 5, 3, 'V.3', 'Aprender sobre os prejuízos que o cigarro causa à saúde e escrever seu compromisso de não fazer uso do fumo.', '[]'::jsonb, '{}'::text[], false),
(2, 'V - Saúde e Aptidão Física', 5, 4, 'V.4', 'Completar uma das seguintes especialidades:', '[{"t":"Natação Principiante II","sub":[]},{"t":"Acampamento II","sub":[]}]'::jsonb, array['AR-004', 'AR-051']::text[], false),
(2, 'VI - Organização e Liderança', 6, 1, 'VI.1', 'Dirigir ou colaborar em uma meditação criativa para a sua unidade ou Clube.', '[]'::jsonb, '{}'::text[], false),
(2, 'VI - Organização e Liderança', 6, 2, 'VI.2', 'Ajudar no planejamento de uma excursão ou acampamento com sua unidade ou clube, envolvendo pelo menos um pernoite.', '[]'::jsonb, '{}'::text[], false),
(2, 'VII - Estudo da Natureza', 7, 1, 'VII.1', 'Participar de jogos da natureza, ou caminhada ecológica em meio a natureza, pelo período de uma hora.', '[]'::jsonb, '{}'::text[], false),
(2, 'VII - Estudo da Natureza', 7, 2, 'VII.2', 'Completar duas das seguintes especialidades:', '[{"t":"Anfíbios","sub":[]},{"t":"Aves","sub":[]},{"t":"Aves domésticas","sub":[]},{"t":"Pecuária","sub":[]},{"t":"Répteis","sub":[]},{"t":"Moluscos","sub":[]},{"t":"Árvores","sub":[]},{"t":"Arbustos","sub":[]}]'::jsonb, array['EN-023', 'EN-003', 'EN-004', 'AA-014', 'EN-011', 'EN-014', 'EN-006', 'EN-019']::text[], false),
(2, 'VII - Estudo da Natureza', 7, 3, 'VII.3', 'Recapitular o estudo da criação e fazer um diário por sete dias registrando suas observações do que foi criado em cada dia correspondente.', '[]'::jsonb, '{}'::text[], false),
(2, 'VIII - Arte de Acampar', 8, 1, 'VIII.1', 'Descobrir os pontos cardeais sem a ajuda de uma bússola e desenhar uma Rosa dos Ventos.', '[]'::jsonb, '{}'::text[], false),
(2, 'VIII - Arte de Acampar', 8, 2, 'VIII.2', 'Participar em um acampamento de final de semana, e fazer um relatório destacando o que mais lhe impressionou positivamente.', '[]'::jsonb, '{}'::text[], false),
(2, 'VIII - Arte de Acampar', 8, 3, 'VIII.3', 'Aprender ou recapitular os seguintes nós:', '[{"t":"Oito","sub":[]},{"t":"Volta do salteador","sub":[]},{"t":"Duplo","sub":[]},{"t":"Caminhoneiro","sub":[]},{"t":"Direito","sub":[]},{"t":"Volta do fiel","sub":[]},{"t":"Escota","sub":[]},{"t":"Lais de guia","sub":[]},{"t":"Simples","sub":[]}]'::jsonb, '{}'::text[], false),
(2, 'IX - Estilo de Vida', 9, 1, 'IX.1', 'Completar uma especialidade não realizada anteriormente. Na seção de Artes e Habilidades Manuais.', '[]'::jsonb, '{}'::text[], false),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 1, 'AV.1', 'Aprender e demonstrar a composição, significado e uso correto da Bandeira Nacional.', '[]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 2, 'AV.2', 'Ler a primeira visão de Ellen White e discutir como Deus usa os profetas para apresentar Sua mensagem à igreja (ver "Primeiros Escritos", pág. 13-20).', '[]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 3, 'AV.3', 'Participar de uma atividade missionária ou comunitária, envolvendo também um amigo.', '[]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 4, 'AV.4', 'Conversar com seu conselheiro ou unidade sobre como demonstrar respeito pelos seus pais ou responsáveis e fazer uma lista mostrando como cuidam de você.', '[]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 5, 'AV.5', 'Participar de uma caminhada de 6 quilômetros preparando ao final um relatório de uma página.', '[]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 6, 'AV.6', 'Escolher um dos seguintes itens:', '[{"t":"Assistir à um \"curso como deixar de fumar\"","sub":[]},{"t":"Assistir à dois filmes sobre saúde","sub":[]},{"t":"Elaborar um cartaz sobre o prejuízo das drogas","sub":[]},{"t":"Ajudar a preparar material para uma exposição ou passeata sobre saúde","sub":[]},{"t":"Pesquisar na internet informações sobre saúde e escrever uma página sobre os resultados encontrados","sub":[]}]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 7, 'AV.7', 'Identificar e descrever 12 aves nativas e 12 árvores nativas.', '[]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 8, 'AV.8', 'Participar de uma das seguintes cerimônias e sugerir ideias criativas de como realiza-las.', '[{"t":"Investidura","sub":[]},{"t":"Admissão de lenço","sub":[]},{"t":"Dia do desbravador.","sub":[]}]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 9, 'AV.9', 'Preparar uma refeição em uma fogueira durante um acampamento de clube ou unidade.', '[]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 10, 'AV.10', 'Preparar um quadro com 15 nós diferentes.', '[]'::jsonb, '{}'::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 11, 'AV.11', 'Completar a especialidade de Excursionismo pedestre com mochila.', '[]'::jsonb, array['AR-056']::text[], true),
(2, 'Classe Avançada - Companheiro de Excursionismo', 10, 12, 'AV.12', 'Completar uma especialidade não realizada anteriormente:', '[{"t":"Habilidades Domésticas","sub":[]},{"t":"Ciência e Saúde","sub":[]},{"t":"Atividades Missionárias","sub":[]},{"t":"Atividades Agrícolas","sub":[]}]'::jsonb, '{}'::text[], true),
(3, 'I - Geral', 1, 1, 'I.1', 'Ter, no mínimo, 12 anos de idade.', '[]'::jsonb, '{}'::text[], false),
(3, 'I - Geral', 1, 2, 'I.2', 'Ser membro ativo do Clube de Desbravadores.', '[]'::jsonb, '{}'::text[], false),
(3, 'I - Geral', 1, 3, 'I.3', 'Demonstrar sua compreensão do significado da Lei do Desbravador através de uma das seguintes atividades:', '[{"t":"Representação","sub":[]},{"t":"Debate","sub":[]},{"t":"Redação","sub":[]}]'::jsonb, '{}'::text[], false),
(3, 'I - Geral', 1, 4, 'I.4', 'Ler o livro do Clube do Livro Juvenil do ano e escrever dois parágrafos sobre o que mais lhe chamou a atenção ou considerou importante.', '[]'::jsonb, '{}'::text[], false),
(3, 'I - Geral', 1, 5, 'I.5', 'Ler o livro "Além da Magia".', '[]'::jsonb, '{}'::text[], false),
(3, 'I - Geral', 1, 6, 'I.6', 'Participar ativamente da classe bíblica do seu clube.', '[]'::jsonb, '{}'::text[], false),
(3, 'II - Descoberta Espiritual', 2, 1, 'II.1', 'Memorizar e demonstrar seu conhecimento:', '[{"t":"Levítico 11: quais as regras para os alimentos considerados comestíveis e não comestíveis.","sub":[]}]'::jsonb, '{}'::text[], false),
(3, 'II - Descoberta Espiritual', 2, 2, 'II.2', 'Ler e explicar os versos abaixo:', '[{"t":"Ecles. 12:13-14","sub":[]},{"t":"Rom. 6:23","sub":[]},{"t":"Apoc. 1:3","sub":[]},{"t":"Isa. 43:1-2","sub":[]},{"t":"Salmo 51:10","sub":[]},{"t":"Salmo 16","sub":[]}]'::jsonb, '{}'::text[], false),
(3, 'II - Descoberta Espiritual', 2, 3, 'II.3', 'Leitura Bíblica:', '[{"t":"1 Reis: 1:28-53, 3, 4:20-34, 5, 6, 8:12-60, 10, 11:6-43, 12, 16:29-33; 17:1-7, 17:8-24, 18, 19, 21","sub":[]},{"t":"2 Reis: 2, 4:1-7, 4:8-41, 5, 6:1-23, 6:24-33; 7, 20, 22, 23:36-37; 24; 25:1-7","sub":[]},{"t":"2 Crônicas: 24:1-14, 36","sub":[]},{"t":"Esdras: 1, 3; 6:14-15","sub":[]},{"t":"Neemias: 1, 2, 4, 8","sub":[]},{"t":"Ester: 1, 2, 3, 4, 5, 6, 7;8","sub":[]},{"t":"Jó: 1, 2, 42","sub":[]},{"t":"Salmos: 1, 15, 19, 23, 24, 27, 37, 39, 42, 46, 67, 90;91, 92; 97, 98, 100, 117, 119:1-80, 119:81-176, 121, 125, 150","sub":[]},{"t":"Provérbios: 1, 3, 4, 10, 15, 20, 25","sub":[]},{"t":"Eclesiastes: 1","sub":[]}]'::jsonb, '{}'::text[], false)
on conflict (class_id, codigo) do update set secao = excluded.secao, secao_ordem = excluded.secao_ordem, ordem = excluded.ordem, texto = excluded.texto, detalhes = excluded.detalhes, especialidades = excluded.especialidades, avancada = excluded.avancada;

insert into public.caderno_itens (class_id, secao, secao_ordem, ordem, codigo, texto, detalhes, especialidades, avancada) values
(3, 'II - Descoberta Espiritual', 2, 4, 'II.4', 'Conversar com seu líder e escolher uma das seguintes histórias:', '[{"t":"João 3 - Nicodemos","sub":[]},{"t":"João 4 - A mulher samaritana","sub":[]},{"t":"Lucas 10 - O bom samaritano","sub":[]},{"t":"Lucas 15 - O filho pródigo","sub":[]},{"t":"Lucas 19 - Zaqueu","sub":[]},{"t":"Através da história escolhida, demonstrar sua compreensão em como Jesus salva as pessoas, usando um dos seguintes métodos abaixo:","sub":[]},{"t":"Conversar em grupo com a participação de seu líder.","sub":[]},{"t":"Apresentar uma mensagem em uma reunião do clube.","sub":[]},{"t":"Fazer uma série de cartazes ou uma maquete.","sub":[]},{"t":"Escrever uma poesia ou hino.","sub":[]}]'::jsonb, '{}'::text[], false),
(3, 'III - Servindo a Outros', 3, 1, 'III.1', 'Conhecer os projetos comunitários desenvolvidos em sua cidade e participar em pelo menos um deles com sua unidade ou clube.', '[]'::jsonb, '{}'::text[], false),
(3, 'III - Servindo a Outros', 3, 2, 'III.2', 'Participar em três atividades missionárias da igreja.', '[]'::jsonb, '{}'::text[], false),
(3, 'IV - Desenvolvendo Amizade', 4, 1, 'IV.1', 'Participar de um debate ou representação sobre a pressão de grupo e identificar a influência que isso exerce sobre suas decisões.', '[]'::jsonb, '{}'::text[], false),
(3, 'IV - Desenvolvendo Amizade', 4, 2, 'IV.2', 'Visitar um órgão público de sua cidade e descobrir de que maneiras o clube pode ser útil à sua comunidade.', '[]'::jsonb, '{}'::text[], false),
(3, 'V - Saúde e Aptidão Física', 5, 1, 'V.1', 'Escolher uma das atividades abaixo e escrever um texto pessoal para um estilo de vida livre do álcool:', '[{"t":"Participar de uma discussão em classe sobre os efeitos do álcool no organismo.","sub":[]},{"t":"Assistir à um vídeo sobre o álcool ou outras drogas no corpo humano e conversar sobre o assunto.","sub":[]}]'::jsonb, '{}'::text[], false),
(3, 'VI - Organização e Liderança', 6, 1, 'VI.1', 'Dirigir uma cerimônia de abertura da reunião semanal em seu clube ou um programa de Escola Sabatina.', '[]'::jsonb, '{}'::text[], false),
(3, 'VI - Organização e Liderança', 6, 2, 'VI.2', 'Ajudar a organizar a classe bíblica de seu clube.', '[]'::jsonb, '{}'::text[], false),
(3, 'VII - Estudo da Natureza', 7, 1, 'VII.1', 'Identificar a estrela Alfa da constelação do Centauro e a constelação de Órion. Conhecer o significado espiritual de Órion, como descrito no livro "Primeiros Escritos", de Ellen White, pág. 41.', '[]'::jsonb, '{}'::text[], false),
(3, 'VII - Estudo da Natureza', 7, 2, 'VII.2', 'Completar uma das especialidades abaixo:', '[{"t":"Astronomia","sub":[]},{"t":"Cactos","sub":[]},{"t":"Climatologia","sub":[]},{"t":"Flores","sub":[]},{"t":"Rastreio de animais","sub":[]}]'::jsonb, array['EN-002', 'EN-015', 'EN-016', 'EN-005', 'EN-050']::text[], false),
(3, 'VIII - Arte de Acampar', 8, 1, 'VIII.1', 'Apresentar seis segredos para um bom acampamento. Participar de um acampamento de final de semana, planejando e cozinhando duas refeições.', '[]'::jsonb, '{}'::text[], false),
(3, 'VIII - Arte de Acampar', 8, 2, 'VIII.2', 'Completar as seguintes especialidades:', '[{"t":"Acampamento III","sub":[]},{"t":"Primeiros Socorros - básico","sub":[]}]'::jsonb, array['AR-052', 'CS-003']::text[], false),
(3, 'VIII - Arte de Acampar', 8, 3, 'VIII.3', 'Aprender a usar uma bússola ou GPS (urbano ou campo), e demonstrar sua habilidade encontrando endereços em uma zona urbana.', '[]'::jsonb, '{}'::text[], false),
(3, 'IX - Estilo de Vida', 9, 1, 'IX.1', 'Completar uma especialidade não realizada anteriormente, em Artes e Habilidades Manuais.', '[]'::jsonb, '{}'::text[], false),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 1, 'AV.1', 'Conhecer e saber usar de forma adequada a Bandeira dos Desbravadores, o bandeirim de unidade e os comandos de ordem unida.', '[]'::jsonb, '{}'::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 2, 'AV.2', 'Ler a história de J. N. Andrews ou um pioneiro de seu país e discutir a importância do trabalho de missionários, e porque Cristo ordenou a Grande Comissão (Mateus 28:18-20).', '[]'::jsonb, '{}'::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 3, 'AV.3', 'Convidar uma pessoa para assistir um dos seguintes programas:', '[{"t":"Clube dos Desbravadores","sub":[]},{"t":"Classe Bíblica","sub":[]},{"t":"Pequeno Grupo","sub":[]}]'::jsonb, '{}'::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 4, 'AV.4', 'Fazer uma das seguintes especialidades:', '[{"t":"Asseio e Cortesia Cristã","sub":[]},{"t":"Vida Familiar","sub":[]}]'::jsonb, array['AM-012']::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 5, 'AV.5', 'Participar de uma caminhada de 10 quilômetros e fazer uma lista dos equipamentos necessários, incluindo a roupa e o calçado que devem ser usados.', '[]'::jsonb, '{}'::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 6, 'AV.6', 'Participar na organização de um dos eventos especiais do Clube:', '[{"t":"Investidura","sub":[]},{"t":"Admissão de Lenço","sub":[]},{"t":"Dia do Desbravador","sub":[]}]'::jsonb, '{}'::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 7, 'AV.7', 'Identificar seis pegadas de animais ou aves. Fazer um modelo em gesso, massa de modelar ou biscuit de três dessas pegadas.', '[]'::jsonb, '{}'::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 8, 'AV.8', 'Aprender a fazer quatro amarras básicas e construir um móvel de acampamento.', '[]'::jsonb, '{}'::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 9, 'AV.9', 'Planejar um cardápio vegetariano para sua unidade, para um acampamento de três dias e apresentar para seu instrutor.', '[]'::jsonb, '{}'::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 10, 'AV.10', 'Enviar e receber uma mensagem através das formas de comunicação abaixo:', '[{"t":"Alfabeto com semáforos","sub":[]},{"t":"Código Morse, com lanterna","sub":[]},{"t":"Alfabeto LIBRAS (língua de sinais)","sub":[]},{"t":"Alfabeto Braile","sub":[]}]'::jsonb, '{}'::text[], true),
(3, 'Classe Avançada - Pesquisador de Campo e Bosque', 10, 11, 'AV.11', 'Completar duas especialidades não realizadas anteriormente, em uma das áreas abaixo:', '[{"t":"Habilidades Domésticas","sub":[]},{"t":"Ciência e Saúde","sub":[]},{"t":"Atividades Missionárias","sub":[]},{"t":"Atividades Agrícolas","sub":[]}]'::jsonb, '{}'::text[], true),
(4, 'I - Geral', 1, 1, 'I.1', 'Ter, no mínimo, 13 anos de idade.', '[]'::jsonb, '{}'::text[], false),
(4, 'I - Geral', 1, 2, 'I.2', 'Ser membro ativo do Clube de Desbravadores.', '[]'::jsonb, '{}'::text[], false),
(4, 'I - Geral', 1, 3, 'I.3', 'Memorizar e entender o Alvo e o Lema JA.', '[]'::jsonb, '{}'::text[], false),
(4, 'I - Geral', 1, 4, 'I.4', 'Ler o livro do Clube do Livro Juvenil do ano em curso e resumi-lo em uma página.', '[]'::jsonb, '{}'::text[], false),
(4, 'I - Geral', 1, 5, 'I.5', 'Ler o livro "Expedição Galápagos".', '[]'::jsonb, '{}'::text[], false),
(4, 'II - Descoberta Espiritual', 2, 1, 'II.1', 'Memorizar e demonstrar seu conhecimento:', '[{"t":"Bem-Aventuranças: O sermão da Montanha","sub":[]}]'::jsonb, '{}'::text[], false),
(4, 'II - Descoberta Espiritual', 2, 2, 'II.2', 'Ler e explicar os versos abaixo:', '[{"t":"Isa. 26:3","sub":[]},{"t":"Rom. 12:12","sub":[]},{"t":"João 14:1-3","sub":[]},{"t":"Sal. 37:5","sub":[]},{"t":"Filip. 3:12-14","sub":[]},{"t":"Salmo 23","sub":[]},{"t":"I Sam. 15:22","sub":[]}]'::jsonb, '{}'::text[], false),
(4, 'II - Descoberta Espiritual', 2, 3, 'II.3', 'Conversar em seu clube ou unidade sobre:', '[{"t":"O que é o cristianismo","sub":[]},{"t":"Quais são as características de um verdadeiro discípulo","sub":[]},{"t":"O que fazer para ser um cristão verdadeiro","sub":[]}]'::jsonb, '{}'::text[], false),
(4, 'II - Descoberta Espiritual', 2, 4, 'II.4', 'Participar de um estudo especial sobre a inspiração da Bíblia, com a ajuda de um pastor, trabalhando os conceitos de inspiração, revelação e iluminação.', '[]'::jsonb, '{}'::text[], false),
(4, 'II - Descoberta Espiritual', 2, 5, 'II.5', 'Convidar três ou mais pessoas para assistirem uma classe bíblica ou pequeno grupo.', '[]'::jsonb, '{}'::text[], false),
(4, 'II - Descoberta Espiritual', 2, 6, 'II.6', 'Leitura bíblica:', '[{"t":"Eclesiastes: 3, 5, 7, 11; 12","sub":[]},{"t":"Isaías: 5, 11, 26:1-12; 35, 40, 43, 52:13-15; 53, 58, 60, 61","sub":[]},{"t":"Jeremias: 9:23-26, 10:1-16, 18:1-6, 26, 36, 52:1-11","sub":[]},{"t":"Daniel: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12","sub":[]},{"t":"Joel: 2:12-31","sub":[]},{"t":"Amós: 7:10-16; 8:4-11","sub":[]},{"t":"Jonas: 1, 2, 3;4","sub":[]},{"t":"Miqueias: 4","sub":[]},{"t":"Ageu: 2","sub":[]},{"t":"Zacarias: 4","sub":[]},{"t":"Malaquias: 3; 4","sub":[]},{"t":"Mateus: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23","sub":[]}]'::jsonb, '{}'::text[], false),
(4, 'III - Servindo a Outros', 3, 1, 'III.1', 'Participar em dois projetos missionários definidos por seu clube.', '[]'::jsonb, '{}'::text[], false),
(4, 'III - Servindo a Outros', 3, 2, 'III.2', 'Trabalhar em um projeto comunitário de sua igreja, escola ou comunidade.', '[]'::jsonb, '{}'::text[], false),
(4, 'IV - Desenvolvendo Amizade', 4, 1, 'IV.1', 'Participar de um debate e fazer uma avaliação pessoal sobre suas atitudes em dois dos seguintes temas:', '[{"t":"Auto-estima","sub":[]},{"t":"Amizade","sub":[]},{"t":"Relacionamentos","sub":[]},{"t":"Otimismo e pessimismo","sub":[]}]'::jsonb, '{}'::text[], false),
(4, 'V - Saúde e Aptidão Física', 5, 1, 'V.1', 'Preparar um programa pessoal de exercícios físicos diários e conversar com seu líder ou conselheiro sobre os princípios de aptidão física. Fazer e assinar um compromisso pessoal de realizar exercícios físicos regularmente.', '[]'::jsonb, '{}'::text[], false),
(4, 'V - Saúde e Aptidão Física', 5, 2, 'V.2', 'Discutir as vantagens do estilo de vida Adventista de acordo com o que a Bíblia ensina.', '[]'::jsonb, '{}'::text[], false),
(4, 'VI - Organização e Liderança', 6, 1, 'VI.1', 'Assistir a um seminário ou treinamento, oferecido pela sua igreja ou distrito nos departamentos abaixo:', '[{"t":"Ministério Pessoal","sub":[]},{"t":"Evangelismo","sub":[]}]'::jsonb, '{}'::text[], false),
(4, 'VI - Organização e Liderança', 6, 2, 'VI.2', 'Participar de uma atividade social de sua igreja.', '[]'::jsonb, '{}'::text[], false),
(4, 'VII - Estudo da Natureza', 7, 1, 'VII.1', 'Estudar a história do dilúvio e o processo de fossilização.', '[]'::jsonb, '{}'::text[], false),
(4, 'VII - Estudo da Natureza', 7, 2, 'VII.2', 'Completar uma especialidade, não realizada anteriormente, em Estudos da Natureza.', '[]'::jsonb, '{}'::text[], false),
(4, 'VIII - Arte de Acampar', 8, 1, 'VIII.1', 'Fazer um fogo refletor e demonstrar seu uso.', '[]'::jsonb, '{}'::text[], false),
(4, 'VIII - Arte de Acampar', 8, 2, 'VIII.2', 'Participar de um acampamento de final de semana, arrumando de forma apropriada sua bolsa ou mochila com o equipamento pessoal necessário.', '[]'::jsonb, '{}'::text[], false),
(4, 'VIII - Arte de Acampar', 8, 3, 'VIII.3', 'Completar a especialidade de Resgate básico.', '[]'::jsonb, array['CS-012']::text[], false),
(4, 'IX - Estilo de Vida', 9, 1, 'IX.1', 'Completar uma especialidade não realizada anteriormente em uma das seguintes áreas:', '[{"t":"Atividades Missionárias","sub":[]},{"t":"Atividades Profissionais","sub":[]},{"t":"Atividades Agrícolas","sub":[]}]'::jsonb, '{}'::text[], false),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 1, 'AV.1', 'Completar a especialidade de Cidadania Cristã, caso não tenha sido realizada anteriormente.', '[]'::jsonb, array['AM-006']::text[], true),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 2, 'AV.2', 'Encenar a história do bom samaritano, demonstrando como ajudar as pessoas e auxiliar de forma prática três pessoas ou mais.', '[]'::jsonb, '{}'::text[], true),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 3, 'AV.3', 'Participar em uma das seguintes atividades, apresentando ao final um relatório escrito contendo, no mínimo, duas páginas:', '[{"t":"Caminhar 10 quilômetros","sub":[]},{"t":"Cavalgar 2 quilômetros","sub":[]},{"t":"Viajar de canoa durante 2 horas","sub":[]},{"t":"Praticar 15 quilômetros de ciclismo","sub":[]},{"t":"Nadar 200 metros","sub":[]},{"t":"Correr 1500 metros","sub":[]},{"t":"Rodar 2 Km de patins ou roller","sub":[]}]'::jsonb, '{}'::text[], true),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 4, 'AV.4', 'Completar a especialidade de Mapa e bússola.', '[]'::jsonb, array['AR-021']::text[], true),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 5, 'AV.5', 'Demonstrar habilidade no uso correto de uma machadinha.', '[]'::jsonb, '{}'::text[], true),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 6, 'AV.6', 'Ser capaz de acender uma fogueira num dia de chuva, saber como conseguir lenha seca e manter o fogo aceso.', '[]'::jsonb, '{}'::text[], true),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 7, 'AV.7', 'Completar um dos seguintes itens:', '[{"t":"Pesquisar e identificar dez variedades de plantas comestíveis.","sub":[]},{"t":"Ser capaz de enviar e receber 35 letras por minuto pelo código semafórico","sub":[]},{"t":"Ser capaz de enviar e receber 35 letras por minuto através do código náutico, usando o código internacional.","sub":[]},{"t":"Ser capaz de apresentar e entender Mateus 24 em LIBRAS (linguagem de sinais)","sub":[]},{"t":"Preparar o Salmo 23 em Braile.","sub":[]}]'::jsonb, '{}'::text[], true),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 8, 'AV.8', 'Completar uma especialidade, não realizadas anteriormente, em Atividades Recreativas.', '[]'::jsonb, '{}'::text[], true),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 9, 'AV.9', 'Pesquisar e identificar, através de fotografia, exposição ou ao vivo, um dos seguintes itens:', '[{"t":"25 folhas de árvores","sub":[]},{"t":"25 rochas e minerais","sub":[]},{"t":"25 flores silvestres","sub":[]},{"t":"25 borboletas e mariposas","sub":[]},{"t":"25 conchas","sub":[]}]'::jsonb, '{}'::text[], true),
(4, 'Classe Avançada - Pioneiro de Novas Fronteiras', 10, 10, 'AV.10', 'Completar a especialidade de Fogueiras e cozinha ao ar livre.', '[]'::jsonb, array['AR-020']::text[], true),
(5, 'I - Geral', 1, 1, 'I.1', 'Ter, no mínimo, 14 anos de idade.', '[]'::jsonb, '{}'::text[], false),
(5, 'I - Geral', 1, 2, 'I.2', 'Ser membro ativo do Clube de Desbravadores.', '[]'::jsonb, '{}'::text[], false),
(5, 'I - Geral', 1, 3, 'I.3', 'Memorizar e explicar o significado do Objetivo JA.', '[]'::jsonb, '{}'::text[], false),
(5, 'I - Geral', 1, 4, 'I.4', 'Ler o livro do Clube do Livro Juvenil do ano em curso e resumi-lo em uma página.', '[]'::jsonb, '{}'::text[], false),
(5, 'I - Geral', 1, 5, 'I.5', 'Ler o livro "O Fim do Começo".', '[]'::jsonb, '{}'::text[], false),
(5, 'II - Descoberta Espiritual', 2, 1, 'II.1', 'Memorizar e demonstrar o seu conhecimento:', '[{"t":"12 Apóstolos: O nome do 12 apóstolos de Cristo","sub":[]},{"t":"Frutos do Espírito: A relação dos adjetivos do caráter do cristão","sub":[]}]'::jsonb, '{}'::text[], false),
(5, 'II - Descoberta Espiritual', 2, 2, 'II.2', 'Ler e explicar os versos abaixo:', '[{"t":"Rom. 8:28","sub":[]},{"t":"Apoc. 21:1-3","sub":[]},{"t":"II Ped. 1:20-21","sub":[]},{"t":"I João 2:14","sub":[]},{"t":"II Cro. 20:20","sub":[]},{"t":"Salmo 46","sub":[]}]'::jsonb, '{}'::text[], false),
(5, 'II - Descoberta Espiritual', 2, 3, 'II.3', 'Estudar e entender a pessoa do Espírito Santo, como Ele se relaciona, e qual o Seu papel no crescimento espiritual de cada ser humano.', '[]'::jsonb, '{}'::text[], false),
(5, 'II - Descoberta Espiritual', 2, 4, 'II.4', 'Estude, com sua unidade, os eventos finais e a segunda vinda de Cristo.', '[]'::jsonb, '{}'::text[], false),
(5, 'II - Descoberta Espiritual', 2, 5, 'II.5', 'Através do estudo da Bíblia, descobrir o verdadeiro significado da observância do sábado.', '[]'::jsonb, '{}'::text[], false),
(5, 'II - Descoberta Espiritual', 2, 6, 'II.6', 'Leitura bíblica:', '[{"t":"Mateus: 24, 25, 26:1-35, 26:36-75, 27:1-31, 27:32-56, 27:57-66, 28","sub":[]},{"t":"Marcos: 7, 9, 10, 11, 12, 16","sub":[]},{"t":"Lucas: 1:4-25, 1:26-66, 2:21-38, 2:39-52, 7:18-28, 8, 10:1-37, 10:38-42; 11:1-13, 12, 13, 14, 15, 16:1-17, 17, 18, 19, 21, 22, 23, 24","sub":[]},{"t":"João: 1, 2, 3, 4, 5, 6:1-21, 6:22-71, 8:1-38, 9, 10, 11:1-46, 12, 13, 14, 15, 17, 18, 19, 20, 21","sub":[]},{"t":"Atos: 1, 2, 3, 4, 5, 6, 7, 8","sub":[]}]'::jsonb, '{}'::text[], false),
(5, 'III - Servindo a Outros', 3, 1, 'III.1', 'Convidar um amigo para participar de uma atividade social de sua igreja ou da Associação/Missão.', '[]'::jsonb, '{}'::text[], false),
(5, 'III - Servindo a Outros', 3, 2, 'III.2', 'Participar de um projeto comunitário desde o planejamento, organização até a execução.', '[]'::jsonb, '{}'::text[], false),
(5, 'III - Servindo a Outros', 3, 3, 'III.3', 'Discutir como os jovens adventistas devem se relacionar com as pessoas nas diferentes situações do dia a dia, tais como:', '[{"t":"Vizinhos","sub":[]},{"t":"Escola","sub":[]},{"t":"Atividades sociais","sub":[]},{"t":"Atividades recreativas","sub":[]}]'::jsonb, '{}'::text[], false),
(5, 'IV - Desenvolvendo Amizade', 4, 1, 'IV.1', 'Através de uma conversa em grupo ou avaliação pessoal, examinar suas atitudes em dois dos seguintes temas:', '[{"t":"Auto-estima","sub":[]},{"t":"Relacionamento familiar","sub":[]},{"t":"Finanças pessoais","sub":[]},{"t":"Pressão de grupo","sub":[]}]'::jsonb, '{}'::text[], false),
(5, 'IV - Desenvolvendo Amizade', 4, 2, 'IV.2', 'Preparar uma lista contendo cinco sugestões de atividades recreativas para ajudar pessoas com necessidades específicas e colaborar na organização de uma dessas atividades para essas pessoas.', '[]'::jsonb, '{}'::text[], false),
(5, 'V - Saúde e Aptidão Física', 5, 1, 'V.1', 'Completar a especialidade de Temperança.', '[]'::jsonb, array['AM-013']::text[], false),
(5, 'VI - Organização e Liderança', 6, 1, 'VI.1', 'Preparar um organograma da igreja local e relacionar as funções dos departamentos.', '[]'::jsonb, '{}'::text[], false),
(5, 'VI - Organização e Liderança', 6, 2, 'VI.2', 'Participar em dois programas envolvendo diferentes departamentos da igreja local.', '[]'::jsonb, '{}'::text[], false),
(5, 'VI - Organização e Liderança', 6, 3, 'VI.3', 'Completar a especialidade de Aventuras com Cristo.', '[]'::jsonb, array['AM-016']::text[], false),
(5, 'VII - Estudo da Natureza', 7, 1, 'VII.1', 'Recapitular a historia de Nicodemos e relacioná-la com o ciclo de vida da lagarta ou borboleta, acrescentando um significado espiritual.', '[]'::jsonb, '{}'::text[], false)
on conflict (class_id, codigo) do update set secao = excluded.secao, secao_ordem = excluded.secao_ordem, ordem = excluded.ordem, texto = excluded.texto, detalhes = excluded.detalhes, especialidades = excluded.especialidades, avancada = excluded.avancada;

insert into public.caderno_itens (class_id, secao, secao_ordem, ordem, codigo, texto, detalhes, especialidades, avancada) values
(5, 'VII - Estudo da Natureza', 7, 2, 'VII.2', 'Completar uma especialidade de Estudos da Natureza, não realizada anteriormente.', '[]'::jsonb, '{}'::text[], false),
(5, 'VIII - Arte de Acampar', 8, 1, 'VIII.1', 'Com um grupo de, no mínimo quatro pessoas e com a presença de um conselheiro adulto e experiente, andar pelo menos 20 quilômetros numa área rural ou deserta, incluindo uma noite ao ar livre ou em barraca. Planejar a expedição em detalhes antes da saída. Durante a caminhada, efetuar anotações sobre o terreno, flora e fauna observados. Depois, usando as anotações, participar em uma discussão de grupo, dirigida por seu conselheiro.', '[]'::jsonb, '{}'::text[], false),
(5, 'VIII - Arte de Acampar', 8, 2, 'VIII.2', 'Completar a especialidade de Pioneirias.', '[]'::jsonb, array['AR-101']::text[], false),
(5, 'IX - Estilo de Vida', 9, 1, 'IX.1', 'Completar uma especialidade, não realizada anteriormente, em uma das seguintes áreas:', '[{"t":"Atividades missionárias","sub":[]},{"t":"Atividades agrícolas","sub":[]},{"t":"Ciência e saúde","sub":[]},{"t":"Habilidades domésticas","sub":[]}]'::jsonb, '{}'::text[], false),
(5, 'Classe Avançada - Excursionista na Mata', 10, 1, 'AV.1', 'Fazer uma apresentação escrita ou falada sobre o respeito que devemos ter com a Lei de Deus e as autoridades civis, enumerando pelo menos 10 princípios de comportamento moral.', '[]'::jsonb, '{}'::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 2, 'AV.2', 'Acompanhar seu pastor ou ancião em uma visita missionária ou estudo bíblico.', '[]'::jsonb, '{}'::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 3, 'AV.3', 'Completar a especialidade de Testemunho Juvenil.', '[]'::jsonb, array['AM-010']::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 4, 'AV.4', 'Apresentar cinco atividades na natureza, para serem realizadas no Sábado à tarde.', '[]'::jsonb, '{}'::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 5, 'AV.5', 'Com sua unidade, construir cinco móveis de acampamento e um portal para o clube.', '[]'::jsonb, '{}'::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 6, 'AV.6', 'Através da supervisão de seu líder ou conselheiro, conversar em sua unidade ou clube sobre um dos seguintes temas:', '[{"t":"Modéstia cristã","sub":[]},{"t":"Recreação","sub":[]},{"t":"Saúde","sub":[]},{"t":"Observância do sábado","sub":[]}]'::jsonb, '{}'::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 7, 'AV.7', 'Demonstrar conhecimento para encontrar alimentos, através de plantas silvestres de sua região e saber diferenciá-las de plantas tóxicas/venenosas.', '[]'::jsonb, '{}'::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 8, 'AV.8', 'Demonstrar conhecimento quanto aos procedimentos necessários em caso de ferimentos por diferentes animais peçonhentos e não peçonhentos.', '[]'::jsonb, '{}'::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 9, 'AV.9', 'Demonstrar técnicas para percorrer trilhas em diferentes tipos de terrenos, como: desertos, florestas, pântanos e rios.', '[]'::jsonb, '{}'::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 10, 'AV.10', 'Completar a especialidade de Vida Silvestre.', '[]'::jsonb, array['AR-024']::text[], true),
(5, 'Classe Avançada - Excursionista na Mata', 10, 11, 'AV.11', 'Completar a especialidade de Ordem Unida, caso não tenha sido realizada anteriormente.', '[]'::jsonb, array['AR-047']::text[], true),
(6, 'I - Geral', 1, 1, 'I.1', 'Ter, no mínimo, 15 anos de idade.', '[]'::jsonb, '{}'::text[], false),
(6, 'I - Geral', 1, 2, 'I.2', 'Ser membro ativo do clube de Desbravadores.', '[]'::jsonb, '{}'::text[], false),
(6, 'I - Geral', 1, 3, 'I.3', 'Memorizar e explicar o Voto de Fidelidade à Bíblia.', '[]'::jsonb, '{}'::text[], false),
(6, 'I - Geral', 1, 4, 'I.4', 'Ler o livro do Clube de Leitura Juvenil do ano em curso e resumi-lo em uma página.', '[]'::jsonb, '{}'::text[], false),
(6, 'I - Geral', 1, 5, 'I.5', 'Ler o livro "O livro amargo".', '[]'::jsonb, '{}'::text[], false),
(6, 'II - Descoberta Espiritual', 2, 1, 'II.1', 'Memorizar e demonstrar o seu conhecimento:', '[{"t":"3 mensagens Angélicas: Reveladas em Apocalipse 14:6-12","sub":[]},{"t":"7 Igrejas: O nome das igrejas do Apocalipse","sub":[]},{"t":"Pedras Preciosas: Os 12 fundamentos da Cidade Santa - A Nova Jerusalém","sub":[]}]'::jsonb, '{}'::text[], false),
(6, 'II - Descoberta Espiritual', 2, 2, 'II.2', 'Ler e explicar os versos abaixo:', '[{"t":"I Cor. 13","sub":[]},{"t":"II Cron. 7:14","sub":[]},{"t":"Apoc. 22:18-20","sub":[]},{"t":"II Tim. 4:6-7","sub":[]},{"t":"Rom. 8:38-39","sub":[]},{"t":"Mateus 6:33-34","sub":[]}]'::jsonb, '{}'::text[], false),
(6, 'II - Descoberta Espiritual', 2, 3, 'II.3', 'Descrever os dons espirituais mencionados nos escritos de Paulo (Coríntios, Efésios, Filipenses) e para quais objetivos a igreja recebe estes dons.', '[]'::jsonb, '{}'::text[], false),
(6, 'II - Descoberta Espiritual', 2, 4, 'II.4', 'Estudar a estrutura e serviço do santuário no Antigo Testamento e relacionar com o ministério pessoal de Jesus e a cruz.', '[]'::jsonb, '{}'::text[], false),
(6, 'II - Descoberta Espiritual', 2, 5, 'II.5', 'Ler e resumir três histórias de pioneiros adventistas. Contar essas histórias na reunião do clube, no culto JA ou na Escola Sabatina.', '[]'::jsonb, '{}'::text[], false),
(6, 'II - Descoberta Espiritual', 2, 6, 'II.6', 'Leitura bíblica:', '[{"t":"Atos: 9:1-31, 9:32-43, 10, 11, 12, 13, 14, 16, 17:1-15, 17:16-34, 18, 19:1-22, 19:23-41, 20, 21:17-40; 22:1-16, 23, 24, 25, 26, 27, 28","sub":[]},{"t":"Romanos: 12, 13, 14","sub":[]},{"t":"1 Coríntios: 13","sub":[]},{"t":"2 Coríntios: 5:11-21, 11:16-33; 12:1-10","sub":[]},{"t":"Gálatas: 5:16-26; 6:1-10","sub":[]},{"t":"Efésios: 5:1-21, 6","sub":[]},{"t":"Filipenses: 4","sub":[]},{"t":"Colosenses: 3","sub":[]},{"t":"1 Tessalonissenses: 4:13-18, 5","sub":[]},{"t":"2 Tessalonissenses: 2, 3","sub":[]},{"t":"1 Timóteo: 4:6-16, 5:1-16; 6:11-21","sub":[]},{"t":"2 Timóteo: 2, 3","sub":[]},{"t":"Filemom:","sub":[]},{"t":"Hebreus: 11","sub":[]},{"t":"Tiago: 1, 3, 5:7-20","sub":[]},{"t":"1 Pedro: 1,, 5:1-11","sub":[]},{"t":"2 Pedro: 3","sub":[]},{"t":"1 João: 2, 3, 4, 5","sub":[]},{"t":"Judas: 1:17:25","sub":[]},{"t":"Apocalipse 1, 2, 3, 7:9-17, 12, 13, 14, 19, 20, 21","sub":[]}]'::jsonb, '{}'::text[], false),
(6, 'III - Servindo a Outros', 3, 1, 'III.1', 'Ajudar a organizar e participar em uma das seguintes atividades:', '[{"t":"Fazer uma visita de cortesia a uma pessoa doente","sub":[]},{"t":"Adotar uma pessoa ou família em necessidade e ajudá-los","sub":[]},{"t":"Um projeto de sua escolha aprovado por seu líder","sub":[]}]'::jsonb, '{}'::text[], false),
(6, 'III - Servindo a Outros', 3, 2, 'III.2', 'Discutir com sua unidade os métodos de evangelismo pessoal e colocar alguns princípios em prática.', '[]'::jsonb, '{}'::text[], false),
(6, 'IV - Desenvolvendo Amizade', 4, 1, 'IV.1', 'Assistir a uma palestra ou aula e examinar suas atitudes em relação a dois dos seguintes temas:', '[{"t":"A Importância da escolha profissional","sub":[]},{"t":"Como se relacionar com os pais","sub":[]},{"t":"A escolha da pessoa certa para namorar","sub":[]},{"t":"O plano de Deus para o sexo","sub":[]}]'::jsonb, '{}'::text[], false),
(6, 'V - Saúde e Aptidão Física', 5, 1, 'V.1', 'Fazer uma apresentação, para alunos do ensino fundamental, sobre os oito remédios naturais dados por Deus.', '[]'::jsonb, '{}'::text[], false),
(6, 'V - Saúde e Aptidão Física', 5, 2, 'V.2', 'Completar uma das seguintes atividades:', '[{"t":"Escrever uma poesia ou artigo sobre saúde para ser divulgado em uma revista, boletim ou jornal da igreja","sub":[]},{"t":"Individualmente ou em grupo, organizar e participar em uma corrida ou atividade similar e apresentar com antecedência um programa de treinamento físico para este evento","sub":[]},{"t":"Ler as páginas 102-125 do livro \"Temperança\", de Ellen White, e apresentar em uma página ou mais, 10 textos selecionados da leitura","sub":[]},{"t":"Completar a especialidade de Nutrição ou liderar um grupo para a especialidade de Cultura física","sub":[]}]'::jsonb, array['CS-008', 'AR-002']::text[], false),
(6, 'VI - Organização e Liderança', 6, 1, 'VI.1', 'Preparar um organograma da estrutura administrativa da Igreja Adventista em sua Divisão.', '[]'::jsonb, '{}'::text[], false),
(6, 'VI - Organização e Liderança', 6, 2, 'VI.2', 'Participar em um dos itens abaixo:', '[{"t":"Curso para conselheiros","sub":[]},{"t":"Convenção de liderança da Associação/Missão","sub":[]},{"t":"2 reuniões de diretoria de seu clube","sub":[]}]'::jsonb, '{}'::text[], false),
(6, 'VI - Organização e Liderança', 6, 3, 'VI.3', 'Planejar e ensinar, no mínimo, dois requisitos de uma especialidade para um grupo de desbravadores.', '[]'::jsonb, '{}'::text[], false),
(6, 'VII - Estudo da Natureza', 7, 1, 'VII.1', 'Ler o capitulo 7 do livro "O Desejado de Todas as Nações" sobre a infância de Jesus. Apresentar para um grupo, clube ou unidade as lições encontradas, demonstrando a importância que o estudo da natureza exerceu na educação e no ministério de Jesus.', '[]'::jsonb, '{}'::text[], false),
(6, 'VII - Estudo da Natureza', 7, 2, 'VII.2', 'Completar uma das seguintes especialidades:', '[{"t":"Ecologia","sub":[]},{"t":"Conservação Ambiental","sub":[]}]'::jsonb, array['EN-044', 'EN-046']::text[], false),
(6, 'VIII - Arte de Acampar', 8, 1, 'VIII.1', 'Participar com sua unidade de um acampamento com estrutura de pioneiria, planejar o que deve ser levado e o que vai acontecer neste acampamento.', '[]'::jsonb, '{}'::text[], false),
(6, 'VIII - Arte de Acampar', 8, 2, 'VIII.2', 'Planejar, preparar e cozinhar três refeições ao ar livre.', '[]'::jsonb, '{}'::text[], false),
(6, 'VIII - Arte de Acampar', 8, 3, 'VIII.3', 'Construir e utilizar um móvel de acampamento em tamanho real, com nós e amarras.', '[]'::jsonb, '{}'::text[], false),
(6, 'VIII - Arte de Acampar', 8, 4, 'VIII.4', 'Completar uma especialidade, não realizada anteriormente, que possa ser contada para um dos Mestrados abaixo:', '[{"t":"Aquática","sub":[]},{"t":"Esportes","sub":[]},{"t":"Atividades Recreativas","sub":[]},{"t":"Vida Campestre","sub":[]}]'::jsonb, array['ME-007', 'ME-008', 'ME-010', 'ME-009']::text[], false),
(6, 'IX - Estilo de Vida', 9, 1, 'IX.1', 'Completar uma especialidade, não realizada anteriormente, em alguma das seguintes áreas:', '[{"t":"Atividades agrícolas","sub":[]},{"t":"Ciência e saúde","sub":[]},{"t":"Habilidades domésticas","sub":[]},{"t":"Atividades profissionais","sub":[]}]'::jsonb, '{}'::text[], false),
(6, 'Classe Avançada - Guia de Exploração', 10, 1, 'AV.1', 'Completar a especialidade de Mordomia.', '[]'::jsonb, array['AMEB-021']::text[], true),
(6, 'Classe Avançada - Guia de Exploração', 10, 2, 'AV.2', 'Ler o livro "O maior discurso de Cristo" e escrever uma página sobre o efeito da leitura em sua vida.', '[]'::jsonb, '{}'::text[], true),
(6, 'Classe Avançada - Guia de Exploração', 10, 3, 'AV.3', 'Cumprir um dos seguintes itens:', '[{"t":"Trazer dois amigos para assistir a duas diferentes reuniões da igreja.","sub":[]},{"t":"Ajudar a planejar e participar de, no mínimo, quatro domingos em uma série de evangelismo jovem.","sub":[]}]'::jsonb, '{}'::text[], true),
(6, 'Classe Avançada - Guia de Exploração', 10, 4, 'AV.4', 'Escrever uma página ou apresentar uma palestra sobre como influenciar amigos para Cristo.', '[]'::jsonb, '{}'::text[], true),
(6, 'Classe Avançada - Guia de Exploração', 10, 5, 'AV.5', 'Observar durante o período de dois meses o trabalho dos diáconos, apresentando um relatório detalhado de suas atividades, contendo:', '[{"t":"Cuidado da propriedade da igreja","sub":[]},{"t":"Cerimônia de lava-pés","sub":[]},{"t":"Cerimônia de batismo","sub":[]},{"t":"Recolhimento dos dízimos e ofertas","sub":[]}]'::jsonb, '{}'::text[], true),
(6, 'Classe Avançada - Guia de Exploração', 10, 6, 'AV.6', 'Completar o mestrado em Vida Campestre.', '[]'::jsonb, array['ME-009']::text[], true),
(6, 'Classe Avançada - Guia de Exploração', 10, 7, 'AV.7', 'Projetar três tipos diferentes de abrigo, explicar seu uso e utilizar um deles em um acampamento.', '[]'::jsonb, '{}'::text[], true),
(6, 'Classe Avançada - Guia de Exploração', 10, 8, 'AV.8', 'Assistir um seminário ou apresentar uma palestra sobre dois dos seguintes temas:', '[{"t":"Aborto","sub":[]},{"t":"Bullying","sub":[]},{"t":"Violência","sub":[]},{"t":"Drogas","sub":[]},{"t":"Doenças sexualmente transmissíveis","sub":[]}]'::jsonb, '{}'::text[], true),
(6, 'Classe Avançada - Guia de Exploração', 10, 9, 'AV.9', 'Completar a especialidade de Orçamento familiar.', '[]'::jsonb, array['HD-006']::text[], true),
(6, 'Classe Avançada - Guia de Exploração', 10, 10, 'AV.10', 'Completar a especialidade de Liderança campestre.', '[]'::jsonb, array['AR-057']::text[], true)
on conflict (class_id, codigo) do update set secao = excluded.secao, secao_ordem = excluded.secao_ordem, ordem = excluded.ordem, texto = excluded.texto, detalhes = excluded.detalhes, especialidades = excluded.especialidades, avancada = excluded.avancada;

insert into public.class_especialidades (class_id, especialidade_codigo, obrigatoria) values
(1, 'AR-003', true),
(1, 'AR-002', true),
(1, 'AR-040', true),
(1, 'AR-090', true),
(1, 'EN-024', true),
(1, 'EN-034', true),
(1, 'EN-010', true),
(1, 'EN-040', true),
(1, 'EN-020', true),
(1, 'AR-050', true),
(1, 'AR-001', true),
(2, 'AR-004', true),
(2, 'AR-051', true),
(2, 'EN-023', true),
(2, 'EN-003', true),
(2, 'EN-004', true),
(2, 'AA-014', true),
(2, 'EN-011', true),
(2, 'EN-014', true),
(2, 'EN-006', true),
(2, 'EN-019', true),
(2, 'AR-056', true),
(3, 'EN-002', true),
(3, 'EN-015', true),
(3, 'EN-016', true),
(3, 'EN-005', true),
(3, 'EN-050', true),
(3, 'AR-052', true),
(3, 'CS-003', true),
(3, 'AM-012', true),
(4, 'CS-012', true),
(4, 'AM-006', true),
(4, 'AR-021', true),
(4, 'AR-020', true),
(5, 'AM-013', true),
(5, 'AM-016', true),
(5, 'AR-101', true),
(5, 'AM-010', true),
(5, 'AR-024', true),
(5, 'AR-047', true),
(6, 'CS-008', true),
(6, 'AR-002', true),
(6, 'EN-044', true),
(6, 'EN-046', true),
(6, 'ME-007', true),
(6, 'ME-008', true),
(6, 'ME-010', true),
(6, 'ME-009', true),
(6, 'AMEB-021', true),
(6, 'HD-006', true),
(6, 'AR-057', true)
on conflict (class_id, especialidade_codigo) do update set obrigatoria = true;

commit;
