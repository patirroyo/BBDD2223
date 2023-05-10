# 1.9 Ejercicios de repaso
# 1. ¿Qué beneficios nos puede aportar utilizar procedimientos y funciones almacenadas?

-- El uso de procedimientos y funciones almacenadas en MySQL puede proporcionar varios beneficios a los desarrolladores y administradores de bases de datos. Algunos de estos beneficios incluyen:

    -- Reutilización de código: Los procedimientos y funciones almacenadas permiten la reutilización de código, lo que significa que una vez que se ha creado una función o procedimiento, se puede utilizar en varias partes del código sin tener que escribir el mismo código varias veces. Esto reduce el tiempo y esfuerzo necesarios para desarrollar aplicaciones y mejora la mantenibilidad del código.
    -- Mejora del rendimiento: Las funciones y procedimientos almacenados se ejecutan en el servidor de la base de datos, lo que puede proporcionar un mejor rendimiento en comparación con la ejecución de código en el cliente. Además, la capacidad de ejecutar múltiples operaciones en una sola llamada de procedimiento también puede mejorar el rendimiento de la aplicación.
    -- Mejora de la seguridad: Los procedimientos almacenados pueden proporcionar una mayor seguridad al permitir que los desarrolladores restrinjan el acceso a ciertos datos y operaciones en la base de datos. Esto se logra mediante la creación de procedimientos almacenados que requieren autenticación y autorización antes de ejecutar una operación.
    -- Facilita el mantenimiento: La implementación de funciones y procedimientos almacenados en una base de datos puede facilitar la tarea de mantenimiento de la base de datos. Al tener todo el código en un solo lugar, es más fácil de entender, depurar y mantener.
-- En resumen, el uso de procedimientos y funciones almacenadas puede proporcionar una serie de beneficios a los desarrolladores y administradores de bases de datos, como la reutilización de código, mejoras de rendimiento, mejora de la seguridad y facilita el mantenimiento.


# 2. Según la siguiente sentencia, ¿estamos haciendo una llamada a un procedimiento o a una función?

# CALL resolver_ejercicio2()


-- La sentencia "CALL resolver_ejercicio2()" está haciendo una llamada a un procedimiento almacenado en MySQL. En este caso, el procedimiento se llama "resolver_ejercicio2" y se está llamando mediante la sentencia CALL.

-- Es importante tener en cuenta que las funciones almacenadas también se pueden llamar utilizando la misma sintaxis de CALL, pero en este caso la sentencia sería "SELECT resolver_ejercicio2()". La principal diferencia entre los procedimientos y las funciones almacenadas es que las funciones deben devolver un valor, mientras que los procedimientos no necesitan hacerlo.

# 3. ¿Cuáles de los siguientes bloques son correctos?
# 1.
# LOOP bucle:
#   statements
# END bucle:

# 2.
# bucle: LOOP
#   statements
# END bucle;

# 3.
# bucle:
# LOOP bucle;
#   statements;
# END bucle;

-- El correcto es el 2, por sintaxis.

# 4. ¿Pueden aparecer las siguientes sentencias en el mismo bloque de código?
# DECLARE a INT;
# DECLARE a INT;

-- No, porque es declarar lo mismo dos veces. No se puede duplicar una variable.

# 5. ¿Pueden aparecer las siguientes sentencias en el mismo bloque de código?
# DECLARE a INT;
# DECLARE a FLOAT;

-- No, por lo mismo que en el ejercicio anterior. No se puede declarar la misma variable dos veces.

# 6. ¿Pueden aparecer las siguientes sentencias en el mismo bloque de código?
# DECLARE b VARCHAR(20);
# DECLARE b HANDLER FOR SQLSTATE '02000';

-- NO, por lo mismo que en los ejercicios anteriores: no se puede declarar la misma variable dos veces.

# 7. ¿Para qué podemos utilizar un cursor en MySQL?


-- En MySQL, un cursor es un objeto que permite recorrer los resultados de una consulta SELECT de forma secuencial, permitiendo así el procesamiento de cada fila individualmente. Los cursores pueden ser útiles en situaciones en las que se necesita realizar operaciones más complejas en los datos obtenidos a través de una consulta.

-- Por ejemplo, supongamos que tenemos una tabla de empleados y queremos calcular el salario promedio de todos los empleados de un determinado departamento. Podemos usar un cursor para recorrer los registros del departamento seleccionado, sumar los salarios y luego dividir por el número total de empleados.

