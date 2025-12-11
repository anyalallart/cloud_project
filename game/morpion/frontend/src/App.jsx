import { useState } from 'react'
import './App.css'

function App() {
  const [result, setResult] = useState(null)
  const [computerMove, setComputerMove] = useState(null)
  const [score, setScore] = useState({ player: 0, computer: 0 })

  const choices = ["Pierre 🪨", "Feuille 📄", "Ciseaux ✂️"]

  const play = async (choice) => {
    try {
      const response = await fetch('http://localhost:8000/play', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ player_move: choice })
      })
      const data = await response.json()
      
      setComputerMove(data.computer)
      setResult(data.result)

      // Petit bonus : mise à jour du score
      if (data.result.includes("Gagné")) {
        setScore(s => ({ ...s, player: s.player + 1 }))
      } else if (data.result.includes("Perdu")) {
        setScore(s => ({ ...s, computer: s.computer + 1 }))
      }
    } catch (error) {
      console.error("Erreur backend:", error)
    }
  }

  return (
    <div className="container">
      <div className="game-card">
        <h1 className="title">Chifoumi 🔥</h1>
        
        <div className="score-board">
          Toi : {score.player} | Ordi : {score.computer}
        </div>

        <div className="result-area">
          {result ? (
            <>
              <div className="vs-text">L'ordi a joué : {computerMove}</div>
              <div className="final-result">{result}</div>
            </>
          ) : (
            <div className="vs-text">Fais ton choix !</div>
          )}
        </div>

        <div className="choices-grid">
          {choices.map((choice) => (
            <button 
              key={choice} 
              className="choice-btn" 
              onClick={() => play(choice)}
            >
              {choice.split(" ")[1]} {/* Affiche juste l'emoji */}
              <span className="btn-label">{choice.split(" ")[0]}</span>
            </button>
          ))}
        </div>
      </div>
    </div>
  )
}

export default App