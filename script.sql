-- 1. Cargar el respaldo de la base de datos unidad2.sql.
--psql -U postgres compras_db < unidad2

-- 2. El cliente usuario01 ha realizado la siguiente compra:
-- ● producto: producto9.
-- ● cantidad: 5.
-- ● fecha: fecha del sistema.
BEGIN TRANSACTION;
INSERT INTO compra (cliente_id, fecha) VALUES (1, '13-04-2022');
SELECT * FROM compra; -- se ejecuta para saber el compra_id
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (9, 39, 5);
SELECT * FROM detalle_compra;
UPDATE producto SET stock = stock - 5 WHERE id = 1;
SELECT * FROM producto;
COMMIT;
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este requerimiento y luego consulta 
-- la tabla producto para validar si fue efectivamente descontado en el stock.
              
-- 3. El cliente usuario02 ha realizado la siguiente compra:
-- ● producto: producto1, producto 2, producto 8.
-- ● cantidad: 3 de cada producto.
-- ● fecha: fecha del sistema.
BEGIN TRANSACTION;
INSERT INTO compra (cliente_id, fecha) VALUES (2, '13-04-2022');
SELECT * FROM compra; -- verificar compra_id para entregar valor en el sgte insert  
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (1, 41, 3);
SELECT * FROM detalle_compra;
UPDATE producto SET stock = stock  - 3 WHERE id = 1;
SELECT * from producto;
COMMIT;

BEGIN TRANSACTION;
INSERT INTO compra (cliente_id, fecha) VALUES (2, '13-04-2022');
SELECT * FROM compra; -- verificar compra_id para entregar valor en el sgte insert  
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (2, 42, 3);
SELECT * FROM detalle_compra;
UPDATE producto SET stock = stock  - 3 WHERE id = 2;
SELECT * from producto;
COMMIT;

BEGIN TRANSACTION;
INSERT INTO compra (cliente_id, fecha) VALUES (2, '13-04-2022');
SELECT * FROM compra; -- verificar compra_id para entregar valor en el sgte insert  
INSERT INTO detalle_compra (producto_id, compra_id, cantidad) VALUES (8, 43, 3)
SELECT * FROM detalle_compra;
UPDATE producto SET stock = stock - 3 WHERE id = 8; -- arroja error porque no cumple el check de stock se debe hacer rollback
SELECT * from producto;
ROLLBACK;
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este requerimiento y luego consulta 
-- la tabla producto para validar que si alguno de ellos se queda sin stock, no se realice la compra.

-- 4. Realizar las siguientes consultas:
-- a. Deshabilitar el AUTOCOMMIT.
-- SOLUCION: \set AUTOCOMMIT off

-- b. Insertar un nuevo cliente.
BEGIN TRANSACTION;
INSERT INTO cliente (nombre, email) VALUES ('usuario20', 'usuario20@gmail.com');

-- c. Confirmar que fue agregado en la tabla cliente.
SELECT * FROM cliente;

-- d. Realizar un ROLLBACK.
ROLLBACK;
-- e. Confirmar que se restauró la información, sin considerar la inserción delpunto b.

-- f. Habilitar de nuevo el AUTOCOMMIT.
-- SOLUCION: \set AUTOCOMMIT on