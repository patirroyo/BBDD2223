# 1.8.1 Procedimientos sin sentencias SQL

# 1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto ¡Hola mundo!.

DELIMITER $$
DROP PROCEDURE IF EXISTS hello_world $$

CREATE PROCEDURE hello_world()
BEGIN
    SELECT '¡Hola mundo!';
END $$

DELIMITER ;
CALL hello_world();

# 2. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo, negativo o cero.

DELIMITER $$
DROP PROCEDURE IF EXISTS signo_numero $$

CREATE PROCEDURE signo_numero(IN numero INT)

    CASE
        WHEN numero > 0 THEN SELECT 'El número es positivo';
        WHEN numero < 0 THEN SELECT 'El número es negativo';
        ELSE SELECT 'El número es cero';
    END CASE $$

DELIMITER ;
CALL signo_numero(0);

# 3. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor un número real, y un parámetro de salida, con una cadena de caracteres indicando si el número es positivo, negativo o cero.

DELIMITER $$
DROP PROCEDURE IF EXISTS signo_numero $$

CREATE PROCEDURE signo_numero(IN numero INT, OUT salida VARCHAR(30))

    CASE
        WHEN numero > 0 THEN SET salida = 'El número es positivo';
        WHEN numero < 0 THEN SET salida = 'El número es negativo';
        ELSE SET salida = 'El número es cero';
    END CASE $$

DELIMITER ;
CALL signo_numero(2, @resultado);
SELECT @resultado;

# 4. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones:
# [0,5) = Insuficiente
# [5,6) = Aprobado
# [6, 7) = Bien
# [7, 9) = Notable
# [9, 10] = Sobresaliente
# En cualquier otro caso la nota no será válida.

DELIMITER $$
DROP PROCEDURE IF EXISTS calificaciones $$

CREATE PROCEDURE calificaciones(IN numero REAL)
    CASE
        WHEN numero >= 0 AND numero < 5 THEN SELECT 'Insuficiente';
        WHEN numero >= 5 AND numero < 6 THEN SELECT 'Aprobado';
        WHEN numero >= 6 AND numero < 7 THEN SELECT 'Bien';
        WHEN numero >= 7 AND numero < 9 THEN SELECT 'Notable';
        WHEN numero >= 9 AND numero <= 10 THEN SELECT 'Sobresaliente';
        ELSE SELECT 'Nota no valida';
    END CASE
$$

DELIMITER ;
CALL calificaciones(10);

# 5. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor de la nota en formato numérico y un parámetro de salida, con una cadena de texto indicando la nota correspondiente.

DELIMITER $$
DROP PROCEDURE IF EXISTS calificaciones $$

CREATE PROCEDURE calificaciones(IN numero REAL, OUT calificacion VARCHAR(20))
    IF numero >= 0 AND numero < 5 THEN SET calificacion = 'Insuficiente';
        ELSE IF numero >= 5 AND numero < 6 THEN SET calificacion = 'Aprobado';
            ELSE IF numero >= 6 AND numero < 7 THEN SET calificacion = 'Bien';
                ELSE IF numero >= 7 AND numero < 9 THEN SET calificacion = 'Notable';
                    ELSE IF numero >= 9 AND numero <= 10 THEN SET calificacion = 'Sobresaliente';
                        ELSE SELECT 'Nota no valida';
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF
$$

DELIMITER ;
CALL calificaciones(8, @nota);
SELECT @nota;

# 6. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.

DELIMITER $$
DROP PROCEDURE IF EXISTS calificaciones $$

CREATE PROCEDURE calificaciones(IN numero REAL, OUT calificacion VARCHAR(20))
    CASE
        WHEN numero >= 0 AND numero < 5 THEN SET calificacion = 'Insuficiente';
        WHEN numero >= 5 AND numero < 6 THEN SET calificacion = 'Aprobado';
        WHEN numero >= 6 AND numero < 7 THEN SET calificacion = 'Bien';
        WHEN numero >= 7 AND numero < 9 THEN SET calificacion = 'Notable';
        WHEN numero >= 9 AND numero <= 10 THEN SET calificacion = 'Sobresaliente';
        ELSE SELECT 'Nota no valida';
    END CASE
$$

DELIMITER ;
CALL calificaciones(5.4, @nota);
SELECT @nota;


# 7. Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.

DELIMITER $$
DROP PROCEDURE IF EXISTS diasDeLaSemana $$

CREATE PROCEDURE diasDeLaSemana(IN dia INT)
    CASE
        WHEN dia = 1 THEN SELECT 'Lunes';
        WHEN dia = 2 THEN SELECT 'Martes';
        WHEN dia = 3 THEN SELECT 'Miércoles';
        WHEN dia = 4 THEN SELECT 'Jueves';
        WHEN dia = 5 THEN SELECT 'Viernes';
        WHEN dia = 6 THEN SELECT 'Sábado';
        WHEN dia = 7 THEN SELECT 'Domingo';
        ELSE SELECT 'día no valido';
    END CASE
$$

DELIMITER ;
CALL diasDeLaSemana(6);

# 1.8.2 Procedimientos con sentencias SQL

# 1. Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice una consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de ese país.

DELIMITER $$
DROP PROCEDURE IF EXISTS clientesPorPais $$

CREATE PROCEDURE clientesPorPais(IN pais VARCHAR(20))
    BEGIN
        SELECT c.*
        FROM cliente c
        WHERE c.pais = pais;
    END
$$

