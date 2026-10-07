-- ENUT 2024 | 36 ejercicios intermedios y 12 indicadores
-- Ejecutar antes S13_preparar_practicas_ENUT.sql. Resolver UN ejercicio a la vez.
-- Los ejercicios de objetos siguen el orden numérico.


-- EJERCICIO 01 Normalizar una etiqueta y revisar claves
-- Limpia la etiqueta de la fuente y compara los dos primeros caracteres de la llave de vivienda con la entidad. Conserva los ceros iniciales.

SELECT llaveviv, cve_ent,
       LOWER(TRIM('  ENUT 2024  ')) AS fuente,
       LEFT(llaveviv,2) AS entidad_en_llave,
       LEFT(llaveviv,2) = cve_ent AS coincide
FROM enut.tvivienda
ORDER BY llaveviv LIMIT 10;

-- EJERCICIO 02 Convertir edades sin confundir códigos
-- Compara el código original con la edad numérica. Cuenta cuántos registros tienen edad exacta, 97 años y más o edad desconocida.

SELECT COUNT(*) AS muestra,
       COUNT(edad) AS edad_exacta,
       COUNT(*) FILTER (WHERE edad_codigo='97') AS edad_97_mas,
       COUNT(*) FILTER (WHERE edad_codigo='98') AS edad_desconocida
FROM analisis.personas;
-- El código 97 es un intervalo abierto y 98 significa no sabe. La vista no los trata como edades exactas. No se excluyen de los indicadores de toda la población de 12 años y más.

-- EJERCICIO 03 Agrupar una bitácora por mes
-- Suma las filas de la bitácora ficticia por mes usando DATE_TRUNC y calcula los días desde cada fecha hasta el 30 de noviembre de 2026.

SELECT DATE_TRUNC('month',fecha)::date AS mes,
       SUM(filas) AS filas
FROM laboratorio.bitacora GROUP BY 1 ORDER BY 1;
SELECT id, fecha, DATE '2026-11-30'-fecha AS dias
FROM laboratorio.bitacora ORDER BY id;
-- Los meses describen eventos de práctica, no cambios del uso del tiempo.

-- EJERCICIO 04 Hogares con mujeres o con hombres
-- Obtén las llaves de hogares con al menos una mujer o al menos un hombre, sin duplicados.

SELECT llavehog FROM enut.tsdem WHERE sexo='2'
UNION
SELECT llavehog FROM enut.tsdem WHERE sexo='1'
ORDER BY llavehog;

-- EJERCICIO 05 Hogares con ambos sexos
-- Obtén hogares que tienen por lo menos una mujer y un hombre.

SELECT llavehog FROM enut.tsdem WHERE sexo='2'
INTERSECT
SELECT llavehog FROM enut.tsdem WHERE sexo='1'
ORDER BY llavehog;

-- EJERCICIO 06 Hogares con mujeres y sin hombres
-- Resta al conjunto de hogares con mujeres el conjunto de hogares con hombres.

SELECT llavehog FROM enut.tsdem WHERE sexo='2'
EXCEPT
SELECT llavehog FROM enut.tsdem WHERE sexo='1'
ORDER BY llavehog;
-- EXCEPT no elimina registros de las tablas. El orden de los conjuntos cambia la respuesta.

-- EJERCICIO 07 Integrantes por hogar
-- Cuenta integrantes en TSDEM y agrega ese conteo a cada hogar sin multiplicar las filas de THOGAR.

WITH integrantes AS (
 SELECT llavehog, COUNT(*) AS n
 FROM enut.tsdem GROUP BY llavehog
)
SELECT h.llavehog, h.cve_ent, COALESCE(i.n,0) AS integrantes
FROM enut.thogar h
LEFT JOIN integrantes i USING (llavehog)
ORDER BY integrantes DESC,h.llavehog;

-- EJERCICIO 08 Hogares por encima del tamaño medio
-- Usa dos CTE para encontrar hogares con más integrantes que la media de hogares observados.

WITH tamanos AS (
 SELECT llavehog, COUNT(*) AS n
 FROM enut.tsdem GROUP BY llavehog
), media AS (SELECT AVG(n) AS valor FROM tamanos)
SELECT t.* FROM tamanos t CROSS JOIN media m
WHERE t.n > m.valor ORDER BY t.n DESC,t.llavehog;
-- Es una media muestral no ponderada; no representa por sí sola el tamaño medio nacional.

-- EJERCICIO 09 Cobertura del módulo por hogar
-- Compara cuántas personas figuran en TSDEM y en TMODULO por hogar, agregando antes de unir.

