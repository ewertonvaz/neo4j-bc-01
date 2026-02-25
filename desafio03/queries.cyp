// ======================================================================
// Desafio 03 — Rede Social de Apreciadores de Livros
// CONSULTAS ANALÍTICAS (15 perguntas de negócio)
// ======================================================================
// cypher-shell -u neo4j -p secret2026 -f desafio03/queries.cyp
// ======================================================================

// ── 1. LEITORES MAIS INFLUENTES ────────────────────────────────────────
// Pergunta: Qual é o ranking de influência dos usuários da plataforma?
MATCH (u:Usuario)<-[:SEGUE]-(s:Usuario)
RETURN u.nome          AS leitor,
       u.cidade        AS cidade,
       count(s)        AS totalSeguidores
ORDER BY totalSeguidores DESC
LIMIT 10;

// ── 2. LIVROS MAIS LIDOS NA PLATAFORMA ────────────────────────────────
// Pergunta: Quais são os títulos mais consumidos pelos leitores?
MATCH (u:Usuario)-[:JA_LEU]->(l:Livro)<-[:ESCREVEU]-(a:Autor)
RETURN l.titulo        AS livro,
       a.nome          AS autor,
       l.anoPublicacao AS ano,
       count(u)        AS totalLeitores
ORDER BY totalLeitores DESC
LIMIT 15;

// ── 3. POST MAIS CURTIDO NO MÊS ───────────────────────────────────────
// Pergunta: Qual foi o post com maior engajamento em janeiro de 2024?
MATCH (u:Usuario)-[:CURTIU]->(p:Post)
WHERE p.dataPublicacao >= date('2024-01-01')
  AND p.dataPublicacao <  date('2024-02-01')
WITH p, count(u) AS curtidas
ORDER BY curtidas DESC
LIMIT 5
MATCH (autor:Usuario)-[:PUBLICOU]->(p)-[:SOBRE]->(l:Livro)
RETURN p.tipo                   AS tipo,
       left(p.conteudo, 100)    AS preview,
       autor.nome               AS publicadoPor,
       l.titulo                 AS sobreLivro,
       p.dataPublicacao         AS data,
       curtidas;

// ── 4. RECOMENDAÇÃO DE LIVROS — FILTRAGEM COLABORATIVA ────────────────
// Pergunta: Que livros devo ler baseado no gosto de leitores similares?
MATCH (eu:Usuario {nome: 'Ana Lima'})-[:INTERESSA_SE]->(g:Genero)
        <-[:INTERESSA_SE]-(similar:Usuario)
WHERE eu <> similar
MATCH (similar)-[:JA_LEU]->(l:Livro)-[:PERTENCE_AO]->(g)
WHERE NOT (eu)-[:JA_LEU]->(l)
  AND NOT (eu)-[:LENDO]->(l)
  AND NOT (eu)-[:QUER_LER]->(l)
RETURN l.titulo                        AS livroRecomendado,
       collect(DISTINCT similar.nome)  AS recomendadoPor,
       count(DISTINCT similar)         AS forcaRecomendacao
ORDER BY forcaRecomendacao DESC
LIMIT 10;

// ── 5. SUGESTÃO DE USUÁRIOS PARA SEGUIR ───────────────────────────────
// Pergunta: Quem eu deveria seguir com base nos meus contatos?
MATCH (eu:Usuario {nome: 'Ana Lima'})-[:SEGUE]->(seguido:Usuario)
        -[:SEGUE]->(sugestao:Usuario)
WHERE eu <> sugestao
  AND NOT (eu)-[:SEGUE]->(sugestao)
RETURN sugestao.nome                       AS usuarioSugerido,
       sugestao.cidade                     AS cidade,
       collect(DISTINCT seguido.nome)      AS conexoesEmComum,
       count(DISTINCT seguido)             AS qtdConexoesComum
ORDER BY qtdConexoesComum DESC
LIMIT 5;