DELIMITER ;
CALL clientesPorPais('Spain');


# 2. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de máximo valor realizado para esa forma de pago. Deberá hacer uso de la tabla pago de la base de datos jardineria.

DELIMITER $$
DROP PROCEDURE IF EXISTS pagoMax $$

CREATE PROCEDURE pagoMax(IN metodo VARCHAR(20))
    BEGIN
        SELECT p.id_transaccion,
                p.forma_pago,
                p.total
        FROM pago p
        WHERE p.forma_pago = metodo
        ORDER BY p.total DESC
        LIMIT 1;
    END $$
DELIMITER ;
CALL pagoMax('Transferencia');



# 3. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los siguientes valores teniendo en cuenta la forma de pago seleccionada como parámetro de entrada:
# el pago de máximo valor,
DELIMITER $$
DROP PROCEDURE IF EXISTS pagoMax $$

CREATE PROCEDURE pagoMax(IN metodoPago VARCHAR(20))
    BEGIN
        SELECT p.id_transaccion,
                p.forma_pago,
                p.total
        FROM pago p
        WHERE p.forma_pago = metodoPago
        ORDER BY p.total DESC
        LIMIT 1;
    END $$
DELIMITER ;
CALL pagoMax('PayPal');

# el pago de mínimo valor,
DELIMITER $$
DROP PROCEDURE IF EXISTS pagoMin $$

CREATE PROCEDURE pagoMin(IN metodoPago VARCHAR(20))
    BEGIN
        SELECT p.id_transaccion,
                p.forma_pago,
                p.total
        FROM pago p
        WHERE p.forma_pago = metodoPago
        ORDER BY p.total ASC
        LIMIT 1;
    END $$
DELIMITER ;
CALL pagoMin('PayPal');

# el valor medio de los pagos realizados,

DELIMITER $$
DROP PROCEDURE IF EXISTS pagoAVG $$

CREATE PROCEDURE pagoAVG(IN metodoPago VARCHAR(20))
    BEGIN
        SELECT  p.forma_pago,
                AVG(p.total)
        FROM pago p
        WHERE p.forma_pago = metodoPago
        GROUP BY p.forma_pago;
    END $$
DELIMITER ;
CALL pagoAVG('Cheque');

# la suma de todos los pagos,
DELIMITER $$
DROP PROCEDURE IF EXISTS pagoTotal $$

CREATE PROCEDURE pagoTotal(IN metodoPago VARCHAR(20))
    BEGIN
        SELECT  p.forma_pago,
                SUM(p.total)
        FROM pago p
        WHERE p.forma_pago = metodoPago
        GROUP BY p.forma_pago;
    END $$
DELIMITER ;
CALL pagoTotal('PayPal');

# el número de pagos realizados para esa forma de pago.
DELIMITER $$
DROP PROCEDURE IF EXISTS numPagos $$

CREATE PROCEDURE numPagos(IN metodoPago VARCHAR(20))
    BEGIN
        SELECT  p.forma_pago,
                COUNT(p.total)
        FROM pago p
        WHERE p.forma_pago = metodoPago
        GROUP BY p.forma_pago;
    END $$
DELIMITER ;
CALL numPagos('PayPal');

# Deberá hacer uso de la tabla pago de la base de datos jardineria.


# 4. Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados. La tabla cuadrados debe tener dos columnas de tipo INT UNSIGNED, una columna llamada número y otra columna llamada cuadrado.

CREATE DATABASE IF NOT EXISTS procedimientos;
USE procedimientos;
DROP TABLE IF EXISTS cuadrados;
CREATE TABLE IF NOT EXISTS cuadrados(
    numero INT UNSIGNED,
    cuadrado INT UNSIGNED
);


# Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados con las siguientes características. El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y calculará el valor de los cuadrados de los primeros números naturales hasta el valor introducido como parámetro. El valor del números y de sus cuadrados deberán ser almacenados en la tabla cuadrados que hemos creado previamente.

# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores de los cuadrados que va a calcular.

# Utilice un bucle WHILE para resolver el procedimiento.
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_cuadrados $$

CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
    BEGIN
        DECLARE contador INT;
        SET contador = 0;
        DELETE FROM cuadrados;
        WHILE contador <= tope DO
            INSERT INTO cuadrados VALUES (contador, contador*contador);
            SET contador = contador + 1;
        END WHILE;
    END $$
DELIMITER ;
CALL calcular_cuadrados(5);


# 5. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_cuadrados $$

CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
    BEGIN
        DECLARE contador INT;
        SET contador = 0;
        DELETE FROM cuadrados;
        REPEAT
            INSERT INTO cuadrados VALUES (contador, contador*contador);
            SET contador = contador + 1;
        UNTIL contador > tope
        END REPEAT ;
    END $$
DELIMITER ;
CALL calcular_cuadrados(5);

# 6. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_cuadrados $$

CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
    BEGIN
        DECLARE contador INT;
        SET contador = 0;
        DELETE FROM cuadrados;
        bucle: LOOP
            IF contador > tope THEN
                LEAVE bucle;
            END IF;
            INSERT INTO cuadrados VALUES (contador, contador*contador);
            SET contador = contador + 1;
        END LOOP ;
    END $$
DELIMITER ;
CALL calcular_cuadrados(5);


# 7. Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio. La tabla debe tener una única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.


CREATE DATABASE IF NOT EXISTS procedimientos;
USE procedimientos;
DROP TABLE IF EXISTS ejercicios;
CREATE TABLE IF NOT EXISTS ejercicios(
    numero INT UNSIGNED);

# Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_números con las siguientes características. El procedimiento recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED y deberá almacenar en la tabla ejercicio toda la secuencia de números desde el valor inicial pasado como entrada hasta el 1.

# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.


# Utilice un bucle WHILE para resolver el procedimiento.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros $$

CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
    BEGIN
        DELETE FROM ejercicios;
        WHILE valor_inicial > 0 DO
            INSERT INTO ejercicios VALUES (valor_inicial);
            SET valor_inicial = valor_inicial - 1;
        END WHILE;
    END $$
DELIMITER ;
CALL calcular_numeros(50);


# 8. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros $$

CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
    BEGIN
        DELETE FROM ejercicios;
        REPEAT
            INSERT INTO ejercicios VALUES (valor_inicial);
            SET valor_inicial = valor_inicial - 1;
        UNTIL valor_inicial < 1
        END REPEAT;
    END $$
DELIMITER ;
CALL calcular_numeros(40);

# 9. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros $$

CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
    BEGIN
        DELETE FROM ejercicios;
        bucle: LOOP
            IF valor_inicial < 1 THEN
                LEAVE bucle;
            END IF;
            INSERT INTO ejercicios VALUES (valor_inicial);
            SET valor_inicial = valor_inicial - 1;
        END LOOP ;
    END $$
DELIMITER ;
CALL calcular_numeros(30);

# 10. Crea una base de datos llamada procedimientos que contenga una tabla llamada pares y otra tabla llamada impares. Las dos tablas deben tener única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.

CREATE DATABASE IF NOT EXISTS procedimientos;
USE procedimientos;
DROP TABLE IF EXISTS pares;
DROP TABLE IF EXISTS impares;
CREATE TABLE IF NOT EXISTS pares(
    numero INT UNSIGNED);
CREATE TABLE IF NOT EXISTS impares(
    numero INT UNSIGNED);


# Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado calcular_pares_impares con las siguientes características. El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y deberá almacenar en la tabla pares aquellos números pares que existan entre el número 1 el valor introducido como parámetro. Habrá que realizar la misma operación para almacenar los números impares en la tabla impares.

# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.

# Utilice un bucle WHILE para resolver el procedimiento.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares $$

CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
    BEGIN
        DECLARE contador INT UNSIGNED;
        SET contador = 1;
        DELETE FROM pares;
        DELETE FROM impares;
        WHILE contador <= tope DO
            IF contador%2 = 0 THEN
                INSERT INTO pares VALUES (contador);
            ELSE
                INSERT INTO impares VALUES (contador);
            END IF;
            SET contador = contador + 1;
        END WHILE;
    END $$
DELIMITER ;
CALL calcular_pares_impares(50);

# 11. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares $$

CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
    BEGIN
        DECLARE contador INT UNSIGNED;
        SET contador = 1;
        DELETE FROM pares;
        DELETE FROM impares;
        REPEAT
            IF contador%2 = 0 THEN
                INSERT INTO pares VALUES (contador);
            ELSE
                INSERT INTO impares VALUES (contador);
            END IF;
            SET contador = contador + 1;
        UNTIL contador > tope
        END REPEAT;
    END $$
DELIMITER ;
CALL calcular_pares_impares(40);

# 12. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares $$

CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
    BEGIN
        DECLARE contador INT UNSIGNED;
        SET contador = 1;
        DELETE FROM pares;
        DELETE FROM impares;
        bucle: LOOP
            IF contador > tope THEN
                LEAVE bucle;
            END IF;
            IF contador%2 = 0 THEN
                INSERT INTO pares VALUES (contador);
            ELSE
                INSERT INTO impares VALUES (contador);
            END IF;
            SET contador = contador + 1;
        END LOOP;
    END $$
DELIMITER ;
CALL calcular_pares_impares(43);


# 1.8.3 Funciones sin sentencias SQL

# 1. Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número es par o FALSE en caso contrario.

DELIMITER $$
DROP FUNCTION IF EXISTS es_numero_par $$
CREATE FUNCTION es_numero_par(numero INT UNSIGNED)
    RETURNS BOOLEAN NO SQL
    BEGIN
        IF numero%2 = 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END $$
DELIMITER ;
SELECT IF (es_numero_par(1), 'TRUE', 'FALSE') AS 'Is this number even?';

# 2. Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.

DELIMITER $$
DROP FUNCTION IF EXISTS hipotenusa $$
CREATE FUNCTION hipotenusa(cateto1 INT UNSIGNED, cateto2 INT UNSIGNED)
    RETURNS VARCHAR(40) NO SQL
    BEGIN
        IF (cateto1 > 0 && cateto2 > 0) THEN
            RETURN SQRT(cateto1*cateto1 + cateto2*cateto2);
        ELSE
            RETURN 'Cada cateto tiene que ser mayor de 0';
        END IF;
    END $$
DELIMITER ;
SELECT hipotenusa(4, 3);

# 3. Escribe una función que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.

DELIMITER $$
DROP FUNCTION IF EXISTS dia_de_la_semana $$
CREATE FUNCTION dia_de_la_semana(dia INT UNSIGNED)
    RETURNS VARCHAR(20) NO SQL
    BEGIN
        CASE
            WHEN dia = 1 THEN RETURN 'Lunes';
            WHEN dia = 2 THEN RETURN 'Martes';
            WHEN dia = 3 THEN RETURN 'Miércoles';
            WHEN dia = 4 THEN RETURN 'Jueves';
            WHEN dia = 5 THEN RETURN 'Viernes';
            WHEN dia = 6 THEN RETURN 'Sábado';
            WHEN dia = 7 THEN RETURN 'Domingo';
            ELSE RETURN 'día no valido';
        END CASE;
    END $$
