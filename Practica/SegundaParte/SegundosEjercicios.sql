-- Ejercicios consultas para BPsimple.

-- 1. Listar nombre y apellido de los clientes junto con la fecha de las órdenes realizadas.
SELECT customer.fname, customer.lname, orderinfo.date_placed
FROM customer
INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id;
-- 2. Mostrar los productos junto con la cantidad vendida en cada órden.
SELECT item.description, orderline.quantity
FROM item
INNER JOIN orderline ON item.item_id = orderline.item_id
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
-- Puede que sea un RIGHT JOIN si queremos mostrar todo el stock aunque no tenga descripción de producto
-- 5. Recoge información acerca del código de barras de cada producto
SELECT item.description, barcode.barcode_ean
FROM item
INNER JOIN barcode ON item.item_id = barcode.item_id
-- 6. Mostrar clientes (nombre, apellidos) junto con cuántas órdenes han hecho, para aquellos que han
-- realizado más de una orden.
SELECT customer.fname, customer.lname, COUNT(orderinfo.orderinfo_id) AS "Number of orders"
FROM customer
INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
GROUP BY customer.customer_id
HAVING COUNT(orderinfo.orderinfo_id) > 1
-- 7. Mostrar el producto (descripción) de los que no se han realizado ningun pedido.
SELECT item.description
FROM item
LEFT JOIN orderline ON item.item_id = orderline.item_id
WHERE orderline.orderline_id IS NULL
-- 8. Muestra los clientes (nombre, apellido) que han comprado el producto "Linux CD"
SELECT customer.fname, customer.lname
FROM customer
INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
INNER JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
INNER JOIN item ON item.item_id = orderline.item_id
WHERE item.description = 'Linux CD'
-- 9. Selecciona todos los pedidos (tabla orderinfo) que han sido creados por la cliente ’Ann Stones’.
SELECT orderinfo.*
FROM orderinfo
INNER JOIN customer ON orderinfo.customer_id = customer.customer_id
WHERE customer.fname = 'Ann' AND customer.lname = 'Stones'
-- 10. Selecciona la descripción, precio de coste y código de barras de todos los items del almacén.
SELECT item.description, item.cost_price, barcode.barcode_ean
FROM item
INNER JOIN barcode ON item.item_id = barcode.item_id
INNER JOIN stock ON item.item_id = stock.item_id
WHERE stock.quantity > 0
-- 11. Obtén el identicador de item, descripción, precio de coste y total de veces que ha sido solicitado
-- por pedido (tabla orderline) cada item
SELECT item.item_id, item.description, item.cost_price, orderline.orderinfo_id, orderline.quantity
FROM item
INNER JOIN orderline ON item.item_id = orderline.item_id
-- 12. Repite la consulta anterior para recuperar solo aquellos items para los que quedan existencias en
-- el almacén
SELECT item.item_id, item.description, item.cost_price, orderline.orderinfo_id, orderline.quantity
FROM item
INNER JOIN orderline ON item.item_id = orderline.item_id
INNER JOIN stock ON item.item_id = stock.item_id
WHERE stock.quantity > 0
-- 13. Obtén el identicador de item, descripción y precio de coste de todos aquellos items para los que
-- no hay existencias en el almacén.
SELECT item.item_id, item.description, item.cost_price
FROM item
LEFT JOIN stock ON item.item_id = stock.item_id
WHERE stock.quantity IS NULL
-- 14. Obtén el identicador de pedido, fecha de registro de pedido, gastos de envío y número total de
-- items enviados de todos los pedidos con gastos de envío superiores a 2 dólares y que contengan
-- más de 2 items.
SELECT orderinfo.orderinfo_id, orderinfo.date_placed, orderinfo.shipping, SUM(orderline.quantity) as TotalProductos
FROM orderinfo
INNER JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
GROUP BY orderinfo.orderinfo_id
HAVING orderinfo.shipping > 2 AND SUM(orderline.quantity) > 2
-- 15. Recupera el identicador de pedido, identicador de item y cantidad solicitada de todos los pe-
-- didos que incluyen productos de los que en este momento no hay existencias en almacén.
SELECT orderline.orderinfo_id, orderline.item_id, orderline.quantity
FROM orderline
LEFT JOIN stock ON orderline.item_id = stock.item_id
WHERE stock.quantity is NULL
-- 16.  Recupera el identicador de pedido, identicador de cliente, nombre, apellido, identicador de
-- producto y cantidad de producto solicitada de todos los pedidos que incluyen productos de los
-- que en este momento no hay existencias en almacén.
SELECT orderinfo.orderinfo_id, customer.customer_id, customer.fname, customer.lname, orderline.item_id, orderline.quantity
FROM orderinfo
INNER JOIN customer ON orderinfo.customer_id = customer.customer_id
INNER JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
WHERE orderline.item_id NOT IN (
    SELECT item_id
    FROM stock
)
-- 17. Selecciona el identicador de cliente y número total de pedidos por cliente de todos los clientes
-- cuyo código postal comienza por BG4.
SELECT customer.customer_id, COUNT(orderinfo.orderinfo_id) as TotalPedidos
FROM customer
INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
WHERE customer.postcode LIKE 'BG4%'
-- 18. Muestra la descripción de los productos y el número de veces que se han vendido, siempre que la
-- venta supere las 2 unidades.
SELECT item.description, SUM(orderline.quantity) as TotalVendido
FROM item
INNER JOIN orderline ON item.item_id = orderline.item_id
GROUP BY item.item_id
HAVING SUM(orderline.quantity) > 2
-- 19. Obtener el nombre y el apellido de los clientes que han realizado un pedido en el mes de marzo
-- del año 2004
SELECT customer.fname, customer.lname, orderinfo.date_placed
FROM customer
JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
WHERE EXTRACT (MONTH FROM orderinfo.date_placed) = 3 AND EXTRACT (YEAR FROM orderinfo.date_placed) = 2004
-- 20. Obtener la descripción de los artículos que tienen un stock inferior a 5 unidades.
SELECT item.description, stock.quantity
FROM item
INNER JOIN stock ON item.item_id = stock.item_id
WHERE stock.quantity < 5
-- 21. Obtener el importe total (precio de venta * cantidad vendida) de los pedidos realizados por cada
-- cliente (id, nombre y apellido), ordenado por id.
SELECT customer.customer_id, customer.fname, customer.lname, SUM(item.sell_price * orderline.quantity) as Total
FROM customer
INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
INNER JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
INNER JOIN item ON orderline.item_id = item.item_id
GROUP BY customer.customer_id
ORDER BY customer.customer_id
-- 22. Mostrar la descripción de cara producto junton con el total de ventas de cada uno y ordenar todos
-- los artículos por número de ventas (incluídos los no vendidos que aparecerán al principio)
SELECT item.description, SUM(orderline.quantity) as TotalVentas
FROM item
LEFT JOIN orderline ON item.item_id = orderline.item_id
GROUP BY item.item_id
ORDER BY TotalVentas DESC
-- 23. Muestra el importe total (sell_price ∗ quantity) obtenido en cada mes con cada uno de los produc-
-- tos vendidos.
SELECT 
	EXTRACT(YEAR FROM orderinfo.date_placed) AS year,
	EXTRACT(MONTH FROM orderinfo.date_placed) AS month,
	item.description,
	(item.sell_price * orderline.quantity) AS total_amount
