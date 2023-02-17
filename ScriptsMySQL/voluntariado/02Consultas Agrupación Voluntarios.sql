-- 41. Cantidad de personas de cada país.

SELECT p2.pais  ,
			COUNT( v.IdVoluntarios) 
FROM voluntarios v ,
			localidades l ,
			provincias p ,
			paises p2 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p.idProvincia 
	AND p.idPais = p2.idPais
GROUP BY p2.pais  ; 

-- 42. Cantidad de personas de las diferentes provincias de España.

-- explain analyze format=tree
SELECT p.provincia ,
			COUNT(v.IdVoluntarios) -- el Distinct es una de las causas de las consultas lentas
FROM voluntarios v ,
			localidades l ,
			provincias p ,
			paises p2 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p.idProvincia 
	AND p.idPais = p2.idPais
	AND p2.pais = 'España'
GROUP BY p.provincia
ORDER BY p.provincia;

-- 43. Cantidad de personas de las tres provincias de Aragón.

SELECT p.provincia ,
			COUNT(v.IdVoluntarios) 
FROM voluntarios v ,
			localidades l ,
			provincias p 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p.idProvincia 
	AND p.provincia IN ('Zaragoza', 'Huesca', 'Teruel')
GROUP BY p.provincia ;

-- 44. Cantidad de personas de las diferentes poblaciones de Huesca.

SELECT l.localidad  ,
			COUNT(v.IdVoluntarios) 
FROM voluntarios v ,
			localidades l ,
			provincias p 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p.idProvincia 
	AND p.provincia = 'Huesca'
GROUP BY l.localidad ;

-- 45.
	-- a. Cantidad de personas que se llaman igual.

SELECT v.nombre ,
		COUNT(v.IdVoluntarios) AS Total
FROM voluntarios v 
GROUP BY v.nombre
ORDER BY Total DESC;

	-- b. Nombre que más se repite

SELECT v.nombre ,
		COUNT(v.IdVoluntarios) AS Total
FROM voluntarios v 
GROUP BY v.nombre
ORDER BY Total DESC 
LIMIT 1;

	-- c. Nombre que se repiten entre 5 y 10 veces
SELECT v.nombre ,
		COUNT(v.IdVoluntarios) AS Total
FROM voluntarios v 
GROUP BY v.nombre
HAVING Total BETWEEN 5 AND 10 
ORDER BY Total DESC;


-- 46. Cantidad de personas por edades.

SELECT TIMESTAMPDIFF(YEAR , v.fNacimiento, CURTIME()) AS Edad,
		COUNT(v.IdVoluntarios) AS Total
FROM voluntarios v 
GROUP BY Edad
ORDER BY Edad ASC;

-- 47. Cantidad de personas por tallas.

SELECT v.talla ,
	COUNT(v.IdVoluntarios) AS Total
FROM voluntarios v 
GROUP BY v.talla 
ORDER BY Total DESC;

-- 48. Cantidad de personas por profesion.

SELECT l.labor  ,
				COUNT(v.IdVoluntarios) AS Total
FROM voluntarios v ,
			laboral l 
WHERE v.idLabor = l.IdLabor 
GROUP BY l.labor 
ORDER BY Total DESC;

-- 49. Cantidad de personas por sexo.

SELECT vo.Sexo ,
			COUNT(vo.Idvoluntario) AS Total 
FROM Voluntarios_OLD vo 
GROUP BY vo.Sexo 
ORDER BY Total DESC;

-- 50. Cantidad de personas nacidas en cada mes.

SELECT MONTH (v.fNacimiento) AS Mes,
			MONTHNAME(v.fNacimiento) AS NombreMes ,
			COUNT(v.IdVoluntarios) AS Total 
FROM voluntarios v 
GROUP BY Mes, NombreMes
ORDER BY Mes;


-- 51. Cantidad de personas nacidas en cada trimestre.

SELECT COUNT(v.IdVoluntarios) AS Total,
	QUARTER(v.fNacimiento) AS Trimestre
FROM voluntarios v 
GROUP BY Trimestre;

-- 52. Cantidad de personas nacidas en cada trimestre, pero solo de aquellos trimestres que tengan más de 110 personas.

