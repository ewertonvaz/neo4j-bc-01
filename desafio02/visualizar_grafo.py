#!/usr/bin/env python3
"""
Script para visualizar a estrutura do grafo de música criado no Neo4j
Gera uma imagem PNG mostrando os nós e relacionamentos
"""

import matplotlib.pyplot as plt
import networkx as nx
from matplotlib.patches import FancyBboxPatch
import numpy as np

def criar_grafo_musica():
    """Cria um grafo NetworkX baseado na estrutura do arquivo Cypher"""
    G = nx.Graph()
    
    # Definir cores para cada tipo de nó
    cores_nos = {
        'Usuario': '#FF6B6B',      # Vermelho
        'Artista': '#4ECDC4',      # Azul-turquesa  
        'Musica': '#45B7D1',       # Azul
        'Genero': '#96CEB4'        # Verde
    }
    
    # Adicionar nós de usuários
    usuarios = [
        ("Ana Silva", "Usuario"),
        ("Carlos Santos", "Usuario"), 
        ("Maria Oliveira", "Usuario"),
        ("João Costa", "Usuario"),
        ("Lúcia Ferreira", "Usuario")
    ]
    
    # Adicionar nós de artistas
    artistas = [
        ("The Beatles", "Artista"),
        ("Michael Jackson", "Artista"),
        ("Miles Davis", "Artista"),
        ("Daft Punk", "Artista"),
        ("Bob Marley", "Artista")
    ]
    
    # Adicionar nós de músicas
    musicas = [
        ("Yesterday", "Musica"),
        ("Hey Jude", "Musica"),
        ("Billie Jean", "Musica"),
        ("Thriller", "Musica"),
        ("Kind of Blue", "Musica"),
        ("One More Time", "Musica"),
        ("Harder Better Faster Stronger", "Musica"),
        ("No Woman No Cry", "Musica"),
        ("Three Little Birds", "Musica")
    ]
    
    # Adicionar nós de gêneros
    generos = [
        ("Rock", "Genero"),
        ("Pop", "Genero"),
        ("Jazz", "Genero"),
        ("Eletrônica", "Genero"),
        ("Reggae", "Genero")
    ]
    
    # Adicionar todos os nós ao grafo
    todos_nos = usuarios + artistas + musicas + generos
    for nome, tipo in todos_nos:
        G.add_node(nome, tipo=tipo, cor=cores_nos[tipo])
    
    # Adicionar relacionamentos principais para visualização
    # Artistas -> Músicas
    relacionamentos_artista_musica = [
        ("The Beatles", "Yesterday"),
        ("The Beatles", "Hey Jude"),
        ("Michael Jackson", "Billie Jean"),
        ("Michael Jackson", "Thriller"),
        ("Miles Davis", "Kind of Blue"),
        ("Daft Punk", "One More Time"),
        ("Daft Punk", "Harder Better Faster Stronger"),
        ("Bob Marley", "No Woman No Cry"),
        ("Bob Marley", "Three Little Birds")
    ]
    
    # Músicas -> Gêneros
    relacionamentos_musica_genero = [
        ("Yesterday", "Rock"),
        ("Hey Jude", "Rock"),
        ("Billie Jean", "Pop"),
        ("Thriller", "Pop"),
        ("Kind of Blue", "Jazz"),
        ("One More Time", "Eletrônica"),
        ("Harder Better Faster Stronger", "Eletrônica"),
        ("No Woman No Cry", "Reggae"),
        ("Three Little Birds", "Reggae")
    ]
    
    # Algumas interações de usuários (sample)
    relacionamentos_usuario = [
        ("Ana Silva", "The Beatles"),
        ("Ana Silva", "Yesterday"),
        ("Ana Silva", "Daft Punk"),
        ("Carlos Santos", "Michael Jackson"),
        ("Carlos Santos", "Thriller"),
        ("Carlos Santos", "Bob Marley"),
        ("Maria Oliveira", "Miles Davis"),
        ("Maria Oliveira", "Kind of Blue"),
        ("João Costa", "Bob Marley"),
        ("João Costa", "Three Little Birds"),
        ("Lúcia Ferreira", "Michael Jackson"),
        ("Lúcia Ferreira", "Daft Punk")
    ]
    
    # Adicionar todas as arestas
    G.add_edges_from(relacionamentos_artista_musica)
    G.add_edges_from(relacionamentos_musica_genero)
    G.add_edges_from(relacionamentos_usuario)
    
    return G