-- Los cursores también pueden ser útiles en situaciones en las que se necesita procesar datos en varias etapas o cuando se necesita realizar operaciones de actualización o eliminación en los datos. Sin embargo, es importante tener en cuenta que el uso de cursores puede tener un impacto negativo en el rendimiento, por lo que se deben utilizar con cuidado y sólo cuando sea necesario.


# 8. ¿Puedo actualizar los datos de un cursor en MySQL? Si fuese posible actualizar los datos de un cursor, ¿se actualizarían automáticamente los datos de la tabla?

-- En MySQL, es posible actualizar los datos de un cursor utilizando la declaración UPDATE en combinación con la instrucción WHERE. Sin embargo, es importante tener en cuenta que la actualización de datos en un cursor no actualiza automáticamente los datos en la tabla correspondiente.

-- Cuando se actualiza un registro a través de un cursor, sólo se actualiza el valor en la memoria que contiene el cursor. Para actualizar los datos en la tabla, se debe ejecutar una instrucción UPDATE adicional utilizando la clave primaria o cualquier otro identificador único para actualizar el registro correspondiente.

-- Por lo tanto, si se actualizan los datos de un cursor en MySQL, es necesario realizar una actualización adicional en la tabla correspondiente para que los cambios se reflejen en la base de datos.

# 9. Cuál o cuáles de los siguientes bucles no está soportado en MySQL: FOR, LOOP, REPEAT y WHILE.

-- El bucle FOR no está soportado en MySQL

# 10. Si el cuerpo del bucle se debe ejecutar al menos una vez, ¿qué bucle sería más apropiado?

-- REPEAT, pues se ejecuta una vez y luego mientras se cumpla la condición que le hayamos dado.

# 11. ¿Qué valor devuelve la sentencia SELECT value?
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

-- Devolverá el valor 10, pues se repite hasta que 1 sea mayor de 9, y como va incrementando de uno en uno, lo lógico es que pare en el momento inmediatamente posterior a pasar el 9.


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



# 11. ¿Qué valor devuelve la sentencia SELECT value?
# 0
# 9
# 10
# NULL
# El código entra en un bucle infinito y nunca alcanza la sentencia SELECT value

-- 10, el procedimiento test llama al procedimiento incrementor, el valor 'value' que en un primero momento es 0 se devuelve como 10 al ejecutarse incrementor() y luego se muestra por pantalla.


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

--


# 12. Realice los siguientes procedimientos y funciones sobre la base de datos jardineria.
# a.
    # Función: calcular_precio_total_pedido
    # Descripción: Dado un código de pedido la función debe calcular la suma total del pedido. Tenga en cuenta que un pedido puede contener varios productos diferentes y varias cantidades de cada producto.
    # Parámetros de entrada: codigo_pedido (INT)
    # Parámetros de salida: El precio total del pedido (FLOAT)

    USE jardineria;

    DELIMITER $$
    DROP FUNCTION IF EXISTS calcular_precio_total_pedido $$
    CREATE FUNCTION calcular_precio_total_pedido(codigo_pedido INT)
        RETURNS FLOAT READS SQL DATA
        BEGIN
            DECLARE total FLOAT;
            SELECT SUM(dp.precio_unidad*dp.cantidad) INTO total
            FROM detalle_pedido dp
            WHERE dp.codigo_pedido = codigo_pedido;
        RETURN total;
    END $$
    DELIMITER ;
    SELECT calcular_precio_total_pedido(35);

# b.
    # Función: calcular_suma_pedidos_cliente
    # Descripción: Dado un código de cliente la función debe calcular la suma total de todos los pedidos realizados por el cliente. Deberá hacer uso de la función calcular_precio_total_pedido que ha desarrollado en el apartado anterior.
    # Parámetros de entrada: codigo_cliente (INT)
    # Parámetros de salida: La suma total de todos los pedidos del cliente (FLOAT)

    DELIMITER $$
    DROP FUNCTION IF EXISTS calcular_suma_pedidos_cliente $$
    CREATE FUNCTION calcular_suma_pedidos_cliente(codigo_cliente INT)
        RETURNS FLOAT READS SQL DATA
        BEGIN
            DECLARE total FLOAT;
            DECLARE done INT DEFAULT 0;
            DECLARE total_pedido FLOAT;
            DECLARE pedidos_cliente CURSOR FOR SELECT calcular_precio_total_pedido(dp.codigo_pedido)
                                                FROM detalle_pedido dp INNER JOIN pedido p
                                                    ON dp.codigo_pedido = p.codigo_pedido
                                                WHERE p.codigo_cliente = codigo_cliente
                                                    AND p.estado != 'Rechazado';
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
            OPEN pedidos_cliente;
            SET total = 0;
            bucle: LOOP
                SET total_pedido = 0;
                FETCH pedidos_cliente INTO total_pedido;
                IF done = 1 THEN
                    LEAVE bucle;
                END IF;
                SET total = total + total_pedido;
            END LOOP;
            CLOSE pedidos_cliente;
        RETURN total;
    END $$
    DELIMITER ;
    SELECT calcular_suma_pedidos_cliente(38);

