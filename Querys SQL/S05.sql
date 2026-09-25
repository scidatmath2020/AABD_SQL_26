--- Bloque: UPDATE y DELETE

--- Ejercicio 1. Actualizar becas. Aumentar 10 puntos porcentuales la beca de alumnos 
--- de aquellos que tengan mayor de 0 y menor e igual que 50, sin superar 100.

SELECT beca_porcentaje FROM academico.alumnos;

UPDATE academico.alumnos
SET beca_porcentaje =
	CASE WHEN beca_porcentaje + 10 > 100 THEN 100
		ELSE beca_porcentaje + 10 END
WHERE beca_porcentaje > 0 AND beca_porcentaje <=50;

--- ordenar tabla por id_alumnos

SELECT * FROM academico.alumnos
ORDER BY id_alumno ASC;

--- Ejercicio 2. Clonar y revir actualización sin ROLLBACK;

--- Crear la nueva columna 

ALTER TABLE academico.alumnos
ADD COLUMN beca_porcentaje_sn10 NUMERIC(5,2);

--- Copiar valores con la reversión
UPDATE academico.alumnos
SET beca_porcentaje_sn10 = 
	CASE 
		WHEN beca_porcentaje > 10
		AND beca_porcentaje <= 60
		THEN beca_porcentaje - 10
		ELSE beca_porcentaje
	END;

SELECT * FROM academico.alumnos
ORDER BY id_alumno ASC;

--- Ejercicio 3. Desactivar profesores. Cambia activo a FALSE para docentes contratados
--- antes de 2012

SELECT fecha_contratacion, activo FROM academico.profesores
ORDER BY fecha_contratacion ASC;

UPDATE academico.profesores
SET activo = FALSE
WHERE fecha_contratacion < DATE '2012-01-01' 

SELECT fecha_contratacion, activo FROM academico.profesores
ORDER BY fecha_contratacion ASC;

--- Ejercicio 4. USAR ROLLBACK y COMMIT para efectuar o no efectuar cambios/actualizaciones.
--- el profesor con el id_profesor = 1 cambiará su especialidad por matemáticas 
--- pero se requiere visualizar los cambios y decidir si se acepta o se deshace 

SELECT * FROM academico.profesores;

--- Inicar transacción
BEGIN;

--- Actualizar al profesor y mostrar el resultado 

UPDATE academico.profesores
SET especialidad = 'Matemáticas'
WHERE id_profesor = 1
RETURNING *;

--- Si aceptamos los cambios:
--- COMMIT;

--- Si no aceptas y deshacemos el cambio:
--- ROLLBACK;

ROLLBACK;
SELECT * FROM academico.profesores;


--- Inicar transacción
BEGIN;

--- Actualizar al profesor y mostrar el resultado 

UPDATE academico.profesores
SET especialidad = 'Matemáticas'
WHERE id_profesor = 1
RETURNING *;

--- Si aceptamos los cambios:
--- COMMIT;

--- Si no aceptas y deshacemos el cambio:
--- ROLLBACK;

COMMIT;
SELECT * FROM academico.profesores
ORDER BY id_profesor ASC;

---- Ejercicio 12. Borrado controlado. Inserta un aviso de prueba y elimina
---- únicamente ese registro usando su clave

---- Se crea la tabla 

CREATE TABLE academico.avisos (
    id_aviso INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR(120) NOT NULL,
    contenido VARCHAR(500),
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estatus VARCHAR(12) NOT NULL DEFAULT 'Publicado'
);
INSERT INTO academico.avisos (titulo,contenido)
SELECT 'Aviso '||LPAD(i::text,2,'0'),
       'Contenido del aviso '||LPAD(i::text,2,'0')
FROM generate_series(1,30) AS s(i);

SELECT * FROM academico.avisos;

INSERT INTO academico.avisos (titulo, contenido)
VALUES ('AVISO PRUEBA', 'Registro que se eliminará');

SELECT * FROM academico.avisos;

--- Borrado controlado 

DELETE FROM academico.avisos WHERE titulo = 'AVISO PRUEBA';
SELECT * FROM academico.avisos;

--- Verificar inserción manual 

BEGIN;
INSERT INTO academico.avisos (titulo, contenido)
VALUES ('AVISO PRUEBA', 'Registro que se eliminará')
RETURNING *;
ROLLBACK;
SELECT * FROM academico.avisos;

BEGIN;
INSERT INTO academico.avisos (titulo, contenido)
VALUES ('AVISO PRUEBA', 'Registro que se eliminará')
RETURNING *;
COMMIT;
SELECT * FROM academico.avisos;

--- Bloque: Select condicionales (usando order by, alias, where, case)

--- Ejercicio 1. Clasificar alumnos según su beca.

--- Sin información: Si la beca es NULL
--- Sin beca: si es igual a 0
--- Beca baja: Si es mayor que 0 pero menor que 30
--- Beca media: Si esta entre 30 y 60
--- Beca alta: si es mayor que 60

SELECT 
	id_alumno,
	beca_porcentaje,
	CASE
		WHEN beca_porcentaje IS NULL THEN 'Sin información'
		WHEN beca_porcentaje = 0 THEN 'Sin beca'
		WHEN beca_porcentaje > 0
		AND beca_porcentaje < 30 THEN 'Beca baja'
		WHEN beca_porcentaje BETWEEN 30 AND 60 THEN 'Beca media'
		WHEN beca_porcentaje > 60 THEN 'Beca alta'
		ELSE 'Valor no valido'
	END as tipo_beca
FROM academico.alumnos
ORDER BY beca_porcentaje DESC NULLS LAST,
		 id_alumno ASC;

--- Diferencia entre consulta y actualización 

ALTER TABLE academico.alumnos
ADD COLUMN tipo_beca VARCHAR(10);

UPDATE academico.alumnos
SET tipo_beca = 
	CASE
		WHEN beca_porcentaje IS NULL THEN 'Sin información'
		WHEN beca_porcentaje = 0 THEN 'Sin beca'
		WHEN beca_porcentaje > 0
		AND beca_porcentaje < 30 THEN 'Beca baja'
		WHEN beca_porcentaje BETWEEN 30 AND 60 THEN 'Beca media'
		WHEN beca_porcentaje > 60 THEN 'Beca alta'
		ELSE 'Valor no valido'
	END;

SELECT * FROM academico.alumnos
ORDER BY beca_porcentaje DESC NULLS LAST,
		 id_alumno ASC;