FROM 
	orderinfo
INNER JOIN 
	orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
INNER JOIN 
	item ON orderline.item_id = item.item_id
-- 24. Obtener el cliente que ha realizado el pedido más caro por cada artículo junto con el importe total.
-- No esta permitido el uso de multiples group by, si se necesita hacer subconsultas.


-- 25. Obtener el número de artículos total vendidos cada mes.
SELECT EXTRACT(MONTH FROM orderinfo.date_placed), SUM(quantity)
FROM orderinfo
NATURAL JOIN orderline
GROUP BY EXTRACT(MONTH FROM orderinfo.date_placed)


-- 26. Obtener los datos de los clientes y de los pedidos que han realizado, en una sola tabla (empleando
-- NATURAL JOIN).
SELECT customer.*, orderinfo.*
FROM customer
NATURAL JOIN orderinfo

-- 27.Muestra los productos (descripción) que sólo se han vendido en un pedido junto a la orden de
-- pedido en la que han sido comprados
SELECT item.description, orderline.orderinfo_id
FROM item
INNER JOIN orderline ON item.item_id = orderline.item_id
WHERE item.item_id IN (
	SELECT orderline.item_id
	FROM orderline
	GROUP BY orderline.item_id
	HAVING COUNT(*) = 1
)
ORDER BY item.description DESC
-- Otra forma de hacerlo sin subconsulta
SELECT item.description, orderline.orderinfo_id
FROM item
INNER JOIN orderline ON item.item_id = orderline.item_id
GROUP BY item.item_id
HAVING COUNT(*) = 1
-- Otra forma
SELECT item.item_id, item.description
FROM item
NATURAL JOIN orderline
GROUP BY item.item_id
HAVING COUNT(*) = 1

