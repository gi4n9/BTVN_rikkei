CREATE DATABASE chtt;

USE chtt;

CREATE TABLE Customer (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    contact_name VARCHAR(200),
    country VARCHAR(100)
);

CREATE TABLE Orders (
	order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(200),
    price DECIMAL(10,2)
);

CREATE TABLE OrderDetails (
	order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE VIEW view_orders AS
SELECT * FROM Orders;

CREATE VIEW view_order_details AS
SELECT * FROM OrderDetails;

CREATE INDEX `order_date` ON Orders(`order_date`);
CREATE INDEX `quantity` ON OrderDetails(`quantity`);