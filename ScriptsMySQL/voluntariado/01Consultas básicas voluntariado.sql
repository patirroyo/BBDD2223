-- 1.	Extranjeros que vienen al FOJE
SELECT v.IdVoluntarios, v.nombre, l.localidad 
FROM voluntarios v, localidades l  
WHERE v.idLocalidad = l.idLocalidad 
	AND l.localidad = "Extranjera";

-- 2.	Personas de fuera de Aragón 
SELECT v.IdVoluntarios, v.nombre, p.provincia  
FROM voluntarios v, localidades l, provincias p  
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia  = p.idProvincia 
	AND p.provincia NOT IN ("Huesca", "Zaragoza", "Teruel");

-- 3.	Personas de Jaca
SELECT v.IdVoluntarios, v.nombre, l.localidad 
FROM voluntarios v , localidades l 
WHERE v.idLocalidad = l.idLocalidad
	AND l.localidad = "Jaca";

-- 4.	Personas que no tengan alojamiento durante el FOJE
SELECT v.IdVoluntarios, v.nombre, v.alojamiento  
FROM voluntarios v 
WHERE v.alojamiento != "true";

-- 5.	Personas entre 18 y 25 años que pesen más de 70Kg y lleven la talla M o L
SELECT v.IdVoluntarios ,
		v.nombre ,
		v.fNacimiento, 
		TIMESTAMPDIFF(YEAR,v.fNacimiento,CURDATE()) AS 'edad',
		v.peso ,
		v.talla 
FROM voluntarios v 
WHERE TIMESTAMPDIFF(YEAR,v.fNacimiento,CURDATE()) BETWEEN 18 and 25
 	AND v.peso > 70
	AND v.talla IN ("M", "L");

-- 6.	Personas entre 26 y 40 años de Zaragoza  o Personas entre 41 y 55 años de huesca

SELECT v.IdVoluntarios ,
		v.nombre ,
		TIMESTAMPDIFF(YEAR,v.fNacimiento,CURDATE()) AS edad,
		p.provincia 
FROM voluntarios v , localidades l , provincias p 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p.idProvincia 
	AND ((TIMESTAMPDIFF(YEAR,v.fNacimiento,CURDATE()) BETWEEN 26 AND 40
			AND p.provincia = "Zaragoza")
		OR (TIMESTAMPDIFF(YEAR,v.fNacimiento,CURDATE()) BETWEEN 41 AND 55
			AND p.provincia = "Huesca"));

-- 7.	Personas mayores a 55 años
		
SELECT v.IdVoluntarios ,
		v.nombre ,
		TIMESTAMPDIFF(YEAR,v.fNacimiento,CURDATE()) AS edad
FROM voluntarios v 
WHERE TIMESTAMPDIFF(YEAR,v.fNacimiento,CURDATE()) > 55;

-- 8.	Personas con una talla XXL y cuya altura sea inferior a 175cm

SELECT v.IdVoluntarios ,
		v.nombre ,
		v.talla ,
		v.altura 
FROM voluntarios v
WHERE v.talla = "XXL"
	AND v.altura < 175;

-- 9.	Personas estudiantes con nivel ALTO en informatica

SELECT v.IdVoluntarios ,
		v.nombre ,
		v.nivelInformatica 
FROM voluntarios v 
WHERE v.nivelInformatica LIKE "%alto%";
		
-- 10.	Personas estudiantes con un nivel ALTO en ingles hablado y escrito

SELECT v.IdVoluntarios ,
		v.nombre ,
		i.idioma ,
		n.hablado ,
		n.escrito 
FROM voluntarios v ,
	nivel n ,
	idiomas i 
WHERE v.IdVoluntarios = n.IdVoluntario 
	AND i.Ididioma = n.IdIdioma 
	AND i.idioma = 'Inglés'
	AND n.hablado = 'Alto'
	AND n.escrito = 'Alto';

-- 11.	Personas jubiladas con un nivel ALTO en frances hablado y escrito o con un nivel ALTO en inglés hablado y escrito

SELECT v.IdVoluntarios ,
				v.nombre ,
				i.idioma ,
				n.hablado ,
				n.escrito,
				l.labor 
FROM voluntarios v ,
			nivel n ,
			idiomas i,
			laboral l 
WHERE v.IdVoluntarios = n.IdVoluntario 
	AND i.Ididioma = n.IdIdioma 
	AND i.idioma IN ('Inglés', 'Francés')
	AND n.hablado = 'Alto'
	AND n.escrito = 'Alto'
	AND v.idLabor = l.IdLabor 
	AND l.labor IN ('Jubilado', 'Prejubilado');

-- 12.	Personas que practiquen esquí en cualquiera de sus modalidades

