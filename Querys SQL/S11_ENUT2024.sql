--- Bloque. Validación

BEGIN;

DO $enut$
BEGIN
    IF current_database() <> 'ENUT2024' THEN
        RAISE EXCEPTION 'Abra Query Tool sobre la base ENUT2024 antes de ejecutar este archivo.';
    END IF;
END
$enut$;

--- Bloque. Crear esquema. 

CREATE SCHEMA IF NOT EXISTS enut;
COMMENT ON SCHEMA enut IS 'ENUT 2024. Estructura basada en enut_2024_fd.xlsx.';

--- Bloque. Creación de tabla TVIVIENDA 

CREATE TABLE enut.tvivienda (
    llaveviv VARCHAR(9) PRIMARY KEY,
    p1_1 VARCHAR(1),
    p1_2 VARCHAR(1),
    p1_3 VARCHAR(2),
    p1_3a VARCHAR(2),
    p1_4 VARCHAR(1),
    p1_5 VARCHAR(1),
    p1_6 VARCHAR(1),
    p1_7 VARCHAR(1),
    p1_8 VARCHAR(1),
    p1_9 VARCHAR(1),
    p1_10 VARCHAR(1),
    p1_11 VARCHAR(1),
    p1_12 VARCHAR(1),
    p1_13 VARCHAR(1),
    p1_14 VARCHAR(1),
    p1_15_01 VARCHAR(1),
    p1_15_02 VARCHAR(1),
    p1_15_03 VARCHAR(1),
    p1_15_04 VARCHAR(1),
    p1_15_05 VARCHAR(1),
    p1_15_06 VARCHAR(1),
    p1_15_07 VARCHAR(1),
    p1_15_08 VARCHAR(1),
    p1_15_09 VARCHAR(1),
    p1_15_10 VARCHAR(1),
    p2_1 VARCHAR(2),
    p2_2 VARCHAR(1),
    p2_3 VARCHAR(2),
    cvegeo VARCHAR(2),
    cve_ent VARCHAR(2),
    tloc VARCHAR(1),
    menor10 VARCHAR(1),
    est_dis VARCHAR(4),
    upm_dis VARCHAR(5),
    fac_viv NUMERIC(5,0),
    control VARCHAR(7),
    viv_sel VARCHAR(2)
);

COMMENT ON TABLE enut.tvivienda IS 'ENUT 2024. Hoja TVIVIENDA de enut_2024_fd.xlsx. 38 columnas.';
COMMENT ON COLUMN enut.tvivienda.llaveviv IS 'Llave de identificación de la vivienda | Descriptor: Alfanumérico, tamaño 9. | Códigos/conceptos: 010009401 - 326123120 = Llave de identificación de la vivienda';
COMMENT ON COLUMN enut.tvivienda.p1_1 IS '1.1 ¿De qué material es la mayor parte del piso de esta vivienda? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Tierra; 2 = Cemento o firme; 3 = Madera, mosaico u otro recubrimiento';
COMMENT ON COLUMN enut.tvivienda.p1_2 IS '1.2 ¿Esta vivienda tiene cuarto para cocinar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_3 IS '1.3 ¿Cuántos cuartos se usan para dormir, sin contar pasillos? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 11 = Número de cuartos que se usan para dormir';
COMMENT ON COLUMN enut.tvivienda.p1_3a IS '1.3a ¿Cuántos cuartos tiene en total esta vivienda, contando la cocina? (No cuente pasillos ni baños) | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 16 = Total de cuartos';
COMMENT ON COLUMN enut.tvivienda.p1_4 IS '1.4 ¿El agua la obtienen de llaves o mangueras que están... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = dentro de la vivienda?; 2 = solo en el patio o terreno?; 3 = ¿No tiene agua entubada?';
COMMENT ON COLUMN enut.tvivienda.p1_5 IS '1.5 ¿El agua que usan en su vivienda proviene... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = del servicio público de agua?; 2 = de un pozo comunitario?; 3 = de un pozo particular?; 4 = de una pipa?; 5 = de otra vivienda?; 6 = de la lluvia?; 7 = de otro lugar?; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tvivienda.p1_6 IS '1.6 Entonces, ¿acarrean el agua de... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = un pozo?; 2 = una llave comunitaria?; 3 = otra vivienda?; 4 = un río, arroyo o lago?; 5 = ¿La trae una pipa?; 6 = ¿La captan de la lluvia?; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tvivienda.p1_7 IS '1.7 ¿Cuántos días a la semana cuenta con agua en su vivienda? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Diario (7 días); 2 = Seis días; 3 = Cinco días; 4 = Cuatro días; 5 = Tres días; 6 = Dos días; 7 = Un día; 8 = Escasea más de una semana';
COMMENT ON COLUMN enut.tvivienda.p1_8 IS '1.8 ¿Tienen... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = taza de baño (excusado o sanitario)?; 2 = letrina (pozo u hoyo)?; 3 = ¿No tienen taza de baño ni letrina?';
COMMENT ON COLUMN enut.tvivienda.p1_9 IS '1.9 ¿La taza de baño (letrina)... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = tiene descarga directa de agua?; 2 = le echan agua con una cubeta?; 3 = ¿No se le puede echar agua?; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tvivienda.p1_10 IS '1.10 ¿Esta vivienda tiene drenaje o desagüe conectado a... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = la red pública?; 2 = una fosa séptica o tanque séptico (biodigestor)?; 3 = una tubería que va a dar a una barranca o grieta?; 4 = una tubería que va a dar a un río, lago o mar?; 5 = ¿No tiene drenaje?';
COMMENT ON COLUMN enut.tvivienda.p1_11 IS '1.11 ¿Hay luz eléctrica en esta vivienda? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_12 IS '1.12 ¿El combustible que más usan para cocinar es... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = leña o carbón?; 2 = gas?; 3 = electricidad?; 4 = ¿Otro combustible?; 5 = ¿No cocinan?';
COMMENT ON COLUMN enut.tvivienda.p1_13 IS '1.13 ¿El fogón (anafre, estufa, comal) donde cocinan con leña o carbón tiene un tubo o chimenea para sacar el humo? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tvivienda.p1_14 IS '1.14 ¿La basura de esta vivienda... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = la tiran en un contenedor o depósito?; 2 = la recoge un camión o carrito de basura?; 3 = la queman?; 4 = la entierran?; 5 = la tiran en el basurero público?; 6 = la tiran en otro lugar (calle, baldío, barranca, río)?';
COMMENT ON COLUMN enut.tvivienda.p1_15_01 IS '1.15 ¿En esta vivienda tienen lavadero? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_15_02 IS '1.15 ¿En esta vivienda tienen fregadero o tarja? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_15_03 IS '1.15 ¿En esta vivienda tienen tanque de gas estacionario o instalación para gas natural? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_15_04 IS '1.15 ¿En esta vivienda tienen tinaco? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_15_05 IS '1.15 ¿En esta vivienda tienen cisterna o aljibe? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_15_06 IS '1.15 ¿En esta vivienda tienen bomba de agua? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_15_07 IS '1.15 ¿En esta vivienda tienen regadera? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_15_08 IS '1.15 ¿En esta vivienda tienen boiler o calentador de agua? (gas, eléctrico, leña) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_15_09 IS '1.15 ¿En esta vivienda tienen calentador solar de agua? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p1_15_10 IS '1.15 ¿En esta vivienda tienen aire acondicionado? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tvivienda.p2_1 IS '2.1 ¿Cuántas personas viven normalmente en esta vivienda contando a bebés, niñas, niños, personas mayores y personas con discapacidad? Incluya también a las personas trabajadoras domésticas y huéspedes que duerman aquí. | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 18 = Número de personas';
COMMENT ON COLUMN enut.tvivienda.p2_2 IS '2.2 ¿Todas las personas que viven en esta vivienda comparten un mismo gasto para comer? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tvivienda.p2_3 IS '2.3 Entonces, ¿cuántos hogares o grupos de personas tienen gasto separado para comer contando el de usted? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 02 - 05 = Número de hogares; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tvivienda.cvegeo IS 'Clave geográfica | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.tvivienda.cve_ent IS 'Entidad | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.tvivienda.tloc IS 'Tamaño de Localidad | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de entre 100 000 y más habitantes; 2 = Localidades con una población de entre 15 000 y 99 999 habitantes; 3 = Localidades con una población de entre 2 500 y 14 999 habitantes; 4 = Localidades con una población de menos de 2 500 habitantes';
COMMENT ON COLUMN enut.tvivienda.menor10 IS 'Variable indicadora del tamaño de localidad para explotación | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de 1 a 9 999 habitantes; 2 = Localidades con una población de 10 000 y más habitantes';
COMMENT ON COLUMN enut.tvivienda.est_dis IS 'Estrato de Diseño Muestral | Descriptor: Alfanumérico, tamaño 4. | Códigos/conceptos: 0001 - 0342 = Estrato de Diseño Muestral';
COMMENT ON COLUMN enut.tvivienda.upm_dis IS 'Unidad Primaria de Muestreo | Descriptor: Alfanumérico, tamaño 5. | Códigos/conceptos: 00001 - 04208 = Unidad Primaria de Muestreo';
COMMENT ON COLUMN enut.tvivienda.fac_viv IS 'Factor | Descriptor: Numérico, tamaño 5. | Códigos/conceptos: 00007 - 12654 = Factor';
COMMENT ON COLUMN enut.tvivienda.control IS 'Control de Vivienda | Descriptor: Alfanumérico, tamaño 7. | Códigos/conceptos: 0100094 - 3261231 = Número de Control de la Vivienda';
COMMENT ON COLUMN enut.tvivienda.viv_sel IS 'Número de Vivienda Seleccionada | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 24 = Número de Vivienda Seleccionada';

--- Bloque. Tabla THOGAR

CREATE TABLE enut.thogar (
    llavehog VARCHAR(10) PRIMARY KEY,
    llaveviv VARCHAR(9),
    p2_4_01 VARCHAR(1),
    p2_4_02 VARCHAR(1),
    p2_4_03 VARCHAR(1),
    p2_4_04 VARCHAR(1),
    p2_4_05 VARCHAR(1),
    p2_4_05a VARCHAR(1),
    p2_4_06 VARCHAR(1),
    p2_4_07 VARCHAR(1),
    p2_4_08 VARCHAR(1),
    p2_4_09 VARCHAR(1),
    p2_4_10 VARCHAR(1),
    p2_4_11 VARCHAR(1),
    p2_4_12 VARCHAR(1),
    p2_4_13 VARCHAR(1),
    p2_4_14 VARCHAR(1),
    p3_14_1 VARCHAR(1),
    p3_15_1 VARCHAR(1),
    p3_16_1 VARCHAR(2),
    p3_17_1 VARCHAR(5),
    p3_19_1 VARCHAR(1),
    p3_14_2 VARCHAR(1),
    p3_15_2 VARCHAR(1),
    p3_16_2 VARCHAR(2),
    p3_17_2 VARCHAR(5),
    p3_18_2 VARCHAR(1),
    p3_19_2 VARCHAR(1),
    p3_14_3 VARCHAR(1),
    p3_15_3 VARCHAR(1),
    p3_16_3 VARCHAR(2),
    p3_17_3 VARCHAR(5),
    p3_18_3 VARCHAR(1),
    p3_19_3 VARCHAR(1),
    p3_20_1 VARCHAR(1),
    p3_20a_1 VARCHAR(6),
    p3_20_2 VARCHAR(1),
    p3_20a_2 VARCHAR(6),
    p3_20_3 VARCHAR(1),
    p3_20a_3 VARCHAR(6),
    p3_20_4 VARCHAR(1),
    p3_20a_4 VARCHAR(6),
    p3_20_5 VARCHAR(1),
    p3_20a_5 VARCHAR(6),
    p3_20_6 VARCHAR(1),
    p3_20a_6 VARCHAR(6),
    p3_20_7 VARCHAR(1),
    p3_20a_7 VARCHAR(6),
    p3_20_8 VARCHAR(1),
    p3_20a_8 VARCHAR(6),
    cvegeo VARCHAR(2),
    cve_ent VARCHAR(2),
    tloc VARCHAR(1),
    menor10 VARCHAR(1),
    est_dis VARCHAR(4),
    upm_dis VARCHAR(5),
    fac_hog NUMERIC(5,0),
    control VARCHAR(7),
    viv_sel VARCHAR(2),
    hogar VARCHAR(1),
    CONSTRAINT fk_thogar_llaveviv FOREIGN KEY (llaveviv) REFERENCES enut.tvivienda (llaveviv)
);

