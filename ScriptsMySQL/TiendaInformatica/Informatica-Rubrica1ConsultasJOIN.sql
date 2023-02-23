# 1.1.4 Consultas multitabla (Composición interna)
#
# Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.
#
# 1 Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.

-- SQL1
SELECT p.nombre AS producto,
    f.nombre as fabricante,
    p.precio as precio
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id;


-- SQL 2
SELECT p.nombre as producto,
    f.nombre as fabricante,
    p.precio as precio
FROM producto p INNER JOIN fabricante f -- si quiero quedarme con todos los datos de la tabla de la izquierda, aunque no tengan correspondencia con el de la derecha; si quiero un producto que no tiene fabricante tengo que usar el left; si no con un INNER JOIN sería suficiente
ON p.id_fabricante = f.id;
-- WHERE f.id is null; -- para ver los productos que no tienen asociado un fabricante


# 2 Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.

-- SQL1
SELECT p.nombre AS producto,
    f.nombre AS fabricante,
    p.precio AS precio
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
ORDER BY f.nombre ASC;


-- SQL 2
SELECT p.nombre AS producto,
    f.nombre AS fabricante,
    p.precio AS precio
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
ORDER BY f.nombre ASC;

# 3 Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos.

-- SQL1
SELECT p.id AS ientificadorProducto,
    p.nombre AS producto,
    f.id AS identificadorFabricante,
    f.nombre AS fabricante
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id;


-- SQL 2
SELECT p.id AS ientificadorProducto,
    p.nombre AS producto,
    f.id AS identificadorFabricante,
    f.nombre AS fabricante
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id;

# 4 Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.

-- SQL1
SELECT p.nombre AS producto,
    f.nombre AS fabricante,
    p.precio AS precio
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
ORDER BY p.precio ASC
LIMIT 1;

-- SQL 2

SELECT p.nombre AS producto,
    f.nombre AS fabricante,
    p.precio AS precio
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
ORDER BY p.precio ASC
LIMIT 1;

# 5 Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.

-- SQL1
SELECT p.nombre AS producto,
    f.nombre AS fabricante,
    p.precio AS precio
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
ORDER BY p.precio DESC
LIMIT 1;

-- SQL 2

SELECT p.nombre AS producto,
    f.nombre AS fabricante,
    p.precio AS precio
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
ORDER BY p.precio DESC
LIMIT 1;

# 6 Devuelve una lista de todos los productos del fabricante Lenovo.

-- SQL1
SELECT p.nombre AS producto
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
    AND f.nombre = 'Lenovo';

-- SQL 2

SELECT p.nombre AS producto
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
WHERE f.nombre = 'Lenovo';


# 7 Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.

-- SQL1
SELECT p.nombre AS producto
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
    AND f.nombre = 'Crucial'
    AND p.precio > 200;

-- SQL 2

SELECT p.nombre AS producto
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
WHERE f.nombre = 'Crucial'
AND p.precio > 200;

# 8 Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.

-- SQL1
SELECT p.nombre AS producto,
        f.nombre AS fabricante
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
    AND (f.nombre = 'Asus'
        OR f.nombre = 'Hewlett-Packard'
        OR f.nombre = 'Seagate');

-- SQL 2

SELECT p.nombre AS producto,
        f.nombre AS fabricante
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
WHERE f.nombre = 'Asus'
    OR f.nombre = 'Hewlett-Packard'
    OR f.nombre = 'Seagate';

# 9 Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.

-- SQL1
SELECT p.nombre AS producto,
        f.nombre AS fabricante
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
    AND f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- SQL 2

SELECT p.nombre AS producto,
        f.nombre AS fabricante
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');


# 10 Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.

-- SQL1
SELECT p.nombre AS producto,
        p.precio AS precio
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
    AND f.nombre LIKE '%e';

-- SQL 2

SELECT p.nombre AS producto,
        p.precio AS precio
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%e';


# 11 Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.

-- SQL1
SELECT p.nombre AS producto,
        p.precio AS precio
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
    AND f.nombre LIKE '%w%';

-- SQL 2

SELECT p.nombre AS producto,
        p.precio AS precio
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%w%';

# 12 Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)

-- SQL1
SELECT p.nombre AS producto,
        p.precio AS precio,
        f.nombre AS fabricante
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
    AND p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

-- SQL 2

SELECT p.nombre AS producto,
        p.precio AS precio,
        f.nombre AS fabricante
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

# 13 Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.

-- SQL1
SELECT DISTINCT f.id AS identificador,
        f.nombre AS fabricante
FROM producto p, fabricante f
WHERE p.id_fabricante = f.id
    AND p.id IS NOT NULL ;

-- SQL 2

SELECT DISTINCT f.id AS identificador,
        f.nombre AS fabricante
FROM producto p INNER JOIN fabricante f
ON p.id_fabricante = f.id;

# 1.1.5 Consultas multitabla (Composición externa)

# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

# 1 Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.

SELECT p.nombre,
        f.nombre AS fabricante
FROM producto p RIGHT JOIN fabricante f
ON p.id_fabricante = f.id;

# 2 Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.

SELECT f.nombre AS fabricante
FROM producto p RIGHT JOIN fabricante f
ON p.id_fabricante = f.id
WHERE p.id IS NULL;

# 3 ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.

# NO pueden existir prodcutos sin estar relacionados con un fabricante pues la columna id_fabricante es 'NOT NULL' por lo que no se pueden introducir datos sin ese valor, a no ser que se desactive manualmente.