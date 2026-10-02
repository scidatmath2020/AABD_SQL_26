-- Bloque 1. Fechas y limpieza de texto
-- Consulta antigüedad, periodos y cadenas de texto. Usa el 30 de septiembre de 2026 como
-- referencia para obtener resultados reproducibles.

-- ----------------------------------------------------------------------------
-- Ejercicio 01. Antigüedad de clientes
-- ----------------------------------------------------------------------------
-- Enunciado: Muestra nombre completo, fecha de registro y días transcurridos hasta la fecha de
-- referencia. Ordena del cliente más antiguo al más reciente.
-- Solución orientativa

SELECT id_cliente,CONCAT(nombre,' ',apellidos) AS cliente,
 fecha_registro,DATE '2026-09-30'-fecha_registro AS dias
FROM comercial.clientes
ORDER BY fecha_registro,id_cliente;

-- ----------------------------------------------------------------------------
-- Ejercicio 02. Antigüedad de vendedores
-- ----------------------------------------------------------------------------
-- Enunciado: Calcula la antigüedad con AGE y los años cumplidos con EXTRACT. Selecciona
-- contrataciones anteriores al 30 de septiembre de 2021.
-- Solución orientativa

SELECT id_vendedor,nombre,fecha_contratacion,
 AGE(DATE '2026-09-30',fecha_contratacion) AS antiguedad,
 EXTRACT(YEAR FROM AGE(DATE '2026-09-30',
                       fecha_contratacion))::int AS anios
FROM comercial.vendedores
WHERE fecha_contratacion<DATE '2021-09-30'
ORDER BY fecha_contratacion,id_vendedor;

-- ----------------------------------------------------------------------------
-- Ejercicio 03. Correos y meses
-- ----------------------------------------------------------------------------
-- Enunciado: Normaliza los correos con LOWER y TRIM, extrae su dominio y calcula el primer día
-- del mes de registro con DATE_TRUNC.
-- Solución orientativa

SELECT id_cliente,LOWER(TRIM(email)) AS correo,
 SPLIT_PART(LOWER(TRIM(email)),'@',2) AS dominio,
 DATE_TRUNC('month',fecha_registro)::date AS mes_registro
FROM comercial.clientes ORDER BY id_cliente;
-- Nota: Si un correo ya está limpio, el valor normalizado será idéntico al original.

-- ============================================================================
-- Bloque 2. Operaciones entre conjuntos
-- ============================================================================
-- Compara clientes con ventas en el primer y segundo semestre de 2026. Incluye tanto ventas
-- pagadas como pendientes; la base llega hasta septiembre.

-- ----------------------------------------------------------------------------
-- Ejercicio 04. Clientes con compras en 2026
-- ----------------------------------------------------------------------------
-- Enunciado: Obtén los identificadores de clientes con al menos una venta en cualquiera de los
-- dos semestres, sin duplicados.
-- Solución orientativa

SELECT id_cliente FROM comercial.ventas
WHERE fecha_venta>=DATE '2026-01-01'
 AND fecha_venta<DATE '2026-07-01'
UNION
SELECT id_cliente FROM comercial.ventas
WHERE fecha_venta>=DATE '2026-07-01'
 AND fecha_venta<DATE '2027-01-01'
ORDER BY id_cliente;

-- ----------------------------------------------------------------------------
-- Ejercicio 05. Clientes recurrentes entre semestres
-- ----------------------------------------------------------------------------
-- Enunciado: Obtén los clientes con ventas en ambos semestres.
-- Solución orientativa

SELECT id_cliente FROM comercial.ventas
WHERE fecha_venta>=DATE '2026-01-01'
 AND fecha_venta<DATE '2026-07-01'
INTERSECT
SELECT id_cliente FROM comercial.ventas
WHERE fecha_venta>=DATE '2026-07-01'
 AND fecha_venta<DATE '2027-01-01'
ORDER BY id_cliente;

-- ----------------------------------------------------------------------------
-- Ejercicio 06. Clientes sin recompra en el segundo semestre
-- ----------------------------------------------------------------------------
-- Enunciado: Identifica clientes del primer semestre sin ventas registradas en el segundo
-- semestre.
-- Solución orientativa

SELECT id_cliente FROM comercial.ventas
WHERE fecha_venta>=DATE '2026-01-01'
 AND fecha_venta<DATE '2026-07-01'