SELECT v.IdVoluntarios ,
				v.nombre ,
				d.deporte 
FROM voluntarios v ,
			deportes d ,
			practicar p 
WHERE v.IdVoluntarios = p.IdVoluntarios 
	AND d.IdDeporte = p.IdDeportes 
	AND d.deporte LIKE 'Esqui%';

-- 13.	Personas que cumplen años hoy

SELECT v.IdVoluntarios ,
		v.nombre ,
		v.fNacimiento
FROM voluntarios v 
WHERE MONTH (v.fNacimiento ) = MONTH ( CURDATE()) 
			AND DAY(v.fNacimiento ) = DAY (CURDATE()) ;

-- 14.	Personas que cumplen años en el mes de diciembre

		SELECT v.IdVoluntarios ,
		v.nombre ,
		v.fNacimiento
FROM voluntarios v 
WHERE MONTH (v.fNacimiento ) = 12 ;
		
		
-- 15.	Personas que cumplen años en invierno

SELECT v.IdVoluntarios ,
		v.nombre ,
		v.fNacimiento
FROM voluntarios v 
WHERE (MONTH (v.fNacimiento ) = 12
		AND DAY (v.fNacimiento ) >= 21)
	OR MONTH (v.fNacimiento ) IN (1,2)
	OR (MONTH (v.fNacimiento ) = 3
		AND DAY (v.fNacimiento ) <= 20);

-- 16.	Personas que cumplen años en el primer trimestre del año
	
SELECT v.IdVoluntarios ,
		v.nombre ,
		v.fNacimiento
FROM voluntarios v 
WHERE QUARTER(v.fNacimiento ) = 1;
	
-- 17.	Personas que tengan preferencia 1 en tareas de informática o preferencia 1 en tareas de conducción

SELECT v.IdVoluntarios ,
		v.nombre ,
		t.nombre 
FROM voluntarios v,
			preferencias p ,
			tareas t 
WHERE v.IdVoluntarios = p.IdVoluntario 
	AND p.IdTarea = t.IdTarea 
	AND p.Preferencia = 1
	AND t.nombre IN ('informática', 'conducción') ;

-- 18.	Personas  que tengan preferencia 1 en tareas de interprete y que tengan un nivel hablado alto en cualquiera de los idiomas

SELECT v.IdVoluntarios ,
		v.nombre ,
		t.nombre ,
		p.Preferencia,
		i.idioma ,
		n.hablado 
FROM voluntarios v,
			preferencias p ,
			tareas t ,
			nivel n  ,
			idiomas i 
WHERE v.IdVoluntarios = p.IdVoluntario
	AND p.IdTarea = t.IdTarea 
	AND v.IdVoluntarios = n.IdVoluntario 
	AND n.IdIdioma = i.Ididioma 
	AND p.Preferencia = 1
	AND t.nombre = 'interprete' 
	AND n.hablado = 'alto';

-- 19.	Personas que tengan preferencia 1 en tareas de informatica y tengan un nivel medio o alto en informatica

SELECT v.IdVoluntarios ,
		v.nombre ,
		t.nombre ,
		p.Preferencia,
		v.nivelInformatica 
FROM voluntarios v,
			preferencias p ,
			tareas t 
WHERE v.IdVoluntarios = p.IdVoluntario 
	AND p.IdTarea = t.IdTarea 
	AND p.Preferencia = 1
	AND t.nombre = 'informática' 
	AND v.nivelInformatica  IN ('alto', 'medio');

-- 20.	Personas que tengan preferencia 1 en tareas de conducción, tengan un nivel medio o alto de ingles hablado, sean mayores de 26 años, tengan carnet de conducir B y sean de Huesca.

SELECT v.IdVoluntarios ,
		v.nombre ,
		t.nombre ,
		p.Preferencia,
		i.idioma ,
		n.hablado ,
		TIMESTAMPDIFF(YEAR , v.fNacimiento, CURDATE()) as EDAD,
		v.carnetB ,
		p2.provincia 
FROM voluntarios v,
			preferencias p ,
			tareas t ,
			nivel n  ,
			idiomas i,
			provincias p2,
			localidades l2 
WHERE v.IdVoluntarios = p.IdVoluntario 
	AND p.IdTarea = t.IdTarea 
	AND v.IdVoluntarios = n.IdVoluntario 
	AND n.IdIdioma = i.Ididioma 
	AND p.Preferencia = 1
	AND t.nombre = 'conducción' 
	AND i.idioma = 'inglés'
	AND n.hablado IN ('alto', 'medio')
	AND TIMESTAMPDIFF(YEAR , v.fNacimiento, CURDATE()) > 26
	AND v.carnetB = 'true'
	AND v.idLocalidad = l2.idLocalidad 
	AND l2.idProvincia = p2.idProvincia 
	AND p2.provincia = 'Huesca';

