/*data.sql*/

CREATE DATABASE demosql;
USE demosql;

CREATE TABLE myTable (
  id INT AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO myTable (id, name) VALUES (NULL, 'bob');
INSERT INTO myTable (id, name) VALUES (NULL, 'alice');
INSERT INTO myTable (id, name) VALUES (NULL, 'john');

