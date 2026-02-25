// ======================================================================
// Desafio 03 — Rede Social de Apreciadores de Livros
// DADOS: 22 usuários · 52 livros · 48 autores · 9 gêneros
//        6 comunidades · 32 posts · interações completas
// ======================================================================
// cypher-shell -u neo4j -p secret2026 -f desafio03/initial.cyp
// ======================================================================

// Limpeza do banco
MATCH (n) DETACH DELETE n;

// =====================================================================
// 1. GÊNEROS (9)
// =====================================================================
UNWIND [
  {id:1, nome:'Ficção Científica',       descricao:'Narrativas especulativas sobre ciência e tecnologia'},
  {id:2, nome:'Fantasia',                descricao:'Mundos imaginários com elementos mágicos e sobrenaturais'},
  {id:3, nome:'Romance',                 descricao:'Histórias centradas em relacionamentos afetivos'},
  {id:4, nome:'Mistério e Thriller',     descricao:'Narrativas de suspense, investigação e tensão'},
  {id:5, nome:'Terror',                  descricao:'Histórias perturbadoras que evocam medo e angústia'},
  {id:6, nome:'Literatura Brasileira',   descricao:'Obras de autores nacionais de todas as épocas'},
  {id:7, nome:'Desenvolvimento Pessoal', descricao:'Guias para crescimento pessoal e profissional'},
  {id:8, nome:'Biografia',               descricao:'Relatos de vida de personalidades históricas e contemporâneas'},
  {id:9, nome:'Ficção Clássica',         descricao:'Grandes obras da literatura universal'}
] AS g
CREATE (:Genero {id: g.id, nome: g.nome, descricao: g.descricao});

// =====================================================================
// 2. AUTORES (48)
// =====================================================================
UNWIND [
  {id: 1, nome:'Isaac Asimov',              nac:'Americano'},
  {id: 2, nome:'Frank Herbert',             nac:'Americano'},
  {id: 3, nome:'George Orwell',             nac:'Britânico'},
  {id: 4, nome:'Aldous Huxley',             nac:'Britânico'},
  {id: 5, nome:'William Gibson',            nac:'Americano-Canadense'},
  {id: 6, nome:'Douglas Adams',             nac:'Britânico'},
  {id: 7, nome:'Ray Bradbury',              nac:'Americano'},
  {id: 8, nome:'Orson Scott Card',          nac:'Americano'},
  {id: 9, nome:'J.R.R. Tolkien',            nac:'Britânico'},
  {id:10, nome:'J.K. Rowling',              nac:'Britânica'},
  {id:11, nome:'Patrick Rothfuss',          nac:'Americano'},
  {id:12, nome:'George R.R. Martin',        nac:'Americano'},
  {id:13, nome:'Neil Gaiman',               nac:'Britânico'},
  {id:14, nome:'Brandon Sanderson',         nac:'Americano'},
  {id:15, nome:'Jane Austen',               nac:'Britânica'},
  {id:16, nome:'John Green',                nac:'Americano'},
  {id:17, nome:'Emily Brontë',              nac:'Britânica'},
  {id:18, nome:'Lev Tolstói',               nac:'Russo'},
  {id:19, nome:'Jojo Moyes',                nac:'Britânica'},
  {id:20, nome:'Agatha Christie',           nac:'Britânica'},
  {id:21, nome:'Gillian Flynn',             nac:'Americana'},
  {id:22, nome:'Dan Brown',                 nac:'Americano'},
  {id:23, nome:'Stieg Larsson',             nac:'Sueco'},
  {id:24, nome:'Thomas Harris',             nac:'Americano'},
  {id:25, nome:'Stephen King',              nac:'Americano'},
  {id:26, nome:'Bram Stoker',               nac:'Irlandês'},
  {id:27, nome:'Mary Shelley',              nac:'Britânica'},
  {id:28, nome:'João Guimarães Rosa',       nac:'Brasileiro'},
  {id:29, nome:'Graciliano Ramos',          nac:'Brasileiro'},
  {id:30, nome:'Machado de Assis',          nac:'Brasileiro'},
  {id:31, nome:'Clarice Lispector',         nac:'Brasileira'},
  {id:32, nome:'Jorge Amado',               nac:'Brasileiro'},
  {id:33, nome:'Carolina Maria de Jesus',   nac:'Brasileira'},
  {id:34, nome:'Paulo Coelho',              nac:'Brasileiro'},
  {id:35, nome:'Aluísio Azevedo',           nac:'Brasileiro'},
  {id:36, nome:'Charles Duhigg',            nac:'Americano'},
  {id:37, nome:'Carol Dweck',               nac:'Americana'},
  {id:38, nome:'James Clear',               nac:'Americano'},
  {id:39, nome:'Mark Manson',               nac:'Americano'},
  {id:40, nome:'Greg McKeown',              nac:'Britânico'},
  {id:41, nome:'Stephen Covey',             nac:'Americano'},
  {id:42, nome:'Walter Isaacson',           nac:'Americano'},
  {id:43, nome:'Yuval Noah Harari',         nac:'Israelense'},
  {id:44, nome:'Malala Yousafzai',          nac:'Paquistanesa'},
  {id:45, nome:'Alex Haley',                nac:'Americano'},
  {id:46, nome:'Fiódor Dostoiévski',        nac:'Russo'},
  {id:47, nome:'Gabriel García Márquez',    nac:'Colombiano'},
  {id:48, nome:'F. Scott Fitzgerald',       nac:'Americano'}
] AS a
CREATE (:Autor {id: a.id, nome: a.nome, nacionalidade: a.nac});

// =====================================================================
// 3. LIVROS (52)
// =====================================================================
UNWIND [
  // Ficção Científica
  {id: 1, titulo:'Fundação',                                    ano:1951, pag:244,  isbn:'978-8576573289'},
  {id: 2, titulo:'Duna',                                        ano:1965, pag:896,  isbn:'978-8576573302'},
  {id: 3, titulo:'1984',                                        ano:1949, pag:328,  isbn:'978-8535909555'},
  {id: 4, titulo:'Admirável Mundo Novo',                        ano:1932, pag:311,  isbn:'978-8535909562'},
  {id: 5, titulo:'Neuromancer',                                 ano:1984, pag:271,  isbn:'978-8576570301'},
  {id: 6, titulo:'O Guia do Mochileiro das Galáxias',          ano:1979, pag:193,  isbn:'978-8599977309'},
  {id: 7, titulo:'Fahrenheit 451',                              ano:1953, pag:274,  isbn:'978-8556510648'},
  {id: 8, titulo:'O Jogo de Ender',                             ano:1985, pag:352,  isbn:'978-8576573678'},
  // Fantasia
  {id: 9, titulo:'O Senhor dos Anéis',                          ano:1954, pag:1216, isbn:'978-8578278441'},
  {id:10, titulo:'Harry Potter e a Pedra Filosofal',            ano:1997, pag:264,  isbn:'978-8532530783'},
  {id:11, titulo:'O Nome do Vento',                             ano:2007, pag:662,  isbn:'978-8580411041'},
  {id:12, titulo:'A Guerra dos Tronos',                         ano:1996, pag:813,  isbn:'978-8556510969'},
  {id:13, titulo:'O Hobbit',                                    ano:1937, pag:336,  isbn:'978-8578272081'},
  {id:14, titulo:'American Gods',                               ano:2001, pag:560,  isbn:'978-8580412826'},
  {id:15, titulo:'Mistborn: O Império Final',                   ano:2006, pag:672,  isbn:'978-8556510204'},
  // Romance
  {id:16, titulo:'Orgulho e Preconceito',                       ano:1813, pag:432,  isbn:'978-8520926748'},
  {id:17, titulo:'A Culpa é das Estrelas',                      ano:2012, pag:286,  isbn:'978-8580575477'},
  {id:18, titulo:'O Morro dos Ventos Uivantes',                 ano:1847, pag:356,  isbn:'978-8520926755'},
  {id:19, titulo:'Anna Karenina',                               ano:1877, pag:944,  isbn:'978-8535925517'},
  {id:20, titulo:'Me Before You',                               ano:2012, pag:369,  isbn:'978-0143124542'},
  // Mistério e Thriller
  {id:21, titulo:'Assassinato no Expresso do Oriente',          ano:1934, pag:272,  isbn:'978-8520928612'},
  {id:22, titulo:'Garota Exemplar',                             ano:2012, pag:432,  isbn:'978-8556510310'},
  {id:23, titulo:'O Código Da Vinci',                           ano:2003, pag:488,  isbn:'978-8575421864'},
  {id:24, titulo:'Os Homens que Não Amavam as Mulheres',        ano:2005, pag:672,  isbn:'978-8599296097'},
  {id:25, titulo:'O Silêncio dos Inocentes',                    ano:1988, pag:353,  isbn:'978-8556510389'},
  // Terror
  {id:26, titulo:'It: A Coisa',                                 ano:1986, pag:1104, isbn:'978-8532528667'},
  {id:27, titulo:'O Iluminado',                                 ano:1977, pag:480,  isbn:'978-8532528674'},
  {id:28, titulo:'Drácula',                                     ano:1897, pag:491,  isbn:'978-8535929683'},
  {id:29, titulo:'Frankenstein',                                ano:1818, pag:288,  isbn:'978-8535929690'},
  // Literatura Brasileira
  {id:30, titulo:'Grande Sertão: Veredas',                      ano:1956, pag:624,  isbn:'978-8503010498'},
  {id:31, titulo:'Vidas Secas',                                 ano:1938, pag:176,  isbn:'978-8503010504'},
  {id:32, titulo:'Dom Casmurro',                                ano:1899, pag:256,  isbn:'978-8503010511'},
  {id:33, titulo:'A Hora da Estrela',                           ano:1977, pag:96,   isbn:'978-8532210890'},
  {id:34, titulo:'Capitães da Areia',                           ano:1937, pag:288,  isbn:'978-8503010528'},
  {id:35, titulo:'Quarto de Despejo',                           ano:1960, pag:200,  isbn:'978-8503010535'},
  {id:36, titulo:'Memórias Póstumas de Brás Cubas',             ano:1881, pag:256,  isbn:'978-8503010542'},
  {id:37, titulo:'O Alquimista',                                ano:1988, pag:208,  isbn:'978-8575040010'},
  {id:38, titulo:'O Cortiço',                                   ano:1890, pag:304,  isbn:'978-8503010559'},
  // Desenvolvimento Pessoal
  {id:39, titulo:'O Poder do Hábito',                           ano:2012, pag:408,  isbn:'978-8539003389'},
  {id:40, titulo:'Mindset',                                     ano:2006, pag:296,  isbn:'978-8543102009'},
  {id:41, titulo:'Hábitos Atômicos',                            ano:2018, pag:320,  isbn:'978-6555643336'},
  {id:42, titulo:'A Sutil Arte de Ligar o F*da-se',             ano:2016, pag:224,  isbn:'978-8543102139'},
  {id:43, titulo:'Essencialismo',                               ano:2014, pag:272,  isbn:'978-8543102603'},
  {id:44, titulo:'Os 7 Hábitos das Pessoas Altamente Eficazes', ano:1989, pag:358,  isbn:'978-8576841364'},
  // Biografia
  {id:45, titulo:'Steve Jobs',                                  ano:2011, pag:624,  isbn:'978-8535919370'},
  {id:46, titulo:'Sapiens',                                     ano:2011, pag:464,  isbn:'978-8535928525'},
  {id:47, titulo:'Homo Deus',                                   ano:2015, pag:464,  isbn:'978-8535928532'},
  {id:48, titulo:'Eu Sou Malala',                               ano:2013, pag:336,  isbn:'978-8551000120'},
  {id:49, titulo:'A Autobiografia de Malcolm X',                ano:1965, pag:528,  isbn:'978-8532528308'},
  // Ficção Clássica
  {id:50, titulo:'Crime e Castigo',                             ano:1866, pag:592,  isbn:'978-8535929706'},
  {id:51, titulo:'Cem Anos de Solidão',                         ano:1967, pag:432,  isbn:'978-8535909677'},
  {id:52, titulo:'O Grande Gatsby',                             ano:1925, pag:224,  isbn:'978-8535929713'}
] AS l
CREATE (:Livro {id: l.id, titulo: l.titulo, anoPublicacao: l.ano, paginas: l.pag, isbn: l.isbn});