DELIMITER ;
SELECT dia_de_la_semana(7);

# 4. Escribe una función que reciba tres números reales como parámetros de entrada y devuelva el mayor de los tres.
DELIMITER $$
DROP FUNCTION IF EXISTS el_mayor_de_tres $$
CREATE FUNCTION el_mayor_de_tres(numero1 INT UNSIGNED, numero2 INT UNSIGNED, numero3 INT UNSIGNED)
    RETURNS INT UNSIGNED NO SQL
    BEGIN
        DECLARE mayor INT UNSIGNED;
        IF (numero1 > numero2) THEN
            SET mayor = numero1;
        ELSE
            SET mayor = numero2;
        END IF;
        IF (numero3 > mayor) THEN
            SET mayor = numero3;
        END IF;
        RETURN mayor;
END $$
DELIMITER ;
SELECT el_mayor_de_tres(30,20,10);

# 5. Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio que se recibirá como parámetro de entrada.

DELIMITER $$
DROP FUNCTION IF EXISTS area_circulo $$
CREATE FUNCTION area_circulo(radio INT UNSIGNED)
    RETURNS VARCHAR(40) NO SQL
    BEGIN
        IF (radio > 0) THEN
            RETURN PI()*POW(radio, 2);
        ELSE
            RETURN 'El radio tiene que ser mayor de 0';
        END IF;
    END $$
DELIMITER ;
SELECT area_circulo(9 );


# 6. Escribe una función que devuelva como salida el número de años que han transcurrido entre dos fechas que se reciben como parámetros de entrada. Por ejemplo, si pasamos como parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.
# Para realizar esta función puede hacer uso de las siguientes funciones que nos proporciona MySQL:

# DATEDIFF
# TRUNCATE

DELIMITER $$
DROP FUNCTION IF EXISTS años_transcurridos $$
CREATE FUNCTION años_transcurridos(fecha1 DATETIME, fecha2 DATETIME)
    RETURNS VARCHAR(40) NO SQL
    BEGIN
        IF (fecha1 > fecha2) THEN
            RETURN CONCAT('Han pasado ', TIMESTAMPDIFF(YEAR , fecha2, fecha1), ' años');
        ELSE
            RETURN CONCAT('Han pasado ', TIMESTAMPDIFF(YEAR , fecha1, fecha2), ' años');
        END IF;
    END $$
DELIMITER ;
SELECT años_transcurridos('1988-05-04', NOW() );

# 7. Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento. Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe devolver la cadena Maria.

DELIMITER $$
DROP FUNCTION IF EXISTS desacentuar $$
CREATE FUNCTION desacentuar(cadena VARCHAR(100))
    RETURNS VARCHAR(100) NO SQL
    BEGIN
        SET cadena = REPLACE(cadena, 'á', 'a');
        SET cadena = REPLACE(cadena, 'é', 'e');
        SET cadena = REPLACE(cadena, 'í', 'i');
        SET cadena = REPLACE(cadena, 'ó', 'o');
        SET cadena = REPLACE(cadena, 'ú', 'u');
        SET cadena = REPLACE(cadena, 'Á', 'A');
        SET cadena = REPLACE(cadena, 'É', 'E');
        SET cadena = REPLACE(cadena, 'Í', 'I');
        SET cadena = REPLACE(cadena, 'Ó', 'O');
        SET cadena = REPLACE(cadena, 'Ú', 'U');
        RETURN cadena;
    END $$
DELIMITER ;
SELECT desacentuar('ÁÉÍÓÚ áéíóú ¿desacentuará o no desacentuará?');


# 1.8.4 Funciones con sentencias SQL

# 1. Escribe una función para la base de datos tienda que devuelva el número total de productos que hay en la tabla productos.

USE tienda;
DELIMITER $$
DROP FUNCTION IF EXISTS total_productos $$
CREATE FUNCTION total_productos()
    RETURNS INT UNSIGNED DETERMINISTIC
    BEGIN
        DECLARE total INT UNSIGNED;
        SELECT COUNT(*) INTO total FROM producto;
        RETURN total;
    END $$
DELIMITER ;
SELECT total_productos();

# 2. Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.

DELIMITER $$
DROP FUNCTION IF EXISTS valor_medio_productos_por_fabricante $$
CREATE FUNCTION valor_medio_productos_por_fabricante(fabricante VARCHAR(20))
    RETURNS INT UNSIGNED DETERMINISTIC
    BEGIN
        DECLARE valorMedio INT UNSIGNED;
        SELECT AVG(p.precio) INTO valorMedio
        FROM producto p
        INNER JOIN fabricante f
            ON p.id_fabricante = f.id
        WHERE f.nombre = fabricante;
        RETURN valorMedio;
    END $$
DELIMITER ;
SELECT valor_medio_productos_por_fabricante('Lenovo');

# 3. Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.
DELIMITER $$
DROP FUNCTION IF EXISTS producto_mayor_valor_fabricante $$
CREATE FUNCTION producto_mayor_valor_fabricante(fabricante VARCHAR(20))
    RETURNS INT UNSIGNED DETERMINISTIC
    BEGIN
        DECLARE valorMax INT UNSIGNED;
        SELECT MAX(p.precio) INTO valorMax
        FROM producto p
        INNER JOIN fabricante f
            ON p.id_fabricante = f.id
        WHERE f.nombre = fabricante;
        RETURN valorMax;
    END $$
