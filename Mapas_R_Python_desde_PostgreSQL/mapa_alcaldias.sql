-- Consulta compartida por R y Python. CRS de salida: UTM 14N en metros.
SELECT cvegeo, cve_mun, nombre, poblacion_2020,
       area_km2, n_puntos_simulados,
       ST_Transform(geom,32614) AS geom
FROM gis.v_alcaldias_indicadores
ORDER BY cvegeo;
