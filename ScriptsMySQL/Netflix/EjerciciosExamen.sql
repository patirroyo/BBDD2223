# 1)Se desea tener un procedimiento almacenado tal que dados un nombre y apellidos del empleado, compruebe si este empleado es jefe de un almacén.

DELIMITER $$
DROP FUNCTION IF EXISTS es_jefe $$
CREATE FUNCTION es_jefe(nombre VARCHAR(45), apellidos VARCHAR(45))
    RETURNS INT DETERMINISTIC
    BEGIN
        DECLARE id TINYINT UNSIGNED;
        SET id = (SELECT e.id_empleado
                FROM empleado e
                WHERE e.nombre = nombre
                    AND e. apellidos = apellidos);
        IF id IN (SELECT a.id_empleado_jefe
                    FROM almacen a) THEN
            RETURN id;
        ELSE
            RETURN FALSE;
        END IF;
    END $$
DELIMITER ;
SELECT es_jefe('Jon', 'Stephens');
SELECT es_jefe('Ada', 'Byron');


# 2)En caso afirmativo deberemos recuperar todos los empleados de ese almacén.
DELIMITER $$
DROP FUNCTION IF EXISTS empleados_por_jefe $$
CREATE FUNCTION empleados_por_jefe(nombre VARCHAR(45), apellidos VARCHAR(45))
    RETURNS
    BEGIN
    DECLARE jefe INT;
        IF (SELECT es_jefe(nombre, apellidos) != 0) THEN
            SET jefe = es_jefe(nombre, apellidos);
            SELECT e.id_empleado
            FROM empleado e
            WHERE id_almacen = (SELECT id_almacen
                                FROM almacen
                                WHERE id_empleado_jefe = jefe);

        END IF;
    END $$
DELIMITER ;

CALL empleados_por_jefe('Jon', 'Stephens');

# 3)De cada empleado de ese almacén calcularemos  el tiempo medio de devolución de los alquileres de ese empleado.
DELIMITER $$
DROP FUNCTION IF EXISTS tiempo_medio_devolucion $$
CREATE FUNCTION tiempo_medio_devolucion(id_emple INTEGER)
    RETURNS FLOAT READS SQL DATA
    BEGIN
        DECLARE resultado FLOAT;
        SELECT AVG(DATEDIFF(a.fecha_devolucion,a.fecha_alquiler))
        INTO resultado
        FROM alquiler a
        WHERE a.id_empleado = id_emple;
        RETURN resultado;
    END $$
DELIMITER ;

SELECT tiempo_medio_devolucion(1);

# 4)Al final del procedimiento devolveremos la suma de todos los tiempos medios de devolución de alquileres(apartado 3)
#
DELIMITER $$
DROP PROCEDURE IF EXISTS tiempo_devolucion_por_jefe $$
CREATE PROCEDURE tiempo_devolucion_por_jefe(IN nombre VARCHAR(30), IN apellidos VARCHAR(30), OUT tiempo FLOAT)
BEGIN
    DECLARE num_empleados INT;
    DECLARE sum_tiempo FLOAT;
    DECLARE avg_empleado FLOAT;
    DECLARE done INT;
    DECLARE id_e INT;
    DECLARE id_alma INT;
    DECLARE empleados CURSOR FOR SELECT e.id_empleado
                                        FROM empleado e
                                        WHERE e.id_almacen = id_alma;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    SET done = 0;
    SET num_empleados = 0;
    SET sum_tiempo = 0;
    SET id_alma = es_jefe(nombre, apellidos);
    OPEN empleados;
        bucle: LOOP
        FETCH empleados
        INTO id_e;
        SET avg_empleado = 0;
            IF done = 1 THEN
                LEAVE bucle;
            END IF;
        IF (tiempo_medio_devolucion(id_e) IS NOT NULL) THEN
            SET avg_empleado = tiempo_medio_devolucion(id_e);
            SET num_empleados = num_empleados +1;
        END IF;
        SET sum_tiempo = sum_tiempo + avg_empleado;
        END LOOP;
    CLOSE empleados;
    SET tiempo = sum_tiempo/num_empleados;
END $$
DELIMITER ;
CALL tiempo_devolucion_por_jefe('Jon', 'Stephens', @suma);
SELECT @suma;


DELIMITER $$
DROP PROCEDURE IF EXISTS tiempo_medio_devolucion_por_jefe $$
CREATE PROCEDURE tiempo_medio_devolucion_por_jefe(IN nombre VARCHAR(45), IN apellidos VARCHAR(45), OUT sum_avg_time INTEGER)
    BEGIN
        DECLARE done INT DEFAULT 0;
        DECLARE id_jefe TINYINT UNSIGNED;
        DECLARE id_almacen TINYINT UNSIGNED;
        DECLARE id_e TINYINT UNSIGNED;
        DECLARE average_per_emp INTEGER;
        DECLARE num_empleados INTEGER;
        DECLARE empleados_almacen CURSOR FOR SELECT id_empleado
                                    FROM empleado e
                                    WHERE e.id_almacen = id_almacen;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

        SET sum_avg_time = 0;
        SET id_jefe = (SELECT e.id_empleado
                        FROM empleado e
                        WHERE e.nombre = nombre
                            AND e.apellidos = apellidos);
        SET id_almacen = (SELECT a.id_almacen
                            FROM almacen a
                            WHERE a.id_empleado_jefe = id_jefe
                            LIMIT 1);
        SELECT COUNT(e.id_empleado) INTO num_empleados
            FROM empleado e
            WHERE e.id_almacen = id_almacen;
        OPEN empleados_almacen;
            bucle: LOOP
                FETCH empleados_almacen
                INTO id_e;
                SET average_per_emp = 0;
                IF done = 1 THEN
                    LEAVE bucle;
                END IF;
                SELECT AVG(DATEDIFF(a.fecha_devolucion, a.fecha_alquiler))
                    INTO average_per_emp
                    FROM  alquiler a
                    WHERE a.id_empleado = id_e
                        AND a.fecha_devolucion > a.fecha_alquiler;
                SELECT average_per_emp;
                IF(average_per_emp is not null) THEN
                    SET sum_avg_time = sum_avg_time + average_per_emp;
                    SELECT sum_avg_time;
                ELSE
                    SET num_empleados = num_empleados - 1;
                END IF;

            END LOOP bucle;
        SET sum_avg_time = sum_avg_time / num_empleados;
        CLOSE empleados_almacen;
    END $$
DELIMITER ;
CALL tiempo_medio_devolucion_por_jefe('Jon', 'Stephens', @suma);
SELECT @suma;