DELIMITER ;
SELECT producto_mayor_valor_fabricante('Asus');

# Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.
DELIMITER $$
DROP FUNCTION IF EXISTS producto_menor_valor_fabricante $$
CREATE FUNCTION producto_menor_valor_fabricante(fabricante VARCHAR(20))
    RETURNS INT UNSIGNED DETERMINISTIC
    BEGIN
        DECLARE valorMin INT UNSIGNED;
        SELECT MIN(p.precio) INTO valorMin
        FROM producto p
        INNER JOIN fabricante f
            ON p.id_fabricante = f.id
        WHERE f.nombre = fabricante;
        RETURN valorMin;
    END $$
DELIMITER ;
SELECT producto_menor_valor_fabricante('Asus');


# 1.8.5 Manejo de errores en MySQL

# Crea una base de datos llamada test que contenga una tabla llamada alumno. La tabla debe tener cuatro columnas:
# id: entero sin signo (clave primaria).
# nombre: cadena de 50 caracteres.
# apellido1: cadena de 50 caracteres.
# apellido2: cadena de 50 caracteres.

CREATE DATABASE IF NOT EXISTS test;
USE test;
DROP TABLE IF EXISTS alumno;
CREATE TABLE IF NOT EXISTS alumno(
    id INT UNSIGNED,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    PRIMARY KEY (id)
);
# Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado insertar_alumno con las siguientes características. El procedimiento recibe cuatro parámetros de entrada (id, nombre, apellido1, apellido2) y los insertará en la tabla alumno. El procedimiento devolverá como salida un parámetro llamado error que tendrá un valor igual a 0 si la operación se ha podido realizar con éxito y un valor igual a 1 en caso contrario.
#
# Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una fila que contiene una clave primaria repetida.

DELIMITER $$
DROP PROCEDURE IF EXISTS insertar_alumno $$
CREATE PROCEDURE insertar_alumno(IN id INT UNSIGNED, nomb VARCHAR(50), apellido1 VARCHAR(50), apellido2 VARCHAR(50), OUT error INT)
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET error = 1;
        SET error = 0;
        INSERT INTO test.alumno
            VALUES (id, nomb, apellido1, apellido2);
        SELECT error;
    END $$
DELIMITER ;
CALL insertar_alumno(1, 'Alberto', 'Saz', 'Simón', @error);



# 1.8.6 Transacciones con procedimientos almacenados

# Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
# Tabla cuentas:

# id_cuenta: entero sin signo (clave primaria).
# saldo: real sin signo.
# Tabla entradas:

# id_butaca: entero sin signo (clave primaria).
# nif: cadena de 9 caracteres.

CREATE DATABASE IF NOT EXISTS cine;
USE cine;
DROP TABLE IF EXISTS cuentas;
CREATE TABLE IF NOT EXISTS cuentas(
    id_cuenta INT UNSIGNED PRIMARY KEY ,
    saldo INT UNSIGNED
);
DROP TABLE IF EXISTS entradas;
CREATE TABLE IF NOT EXISTS entradas(
    id_butaca INT UNSIGNED PRIMARY KEY ,
    nif VARCHAR(9)
);

# Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado comprar_entrada con las siguientes características. El procedimiento recibe 3 parámetros de entrada (nif, id_cuenta, id_butaca) y devolverá como salida un parámetro llamado error que tendrá un valor igual a 0 si la compra de la entrada se ha podido realizar con éxito y un valor igual a 1 en caso contrario.


# El procedimiento de compra realiza los siguientes pasos:
#
# Inicia una transacción.
# Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta adecuado.
# Inserta una una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar el usuario (nif).
# Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún error entonces aplica un COMMIT a la transacción y si ha ocurrido algún error aplica un ROLLBACK.
# Deberá manejar los siguientes errores que puedan ocurrir durante el proceso.
#
# ERROR 1264 (Out of range value)
# ERROR 1062 (Duplicate entry for PRIMARY KEY)

DELIMITER $$
DROP PROCEDURE IF EXISTS comprar_entrada $$
CREATE PROCEDURE comprar_entrada(IN nif VARCHAR(9), IN id_cuenta INT UNSIGNED, IN id_butaca INT UNSIGNED, OUT error INT UNSIGNED)
    BEGIN
        DECLARE EXIT HANDLER FOR 1264
            BEGIN
                SET error = 1;
                SELECT error, 'Out of range value' as 'ERROR TYPE';
            ROLLBACK;
        END;
        DECLARE EXIT HANDLER FOR 1062
            BEGIN
                SET error = 1;
                SELECT error, 'Duplicate entry for PRIMARY KEY' as 'ERROR TYPE';
            ROLLBACK;
        END;
        SET error = 0;
        START TRANSACTION;
            UPDATE cuentas SET saldo = saldo - 5 WHERE cuentas.id_cuenta = id_cuenta;
            INSERT INTO entradas VALUES (id_butaca, nif);
            SELECT error;
        COMMIT;
    END $$
DELIMITER ;
CALL comprar_entrada('18447807J', 5, 8, @error);


# ¿Qué ocurre cuando intentamos comprar una entrada y le pasamos como parámetro un número de cuenta que no existe en la tabla cuentas? ¿Ocurre algún error o podemos comprar la entrada?

