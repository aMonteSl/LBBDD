-- Ejercicios consultas para BPsimple.
-- 1. Listar nombre y apellido de los clientes junto con la fecha de las órdenes realizadas.
SELECT customer.fname, customer.lname, orderinfo.date_placed
FROM customer
INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id;
-- 2. Mostrar los productos junto con la cantidad vendida en cada órden.
SELECT item.description, orderline.quantity
FROM item
INNER JOIN orderline ON orderline.item_id = item.item_id;
-- 3. Mostrar título, nombre, y apellidos de cada cliente junto con las descripción de los productos que han comprado.
SELECT customer.title, customer.fname, customer.lname, item.description
FROM customer
INNER JOIN orderinfo ON orderinfo.customer_id = customer.customer_id
INNER JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
INNER JOIN item ON item.item_id = orderline.item_id
-- 4. Mostrar la descripción de los productos con su cantidad en stock (siempre que estén disponibles)
-- y el "potencial benecio de su venta"
SELECT item.description, stock.quantity, (item.sell_price - item.cost_price ) * stock.quantity AS "Potential Benefit"
FROM item
INNER JOIN stock ON item.item_id = stock.item_id
-- 5. Recoge información acerca del código de barras de cada producto
SELECT item.description, barcode.barcode_ean
FROM item
INNER JOIN barcode ON item.item_id = barcode.item_id






-- Ejercicios consultas para BPUniversidad.
-- 1. Listar el nombre completo (Nombre y Apellido) de todos los estudiantes y sus asignaturas matriculadas
SELECT estudiantes.nombre, estudiantes.apellido, asignaturas.nombre
FROM estudiantes
INNER JOIN matriculas ON estudiantes.matricula = matriculas.matricula
INNER JOIN asignaturas ON asignaturas.idasignatura = matriculas.idasignatura
-- 2. Calcular el promedio de edad de todos los estudiantes matriculados en asignaturas del Departamento de Ïngenieria"
SELECT AVG(estudiantes.edad)
FROM estudiantes
INNER JOIN matriculas ON estudiantes.matricula = matriculas.matricula
INNER JOIN asignaturas ON asignaturas.idasignatura = matriculas.idasignatura
INNER JOIN profesores ON asignaturas.idprofesor = profesores.idprofesor
WHERE profesores.departamento = 'Ingenieria'
-- 3. Calcular el promedio de edad de todos los estudiantes matriculados en la asignatura ’Historia’
SELECT AVG(estudiantes.edad)
FROM estudiantes
INNER JOIN matriculas ON estudiantes.matricula = matriculas.matricula
INNER JOIN asignaturas ON asignaturas.idasignatura = matriculas.idasignatura
WHERE asignaturas.nombre = 'Historia'
-- 4. Listar el nombre de todas las asignaturas y el nombre del profesor que las imparte, solo para asignaturas con más de 3 créditos.
SELECT asignaturas.nombre, profesores.nombre
FROM asignaturas
INNER JOIN profesores ON profesores.idprofesor = asignaturas.idprofesor
-- 5. Obtener el nombre del alumno, la asignatura y la nota numérica para cada asignatura en la que están matriculado.
SELECT estudiantes.nombre, asignaturas.nombre, matriculas.notanumerica
FROM estudiantes
INNER JOIN matriculas ON matriculas.matricula = estudiantes.matricula
INNER JOIN asignaturas ON asignaturas.idasignatura = matriculas.idasignatura



-- Ejecicios consultas para DVDRental.
-- 1. Listar todas las peliculas en las que el actor con el apellido 'Keitel' ha actuado
SELECT film.title, film_actor.actor_id, actor.last_name
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.last_name = 'Keitel';