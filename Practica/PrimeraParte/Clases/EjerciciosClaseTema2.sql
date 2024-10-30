SELECT customer.customer_id, customer.fname, customer.lname, orderinfo.date_placed
FROM customer
INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id;

-- Mostrar la cantidad de cada profucto en stock junto con su descripcion y precio de venta
-- Tabla item, stock
SELECT item.description, item.sell_price, stock.quantity
FROM item
INNER JOIN stock ON item.item_id = stock.item_id

-- Mostrar los pedidos y sus productos correspondientes(con la cnatidad pedida) para cada orden
-- Orderinfo, item, orderline
SELECT orderinfo.orderinfo_id, item.description, orderline.quantity
FROM orderinfo
INNER JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
INNER JOIN item ON item.item_id = orderline.item_id

-- Muestra todos los productos junto con su cantidad disponible en stock,
-- incluyendo productos sin stock.
SELECT item.item_id, item.description, stock.quantity
FROM item
LEFT JOIN stock ON item.item_id = stock.item_id
WHERE stock.quantity IS NULL

-- Órdenes de compra junto con la información del cliente asociado.
SELECT customer.fname, customer.lname, orderinfo.date_placed
FROM customer
RIGHT JOIN orderinfo ON customer.customer_id = orderinfo.customer_id;

-- Muestra todos los productos junto con su cantidad disponible en stock,
-- no incluyendo productos sin stock.
SELECT item.item_id, item.description, stock.quantity
FROM item
RIGHT JOIN stock ON item.item_id = stock.item_id;

-- Tods las asignaturas y los nombres de profesores que las imparten
SELECT Asignaturas.nombre, profesores.nombre
FROM Asignaturas
INNER JOIN profesores ON asignaturas.IDProfesor = Profesores.IDProfesor

-- Tods las asignaturas y los nombres de profesores que las imparten, incluir las asignaturas que no tengan profesor
SELECT Asignaturas.nombre, profesores.nombre
FROM Asignaturas
LEFT JOIN profesores ON asignaturas.IDProfesor = Profesores.IDProfesor

-- Tods las asignaturas y los nombres de profesores que las imparten, profesores que no imparten alguna asignatura
SELECT Asignaturas.nombre, profesores.nombre
FROM Asignaturas
RIGHT JOIN profesores ON asignaturas.IDProfesor = Profesores.IDProfesor

-- Tods las asignaturas y los nombres de profesores que las imparten,
-- Incluyendo los profes sin asignaturas y ademas las asignaturas sin profesores asignados
SELECT Asignaturas.nombre, profesores.nombre
FROM Asignaturas
FULL JOIN profesores ON asignaturas.IDProfesor = Profesores.IDProfesor

-- Todos los estudiantes junto a las asigntaruas que estan matriculados
SELECT *
FROM estudiantes
--NATURAL JOIN matriculas
INNER JOIN matriculas on estudiantes.matricula = matriculas.matricula

-- Todos los estudiantes junto a las asigntaruas que estan matriculados
-- Incluye estudiantes sin asignaturas matriculadas
SELECT *
FROM estudiantes
NATURAL LEFT JOIN matriculas
--LEFT JOIN matriculas on estudiantes.matricula = matriculas.matricula

-- Todos los estudiantes junto a las asigntaruas que estan matriculados
-- Incluye estudiantes sin asignaturas matriculadas
SELECT *
FROM estudiantes
NATURAL JOIN matriculas
NATURAL JOIN asignaturas
--LEFT JOIN matriculas on estudiantes.matricula = matriculas.matricula
-- EJercicio entender porqeu no funciona