COMMENT ON TABLE enut.thogar IS 'ENUT 2024. Hoja THOGAR de enut_2024_fd.xlsx. 60 columnas.';
COMMENT ON COLUMN enut.thogar.llavehog IS 'Llave de identificación del hogar | Descriptor: Alfanumérico, tamaño 10. | Códigos/conceptos: 0100094011 - 3261231201 = Llave de identificación del hogar';
COMMENT ON COLUMN enut.thogar.llaveviv IS 'Llave de identificación de la vivienda | Descriptor: Alfanumérico, tamaño 9. | Códigos/conceptos: 010009401 - 326123120 = Llave de identificación de la vivienda';
COMMENT ON COLUMN enut.thogar.p2_4_01 IS '2.4 ¿En este hogar tienen televisor? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_02 IS '2.4 ¿En este hogar tienen plancha eléctrica? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_03 IS '2.4 ¿En este hogar tienen licuadora? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_04 IS '2.4 ¿En este hogar tienen refrigerador? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_05 IS '2.4 ¿En este hogar tienen lavadora? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_05a IS '2.4 ¿En este hogar tienen ¿Es automática (se llena, lava, enjuaga y exprime sola)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p2_4_06 IS '2.4 ¿En este hogar tienen secadora de ropa? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No especificado; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p2_4_07 IS '2.4 ¿En este hogar tienen horno de microondas? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_08 IS '2.4 ¿En este hogar tienen automóvil o camioneta? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_09 IS '2.4 ¿En este hogar tienen motocicleta o motoneta? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_10 IS '2.4 ¿En este hogar tienen bicicleta que se utilice como medio de transporte? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_11 IS '2.4 ¿En este hogar tienen computadora, laptop o tablet? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_12 IS '2.4 ¿En este hogar tienen teléfono celular o smartphone? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_13 IS '2.4 ¿En este hogar tienen internet? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p2_4_14 IS '2.4 ¿En este hogar tienen servicio de películas, música o videos de paga por internet (Netflix, Claro video, HBO, Spotify, etcétera)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.thogar.p3_14_1 IS '3.14 En este hogar, ¿contratan personal para realizar trabajo doméstico (limpiar casa, planchar, cocinar)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_15_1 IS '3.15 La semana pasada ¿cuántos días asistió a trabajar el personal para realizar trabajo doméstico (limpiar casa, planchar, cocinar)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 - 7 = Días trabajados; 8 = No trabajó la semana pasada; 9 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_16_1 IS '3.16 En total, ¿cuántas horas trabajó el personal para realizar trabajo doméstico (limpiar casa, planchar, cocinar), la semana pasada? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 = Menos de 1 hora; 01 - 96 = Horas trabajadas; 97 = 97 y más; 99 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_17_1 IS '3.17 ¿Cuánto se pagó por el servicio que realizó este personal la semana pasada? | Descriptor: Alfanumérico, tamaño 5. | Códigos/conceptos: 00020 - 25000 = Cantidad; 98000 = $98,000 y más; 99999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_19_1 IS '3.19 Cuando el personal para realizar trabajo doméstico (limpiar casa, planchar, cocinar) no asiste, ¿quién es la persona del hogar encargada de realizar estas labores? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Jefa(e); 2 = Cónyuge; 3 = Jefa(e) y cónyuge; 4 = Entre todas las personas del hogar; 5 = Otra(s) persona(s) del hogar; 6 = Persona(s) de otro hogar; 7 = Contrata(n) a alguien más; 8 = No ha ocurrido; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_14_2 IS '3.14 En este hogar, ¿contratan personal de enfermería o para el cuidado o apoyo a personas mayores o con discapacidad? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_15_2 IS '3.15 La semana pasada ¿cuántos días asistió a trabajar el personal de enfermería o para el cuidado o apoyo a personas mayores o con discapacidad? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 - 7  = Días trabajados; 8 = No trabajó la semana pasada; 9 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_16_2 IS '3.16 En total, ¿cuántas horas trabajó el personal de enfermería o para el cuidado o apoyo a personas mayores o con discapacidad, la semana pasada? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 = Menos de 1 hora; 01 - 96 = Horas trabajadas; 97 = 97 y más; 99 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_17_2 IS '3.17 ¿Cuánto se pagó por el servicio que realizó este personal la semana pasada? | Descriptor: Alfanumérico, tamaño 5. | Códigos/conceptos: 00060 - 13000 = Cantidad; 98000 = $98,000 y más; 99999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_18_2 IS '3.18 ¿Esta(s) persona(s) es(son)enfermera(s) o enfermero(s) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_19_2 IS '3.19 Cuando el personal de enfermería o para el cuidado o apoyo a personas mayores o con discapacidad no asiste, ¿quién es la persona del hogar encargada de realizar estas labores? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Jefa(e); 2 = Cónyuge; 3 = Jefa(e) y cónyuge; 4 = Entre todas las personas del hogar; 5 = Otra(s) persona(s) del hogar; 6 = Persona(s) de otro hogar; 7 = Contrata(n) a alguien más; 8 = No ha ocurrido; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_14_3 IS '3.14 En este hogar, ¿contratan personal de enfermería o para el cuidado o atención a bebés, niñas y niños? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_15_3 IS '3.15 La semana pasada ¿cuántos días asistió a trabajar el personal de enfermería o para el cuidado o atención a bebés, niñas y niños? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 - 7 = Días trabajados; 8 = No trabajó la semana pasada; 9 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_16_3 IS '3.16 En total, ¿cuántas horas trabajó el personal de enfermería o para el cuidado o atención a bebés, niñas y niños, la semana pasada? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 02 - 72 = Horas trabajadas; 99 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_17_3 IS '3.17 ¿Cuánto se pagó por el servicio que realizó este personal la semana pasada? | Descriptor: Alfanumérico, tamaño 5. | Códigos/conceptos: 00150 - 07500 = Cantidad; 98000 = $98,000 y más; 99999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_18_3 IS '3.18 ¿Esta(s) persona(s) es(son)enfermera(s) o enfermero(s) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_19_3 IS '3.19 Cuando el personal de enfermería o para el cuidado o atención a bebés, niñas y niños no asiste, ¿quién es la persona del hogar encargada de realizar estas labores? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Jefa(e); 2 = Cónyuge; 3 = Jefa(e) y cónyuge; 4 = Entre todas las personas del hogar; 5 = Otra(s) persona(s) del hogar; 6 = Persona(s) de otro hogar; 7 = Contrata(n) a alguien más; 8 = No ha ocurrido; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_20_1 IS '3.20 Durante los últimos tres meses, ¿las personas de este hogar recibieron dinero de programas de apoyos del gobierno (pensión para personas mayores, jóvenes construyendo el futuro, becas para estudiar, etcétera)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_20a_1 IS '3.20a ¿Cuánto recibieron en total? Declare en pesos | Descriptor: Alfanumérico, tamaño 6. | Códigos/conceptos: 000006 - 152000 = Cantidad recibida; 999999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_20_2 IS '3.20 Durante los últimos tres meses, ¿las personas de este hogar recibieron dinero por jubilación o pensión? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_20a_2 IS '3.20a ¿Cuánto recibieron en total? Declare en pesos | Descriptor: Alfanumérico, tamaño 6. | Códigos/conceptos: 000001 - 840000 = Cantidad recibida; 980000 = $980,000 y más; 999999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_20_3 IS '3.20 Durante los últimos tres meses, ¿las personas de este hogar recibieron dinero de familiares o amistades que viven o se fueron a trabajar a otro país? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_20a_3 IS '3.20a ¿Cuánto recibieron en total? Declare en pesos | Descriptor: Alfanumérico, tamaño 6. | Códigos/conceptos: 000200 - 210000 = Cantidad recibida; 999999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_20_4 IS '3.20 Durante los últimos tres meses, ¿las personas de este hogar recibieron dinero de familiares o amistades que viven en el país? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_20a_4 IS '3.20a ¿Cuánto recibieron en total? Declare en pesos | Descriptor: Alfanumérico, tamaño 6. | Códigos/conceptos: 000100 - 216000 = Cantidad recibida; 999999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_20_5 IS '3.20 Durante los últimos tres meses, ¿las personas de este hogar recibieron dinero por el alquiler de algún bien (placas para taxi, automóvil, etcétera)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_20a_5 IS '3.20a ¿Cuánto recibieron en total? Declare en pesos | Descriptor: Alfanumérico, tamaño 6. | Códigos/conceptos: 000500 - 600000 = Cantidad recibida; 999999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_20_6 IS '3.20 Durante los últimos tres meses, ¿las personas de este hogar recibieron dinero por la renta de alguna propiedad (casa, edificio, local, terreno, tierra de cultivo, etcétera)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_20a_6 IS '3.20a ¿Cuánto recibieron en total? Declare en pesos | Descriptor: Alfanumérico, tamaño 6. | Códigos/conceptos: 000060 - 140000 = Cantidad recibida; 980000 = $980,000 y más; 999999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_20_7 IS '3.20 Durante los últimos tres meses, ¿las personas de este hogar recibieron dinero por retiro de intereses bancarios? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_20a_7 IS '3.20a ¿Cuánto recibieron en total? Declare en pesos | Descriptor: Alfanumérico, tamaño 6. | Códigos/conceptos: 000020 - 099999 = Cantidad recibida; 980000 = $980,000 y más; 999999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.p3_20_8 IS '3.20 Durante los últimos tres meses, ¿las personas de este hogar recibieron dinero por la venta o empeño de algún bien (casa, joyas, vehículos, maquinaria, animales,electrodomésticos, etcétera)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.thogar.p3_20a_8 IS '3.20a ¿Cuánto recibieron en total? Declare en pesos | Descriptor: Alfanumérico, tamaño 6. | Códigos/conceptos: 000100 - 600000 = Cantidad recibida; 980000 = $980,000 y más; 999999 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.thogar.cvegeo IS 'Clave geográfica | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.thogar.cve_ent IS 'Entidad | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.thogar.tloc IS 'Tamaño de Localidad | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de entre 100 000 y más habitantes; 2 = Localidades con una población de entre 15 000 y 99 999 habitantes; 3 = Localidades con una población de entre 2 500 y 14 999 habitantes; 4 = Localidades con una población de menos de 2 500 habitantes';
COMMENT ON COLUMN enut.thogar.menor10 IS 'Variable indicadora del tamaño de localidad para explotación | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de 1 a 9 999 habitantes; 2 = Localidades con una población de 10 000 y más habitantes';
COMMENT ON COLUMN enut.thogar.est_dis IS 'Estrato de Diseño Muestral | Descriptor: Alfanumérico, tamaño 4. | Códigos/conceptos: 0001 - 0342 = Estrato de Diseño Muestral';
COMMENT ON COLUMN enut.thogar.upm_dis IS 'Unidad Primaria de Muestreo | Descriptor: Alfanumérico, tamaño 5. | Códigos/conceptos: 00001 - 04208 = Unidad Primaria de Muestreo';
COMMENT ON COLUMN enut.thogar.fac_hog IS 'Factor | Descriptor: Numérico, tamaño 5. | Códigos/conceptos: 00007 - 12654 = Factor';
COMMENT ON COLUMN enut.thogar.control IS 'Control de Vivienda | Descriptor: Alfanumérico, tamaño 7. | Códigos/conceptos: 0100094 - 3261231 = Número de Control de la Vivienda';
COMMENT ON COLUMN enut.thogar.viv_sel IS 'Número de Vivienda Seleccionada | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 24 = Número de Vivienda Seleccionada';
COMMENT ON COLUMN enut.thogar.hogar IS 'Número de Hogar en la Vivienda | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 - 5 = Número de Hogar en la Vivienda';

CREATE INDEX idx_thogar_llaveviv ON enut.thogar (llaveviv);

--- Bloque. Tabla TSDEM 

CREATE TABLE enut.tsdem (
    llavesde VARCHAR(12) PRIMARY KEY,
    llaveviv VARCHAR(9),
    llavehog VARCHAR(10),
    paren VARCHAR(1),
    parenc VARCHAR(3),
    sexo VARCHAR(1),
    edad VARCHAR(2),
    p3_6_1 VARCHAR(1),
    p3_6_2 VARCHAR(1),
    p3_6_3 VARCHAR(1),
    p3_6_4 VARCHAR(1),
    p3_6_5 VARCHAR(1),
    p3_6_6 VARCHAR(1),
    p3_6_7 VARCHAR(1),
    p3_6_8 VARCHAR(1),
    p3_7 VARCHAR(1),
    p3_8 VARCHAR(1),
    p3_9 VARCHAR(2),
    p3_10 VARCHAR(1),
    p3_11 VARCHAR(1),
    p3_12 VARCHAR(1),
    p3_13 VARCHAR(2),
    cvegeo VARCHAR(2),
    cve_ent VARCHAR(2),
    tloc VARCHAR(1),
    menor10 VARCHAR(1),
    est_dis VARCHAR(4),
    upm_dis VARCHAR(5),
    fac_hog NUMERIC(5,0),
    control VARCHAR(7),
    viv_sel VARCHAR(2),
    hogar VARCHAR(1),
    n_ren VARCHAR(2),
    CONSTRAINT fk_tsdem_llaveviv FOREIGN KEY (llaveviv) REFERENCES enut.tvivienda (llaveviv),
    CONSTRAINT fk_tsdem_llavehog FOREIGN KEY (llavehog) REFERENCES enut.thogar (llavehog)
);

COMMENT ON TABLE enut.tsdem IS 'ENUT 2024. Hoja TSDEM de enut_2024_fd.xlsx. 33 columnas.';
COMMENT ON COLUMN enut.tsdem.llavesde IS 'Llave de identificación de la tabla sociodemográfica | Descriptor: Alfanumérico, tamaño 12. | Códigos/conceptos: 010009401101 - 326123120102 = Llave de identificación de la tabla sociodemografica';
COMMENT ON COLUMN enut.tsdem.llaveviv IS 'Llave de identificación de la vivienda | Descriptor: Alfanumérico, tamaño 9. | Códigos/conceptos: 010009401 - 326123120 = Llave de identificación de la vivienda';
COMMENT ON COLUMN enut.tsdem.llavehog IS 'Llave de identificación del hogar | Descriptor: Alfanumérico, tamaño 10. | Códigos/conceptos: 0100094011 - 3261231201 = Llave de identificación del hogar';
COMMENT ON COLUMN enut.tsdem.paren IS '3.3 ¿Qué es (NOMBRE) de la (del) jefa(e) del hogar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Jefa(e); 2 = Esposa(o) o compañera(o); 3 = Hija(o); 4 = Nieta(o); 5 = Nuera o yerno; 6 = Madre, padre o suegra(o); 7 = Otro parentesco (Especifique); 8 = Sin parentesco';
COMMENT ON COLUMN enut.tsdem.parenc IS '3.3 ¿Qué es (NOMBRE) de la (del) jefa(e) del hogar? - Otro parentesco (codificada) | Descriptor: Alfanumérico, tamaño 3. | Códigos/conceptos: 201 - 999 = Consultar ''CATÁLOGO ENUT 2024'', pestaña ''PARENTESCO_PARENC 2024''; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tsdem.sexo IS '3.4 (NOMBRE) es hombre (NOMBRE) es mujer | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Hombre; 2 = Mujer';
COMMENT ON COLUMN enut.tsdem.edad IS '3.5 ¿Cuántos años cumplidos tiene (NOMBRE)? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 = Menos de un año; 01 - 96 = Años cumplidos; 97 = 97 años y más; 98 = No sabe, en personas de 12 años y más; 99 = No sabe, en personas menores de 12 años';
COMMENT ON COLUMN enut.tsdem.p3_6_1 IS '3.6 En su vida diaria, ¿(NOMBRE) cuánta dificultad tiene para ver, aun usando lentes? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = No tiene dificultad; 2 = Lo hace con poca dificultad; 3 = Lo hace con mucha dificultad; 4 = No puede hacerlo';
COMMENT ON COLUMN enut.tsdem.p3_6_2 IS '3.6 En su vida diaria, ¿(NOMBRE) cuánta dificultad tiene para oír, aun usando aparato auditivo? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = No tiene dificultad; 2 = Lo hace con poca dificultad; 3 = Lo hace con mucha dificultad; 4 = No puede hacerlo';
COMMENT ON COLUMN enut.tsdem.p3_6_3 IS '3.6 En su vida diaria, ¿(NOMBRE) cuánta dificultad tiene para mover o usar sus brazos o manos? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = No tiene dificultad; 2 = Lo hace con poca dificultad; 3 = Lo hace con mucha dificultad; 4 = No puede hacerlo';
COMMENT ON COLUMN enut.tsdem.p3_6_4 IS '3.6 En su vida diaria, ¿(NOMBRE) cuánta dificultad tiene para caminar, subir o bajar usando sus piernas? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = No tiene dificultad; 2 = Lo hace con poca dificultad; 3 = Lo hace con mucha dificultad; 4 = No puede hacerlo';
COMMENT ON COLUMN enut.tsdem.p3_6_5 IS '3.6 En su vida diaria, ¿(NOMBRE) cuánta dificultad tiene para recordar o concentrarse? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = No tiene dificultad; 2 = Lo hace con poca dificultad; 3 = Lo hace con mucha dificultad; 4 = No puede hacerlo';
COMMENT ON COLUMN enut.tsdem.p3_6_6 IS '3.6 En su vida diaria, ¿(NOMBRE) cuánta dificultad tiene para bañarse, vestirse o comer? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = No tiene dificultad; 2 = Lo hace con poca dificultad; 3 = Lo hace con mucha dificultad; 4 = No puede hacerlo';
COMMENT ON COLUMN enut.tsdem.p3_6_7 IS '3.6 En su vida diaria, ¿(NOMBRE) cuánta dificultad tiene para hablar o comunicarse (por ejemplo, entender o ser entendido por otros)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = No tiene dificultad; 2 = Lo hace con poca dificultad; 3 = Lo hace con mucha dificultad; 4 = No puede hacerlo';
COMMENT ON COLUMN enut.tsdem.p3_6_8 IS '3.6 En su vida diaria, ¿(NOMBRE) cuánta dificultad tiene para realizar sus actividades diarias por alguna condición emocional o mental (con autonomía e independencia)? Condición de salud como autismo, depresión, bipolaridad, esquizofrenia, etcétera. | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = No tiene dificultad; 2 = Lo hace con poca dificultad; 3 = Lo hace con mucha dificultad; 4 = No puede hacerlo';
COMMENT ON COLUMN enut.tsdem.p3_7 IS '3.7 La semana pasada, (NOMBRE) por la dificultad que tiene para (RESPUESTA DE 3.6), ¿necesitó de los cuidados de otra persona? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tsdem.p3_8 IS '3.8 La semana pasada, ¿(NOMBRE) necesitó de los cuidados de otra persona por tener alguna enfermedad crónica o temporal? ¿Necesitó cuidados por enfermedad... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = crónica?; 2 = temporal?; 3 = No; 9 = No sabe';
COMMENT ON COLUMN enut.tsdem.p3_9 IS '3.9 Cuando (NOMBRE) tiene problemas de salud, ¿en dónde se atiende? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Centros de salud (Secretaría de Salud); 02 = Hospital o instituto (Secretaría de Salud); 03 = Seguro Social o IMSS; 04 = IMSS-Prospera/IMSS-Bienestar; 05 = ISSSTE; 06 = ISSSTE estatal; 07 = Otro servicio médico público (PEMEX, Defensa, Marina, DIF, INI); 08 = Consultorios y hospitales privados; 09 = Consultorio de farmacias; 10 = Curandero, hierbero, comadrona, brujo, etcétera; 11 = No se atiende; 12 = Otro (Especifique)';
COMMENT ON COLUMN enut.tsdem.p3_10 IS '3.10 ¿(NOMBRE) asiste actualmente a educación inicial, estancia, guardería, preescolar o kínder? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tsdem.p3_11 IS '3.11 ¿Cuál es la razón principal por la que (NOMBRE) no asiste a educación inicial, estancia, guardería, preescolar o kínder? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = La mamá o el papá de la (del) niña(o) u otro familiar lo cuida/no tiene necesidad; 2 = Por falta de dinero o recursos; 3 = No había cupo, está en lista de espera; 4 = No hay guardería o estancia infantil, está en malas condiciones o queda lejos; 5 = Los horarios no se ajustan a las necesidades de su mamá / papá / tutor(a); 6 = Está pequeña(o), no cumple la edad para el kínder; 7 = Por discapacidad; 8 = Otra (Especifique); 9 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tsdem.p3_12 IS '3.12 ¿(NOMBRE) asiste actualmente a la escuela? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tsdem.p3_13 IS '3.13 ¿Cuál es la razón principal por la que (NOMBRE) no asiste o dejó de asistir a la escuela? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Por falta de dinero o recursos; 02 = Tenía que trabajar o entró a trabajar para ayudar a los gastos del hogar; 03 = Falta de interés o aptitud para la escuela (no quiso o no le gustó); 04 = Se unió o casó; 05 = Se embarazó o embarazó a alguien; 06 = No había cupo, está en lista de espera; 07 = No hay escuela, está en malas condiciones o queda lejos; 08 = Tenía que hacer trabajo doméstico, cuidar a sus hijas(os) o a un familiar u otra persona; 09 = Por discapacidad; 10 = Se graduó o logró su meta educativa; 11 = Otra (Especifique); 99 = No sabe; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tsdem.cvegeo IS 'Clave geográfica | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.tsdem.cve_ent IS 'Entidad | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.tsdem.tloc IS 'Tamaño de Localidad | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de entre 100 000 y más habitantes; 2 = Localidades con una población de entre 15 000 y 99 999 habitantes; 3 = Localidades con una población de entre 2 500 y 14 999 habitantes; 4 = Localidades con una población de menos de 2 500 habitantes';
COMMENT ON COLUMN enut.tsdem.menor10 IS 'Variable indicadora del tamaño de localidad para explotación | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de 1 a 9 999 habitantes; 2 = Localidades con una población de 10 000 y más habitantes';
COMMENT ON COLUMN enut.tsdem.est_dis IS 'Estrato de Diseño Muestral | Descriptor: Alfanumérico, tamaño 4. | Códigos/conceptos: 0001 - 0342 = Estrato de Diseño Muestral';
COMMENT ON COLUMN enut.tsdem.upm_dis IS 'Unidad Primaria de Muestreo | Descriptor: Alfanumérico, tamaño 5. | Códigos/conceptos: 00001 - 04208 = Unidad Primaria de Muestreo';
COMMENT ON COLUMN enut.tsdem.fac_hog IS 'Factor | Descriptor: Numérico, tamaño 5. | Códigos/conceptos: 00007 - 12654 = Factor';
COMMENT ON COLUMN enut.tsdem.control IS 'Control de Vivienda | Descriptor: Alfanumérico, tamaño 7. | Códigos/conceptos: 0100094 - 3261231 = Número de Control de la Vivienda';
COMMENT ON COLUMN enut.tsdem.viv_sel IS 'Número de Vivienda Seleccionada | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 24 = Número de Vivienda Seleccionada';
COMMENT ON COLUMN enut.tsdem.hogar IS 'Número de Hogar en la Vivienda | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 - 5 = Número de Hogar en la Vivienda';
COMMENT ON COLUMN enut.tsdem.n_ren IS 'Número de Renglón de la Persona | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 18 = Número de Renglón de la Persona';

