// ======================================================================
// CONSULTAS DE EXEMPLO PARA VALIDAR O GRAFO
// ======================================================================

// Comentários com consultas úteis para explorar o grafo criado:

// 1. Listar todas as músicas que um usuário escutou
MATCH (u:Usuario {nome: "Ana Silva"})-[e:ESCUTA]->(m:Musica)
RETURN u.nome, m.titulo, e.dataEscuta, e.duracaoEscuta;

// 2. Encontrar músicas mais curtidas
MATCH (u:Usuario)-[c:CURTE]->(m:Musica)
RETURN m.titulo, count(c) as totalCurtidas
ORDER BY totalCurtidas DESC;

// 3. Artistas mais seguidos
MATCH (u:Usuario)-[s:SEGUE]->(a:Artista)
RETURN a.nome, count(s) as totalSeguidores
ORDER BY totalSeguidores DESC;

// 4. Músicas de um gênero específico
MATCH (m:Musica)-[:PERTENCE_AO]->(g:Genero {nome: "Rock"})
RETURN m.titulo, m.anoLancamento;

// 5. Usuários que gostam do mesmo artista
MATCH (u1:Usuario)-[:SEGUE]->(a:Artista)<-[:SEGUE]-(u2:Usuario)
WHERE u1 <> u2
RETURN u1.nome, u2.nome, a.nome;

// 6. Tempo total de escuta por usuário
MATCH (u:Usuario)-[e:ESCUTA]->(m:Musica)
RETURN u.nome, sum(e.duracaoEscuta) as tempoTotalSegundos;

// 7. Recomendação: músicas curtidas por usuários que seguem os mesmos artistas
MATCH (u1:Usuario {nome: "Ana Silva"})-[:SEGUE]->(a:Artista)<-[:SEGUE]-(u2:Usuario)
MATCH (u2)-[:CURTE]->(m:Musica)
WHERE NOT EXISTS((u1)-[:CURTE]->(m))
RETURN DISTINCT m.titulo as musicaRecomendada;

// Fim do arquivo
