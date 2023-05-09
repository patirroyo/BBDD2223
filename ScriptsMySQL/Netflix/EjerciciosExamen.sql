# 1)Se desea tener un procedimiento almacenado tal que dados un nombre y apellidos del empleado, compruebe si este empleado es jefe de un almacén.

DELIMITER $$
DROP FUNCTION IF EXISTS es_jefe $$
CREATE FUNCTION es_jefe(nombre VARCHAR(45), apellidos VARCHAR(45))
    RETURNS BOOLEAN DETERMINISTIC
    BEGIN
        DECLARE id TINYINT UNSIGNED;
        SET id = (SELECT e.id_empleado
                FROM empleado e
                WHERE e.nombre = nombre
                    AND e. apellidos = apellidos);
        IF id IN (SELECT a.id_empleado_jefe
                    FROM almacen a) THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END $$
DELIMITER ;
SELECT es_jefe('Ringo', 'Rooksby');
SELECT es_jefe('Ada', 'Byron');


# 2)En caso afirmativo deberemos recuperar todos los empleados de ese almacén.



# 3)De cada empleado de ese almacén calcularemos  el tiempo medio de devolución de los alquileres de ese empleado.
# 4)Al final del procedimiento devolveremos la suma de todos los tiempos medios de devolución de alquileres(apartado 3)
#
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