-- 28. Muestra el ranking de los 5 items con los que se ha ganado más dinero: indica id item, descripción
-- y benecios (cantidad ganada).
SELECT item.item_id, item.description, SUM(orderline.quantity*(item.sell_price - item.cost_price)) AS BENEFICIO
FROM item
INNER JOIN orderline On item.item_id = orderline.item_id
GROUP BY item.item_id
ORDER BY BENEFICIO DESC
LIMIT 5;
-- 29. Muestra el ranking de los 5 mejores clientes: mostrar id cliente, nombre, apellido y cantidad gas-
--tada
SELECT customer.customer_id, customer.fname, customer.lname, MejoresClientes.CantidadGastada
FROM customer
INNER JOIN (
	SELECT orderinfo.customer_id, SUM(orderline.quantity * item.sell_price) + SUM(orderinfo.shipping) AS CantidadGastada
	FROM orderinfo
	INNER JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
	INNER JOIN item ON orderline.item_id = item.item_id
	GROUP BY orderinfo.customer_id
	ORDER BY CantidadGastada DESC
	LIMIT 5
) AS MejoresClientes ON customer.customer_id = MejoresClientes.customer_id
ORDER BY CantidadGastada DESC
LIMIT 5;
-- 30. Muestra el precio de envío (shipping) para cada ciudad de destino del pedido, incluídas las ciu-
-- dades a las que aún no hay envíos.
SELECT customer.town, SUM(orderinfo.shipping) AS PriceShipping
FROM customer
LEFT JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
GROUP BY customer.town
ORDER BY PriceShipping;
-- 31. Muestra los clientes (nombre y apellidos) que hayan realizado pedidos a partir de la fecha ’2004-
-- 07-20’
SELECT customer.fname, customer.lname, orderinfo.date_placed
FROM orderinfo
INNER JOIN customer ON orderinfo.customer_id = customer.customer_id
WHERE orderinfo.date_placed >= '2004-07-20'
-- 32. Obtener todos los datos del cliente que ha realizado más pedidos
SELECT customer.*, NumPedidos.Npedidos as PedidosRealizados
FROM customer
JOIN (
	SELECT customer.customer_id, count(*) as NPedidos
	FROM customer
	INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
	GROUP BY customer.customer_id	
) AS NumPedidos
ON customer.customer_id = NumPedidos.customer_id
ORDER BY NumPedidos.Npedidos DESC
LIMIT 1
-- 33. Obtener todos los artículos en stock que nunca se han vendido, pero cuyo código de barras ha
-- sido registrado
SELECT item.*
FROM item
JOIN barcode ON item.item_id = barcode.item_id
LEFT JOIN orderline ON item.item_id = orderline.item_id
LEFT JOIN stock ON item.item_id = stock.item_id
WHERE orderline.item_id IS NULL 
  AND stock.item_id IS NOT NULL  
  AND barcode.item_id IS NOT NULL
