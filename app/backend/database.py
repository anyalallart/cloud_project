import os
import urllib.parse
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

# Récupération des variables
POSTGRES_USER = os.getenv("POSTGRES_USER", "user")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD", "password")
POSTGRES_HOST = os.getenv("POSTGRES_HOST", "localhost")
POSTGRES_DB = os.getenv("POSTGRES_DB", "db")
SSL_MODE = os.getenv("SSL_MODE", "require") # Par défaut 'require' pour la PROD

encoded_password = urllib.parse.quote_plus(POSTGRES_PASSWORD)

# Construction de l'URL
DATABASE_URL = f"postgresql://{POSTGRES_USER}:{encoded_password}@{POSTGRES_HOST}:5432/{POSTGRES_DB}"

# Ajout conditionnel du SSL
if SSL_MODE == "require":
    DATABASE_URL += "?sslmode=require"

print(f"Connecting to DB at {POSTGRES_HOST}...") # Debug utile

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base() 