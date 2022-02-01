
DROP DATABASE IF EXISTS airline_reservations;
CREATE DATABASE IF NOT EXISTS airline_reservations;

USE airline_reservations;

DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers(
	customer_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL
) Engine=InnoDB;


# DATE FORMATS FOR MYSQL
# 'yyyy-mm-dd'
# 'yyyy-mm-dd HH:mm:ss'

DROP TABLE IF EXISTS reservations;
CREATE TABLE reservations(
	reservation_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    reservation_date DATETIME NOT NULL,
    fk_customer_id INT,
    FOREIGN KEY(fk_customer_id)
    REFERENCES customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) Engine=InnoDB;

INSERT INTO customers (first_name, last_name, dob) VALUES ('Dmitriy', 'Babichenko', '1977-04-11');

INSERT INTO customers (first_name, last_name, dob) 
VALUES 
('Bob', 'Smith', '1980-04-11'),
('Jane', 'Doe', '2000-12-11'),
('Jake', 'Something', '1940-04-17');


INSERT INTO reservations (reservation_date, fk_customer_id) 
VALUES
(NOW(), 1),
(NOW(), 2),
(NOW(), 2),
(NOW(), 2),
(NOW(), 3),
(NOW(), 3);

# Show current date and time
SELECT NOW();
# Show current date
SELECT CURDATE();

DELETE FROM customers WHERE customer_id = 2;

SELECT * FROM customers;
SELECT * FROM reservations;

DROP TABLE IF EXISTS addresses;

CREATE TABLE IF NOT EXISTS addresses(
	address_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    street1 VARCHAR(255) NOT NULL,
    street2 VARCHAR(255) NULL,
    city VARCHAR(100) NOT NULL,
    state CHAR(2) NOT NULL,
    zip INT NOT NULL
) ENGINE=InnoDB;

DROP TABLE IF EXISTS customers_addresses;
CREATE TABLE IF NOT EXISTS customers_addresses(
	fk_customer_id INT NOT NULL,
    fk_address_id INT NOT NULL,
    FOREIGN KEY(fk_customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(fk_address_id) REFERENCES addresses(address_id)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO addresses(street1, street2, city, state, zip) 
VALUES 
('123 Main Street', NULL, 'Pittsburgh', 'PA', 15213);

INSERT INTO addresses(street1, city, state, zip) 
VALUES 
('5234 Phillips Avenue', 'Pittsburgh', 'PA', 15218);

INSERT INTO addresses(street1, street2, city, state, zip) 
VALUES 
('135 N Bellefield Avenue', 'Room 721', 'Pittsburgh', 'PA', 15213);

SELECT * FROM addresses;

INSERT INTO customers_addresses(fk_customer_id, fk_address_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(3, 1);

SELECT * FROM customers_addresses;