-- otra forma de hacerlo sin cursor:
    DELIMITER $$
    DROP FUNCTION IF EXISTS calcular_suma_pedidos_cliente2 $$
    CREATE FUNCTION calcular_suma_pedidos_cliente2(codigo_cliente INT)
        RETURNS FLOAT READS SQL DATA
        BEGIN
            DECLARE total FLOAT;
            SELECT SUM(calcular_precio_total_pedido(dp.codigo_pedido)) INTO total
            FROM detalle_pedido dp INNER JOIN pedido p
                ON dp.codigo_pedido = p.codigo_pedido
            WHERE p.codigo_cliente = codigo_cliente;
        RETURN total;
    END $$
    DELIMITER ;
    SELECT calcular_suma_pedidos_cliente2(38);

#c.
    # Función: calcular_suma_pagos_cliente
    # Descripción: Dado un código de cliente la función debe calcular la suma total de los pagos realizados por ese cliente.
    # Parámetros de entrada: codigo_cliente (INT)
    # Parámetros de salida: La suma total de todos los pagos del cliente (FLOAT)

    DELIMITER $$
    DROP FUNCTION IF EXISTS calcular_suma_pagos_cliente $$
    CREATE FUNCTION calcular_suma_pagos_cliente(codigo_cliente INT)
        RETURNS FLOAT READS SQL DATA
        BEGIN
            DECLARE total FLOAT;
            DECLARE done INT DEFAULT 0;
            DECLARE total_pedido FLOAT;
            DECLARE pagos_cliente CURSOR FOR SELECT p.total
                                                FROM  pago p
                                                WHERE p.codigo_cliente = codigo_cliente;
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
            OPEN pagos_cliente;
            SET total = 0;
            bucle: LOOP
                SET total_pedido = 0;
                FETCH pagos_cliente INTO total_pedido;
                IF done = 1 THEN
                    LEAVE bucle;
                END IF;
                SET total = total + total_pedido;
            END LOOP;
            CLOSE pagos_cliente;
        RETURN total;
    END $$
    DELIMITER ;
    SELECT calcular_suma_pagos_cliente(1);

# d.
    # Procedimiento: calcular_pagos_pendientes
    # Descripción: Deberá calcular los pagos pendientes de todos los clientes. Para saber si un cliente tiene algún pago pendiente deberemos calcular cuál es la cantidad de todos los pedidos y los pagos que ha realizado. Si la cantidad de los pedidos es mayor que la de los pagos entonces ese cliente tiene pagos pendientes.
# Deberá insertar en una tabla llamada clientes_con_pagos_pendientes los siguientes datos:
#
# id_cliente
# suma_total_pedidos
# suma_total_pagos
# pendiente_de_pago

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pagos_pendientes $$
CREATE PROCEDURE calcular_pagos_pendientes()
    BEGIN
        DECLARE id INT;
        DECLARE done INT DEFAULT 0;
        DECLARE clientes CURSOR FOR SELECT c.codigo_cliente
                                    FROM cliente c;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
        DROP TABLE IF EXISTS clientes_con_pagos_pendientes;
        CREATE TABLE clientes_con_pagos_pendientes(id_cliente INT,
                                                    suma_total_pedidos FLOAT,
                                                    suma_total_pagos FLOAT,
                                                    pendiente_de_pago FLOAT);
        OPEN clientes;
        bucle: LOOP
            FETCH clientes INTO id;
            IF done = 1 THEN
                LEAVE bucle;
            END IF;
            INSERT INTO clientes_con_pagos_pendientes(id_cliente,
                                                  suma_total_pedidos,
                                                  suma_total_pagos) VALUES(id,
                                                                            calcular_suma_pedidos_cliente(id),
                                                                            calcular_suma_pagos_cliente(id));
            UPDATE clientes_con_pagos_pendientes SET pendiente_de_pago = suma_total_pedidos - suma_total_pagos
            WHERE id_cliente = id;
        END LOOP;
        CLOSE clientes;
    END $$
    DELIMITER ;
    CALL calcular_pagos_pendientes();