// =====================================================================
// 4. USUÁRIOS (22)
// =====================================================================
UNWIND [
  {id: 1, nome:'Ana Lima',         email:'ana.lima@email.com',         cidade:'São Paulo',       bio:'Apaixonada por fantasia e ficção científica',             dt:'2023-01-15T10:00:00Z'},
  {id: 2, nome:'Carlos Ferreira',  email:'carlos.ferreira@email.com',  cidade:'Belo Horizonte',  bio:'Leitor voraz de fantasia épica',                          dt:'2023-01-28T14:30:00Z'},
  {id: 3, nome:'Maria Santos',     email:'maria.santos@email.com',     cidade:'Salvador',        bio:'Fã de literatura brasileira e clássicos',                  dt:'2023-02-05T09:00:00Z'},
  {id: 4, nome:'João Oliveira',    email:'joao.oliveira@email.com',    cidade:'Curitiba',        bio:'Nerd de ficção científica e distopias',                    dt:'2023-02-18T11:20:00Z'},
  {id: 5, nome:'Fernanda Costa',   email:'fernanda.costa@email.com',   cidade:'Recife',          bio:'Defensora da literatura nacional',                         dt:'2023-03-01T08:45:00Z'},
  {id: 6, nome:'Rafael Mendes',    email:'rafael.mendes@email.com',    cidade:'Porto Alegre',    bio:'Leitor eclético com paixão por fantasia',                  dt:'2023-03-12T16:00:00Z'},
  {id: 7, nome:'Patricia Silva',   email:'patricia.silva@email.com',   cidade:'Fortaleza',       bio:'Especialista em Machado de Assis e romances',              dt:'2023-03-20T13:30:00Z'},
  {id: 8, nome:'Bruno Alves',      email:'bruno.alves@email.com',      cidade:'Manaus',          bio:'Obcecado por thrillers e suspense',                        dt:'2023-04-02T10:15:00Z'},
  {id: 9, nome:'Lucia Rodrigues',  email:'lucia.rodrigues@email.com',  cidade:'Goiânia',         bio:'Romance, clássicos e literatura brasileira',               dt:'2023-04-15T09:30:00Z'},
  {id:10, nome:'Eduardo Pereira',  email:'eduardo.pereira@email.com',  cidade:'Brasília',        bio:'Ficção científica e livros de crescimento pessoal',        dt:'2023-04-25T15:00:00Z'},
  {id:11, nome:'Camila Martins',   email:'camila.martins@email.com',   cidade:'Florianópolis',   bio:'Romântica apaixonada por clássicos',                      dt:'2023-05-03T12:00:00Z'},
  {id:12, nome:'Felipe Souza',     email:'felipe.souza@email.com',     cidade:'Campinas',        bio:'Ficção científica e grandes clássicos da literatura',      dt:'2023-05-14T17:45:00Z'},
  {id:13, nome:'Juliana Barbosa',  email:'juliana.barbosa@email.com',  cidade:'Rio de Janeiro',  bio:'Fantasy e romance são minha vida',                        dt:'2023-05-25T10:00:00Z'},
  {id:14, nome:'Diego Castro',     email:'diego.castro@email.com',     cidade:'Vitória',         bio:'Fã de Stephen King e Agatha Christie',                    dt:'2023-06-05T14:20:00Z'},
  {id:15, nome:'Amanda Nunes',     email:'amanda.nunes@email.com',     cidade:'Natal',           bio:'Romance e desenvolvimento pessoal me movem',              dt:'2023-06-18T11:30:00Z'},
  {id:16, nome:'Thiago Gomes',     email:'thiago.gomes@email.com',     cidade:'Maceió',          bio:'Thriller e autodesenvolvimento lado a lado',              dt:'2023-07-01T09:00:00Z'},
  {id:17, nome:'Bianca Moreira',   email:'bianca.moreira@email.com',   cidade:'Teresina',        bio:'Romance, biografias e histórias inspiradoras',            dt:'2023-07-14T16:15:00Z'},
  {id:18, nome:'Leonardo Dias',    email:'leonardo.dias@email.com',    cidade:'Campo Grande',    bio:'Apaixonado por sci-fi e fantasia épica',                  dt:'2023-07-28T13:00:00Z'},
  {id:19, nome:'Vanessa Lima',     email:'vanessa.lima@email.com',     cidade:'João Pessoa',     bio:'Literatura brasileira e romances clássicos',              dt:'2023-08-08T10:45:00Z'},
  {id:20, nome:'Marcos Ribeiro',   email:'marcos.ribeiro@email.com',   cidade:'São Luís',        bio:'Mistério, conspirações e sci-fi',                         dt:'2023-08-20T14:00:00Z'},
  {id:21, nome:'Sandra Carvalho',  email:'sandra.carvalho@email.com',  cidade:'São Paulo',       bio:'Literatura brasileira e livros de crescimento pessoal',   dt:'2023-09-01T09:30:00Z'},
  {id:22, nome:'Roberto Vieira',   email:'roberto.vieira@email.com',   cidade:'Rio de Janeiro',  bio:'Sci-fi, biografias e não-ficção',                         dt:'2023-09-15T11:00:00Z'}
] AS u
CREATE (:Usuario {id: u.id, nome: u.nome, email: u.email, cidade: u.cidade, bio: u.bio,
                  dataCadastro: datetime(u.dt)});

// =====================================================================
// 5. COMUNIDADES (6)
// =====================================================================
UNWIND [
  {id:1, nome:'Clube de Leitura de Fantasia',     desc:'Discussões sobre mundos mágicos e épicos',        dt:'2023-02-01'},
  {id:2, nome:'Ficção Científica do Brasil',       desc:'Sci-fi e distopias para apaixonados pelo futuro', dt:'2023-03-10'},
  {id:3, nome:'Amantes do Romance',               desc:'Histórias de amor que tocam o coração',           dt:'2023-03-22'},
  {id:4, nome:'Mestres do Suspense',              desc:'Thrillers, mistérios e terror em debate',          dt:'2023-04-15'},
  {id:5, nome:'Literatura Brasileira em Foco',    desc:'Celebrando nossos autores e obras nacionais',     dt:'2023-05-01'},
  {id:6, nome:'Crescimento com Livros',           desc:'Desenvolvimento pessoal e profissional por livros',dt:'2023-06-01'}
] AS c
CREATE (:Comunidade {id: c.id, nome: c.nome, descricao: c.desc, dataCriacao: date(c.dt)});

