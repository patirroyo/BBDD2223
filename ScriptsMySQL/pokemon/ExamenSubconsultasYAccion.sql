/*Busca el top 10 pokemon que tengas mas puntos de salud que la salud del pokemon mas pequeño de altura */

SELECT p.numero_pokedex,
        p.nombre,
        eb.ps
FROM pokemon p,
    estadisticas_base eb
WHERE p.numero_pokedex = eb.numero_pokedex
    AND eb.ps >
                (SELECT eb2.ps
                FROM pokemon p2,
                    estadisticas_base eb2
                WHERE p2.numero_pokedex = eb2.numero_pokedex
                ORDER BY p2.altura ASC
                LIMIT 1
                )
ORDER BY eb.ps DESC
LIMIT 10;

/*Dime cuantos pokemon que evolucionan mediante piedra, y no son de tipo piedra tienen una defensa superior a la media de los pokemon de tipo piedra ordenados por estadistica de defensa*/

SELECT p.numero_pokedex,
        p.nombre, eb.defensa,
        t.nombre,
        te.tipo_evolucion
FROM pokemon p,
    pokemon_forma_evolucion pfe,
    forma_evolucion fe,
    tipo_evolucion te,
    pokemon_tipo pt,
    tipo t,
    estadisticas_base eb
WHERE p.numero_pokedex = pfe.numero_pokedex
    AND pfe.id_forma_evolucion = fe.id_forma_evolucion
    AND fe.tipo_evolucion = te.id_tipo_evolucion
    AND te.tipo_evolucion = 'piedra'
    AND p.numero_pokedex = pt.numero_pokedex
    AND pt.id_tipo = t.id_tipo
    AND t.nombre != 'roca'
    AND p.numero_pokedex = eb.numero_pokedex
    AND eb.defensa >
                    (SELECT AVG(eb2.defensa)
                    FROM pokemon p2,
                        pokemon_tipo pt2,
                        tipo t2,
                        estadisticas_base eb2
                    WHERE p2.numero_pokedex = pt2.numero_pokedex
                        AND pt2.id_tipo = t2.id_tipo
                        AND p2.numero_pokedex = eb2.numero_pokedex
                        AND t2.nombre = 'roca'
                    )
ORDER BY eb.defensa;

/*Dime cuantos pokemon que no evolucionan con piedra pesan más que cualquiera de los pokemon que evolucionan mediante piedra.*/

SELECT COUNT(p.numero_pokedex)
FROM pokemon p,
    pokemon_forma_evolucion pfe,
    forma_evolucion fe,
    tipo_evolucion te
WHERE p.numero_pokedex = pfe.numero_pokedex
    AND pfe.id_forma_evolucion = fe.id_forma_evolucion
    AND fe.tipo_evolucion = te.id_tipo_evolucion
    AND te.tipo_evolucion != 'piedra'
    AND p.peso > ALL (SELECT p.peso
                    FROM pokemon p,
                        pokemon_forma_evolucion pfe,
                        forma_evolucion fe,
                        tipo_evolucion te
                    WHERE p.numero_pokedex = pfe.numero_pokedex
                        AND pfe.id_forma_evolucion = fe.id_forma_evolucion
                        AND fe.tipo_evolucion = te.id_tipo_evolucion
                        AND te.tipo_evolucion = 'piedra');

/*Dime los elementos que tienen mas movimientos distintos que la media de los movimientos de cada tipo de elemento*/

SELECT t.nombre,
        COUNT(DISTINCT (m.id_movimiento)) AS movimientos_diferentes
FROM pokemon p,
    pokemon_movimiento_forma pmf,
    movimiento m,
    pokemon_tipo pt,
    tipo t
WHERE p.numero_pokedex = pmf.numero_pokedex
    AND pmf.id_movimiento = m.id_movimiento
    AND p.numero_pokedex = pt.numero_pokedex
    AND pt.id_tipo = t.id_tipo
GROUP BY t.nombre
HAVING movimientos_diferentes >
            (SELECT AVG(movis)
            FROM (
                SELECT COUNT(DISTINCT (m2.id_movimiento)) AS movis
                FROM pokemon p2,
                    pokemon_movimiento_forma pmf2,
                    movimiento m2,
                    pokemon_tipo pt2,
                    tipo t2
                WHERE p2.numero_pokedex = pmf2.numero_pokedex
                    AND pmf2.id_movimiento = m2.id_movimiento
                    AND p2.numero_pokedex = pt2.numero_pokedex
                    AND pt2.id_tipo = t2.id_tipo
                GROUP BY t2.nombre
                ) as media
        );



/*Dime los 5 pokemon de tipo roca que son mas altos que la media de los pokemon de tipo rayo ordenalos por altura y después por peso*/