GROUP BY item.item_id
-- 34.  Clientes (nombre, apellido) que han comprado productos con un precio de venta superior al pro-
-- medio.
SELECT customer.customer_id, AVG(item.sell_price) 
FROM customer
JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
JOIN item ON orderline.item_id = item.item_id
WHERE item.sell_price > (
	SELECT AVG(item.sell_price)
	FROM item
)
GROUP BY customer.customer_id
-- 35. Productos que se han vendido al menos 1 vez y con existencias agotadas en el almacén.
SELECT item.*
FROM item
JOIN orderline ON item.item_id = orderline.item_id
LEFT JOIN stock ON stock.item_id = item.item_id
WHERE (stock.quantity IS NULL OR stock.quantity = 0);
-- 36. Productos que no se han vendido en ninguna orden y tienen una cantidad en stock de al menos
-- 10 unidades.
SELECT item.*
FROM item
LEFT JOIN orderline ON item.item_id = orderline.item_id
LEFT JOIN stock ON item.item_id = stock.item_id
WHERE stock.quantity >= 10 AND orderline.orderinfo_id IS NULL;


-- Ejercicios consultas para BPUniversidad.

-- 1. Listar el nombre completo (Nombre y Apellido) de todos los estudiantes y sus asignaturas matriculadas
SELECT estudiantes.nombre, estudiantes.apellido, asignaturas.nombre
FROM estudiantes
INNER JOIN matriculas ON estudiantes.matricula = matriculas.matricula
INNER JOIN asignaturas ON asignaturas.idasignatura = matriculas.idasignatura
-- 2. Calcular el promedio de edad de todos los estudiantes matriculados en asignaturas del Departamento de Ïngenieria"
SELECT AVG(estudiantes.edad)
FROM estudiantes
JOIN matriculas ON estudiantes.matricula = matriculas.matricula
JOIN asignaturas ON matriculas.idasignatura = asignaturas.idasignatura
JOIN profesores On asignaturas.idprofesor = profesores.idprofesor
WHERE profesores.departamento = 'Ingenieria'
-- 3. Calcular el promedio de edad de todos los estudiantes matriculados en la asignatura ’Historia’
SELECT AVG(estudiantes.edad)
FROM estudiantes
JOIN matriculas ON estudiantes.matricula = matriculas.matricula
JOIN asignaturas ON matriculas.idasignatura = asignaturas.idasignatura
WHERE asignaturas.nombre = 'Historia'
-- 4. Listar el nombre de todas las asignaturas y el nombre del profesor que las imparte, solo para asignaturas con más de 3 créditos.
SELECT asig.nombre, prf.nombre
FROM asignaturas AS asig
JOIN profesores as prf ON asig.idprofesor = prf.idprofesor
WHERE asig.creditos > 3
-- 5. Obtener el nombre del alumno, la asignatura y la nota numérica para cada asignatura en la que están matriculado.
SELECT estudiantes.nombre, asignaturas.nombre, matriculas.notanumerica
FROM estudiantes
INNER JOIN matriculas ON matriculas.matricula = estudiantes.matricula
INNER JOIN asignaturas ON asignaturas.idasignatura = matriculas.idasignatura
-- 6. Listar el nombre de los profesores y la cantidad de asignaturas que imparten (incluyendo si hu-
-- biera profesores sin asignaturas asignadas).
SELECT profesores.nombre, COUNT(asignaturas.idasignatura) as CantidadAsignaturas
FROM profesores
LEFT JOIN asignaturas ON profesores.idprofesor = asignaturas.idprofesor
GROUP BY profesores.nombre
-- 7. Obtener el nombre del estudiante y el nombre de la asignatura en la que ha obtenido la nota más
-- alta.
SELECT mat.matricula, MAX(mat.notanumerica)
FROM matriculas as mat
GROUP BY mat.matricula;