EXCEPT
SELECT id_cliente FROM comercial.ventas
WHERE fecha_venta>=DATE '2026-07-01'
 AND fecha_venta<DATE '2027-01-01'
ORDER BY id_cliente;
-- Nota: En la carga inicial: UNION devuelve 45 clientes, INTERSECT 15 y EXCEPT 15.

-- ============================================================================
-- Bloque 3. Consultas por etapas con CTE
-- ============================================================================
-- WITH nombra resultados intermedios dentro de una consulta. La vista vw_totales_venta contiene
-- una fila por venta y evita duplicar importes al trabajar con sus renglones.

-- ----------------------------------------------------------------------------
-- Ejercicio 07. Compras acumuladas por cliente
-- ----------------------------------------------------------------------------
-- Enunciado: Calcula en una CTE el importe vendido a cada cliente. Muestra nombre e importe para
-- quienes acumulan al menos 5000 MXN.
-- Solución orientativa

WITH compras AS (
 SELECT id_cliente,SUM(total) AS importe
 FROM comercial.vw_totales_venta GROUP BY id_cliente
)
SELECT c.id_cliente,c.nombre,p.importe
FROM comercial.clientes c
JOIN compras p USING(id_cliente)
WHERE p.importe>=5000
ORDER BY p.importe DESC,c.id_cliente;

-- ----------------------------------------------------------------------------
-- Ejercicio 08. Clientes sobre la media de compradores
-- ----------------------------------------------------------------------------
-- Enunciado: Calcula el importe por cliente y la media de esos importes. Muestra compradores que
-- superan esa media. Excluye clientes sin ventas.
-- Solución orientativa

WITH compras AS (
 SELECT id_cliente,SUM(total) AS importe
 FROM comercial.vw_totales_venta GROUP BY id_cliente
), referencia AS (
 SELECT AVG(importe) AS media FROM compras
)
SELECT p.id_cliente,p.importe,ROUND(r.media,2) AS referencia
FROM compras p CROSS JOIN referencia r
WHERE p.importe>r.media
ORDER BY p.importe DESC,p.id_cliente;
-- Nota: Cada comprador pesa lo mismo. Esta referencia no es el ticket promedio por venta.

-- ----------------------------------------------------------------------------
-- Ejercicio 09. Saldo pendiente por venta
-- ----------------------------------------------------------------------------
-- Enunciado: Agrega pagos por venta antes de unirlos con sus totales. Muestra ventas con saldo
-- positivo y calcula el porcentaje cubierto.
-- Solución orientativa

WITH cobros AS (
 SELECT id_venta,SUM(monto) AS pagado
 FROM comercial.pagos GROUP BY id_venta
)
SELECT v.id_venta,v.total,COALESCE(c.pagado,0) AS pagado,
 v.total-COALESCE(c.pagado,0) AS saldo,
 ROUND(100.0*COALESCE(c.pagado,0)/NULLIF(v.total,0),2)
 AS porcentaje_cubierto
FROM comercial.vw_totales_venta v
LEFT JOIN cobros c USING(id_venta)
WHERE v.total>COALESCE(c.pagado,0)
ORDER BY saldo DESC,v.id_venta;
-- Nota: La carga inicial contiene 15 ventas pendientes. No unas pagos y detalle sin agregarlos
-- primero: podrías multiplicar importes.

-- ============================================================================
-- Bloque 4. Funciones de ventana
-- ============================================================================
-- Compara cada fila con su grupo sin colapsarla. Los salarios incluyen empates para distinguir
-- ROW_NUMBER, RANK y DENSE_RANK.

-- ----------------------------------------------------------------------------
-- Ejercicio 10. Posición salarial por región
-- ----------------------------------------------------------------------------
-- Enunciado: Muestra tres posiciones salariales por región usando ROW_NUMBER, RANK y DENSE_RANK.
-- Ordena por salario descendente.
-- Solución orientativa

SELECT id_vendedor,region,salario,
 ROW_NUMBER() OVER (
  PARTITION BY region ORDER BY salario DESC,id_vendedor
 ) AS numero,
 RANK() OVER (
  PARTITION BY region ORDER BY salario DESC
 ) AS rango,
 DENSE_RANK() OVER (
  PARTITION BY region ORDER BY salario DESC
 ) AS rango_denso
