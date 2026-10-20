-- BASE: gis_cdmx. Requisito: 16 alcaldías cargadas.
-- Genera 3, 4, 5 y 6 puntos sucesivamente por clave; total 72.
-- La semilla permite repetir la generación en el mismo entorno PostGIS.
-- Las posiciones pueden variar entre versiones; los conteos son el control estable.
BEGIN;
WITH ordenadas AS (
 SELECT *, row_number() OVER (ORDER BY cvegeo)::integer AS orden
 FROM gis.alcaldias
), generados AS (
 SELECT a.cvegeo, d.path[1] AS numero,
        ST_Transform(d.geom,4326) AS geom
 FROM ordenadas a
 CROSS JOIN LATERAL ST_Dump(
   ST_GeneratePoints(ST_Transform(a.geom,32614),
     3 + ((a.orden-1) % 4), 2026 + a.cve_mun::integer)
 ) AS d
)
INSERT INTO gis.puntos_simulados(etiqueta,cvegeo_origen,tipo,geom)
SELECT 'SIM_' || cvegeo || '_' || numero,
       cvegeo,
       CASE (numero-1) % 3
         WHEN 0 THEN 'Salud simulada'
         WHEN 1 THEN 'Educación simulada'
         ELSE 'Abasto simulado'
       END, geom
FROM generados
ON CONFLICT (etiqueta) DO UPDATE SET
 cvegeo_origen=EXCLUDED.cvegeo_origen,
 tipo=EXCLUDED.tipo, geom=EXCLUDED.geom;
COMMIT;
ANALYZE gis.puntos_simulados;
SELECT COUNT(*) AS puntos_simulados FROM gis.puntos_simulados;
