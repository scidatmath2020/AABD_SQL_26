-- Consulta compartida por R y Python. CRS de salida: UTM 14N en metros.
SELECT cvegeo, cve_mun, nombre, poblacion_2020,
       ST_Transform(geom,32614) AS geom
FROM gis.alcaldias
ORDER BY cvegeo;
