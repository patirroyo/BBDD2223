# 1.4.5 Consultas multitabla (Composición interna)
#
# Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

# 1    Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

-- SQL1
SELECT c.nombre_cliente,
        e.nombre,
        e.apellido1
FROM cliente c,
    empleado e
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- SQL2
SELECT c.nombre_cliente,
        e.nombre,
        e.apellido1
FROM cliente c INNER JOIN empleado e
    ON c.codigo_empleado_rep_ventas = e.codigo_empleado;


# 2    Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

-- SQL1
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        e.apellido1
FROM cliente c,
    empleado e
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
    AND c.codigo_cliente IN (
                            SELECT c1.codigo_cliente
                            FROM cliente c1,
                                pago p
                            WHERE c1.codigo_cliente = p.codigo_cliente
                            );

-- SQL2
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        e.apellido1
FROM cliente c INNER JOIN empleado e
    ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_cliente IN (
                            SELECT c1.codigo_cliente
                            FROM cliente c1 NATURAL JOIN  pago p
                            );


# 3    Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

-- SQL1
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        e.apellido1
FROM cliente c,
    empleado e
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
    AND c.codigo_cliente NOT IN (
                            SELECT c1.codigo_cliente
                            FROM cliente c1,
                                pago p
                            WHERE c1.codigo_cliente = p.codigo_cliente
                            );

-- SQL2
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        e.apellido1
FROM cliente c INNER JOIN empleado e
    ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_cliente NOT IN (
                            SELECT c1.codigo_cliente
                            FROM cliente c1 NATURAL JOIN  pago p
                            );


# 4    Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

-- SQL1
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        e.apellido1,
        o.ciudad
FROM cliente c,
    empleado e,
    oficina o
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
    AND e.codigo_oficina = o.codigo_oficina
    AND c.codigo_cliente IN (
                            SELECT c1.codigo_cliente
                            FROM cliente c1,
                                pago p
                            WHERE c1.codigo_cliente = p.codigo_cliente
                            );

-- SQL2
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        e.apellido1,
        o.ciudad
FROM cliente c
    INNER JOIN empleado e
        ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    INNER JOIN oficina o
        ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente IN (
                            SELECT c1.codigo_cliente
                            FROM cliente c1 NATURAL JOIN  pago p
                            );

# 5    Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

-- SQL1
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        e.apellido1,
        o.ciudad
FROM cliente c,
    empleado e,
    oficina o
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
    AND e.codigo_oficina = o.codigo_oficina
    AND c.codigo_cliente NOT IN (
                            SELECT c1.codigo_cliente
                            FROM cliente c1,
                                pago p
                            WHERE c1.codigo_cliente = p.codigo_cliente
                            );

-- SQL2
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        e.apellido1,
        o.ciudad
FROM cliente c
    INNER JOIN empleado e
        ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    INNER JOIN oficina o
        ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente NOT IN (
                            SELECT c1.codigo_cliente
                            FROM cliente c1 NATURAL JOIN  pago p
                            );

# 6    Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

-- SQL1
SELECT o.linea_direccion1,
        o.linea_direccion2,
        o.codigo_postal,
        o.ciudad
FROM cliente c,
    empleado e,
    oficina o
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
    AND e.codigo_oficina = o.codigo_oficina
    AND c.ciudad = 'Fuenlabrada';

-- SQL2
SELECT o.linea_direccion1,
        o.linea_direccion2,
        o.codigo_postal,
        o.ciudad
FROM cliente c
    INNER JOIN empleado e
        ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    INNER JOIN oficina o
        ON e.codigo_oficina = o.codigo_oficina
WHERE c.ciudad = 'Fuenlabrada';

# 7    Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

-- SQL1
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        o.ciudad
FROM cliente c,
    empleado e,
    oficina o
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
    AND e.codigo_oficina = o.codigo_oficina;

-- SQL2
SELECT c.codigo_cliente,
        c.nombre_cliente,
        e.nombre,
        o.ciudad
FROM cliente c
    INNER JOIN empleado e
        ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    INNER JOIN oficina o -- se podría utilizar el natural join
        ON e.codigo_oficina = o.codigo_oficina;

# 8    Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

-- SQL1
SELECT e.nombre,
       j.nombre AS 'Jefe'
FROM empleado e,
    empleado j
WHERE j.codigo_empleado = e.codigo_jefe;

-- SQL2
SELECT e.nombre,
       j.nombre AS 'Jefe'
FROM empleado e INNER JOIN empleado j
    ON e.codigo_jefe = j.codigo_empleado
WHERE j.codigo_empleado = e.codigo_jefe;


# 9    Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

-- SQL1
SELECT e.nombre AS 'Empleado',
       e1.nombre AS 'Jefe',
       e2.nombre AS 'Jefe del Jefe'
FROM empleado e,
    empleado e1,
    empleado e2
WHERE e1.codigo_empleado = e.codigo_jefe
    AND e2.codigo_empleado = e1.codigo_jefe;

-- SQL2
SELECT e.nombre AS 'Empleado',
       j.nombre AS 'Jefe',
       jdj.nombre AS 'Jefe del Jefe'
FROM empleado e
    INNER JOIN empleado j
        ON e.codigo_jefe = j.codigo_empleado
    INNER JOIN empleado jdj
        ON j.codigo_jefe = jdj.codigo_empleado
WHERE j.codigo_empleado = e.codigo_jefe;


# 10    Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

-- SQL1
SELECT DISTINCT c.nombre_cliente
FROM cliente c,
     pedido p
WHERE c.codigo_cliente = p.codigo_cliente
    AND p.estado = 'Entregado'
    AND p.fecha_entrega > p.fecha_esperada;

-- SQL2
SELECT DISTINCT c.nombre_cliente
FROM cliente c NATURAL JOIN pedido p
   -- ON c.codigo_cliente = p.codigo_cliente
WHERE p.estado = 'Entregado'
    AND p.fecha_entrega > p.fecha_esperada;

# 11    Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

-- SQL1
SELECT DISTINCT c.nombre_cliente,
                g.gama
FROM cliente c,
    pedido p,
    detalle_pedido dp,
    producto pr,
    gama_producto g
WHERE  c.codigo_cliente = p.codigo_cliente
    AND p.codigo_pedido = dp.codigo_pedido
    AND dp.codigo_producto = pr.codigo_producto
    AND pr.gama = g.gama;

-- SQL2
SELECT DISTINCT c.nombre_cliente,
                g.gama
FROM cliente c
    NATURAL JOIN pedido p
    NATURAL JOIN detalle_pedido dp
    NATURAL JOIN producto pr
    NATURAL JOIN gama_producto g;


# 1.4.6 Consultas multitabla (Composición externa)

# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.

# 1    Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.



# 2    Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.



# 3    Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.



# 4    Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.



# 5    Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.



# 6    Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.



# 7    Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.



# 8    Devuelve un listado de los productos que nunca han aparecido en un pedido.



# 9    Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.



# 10    Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.



# 11    Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

SELECT DISTINCT c.nombre_cliente
FROM cliente c
    INNER JOIN  pedido p
        ON c.codigo_cliente = p.codigo_cliente
    LEFT JOIN  pago p2
        ON c.codigo_cliente = p2.codigo_cliente
WHERE p2.id_transaccion IS NULL;


# 12    Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.