FROM comercial.vendedores ORDER BY region,numero;
-- Nota: RANK deja huecos después de un empate; DENSE_RANK no. ROW_NUMBER desempata aquí por
-- identificador.

-- ----------------------------------------------------------------------------
-- Ejercicio 11. Precio respecto de su categoría
-- ----------------------------------------------------------------------------
-- Enunciado: Muestra precio de cada producto, precio promedio de su categoría y diferencia
-- respecto de dicho promedio.
-- Solución orientativa

SELECT id_producto,id_categoria,precio,
 ROUND(AVG(precio) OVER (
  PARTITION BY id_categoria),2) AS promedio_categoria,
 ROUND(precio-AVG(precio) OVER (
  PARTITION BY id_categoria),2) AS diferencia
FROM comercial.productos
ORDER BY id_categoria,id_producto;

-- ----------------------------------------------------------------------------
-- Ejercicio 12. Dos vendedores con mayores ventas por región
-- ----------------------------------------------------------------------------
-- Enunciado: Suma el importe vendido por vendedor, incluyendo vendedores sin ventas, y
-- selecciona exactamente dos por región. Desempata por identificador.
-- Solución orientativa

WITH totales AS (
 SELECT p.id_vendedor,p.region,COALESCE(SUM(v.total),0) AS total
 FROM comercial.vendedores p
 LEFT JOIN comercial.vw_totales_venta v USING(id_vendedor)
 GROUP BY p.id_vendedor
), posiciones AS (
 SELECT *,ROW_NUMBER() OVER (
  PARTITION BY region ORDER BY total DESC,id_vendedor
 ) AS posicion FROM totales
)
SELECT * FROM posiciones WHERE posicion<=2
ORDER BY region,posicion;

-- ============================================================================
-- Bloque 5. Comparaciones temporales
-- ============================================================================
-- Analiza ventas mensuales, siguientes compras y acumulados. Todas las fechas corresponden a
-- 2026 y se incluyen ventas pagadas y pendientes.

-- ----------------------------------------------------------------------------
-- Ejercicio 13. Variación mensual de ventas
-- ----------------------------------------------------------------------------
-- Enunciado: Suma el importe por mes, calcula el total del mes anterior con LAG y la variación
-- porcentual. Protege la división entre cero.
-- Solución orientativa

WITH meses AS (
 SELECT DATE_TRUNC('month',fecha_venta)::date AS mes,
 SUM(total) AS total FROM comercial.vw_totales_venta
 GROUP BY 1
), cambios AS (
 SELECT *,LAG(total) OVER (ORDER BY mes) AS anterior FROM meses
)
SELECT *,ROUND(100.0*(total-anterior)/NULLIF(anterior,0),2)
 AS variacion_pct FROM cambios ORDER BY mes;
-- Nota: El primer mes tiene referencia NULL. En estos datos hay ventas de enero a septiembre; si
-- faltaran meses habría que completar el calendario antes de usar LAG como comparación mensual.

-- ----------------------------------------------------------------------------
-- Ejercicio 14. Tiempo hasta la siguiente compra
-- ----------------------------------------------------------------------------
-- Enunciado: Muestra la fecha de la siguiente venta de cada cliente y la cantidad de días entre
-- ambas mediante LEAD.
-- Solución orientativa

WITH fechas AS (
 SELECT id_cliente,id_venta,fecha_venta,
 LEAD(fecha_venta) OVER (
  PARTITION BY id_cliente ORDER BY fecha_venta,id_venta
 ) AS siguiente FROM comercial.ventas
)
SELECT *,siguiente-fecha_venta AS dias FROM fechas
ORDER BY id_cliente,fecha_venta,id_venta;

-- ----------------------------------------------------------------------------
-- Ejercicio 15. Ventas acumuladas por día
-- ----------------------------------------------------------------------------
-- Enunciado: Agrega importes por fecha y calcula su acumulado cronológico usando un marco ROWS
-- explícito.
-- Solución orientativa

