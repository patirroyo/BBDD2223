#Dime todas las asignaturas que tengan alumnos masculinos matriculados en el curso 2016 de informatica
SELECT al.*, a.*
FROM alumno_se_matricula_asignatura asma
    INNER JOIN curso_escolar c
        ON c.id = asma.id_curso_escolar
    INNER JOIN  asignatura a
        ON asma.id_asignatura = a.id
    INNER JOIN alumno al
        ON asma.id_alumno = al.id
    INNER JOIN grado g
        ON a.id_grado = g.id
WHERE c.anyo_inicio = 2016
    AND al.sexo = 'H'
    AND g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

#Dime todos los alumnos esten matriculados o no y si no están matriculados que diga 'no matriculado'.

SELECT DISTINCT al.id,
       al.nombre,
       al.apellido1,
       IF(asma.id_alumno IS NULL, 'No matriculado','Matriculado')
FROM alumno al
    LEFT JOIN alumno_se_matricula_asignatura asma
        ON al.id = asma.id_alumno;

EXPLAIN FORMAT=JSON SELECT DISTINCT al.id,
       al.nombre,
       al.apellido1,
       'Matriculado' as tipo_matricula
FROM alumno al
    INNER JOIN alumno_se_matricula_asignatura asma
        ON al.id = asma.id_alumno
UNION
SELECT DISTINCT al.id,
       al.nombre,
       al.apellido1,
       'No matriculado' as tipo_matricula
FROM alumno al
    LEFT JOIN alumno_se_matricula_asignatura asma
        ON asma.id_alumno = al.id
WHERE asma.id_asignatura IS NULL;

#Indices
/*Es probable que nos pidan consultas con alumnos, asignaturas y cursos, por lo que se puede realizar un índice con ellos
  Codigos BTREE
  Texto HASH
  Texto complejo FULLTEXT
  */

CREATE INDEX alumno_se_matricula_asignatura_IDX USING BTREE ON universidad.alumno_se_matricula_asignatura(id_asignatura, id_curso_escolar);

EXPLAIN SELECT * FROM alumno_se_matricula_asignatura asma
WHERE asma.id_asignatura = 1 AND asma.id_alumno = 1;


/*Crear un índice fulltext sobre el campo descripción de los ataques de los pokemon*/

SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;