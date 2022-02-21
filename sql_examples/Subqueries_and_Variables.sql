USE classicmodels;

SELECT * FROM customers WHERE contactLastName = 'Lee';

SELECT * FROM customers WHERE contactLastName = 'Lee' OR contactLastName = 'Murphy' OR contactLastName = 'Nelson';

SELECT * FROM customers WHERE contactLastName IN ('Lee', 'Murphy', 'Nelson');

SELECT productCode FROM products WHERE buyPrice > 50;

SELECT * FROM orderdetails AS od WHERE od.productCode IN (SELECT productCode FROM products WHERE buyPrice > 50);

SELECT * 
FROM classicmodels.orderdetails AS od JOIN classicmodels.products as p ON od.productCode = p.productCode
WHERE buyPrice > 50;


SELECT c.customerNumber, customerName, SUM(amount) 
FROM customers AS c JOIN payments AS p ON c.customerNumber = p.customerNumber
GROUP BY customerNumber, customerName;

/*
FOR EACH RECORD IN customers
	1. Get customerNumber
    2. Find sum of customer's purchases from payments table
		DOUBLE paymentAmount = SELECT SUM(amount) FROM payments WHERE customerNumber = 'CUSTOMER NUMBER'
*/

SELECT c.customerNumber, customerName, 
(SELECT SUM(amount) FROM payments AS p WHERE p.customerNumber = c.customerNumber) AS paymentAmount
FROM customers AS c;

SELECT c.customerNumber, customerName, SUM(amount) 
FROM customers AS c JOIN payments AS p ON c.customerNumber = p.customerNumber
GROUP BY customerNumber, customerName
HAVING SUM(amount) > 10000;

SELECT o.orderNumber, MAX(quantityOrdered), SUM(priceEach)
FROM orders AS o JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber;

SELECT o.orderNumber,
(SELECT MAX(quantityOrdered) FROM orderdetails od WHERE od.orderNumber = o.orderNumber) AS maxQuantity,
(SELECT SUM(priceEach) FROM orderdetails od WHERE od.orderNumber = o.orderNumber) AS totalPrice
FROM orders o
ORDER BY totalPrice DESC;


### CREATING A VIEW
CREATE VIEW vw_ordersummary AS
	SELECT o.orderNumber,
	(SELECT MAX(quantityOrdered) FROM orderdetails od WHERE od.orderNumber = o.orderNumber) AS maxQuantity,
	(SELECT SUM(priceEach) FROM orderdetails od WHERE od.orderNumber = o.orderNumber) AS totalPrice
	FROM orders o
	ORDER BY totalPrice DESC;

SELECT * FROM vw_ordersummary;

SELECT * FROM vw_ordersummary WHERE maxQuantity > 50;

CREATE VIEW vw_filtered_order_summary AS
	SELECT * FROM vw_ordersummary WHERE maxQuantity > 50;

SELECT * FROM vw_filtered_order_summary;



