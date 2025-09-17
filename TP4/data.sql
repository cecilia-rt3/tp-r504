CREATE DATABASE IF NOT EXISTS tp4db;
USE tp4db;

DROP TABLE IF EXISTS myTable;
CREATE TABLE myTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    age INT
);

INSERT INTO myTable (nom, age) VALUES
('Alice', 22),
('Bob', 25),
('Charlie', 30);
