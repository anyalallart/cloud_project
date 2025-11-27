from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from sqlalchemy.orm import Session
import models
from database import SessionLocal, engine

# Create the database tables
app = FastAPI()

# enable CORS so browsers can perform OPTIONS preflight requests
origins = [
    "http://localhost:5173",
    "http://127.0.0.1:5173",
    "http://localhost:3000",
    "http://127.0.0.1:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,      
    allow_credentials=True,
    allow_methods=["*"],        
    allow_headers=["*"],        
)
models.Base.metadata.create_all(bind=engine)

# Pydantic models for request and response bodies
class UsersBase(BaseModel):
    username: str
    password: str

# get database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# API endpoints
@app.post("/api/login/")    #to log in
def login(user: UsersBase, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.username == user.username).first()
    if db_user is None or db_user.password != user.password:
        raise HTTPException(status_code=400, detail="Invalid username or password")
    return {"message": "Login successful"}

@app.post("/api/users/", status_code=201)   #to create a new user
def create_user(user: UsersBase, db: Session = Depends(get_db)):
    # simple validation
    if not user.username or not user.username.strip():
        raise HTTPException(status_code=422, detail="Username cannot be empty")
    if not user.password or len(user.password) < 6:
        raise HTTPException(status_code=422, detail="Password must be at least 6 characters")   

    # check for existing user
    existing = db.query(models.User).filter(models.User.username == user.username).first()
    if existing:
        raise HTTPException(status_code=400, detail="Username already registered")

    db_user = models.User(username=user.username, password=user.password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return {"message": "User created successfully"}

