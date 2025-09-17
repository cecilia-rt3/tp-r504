DROP DATABASE IF EXISTS tp4db;
CREATE DATABASE tp4db;
USE tp4db;

CREATE TABLE myTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45)
);

INSERT INTO myTable (id,name) VALUES (NULL, 'bob');
INSERT INTO myTable (id,name) VALUES (NULL, 'alice');
INSERT INTO myTable (id,name) VALUES (NULL, 'john');

