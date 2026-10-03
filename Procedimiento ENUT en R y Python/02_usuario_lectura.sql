-- Ejecutar en ENUT2024 con un administrador, una sola vez.
-- Este usuario no tendrá contraseña hasta configurarla en pgAdmin.
CREATE ROLE enut_lector LOGIN;
GRANT CONNECT ON DATABASE "ENUT2024" TO enut_lector;
GRANT USAGE ON SCHEMA enut TO enut_lector;
GRANT SELECT ON ALL TABLES IN SCHEMA enut TO enut_lector;

-- En pgAdmin: Login/Group Roles > enut_lector > Properties
-- > Definition > Password: definir tu contraseña y guardar.
-- Las contraseñas no se incluyen en estos archivos.

-- Comprobar permisos (no comprueba la autenticación por contraseña):
SELECT has_database_privilege('enut_lector','ENUT2024','CONNECT'),
       has_schema_privilege('enut_lector','enut','USAGE'),
       has_table_privilege('enut_lector','enut.tvar_crea','SELECT');
