/*Muestra la información completa de todos los pokemon indicando mediante que
piedra evolucionan (solo en aquellos que evolucionan mediante alguna piedra,
mostrando la información de la piedra)*/
SELECT p.*,
		IF(tp.nombre_piedra IS NULL, '', tp.nombre_piedra) AS 'piedra evolucion'
FROM pokemon p
	LEFT JOIN pokemon_forma_evolucion pfe
		ON p.numero_pokedex = pfe.numero_pokedex
	LEFT JOIN forma_evolucion fe
		ON pfe.id_forma_evolucion = fe.id_forma_evolucion
	LEFT JOIN tipo_evolucion te
		ON fe.tipo_evolucion = te.id_tipo_evolucion
	LEFT JOIN piedra p2
		ON fe.id_forma_evolucion = p2.id_forma_evolucion
	LEFT JOIN tipo_piedra tp
		ON p2.id_tipo_piedra = tp.id_tipo_piedra;

/*Muestra la informacion completa de los pokemon que evolucionan
mediante MT o MO, indicándo (MT/MO) en los resultados de la
consuta segun corresponda */
SELECT p.*,
		'MO' as 'tipo aprendizaje'
FROM pokemon p
	INNER JOIN pokemon_movimiento_forma pmf
		ON p.numero_pokedex = pmf.numero_pokedex
	INNER JOIN forma_aprendizaje fa
		ON pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
	INNER JOIN MO m
		ON fa.id_forma_aprendizaje = m.id_forma_aprendizaje
UNION
SELECT p.*,
		'MT' as 'tipo aprendizaje'
FROM pokemon p
	INNER JOIN pokemon_movimiento_forma pmf
		ON p.numero_pokedex = pmf.numero_pokedex
	INNER JOIN forma_aprendizaje fa
		ON pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
	INNER JOIN MT m
		ON fa.id_forma_aprendizaje = m.id_forma_aprendizaje;

/*Dime los ataques que se aprenden por nivel y los que no.
Debes indicar el nivel en el que se aprenden y en aquellos
que no se aprenden por nivel debe indicar NULO*/
SELECT DISTINCT m.id_movimiento,
		m.nombre,
		IF(na.nivel IS NULL, 'NULO', na.nivel) as 'Nivel'
FROM movimiento m
	INNER JOIN pokemon_movimiento_forma pmf
		ON m.id_movimiento = pmf.id_movimiento
	INNER JOIN forma_aprendizaje fa
		ON pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
	LEFT JOIN nivel_aprendizaje na
		ON fa.id_forma_aprendizaje = na.id_forma_aprendizaje;

/*Dime todos los ataques de tipo fuego añadiendo la
informacion de aquellos que tengan efecto secundario */
SELECT DISTINCT m.id_movimiento,
		m.nombre,
		t.nombre,
		IF(es.efecto_secundario IS NULL, '', es.efecto_secundario) as efecto_secundario
FROM movimiento m
	INNER JOIN tipo t
		ON m.id_tipo = t.id_tipo
	LEFT JOIN movimiento_efecto_secundario mes
		ON m.id_movimiento = mes.id_movimiento
	LEFT JOIN efecto_secundario es
		ON mes.id_efecto_secundario = es.id_efecto_secundario
WHERE t.nombre = 'Fuego';

/*Dime que pokemon no tiene estadísticas base asociadas y de qué tipo es*/
SELECT p.*,
	t.nombre
FROM pokemon p
	LEFT JOIN estadisticas_base eb
		ON p.numero_pokedex = eb.numero_pokedex
	INNER JOIN pokemon_tipo pt
		ON p.numero_pokedex = pt.numero_pokedex
	INNER JOIN tipo t
		ON pt.id_tipo = t.id_tipo
WHERE eb.numero_pokedex IS NULL;

/*Muestra los pokemon que evolucionan mediante mt, mo o nivel*/
SELECT DISTINCT p.*,
		tfa.tipo_aprendizaje
FROM pokemon p
	INNER JOIN pokemon_movimiento_forma pmf
		ON p.numero_pokedex = pmf.numero_pokedex
	INNER JOIN forma_aprendizaje fa
		ON pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
	INNER JOIN tipo_forma_aprendizaje tfa
		ON fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje;

/*Muestra los pokemon que evolucionan mediante mt, mo o nivel*/
SELECT DISTINCT p.*,
		tfa.tipo_aprendizaje
FROM pokemon p
	INNER JOIN pokemon_movimiento_forma pmf
		ON p.numero_pokedex = pmf.numero_pokedex
	INNER JOIN forma_aprendizaje fa
		ON pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
	INNER JOIN tipo_forma_aprendizaje tfa
		ON fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje;

/*Muestra la información completa de los pokemon junto
con su estadística base de los pokemon de fuego y
los ataque que estos tengan */
SELECT p.*,
	eb.*,
	t.nombre as 'Tipo',
	m.nombre as 'Movimiento'
FROM pokemon p
	INNER JOIN estadisticas_base eb
		ON p.numero_pokedex = eb.numero_pokedex
	INNER JOIN pokemon_tipo pt
		ON p.numero_pokedex = pt.numero_pokedex
	INNER JOIN tipo t
		ON pt.id_tipo = t.id_tipo
	INNER JOIN pokemon_movimiento_forma pmf
		ON p.numero_pokedex = pmf.numero_pokedex
	INNER JOIN movimiento m
		ON pmf.id_movimiento = m.id_movimiento
WHERE t.nombre = 'Fuego';

/*Crea un indice fulltext sobre la columna descripcion de
la tabla movimientos y busca aquellos ataques
que causa daño y probabilidad*/

CREATE FULLTEXT INDEX idx_descripcion2 ON movimiento(descripcion);

SELECT *
FROM movimiento
WHERE MATCH(descripcion) AGAINST ('+daño +probabilidad' IN BOOLEAN MODE);

/*Crea los indices necesarios y solo los justos que permita optimizar
la siguiente consulta dime los pokemon con una altura
entre metro y medio y dos metros pero que pesen mas de 30 kilos*/

CREATE INDEX idx_altura_peso ON pokemon(altura, peso);

EXPLAIN SELECT p.*
FROM pokemon p
WHERE p.altura > '1.5'
	AND p.altura < '2'
	AND p.peso > '30';

/*Crea un indice para optimizar la consulta de los movimientos
y su pokemon, añade una consulta que haga uso de este indice*/

CREATE INDEX idx_numero_idMoviviento ON pokemon_movimiento_forma(numero_pokedex, id_movimiento);

EXPLAIN SELECT p.nombre,
	m.nombre
FROM pokemon p
	INNER JOIN pokemon_movimiento_forma pmf
		ON p.numero_pokedex = pmf.numero_pokedex
	INNER JOIN movimiento m
		ON pmf.id_movimiento = m.id_movimiento;

