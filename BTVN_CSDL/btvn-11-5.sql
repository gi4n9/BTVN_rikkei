use db_new;

-- exercise 3
SELECT * FROM `architect`;
SELECT `name`, `sex` FROM `architect`;
SELECT `birthday` FROM `architect`;
SELECT `name`, `birthday` FROM `architect` ORDER BY `birthday` ASC;
SELECT `name`, `birthday` FROM `architect` ORDER BY `birthday` DESC;
SELECT * FROM `building` ORDER BY `cost` ASC, `city` ASC;

-- exercise 4
SELECT * FROM `architect` WHERE `name` = 'le thanh tung';
SELECT `name`, `birthday` FROM `worker` WHERE `skill` IN('han', 'dien');
SELECT `name` FROM `worker` WHERE `skill` IN('han', 'dien') AND `birthday` > 1948;
SELECT `name` FROM `worker` WHERE `birthday` + 20 > `year`;

SELECT `name` FROM `worker` WHERE `birthday` IN(1945, 1940, 1948);
SELECT `name` FROM `worker` WHERE `birthday` = 1945 OR `birthday` = 1940 OR `birthday` = 1948;

SELECT `name` FROM `building` WHERE `cost` BETWEEN 200 AND 500;
SELECT `name` FROM `building` WHERE `cost` >= 200 AND `cost` <= 500;

SELECT * FROM `architect` WHERE `name` LIKE 'nguyen %';
SELECT * FROM `architect` WHERE `name` LIKE '% anh %';
SELECT * FROM `architect` WHERE `name` LIKE '%th_';

SELECT * FROM `contractor` WHERE `phone` IS NULL;

-- Quản lý cơ sở dữ liệu thương mại điện tử
CREATE DATABASE tmdt_db;

USE tmdt_db;

CREATE TABLE Users(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password_hashed VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Users (user_name, password_hashed, email)
VALUES 
('trần nhả nhớt', 'bigdaddy@1234', 'bigdaddy@gmail.com'),
('trần lả lướt', 'dangrangto@1234', 'tll@gmail.com'),
('phạm đức thành', 'thanh@1234', 'ngan@gmail.com');


CREATE TABLE Products(
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    descrip TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

INSERT INTO Products (product_name, descrip, price, stock)
VALUES 
('kem đánh răng', 'kem đánh răng close up lửa băng', 2.20, 10),
('mũ bảo hiểm', 'mũ bảo hiểm 3/4', 5.40, 30),
('ốp điện thoại', 'ốp điện thoại venom', 6.10, 1200),
('dầu gội đầu', 'thanh@1234', 2.60, 300),
('thuốc lá thăng long', 'thanh@1234', 6.80, 28);



CREATE TABLE Orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

INSERT INTO Orders (user_id, total_amount)
VALUES 
(1, 250.00),
(2, 350.00);


CREATE TABLE OrderDetails(
	orderDetails_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    priceAtOrder DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE, 
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


INSERT INTO OrderDetails (order_id, product_id, quantity, priceAtOrder)
VALUES 
(1, 1, 1, 1500.00), -- kem đánh răng
(1, 3, 2, 199.99);  -- ốp điện thoại

INSERT INTO OrderDetails (order_id, product_id, quantity, priceAtOrder)
VALUES 
(2, 2, 1, 999.99),  -- mũ bảo hiểm
(2, 5, 1, 399.99);  -- thuốc lá thăng long


CREATE TABLE Reviews(
	review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    user_id INT,
    rating INT,
    CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_At DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Reviews (product_id, user_id, rating, review_text)
VALUES
(1, 1, 5, 'Kem đánh răng rất thơm, sau vài ngày sử dụng đã thấy răng trắng sáng.'),
(2, 2, 4, 'Mũ bảo hiểm đúng như ảnh, đội rất thoải mái.'),
(3, 3, 3, 'Ốp điện thoại đúng như mẫu nhưng còn nhiều ghẻ nhựa');

UPDATE Products
SET price = 18.20
WHERE product_id = 1;

UPDATE Products
SET stock = 30
WHERE product_id = 1;

UPDATE Users
SET email = 'thanhducpham@gmail.com'
WHERE user_id = 3;

DELETE FROM Products WHERE product_id = 1;
DELETE FROM OrderDetails WHERE orderDetails_id = 2;




