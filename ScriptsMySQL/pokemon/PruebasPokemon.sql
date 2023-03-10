-- devuelveme todo lo que pesan todos lo pokemon de tipo eléctrico

SELECT t.nombre ,
				SUM(p.peso) 
FROM pokemon p ,
		pokemon_tipo pt ,
		tipo t 
WHERE p.numero_pokedex = pt.numero_pokedex 
		AND pt.id_tipo = t.id_tipo 
GROUP BY t.nombre 

-- muestra el número de pokemon y su evolucion

SELECT pokemon_original.numero_pokedex ,
				pokemon_original.nombre AS 'Pokemon original',
				ed.pokemon_evolucionado,
				pokemon_evolucionado.nombre AS 'Pokemon evolucionado'
FROM pokemon pokemon_original ,
			evoluciona_de ed ,
			pokemon pokemon_evolucionado
WHERE pokemon_original.numero_pokedex = ed.pokemon_origen
	AND pokemon_evolucionado.numero_pokedex = ed.pokemon_evolucionado
	AND ed.pokemon_evolucionado > ed.pokemon_origen ;

-- cual es el pokemon que tiene menor ataque de estadistica_base

SELECT p.numero_pokedex ,
	p.nombre ,
	eb.ataque 
FROM pokemon p ,
	estadisticas_base eb 
WHERE p.numero_pokedex = eb.numero_pokedex 
ORDER BY eb.ataque ASC 
LIMIT 1;



-- pokemon con ataque aprendido a partir de MO

SELECT DISTINCT p.numero_pokedex ,
	p.nombre ,
	tfa.tipo_aprendizaje  
FROM pokemon p ,
	pokemon_movimiento_forma pmf ,
	forma_aprendizaje fa ,
	tipo_forma_aprendizaje tfa 
WHERE p.numero_pokedex = pmf.numero_pokedex 
	AND pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje 
	AND fa.id_tipo_aprendizaje  = tfa.id_tipo_aprendizaje
	AND tfa.tipo_aprendizaje = 'MO';

-- pokemon con ataque veneno

SELECT p.numero_pokedex ,
	p.nombre ,
	t.nombre AS 'Tipo de Pokemon'
FROM pokemon p ,
	pokemon_tipo pt ,
	tipo t 
WHERE p.numero_pokedex = pt.numero_pokedex 
	AND pt.id_tipo = t.id_tipo 
	AND t.nombre = 'veneno';
	
-- todos los pokemon que evolucionan con piedra x

-- numero de pokemon que evolucionan con piedra lunar y agrupalos por su tipo (agua,fuego,etc)

SELECT COUNT(p.numero_pokedex ) AS 'Total' ,
	t.nombre as 'Tipo Pokemon'
FROM pokemon p ,
	pokemon_forma_evolucion pfe ,
	forma_evolucion fe ,
	piedra p2 ,
	tipo_piedra tp ,
	pokemon_tipo pt,
	tipo t 
WHERE p.numero_pokedex = pfe.numero_pokedex 
	AND pfe.id_forma_evolucion = fe.id_forma_evolucion 
	AND fe.id_forma_evolucion = p2.id_forma_evolucion 
	AND p2.id_tipo_piedra = tp.id_tipo_piedra 
	AND tp.nombre_piedra = 'Piedra lunar'
	AND p.numero_pokedex = pt.numero_pokedex
	AND pt.id_tipo = t.id_tipo 
GROUP BY t.nombre 

-- pokemon con ataque tipo especial

-- calcula imc pokemon y 

SELECT p.numero_pokedex ,
				p.nombre ,
				p.peso ,
				p.altura ,
				p.peso/(p.altura*p.altura) AS IMC
FROM pokemon p 

-- cuales son los pokemon con sobrepeso

SELECT DISTINCT (p.nombre), p.peso , p.altura , m.*, t.*
FROM pokemon p ,
		pokemon_movimiento_forma pmf ,
		movimiento m ,
		tipo t 
WHERE p.numero_pokedex = pmf.numero_pokedex 
		AND pmf.id_movimiento  = m.id_movimiento 
		AND m.id_tipo = t.id_tipo 
		AND t.nombre  = 'Fuego'
ORDER BY p.peso ASC , p.altura DESC  ;

-- pokemon con ataque impactrueno agrupados por tipo de pokemon

SELECT COUNT(p.numero_pokedex) as total,
	t.nombre ,
	m.nombre 
FROM pokemon p ,
	pokemon_movimiento_forma pmf ,
	movimiento m ,
	pokemon_tipo pt ,
	tipo t 
WHERE p.numero_pokedex = pmf.numero_pokedex 
	AND pmf.id_movimiento = m.id_movimiento 
	AND m.nombre = 'impactrueno'
	AND p.numero_pokedex = pt.numero_pokedex 
	AND pt.id_tipo = t.id_tipo 
GROUP BY t.nombre , m.nombre 
HAVING COUNT(p.numero_pokedex) < 2 ;