from fastapi import FastAPI
from pydantic import BaseModel
import random
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Autoriser React à nous parler
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Move(BaseModel):
    player_move: str

@app.post("/play")
def play_game(move: Move):
    choices = ["Pierre 🪨", "Feuille 📄", "Ciseaux ✂️"]
    computer_move = random.choice(choices)
    player = move.player_move
    
    result = ""
    
    if player == computer_move:
        result = "Égalité ! 😐"
    elif (player == "Pierre 🪨" and computer_move == "Ciseaux ✂️") or \
         (player == "Feuille 📄" and computer_move == "Pierre 🪨") or \
         (player == "Ciseaux ✂️" and computer_move == "Feuille 📄"):
        result = "Gagné ! 🎉"
    else:
        result = "Perdu ! 🤖"

    return {"computer": computer_move, "result": result}