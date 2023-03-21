-- 1. Consulte cuáles son los índices que hay en la tabla producto utilizando las instrucciones SQL que nos permiten obtener esta información de la tabla.

SHOW INDEX from producto;

-- 2. Haga uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas y diga cuál de las dos consultas realizará menos comparaciones para encontrar el producto que estamos buscando. ¿Cuántas comparaciones se realizan en cada caso? ¿Por qué?.
EXPLAIN SELECT *
FROM producto
WHERE codigo_producto = 'OR-114';

-- Se usa 1 comparación porque hay un índice creado sobre producto.

EXPLAIN SELECT *
FROM producto
WHERE nombre = 'Evonimus Pulchellus';

-- Se usan 276 comparaciones hasta que lo consigue porque no existe un índice donde buscar.

-- 3. Suponga que estamos trabajando con la base de datos jardineria y queremos saber optimizar las siguientes consultas. ¿Cuál de las dos sería más eficiente?. Se recomienda hacer uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas.
EXPLAIN SELECT AVG(total)
FROM pago
WHERE YEAR(fecha_pago) = 2008;

-- La función YEAR no aprovecha los indices, por lo que sería menos eficiente al calcular el año de todos y cada uno de las filas.

EXPLAIN SELECT AVG(total)
FROM pago
WHERE fecha_pago >= '2008-01-01' AND fecha_pago <= '2008-12-31';
-- Nota: Lectura recomendada sobre la función YEAR y el uso de índices.

-- En este caso si usaría el índice si existiera, por lo que sería más eficiente. Pero no hay índice por lo que ambas consultas son iguales.



-- 4. Optimiza la siguiente consulta creando índices cuando sea necesario. Se recomienda hacer uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas.

SHOW INDEX FROM pedido;

CREATE INDEX pedido_codigo_cliente_IDX USING BTREE ON jardineria.pedido (codigo_cliente);
CREATE INDEX cliente_nombre_cliente_IDX USING BTREE ON jardineria.cliente (nombre_cliente);

SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE 'A%';



-- 5. ¿Por qué no es posible optimizar el tiempo de ejecución de las siguientes consultas, incluso haciendo uso de índices?

-- SELECT *
-- FROM cliente INNER JOIN pedido
-- ON cliente.codigo_cliente = pedido.codigo_cliente
-- WHERE cliente.nombre_cliente LIKE '%A%';
--
-- SELECT *
-- FROM cliente INNER JOIN pedido
-- ON cliente.codigo_cliente = pedido.codigo_cliente
-- WHERE cliente.nombre_cliente LIKE '%A';

-- la funcioon like usa por debajo el coalesce y esa opereacionno se ejecuta contra los indices creados

-- 6. Crea un índice de tipo FULLTEXT sobre las columnas nombre y descripcion de la tabla producto.


-- 7. Una vez creado el índice del ejercicio anterior realiza las siguientes consultas haciendo uso de la función MATCH, para buscar todos los productos que:
-- Contienen la palabra planta en el nombre o en la descripción. Realice una consulta para cada uno de los modos de búsqueda full-text que existen en MySQL (IN NATURAL LANGUAGE MODE, IN BOOLEAN MODE y WITH QUERY EXPANSION) y compare los resultados que ha obtenido en cada caso.
-- Contienen la palabra planta seguida de cualquier carácter o conjunto de caracteres, en el nombre o en la descripción.
-- Empiezan con la palabra planta en el nombre o en la descripción.
-- Contienen la palabra tronco o la palabra árbol en el nombre o en la descripción.
-- Contienen la palabra tronco y la palabra árbol en el nombre o en la descripción.
-- Contienen la palabra tronco pero no contienen la palabra árbol en el nombre o en la descripción.
-- Contiene la frase proviene de las costas en el nombre o en la descripción.


-- 8. Crea un índice de tipo INDEX compuesto por las columnas apellido_contacto y nombre_contacto de la tabla cliente.


-- 9. Una vez creado el índice del ejercicio anterior realice las siguientes consultas haciendo uso de EXPLAIN:
-- Busca el cliente Javier Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?
-- Busca el ciente anterior utilizando solamente el apellido Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?
-- Busca el ciente anterior utilizando solamente el nombre Javier. ¿Cuántas filas se han examinado hasta encontrar el resultado? ¿Qué ha ocurrido en este caso?


-- 10. Calcula cuál podría ser un buen valor para crear un índice sobre un prefijo de la columna nombre_cliente de la tabla cliente. Tenga en cuenta que un buen valor será aquel que nos permita utilizar el menor número de caracteres para diferenciar todos los valores que existen en la columna sobre la que estamos creando el índice.

-- En primer lugar calculamos cuántos valores distintos existen en la columna nombre_cliente. Necesitarás utilizar la función COUNT y DISTINCT.

SELECT COUNT(c.nombre_cliente)
FROM cliente c;

SELECT COUNT(DISTINCT c.nombre_cliente)
FROM cliente c;


-- 36 con count y 35 con distinct resultados.


-- Haciendo uso de la función LEFT ve calculando el número de caracteres que necesitas utilizar como prefijo para diferenciar todos los valores de la columna. Necesitarás la función COUNT, DISTINCT y LEFT.

SELECT COUNT(DISTINCT (LEFT(c.nombre_cliente, 11)))
FROM cliente c;

-- el tamaño más pequeño que puedo usar es 11

-- Una vez que hayas encontrado el valor adecuado para el prefijo, crea el índice sobre la columna nombre_cliente de la tabla cliente.

CREATE INDEX cliente_nombre_cliente_IDX ON jardineria.cliente (nombre_cliente(11));


-- Ejecuta algunas consultas de prueba sobre el índice que acabas de crear.

EXPLAIN SELECT *
FROM cliente c
WHERE nombre_cliente = 'Beragua';
