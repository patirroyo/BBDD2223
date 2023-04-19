# 1 Triggers, procedimientos y funciones en MySQL


# 1.1 Procedimientos

-- Lo primero que hay que hacer es cambiar el delimitador:
DELIMITER $$
-- Luego CREATE PROCEDURE, BEGIN y termino con END;
CREATE PROCEDURE listar_productos(IN gama VARCHAR(50))
    -- IN paso por valor, metes el valor en tu código y haces lo que quieres con él pero sin modificar el dato original, es decir se pasa una copia.
    -- INOUT paso por referencia: si se modifica el dato, se modifica el valor original, se pasará el valor original, no una copia.
    -- OUT son variables de salida, variables que quiero que contengan información. Como devolver un valor, simplemente las declaro (Declare) y ya las puedo usar.
    -- DECLARE gama;
    -- CALL listar_productos(gama);
BEGIN
    SELECT *
    FROM producto
    WHERE producto.gama = gama;
END $$
-- Cuando acabamos lo volvemos a cambiar:
DELIMITER ;
-- llamamos al procedimiento
CALL listar_productos('Frutales');


DELIMITER $$
DROP PROCEDURE IF EXISTS contar_productos$$
CREATE PROCEDURE contar_productos(IN gama VARCHAR(50), OUT total INT UNSIGNED)
-- variable total es de salida, va a tener un valor.
BEGIN
    SET total = (
        SELECT COUNT(*)
        FROM producto
        WHERE producto.gama = gama);
END
$$

DELIMITER ;
CALL contar_productos('Herramientas', @total);
-- la @ significa address: dirección porque las variables de entrada/salida son direcciones de memoria, por lo que con la @ indico que lo que estoy mandando son direcciones de memoria.
SELECT @total;

-- tenemos otra manera de asignar valores a variables, la anterior y esta (SELECT INTO):
DELIMITER $$
DROP PROCEDURE IF EXISTS contar_productos$$
CREATE PROCEDURE contar_productos(IN gama VARCHAR(50), OUT total INT UNSIGNED)
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM producto
    WHERE producto.gama = gama;
END
$$

DELIMITER ;
CALL contar_productos('Herramientas', @total);
SELECT @total;

-- DIFERENCIA ENTRE SET Y SELECT INTO
-- Solucioń 1. Utilizando SET
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_max_min_media$$
CREATE PROCEDURE calcular_max_min_media(
    IN gama VARCHAR(50),
    OUT maximo DECIMAL(15, 2),
    OUT minimo DECIMAL(15, 2),
    OUT media DECIMAL(15, 2)
)
BEGIN
    SET maximo = (
        SELECT MAX(precio_venta)
        FROM producto
        WHERE producto.gama = gama);

    SET minimo = (
        SELECT MIN(precio_venta)
        FROM producto
        WHERE producto.gama = gama);

    SET media = (
        SELECT AVG(precio_venta)
        FROM producto
        WHERE producto.gama = gama);
END
$$

DELIMITER ;
CALL calcular_max_min_media('Herramientas', @maximo, @minimo, @media);
SELECT @maximo, @minimo, @media;

-- Solucioń 2. Utilizando SELECT ... INTO
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_max_min_media$$
CREATE PROCEDURE calcular_max_min_media(
    IN gama VARCHAR(50),
    OUT maximo DECIMAL(15, 2),
    OUT minimo DECIMAL(15, 2),
    OUT media DECIMAL(15, 2)
)
BEGIN
    SELECT
        MAX(precio_venta),
        MIN(precio_venta),
        AVG(precio_venta)
    FROM producto
    WHERE producto.gama = gama
    INTO maximo, minimo, media;
END
$$

DELIMITER ;
CALL calcular_max_min_media('Herramientas', @maximo, @minimo, @media);
SELECT @maximo, @minimo, @media;

-- Con el SELECT INTO hacemos muchas menos consultas.

# FUNCIONES

-- las funciones tienen un RETURN
-- Tenemos que indicar el tipo de dato que devuelve
-- se llaman con un SELECT
-- DETERMINISTIC O NOT DETERMINISTIC
-- NO SQL
-- contains SQL


#un bucle for
-- for (p1=0; p1 < 10; p1++)
CREATE PROCEDURE doiterate(p1 INT)
BEGIN
    SET p1 = 0; -- condicion inicial
    label1: LOOP

        IF p1 < 10 THEN -- condicion de parada del for
            ITERATE label1;
        END IF;
        SET p1 = p1 + 1; -- como se incrementa el for
        LEAVE label1;
    END LOOP label1;
    SET @x = p1;
END;

# REPEAT Es un do while: hacer esto mientras se cumpla esta condicion.
DELIMITER $$

CREATE PROCEDURE ejemplo_bucle_repeat(IN tope INT, OUT suma INT)
BEGIN
    DECLARE contador INT;

    SET contador = 1;
    SET suma = 0;

    REPEAT
        SET suma = suma + contador;
        SET contador = contador + 1;
    UNTIL contador > tope
        END REPEAT;
END
$$


-- WHILE contador <= tope DO
--    SET suma = suma + contador;
--    SET contador = contador + 1;
-- END WHILE;
-- END
-- $$


DELIMITER ;
CALL ejemplo_bucle_repeat(10, @resultado);
SELECT @resultado;

-- SIEMPRE HAY QUE CERRAR LO QUE SE ABRE!!!!