SELECT est.nombre, asg.nombre, NotasMaximas.MaxNota
FROm estudiantes as est
JOIN matriculas AS mat ON est.matricula = mat.matricula
JOIN asignaturas AS asg ON mat.idasignatura = asg.idasignatura
JOIN (
	SELECT mat.matricula, MAX(mat.notanumerica) as MaxNota
	FROM matriculas as mat
	GROUP BY mat.matricula
) AS NotasMaximas ON mat.matricula = NotasMaximas.matricula
WHERE mat.notanumerica = NotasMaximas.MaxNota
-- 8. Calcular la nota promedio (redondeada a 2 decimales )de todas las asignaturas para un estudiante
-- especíco (por Matrícula), incluyendo asignaturas sin calicaciones para ese estudiante y ordena-
-- das por matrícula
SELECT est.nombre, ROUND(AVG(mat.notanumerica), 2)
FROM estudiantes AS est
LEFT JOIN matriculas AS mat ON est.matricula = mat.matricula
GROUP BY est.nombre
ORDER BY est.matricula ASC
-- 9. Muestra el nombre de cada asignatura con la nota media de los alumnos matriculados en ella.
SELECT asg.nombre, ROUND(AVG(mat.notanumerica),2) AS NotaMediaAsig
FROM asignaturas AS asg
JOIN matriculas AS mat ON asg.idasignatura = mat.idasignatura
GROUP BY asg.nombre
-- 10.  Muestra el nombre, apellido y nombre de asignatura de aquellos alumnos cuya nota en cada
-- asignatura sea superior a la media de esa asignatura
SELECT est.nombre, est.apellido, asg.nombre, mat.notanumerica
FROM estudiantes AS est
JOIN matriculas AS mat ON est.matricula = mat.matricula
JOIN asignaturas AS asg ON mat.idasignatura = asg.idasignatura
JOIN (
	SELECT asg.idasignatura, AVG(mat.notanumerica) as NotaMedia
	FROM matriculas AS mat
	JOIN asignaturas AS asg ON mat.idasignatura = asg.idasignatura
	GROUP BY asg.idasignatura
) AS NotaMediaAsig ON asg.idasignatura = NotaMediaAsig.idasignatura
WHERE mat.notanumerica > NotaMediaAsig.NotaMedia
-- 11. Obtener la matrícula y el nombre de los estudiantes que han matriculado más de 2 asignaturas en
-- el primer semestre.
SELECT *
FROM asignaturas 
WHERE asignaturas.semestre = 1;

SELECT mat.matricula
FROM estudiantes as est
JOIN matriculas as mat On est.matricula = mat.matricula
JOIN (
	SELECT *
	FROM asignaturas 
	WHERE asignaturas.semestre = 1
) AS asgP ON mat.idasignatura = asgP.idasignatura
GROUP BY mat.matricula
HAVING COUNT(*) > 2;

SELECT est.nombre, est.matricula
FROM estudiantes as est
INNER JOIN (
	SELECT mat.matricula
	FROM estudiantes as est
	JOIN matriculas as mat On est.matricula = mat.matricula
	JOIN (
		SELECT *
		FROM asignaturas 
		WHERE asignaturas.semestre = 1
	) AS asgP ON mat.idasignatura = asgP.idasignatura
	GROUP BY mat.matricula
	HAVING COUNT(*) > 2
) AS EstMas2PSemestre ON est.matricula = EstMas2PSemestre.matricula
-- 12. Calcular el total de créditos matriculados por cada estudiante y mostrar solo aquellos con más de
-- 12 créditos.
SELECT est.nombre, SUM(asg.creditos) as TotalCreditos
FROM estudiantes as est
JOIN matriculas as mat ON est.matricula = mat.matricula
JOIN asignaturas as asg ON mat.idasignatura = asg.idasignatura
GROUP BY est.matricula
HAVING SUM(asg.creditos) > 12
-- Otra forma de hacerlo
SELECT mat.matricula, SUM(asg.creditos)
FROM matriculas AS mat
JOIN asignaturas as asg ON mat.idasignatura = asg.idasignatura
GROUP BY mat.matricula;


