from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import random
from typing import Optional

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

def count_mines(grid, r, c, rows, cols):
    count = 0
    for i in range(max(0, r-1), min(rows, r+2)):
        for j in range(max(0, c-1), min(cols, c+2)):
            if grid[i][j] == "M":
                count += 1
    return count

@app.get("/new-game")
def new_game(difficulty: str = "easy", safe_r: Optional[int] = None, safe_c: Optional[int] = None, safe_radius: int = 0):
    # Configuration selon la difficulté
    if difficulty == "hard":
        rows, cols, mines = 12, 12, 25
    else: # easy
        rows, cols, mines = 8, 8, 10

    # 1. Création grille vide
    grid = [[0 for _ in range(cols)] for _ in range(rows)]

    # 2. Construire liste de positions autorisées pour mines en excluant la zone safe
    all_positions = [(r, c) for r in range(rows) for c in range(cols)]
    forbidden = set()
    if safe_r is not None and safe_c is not None:
        for i in range(max(0, safe_r - safe_radius), min(rows, safe_r + safe_radius + 1)):
            for j in range(max(0, safe_c - safe_radius), min(cols, safe_c + safe_radius + 1)):
                forbidden.add((i, j))

    allowed_positions = [pos for pos in all_positions if pos not in forbidden]

    # Si trop peu de positions autorisées (rare), on réduit le radius ou on autorise quand même
    if len(allowed_positions) < mines:
        allowed_positions = all_positions  # fallback : autoriser toutes les positions

    # 3. Placement aléatoire des mines parmi les allowed_positions
    mines_positions = random.sample(allowed_positions, mines)
    for (r, c) in mines_positions:
        grid[r][c] = "M"

    # 4. Calcul des chiffres pour les cases sans mines
    for r in range(rows):
        for c in range(cols):
            if grid[r][c] != "M":
                grid[r][c] = count_mines(grid, r, c, rows, cols)

    return {"grid": grid, "mines_count": mines}