# 13. Teniendo en cuenta el significado de los siguientes códigos de error:
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

# -- a)
# CALL handlerexam(1, 2, 3, @x);
# SELECT @x;
#
# -- b)
# CALL handlerexam(1, 2, 1, @x);
# SELECT @x;

-- En el primer caso (a), se están insertando valores distintos en la tabla, por lo que no se debería producir ningún error. El valor de la variable x se establece en 4 antes de que termine la ejecución del procedimiento almacenado, por lo que la última sentencia SELECT @x devolverá el valor 4.

-- En el segundo caso (b), se está intentando insertar un valor duplicado (1) en la columna que tiene una restricción de clave única. Como se ha declarado un manejador de excepción para el código de error 1062, el valor de la variable x se establecerá en 30 en lugar de seguir insertando valores. La última sentencia SET establece el valor de x en 2 antes de que se produzca el error, por lo que la última sentencia SELECT @x devolverá el valor 30.

-- Por lo tanto, las respuestas serían:

    -- Para el caso (a): la última sentencia SELECT @x devolverá el valor 4.
    -- Para el caso (b): la última sentencia SELECT @x devolverá el valor 30.


# 14. Dado el siguiente procedimiento:
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

-- En el primer caso (a), el valor de 'a' es -10, por lo que el bucle 'while' no se ejecutará en absoluto. El valor de 'b' sigue siendo 0 y no se realiza ninguna inserción en la tabla 't'. El procedimiento devuelve 0 como valor de salida y la sentencia SELECT @value devolverá el valor 0.

-- En el segundo caso (b), el valor de 'a' es 10, por lo que el bucle 'while' se ejecutará 10 veces. En cada iteración del bucle, se incrementará el valor de 'b' en 1 y se insertará en la tabla 't' si no es igual a 2. Por lo tanto, los valores insertados en la tabla 't' serán 1, 3, 4, 5, 6, 7, 8, 9 y 10. El procedimiento devuelve el valor 9 como valor de salida, que es el último valor que se inserta en la tabla 't' antes de que se termine el bucle. La sentencia SELECT @value devolverá el valor 9.

-- Por lo tanto, las respuestas serían:

    -- Para el caso (a): la tabla 't' no tendrá ningún valor y la sentencia SELECT @value devolverá el valor 0.
    -- Para el caso (b): la tabla 't' tendrá los valores 1, 3, 4, 5, 6, 7, 8, 9 y 10 y la sentencia SELECT @value devolverá el valor 9.

# 15. Escriba un procedimiento llamado obtener_numero_empleados que reciba como parámetro de entrada el código de una oficina y devuelva el número de empleados que tiene.
# Escriba una sentencia SQL que realice una llamada al procedimiento realizado para comprobar que se ejecuta correctamente.

DELIMITER $$
DROP PROCEDURE IF EXISTS obtener_numero_empleados $$
CREATE PROCEDURE obtener_numero_empleados(IN codigo_oficina VARCHAR(10), OUT total_empleados INT)
    BEGIN
        SELECT COUNT(e.codigo_empleado) INTO total_empleados
        FROM empleado e
        WHERE e.codigo_oficina = codigo_oficina;
    END $$
DELIMITER ;
CALL obtener_numero_empleados('TAL-ES', @total);
SELECT @total;


# 16. Escriba una función llamada cantidad_total_de_productos_vendidos que reciba como parámetro de entrada el código de un producto y devuelva la cantidad total de productos que se han vendido con ese código.
# Escriba una sentencia SQL que realice una llamada a la función realizada para comprobar que se ejecuta correctamente.

DELIMITER $$
DROP FUNCTION IF EXISTS cantidad_total_de_productos_vendidos $$
CREATE FUNCTION cantidad_total_de_productos_vendidos(codigo_producto VARCHAR(10))
    RETURNS INT READS SQL DATA
    BEGIN
        DECLARE total INT;
        SELECT SUM(dp.cantidad) INTO total
        FROM detalle_pedido dp
        WHERE dp.codigo_producto = codigo_producto;
        RETURN total;
    END $$