CREATE INDEX idx_tsdem_llaveviv ON enut.tsdem (llaveviv);
CREATE INDEX idx_tsdem_llavehog ON enut.tsdem (llavehog);

--- Bloque. Tabla TMODULO

CREATE TABLE enut.tmodulo (
    llavemod VARCHAR(12) PRIMARY KEY,
    llaveviv VARCHAR(9),
    llavehog VARCHAR(10),
    sexo VARCHAR(1),
    edad_v VARCHAR(2),
    p4_1 VARCHAR(1),
    p4_1c VARCHAR(4),
    niv VARCHAR(2),
    gra VARCHAR(1),
    p4_3 VARCHAR(1),
    p4_4 VARCHAR(1),
    p4_5 VARCHAR(1),
    p4_6 VARCHAR(1),
    p4_7 VARCHAR(1),
    p5_1 VARCHAR(1),
    p5_2 VARCHAR(1),
    p5_3c VARCHAR(4),
    p5_5 VARCHAR(1),
    p5_6_1 VARCHAR(1),
    p5_6_2 VARCHAR(1),
    p5_6_3 VARCHAR(1),
    p5_6_4 VARCHAR(1),
    p5_6_5 VARCHAR(1),
    p5_6_6 VARCHAR(1),
    p5_6_7 VARCHAR(1),
    p5_6_8 VARCHAR(1),
    p5_7 VARCHAR(1),
    p5_8_1_1 VARCHAR(2),
    p5_8_1_2 VARCHAR(2),
    p5_8_1_3 VARCHAR(2),
    p5_8_1_4 VARCHAR(2),
    p5_8_2_1 VARCHAR(2),
    p5_8_2_2 VARCHAR(2),
    p5_8_2_3 VARCHAR(2),
    p5_8_2_4 VARCHAR(2),
    p5_9_1 VARCHAR(2),
    p5_9_2 VARCHAR(2),
    p5_9_3 VARCHAR(2),
    p5_9_4 VARCHAR(2),
    p5_10 VARCHAR(5),
    p5_10a VARCHAR(1),
    p5_11 VARCHAR(1),
    p5_12_1 VARCHAR(2),
    p5_12_2 VARCHAR(2),
    p5_12_3 VARCHAR(2),
    p5_12_4 VARCHAR(2),
    p6_1_1_1 VARCHAR(2),
    p6_1_1_2 VARCHAR(2),
    p6_1_1_3 VARCHAR(2),
    p6_1_1_4 VARCHAR(2),
    p6_1_2_1 VARCHAR(2),
    p6_1_2_2 VARCHAR(2),
    p6_1_2_3 VARCHAR(2),
    p6_1_2_4 VARCHAR(2),
    p6_1_3_1 VARCHAR(2),
    p6_1_3_2 VARCHAR(2),
    p6_1_3_3 VARCHAR(2),
    p6_1_3_4 VARCHAR(2),
    p6_2_1 VARCHAR(1),
    p6_2_1a VARCHAR(1),
    p6_2a_1_1_1 VARCHAR(2),
    p6_2a_1_1_2 VARCHAR(2),
    p6_2a_1_1_3 VARCHAR(2),
    p6_2a_1_1_4 VARCHAR(2),
    p6_2a_1_2_1 VARCHAR(2),
    p6_2a_1_2_2 VARCHAR(2),
    p6_2a_1_2_3 VARCHAR(2),
    p6_2a_1_2_4 VARCHAR(2),
    p6_2_2 VARCHAR(1),
    p6_2a_2_1 VARCHAR(2),
    p6_2a_2_2 VARCHAR(2),
    p6_2a_2_3 VARCHAR(2),
    p6_2a_2_4 VARCHAR(2),
    p6_2_3 VARCHAR(1),
    p6_2a_3_1 VARCHAR(2),
    p6_2a_3_2 VARCHAR(2),
    p6_2a_3_3 VARCHAR(2),
    p6_2a_3_4 VARCHAR(2),
    p6_3_1 VARCHAR(1),
    p6_3a_1_1 VARCHAR(2),
    p6_3a_1_2 VARCHAR(2),
    p6_3a_1_3 VARCHAR(2),
    p6_3a_1_4 VARCHAR(2),
    p6_3_2 VARCHAR(1),
    p6_3a_2_1 VARCHAR(2),
    p6_3a_2_2 VARCHAR(2),
    p6_3a_2_3 VARCHAR(2),
    p6_3a_2_4 VARCHAR(2),
    p6_3_3 VARCHAR(1),
    p6_3a_3_1 VARCHAR(2),
    p6_3a_3_2 VARCHAR(2),
    p6_3a_3_3 VARCHAR(2),
    p6_3a_3_4 VARCHAR(2),
    p6_3_4 VARCHAR(1),
    p6_3a_4_1 VARCHAR(2),
    p6_3a_4_2 VARCHAR(2),
    p6_3a_4_3 VARCHAR(2),
    p6_3a_4_4 VARCHAR(2),
    p6_3_5 VARCHAR(1),
    p6_3a_5_1 VARCHAR(2),
    p6_3a_5_2 VARCHAR(2),
    p6_3a_5_3 VARCHAR(2),
    p6_3a_5_4 VARCHAR(2),
    p6_3_6 VARCHAR(1),
    p6_3a_6_1 VARCHAR(2),
    p6_3a_6_2 VARCHAR(2),
    p6_3a_6_3 VARCHAR(2),
    p6_3a_6_4 VARCHAR(2),
    p6_3_7 VARCHAR(1),
    p6_3a_7_1 VARCHAR(2),
    p6_3a_7_2 VARCHAR(2),
    p6_3a_7_3 VARCHAR(2),
    p6_3a_7_4 VARCHAR(2),
    p6_3_8 VARCHAR(1),
    p6_3a_8_1 VARCHAR(2),
    p6_3a_8_2 VARCHAR(2),
    p6_3a_8_3 VARCHAR(2),
    p6_3a_8_4 VARCHAR(2),
    p6_3_9 VARCHAR(1),
    p6_3a_9_1 VARCHAR(2),
    p6_3a_9_2 VARCHAR(2),
    p6_3a_9_3 VARCHAR(2),
    p6_3a_9_4 VARCHAR(2),
    p6_4_1 VARCHAR(1),
    p6_4a_1_1 VARCHAR(2),
    p6_4a_1_2 VARCHAR(2),
    p6_4a_1_3 VARCHAR(2),
    p6_4a_1_4 VARCHAR(2),
    p6_4_2 VARCHAR(1),
    p6_4a_2_1 VARCHAR(2),
    p6_4a_2_2 VARCHAR(2),
    p6_4a_2_3 VARCHAR(2),
    p6_4a_2_4 VARCHAR(2),
    p6_4_3 VARCHAR(1),
    p6_4a_3_1 VARCHAR(2),
    p6_4a_3_2 VARCHAR(2),
    p6_4a_3_3 VARCHAR(2),
    p6_4a_3_4 VARCHAR(2),
    p6_4_4 VARCHAR(1),
    p6_4a_4_1 VARCHAR(2),
    p6_4a_4_2 VARCHAR(2),
    p6_4a_4_3 VARCHAR(2),
    p6_4a_4_4 VARCHAR(2),
    p6_4_5 VARCHAR(1),
    p6_4a_5_1 VARCHAR(2),
    p6_4a_5_2 VARCHAR(2),
    p6_4a_5_3 VARCHAR(2),
    p6_4a_5_4 VARCHAR(2),
    p6_5_1 VARCHAR(1),
    p6_5a_1_1 VARCHAR(2),
    p6_5a_1_2 VARCHAR(2),
    p6_5a_1_3 VARCHAR(2),
    p6_5a_1_4 VARCHAR(2),
    p6_5_2 VARCHAR(1),
    p6_5a_2_1 VARCHAR(2),
    p6_5a_2_2 VARCHAR(2),
    p6_5a_2_3 VARCHAR(2),
    p6_5a_2_4 VARCHAR(2),
    p6_5_3 VARCHAR(1),
    p6_5a_3_1 VARCHAR(2),
    p6_5a_3_2 VARCHAR(2),
    p6_5a_3_3 VARCHAR(2),
    p6_5a_3_4 VARCHAR(2),
    p6_5_4 VARCHAR(1),
    p6_5a_4_1 VARCHAR(2),
    p6_5a_4_2 VARCHAR(2),
    p6_5a_4_3 VARCHAR(2),
    p6_5a_4_4 VARCHAR(2),
    p6_5_5 VARCHAR(1),
    p6_5a_5_1 VARCHAR(2),
    p6_5a_5_2 VARCHAR(2),
    p6_5a_5_3 VARCHAR(2),
    p6_5a_5_4 VARCHAR(2),
    p6_6_1 VARCHAR(1),
    p6_6a_1_1 VARCHAR(2),
    p6_6a_1_2 VARCHAR(2),
    p6_6a_1_3 VARCHAR(2),
    p6_6a_1_4 VARCHAR(2),
    p6_6_2 VARCHAR(1),
    p6_6a_2_1 VARCHAR(2),
    p6_6a_2_2 VARCHAR(2),
    p6_6a_2_3 VARCHAR(2),
    p6_6a_2_4 VARCHAR(2),
    p6_6_3 VARCHAR(1),
    p6_6a_3_1 VARCHAR(2),
    p6_6a_3_2 VARCHAR(2),
    p6_6a_3_3 VARCHAR(2),
    p6_6a_3_4 VARCHAR(2),
    p6_6_4 VARCHAR(1),
    p6_6a_4_1 VARCHAR(2),
    p6_6a_4_2 VARCHAR(2),
    p6_6a_4_3 VARCHAR(2),
    p6_6a_4_4 VARCHAR(2),
    p6_6_5 VARCHAR(1),
    p6_6a_5_1 VARCHAR(2),
    p6_6a_5_2 VARCHAR(2),
    p6_6a_5_3 VARCHAR(2),
    p6_6a_5_4 VARCHAR(2),
    p6_7_1 VARCHAR(1),
    p6_7a_1_1 VARCHAR(2),
    p6_7a_1_2 VARCHAR(2),
    p6_7a_1_3 VARCHAR(2),
    p6_7a_1_4 VARCHAR(2),
    p6_7_2 VARCHAR(1),
    p6_7a_2_1 VARCHAR(2),
    p6_7a_2_2 VARCHAR(2),
    p6_7a_2_3 VARCHAR(2),
    p6_7a_2_4 VARCHAR(2),
    p6_7_3 VARCHAR(1),
    p6_7a_3_1 VARCHAR(2),
    p6_7a_3_2 VARCHAR(2),
    p6_7a_3_3 VARCHAR(2),
    p6_7a_3_4 VARCHAR(2),
    p6_7_4 VARCHAR(1),
    p6_7a_4_1 VARCHAR(2),
    p6_7a_4_2 VARCHAR(2),
    p6_7a_4_3 VARCHAR(2),
    p6_7a_4_4 VARCHAR(2),
    p6_8_1 VARCHAR(1),
    p6_8a_1_1 VARCHAR(2),
    p6_8a_1_2 VARCHAR(2),
    p6_8a_1_3 VARCHAR(2),
    p6_8a_1_4 VARCHAR(2),
    p6_8_2 VARCHAR(1),
    p6_8a_2_1 VARCHAR(2),
    p6_8a_2_2 VARCHAR(2),
    p6_8a_2_3 VARCHAR(2),
    p6_8a_2_4 VARCHAR(2),
    p6_8_3 VARCHAR(1),
    p6_8a_3_1 VARCHAR(2),
    p6_8a_3_2 VARCHAR(2),
    p6_8a_3_3 VARCHAR(2),
    p6_8a_3_4 VARCHAR(2),
    p6_9_1 VARCHAR(1),
    p6_9a_1_1 VARCHAR(2),
    p6_9a_1_2 VARCHAR(2),
    p6_9a_1_3 VARCHAR(2),
    p6_9a_1_4 VARCHAR(2),
    p6_9_2 VARCHAR(1),
    p6_9a_2_1 VARCHAR(2),
    p6_9a_2_2 VARCHAR(2),
    p6_9a_2_3 VARCHAR(2),
    p6_9a_2_4 VARCHAR(2),
    p6_9_3 VARCHAR(1),
    p6_9a_3_1 VARCHAR(2),
    p6_9a_3_2 VARCHAR(2),
    p6_9a_3_3 VARCHAR(2),
    p6_9a_3_4 VARCHAR(2),
    p6_10_1 VARCHAR(1),
    p6_10a_1_1 VARCHAR(2),
    p6_10a_1_2 VARCHAR(2),
    p6_10a_1_3 VARCHAR(2),
    p6_10a_1_4 VARCHAR(2),
    p6_10_2 VARCHAR(1),
    p6_10a_2_1 VARCHAR(2),
    p6_10a_2_2 VARCHAR(2),
    p6_10a_2_3 VARCHAR(2),
    p6_10a_2_4 VARCHAR(2),
    p6_10_3 VARCHAR(1),
    p6_10a_3_1 VARCHAR(2),
    p6_10a_3_2 VARCHAR(2),
    p6_10a_3_3 VARCHAR(2),
    p6_10a_3_4 VARCHAR(2),
    p6_10_4 VARCHAR(1),
    p6_10a_4_1 VARCHAR(2),
    p6_10a_4_2 VARCHAR(2),
    p6_10a_4_3 VARCHAR(2),
    p6_10a_4_4 VARCHAR(2),
    p6_10_5 VARCHAR(1),
    p6_10a_5_1 VARCHAR(2),
    p6_10a_5_2 VARCHAR(2),
    p6_10a_5_3 VARCHAR(2),
    p6_10a_5_4 VARCHAR(2),
    p6_10_6 VARCHAR(1),
    p6_10a_6_1 VARCHAR(2),
    p6_10a_6_2 VARCHAR(2),
    p6_10a_6_3 VARCHAR(2),
    p6_10a_6_4 VARCHAR(2),
    p6_10_7 VARCHAR(1),
    p6_10a_7_1 VARCHAR(2),
    p6_10a_7_2 VARCHAR(2),
    p6_10a_7_3 VARCHAR(2),
    p6_10a_7_4 VARCHAR(2),
    filtro_s6_11 VARCHAR(1),
    p6_11_01 VARCHAR(1),
    p6_11a_01_1 VARCHAR(2),
    p6_11a_01_2 VARCHAR(2),
    p6_11a_01_3 VARCHAR(2),
    p6_11a_01_4 VARCHAR(2),
    p6_11_02 VARCHAR(1),
    p6_11a_02_1 VARCHAR(2),
    p6_11a_02_2 VARCHAR(2),
    p6_11a_02_3 VARCHAR(2),
    p6_11a_02_4 VARCHAR(2),
    p6_11_03 VARCHAR(1),
    p6_11a_03_1 VARCHAR(2),
    p6_11a_03_2 VARCHAR(2),
    p6_11a_03_3 VARCHAR(2),
    p6_11a_03_4 VARCHAR(2),
    p6_11_04 VARCHAR(1),
    p6_11a_04_1 VARCHAR(2),
    p6_11a_04_2 VARCHAR(2),
    p6_11a_04_3 VARCHAR(2),
    p6_11a_04_4 VARCHAR(2),
    p6_11_05 VARCHAR(1),
    p6_11a_05_1 VARCHAR(2),
    p6_11a_05_2 VARCHAR(2),
    p6_11a_05_3 VARCHAR(2),
    p6_11a_05_4 VARCHAR(2),
    p6_11_06 VARCHAR(1),
    p6_11a_06_1 VARCHAR(2),
    p6_11a_06_2 VARCHAR(2),
    p6_11a_06_3 VARCHAR(2),
    p6_11a_06_4 VARCHAR(2),
    p6_11_07 VARCHAR(1),
    p6_11a_07_1 VARCHAR(2),
    p6_11a_07_2 VARCHAR(2),
    p6_11a_07_3 VARCHAR(2),
    p6_11a_07_4 VARCHAR(2),
    p6_11_08 VARCHAR(1),
    p6_11a_08_1 VARCHAR(2),
    p6_11a_08_2 VARCHAR(2),
    p6_11a_08_3 VARCHAR(2),
    p6_11a_08_4 VARCHAR(2),
    p6_11_09 VARCHAR(1),
    p6_11a_09_1 VARCHAR(2),
    p6_11a_09_2 VARCHAR(2),
    p6_11a_09_3 VARCHAR(2),
    p6_11a_09_4 VARCHAR(2),
    p6_11_10 VARCHAR(1),
    p6_11a_10_1 VARCHAR(2),
    p6_11a_10_2 VARCHAR(2),
    p6_11a_10_3 VARCHAR(2),
    p6_11a_10_4 VARCHAR(2),
    p6_11_11 VARCHAR(1),
    p6_11a_11_1 VARCHAR(2),
    p6_11a_11_2 VARCHAR(2),
    p6_11a_11_3 VARCHAR(2),
    p6_11a_11_4 VARCHAR(2),
    p6_11_12 VARCHAR(1),
    p6_11a_12_1 VARCHAR(2),
    p6_11a_12_2 VARCHAR(2),
    p6_11a_12_3 VARCHAR(2),
    p6_11a_12_4 VARCHAR(2),
    p6_11_13 VARCHAR(1),
    p6_11a_13_1 VARCHAR(2),
    p6_11a_13_2 VARCHAR(2),
    p6_11a_13_3 VARCHAR(2),
    p6_11a_13_4 VARCHAR(2),
    p6_11_14 VARCHAR(1),
    p6_11a_14_1 VARCHAR(2),
    p6_11a_14_2 VARCHAR(2),
    p6_11a_14_3 VARCHAR(2),
    p6_11a_14_4 VARCHAR(2),
    filtro_s6_12 VARCHAR(1),
    p6_12_01 VARCHAR(1),
    p6_12a_01_1 VARCHAR(2),
    p6_12a_01_2 VARCHAR(2),
    p6_12a_01_3 VARCHAR(2),
    p6_12a_01_4 VARCHAR(2),
    p6_12_02 VARCHAR(1),
    p6_12a_02_1 VARCHAR(2),
    p6_12a_02_2 VARCHAR(2),
    p6_12a_02_3 VARCHAR(2),
    p6_12a_02_4 VARCHAR(2),
    p6_12_03 VARCHAR(1),
    p6_12a_03_1 VARCHAR(2),
    p6_12a_03_2 VARCHAR(2),
    p6_12a_03_3 VARCHAR(2),
    p6_12a_03_4 VARCHAR(2),
    p6_12_04 VARCHAR(1),
    p6_12a_04_1 VARCHAR(2),
    p6_12a_04_2 VARCHAR(2),
    p6_12a_04_3 VARCHAR(2),
    p6_12a_04_4 VARCHAR(2),
    p6_12_05 VARCHAR(1),
    p6_12a_05_1 VARCHAR(2),
    p6_12a_05_2 VARCHAR(2),
    p6_12a_05_3 VARCHAR(2),
    p6_12a_05_4 VARCHAR(2),
    p6_12_06 VARCHAR(1),
    p6_12a_06_1 VARCHAR(2),
    p6_12a_06_2 VARCHAR(2),
    p6_12a_06_3 VARCHAR(2),
    p6_12a_06_4 VARCHAR(2),
    p6_12_07 VARCHAR(1),
    p6_12a_07_1 VARCHAR(2),
    p6_12a_07_2 VARCHAR(2),
    p6_12a_07_3 VARCHAR(2),
    p6_12a_07_4 VARCHAR(2),
    p6_12_08 VARCHAR(1),
    p6_12a_08_1 VARCHAR(2),
    p6_12a_08_2 VARCHAR(2),
    p6_12a_08_3 VARCHAR(2),
    p6_12a_08_4 VARCHAR(2),
    p6_12_09 VARCHAR(1),
    p6_12a_09_1 VARCHAR(2),
    p6_12a_09_2 VARCHAR(2),
    p6_12a_09_3 VARCHAR(2),
    p6_12a_09_4 VARCHAR(2),
    p6_12_10 VARCHAR(1),
    p6_12a_10_1 VARCHAR(2),
    p6_12a_10_2 VARCHAR(2),
    p6_12a_10_3 VARCHAR(2),
    p6_12a_10_4 VARCHAR(2),
    p6_12_11 VARCHAR(1),
    p6_12a_11_1 VARCHAR(2),
    p6_12a_11_2 VARCHAR(2),
    p6_12a_11_3 VARCHAR(2),
    p6_12a_11_4 VARCHAR(2),
    p6_12_12 VARCHAR(1),
    p6_12a_12_1 VARCHAR(2),
    p6_12a_12_2 VARCHAR(2),
    p6_12a_12_3 VARCHAR(2),
    p6_12a_12_4 VARCHAR(2),
    filtro_s6_13 VARCHAR(1),
    p6_13_1 VARCHAR(1),
    p6_13a_1_1 VARCHAR(2),
    p6_13a_1_2 VARCHAR(2),
    p6_13a_1_3 VARCHAR(2),
    p6_13a_1_4 VARCHAR(2),
    p6_13_2 VARCHAR(1),
    p6_13a_2_1 VARCHAR(2),
    p6_13a_2_2 VARCHAR(2),
    p6_13a_2_3 VARCHAR(2),
    p6_13a_2_4 VARCHAR(2),
    p6_13_3 VARCHAR(1),
    p6_13a_3_1 VARCHAR(2),
    p6_13a_3_2 VARCHAR(2),
    p6_13a_3_3 VARCHAR(2),
    p6_13a_3_4 VARCHAR(2),
    p6_13_4 VARCHAR(1),
    p6_13a_4_1 VARCHAR(2),
    p6_13a_4_2 VARCHAR(2),
    p6_13a_4_3 VARCHAR(2),
    p6_13a_4_4 VARCHAR(2),
    p6_13_5 VARCHAR(1),
    p6_13a_5_1 VARCHAR(2),
    p6_13a_5_2 VARCHAR(2),
    p6_13a_5_3 VARCHAR(2),
    p6_13a_5_4 VARCHAR(2),
    p6_13_6 VARCHAR(1),
    p6_13a_6_1 VARCHAR(2),
    p6_13a_6_2 VARCHAR(2),
    p6_13a_6_3 VARCHAR(2),
    p6_13a_6_4 VARCHAR(2),
    p6_13_7 VARCHAR(1),
    p6_13a_7_1 VARCHAR(2),
    p6_13a_7_2 VARCHAR(2),
    p6_13a_7_3 VARCHAR(2),
    p6_13a_7_4 VARCHAR(2),
    p6_13_8 VARCHAR(1),
    p6_13a_8_1 VARCHAR(2),
    p6_13a_8_2 VARCHAR(2),
    p6_13a_8_3 VARCHAR(2),
    p6_13a_8_4 VARCHAR(2),
    p6_13_9 VARCHAR(1),
    p6_13a_9_1 VARCHAR(2),
    p6_13a_9_2 VARCHAR(2),
    p6_13a_9_3 VARCHAR(2),
    p6_13a_9_4 VARCHAR(2),
    filtro_s6_14 VARCHAR(1),
    p6_14_1 VARCHAR(1),
    p6_14a_1_1 VARCHAR(2),
    p6_14a_1_2 VARCHAR(2),
    p6_14a_1_3 VARCHAR(2),
    p6_14a_1_4 VARCHAR(2),
    p6_14_2 VARCHAR(1),
    p6_14a_2_1 VARCHAR(2),
    p6_14a_2_2 VARCHAR(2),
    p6_14a_2_3 VARCHAR(2),
    p6_14a_2_4 VARCHAR(2),
    p6_14_3 VARCHAR(1),
    p6_14a_3_1 VARCHAR(2),
    p6_14a_3_2 VARCHAR(2),
    p6_14a_3_3 VARCHAR(2),
    p6_14a_3_4 VARCHAR(2),
    p6_14_4 VARCHAR(1),
    p6_14a_4_1 VARCHAR(2),
    p6_14a_4_2 VARCHAR(2),
    p6_14a_4_3 VARCHAR(2),
    p6_14a_4_4 VARCHAR(2),
    p6_14_5 VARCHAR(1),
    p6_14a_5_1 VARCHAR(2),
    p6_14a_5_2 VARCHAR(2),
    p6_14a_5_3 VARCHAR(2),
    p6_14a_5_4 VARCHAR(2),
    p6_14_6 VARCHAR(1),
    p6_14a_6_1 VARCHAR(2),
    p6_14a_6_2 VARCHAR(2),
    p6_14a_6_3 VARCHAR(2),
    p6_14a_6_4 VARCHAR(2),
    filtro_s6_15 VARCHAR(1),
    p6_15_1 VARCHAR(1),
    p6_15a_1_1 VARCHAR(2),
    p6_15a_1_2 VARCHAR(2),
    p6_15a_1_3 VARCHAR(2),
    p6_15a_1_4 VARCHAR(2),
    p6_15_2 VARCHAR(1),
    p6_15a_2_1 VARCHAR(2),
    p6_15a_2_2 VARCHAR(2),
    p6_15a_2_3 VARCHAR(2),
    p6_15a_2_4 VARCHAR(2),
    p6_15_3 VARCHAR(1),
    p6_15a_3_1 VARCHAR(2),
    p6_15a_3_2 VARCHAR(2),
    p6_15a_3_3 VARCHAR(2),
    p6_15a_3_4 VARCHAR(2),
    p6_15_4 VARCHAR(1),
    p6_15a_4_1 VARCHAR(2),
    p6_15a_4_2 VARCHAR(2),
    p6_15a_4_3 VARCHAR(2),
    p6_15a_4_4 VARCHAR(2),
    p6_15_5 VARCHAR(1),
    p6_15a_5_1 VARCHAR(2),
    p6_15a_5_2 VARCHAR(2),
    p6_15a_5_3 VARCHAR(2),
    p6_15a_5_4 VARCHAR(2),
    p6_15_6 VARCHAR(1),
    p6_15a_6_1 VARCHAR(2),
    p6_15a_6_2 VARCHAR(2),
    p6_15a_6_3 VARCHAR(2),
    p6_15a_6_4 VARCHAR(2),
    p6_15_7 VARCHAR(1),
    p6_15a_7_1 VARCHAR(2),
    p6_15a_7_2 VARCHAR(2),
    p6_15a_7_3 VARCHAR(2),
    p6_15a_7_4 VARCHAR(2),
    p6_16_1 VARCHAR(1),
    p6_16a_1_1 VARCHAR(2),
    p6_16a_1_2 VARCHAR(2),
    p6_16a_1_3 VARCHAR(2),
    p6_16a_1_4 VARCHAR(2),
    p6_16_2 VARCHAR(1),
    p6_16a_2_1 VARCHAR(2),
    p6_16a_2_2 VARCHAR(2),
    p6_16a_2_3 VARCHAR(2),
    p6_16a_2_4 VARCHAR(2),
    p6_16_3 VARCHAR(1),
    p6_16a_3_1 VARCHAR(2),
    p6_16a_3_2 VARCHAR(2),
    p6_16a_3_3 VARCHAR(2),
    p6_16a_3_4 VARCHAR(2),
    p6_16_4 VARCHAR(1),
    p6_16a_4_1 VARCHAR(2),
    p6_16a_4_2 VARCHAR(2),
    p6_16a_4_3 VARCHAR(2),
    p6_16a_4_4 VARCHAR(2),
    p6_16_5 VARCHAR(1),
    p6_16a_5_1 VARCHAR(2),
    p6_16a_5_2 VARCHAR(2),
    p6_16a_5_3 VARCHAR(2),
    p6_16a_5_4 VARCHAR(2),
    p6_16_6 VARCHAR(1),
    p6_16a_6_1 VARCHAR(2),
    p6_16a_6_2 VARCHAR(2),
    p6_16a_6_3 VARCHAR(2),
    p6_16a_6_4 VARCHAR(2),
    p6_17_1 VARCHAR(1),
    p6_17a_1_1 VARCHAR(2),
    p6_17a_1_2 VARCHAR(2),
    p6_17a_1_3 VARCHAR(2),
    p6_17a_1_4 VARCHAR(2),
    p6_17_2 VARCHAR(1),
    p6_17a_2_1 VARCHAR(2),
    p6_17a_2_2 VARCHAR(2),
    p6_17a_2_3 VARCHAR(2),
    p6_17a_2_4 VARCHAR(2),
    p6_17_3 VARCHAR(1),
    p6_17a_3_1 VARCHAR(2),
    p6_17a_3_2 VARCHAR(2),
    p6_17a_3_3 VARCHAR(2),
    p6_17a_3_4 VARCHAR(2),
    p6_18 VARCHAR(1),
    p6_18a_1 VARCHAR(2),
    p6_18a_2 VARCHAR(2),
    p6_18a_3 VARCHAR(2),
    p6_18a_4 VARCHAR(2),
    p6_19_1 VARCHAR(1),
    p6_19a_1_1 VARCHAR(2),
    p6_19a_1_2 VARCHAR(2),
    p6_19a_1_3 VARCHAR(2),
    p6_19a_1_4 VARCHAR(2),
    p6_19_2 VARCHAR(1),
    p6_19a_2_1 VARCHAR(2),
    p6_19a_2_2 VARCHAR(2),
    p6_19a_2_3 VARCHAR(2),
    p6_19a_2_4 VARCHAR(2),
    p6_20_1 VARCHAR(1),
    p6_20a_1_1 VARCHAR(2),
    p6_20a_1_2 VARCHAR(2),
    p6_20a_1_3 VARCHAR(2),
    p6_20a_1_4 VARCHAR(2),
    p6_20_2 VARCHAR(1),
    p6_20a_2_1 VARCHAR(2),
    p6_20a_2_2 VARCHAR(2),
    p6_20a_2_3 VARCHAR(2),
    p6_20a_2_4 VARCHAR(2),
    p6_21_1 VARCHAR(1),
    p6_21a_1_1 VARCHAR(2),
    p6_21a_1_2 VARCHAR(2),
    p6_21a_1_3 VARCHAR(2),
    p6_21a_1_4 VARCHAR(2),
    p6_21_2 VARCHAR(1),
    p6_21a_2_1 VARCHAR(2),
    p6_21a_2_2 VARCHAR(2),
    p6_21a_2_3 VARCHAR(2),
    p6_21a_2_4 VARCHAR(2),
    p6_21_3 VARCHAR(1),
    p6_21a_3_1 VARCHAR(2),
    p6_21a_3_2 VARCHAR(2),
    p6_21a_3_3 VARCHAR(2),
    p6_21a_3_4 VARCHAR(2),
    p6_21_4 VARCHAR(1),
    p6_21a_4_1 VARCHAR(2),
    p6_21a_4_2 VARCHAR(2),
    p6_21a_4_3 VARCHAR(2),
    p6_21a_4_4 VARCHAR(2),
    p6_22_1 VARCHAR(1),
    p6_22a_1_1 VARCHAR(2),
    p6_22a_1_2 VARCHAR(2),
    p6_22a_1_3 VARCHAR(2),
    p6_22a_1_4 VARCHAR(2),
    p6_22_2 VARCHAR(1),
    p6_22a_2_1 VARCHAR(2),
    p6_22a_2_2 VARCHAR(2),
    p6_22a_2_3 VARCHAR(2),
    p6_22a_2_4 VARCHAR(2),
    p6_22_3 VARCHAR(1),
    p6_22a_3_1 VARCHAR(2),
    p6_22a_3_2 VARCHAR(2),
    p6_22a_3_3 VARCHAR(2),
    p6_22a_3_4 VARCHAR(2),
    p6_22_4 VARCHAR(1),
    p6_22a_4_1 VARCHAR(2),
    p6_22a_4_2 VARCHAR(2),
    p6_22a_4_3 VARCHAR(2),
    p6_22a_4_4 VARCHAR(2),
    p6_22_5 VARCHAR(1),
    p6_22a_5_1 VARCHAR(2),
    p6_22a_5_2 VARCHAR(2),
    p6_22a_5_3 VARCHAR(2),
    p6_22a_5_4 VARCHAR(2),
    p6_22_6 VARCHAR(1),
    p6_22a_6_1 VARCHAR(2),
    p6_22a_6_2 VARCHAR(2),
    p6_22a_6_3 VARCHAR(2),
    p6_22a_6_4 VARCHAR(2),
    p6_23_1 VARCHAR(1),
    p6_23a_1_1 VARCHAR(2),
    p6_23a_1_2 VARCHAR(2),
    p6_23a_1_3 VARCHAR(2),
    p6_23a_1_4 VARCHAR(2),
    p6_23_2 VARCHAR(1),
    p6_23a_2_1 VARCHAR(2),
    p6_23a_2_2 VARCHAR(2),
    p6_23a_2_3 VARCHAR(2),
    p6_23a_2_4 VARCHAR(2),
    p6_23_3 VARCHAR(1),
    p6_23_3c VARCHAR(3),
    p6_23a_3_1 VARCHAR(2),
    p6_23a_3_2 VARCHAR(2),
    p6_23a_3_3 VARCHAR(2),
    p6_23a_3_4 VARCHAR(2),
    p7_1_1 VARCHAR(1),
    p7_1_2 VARCHAR(1),
    p7_1_3 VARCHAR(1),
    p7_1_4 VARCHAR(1),
    p7_1_5 VARCHAR(1),
    p7_1_6 VARCHAR(1),
    p7_1_7 VARCHAR(1),
    p7_1_8 VARCHAR(1),
    p7_2_01 VARCHAR(2),
    p7_2_02 VARCHAR(2),
    p7_2_03 VARCHAR(2),
    p7_2_04 VARCHAR(2),
    p7_2_05 VARCHAR(2),
    p7_2_06 VARCHAR(2),
    p7_2_07 VARCHAR(2),
    p7_2_08 VARCHAR(2),
    p7_2_09 VARCHAR(2),
    p7_2_10 VARCHAR(2),
    p7_2_11 VARCHAR(2),
    cvegeo VARCHAR(2),
    cve_ent VARCHAR(2),
    tloc VARCHAR(1),
    menor10 VARCHAR(1),
    est_dis VARCHAR(4),
    upm_dis VARCHAR(5),
    fac_per NUMERIC(5,0),
    control VARCHAR(7),
    viv_sel VARCHAR(2),
    hogar VARCHAR(1),
    n_ren VARCHAR(2),
    CONSTRAINT fk_tmodulo_llaveviv FOREIGN KEY (llaveviv) REFERENCES enut.tvivienda (llaveviv),
    CONSTRAINT fk_tmodulo_llavehog FOREIGN KEY (llavehog) REFERENCES enut.thogar (llavehog)
);

