DROP TABLE IF EXISTS Users;

CREATE TABLE  Users (
    user_id SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    password TEXT NOT NULL
);