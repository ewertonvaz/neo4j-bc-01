"""
Desafio 03 — Rede Social de Apreciadores de Livros
Gera o diagrama do modelo de grafo Neo4j em PNG.
"""
import os
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Circle

# ── Layout ────────────────────────────────────────────────────────────────────
# figura 20×14 pol → escala 1 pol/unidade em x e y (círculos ficam perfeitos)
FIG_W, FIG_H = 20, 14
BG = '#0D1117'
ARROW_COLOR = '#58A6FF'
LABEL_BG = '#161B22'
LABEL_EDGE = '#30363D'

NODES = {
    'Usuario': {
        'pos': (5.5, 7.5), 'r': 1.55, 'color': '#1F6FEB',
        'props': 'id · nome · email\ncidade · bio · dataCadastro',
    },
    'Post': {
        'pos': (5.5, 12.5), 'r': 1.2, 'color': '#B91C1C',
        'props': 'id · conteudo · tipo\ndataPublicacao',
    },
    'Livro': {
        'pos': (13.5, 7.5), 'r': 1.45, 'color': '#C2410C',
        'props': 'id · titulo · isbn\nanoPublicacao · paginas',
    },
    'Autor': {
        'pos': (13.5, 12.5), 'r': 1.15, 'color': '#15803D',
        'props': 'id · nome\nnacionalidade',
    },
    'Genero': {
        'pos': (10.5, 2.5), 'r': 1.1, 'color': '#7E22CE',
        'props': 'id · nome\ndescricao',
    },
    'Comunidade': {
        'pos': (1.5, 7.5), 'r': 1.2, 'color': '#0F766E',
        'props': 'id · nome · descricao\ndataCriacao',
    },
}

# ── Helpers ───────────────────────────────────────────────────────────────────

def edge_point(cx, cy, r, tx, ty):
    """Ponto na borda do círculo na direção de (tx, ty)."""
    dx, dy = tx - cx, ty - cy
    d = np.hypot(dx, dy)
    return cx + dx / d * (r + 0.06), cy + dy / d * (r + 0.06)


def draw_node(ax, name, cfg):
    x, y = cfg['pos']
    r, color = cfg['r'], cfg['color']
    # brilho
    for i in (3, 2, 1):
        ax.add_patch(Circle((x, y), r + 0.12 * i,
                            fc=color, ec='none', alpha=0.04, zorder=1))
    # círculo principal
    ax.add_patch(Circle((x, y), r, fc=color, ec='white',
                        lw=1.8, alpha=0.92, zorder=3))
    # label tipo
    ax.text(x, y + r * 0.32, f':{name}',
            ha='center', va='center', fontsize=9.5,
            fontweight='bold', color='white', zorder=5)
    # propriedades
    ax.text(x, y - r * 0.28, cfg['props'],
            ha='center', va='center', fontsize=6.5,
            color='#C9D1D9', alpha=0.95, zorder=5,
            multialignment='center', linespacing=1.5)


def draw_rel(ax, fn, tn, label, rad=0.0, lpos=None):
    fc, tc = NODES[fn], NODES[tn]
    fx, fy = fc['pos']
    tx, ty = tc['pos']
    sx, sy = edge_point(fx, fy, fc['r'], tx, ty)
    ex, ey = edge_point(tx, ty, tc['r'], fx, fy)

    ax.annotate('', xy=(ex, ey), xytext=(sx, sy),
                arrowprops=dict(
                    arrowstyle='-|>', color=ARROW_COLOR, lw=1.5,
                    mutation_scale=13,
                    connectionstyle=f'arc3,rad={rad}',
                ), zorder=4)

    if lpos is None:
        mx, my = (sx + ex) / 2, (sy + ey) / 2
        if rad != 0:
            dx, dy = ex - sx, ey - sy
            length = np.hypot(dx, dy)
            nx, ny = -dy / length, dx / length
            scale = abs(rad) * np.hypot(ex - sx, ey - sy) * 0.45
            mx += nx * scale
            my += ny * scale
        lpos = (mx, my)

    ax.text(lpos[0], lpos[1], label,
            ha='center', va='center', fontsize=7.2,
            color='#E6EDF3', fontweight='bold', zorder=6,
            bbox=dict(boxstyle='round,pad=0.28', fc=LABEL_BG,
                      ec=ARROW_COLOR, lw=0.8, alpha=0.95))


def draw_self_loop(ax, name, label):
    cfg = NODES[name]
    cx, cy = cfg['pos']
    r = cfg['r']
    lx = cx - r * 0.45
    ly = cy + r + 0.75
    lr = 0.68
    theta = np.linspace(0, 2 * np.pi, 200)
    ax.plot(lx + lr * np.cos(theta), ly + lr * np.sin(theta),
            color=ARROW_COLOR, lw=1.5, zorder=4)
    # ponta da seta (bottom do loop)
    ax.annotate('', xy=(lx + lr * 0.08, ly - lr),
                xytext=(lx - lr * 0.08, ly - lr),
                arrowprops=dict(arrowstyle='-|>', color=ARROW_COLOR,
                                lw=1.5, mutation_scale=11), zorder=5)
    ax.text(lx, ly + lr + 0.38, label,
            ha='center', va='center', fontsize=7.2,
            color='#E6EDF3', fontweight='bold', zorder=6,
            bbox=dict(boxstyle='round,pad=0.28', fc=LABEL_BG,
                      ec=ARROW_COLOR, lw=0.8, alpha=0.95))


