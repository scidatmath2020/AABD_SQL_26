-- Ejecutar una vez sobre ENUT2024 con las cinco tablas enut cargadas.
-- Solo crea objetos de análisis y laboratorio; no modifica los microdatos.
BEGIN;
CREATE SCHEMA IF NOT EXISTS analisis;
CREATE SCHEMA IF NOT EXISTS laboratorio;
CREATE OR REPLACE VIEW analisis.personas AS
SELECT llavemod, llavehog, llaveviv, cve_ent, sexo,
       edad AS edad_codigo,
       CASE WHEN edad ~ '^[0-9]{2}$'
             AND edad::integer BETWEEN 12 AND 96
            THEN edad::integer END AS edad,
       menor10, cond_disc, cond_ind, cond_aee,
       escolaridad, est_dis, upm_dis, fac_per,
       NULLIF(TRIM(trab_no_rem_hog), '')::numeric AS h_dom,
       NULLIF(TRIM(trab_no_rem_cuid_hog), '')::numeric AS h_cuid,
       NULLIF(TRIM(activ_merc), '')::numeric AS h_merc,
       NULLIF(TRIM(activ_prod_sin_cp), '')::numeric AS h_total
FROM enut.tvar_crea;

CREATE TABLE laboratorio.hogares AS
SELECT llavehog, cve_ent, 0::integer AS prioridad,
       NULL::text AS nota
FROM enut.thogar;
ALTER TABLE laboratorio.hogares ADD PRIMARY KEY (llavehog);
ALTER TABLE laboratorio.hogares ADD CHECK (prioridad BETWEEN 0 AND 5);

CREATE TABLE laboratorio.catalogo (
    codigo varchar(2) PRIMARY KEY, nombre text NOT NULL
);
INSERT INTO laboratorio.catalogo VALUES ('01','Aguascalientes');

-- Fechas y cantidades ficticias de una bitácora de carga.
-- NO son fechas de entrevista ni una serie temporal de la ENUT.
CREATE TABLE laboratorio.bitacora (
    id integer PRIMARY KEY, fecha date NOT NULL,
    filas integer NOT NULL CHECK (filas > 0)
);
INSERT INTO laboratorio.bitacora VALUES
 (1,'2026-09-01',100),(2,'2026-09-03',200),
 (3,'2026-10-01',150),(4,'2026-10-04',250),
 (5,'2026-11-01',300);
COMMIT;