def criar_layout_personalizado(G):
    """Cria um layout personalizado organizando os nós por tipo"""
    pos = {}
    
    # Separar nós por tipo
    usuarios = [n for n in G.nodes() if G.nodes[n]['tipo'] == 'Usuario']
    artistas = [n for n in G.nodes() if G.nodes[n]['tipo'] == 'Artista']
    musicas = [n for n in G.nodes() if G.nodes[n]['tipo'] == 'Musica']
    generos = [n for n in G.nodes() if G.nodes[n]['tipo'] == 'Genero']
    
    # Posicionar usuários na esquerda
    for i, usuario in enumerate(usuarios):
        pos[usuario] = (-3, i - len(usuarios)/2)
    
    # Posicionar artistas no centro-esquerda
    for i, artista in enumerate(artistas):
        pos[artista] = (-1, i - len(artistas)/2)
    
    # Posicionar músicas no centro-direita
    for i, musica in enumerate(musicas):
        pos[musica] = (1, i - len(musicas)/2)
    
    # Posicionar gêneros na direita
    for i, genero in enumerate(generos):
        pos[genero] = (3, i - len(generos)/2)
    
    return pos

def visualizar_grafo():
    """Cria e salva a visualização do grafo"""
    # Criar o grafo
    G = criar_grafo_musica()
    
    # Configurar figura
    plt.figure(figsize=(20, 14))
    plt.title("Estrutura do Grafo de Música - Neo4j\nUsuários, Artistas, Músicas e Gêneros", 
              fontsize=16, fontweight='bold', pad=20)
    
    # Criar layout
    pos = criar_layout_personalizado(G)
    
    # Separar nós por tipo para desenhar com cores diferentes
    tipos_nos = {}
    for node in G.nodes():
        tipo = G.nodes[node]['tipo']
        if tipo not in tipos_nos:
            tipos_nos[tipo] = []
        tipos_nos[tipo].append(node)
    
    # Cores para cada tipo
    cores_tipos = {
        'Usuario': '#FF6B6B',      # Vermelho
        'Artista': '#4ECDC4',      # Azul-turquesa  
        'Musica': '#45B7D1',       # Azul
        'Genero': '#96CEB4'        # Verde
    }
    
    # Desenhar nós por tipo
    for tipo, nos in tipos_nos.items():
        nx.draw_networkx_nodes(G, pos, nodelist=nos, 
                             node_color=cores_tipos[tipo],
                             node_size=1500,
                             alpha=0.8)
    
    # Desenhar arestas
    nx.draw_networkx_edges(G, pos, edge_color='gray', alpha=0.5, width=1)
    
    # Adicionar labels dos nós
    nx.draw_networkx_labels(G, pos, font_size=8, font_weight='bold')
    
    # Adicionar legenda
    legenda_elementos = []
    for tipo, cor in cores_tipos.items():
        legenda_elementos.append(plt.Line2D([0], [0], marker='o', color='w', 
                                          markerfacecolor=cor, markersize=15, label=tipo))
    
    plt.legend(handles=legenda_elementos, loc='upper right', fontsize=12)
    
    # Adicionar informações sobre relacionamentos
    info_texto = """
    Relacionamentos:
    • ESCUTA (Usuario → Musica)
    • CURTE (Usuario → Musica)  
    • SEGUE (Usuario → Artista)
    • CANTA (Artista → Musica)
    • PERTENCE_AO (Musica → Genero)
    • PRODUZ_GENERO (Artista → Genero)
    """
    
    plt.text(-3.5, -6, info_texto, fontsize=10, 
             bbox=dict(boxstyle="round,pad=0.5", facecolor="lightgray", alpha=0.7))
    
    # Remover eixos
    plt.axis('off')
    
    # Ajustar layout
    plt.tight_layout()
    
    # Salvar imagem
    plt.savefig('estrutura_grafo_musica.png', dpi=300, bbox_inches='tight', 
                facecolor='white', edgecolor='none')
    
    print("✅ Imagem salva como 'estrutura_grafo_musica.png'")
    print("📊 Estatísticas do grafo:")
    print(f"   • Nós: {G.number_of_nodes()}")
    print(f"   • Arestas: {G.number_of_edges()}")
    print(f"   • Usuários: {len([n for n in G.nodes() if G.nodes[n]['tipo'] == 'Usuario'])}")
    print(f"   • Artistas: {len([n for n in G.nodes() if G.nodes[n]['tipo'] == 'Artista'])}")
    print(f"   • Músicas: {len([n for n in G.nodes() if G.nodes[n]['tipo'] == 'Musica'])}")
    print(f"   • Gêneros: {len([n for n in G.nodes() if G.nodes[n]['tipo'] == 'Genero'])}")
    
    # Mostrar a imagem
    plt.show()

if __name__ == "__main__":
    print("🎵 Gerando visualização do grafo de música...")
    visualizar_grafo()