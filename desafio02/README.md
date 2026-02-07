# Desafio 02 - Grafo de Música no Neo4j

Este projeto implementa um sistema de recomendação musical através de um grafo no Neo4j, modelando as interações entre usuários, artistas, músicas e gêneros musicais.

## 🎵 Visão Geral

O sistema modela um ambiente musical onde usuários podem:

- Escutar músicas
- Curtir suas músicas favoritas
- Seguir artistas
- Receber recomendações baseadas em comportamentos similares

## 📁 Estrutura dos Arquivos

### 📄 `initial.cyp`

**Descrição**: Script principal em Cypher para criação e população do banco de dados Neo4j.

**Funcionalidades**:

- Limpa o banco de dados existente
- Cria nós para 4 tipos de entidades:
  - **Usuários** (5): Ana Silva, Carlos Santos, Maria Oliveira, João Costa, Lúcia Ferreira
  - **Artistas** (5): The Beatles, Michael Jackson, Miles Davis, Daft Punk, Bob Marley
  - **Músicas** (9): Yesterday, Hey Jude, Billie Jean, Thriller, etc.
  - **Gêneros** (5): Rock, Pop, Jazz, Eletrônica, Reggae

**Relacionamentos modelados**:

- `ESCUTA`: Usuário escuta música (com timestamp e duração)
- `CURTE`: Usuário curte música (com timestamp)
- `SEGUE`: Usuário segue artista (com data de início)
- `CANTA`: Artista canta música
- `PERTENCE_AO`: Música pertence a gênero
- `PRODUZ_GENERO`: Artista produz gênero

### 📄 `queries.cyp`

**Descrição**: Conjunto de consultas Cypher para análise e exploração do grafo.

**Consultas incluídas**:

1. **Histórico de escuta** - Músicas escutadas por usuário específico
2. **Ranking de popularidade** - Músicas mais curtidas
3. **Artistas populares** - Artistas mais seguidos
4. **Filtros por gênero** - Músicas de gêneros específicos
5. **Conexões sociais** - Usuários que gostam dos mesmos artistas
6. **Análise temporal** - Tempo total de escuta por usuário
7. **Sistema de recomendação** - Sugere músicas baseadas em usuários com gostos similares

**Destaque**: A consulta de recomendação identifica músicas curtidas por usuários que seguem os mesmos artistas, mas que o usuário alvo ainda não curtiu.

### 📄 `visualizar_grafo.py`

**Descrição**: Script Python para visualização gráfica da estrutura do grafo.

**Funcionalidades**:

- Cria representação visual usando NetworkX e Matplotlib
- Organiza nós por tipo em layout hierárquico:
  - **Usuários** (vermelho) → esquerda
  - **Artistas** (azul-turquesa) → centro-esquerda
  - **Músicas** (azul) → centro-direita
  - **Gêneros** (verde) → direita
- Gera arquivo PNG com visualização completa
- Inclui legenda e estatísticas do grafo
- Mostra amostra de relacionamentos principais

**Dependências**: `matplotlib`, `networkx`, `numpy`

## 🚀 Como Usar

### 1. Criação do Grafo

```bash
# Execute o script inicial no Neo4j Browser ou cypher-shell
cypher-shell -f initial.cyp
```

### 2. Executar Consultas

```bash
# Execute consultas específicas
cypher-shell -f queries.cyp
```

### 3. Gerar Visualização

```bash
# Instalar dependências
pip install matplotlib networkx numpy

# Executar script de visualização
python visualizar_grafo.py
```

## 📊 Estatísticas do Grafo

- **Nós totais**: 24
  - 5 Usuários
  - 5 Artistas
  - 9 Músicas
  - 5 Gêneros
- **Relacionamentos**: Múltiplos tipos modelando interações complexas
- **Casos de uso**: Análise de comportamento musical, sistema de recomendação

## 🎯 Casos de Uso

1. **Análise de Engagement**: Identificar músicas e artistas mais populares
2. **Recomendação Musical**: Sugerir conteúdo baseado em preferências similares
3. **Análise de Gêneros**: Compreender distribuição e preferências musicais
4. **Métricas de Usuário**: Tempo de escuta, padrões de consumo
5. **Descoberta Social**: Conexões entre usuários através de gostos musicais

## 🔧 Tecnologias Utilizadas

- **Neo4j**: Banco de dados de grafos
- **Cypher**: Linguagem de consulta para grafos
- **Python**: Visualização e análise
- **NetworkX**: Biblioteca para manipulação de grafos
- **Matplotlib**: Geração de gráficos e visualizações

## 🎯 Sistema de Recomendação

### Algoritmo de Similaridade por Filtragem Colaborativa

A consulta destacada no arquivo [queries.cyp](desafio02/queries.cyp#L35-L38) implementa um **algoritmo de similaridade baseado em filtragem colaborativa**, uma das técnicas mais eficazes em sistemas de recomendação:

```cypher
MATCH (u1:Usuario {nome: "Ana Silva"})-[:SEGUE]->(a:Artista)<-[:SEGUE]-(u2:Usuario)
MATCH (u2)-[:CURTE]->(m:Musica)
WHERE NOT EXISTS((u1)-[:CURTE]->(m))
RETURN DISTINCT m.titulo as musicaRecomendada;
```

### 🧠 Conceitos Fundamentais

**1. Filtragem Colaborativa**

- **Princípio**: "Usuários com gostos similares tendem a gostar de conteúdo similar"
- **Funcionamento**: Identifica usuários com comportamentos semelhantes e recomenda itens que esses usuários similares já avaliaram positivamente
- **Vantagem**: Não depende de análise de conteúdo, apenas de padrões de comportamento

**2. Similaridade por Conexões Sociais**

- **Estratégia**: Usuários que seguem os mesmos artistas provavelmente têm gostos musicais compatíveis
- **Implementação**: O algoritmo encontra usuários que compartilham artistas seguidos com o usuário alvo
- **Resultado**: Recomenda músicas curtidas por esses usuários similares

**3. Filtragem de Redundância**

- **Otimização**: `WHERE NOT EXISTS((u1)-[:CURTE]->(m))` garante que apenas músicas ainda não curtidas pelo usuário sejam recomendadas
- **Benefício**: Evita sugestões de conteúdo já conhecido/consumido

### 📈 Eficácia do Algoritmo

**Pontos Fortes**:

- ✅ **Personalização**: Recomendações específicas baseadas no perfil do usuário
- ✅ **Descoberta**: Exposição a novos conteúdos através de usuários similares
- ✅ **Simplicidade**: Implementação direta usando apenas relacionamentos do grafo
- ✅ **Escalabilidade**: Funciona bem com o crescimento da base de usuários

**Cenários de Uso**:

- Playlists personalizadas
- Descoberta de novos artistas
- Sugestões em tempo real
- Análise de tendências musicais

### 🔄 Extensões Possíveis

O algoritmo pode ser refinado com:

- **Pesos temporais**: Priorizar interações recentes
- **Múltiplos fatores**: Combinar seguir artistas + curtir gêneros
- **Scoring**: Classificar recomendações por força da similaridade
- **Diversidade**: Equilibrar recomendações entre diferentes gêneros