WITH diario AS (
 SELECT fecha_venta,SUM(total) AS importe
 FROM comercial.vw_totales_venta GROUP BY fecha_venta
)
SELECT *,SUM(importe) OVER (
 ORDER BY fecha_venta
 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS acumulado FROM diario ORDER BY fecha_venta;
-- Nota: El último acumulado debe coincidir con SUM(total) de vw_totales_venta, sin confundirse
-- con dinero cobrado.

-- ============================================================================
-- Bloque 6. Reportes estadísticos avanzados
-- ============================================================================
-- Distingue importes vendidos de cobros recibidos y define el denominador de cada porcentaje.
-- Los importes se expresan en MXN y no incluyen impuestos.

-- ----------------------------------------------------------------------------
-- Ejercicio 16. Ventas pagadas y pendientes por vendedor
-- ----------------------------------------------------------------------------
-- Enunciado: Cuenta ventas, pagadas y pendientes con FILTER. Calcula el porcentaje de ventas
-- pagadas sobre el número de ventas de cada vendedor.
-- Solución orientativa

SELECT p.id_vendedor,p.nombre,COUNT(v.id_venta) AS ventas,
 COUNT(v.id_venta) FILTER (WHERE v.estado='Pagada') AS pagadas,
 COUNT(v.id_venta) FILTER (WHERE v.estado='Pendiente')
 AS pendientes,
 ROUND(100.0*COUNT(v.id_venta) FILTER (WHERE v.estado='Pagada')
 /NULLIF(COUNT(v.id_venta),0),2) AS porcentaje_pagadas
FROM comercial.vendedores p
LEFT JOIN comercial.ventas v USING(id_vendedor)
GROUP BY p.id_vendedor ORDER BY p.id_vendedor;

-- ----------------------------------------------------------------------------
-- Ejercicio 17. Subtotales por región y estado
-- ----------------------------------------------------------------------------
-- Enunciado: Suma importes por región y estado de venta, subtotales por región y total general
-- con ROLLUP. Identifica subtotales con GROUPING.
-- Solución orientativa

SELECT p.region,v.estado,
 GROUPING(p.region) AS es_total,
 GROUPING(v.estado) AS es_subtotal,
 SUM(v.total) AS importe
FROM comercial.vw_totales_venta v
JOIN comercial.vendedores p USING(id_vendedor)
GROUP BY ROLLUP(p.region,v.estado)
ORDER BY p.region NULLS LAST,v.estado NULLS LAST;

-- ----------------------------------------------------------------------------
-- Ejercicio 18. Distribución del ticket por región
-- ----------------------------------------------------------------------------
-- Enunciado: Calcula ticket medio, mediana y desviación estándar muestral del importe por venta
-- en cada región.
-- Solución orientativa

SELECT p.region,ROUND(AVG(v.total),2) AS ticket_medio,
 ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (
  ORDER BY v.total))::numeric,2) AS mediana,
 ROUND(STDDEV_SAMP(v.total),2) AS desviacion
FROM comercial.vw_totales_venta v
JOIN comercial.vendedores p USING(id_vendedor)
GROUP BY p.region ORDER BY p.region;

-- ============================================================================
-- Bloque 7. Inserciones y actualizaciones por conflicto
-- ============================================================================
-- Utiliza restricciones UNIQUE para decidir qué hacer si ya existe un SKU o correo. Las
-- prácticas terminan con ROLLBACK.

-- ----------------------------------------------------------------------------
-- Ejercicio 19. Actualizar el precio de un producto
-- ----------------------------------------------------------------------------
-- Enunciado: Intenta insertar SKU001. Si existe, actualiza únicamente su precio con EXCLUDED.
-- Muestra el resultado y deshaz la operación.
-- Solución orientativa

BEGIN;
INSERT INTO comercial.productos(sku,nombre,id_categoria,precio,stock)
VALUES ('SKU001','Producto de prueba',1,150,20)
ON CONFLICT(sku) DO UPDATE SET precio=EXCLUDED.precio
RETURNING *;
ROLLBACK;
-- Nota: El precio_unitario del detalle conserva el precio histórico de cada venta; cambiar el
-- catálogo no recalcula ventas anteriores.

-- ----------------------------------------------------------------------------
-- Ejercicio 20. Ignorar un correo duplicado
-- ----------------------------------------------------------------------------
-- Enunciado: Intenta registrar un cliente con el correo de cliente 1. No modifiques el cliente
-- existente y observa RETURNING.
-- Solución orientativa