// =====================================================================
// 6. POSTS (32)
// =====================================================================
UNWIND [
  // ── Resenhas ───────────────────────────────────────────────────────
  {id: 1, tipo:'Resenha',       data:'2024-01-08',
   conteudo:'Harry Potter e a Pedra Filosofal me transportou para um mundo mágico desde a primeira página. Uma obra que atravessa gerações e ainda emociona. Recomendo para todas as idades!'},
  {id: 2, tipo:'Resenha',       data:'2024-01-10',
   conteudo:'Duna é simplesmente épico. A construção política e ecológica do universo de Arrakis é extraordinária. Frank Herbert foi um gênio visionário que todo leitor de sci-fi precisa conhecer.'},
  {id: 3, tipo:'Resenha',       data:'2024-01-12',
   conteudo:'Dom Casmurro é uma obra-prima da literatura brasileira. A ambiguidade de Capitu ainda me fascina depois de tantas leituras. Machado de Assis é simplesmente o maior.'},
  {id: 4, tipo:'Resenha',       data:'2024-01-15',
   conteudo:'1984 é perturbador e assustadoramente atual. Uma distopia que parece cada vez mais real. Leitura obrigatória para entender os mecanismos de controle do poder.'},
  {id: 5, tipo:'Resenha',       data:'2024-01-18',
   conteudo:'Mistborn: O Império Final superou todas as expectativas. O sistema de magia do allomancy é brilhantemente construído e a reviravolta final me deixou de queixo caído!'},
  {id: 6, tipo:'Resenha',       data:'2024-01-20',
   conteudo:'A Hora da Estrela é de uma sensibilidade única. Clarice Lispector escreve o que não tem palavras. Uma obra atemporal que revela o Brasil invisível com imenso lirismo.'},
  {id: 7, tipo:'Resenha',       data:'2024-01-22',
   conteudo:'Garota Exemplar é viciante do início ao fim. Gillian Flynn é mestre em construir personagens complexos e reviravoltas que nos deixam desconfiados de tudo.'},
  {id: 8, tipo:'Resenha',       data:'2024-01-25',
   conteudo:'O Poder do Hábito mudou minha relação com a rotina. Charles Duhigg explica com precisão como os hábitos funcionam no cérebro. Comecei a aplicar os conceitos no mesmo dia.'},
  {id: 9, tipo:'Resenha',       data:'2024-01-28',
   conteudo:'Sapiens é leitura obrigatória para qualquer pessoa curiosa sobre a humanidade. Yuval Harari explica 70.000 anos de história de forma acessível e fascinante.'},
  {id:10, tipo:'Resenha',       data:'2024-01-30',
   conteudo:'Crime e Castigo é denso, mas a jornada psicológica de Raskólnikov é inesquecível. Dostoiévski mergulha na culpa e na redenção com uma profundidade que poucos escritores alcançaram.'},
  {id:11, tipo:'Resenha',       data:'2024-02-03',
   conteudo:'O Alquimista continua sendo inspirador em cada releitura. A história de Santiago é universal — fala sobre coragem de seguir os próprios sonhos. Um clássico atemporal de Paulo Coelho.'},
  {id:12, tipo:'Resenha',       data:'2024-02-06',
   conteudo:'American Gods é uma viagem literária alucinante pela América através de deuses esquecidos. Neil Gaiman criou algo extraordinário que mistura mitologia e crítica cultural.'},
  {id:13, tipo:'Resenha',       data:'2024-02-09',
   conteudo:'Hábitos Atômicos transformou minha produtividade. James Clear apresenta um sistema prático e embasado em ciência. Pequenas mudanças geram resultados extraordinários.'},
  {id:14, tipo:'Resenha',       data:'2024-02-12',
   conteudo:'Assassinato no Expresso do Oriente é Agatha Christie no seu melhor. A solução do mistério é genial e surpreende até os leitores mais atentos. Poirot é magnífico!'},
  {id:15, tipo:'Resenha',       data:'2024-02-15',
   conteudo:'Cem Anos de Solidão é uma experiência de leitura diferente de tudo que já li. García Márquez criou um universo mágico e denso que exige atenção mas recompensa imensamente.'},
  // ── Recomendações ──────────────────────────────────────────────────
  {id:16, tipo:'Recomendação',  data:'2024-02-18',
   conteudo:'Para quem ama fantasia, O Nome do Vento é leitura absolutamente obrigatória! Patrick Rothfuss construiu o sistema de magia mais elegante e uma narrativa que prende do início ao fim.'},
  {id:17, tipo:'Recomendação',  data:'2024-02-20',
   conteudo:'Se você ainda não leu Vidas Secas de Graciliano Ramos, está perdendo uma das obras mais poderosas da nossa literatura. Curto, denso e devastadoramente humano.'},
  {id:18, tipo:'Recomendação',  data:'2024-02-22',
   conteudo:'Para amantes de sci-fi que não sabem por onde começar, Fundação de Isaac Asimov é o ponto de partida perfeito. Uma saga épica sobre o colapso e renascimento da civilização.'},
  {id:19, tipo:'Recomendação',  data:'2024-03-01',
   conteudo:'Quem curte thriller psicológico precisa ler Os Homens que Não Amavam as Mulheres! Stieg Larsson criou uma narrativa envolvente com uma das protagonistas mais marcantes da literatura.'},
  {id:20, tipo:'Recomendação',  data:'2024-03-04',
   conteudo:'Orgulho e Preconceito é muito mais do que um romance clássico — é um estudo sofisticado sobre julgamentos, preconceitos e crescimento pessoal. Jane Austen era genial.'},
  {id:21, tipo:'Recomendação',  data:'2024-03-06',
   conteudo:'A Sutil Arte de Ligar o F*da-se é refrescantemente honesto. Mark Manson fala verdades difíceis de ouvir mas necessárias. Um antídoto para a cultura do pensamento positivo.'},
  {id:22, tipo:'Recomendação',  data:'2024-03-09',
   conteudo:'O Hobbit é a porta de entrada perfeita para a Terra Média de Tolkien. Mágico, aventureiro e acessível para todas as idades. Leitura essencial para qualquer fã de fantasia!'},
  {id:23, tipo:'Recomendação',  data:'2024-03-12',
   conteudo:'Eu Sou Malala é uma história de coragem extraordinária. A narrativa de Malala sobre sua luta pela educação nos inspira e nos lembra do poder transformador do conhecimento.'},
  // ── Discussões ──────────────────────────────────────────────────────
  {id:24, tipo:'Discussão',     data:'2024-03-15',
   conteudo:'Qual é a melhor obra de Stephen King? Estou em dúvida entre It e O Iluminado. Cada releitura me convence de um diferente. Compartilhem suas opiniões!'},
  {id:25, tipo:'Discussão',     data:'2024-03-17',
   conteudo:'Alguém mais acha que 1984 e Admirável Mundo Novo são leituras complementares perfeitas? Dois retratos distópicos, dois mecanismos de controle totalmente diferentes.'},
  {id:26, tipo:'Discussão',     data:'2024-03-19',
   conteudo:'Capitu traiu ou não traiu? Essa é a grande questão não respondida da literatura brasileira! Após muitas releituras ainda não consigo me decidir. O que vocês acham?'},
  {id:27, tipo:'Discussão',     data:'2024-03-21',
   conteudo:'Precisando de sugestão para o clube de leitura de outubro: Drácula ou Frankenstein? Ambos são clássicos do terror do século XIX. Qual vocês preferem?'},
  {id:28, tipo:'Discussão',     data:'2024-03-23',
   conteudo:'Alguém mais relê Harry Potter durante o inverno? Parece que a magia fica mais vívida quando está frio. Já é minha terceira releitura e ainda me emociono da mesma forma!'},
  {id:29, tipo:'Discussão',     data:'2024-03-25',
   conteudo:'Depois de ler Sapiens fiquei obcecado com Homo Deus. Como vocês enxergam as previsões de Harari sobre IA e o futuro da humanidade à luz do que está acontecendo em 2024?'},
  {id:30, tipo:'Discussão',     data:'2024-03-27',
   conteudo:'Grande Sertão: Veredas exige paciência e dedicação, mas a recompensa é imensurável. A linguagem de Guimarães Rosa é uma experiência única. Demorei 3 meses para terminar e valeu cada página.'},
  {id:31, tipo:'Discussão',     data:'2024-03-28',
   conteudo:'A série Fundação da Apple TV fez justiça ao livro de Isaac Asimov? Estou dividido: adorei a produção visual, mas as diferenças em relação ao original me incomodam.'},
  {id:32, tipo:'Discussão',     data:'2024-03-30',
   conteudo:'Quem mais ficou completamente obcecado com o sistema de magia do Mistborn depois de terminar o primeiro livro? Já comecei o segundo e não consigo mais parar!'}
] AS p
CREATE (:Post {id: p.id, tipo: p.tipo, conteudo: p.conteudo, dataPublicacao: date(p.data)});

