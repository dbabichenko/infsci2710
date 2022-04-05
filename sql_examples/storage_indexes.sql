USE classicmodels;




CREATE TABLE `orderdetails_temp` (
  `orderNumber` int NOT NULL,
  `productCode` varchar(15) NOT NULL,
  `quantityOrdered` int NOT NULL,
  `priceEach` decimal(10,2) NOT NULL,
  `orderLineNumber` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `orders_temp` (
  `orderNumber` int NOT NULL,
  `orderDate` date NOT NULL,
  `requiredDate` date NOT NULL,
  `shippedDate` date DEFAULT NULL,
  `status` varchar(15) NOT NULL,
  `comments` text,
  `customerNumber` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



INSERT INTO `classicmodels`.`orders_temp`
(`orderNumber`,
`orderDate`,
`requiredDate`,
`shippedDate`,
`status`,
`comments`,
`customerNumber`)
(SELECT `orderNumber`,
`orderDate`,
`requiredDate`,
`shippedDate`,
`status`,
`comments`,
`customerNumber` FROM orders);


INSERT INTO `classicmodels`.`orderdetails_temp`
(`orderNumber`,
`productCode`,
`quantityOrdered`,
`priceEach`,
`orderLineNumber`)
(SELECT `orderNumber`,
`productCode`,
`quantityOrdered`,
`priceEach`,
`orderLineNumber` FROM orderdetails);

SELECT * FROM orders_temp WHERE orderNumber = '10100';

#DELETE FROM temp;
INSERT INTO temp(id, something) values (uuid(), 'hello');

SELECT * FROM temp WHERE id = '1e665713-b46b-11ec-8c9c-ba828d89e5cd';


SELECT * FROM temp;
SELECT UUID();


SELECT * FROM products WHERE productName LIKE '1968%';



