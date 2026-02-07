// Código Cypher para representar um grafo de música no Neo4j
// Desafio 02 - Usuários, Músicas, Artistas e Gêneros com Interações

// Limpeza inicial do banco de dados
MATCH (n)
DETACH DELETE n;

// ======================================================================
// CRIAÇÃO DOS NÓS (ENTIDADES)
// ======================================================================

// Criando Gêneros Musicais
CREATE (rock:Genero { id: 1, nome: "Rock", descricao: "Gênero musical caracterizado por guitarra elétrica" })
CREATE (pop:Genero { id: 2, nome: "Pop", descricao: "Música popular contemporânea" })
CREATE (jazz:Genero { id: 3, nome: "Jazz", descricao: "Gênero musical com improvisação e harmonia complexa" })
CREATE (eletronica:Genero { id: 4, nome: "Eletrônica", descricao: "Música produzida principalmente com instrumentos eletrônicos" })
CREATE (reggae:Genero { id: 5, nome: "Reggae", descricao: "Gênero musical originário da Jamaica" });

// Criando Artistas
CREATE (beatles:Artista { id: 1, nome: "The Beatles", paisOrigem: "Reino Unido", dataFormacao: date("1960-01-01") })
CREATE (michael:Artista { id: 2, nome: "Michael Jackson", paisOrigem: "Estados Unidos", dataFormacao: date("1964-01-01") })
CREATE (miles:Artista { id: 3, nome: "Miles Davis", paisOrigem: "Estados Unidos", dataFormacao: date("1945-01-01") })
CREATE (daft:Artista { id: 4, nome: "Daft Punk", paisOrigem: "França", dataFormacao: date("1993-01-01") })
CREATE (marley:Artista { id: 5, nome: "Bob Marley", paisOrigem: "Jamaica", dataFormacao: date("1963-01-01") });

// Criando Músicas
CREATE (yesterday:Musica { id: 1, titulo: "Yesterday", duracao: 125, anoLancamento: 1965 })
CREATE (hey:Musica { id: 2, titulo: "Hey Jude", duracao: 431, anoLancamento: 1968 })
CREATE (billie:Musica { id: 3, titulo: "Billie Jean", duracao: 294, anoLancamento: 1983 })
CREATE (thriller:Musica { id: 4, titulo: "Thriller", duracao: 358, anoLancamento: 1982 })
CREATE (kind:Musica { id: 5, titulo: "Kind of Blue", duracao: 585, anoLancamento: 1959 })
CREATE (one:Musica { id: 6, titulo: "One More Time", duracao: 320, anoLancamento: 2000 })
CREATE (harder:Musica { id: 7, titulo: "Harder Better Faster Stronger", duracao: 225, anoLancamento: 2001 })
CREATE (no:Musica { id: 8, titulo: "No Woman No Cry", duracao: 429, anoLancamento: 1974 })
CREATE (three:Musica { id: 9, titulo: "Three Little Birds", duracao: 180, anoLancamento: 1977 });

// Criando Usuários
CREATE (ana:Usuario { id: 1, nome: "Ana Silva", email: "ana.silva@email.com", dataCriacao: datetime("2023-01-15T10:30:00Z") })
CREATE (carlos:Usuario { id: 2, nome: "Carlos Santos", email: "carlos.santos@email.com", dataCriacao: datetime("2023-02-20T14:45:00Z") })
CREATE (maria:Usuario { id: 3, nome: "Maria Oliveira", email: "maria.oliveira@email.com", dataCriacao: datetime("2023-03-10T09:15:00Z") })
CREATE (joao:Usuario { id: 4, nome: "João Costa", email: "joao.costa@email.com", dataCriacao: datetime("2023-04-05T16:20:00Z") })
CREATE (lucia:Usuario { id: 5, nome: "Lúcia Ferreira", email: "lucia.ferreira@email.com", dataCriacao: datetime("2023-05-12T11:00:00Z") });

// ======================================================================
// CRIAÇÃO DOS RELACIONAMENTOS (ARESTAS)
// ======================================================================

// Relacionamentos entre Artistas e Músicas (CANTA)
MATCH (beatles:Artista { nome: "The Beatles" }), (yesterday:Musica {titulo: "Yesterday"})
CREATE (beatles)-[:CANTA]->(yesterday);

MATCH (beatles:Artista { nome: "The Beatles" }), (hey:Musica {titulo: "Hey Jude"})
CREATE (beatles)-[:CANTA]->(hey);

MATCH (michael:Artista { nome: "Michael Jackson" }), (billie:Musica {titulo: "Billie Jean"})
CREATE (michael)-[:CANTA]->(billie);