// =====================================================================
// 7. ESCREVEU (Autor → Livro)
// =====================================================================
UNWIND [
  {a:'Isaac Asimov',           l:'Fundação'},
  {a:'Frank Herbert',          l:'Duna'},
  {a:'George Orwell',          l:'1984'},
  {a:'Aldous Huxley',          l:'Admirável Mundo Novo'},
  {a:'William Gibson',         l:'Neuromancer'},
  {a:'Douglas Adams',          l:'O Guia do Mochileiro das Galáxias'},
  {a:'Ray Bradbury',           l:'Fahrenheit 451'},
  {a:'Orson Scott Card',       l:'O Jogo de Ender'},
  {a:'J.R.R. Tolkien',         l:'O Senhor dos Anéis'},
  {a:'J.R.R. Tolkien',         l:'O Hobbit'},
  {a:'J.K. Rowling',           l:'Harry Potter e a Pedra Filosofal'},
  {a:'Patrick Rothfuss',       l:'O Nome do Vento'},
  {a:'George R.R. Martin',     l:'A Guerra dos Tronos'},
  {a:'Neil Gaiman',            l:'American Gods'},
  {a:'Brandon Sanderson',      l:'Mistborn: O Império Final'},
  {a:'Jane Austen',            l:'Orgulho e Preconceito'},
  {a:'John Green',             l:'A Culpa é das Estrelas'},
  {a:'Emily Brontë',           l:'O Morro dos Ventos Uivantes'},
  {a:'Lev Tolstói',            l:'Anna Karenina'},
  {a:'Jojo Moyes',             l:'Me Before You'},
  {a:'Agatha Christie',        l:'Assassinato no Expresso do Oriente'},
  {a:'Gillian Flynn',          l:'Garota Exemplar'},
  {a:'Dan Brown',              l:'O Código Da Vinci'},
  {a:'Stieg Larsson',          l:'Os Homens que Não Amavam as Mulheres'},
  {a:'Thomas Harris',          l:'O Silêncio dos Inocentes'},
  {a:'Stephen King',           l:'It: A Coisa'},
  {a:'Stephen King',           l:'O Iluminado'},
  {a:'Bram Stoker',            l:'Drácula'},
  {a:'Mary Shelley',           l:'Frankenstein'},
  {a:'João Guimarães Rosa',    l:'Grande Sertão: Veredas'},
  {a:'Graciliano Ramos',       l:'Vidas Secas'},
  {a:'Machado de Assis',       l:'Dom Casmurro'},
  {a:'Machado de Assis',       l:'Memórias Póstumas de Brás Cubas'},
  {a:'Clarice Lispector',      l:'A Hora da Estrela'},
  {a:'Jorge Amado',            l:'Capitães da Areia'},
  {a:'Carolina Maria de Jesus',l:'Quarto de Despejo'},
  {a:'Paulo Coelho',           l:'O Alquimista'},
  {a:'Aluísio Azevedo',        l:'O Cortiço'},
  {a:'Charles Duhigg',         l:'O Poder do Hábito'},
  {a:'Carol Dweck',            l:'Mindset'},
  {a:'James Clear',            l:'Hábitos Atômicos'},
  {a:'Mark Manson',            l:'A Sutil Arte de Ligar o F*da-se'},
  {a:'Greg McKeown',           l:'Essencialismo'},
  {a:'Stephen Covey',          l:'Os 7 Hábitos das Pessoas Altamente Eficazes'},
  {a:'Walter Isaacson',        l:'Steve Jobs'},
  {a:'Yuval Noah Harari',      l:'Sapiens'},
  {a:'Yuval Noah Harari',      l:'Homo Deus'},
  {a:'Malala Yousafzai',       l:'Eu Sou Malala'},
  {a:'Alex Haley',             l:'A Autobiografia de Malcolm X'},
  {a:'Fiódor Dostoiévski',     l:'Crime e Castigo'},
  {a:'Gabriel García Márquez', l:'Cem Anos de Solidão'},
  {a:'F. Scott Fitzgerald',    l:'O Grande Gatsby'}
] AS rel
MATCH (a:Autor {nome: rel.a}), (l:Livro {titulo: rel.l})
CREATE (a)-[:ESCREVEU]->(l);

// =====================================================================
// 8. PERTENCE_AO (Livro → Genero)
// =====================================================================
UNWIND [
  // Ficção Científica
  {l:'Fundação',                              g:'Ficção Científica'},
  {l:'Duna',                                  g:'Ficção Científica'},
  {l:'1984',                                  g:'Ficção Científica'},
  {l:'Admirável Mundo Novo',                  g:'Ficção Científica'},
  {l:'Neuromancer',                           g:'Ficção Científica'},
  {l:'O Guia do Mochileiro das Galáxias',    g:'Ficção Científica'},
  {l:'Fahrenheit 451',                        g:'Ficção Científica'},
  {l:'O Jogo de Ender',                       g:'Ficção Científica'},
  // Fantasia
  {l:'O Senhor dos Anéis',                    g:'Fantasia'},
  {l:'Harry Potter e a Pedra Filosofal',      g:'Fantasia'},
  {l:'O Nome do Vento',                       g:'Fantasia'},
  {l:'A Guerra dos Tronos',                   g:'Fantasia'},
  {l:'O Hobbit',                              g:'Fantasia'},
  {l:'American Gods',                         g:'Fantasia'},
  {l:'Mistborn: O Império Final',             g:'Fantasia'},
  // Romance
  {l:'Orgulho e Preconceito',                 g:'Romance'},
  {l:'A Culpa é das Estrelas',               g:'Romance'},
  {l:'O Morro dos Ventos Uivantes',          g:'Romance'},
  {l:'Anna Karenina',                         g:'Romance'},
  {l:'Me Before You',                         g:'Romance'},
  // Mistério e Thriller
  {l:'Assassinato no Expresso do Oriente',   g:'Mistério e Thriller'},
  {l:'Garota Exemplar',                       g:'Mistério e Thriller'},
  {l:'O Código Da Vinci',                     g:'Mistério e Thriller'},
  {l:'Os Homens que Não Amavam as Mulheres', g:'Mistério e Thriller'},
  {l:'O Silêncio dos Inocentes',             g:'Mistério e Thriller'},
  // Terror
  {l:'It: A Coisa',                           g:'Terror'},
  {l:'O Iluminado',                           g:'Terror'},
  {l:'Drácula',                               g:'Terror'},
  {l:'Frankenstein',                          g:'Terror'},
  // Literatura Brasileira
  {l:'Grande Sertão: Veredas',               g:'Literatura Brasileira'},
  {l:'Vidas Secas',                           g:'Literatura Brasileira'},
  {l:'Dom Casmurro',                          g:'Literatura Brasileira'},
  {l:'A Hora da Estrela',                     g:'Literatura Brasileira'},
  {l:'Capitães da Areia',                     g:'Literatura Brasileira'},
  {l:'Quarto de Despejo',                     g:'Literatura Brasileira'},
  {l:'Memórias Póstumas de Brás Cubas',      g:'Literatura Brasileira'},
  {l:'O Alquimista',                          g:'Literatura Brasileira'},
  {l:'O Cortiço',                             g:'Literatura Brasileira'},
  // Desenvolvimento Pessoal
  {l:'O Poder do Hábito',                     g:'Desenvolvimento Pessoal'},
  {l:'Mindset',                               g:'Desenvolvimento Pessoal'},
  {l:'Hábitos Atômicos',                      g:'Desenvolvimento Pessoal'},
  {l:'A Sutil Arte de Ligar o F*da-se',      g:'Desenvolvimento Pessoal'},
  {l:'Essencialismo',                         g:'Desenvolvimento Pessoal'},
  {l:'Os 7 Hábitos das Pessoas Altamente Eficazes', g:'Desenvolvimento Pessoal'},
  // Biografia
  {l:'Steve Jobs',                            g:'Biografia'},
  {l:'Sapiens',                               g:'Biografia'},
  {l:'Homo Deus',                             g:'Biografia'},
  {l:'Eu Sou Malala',                         g:'Biografia'},
  {l:'A Autobiografia de Malcolm X',          g:'Biografia'},
  // Ficção Clássica
  {l:'Crime e Castigo',                       g:'Ficção Clássica'},
  {l:'Cem Anos de Solidão',                   g:'Ficção Clássica'},
  {l:'O Grande Gatsby',                       g:'Ficção Clássica'},
  // Cruzamentos relevantes
  {l:'1984',                                  g:'Ficção Clássica'},
  {l:'Orgulho e Preconceito',                 g:'Ficção Clássica'},
  {l:'O Alquimista',                          g:'Ficção Clássica'}
] AS rel
MATCH (l:Livro {titulo: rel.l}), (g:Genero {nome: rel.g})
CREATE (l)-[:PERTENCE_AO]->(g);

