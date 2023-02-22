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
            AND v1.nivelInformatica = 'Alto'
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

UPDATE voluntarios v
SET v.Puesto = 'Sanitario'
WHERE Idvoluntarios IN(
        SELECT Idvoluntarios
        FROM (
            SELECT v2.Idvoluntarios
            FROM voluntarios v2,
                preferencias p,
                laboral l,
                tareas t
            WHERE v2.Idvoluntarios = p.IdVoluntario
                AND v2.idLabor = l.IdLabor
                AND t.IdTarea = p.IdTarea
                AND p.Preferencia IN(1, 2)
                AND t.nombre = 'Sanitaria'
            ) AS t
    )
LIMIT 30;


-- 79. Asignar en la tabla voluntarios la columna puesto el valor “Comunicación” a: 30 personas que hayan elegido Tareas Comunicación con preferencia 1 ó 2.


UPDATE voluntarios v
SET v.Puesto = 'Comunicacion'
WHERE Idvoluntarios IN(
        SELECT Idvoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                laboral l,
                tareas t
            WHERE v2.Idvoluntarios = p.IdVoluntario
                AND v2.idLabor = l.IdLabor
                AND t.IdTarea = p.IdTarea
                AND p.Preferencia IN(1, 2)
                AND t.nombre = 'Comunicación'
            ) AS t
    )
LIMIT 30;

-- 80. Asignar en la tabla voluntarios la columna puesto el valor “Acompañante” a: 20 personas que hayan elegido Tareas Acompañante con preferencia 1 ó 2 ó 3.

UPDATE voluntarios v
SET v.Puesto = 'Acompañante'
WHERE Idvoluntarios IN(
        SELECT Idvoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                laboral l,
                tareas t
            WHERE v2.Idvoluntarios = p.IdVoluntario
                AND v2.idLabor = l.IdLabor
                AND t.IdTarea = p.IdTarea
                AND p.Preferencia IN(1, 2, 3)
                AND t.nombre = 'Acompañante'
            ) AS t
    )
LIMIT 20;


-- 81. Asignar en la tabla voluntarios la columna puesto el valor “Logística” a: 30  personas que hayan elegido Tareas Logistica con preferencia 1 ó 2 ó 3 ó 4

UPDATE voluntarios v
SET v.Puesto = 'Logística'
WHERE Idvoluntarios IN(
        SELECT Idvoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                laboral l,
                tareas t
            WHERE v2.Idvoluntarios = p.IdVoluntario
                AND v2.idLabor = l.IdLabor
                AND t.IdTarea = p.IdTarea
                AND p.Preferencia IN(1, 2, 3, 4)
                AND t.nombre = 'Logístico'
            ) AS t
    )
LIMIT 30;

-- 82. Asignar en la tabla voluntarios old la labor de Promoción a: 30 personas que hayan elegido Tareas Promocion con preferencia 1 ó 2 ó 3 ó 4

UPDATE voluntarios v
SET v.Puesto = 'Promoción'
WHERE Idvoluntarios IN(
        SELECT Idvoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                laboral l,
                tareas t
            WHERE v2.Idvoluntarios = p.IdVoluntario
                AND v2.idLabor = l.IdLabor
                AND t.IdTarea = p.IdTarea
                AND p.Preferencia IN(1, 2, 3, 4)
                AND t.nombre = 'Promoción'
            ) AS t
    )
LIMIT 30;

-- 83. Asignar en la tabla voluntarios la columna puesto el valor “Apoyo” a: 60 personas que practiquen esquí

UPDATE voluntarios v
SET v.Puesto = 'Apoyo'
WHERE Idvoluntarios IN(
        SELECT Idvoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                practicar p,
                deportes d
            WHERE v2.Idvoluntarios = p.IdVoluntarios
                AND p.IdDeportes = d.IdDeporte
                AND d.deporte LIKE '%esquí%'
            ) AS t
    )
LIMIT 60;


-- 84. Asignar en la tabla voluntarios la columna puesto el valor “Accesos” a: 30 personas mas altas.

