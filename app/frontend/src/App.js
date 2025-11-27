import './App.css';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Accueil from './pages/accueil/Accueil';
import CreateAccount from './pages/inscription/inscription';
import LoginPage from './pages/connexion/connexion';
import ListeJeux from './pages/liste_jeux/liste_jeux';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Accueil />} />
        <Route path="/create-account" element={<CreateAccount/>} />
        <Route path="/connexion" element={<LoginPage/>} />
        <Route path="/liste_jeux" element={<ListeJeux/>} />
      </Routes>
    </Router>
  );
}

export default App;
