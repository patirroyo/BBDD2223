-- 21 Realiza una consulta que nos agrupe las películas por género.

SELECT 
			g.NOMBREGENERO,
			COUNT(p.TITULO) as TOTAL_TITULOS
FROM Peliculas p ,
			Generos g 
WHERE p.GENERO  = g.CODIGOGENERO 
GROUP BY 	g.NOMBREGENERO  ;

-- 22. Realiza una consulta que nos muestre cuantas películas existen de cada género. (Mostrar como título de columna TOTAL PELICULAS) también agrupar por precio

SELECT g.NOMBREGENERO,
			p.PRECIO, 
		COUNT(p.TITULO) as TOTAL_PELICULAS				  
FROM Peliculas p ,
			Generos g 
WHERE p.GENERO = g.CODIGOGENERO 
GROUP BY g.NOMBREGENERO, p.PRECIO;

-- 23. Realiza una consulta que nos muestre cuantas películas existen de cada género y nos muestre aquellos que superen 10 películas (Mostrar como título de columna TOTAL PELICULAS)

SELECT g.NOMBREGENERO,
		COUNT(p.TITULO) as TOTAL_TITULOS				  
FROM Peliculas p ,
			Generos g 
WHERE p.GENERO = g.CODIGOGENERO
GROUP BY g.NOMBREGENERO
HAVING TOTAL_TITULOS > 10; -- solo los que tengan más de 10

-- 24. Realiza una consulta que nos muestre cuantas películas existen de los géneros INFANTIL y MUSICAL. (Mostrar como título de columna TOTAL PELICULAS)

SELECT g.NOMBREGENERO,
		COUNT(p.TITULO) as TOTAL_PELICULAS				  
FROM Peliculas p ,
			Generos g 
WHERE p.GENERO = g.CODIGOGENERO
		AND g.NOMBREGENERO IN ('Infantil', 'Musical')
GROUP BY g.NOMBREGENERO;

-- 25. Realiza una consulta que nos agrupe las películas por fecha de publicación.

SELECT 	p.FECHAPUBLICACION 
FROM Peliculas p 
GROUP BY 	p.FECHAPUBLICACION;

-- 26. Realiza una consulta que nos muestre cuantas películas existen de cada fecha de publicación . (Mostrar como título de columna TOTAL PELICULAS)

SELECT 	p.FECHAPUBLICACION ,
			COUNT(p.TITULO) as TOTAL_PELICULAS
FROM Peliculas p 
GROUP BY 	p.FECHAPUBLICACION;

-- 27. Realiza una consulta que nos muestre cuantas películas existen de cada fecha de publicación mostrando sólo aquellas fechas que tengan 1 película. (Mostrar como título de columna TOTAL PELICULAS)

SELECT COUNT(p.TITULO) AS TOTAL_PELICULAS,
			p.FECHAPUBLICACION 
FROM Peliculas p 
GROUP BY p.FECHAPUBLICACION 
HAVING TOTAL_PELICULAS = 1; 

-- 28. Realiza una consulta que nos agrupe las películas por genero y fecha de publicación.

SELECT p.FECHAPUBLICACION,
			g.NOMBREGENERO 
FROM Peliculas p ,
			Generos g 
WHERE p.GENERO = g.CODIGOGENERO 
GROUP BY g.NOMBREGENERO, p.FECHAPUBLICACION ;


-- 29. Realiza una consulta que nos muestre cuantas películas existen de cada género y fecha de publicación. (Mostrar como título de columna TOTAL PELICULAS)

SELECT COUNT(p.TITULO) AS TOTAL_PELICULAS,
			p.FECHAPUBLICACION,
			g.NOMBREGENERO 
FROM Peliculas p ,
			Generos g 
WHERE p.GENERO = g.CODIGOGENERO 
GROUP BY g.NOMBREGENERO, p.FECHAPUBLICACION
ORDER BY TOTAL_PELICULAS DESC;


-- 30. Añadir a la consulta anterior, la suma del precio. (Mostrar como título de columna TOTAL)

SELECT COUNT(p.TITULO) AS TOTAL_PELICULAS,
			SUM(p.PRECIO) AS TOTAL, 
			p.FECHAPUBLICACION,
			g.NOMBREGENERO 
FROM Peliculas p ,
			Generos g 
WHERE p.GENERO = g.CODIGOGENERO 
GROUP BY p.FECHAPUBLICACION , g.NOMBREGENERO ;

-- 31. Realiza una consulta que nos muestre el sumatorio de los precios de las películas publicadas en el año 2017 y al lado el sumatorio de los precios con un incremento del 21% de IVA . (Mostrar como título de columnas TOTAL AÑO 2017 y TOTAL AÑO 2017 con IVA)

SELECT SUM(p.PRECIO) AS TOTAL_AÑO_2017,
				SUM(p.PRECIO)*1.21  AS TOTAL_AÑO_2017_con_IVA
FROM Peliculas p 
WHERE YEAR(p.FECHAPUBLICACION) = 2017;

-- 32. Realiza una consulta que nos muestre por cada fecha de publicación, el promedio de los precios de las películas. (Mostrar como título de columna PROMEDIO)

SELECT p.FECHAPUBLICACION, 
				AVG(p.PRECIO) 
FROM Peliculas p 
GROUP BY p.FECHAPUBLICACION ;

-- 33. Realiza una consulta que nos muestre de cada tipo de película la primera y la última fecha de publicación.

SELECT COUNT(p.TITULO) AS TOTAL,
			t.MODALIDAD  ,
			p.TIPOPELICULA ,
			MIN(p.FECHAPUBLICACION),
			MAX(p.FECHAPUBLICACION) 
FROM Peliculas p ,
			Tipopeliculas t 
WHERE p.TIPOPELICULA = t.CODIGOENTREGA 
GROUP BY t.MODALIDAD , p.TIPOPELICULA  ;

-- 34. Realiza una consulta que nos muestre por cada género, el precio más barato, el precio más caro y el promedio de precios de las películas.

SELECT g.NOMBREGENERO ,
			MIN(p.PRECIO),
			MAX(p.PRECIO) ,
			AVG(p.PRECIO) 
FROM Peliculas p ,
		 	Generos g 
WHERE p.GENERO  = g.CODIGOGENERO  
GROUP BY g.NOMBREGENERO  ;

-- SHOW COLLATION;
