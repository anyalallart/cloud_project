from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

app = FastAPI()

# Configuration CORS : Permet au Frontend (port 3000) de parler au Backend (port 8000)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3001","http://127.0.0.1:3001"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"message": "Le Backend Morpion est en ligne !"}

# Modèle de données : on attend une liste de 9 cases (ex: ["X", "", "O", ...])
class GameBoard(BaseModel):
    board: List[str]

def check_victory(board):
    # Toutes les combinaisons gagnantes (lignes, colonnes, diagonales)
    winning_combos = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], # Lignes
        [0, 3, 6], [1, 4, 7], [2, 5, 8], # Colonnes
        [0, 4, 8], [2, 4, 6]             # Diagonales
    ]
    
    for a, b, c in winning_combos:
        if board[a] and board[a] == board[b] == board[c]:
            return board[a] # Retourne "X" ou "O"
    
    if "" not in board:
        return "Draw" # Match nul si plus de case vide
        
    return None # Pas encore fini

#@app.post("/check-game")
#def check_game(game: GameBoard):
#    winner = check_victory(game.board)
#    return {"winner": winner}

@app.post("/check-game")
def check_game(game: GameBoard):
    # On affiche ce qu'on reçoit dans le terminal
    print(f"Plateau reçu : {game.board}") 
    
    winner = check_victory(game.board)
    
    # On affiche le gagnant trouvé (ou None)
    print(f"Gagnant détecté : {winner}")
    
    return {"winner": winner}