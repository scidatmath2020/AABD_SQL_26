--- Bloque. ORDER BY, LIMIT, DISTINCT y ALIAS 

--- Ejercicio 1. Diez salarios mayores. Obtenga los 10 profesores con mayor salario
--- ordenados de mayor a menor.

SELECT nombre, apellidos, salario 
FROM academico.profesores
ORDER BY salario DESC
LIMIT 10;

--- Alternativo: FETCH FIRST combinado con ROWS ONLY

SELECT nombre, apellidos, salario 
FROM academico.profesores
ORDER BY salario DESC
FETCH FIRST 10 ROWS ONLY;

--- Alternativo: FETCH FIRST combinado con ROWS WITH TIES

--- NOTA: WITH TIES respeta aquellos salarios que lleguen a ser igual en varios
--- registros que formen parte de los 10 salarios (únicos) más altos

SELECT nombre, apellidos, salario 
FROM academico.profesores
ORDER BY salario DESC
FETCH FIRST 10 ROWS WITH TIES;

--- Ejercicio 2. Obtenga los profesores con los 10 mayores salarios ordenados por salario
--- más alto y recente contratación 

SELECT nombre, apellidos, salario, fecha_contratacion
FROM academico.profesores
ORDER BY
	salario DESC,
	fecha_contratacion ASC
FETCH FIRST 10 ROWS WITH TIES;

--- Ejercicio 3. Áreas distintas. Consulta la lista de áreas de materias sin repeticiones
--- y en orden alfabético. 

SELECT * FROM academico.materias;

SELECT DISTINCT area
FROM academico.materias
ORDER BY area ASC;

SELECT DISTINCT area, creditos
FROM academico.materias
ORDER BY area ASC;

--- Ejercicio 4. Alias descriptivo. Muestra matrícula como MatriculaEscolar y 
--- beca_porcentaje como Beca, ordenado por Beca descendente

SELECT matricula AS MatriculaEscolar,
	   beca_porcentaje AS Beca
FROM academico.alumnos
ORDER BY Beca DESC;

SELECT * FROM academico.alumnos;

--- Bloque. Uniones con condicionales. 

--- Ejercicio 1. Becarios del turno matutino. Localiza alumnos con becas de al menos
--- 50 que pertenecen a grupos del turno matutino.

SELECT * FROM academico.alumnos;
SELECT * FROM academico.grupos;

--- Lógica del JOIN 

SELECT a.matricula, a.nombre, a.apellidos, a.beca_porcentaje, g.turno
FROM academico.alumnos a
INNER JOIN academico.grupos g 
	ON g.id_grupo = a.id_grupo;

SELECT a.matricula, a.nombre, a.apellidos, a.beca_porcentaje, g.turno
FROM academico.alumnos AS a
INNER JOIN academico.grupos AS g 
	ON g.id_grupo = a.id_grupo;

--- Agregamos la condición después de la unión 

SELECT a.matricula, a.nombre, a.apellidos, a.beca_porcentaje, g.turno
FROM academico.alumnos AS a
INNER JOIN academico.grupos AS g 
	ON g.id_grupo = a.id_grupo
WHERE a.beca_porcentaje >= 50 AND g.turno = 'Matutino';

SELECT a.matricula, a.nombre, a.apellidos, a.beca_porcentaje, g.turno
FROM academico.alumnos AS a
INNER JOIN academico.grupos AS g 
	ON g.id_grupo = a.id_grupo
WHERE a.beca_porcentaje >= 50 AND g.turno = 'Vespertino';

--- Ejercicio 2. Profesores de dos áreas. Muestra profesores activos cuya especialidad
--- sea matemáticas o Ciencias. 

SELECT nombre, apellidos, especialidad 
FROM academico.profesores
WHERE activo IS TRUE
	AND (especialidad = 'Matemáticas' OR especialidad = 'Ciencias');

SELECT nombre, apellidos, especialidad 
FROM academico.profesores
WHERE activo IS TRUE
	AND especialidad IN ('Matemáticas', 'Ciencias');

--- Ejercicio 3. Negación. Obtén materia que no sean del área Artes
--- y que tengan más de 4 créditos. 

SELECT clave, nombre, area, creditos
FROM academico.materias
WHERE NOT area = 'Artes' AND creditos > 4;


--- Bloque. LIKE

--- Ejercicio. Patrón de apellidos. Busca alumnos cuyo apellido comience con Familia 0

SELECT matricula, nombre, apellidos
FROM academico.alumnos
WHERE apellidos LIKE 'Familia 0%'
ORDER BY apellidos ASC;
