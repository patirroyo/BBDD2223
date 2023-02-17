-- 65. Modificar el campo de sexo para que aparezca H de Hombre dónde actualmente aparece V.

UPDATE Voluntarios_OLD
SET Sexo = 'H'
WHERE Sexo = 'V';

-- 66. Modificar la provincia para que aparezca La Rioja dónde actualmente aparece Logroño.

UPDATE Voluntarios_OLD
SET Provincia = 'La Rioja'
WHERE Provincia = 'Logroño';

-- 67. Modificar el campo de laboral para que en todos quede sin información.

UPDATE Voluntarios_OLD
SET Laboral = '';

-- 68. Modificar el campo LABORAL y Deporte para que el contenido aparezca en mayúsculas.

UPDATE Voluntarios_OLD
SET Laboral = UPPER(Laboral)
AND Deporte = UPPER(deporte);

-- 69. Modificar el campo de Edad para que aparezca a edad exacta de la persona a fecha 13/12/1990.

UPDATE Voluntarios_OLD
SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, '1990-12-13');


-- 70. Seleccionar el campo de pais mostrando solo aquellos diferentes. Crear la tabla de paises con los registros seleccionados. (Voluntarios_OLD)

CREATE TABLE paises2(
    ID integer not null auto_increment primary key,
    nombrePais varchar(40));
INSERT INTO paises2(nombrePais)
    (SELECT DISTINCT Pais
     FROM Voluntarios_OLD);


-- 71. Seleccionar el campo de pais y provincia mostrando sólo aquellas provincias de España (las provincias no tienen que repetirse). Crear una tabla de provincias con los registros seleccionados. Añadir a esta tabla el resto de provincias que no sean de España.

SELECT DISTINCT  Provincia, Pais
    FROM Voluntarios_OLD
    WHERE Pais = 'España';

CREATE TABLE provincias2(
    ID integer not null auto_increment primary key,
    nombreProvincia varchar(40),
    pais varchar(40));

INSERT INTO provincias2(nombreProvincia, pais)
    (SELECT DISTINCT  Provincia, Pais
    FROM Voluntarios_OLD
    WHERE Pais = 'España');

INSERT INTO provincias2(nombreProvincia, pais)
    (SELECT DISTINCT  Provincia, Pais
    FROM Voluntarios_OLD
    WHERE Pais != 'España');

-- 72. Seleccionar el campo de provincia y población mostrando solo aquellas poblaciones diferentes. Crear la tabla de poblaciones con los registros seleccionados.

SELECT DISTINCT  Provincia, Poblacion
    FROM Voluntarios_OLD;

CREATE TABLE poblaciones(
    ID integer not null auto_increment primary key,
    nombrePoblacion varchar(40),
    provincia varchar(40));

INSERT INTO poblaciones(nombrePoblacion, provincia)
    (SELECT DISTINCT  Poblacion, Provincia
    FROM Voluntarios_OLD);

-- 73. Asignar la tarea de Administrativo a :15 personas con conocimientos de ingles ESCRITO o francés ESCRITO Medios o Altos, con nivel medio o alto de informática

SELECT COUNT(*)
FROM preferencias;
INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 1, v.IdVoluntarios -- Puesto el 1 para asignar la preferencia a IdTarea y el resto de la subconsulta a IdVolunario porque está detrás de la coma.
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.escrito IN ('Medio', 'Alto')
 AND i.idioma IN ('Inglés', 'Francés')
 AND v.nivelInformatica IN ('Medio', 'Alto')
LIMIT 15;


-- 74. Asignar la tarea de Traducción /Interprete a:
    -- a. 39 personas que tengan nivel Alto de inglés HABLADO.

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 3, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Inglés'
LIMIT 39;

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 4, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Inglés'
LIMIT 39;
    -- b. 10 personas que tengan nivel Alto de francés HABLADO.

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 3, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Francés'
LIMIT 10;

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 4, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Francés'
LIMIT 10;

    -- c. 2 personas que tengan nivel Alto de alemán HABLADO.

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 3, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Alemán'
LIMIT 2;

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 4, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Alemán'
LIMIT 2;

    -- d. 2 personas que tengan nivel Alto de italiano HABLADO

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 3, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Italiano'
LIMIT 2;

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 4, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Italiano'
LIMIT 2;

    -- e. 2 personas que tengan nivel Alto de ruso HABLADO.

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 3, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Ruso'
LIMIT 2;

