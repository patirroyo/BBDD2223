-- esto es un comentario de linea.

/* esto es un comentario
 * multilinea
 * 
 * Las consultas es mejor hacerlas en lineas separadas, aunque se 
 * puede hacer en una sola línea.
 */

SELECT
	c.NOMBRECLIENTE ,
	-- COUNT(c.NOMBRECLIENTE)  -- puedo mostrar todos los campos de clientes poniendo c.*
		-- c.CIUDAD ,
		-- c.APELLIDO2CLIENTE, 
		c.APELLIDO1CLIENTE,
		c.APELLIDO2CLIENTE,
		a.FECHADESCARGA 
FROM Clientes c, Alquileres a  -- la c es el alias, para llamarlo más facil puedo poner lo que quiera.
WHERE c.CIUDAD = 'Zaragoza' -- muestro los clientes que son de Zaragoza 
	AND  c.APELLIDO2CLIENTE LIKE 'g%a'-- Y (AND) que el segundo apellido empiece por g con el operador LIKE, en mySQL este operador es case-INsensitive
	and a.CODIGOCLIENTE = c.CODIGOCLIENTE  -- solo quiero saber los que tienen el mismo código, si no lo pongo obtengo el producto cartesiano 3 x 27
-- O (OR) para que los sume y si pones _ te busca lo que empiece por g y el tamaño total sea 3 letras
ORDER by c.APELLIDO2CLIENTE DESC, -- ordena descendente
	c.APELLIDO1CLIENTE asc;
	


-- 1.	Realiza una consulta que nos muestre los campos Título, FECHAPUBLICACION de todas las películas, ordenado descendentemente por el Título.

SELECT p.TITULO ,
		p.FECHAPUBLICACION 
FROM Peliculas p 
ORDER BY p.TITULO DESC; 

-- 2.	Realiza una consulta que nos muestre los campos Título, FECHAPUBLICACION y Género de todas las películas, ordenando ascendentemente por FECHAPUBLICACION y descendentemente por Género.

SELECT p.TITULO ,
		p.FECHAPUBLICACION ,
		p.GENERO 
FROM Peliculas p 
ORDER BY p.FECHAPUBLICACION ASC ,
		p.GENERO DESC 
		
-- 3.	Realiza una consulta que nos muestre los campos Título, FECHAPUBLICACION, Género y  Tipo de todas las películas, ordenando ascendentemente por Tipo y Título.

SELECT p.TITULO ,
		p.FECHAPUBLICACION ,
		p.GENERO ,
		p.TIPOPELICULA 
FROM Peliculas p 
ORDER BY p.TIPOPELICULA ASC ,
		p.TITULO ASC; 


-- 4.	Realiza una consulta que nos muestre el Título y Género de las 7 últimas películas (en orden alfabético) del género Comedia.

SELECT p.TITULO ,
		p.GENERO 
FROM Peliculas p
ORDER BY p.TITULO DESC 
LIMIT 7;

-- 5.	Realiza una consulta que nos muestre todos los campos de las películas cuyo género sea Drama o Comedia, ordenadas por genero.

SELECT p.*
FROM Peliculas p, Generos g 
WHERE p.GENERO = g.CODIGOGENERO 
	AND  g.NOMBREGENERO  IN ("Drama", "Comedia")
ORDER BY p.GENERO; 


-- 6.	Realiza una consulta que nos muestre todos los campos de las películas cuyo precio esté entre 15 y 16, ordenadas por título.

SELECT *
FROM Peliculas p 
WHERE p.PRECIO BETWEEN 15 AND 16
ORDER BY p.TITULO ;

-- 7.	Realiza una consulta que nos muestre todos los campos de las películas PUBLICADAS en el año 2017.

SELECT *
FROM Peliculas p 
WHERE YEAR (p.FECHAPUBLICACION) = 2017; 


-- 8.	Realiza una consulta que nos muestre todos los campos de las películas PUBLICADAS en el mes de marzo del año 2017.

SELECT *
FROM Peliculas p 
WHERE YEAR (p.FECHAPUBLICACION) = 2017
	AND MONTH (p.FECHAPUBLICACION) = 03;


