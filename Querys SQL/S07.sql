---- Bloque de funciones de agregado.

---- EJERCICIO 1: Promedios y extremos
---- Calcula el salario promedio, minimo maximo del profesor activo.

SELECT AVG(salario) AS salario_promedio,
MIN(salario) AS salario_minimo,
MAX(salario) AS salario_maximo
FROM academico.profesores WHERE activo IS TRUE;

--- Ejercicio 2. Promedios y extremos. Calcula salario promedio,
--- mínimo, máximo del profesor activo según su especialidad.

SELECT especialidad,
AVG(salario) AS salario_promedio,
MIN(salario) AS salario_minimo,
MAX(salario) AS salario_maximo
FROM academico.profesores WHERE activo IS TRUE
GROUP BY especialidad;

--- EJERCICIO3. indiciador academico. calcula el promedio de calificacion
--- suma de asistencia y numerico de inscripciones calificadas

SELECT AVG(calificacion) AS promedio,
SUM(asistencias) AS suma_asistencias,
COUNT(calificacion) AS calificadas
FROM academico.inscripciones;

--- bloque Group by y having

--- Ejercicio 1. Salario por especialidad.
--- Calcula salario promedio por especialidad y conserva solo promedios mayores a 25K

SELECT especialidad,
AVG(salario) AS salario_promedio
FROM academico.profesores
GROUP BY especialidad
HAVING AVG (salario) > 28000;

---ejercicio 2 Rendimiento por materia. calcula calificacione promedio
--- por materia y conserva materia con al menos dos inscripciones calificacdas

SELECT m.clave, m.nombre, AVG(i.calificacion) AS promedio,
COUNT(i.calificacion) AS calificaciones
FROM academico.materias AS m
JOIN academico.asignaciones AS x ON x.id_materia = m.id_materia
JOIN academico.inscripciones AS i ON i.id_asignacion = x.id_asignacion
GROUP BY m.clave, m.nombre
HAVING COUNT(i.calificacion)>=4;
