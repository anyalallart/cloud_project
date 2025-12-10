import { useState } from 'react'
import './App.css'
import syncIcon from './assets/icons8-synchroniser-48.png'

function App() {
  const [board, setBoard] = useState(Array(9).fill(""))
  const [isXNext, setIsXNext] = useState(true)
  const [winner, setWinner] = useState(null)

  const handleClick = async (index) => {
    if (board[index] !== "" || winner) return

    const newBoard = [...board]
    newBoard[index] = isXNext ? "X" : "O"
    setBoard(newBoard)
    setIsXNext(!isXNext)

    try {
      const response = await fetch(import.meta.env.VITE_API_URL || 'http://localhost:8000/check-game', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ board: newBoard })
      })
      const data = await response.json()
      if (data.winner) setWinner(data.winner)
    } catch (error) {
      console.error("Erreur backend:", error)
    }
  }

  const resetGame = () => {
    setBoard(Array(9).fill(""))
    setWinner(null)
    setIsXNext(true)
  }

  return (
    <div className="container">
      <div className="game-card">
        <h1 className="title">Morpion ✨</h1>
        
        <div className="status-badge">
          {winner === "Draw" ? "Match Nul 😐" : 
           winner ? `Vainqueur : ${winner} 🎉` : 
           `Au tour de : ${isXNext ? "X" : "O"}`}
        </div>

        <div className="board">
          {board.map((cell, index) => (
            <button 
              key={index} 
              // Ici on ajoute une classe spécifique si c'est X ou O
              className={`cell ${cell === "X" ? "is-x" : cell === "O" ? "is-o" : ""}`} 
              onClick={() => handleClick(index)}
            >
              {cell}
            </button>
          ))}
        </div>

        <button className="reset-btn" onClick={resetGame}>
          Recommencer <img src={syncIcon} alt="Sync" className="btn-icon" />
        </button>
      </div>
    </div>
  )
}

export default App