SELECT est.*, CreditosMatricula.CreditosTotales
FROM estudiantes AS est
INNER JOIN (
	SELECT mat.matricula, SUM(asg.creditos) as CreditosTotales
	FROM matriculas AS mat
	JOIN asignaturas as asg ON mat.idasignatura = asg.idasignatura
	GROUP BY mat.matricula
) AS CreditosMatricula ON est.matricula = CreditosMatricula.matricula
WHERE CreditosMatricula.CreditosTotales > 12;
-- 13. Listar el nombre de las asignaturas y el nombre del profesor que las imparte, ordenadas por nom-
-- bre de asignatura.
SELECT asg.nombre, prf.nombre
FROM asignaturas as asg
JOIN profesores as prf ON asg.idprofesor = prf.idprofesor
ORDER BY asg.nombre
-- 14. Calcular el promedio de notas numéricas por asignatura, excluyendo asignaturas sin notas.
SELECT asg.nombre, AVG(mat.notanumerica) as NotaMedia
FROM asignaturas as asg
JOIN matriculas as mat ON asg.idasignatura = mat.idasignatura
GROUP BY asg.idasignatura
HAVING COUNT(mat.notanumerica) > 0
-- 15. Mostrar el nombre de las asignaturas que no tienen estudiantes matriculados
SELECT asg.nombre
FROM asignaturas as asg
LEFT JOIN matriculas as mat ON asg.idasignatura = mat.idasignatura
GROUP BY asg.idasignatura
HAVING COUNT(mat.matricula) = 0
-- 16. Listar el nombre de los profesores que tienen un salario superior al promedio de salarios de todos
-- los profesores
SELECT *
FROM profesores as prf
WHERE prf.salario > (
	SELECT AVG(prf.salario)
	FROM profesores as prf
)
-- 17. Mostrar el nombre de las asignaturas y el número de estudiantes matriculados, excluyendo asig-
--naturas sin estudiantes
SELECT asignaturas.nombre, COUNT(matriculas.matricula) AS NumeroEstudiantes
FROM asignaturas
LEFT JOIN matriculas ON matriculas.idasignatura = asignaturas.idasignatura
GROUP BY asignaturas.nombre
HAVING COUNT(matriculas.matricula) > 0
-- 18. Calcular la cantidad de alumnos matriculados en cada uno de los semestres
SELECT asg.semestre, COUNT(DISTINCT matriculas.matricula) as EstudiantesSemestre
FROM asignaturas as asg
JOIN matriculas ON matriculas.idasignatura = asg.idasignatura
GROUP BY asg.semestre;
-- 19. Muestra la nota media de las asignaturas de cada departamento para cada uno de los cursos,
-- ordenado por cursos



-- 20. Encuentra la cantidad de asignaturas por departamento. Muestra el nombre del departamento y
-- la cantidad de asignaturas que ofrece.
SELECT prf.departamento, COUNT(*) AS NumAsignaturas
FROM profesores as prf
JOIN asignaturas as asg ON prf.idprofesor = asg.idprofesor
GROUP BY prf.departamento

-- 21. Encuentra la cantidad de estudiantes matriculados en cada asignatura. Muestra el nombre de la
-- asignatura y la cantidad de estudiantes matriculados en ella
SELECT asg.nombre, COUNT(mat.matricula) as NumEstudiantes
FROM asignaturas as asg
JOIN matriculas as mat ON asg.idasignatura = mat.idasignatura
GROUP BY asg.nombre

-- 22. Muestra el correo electrónico de todos los alumnos matriculados en asignaturas del segundo curso
SELECT est.correoelectronico
FROM estudiantes as est
JOIN matriculas as mat ON est.matricula = mat.matricula
JOIN asignaturas as asg ON mat.idasignatura = asg.idasignatura
WHERE asg.semestre = 2
GROUP BY est.matricula

