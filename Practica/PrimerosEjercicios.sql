-- 2.
-- SELECT * FROM estudiantes

-- 3.
-- SELECT idasignatura, nombre
-- FROM asignaturas

-- 4.
-- SELECT *
-- from asignaturas
-- WHERE creditos > 3

-- 5.
-- SELECT nombre, apellido
-- from estudiantes
-- where edad > 21

-- 6.
-- SELECT COUNT(*)
-- FROM estudiantes
-- WHERE nombre like 'Martinez' or apellido like 'Martinez'

-- 7.
-- SELECT 'Asignaturas' AS Encabezado, nombre
-- FROM asignaturas;

-- 8.
--SELECT UPPER(nombre) as UpperNombre, UPPER (correoelectronico) as UpperCorreo
--from estudiantes

-- 9.
-- SELECT AVG (notanumerica) as media3003
-- FROM matriculas
-- WHERE idasignatura = '3003'

-- 10.
/*
SELECT idasignatura, COUNT(*) as nummatriculas
from matriculas
group by idasignatura
order by nummatriculas desc
*/

-- 11.
/*
select nombre
from asignaturas
where semestre = '1'
order by creditos desc
LIMIT 1
*/


-- 12. 

-- SELECT LOWER(TRIM(correoelectronico)) as correosminus
-- from estudiantes

-- 13.

--SELECT *
--from estudiantes
--where correoelectronico like '%correo.com%'

-- 14.
/*
SELECT *
from estudiantes
order by edad desc
*/

-- 15.
/*
SELECT AVG(edad) as mediaEdades
from estudiantes
*/

-- 16.
/*
select *
from profesores
where UPPER(nombre) like 'A%' or UPPER(nombre) like '%L'
*/

-- 17.
/*
SELECT COUNT(DISTINCT(edad)) as edadesDistintas
from estudiantes
*/

-- 18.
/*
SELECT edad, COUNT(DISTINCT(edad))
from estudiantes
group by edad
*/

-- 19.
/*
SELECT *
from matriculas
where fechamatriculacion = '2023-01-17'
*/

-- 20.
/*
SELECT *
from matriculas
where idasignatura = '3003'
*/

-- 21.
/*
SELECT correoelectronico as contieneloj
from profesores
where correoelectronico like '%l%' or correoelectronico like '%j%'
*/

-- 22.
/*
select nombre, apellido
from estudiantes
where apellido like '%ez'
*/

-- 23.
/*
select nombre, (25 * creditos) as horastotales
from asignaturas
*/

-- 24.
/*
select matricula, AVG(notanumerica)
from matriculas
group by matricula
having COUNT(matricula) > 1
*/

-- 25.
/*
select matricula, idasignatura, AGE(CURRENT_DATE, fechamatriculacion) as tiempo
from matriculas
*/

/*
SELECT matricula, EXTRACT(MONTH FROM fechamatriculacion) AS AñoMatriculacion
FROM matriculas
*/

-- Mostrar cuantas matriculas se han realizado el mes de enero
-- SELECT COUNT (fechamatriculacion) as matriculasEnero
-- FROM matriculas
-- WHERE EXTRACT(MONTH FROM fechamatriculacion) = 1;

/*
SELECT COUNT(*), idasignatura
FROM Matriculas
group by idasignatura
*/

/*
SELECT idasignatura, avg(NotaNumerica) as Nota_media
from matriculas
group by idasignatura
*/

/*
SELECT customer_id, COUNT(*) as NumeroPedidos
from orderinfo
group by customer_id
*/

/*
CUantos productos diferentes fueron pedidos en cada orden
SELECT orderinfo_id, COUNT (DISTINCT(item_id)) as Productosdistintos
FROM orderline
GROUP BY orderinfo_id;
*/


--------------------------------------------------------------------------------

-- 2.
/*
SELECT *
FROM item
*/

-- 3.
/*
SELECT town, lname
FROM customer
*/

-- 4.
/*
SELECT town, lname AS lastname
FROM customer
*/

-- 5.
/*
SELECT town, lname AS lastname
FROM customer
ORDER BY town
*/

-- 6.
/*
SELECT town, lname AS lastname
FROM customer
ORDER BY town DESC
*/

-- 7.
/*
SELECT town, lname AS lastname
FROM customer
GROUP by town, lname
HAVING (COUNT(town) = 1 OR COUNT(lname) = 1)
ORDER BY town DESC
*/

-- 8.
/*
SELECT description, cost_price * 100 AS costcents
FROM item
*/

-- 9.
/*
SELECT town, lname, fname
FROM CUSTOMER
WHERE town = 'Bingham'
*/

-- 10.
/*
SELECT town, lname, fname
FROM CUSTOMER
WHERE (town = 'Bingham' or town = 'Nicetown') and title = 'Mr'
*/

-- 11.
/*
SELECT customer_id, town, lname
FROM CUSTOMER
WHERE customer_id BETWEEN 5 AND 9
*/

-- 12.
/*
SELECT fname, lname
FROM CUSTOMER
WHERE fname LIKE 'D%'
*/

-- 13.
/*
SELECT fname, lname
FROM CUSTOMER
WHERE fname LIKE '_a%'
*/

-- 14.
/*
SELECT fname, lname
FROM CUSTOMER
WHERE lname LIKE '%o%'
*/

-- 15.
/*
SELECT * 
FROM item
WHERE cost_price > 7
LIMIT 3
*/

-- 16.
/*
SELECT *
FROM customer
WHERE phone IS NULL
*/

-- 17.
/*
SELECT customer_id as onlyoneorder
FROM orderinfo
GROUP BY customer_id
*/

-- 18.
/*
SELECT customer_id as onlyoneorder
FROM orderinfo
GROUP BY customer_id
HAVING COUNT(customer_id) = '1'
*/

-- 19.
/*
SELECT ROUND(SUM((sell_price - cost_price)*553),1) as beneficio
from item;
*/

-- 20.
-- PREGUNTAR SI SE PUEDE HACER UN MAX(SELL_PRICE)
/*
SELECT description, sell_price, width_bucket(sell_price, 0, 25.32, 5) AS gama_producto
FROM item
*/

-- 21.
/*
SELECT customer_id, COUNT(*)
FROM orderinfo
GROUP BY customer_id
*/

