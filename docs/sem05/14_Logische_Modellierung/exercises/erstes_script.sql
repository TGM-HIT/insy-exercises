DROP DATABASE IF EXISTS test_db;
CREATE DATABASE test_db;
USE test_db;

CREATE TABLE person(
    id int,
    vorname VARCHAR(50),
    nachname VARCHAR(50),
    tel VARCHAR(50)
);

INSERT INTO person(id, vorname, nachname) VALUES
(3, 'dominik', 'hoebert');
