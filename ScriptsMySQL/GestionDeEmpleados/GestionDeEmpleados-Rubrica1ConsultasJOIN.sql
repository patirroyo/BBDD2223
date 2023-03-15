# 1.2.4 Consultas multitabla (Composición interna)

# Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

# 1    Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.

-- SQL1
SELECT e.id,
        e.nombre,
        e.apellido1,
        e.apellido2,
        d.nombre AS Departamento
FROM empleado e,
        departamento d
WHERE e.id_departamento = d.id;

-- SQL2
SELECT e.id,
        e.nombre,
        e.apellido1,
        e.apellido2,
        d.nombre AS Departamento
FROM empleado e INNER JOIN departamento d
    ON e.id_departamento = d.id;

# 2    Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.

-- SQL1
SELECT e.id,
        e.nombre,
        e.apellido1,
        e.apellido2,
        d.nombre AS Departamento
FROM empleado e,
        departamento d
WHERE e.id_departamento = d.id
ORDER BY d.nombre,
        e.apellido1,
        e.apellido2,
        e.nombre;

-- SQL2
SELECT e.id,
        e.nombre,
        e.apellido1,
        e.apellido2,
        d.nombre AS Departamento
FROM empleado e INNER JOIN departamento d
    ON e.id_departamento = d.id
ORDER BY d.nombre,
        e.apellido1,
        e.apellido2,
        e.nombre;

# 3    Devuelve un listado con el identificador y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.

-- SQL1
SELECT DISTINCT d.id,
        d.nombre
FROM departamento d,
    empleado e
WHERE d.id = e.id_departamento;

-- SQL2
SELECT DISTINCT d.id,
        d.nombre
FROM departamento d INNER JOIN empleado e
    ON d.id = e.id_departamento;

# 4    Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) el valor de los gastos que ha generado (columna gastos).

-- SQL1
SELECT DISTINCT d.id,
        d.nombre,
        d.presupuesto - d.gastos AS PresupuestoActual
FROM departamento d,
    empleado e
WHERE d.id = e.id_departamento;

-- SQL2
SELECT DISTINCT d.id,
        d.nombre,
        d.presupuesto - d.gastos AS PresupuestoActual
FROM departamento d INNER JOIN empleado e
    ON d.id = e.id_departamento;


# 5    Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.

-- SQL1
SELECT d.nombre
FROM empleado e,
    departamento d
WHERE e.id_departamento = d.id
    AND e.nif = '38382980M';

-- SQL2
SELECT d.nombre
FROM departamento d INNER JOIN  empleado e
    ON d.id = e.id_departamento
WHERE e.nif = '38382980M';

# 6    Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.

-- SQL1
SELECT d.nombre
FROM empleado e,
    departamento d
WHERE e.id_departamento = d.id
    AND e.nombre = 'Pepe'
    AND e.apellido1 = 'Ruiz'
    AND e.apellido2 = 'Santana';

-- SQL2
SELECT d.nombre
FROM departamento d INNER JOIN  empleado e
    ON d.id = e.id_departamento
WHERE e.nombre = 'Pepe'
    AND e.apellido1 = 'Ruiz'
    AND e.apellido2 = 'Santana';


# 7    Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.

-- SQL1
SELECT e.*
FROM empleado e,
    departamento d
WHERE e.id_departamento = d.id
    AND d.nombre = 'I+D'
ORDER BY e.apellido1;

-- SQL2
SELECT e.*
FROM empleado e INNER JOIN departamento d
    ON e.id_departamento = d.id
WHERE d.nombre = 'I+D'
ORDER BY e.apellido1;


# 8    Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.

-- SQL1
SELECT e.*
FROM empleado e,
    departamento d
WHERE e.id_departamento = d.id
    AND d.nombre IN ('Sistemas', 'Contabilidad','I+D')
ORDER BY e.apellido1;

-- SQL2
SELECT e.*
FROM empleado e INNER JOIN departamento d
    ON e.id_departamento = d.id
WHERE d.nombre IN ('Sistemas', 'Contabilidad','I+D')
ORDER BY e.apellido1;

# 9    Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.

-- SQL1
SELECT e.nombre
FROM empleado e,
    departamento d
WHERE e.id_departamento = d.id
    AND d.presupuesto NOT BETWEEN 100000 AND 200000;

-- SQL2
SELECT e.nombre
FROM empleado e INNER JOIN departamento d
    ON e.id_departamento = d.id
WHERE d.presupuesto NOT BETWEEN 100000 AND 200000;

# 10    Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.

-- SQL1
SELECT DISTINCT d.nombre
FROM departamento d,
    empleado e
WHERE e.id_departamento = d.id
    AND e.apellido2 IS NULL;

-- SQL2
SELECT DISTINCT d.nombre
FROM departamento d INNER JOIN  empleado e
    ON d.id = e.id_departamento
WHERE e.apellido2 IS NULL;


# 1.2.5 Consultas multitabla (Composición externa)

# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

# 1    Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. Este listado también debe incluir los empleados que no tienen ningún departamento asociado.

SELECT e.id,
        e.nombre,
        d.id,
        d.nombre
FROM empleado e LEFT JOIN departamento d
    on d.id = e.id_departamento;

# 2    Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.

SELECT e.id,
        e.nombre,
        d.id,
        d.nombre
FROM empleado e LEFT JOIN departamento d
    on d.id = e.id_departamento
WHERE d.id IS NULL;


# 3    Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.

SELECT d.nombre
FROM empleado e RIGHT JOIN departamento d
    ON e.id_departamento = d.id
WHERE  e.id IS NULL;

# 4    Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

-- En MySQL no hay FULL OUTER JOIN, pero es lo que deberíamos usar

SELECT e.nombre AS en,
        d.nombre AS dn
FROM empleado e LEFT JOIN departamento d
    ON d.id = e.id_departamento
UNION
SELECT e2.nombre AS en,
        d2.nombre AS dn
FROM empleado e2 RIGHT JOIN departamento d2
    ON d2.id = e2.id_departamento
ORDER BY dn;


# 5    Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

SELECT e.nombre AS en,
        d.nombre AS dn
FROM empleado e LEFT JOIN departamento d
    ON d.id = e.id_departamento
WHERE d.id IS NULL
UNION ALL
SELECT e2.nombre AS en,
        d2.nombre AS dn
FROM empleado e2 RIGHT JOIN departamento d2
    ON d2.id = e2.id_departamento
WHERE e2.id IS NULL
ORDER BY dn;
