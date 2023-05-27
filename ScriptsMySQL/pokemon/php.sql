-- esto para que no de el error:
-- [HY000][1419] You do not have the SUPER privilege and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
-- set global log_bin_trust_function_creators = 1; -- No funciona en AWS
-- https://repost.aws/knowledge-center/rds-mysql-functions


-- funcion para generar IdTipos aleatorios

DELIMITER $$
DROP FUNCTION IF EXISTS generarTipo;
CREATE FUNCTION generarTipo()
    RETURNS INT READS SQL DATA
    BEGIN
        RETURN RAND()*(SELECT COUNT(t.id_tipo)
                        FROM tipo t) + 1;
    END $$
DELIMITER ;
-- SELECT generarTipo();

-- funcion para generar movimientos aleatorios
DELIMITER $$
DROP FUNCTION IF EXISTS generarMovimiento;
CREATE FUNCTION generarMovimiento()
    RETURNS INT READS SQL DATA
    BEGIN
        RETURN RAND()*(SELECT COUNT(m.id_movimiento)
                        FROM movimiento m) + 1;
    END $$
DELIMITER ;
-- SELECT generarMovimiento();

-- Procedimiento que genera tipo y movimientos aleatorios
INSERT INTO tipo_forma_aprendizaje VALUES (4, 'Trigger');
INSERT INTO forma_aprendizaje VALUES (118,4);

DELIMITER $$
DROP PROCEDURE IF EXISTS rellenarTipoMovimientos;
CREATE PROCEDURE rellenarTipoMovimientos(IN numero INT)
BEGIN
    DECLARE contador INT;
    DECLARE error INT;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET error = 1;
    SET error = 0;
    SET contador = 0;
    IF ((SELECT COUNT(pt.id_tipo)
        FROM pokemon p
        INNER JOIN pokemon_tipo pt
            ON p.numero_pokedex = pt.numero_pokedex
        WHERE p.numero_pokedex = numero) = 0) THEN
        IF (RAND()*2 = 0) THEN
            INSERT INTO pokemon_tipo VALUES (numero, generarTipo());
        ELSE
            bucle: LOOP
                IF contador > 1 THEN
                    LEAVE bucle;
                END IF;
                INSERT INTO pokemon_tipo VALUES (numero, generarTipo());
                SET contador = contador + 1;
            END LOOP ;
        END IF;
    END IF;
    IF ((SELECT COUNT(pmf.id_movimiento)
        FROM pokemon p
        INNER JOIN pokemon_movimiento_forma pmf
            ON p.numero_pokedex = pmf.numero_pokedex
        WHERE p.numero_pokedex = numero) = 0) THEN
        SET contador = RAND()*40 +1;
        bucle: LOOP
                IF contador = 0 THEN
                    LEAVE bucle;
                END IF;
                INSERT INTO pokemon_movimiento_forma VALUES (numero, generarMovimiento(), 118);
                SET contador = contador - 1;
            END LOOP ;
    END IF;
END $$
DELIMITER ;
-- CALL rellenarTipoMovimientos(154);
-- SELECT @error;

-- Ahora craeamos un trigger para que se ejecute al crear un nuevo pokemon y le cargue Tipo y movimientos

CREATE TABLE IF NOT EXISTS Creados(id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL ,fecha DATETIME,  usuario VARCHAR(20), numero_creado INT UNSIGNED, nombre VARCHAR(30));


DELIMITER $$
DROP TRIGGER IF EXISTS autoGeneraInfoPokemon $$
CREATE TRIGGER autoGeneraInfoPokemon
    AFTER INSERT
    ON pokemon FOR EACH ROW
    BEGIN
        CALL rellenarTipoMovimientos(NEW.numero_pokedex);
        INSERT INTO Creados(fecha, usuario, numero_creado, nombre)
            VALUES(NOW(), USER(), NEW.numero_pokedex, NEW.nombre);
    END $$
DELIMITER ;

-- Un procedimiento para eliminar los pokemon que tengan cosas asociadas

CREATE TABLE IF NOT EXISTS Borrados(id INT UNSIGNED UNIQUE AUTO_INCREMENT NOT NULL ,fecha DATETIME,  usuario VARCHAR(20), numero_eliminado INT UNSIGNED, nombre_eliminado VARCHAR(30));

