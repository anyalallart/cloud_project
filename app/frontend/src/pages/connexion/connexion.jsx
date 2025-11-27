import { useState } from 'react';
import './connexion.css';

const LoginPage = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const handleClick = async () => {
    try {
      const response = await fetch('http://127.0.0.1:8000/api/login/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username,
          password,
        }),
      });

      console.log('response', response);
      if (!response.ok) {
        const text = await response.text();
        alert('Error login in: ' + (text || response.statusText));
        return;
      }
      window.location.href = '/Liste_jeux';
    }
    catch (error) {
      alert('Error login in: ' + error.message);
      return;
    }
  };

  return (
    <div className="page">
      <h1 className="title">Pixelo</h1>

      <input
        type="text"
        placeholder="Username"
        className="input-field"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
      />
      <input
        type="password"
        placeholder="Password"
        className="input-field"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
      <button onClick={handleClick} className="button">
        Valider
      </button>
    </div>
  );
};

export default LoginPage;