MATCH (michael:Artista { nome: "Michael Jackson" }), (thriller:Musica {titulo: "Thriller"})
CREATE (michael)-[:CANTA]->(thriller);

MATCH (miles:Artista { nome: "Miles Davis" }), (kind:Musica {titulo: "Kind of Blue"})
CREATE (miles)-[:CANTA]->(kind);

MATCH (daft:Artista { nome: "Daft Punk" }), (one:Musica {titulo: "One More Time"})
CREATE (daft)-[:CANTA]->(one);

MATCH (daft:Artista { nome: "Daft Punk" }), (harder:Musica {titulo: "Harder Better Faster Stronger"})
CREATE (daft)-[:CANTA]->(harder);

MATCH (marley:Artista { nome: "Bob Marley" }), (no:Musica {titulo: "No Woman No Cry"})
CREATE (marley)-[:CANTA]->(no);

MATCH (marley:Artista { nome: "Bob Marley" }), (three:Musica {titulo: "Three Little Birds"})
CREATE (marley)-[:CANTA]->(three);

// Relacionamentos entre Músicas e Gêneros (PERTENCE_AO)
MATCH (yesterday:Musica { titulo: "Yesterday" }), (rock:Genero {nome: "Rock"})
CREATE (yesterday)-[:PERTENCE_AO]->(rock);

MATCH (hey:Musica { titulo: "Hey Jude" }), (rock:Genero {nome: "Rock"})
CREATE (hey)-[:PERTENCE_AO]->(rock);

MATCH (billie:Musica { titulo: "Billie Jean" }), (pop:Genero {nome: "Pop"})
CREATE (billie)-[:PERTENCE_AO]->(pop);

MATCH (thriller:Musica { titulo: "Thriller" }), (pop:Genero {nome: "Pop"})
CREATE (thriller)-[:PERTENCE_AO]->(pop);

MATCH (kind:Musica { titulo: "Kind of Blue" }), (jazz:Genero {nome: "Jazz"})
CREATE (kind)-[:PERTENCE_AO]->(jazz);

MATCH (one:Musica { titulo: "One More Time" }), (eletronica:Genero {nome: "Eletrônica"})
CREATE (one)-[:PERTENCE_AO]->(eletronica);

MATCH (harder:Musica { titulo: "Harder Better Faster Stronger" }), (eletronica:Genero {nome: "Eletrônica"})
CREATE (harder)-[:PERTENCE_AO]->(eletronica);

MATCH (no:Musica { titulo: "No Woman No Cry" }), (reggae:Genero {nome: "Reggae"})
CREATE (no)-[:PERTENCE_AO]->(reggae);

MATCH (three:Musica { titulo: "Three Little Birds" }), (reggae:Genero {nome: "Reggae"})
CREATE (three)-[:PERTENCE_AO]->(reggae);

// Relacionamentos entre Artistas e Gêneros (PRODUZ_GENERO)
MATCH (beatles:Artista { nome: "The Beatles" }), (rock:Genero {nome: "Rock"})
CREATE (beatles)-[:PRODUZ_GENERO]->(rock);

MATCH (michael:Artista { nome: "Michael Jackson" }), (pop:Genero {nome: "Pop"})
CREATE (michael)-[:PRODUZ_GENERO]->(pop);

MATCH (miles:Artista { nome: "Miles Davis" }), (jazz:Genero {nome: "Jazz"})
CREATE (miles)-[:PRODUZ_GENERO]->(jazz);

MATCH (daft:Artista { nome: "Daft Punk" }), (eletronica:Genero {nome: "Eletrônica"})
CREATE (daft)-[:PRODUZ_GENERO]->(eletronica);

MATCH (marley:Artista { nome: "Bob Marley" }), (reggae:Genero {nome: "Reggae"})
CREATE (marley)-[:PRODUZ_GENERO]->(reggae);

// ======================================================================
// RELACIONAMENTOS DE INTERAÇÃO DOS USUÁRIOS
// ======================================================================

// Ana Silva - Interações
// Ana escuta várias músicas
MATCH (ana:Usuario { nome: "Ana Silva" }), (yesterday:Musica {titulo: "Yesterday"})
CREATE (ana)-[:ESCUTA { dataEscuta: datetime("2024-01-15T14:30:00Z"), duracaoEscuta: 125 }]->(yesterday);

MATCH (ana:Usuario { nome: "Ana Silva" }), (billie:Musica {titulo: "Billie Jean"})
CREATE (ana)-[:ESCUTA { dataEscuta: datetime("2024-01-16T09:45:00Z"), duracaoEscuta: 280 }]->(billie);