-- No devuelve error  y se produce la transacción, por lo que si podemos comprar la entrada.

# En caso de que exista algún error, ¿cómo podríamos resolverlo?.

-- Deberiamos crear una condición para evitarlo:

DELIMITER $$
DROP PROCEDURE IF EXISTS comprar_entrada $$
CREATE PROCEDURE comprar_entrada(IN nif VARCHAR(9), IN id_cuenta INT UNSIGNED, IN id_butaca INT UNSIGNED, OUT error INT UNSIGNED)
    BEGIN
        DECLARE EXIT HANDLER FOR 1264
            BEGIN
                SET error = 1;
                SELECT error, 'Out of range value' as 'ERROR TYPE';
            ROLLBACK;
        END;
        DECLARE EXIT HANDLER FOR 1062
            BEGIN
                SET error = 1;
                SELECT error, 'Duplicate entry for PRIMARY KEY' as 'ERROR TYPE';
            ROLLBACK;
        END;
        SET error = 0;
        START TRANSACTION;
            IF ((SELECT COUNT(cuentas.id_cuenta)
               FROM cuentas
               WHERE cuentas.id_cuenta = id_cuenta) = 0) THEN
                   SELECT 'Cuenta no encontrada';
                   ROLLBACK;
            ELSE
                UPDATE cuentas SET saldo = saldo - 5 WHERE cuentas.id_cuenta = id_cuenta;
                INSERT INTO entradas VALUES (id_butaca, nif);
                SELECT error;
            END IF;
        COMMIT;
    END $$
DELIMITER ;
CALL comprar_entrada('18447807J', 1, 85, @error);

#
# 1.8.7 Cursores
#
# Escribe las sentencias SQL necesarias para crear una base de datos llamada test, una tabla llamada alumnos y 4 sentencias de inserción para inicializar la tabla. La tabla alumnos está formada por las siguientes columnas:

    # id (entero sin signo y clave primaria)
    # nombre (cadena de caracteres)
    # apellido1 (cadena de caracteres)
    # apellido2 (cadena de caracteres
    # fecha_nacimiento (fecha)

CREATE DATABASE IF NOT EXISTS test;
USE test;
DROP TABLE IF EXISTS alumno;
CREATE TABLE IF NOT EXISTS alumno(
    id INT UNSIGNED,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    fecha_nacimiento DATETIME,
    PRIMARY KEY (id)
);

# Una vez creada la tabla se decide añadir una nueva columna a la tabla llamada edad que será un valor calculado a partir de la columna fecha_nacimiento. Escriba la sentencia SQL necesaria para modificar la tabla y añadir la nueva columna.
ALTER TABLE alumno ADD COLUMN edad int;

# Escriba una función llamada calcular_edad que reciba una fecha y devuelva el número de años que han pasado desde la fecha actual hasta la fecha pasada como parámetro:
#
# Función: calcular_edad
# Entrada: Fecha
# Salida: Número de años (entero)

DELIMITER $$
DROP FUNCTION IF EXISTS calcular_edad;
CREATE FUNCTION calcular_edad(fnac DATETIME)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE edad INT;
    SET edad = YEAR(NOW())-YEAR(fnac);
    RETURN edad;
END $$

# Ahora escriba un procedimiento que permita calcular la edad de todos los alumnmos que ya existen en la tabla. Para esto será necesario crear un procedimiento llamado actualizar_columna_edad que calcule la edad de cada alumno y actualice la tabla. Este procedimiento hará uso de la función calcular_edad que hemos creado en el paso anterior.

DROP PROCEDURE IF EXISTS actualizar_columna_edad;
CREATE PROCEDURE actualizar_columna_edad()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE id_a INT;
    DECLARE edad INT;
    DECLARE fnac DATETIME;
    DECLARE cur1 CURSOR FOR SELECT id, fecha_nacimiento FROM alumno;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur1;
    bucle: LOOP
        FETCH cur1
        INTO id_a,
            fnac;
        SET edad = 0;
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        START TRANSACTION;
            UPDATE alumno
            SET edad = calcular_edad(fnac)
            WHERE id = id_a;
        COMMIT;
    END LOOP bucle;
    CLOSE cur1;
END $$
DELIMITER ;
CALL actualizar_columna_edad();

# Modifica la tabla alumnos del ejercicio anterior para añadir una nueva columna email. Una vez que hemos modificado la tabla necesitamos asignarle una dirección de correo electrónico de forma automática.

ALTER TABLE alumno ADD COLUMN email VARCHAR(40);

# Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.
#
# Procedimiento: crear_email
# Entrada:
# nombre (cadena de caracteres)
# apellido1 (cadena de caracteres)
# apellido2 (cadena de caracteres)
# dominio (cadena de caracteres)
# Salida:
# email (cadena de caracteres)
# devuelva una dirección de correo electrónico con el siguiente formato:
#
# El primer carácter del parámetro nombre.
# Los tres primeros caracteres del parámetro apellido1.
# Los tres primeros caracteres del parámetro apellido2.
# El carácter @.
# El dominio pasado como parámetro.

DELIMITER $$
DROP PROCEDURE IF EXISTS crear_email $$
CREATE PROCEDURE crear_email(IN nombre VARCHAR(30), IN apellido1 VARCHAR(30), IN apellido2 VARCHAR(30), IN dominio VARCHAR(30), OUT direccion VARCHAR(30))
    BEGIN
        SET direccion = CONCAT(
                                LOWER(LEFT(nombre,1)),
                                LOWER(LEFT(apellido1, 3)),
                                LOWER(LEFT(apellido2,3)),
                                '@',
                                LOWER(dominio));
    END $$
