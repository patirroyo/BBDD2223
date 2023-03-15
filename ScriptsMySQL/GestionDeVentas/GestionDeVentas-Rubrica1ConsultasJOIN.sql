# 1.3.4 Consultas multitabla (Composición interna)
#
# Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.
#
# 1    Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.

-- SQL1
SELECT DISTINCT c.id,
        c.nombre,
        c.apellido1,
        c.apellido2
FROM cliente c,
    pedido p
WHERE c.id = p.id_cliente
ORDER BY c.apellido1,
        c.apellido2;

-- SQL2
SELECT DISTINCT c.id,
        c.nombre,
        c.apellido1,
        c.apellido2
FROM cliente c INNER JOIN pedido p
    ON c.id = p.id_cliente
ORDER BY c.apellido1,
        c.apellido2;

# 2    Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.

-- SQL1
SELECT c.*,
        p.*
FROM cliente c,
    pedido p
WHERE c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2;

-- SQL2
SELECT c.*,
        p.*
FROM cliente c INNER JOIN pedido p
    ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2;

# 3    Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.

-- SQL1
SELECT p.*,
        c.*
FROM pedido p,
    comercial c
WHERE p.id_comercial = c.id
ORDER BY c.apellido1, c.apellido2;

-- SQL2
SELECT p.*,
        c.*
FROM pedido p INNER JOIN comercial c
    ON p.id_comercial = c.id
ORDER BY c.apellido1, c.apellido2;

# 4    Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.

-- SQL1
SELECT c.*,
        p.*,
        co.*
FROM cliente c,
    pedido p,
    comercial co
WHERE p.id_cliente = c.id
    AND p.id_comercial = co.id;

-- SQL2
SELECT c.*,
        p.*,
        co.*
FROM cliente c
    INNER JOIN pedido p
        ON c.id = p.id_cliente
    INNER JOIN comercial co
        ON p.id_comercial = co.id;

# 5    Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.

-- SQL1
SELECT c.id,
       c.nombre,
       c.apellido1,
       YEAR(p.fecha) AS year,
       p.total
FROM cliente c,
    pedido p
WHERE p.id_cliente = c.id
    AND YEAR(p.fecha) = 2017
    AND p.total BETWEEN 300 AND 1000;

-- SQL2
SELECT c.id,
       c.nombre,
       c.apellido1,
       YEAR(p.fecha) AS year,
       p.total
FROM cliente c INNER JOIN pedido p
    ON c.id = p.id_cliente
WHERE YEAR(p.fecha) = 2017
    AND p.total BETWEEN 300 AND 1000;

# 6    Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.

-- SQL1
SELECT DISTINCT co.nombre,
       co.apellido1,
       co.apellido2
FROM cliente c,
     pedido p,
     comercial co
WHERE c.id = p.id_cliente
    AND p.id_comercial = co.id
    AND c.id =
        (SELECT c1.id
        FROM cliente c1
        WHERE c1.nombre = 'María'
            AND c1.apellido1 = 'Santana'
            AND c1.apellido2 = 'Moreno'
        );

SELECT DISTINCT co.nombre,
       co.apellido1,
       co.apellido2
FROM cliente c
    INNER JOIN pedido p
        ON c.id = p.id_cliente
    INNER JOIN comercial co
        ON p.id_comercial = co.id
WHERE c.id =
        (SELECT c1.id
        FROM cliente c1
        WHERE c1.nombre = 'María'
            AND c1.apellido1 = 'Santana'
            AND c1.apellido2 = 'Moreno'
        );

# 7    Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.

-- SQL1
SELECT DISTINCT c.nombre
FROM cliente c,
     pedido p,
     comercial co
WHERE c.id = p.id_cliente
    AND p.id_comercial = co.id
    AND co.id =
        (SELECT co1.id
        FROM comercial co1
        WHERE co1.nombre = 'Daniel'
            AND co1.apellido1 = 'Sáez'
            AND co1.apellido2 = 'Vega'
        );

SELECT DISTINCT c.nombre
FROM cliente c
    INNER JOIN pedido p
        ON c.id = p.id_cliente
    INNER JOIN comercial co
        ON p.id_comercial = co.id
WHERE co.id =
        (SELECT co1.id
        FROM comercial co1
        WHERE co1.nombre = 'Daniel'
            AND co1.apellido1 = 'Sáez'
            AND co1.apellido2 = 'Vega'
        );


# 1.3.5 Consultas multitabla (Composición externa)

# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

# 1    Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. Este listado también debe incluir los clientes que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.

SELECT c.id,
        c.nombre,
        c.apellido1,
        c.apellido2,
        p.id,
        p.fecha
FROM cliente c LEFT JOIN pedido p
    ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;

# 2    Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. Este listado también debe incluir los comerciales que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.

SELECT c.id,
        c.nombre,
        c.apellido1,
        c.apellido2,
        p.id,
        p.fecha
FROM comercial c LEFT JOIN pedido p
    ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;

# 3    Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.

SELECT c.id,
        c.nombre,
        c.apellido1,
        c.apellido2
FROM cliente c LEFT JOIN pedido p
    ON c.id = p.id_cliente
WHERE p.id IS NULL;

# 4    Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.

SELECT c.id,
        c.nombre,
        c.apellido1,
        c.apellido2
FROM comercial c LEFT JOIN pedido p
    ON c.id = p.id_comercial
WHERE p.id IS NULL;


# 5    Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos y el nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.

SELECT c.id,
        c.nombre,
        c.apellido1,
        c.apellido2,
        'cliente' AS 'Tipo'
FROM cliente c LEFT JOIN pedido p
    ON c.id = p.id_cliente
WHERE p.id IS NULL
UNION
SELECT co.id,
        co.nombre,
        co.apellido1,
        co.apellido2,
        'comercial' AS 'Tipo'
FROM comercial co LEFT JOIN pedido p
    ON co.id = p.id_comercial
WHERE p.id IS NULL
ORDER BY apellido1;

# 6    ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.

/* No habríamos podido porque los nombres de las columnas id habrían dado problemas porque todas se llaman igual pero no corresponde con lo que nos interesaría juntar*/