BEGIN;
INSERT INTO comercial.clientes
 (nombre,apellidos,email,ciudad,fecha_registro)
VALUES ('Prueba','Duplicado','cliente1@correo.example',
        'Puebla',DATE '2026-09-30')
ON CONFLICT(email) DO NOTHING
RETURNING *;
ROLLBACK;
-- Nota: Devuelve cero filas con los datos iniciales. Una secuencia de identidad puede avanzar
-- aunque no se conserve una fila.

-- ----------------------------------------------------------------------------
-- Ejercicio 21. Completar solo un teléfono faltante
-- ----------------------------------------------------------------------------
-- Enunciado: Intenta insertar el correo del cliente 7. Si existe, actualiza el teléfono solo
-- cuando el teléfono actual es NULL.
-- Solución orientativa

BEGIN;
INSERT INTO comercial.clientes AS actual
 (nombre,apellidos,email,telefono,ciudad,fecha_registro)
VALUES ('Cliente','Prueba','cliente7@correo.example',
        '5550000007','Puebla',DATE '2026-09-30')
ON CONFLICT(email) DO UPDATE SET telefono=EXCLUDED.telefono
WHERE actual.telefono IS NULL
RETURNING *;
ROLLBACK;
-- Nota: En la base inicial el cliente 7 tiene teléfono NULL y sí se actualiza dentro de la
-- transacción.

-- ============================================================================
-- Bloque 8. Transacciones y puntos de recuperación
-- ============================================================================
-- Practica recuperaciones parciales y bloqueos. En pgAdmin ejecuta por selección las consultas
-- que quieras revisar; para concurrencia utiliza dos conexiones distintas.

-- ----------------------------------------------------------------------------
-- Ejercicio 22. Deshacer solo la segunda modificación
-- ----------------------------------------------------------------------------
-- Enunciado: Cambia el descuento de clientes 1 y 2. Usa un SAVEPOINT para revertir únicamente el
-- segundo cambio, consulta ambos y deshaz finalmente todo.
-- Solución orientativa

BEGIN;
UPDATE comercial.clientes SET descuento_porcentaje=15
WHERE id_cliente=1;
SAVEPOINT antes_del_segundo;
UPDATE comercial.clientes SET descuento_porcentaje=20
WHERE id_cliente=2;
ROLLBACK TO SAVEPOINT antes_del_segundo;
SELECT id_cliente,descuento_porcentaje
FROM comercial.clientes WHERE id_cliente IN (1,2)
ORDER BY id_cliente;
ROLLBACK;

-- ----------------------------------------------------------------------------
-- Ejercicio 23. Revisar una actualización de precio
-- ----------------------------------------------------------------------------
-- Enunciado: Aumenta 5% el precio del producto 1. Vuelve al punto de recuperación y verifica que
-- recuperó su precio.
-- Solución orientativa

BEGIN;
SAVEPOINT antes_del_aumento;
UPDATE comercial.productos SET precio=ROUND(precio*1.05,2)
WHERE id_producto=1 RETURNING *;
ROLLBACK TO SAVEPOINT antes_del_aumento;
SELECT id_producto,precio FROM comercial.productos
WHERE id_producto=1;
ROLLBACK;

-- ----------------------------------------------------------------------------
-- Ejercicio 24. Observar un bloqueo de inventario
-- ----------------------------------------------------------------------------
-- Enunciado: En A bloquea el producto 1 con FOR UPDATE. En B intenta bloquearlo con NOWAIT y
-- observa el error. Recupera B y luego libera A.
-- Solución orientativa

-- COPIA los bloques siguientes sin el prefijo de comentario a dos Query Tools.
-- Mantén abierta la transacción de A mientras ejecutas la prueba en B.
-- A: ejecutar y detenerse aquí, sin COMMIT ni ROLLBACK todavía.
-- BEGIN;
-- SELECT * FROM comercial.productos
-- WHERE id_producto=1 FOR UPDATE;

-- B: ejecutar mientras A mantiene el bloqueo; se espera un error.
-- BEGIN;
-- SELECT * FROM comercial.productos
-- WHERE id_producto=1 FOR UPDATE NOWAIT;

-- B: tras observar el error, ejecutar por separado.
-- ROLLBACK;