WITH s AS (
 SELECT llavehog,COUNT(*) AS residentes
 FROM enut.tsdem GROUP BY llavehog
), m AS (
 SELECT llavehog,COUNT(*) AS modulo
 FROM enut.tmodulo GROUP BY llavehog
)
SELECT s.llavehog,s.residentes,COALESCE(m.modulo,0) AS modulo,
       s.residentes-COALESCE(m.modulo,0) AS diferencia
FROM s LEFT JOIN m USING (llavehog)
ORDER BY s.llavehog;
-- La diferencia no equivale automáticamente a falta de respuesta: TSDEM incluye menores de 12 años y el módulo tiene otro universo.

-- EJERCICIO 10 Comparar tres tipos de rango
-- Ordena personas por horas domésticas dentro de cada entidad con ROW_NUMBER, RANK y DENSE_RANK.

SELECT llavemod,cve_ent,h_dom,
 ROW_NUMBER() OVER (
  PARTITION BY cve_ent ORDER BY h_dom DESC,llavemod) AS fila,
 RANK() OVER (
  PARTITION BY cve_ent ORDER BY h_dom DESC) AS rango,
 DENSE_RANK() OVER (
  PARTITION BY cve_ent ORDER BY h_dom DESC) AS rango_denso
FROM analisis.personas WHERE h_dom IS NOT NULL
ORDER BY cve_ent,fila;
-- Solo ROW_NUMBER usa la llave para desempatar. RANK deja saltos en los empates y DENSE_RANK no.

-- EJERCICIO 11 Comparar con la media de la muestra
-- Muestra las horas domésticas y su diferencia respecto de la media muestral de cada sexo.

SELECT llavemod,sexo,h_dom,
 ROUND(AVG(h_dom) OVER (PARTITION BY sexo),2) AS media,
 ROUND(h_dom-AVG(h_dom) OVER (PARTITION BY sexo),2) AS diferencia
FROM analisis.personas WHERE h_dom IS NOT NULL
ORDER BY sexo,llavemod;
-- AVG no utiliza FAC_PER. En la segunda parte se construyen medias ponderadas.

-- EJERCICIO 12 Seleccionar dos personas por entidad
-- Usa una CTE con ROW_NUMBER para seleccionar los dos registros con más horas domésticas en cada entidad.

WITH posiciones AS (
 SELECT llavemod,cve_ent,h_dom,
 ROW_NUMBER() OVER (
  PARTITION BY cve_ent ORDER BY h_dom DESC,llavemod) AS pos
 FROM analisis.personas WHERE h_dom IS NOT NULL
)
SELECT * FROM posiciones WHERE pos<=2 ORDER BY cve_ent,pos;

-- EJERCICIO 13 Comparar cargas mensuales
-- Agrupa las cargas por mes y calcula la variación porcentual respecto del mes anterior.

WITH meses AS (
 SELECT DATE_TRUNC('month',fecha)::date AS mes,SUM(filas) AS n
 FROM laboratorio.bitacora GROUP BY 1
), cambios AS (
 SELECT *,LAG(n) OVER (ORDER BY mes) AS anterior FROM meses
)
SELECT mes,n,anterior,
 ROUND(100.0*(n-anterior)/NULLIF(anterior,0),2) AS variacion
FROM cambios ORDER BY mes;
-- El primer mes tiene variación NULL. Los tres meses de la bitácora son consecutivos.

-- EJERCICIO 14 Tiempo hasta la siguiente carga
-- Calcula los días hasta el siguiente evento con LEAD.

SELECT id,fecha,
 LEAD(fecha) OVER (ORDER BY fecha,id) AS siguiente,
 LEAD(fecha) OVER (ORDER BY fecha,id)-fecha AS dias
FROM laboratorio.bitacora ORDER BY fecha,id;

-- EJERCICIO 15 Acumular registros cargados
-- Calcula el total acumulado de filas de la bitácora con una ventana explícita.

SELECT id,fecha,filas,
 SUM(filas) OVER (ORDER BY fecha,id
 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS acumulado
FROM laboratorio.bitacora ORDER BY fecha,id;

-- EJERCICIO 16 Conteos condicionales
-- Cuenta por entidad los registros con horas domésticas positivas, cero y faltantes.

SELECT cve_ent,COUNT(*) AS muestra,
 COUNT(*) FILTER (WHERE h_dom>0) AS positivos,
 COUNT(*) FILTER (WHERE h_dom=0) AS ceros,
 COUNT(*) FILTER (WHERE h_dom IS NULL) AS faltantes
FROM analisis.personas GROUP BY cve_ent ORDER BY cve_ent;

-- EJERCICIO 17 Subtotales por entidad y sexo
-- Construye conteos con subtotales de entidad y total general. Distingue los totales con GROUPING.

SELECT cve_ent,sexo,GROUPING(cve_ent) AS total_general,
 GROUPING(sexo) AS subtotal,COUNT(*) AS muestra
FROM analisis.personas
GROUP BY ROLLUP(cve_ent,sexo)
ORDER BY cve_ent NULLS LAST,sexo NULLS LAST;

-- EJERCICIO 18 Mediana y dispersión
-- Calcula mediana, desviación estándar y promedio muestral de horas domésticas por sexo.

SELECT sexo,COUNT(h_dom) AS n,
 ROUND(AVG(h_dom),2) AS media,
 PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY h_dom) AS mediana,
 ROUND(STDDEV_SAMP(h_dom),2) AS desviacion
