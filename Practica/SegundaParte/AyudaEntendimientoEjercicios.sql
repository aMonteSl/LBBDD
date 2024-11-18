SELECT orderline.item_id
FROM orderline
GROUP BY orderline.item_id
HAVING COUNT(*) = 1;


SELECT item.description, orderline.orderinfo_id
FROM item
INNER JOIN orderline ON item.item_id = orderline.item_id
WHERE item.item_id IN(
	SELECT orderline.item_id
	FROM orderline
	GROUP BY orderline.item_id
	HAVING COUNT(*) = 1
);

SELECT item.item_id, item.description, SUM(orderline.quantity*(item.sell_price - item.cost_price)) AS BENEFICIO
FROM item
INNER JOIN orderline On item.item_id = orderline.item_id
GROUP BY item.item_id
ORDER BY BENEFICIO DESC
LIMIT 5;

SELECT orderinfo.customer_id,SUM(orderline.quantity*(item.sell_price)) AS CantidadGastada
FROM orderinfo
INNER JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
INNER JOIN item ON orderline.item_id = item.item_id
GROUP BY orderinfo.customer_id;


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

SELECT customer.town, SUM(orderinfo.shipping) AS PriceShipping
FROM customer
LEFT JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
GROUP BY customer.town
ORDER BY PriceShipping;


SELECT orderinfo.customer_id, customer.fname, customer.lname, orderinfo.date_placed
FROM orderinfo
INNER JOIN customer ON orderinfo.customer_id = customer.customer_id
WHERE orderinfo.date_placed >= '2004-07-20';

SELECT customer.customer_id, count(*)
FROM customer
INNER JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
GROUP BY customer.customer_id;


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
LIMIT 1;


SELECT *
FROM stock
LEFT JOIN orderline ON stock.item_id = orderline.item_id;


SELECT item.*
FROM item
JOIN barcode ON item.item_id = barcode.item_id
LEFT JOIN orderline ON item.item_id = orderline.item_id
LEFT JOIN stock ON item.item_id = stock.item_id
WHERE orderline.item_id IS NULL 
  AND stock.item_id IS NOT NULL  
  AND barcode.item_id IS NOT NULL
GROUP BY item.item_id;

SELECT AVG(item.sell_price)
FROM item;

SELECT customer.customer_id, AVG(item.sell_price) 
FROM customer
JOIN orderinfo ON customer.customer_id = orderinfo.customer_id
JOIN orderline ON orderinfo.orderinfo_id = orderline.orderinfo_id
JOIN item ON orderline.item_id = item.item_id
WHERE item.sell_price > (
	SELECT AVG(item.sell_price)
	FROM item
)
GROUP BY customer.customer_id;

SELECT item.*
FROM item
JOIN orderline ON item.item_id = orderline.item_id
LEFT JOIN stock ON stock.item_id = item.item_id
WHERE (stock.quantity IS NULL OR stock.quantity = 0);

SELECT item.*
FROM item
LEFT JOIN orderline ON item.item_id = orderline.item_id
LEFT JOIN stock ON item.item_id = stock.item_id
WHERE stock.quantity >= 10 AND orderline.orderinfo_id IS NULL;


