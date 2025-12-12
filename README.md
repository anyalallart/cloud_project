# cloud_project
# Feature: Morpion

> **Status:** 🧪 **Proof of Concept (PoC)** — Functional in local environment, currently not deployed to Production.

## 1. Technical Overview

This module implements a **morpion** game designed to be hosted on the **Azure Container Apps** infrastructure provisioned via Terraform.

The primary objective of this PoC was to demonstrate the deployment pattern of lightweight microservices communicating via HTTP within the **Pixelo Cloud** environment.

### Technology

* **Frontend:** **React.js (Vite)** — Reactive User Interface responsible for managing the board state.
* **Backend:** **Python (FastAPI)** — Stateless REST API handling the game logic and victory conditions.
* **Protocol:** JSON exchanges via POST requests (`/check-game`).

## 2. Structure

```text
game/morpion/
├── backend/
│   └── main.py
├── frontend/
│   ├── public/
│   │   └── vite.svg
│   ├── src/
│   │   ├── assets/
│   │   │   ├── Fredoka-Regular.ttf
│   │   │   ├── Fredoka-SemiBold.ttf
│   │   │   ├── icons8-synchroniser-48.png
│   │   │   └── react.svg
│   │   ├── App.css
│   │   ├── App.jsx
│   │   ├── index.css
│   │   └── main.jsx
│   ├── .gitignore
│   ├── eslint.config.js
│   ├── index.html
│   ├── package-lock.json
│   ├── package.json
│   ├── README.md
│   └── vite.config.js
└── .gitignore
```
## 3. Architecture & Cloud Integration (Target)

Although the application currently runs locally, it was architected to integrate seamlessly with the existing Terraform resources (`cloud_project`).

### Data Flow

1.  **Interaction:** The player clicks on a tile in the Frontend interface.
2.  **Payload:** The Frontend sends the current board state (e.g., `board: ["X", "", "O"...]`) to the Backend.
3.  **Processing:** The `check_victory` API endpoint analyzes the matrices (rows, columns, diagonals).
4.  **Response:** The Backend returns the winner or `null`.


## 4. Local Development Guide

Follow these steps to test the functionality outside of the cloud environment:

### 1. Start the Backend (API)

```bash
cd game/morpion/backend

# Install dependencies
pip install fastapi uvicorn

# Start the server (Listens on http://localhost:8000)
uvicorn main:app --reload
```

### 2. Start the Frontend

```bash
cd game/morpion/frontend

# Install dependencies
npm install

# Start the development server (Listens on http://localhost:3001 by default)
npm run dev
```
