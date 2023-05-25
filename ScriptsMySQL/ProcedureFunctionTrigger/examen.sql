DELIMITER $$
DROP FUNCTION IF EXISTS ultimo_alquiler $$
CREATE FUNCTION ultimo_alquiler(titulo VARCHAR(255))
RETURNS DATETIME READS SQL DATA
BEGIN
	DECLARE fecha DATETIME;
	SELECT a.fecha_alquiler into fecha
	FROM pelicula p
	INNER JOIN inventario i
	ON p.id_pelicula = i.id_pelicula
	INNER JOIN alquiler a
	ON i.id_inventario = a.id_inventario
	WHERE p.titulo = titulo
	ORDER BY a.fecha_alquiler DESC
	LIMIT 1;
	RETURN fecha;
	END $$
DELIMITER ;
SELECT ultimo_alquiler('ACE GOLDFINGER');

/* Crea una función que dado el titulo de una película, nos diga la calle del videoclub donde fue alquilada */
DELIMITER $$
DROP FUNCTION IF EXISTS calle_alquiler $$
CREATE FUNCTION calle_alquiler(titulo VARCHAR(255))
RETURNS VARCHAR(50) READS SQL DATA
BEGIN
	DECLARE calle VARCHAR(50);
	SELECT d.direccion INTO calle
	FROM pelicula p
	INNER JOIN inventario i
	    ON p.id_pelicula = i.id_pelicula
	INNER JOIN almacen a
	    ON i.id_almacen = a.id_almacen
	INNER JOIN direccion d
	    ON a.id_direccion = d.id_direccion
	INNER JOIN alquiler a2
	    ON i.id_inventario = a2.id_inventario
	WHERE p.titulo = titulo
	    AND a2.fecha_alquiler = (SELECT ultimo_alquiler(titulo));
	RETURN calle;
	END $$
DELIMITER ;
SELECT calle_alquiler('AFRICAN EGG');

/* un trigger para que cuando un cliente pase de activo a inactivo (solo en ese caso) se compruebe si el numero de clientes inactivos del videoclub(almacen) supera el 90%, en ese caso, los empleados de ese videoclub quedarán inactivos */

DELIMITER $$
DROP TRIGGER IF EXISTS desactivar_clientes_videoclub_inactivo $$
CREATE TRIGGER desactivar_clientes_videoclub_inactivo
    AFTER UPDATE ON cliente FOR EACH ROW
    BEGIN
        DECLARE activos INT;
        DECLARE inactivos INT;
        DECLARE porcentaje FLOAT;
        IF (NEW.activo = 0) THEN
            SELECT COUNT(c.id_cliente) INTO activos
            FROM cliente c
                INNER JOIN almacen a
                    ON c.id_almacen = a.id_almacen
            WHERE c.id_almacen = NEW.id_almacen
            AND c.id_cliente = 1;
            SELECT COUNT(c.id_cliente) INTO inactivos
            FROM cliente c
                INNER JOIN almacen a
                    ON c.id_almacen = a.id_almacen
            WHERE c.id_almacen = NEW.id_almacen
            AND c.id_cliente = 0;

            SET porcentaje = activos/(activos+inactivos);
            IF (porcentaje > 0.9) THEN
                UPDATE cliente SET activo = 0
                WHERE id_almacen = NEW.id_almacen;
            END IF;
        END IF;
    END $$
DELIMITER ;

/*Crea un trigger para que cuando insertamos un nuevo empleado,  su correo tenga la forma nombre.apellido@zaragoza.salesianos.edu  y si no tiene username debe poner como nombre de usuario  nombre.apellido  */
DELIMITER $$
DROP TRIGGER IF EXISTS crear_correo_empleado $$
CREATE TRIGGER crear_correo_empleado
    AFTER INSERT ON empleado FOR EACH ROW
    BEGIN
        IF(NEW.username IS NULL) THEN
            UPDATE empleado SET username = CONCAT_WS('.',nombre,apellidos)
            WHERE id_empleado = NEW.id_empleado;
        END IF ;
        UPDATE empleado SET email = CONCAT(username, '@zaragoza.salesianos.edu')
        WHERE id_empleado = NEW.id_empleado;
    END $$
DELIMITER ;

INSERT INTO empleado(nombre, apellidos, id_direccion,id_almacen) VALUES ('alberto', 'saz',1,1);

/* Queremos un procedimiento usando cursores para normalizar la información de la clasificación por edades de las películas a una tabla nueva. Esta tabla nueva tendrá una relación muchos a muchos con las películas. Hacer un procedimiento almacenado para realizar el trasvase  y normalización de la información.   USAD CURSORES  */

