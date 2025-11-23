from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from typing import List, Optional, Annotated
from sqlalchemy.orm import Session
import models
from database import SessionLocal, engine

# Create the database tables
app = FastAPI()
models.Base.metadata.create_all(bind=engine)

# Pydantic models for request and response bodies
class UsersBase(BaseModel):
    username: str
    password: str

# get database session
def get_db () :
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]

# API endpoints

@app.post("/users/", response_model=UsersBase)
def create_user(user: UsersBase, db: db_dependency):
    db_user = models.User(username=user.username, password=user.password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

@app.post("/login/")
def login(user: UsersBase, db: db_dependency):
    db_user = db.query(models.User).filter(models.User.username == user.username).first()
    if db_user is None or db_user.password != user.password:
        raise HTTPException(status_code=400, detail="Invalid username or password")
    return {"message": "Login successful"}
