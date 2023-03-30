# 1.9 Ejercicios de repaso
# ¿Qué beneficios nos puede aportar utilizar procedimientos y funciones almacenadas?
# Según la siguiente sentencia, ¿estamos haciendo una llamada a un procedimiento o a una función?
# CALL resolver_ejercicio2()
# ¿Cuáles de los siguientes bloques son correctos?
# 1.
# LOOP bucle:
#   statements
# END bucle:
#
# 2.
# bucle: LOOP
#   statements
# END bucle;
#
# 3.
# bucle:
# LOOP bucle;
#   statements;
# END bucle;
# ¿Pueden aparecer las siguientes sentencias en el mismo bloque de código?
# DECLARE a INT;
# DECLARE a INT;
# ¿Pueden aparecer las siguientes sentencias en el mismo bloque de código?
# DECLARE a INT;
# DECLARE a FLOAT;
# ¿Pueden aparecer las siguientes sentencias en el mismo bloque de código?
# DECLARE b VARCHAR(20);
# DECLARE b HANDLER FOR SQLSTATE '02000';
# ¿Para qué podemos utilizar un cursor en MySQL?
#
# ¿Puedo actualizar los datos de un cursor en MySQL? Si fuese posible actualizar los datos de un cursor, ¿se actualizarían automáticamente los datos de la tabla?
#
# Cuál o cuáles de los siguientes bucles no está soportado en MySQL: FOR, LOOP, REPEAT y WHILE.
#
# Si el cuerpo del bucle se debe ejecutar al menos una vez, ¿qué bucle sería más apropiado?
#
# ¿Qué valor devuelve la sentencia SELECT value?
#
# 0
# 9
# 10
# NULL
# El código entra en un bucle infinito y nunca alcanza la sentencia SELECT value
# DELIMITER $$
# CREATE PROCEDURE incrementor (OUT i INT)
# BEGIN
#   REPEAT
#     SET i = i + 1;
#   UNTIL i > 9
#   END REPEAT;
# END;
#
# DELIMITER $$
# CREATE PROCEDURE test ()
# BEGIN
#   DECLARE value INT default 0;
#   CALL incrementor(value);
#
#   -- ¿Qué valor se muestra en esta sentencia?
#   SELECT value;
# END;
#
# DELIMITER ;
# CALL test();
# ¿Qué valor devuelve la sentencia SELECT value?
# 0
# 9
# 10
# NULL
# El código entra en un bucle infinito y nunca alcanza la sentencia SELECT value
# DELIMITER $$
# CREATE PROCEDURE incrementor (IN i INT)
# BEGIN
#   REPEAT
#     SET i = i + 1;
#   UNTIL i > 9
#   END REPEAT;
# END;
#
# DELIMITER $$
# CREATE PROCEDURE test ()
# BEGIN
#   DECLARE value INT default 0;
#   CALL incrementor(value);
#
#   -- ¿Qué valor se muestra en esta sentencia?
#   SELECT value;
# END;
#
# DELIMITER ;
# CALL test();
# Realice los siguientes procedimientos y funciones sobre la base de datos jardineria.
# Función: calcular_precio_total_pedido
# Descripción: Dado un código de pedido la función debe calcular la suma total del pedido. Tenga en cuenta que un pedido puede contener varios productos diferentes y varias cantidades de cada producto.
# Parámetros de entrada: codigo_pedido (INT)
# Parámetros de salida: El precio total del pedido (FLOAT)
# Función: calcular_suma_pedidos_cliente
# Descripción: Dado un código de cliente la función debe calcular la suma total de todos los pedidos realizados por el cliente. Deberá hacer uso de la función calcular_precio_total_pedido que ha desarrollado en el apartado anterior.
# Parámetros de entrada: codigo_cliente (INT)
# Parámetros de salida: La suma total de todos los pedidos del cliente (FLOAT)
# Función: calcular_suma_pagos_cliente
# Descripción: Dado un código de cliente la función debe calcular la suma total de los pagos realizados por ese cliente.
# Parámetros de entrada: codigo_cliente (INT)
# Parámetros de salida: La suma total de todos los pagos del cliente (FLOAT)
# Procedimiento: calcular_pagos_pendientes
# Descripción: Deberá calcular los pagos pendientes de todos los clientes. Para saber si un cliente tiene algún pago pendiente deberemos calcular cuál es la cantidad de todos los pedidos y los pagos que ha realizado. Si la cantidad de los pedidos es mayor que la de los pagos entonces ese cliente tiene pagos pendientes.
# Deberá insertar en una tabla llamada clientes_con_pagos_pendientes los siguientes datos:
#
# id_cliente
# suma_total_pedidos
# suma_total_pagos
# pendiente_de_pago
# Teniendo en cuenta el significado de los siguientes códigos de error:
# Error: 1036 (ER_OPEN_AS_READONLY). Table ‘%s’ is read only
# Error: 1062 (ER_DUP_ENTRY). Duplicate entry ‘%s’ for key %d
# -- Paso 1
# CREATE TABLE t (s1 INT, PRIMARY KEY (s1));
#
# -- Paso 2
# DELIMITER $$
# CREATE PROCEDURE handlerexam(IN a INT, IN b INT, IN c INT, OUT x INT)
# BEGIN
#   DECLARE EXIT HANDLER FOR 1036 SET x = 10;
#   DECLARE EXIT HANDLER FOR 1062 SET x = 30;
#
#   SET x = 1;
#   INSERT INTO t VALUES (a);
#   SET x = 2;
#   INSERT INTO t VALUES (b);
#   SET x = 3;
#   INSERT INTO t VALUES (c);
#   SET x = 4;
# END
# $$
# ¿Qué devolvería la última sentencia SELECT @x en cada caso (a y b)? Justifique su respuesta. Sin una justificación válida la respuesta será considerada incorrecta.
#
# -- a)
# CALL handlerexam(1, 2, 3, @x);
# SELECT @x;
#
# -- b)
# CALL handlerexam(1, 2, 1, @x);
# SELECT @x;
# Dado el siguiente procedimiento:
# -- Paso 1
# CREATE TABLE t (s1 INT, PRIMARY KEY (s1));
#
# -- Paso 2
# DELIMITER $$
# CREATE PROCEDURE test(IN a INT, OUT b INT)
# BEGIN
#     SET b = 0;
#     WHILE a > b DO
#         SET b = b + 1;
#         IF b != 2 THEN
#             INSERT INTO t VALUES (b);
#         END IF
#     END WHILE;
# END;
# ¿Qué valores tendría la tabla t y qué valor devuelve la sentencia SELECT value en cada caso (a y b)? Justifique la respuesta. Sin una justificación válida la respuesta será considerada incorrecta.
#
# -- a)
# CALL test(-10, @value);
# SELECT @value;
#
# -- b)
# CALL test(10, @value);
# SELECT @value;
# Escriba un procedimiento llamado obtener_numero_empleados que reciba como parámetro de entrada el código de una oficina y devuelva el número de empleados que tiene.
# Escriba una sentencia SQL que realice una llamada al procedimiento realizado para comprobar que se ejecuta correctamente.
#
# Escriba una función llamada cantidad_total_de_productos_vendidos que reciba como parámetro de entrada el código de un producto y devuelva la cantidad total de productos que se han vendido con ese código.
# Escriba una sentencia SQL que realice una llamada a la función realizada para comprobar que se ejecuta correctamente.
#
# Crea una tabla que se llame productos_vendidos que tenga las siguientes columnas:
# id (entero sin signo, auto incremento y clave primaria)
# codigo_producto (cadena de caracteres)
# cantidad_total (entero)
# Escriba un procedimiento llamado estadísticas_productos_vendidos que para cada uno de los productos de la tabla producto calcule la cantidad total de unidades que se han vendido y almacene esta información en la tabla productos_vendidos.
#
# El procedimiento tendrá que realizar las siguientes acciones:
#
# Borrar el contenido de la tabla productos_vendidos.
# Recorrer cada uno de los productos de la tabla producto. Será necesario usar un cursor.
# Calcular la cantidad total de productos vendidos. En este paso será necesario utilizar la función cantidad_total_de_productos_vendidos desarrollada en el ejercicio 2.
# Insertar en la tabla productos_vendidos los valores del código de producto y la cantidad total de unidades que se han vendido para ese producto en concreto.
# Crea una tabla que se llame notificaciones que tenga las siguientes columnas:
# id (entero sin signo, autoincremento y clave primaria)
# fecha_hora: marca de tiempo con el instante del pago (fecha y hora)
# total: el valor del pago (real)
# codigo_cliente: código del cliente que realiza el pago (entero)
# Escriba un trigger que nos permita llevar un control de los pagos que van realizando los clientes. Los detalles de implementación son los siguientes:
#
# Nombre: trigger_notificar_pago
# Se ejecuta sobre la tabla pago.
# Se ejecuta después de hacer la inserción de un pago.
# Cada vez que un cliente realice un pago (es decir, se hace una inserción en la tabla pago), el trigger deberá insertar un nuevo registro en una tabla llamada notificaciones.
# Escriba algunas sentencias SQL para comprobar que el trigger funciona correctamente.