-- A: finalmente liberar el bloqueo.
-- ROLLBACK;
-- Nota: No ejecutes los dos bloques en una conexión. Esta práctica demuestra el bloqueo, no
-- implementa una operación completa de venta.

-- ============================================================================
-- Bloque 9. Funciones y procedimientos
-- ============================================================================
-- Crea objetos reutilizables para consultar importes, clasificar tickets y asignar descuentos.
-- Las funciones y procedimientos de solución no vienen instalados en el respaldo.

-- ----------------------------------------------------------------------------
-- Ejercicio 25. Función de importe comprado
-- ----------------------------------------------------------------------------
-- Enunciado: Crea una función SQL que devuelva el importe total de ventas de un cliente.
-- Devuelve cero si no tiene ventas y pruébala con el cliente 1.
-- Solución orientativa

CREATE OR REPLACE FUNCTION comercial.total_cliente(p_id int)
RETURNS numeric LANGUAGE sql STABLE AS $$
 SELECT COALESCE(SUM(total),0)
 FROM comercial.vw_totales_venta WHERE id_cliente=p_id;
$$;
SELECT comercial.total_cliente(1);
-- Nota: Incluye ventas pagadas y pendientes. La función devuelve cero también si el
-- identificador no existe.

-- ----------------------------------------------------------------------------
-- Ejercicio 26. Clasificar un ticket con IF
-- ----------------------------------------------------------------------------
-- Enunciado: Crea una función PL/pgSQL: NULL es Sin información; menos de 1000 es Bajo; de 1000
-- a menos de 5000 es Medio; 5000 o más es Alto. Rechaza importes negativos.
-- Solución orientativa

CREATE OR REPLACE FUNCTION comercial.clasificar_ticket(n numeric)
RETURNS text LANGUAGE plpgsql AS $$
BEGIN
 IF n IS NULL THEN RETURN 'Sin información';
 ELSIF n<0 THEN RAISE EXCEPTION 'Importe negativo';
 ELSIF n<1000 THEN RETURN 'Bajo';
 ELSIF n<5000 THEN RETURN 'Medio';
 ELSE RETURN 'Alto';
 END IF;
END; $$;
SELECT comercial.clasificar_ticket(2500);

-- ----------------------------------------------------------------------------
-- Ejercicio 27. Procedimiento para asignar descuento
-- ----------------------------------------------------------------------------
-- Enunciado: Valida un descuento entre 0 y 100 y actualiza el cliente indicado. Lanza excepción
-- si no existe. Prueba el procedimiento y deshaz el cambio.
-- Solución orientativa

CREATE OR REPLACE PROCEDURE comercial.asignar_descuento(
 p_id int,p_descuento numeric)
LANGUAGE plpgsql AS $$
BEGIN
 IF p_descuento IS NULL OR p_descuento<0 OR p_descuento>100 THEN
  RAISE EXCEPTION 'Descuento fuera de rango';
 END IF;
 UPDATE comercial.clientes SET descuento_porcentaje=p_descuento
 WHERE id_cliente=p_id;
 IF NOT FOUND THEN RAISE EXCEPTION 'Cliente inexistente'; END IF;
END; $$;
BEGIN;
CALL comercial.asignar_descuento(1,12);
SELECT id_cliente,descuento_porcentaje FROM comercial.clientes
WHERE id_cliente=1;
ROLLBACK;

-- ============================================================================
-- Bloque 10. Triggers y auditoría
-- ============================================================================
-- Resuelve los tres Ejercicios en orden. La bitácora registrará cambios futuros del descuento de
-- clientes; no reconstruye cambios anteriores.

-- ----------------------------------------------------------------------------
-- Ejercicio 28. Crear la bitácora de descuentos
-- ----------------------------------------------------------------------------
-- Enunciado: Crea una tabla para guardar cliente, descuento anterior, nuevo, usuario y fecha del
-- cambio.
-- Solución orientativa