// =====================================================================
// 9. SEGUE (Usuario → Usuario)
// =====================================================================
UNWIND [
  // Ana Lima (1) segue
  {de:'Ana Lima',        para:'Carlos Ferreira'}, {de:'Ana Lima',        para:'Maria Santos'},
  {de:'Ana Lima',        para:'Fernanda Costa'},  {de:'Ana Lima',        para:'Rafael Mendes'},
  // Carlos Ferreira (2) segue
  {de:'Carlos Ferreira', para:'Ana Lima'},         {de:'Carlos Ferreira', para:'João Oliveira'},
  {de:'Carlos Ferreira', para:'Eduardo Pereira'},
  // Maria Santos (3) segue
  {de:'Maria Santos',    para:'Fernanda Costa'},   {de:'Maria Santos',    para:'Patricia Silva'},
  {de:'Maria Santos',    para:'Lucia Rodrigues'},  {de:'Maria Santos',    para:'Sandra Carvalho'},
  // João Oliveira (4) segue
  {de:'João Oliveira',   para:'Carlos Ferreira'},  {de:'João Oliveira',   para:'Eduardo Pereira'},
  {de:'João Oliveira',   para:'Felipe Souza'},     {de:'João Oliveira',   para:'Marcos Ribeiro'},
  // Fernanda Costa (5) segue
  {de:'Fernanda Costa',  para:'Maria Santos'},     {de:'Fernanda Costa',  para:'Patricia Silva'},
  {de:'Fernanda Costa',  para:'Lucia Rodrigues'},
  // Rafael Mendes (6) segue
  {de:'Rafael Mendes',   para:'Ana Lima'},         {de:'Rafael Mendes',   para:'Carlos Ferreira'},
  {de:'Rafael Mendes',   para:'Juliana Barbosa'},
  // Patricia Silva (7) segue
  {de:'Patricia Silva',  para:'Maria Santos'},     {de:'Patricia Silva',  para:'Camila Martins'},
  {de:'Patricia Silva',  para:'Sandra Carvalho'},
  // Bruno Alves (8) segue
  {de:'Bruno Alves',     para:'Diego Castro'},     {de:'Bruno Alves',     para:'Thiago Gomes'},
  {de:'Bruno Alves',     para:'Marcos Ribeiro'},
  // Lucia Rodrigues (9) segue
  {de:'Lucia Rodrigues', para:'Maria Santos'},     {de:'Lucia Rodrigues', para:'Camila Martins'},
  {de:'Lucia Rodrigues', para:'Vanessa Lima'},
  // Eduardo Pereira (10) segue
  {de:'Eduardo Pereira', para:'João Oliveira'},    {de:'Eduardo Pereira', para:'Roberto Vieira'},
  {de:'Eduardo Pereira', para:'Felipe Souza'},
  // Camila Martins (11) segue
  {de:'Camila Martins',  para:'Maria Santos'},     {de:'Camila Martins',  para:'Lucia Rodrigues'},
  {de:'Camila Martins',  para:'Amanda Nunes'},
  // Felipe Souza (12) segue
  {de:'Felipe Souza',    para:'João Oliveira'},    {de:'Felipe Souza',    para:'Eduardo Pereira'},
  {de:'Felipe Souza',    para:'Roberto Vieira'},
  // Juliana Barbosa (13) segue
  {de:'Juliana Barbosa', para:'Ana Lima'},         {de:'Juliana Barbosa', para:'Rafael Mendes'},
  {de:'Juliana Barbosa', para:'Leonardo Dias'},
  // Diego Castro (14) segue
  {de:'Diego Castro',    para:'Bruno Alves'},      {de:'Diego Castro',    para:'Thiago Gomes'},
  // Amanda Nunes (15) segue
  {de:'Amanda Nunes',    para:'Camila Martins'},   {de:'Amanda Nunes',    para:'Bianca Moreira'},
  {de:'Amanda Nunes',    para:'Lucia Rodrigues'},
  // Thiago Gomes (16) segue
  {de:'Thiago Gomes',    para:'Bruno Alves'},      {de:'Thiago Gomes',    para:'Diego Castro'},
  {de:'Thiago Gomes',    para:'Eduardo Pereira'},
  // Bianca Moreira (17) segue
  {de:'Bianca Moreira',  para:'Camila Martins'},   {de:'Bianca Moreira',  para:'Amanda Nunes'},
  {de:'Bianca Moreira',  para:'Roberto Vieira'},
  // Leonardo Dias (18) segue
  {de:'Leonardo Dias',   para:'Carlos Ferreira'},  {de:'Leonardo Dias',   para:'Rafael Mendes'},
  {de:'Leonardo Dias',   para:'João Oliveira'},
  // Vanessa Lima (19) segue
  {de:'Vanessa Lima',    para:'Maria Santos'},     {de:'Vanessa Lima',    para:'Lucia Rodrigues'},
  {de:'Vanessa Lima',    para:'Patricia Silva'},
  // Marcos Ribeiro (20) segue
  {de:'Marcos Ribeiro',  para:'Bruno Alves'},      {de:'Marcos Ribeiro',  para:'João Oliveira'},
  {de:'Marcos Ribeiro',  para:'Eduardo Pereira'},
  // Sandra Carvalho (21) segue
  {de:'Sandra Carvalho', para:'Maria Santos'},     {de:'Sandra Carvalho', para:'Fernanda Costa'},
  {de:'Sandra Carvalho', para:'Patricia Silva'},
  // Roberto Vieira (22) segue
  {de:'Roberto Vieira',  para:'Eduardo Pereira'},  {de:'Roberto Vieira',  para:'Felipe Souza'},
  {de:'Roberto Vieira',  para:'Marcos Ribeiro'}
] AS rel
MATCH (u1:Usuario {nome: rel.de}), (u2:Usuario {nome: rel.para})
CREATE (u1)-[:SEGUE {dataInicio: datetime('2023-10-01T10:00:00Z')}]->(u2);

// =====================================================================
// 10. INTERESSA_SE (Usuario → Genero)
// =====================================================================
UNWIND [
  {u:'Ana Lima',         gs:['Fantasia','Ficção Científica','Terror']},
  {u:'Carlos Ferreira',  gs:['Fantasia','Ficção Científica']},
  {u:'Maria Santos',     gs:['Literatura Brasileira','Romance','Ficção Clássica']},
  {u:'João Oliveira',    gs:['Ficção Científica','Ficção Clássica']},
  {u:'Fernanda Costa',   gs:['Literatura Brasileira','Ficção Clássica']},
  {u:'Rafael Mendes',    gs:['Fantasia','Ficção Científica','Ficção Clássica']},
  {u:'Patricia Silva',   gs:['Literatura Brasileira','Romance']},
  {u:'Bruno Alves',      gs:['Mistério e Thriller','Terror']},
  {u:'Lucia Rodrigues',  gs:['Romance','Literatura Brasileira','Ficção Clássica']},
  {u:'Eduardo Pereira',  gs:['Ficção Científica','Desenvolvimento Pessoal']},
  {u:'Camila Martins',   gs:['Romance','Ficção Clássica']},
  {u:'Felipe Souza',     gs:['Ficção Científica','Ficção Clássica']},
  {u:'Juliana Barbosa',  gs:['Fantasia','Romance']},
  {u:'Diego Castro',     gs:['Mistério e Thriller','Terror']},
  {u:'Amanda Nunes',     gs:['Romance','Desenvolvimento Pessoal']},
  {u:'Thiago Gomes',     gs:['Mistério e Thriller','Desenvolvimento Pessoal']},
  {u:'Bianca Moreira',   gs:['Romance','Biografia']},
  {u:'Leonardo Dias',    gs:['Fantasia','Ficção Científica']},
  {u:'Vanessa Lima',     gs:['Romance','Literatura Brasileira']},
  {u:'Marcos Ribeiro',   gs:['Mistério e Thriller','Ficção Científica']},
  {u:'Sandra Carvalho',  gs:['Literatura Brasileira','Desenvolvimento Pessoal']},
  {u:'Roberto Vieira',   gs:['Ficção Científica','Biografia']}
] AS entry
MATCH (u:Usuario {nome: entry.u})
UNWIND entry.gs AS gNome
MATCH (g:Genero {nome: gNome})
CREATE (u)-[:INTERESSA_SE]->(g);

// =====================================================================
// 11. MEMBRO_DE (Usuario → Comunidade)
// =====================================================================
UNWIND [
  {u:'Ana Lima',         cs:['Clube de Leitura de Fantasia','Ficção Científica do Brasil']},
  {u:'Carlos Ferreira',  cs:['Clube de Leitura de Fantasia','Ficção Científica do Brasil']},
  {u:'Maria Santos',     cs:['Literatura Brasileira em Foco','Amantes do Romance']},
  {u:'João Oliveira',    cs:['Ficção Científica do Brasil']},
  {u:'Fernanda Costa',   cs:['Literatura Brasileira em Foco']},
  {u:'Rafael Mendes',    cs:['Clube de Leitura de Fantasia','Ficção Científica do Brasil']},
  {u:'Patricia Silva',   cs:['Literatura Brasileira em Foco','Amantes do Romance']},
  {u:'Bruno Alves',      cs:['Mestres do Suspense']},
  {u:'Lucia Rodrigues',  cs:['Amantes do Romance','Literatura Brasileira em Foco']},
  {u:'Eduardo Pereira',  cs:['Ficção Científica do Brasil','Crescimento com Livros']},
  {u:'Camila Martins',   cs:['Amantes do Romance']},
  {u:'Felipe Souza',     cs:['Ficção Científica do Brasil']},
  {u:'Juliana Barbosa',  cs:['Clube de Leitura de Fantasia','Amantes do Romance']},
  {u:'Diego Castro',     cs:['Mestres do Suspense']},
  {u:'Amanda Nunes',     cs:['Amantes do Romance','Crescimento com Livros']},
  {u:'Thiago Gomes',     cs:['Mestres do Suspense','Crescimento com Livros']},
  {u:'Bianca Moreira',   cs:['Amantes do Romance']},
  {u:'Leonardo Dias',    cs:['Clube de Leitura de Fantasia','Ficção Científica do Brasil']},
  {u:'Vanessa Lima',     cs:['Amantes do Romance','Literatura Brasileira em Foco']},
  {u:'Marcos Ribeiro',   cs:['Mestres do Suspense','Ficção Científica do Brasil']},
  {u:'Sandra Carvalho',  cs:['Literatura Brasileira em Foco','Crescimento com Livros']},
  {u:'Roberto Vieira',   cs:['Ficção Científica do Brasil']}
] AS entry
MATCH (u:Usuario {nome: entry.u})
UNWIND entry.cs AS cNome
MATCH (c:Comunidade {nome: cNome})
CREATE (u)-[:MEMBRO_DE {dataEntrada: date('2023-11-01')}]->(c);