DELIMITER ;
SELECT cantidad_total_de_productos_vendidos('FR-67');


# 17. Crea una tabla que se llame productos_vendidos que tenga las siguientes columnas:
# id (entero sin signo, auto incremento y clave primaria)
# codigo_producto (cadena de caracteres)
# cantidad_total (entero)

USE jardineria;
DROP TABLE IF EXISTS productos_vendidos;
CREATE TABLE IF NOT EXISTS productos_vendidos(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                                codigo_producto VARCHAR(10),
                                cantidad_total INTEGER);



# Escriba un procedimiento llamado estadísticas_productos_vendidos que para cada uno de los productos de la tabla producto calcule la cantidad total de unidades que se han vendido y almacene esta información en la tabla productos_vendidos.
#
# El procedimiento tendrá que realizar las siguientes acciones:
#
# Borrar el contenido de la tabla productos_vendidos.
# Recorrer cada uno de los productos de la tabla producto. Será necesario usar un cursor.
# Calcular la cantidad total de productos vendidos. En este paso será necesario utilizar la función cantidad_total_de_productos_vendidos desarrollada en el ejercicio 2.
# Insertar en la tabla productos_vendidos los valores del código de producto y la cantidad total de unidades que se han vendido para ese producto en concreto.

DELIMITER $$
DROP PROCEDURE IF EXISTS estadísticas_productos_vendidos $$
CREATE PROCEDURE estadísticas_productos_vendidos()
    BEGIN
        DECLARE done INT DEFAULT 0;
        DECLARE id_pro VARCHAR(10);
        DECLARE productos CURSOR FOR SELECT p.codigo_producto
                                    FROM producto p;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
        DELETE FROM productos_vendidos;
        OPEN productos;
        bucle: LOOP
            FETCH productos INTO id_pro;
            IF done = 1 THEN
                LEAVE bucle;
            END IF;
            INSERT INTO productos_vendidos(codigo_producto, cantidad_total)
                VALUES(id_pro, cantidad_total_de_productos_vendidos(id_pro));
        END LOOP;
        CLOSE productos;
    END $$
DELIMITER ;
CALL estadísticas_productos_vendidos();


# 18. Crea una tabla que se llame notificaciones que tenga las siguientes columnas:
# id (entero sin signo, autoincremento y clave primaria)
# fecha_hora: marca de tiempo con el instante del pago (fecha y hora)
# total: el valor del pago (real)
# codigo_cliente: código del cliente que realiza el pago (entero)

USE jardineria;
DROP TABLE IF EXISTS notificaciones;
CREATE TABLE IF NOT EXISTS notificaciones(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                                        fecha_hora DATETIME,
                                        total FLOAT,
                                        codigo_cliente INTEGER);

# Escriba un trigger que nos permita llevar un control de los pagos que van realizando los clientes. Los detalles de implementación son los siguientes:
#
# Nombre: trigger_notificar_pago
# Se ejecuta sobre la tabla pago.
# Se ejecuta después de hacer la inserción de un pago.
# Cada vez que un cliente realice un pago (es decir, se hace una inserción en la tabla pago), el trigger deberá insertar un nuevo registro en una tabla llamada notificaciones.
# Escriba algunas sentencias SQL para comprobar que el trigger funciona correctamente.

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_notificar_pago $$
CREATE TRIGGER trigger_notificar_pago
    AFTER INSERT
    ON pago FOR EACH ROW
    BEGIN
        INSERT INTO notificaciones(fecha_hora,
                                   total,
                                   codigo_cliente)
            VALUES (NOW(),
                    NEW.total,
                    NEW.codigo_cliente);
    END $$
DELIMITER ;

INSERT INTO pago(codigo_cliente,
                 forma_pago,
                 id_transaccion,
                 fecha_pago,
                 total)
VALUES (1, 'manual', 'ak-std-000039',NOW(), 1234.54);
INSERT INTO pago(codigo_cliente,
                 forma_pago,
                 id_transaccion,
                 fecha_pago,
                 total)
VALUES (1, 'manual', 'ak-std-000036',NOW(), 2345.77);
INSERT INTO pago(codigo_cliente,
                 forma_pago,
                 id_transaccion,
                 fecha_pago,
                 total)
VALUES (3, 'manual', 'ak-std-000037',NOW(), 12.45);