-- 21.	Personas que tengan preferencia 2 en tareas administrativas, tengan un nivel medio o alto de ingles hablado y  sean mayores de 40 años.

SELECT v.IdVoluntarios ,
		v.nombre ,
		t.nombre ,
		p.Preferencia,
		i.idioma ,
		n.hablado ,
		TIMESTAMPDIFF(YEAR , v.fNacimiento, CURDATE()) as EDAD
FROM voluntarios v,
			preferencias p ,
			tareas t ,
			nivel n  ,
			idiomas i
WHERE v.IdVoluntarios = p.IdVoluntario 
	AND p.IdTarea = t.IdTarea 
	AND v.IdVoluntarios = n.IdVoluntario 
	AND n.IdIdioma = i.Ididioma 
	AND p.Preferencia = 2
	AND t.nombre = 'Administrativas' 
	AND i.idioma = 'inglés'
	AND n.hablado IN ('alto', 'medio')
	AND TIMESTAMPDIFF(YEAR , v.fNacimiento, CURDATE()) > 40;
	
-- 22.	Personas cuyo nombre  comience por A y que sean de Cataluña

SELECT v.IdVoluntarios ,
				v.nombre ,
				l.localidad ,
				p.provincia 
FROM voluntarios v ,
			localidades l ,
			provincias p 
WHERE v.idLocalidad  = l.idLocalidad
			AND l.idProvincia = p.idProvincia 
			AND v.nombre LIKE 'A%'
			AND p.provincia IN ('Girona', 'Barcelona', 'Tarragona', 'Lleida');
			

-- 23.	Personas cuyo codigo postal comience por 2 y termine en 6 

SELECT vo.Idvoluntario ,
				vo.Nombre ,
				vo.Poblacion ,
				vo.Cp 
FROM Voluntarios_OLD vo 
WHERE vo.Cp LIKE '2%6';

-- 24.	Personas cuya localidad comience por CAN 

SELECT *
FROM voluntarios v ,
			localidades l 
WHERE v.idLocalidad = l.idLocalidad 
		AND l.localidad LIKE 'CAN%';

-- 25.	Personas cuyo nombre comience por cualquiera de las siguientes letras F,G.H,I,J,K,L,M 
	
SELECT *
FROM voluntarios v 
WHERE v.nombre  REGEXP '^[F-M]';

-- 26.	Personas cuya cuarta letra del nombre tenga una de las siguientes letras P,Q,R,S,T   y además sean aragonesas. 

SELECT v.nombre ,
				p.provincia ,
				MID(v.nombre, 4, 1),
				SUBSTRING(v.nombre,4,1) 
FROM voluntarios v ,
			localidades l,
			provincias p 
WHERE v.idLocalidad = l.idLocalidad 
		AND l.idProvincia = p.idProvincia 
		AND p.provincia IN ('Zaragoza', 'Huesca', 'Teruel')
		AND v.nombre REGEXP '^([A-Za-z]{3})[P-Tp-t]';
		-- AND (MID(v.nombre, 4, 1) REGEXP '^[P-T]')
		-- AND SUBSTRING(v.nombre,4,1) REGEXP '^[P-T]')
		/* AND v.nombre LIKE '___p%'
		 * AND v.nombre LIKE '___q%'
		 * AND v.nombre LIKE '___r%'
		 * AND v.nombre LIKE '___s%'
		 * AND v.nombre LIKE '___t%'
		 */
		

-- 27.	Personas cuyo nombre comience por cualquiera de las siguientes letras A,B,C,D,E,F,G,H,I,J,K,L sean varones y residan en Galicia 
	
	SELECT vo.Nombre ,
				vo.Sexo ,
				vo.Provincia 
	FROM Voluntarios_OLD vo 
	WHERE vo.Sexo = 'M'
			AND (vo.Nombre REGEXP '^[A-L]')
			AND vo.Provincia IN ('Lugo','Ourense', 'Pontevedra', 'A Coruña');
	
	
-- 28.	Personas cuyo nombre comience y termine por una vocal
	
SELECT  v.IdVoluntarios ,
				v.nombre 
FROM voluntarios v 
WHERE LOWER(nombre)  RLIKE  '^[aeiou]' 
	AND LOWER(v.nombre)  RLIKE  '[aeiou]$';

-- REGEXP '^[aeiou].*[aeiou]$'

-- 29.	Personas cuyo nombre  tenga 3 letras  o tenga 10 letras
SELECT v.IdVoluntarios ,
				v.nombre ,
				LENGTH (TRIM(v.nombre)) AS 'Longitud'
