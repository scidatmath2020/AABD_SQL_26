-- BASE: gis_cdmx. Ejecutar como administrador tras los archivos 01, 02 y 03.
-- Vista de indicadores: población observada en 2020 y área calculada del MG 2025.
-- LEFT JOIN conserva las alcaldías incluso si no tuvieran puntos.
-- COUNT(p.id_punto) evita contar una fila vacía como si fuera un punto.
CREATE OR REPLACE VIEW gis.v_alcaldias_indicadores AS
SELECT a.cvegeo, a.cve_mun, a.nombre, a.poblacion_2020,
       a.marco_version,
       ST_Area(ST_Transform(a.geom,32614))/1000000.0 AS area_km2,
       COUNT(p.id_punto)::integer AS n_puntos_simulados,
       a.geom
FROM gis.alcaldias a
LEFT JOIN gis.puntos_simulados p ON ST_Covers(a.geom,p.geom)
GROUP BY a.cvegeo;

-- Pares de vecindad sin duplicar A-B y B-A ni comparar una alcaldía consigo misma.
-- ST_Touches detecta contacto en frontera sin superposición de interiores.
CREATE OR REPLACE VIEW gis.v_vecinas AS
SELECT a.cvegeo AS cve_a, a.nombre AS alcaldia_a,
       b.cvegeo AS cve_b, b.nombre AS alcaldia_b
FROM gis.alcaldias a
JOIN gis.alcaldias b ON a.cvegeo < b.cvegeo
 AND ST_Touches(a.geom,b.geom);

-- CUENTA LOCAL DE LECTURA. Reemplazar el marcador por una contraseña propia.
-- Ejecutar CREATE ROLE una sola vez; si ya existe, revisar sus permisos.
CREATE ROLE gis_lector LOGIN PASSWORD 'CAMBIA_ESTA_CLAVE_ANTES_DE_EJECUTAR'
 NOSUPERUSER NOCREATEDB NOCREATEROLE;
GRANT CONNECT ON DATABASE gis_cdmx TO gis_lector;
GRANT USAGE ON SCHEMA gis TO gis_lector;
GRANT SELECT ON gis.alcaldias, gis.puntos_simulados,
 gis.v_alcaldias_indicadores, gis.v_vecinas TO gis_lector;
-- No se conceden INSERT, UPDATE, DELETE ni permisos administrativos.
