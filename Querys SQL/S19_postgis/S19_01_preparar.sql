-- CONEXIÓN: base gis_cdmx, usuario postgres o administrador equivalente.
-- Instalar primero PostGIS en el equipo SERVIDOR. Ejecutar una vez.
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE SCHEMA IF NOT EXISTS gis;

-- Una fila por alcaldía. VARCHAR conserva las claves con ceros iniciales.
CREATE TABLE gis.alcaldias (
    cvegeo VARCHAR(5) PRIMARY KEY CHECK (cvegeo ~ '^09[0-9]{3}$'),
    cve_mun VARCHAR(3) NOT NULL UNIQUE,
    nombre VARCHAR(80) NOT NULL,
    poblacion_2020 INTEGER NOT NULL CHECK (poblacion_2020 > 0),
    marco_version VARCHAR(7) NOT NULL DEFAULT '2025-12',
    geom geometry(MultiPolygon,4326) NOT NULL,
    CHECK (cvegeo = '09' || cve_mun),
    CHECK (ST_IsValid(geom) AND NOT ST_IsEmpty(geom))
);
COMMENT ON TABLE gis.alcaldias IS
 'INEGI: Marco Geoestadístico diciembre 2025 y población CPV 2020. Descarga 2026-10-19.';
COMMENT ON COLUMN gis.alcaldias.geom IS
 'Polígonos reproyectados de EPSG:6365 a EPSG:4326 antes de la carga; sin simplificación.';

-- Datos exclusivamente didácticos: NO son establecimientos reales.
CREATE TABLE gis.puntos_simulados (
    id_punto INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    etiqueta VARCHAR(40) NOT NULL UNIQUE,
    cvegeo_origen VARCHAR(5) NOT NULL REFERENCES gis.alcaldias(cvegeo),
    tipo VARCHAR(30) NOT NULL,
    es_simulado BOOLEAN NOT NULL DEFAULT TRUE CHECK (es_simulado),
    geom geometry(Point,4326) NOT NULL,
    CHECK (NOT ST_IsEmpty(geom))
);
COMMENT ON TABLE gis.puntos_simulados IS
 '72 puntos generados para enseñanza. No describen establecimientos, servicios ni cobertura reales.';

-- Índices de las geometrías almacenadas para búsquedas y cruces espaciales.
CREATE INDEX ix_alcaldias_geom ON gis.alcaldias USING GIST (geom);
CREATE INDEX ix_puntos_geom ON gis.puntos_simulados USING GIST (geom);
-- Esta expresión coincide con las búsquedas geodésicas en metros de la clase 2.
CREATE INDEX ix_puntos_geog
 ON gis.puntos_simulados USING GIST ((geom::geography));
SELECT current_database() AS base, PostGIS_Full_Version() AS version_postgis;