-- 9.	Realiza una consulta que nos muestre el Título de la película y al lado una columna donde aparezca 'Para niños' si el género es INFANTIL, o que aparezca 'Para adultos' en caso contrario. (El título de la nueva columna se llamará RECOMENDADA).

SELECT p.TITULO ,
		IF (g.NOMBREGENERO = "Infantil", "Para niños", "Para adultos") as RECOMENDADA
FROM Peliculas p, Generos g 
WHERE p.GENERO = g.CODIGOGENERO; 


-- 10.	Realiza una consulta que nos muestre los Títulos de películas que empiezan por M o P.

SELECT  p.TITULO 
FROM Peliculas p 
WHERE p.TITULO LIKE 'm%'
	OR p.TITULO LIKE 'p%';

-- 11.	Realiza una consulta que nos muestre los Títulos de  películas que acaben en la letra S.

SELECT  p.TITULO 
FROM Peliculas p 
WHERE p.TITULO LIKE '%s';


-- 12.	Realiza una consulta que nos muestre los Títulos de  películas que contengan la palabra AMOR.

SELECT  p.TITULO 
FROM Peliculas p 
WHERE p.TITULO LIKE '%amor%'

-- 13.	Realiza una consulta que nos muestre los Títulos y Géneros de  películas que tengan 4 caracteres en su título.

SELECT  p.TITULO,
		g.NOMBREGENERO 
FROM Peliculas p, Generos g 
WHERE p.GENERO = g.CODIGOGENERO  
	AND p.TITULO LIKE '____';

-- 14.	Realiza una consulta que nos muestre los Títulos y Géneros de  películas que tengan 4 caracteres en su título y sean de género Acción.

SELECT  p.TITULO,
		g.NOMBREGENERO 
FROM Peliculas p, Generos g 
WHERE p.GENERO = g.CODIGOGENERO  
	AND p.TITULO LIKE '____'
	AND g.NOMBREGENERO = "Accion";



-- 15.	Realiza una consulta que nos muestre los Títulos de películas que tengan por lo menos (+) un carácter numérico.

SELECT p.TITULO 
FROM Peliculas p
WHERE p.TITULO REGEXP '[0-9]+';
	-- REGEXP = RLIKE

-- 16.	Realiza una consulta que nos muestre los Títulos y la fecha de publicación de las películas que empiezan por alguno de los siguientes caracteres: C,D,E,F,G,H 

SELECT p.TITULO, p.FECHAPUBLICACION 
FROM Peliculas p
WHERE p.TITULO REGEXP '^[C-H]';

-- 17.	Realiza una consulta que nos muestre los Títulos y la fecha de publicación de las películas que empiezan por alguno de los siguientes caracteres: C,D,E,F,G,H,P,Q,R,S,T,U,V

SELECT p.TITULO, p.FECHAPUBLICACION 
FROM Peliculas p
WHERE p.TITULO REGEXP '^[C-H P-V]';

-- 18.	Realiza una consulta que nos muestre los Títulos y la fecha de publicación de las películas que no terminen por alguno de los siguientes caracteres: I,J,K,L,M,N,O,P

SELECT p.TITULO, p.FECHAPUBLICACION 
FROM Peliculas p
WHERE p.TITULO REGEXP '[^I-P]$';


-- 19.	Realiza una consulta que  muestre los Títulos de películas que no contengan la letra a.

SELECT p.TITULO 
FROM Peliculas p
WHERE p.TITULO NOT LIKE "%a%";

/* NOT REGEXP 'a|á'*/

-- 20.	Realiza una consulta que nos muestre los Títulos y el género de las películas cuyo género sea TERROR, COMEDIA, INFANTIL ordenadas ascendentemente por el título.

SELECT p.TITULO , g.NOMBREGENERO 
FROM Peliculas p , Generos g 
WHERE p.GENERO = g.CODIGOGENERO 
	AND g.NOMBREGENERO IN ("TERROR", "COMEDIA", "INFANTIL")
ORDER BY p.TITULO ASC;
	