COMMENT ON TABLE enut.tmodulo IS 'ENUT 2024. Hoja TMODULO de enut_2024_fd.xlsx. 694 columnas.';
COMMENT ON COLUMN enut.tmodulo.llavemod IS 'Llave de identificación de la persona elegida | Descriptor: Alfanumérico, tamaño 12. | Códigos/conceptos: 010009401101 - 326123120102 = Llave de identificación de la persona elegida';
COMMENT ON COLUMN enut.tmodulo.llaveviv IS 'Llave de identificación de la vivienda | Descriptor: Alfanumérico, tamaño 9. | Códigos/conceptos: 010009401 - 326123120 = Llave de identificación de la vivienda';
COMMENT ON COLUMN enut.tmodulo.llavehog IS 'Llave de identificación del hogar | Descriptor: Alfanumérico, tamaño 10. | Códigos/conceptos: 0100094011 - 3261231201 = Llave de identificación del hogar';
COMMENT ON COLUMN enut.tmodulo.sexo IS '3.4 (NOMBRE) es hombre (NOMBRE) es mujer | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Hombre; 2 = Mujer';
COMMENT ON COLUMN enut.tmodulo.edad_v IS 'Edad verificada | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 12 - 96 = Años; 97 = 97 años y más; 98 = No sabe, en personas de 12 años y más';
COMMENT ON COLUMN enut.tmodulo.p4_1 IS '4.1 ¿Usted habla algún dialecto o lengua indígena? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p4_1c IS '4.1c ¿Qué dialecto o lengua indígena habla? (Codificación de dialecto o lengua indígena) | Descriptor: Alfanumérico, tamaño 4. | Códigos/conceptos: 0204 - 9999 = Consultar ''CATÁLOGO ENUT 2024'', pestaña ''LENGUA INDÍGENA_P4_1C  2024''; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.niv IS '4.2 ¿Hasta qué año o grado aprobó usted en la escuela? - Nivel | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 = Ninguno; 01 = Preescolar o kínder; 02 = Primaria; 03 = Secundaria; 04 = Normal básica; 05 = Estudios técnicos con secundaria terminada; 06 = Preparatoria o bachillerato; 07 = Estudios técnicos con preparatoria terminada; 08 = Licenciatura o ingeniería (profesional); 09 = Especialidad; 10 = Maestría; 11 = Doctorado; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.gra IS '4.2 ¿Hasta qué año o grado aprobó usted en la escuela? - Grado | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 0 - 9 = Grados aprobados';
COMMENT ON COLUMN enut.tmodulo.p4_3 IS '4.3 ¿Usted sabe leer y escribir un recado? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No especificado; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p4_4 IS '4.4 Por sus antepasados y de acuerdo con sus costumbres y tradiciones, ¿usted se considera afromexicana(o)negra(o) o afrodescendiente? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p4_5 IS '4.5 Actualmente, ¿usted es una persona... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = que vive con su pareja en unión libre?; 2 = separada?; 3 = divorciada?; 4 = viuda?; 5 = casada?; 6 = soltera?';
COMMENT ON COLUMN enut.tmodulo.p4_6 IS '4.6 Por sus costumbres y tradiciones, ¿usted se considera indígena? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; 9 = No sabe';
COMMENT ON COLUMN enut.tmodulo.p4_7 IS '4.7 ¿Se considera indígena principalmente... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = porque habla lengua indígena?; 2 = porque nació o pertenece a una comunidad indígena?; 3 = porque su madre, padre o abuelos hablan o hablaban lengua indígena?; 4 = porque su madre, padre o abuelos pertenecen o pertenecieron a una comunidad indígena?; 5 = porque la comunidad le reconoce como persona indígena?; 6 = por sus costumbres y tradiciones?; 7 = por ser mexicana(o)?; 8 = ¿Otro motivo?; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_1 IS '5.1 Durante la semana pasada, ¿usted trabajó al menos una hora? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p5_2 IS '5.2 Dígame si para ganar dinero o ayudar al gasto del hogar, ¿la semana pasada usted... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = ayudó en un negocio familiar o no familiar; 2 = vendió algún producto; 3 = hizo algún producto para vender; 4 = ayudó en las labores del campo o en la cría de animales; 5 = a cambio de un pago realizó otro tipo de actividad (por ejemplo: lavó o planchó ajeno, cuidó niñas y niños); 6 = estuvo de aprendiz o haciendo su servicio social; 7 = tenía trabajo, pero estuvo ausente? (vacaciones, enfermedad, huelga, paro técnico, etcétera); 8 = Entonces, ¿no trabajó?; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_3c IS '5.3 ¿Cuáles son las tareas o funciones principales que desempeñó en su trabajo (actividad) (principal) de la semana pasada? | Descriptor: Alfanumérico, tamaño 4. | Códigos/conceptos: 1111 - 9999 = Consultar ''CATÁLOGO ENUT 2024'', pestaña ''OCUPACIÓN_P5_3C 2024''; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_5 IS '5.5 En su trabajo (actividad) (principal) de la semana pasada, ¿usted fue... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = empleada(o) u obrera(o)?; 2 = jornalera(o) o peón(a)?; 3 = ayudante con pago?; 4 = patrón(a) o empleador(a)? (Tiene personas trabajadoras por un sueldo); 5 = trabajador(a) por cuenta propia? (No tiene personas trabajadoras por un sueldo); 6 = trabajador(a) sin pago?; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_6_1 IS '5.6 Aunque no las use, ¿en su trabajo (principal) tiene derecho a licencia o incapacidad con goce de sueldo por enfermedad, accidente o maternidad (paternidad)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_6_2 IS '5.6 Aunque no las use, ¿en su trabajo (principal) tiene derecho a vacaciones con goce de sueldo? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_6_3 IS '5.6 Aunque no las use, ¿en su trabajo (principal) tiene derecho a jubilación o pensión? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_6_4 IS '5.6 Aunque no las use, ¿en su trabajo (principal) tiene derecho a sistema de ahorro para el retiro (AFORE, SAR)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_6_5 IS '5.6 Aunque no las use, ¿en su trabajo (principal) tiene derecho a guardería o estancia infantil? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_6_6 IS '5.6 Aunque no las use, ¿en su trabajo (principal) tiene derecho a licencia por cuidados maternos o paternos? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_6_7 IS '5.6 Aunque no las use, ¿en su trabajo (principal) tiene derecho a servicio médico (IMSS, ISSSTE, entre otros)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_6_8 IS '5.6 Aunque no las use, ¿en su trabajo (principal) tiene derecho a crédito para la vivienda? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_7 IS '5.7 Durante la semana pasada, ¿realizó su trabajo (actividad) (principal)... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = solamente en su lugar de trabajo de manera presencial?; 2 = solamente de manera virtual (a distancia)?; 3 = de manera presencial en su lugar de trabajo y de manera virtual (a distancia)?; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_8_1_1 IS '5.8 Durante la semana pasada, ¿en total cuánto tiempo dedicó a trabajar (su actividad) de forma presencial de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_8_1_2 IS '5.8 Durante la semana pasada, ¿en total cuánto tiempo dedicó a trabajar (su actividad) de forma presencial de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_8_1_3 IS '5.8 Durante la semana pasada, ¿en total cuánto tiempo dedicó a trabajar (su actividad) de forma presencial sábado y domingo? - Horas  | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_8_1_4 IS '5.8 Durante la semana pasada, ¿en total cuánto tiempo dedicó a trabajar (su actividad) de forma presencial sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_8_2_1 IS '5.8 Durante la semana pasada, ¿en total cuánto tiempo dedicó a trabajar (su actividad) de forma virtual de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_8_2_2 IS '5.8 Durante la semana pasada, ¿en total cuánto tiempo dedicó a trabajar (su actividad) de forma virtual de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_8_2_3 IS '5.8 Durante la semana pasada, ¿en total cuánto tiempo dedicó a trabajar (su actividad) de forma virtual sábado y domingo? - Horas  | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_8_2_4 IS '5.8 Durante la semana pasada, ¿en total cuánto tiempo dedicó a trabajar (su actividad) de forma virtual sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_9_1 IS '5.9 Durante la semana pasada, ¿cuánto tiempo utilizó en trasladarse de ida y vuelta para trabajar (a su actividad) de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 85 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_9_2 IS '5.9 Durante la semana pasada, ¿cuánto tiempo utilizó en trasladarse de ida y vuelta para trabajar (a su actividad) de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_9_3 IS '5.9 Durante la semana pasada, ¿cuánto tiempo utilizó en trasladarse de ida y vuelta para trabajar (a su actividad) sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 46 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_9_4 IS '5.9 Durante la semana pasada, ¿cuánto tiempo utilizó en trasladarse de ida y vuelta para trabajar (a su actividad) sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_10 IS '5.10 En total, ¿cuánto gana o recibe usted por trabajar (su actividad)? | Descriptor: Alfanumérico, tamaño 5. | Códigos/conceptos: 00000 = No recibe ingresos; 00001 - 95000 = Ingresos; 98000 = $98 000 y más; 99999 = No responde; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_10a IS '5.10a ¿Cada cuándo? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = A la semana; 2 = A la quincena; 3 = Al mes; 4 = Al año; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_11 IS '5.11 Entonces, ¿la semana pasada... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = buscó trabajo?; 2 = hizo gestiones o realizó trámites para iniciar un negocio o actividad por su cuenta?; 3 = rentó o alquiló alguna propiedad o un bien?; 4 = ¿Es persona pensionada o jubilada?; 5 = se dedicó a estudiar?; 6 = se dedicó a los quehaceres del hogar o al cuidado de otro familiar?; 7 = Es una persona con alguna limitación física o mental que le impide trabajar; 8 = Estaba en otra situación; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_12_1 IS '5.12 Incluyendo traslados de ida y vuelta, ¿cuánto tiempo le dedicó a (RESPUESTA DE 5.11) la semana pasada de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas  de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_12_2 IS '5.12 Incluyendo traslados de ida y vuelta, ¿cuánto tiempo le dedicó a (RESPUESTA DE 5.11) la semana pasada de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_12_3 IS '5.12 Incluyendo traslados de ida y vuelta, ¿cuánto tiempo le dedicó a (RESPUESTA DE 5.11) la semana pasada sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 16 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p5_12_4 IS '5.12 Incluyendo traslados de ida y vuelta, ¿cuánto tiempo le dedicó a (RESPUESTA DE 5.11) la semana pasada sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_1_1_1 IS '6.1 Durante la semana pasada, sin hacer otra actividad, ¿cuánto tiempo dedicó a dormir (incluya siesta) de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de lunes a viernes';
COMMENT ON COLUMN enut.tmodulo.p6_1_1_2 IS '6.1 Durante la semana pasada, sin hacer otra actividad, ¿cuánto tiempo dedicó a dormir (incluya siesta) de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; 99 = Cuando en horas registró 99, entonces ''No especificado''';
COMMENT ON COLUMN enut.tmodulo.p6_1_1_3 IS '6.1 Durante la semana pasada, sin hacer otra actividad, ¿cuánto tiempo dedicó a dormir (incluya siesta) de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de sábado y domingo';
COMMENT ON COLUMN enut.tmodulo.p6_1_1_4 IS '6.1 Durante la semana pasada, sin hacer otra actividad, ¿cuánto tiempo dedicó a dormir (incluya siesta) de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de sábado y domingo; 99 = Cuando en horas registró 99, entonces ''No especificado''';
COMMENT ON COLUMN enut.tmodulo.p6_1_2_1 IS '6.1 Durante la semana pasada, sin hacer otra actividad, ¿cuánto tiempo dedicó a comer sus alimentos diarios (desayuno, comida, almuerzo, cena, etcétera) de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 75 = Horas de lunes a viernes';
COMMENT ON COLUMN enut.tmodulo.p6_1_2_2 IS '6.1 Durante la semana pasada, sin hacer otra actividad, ¿cuánto tiempo dedicó a comer sus alimentos diarios (desayuno, comida, almuerzo, cena, etcétera) de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes';
COMMENT ON COLUMN enut.tmodulo.p6_1_2_3 IS '6.1 Durante la semana pasada, sin hacer otra actividad, ¿cuánto tiempo dedicó a comer sus alimentos diarios (desayuno, comida, almuerzo, cena, etcétera) de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo';
COMMENT ON COLUMN enut.tmodulo.p6_1_2_4 IS '6.1 Durante la semana pasada, sin hacer otra actividad, ¿cuánto tiempo dedicó a comer sus alimentos diarios (desayuno, comida, almuerzo, cena, etcétera) de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 56 = Minutos de sábado y domingo';
COMMENT ON COLUMN enut.tmodulo.p6_1_3_1 IS '6.1 Durante la semana pasada, sin hacer otra actividad, ¿cuánto tiempo dedicó a su aseo o arreglo personal como bañarse, ir al baño, lavarse los dientes, etcétera de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 90 = Horas de lunes a viernes';
COMMENT ON COLUMN enut.tmodulo.p6_1_3_2 IS '6.1 Durante la semana pasada, sin hacer otra actividad,¿cuánto tiempo dedicó a su aseo o arreglo personal como bañarse, ir al baño, lavarse los dientes, etcétera de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes';
COMMENT ON COLUMN enut.tmodulo.p6_1_3_3 IS '6.1 Durante la semana pasada, sin hacer otra actividad,¿cuánto tiempo dedicó a su aseo o arreglo personal como bañarse, ir al baño, lavarse los dientes, etcétera de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo';
COMMENT ON COLUMN enut.tmodulo.p6_1_3_4 IS '6.1 Durante la semana pasada, sin hacer otra actividad,¿cuánto tiempo dedicó a su aseo o arreglo personal como bañarse, ir al baño, lavarse los dientes, etcétera de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo';
COMMENT ON COLUMN enut.tmodulo.p6_2_1 IS '6.2 Durante la semana pasada, ¿usted asistió a clases, tomó cursos o estudió? (incluya clases en línea, sistema abierto o a distancia, diplomados, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_2_1a IS '6.2.1a Durante la semana pasada, ¿sus clases o cursos fueron... | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = de manera presencial y virtual (a distancia)?; 2 = solamente de manera presencial?; 3 = solamente de manera virtual (a distancia)?; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_1_1_1 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de forma presencial de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 84 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_1_1_2 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de forma presencial de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_1_1_3 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de forma presencial sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 26 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_1_1_4 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de forma presencial sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_1_2_1 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de forma virtual de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_1_2_2 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de forma virtual de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_1_2_3 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de forma virtual sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 15 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_1_2_4 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de forma virtual sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2_2 IS '6.2 Durante la semana pasada, ¿usted hizo tareas, prácticas escolares o alguna otra actividad de estudio? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_2_1 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 75 = Horas  de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_2_2 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_2_3 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_2_4 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2_3 IS '6.2 Durante la semana pasada, ¿usted se trasladó de ida y vuelta a la escuela? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_3_1 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_3_2 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_3_3 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_2a_3_4 IS '6.2a De manera exclusiva, ¿cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3_1 IS '6.3 Durante la semana pasada, SÓLO para el consumo de su hogar, ¿usted cuidó o crió animales de corral (ordeñar, recolectar huevos, etcétera)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_1_1 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_1_2 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_1_3 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_1_4 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 54 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3_2 IS '6.3 Durante la semana pasada, SÓLO para el consumo de su hogar, ¿usted recolectó leña?  | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_2_1 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_2_2 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_2_3 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_2_4 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3_3 IS '6.3 Durante la semana pasada, SÓLO para el consumo de su hogar, ¿usted recolectó plantas, hongos, flores o frutos silvestres; pescó o cazó? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_3_1 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 35 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_3_2 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_3_3 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 13 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_3_4 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3_4 IS '6.3 Durante la semana pasada, SÓLO para el consumo de su hogar, ¿usted sembró o cuidó lo que plantó en el traspatio o huerto?  | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_4_1 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_4_2 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_4_3 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_4_4 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3_5 IS '6.3 Durante la semana pasada, SÓLO para el consumo de su hogar, ¿usted acarreó o almacenó agua? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_3a_5_1 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 81 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_5_2 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_5_3 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_5_4 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3_6 IS '6.3 Durante la semana pasada, SÓLO para el consumo de su hogar, ¿usted elaboró o tejió ropa, manteles, cortinas o textiles, etcétera? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_3a_6_1 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_6_2 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_6_3 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_6_4 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 52 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3_7 IS '6.3 Durante la semana pasada, SÓLO para el consumo de su hogar, ¿usted elaboró alimentos como mermeladas, conservas, encurtidos, pan, quesos u otros para conservarse o almacenarse?. | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_3a_7_1 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 35 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_7_2 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_7_3 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 12 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_7_4 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3_8 IS '6.3 Durante la semana pasada, SÓLO para el consumo de su hogar, ¿usted hizo muebles, utensilios de cocina, blocks, adobes u otros productos? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_3a_8_1 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_8_2 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_8_3 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 24 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_8_4 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3_9 IS '6.3 Durante la semana pasada, SÓLO para el consumo de su hogar, ¿usted amplió o remodeló usted misma(o) su vivienda o la estuvo construyendo?  | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_3a_9_1 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 72 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_9_2 IS '6.3a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_9_3 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 18 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_3a_9_4 IS '6.3a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4_1 IS '6.4 Durante la semana pasada, ¿usted desgranó maíz, coció o molió el nixtamal o hizo tortillas de maíz o trigo para su hogar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_1_1 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_1_2 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 56 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_1_3 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_1_4 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4_2 IS '6.4 Durante la semana pasada, ¿usted encendió el fogón, horno o anafre de leña o carbón para preparar o calentar alimentos? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_2_1 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_2_2 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_2_3 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_2_4 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4_3 IS '6.4 Durante la semana pasada, ¿usted cocinó, preparó o calentó alimentos o bebidas? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_4a_3_1 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 90 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_3_2 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_3_3 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_3_4 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4_4 IS '6.4 Durante la semana pasada, ¿usted sirvió la comida, recogió, lavó, secó o acomodó los trastes?. | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_4a_4_1 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 82 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_4_2 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_4_3 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_4_4 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4_5 IS '6.4 Durante la semana pasada, ¿usted llevó comida a algún integrante de su hogar a la escuela, trabajo u otro lugar?  | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_4a_5_1 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_5_2 IS '6.4a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_5_3 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_4a_5_4 IS '6.4a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5_1 IS '6.5 Durante la semana pasada, ¿usted barrió la banqueta, cochera o patio de su vivienda? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_5a_1_1 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_1_2 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_1_3 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_1_4 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5_2 IS '6.5 Durante la semana pasada, ¿usted limpió o recogió el interior de su vivienda? (ordenar objetos, tender camas, barrer, trapear, sacudir, lavar la cocina, el baño, entre otros) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_5a_2_1 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_2_2 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 56 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_2_3 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_2_4 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5_3 IS '6.5 Durante la semana pasada, ¿usted recogió, separó, tiró o quemó la basura? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_5a_3_1 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_3_2 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_3_3 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_3_4 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 53 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5_4 IS '6.5 Durante la semana pasada, ¿usted cuidó o regó macetas y plantas de su patio o jardín? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_5a_4_1 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 80 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_4_2 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_4_3 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 28 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_4_4 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5_5 IS '6.5 Durante la semana pasada, ¿usted limpió, alimentó o cuidó a la(s) mascota(s) (animales de compañía) de su hogar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_5a_5_1 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_5_2 IS '6.5a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_5_3 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_5a_5_4 IS '6.5a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6_1 IS '6.6 Durante la semana pasada, ¿usted lavó, tendió o puso a secar la ropa? (si lo hizo con máquina, quite el tiempo de operación) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_6a_1_1 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 84 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_1_2 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_1_3 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_1_4 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 56 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6_2 IS '6.6 Durante la semana pasada, ¿usted planchó la ropa? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_6a_2_1 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_2_2 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_2_3 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_2_4 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6_3 IS '6.6 Durante la semana pasada, ¿usted separó, dobló, acomodó o guardó la ropa? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_6a_3_1 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 88 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_3_2 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_3_3 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_3_4 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6_4 IS '6.6 Durante la semana pasada, ¿usted arregló o remendó la ropa, manteles, cortinas o sábanas? Excluya confección | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_6a_4_1 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_4_2 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_4_3 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_4_4 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6_5 IS '6.6 Durante la semana pasada, ¿usted limpió, boleó o pintó el calzado? (tenis, huaraches, botas, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_6a_5_1 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 88 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_5_2 IS '6.6a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_5_3 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_6a_5_4 IS '6.6a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7_1 IS '6.7 Durante la semana pasada, ¿usted reparó o hizo alguna instalación menor a su vivienda? (pintar paredes, cambiar focos, reparar un enchufe, colocar una repisa, entre otras). | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_7a_1_1 IS '6.7a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_1_2 IS '6.7a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_1_3 IS '6.7a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_1_4 IS '6.7a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7_2 IS '6.7 Durante la semana pasada, ¿usted reparó muebles, juguetes, aparatos domésticos o computadora de su hogar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_7a_2_1 IS '6.7a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_2_2 IS '6.7a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 54 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_2_3 IS '6.7a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 16 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_2_4 IS '6.7a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7_3 IS '6.7 Durante la semana pasada, ¿usted lavó o limpió algún medio de transporte de su hogar? (bicicleta, moto, camioneta, automóvil) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_7a_3_1 IS '6.7a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_3_2 IS '6.7a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_3_3 IS '6.7a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_3_4 IS '6.7a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7_4 IS '6.7 Durante la semana pasada, ¿usted reparó o dio mantenimiento a algún medio de transporte de su hogar? (bicicleta, moto, camioneta, automóvil) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_7a_4_1 IS '6.7a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_4_2 IS '6.7a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_4_3 IS '6.7a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_7a_4_4 IS '6.7a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8_1 IS '6.8 Durante la semana pasada, ¿usted buscó o compró refacciones, llantas, herramientas, o materiales de construcción, automóvil, casa o terreno? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_8a_1_1 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8a_1_2 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 57 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8a_1_3 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8a_1_4 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 56 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8_2 IS '6.8 Durante la semana pasada, ¿usted buscó o hizo las compras del mandado, la despensa, papelería, medicinas o artículos de limpieza? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_8a_2_1 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8a_2_2 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8a_2_3 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8a_2_4 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8_3 IS '6.8 Durante la semana pasada, ¿usted buscó o compró artículos o bienes para su hogar como trastes, sábanas, muebles, ropa, calzado u otros? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_8a_3_1 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8a_3_2 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8a_3_3 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 12 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_8a_3_4 IS '6.8a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9_1 IS '6.9 Durante la semana pasada, ¿usted hizo pagos o trámites de servicios para su hogar? Incluya también si lo hizo por internet (tenencia, predial, agua, luz, credencial de elector, colegiatura, crédito hipotecario, caja de ahorro, renta, actas, CURP, pasaporte, denuncias, etcétera). | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_9a_1_1 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 33 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9a_1_2 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9a_1_3 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9a_1_4 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9_2 IS '6.9 Durante la semana pasada, ¿usted planeó u organizó los gastos de su hogar? (hacer las cuentas diarias, planear sus compras o vacaciones, entre otros) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_9a_2_1 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9a_2_2 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9a_2_3 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9a_2_4 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9_3 IS '6.9 Durante la semana pasada, ¿usted tramitó o cobró algún programa social? (pensión para adultos mayores, tarjeta LICONSA, becas, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_9a_3_1 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 12 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9a_3_2 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9a_3_3 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_9a_3_4 IS '6.9a Incluyendo el traslado, ¿cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10_1 IS '6.10 Durante la semana pasada, ¿usted llevó o recogió ropa o calzado a algún lugar para su limpieza o reparación? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_10a_1_1 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 07 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_1_2 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_1_3 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_1_4 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10_2 IS '6.10 Durante la semana pasada, ¿usted supervisó la construcción, reparación o mantenimiento de su vivienda? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_10a_2_1 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 35 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_2_2 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_2_3 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_2_4 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10_3 IS '6.10 Durante la semana pasada, ¿usted llevó o supervisó la reparación de muebles, juguetes, aparatos domésticos o computadora de su hogar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_10a_3_1 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_3_2 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_3_3 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 04 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_3_4 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10_4 IS '6.10 Durante la semana pasada, ¿usted llevó a que lavaran, repararan o dieran mantenimiento a algún medio de transporte de su hogar? (bicicleta, moto, camioneta, automóvil) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_10a_4_1 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 49 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_4_2 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_4_3 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_4_4 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10_5 IS '6.10 Durante la semana pasada, ¿usted cerró puertas, ventanas, puso candados u otras medidas para proteger sus bienes y su vivienda? (guardó el auto, encendió la alarma). | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_10a_5_1 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 88 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_5_2 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_5_3 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_5_4 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10_6 IS '6.10 Durante la semana pasada, ¿usted sin hacer otra actividad, esperó el gas, la pipa de agua, el camión de basura u otro servicio? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_10a_6_1 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_6_2 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_6_3 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_6_4 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10_7 IS '6.10 Durante la semana pasada, ¿usted organizó o repartió los quehaceres de su hogar? (indicó qué hacer de comer, supervisó la limpieza de su vivienda, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_10a_7_1 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_7_2 IS '6.10a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_7_3 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 15 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_10a_7_4 IS '6.10a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.filtro_s6_11 IS 'FILTRO 6.11. VERIFIQUE SI HAY INTEGRANTES QUE NECESITARON CUIDADOS ESPECIALES (3.7 = CÓDIGO 1 O 3.8 = CÓDIGO 1 O 2). | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí... Otra(s) persona(s); otra(s) persona(s) y la (el) informante necesitaron cuidados; 2 = Sí... Solo la (el) informante necesitó cuidados; 3 = No';
COMMENT ON COLUMN enut.tmodulo.p6_11_01 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted le(s) dio de comer o ayudó a hacerlo? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_01_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_01_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_01_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_01_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_02 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted le(s) bañó, aseó, vistió, arregló o ayudó a hacerlo? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_02_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_02_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_02_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_02_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 52 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_03 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted le(s) cargó, acostó o le(s) ayudó a hacerlo?  | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_03_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_03_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_03_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_03_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_04 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted le(s) preparó remedios caseros o algún alimento especial? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_04_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_04_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_04_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_04_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_05 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted le(s) dio medicamentos o checó sus síntomas como: temperatura, presión, entre otros? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_05_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 52 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_05_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_05_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_05_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_06 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted sin considerar el traslado y sin hacer otra actividad, le(s) acompañó mientras recibía(n) la atención de salud (exámenes, visitas al médico, etc.) o alguna terapia? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_06_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 80 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_06_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 51 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_06_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_06_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_07 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted le(s) llevó o recogió para que recibiera(n) atención de salud (exámenes, visitas al médico, etc.) o alguna terapia?  | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_07_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 35 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_07_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_07_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_07_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_08 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted le(s) dio terapia o ayudó a realizar ejercicios?  | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_08_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 25 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_08_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_08_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_08_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_09 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted sin considerar el traslado y sin hacer otra actividad, le(s) esperó de clases, trabajo u otro lugar?  | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_09_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_09_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_09_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 06 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_09_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_10 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted le(s) llevó o recogió de clases, trabajo u otro lugar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_10_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_10_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_10_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_10_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_11 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted le(s) ayudó o apoyó en las tareas de la escuela o trabajo? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_11_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_11_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_11_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 15 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_11_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_12 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted asistió a juntas, festivales o actividades de apoyo escolar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_12_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_12_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_12_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 17 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_12_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_13 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted sin hacer otra actividad, le(s) dedicó tiempo para jugar, leerle(s) un libro, escucharle(s), orientarle(s) o consolarle(s)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_13_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_13_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_13_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_13_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11_14 IS '6.11 (NOMBRE(S)) necesitó(aron) cuidados de otra persona. Durante la semana pasada, sea en la casa, hospital u otro lugar, ¿usted mientras hacía otra cosa, le(s) vigiló o estuvo al pendiente de forma presente? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_14_1 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_14_2 IS '6.11a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_14_3 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_11a_14_4 IS '6.11a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.filtro_s6_12 IS 'FILTRO 6.12. VERIFIQUE SI HAY INTEGRANTES DE 0 A 5 AÑOS Y SIN CUIDADOS ESPECIALES (3.7 ≠ CÓDIGO 1 Y 3.8 = CÓDIGO 3 O 9). | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_12_01 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) dio de comer (amamantó) o dio de beber? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_01_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 90 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_01_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_01_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_01_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_02 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) bañó, aseó, cambió pañales, vistió o arregló? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_02_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_02_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 57 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_02_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_02_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_03 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) cargó o acostó? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_03_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 80 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_03_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_03_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_03_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_04 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin considerar el traslado y sin hacer otra actividad, le(s) esperó de alguna clase, actividad o taller (karate, natación, pintura, música)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_04_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 25 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_04_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_04_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 06 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_04_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_05 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) llevó o recogió de la guardería, del preescolar, o de la casa de familiares donde le(s) cuidan? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_05_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_05_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_05_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_05_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_06 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) ayudó en sus actividades de la educación inicial, guardería, o preescolar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_06_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_06_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_06_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_06_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_07 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) asistió a juntas, festivales o actividades de apoyo para la educación inicial, guardería o preescolar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_07_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 06 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_07_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_07_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 03 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_07_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_08 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin considerar el traslado y sin hacer otra actividad, le(s) acompañó mientras recibía(n) la atención de salud? (vacunas, dentista, chequeo médico, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_08_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 75 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_08_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_08_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_08_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_09 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) llevó o recogió para que recibiera(n) atención de salud? (vacunas, dentista, chequeo médico, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_09_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_09_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_09_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_09_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_10 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) revisó o dio atención a su salud como: ponerle(s) pomada, un vendaje, apoyó en ejercicios de alguna terapia, entre otros? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_10_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_10_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_10_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 12 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_10_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_11 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin hacer otra actividad, le(s) dedicó tiempo para jugar, leerle(s) un libro, escucharle(s), orientarle(s) o consolarle(s)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_11_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 75 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_11_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_11_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_11_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12_12 IS '6.12 Durante la semana pasada, ¿usted a (NOMBRE(S)) mientras hacía otra cosa, le(s) vigiló o estuvo al pendiente de forma presente? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_12_1 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_12_2 IS '6.12a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 56 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_12_3 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_12a_12_4 IS '6.12a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.filtro_s6_13 IS 'FILTRO 6.13. VERIFIQUE SI HAY INTEGRANTES DE 6 A 14 AÑOS Y SIN CUIDADOS ESPECIALES (3.7 ≠ CÓDIGO 1 Y 3.8 CÓDIGO 3 O 9). | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí... Otra(s) persona(s); otra(s) persona(s) y la (el) informante; 2 = Sí... Solo la (el) informante; 3 = No';
COMMENT ON COLUMN enut.tmodulo.p6_13_1 IS '6.13 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin considerar el traslado y sin hacer otra actividad, le(s) esperó de alguna clase, actividad o taller (karate, natación, pintura, música)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_1_1 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_1_2 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_1_3 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 36 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_1_4 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13_2 IS '6.13 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) llevo o recogió de la escuela, clase, actividad o taller o de la casa de familiares donde le(s) cuidan? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_2_1 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_2_2 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_2_3 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_2_4 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13_3 IS '6.13 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) ayudó en las tareas de la escuela? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_3_1 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_3_2 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 51 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_3_3 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_3_4 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13_4 IS '6.13 Durante la semana pasada, ¿usted a (NOMBRE(S)) asistió a juntas, festivales o actividades de apoyo para la escuela? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_4_1 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 14 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_4_2 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 52 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_4_3 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_4_4 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13_5 IS '6.13 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin considerar el traslado y sin hacer otra actividad, le(s) acompañó mientras recibía(n) la atención de salud? (vacunas, dentista, chequeo médico, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_5_1 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_5_2 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_5_3 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 24 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_5_4 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13_6 IS '6.13 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) llevó o recogió para que recibiera(n) atención de salud? (vacunas, dentista, chequeo médico, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_6_1 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_6_2 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_6_3 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_6_4 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13_7 IS '6.13 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) revisó o dio atención a su salud como: ponerle(s) pomada, un vendaje, apoyó en ejercicios de alguna terapia, entre otros? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_7_1 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_7_2 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_7_3 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 16 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_7_4 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13_8 IS '6.13 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin hacer otra actividad, le(s) dedicó tiempo para jugar, leerle(s) un libro, escucharle(s), orientarle(s) o consolarle(s)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_8_1 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_8_2 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_8_3 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_8_4 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13_9 IS '6.13 Durante la semana pasada, ¿usted a (NOMBRE(S)) mientras hacía otra cosa, le(s) vigiló o estuvo al pendiente de forma presente? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_9_1 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 90 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_9_2 IS '6.13a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_9_3 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_13a_9_4 IS '6.13a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.filtro_s6_14 IS 'FILTRO 6.14. VERIFIQUE SI HAY INTEGRANTES DE 15 A 59 AÑOS Y SIN CUIDADOS ESPECIALES (3.7 ≠ CÓDIGO 1 Y 3.8 = CÓDIGO 3 O 9). | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí... Otra(s) persona(s); otra(s) persona(s) y la (el) informante; 2 = Sí... Solo la (el) informante; 3 = No';
COMMENT ON COLUMN enut.tmodulo.p6_14_1 IS '6.14 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) apoyó o asesoró en el uso de la computadora, celular, internet o actividades relacionadas con sus cursos o clases? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_1_1 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 35 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_1_2 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_1_3 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_1_4 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14_2 IS '6.14 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin considerar el traslado y sin hacer otra actividad, le(s) acompañó mientras recibía(n) la atención de salud? (vacunas, dentista, chequeo médico, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_2_1 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_2_2 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_2_3 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_2_4 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14_3 IS '6.14 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) llevó o recogió para que recibiera(n) atención de salud? (vacunas, dentista, chequeo médico, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_3_1 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_3_2 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 52 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_3_3 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 12 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_3_4 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14_4 IS '6.14 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin considerar el traslado y sin hacer otra actividad, le(s) esperó de clases, trabajo, de algún trámite u otro lugar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_4_1 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_4_2 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_4_3 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 16 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_4_4 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14_5 IS '6.14 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) llevó o recogió de clases, trabajo, de algún trámite u otro lugar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_5_1 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_5_2 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_5_3 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_5_4 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14_6 IS '6.14 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin hacer otra actividad, le(s) dedico tiempo para escucharle(s), orientarle(s) o consolarle(s)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_6_1 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 82 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_6_2 IS '6.14a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_6_3 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_14a_6_4 IS '6.14a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.filtro_s6_15 IS 'FILTRO 6.15. VERIFIQUE SI HAY INTEGRANTES DE 60 AÑOS Y MÁS Y SIN CUIDADOS ESPECIALES (3.7 ≠ CÓDIGO 1 Y 3.8 = CÓDIGO 3 O 9). | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí... Otra(s) persona(s); otra(s) persona(s) y la (el) informante; 2 = Sí... Solo la (el) informante; 3 = No';
COMMENT ON COLUMN enut.tmodulo.p6_15_1 IS '6.15 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) apoyó o asesoró en el uso de la computadora, celular, internet o actividades relacionadas con sus cursos o clases? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_1_1 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_1_2 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_1_3 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_1_4 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15_2 IS '6.15 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin considerar el traslado y sin hacer otra actividad, le(s) acompañó mientras recibía(n) la atención de salud? (vacunas, dentista, chequeo médico, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_2_1 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 16 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_2_2 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_2_3 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_2_4 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15_3 IS '6.15 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) llevó o recogió para que recibiera(n) atención de salud? (vacunas, dentista, chequeo médico, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_3_1 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 32 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_3_2 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_3_3 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 08 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_3_4 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15_4 IS '6.15 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin considerar el traslado y sin hacer otra actividad, le(s) esperó del trabajo, de algún trámite u otro lugar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_4_1 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 25 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_4_2 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_4_3 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 06 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_4_4 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15_5 IS '6.15 Durante la semana pasada, ¿usted a (NOMBRE(S)) le(s) llevó o recogió del trabajo, de algún trámite u otro lugar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_5_1 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_5_2 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_5_3 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 09 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_5_4 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15_6 IS '6.15 Durante la semana pasada, ¿usted a (NOMBRE(S)) sin hacer otra actividad, le(s) dedicó tiempo para leerle(s) un libro, escucharle(s), orientarle(s) o consolarle(s)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_6_1 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_6_2 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_6_3 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_6_4 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15_7 IS '6.15 Durante la semana pasada, ¿usted a (NOMBRE(S)) mientras hacía otra cosa, le(s) vigiló o estuvo al pendiente de forma presente? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_7_1 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_7_2 IS '6.15a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_7_3 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_15a_7_4 IS '6.15a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16_1 IS '6.16 Durante la semana pasada, ¿usted ayudó de manera gratuita a otro hogar de un familiar en los quehaceres domésticos? (preparación de alimentos, limpieza de la vivienda, lavado o planchado de ropa, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_16a_1_1 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_1_2 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_1_3 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_1_4 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16_2 IS '6.16 Durante la semana pasada, ¿usted ayudó de manera gratuita a otro hogar de un familiar en las compras, pagos, trámites, reparaciones de esa vivienda? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_16a_2_1 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 35 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_2_2 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_2_3 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_2_4 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16_3 IS '6.16 Durante la semana pasada, ¿usted ayudó de manera gratuita a otro hogar de un familiar en la atención de personas que necesitaron cuidados por discapacidad o enfermedad? (darles su medicina, llevarles al doctor, entre otras) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_16a_3_1 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 90 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_3_2 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_3_3 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_3_4 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16_4 IS '6.16 Durante la semana pasada, ¿usted ayudó de manera gratuita a otro hogar de un familiar en el cuidado o atención de bebés, niñas o niños de 0 a 5 años? (llevarles o recogerles de la guardería o estancia, cargarles, bañarles, ayudarles en las tareas escolares, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_16a_4_1 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 86 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_4_2 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_4_3 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_4_4 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16_5 IS '6.16 Durante la semana pasada, ¿usted ayudó de manera gratuita a otro hogar de un familiar en el cuidado o apoyo para personas de 6 a 59 años? (llevarles o recogerles de clases, trabajo, ayudarles en las tareas escolares, acompañarles durante la atención de salud, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_16a_5_1 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_5_2 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_5_3 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_5_4 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16_6 IS '6.16 Durante la semana pasada, ¿usted ayudó de manera gratuita a otro hogar de un familiar en el cuidado o apoyo para personas de 60 años y más? (llevarles, recogerles o esperarles para hacer cobros, trámites, etcétera) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_16a_6_1 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 96 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_6_2 IS '6.16a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_6_3 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_16a_6_4 IS '6.16a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17_1 IS '6.17 Durante la semana pasada, ¿usted hizo actividades o servicios gratuitos de quehaceres domésticos, compras, pagos, trámites, reparaciones de la vivienda o cuidado de personas para hogares de amistades u otras personas (excluye familiares)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_17a_1_1 IS '6.17a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17a_1_2 IS '6.17a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17a_1_3 IS '6.17a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 28 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17a_1_4 IS '6.17a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17_2 IS '6.17 Durante la semana pasada, ¿usted hizo actividades o servicios gratuitos como voluntaria(o) en la Cruz Roja, asilos, casa hogar, DIF, hospitales, iglesias, Alcohólicos Anónimos, partidos políticos, etcétera? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_17a_2_1 IS '6.17a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17a_2_2 IS '6.17a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17a_2_3 IS '6.17a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17a_2_4 IS '6.17a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17_3 IS '6.17 Durante la semana pasada, ¿usted hizo actividades o servicios gratuitos para la comunidad como tequio, faena, mano vuelta, mayordomía, fiestas patronales o sembrar árboles, limpiar calles, ríos, mercados, etcétera? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_17a_3_1 IS '6.17a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17a_3_2 IS '6.17a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17a_3_3 IS '6.17a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_17a_3_4 IS '6.17a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_18 IS 'Durante la semana pasada, en su tiempo libre ¿usted hizo deporte o ejercicio físico? (fútbol, basquetbol, natación, box, karate, caminar, correr, patinar, andar en bicicleta, yoga, zumba) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_18a_1 IS '6.18a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 90 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_18a_2 IS '6.18a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_18a_3 IS '6.18a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_18a_4 IS '6.18a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_19_1 IS '6.19 Durante la semana pasada, ¿usted realizó actividades artísticas o culturales? (tocar un instrumento musical, pintar o realizar artes plásticas, gráficas, literarias o escénicas; incluye danza) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_19a_1_1 IS '6.19a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_19a_1_2 IS '6.19a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_19a_1_3 IS '6.19a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_19a_1_4 IS '6.19a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_19_2 IS '6.19 Durante la semana pasada, ¿usted participó en juegos de mesa o azar (cartas, ajedrez, dominó, ruleta, etcétera), videojuegos, aficiones o pasatiempos (manualidades)? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_19a_2_1 IS '6.19a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 75 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_19a_2_2 IS '6.19a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_19a_2_3 IS '6.19a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_19a_2_4 IS '6.19a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_20_1 IS '6.20 Durante la semana pasada, ¿usted asistió a estadios, parques, ferias u otros sitios de entretenimiento? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_20a_1_1 IS '6.20a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 60 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_20a_1_2 IS '6.20a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_20a_1_3 IS '6.20a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_20a_1_4 IS '6.20a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_20_2 IS '6.20 Durante la semana pasada, ¿usted asistió al cine, museo, teatro u otros sitios culturales?  | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_20a_2_1 IS '6.20a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 12 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_20a_2_2 IS '6.20a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_20a_2_3 IS '6.20a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_20a_2_4 IS '6.20a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21_1 IS '6.21 Durante la semana pasada, sea presencial o de forma virtual, ¿usted dedicó tiempo especial (sin hacer otra actividad) a integrantes de su hogar para platicar de las actividades diarias? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_21a_1_1 IS '6.21a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 82 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_1_2 IS '6.21a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_1_3 IS '6.21a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_1_4 IS '6.21a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21_2 IS '6.21 Durante la semana pasada, sea presencial o de forma virtual, ¿usted asistió o participó en actividades o celebraciones religiosas? (actividades ceremoniales en casa u otro lugar, misas, rosarios u otro tipo de oraciones grupales, funerales, fiestas patronales, kermés de la iglesia) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_21a_2_1 IS '6.21a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 86 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_2_2 IS '6.21a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_2_3 IS '6.21a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_2_4 IS '6.21a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21_3 IS '6.21 Durante la semana pasada, sea presencial o de forma virtual, ¿usted asistió o participó en celebraciones cívicas o políticas? (desfiles, mítines, marchas, reuniones o juntas vecinales) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_21a_3_1 IS '6.21a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 20 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_3_2 IS '6.21a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_3_3 IS '6.21a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 24 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_3_4 IS '6.21a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21_4 IS '6.21 Durante la semana pasada, sea presencial o de forma virtual, ¿usted conversó o se reunió con familiares o amistades, asistió o participó en fiestas, etcétera? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_21a_4_1 IS '6.21a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 78 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_4_2 IS '6.21a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_4_3 IS '6.21a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_21a_4_4 IS '6.21a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22_1 IS '6.22 Durante la semana pasada, ¿usted PARA ENTRETENERSE sin hacer otra actividad, vio películas, novelas, series, programas, videos o documentales en televisión, tablet, celular o computadora? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_22a_1_1 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 90 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_1_2 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_1_3 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_1_4 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22_2 IS '6.22 Durante la semana pasada, ¿usted PARA ENTRETENERSE sin hacer otra actividad, escuchó música, noticias u otro programa de radio en cualquier dispositivo o aparato de audio?. | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_22a_2_1 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 95 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_2_2 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_2_3 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_2_4 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22_3 IS '6.22 Durante la semana pasada, ¿usted PARA ENTRETENERSE leyó algún libro, revista, periódico o artículo mediante algún dispositivo digital o impreso? (excluya si es por trabajo o estudio). | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_22a_3_1 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 75 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_3_2 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_3_3 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 45 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_3_4 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22_4 IS '6.22 Durante la semana pasada, ¿usted PARA ENTRETENERSE a través de Facebook, X (antes Twitter), Instagram, YouTube, TikTok, u otras plataformas, subió fotos, historias, videos, etc., sin recibir un pago? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_22a_4_1 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 90 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_4_2 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_4_3 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 36 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_4_4 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22_5 IS '6.22 Durante la semana pasada, ¿usted PARA ENTRETENERSE sin hacer otra actividad, revisó su correo electrónico o consultó redes sociales como Facebook, X (antes Twitter), WhatsApp, Instagram, entre otros? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_22a_5_1 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 80 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_5_2 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_5_3 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_5_4 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22_6 IS '6.22 Durante la semana pasada, ¿usted PARA ENTRETENERSE realizó alguna otra actividad relacionada con el uso de internet como descargar archivos o consultar información en cualquier aparato o dispositivo? (excluya si es por trabajo o estudio) | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_22a_6_1 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_6_2 IS '6.22a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_6_3 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 30 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_22a_6_4 IS '6.22a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23_1 IS '6.23 Durante la semana pasada, ¿usted sin hacer otra actividad, rezó, meditó o descansó? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_23a_1_1 IS '6.23a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_1_2 IS '6.23a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 58 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_1_3 IS '6.23a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 40 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_1_4 IS '6.23a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 59 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23_2 IS '6.23 Durante la semana pasada, ¿usted recibió alguna atención de salud, terapias, asistió a algún grupo de ayuda o se recuperó de alguna enfermedad? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_23a_2_1 IS '6.23a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 99 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_2_2 IS '6.23a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 55 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_2_3 IS '6.23a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 48 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_2_4 IS '6.23a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23_3 IS '6.23 Durante la semana pasada, ¿usted hizo otra actividad que no le haya mencionado anteriormente? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí; 2 = No';
COMMENT ON COLUMN enut.tmodulo.p6_23_3c IS '6.23 Durante la semana pasada, ¿usted hizo otra actividad que no le haya mencionado anteriormente? ¿Cuál? - Especifique | Descriptor: Alfanumérico, tamaño 3. | Códigos/conceptos: 111 - 999 = Consultar ''CATÁLOGO ENUT 2024'', pestaña ''USO TIEMPO_P6_23_3C 2024''; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_3_1 IS '6.23a ¿Cuánto tiempo le dedicó de lunes a viernes? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 80 = Horas de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_3_2 IS '6.23a ¿Cuánto tiempo le dedicó de lunes a viernes? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de lunes a viernes; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_3_3 IS '6.23a ¿Cuánto tiempo le dedicó de sábado y domingo? - Horas | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 36 = Horas de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p6_23a_3_4 IS '6.23a ¿Cuánto tiempo le dedicó de sábado y domingo? - Minutos | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 50 = Minutos de sábado y domingo; b = Blanco por secuencia';
COMMENT ON COLUMN enut.tmodulo.p7_1_1 IS '7.1 Por favor dígame, ¿cómo se siente con el tiempo que le dedicó la semana pasada a los quehaceres domésticos que hizo en su hogar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = ¿Quisiera dedicarle menos tiempo?; 2 = ¿Es suficiente el tiempo que le dedicó?; 3 = ¿Quisiera dedicarle más tiempo?; 8 = No aplica (no hizo la actividad); 9 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_1_2 IS '7.1 Por favor dígame, ¿cómo se siente con el tiempo que le dedicó la semana pasada a sus clases, cursos o estudios? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = ¿Quisiera dedicarle menos tiempo?; 2 = ¿Es suficiente el tiempo que le dedicó?; 3 = ¿Quisiera dedicarle más tiempo?; 8 = No aplica (no hizo la actividad); 9 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_1_3 IS '7.1 Por favor dígame, ¿cómo se siente con el tiempo que le dedicó la semana pasada a su trabajo remunerado o actividad económica? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = ¿Quisiera dedicarle menos tiempo?; 2 = ¿Es suficiente el tiempo que le dedicó?; 3 = ¿Quisiera dedicarle más tiempo?; 8 = No aplica (no hizo la actividad); 9 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_1_4 IS '7.1 Por favor dígame, ¿cómo se siente con el tiempo que le dedicó la semana pasada a cuidar y apoyar a las personas de su hogar? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = ¿Quisiera dedicarle menos tiempo?; 2 = ¿Es suficiente el tiempo que le dedicó?; 3 = ¿Quisiera dedicarle más tiempo?; 8 = No aplica (no hizo la actividad); 9 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_1_5 IS '7.1 Por favor dígame, ¿cómo se siente con el tiempo que le dedicó la semana pasada a convivir con familiares y amistades? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = ¿Quisiera dedicarle menos tiempo?; 2 = ¿Es suficiente el tiempo que le dedicó?; 3 = ¿Quisiera dedicarle más tiempo?; 8 = No aplica (no hizo la actividad); 9 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_1_6 IS '7.1 Por favor dígame, ¿cómo se siente con el tiempo que le dedicó la semana pasada a los traslados a su trabajo o escuela? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = ¿Quisiera dedicarle menos tiempo?; 2 = ¿Es suficiente el tiempo que le dedicó?; 3 = ¿Quisiera dedicarle más tiempo?; 8 = No aplica (no hizo la actividad); 9 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_1_7 IS '7.1 Por favor dígame, ¿cómo se siente con el tiempo que le dedicó la semana pasada a hacer trámites, pagos o cobrar algún programa social que recibe o recibió? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = ¿Quisiera dedicarle menos tiempo?; 2 = ¿Es suficiente el tiempo que le dedicó?; 3 = ¿Quisiera dedicarle más tiempo?; 8 = No aplica (no hizo la actividad); 9 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_1_8 IS '7.1 Por favor dígame, ¿cómo se siente con el tiempo que le dedicó la semana pasada a el uso del internet para entretenerse? | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = ¿Quisiera dedicarle menos tiempo?; 2 = ¿Es suficiente el tiempo que le dedicó?; 3 = ¿Quisiera dedicarle más tiempo?; 8 = No aplica (no hizo la actividad); 9 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_01 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con su salud física? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_02 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con su salud emocional? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_03 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con sus logros en la vida? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_04 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con su vida familiar? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_05 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con su vida afectiva (amorosa)? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_06 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con su vida social (amistades)? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_07 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con el tiempo del que dispone para hacer lo que le gusta? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_08 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con su situación económica? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_09 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con sus perspectivas a futuro? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_10 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con esta vivienda? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.p7_2_11 IS '7.2 Podría decirme, en una escala de 0 a 10, donde 0 es totalmente insatisfecha(o) y 10 totalmente satisfecha(o), ¿qué tan satisfecha(o) está con su vida en general? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 - 10 = Percepción de satisfacción personal; 99 = No especificado';
COMMENT ON COLUMN enut.tmodulo.cvegeo IS 'Clave geográfica | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.tmodulo.cve_ent IS 'Entidad | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.tmodulo.tloc IS 'Tamaño de Localidad | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de entre 100 000 y más habitantes; 2 = Localidades con una población de entre 15 000 y 99 999 habitantes; 3 = Localidades con una población de entre 2 500 y 14 999 habitantes; 4 = Localidades con una población de menos de 2 500 habitantes';
COMMENT ON COLUMN enut.tmodulo.menor10 IS 'Variable indicadora del tamaño de localidad para explotación | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de 1 a 9 999 habitantes; 2 = Localidades con una población de 10 000 y más habitantes';
COMMENT ON COLUMN enut.tmodulo.est_dis IS 'Estrato de Diseño Muestral | Descriptor: Alfanumérico, tamaño 4. | Códigos/conceptos: 0001 - 0342 = Estrato de Diseño Muestral';
COMMENT ON COLUMN enut.tmodulo.upm_dis IS 'Unidad Primaria de Muestreo | Descriptor: Alfanumérico, tamaño 5. | Códigos/conceptos: 00001 - 04208 = Unidad Primaria de Muestreo';
COMMENT ON COLUMN enut.tmodulo.fac_per IS 'Factor | Descriptor: Numérico, tamaño 5. | Códigos/conceptos: 00007 - 13155 = Factor';
COMMENT ON COLUMN enut.tmodulo.control IS 'Control de Vivienda | Descriptor: Alfanumérico, tamaño 7. | Códigos/conceptos: 100094 - 3261231 = Número de Control de la Vivienda';
COMMENT ON COLUMN enut.tmodulo.viv_sel IS 'Número de Vivienda Seleccionada | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 24 = Número de Vivienda Seleccionada';
COMMENT ON COLUMN enut.tmodulo.hogar IS 'Número de Hogar en la Vivienda | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 - 5 = Número de Hogar en la Vivienda';
COMMENT ON COLUMN enut.tmodulo.n_ren IS 'Número de Renglón de la Persona | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 14 = Número de Renglón de la Persona';

CREATE INDEX idx_tmodulo_llaveviv ON enut.tmodulo (llaveviv);
CREATE INDEX idx_tmodulo_llavehog ON enut.tmodulo (llavehog);

--- Bloque. TVAR_CREA

CREATE TABLE enut.tvar_crea (
    llavemod VARCHAR(12) PRIMARY KEY,
    llaveviv VARCHAR(9),
    llavehog VARCHAR(10),
    activ_prod_con_cp VARCHAR(21),
    activ_prod_sin_cp VARCHAR(21),
    activ_merc VARCHAR(21),
    trab_merc_pv VARCHAR(21),
    tras_trab VARCHAR(21),
    bus_trab VARCHAR(21),
    prod_bien_trab_auto VARCHAR(21),
    trab_no_rem_vol VARCHAR(21),
    trab_no_rem_hog VARCHAR(21),
    prep_serv_alim VARCHAR(21),
    limp_viv VARCHAR(21),
    limp_rop VARCHAR(21),
    mant_viv VARCHAR(21),
    compras_hog VARCHAR(21),
    pagos_tram_hog VARCHAR(21),
    org_sup_hog VARCHAR(21),
    trab_no_rem_con_cp VARCHAR(21),
    trab_no_rem_cuid_hog VARCHAR(21),
    cuid_esp_int_hog_con_cp VARCHAR(21),
    cuid_esp_int_hog_sin_cp VARCHAR(21),
    cuid_int_0a5_con_cp VARCHAR(21),
    cuid_int_0a5_sin_cp VARCHAR(21),
    cuid_int_6a14_con_cp VARCHAR(21),
    cuid_int_6a14_sin_cp VARCHAR(21),
    cuid_int_15a59 VARCHAR(21),
    cuid_int_60mas_con_cp VARCHAR(21),
    cuid_int_60mas_sin_cp VARCHAR(21),
    trab_no_rem_otros_hog VARCHAR(21),
    apoy_hog_fam VARCHAR(21),
    trab_dom_otros_hog_fam VARCHAR(21),
    cuid_esp_disc_enf VARCHAR(21),
    cuid_per_otros_hog VARCHAR(21),
    trab_no_rem_no_fam VARCHAR(21),
    prod_bien_hog_rural VARCHAR(21),
    prep_serv_alim_rural VARCHAR(21),
    activ_cuid_per VARCHAR(21),
    activ_estud VARCHAR(21),
    activ_conviv VARCHAR(21),
    edad VARCHAR(2),
    sexo VARCHAR(1),
    niv VARCHAR(2),
    gra VARCHAR(1),
    cvegeo VARCHAR(2),
    cve_ent VARCHAR(2),
    tloc VARCHAR(1),
    menor10 VARCHAR(1),
    escolaridad VARCHAR(1),
    cond_ind VARCHAR(1),
    cond_disc VARCHAR(1),
    cond_aee VARCHAR(1),
    est_dis VARCHAR(4),
    upm_dis VARCHAR(5),
    fac_per NUMERIC(5,0),
    control VARCHAR(7),
    viv_sel VARCHAR(2),
    hogar VARCHAR(1),
    n_ren VARCHAR(2),
    CONSTRAINT fk_tvar_crea_llaveviv FOREIGN KEY (llaveviv) REFERENCES enut.tvivienda (llaveviv),
    CONSTRAINT fk_tvar_crea_llavehog FOREIGN KEY (llavehog) REFERENCES enut.thogar (llavehog)
);

COMMENT ON TABLE enut.tvar_crea IS 'ENUT 2024. Hoja TVAR_CREA de enut_2024_fd.xlsx. 60 columnas.';
COMMENT ON COLUMN enut.tvar_crea.llavemod IS 'Llave de identificación de la persona elegida | Descriptor: Alfanumérico, tamaño 12. | Códigos/conceptos: 010009401101 - 326123120102 = Llave de identificación de la persona elegida';
COMMENT ON COLUMN enut.tvar_crea.llaveviv IS 'Llave de identificación de la vivienda | Descriptor: Alfanumérico, tamaño 9. | Códigos/conceptos: 010009401 - 326123120 = Llave de identificación de la vivienda';
COMMENT ON COLUMN enut.tvar_crea.llavehog IS 'Llave de identificación del hogar | Descriptor: Alfanumérico, tamaño 10. | Códigos/conceptos: 0100094011 - 3261231201 = Llave de identificación del hogar';
COMMENT ON COLUMN enut.tvar_crea.activ_prod_con_cp IS 'Actividades productivas o de trabajo, con cuidados pasivos | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 522.61666666666666668 = Tiempo total de trabajo (TTT) (con cuidados pasivos)';
COMMENT ON COLUMN enut.tvar_crea.activ_prod_sin_cp IS 'Actividades productivas o de trabajo | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 522.61666666666666668 = Tiempo total de trabajo (TTT) (sin cuidados pasivos)';
COMMENT ON COLUMN enut.tvar_crea.activ_merc IS 'Trabajo para el mercado (incluye búsqueda de trabajo y traslados) | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 236.00000000000000000 = Actividades para el mercado';
COMMENT ON COLUMN enut.tvar_crea.trab_merc_pv IS 'Trabajo para el mercado | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 192.00000000000000000 = Trabajo para el mercado (presencial o virtual)';
COMMENT ON COLUMN enut.tvar_crea.tras_trab IS 'Traslados al trabajo | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 118.00000000000000000 = Traslado al trabajo';
COMMENT ON COLUMN enut.tvar_crea.bus_trab IS 'Búsqueda de trabajo | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 060.00000000000000000 = Búsqueda de trabajo';
COMMENT ON COLUMN enut.tvar_crea.prod_bien_trab_auto IS 'Producción de bienes para uso exclusivo del hogar | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 100.00000000000000000 = Producción de bienes para uso exclusivo del hogar (Trabajo de autoconsumo)';
COMMENT ON COLUMN enut.tvar_crea.trab_no_rem_vol IS 'Trabajo no remunerado doméstico, de cuidados y voluntario | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 466.50000000000000001 = Trabajo no remunerado de los hogares y trabajo voluntario';
COMMENT ON COLUMN enut.tvar_crea.trab_no_rem_hog IS 'Trabajo doméstico no remunerado para el propio hogar | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 244.36666666666666666 = Trabajo domestico no remunerado para el propio hogar';
COMMENT ON COLUMN enut.tvar_crea.prep_serv_alim IS 'Preparación y servicio de alimentos | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 116.00000000000000000 = Preparación y servicios de alimentos para el hogar';
COMMENT ON COLUMN enut.tvar_crea.limp_viv IS 'Limpieza de la vivienda | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 102.66666666666666666 = Limpieza de la vivienda';
COMMENT ON COLUMN enut.tvar_crea.limp_rop IS 'Limpieza y cuidado de ropa y calzado | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 108.66666666666666667 = Limpieza y cuidado de ropa y calzado del hogar';
COMMENT ON COLUMN enut.tvar_crea.mant_viv IS 'Mantenimiento, instalación y reparaciones menores de la vivienda y otros bienes del hogar | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 084.00000000000000000 = Mantenimiento, instalación y reparaciones menores de la vivienda y otros bienes del hogar';
COMMENT ON COLUMN enut.tvar_crea.compras_hog IS 'Compras | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 052.00000000000000000 = Compras para el hogar';
COMMENT ON COLUMN enut.tvar_crea.pagos_tram_hog IS 'Pagos y trámites | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 060.00000000000000000 = Pagos, trámites y planeación para el hogar';
COMMENT ON COLUMN enut.tvar_crea.org_sup_hog IS 'Gestión y administración  | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 088.08333333333333333 = Organización y supervisión del hogar';
COMMENT ON COLUMN enut.tvar_crea.trab_no_rem_con_cp IS 'Trabajo no remunerado de cuidado a integrantes del hogar, con cuidados pasivos | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 419.50000000000000000 = Trabajo no remunerado de cuidados a integrantes del hogar con cuidado pasivos y con cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.trab_no_rem_cuid_hog IS 'Trabajo no remunerado de cuidado a integrantes del hogar | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 281.13333333333333333 = Trabajo no remunerado de cuidados a integrantes del hogar sin cuidado pasivo y con cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.cuid_esp_int_hog_con_cp IS 'Cuidados especiales a integrantes del hogar por enfermedad crónica, temporal o discapacidad, con cuidados pasivos  | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 201.25000000000000000 = Cuidados a integrantes del hogar con enfermedad crónica, temporal o discapacidad, incluye cuidados pasivos y cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.cuid_esp_int_hog_sin_cp IS 'Cuidados especiales a integrantes del hogar con enfermedad crónica, temporal o discapacidad | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 136.83333333333333333 = Cuidados a integrantes del hogar con enfermedad crónica, temporal o discapacidad, excluye cuidados pasivos e incluye cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.cuid_int_0a5_con_cp IS 'Cuidado a integrantes del hogar de 0 a 5 años, con cuidados pasivos | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 280.00000000000000000 = Cuidados a integrantes del hogar de 0 a 5 años, con cuidados pasivos y con cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.cuid_int_0a5_sin_cp IS 'Cuidado a integrantes del hogar de 0 a 5 años | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 217.23333333333333333 = Cuidados a integrantes del hogar de 0 a 5 años, sin cuidados pasivos y con cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.cuid_int_6a14_con_cp IS 'Cuidado a integrantes del hogar de 6 a 14 años, con cuidados pasivos | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 152.41666666666666667 = Cuidados a integrantes del hogar de 6 a 14 años, con cuidados pasivos y con cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.cuid_int_6a14_sin_cp IS 'Cuidado a integrantes del hogar de 6 a 14 años | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 116.13333333333333333 = Cuidados a integrantes del hogar de 6 a 14 años, sin cuidados pasivos y con cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.cuid_int_15a59 IS 'Cuidado a integrantes del hogar de 15 a 59 años | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 082.50000000000000000 = Cuidados a integrantes del hogar de 15 a 59 años con cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.cuid_int_60mas_con_cp IS 'Cuidado a integrantes del hogar de 60 años y más, con cuidados pasivos | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 147.00000000000000000 = Cuidados a integrantes del hogar de 60 años y más, con cuidados pasivos y con cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.cuid_int_60mas_sin_cp IS 'Cuidado a integrantes del hogar de 60 años y más | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 074.00000000000000000 = Cuidados a integrantes del hogar de 60 años y más, sin cuidados pasivos y con cuidados emocionales';
COMMENT ON COLUMN enut.tvar_crea.trab_no_rem_otros_hog IS 'Trabajo no remunerado como apoyo  a otros hogares y trabajo voluntario | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 171.00000000000000000 = Trabajo no remunerado como apoyo a otros hogares y trabajo voluntario';
COMMENT ON COLUMN enut.tvar_crea.apoy_hog_fam IS 'Apoyo a otros hogares de familiares | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 170.00000000000000000 = Quehaceres y cuidados a otros hogares familiares (apoyo gratuito a otros hogares)';
COMMENT ON COLUMN enut.tvar_crea.trab_dom_otros_hog_fam IS 'Trabajo doméstico para hogar familiar | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 084.00000000000000000 = Trabajo doméstico para otros hogares familiares';
COMMENT ON COLUMN enut.tvar_crea.cuid_esp_disc_enf IS 'Cuidados especiales a personas de otros hogares familiares con enfermedad crónica, temporal o discapacidad | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 123.00000000000000000 = Ayudar de manera gratuita a personas de otro hogar familiar que necesitaron cuidados por discapacidad o enfermedad.';
COMMENT ON COLUMN enut.tvar_crea.cuid_per_otros_hog IS 'Cuidados propios de la edad a personas de otros hogares familiares | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 168.00000000000000000 = Cuidados propios de la edad a personas de otros hogares familiares';
COMMENT ON COLUMN enut.tvar_crea.trab_no_rem_no_fam IS 'Trabajo no remunerado como apoyo a hogares no familiares,6 trabajo comunitario y voluntario (Apoyo a otros hogares no familiares, a la comunidad y trabajo voluntario) | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 098.00000000000000000 = Trabajo no remunerado como apoyo a hogares no familiares, trabajo comunitario y voluntario';
COMMENT ON COLUMN enut.tvar_crea.prod_bien_hog_rural IS 'Producción bienes para  consumo exclusivo del hogar | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 094.00000000000000000 = Producción de bienes para consumo exclusivo del hogar, solo actividades en localidades rurales';
COMMENT ON COLUMN enut.tvar_crea.prep_serv_alim_rural IS 'Preparación y servicios de alimentos para el hogar  | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 075.00000000000000000 = Preparación y servicios de alimentos para el hogar, solo actividades en localidades rurales';
COMMENT ON COLUMN enut.tvar_crea.activ_cuid_per IS 'Actividades de cuidado personal | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 004.75000000000000000 - 262.66666666666666667 = Necesidades y cuidados personales, con autocuidado';
COMMENT ON COLUMN enut.tvar_crea.activ_estud IS 'Actividades de estudio | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 134.50000000000000000 = Actividades de estudio';
COMMENT ON COLUMN enut.tvar_crea.activ_conviv IS 'Actividades de convivencia y entretenimiento | Descriptor: Alfanumérico, tamaño 21. | Códigos/conceptos: 000.00000000000000000 - 353.16666666666666668 = Tiempo libre';
COMMENT ON COLUMN enut.tvar_crea.edad IS '3.5 ¿Cuántos años cumplidos tiene (NOMBRE)? | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 12 - 96 = Años cumplidos; 97 = 97 años y más; 98 = No sabe, en personas de 12 años y más';
COMMENT ON COLUMN enut.tvar_crea.sexo IS '3.4 (NOMBRE) es hombre (NOMBRE) es mujer | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Hombre; 2 = Mujer';
COMMENT ON COLUMN enut.tvar_crea.niv IS '4.2 ¿Hasta qué año o grado aprobó usted en la escuela? - Nivel | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 00 = Ninguno; 01 = Preescolar o kínder; 02 = Primaria; 03 = Secundaria; 04 = Normal básica; 05 = Estudios técnicos con secundaria terminada; 06 = Preparatoria o bachillerato; 07 = Estudios técnicos con preparatoria terminada; 08 = Licenciatura o ingeniería (profesional); 09 = Especialidad; 10 = Maestría; 11 = Doctorado; 99 = No especificado';
COMMENT ON COLUMN enut.tvar_crea.gra IS '4.2 ¿Hasta qué año o grado aprobó usted en la escuela? - Grado | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 0 - 9 = Grados aprobados';
COMMENT ON COLUMN enut.tvar_crea.cvegeo IS 'Clave geográfica | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.tvar_crea.cve_ent IS 'Entidad | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 = Aguascalientes; 02 = Baja California; 03 = Baja California Sur; 04 = Campeche; 05 = Coahuila de Zaragoza; 06 = Colima; 07 = Chiapas; 08 = Chihuahua; 09 = Ciudad de México; 10 = Durango; 11 = Guanajuato; 12 = Guerrero; 13 = Hidalgo; 14 = Jalisco; 15 = Estado de México; 16 = Michoacán de Ocampo; 17 = Morelos; 18 = Nayarit; 19 = Nuevo León; 20 = Oaxaca; 21 = Puebla; 22 = Querétaro; 23 = Quintana Roo; 24 = San Luis Potosí; 25 = Sinaloa; 26 = Sonora; 27 = Tabasco; 28 = Tamaulipas; 29 = Tlaxcala; 30 = Veracruz de Ignacio de la Llave; 31 = Yucatán; 32 = Zacatecas';
COMMENT ON COLUMN enut.tvar_crea.tloc IS 'Tamaño de Localidad | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de entre 100 000 y más habitantes; 2 = Localidades con una población de entre 15 000 y 99 999 habitantes; 3 = Localidades con una población de entre 2 500 y 14 999 habitantes; 4 = Localidades con una población de menos de 2 500 habitantes';
COMMENT ON COLUMN enut.tvar_crea.menor10 IS 'Variable indicadora del tamaño de localidad para explotación | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Localidades con una población de 1 a 9 999 habitantes; 2 = Localidades con una población de 10 000 y más habitantes';
COMMENT ON COLUMN enut.tvar_crea.escolaridad IS 'Escolaridad | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sin escolaridad; 2 = Educación básica; 3 = Educación media superior; 4 = Licenciatura o equivalente; 5 = Posgrado';
COMMENT ON COLUMN enut.tvar_crea.cond_ind IS 'Condición de adscripción indígena | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí se considera indígena; 2 = No se considera indígena; 9 = No especificado';
COMMENT ON COLUMN enut.tvar_crea.cond_disc IS 'Condición de discapacidad | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Sí tiene discapacidad; 2 = No tiene discapacidad';
COMMENT ON COLUMN enut.tvar_crea.cond_aee IS 'Condición de actividad económica específica | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 = Ocupada; 2 = Desocupada; 3 = Persona jubilada o pensionada; 4 = Estudiante; 5 = Se dedica a los quehaceres del hogar  o al cuidado de algún familiar; 6 = Estaba en otra situación';
COMMENT ON COLUMN enut.tvar_crea.est_dis IS 'Estrato de Diseño Muestral | Descriptor: Alfanumérico, tamaño 4. | Códigos/conceptos: 0001 - 0342 = Estrato de Diseño Muestral';
COMMENT ON COLUMN enut.tvar_crea.upm_dis IS 'Unidad Primaria de Muestreo | Descriptor: Alfanumérico, tamaño 5. | Códigos/conceptos: 00001 - 04208 = Unidad Primaria de Muestreo';
COMMENT ON COLUMN enut.tvar_crea.fac_per IS 'Factor | Descriptor: Numérico, tamaño 5. | Códigos/conceptos: 00007 - 13155 = Factor';
COMMENT ON COLUMN enut.tvar_crea.control IS 'Control de Vivienda | Descriptor: Alfanumérico, tamaño 7. | Códigos/conceptos: 100094 - 3261231 = Número de Control de la Vivienda';
COMMENT ON COLUMN enut.tvar_crea.viv_sel IS 'Número de Vivienda Seleccionada | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 24 = Número de Vivienda Seleccionada';
COMMENT ON COLUMN enut.tvar_crea.hogar IS 'Número de Hogar en la Vivienda | Descriptor: Alfanumérico, tamaño 1. | Códigos/conceptos: 1 - 5 = Número de Hogar en la Vivienda';
COMMENT ON COLUMN enut.tvar_crea.n_ren IS 'Número de Renglón de la Persona | Descriptor: Alfanumérico, tamaño 2. | Códigos/conceptos: 01 - 14 = Número de Renglón de la Persona';

CREATE INDEX idx_tvar_crea_llaveviv ON enut.tvar_crea (llaveviv);
CREATE INDEX idx_tvar_crea_llavehog ON enut.tvar_crea (llavehog);

COMMIT;

SELECT * FROM enut.tvivienda;
SELECT * FROM enut.thogar;
SELECT * FROM enut.tsdem;
SELECT * FROM enut.tmodulo;
SELECT * FROM enut.tvar_crea;