// ── 6. MENOR DISTÂNCIA ENTRE DOIS USUÁRIOS ────────────────────────────
// Pergunta: Qual o caminho mais curto entre Ana Lima e Roberto Vieira?
MATCH (a:Usuario {nome: 'Ana Lima'}),
      (b:Usuario {nome: 'Roberto Vieira'})
MATCH p = shortestPath((a)-[:SEGUE*]-(b))
RETURN [n IN nodes(p) | n.nome] AS caminho,
       length(p)                AS distancia;

// ── 7. LIVROS MELHOR AVALIADOS POR GÊNERO ────────────────────────────
// Pergunta: Quais são os livros preferidos dos leitores em cada gênero?
MATCH (u:Usuario)-[av:AVALIOU]->(l:Livro)-[:PERTENCE_AO]->(g:Genero)
WITH g.nome AS genero,
     l.titulo AS livro,
     round(avg(av.nota) * 10) / 10 AS notaMedia,
     count(av) AS totalAvaliacoes
WHERE totalAvaliacoes >= 2
RETURN genero, livro, notaMedia, totalAvaliacoes
ORDER BY genero ASC, notaMedia DESC;

// ── 8. AUTORES MAIS LIDOS NA PLATAFORMA ──────────────────────────────
// Pergunta: Quais autores têm maior audiência na plataforma?
MATCH (a:Autor)-[:ESCREVEU]->(l:Livro)<-[:JA_LEU]-(u:Usuario)
RETURN a.nome             AS autor,
       a.nacionalidade    AS pais,
       count(DISTINCT l)  AS titulos,
       count(u)           AS totalLeituras
ORDER BY totalLeituras DESC
LIMIT 10;

// ── 9. PERFIL COMPLETO DO LEITOR ──────────────────────────────────────
// Pergunta: Qual é o resumo de atividade de um usuário na plataforma?
MATCH (u:Usuario {nome: 'Ana Lima'})
OPTIONAL MATCH (u)-[:JA_LEU]->(lido:Livro)
OPTIONAL MATCH (u)-[:LENDO]->(lendo:Livro)
OPTIONAL MATCH (u)-[:QUER_LER]->(quer:Livro)
OPTIONAL MATCH (u)-[:INTERESSA_SE]->(g:Genero)
OPTIONAL MATCH (u)-[:MEMBRO_DE]->(c:Comunidade)
OPTIONAL MATCH (u)-[:PUBLICOU]->(p:Post)
OPTIONAL MATCH (seg:Usuario)-[:SEGUE]->(u)
OPTIONAL MATCH (u)-[:SEGUE]->(seg2:Usuario)
RETURN u.nome                          AS nome,
       u.cidade                        AS cidade,
       count(DISTINCT lido)            AS livrosLidos,
       collect(DISTINCT lendo.titulo)  AS lendoAgora,
       count(DISTINCT quer)            AS listaDeDesejo,
       collect(DISTINCT g.nome)        AS interesses,
       collect(DISTINCT c.nome)        AS comunidades,
       count(DISTINCT p)               AS totalPosts,
       count(DISTINCT seg)             AS seguidores,
       count(DISTINCT seg2)            AS seguindo;

// ── 10. PÚBLICO-ALVO POR GÊNERO ──────────────────────────────────────
// Pergunta: Quantos leitores interessados de cada gênero realmente leram?
MATCH (g:Genero)
OPTIONAL MATCH (u1:Usuario)-[:INTERESSA_SE]->(g)
OPTIONAL MATCH (u2:Usuario)-[:JA_LEU]->(:Livro)-[:PERTENCE_AO]->(g)
RETURN g.nome                                            AS genero,
       count(DISTINCT u1)                               AS interessados,
       count(DISTINCT u2)                               AS leitoresEfetivos,
       count(DISTINCT u1) - count(DISTINCT u2)          AS potencialNaoConvertido
ORDER BY leitoresEfetivos DESC;