INSERT INTO preferencias(IdTarea, IdVoluntario)
SELECT 4, v.IdVoluntarios
FROM voluntarios v,
    nivel n,
    idiomas i
WHERE v.IdVoluntarios = n.IdVoluntario
 AND n.IdIdioma = i.Ididioma
 AND n.hablado = 'Alto'
 AND i.idioma ='Ruso'
LIMIT 2;

-- Realizar la siguiente consulta para poder realizar las sql a continuación indicadas
 ALTER TABLE voluntariado.voluntarios ADD Puesto VARCHAR(20) NULL;
 ALTER TABLE voluntariado.Voluntarios_OLD ADD Puesto VARCHAR(20) NULL;


-- 75. Asignar en la tabla voluntarios la columna puesto con el valor “Informática” a:15 personas con nivel alto de informática y hayan elegido Tareas Informática con preferencia 1 o 2.
UPDATE voluntarios
SET Puesto ="Informática"
WHERE IdVoluntarios IN(
    SELECT IdVoluntarios
    FROM (
        SELECT v1.IdVoluntarios
        FROM voluntarios v1,preferencias p ,tareas t
        WHERE v1.IdVoluntarios =p.IdVoluntario
            AND p.Preferencia in("1","2")
            AND p.IdTarea =t.IdTarea
            AND t.nombre ="Informática"
            AND v1.nivelInformatica ="Alto"
        LIMIT 15
        ) AS t -- Every derived table must have its own alias
);

/*UPDATE voluntarios v1
JOIN preferencias p ON v1.IdVoluntarios =p.IdVoluntario
JOIN tareas t ON p.IdTarea =t.IdTarea SET Puesto ="Informática"
WHERE p.Preferencia IN("1","2")
    AND t.nombre ="Informática"
    AND v1.nivelInformatica ="Alto"
LIMIT 15;
*/

-- 76. Asignar en la tabla voluntarios old la columna Puesto con el valor “Protocolo” a: 20 personas que hayan elegido Tareas Protocolo con preferencia 1 o 2, tengan nivel medio escrito de cualquier idioma.

UPDATE Voluntarios_OLD v
SET v.Puesto = 'Protocolo'
WHERE Idvoluntario IN(
    SELECT IdVoluntario
    FROM (
        SELECT v2.Idvoluntario
        FROM Voluntarios_OLD v2,
             tareas t,
             preferencias p,
             nivel n
        WHERE v2.Idvoluntario = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND n.IdVoluntario = v2.Idvoluntario
            AND t.nombre = 'Protocolo'
            AND p.Preferencia IN(1, 2)
            AND n.escrito = 'medio'
         ) AS t
    )
LIMIT 15;

-- 77. Asignar en la tabla voluntarios old la columna puesto con el valor “Conducción” a:
    -- a. 10 personas con carnet de conducir tipo C.

UPDATE Voluntarios_OLD v
SET v.Puesto = 'Condución'
WHERE v.CarnetC = 'si'
LIMIT 10;

    -- b. 60 personas con carnet de conducir tipo B que tengan nivel hablado bajo o medio de algún idioma y que preferiblemente sean de Jaca o Huesca o Zaragoza.

UPDATE Voluntarios_OLD v
SET v.Puesto = 'Condución'
WHERE v.CarnetB = 'si'
AND Idvoluntario IN(
        SELECT Idvoluntario
        FROM (
            SELECT v2.Idvoluntario
            FROM Voluntarios_OLD v2,
                nivel n
            WHERE v2.Idvoluntario = n.IdVoluntario
                AND n.hablado IN('bajo', 'medio')
                AND v2.Poblacion IN('Jaca', 'Huesca', 'Zaragoza')
            ) AS t
    )
LIMIT 60;

-- 78. Asignar en la tabla voluntarios la columna puesto el valor “Sanitario” a: 30 personas, que hayan elegido Tareas Sanitarias con preferencia 1 o 2 y preferiblemente tengan la situación laboral de trabajadores en caso contrario de estudiante.

UPDATE Voluntarios v
SET v.Puesto = 'Sanitario'
WHERE Idvoluntario IN(
        SELECT Idvoluntario
        FROM (
            SELECT v2.Idvoluntario
            FROM voluntarios v2,
                preferencias p,
                laboral l,
                tareas t
            WHERE v2.Idvoluntario = p.IdVoluntario
                AND v2.idLabor = l.IdLabor
                AND t.IdTarea = p.IdTarea
                AND p.Preferencia IN(1, 2)
                AND t.nombre = 'Sanitaria'
            ) AS t
    )