// =====================================================================
// 12. JA_LEU (Usuario → Livro)
// =====================================================================
UNWIND [
  {u:'Ana Lima',        ls:['Harry Potter e a Pedra Filosofal','O Senhor dos Anéis','American Gods','It: A Coisa','O Guia do Mochileiro das Galáxias','Duna']},
  {u:'Carlos Ferreira', ls:['Harry Potter e a Pedra Filosofal','O Hobbit','Mistborn: O Império Final','A Guerra dos Tronos','Neuromancer','Fundação']},
  {u:'Maria Santos',    ls:['Dom Casmurro','Vidas Secas','Grande Sertão: Veredas','A Hora da Estrela','Orgulho e Preconceito','Cem Anos de Solidão']},
  {u:'João Oliveira',   ls:['Duna','Fundação','1984','Admirável Mundo Novo','O Jogo de Ender','Crime e Castigo']},
  {u:'Fernanda Costa',  ls:['A Hora da Estrela','Quarto de Despejo','Dom Casmurro','Capitães da Areia','Crime e Castigo']},
  {u:'Rafael Mendes',   ls:['American Gods','O Nome do Vento','Cem Anos de Solidão','O Grande Gatsby','Fahrenheit 451']},
  {u:'Patricia Silva',  ls:['Dom Casmurro','O Alquimista','Capitães da Areia','Orgulho e Preconceito','Me Before You']},
  {u:'Bruno Alves',     ls:['Garota Exemplar','Assassinato no Expresso do Oriente','Os Homens que Não Amavam as Mulheres','It: A Coisa','O Silêncio dos Inocentes']},
  {u:'Lucia Rodrigues', ls:['Orgulho e Preconceito','O Cortiço','Cem Anos de Solidão','Me Before You','A Hora da Estrela']},
  {u:'Eduardo Pereira', ls:['1984','Fundação','Sapiens','O Poder do Hábito','Hábitos Atômicos']},
  {u:'Camila Martins',  ls:['Orgulho e Preconceito','Anna Karenina','A Culpa é das Estrelas','O Morro dos Ventos Uivantes','Sapiens']},
  {u:'Felipe Souza',    ls:['Crime e Castigo','1984','Neuromancer','O Grande Gatsby','Admirável Mundo Novo']},
  {u:'Juliana Barbosa', ls:['Harry Potter e a Pedra Filosofal','Orgulho e Preconceito','A Culpa é das Estrelas','O Senhor dos Anéis']},
  {u:'Diego Castro',    ls:['Garota Exemplar','O Código Da Vinci','Assassinato no Expresso do Oriente','Drácula']},
  {u:'Amanda Nunes',    ls:['A Culpa é das Estrelas','Me Before You','Hábitos Atômicos','Mindset','Os 7 Hábitos das Pessoas Altamente Eficazes']},
  {u:'Thiago Gomes',    ls:['O Silêncio dos Inocentes','Os Homens que Não Amavam as Mulheres','A Sutil Arte de Ligar o F*da-se','O Poder do Hábito']},
  {u:'Bianca Moreira',  ls:['A Culpa é das Estrelas','Eu Sou Malala','Steve Jobs','O Morro dos Ventos Uivantes']},
  {u:'Leonardo Dias',   ls:['Fundação','Duna','O Senhor dos Anéis','Mistborn: O Império Final','Neuromancer']},
  {u:'Vanessa Lima',    ls:['Dom Casmurro','O Alquimista','Anna Karenina','Orgulho e Preconceito']},
  {u:'Marcos Ribeiro',  ls:['O Código Da Vinci','Fundação','Garota Exemplar','1984']},
  {u:'Sandra Carvalho', ls:['O Alquimista','Memórias Póstumas de Brás Cubas','O Poder do Hábito','Essencialismo']},
  {u:'Roberto Vieira',  ls:['Fundação','Sapiens','Homo Deus','Steve Jobs','Eu Sou Malala']}
] AS entry
MATCH (u:Usuario {nome: entry.u})
UNWIND entry.ls AS titulo
MATCH (l:Livro {titulo: titulo})
CREATE (u)-[:JA_LEU {dataLeitura: date('2024-01-01')}]->(l);

// =====================================================================
// 13. LENDO (Usuario → Livro)
// =====================================================================
UNWIND [
  {u:'Ana Lima',        l:'O Nome do Vento'},
  {u:'Carlos Ferreira', l:'Fahrenheit 451'},
  {u:'Maria Santos',    l:'O Cortiço'},
  {u:'João Oliveira',   l:'O Guia do Mochileiro das Galáxias'},
  {u:'Fernanda Costa',  l:'Vidas Secas'},
  {u:'Rafael Mendes',   l:'A Guerra dos Tronos'},
  {u:'Patricia Silva',  l:'Grande Sertão: Veredas'},
  {u:'Bruno Alves',     l:'O Iluminado'},
  {u:'Lucia Rodrigues', l:'Capitães da Areia'},
  {u:'Eduardo Pereira', l:'Homo Deus'},
  {u:'Camila Martins',  l:'Me Before You'},
  {u:'Felipe Souza',    l:'Cem Anos de Solidão'},
  {u:'Juliana Barbosa', l:'Mistborn: O Império Final'},
  {u:'Diego Castro',    l:'It: A Coisa'},
  {u:'Amanda Nunes',    l:'O Morro dos Ventos Uivantes'},
  {u:'Thiago Gomes',    l:'O Código Da Vinci'},
  {u:'Bianca Moreira',  l:'Sapiens'},
  {u:'Leonardo Dias',   l:'American Gods'},
  {u:'Vanessa Lima',    l:'A Sutil Arte de Ligar o F*da-se'},
  {u:'Marcos Ribeiro',  l:'Admirável Mundo Novo'},
  {u:'Sandra Carvalho', l:'Mindset'},
  {u:'Roberto Vieira',  l:'A Autobiografia de Malcolm X'}
] AS rel
MATCH (u:Usuario {nome: rel.u}), (l:Livro {titulo: rel.l})
CREATE (u)-[:LENDO {dataInicio: date('2024-06-01')}]->(l);

// =====================================================================
// 14. QUER_LER (Usuario → Livro)
// =====================================================================
UNWIND [
  {u:'Ana Lima',        ls:['Mistborn: O Império Final','A Guerra dos Tronos']},
  {u:'Carlos Ferreira', ls:['American Gods','O Nome do Vento']},
  {u:'Maria Santos',    ls:['Quarto de Despejo','O Cortiço']},
  {u:'João Oliveira',   ls:['Neuromancer','O Jogo de Ender']},
  {u:'Fernanda Costa',  ls:['Grande Sertão: Veredas','Memórias Póstumas de Brás Cubas']},
  {u:'Rafael Mendes',   ls:['O Senhor dos Anéis','Harry Potter e a Pedra Filosofal']},
  {u:'Patricia Silva',  ls:['A Hora da Estrela','Vidas Secas']},
  {u:'Bruno Alves',     ls:['Frankenstein','O Código Da Vinci']},
  {u:'Lucia Rodrigues', ls:['Anna Karenina','Dom Casmurro']},
  {u:'Eduardo Pereira', ls:['A Autobiografia de Malcolm X','Essencialismo']},
  {u:'Camila Martins',  ls:['Anna Karenina','Orgulho e Preconceito']},
  {u:'Felipe Souza',    ls:['Fundação','Dom Casmurro']},
  {u:'Juliana Barbosa', ls:['Anna Karenina','O Nome do Vento']},
  {u:'Diego Castro',    ls:['Frankenstein','O Silêncio dos Inocentes']},
  {u:'Amanda Nunes',    ls:['Sapiens','Anna Karenina']},
  {u:'Thiago Gomes',    ls:['Garota Exemplar','Essencialismo']},
  {u:'Bianca Moreira',  ls:['Eu Sou Malala','A Autobiografia de Malcolm X']},
  {u:'Leonardo Dias',   ls:['A Guerra dos Tronos','O Nome do Vento']},
  {u:'Vanessa Lima',    ls:['Capitães da Areia','Quarto de Despejo']},
  {u:'Marcos Ribeiro',  ls:['Os Homens que Não Amavam as Mulheres','Neuromancer']},
  {u:'Sandra Carvalho', ls:['Hábitos Atômicos','Vidas Secas']},
  {u:'Roberto Vieira',  ls:['Crime e Castigo','Grande Sertão: Veredas']}
] AS entry
MATCH (u:Usuario {nome: entry.u})
UNWIND entry.ls AS titulo
MATCH (l:Livro {titulo: titulo})
CREATE (u)-[:QUER_LER {dataAdicao: date('2024-05-01')}]->(l);

