-- EJERCICIO 25 Función de integrantes por hogar
-- Crea una función SQL que reciba la llave de hogar y devuelva el número de integrantes registrados en TSDEM.

CREATE OR REPLACE FUNCTION laboratorio.integrantes(p_hogar text)
RETURNS bigint LANGUAGE sql STABLE AS $$
 SELECT COUNT(*) FROM enut.tsdem WHERE llavehog=p_hogar;
$$;
SELECT laboratorio.integrantes('0100094011');

-- EJERCICIO 26 Clasificar horas con IF
-- Crea una clasificación didáctica: sin dato, sin horas, hasta 20 o más de 20 horas domésticas. No es un clasificador oficial.

CREATE OR REPLACE FUNCTION laboratorio.clase_horas(h numeric)
RETURNS text LANGUAGE plpgsql IMMUTABLE AS $$
BEGIN
 IF h IS NULL THEN RETURN 'Sin dato';
 ELSIF h=0 THEN RETURN 'Sin horas';
 ELSIF h<=20 THEN RETURN 'Hasta 20';
 ELSE RETURN 'Más de 20'; END IF;
END;
$$;
SELECT llavemod,laboratorio.clase_horas(h_dom) AS clase
FROM analisis.personas ORDER BY llavemod LIMIT 10;

-- EJERCICIO 27 Procedimiento para prioridad
-- Crea un procedimiento que valide una prioridad entre 0 y 5 y la asigne a un hogar de laboratorio.

CREATE OR REPLACE PROCEDURE laboratorio.asignar_prioridad(
 p_hogar text,p_prioridad integer)
LANGUAGE plpgsql AS $$
BEGIN
 IF p_prioridad IS NULL OR p_prioridad NOT BETWEEN 0 AND 5 THEN
  RAISE EXCEPTION 'Prioridad inválida';
 END IF;
 UPDATE laboratorio.hogares SET prioridad=p_prioridad
 WHERE llavehog=p_hogar;
 IF NOT FOUND THEN RAISE EXCEPTION 'Hogar inexistente'; END IF;
END;
$$;
BEGIN;
CALL laboratorio.asignar_prioridad('0100094011',3);
SELECT * FROM laboratorio.hogares WHERE llavehog='0100094011';
ROLLBACK;

-- EJERCICIO 28 Crear una auditoría
-- Crea la tabla que guardará la llave, la prioridad anterior y nueva, el usuario y la fecha del cambio.