LIMIT 30;


-- 79. Asignar en la tabla voluntarios la columna puesto el valor “Comunicación” a: 30 personas que hayan elegido Tareas Comunicación con preferencia 1 ó 2.


-- 80. Asignar en la tabla voluntarios la columna puesto el valor “Acompañante” a: 20 personas que hayan elegido Tareas Acompañante con preferencia 1 ó 2 ó 3.



-- 81. Asignar en la tabla voluntarios la columna puesto el valor “Logística” a: 30  personas que hayan elegido Tareas Logistica con preferencia 1 ó 2 ó 3 ó 4



-- 82. Asignar en la tabla voluntarios old la labor de Promoción a: 30 personas que hayan elegido Tareas Promocion con preferencia 1 ó 2 ó 3 ó 4



-- 83. Asignar en la tabla voluntarios la columna puesto el valor “Apoyo” a: 60 personas que practiquen esquí


-- 84. Asignar en la tabla voluntarios la columna puesto el valor “Accesos” a: 30 personas mas altas.



-- 85. Asignar en la tabla voluntarios la columna puesto el valor “Voluntarios” a: 30 personas de menor peso



-- 86. Asignar en la tabla voluntarios la columna puesto el valor “Información” a: 30 personas


-- 87. Asignar en la tabla voluntarios la columna puesto el valor “Palacio de congresos” a personas con las siguientes tareas:
    -- a. 10 personas Traducción o Interprete ,
    -- b. 4 sanitarios,
    -- c. 10 administrativos,
    -- d. 5 información,
    -- e. 5 informaticos,
    -- f. 10 protocolo
    -- g. 5 logistica

-- 88. Asigna en la tabla voluntarios la columna puesto el valor “Pista de Hielo” a personas con las siguientes tareas:
    -- a. 8 personas de Accesos,
    -- b. 8 personas de logística,
    -- c. 6 sanitarios ,
    -- d. 5 información,
    -- e. 5 informaticos



-- 89. Asigna en la tabla voluntarios la columna puesto el valor “Centro de Transporte” a personas con las siguientes tareas:
    -- a. 70 personas de conducción,
    -- b. 5 administrativos
    -- c. 5 informaticos
    -- d. 5 logistica
    -- e. 5 informacion


-- 90. asigna en la tabla voluntarios la columna puesto el valor “Nave de Logistica” a personas con las siguientes tareas:
    -- a. 2 personas de Accesos
    -- b. 30 promocion
    -- c. 5 logistica


-- 91. Asigna en la tabla voluntarios la columna puesto el valor “Escuela militar de montaña” a personas con las siguientes tareas:
    -- a. 5 Accesos
    -- b. 30 voluntarios


-- 92. Asigna en la tabla voluntarios la columna puesto el valor “delegaciones” a personas con las siguientes tareas:
    -- a. 43 personas de Traducción/Interprete
    -- b. 10 protocolo
    -- c. 20 acompañantes
    -- d. 7 logistica
    -- e. 5 comunicación

-- 93. Asigna en la tabla voluntarios la localidad “Berja” a personas con las siguientes tareas:
    -- a. 12 personas Apoyo
    -- b. 4 sanitarios
    -- c. 3 informacion
    -- d. 5 comunicacion
    -- e. 3 accesos

-- 94. Asigna en la tabla voluntarios la localidad “Jaca” a personas con las siguientes tareas:
    -- a. 12 personas Apoyo
    -- b. 4 sanitarios
    -- c. 3 informacion
    -- d. 5 comunicacion
    -- e. 3 accesos

-- 95. Asigna en la tabla voluntarios la localidad “Formentera” a personas con las siguientes tareas:
    -- a. 12 personas Apoyo
    -- b. 4 sanitarios
    -- c. 3 informacion
    -- d. 5 comunicacion
    -- e. 3 accesos



-- 96. Asigna la tarea de Panticosa a personas con las siguientes tareas:
    -- a. 12 personas Apoyo
    -- b. 4 sanitarios
    -- c. 3 informacion
    -- d. 5 comunicacion
    -- e. 3 accesoS