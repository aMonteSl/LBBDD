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
-- SELECT COUNT(LOWER(nombre) = 'martinez') as numMArtinez
--from estudiantes

-- 7.
-- SELECT nombre
--from asignaturas

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
--where correoelectronico like '%correo.com'

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
SELECT edad
FROM estudiantes
GROUP BY edad
HAVING (COUNT(edad) = '1')
*/

-- 18.


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