UPDATE voluntarios v
SET v.Puesto = 'Accesos'
ORDER BY v.altura DESC
LIMIT 30;

-- 85. Asignar en la tabla voluntarios la columna puesto el valor “Voluntarios” a: 30 personas de menor peso

UPDATE voluntarios v
SET v.Puesto = 'Voluntarios'
WHERE v.peso != ''
ORDER BY CAST(v.peso AS UNSIGNED) ASC
LIMIT 30;

-- 86. Asignar en la tabla voluntarios la columna puesto el valor “Información” a: 30 personas

UPDATE voluntarios v
SET v.Puesto = 'Información'
WHERE v.Puesto = ''
LIMIT 30;

-- 87. Asignar en la tabla voluntarios la columna puesto el valor “Palacio de congresos” a personas con las siguientes tareas:
    -- a. 10 personas Traducción o Interprete ,

    UPDATE voluntarios v
    SET v.Puesto = 'Palacio de congresos'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre IN ('Traducción', 'Intérprete')
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 10;

    -- b. 4 sanitarios,

    UPDATE voluntarios v
    SET v.Puesto = 'Palacio de congresos'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Sanitaria'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 4;

    -- c. 10 administrativos,

    UPDATE voluntarios v
    SET v.Puesto = 'Palacio de congresos'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Administrativas'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 10;

    -- d. 5 información,

    UPDATE voluntarios v
    SET v.Puesto = 'Palacio de congresos'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Información'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- e. 5 informaticos,

    UPDATE voluntarios v
    SET v.Puesto = 'Palacio de congresos'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Informática'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- f. 10 protocolo

    UPDATE voluntarios v
    SET v.Puesto = 'Palacio de congresos'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Protocolo'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 10;

    -- g. 5 logistica

    UPDATE voluntarios v
    SET v.Puesto = 'Palacio de congresos'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Logístico'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

-- 88. Asigna en la tabla voluntarios la columna puesto el valor “Pista de Hielo” a personas con las siguientes tareas:
    -- a. 8 personas de Accesos,

    UPDATE voluntarios v
    SET v.Puesto = 'Pista de hielo'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Accesos'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 8;

    -- b. 8 personas de logística,

    UPDATE voluntarios v
    SET v.Puesto = 'Pista de hielo'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Logístico'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 8;

    -- c. 6 sanitarios ,

    UPDATE voluntarios v
    SET v.Puesto = 'Pista de hielo'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Sanitaria'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 6;

    -- d. 5 información,

    UPDATE voluntarios v
    SET v.Puesto = 'Pista de hielo'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Información'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- e. 5 informaticos

    UPDATE voluntarios v
    SET v.Puesto = 'Pista de hielo'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Informática'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;



-- 89. Asigna en la tabla voluntarios la columna puesto el valor “Centro de Transporte” a personas con las siguientes tareas:
    -- a. 70 personas de conducción,

    UPDATE voluntarios v
    SET v.Puesto = 'Centro de Transporte'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Informática'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 70;

    -- b. 5 administrativos

    UPDATE voluntarios v
    SET v.Puesto = 'Centro de Transporte'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Administrativas'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- c. 5 informaticos

    UPDATE voluntarios v
    SET v.Puesto = 'Centro de Transporte'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Informática'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- d. 5 logistica

    UPDATE voluntarios v
    SET v.Puesto = 'Centro de Transporte'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Logístico'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- e. 5 informacion

    UPDATE voluntarios v
    SET v.Puesto = 'Centro de Transporte'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Información'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;


-- 90. asigna en la tabla voluntarios la columna puesto el valor “Nave de Logistica” a personas con las siguientes tareas:
    -- a. 2 personas de Accesos

    UPDATE voluntarios v
    SET v.Puesto = 'Nave de Logística'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Accesos'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 2;

    -- b. 30 promocion

    UPDATE voluntarios v
    SET v.Puesto = 'Nave de Logística'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Promoción'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 30;

    -- c. 5 logistica

    UPDATE voluntarios v
    SET v.Puesto = 'Nave de Logística'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Logístico'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;