// ── 11. COMUNIDADES MAIS ATIVAS ───────────────────────────────────────
// Pergunta: Quais grupos têm maior engajamento de leitores e posts?
MATCH (c:Comunidade)<-[:MEMBRO_DE]-(u:Usuario)
OPTIONAL MATCH (u)-[:PUBLICOU]->(p:Post)
OPTIONAL MATCH (:Usuario)-[:CURTIU]->(p)
RETURN c.nome                AS comunidade,
       count(DISTINCT u)     AS membros,
       count(DISTINCT p)     AS postsGerados,
       count(*)              AS totalInteracoes
ORDER BY membros DESC, totalInteracoes DESC;

// ── 12. LEITORES COM GOSTOS SIMILARES ────────────────────────────────
// Pergunta: Quais usuários têm perfil de leitura mais parecido comigo?
MATCH (eu:Usuario {nome: 'Ana Lima'})-[:JA_LEU]->(l:Livro)<-[:JA_LEU]-(outro:Usuario)
WHERE eu <> outro
WITH outro, count(l) AS livrosEmComum
MATCH (eu)-[:INTERESSA_SE]->(g:Genero)<-[:INTERESSA_SE]-(outro)
RETURN outro.nome      AS leitor,
       outro.cidade    AS cidade,
       livrosEmComum,
       count(g)        AS generosEmComum
ORDER BY livrosEmComum DESC, generosEmComum DESC
LIMIT 8;

// ── 13. LIVROS EM ALTA (engajamento agregado) ─────────────────────────
// Pergunta: Quais livros têm o maior engajamento combinado na plataforma?
MATCH (l:Livro)
OPTIONAL MATCH (l)<-[:JA_LEU]-(u1:Usuario)
OPTIONAL MATCH (l)<-[:LENDO]-(u2:Usuario)
OPTIONAL MATCH (l)<-[:QUER_LER]-(u3:Usuario)
OPTIONAL MATCH (l)<-[:AVALIOU {nota: 5}]-(u4:Usuario)
RETURN l.titulo          AS livro,
       l.anoPublicacao   AS ano,
       count(DISTINCT u1) AS jaLeram,
       count(DISTINCT u2) AS lendoAgora,
       count(DISTINCT u3) AS querLer,
       count(DISTINCT u4) AS notaMaxima,
       count(DISTINCT u1) + count(DISTINCT u2) * 2 + count(DISTINCT u3) AS scoreEngajamento
ORDER BY scoreEngajamento DESC
LIMIT 15;

// ── 14. ALCANCE VIRAL DE UM LIVRO PELA REDE ──────────────────────────
// Pergunta: Quantas pessoas podem descobrir "Duna" via rede de seguidores?
MATCH (l:Livro {titulo: 'Duna'})
MATCH (leitor:Usuario)-[:JA_LEU]->(l)
MATCH (alcancado:Usuario)-[:SEGUE*1..2]->(leitor)
WHERE NOT (alcancado)-[:JA_LEU]->(l)
  AND NOT (alcancado)-[:LENDO]->(l)
RETURN l.titulo              AS livro,
       count(DISTINCT leitor)    AS leitoresDiretos,
       count(DISTINCT alcancado) AS alcancePotencial;

// ── 15. TOP POSTS POR ENGAJAMENTO (curtidas + comentários ponderados) ─
// Pergunta: Quais posts geraram mais debate e interação na plataforma?
MATCH (p:Post)
OPTIONAL MATCH (:Usuario)-[:CURTIU]->(p)
WITH p, count(*) AS curtidas
OPTIONAL MATCH (:Usuario)-[:COMENTOU]->(p)
WITH p, curtidas, count(*) AS comentarios
MATCH (autor:Usuario)-[:PUBLICOU]->(p)-[:SOBRE]->(l:Livro)
RETURN p.tipo                    AS tipo,
       left(p.conteudo, 90)      AS preview,
       autor.nome                AS autor,
       l.titulo                  AS livro,
       p.dataPublicacao          AS data,
       curtidas,
       comentarios,
       curtidas + comentarios * 2 AS scoreEngajamento
ORDER BY scoreEngajamento DESC
LIMIT 10;
