--- Elimina la base de datos si ya existe 
DROP DATABASE IF EXISTS 'EscuelaSQL' WITH (FORCE);

--- Creación de la base de datos 
CREATE DATABASE 'EscuelaSQL';

--- Creación del esquema 
CREATE SCHEMA academico;

--- ¿Cómo crear tablas dentro de un esquema? 

--- Tabla profesores (esquema: academico)

CREATE TABLE academico.profesores(
	id_profesor SERIAL PRIMARY KEY,
	id_supervisor INT NULL,
	nombre VARCHAR(60) NOT NULL,
	apellidos VARCHAR(90) NOT NULL,
	especialidad VARCHAR(50) NOT NULL,
	fecha_contratacion DATE NOT NULL,
	telefono VARCHAR(15) NULL,
	salario DECIMAL(10, 2) NOT NULL,
	activo BOOLEAN NOT NULL DEFAULT TRUE,
	CONSTRAINT CK_prof_salario CHECK (salario >= 10000),
	CONSTRAINT FK_prof_supervisor FOREIGN KEY (id_supervisor)
		REFERENCES academico.profesores(id_profesor)
);

--- Tabla materias (esquema: academico)

CREATE TABLE academico.materias (
    id_materia INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    clave VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(80) NOT NULL,
    area VARCHAR(40) NOT NULL,
    creditos SMALLINT NOT NULL,
    horas_semana SMALLINT NOT NULL,
    obligatoria BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT CK_mat_creditos CHECK (creditos BETWEEN 2 AND 12),
    CONSTRAINT CK_mat_horas CHECK (horas_semana BETWEEN 2 AND 10)
);

--- Tabla grupos (esquema: academico)

CREATE TABLE academico.grupos (
    id_grupo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    clave VARCHAR(10) NOT NULL UNIQUE,
    grado SMALLINT NOT NULL,
    turno VARCHAR(10) NOT NULL,
    aula VARCHAR(10) NOT NULL,
    ciclo_escolar CHAR(9) NOT NULL,
    cupo SMALLINT NOT NULL DEFAULT 35,
    CONSTRAINT CK_grupo_grado CHECK (grado BETWEEN 1 AND 6),
    CONSTRAINT CK_grupo_turno CHECK (turno IN ('Matutino','Vespertino')),
    CONSTRAINT CK_grupo_cupo CHECK (cupo BETWEEN 20 AND 50)
);

--- Tabla alumnos (esquema: academico)

CREATE TABLE academico.alumnos (
    id_alumno INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    matricula VARCHAR(12) NOT NULL UNIQUE,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(90) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15) NULL,
    fecha_ingreso DATE NOT NULL DEFAULT CURRENT_DATE,
    beca_porcentaje DECIMAL(5,2) NOT NULL DEFAULT 0,
    id_grupo INT NOT NULL,
    CONSTRAINT CK_alum_sexo CHECK (sexo IN ('F','M','X')),
    CONSTRAINT CK_alum_beca CHECK (beca_porcentaje BETWEEN 0 AND 100),
    CONSTRAINT FK_alum_grupo FOREIGN KEY (id_grupo)
        REFERENCES academico.grupos(id_grupo)
);

--- Tabla asignaciones (esquema: academico)

CREATE TABLE academico.asignaciones (
    id_asignacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_grupo INT NOT NULL,
    id_materia INT NOT NULL,
    id_profesor INT NOT NULL,
    periodo CHAR(6) NOT NULL,
    aula VARCHAR(10) NOT NULL,
    horario VARCHAR(30) NOT NULL,
    cupo SMALLINT NOT NULL,
    CONSTRAINT UQ_asig UNIQUE (id_grupo, id_materia, periodo),
    CONSTRAINT CK_asig_cupo CHECK (cupo BETWEEN 15 AND 50),
    CONSTRAINT FK_asig_grupo FOREIGN KEY (id_grupo)
        REFERENCES academico.grupos(id_grupo),
    CONSTRAINT FK_asig_materia FOREIGN KEY (id_materia)
        REFERENCES academico.materias(id_materia),
    CONSTRAINT FK_asig_profesor FOREIGN KEY (id_profesor)
        REFERENCES academico.profesores(id_profesor)
);

