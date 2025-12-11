import { useState, useEffect } from 'react'
import './App.css'
import syncIcon from './assets/icons8-synchroniser-48.png'

function App() {
  const [grid, setGrid] = useState([]) // La solution (reçue du back)
  const [view, setView] = useState([]) // Ce que le joueur voit
  const [gameOver, setGameOver] = useState(false)
  const [win, setWin] = useState(false)
  const [score, setScore] = useState(0) // Compteur de drapeaux restants

  // Démarrer une partie
  const startNewGame = async () => {
    try {
      const res = await fetch('http://localhost:8000/new-game?difficulty=easy')
      const data = await res.json()
      setGrid(data.grid)
      setScore(data.mines_count)
      setGameOver(false)
      setWin(false)
      
      // Initialise la vue : tout est caché (status: 'hidden', 'revealed', 'flagged')
      const rows = data.grid.length
      const cols = data.grid[0].length
      const initialView = Array(rows).fill().map(() => Array(cols).fill('hidden'))
      setView(initialView)
    } catch (e) {
      console.error("Erreur serveur", e)
    }
  }

  useEffect(() => { startNewGame() }, [])

  // Gérer le Clic Gauche (Révéler)
// Gérer le Clic Gauche (Révéler)
const handleLeftClick = async (r, c) => {
  if (gameOver || win || view[r][c] !== 'hidden') return

  const isFirstMove = view.every(row => row.every(cell => cell === 'hidden'))

  // Si premier clic et c'est une mine -> regénérer une grille sûre pour cette case
  if (isFirstMove && grid[r][c] === "M") {
    try {
      const res = await fetch(`http://localhost:8000/new-game?difficulty=easy&safe_r=${r}&safe_c=${c}`)
      const data = await res.json()
      setGrid(data.grid)
      setScore(data.mines_count)
      // initialise new view (tout caché)
      const rows = data.grid.length
      const cols = data.grid[0].length
      const initialView = Array(rows).fill().map(() => Array(cols).fill('hidden'))
      // on poursuit en révélant la case cliquée sur la nouvelle grille
      const newView = [...initialView.map(row => [...row])]
      revealCell(newView, r, c)
      checkWin(newView)
      setView(newView)
      setGameOver(false)
      setWin(false)
      return
    } catch (e) {
      console.error("Erreur serveur lors de la regénération safe:", e)
      // si erreur, on continue et laissera le comportement habituel (perdre)
    }
  }

  const newView = [...view.map(row => [...row])]

  // Si c'est une mine -> PERDU
  if (grid[r][c] === "M") {
    newView[r][c] = 'boom'
    setGameOver(true)
    revealAllMines(newView)
  } else {
    // Sinon on révèle (avec propagation si c'est un 0)
    revealCell(newView, r, c)
    checkWin(newView)
  }
  setView(newView)
}


  // Gérer le Clic Droit (Drapeau)
  const handleRightClick = (e, r, c) => {
    e.preventDefault() // Empêche le menu contextuel du navigateur
    if (gameOver || win || view[r][c] === 'revealed') return

    const newView = [...view.map(row => [...row])]
    if (newView[r][c] === 'hidden') {
      newView[r][c] = 'flagged'
      setScore(s => s - 1)
    } else if (newView[r][c] === 'flagged') {
      newView[r][c] = 'hidden'
      setScore(s => s + 1)
    }
    setView(newView)
  }

  // Algorithme de propagation (Flood Fill) pour les zéros
  const revealCell = (currentView, r, c) => {
    if (r < 0 || r >= grid.length || c < 0 || c >= grid[0].length || currentView[r][c] !== 'hidden') return

    currentView[r][c] = 'revealed'

    // Si c'est un 0, on ouvre les voisins
    if (grid[r][c] === 0) {
      for (let i = r-1; i <= r+1; i++) {
        for (let j = c-1; j <= c+1; j++) {
          revealCell(currentView, i, j)
        }
      }
    }
  }

  // Afficher toutes les mines à la fin
  const revealAllMines = (currentView) => {
    grid.forEach((row, r) => {
      row.forEach((val, c) => {
        if (val === "M") currentView[r][c] = 'mine'
      })
    })
  }

  // Vérifier la victoire
  const checkWin = (currentView) => {
    let hiddenCount = 0
    let minesCount = 0
    currentView.forEach((row, r) => {
      row.forEach((status, c) => {
        if (status !== 'revealed') hiddenCount++
        if (grid[r][c] === "M") minesCount++
      })
    })
    if (hiddenCount === minesCount) setWin(true)
  }

  return (
    <div className="container">
      <div className="game-card">
        <h1 className="title">Démineur 💣</h1>
        
        <div className="status-bar">
          <div className="mines-count">🚩 {score}</div>
          <button className="reset-btn" onClick={startNewGame}>
          <span>Recommencer</span>
          <img src={syncIcon} alt="Sync" className="btn-icon" />
          </button>
        </div>

        {gameOver && <div className="overlay lose">💥 BOUM ! 💥</div>}
        {win && <div className="overlay win">🎉 GAGNÉ ! 🎉</div>}

        <div className="grid" style={{gridTemplateColumns: `repeat(${grid[0]?.length || 8}, 1fr)`}}>
          {view.map((row, r) => (
            row.map((status, c) => (
              <div 
                key={`${r}-${c}`}
                className={`cell status-${status} val-${grid[r][c]}`}
                onClick={() => handleLeftClick(r, c)}
                onContextMenu={(e) => handleRightClick(e, r, c)}
              >
                {status === 'revealed' && grid[r][c] !== 0 ? grid[r][c] : ''}
                {status === 'flagged' ? '🚩' : ''}
                {status === 'mine' ? '💣' : ''}
                {status === 'boom' ? '💥' : ''}
              </div>
            ))
          ))}
        </div>
      </div>
    </div>
  )
}

export default App