MATCH (ana:Usuario { nome: "Ana Silva" }), (one:Musica {titulo: "One More Time"})
CREATE (ana)-[:ESCUTA { dataEscuta: datetime("2024-01-17T20:15:00Z"), duracaoEscuta: 320 }]->(one);

// Ana curte algumas músicas
MATCH (ana:Usuario { nome: "Ana Silva" }), (yesterday:Musica {titulo: "Yesterday"})
CREATE (ana)-[:CURTE { dataCurtida: datetime("2024-01-15T14:32:00Z") }]->(yesterday);

MATCH (ana:Usuario { nome: "Ana Silva" }), (one:Musica {titulo: "One More Time"})
CREATE (ana)-[:CURTE { dataCurtida: datetime("2024-01-17T20:18:00Z") }]->(one);

// Ana segue artistas
MATCH (ana:Usuario { nome: "Ana Silva" }), (beatles:Artista {nome: "The Beatles"})
CREATE (ana)-[:SEGUE { dataInicio: datetime("2024-01-15T15:00:00Z") }]->(beatles);

MATCH (ana:Usuario { nome: "Ana Silva" }), (daft:Artista {nome: "Daft Punk"})
CREATE (ana)-[:SEGUE { dataInicio: datetime("2024-01-17T20:30:00Z") }]->(daft);

// Carlos Santos - Interações
// Carlos escuta músicas
MATCH (carlos:Usuario { nome: "Carlos Santos" }), (billie:Musica {titulo: "Billie Jean"})
CREATE (carlos)-[:ESCUTA { dataEscuta: datetime("2024-02-01T11:20:00Z"), duracaoEscuta: 294 }]->(billie);

MATCH (carlos:Usuario { nome: "Carlos Santos" }), (thriller:Musica {titulo: "Thriller"})
CREATE (carlos)-[:ESCUTA { dataEscuta: datetime("2024-02-01T11:25:00Z"), duracaoEscuta: 358 }]->(thriller);

MATCH (carlos:Usuario { nome: "Carlos Santos" }), (no:Musica {titulo: "No Woman No Cry"})
CREATE (carlos)-[:ESCUTA { dataEscuta: datetime("2024-02-02T16:30:00Z"), duracaoEscuta: 429 }]->(no);

// Carlos curte músicas
MATCH (carlos:Usuario { nome: "Carlos Santos" }), (thriller:Musica {titulo: "Thriller"})
CREATE (carlos)-[:CURTE { dataCurtida: datetime("2024-02-01T11:30:00Z") }]->(thriller);

MATCH (carlos:Usuario { nome: "Carlos Santos" }), (no:Musica {titulo: "No Woman No Cry"})
CREATE (carlos)-[:CURTE { dataCurtida: datetime("2024-02-02T16:35:00Z") }]->(no);

// Carlos segue artistas
MATCH (carlos:Usuario { nome: "Carlos Santos" }), (michael:Artista {nome: "Michael Jackson"})
CREATE (carlos)-[:SEGUE { dataInicio: datetime("2024-02-01T12:00:00Z") }]->(michael);

MATCH (carlos:Usuario { nome: "Carlos Santos" }), (marley:Artista {nome: "Bob Marley"})
CREATE (carlos)-[:SEGUE { dataInicio: datetime("2024-02-02T17:00:00Z") }]->(marley);

// Maria Oliveira - Interações
// Maria escuta músicas
MATCH (maria:Usuario { nome: "Maria Oliveira" }), (kind:Musica {titulo: "Kind of Blue"})
CREATE (maria)-[:ESCUTA { dataEscuta: datetime("2024-03-05T19:45:00Z"), duracaoEscuta: 585 }]->(kind);

MATCH (maria:Usuario { nome: "Maria Oliveira" }), (hey:Musica {titulo: "Hey Jude"})
CREATE (maria)-[:ESCUTA { dataEscuta: datetime("2024-03-06T10:30:00Z"), duracaoEscuta: 431 }]->(hey);

MATCH (maria:Usuario { nome: "Maria Oliveira" }), (harder:Musica {titulo: "Harder Better Faster Stronger"})
CREATE (maria)-[:ESCUTA { dataEscuta: datetime("2024-03-07T14:20:00Z"), duracaoEscuta: 225 }]->(harder);

// Maria curte músicas
MATCH (maria:Usuario { nome: "Maria Oliveira" }), (kind:Musica {titulo: "Kind of Blue"})
CREATE (maria)-[:CURTE { dataCurtida: datetime("2024-03-05T20:00:00Z") }]->(kind);

MATCH (maria:Usuario { nome: "Maria Oliveira" }), (hey:Musica {titulo: "Hey Jude"})
CREATE (maria)-[:CURTE { dataCurtida: datetime("2024-03-06T10:35:00Z") }]->(hey);