-- 91. Asigna en la tabla voluntarios la columna puesto el valor “Escuela militar de montaña” a personas con las siguientes tareas:
    -- a. 5 Accesos

    UPDATE voluntarios v
    SET v.Puesto = 'Escuela militar de montaña'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Accesos'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- b. 30 voluntarios

    UPDATE voluntarios v
    SET v.Puesto = 'Escuela militar de montaña'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Voluntarios'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 30;

-- 92. Asigna en la tabla voluntarios la columna puesto el valor “delegaciones” a personas con las siguientes tareas:
    -- a. 43 personas de Traducción/Interprete

    UPDATE voluntarios v
    SET v.Puesto = 'delegaciones'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre IN('Traducción', 'Intérprete')
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 43;


    -- b. 10 protocolo

    UPDATE voluntarios v
    SET v.Puesto = 'delegaciones'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Protocolo'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 10;

    -- c. 20 acompañantes

    UPDATE voluntarios v
    SET v.Puesto = 'delegaciones'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Acompañantes'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 20;

    -- d. 7 logistica

    UPDATE voluntarios v
    SET v.Puesto = 'delegaciones'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Logístico'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 7;

    -- e. 5 comunicación

    UPDATE voluntarios v
    SET v.Puesto = 'delegaciones'
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Comunicación'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;


-- 93. Asigna en la tabla voluntarios la localidad “Berja” a personas con las siguientes tareas:
    -- a. 12 personas Apoyo

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Berja'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Apoyo'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 12;

    -- b. 4 sanitarios

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Berja'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Sanitaria'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 4;

    -- c. 3 informacion

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Berja'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Información'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 3;

    -- d. 5 comunicacion

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Berja'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Comunicación'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- e. 3 accesos

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Berja'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Accesos'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 3;

-- 94. Asigna en la tabla voluntarios la localidad “Jaca” a personas con las siguientes tareas:
    -- a. 12 personas Apoyo

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Jaca'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Apoyo'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 12;

    -- b. 4 sanitarios

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Jaca'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Sanitaria'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 4;

    -- c. 3 informacion

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Jaca'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Información'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 3;

    -- d. 5 comunicacion

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Jaca'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Comunicación'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- e. 3 accesos

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Jaca'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Accesos'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 3;


-- 95. Asigna en la tabla voluntarios la localidad “Formentera” a personas con las siguientes tareas:
    -- a. 12 personas Apoyo

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Formentera'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Apoyo'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 12;

    -- b. 4 sanitarios

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Formentera'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Sanitaria'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 4;

    -- c. 3 informacion

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Formentera'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Información'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 3;

    -- d. 5 comunicacion

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Formentera'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Comunicación'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- e. 3 accesos

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Formentera'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Accesos'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 3;



-- 96. Asigna la tarea (entiendo que será la localidad) de Panticosa a personas con las siguientes tareas:
    -- a. 12 personas Apoyo

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Panticosa'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Apoyo'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 12;

    -- b. 4 sanitarios

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Panticosa'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Sanitaria'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 4;

    -- c. 3 informacion

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Panticosa'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Información'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 3;

    -- d. 5 comunicacion

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Panticosa'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Comunicación'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 5;

    -- e. 3 accesos

    UPDATE voluntarios v
    SET v.idLocalidad =
        (SELECT idLocalidad
        FROM localidades
        WHERE localidad = 'Panticosa'
        )
    WHERE v.IdVoluntarios IN(
        SELECT v.IdVoluntarios
        FROM (
            SELECT v2.IdVoluntarios
            FROM voluntarios v2,
                preferencias p,
                tareas t
            WHERE v2.IdVoluntarios = p.IdVoluntario
            AND p.IdTarea = t.IdTarea
            AND t.nombre = 'Accesos'
            AND v2.Puesto = ''
            ) AS t
        )
    LIMIT 3;
