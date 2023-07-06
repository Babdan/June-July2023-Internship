CREATE DATABASE scada;

USE scada;

CREATE TABLE login (
    uname VARCHAR(29) PRIMARY KEY,
    password VARCHAR(29)
);

INSERT INTO login (uname, password) VALUES ('test', 'testpass');