SELECT QUARTER(v.fNacimiento) AS Trimestre,
	COUNT(v.IdVoluntarios) AS Total
FROM voluntarios v 
GROUP BY Trimestre
HAVING Total > 110
ORDER BY Trimestre;


-- 53. Cantidad de personas de los diferentes niveles de italiano hablado.

SELECT n.hablado ,
	COUNT(v.IdVoluntarios) AS Total 
FROM voluntarios v ,
		idiomas i ,
		nivel n 
WHERE v.IdVoluntarios = n.IdVoluntario 
	AND n.IdIdioma = i.Ididioma 
	AND i.idioma = 'Italiano'
GROUP BY n.hablado
HAVING n.hablado != '';
			

-- 54. Cantidad de personas de los diferentes niveles de frances hablado

SELECT n.hablado ,
	COUNT(v.IdVoluntarios) AS Total 
FROM voluntarios v ,
		idiomas i ,
		nivel n 
WHERE v.IdVoluntarios = n.IdVoluntario 
	AND n.IdIdioma = i.Ididioma 
	AND i.idioma = 'Frances'
GROUP BY n.hablado
HAVING n.hablado != '';

-- 55. Cantidad de personas de los diferentes niveles de ingles hablado.

SELECT n.hablado ,
	COUNT(v.IdVoluntarios) AS Total 
FROM voluntarios v ,
		idiomas i ,
		nivel n 
WHERE v.IdVoluntarios = n.IdVoluntario 
	AND n.IdIdioma = i.Ididioma 
	AND i.idioma = 'Ingles'
GROUP BY n.hablado
HAVING n.hablado in ('Medio', 'Alto', 'Bajo');

-- 56. Cantidad de personas de los diferentes niveles de ingles hablado y por edades.

SELECT TIMESTAMPDIFF(YEAR , v.fNacimiento, CURTIME()) AS Edad,
			n.hablado ,
	COUNT(v.IdVoluntarios) AS Total 
FROM voluntarios v ,
		idiomas i ,
		nivel n 
WHERE v.IdVoluntarios = n.IdVoluntario 
	AND n.IdIdioma = i.Ididioma 
	AND i.idioma = 'Ingles'
GROUP BY n.hablado, Edad
HAVING Edad != ''
ORDER BY Edad, n.hablado; 


-- 57. Promedio de edades, Más viejo, Más Joven

SELECT AVG(TIMESTAMPDIFF(YEAR , v.fNacimiento, CURTIME())) AS Media,
	 MAX(TIMESTAMPDIFF(YEAR , v.fNacimiento, CURTIME()))AS Viejo,
	 MIN(TIMESTAMPDIFF(YEAR , v.fNacimiento, CURTIME())) AS Joven
FROM voluntarios v ;
		
-- 58. Promedio de edades de cada provincia.

SELECT p.provincia, 
	AVG(TIMESTAMPDIFF(YEAR , v.fNacimiento, CURTIME())) AS Media
FROM voluntarios v,
	provincias p ,
	localidades l 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p.idProvincia 
GROUP BY p.provincia 
ORDER BY Media DESC;

-- 59. Edad de la persona más viejo y más joven de cada pais.

SELECT p.pais ,
	MAX(TIMESTAMPDIFF(YEAR , v.fNacimiento, CURTIME()))AS Viejo,
	MIN(TIMESTAMPDIFF(YEAR , v.fNacimiento, CURTIME())) AS Joven
FROM voluntarios v ,
	paises p ,
	provincias p2 ,
	localidades l 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p2.idProvincia 
	AND p2.idPais = p.idPais 
GROUP BY p.pais 
ORDER BY p.pais ASC ;

/*Para realizar en la tabla voluntarios_OLD, tiene más paises
 * 
 * SELECT vo.Pais ,
	MAX(TIMESTAMPDIFF(YEAR , vo.FechaNacimiento, CURTIME())) AS Viejo,
	 MIN(TIMESTAMPDIFF(YEAR , vo.FechaNacimiento, CURTIME())) AS Joven
FROM Voluntarios_OLD vo 
GROUP BY vo.pais 
ORDER BY viejo DESC ;*/
	


