-- Crear base de datos
CREATE DATABASE IF NOT EXISTS laboratorio_mysql
    CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Usar Base de datos 
USE laboratorio_mysql;
-- Crear tabla 
CREATE TABLE prueba (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL
) ENGINE = InnoDB;
-- Insertar valores en la tabla
INSERT INTO prueba(nombre) VALUES ('Mi primera fila');
-- Generar consulta
SELECT * FROM prueba ORDER BY id;
-- Mostrar tablas de la BD 
SHOW TABLES;
-- Descripción de la tabla 
DESCRIBE prueba;