-- Comparar todos los productos en stock con los clientes para ver las combinaciones de ventas
SELECT stock.item_id, stock.quantity,  customer.fname, customer.lname
FROM stock
CROSS JOIN customer

-- Clientes que han realizado al menos un pedido
SELECT fname, lname
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM orderinfo)

-- O se puede hacer
SELECT DISTINCT customer.fname, customer.lname
FROM customer
INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id

-- Mostrar los estudiantes con una nota mayor al promedio en la asignatura

SELECT nombre, apellido
FROM estudiantes
WHERE matricula IN (
	SELECT matricula
	FROM matriculas
	WHERE notanumerica > (
		SELECT AVG(notanumerica)
		FROM matriculas
		WHERE idasignatura = matriculas.idasignatura
	)
)

-- Mostrar los estudiantes que no estan matiruclados en ninguna asignatura
SELECT nombre, apellido
FROM estudiantes
WHERE NOT EXISTS (
	SELECT * 
	FROM Matriculas 
	WHERE Estudiantes.Matricula = Matriculas.Matricula
)

-- Mostrar los estudiantes que estan matiruclados en ninguna asignatura
SELECT nombre, apellido
FROM estudiantes
WHERE EXISTS (
	SELECT * 
	FROM Matriculas 
	WHERE Estudiantes.Matricula = Matriculas.Matricula
)

-- Mostrar los estudiantes que estan matiruclados en ninguna asignatura
SELECT nombre, apellido
FROM estudiantes
WHERE EXISTS (
	SELECT 1
	FROM Matriculas 
	WHERE Estudiantes.Matricula = Matriculas.Matricula
)

-- Calcular el total de pedidos de cada cliente y mostrar solo aquellos con mas de un pedido
SELECT customer.fname, customer.lname, pedidos.TotalPedidos
FROM customer
JOIN (SELECT customer_id, COUNT(*) AS TotalPedidos
	 FROM orderinfo
	 GROUP BY customer_id
	 ) AS pedidos
ON customer.customer_id = pedidos.customer_id
WHERE pedidos.TotalPedidos > 1