SELECT DISTINCT p.numero_pokedex, p.nombre, p.altura, p.peso, t.nombre
FROM pokemon p,
    pokemon_tipo pt,
    tipo t
WHERE p.numero_pokedex = pt.numero_pokedex
    AND pt.id_tipo = t.id_tipo
    AND t.nombre = 'roca'
    AND p.altura > (SELECT *
                    FROM (
                        SELECT AVG(p2.altura)
                        FROM pokemon p2,
                            pokemon_tipo pt2,
                            tipo t2
                        WHERE p2.numero_pokedex = pt2.numero_pokedex
                            AND pt2.id_tipo = t2.id_tipo
                            AND t2.nombre = 'electrico'
                        GROUP BY t2.nombre) AS media
                    )
ORDER BY p.altura DESC, p.peso
LIMIT 5;

-- Consultas Accion
-- SET FOREIGN_KEY_CHECKS = 0;
-- SET FOREIGN_KEY_CHECKS = 1;

/*Actualiza los pokemon de tipo roca,tierra y planta para que: resta 10 puntos de salud a su estadistica base(solo a los 10 primeros pokemon con mayor numero de ps)*/

UPDATE estadisticas_base
SET ps = ps-10
WHERE numero_pokedex IN (
    SELECT numero_pokedex
    FROM (SELECT DISTINCT p.numero_pokedex
        FROM estadisticas_base eb,
            pokemon p,
            pokemon_tipo pt,
            tipo t
        WHERE eb.numero_pokedex = p.numero_pokedex
            AND p.numero_pokedex = pt.numero_pokedex
            AND pt.id_tipo = t.id_tipo
            AND t.nombre IN ('roca', 'tierra', 'planta')
        ) AS eb
);


/*Actualiza a 10 pokemon que evolucionan mediante piedra agua para que ahora lo hagan mediante piedra fuego*/

UPDATE pokemon_forma_evolucion
SET id_forma_evolucion = (SELECT p.id_forma_evolucion
                            FROM piedra p,
                                tipo_piedra tp
                            WHERE p.id_tipo_piedra = tp.id_tipo_piedra
                                AND tp.nombre_piedra = 'Piedra fuego')
WHERE id_forma_evolucion = (SELECT p2.id_forma_evolucion
                            FROM piedra p2,
                                tipo_piedra tp2
                            WHERE p2.id_tipo_piedra = tp2.id_tipo_piedra
                                AND tp2.nombre_piedra = 'Piedra agua')
LIMIT 10;

/*Borra los pokemon que evolucionan mediante intercambio*/

DELETE
FROM pokemon
WHERE numero_pokedex IN (SELECT numero_pokedex
                        FROM (
                            SELECT p.numero_pokedex
                            FROM pokemon p,
                                pokemon_forma_evolucion pfe,
                                forma_evolucion fe,
                                tipo_evolucion te
                            WHERE p.numero_pokedex = pfe.numero_pokedex
                                AND pfe.id_forma_evolucion = fe.id_forma_evolucion
                                AND fe.tipo_evolucion = te.id_tipo_evolucion
                                AND te.tipo_evolucion = 'intercambio') AS t);

/*Borra los movimientos con una ataque superior a 50 que como efecto secundario bajen alguna estadistica(ataque,desfensa,especia....)*/



DELETE
FROM movimiento
WHERE id_movimiento IN (SELECT id_movimiento
                        FROM (
                            SELECT m.id_movimiento
                            FROM movimiento m,
                                movimiento_efecto_secundario mes,
                                efecto_secundario es
                            WHERE m.id_movimiento = mes.id_movimiento
                                AND mes.id_efecto_secundario = es.id_efecto_secundario
                                AND es.efecto_secundario LIKE 'Baja%'
                            ) AS t
                        );

/*crea una tabla nueva llamada pesos_pesados que contenga la información completa de los 10 pokemon de mayor peso y su tipo */

CREATE TABLE pesos_pesados(
    numero_pokedex integer not null primary key,
    nombre varchar(15),
    peso double,
    altura double,
    tipo varchar(10));

INSERT INTO pesos_pesados(numero_pokedex, nombre, peso, altura)
SELECT DISTINCT p.numero_pokedex,
        p.nombre,
        p.peso,
        p.altura
FROM pokemon p
ORDER BY peso DESC
LIMIT 10;

UPDATE pesos_pesados
SET tipo =
    (SELECT nombre
    FROM (SELECT DISTINCT t.nombre
            FROM pokemon p,
                pokemon_tipo pt,
                tipo t
            WHERE p.numero_pokedex = pt.numero_pokedex
                AND pt.id_tipo = t.id_tipo
                AND pesos_pesados.numero_pokedex = p.numero_pokedex
            LIMIT 1
            ) as tip
    );



