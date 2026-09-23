--- Bloque: ALTER TABLE y DROP 

--- Ejercicio 1: Agrega la columna observaciones a academico.grupos 

ALTER TABLE academico.grupos
ADD COLUMN observaciones VARCHAR(200);

ALTER TABLE academico.grupos
ADD COLUMN observaciones2 VARCHAR(200) NOT NULL DEFAULT 'Obs';

SELECT * FROM academico.grupos;

--- Ejercicio 2: Agrega una restricción que acepte únicamente los estatus: 
--- activo, suspendido o cerrado en la columna estatus_grupo creada en grupos

ALTER TABLE academico.grupos
ADD COLUMN estatus_grupo VARCHAR(10) NOT NULL DEFAULT 'Activo';

ALTER TABLE academico.grupos
ADD CONSTRAINT ck_grupo_estatus CHECK
	(estatus_grupo IN ('Activo', 'Suspendido', 'Cerrado'));

SELECT * FROM academico.grupos;

--- Complemento: Duda de Alejandro. Si quiero que los proximos nulos ya no sean 'Activo'
--- por Default, puede modificarse la columna? Para que solo los registros anteriores
--- se rellenen con 'Activo' pero de ahi en adelante ya no acepte nulos ni con default

--- NOTA: Este proceso de hace complementariamente con UPDATE y DROP 

UPDATE academico.grupos
SET estatus_grupo = 'Activo'
WHERE estatus_grupo IS NULL;

ALTER TABLE academico.grupos
ALTER COLUMN estatus_grupo DROP DEFAULT;

ALTER TABLE academico.grupos
ALTER COLUMN estatus_grupo DROP NOT NULL;

ALTER TABLE academico.grupos
ALTER COLUMN estatus_grupo DROP DEFAULT,
ALTER COLUMN estatus_grupo DROP NOT NULL;

--- Ejercicio 3: Elimina la columna observaciones2 

ALTER TABLE academico.grupos
DROP COLUMN observaciones2 CASCADE;

SELECT * FROM academico.grupos;

--- Ejercicio 4: Crea una tabla temporal de práctica llamada academico.bitacora_prueba
--- agrega columna y finalmente eliminala, ojo no elimines ninguna tabla principal 

CREATE TABLE academico.bitacora_prueba(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
);

ALTER TABLE academico.bitacora_prueba
ADD COLUMN detalle VARCHAR(100);

SELECT * FROM academico.bitacora_prueba;
DROP TABLE academico.bitacora_prueba;


--- Bloque 3 INSERT 

--- Ejercicio 1: Vamos a contrar un profesor nuevo. Inserta un profesor especificando todas
--- las columnas excepto la identidad 

INSERT INTO academico.profesores
	(id_supervisor, nombre, apellidos, especialidad,
	fecha_contratacion, telefono, salario, activo)
VALUES
	(1, 'Laura', 'Méndez Ruiz', 'Matemáticas',
	'2026-09-01', '5553000001', 24500, TRUE);

SELECT * FROM academico.profesores;

--- Ejercicio 2: Materia con valores predeterminador. Inserta una materia omitiendo
--- obligatoria para que tome su valor DEFAULT

INSERT INTO academico.materias
	(clave, nombre, area, creditos, horas_semana)
VALUES
	('MAT031', 'Estadística aplicada', 'Matemáticas', 6, 4);

--- Alternativa (NOTA: Debes capturar tal cual está en la tabla de la BD)

INSERT INTO academico.materias
VALUES
	('MAT031', 'Estadística aplicada', 'Matemáticas', 6, 4);

SELECT * FROM academico.materias;

--- Ejercicio 3: Inserción múltiple. Inserta tres grupos en una sola sentencia INSERT

INSERT INTO academico.grupos
	(clave, grado, turno, aula, ciclo_escolar, cupo)
VALUES 
	('G31', 1, 'Matutino', 'A-131', '2026-2027', 30),
	('G32', 2, 'Vespertino', 'A-132', '2026-2027', 32),
	('G33', 3, 'Matutino', 'A-133', '2026-2027', 35);

INSERT INTO academico.grupos
	(clave, grado, turno, aula, ciclo_escolar, cupo)
VALUES 
	('G34', 1, 'Matutimo', 'A-131', '2026-2027', 50);

SELECT * FROM academico.grupos;