# ── Figura ────────────────────────────────────────────────────────────────────
fig = plt.figure(figsize=(FIG_W, FIG_H))
ax = fig.add_axes([0.01, 0.01, 0.98, 0.97])
ax.set_facecolor(BG)
fig.patch.set_facecolor(BG)
ax.set_xlim(0, FIG_W)
ax.set_ylim(0, FIG_H)
ax.axis('off')

# título
ax.text(FIG_W / 2, FIG_H - 0.35,
        'Rede Social de Apreciadores de Livros — Modelo de Grafo Neo4j',
        ha='center', va='center', fontsize=14, fontweight='bold',
        color='white', fontfamily='monospace')

# nós
for name, cfg in NODES.items():
    draw_node(ax, name, cfg)

# relacionamentos
draw_rel(ax, 'Usuario', 'Post',
         'PUBLICOU\nCURTIU | COMENTOU', rad=0.0, lpos=(3.8, 10.3))
draw_rel(ax, 'Post',    'Livro',
         'SOBRE', rad=0.0, lpos=(10.2, 11.0))
draw_rel(ax, 'Autor',   'Livro',
         'ESCREVEU', rad=0.0, lpos=(13.5, 10.5))
draw_rel(ax, 'Livro',   'Genero',
         'PERTENCE_AO', rad=0.0, lpos=(12.7, 5.3))
draw_rel(ax, 'Usuario', 'Livro',
         'JA_LEU | LENDO\nQUER_LER | AVALIOU', rad=-0.18, lpos=(9.5, 9.2))
draw_rel(ax, 'Usuario', 'Genero',
         'INTERESSA_SE', rad=0.12, lpos=(7.8, 4.5))
draw_rel(ax, 'Usuario', 'Comunidade',
         'MEMBRO_DE', rad=0.0, lpos=(3.4, 8.35))
draw_self_loop(ax, 'Usuario', 'SEGUE')

# ── Caixa de propriedades dos relacionamentos ─────────────────────────────────
props_rels = [
    ('SEGUE',        'dataInicio'),
    ('AVALIOU',      'nota (1–5) · dataAvaliacao'),
    ('JA_LEU',       'dataLeitura'),
    ('LENDO',        'dataInicio'),
    ('QUER_LER',     'dataAdicao'),
    ('CURTIU',       'dataCurtida'),
    ('COMENTOU',     'texto · dataComentario'),
    ('MEMBRO_DE',    'dataEntrada'),
    ('PUBLICOU',     '—'),
    ('ESCREVEU',     '—'),
    ('SOBRE',        '—'),
    ('PERTENCE_AO',  '—'),
    ('INTERESSA_SE', '—'),
]

bx, by = 17.4, 6.2
ax.text(bx, by + 0.15, 'Propriedades dos Relacionamentos',
        ha='center', va='bottom', fontsize=8, fontweight='bold', color='white',
        bbox=dict(boxstyle='round,pad=0.3', fc=LABEL_BG,
                  ec='#3D8BFF', lw=1.2))

for i, (rel, prop) in enumerate(props_rels):
    yy = by - 0.62 - i * 0.56
    ax.text(bx - 1.5, yy, f'[:{rel}]',
            ha='left', va='center', fontsize=7, color='#79C0FF', fontweight='bold')
    ax.text(bx + 0.55, yy, prop,
            ha='left', va='center', fontsize=7, color='#8B949E')

# ── Legenda de nós ────────────────────────────────────────────────────────────
lx, ly = 17.4, 13.4
ax.text(lx, ly + 0.12, 'Tipos de Nós',
        ha='center', va='bottom', fontsize=8, fontweight='bold', color='white',
        bbox=dict(boxstyle='round,pad=0.3', fc=LABEL_BG,
                  ec='#58A6FF', lw=1.2))

for i, (name, cfg) in enumerate(NODES.items()):
    yy = ly - 0.65 - i * 0.58
    ax.add_patch(Circle((lx - 1.4, yy), 0.2,
                        fc=cfg['color'], ec='white', lw=1, zorder=3))
    ax.text(lx - 1.1, yy, f':{name}',
            ha='left', va='center', fontsize=8, color='white')

# ── Salvar ────────────────────────────────────────────────────────────────────
out = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'modelo_grafo.png')
plt.savefig(out, dpi=150, bbox_inches='tight', facecolor=BG)
print(f'✓ Modelo do grafo salvo em: {out}')
