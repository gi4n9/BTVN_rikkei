CREATE DATABASE SalesDB;

USE SalesDB;

CREATE TABLE Customers (
	customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
	order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Promotions (
	promotion_id INT PRIMARY KEY,
    promotion_name VARCHAR(100),
    discount_percentage DECIMAL(5,2)
);

CREATE TABLE Sales (
	sale_id INT PRIMARY KEY,
    order_id INt,
    sale_date DATE,
    sale_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert vào bảng Customers
INSERT INTO Customers (customer_id, first_name, last_name, email)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com'),
(2, 'Jane', 'Smith', 'jane.smith@example.com'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com');

-- Insert vào bảng Products
INSERT INTO Products (product_id, product_name, price)
VALUES
(1, 'Laptop', 1200.00),
(2, 'Smartphone', 800.00),
(3, 'Headphones', 150.00);

-- Insert vào bảng Orders
INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
(1, 1, '2024-11-01', 5500.00),
(2, 2, '2024-11-02', 800.00),
(3, 3, '2024-11-03', 150.00);


-- Insert vào bảng Promotions
INSERT INTO Promotions (promotion_id, promotion_name, discount_percentage)
VALUES
(1, 'Black Friday', 30.00),
(2, 'Cyber Monday', 20.00),
(3, 'Holiday Sale', 25.00);

-- Insert vào bảng Sales
INSERT INTO Sales (sale_id, order_id, sale_date, sale_amount)
VALUES
(1, 1, '2024-11-01', 945.00), -- Order with discount applied
(2, 2, '2024-11-02', 640.00), -- Order with discount applied
(3, 3, '2024-11-03', 150.00); -- No discount applied


DELIMITER $$

CREATE PROCEDURE CalculateMonthlyRevenueAndApplyPromotion (
    IN monthYear VARCHAR(7),
    IN revenueThreshold DECIMAL(10,2)
)
BEGIN
    -- Khai báo biến và con trỏ
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_customer_id INT;
    DECLARE current_monthYear VARCHAR(7);
    DECLARE current_revenue DECIMAL(10,2);
    DECLARE cur CURSOR FOR 
        SELECT customer_id, monthYear, total_revenue 
        FROM MonthlyRevenue
        WHERE total_revenue > revenueThreshold;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Tạo bảng tạm để lưu doanh thu hàng tháng
    CREATE TEMPORARY TABLE MonthlyRevenue (
        customer_id INT,
        monthYear VARCHAR(7),
        total_revenue DECIMAL(10,2)
    );

    -- Tính tổng doanh thu hàng tháng cho từng khách hàng và lưu vào bảng tạm
    INSERT INTO MonthlyRevenue (customer_id, monthYear, total_revenue)
    SELECT 
        customer_id, 
        DATE_FORMAT(order_date, '%Y-%m') AS monthYear, 
        SUM(total_amount) AS total_revenue
    FROM 
        Orders
    WHERE 
        DATE_FORMAT(order_date, '%Y-%m') = monthYear
    GROUP BY 
        customer_id, monthYear;

    -- Mở con trỏ
    OPEN cur;

    -- Duyệt qua bảng tạm để kiểm tra doanh thu vượt ngưỡng
    read_loop: LOOP
        FETCH cur INTO current_customer_id, current_monthYear, current_revenue;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Nếu vượt ngưỡng, thêm khuyến mãi vào bảng Promotions
        INSERT INTO Promotions (promotion_id, promotion_name, discount_percentage)
        VALUES (
            NULL, 
            CONCAT('High Revenue Bonus - ', current_monthYear), 
            10.00 -- Áp dụng giảm giá 10%
        );
    END LOOP;

    -- Đóng con trỏ
    CLOSE cur;

    -- Xóa bảng tạm sau khi sử dụng
    DROP TEMPORARY TABLE MonthlyRevenue;
END$$

DELIMITER ;

CALL CalculateMonthlyRevenueAndApplyPromotion('2024-11', 5000);