// Maria segue artistas
MATCH (maria:Usuario { nome: "Maria Oliveira" }), (miles:Artista {nome: "Miles Davis"})
CREATE (maria)-[:SEGUE { dataInicio: datetime("2024-03-05T20:15:00Z") }]->(miles);

MATCH (maria:Usuario { nome: "Maria Oliveira" }), (beatles:Artista {nome: "The Beatles"})
CREATE (maria)-[:SEGUE { dataInicio: datetime("2024-03-06T11:00:00Z") }]->(beatles);

// João Costa - Interações
// João escuta músicas
MATCH (joao:Usuario { nome: "João Costa" }), (three:Musica {titulo: "Three Little Birds"})
CREATE (joao)-[:ESCUTA { dataEscuta: datetime("2024-04-10T08:15:00Z"), duracaoEscuta: 180 }]->(three);

MATCH (joao:Usuario { nome: "João Costa" }), (one:Musica {titulo: "One More Time"})
CREATE (joao)-[:ESCUTA { dataEscuta: datetime("2024-04-10T18:45:00Z"), duracaoEscuta: 320 }]->(one);

MATCH (joao:Usuario { nome: "João Costa" }), (billie:Musica {titulo: "Billie Jean"})
CREATE (joao)-[:ESCUTA { dataEscuta: datetime("2024-04-11T12:30:00Z"), duracaoEscuta: 180 }]->(billie);

// João curte músicas
MATCH (joao:Usuario { nome: "João Costa" }), (three:Musica {titulo: "Three Little Birds"})
CREATE (joao)-[:CURTE { dataCurtida: datetime("2024-04-10T08:18:00Z") }]->(three);

// João segue artistas
MATCH (joao:Usuario { nome: "João Costa" }), (marley:Artista {nome: "Bob Marley"})
CREATE (joao)-[:SEGUE { dataInicio: datetime("2024-04-10T08:30:00Z") }]->(marley);

MATCH (joao:Usuario { nome: "João Costa" }), (daft:Artista {nome: "Daft Punk"})
CREATE (joao)-[:SEGUE { dataInicio: datetime("2024-04-10T19:00:00Z") }]->(daft);

// Lúcia Ferreira - Interações
// Lúcia escuta músicas de todos os gêneros
MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (yesterday:Musica {titulo: "Yesterday"})
CREATE (lucia)-[:ESCUTA { dataEscuta: datetime("2024-05-15T13:00:00Z"), duracaoEscuta: 125 }]->(yesterday);

MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (thriller:Musica {titulo: "Thriller"})
CREATE (lucia)-[:ESCUTA { dataEscuta: datetime("2024-05-15T13:05:00Z"), duracaoEscuta: 358 }]->(thriller);

MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (kind:Musica {titulo: "Kind of Blue"})
CREATE (lucia)-[:ESCUTA { dataEscuta: datetime("2024-05-15T13:15:00Z"), duracaoEscuta: 200 }]->(kind);

MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (harder:Musica {titulo: "Harder Better Faster Stronger"})
CREATE (lucia)-[:ESCUTA { dataEscuta: datetime("2024-05-15T13:30:00Z"), duracaoEscuta: 225 }]->(harder);

MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (no:Musica {titulo: "No Woman No Cry"})
CREATE (lucia)-[:ESCUTA { dataEscuta: datetime("2024-05-15T13:45:00Z"), duracaoEscuta: 380 }]->(no);

// Lúcia curte várias músicas
MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (thriller:Musica {titulo: "Thriller"})
CREATE (lucia)-[:CURTE { dataCurtida: datetime("2024-05-15T13:10:00Z") }]->(thriller);

MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (harder:Musica {titulo: "Harder Better Faster Stronger"})
CREATE (lucia)-[:CURTE { dataCurtida: datetime("2024-05-15T13:35:00Z") }]->(harder);

MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (no:Musica {titulo: "No Woman No Cry"})
CREATE (lucia)-[:CURTE { dataCurtida: datetime("2024-05-15T13:50:00Z") }]->(no);

// Lúcia segue vários artistas
MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (michael:Artista {nome: "Michael Jackson"})
CREATE (lucia)-[:SEGUE { dataInicio: datetime("2024-05-15T14:00:00Z") }]->(michael);

MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (daft:Artista {nome: "Daft Punk"})
CREATE (lucia)-[:SEGUE { dataInicio: datetime("2024-05-15T14:05:00Z") }]->(daft);

MATCH (lucia:Usuario { nome: "Lúcia Ferreira" }), (marley:Artista {nome: "Bob Marley"})
CREATE (lucia)-[:SEGUE { dataInicio: datetime("2024-05-15T14:10:00Z") }]->(marley);
