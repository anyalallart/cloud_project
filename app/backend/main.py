from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base, Session
import os

# --- 1. DB CONFIGURATION (Variables injected by ACA/Terraform) ---
POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_HOST = os.getenv("POSTGRES_HOST") # This is the FQDN of the PostgreSQL server
POSTGRES_DB = os.getenv("POSTGRES_DB")

# Build the connection URL
SQLALCHEMY_DATABASE_URL = f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:5432/{POSTGRES_DB}"

# Attempt connection and table creation
try:
    engine = create_engine(SQLALCHEMY_DATABASE_URL, pool_pre_ping=True)
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    Base = declarative_base()

    class Item(Base):
        __tablename__ = "items"
        id = Column(Integer, primary_key=True, index=True)
        name = Column(String, default="ACA_TEST_ITEM")

    Base.metadata.create_all(bind=engine)
    DB_CONNECTED = True
except Exception as e:
    print(f"Database connection error: {e}")
    DB_CONNECTED = False
    engine = None
    SessionLocal = None

def get_db():
    if not DB_CONNECTED or SessionLocal is None:
        raise HTTPException(status_code=500, detail="Database connection is not available.")
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# --- 2. FASTAPI APPLICATION ---
app = FastAPI()

# CRITICAL CORS FIX: Allow ALL origins.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # Solves the "Failed to fetch" issue
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- 3. API ROUTES (F->B->DB Communication) ---

def get_current_count(db: Session):
    """Retrieves the current item count."""
    return db.query(Item).count()

@app.get("/")
def read_root():
    if not DB_CONNECTED:
        return {"status": "error", "message": "Backend running but DB not connected"}
    return {"status": "ok", "message": "Backend running and DB connected"}

@app.post("/api/add/")
def add_item(db: Session = Depends(get_db)):
    """Adds a simple row to the DB and returns the new count."""
    new_item = Item()
    db.add(new_item)
    db.commit()
    db.refresh(new_item)
    return {"message": "Item added", "count": get_current_count(db)}

@app.post("/api/delete/")
def delete_item(db: Session = Depends(get_db)):
    """Deletes the oldest row and returns the new count."""
    item_to_delete = db.query(Item).order_by(Item.id).first()
    
    if item_to_delete:
        db.delete(item_to_delete)
        db.commit()
        return {"message": "Item deleted", "count": get_current_count(db)}
    
    raise HTTPException(status_code=404, detail="No items to delete")

@app.get("/api/count/")
def count_items(db: Session = Depends(get_db)):
    """Retrieves only the item count (for initial refresh)."""
    return {"count": get_current_count(db)}