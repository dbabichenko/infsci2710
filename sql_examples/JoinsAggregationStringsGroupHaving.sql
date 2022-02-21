USE classicmodels;

# FROM Clause
SELECT * FROM employees;

# WHERE Clause
SELECT * FROM employees WHERE lastName = 'Smith';

SELECT * FROM employees WHERE lastName = 'Smith' OR officeCode = 5;

# BETWEEN OPERATOR
SELECT * FROM employees WHERE officeCode BETWEEN 3 and 5;

SELECT * FROM payments WHERE paymentDate BETWEEN '2004-10-19' AND '2004-10-25';
SELECT * FROM payments WHERE paymentDate >= '2004-10-19' AND paymentDate <='2004-10-25';

# LIKE OPERATOR
SELECT * FROM employees WHERE lastName = 'Smith';

# Starts with 'S'
SELECT * FROM employees WHERE lastName LIKE 'S%';

# Ends with 's'
SELECT * FROM employees WHERE lastName LIKE '%s';

# Contains 's'
SELECT * FROM employees WHERE lastName LIKE '%s%';

# LIMIT
SELECT * FROM employees LIMIT 5; 
SELECT * FROM payments ORDER BY amount DESC LIMIT 1;

# Aggregate function
SELECT COUNT(*) FROM customers;
SELECT COUNT(creditLimit) FROM customers;

SELECT * FROM customers WHERE creditLimit IS NULL;
SELECT * FROM customers WHERE creditLimit IS NOT NULL;

SELECT SUM(creditLimit) FROM customers WHERE creditLimit IS NOT NULL;
SELECT AVG(creditLimit) FROM customers WHERE creditLimit IS NOT NULL;
SELECT MIN(creditLimit) FROM customers WHERE creditLimit IS NOT NULL;
SELECT MAX(creditLimit) FROM customers WHERE creditLimit IS NOT NULL;

# Aliases
SELECT MAX(creditLimit) AS maxCreditLimit FROM customers WHERE creditLimit IS NOT NULL;
SELECT customerNumber AS customerID, checkNumber AS checkNum, paymentDate as pDate, amount AS paymentAmount FROM payments;

# Group By
SELECT * FROM orderdetails;

SELECT COUNT(productCode) FROM orderdetails;
SELECT DISTINCT productCode FROM orderdetails;

SELECT productCode, SUM(quantityOrdered) FROM orderdetails GROUP BY productCode;
SELECT productCode, MAX(quantityOrdered) FROM orderdetails GROUP BY productCode;

SELECT productCode, orderNumber, MAX(quantityOrdered) FROM orderdetails GROUP BY productCode, orderNumber;

SELECT productCode, MAX(quantityOrdered) FROM orderdetails WHERE orderNumber < 10300 GROUP BY productCode;

SELECT productCode, MAX(quantityOrdered), MIN(quantityOrdered), AVG(quantityOrdered) 
FROM orderdetails WHERE orderNumber < 10300 GROUP BY productCode;

SELECT productCode, MAX(quantityOrdered) AS maxQuant, MIN(quantityOrdered) AS minQuant, AVG(quantityOrdered) AS avgQuant
FROM orderdetails WHERE orderNumber < 10300 GROUP BY productCode;

SELECT productCode, MAX(quantityOrdered) AS maxQuant, MIN(quantityOrdered) AS minQuant, AVG(quantityOrdered) AS avgQuant
FROM orderdetails 
WHERE orderNumber < 10300 
GROUP BY productCode
ORDER BY AVG(quantityOrdered) DESC
LIMIT 5;

# Having Clause
SELECT productCode, MAX(quantityOrdered) 
FROM orderdetails 
GROUP BY productCode
HAVING MAX(quantityOrdered) > 60;

SELECT customerNumber, SUM(amount) 
FROM payments
GROUP BY customerNumber
ORDER BY SUM(amount) DESC
LIMIT 5;

SELECT customerNumber, AVG(amount) 
FROM payments
GROUP BY customerNumber
HAVING AVG(amount) >= 50000;


# STRING FUNCTIONS

# Concat
SELECT CONCAT(lastName, ', ', firstName) AS employeeName FROM employees;
# DOESN'T WORK: SELECT lastName + ', ' + firstName AS employeeName FROM employees;

# Lower
SELECT LOWER(lastName) FROM employees;
SELECT LCASE(lastName) FROM employees;
SELECT UPPER(lastName) FROM employees;
SELECT UCASE(lastName) FROM employees;

# Trim
SELECT TRIM(lastName) FROM employees;

# Replace all Ms with _M_
SELECT REPLACE(LOWER(lastName), 'm', '_m_') FROM employees;
# Replace inside of an UPDATE statement
UPDATE employees SET lastName = REPLACE(LOWER(lastName), 'm', '_m_') WHERE LOWER(lastName) LIKE '%m%';

SELECT * FROM employees;

# Substring
SELECT SUBSTRING('Hello', 2, 1);

UPDATE products SET productLine = UCASE(productLine);
SELECT * FROM products;

SELECT productLine,
CONCAT(SUBSTRING(productLine, 1, 1),
LCASE(SUBSTRING(productLine, 2)))
 FROM products;

UPDATE products SET productLine = CONCAT(SUBSTRING(productLine, 1, 1),
LCASE(SUBSTRING(productLine, 2)));

# JOINS
SHOW TABLES;

SELECT * FROM orders WHERE customerNumber = 121;
SELECT * FROM customers WHERE customerNumber = 121;

SELECT customerName AS customerFullName FROM customers;

# The following query will not work because DBMS doesn't know
# which table "customerNumber" belongs to
SELECT orderNumber, orderDate, status, customerNumber, customerName
FROM orders JOIN customers ON customerNumber = customerNumber;

# Prefix customerNumber with table name
SELECT orderNumber, orderDate, status, customers.customerNumber, customerName
FROM orders JOIN customers ON orders.customerNumber = customers.customerNumber;

# Prefix customerNumber with table alias
SELECT o.orderNumber, orderDate, status, p.productCode, productName, quantityOrdered, c.customerNumber, customerName
FROM orders AS o JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN customers AS c ON o.customerNumber = c.customerNumber
JOIN products AS p ON od.productCode = p.productCode;

# LEFT JOIN vs. INNER JOIN
SELECT c.customerNumber, customerName, checkNumber, paymentDate, amount
FROM customers AS c INNER JOIN payments AS p ON c.customerNumber = p.customerNumber;

SELECT c.customerNumber, customerName, checkNumber, paymentDate, amount
FROM payments as p INNER JOIN customers AS c ON c.customerNumber = p.customerNumber;

# Left join
SELECT c.customerNumber, customerName, checkNumber, paymentDate, amount
FROM customers AS c LEFT JOIN payments AS p ON c.customerNumber = p.customerNumber
WHERE checkNumber IS NULL;

# Combine join, groupby, and having
SELECT customerName, AVG(amount)
FROM customers AS c LEFT JOIN payments AS p ON c.customerNumber = p.customerNumber
WHERE checkNumber IS NOT NULL
GROUP BY customerName
HAVING AVG(amount) >= 50000
ORDER BY AVG(amount) DESC;


SELECT customerName, AVG(amount)
FROM customers AS c JOIN payments AS p ON c.customerNumber = p.customerNumber
GROUP BY customerName
HAVING AVG(amount) >= 50000
ORDER BY AVG(amount) DESC;

# Right Join
SELECT paymentDate, amount, customerName 
FROM payments RIGHT JOIN customers ON payments.customerNumber = customers.customerNumber;

# FULL JOIN