-- 23. Muestra la asignatura con la media de edad de alumnos matriculados mayor.
SELECT asg.*, AVG(est.edad) AS MediaEdad
FROM asignaturas as asg
JOIN matriculas as mat ON asg.idasignatura = mat.idasignatura
JOIN estudiantes as est ON mat.matricula = est.matricula
GROUP BY asg.idasignatura
ORDER BY MediaEdad DESC
LIMIT 1

--24. Muestra el nombre, apellido y edad del alumnos que menos tiempo lleva matriculado en una
-- asignatura de primer curso
SELECT est.nombre, est.apellido, est.edad
FROM estudiantes as est
JOIN matriculas as mat ON est.matricula = mat.matricula
JOIN asignaturas as asg ON mat.idasignatura = asg.idasignatura
WHERE asg.semestre = 1
ORDER BY mat.fecha ASC
LIMIT 1

-- 25. Muestra el correo electrónico y departamento de todos los profesores que impartan asignaturas
-- en el primer semestre y que tengan alumnos suspensos.
SELECT prf.correoelectronico, prf.departamento
FROM profesores as prf
JOIN asignaturas as asg ON prf.idprofesor = asg.idprofesor
JOIN matriculas as mat ON asg.idasignatura = mat.idasignatura
WHERE asg.semestre = 1 AND mat.notanumerica < 5
GROUP BY prf.idprofesor

-- 26. Muestra el nombre de la asignatura y el nombre del estudiante más joven matriculado en cada
-- una.
SELECT asg.nombre, est.nombre, est.apellido, est.edad
FROM asignaturas as asg
JOIN matriculas as mat ON asg.idasignatura = mat.idasignatura
JOIN estudiantes as est ON mat.matricula = est.matricula
WHERE est.edad = (
	SELECT MIN(est2.edad)
	FROM estudiantes as est2
	JOIN matriculas as mat2 ON est2.matricula = mat2.matricula
	WHERE mat2.idasignatura = asg.idasignatura
)

-- 27. Muestra el nombre del estudiante con la nota más alta en cada asignatura en la que están matri-
-- culados.
SELECT est.nombre, est.apellido, asg.nombre, mat.notanumerica
FROM estudiantes as est
JOIN matriculas as mat ON est.matricula = mat.matricula
JOIN asignaturas as asg ON mat.idasignatura = asg.idasignatura
WHERE mat.notanumerica = (
	SELECT MAX(mat2.notanumerica)
	FROM matriculas as mat2
	WHERE mat2.idasignatura = asg.idasignatura
)

-- 28. Encuentra el nombre de los profesores que tienen el salario más alto
SELECT prf.nombre, prf.salario
FROM profesores as prf
WHERE prf.salario = (
	SELECT MAX(prf2.salario)
	FROM profesores as prf2
)

-- 29. Encuentra el nombre y apellido de los estudiantes que tienen la calicación más alta en la asigna-
-- tura de ’Matematicas’
SELECT est.nombre, est.apellido, mat.notanumerica
FROM estudiantes as est
JOIN matriculas as mat ON est.matricula = mat.matricula
JOIN asignaturas as asg ON mat.idasignatura = asg.idasignatura
WHERE asg.nombre = 'Matematicas' AND mat.notanumerica = (
	SELECT MAX(mat2.notanumerica)
	FROM matriculas as mat2
	WHERE mat2.idasignatura = asg.idasignatura
)

-- 30. Calcular el total de créditos matriculados en cada semestre por cada estudiante y mostrar el má-
-- ximo total por estudiante.
SELECT est.nombre, est.apellido, SUM(asg.creditos) as TotalCreditos
FROM estudiantes as est
JOIN matriculas as mat ON est.matricula = mat.matricula
JOIN asignaturas as asg ON mat.idasignatura = asg.idasignatura
GROUP BY est.matricula
HAVING TotalCreditos = (
	SELECT MAX(TotalCreditos2)
	FROM (
		SELECT SUM(asg2.creditos) as TotalCreditos2
		FROM estudiantes as est2
		JOIN matriculas as mat2 ON est2.matricula = mat2.matricula
		JOIN asignaturas as asg2 ON mat2.idasignatura = asg2.idasignatura
		GROUP BY est2.matricula
	) AS TotalCreditosEstudiante
)

