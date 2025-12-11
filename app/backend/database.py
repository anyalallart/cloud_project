from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os
from dotenv import load_dotenv

# create database connection

# load variables from data.env
try:
    load_dotenv("environment.env")
except Exception as e:
    raise RuntimeError(f"Failed to load environment variables: {e}")

POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_HOST = os.getenv("POSTGRES_HOST")
POSTGRES_DB = os.getenv("POSTGRES_DB")

if not POSTGRES_USERNAME or not POSTGRES_PASSWORD:
    raise RuntimeError("POSTGRES_USERNAME and POSTGRES_PASSWORD must be set in data.env")

URL_DATABASE = f"postgresql://{POSTGRES_USERNAME}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:5432/{POSTGRES_NAME}"

engine = create_engine(URL_DATABASE)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()