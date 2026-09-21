--- Crear una tabla de clientes: Para ello se necesita implementar
--- el comando CREATE seguido de TABLE y el nombre de la tabla
--- el nombre de la tabla puede contener minusculas pero no usando
--- carácteres especiales (acentos, virgulilla, etc)

CREATE TABLE clientes (
	id_cliente SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	email VARCHAR(150),
	telefono VARCHAR(20)
);

--- Crear una tabla de ventas:

CREATE TABLE ventas (
	id_venta SERIAL PRIMARY KEY,
	id_cliente INTEGER NOT NULL,
	fecha DATE NOT NULL,
	total NUMERIC(10, 2),

	CONSTRAINT fk_cliente
		FOREIGN KEY (id_cliente)
		REFERENCES clientes(id_cliente)
);


--- ¿Cómo puedo capturar datos en las tablas ya creadas en la BD?
--- vamos a utilizar los comandos INSERT INTO (insertar dentro de)
--- seguido del nombre de la tabla de la BD y entre parentesis 
--- vamos a indicar las columnas que van a llenarse, luego se escribe 
--- VALUES que indica "valores a ingresas". Cada fila se debe llenar entre
--- () y al finalizar se agrega "," y se vuele a computar la siguiente fila

INSERT INTO clientes (nombre, apellido, email, telefono) VALUES
('Juan', 'Pérez', 'juan@gmail.com', '5551234567'),
('María', 'López', 'maria@gmail.com', '5567891023'),
('Carlos', 'García', 'carlos@gmail.com', '5554567890');

--- ¿Cómo verifico que la computo o captura fue adecuado? 
--- vamos a consultar toda la tabla con SELECT * FROM clientes
--- SELECT * indica que selecciona todas las columnas
--- FROM indica que selecionará desde el nombre de la tabla que se proporciona

SELECT * FROM clientes;

--- Computo o captura de datos para ventas

INSERT INTO ventas (id_cliente, fecha, total) VALUES
(1, '2026-09-15', 500.00),
(1, '2026-09-16', 750.50),
(2, '2026-09-16', 300.00),
(3, '2026-09-17', 1200.00);

SELECT * FROM ventas;