FROM analisis.personas GROUP BY sexo ORDER BY sexo;
-- PERCENTILE_CONT y STDDEV_SAMP no incorporan FAC_PER. La desviación no es el error estándar del estimador de encuesta.

-- EJERCICIO 19 Actualizar una etiqueta existente
-- Intenta insertar el código 01 y actualiza su nombre cuando ya exista.

BEGIN;
INSERT INTO laboratorio.catalogo VALUES ('01','Aguascalientes revisado')
ON CONFLICT (codigo) DO UPDATE SET nombre=EXCLUDED.nombre
RETURNING *;
ROLLBACK;

-- EJERCICIO 20 Ignorar una clave duplicada
-- Inserta el código 01 y evita modificar el registro cuando exista un conflicto.

BEGIN;
INSERT INTO laboratorio.catalogo VALUES ('01','Otra etiqueta')
ON CONFLICT (codigo) DO NOTHING;
SELECT * FROM laboratorio.catalogo WHERE codigo='01';
ROLLBACK;

BEGIN;

INSERT INTO laboratorio.catalogo (codigo, nombre)
VALUES ('01','Otra etiqueta')
ON CONFLICT (codigo) 
DO UPDATE SET nombre = EXCLUDED.nombre;
SELECT * FROM laboratorio.catalogo WHERE codigo='01';

ROLLBACK;

SELECT * FROM laboratorio.catalogo;

-- EJERCICIO 21 Completar solo etiquetas vacías
-- Deja temporalmente vacío el nombre y usa ON CONFLICT con WHERE para completarlo.

BEGIN;
UPDATE laboratorio.catalogo SET nombre='' WHERE codigo='01';
INSERT INTO laboratorio.catalogo VALUES ('01','Aguascalientes')
ON CONFLICT (codigo) DO UPDATE SET nombre=EXCLUDED.nombre
WHERE TRIM(laboratorio.catalogo.nombre)=''
RETURNING *;
ROLLBACK;

-- EJERCICIO 22 Deshacer solo el segundo cambio
-- Asigna prioridad 1 y luego 2. Revierte el segundo cambio con SAVEPOINT y comprueba que queda 1 antes del ROLLBACK final.

BEGIN;
UPDATE laboratorio.hogares SET prioridad=1
WHERE llavehog='0100094011';
SAVEPOINT cambio_uno;
UPDATE laboratorio.hogares SET prioridad=2
WHERE llavehog='0100094011';
ROLLBACK TO SAVEPOINT cambio_uno;
SELECT * FROM laboratorio.hogares WHERE llavehog='0100094011';
ROLLBACK;

-- EJERCICIO 23 Revisar antes de confirmar
-- Agrega una nota a los hogares de Aguascalientes y revisa las filas afectadas con RETURNING. Revierte la práctica.

BEGIN;
UPDATE laboratorio.hogares SET nota='Revisión de práctica'
WHERE cve_ent='01'
RETURNING llavehog,cve_ent,nota;
ROLLBACK;

SELECT * FROM laboratorio.hogares
WHERE cve_ent='01';

-- EJERCICIO 24 Observar bloqueo entre sesiones
-- Abre dos Query Tool independientes. Ejecuta A sin su ROLLBACK; luego B. B espera y cancela por el tiempo límite. Termina con ROLLBACK en ambas sesiones.

-- -- SESIÓN A
-- BEGIN;
-- UPDATE laboratorio.hogares SET prioridad=1
-- WHERE llavehog='0100094011';
-- -- Ejecutar al finalizar la observación:
-- ROLLBACK;
-- 
-- -- SESIÓN B, mientras A mantiene la transacción abierta
-- BEGIN;
-- SET LOCAL lock_timeout='3s';
-- UPDATE laboratorio.hogares SET prioridad=2
-- WHERE llavehog='0100094011';
-- -- Tras el error de tiempo de espera:
-- ROLLBACK;
-- No ejecutar todo de una sola vez: los bloques pertenecen a dos conexiones.

