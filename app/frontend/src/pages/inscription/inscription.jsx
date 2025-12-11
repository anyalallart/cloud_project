import { useState } from 'react';
import './inscription.css';


const CreateAccount = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');


    const handleSubmit = async () => {
        if (password !== confirmPassword) {
            alert('Passwords do not match!');
            return;
        }

        try {
            // read env vars (for CRA use REACT_APP_ prefix). Fallbacks included.
            const BACK_PATH = process.env.REACT_APP_BACKEND_URL;

            const response = await fetch(`http://${BACK_PATH}:8000/api/users/`, {
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
                alert('Error creating account: ' + (text || response.statusText));
                return;
            }

            // navigate only on success
            window.location.href = '/Liste_jeux';
        } catch (error) {
            alert('Error creating account: ' + error.message);
            return;
        }
    };

    return (
        <div className="page">
            <h1 className="title">Pixelo</h1>
        <button className="home-button" onClick={() => {window.location.href = '/';}}>Accueil</button>
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
            <input
                type="password"
                placeholder="Confirm Password"
                className="input-field"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
            />

            <button onClick={handleSubmit} className="button">
                Valider
            </button>
        </div>
    );
    };

export default CreateAccount;