DELIMITER $$
DROP PROCEDURE IF EXISTS limpiarPokemon;
CREATE PROCEDURE limpiarPokemon(IN numero INT)
BEGIN
    INSERT INTO Borrados(usuario, fecha, numero_eliminado, nombre_eliminado) VALUES (USER(), NOW(), numero, (SELECT nombre FROM pokemon WHERE numero_pokedex = numero));
    DELETE FROM pokemon_tipo WHERE numero_pokedex = numero;
    DELETE FROM pokemon_movimiento_forma WHERE numero_pokedex = numero;
    DELETE FROM pokemon_forma_evolucion WHERE numero_pokedex = numero;
    DELETE FROM estadisticas_base WHERE numero_pokedex = numero;
END $$
DELIMITER ;
-- CALL limpiarPokemon(155);

-- un trigger para que se ejecute antes de eliminar un pokemon y limpie todo
DELIMITER $$
DROP TRIGGER IF EXISTS matarPokemon $$
CREATE TRIGGER matarPokemon
    BEFORE DELETE
    ON pokemon FOR EACH ROW
    BEGIN
        CALL limpiarPokemon(OLD.numero_pokedex);
    END $$
DELIMITER ;



-- Guardar IP del cliente
ALTER TABLE Borrados ADD COLUMN (ip_cliente VARCHAR(30));
ALTER TABLE Borrados ADD COLUMN (user_agent VARCHAR(255));
ALTER TABLE Creados ADD COLUMN (ip_cliente VARCHAR(30));
ALTER TABLE Creados ADD COLUMN (user_agent VARCHAR(255));

-- Índice para los movimientos y los tipos

CREATE INDEX idx_idMovimiento_Aprendizaje ON pokemon_movimiento_forma(id_movimiento, id_forma_aprendizaje);
CREATE INDEX idx_idTipo_Nombre ON tipo(id_tipo, nombre);
CREATE INDEX idx_idTipoFormaAprendizaje_Nombre ON tipo_forma_aprendizaje(id_tipo_aprendizaje, tipo_aprendizaje);

-- Índice para los filtros

CREATE INDEX idx_peso ON pokemon(peso);
CREATE INDEX idx_altura ON pokemon(altura);
CREATE INDEX idx_pokemon ON pokemon(numero_pokedex, nombre, peso, altura);


-- optimizada EXPLAIN SELECT nombre FROM tipo;
-- optimizada EXPLAIN SELECT p.peso FROM pokemon p ORDER BY p.peso DESC LIMIT 1;
-- optimizada EXPLAIN SELECT p.altura FROM pokemon p ORDER BY p.altura DESC LIMIT 1;
-- optimizada EXPLAIN SELECT * FROM pokemon p;
-- optimizada EXPLAIN SELECT p.*, t.nombre as tipo FROM pokemon p INNER JOIN pokemon_tipo pt on p.numero_pokedex = pt.numero_pokedex INNER JOIN tipo t on pt.id_tipo = t.id_tipo;
-- optimizada EXPLAIN SELECT t.nombre as tipo FROM pokemon p INNER JOIN pokemon_tipo pt on p.numero_pokedex = pt.numero_pokedex INNER JOIN tipo t on pt.id_tipo = t.id_tipo;
-- optimizada EXPLAIN SELECT COUNT(m.id_movimiento) as movimientos FROM pokemon p INNER JOIN pokemon_movimiento_forma pmf ON p.numero_pokedex = pmf.numero_pokedex INNER JOIN movimiento m ON pmf.id_movimiento = m.id_movimiento;

-- Un procedimiento con cursor para sacar los tipos del pokemon
DELIMITER $$
DROP PROCEDURE IF EXISTS tiposDeUnPokemon;
CREATE PROCEDURE tiposDeUnPokemon(IN numero int, OUT tipo1 VARCHAR(30), OUT tipo2 VARCHAR(30))
    BEGIN
    DECLARE done INT;
    DECLARE numTipos INT;
    DECLARE tipo CURSOR FOR SELECT nombre
                            FROM tipo t
                            INNER JOIN pokemon_tipo pt
                                ON t.id_tipo = pt.id_tipo
                            WHERE pt.numero_pokedex = numero;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    SET done = 0;
    SET numTipos = 0;
    OPEN tipo;
    bucle : LOOP
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        FETCH tipo INTO tipo2;
            IF tipo1 IS NULL THEN
                SET tipo1 = tipo2;
            END IF;
            SET numTipos = numTipos + 1;
    END LOOP;
    CLOSE tipo;
    IF numTipos < 3 THEN
        SET tipo2 = 'No tiene';
    END IF;
    SELECT tipo1, tipo2;
END $$

-- CALL tiposDeUnPokemon(8, @tipo1, @tipo2);