--- Tabla inscripciones (esquema: academico)

CREATE TABLE academico.inscripciones (
    id_inscripcion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_asignacion INT NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    calificacion DECIMAL(5,2) NULL,
    asistencias SMALLINT NOT NULL,
    estatus VARCHAR(12) NOT NULL,
    CONSTRAINT UQ_insc UNIQUE (id_alumno, id_asignacion),
    CONSTRAINT CK_insc_calif CHECK (calificacion BETWEEN 0 AND 100 OR calificacion IS NULL),
    CONSTRAINT CK_insc_asist CHECK (asistencias BETWEEN 0 AND 100),
    CONSTRAINT CK_insc_estatus CHECK (estatus IN ('Cursando','Aprobado','Reprobado','Baja')),
    CONSTRAINT FK_insc_alumno FOREIGN KEY (id_alumno)
        REFERENCES academico.alumnos(id_alumno),
    CONSTRAINT FK_insc_asig FOREIGN KEY (id_asignacion)
        REFERENCES academico.asignaciones(id_asignacion)
);


--- Ver tablas en el esquema

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'academico'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;

--- Simulación de datos para las tablas 

DO $$
DECLARE
    i INT;
BEGIN
    -- 30 Profesores
    i := 1;
    WHILE i <= 30
    LOOP
        INSERT INTO academico.profesores
            (id_supervisor, nombre, apellidos, especialidad,
             fecha_contratacion, telefono, salario, activo)
        VALUES
            (
                CASE WHEN i <= 5 THEN NULL ELSE ((i - 2) % 5) + 1 END,
                CONCAT('Profesor ', LPAD(i::TEXT, 2, '0')),
                CONCAT('Apellido ', LPAD(i::TEXT, 2, '0')),
                CASE i % 6 
                    WHEN 0 THEN 'Matemáticas' 
                    WHEN 1 THEN 'Lengua'
                    WHEN 2 THEN 'Ciencias' 
                    WHEN 3 THEN 'Historia'
                    WHEN 4 THEN 'Tecnología' 
                    ELSE 'Artes' 
                END,
                '2026-08-01'::DATE - (i * 7 || ' months')::INTERVAL,
                CASE WHEN i % 5 = 0 THEN NULL ELSE CONCAT('5551', LPAD(i::TEXT, 6, '0')) END,
                18000 + (i * 650),
                CASE WHEN i IN (27, 30) THEN FALSE ELSE TRUE END
            );
        i := i + 1;
    END LOOP;

    -- 30 Materias
    i := 1;
    WHILE i <= 30
    LOOP
        INSERT INTO academico.materias
            (clave, nombre, area, creditos, horas_semana, obligatoria)
        VALUES
            (
                CONCAT('MAT', LPAD(i::TEXT, 3, '0')),
                CONCAT(
                    CASE i % 6 
                        WHEN 0 THEN 'Matemáticas' WHEN 1 THEN 'Lengua'
                        WHEN 2 THEN 'Ciencias' WHEN 3 THEN 'Historia'
                        WHEN 4 THEN 'Tecnología' ELSE 'Artes' 
                    END,
                    ' ', LPAD(i::TEXT, 2, '0')
                ),
                CASE i % 6 
                    WHEN 0 THEN 'Matemáticas' WHEN 1 THEN 'Humanidades'
                    WHEN 2 THEN 'Ciencias' WHEN 3 THEN 'Ciencias Sociales'
                    WHEN 4 THEN 'Tecnología' ELSE 'Artes' 
                END,
                3 + (i % 6), 2 + (i % 5), 
                CASE WHEN i % 4 = 0 THEN FALSE ELSE TRUE END
            );
        i := i + 1;
    END LOOP;

    -- 30 Grupos
    i := 1;
    WHILE i <= 30
    LOOP
        INSERT INTO academico.grupos
            (clave, grado, turno, aula, ciclo_escolar, cupo)
        VALUES
            (
                CONCAT('G', LPAD(i::TEXT, 2, '0')), 
                1 + ((i - 1) % 6),
                CASE WHEN i % 2 = 0 THEN 'Matutino' ELSE 'Vespertino' END,
                CONCAT('A-', LPAD((100 + i)::TEXT, 3, '0')), 
                '2026-2027', 
                28 + (i % 13)
            );
        i := i + 1;
    END LOOP;

    -- 60 Alumnos
    i := 1;
    WHILE i <= 60
    LOOP
        INSERT INTO academico.alumnos
            (matricula, nombre, apellidos, fecha_nacimiento, sexo, email,
             telefono, fecha_ingreso, beca_porcentaje, id_grupo)
        VALUES
            (
                CONCAT('A2026', LPAD(i::TEXT, 3, '0')), 
                CONCAT('Alumno ', LPAD(i::TEXT, 3, '0')),
                CONCAT('Familia ', LPAD((((i - 1) % 20) + 1)::TEXT, 2, '0')),
                '2014-01-01'::DATE - (i * 41 || ' days')::INTERVAL,
                CASE i % 3 WHEN 0 THEN 'X' WHEN 1 THEN 'F' ELSE 'M' END,
                CONCAT('alumno', LPAD(i::TEXT, 3, '0'), '@escuela.mx'),
                CASE WHEN i % 7 = 0 THEN NULL ELSE CONCAT('5552', LPAD(i::TEXT, 6, '0')) END,
                '2026-08-01'::DATE + (i % 20 || ' days')::INTERVAL,
                CASE i % 5 WHEN 0 THEN 100 WHEN 1 THEN 50 WHEN 2 THEN 25 ELSE 0 END,
                ((i - 1) % 30) + 1
            );
        i := i + 1;
    END LOOP;

    -- 60 Asignaciones
    i := 1;
    WHILE i <= 60
    LOOP
        INSERT INTO academico.asignaciones
            (id_grupo, id_materia, id_profesor, periodo, aula, horario, cupo)
        VALUES
            (
                ((i - 1) % 30) + 1, 
                ((i - 1) % 30) + 1,
                (((i * 7) - 1) % 30) + 1,
                CASE WHEN i <= 30 THEN '2026-1' ELSE '2026-2' END,
                CONCAT('A-', LPAD((100 + ((i - 1) % 30) + 1)::TEXT, 3, '0')),
                CASE i % 3 
                    WHEN 0 THEN '08:00-10:00'
                    WHEN 1 THEN '10:00-12:00' 
                    ELSE '16:00-18:00' 
                END,
                25 + (i % 16)
            );
        i := i + 1;
    END LOOP;

    -- 100 Inscripciones
    i := 1;
    WHILE i <= 100
    LOOP
        INSERT INTO academico.inscripciones
            (id_alumno, id_asignacion, fecha_inscripcion,
             calificacion, asistencias, estatus)
        VALUES
            (
                ((i - 1) % 60) + 1,
                ((((i - 1) * 17) + ((i - 1) / 60)) % 60) + 1,
                '2026-08-01'::DATE + (i % 25 || ' days')::INTERVAL,
                CASE WHEN i % 10 = 0 THEN NULL ELSE 55 + (i % 46) END,
                60 + (i % 41),
                CASE WHEN i % 10 = 0 THEN 'Cursando'
                      WHEN (55 + (i % 46)) >= 70 THEN 'Aprobado' 
                      ELSE 'Reprobado' 
                END
            );
        i := i + 1;
    END LOOP;

END $$;

---- Consultas completas de cada tabla 

SELECT * FROM academico.alumnos;
SELECT * FROM academico.asignaciones;
SELECT * FROM academico.grupos;
SELECT * FROM academico.inscripciones;
SELECT * FROM academico.materias;
SELECT * FROM academico.profesores;