// =====================================================================
// 15. AVALIOU (Usuario → Livro) — nota de 1 a 5
// =====================================================================
UNWIND [
  {u:'Ana Lima',        avs:[{l:'Harry Potter e a Pedra Filosofal',n:5},{l:'O Senhor dos Anéis',n:5},{l:'American Gods',n:4},{l:'It: A Coisa',n:4},{l:'Duna',n:4}]},
  {u:'Carlos Ferreira', avs:[{l:'Harry Potter e a Pedra Filosofal',n:5},{l:'O Hobbit',n:5},{l:'Mistborn: O Império Final',n:5},{l:'A Guerra dos Tronos',n:4},{l:'Fundação',n:5}]},
  {u:'Maria Santos',    avs:[{l:'Dom Casmurro',n:5},{l:'Vidas Secas',n:5},{l:'Grande Sertão: Veredas',n:5},{l:'A Hora da Estrela',n:5},{l:'Cem Anos de Solidão',n:4}]},
  {u:'João Oliveira',   avs:[{l:'Duna',n:5},{l:'Fundação',n:5},{l:'1984',n:5},{l:'Admirável Mundo Novo',n:4},{l:'O Jogo de Ender',n:4}]},
  {u:'Fernanda Costa',  avs:[{l:'A Hora da Estrela',n:5},{l:'Quarto de Despejo',n:5},{l:'Dom Casmurro',n:5},{l:'Capitães da Areia',n:4}]},
  {u:'Rafael Mendes',   avs:[{l:'American Gods',n:5},{l:'O Nome do Vento',n:5},{l:'Cem Anos de Solidão',n:5},{l:'O Grande Gatsby',n:4}]},
  {u:'Patricia Silva',  avs:[{l:'Dom Casmurro',n:4},{l:'O Alquimista',n:4},{l:'Capitães da Areia',n:5},{l:'Orgulho e Preconceito',n:5}]},
  {u:'Bruno Alves',     avs:[{l:'Garota Exemplar',n:5},{l:'Assassinato no Expresso do Oriente',n:5},{l:'Os Homens que Não Amavam as Mulheres',n:4},{l:'It: A Coisa',n:5}]},
  {u:'Lucia Rodrigues', avs:[{l:'Orgulho e Preconceito',n:5},{l:'Me Before You',n:4},{l:'A Hora da Estrela',n:5},{l:'Cem Anos de Solidão',n:4}]},
  {u:'Eduardo Pereira', avs:[{l:'1984',n:5},{l:'Fundação',n:5},{l:'Sapiens',n:5},{l:'O Poder do Hábito',n:4},{l:'Hábitos Atômicos',n:5}]},
  {u:'Camila Martins',  avs:[{l:'Orgulho e Preconceito',n:5},{l:'Anna Karenina',n:5},{l:'A Culpa é das Estrelas',n:5},{l:'Sapiens',n:4}]},
  {u:'Felipe Souza',    avs:[{l:'Crime e Castigo',n:5},{l:'1984',n:5},{l:'Neuromancer',n:4},{l:'O Grande Gatsby',n:4}]},
  {u:'Juliana Barbosa', avs:[{l:'Harry Potter e a Pedra Filosofal',n:5},{l:'Orgulho e Preconceito',n:4},{l:'A Culpa é das Estrelas',n:5},{l:'O Senhor dos Anéis',n:5}]},
  {u:'Diego Castro',    avs:[{l:'Garota Exemplar',n:5},{l:'O Código Da Vinci',n:4},{l:'Assassinato no Expresso do Oriente',n:5}]},
  {u:'Amanda Nunes',    avs:[{l:'A Culpa é das Estrelas',n:5},{l:'Me Before You',n:5},{l:'Hábitos Atômicos',n:5},{l:'Mindset',n:4}]},
  {u:'Thiago Gomes',    avs:[{l:'O Silêncio dos Inocentes',n:4},{l:'Os Homens que Não Amavam as Mulheres',n:4},{l:'A Sutil Arte de Ligar o F*da-se',n:5}]},
  {u:'Bianca Moreira',  avs:[{l:'A Culpa é das Estrelas',n:5},{l:'Eu Sou Malala',n:5},{l:'Steve Jobs',n:4}]},
  {u:'Leonardo Dias',   avs:[{l:'Fundação',n:5},{l:'Duna',n:5},{l:'O Senhor dos Anéis',n:5},{l:'Mistborn: O Império Final',n:5}]},
  {u:'Vanessa Lima',    avs:[{l:'Dom Casmurro',n:4},{l:'O Alquimista',n:5},{l:'Anna Karenina',n:5}]},
  {u:'Marcos Ribeiro',  avs:[{l:'O Código Da Vinci',n:3},{l:'Fundação',n:4},{l:'1984',n:5}]},
  {u:'Sandra Carvalho', avs:[{l:'O Alquimista',n:5},{l:'O Poder do Hábito',n:5},{l:'Essencialismo',n:4}]},
  {u:'Roberto Vieira',  avs:[{l:'Fundação',n:5},{l:'Sapiens',n:5},{l:'Homo Deus',n:4},{l:'Steve Jobs',n:4}]}
] AS entry
MATCH (u:Usuario {nome: entry.u})
UNWIND entry.avs AS av
MATCH (l:Livro {titulo: av.l})
CREATE (u)-[:AVALIOU {nota: av.n, dataAvaliacao: date('2024-06-15')}]->(l);

// =====================================================================
// 16. PUBLICOU (Usuario → Post) e SOBRE (Post → Livro)
// =====================================================================
UNWIND [
  {u:'Ana Lima',         pid: 1,  l:'Harry Potter e a Pedra Filosofal'},
  {u:'João Oliveira',    pid: 2,  l:'Duna'},
  {u:'Maria Santos',     pid: 3,  l:'Dom Casmurro'},
  {u:'Eduardo Pereira',  pid: 4,  l:'1984'},
  {u:'Carlos Ferreira',  pid: 5,  l:'Mistborn: O Império Final'},
  {u:'Fernanda Costa',   pid: 6,  l:'A Hora da Estrela'},
  {u:'Bruno Alves',      pid: 7,  l:'Garota Exemplar'},
  {u:'Patricia Silva',   pid: 8,  l:'O Poder do Hábito'},
  {u:'Camila Martins',   pid: 9,  l:'Sapiens'},
  {u:'Felipe Souza',     pid:10,  l:'Crime e Castigo'},
  {u:'Sandra Carvalho',  pid:11,  l:'O Alquimista'},
  {u:'Rafael Mendes',    pid:12,  l:'American Gods'},
  {u:'Amanda Nunes',     pid:13,  l:'Hábitos Atômicos'},
  {u:'Diego Castro',     pid:14,  l:'Assassinato no Expresso do Oriente'},
  {u:'Lucia Rodrigues',  pid:15,  l:'Cem Anos de Solidão'},
  {u:'Ana Lima',         pid:16,  l:'O Nome do Vento'},
  {u:'Maria Santos',     pid:17,  l:'Vidas Secas'},
  {u:'Eduardo Pereira',  pid:18,  l:'Fundação'},
  {u:'Bruno Alves',      pid:19,  l:'Os Homens que Não Amavam as Mulheres'},
  {u:'Camila Martins',   pid:20,  l:'Orgulho e Preconceito'},
  {u:'Thiago Gomes',     pid:21,  l:'A Sutil Arte de Ligar o F*da-se'},
  {u:'Rafael Mendes',    pid:22,  l:'O Hobbit'},
  {u:'Bianca Moreira',   pid:23,  l:'Eu Sou Malala'},
  {u:'Diego Castro',     pid:24,  l:'It: A Coisa'},
  {u:'João Oliveira',    pid:25,  l:'Admirável Mundo Novo'},
  {u:'Fernanda Costa',   pid:26,  l:'Dom Casmurro'},
  {u:'Patricia Silva',   pid:27,  l:'Drácula'},
  {u:'Juliana Barbosa',  pid:28,  l:'Harry Potter e a Pedra Filosofal'},
  {u:'Marcos Ribeiro',   pid:29,  l:'Homo Deus'},
  {u:'Vanessa Lima',     pid:30,  l:'Grande Sertão: Veredas'},
  {u:'Leonardo Dias',    pid:31,  l:'Fundação'},
  {u:'Carlos Ferreira',  pid:32,  l:'Mistborn: O Império Final'}
] AS rel
MATCH (u:Usuario {nome: rel.u}), (p:Post {id: rel.pid}), (l:Livro {titulo: rel.l})
CREATE (u)-[:PUBLICOU]->(p),
       (p)-[:SOBRE]->(l);

