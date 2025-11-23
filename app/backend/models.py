from sqlalchemy import Boolean, Column, Integer, String, ForeignKey
from database import Base

# Define DB models

class User(Base):
    __tablename__ = "Users"

    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True, nullable=False)
    password = Column(String, nullable=False)