-- 31. Asignaturas con más de 2 estudiantes matriculados y calicaciones superiores a 8
SELECT asg.nombre, COUNT(mat.matricula) as NumEstudiantes
FROM asignaturas as asg
JOIN matriculas as mat ON asg.idasignatura = mat.idasignatura
WHERE mat.notanumerica > 8
GROUP BY asg.idasignatura
HAVING COUNT(mat.matricula) > 2

-- 32. Encuentra el nombre y apellido de los estudiantes que se matricularon en asignaturas durante el
-- año 2022.
SELECT est.nombre, est.apellido
FROM estudiantes as est
JOIN matriculas as mat ON est.matricula = mat.matricula
WHERE EXTRACT(YEAR FROM mat.fechamatriculacion) = 2022


-- Ejecicios consultas para DVDRental.
-- 1. Listar todas las peliculas en las que el actor con el apellido 'Keitel' ha actuado
SELECT film.title, film_actor.actor_id, actor.last_name
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.last_name = 'Keitel';

-- 22. Listar los actores que han trabajado en películas de categorías diferentes y mostrar el nombre de
--la película junto con el nombre del actor.
SELECT actor.first_name, actor.last_name, film.title, category.name
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE film_category.category_id IN (
	SELECT DISTINCT category_id
	FROM film_category
	GROUP BY category_id
	HAVING COUNT(DISTINCT film_id) > 1
)

-- 30.  Obtén la lista de 5 países de origen en los que residen el número de clientes que más han pagado
-- (en total, por país) por el alquiler de películas
SELECT SUM(pa.amount), cou.country
FROM payment as pa
JOIN customer as cu ON pa.customer_id = cu.customer_id
JOIN address as ad ON cu.address_id = ad.address_id
JOIN city as ci ON ad.city_id = ci.city_id
JOIN country as cou ON ci.country_id = cou.country_id
GROUP BY cou.country
ORDER BY SUM(pa.amount) desc
LIMIT 5

-- 31. Seleccionar el identicador de película y título de las 10 películas de habla inglesa con mayor
-- número de actores en el reparto
SELECT fa.film_id, pelis_ingles.title, COUNT(fa.actor_id) as n_actores
FROM film_actor as fa
INNER JOIN (
	SELECT film_id, title
	FROM film
	INNER JOIN language ON film.language_id = language.language_id
	WHERE language.name = 'English'
) AS pelis_ingles
ON fa.film_id = pelis_ingles.film_id
GROUP BY fa.film_id, pelis_ingles.title
ORDER BY n_actores DESC
LIMIT 10
-- O de forma más sencilla
SELECT film.film_id, film.title, COUNT(film_actor.actor_id) as n_actores
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN language ON film.language_id = language.language_id
WHERE language.name = 'English'
GROUP BY film.film_id, film.title
ORDER BY n_actores DESC
LIMIT 10


-- 35. Muestra el valor máximo y el valor mínimo de dinero abonado de entre los alquileres que han
-- sido gestionados por el empleado Jon Stephens
SELECT MAX(amount), MIN(amount), staff.first_name, staff.last_name
FROM payment
INNER JOIN staff on payment.staff_id = staff.staff_id
WHERE staff.first_name = 'Jon' AND staff.last_name = 'Stephens'
GROUP BY staff.first_name, staff.last_name
-- Otra forma de hacerlo
SELECT MAX(amount), MIN(amount)
FROM payment
JOIN (
	SELECT *
	FROM staff
	WHERE staff.first_name = 'Jon' AND staff.last_name = 'Stephens'

) AS staff_jon
ON payment.staff_id = staff_jon.staff_id