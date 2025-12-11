import "../../App.css";
import { Link } from "react-router-dom";

export default function Accueil() {
  return (
    <div className="page">
      <h1 className="title">Pixelo</h1>
        <Link to ="/connexion">
      <button className="button">Se connecter</button>
        </Link>
        <Link to="/liste_jeux">
      <button className="button">Log in as guest</button>
      </Link>
      <Link to ="/create-account">
        <button className="button">S'inscrire</button>
      </Link>
    </div>
  );
}
