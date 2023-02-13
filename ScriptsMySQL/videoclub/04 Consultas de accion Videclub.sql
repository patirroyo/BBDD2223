-- 41. Borrar todos los registros de clientes que residan fuera de Zaragoza.

DELETE FROM Clientes 
WHERE CIUDAD != 'Zaragoza';
ROLLBACK;

-- En modo Commit - manual puedo usar estos comandos:
-- ROLLBACK no confirmo y no se realiza;
-- commit confirmo el script y se realiza;

/*
 * DML data modification language
 * 		una vez que tengo las tablas, las manipulo: 
 * 			insertar, borrar, actualizar FILAS.
 * 		INSERT
 * 		UPDATE
 * 		DELETE
 * 
 * DDL data definition language
 * 		-crear TABLAS, columnas
 * 		CREATE
 * 		ALTER
 * 		DROP
 */


-- 42. Borrar todos los registros de Peliculas cuyo precio sea inferior a 15 €.

DELETE FROM Peliculas p
WHERE p.PRECIO < 15;

-- 43. Borrar todos los registros de películas que empiecen por H.

DELETE FROM Peliculas
WHERE TITULO LIKE 'H%';


-- 44. Borrar todos los registros de películas cuya modalidad sea ESTRENO
DELETE p.*
FROM Peliculas AS p,
     Tipopeliculas AS tp
WHERE p.CODIGOPELICULA = tp.CODIGOENTREGA
    AND tp.MODALIDAD = 'Estreno';

-- 45. Borrar todos los registros de películas del género de TERROR

DELETE p.* FROM Peliculas AS p INNER JOIN Generos AS g
ON p.GENERO = g.CODIGOGENERO
AND g.NOMBREGENERO ='Terror';


-- 46. Borrar todos los registros de películas cuyo género sea AVENTURAS y hayan sido adquiridas en el año 98

DELETE p.*
FROM Peliculas AS p,
     Generos AS g,
     Alquileres AS a
WHERE p.GENERO = g.CODIGOGENERO
    AND p.CODIGOPELICULA = a.CODIGOPELICULA
    AND g.NOMBREGENERO = 'Aventuras'
    AND YEAR(a.FECHADESCARGA) = 1998;

-- 47. Añadir un registro nuevo en Generos cuyo numero sea 14 y se denomine DOCUMENTAL

INSERT INTO Generos(CODIGOGENERO, NOMBREGENERO)
    VALUES(14, 'Documental');

-- 48. Añadir un registro nuevo en la tabla de clientes cuya información corresponda a vuestros datos personales.

INSERT INTO Clientes(NOMBRECLIENTE, APELLIDO1CLIENTE, APELLIDO2CLIENTE)
	VALUES('Alberto', 'Saz', 'Simón');


-- 49. Crear una tabla vacía (llamada CopiaGeneros) con los mismos campos de la tabla de Generos. Traspasar toda la información de Generos a CopiaGeneros.

CREATE TABLE CopiaGeneros(
	CODIGOGENERO integer not null,
	nombregenero varchar(100)
	)	AS /*optativo*/	SELECT g.CODIGOGENERO , g.NOMBREGENERO
			FROM Generos g ;
		
/* 
 CREATE TABLE CopiaGeneros LIKE Generos; Crea la tabla con la estructura idéntica, pero faltan los insert
 * 
 * para arreglarlo:
 * 
INSERT  INTO CopiaGeneros SELECT * FROM Generos ;
*/
		
		
-- 50. Eliminar los registros de la tabla de CopiaGeneros cuyo nombre comience por C

DELETE FROM CopiaGeneros c
WHERE c.nombregenero LIKE 'C%';

-- 51. Añadir a la tabla CopiaGeneros los registros de Generos cuyo nombre comience por C

INSERT INTO CopiaGeneros
SELECT *
FROM Generos g
WHERE g.NOMBREGENERO LIKE 'C%';


-- 52. Crear una tabla vacía (llamada Infantiles) con los mismos campos de la tabla de Peliculas. Traspasar todos los registros de la tabla Peliculas a la tabla Infantiles, que tengan como genero Infantil, Aventuras, Ciencia-ficción

CREATE TABLE Infantiles LIKE Peliculas;
INSERT INTO Infantiles(
	SELECT p.*
	FROM Peliculas p , Generos g 
	WHERE p.GENERO  = g.CODIGOGENERO 
		AND g.NOMBREGENERO IN ('Infantil', 'Aventuras', 'Ciencia-ficcion')
	);

-- 53. Dividir la tabla de clientes en dos tablas llamadas Capital y Provincias con la misma estructura, en la primera guardaremos todos los registros de clientes que sean de Zaragoza y en Provincias el resto.

CREATE TABLE Capital LIKE Clientes;
CREATE TABLE Provincias LIKE Clientes;
INSERT INTO Capital
    SELECT c.*
    FROM Clientes c
    WHERE c.CIUDAD = 'Zaragoza';
INSERT INTO Provincias
    SELECT c.*
    FROM Clientes c
    WHERE c.CIUDAD != 'Zaragoza';

-- 54. Modificar el campo de Codigo Postal de la tabla de clientes para que a todos les aparezca 50900

UPDATE Clientes c
SET c.CODIGOPOSTAL = 50900;


-- 55. Modificar el campo de Observaciones de la tabla de clientes para que a todos les ponga un CODIGO formado por 3 caracteres de la izda del nombre + los 2 ultimos del 2 apellido+ 3 digitos centrales del telefono

UPDATE Clientes c
    SET c.OBSERVACIONES = CONCAT_WS('', LEFT(c.NOMBRECLIENTE, 3),
                                RIGHT(c.APELLIDO2CLIENTE, 2),
                                CAST(MID(c.TELEFONO, 4, 3) AS CHAR));


-- 56. Modificar el campo de Observaciones de la tabla de clientes para que a todos los que se dieron de alta en el mes de Abril del 99 les aparezca el mensaje de BONIFICADO

UPDATE Clientes c
SET c.OBSERVACIONES = 'Bonificado'
WHERE YEAR (c.FECHALTA) = 1999 
	AND MONTH (c.FECHALTA) = 4; 
		

-- 57. Modificar el campo de Ciudad de la tabla de clientes para que todos los que residan en Zaragoza les aparezca la ciudad en mayúsculas.

UPDATE Clientes c
SET c.CIUDAD = UPPER(c.CIUDAD)
WHERE c.CIUDAD = 'Zaragoza';

-- 58. Modificar el título de películas para que en todas que empiecen por R les aparezca  --- -

UPDATE Peliculas p
SET p.TITULO = '-----'
WHERE p.TITULO LIKE 'R%';

-- 59. Incrementar el precio de cada película un cinco por ciento.

UPDATE Peliculas
SET PRECIO = PRECIO*1.05;


-- 60. Acentuar el apellido de López en la tabla de Clientes.

UPDATE Clientes
SET APELLIDO1CLIENTE = 'López'
WHERE APELLIDO1CLIENTE = 'Lopez';
UPDATE Clientes
SET APELLIDO2CLIENTE = 'López'
WHERE APELLIDO2CLIENTE = 'Lopez';