// =====================================================================
// 17. CURTIU (Usuario → Post)
// =====================================================================
UNWIND [
  // Post 1 — Harry Potter resenha (8 curtidas)
  {u:'Carlos Ferreira', pid:1}, {u:'Juliana Barbosa',pid:1}, {u:'Patricia Silva',pid:1},
  {u:'Sandra Carvalho', pid:1}, {u:'Rafael Mendes',  pid:1}, {u:'João Oliveira', pid:1},
  {u:'Bianca Moreira',  pid:1}, {u:'Camila Martins', pid:1},
  // Post 2 — Duna resenha (5 curtidas)
  {u:'Eduardo Pereira', pid:2}, {u:'Rafael Mendes',  pid:2}, {u:'Carlos Ferreira',pid:2},
  {u:'Felipe Souza',    pid:2}, {u:'Leonardo Dias',  pid:2},
  // Post 3 — Dom Casmurro resenha (6 curtidas)
  {u:'Fernanda Costa',  pid:3}, {u:'Patricia Silva', pid:3}, {u:'Lucia Rodrigues',pid:3},
  {u:'Sandra Carvalho', pid:3}, {u:'Vanessa Lima',   pid:3}, {u:'Maria Santos',   pid:3},
  // Post 4 — 1984 resenha (5 curtidas)
  {u:'João Oliveira',   pid:4}, {u:'Carlos Ferreira',pid:4}, {u:'Felipe Souza',   pid:4},
  {u:'Marcos Ribeiro',  pid:4}, {u:'Thiago Gomes',   pid:4},
  // Post 5 — Mistborn resenha (4 curtidas)
  {u:'Ana Lima',        pid:5}, {u:'Juliana Barbosa',pid:5}, {u:'Leonardo Dias',  pid:5},
  {u:'Rafael Mendes',   pid:5},
  // Post 6 — A Hora da Estrela (4 curtidas)
  {u:'Maria Santos',    pid:6}, {u:'Patricia Silva', pid:6}, {u:'Sandra Carvalho',pid:6},
  {u:'Lucia Rodrigues', pid:6},
  // Post 7 — Garota Exemplar (3 curtidas)
  {u:'Diego Castro',    pid:7}, {u:'Thiago Gomes',   pid:7}, {u:'Marcos Ribeiro', pid:7},
  // Post 8 — Poder do Hábito (5 curtidas)
  {u:'Eduardo Pereira', pid:8}, {u:'Amanda Nunes',   pid:8}, {u:'Sandra Carvalho',pid:8},
  {u:'Thiago Gomes',    pid:8}, {u:'Roberto Vieira', pid:8},
  // Post 9 — Sapiens (4 curtidas)
  {u:'Eduardo Pereira', pid:9}, {u:'Roberto Vieira', pid:9}, {u:'Amanda Nunes',   pid:9},
  {u:'Felipe Souza',    pid:9},
  // Post 10 — Crime e Castigo (4 curtidas)
  {u:'João Oliveira',   pid:10},{u:'Maria Santos',   pid:10},{u:'Fernanda Costa', pid:10},
  {u:'Rafael Mendes',   pid:10},
  // Post 11 — O Alquimista (4 curtidas)
  {u:'Patricia Silva',  pid:11},{u:'Vanessa Lima',   pid:11},{u:'Maria Santos',   pid:11},
  {u:'Lucia Rodrigues', pid:11},
  // Post 12 — American Gods (4 curtidas)
  {u:'Ana Lima',        pid:12},{u:'Carlos Ferreira',pid:12},{u:'Juliana Barbosa',pid:12},
  {u:'Leonardo Dias',   pid:12},
  // Post 13 — Hábitos Atômicos (4 curtidas)
  {u:'Eduardo Pereira', pid:13},{u:'Patricia Silva', pid:13},{u:'Sandra Carvalho',pid:13},
  {u:'Thiago Gomes',    pid:13},
  // Post 14 — Assassinato no Expresso (3 curtidas)
  {u:'Bruno Alves',     pid:14},{u:'Thiago Gomes',   pid:14},{u:'Marcos Ribeiro', pid:14},
  // Post 15 — Cem Anos de Solidão (3 curtidas)
  {u:'Maria Santos',    pid:15},{u:'Fernanda Costa', pid:15},{u:'Vanessa Lima',   pid:15},
  // Post 16 — O Nome do Vento recom (5 curtidas)
  {u:'Carlos Ferreira', pid:16},{u:'Rafael Mendes',  pid:16},{u:'Juliana Barbosa',pid:16},
  {u:'Leonardo Dias',   pid:16},{u:'Ana Lima',        pid:16},
  // Post 17 — Vidas Secas recom (4 curtidas)
  {u:'Fernanda Costa',  pid:17},{u:'Patricia Silva', pid:17},{u:'Sandra Carvalho',pid:17},
  {u:'Lucia Rodrigues', pid:17},
  // Post 18 — Fundação recom (4 curtidas)
  {u:'João Oliveira',   pid:18},{u:'Felipe Souza',   pid:18},{u:'Leonardo Dias',  pid:18},
  {u:'Marcos Ribeiro',  pid:18},
  // Post 19 — Os Homens recom (2 curtidas)
  {u:'Diego Castro',    pid:19},{u:'Thiago Gomes',   pid:19},
  // Post 20 — Orgulho recom (5 curtidas)
  {u:'Maria Santos',    pid:20},{u:'Patricia Silva', pid:20},{u:'Juliana Barbosa',pid:20},
  {u:'Lucia Rodrigues', pid:20},{u:'Vanessa Lima',   pid:20},
  // Post 21 — Sutil Arte recom (3 curtidas)
  {u:'Amanda Nunes',    pid:21},{u:'Eduardo Pereira',pid:21},{u:'Sandra Carvalho',pid:21},
  // Post 22 — O Hobbit recom (4 curtidas)
  {u:'Ana Lima',        pid:22},{u:'Carlos Ferreira',pid:22},{u:'Juliana Barbosa',pid:22},
  {u:'Leonardo Dias',   pid:22},
  // Post 23 — Eu Sou Malala recom (3 curtidas)
  {u:'Roberto Vieira',  pid:23},{u:'Amanda Nunes',   pid:23},{u:'Camila Martins', pid:23},
  // Post 24 — It vs Iluminado discussão (3 curtidas)
  {u:'Bruno Alves',     pid:24},{u:'Thiago Gomes',   pid:24},{u:'Marcos Ribeiro', pid:24},
  // Post 25 — 1984 vs Admirável (4 curtidas)
  {u:'Eduardo Pereira', pid:25},{u:'Felipe Souza',   pid:25},{u:'Carlos Ferreira',pid:25},
  {u:'Marcos Ribeiro',  pid:25},
  // Post 26 — Capitu traiu? (6 curtidas)
  {u:'Maria Santos',    pid:26},{u:'Patricia Silva', pid:26},{u:'Sandra Carvalho',pid:26},
  {u:'Lucia Rodrigues', pid:26},{u:'Vanessa Lima',   pid:26},{u:'Camila Martins', pid:26},
  // Post 27 — Drácula ou Frankenstein (2 curtidas)
  {u:'Bruno Alves',     pid:27},{u:'Diego Castro',   pid:27},
  // Post 28 — Harry Potter inverno (3 curtidas)
  {u:'Ana Lima',        pid:28},{u:'Carlos Ferreira',pid:28},{u:'Rafael Mendes',  pid:28},
  // Post 29 — Homo Deus discussão (3 curtidas)
  {u:'Eduardo Pereira', pid:29},{u:'Roberto Vieira', pid:29},{u:'João Oliveira',  pid:29},
  // Post 30 — Grande Sertão (2 curtidas)
  {u:'Maria Santos',    pid:30},{u:'Fernanda Costa', pid:30},
  // Post 31 — Fundação série (3 curtidas)
  {u:'João Oliveira',   pid:31},{u:'Eduardo Pereira',pid:31},{u:'Carlos Ferreira',pid:31},
  // Post 32 — Mistborn sequências (3 curtidas)
  {u:'Ana Lima',        pid:32},{u:'Juliana Barbosa',pid:32},{u:'Leonardo Dias',  pid:32}
] AS rel
MATCH (u:Usuario {nome: rel.u}), (p:Post {id: rel.pid})
CREATE (u)-[:CURTIU {dataCurtida: datetime('2024-03-15T10:00:00Z')}]->(p);

// =====================================================================
// 18. COMENTOU (Usuario → Post)
// =====================================================================
UNWIND [
  {u:'Carlos Ferreira', pid: 1, texto:'Li na infância e ainda amo! Cada releitura revela detalhes novos.',          dt:'2024-01-09T14:00:00Z'},
  {u:'Juliana Barbosa', pid: 1, texto:'Sim! A saga toda é incrível. O sétimo livro me fez chorar.',                 dt:'2024-01-09T16:30:00Z'},
  {u:'João Oliveira',   pid: 4, texto:'Deveria ser leitura obrigatória nas escolas. Extremamente atual.',           dt:'2024-01-16T11:00:00Z'},
  {u:'Fernanda Costa',  pid: 3, texto:'Capitu foi ou não foi? rsrs — Machado nos deixou nessa dúvida de propósito.', dt:'2024-01-13T09:15:00Z'},
  {u:'Maria Santos',    pid:26, texto:'Nunca vou me decidir sobre Capitu. Machado foi um gênio perturbador!',        dt:'2024-03-20T10:00:00Z'},
  {u:'Patricia Silva',  pid:26, texto:'Capitu definitivamente traiu. A narrativa não deixa dúvida para quem lê com atenção.', dt:'2024-03-20T11:30:00Z'},
  {u:'Ana Lima',        pid:16, texto:'Patrick Rothfuss precisa lançar o terceiro livro logo! Estou ansiosa demais.', dt:'2024-02-19T15:00:00Z'},
  {u:'Eduardo Pereira', pid:18, texto:'Asimov construiu algo eterno. A série completa da Fundação é uma jornada épica.', dt:'2024-02-23T09:30:00Z'},
  {u:'Bruno Alves',     pid:24, texto:'It para mim, sem dúvida. A história de amizade e memória é única.',           dt:'2024-03-16T14:00:00Z'},
  {u:'Felipe Souza',    pid:25, texto:'São complementares! Um pune a ação, o outro a acomodação. Genial os dois.',  dt:'2024-03-18T10:45:00Z'},
  {u:'Camila Martins',  pid:20, texto:'Austen era brilhante para sua época. Elizabeth Bennet é a heroína perfeita.', dt:'2024-03-05T12:00:00Z'},
  {u:'Roberto Vieira',  pid:29, texto:'Harari levanta questões essenciais. A IA em 2024 já parece confirmar muita coisa.', dt:'2024-03-26T08:30:00Z'}
] AS rel
MATCH (u:Usuario {nome: rel.u}), (p:Post {id: rel.pid})
CREATE (u)-[:COMENTOU {texto: rel.texto, dataComentario: datetime(rel.dt)}]->(p);
