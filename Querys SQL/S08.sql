--- Bloque JOIN y producto cartesiano 
--- NOTA: Se puede traducir como: Si la tabla A tiene N filas y la B tiene
--- M filas, el producto cartesiano devolerá N x M filas. 

--- Ejercicio 1. Horario completo. Muestra periodo, grupo, materia, profesor
--- aula y horario de cada asignación. 

SELECT x.periodo, g.clave AS grupo, m.nombre AS materia,
		CONCAT(p.nombre,' ', p.apellidos) AS profesor, x.aula, x.horario
FROM academico.asignaciones AS x
JOIN academico.grupos AS g ON g.id_grupo = x.id_grupo
JOIN academico.materias AS m ON m.id_materia = x.id_materia
JOIN academico.profesores AS p ON p.id_profesor = x.id_profesor
ORDER BY profesor ASC;

--- Ejercicio 2. Producto cartesiano controlado. Genera todas las combinaciones
--- entre las primeras cinco materias y los primeros tres grupos; anticipa
--- el número de filas 

SELECT m.clave AS materia, g.clave AS grupo
FROM (SELECT * FROM academico.materias ORDER BY id_materia LIMIT 5) AS m
CROSS JOIN (SELECT * FROM academico.grupos ORDER BY id_grupo LIMIT 3) AS g;

--- Bloque. Autorrelaciones. 

--- Ejercicio 1. Profesor y supervisor. Muestra cada profesor que tenga 
--- suprevisor junto con el nombre de éste

SELECT CONCAT(p.nombre, ' ', p.apellidos) AS profesor,
	   CONCAT(s.nombre, ' ', s.apellidos) AS supervisor
FROM academico.profesores AS p
JOIN academico.profesores AS s ON s.id_profesor = p.id_supervisor
ORDER BY supervisor ASC;

SELECT CONCAT(s.nombre, ' ', s.apellidos) AS supervisor,
	   COUNT(p.id_profesor) AS total_profesores
FROM academico.profesores AS p
JOIN academico.profesores AS s ON s.id_profesor = p.id_supervisor
GROUP BY s.id_profesor, s.nombre, s.apellidos
ORDER BY total_profesores DESC, supervisor ASC;

--- Ejercicio 2. Supervisores sin subordinados. Encuentra profesores
--- que no supervisen a nadie 

SELECT p.id_profesor, p.nombre, p.apellidos, p.id_supervisor,
CASE 
	WHEN p.id_supervisor IS NULL THEN 'Supervisor'
	ELSE 'Profesor'
END AS rol_jerarquico
FROM academico.profesores AS p
WHERE NOT EXISTS (SELECT 1 FROM academico.profesores AS h
				  WHERE h.id_supervisor = p.id_profesor);

--- Bloque. Subconsultas. 

--- Ejercicio 1. Salario máximo. Obtén el profesor o profesores
--- cuyo salario sea igual al salario máximo 

--- Subconsulta básica 

SELECT nombre, apellidos, salario
FROM academico.profesores
WHERE salario = (SELECT MAX(salario) FROM academico.profesores);

--- Subconsulta tradicional 

WITH SalarioMaximo AS(
	SELECT MAX(salario) AS max_salario
	FROM academico.profesores
)
SELECT p.nombre, p.apellidos, p.salario
FROM academico.profesores AS p
JOIN SalarioMaximo AS sm ON p.salario = sm.max_salario;

WITH SalarioMaximo AS(
	SELECT MAX(salario) AS max_salario
	FROM academico.profesores
)
SELECT * FROM SalarioMaximo;

--- Ejercicio 2. Varianza del salario. 

WITH PromedioSalarios AS(
	SELECT AVG(salario) AS media_salario
	FROM academico.profesores
)
SELECT
	SUM(POWER(p.salario-ps.media_salario,2))/(COUNT(p.salario)-1) AS Varianza_m
FROM academico.profesores AS p
CROSS JOIN PromedioSalarios as ps;

WITH VarianzaSalarios AS (
	SELECT VARIANCE(salario) AS varianza_muestra
	FROM academico.profesores
)
SELECT varianza_muestra FROM VarianzaSalarios;