FROM voluntarios v 
WHERE  LENGTH (TRIM(v.nombre))  IN (3,10);
-- 30.	Personas en cuya población aparezca la palabra VILLANUEVA 

SELECT * 
FROM voluntarios v ,
			localidades l 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.localidad LIKE '%villanueva%'; 


-- 31.	Personas en cuya población aparezca la letra Ñ 

SELECT * 
FROM voluntarios v ,
			localidades l 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.localidad REGEXP '[ñ|Ñ]';

-- 32.	Personas en cuya población aparezca una vocal acentuada 

SELECT v.nombre ,
			l.localidad 
FROM voluntarios v ,
			localidades l 
WHERE v.idLocalidad = l.idLocalidad 
	AND l.localidad REGEXP '[á|é|í|ó|ú|Á|É|Í|Ó|Ú]';


-- 33. Seleccionar el campo nombre, otro que contenga las tres primeras posiciones del nombre, otro que contenga las dos últimas posiciones del nombre.

SELECT v.nombre ,
				LEFT (v.nombre, 3) AS izda,
				RIGHT (v.nombre, 2) AS dcha
FROM voluntarios v ;

-- 34.	Seleccionar el campo nombre, población, otro que contenga las posiciones 2 y 3 del nombre, y otro que contenga la posición primera y última de la población.

SELECT v.nombre ,
				MID(v.nombre, 2, 2) AS medio ,
				l.localidad ,
				CONCAT_WS('-',LEFT (l.localidad , 1), RIGHT (l.localidad, 1)) AS primerayultima
FROM voluntarios v,
			localidades l 
WHERE v.idLocalidad = l.idLocalidad 


-- 35.	Seleccionar el campo nombre, población, otro al que llamaremos usuario, que contenga las tres primeras posiciones del nombre junto con las tres ultimas posiciones de la población y el idvoluntario y otro al que llamaremos clave que contenga los dígitos 3 y 4 del codigo postal junto con el idvoluntario y el mes de nacimiento.
SELECT vo.Nombre ,
		vo.Poblacion, 
		vo.Idvoluntario ,
 		CONCAT(LEFT(vo.Nombre, 3), RIGHT(vo.Poblacion, 3), vo.Idvoluntario ) AS Usuario,
		CONCAT(MID(vo.Cp , 3, 2), vo.Idvoluntario , MONTH(CAST(vo.FechaNacimiento AS date))) AS Clave,
		vo.Cp,
		CAST(vo.FechaNacimiento AS DATE) AS FechaNacimiento ,
		MONTHNAME(CAST(vo.FechaNacimiento AS DATE)) AS Mes 		
FROM Voluntarios_OLD vo ;



-- 36.	Seleccionar el campo nombre y otro llamado Dias Vividos donde muestre la diferencia de dias entre la fecha actual y la de su nacimiento.

SELECT v.nombre ,
		TIMESTAMPDIFF(DAY , v.fNacimiento, CURDATE()) AS Dias_Vividos 
FROM voluntarios v ;


-- 37.	Seleccionar el campo de nombre, fecha, otro llamado Dia Nacimiento en el que se muestre el día de la semana en el que nació, otro llamado Trimestre en el que se muestre el trimestre correspondiente a la fecha de nacimiento.

SELECT v.nombre ,
		v.fNacimiento ,
		DAYNAME(v.fNacimiento) AS Dia_Nacimiento,
		QUARTER(v.fNacimiento) AS Trimestre 
FROM voluntarios v ;


-- 38.	Seleccionar el campo de nombre, provincia y otro al que llamaremos comunidad  y el cual llevará  ARAGONES si la persona reside en cualquier provincia de Aragón,  ANDALUZ si reside en cualquier provincia de  Andalucía y guiones (--------) en caso contrario.

SELECT v.nombre ,
		p.provincia ,
		IF (p.provincia IN('Zaragoza' ,'Huesca', 'Teruel'), 'ARAGONES', 
			IF(p.provincia
				IN('Almeria', 'Cádiz', 'Córdoba', 'Granada', 'Huelva', 'Jaén', 'Malaga', 'Sevilla'),
				'ANDALUZ','-------')) AS comunidad
FROM voluntarios v ,
	localidades l ,
	provincias p
WHERE v.idLocalidad = l.idLocalidad 
	AND l.idProvincia = p.idProvincia ;



-- 39.	Selecciona el campo de nombre, fecha, edad y prepara un  campo llamado Edad Exacta que contenga la edad exacta de la persona.

SELECT vo.nombre ,
		vo.FechaNacimiento ,
		vo.Edad ,
		TIMESTAMPDIFF(YEAR  , vo.FechaNacimiento , CURDATE()) AS edad_exacta
FROM Voluntarios_OLD vo;

