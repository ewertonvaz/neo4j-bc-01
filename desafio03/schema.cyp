// ======================================================================
// Desafio 03 — Rede Social de Apreciadores de Livros
// SCHEMA: Constraints e Índices
// ======================================================================
// Execute este arquivo UMA VEZ antes de carregar os dados.
// cypher-shell -u neo4j -p secret2026 -f desafio03/schema.cyp
// ======================================================================

// ── CONSTRAINTS (garantem unicidade de IDs) ────────────────────────────
CREATE CONSTRAINT usuario_id_unico    IF NOT EXISTS FOR (u:Usuario)    REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT livro_id_unico      IF NOT EXISTS FOR (l:Livro)      REQUIRE l.id IS UNIQUE;
CREATE CONSTRAINT autor_id_unico      IF NOT EXISTS FOR (a:Autor)      REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT genero_id_unico     IF NOT EXISTS FOR (g:Genero)     REQUIRE g.id IS UNIQUE;
CREATE CONSTRAINT post_id_unico       IF NOT EXISTS FOR (p:Post)       REQUIRE p.id IS UNIQUE;
CREATE CONSTRAINT comunidade_id_unico IF NOT EXISTS FOR (c:Comunidade) REQUIRE c.id IS UNIQUE;

// ── ÍNDICES (aceleram buscas por propriedade) ──────────────────────────
CREATE INDEX usuario_nome    IF NOT EXISTS FOR (u:Usuario)    ON (u.nome);
CREATE INDEX usuario_cidade  IF NOT EXISTS FOR (u:Usuario)    ON (u.cidade);
CREATE INDEX livro_titulo    IF NOT EXISTS FOR (l:Livro)      ON (l.titulo);
CREATE INDEX livro_ano       IF NOT EXISTS FOR (l:Livro)      ON (l.anoPublicacao);
CREATE INDEX autor_nome      IF NOT EXISTS FOR (a:Autor)      ON (a.nome);
CREATE INDEX genero_nome     IF NOT EXISTS FOR (g:Genero)     ON (g.nome);
CREATE INDEX post_data       IF NOT EXISTS FOR (p:Post)       ON (p.dataPublicacao);
CREATE INDEX post_tipo       IF NOT EXISTS FOR (p:Post)       ON (p.tipo);
CREATE INDEX comunidade_nome IF NOT EXISTS FOR (c:Comunidade) ON (c.nome);

// ── MODELO CONCEITUAL ──────────────────────────────────────────────────
//
//  Nós:
//    (:Usuario)    — perfil do leitor
//    (:Livro)      — obra literária
//    (:Autor)      — escritor do livro
//    (:Genero)     — categoria literária
//    (:Post)       — publicação (resenha, recomendação ou discussão)
//    (:Comunidade) — grupo de leitores por interesse
//
//  Relacionamentos:
//    (Usuario)-[:SEGUE          {dataInicio}]          ->(Usuario)
//    (Usuario)-[:JA_LEU         {dataLeitura}]         ->(Livro)
//    (Usuario)-[:LENDO          {dataInicio}]          ->(Livro)
//    (Usuario)-[:QUER_LER       {dataAdicao}]          ->(Livro)
//    (Usuario)-[:AVALIOU        {nota, dataAvaliacao}] ->(Livro)
//    (Usuario)-[:PUBLICOU]                             ->(Post)
//    (Usuario)-[:CURTIU         {dataCurtida}]         ->(Post)
//    (Usuario)-[:COMENTOU       {texto, dataComentario}]->(Post)
//    (Usuario)-[:INTERESSA_SE]                         ->(Genero)
//    (Usuario)-[:MEMBRO_DE      {dataEntrada}]         ->(Comunidade)
//    (Post)   -[:SOBRE]                                ->(Livro)
//    (Autor)  -[:ESCREVEU]                             ->(Livro)
//    (Livro)  -[:PERTENCE_AO]                          ->(Genero)