DELIMITER $$
DROP PROCEDURE IF EXISTS normalizar_clasificacion_edades $$
CREATE PROCEDURE normalizar_clasificacion_edades()
BEGIN
    DECLARE done INT;
    DECLARE contador INT;
    DECLARE clasi VARCHAR(10);
    DECLARE id_peli INT;
    DECLARE clasificaciones CURSOR FOR (SELECT DISTINCT clasificacion
                                        FROM pelicula);
    DECLARE pelis CURSOR FOR (SELECT id_pelicula
                                        FROM pelicula);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    SET done = 0;
    SET contador = 1;
    ALTER TABLE pelicula ADD COLUMN IF NOT EXISTS clasificacionesID SMALLINT UNSIGNED;
    DROP TABLE IF EXISTS clasificacion;
    CREATE TABLE clasificacion (id_clasificacion SMALLINT UNSIGNED PRIMARY KEY , clasificacion VARCHAR(10));
    -- ALTER TABLE clasificacion ADD CONSTRAINT FOREIGN KEY (id_clasificacion) REFERENCES pelicula(clasificacionesID);
    OPEN clasificaciones;
    bucle :LOOP
        FETCH clasificaciones INTO clasi;
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        INSERT INTO clasificacion VALUES (contador, clasi);
        SET contador = contador + 1;
    END LOOP;
    CLOSE clasificaciones;
    OPEN pelis;
    SET done = 0;
    bucle :LOOP
        FETCH pelis INTO id_peli;
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        UPDATE pelicula SET clasificacionesID = (SELECT id_clasificacion
                                             FROM clasificacion
                                             WHERE clasificacion = (SELECT clasificacion
                                                                    FROM pelicula
                                                                    WHERE id_pelicula = id_peli))
        WHERE id_pelicula = id_peli;
    END LOOP;
    CLOSE pelis;
END $$
CALL normalizar_clasificacion_edades();
/* Realiza lo mismo que para stored procedure anterior pero aplicado con el campo características especiales de la película, La tabla Características especiales tendrá el formato de id_pelicula int, trailer boolean, deleted_scenes boolean, behind_scenes boolean . Realiza el trasvase de la información  USAD CURSORES   */

DELIMITER $$
DROP PROCEDURE IF EXISTS normalizar_caracteristicas_especiales $$
CREATE PROCEDURE normalizar_caracteristicas_especiales()
BEGIN
    DECLARE done INT;
    DECLARE id_peli INT;
    DECLARE pelis CURSOR FOR (SELECT id_pelicula
                                        FROM pelicula);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    SET done = 0;
    DROP TABLE IF EXISTS caracteristicas_especiales;
    CREATE TABLE caracteristicas_especiales (id_pelicula SMALLINT UNSIGNED PRIMARY KEY , trailer BOOLEAN, deleted_scenes BOOLEAN, behind_scenes BOOLEAN, FOREIGN KEY(id_pelicula) REFERENCES pelicula(id_pelicula));
    OPEN pelis;
    SET done = 0;
    bucle :LOOP
        FETCH pelis INTO id_peli;
        IF done = 1 THEN
            LEAVE bucle;
        END IF;
        INSERT INTO caracteristicas_especiales VALUES (id_peli, FALSE, FALSE, FALSE);
        IF (SELECT id_pelicula
            FROM pelicula
            WHERE caracteristicas_especiales LIKE '%trailer%'
                AND id_pelicula = id_peli) IS NOT NULL THEN
            UPDATE caracteristicas_especiales SET trailer = TRUE
            WHERE id_pelicula = id_peli;
        END IF;
        IF (SELECT id_pelicula
            FROM pelicula
            WHERE caracteristicas_especiales LIKE '%deleted%'
                AND id_pelicula = id_peli) IS NOT NULL THEN
            UPDATE caracteristicas_especiales SET deleted_scenes = TRUE
            WHERE id_pelicula = id_peli;
        END IF;
        IF (SELECT id_pelicula
            FROM pelicula
            WHERE caracteristicas_especiales LIKE '%behind%'
                AND id_pelicula = id_peli) IS NOT NULL THEN
            UPDATE caracteristicas_especiales SET behind_scenes = TRUE
            WHERE id_pelicula = id_peli;
        END IF;
    END LOOP;
    CLOSE pelis;
END $$
CALL normalizar_caracteristicas_especiales();

