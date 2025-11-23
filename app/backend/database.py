from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os
from dotenv import load_dotenv

# create database connection

# load variables from data.env
load_dotenv("environment.env")

DB_USERNAME = os.getenv("DB_USERNAME")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_PATH")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME", "testpixelo")

if not DB_USERNAME or not DB_PASSWORD:
    raise RuntimeError("DB_USERNAME and DB_PASSWORD must be set in data.env")

URL_DATABASE = f"postgresql://{DB_USERNAME}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

engine = create_engine(URL_DATABASE)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()