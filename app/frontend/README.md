# 1.Getting the project started

To launch this part of the project, you have to follow these directions :

## Frontend

go into the project directory entitled frontend.
run these commands :

### `npm install`
### `npm start`

It will run the app in development mode.
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

## Backend

go into the project directory entitled backend.
run these commands :

### `python3 -m venv mon_environnement_virtuel`

puis, selon votre systeme d'exploitation :

Windows :
### `mon_environnement_virtuel\Scripts\activate.bat`
Linux/MacOS :
### `source mon_environnement_virtuel/bin/activate`

enfin, exécutez ces commandes :
### `pip install -r requirements.txt`
### `python -m uvicorn main:app`

Cela rendra accessible la partie backend sur à l'adresse [http://localhost:8000](http://127.0.0.1:8000)

Vous pouvez tester les différentes routes de l'API en vous rendant sur [http://localhost:8000](http://127.0.0.1:8000)/docs