CREATE TABLE comercial.auditoria_descuentos (
 id_evento bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 id_cliente int NOT NULL,
 descuento_anterior numeric(5,2),
 descuento_nuevo numeric(5,2),
 usuario text NOT NULL,
 fecha timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- Nota: Empieza vacía. No se añade clave foránea para conservar el historial aunque
-- posteriormente se elimine un cliente.

-- ----------------------------------------------------------------------------
-- Ejercicio 29. Registrar automáticamente el cambio
-- ----------------------------------------------------------------------------
-- Enunciado: Crea la función y un trigger AFTER UPDATE que use OLD y NEW, solo cuando cambie
-- realmente el descuento.
-- Solución orientativa

CREATE OR REPLACE FUNCTION comercial.registrar_descuento()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
 INSERT INTO comercial.auditoria_descuentos
 (id_cliente,descuento_anterior,descuento_nuevo,usuario)
 VALUES (NEW.id_cliente,OLD.descuento_porcentaje,
         NEW.descuento_porcentaje,current_user);
 RETURN NEW;
END; $$;
CREATE TRIGGER trg_auditar_descuento
AFTER UPDATE OF descuento_porcentaje ON comercial.clientes
FOR EACH ROW
WHEN (OLD.descuento_porcentaje IS DISTINCT FROM
      NEW.descuento_porcentaje)
EXECUTE FUNCTION comercial.registrar_descuento();

-- ----------------------------------------------------------------------------
-- Ejercicio 30. Comprobar el efecto de ROLLBACK
-- ----------------------------------------------------------------------------
-- Enunciado: Cambia el descuento del cliente 1, observa el evento y deshaz la transacción.
-- Verifica que también se revirtió el evento de auditoría.
-- Solución orientativa

BEGIN;
UPDATE comercial.clientes
SET descuento_porcentaje=CASE
 WHEN descuento_porcentaje=12 THEN 15 ELSE 12 END
WHERE id_cliente=1;
SELECT * FROM comercial.auditoria_descuentos ORDER BY id_evento;
ROLLBACK;
SELECT * FROM comercial.auditoria_descuentos ORDER BY id_evento;
-- Nota: La bitácora forma parte de la transacción. La identidad puede conservar un hueco tras la
-- reversión.

-- ============================================================================
-- Bloque 11. Índices y rendimiento
-- ============================================================================
-- Crea una tabla auxiliar sintética con 100000 operaciones para comparar planes. Las siete
-- tablas base conservan entre 30 y 100 filas.

-- ----------------------------------------------------------------------------
-- Ejercicio 31. Medir una consulta sin índice
-- ----------------------------------------------------------------------------
-- Enunciado: Crea operaciones de laboratorio y ejecuta ANALYZE. Mide una consulta selectiva por
-- cliente con EXPLAIN ANALYZE y BUFFERS.
-- Solución orientativa

CREATE TABLE comercial.laboratorio_ventas AS
SELECT i AS id_operacion,1+(i%1000) AS id_cliente,
 DATE '2020-01-01'+(i%2000) AS fecha,
 REPEAT('Operacion comercial ',10) AS detalle
FROM generate_series(1,100000) AS s(i);
ANALYZE comercial.laboratorio_ventas;
EXPLAIN (ANALYZE,BUFFERS)
SELECT * FROM comercial.laboratorio_ventas
WHERE id_cliente=250;
-- Nota: Los clientes de laboratorio no tienen clave foránea. EXPLAIN ANALYZE ejecuta realmente
-- la consulta.

-- ----------------------------------------------------------------------------
-- Ejercicio 32. Comparar con un índice simple
-- ----------------------------------------------------------------------------
-- Enunciado: Crea un índice por cliente y repite la consulta. Compara recorrido, tiempo y
-- buffers.
-- Solución orientativa

CREATE INDEX idx_lab_cliente
ON comercial.laboratorio_ventas(id_cliente);
ANALYZE comercial.laboratorio_ventas;
EXPLAIN (ANALYZE,BUFFERS)
SELECT * FROM comercial.laboratorio_ventas
WHERE id_cliente=250;
-- Nota: El plan y el tiempo dependen del volumen, las estadísticas y la caché. No se garantiza
-- un factor fijo de mejora.

-- ----------------------------------------------------------------------------
-- Ejercicio 33. Índice compuesto por cliente y fecha
-- ----------------------------------------------------------------------------
-- Enunciado: Crea un índice compuesto y examina una consulta por cliente y rango de fechas,
-- ordenada cronológicamente.
-- Solución orientativa

CREATE INDEX idx_lab_cliente_fecha
ON comercial.laboratorio_ventas(id_cliente,fecha);
EXPLAIN (ANALYZE,BUFFERS)
SELECT * FROM comercial.laboratorio_ventas
WHERE id_cliente=250
 AND fecha>=DATE '2023-01-01'
 AND fecha<DATE '2026-01-01'
ORDER BY fecha;
-- Nota: Cada índice consume espacio y añade trabajo a las escrituras. El optimizador puede
-- elegir un plan distinto del esperado.

-- ============================================================================
-- Bloque 12. Roles respaldos y restauración
-- ============================================================================
-- La creación de roles requiere CREATEROLE y los cambios de privilegios requieren autorización
-- sobre los objetos. Los roles globales no se crean mediante el respaldo de una base.

-- ----------------------------------------------------------------------------
-- Ejercicio 34. Crear un rol de consulta
-- ----------------------------------------------------------------------------
-- Enunciado: Crea un rol sin inicio de sesión con USAGE en comercial y SELECT en sus tablas y
-- vistas. Comprueba que puede consultar clientes pero no actualizarlos.
-- Solución orientativa

CREATE ROLE comercial_lector NOLOGIN;
GRANT USAGE ON SCHEMA comercial TO comercial_lector;
GRANT SELECT ON ALL TABLES IN SCHEMA comercial TO comercial_lector;
SELECT has_table_privilege('comercial_lector',
 'comercial.clientes','SELECT') AS puede_leer,
 has_table_privilege('comercial_lector',
 'comercial.clientes','UPDATE') AS puede_actualizar;
-- Nota: Ejecuta CREATE ROLE una vez. Para asignarlo a una cuenta existente: GRANT
-- comercial_lector TO nombre_usuario; sustituye el nombre.

-- ----------------------------------------------------------------------------
-- Ejercicio 35. Privilegios futuros y revocación
-- ----------------------------------------------------------------------------
-- Enunciado: Configura SELECT para las tablas que cree posteriormente el usuario actual. Revoca
-- SELECT directo sobre vendedores y verifica el resultado.
-- Solución orientativa

ALTER DEFAULT PRIVILEGES IN SCHEMA comercial
GRANT SELECT ON TABLES TO comercial_lector;
REVOKE SELECT ON comercial.vendedores FROM comercial_lector;
SELECT has_table_privilege('comercial_lector',
 'comercial.vendedores','SELECT') AS puede_leer_vendedores;
-- Nota: Los privilegios predeterminados corresponden al rol creador que ejecuta la sentencia y a
-- sus objetos futuros. Permisos heredados o vistas pueden ofrecer otras vías de lectura.

-- ----------------------------------------------------------------------------
-- Ejercicio 36. Crear un respaldo y restaurarlo
-- ----------------------------------------------------------------------------
-- Enunciado: Genera un respaldo Custom y restáuralo en ventas_verificacion. Verifica las siete
-- tablas con la consulta inicial y revisa ventas y renglones de detalle.
-- Solución orientativa

-- ALTERNATIVA EN PGADMIN
-- A. Clic derecho en ventas_intermedia > Backup > formato Custom.
--    Guarda el archivo como ventas_copia.backup.
-- B. Crea una base vacía llamada ventas_verificacion.
-- C. Clic derecho en ventas_verificacion > Restore > selecciona el respaldo.
--    Excluye Owner y Privileges. Comprueba que termine sin errores.
-- D. Abre OTRO Query Tool conectado a ventas_verificacion para los SELECT finales.
--
-- ALTERNATIVA EN TERMINAL (cada comando en una sola línea)
-- pg_dump -U postgres -d ventas_intermedia -Fc -f ventas_copia.backup
-- createdb -U postgres ventas_verificacion
-- pg_restore -U postgres -d ventas_verificacion --no-owner --no-acl --exit-on-error ventas_copia.backup

-- Ejecutar solo en Query Tool conectado a ventas_verificacion.
SELECT current_database() AS base_restaurada;
SELECT COUNT(*) AS ventas FROM comercial.ventas;
SELECT COUNT(*) AS renglones FROM comercial.detalle_ventas;
-- Nota: En la carga inicial hay 60 ventas y 100 renglones. Ajusta usuario, host y rutas. Los
-- comandos de terminal no se ejecutan en Query Tool; también puedes usar Backup y Restore de
-- pgAdmin.

-- FIN DE LOS 36 EjercicioS
