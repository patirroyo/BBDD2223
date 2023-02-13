-- 60. Mostrar voluntarios de la provincia de Madrid cuya edad supere la media de edades de los voluntarios de Zaragoza.

SELECT v.IdVoluntarios ,
	v.nombre ,
	TIMESTAMPDIFF(YEAR ,v.fNacimiento,CURDATE()) AS Edad,
	p.provincia 
FROM voluntarios v ,
	localidades l ,
	provincias p 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p.idProvincia 
	AND p.provincia = 'Madrid'
	AND TIMESTAMPDIFF(YEAR ,v.fNacimiento,CURDATE()) >
	(
		SELECT AVG(TIMESTAMPDIFF(YEAR ,v.fNacimiento,CURDATE()))
		FROM voluntarios v ,
			localidades l ,
			provincias p 
		WHERE v.idLocalidad = l.idLocalidad 
			AND l.idProvincia = p.idProvincia 
			AND p.provincia = 'Zaragoza'
	);

-- 61. Mostrar voluntarios y edad que superen a todas las edades de los voluntarios de la provincia de Madrid.

SELECT v.IdVoluntarios ,
	v.nombre ,
	TIMESTAMPDIFF(YEAR ,v.fNacimiento,CURDATE()) AS Edad,
	p.provincia 
FROM voluntarios v ,
	localidades l ,
	provincias p 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p.idProvincia 
	AND TIMESTAMPDIFF(YEAR ,v.fNacimiento,CURDATE()) >
	(
		SELECT MAX(TIMESTAMPDIFF(YEAR ,v.fNacimiento,CURDATE()))
		FROM voluntarios v ,
			localidades l ,
			provincias p 
		WHERE v.idLocalidad = l.idLocalidad 
			AND l.idProvincia = p.idProvincia 
			AND p.provincia = 'Madrid'
	);

-- 62. Mostrar voluntarios y altura, que superen el peso más alto de los voluntarios de Barcelona.

EXPLAIN FORMAT=JSON
SELECT v.nombre ,
	v.altura ,
	v.peso 
FROM voluntarios v 
WHERE peso >
(	
	SELECT MAX(v2.peso)
	FROM voluntarios v2 ,
		localidades l ,
		provincias p 
	WHERE v2.idLocalidad = l.idLocalidad 
		AND l.idProvincia = p.idProvincia 
		AND p.provincia = 'Barcelona'
)
ORDER BY v.peso ASC ;
	
-- 63. Mostrar voluntarios y altura cuyo altura sea inferior a cualquier altura de los voluntarios de Burgos.

SELECT v.nombre ,
	v.altura 
FROM voluntarios v 
WHERE v.altura  < ALL -- usamos este operador para comparar un dato con un rango
(	
	SELECT v2.altura -- MIN(v2.altura)
	FROM voluntarios v2 ,
		localidades l ,
		provincias p 
	WHERE v2.idLocalidad = l.idLocalidad 
		AND l.idProvincia = p.idProvincia 
		AND p.provincia = 'Burgos'
)
ORDER BY v.altura  ASC ;

-- 64. Mostrar nombre de voluntarios y altura cuya altura coincida con alturas de voluntarios de Valencia.

SELECT v.nombre ,
		v.altura 
FROM voluntarios v 
WHERE v.altura IN 
(
	SELECT v2.altura 
	FROM voluntarios v2 ,
		localidades l ,
		provincias p 
	WHERE v2.idLocalidad = l.idLocalidad 
		AND l.idProvincia  = p.idProvincia 
		AND p.provincia ='Valencia/València'
);