CREATE TABLE laboratorio.auditoria (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 llavehog text NOT NULL,antes integer,despues integer,
 usuario text NOT NULL DEFAULT CURRENT_USER,
 fecha timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- EJERCICIO 29 Registrar automáticamente los cambios
-- Crea la función y el trigger que insertan en auditoría cuando cambia la prioridad.

CREATE OR REPLACE FUNCTION laboratorio.auditar_prioridad()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
 INSERT INTO laboratorio.auditoria(llavehog,antes,despues)
 VALUES (NEW.llavehog,OLD.prioridad,NEW.prioridad);
 RETURN NEW;
END;
$$;
CREATE TRIGGER tr_prioridad AFTER UPDATE OF prioridad
ON laboratorio.hogares FOR EACH ROW
WHEN (OLD.prioridad IS DISTINCT FROM NEW.prioridad)
EXECUTE FUNCTION laboratorio.auditar_prioridad();

-- EJERCICIO 30 Comprobar la reversión de la auditoría
-- Actualiza una prioridad, consulta la auditoría dentro de la transacción y revierte. Compara su conteo antes y después.

SELECT COUNT(*) FROM laboratorio.auditoria;
BEGIN;
UPDATE laboratorio.hogares SET prioridad=4
WHERE llavehog='0100094011';
SELECT * FROM laboratorio.auditoria ORDER BY id DESC LIMIT 5;
ROLLBACK;
SELECT COUNT(*) FROM laboratorio.auditoria;
-- El cambio y el evento se revierten juntos. La secuencia de la identidad puede dejar huecos.

-- EJERCICIO 31 Medir antes del índice
-- Crea una copia analítica y examina el plan de una búsqueda por entidad.

CREATE TABLE laboratorio.personas AS SELECT * FROM analisis.personas;
ANALYZE laboratorio.personas;
EXPLAIN (ANALYZE,BUFFERS)
SELECT * FROM laboratorio.personas WHERE cve_ent='01';

-- EJERCICIO 32 Agregar un índice simple
-- Crea un índice por entidad y compara el plan con el anterior.

CREATE INDEX idx_lab_entidad ON laboratorio.personas(cve_ent);
ANALYZE laboratorio.personas;
EXPLAIN (ANALYZE,BUFFERS)
SELECT * FROM laboratorio.personas WHERE cve_ent='01';
-- El planificador puede preferir una lectura secuencial; crear un índice no obliga a utilizarlo.

-- EJERCICIO 33 Diseñar un índice compuesto
-- Optimiza una selección por entidad y sexo ordenada por horas domésticas, con desempate por llave.

CREATE INDEX idx_lab_ent_sexo_horas ON laboratorio.personas
 (cve_ent,sexo,h_dom DESC,llavemod);
ANALYZE laboratorio.personas;
EXPLAIN (ANALYZE,BUFFERS)
SELECT llavemod,h_dom FROM laboratorio.personas
WHERE cve_ent='01' AND sexo='2'
ORDER BY h_dom DESC,llavemod LIMIT 20;

-- EJERCICIO 34 Crear un rol de lectura
-- Crea un rol de grupo sin LOGIN y otorga lectura de las tablas originales y de las vistas analíticas.

CREATE ROLE rol_enut_lectura NOLOGIN;
GRANT CONNECT ON DATABASE "ENUT2024" TO rol_enut_lectura;
GRANT USAGE ON SCHEMA enut,analisis TO rol_enut_lectura;
GRANT SELECT ON ALL TABLES IN SCHEMA enut,analisis
TO rol_enut_lectura;
-- Ejecutar una vez con un administrador. Un usuario de conexión debe tener LOGIN y recibir este rol.

-- EJERCICIO 35 Privilegios futuros y revocación
-- Configura SELECT para nuevos objetos creados por el usuario que ejecuta el bloque. Quita temporalmente la lectura de THOGAR y revierte.

ALTER DEFAULT PRIVILEGES IN SCHEMA enut,analisis
GRANT SELECT ON TABLES TO rol_enut_lectura;
BEGIN;
REVOKE SELECT ON enut.thogar FROM rol_enut_lectura;
SELECT has_table_privilege('rol_enut_lectura',
 'enut.thogar','SELECT') AS puede_leer;
ROLLBACK;
-- Los privilegios por defecto solo afectan objetos futuros del rol creador. Para otro propietario usar FOR ROLE nombre_propietario.

-- EJERCICIO 36 Respaldar y restaurar una copia
-- En terminal crea un respaldo Custom y restáuralo en ENUT2024_prueba. Revisa los cinco conteos antes de dar por válido el respaldo.

-- pg_dump -h localhost -p 5432 -U postgres -W -Fc   -d ENUT2024 -f ENUT2024.backup
-- createdb -h localhost -p 5432 -U postgres -W ENUT2024_prueba
-- pg_restore -h localhost -p 5432 -U postgres -W   --no-owner --no-privileges --exit-on-error   -d ENUT2024_prueba ENUT2024.backup
-- Cada comando es una sola línea en terminal; los saltos visuales no deben copiarse como comandos separados. Usar herramientas compatibles con la versión del servidor. En pgAdmin: Backup formato Custom y Restore sobre una base vacía. Los roles globales se crean aparte.

-- EJERCICIO 37 Estimar viviendas
-- Calcula viviendas observadas y estimadas usando TVIVIENDA. Universo: viviendas representadas por el archivo. Factor: FAC_VIV.

SELECT COUNT(*) AS n_muestra,SUM(fac_viv) AS viviendas_estimadas
FROM enut.tvivienda WHERE fac_viv>0;
-- Numerador: suma de FAC_VIV; no hay denominador. No equivale al total de toda clase de vivienda existente en el país.

-- EJERCICIO 38 Estimar hogares por entidad
-- Obtén el número de hogares observado y expandido por entidad usando una fila por hogar.

SELECT cve_ent,COUNT(*) AS n_muestra,SUM(fac_hog) AS hogares
FROM enut.thogar WHERE fac_hog>0
GROUP BY cve_ent ORDER BY cve_ent;
-- Unidad: hogar. Factor: FAC_HOG. No uses FAC_PER para contar hogares.

-- EJERCICIO 39 Estimar población por sexo
-- Suma FAC_PER por sexo en TVAR_CREA y conserva el número de observaciones. Universo: población representada de 12 años y más.

SELECT sexo,COUNT(*) AS n_muestra,SUM(fac_per) AS personas
FROM analisis.personas WHERE fac_per>0 AND sexo IN ('1','2')
GROUP BY sexo ORDER BY sexo;
-- No combines TMODULO y TVAR_CREA con UNION ALL: representan a las mismas personas. TSDEM contiene FAC_HOG y tiene otra cobertura.

-- EJERCICIO 40 Hogares con internet
-- Estima el porcentaje de hogares con internet entre hogares con respuesta 1 o 2 en P2_4_13. Usa FAC_HOG.

SELECT COUNT(*) AS n_valido,
 SUM(fac_hog) AS hogares_validos,
 SUM(CASE WHEN p2_4_13='1' THEN fac_hog ELSE 0 END) AS con_internet,
 ROUND(100.0*SUM(CASE WHEN p2_4_13='1' THEN fac_hog ELSE 0 END)
       /NULLIF(SUM(fac_hog),0),2) AS porcentaje
FROM enut.thogar WHERE fac_hog>0 AND p2_4_13 IN ('1','2');
-- Sí = 1; no = 2. Las respuestas faltantes se excluyen de ambos componentes, no se convierten en no.

-- EJERCICIO 41 Viviendas con electricidad
-- Calcula el porcentaje ponderado de viviendas con electricidad por entidad, con FAC_VIV y P1_11 válido.

SELECT cve_ent,COUNT(*) AS n_valido,
 SUM(fac_viv) AS viviendas_validas,
 ROUND(100.0*SUM(CASE WHEN p1_11='1' THEN fac_viv ELSE 0 END)
       /NULLIF(SUM(fac_viv),0),2) AS porcentaje
FROM enut.tvivienda WHERE fac_viv>0 AND p1_11 IN ('1','2')
GROUP BY cve_ent ORDER BY cve_ent;

-- EJERCICIO 42 Participación en trabajo doméstico
-- Calcula por sexo la proporción expandida con horas domésticas positivas. Definición operativa del ejercicio: h_dom > 0 entre registros con h_dom válido.

SELECT sexo,COUNT(*) AS n_valido,SUM(fac_per) AS poblacion_valida,
 SUM(CASE WHEN h_dom>0 THEN fac_per ELSE 0 END) AS participantes,
 ROUND(100.0*SUM(CASE WHEN h_dom>0 THEN fac_per ELSE 0 END)
       /NULLIF(SUM(fac_per),0),2) AS tasa
FROM analisis.personas
WHERE fac_per>0 AND h_dom>=0 AND sexo IN ('1','2')
GROUP BY sexo ORDER BY sexo;
-- Una actividad declarada sin tiempo cuantificado puede requerir otro criterio oficial. Aquí se estima participación con tiempo positivo; no se afirma una réplica automática del tabulado oficial.

-- EJERCICIO 43 Promedio entre toda la población válida
-- Estima por sexo la media de horas domésticas incluyendo ceros. Muestra ambos componentes del cociente.

SELECT sexo,COUNT(*) AS n_valido,
 SUM(h_dom*fac_per) AS horas_expandidas,
 SUM(fac_per) AS personas_validas,
 ROUND(SUM(h_dom*fac_per)/NULLIF(SUM(fac_per),0),2) AS media
FROM analisis.personas
WHERE fac_per>0 AND h_dom>=0 AND sexo IN ('1','2')
GROUP BY sexo ORDER BY sexo;
-- Interpretación: horas semanales por persona del universo válido, incluidas quienes registran cero.

-- EJERCICIO 44 Promedio entre participantes
-- Repite el indicador anterior restringiendo a h_dom > 0 y compara con el promedio que incluye ceros.

SELECT sexo,COUNT(*) AS n_participantes,
 SUM(h_dom*fac_per) AS horas_expandidas,
 SUM(fac_per) AS personas_participantes,
 ROUND(SUM(h_dom*fac_per)/NULLIF(SUM(fac_per),0),2) AS media
FROM analisis.personas
WHERE fac_per>0 AND h_dom>0 AND sexo IN ('1','2')
GROUP BY sexo ORDER BY sexo;
-- El promedio oficial de tiempo se refiere a quienes realizaron la actividad. En esta práctica se operacionaliza participación con horas positivas y debe cotejarse con el tratamiento oficial de casos especiales.

-- EJERCICIO 45 Horas de cuidado según discapacidad
-- Calcula el promedio de cuidado entre participantes por condición de discapacidad de la persona informante, usando h_cuid y FAC_PER.

SELECT cond_disc,COUNT(*) AS n_participantes,
 SUM(fac_per) AS personas_participantes,
 ROUND(SUM(h_cuid*fac_per)/NULLIF(SUM(fac_per),0),2) AS media
FROM analisis.personas
WHERE fac_per>0 AND h_cuid>0 AND cond_disc IN ('1','2')
GROUP BY cond_disc ORDER BY cond_disc;
-- COND_DISC caracteriza a quien realiza la actividad, no a la persona receptora del cuidado. H_CUID proviene de TRAB_NO_REM_CUID_HOG, sin cuidados pasivos y con cuidados emocionales según el descriptor.

-- EJERCICIO 46 Brecha de horas domésticas
-- Calcula la media de participantes por sexo sin redondeo intermedio y resta hombres a mujeres.

WITH medias AS (
 SELECT sexo,SUM(h_dom*fac_per)/NULLIF(SUM(fac_per),0) AS media
 FROM analisis.personas
 WHERE fac_per>0 AND h_dom>0 AND sexo IN ('1','2')
 GROUP BY sexo
)
SELECT ROUND(MAX(media) FILTER (WHERE sexo='2'),2) AS mujeres,
 ROUND(MAX(media) FILTER (WHERE sexo='1'),2) AS hombres,
 ROUND(MAX(media) FILTER (WHERE sexo='2')-
       MAX(media) FILTER (WHERE sexo='1'),2) AS brecha_horas
FROM medias;
-- Unidad: horas semanales, no porcentaje ni puntos porcentuales. Signo positivo: mayor media entre las mujeres participantes.

-- EJERCICIO 47 Participación femenina en el volumen de horas
-- Estima qué porcentaje del volumen expandido de horas domésticas corresponde a mujeres.

SELECT SUM(h_dom*fac_per) AS horas_totales,
 SUM(CASE WHEN sexo='2' THEN h_dom*fac_per ELSE 0 END) AS horas_mujeres,
 ROUND(100.0*SUM(CASE WHEN sexo='2' THEN h_dom*fac_per ELSE 0 END)
       /NULLIF(SUM(h_dom*fac_per),0),2) AS porcentaje_mujeres
FROM analisis.personas
WHERE fac_per>0 AND h_dom>=0 AND sexo IN ('1','2');
-- El denominador son horas expandidas, no personas. Este indicador es distinto de la tasa de participación femenina.

-- EJERCICIO 48 Reconstruir el promedio nacional desde dominios
-- Obtén componentes por tamaño de localidad y reconstruye la media nacional de participantes. Contrasta con promediar las dos medias sin ponderación.

WITH dominios AS (
 SELECT menor10,SUM(h_dom*fac_per) AS horas,SUM(fac_per) AS personas
 FROM analisis.personas
 WHERE fac_per>0 AND h_dom>0 AND menor10 IN ('1','2')
 GROUP BY menor10
)
SELECT ROUND(SUM(horas)/NULLIF(SUM(personas),0),2) AS media_correcta,
 ROUND(AVG(horas/NULLIF(personas,0)),2) AS media_de_medias
FROM dominios;
-- MENOR10: 1 = menos de 10 mil habitantes; 2 = 10 mil y más. La media nacional se reconstruye con sumas de componentes. No se interpreta este corte como rural urbano de 2500 habitantes.