DELIMITER ;
CALL crear_email('Alberto', 'Saz', 'Simón', 'salesianos.edu', @direccion);
SELECT @direccion;


# Ahora escriba un procedimiento que permita crear un email para todos los alumnmos que ya existen en la tabla. Para esto será necesario crear un procedimiento llamado actualizar_columna_email que actualice la columna email de la tabla alumnos. Este procedimiento hará uso del procedimiento crear_email que hemos creado en el paso anterior.

DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_columna_email $$
CREATE PROCEDURE actualizar_columna_email()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE id_a INT;
    DECLARE nomb VARCHAR(30);
    DECLARE ap1 VARCHAR(30);
    DECLARE ap2 VARCHAR(30);
    DECLARE dominio VARCHAR(30) DEFAULT 'salesianos.edu';
    DECLARE mail VARCHAR(30);
    DECLARE cur1 CURSOR FOR
                SELECT id,
                       nombre,
                       apellido1,
                       apellido2
                FROM alumno;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur1;
    bucle: LOOP
        FETCH cur1
        INTO id_a,
            nomb,
            ap1,
            ap2;
        SET mail = '';
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        START TRANSACTION;
            CALL crear_email(nomb, ap1, ap2, dominio, mail);
            UPDATE alumno
            SET email = mail
            WHERE id = id_a;
        COMMIT;
    END LOOP bucle;
    CLOSE cur1;
END $$
DELIMITER ;
CALL actualizar_columna_email();

# Escribe un procedimiento llamado crear_lista_emails_alumnos que devuelva la lista de emails de la tabla alumnos separados por un punto y coma. Ejemplo: juan@iescelia.org;maria@iescelia.org;pepe@iescelia.org;lucia@iescelia.org.

DELIMITER $$
DROP PROCEDURE IF EXISTS crear_lista_emails_alumnos $$
CREATE PROCEDURE crear_lista_emails_alumnos(OUT lista VARCHAR(300))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE mail VARCHAR(30);
    DECLARE cur1 CURSOR FOR
                SELECT email
                FROM alumno;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur1;
    bucle: LOOP
        FETCH cur1
        INTO mail;
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        START TRANSACTION;
            SET lista = CONCAT_WS(';',lista, mail);
        COMMIT;
    END LOOP bucle;
    CLOSE cur1;
END $$
DELIMITER ;
CALL crear_lista_emails_alumnos(@lista);
SELECT @lista;



# 1.8.8 Triggers
#
# Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.
# Tabla alumnos:
#
# id (entero sin signo)
# nombre (cadena de caracteres)
# apellido1 (cadena de caracteres)
# apellido2 (cadena de caracteres)
# nota (número real)

CREATE DATABASE IF NOT EXISTS test;
USE test;
DROP TABLE IF EXISTS alumnos;
CREATE TABLE IF NOT EXISTS alumnos(
    id INT UNSIGNED,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    nota FLOAT,
    PRIMARY KEY (id)
);

# Una vez creada la tabla escriba dos triggers con las siguientes características:
#
# Trigger 1: trigger_check_nota_before_insert
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta antes de una operación de inserción.
# Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
# Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert $$
CREATE TRIGGER trigger_check_nota_before_insert
    BEFORE INSERT
    ON alumnos FOR EACH ROW
    BEGIN
        IF NEW.nota < 0 THEN
            SET NEW.nota = 0;
        ELSEIF NEW.nota > 10 THEN
            SET NEW.nota = 10;
        END IF;
    END $$
DELIMITER ;


# Trigger2 : trigger_check_nota_before_update
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta antes de una operación de actualización.
# Si el nuevo valor de la nota que se quiere actualizar es negativo, se guarda como 0.
# Si el nuevo valor de la nota que se quiere actualizar es mayor que 10, se guarda como 10.

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_update $$
CREATE TRIGGER trigger_check_nota_before_update
    BEFORE UPDATE
    ON alumnos FOR EACH ROW
    BEGIN
        IF NEW.nota < 0 THEN
            SET NEW.nota = 0;
        ELSEIF NEW.nota > 10 THEN
            SET NEW.nota = 10;
        END IF;
    END $$
DELIMITER ;

# Una vez creados los triggers escriba varias sentencias de inserción y actualización sobre la tabla alumnos y verifica que los triggers se están ejecutando correctamente.

INSERT INTO alumnos(id, nota) VALUES (1, 100);
INSERT INTO alumnos(id, nota) VALUES (2, -100);
INSERT INTO alumnos(id, nota) VALUES (3, 5.6);
INSERT INTO alumnos(id, nota) VALUES (4, -0.4);

UPDATE alumnos SET nota = -100 WHERE id = 1;
UPDATE alumnos SET nota = 100 WHERE id = 2;
UPDATE alumnos SET nota = -100 WHERE id = 3;
UPDATE alumnos SET nota = 100 WHERE id = 4;



# Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.
# Tabla alumnos:
#
# id (entero sin signo)
# nombre (cadena de caracteres)
# apellido1 (cadena de caracteres)
# apellido2 (cadena de caracteres)
# email (cadena de caracteres)

CREATE DATABASE IF NOT EXISTS test;
USE test;
DROP TABLE IF EXISTS alumnos;
CREATE TABLE IF NOT EXISTS alumnos(
    id INT UNSIGNED,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    email VARCHAR(30),
    PRIMARY KEY (id)
);


# Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.
#
# Procedimiento: crear_email
# Entrada:
# nombre (cadena de caracteres)
# apellido1 (cadena de caracteres)
# apellido2 (cadena de caracteres)
# dominio (cadena de caracteres)
# Salida:
# email (cadena de caracteres)
# devuelva una dirección de correo electrónico con el siguiente formato:
#
# El primer carácter del parámetro nombre.
# Los tres primeros caracteres del parámetro apellido1.
# Los tres primeros caracteres del parámetro apellido2.
# El carácter @.
# El dominio pasado como parámetro.

DELIMITER $$
DROP PROCEDURE IF EXISTS crear_email $$
CREATE PROCEDURE crear_email(IN nombre VARCHAR(30), IN apellido1 VARCHAR(30), IN apellido2 VARCHAR(30), IN dominio VARCHAR(30), OUT email VARCHAR(30))
    BEGIN
        SET email = CONCAT(
                                LOWER(LEFT(nombre,1)),
                                LOWER(LEFT(apellido1, 3)),
                                LOWER(LEFT(apellido2,3)),
                                '@',
                                LOWER(dominio));
    END $$
DELIMITER ;


# Una vez creada la tabla escriba un trigger con las siguientes características:
#
# Trigger: trigger_crear_email_before_insert
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta antes de una operación de inserción.
# Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de email y se insertará en la tabla.
# Si el nuevo valor del email no es NULL se guardará en la tabla el valor del email.
# Nota: Para crear la nueva dirección de email se deberá hacer uso del procedimiento crear_email.

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_crear_email_before_insert $$
CREATE TRIGGER trigger_crear_email_before_insert
    BEFORE INSERT
    ON alumnos FOR EACH ROW
    BEGIN
        IF NEW.email IS NULL THEN
            CALL crear_email(NEW.nombre, NEW.apellido1, NEW.apellido2, 'salesianos.edu', @mail);
            SET NEW.email = @mail;
        END IF;
    END $$
DELIMITER ;

INSERT INTO alumnos(id, nombre, apellido1, apellido2) VALUES (1, 'Alberto', 'Saz', 'Simón');
INSERT INTO alumnos(id, nombre, apellido1, apellido2) VALUES (2, 'Perico', 'EldeLos', 'Palotes');
INSERT INTO alumnos VALUES (3, 'Manolo', 'Eldel', 'Bombo', 'eldelbombo@bombo.es');

# Modifica el ejercicio anterior y añade un nuevo trigger que las siguientes características:
# Trigger: trigger_guardar_email_after_update:
#
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta después de una operación de actualización.
# Cada vez que un alumno modifique su dirección de email se deberá insertar un nuevo registro en una tabla llamada log_cambios_email.

# La tabla log_cambios_email contiene los siguientes campos:
#
# id: clave primaria (entero autonumérico)
# id_alumno: id del alumno (entero)
# fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
# old_email: valor anterior del email (cadena de caracteres)
# new_email: nuevo valor con el que se ha actualizado

CREATE TABLE IF NOT EXISTS log_cambios_email(
            id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
            id_alumno INT,
            fecha_hora DATETIME,
            old_email VARCHAR(30),
            new_email VARCHAR(30)
        );

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_guardar_email_after_update $$
CREATE TRIGGER trigger_guardar_email_after_update
    AFTER UPDATE
    ON alumnos FOR EACH ROW
    BEGIN
        IF NEW.email != OLD.email THEN
            INSERT INTO log_cambios_email(id_alumno, fecha_hora, old_email, new_email)
            VALUES (OLD.id, NOW(), OLD.email, NEW.email);
        END IF;
    END $$
DELIMITER ;

UPDATE alumnos SET email = 'albertosaz@gmail.com' WHERE id = 1;
UPDATE alumnos SET email = 'periquin@gmail.com' WHERE id = 2;
UPDATE alumnos SET email = '' WHERE id = 3;

# Modifica el ejercicio anterior y añade un nuevo trigger que tenga las siguientes características:
# Trigger: trigger_guardar_alumnos_eliminados:
#
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta después de una operación de borrado.
# Cada vez que se elimine un alumno de la tabla alumnos se deberá insertar un nuevo registro en una tabla llamada log_alumnos_eliminados.
# La tabla log_alumnos_eliminados contiene los siguientes campos:
#
# id: clave primaria (entero autonumérico)
# id_alumno: id del alumno (entero)
# fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
# nombre: nombre del alumno eliminado (cadena de caracteres)
# apellido1: primer apellido del alumno eliminado (cadena de caracteres)
# apellido2: segundo apellido del alumno eliminado (cadena de caracteres)
# email: email del alumno eliminado (cadena de caracteres)

CREATE TABLE IF NOT EXISTS log_alumnos_eliminados(
            id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
            id_alumno INT,
            fecha_hora DATETIME,
            apellido1 VARCHAR(30),
            apellido2 VARCHAR(30),
            email VARCHAR(30)
        );

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_guardar_email_after_update $$
CREATE TRIGGER trigger_guardar_email_after_update
    AFTER UPDATE
    ON alumnos FOR EACH ROW
    BEGIN
        IF NEW.email != OLD.email THEN
            INSERT INTO log_cambios_email(id_alumno, fecha_hora, old_email, new_email)
            VALUES (OLD.id, NOW(), OLD.email, NEW.email);
        END IF;
    END $$
DELIMITER ;