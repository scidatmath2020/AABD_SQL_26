--- Bloque. ANY.

--- Ejercicio 1. Mayor que algún salario. Obtén profesores cuyo salario sea 
--- mayor que al menos un salario de profesores de Artes.

SELECT nombre, apellidos, salario
FROM academico.profesores
WHERE salario > ANY (SELECT salario FROM academico.profesores
					 WHERE especialidad = 'Artes');

--- Ejercicio 2. Créditos comparados. Busca materias cuyos créditos sean
--- mayores que los de alguna materia del área de Humanidades.

SELECT clave, nombre, creditos
FROM academico.materias
WHERE creditos > ANY (SELECT creditos FROM academico.materias
					  WHERE area = 'Humanidades');

--- Ejercicio 3. Beca frente a grupo. Muestra alumnos cuya beca sea mayor 
--- que los de alguna beca observada en el grupo 1.

SELECT matricula, nombre, apellidos, beca_porcentaje
FROM academico.alumnos
WHERE beca_porcentaje > ANY (SELECT beca_porcentaje
							  FROM academico.alumnos WHERE id_grupo = 1);

--- Bloque. CASE COALESCE tablas y vistas 

--- Ejercicio 1. Clasificar calificaciones. Crea una columna
--- Nivel con CASE: Excelente para 90 o más, aprobada para 70 a 89.99
--- reprobado para menos de 70 y NP para NULL.

SELECT id_inscripcion, calificacion,
		CASE WHEN calificacion IS NULL THEN 'NP'
			 WHEN calificacion >= 90 THEN 'Excelente'
			 WHEN calificacion >= 70 THEN 'Aprobado'
			 ELSE 'Reprobado' END AS Nivel
FROM academico.inscripciones;

--- ALTER + CASE + UPDATE 

ALTER TABLE academico.inscripciones
ADD COLUMN niveles VARCHAR(20);

UPDATE academico.inscripciones
SET niveles = CASE
	WHEN calificacion IS NULL THEN 'NP'
	WHEN calificacion >= 90 THEN 'Excelente'
	WHEN calificacion >= 70 THEN 'Aprobado'
	ELSE 'Reprobado'
END;

SELECT * FROM academico.inscripciones;

--- Ejercicio 2. Teléfono disponible. Muestra el teléfono del alumno
--- y, cuando sea NULL, el texto "Sin telefono" mediante COALESCE

SELECT matricula, nombre, apellidos,
	COALESCE(telefono, 'Sin teléfono') AS telefono_disponible
FROM academico.alumnos;

--- Ejercicio 3. Resumen reutilizable 
--- Crea una tabla academico_resumen_grupos a partir de una consulta
--- generada y una vista academico.vw_historial_academico con alumno, 
--- materia, periodo y calificación 

-- Creación de tabla mediante consulta 

DROP TABLE IF EXISTS academico.resumen_grupos;
CREATE TABLE academico.resumen_grupos AS
SELECT g.id_grupo, g.clave, COUNT(a.id_alumno) AS total_alumnos
FROM academico.grupos AS g
LEFT JOIN academico.alumnos AS a ON a.id_grupo = g.id_grupo
GROUP BY g.id_grupo, g.clave
ORDER BY g.id_grupo, g.clave ASC;

SELECT * FROM academico.resumen_grupos;

--- Vista previa 

CREATE OR REPLACE VIEW academico.vw_historial_academico AS
SELECT a.matricula, CONCAT(a.nombre, ' ', a.apellidos) AS alumno,
	   m.nombre AS materia, x.periodo, i.calificacion, i.estatus
FROM academico.inscripciones as i
JOIN academico.alumnos AS a ON a.id_alumno = i.id_alumno
JOIN academico.asignaciones AS x ON x.id_asignacion = i.id_asignacion
JOIN academico.materias AS m ON m.id_materia = x.id_materia
ORDER BY alumno;

SELECT * FROM academico.vw_historial_academico;

--- Exportar tablas 

COPY(
	SELECT id_alumno, matricula, nombre, apellidos,
			fecha_nacimiento, sexo, email, telefono,
			fecha_ingreso, beca_porcentaje, id_grupo
	FROM academico.alumnos
)
TO 'E:/SciData/Bases de datos con SQL/alumnos.csv'
WITH CSV HEADER DELIMITER ',';

--- Importación 

CREATE TABLE academico.alumnos (
    id_alumno INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    matricula VARCHAR(12) NOT NULL UNIQUE,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(90) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15) NULL,
    fecha_ingreso DATE NOT NULL DEFAULT CURRENT_DATE,
    beca_porcentaje DECIMAL(5,2) NOT NULL DEFAULT 0,
    id_grupo INT NOT NULL,
    CONSTRAINT CK_alum_sexo CHECK (sexo IN ('F','M','X')),
    CONSTRAINT CK_alum_beca CHECK (beca_porcentaje BETWEEN 0 AND 100),
    CONSTRAINT FK_alum_grupo FOREIGN KEY (id_grupo)
        REFERENCES academico.grupos(id_grupo)
);

COPY academico.alumnos(id_alumno, matricula, nombre, apellidos,
						fecha_nacimiento, sexo, email, telefono,
						fecha_ingreso, beca_porcentaje, id_grupo)
FROM 'E:/SciData/Bases de datos con SQL/alumnos.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

SELECT * FROM academico.alumnos;
							  