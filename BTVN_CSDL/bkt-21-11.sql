CREATE DATABASE test;

USE shopee_fake;

ALTER TABLE Images
ADD CONSTRAINT FK_ImageProduct
FOREIGN KEY (productId) REFERENCES Products(productId)
ON DELETE CASCADE;

ALTER TABLE Stores
ADD CONSTRAINT FK_StoreUser
FOREIGN KEY (userId) REFERENCES Users(userId)
ON DELETE CASCADE;

ALTER TABLE Reviews
ADD CONSTRAINT FK_ReviewUser
FOREIGN KEY (userId) REFERENCES Users(userId)
ON DELETE CASCADE;

ALTER TABLE Reviews
ADD CONSTRAINT FK_ReviewProduct
FOREIGN KEY (productId) REFERENCES Products(productId)
ON DELETE CASCADE;

ALTER TABLE Carts
ADD CONSTRAINT FK_CartUser
FOREIGN KEY (userId) REFERENCES Users(userId)
ON DELETE CASCADE;

ALTER TABLE Carts
ADD CONSTRAINT FK_CartProduct
FOREIGN KEY (productId) REFERENCES Products(productId)
ON DELETE CASCADE;

ALTER TABLE Products
ADD CONSTRAINT FK_ProductStore
FOREIGN KEY (storeId) REFERENCES Stores(storeId)
ON DELETE CASCADE;

ALTER TABLE Products
ADD CONSTRAINT FK_ProductCategory
FOREIGN KEY (categoryId) REFERENCES Categories(categoryId)
ON DELETE CASCADE;

ALTER TABLE Orders
ADD CONSTRAINT FK_OrderUser
FOREIGN KEY (userId) REFERENCES Users(userId)
ON DELETE CASCADE;

ALTER TABLE Orders
ADD CONSTRAINT FK_OrderStore
FOREIGN KEY (storeId) REFERENCES Stores(storeId)
ON DELETE CASCADE;

ALTER TABLE Order_details
ADD CONSTRAINT FK_OrderDetailProduct
FOREIGN KEY (productId) REFERENCES Products(productId)
ON DELETE CASCADE;


ALTER TABLE Order_details
ADD CONSTRAINT FK_OrderDetailOrder
FOREIGN KEY (orderId) REFERENCES Orders(orderId)
ON DELETE CASCADE;

-- Exercise 03

-- Liệt kê tất cả các thông tin về sản phẩm (products)
SELECT * FROM products;

-- Tìm tất cả các đơn hàng (orders) có tổng giá trị (totalPrice) lớn hơn 500,000
SELECT * FROM orders WHERE totalPrice > 500000;

-- Liệt kê tên và địa chỉ của tất cả các cửa hàng (stores)
SELECT storeName, addressStore FROM stores;

-- Tìm tất cả người dùng (users) có địa chỉ email kết thúc bằng '@gmail.com'
SELECT * FROM users WHERE email LIKE '%gmail.com';

-- Hiển thị tất cả các đánh giá (reviews) với mức đánh giá (rate) bằng 5
SELECT * FROM reviews WHERE rate = 5;

-- Liệt kê tất cả các sản phẩm có số lượng (quantity) dưới 10
SELECT * FROM products WHERE quantity < 10;

-- Tìm tất cả các sản phẩm thuộc danh mục categoryId = 1
SELECT productName FROM products WHERE categoryId = 1;

-- Đếm số lượng người dùng (users) có trong hệ thống
SELECT COUNT(userId) AS `Số lượng người dùng` FROM Users;

-- Tính tổng giá trị của tất cả các đơn hàng (orders)
SELECT SUM(TotalPrice) AS `Tổng giá trị tất cả các đơn hàng` FROM orders;

-- Tìm sản phẩm có giá cao nhất (price)
SELECT productName, price
FROM products
WHERE price = (
	SELECT MAX(price)
    FROM products
);

-- Liệt kê tất cả các cửa hàng đang hoạt động (statusStore = 1)
SELECT storeName FROM stores WHERE statusstore = 1;

-- Đếm số lượng sản phẩm theo từng danh mục (categories)
SELECT c.categoryName , COUNT(p.categoryId) AS `Số lượng sản phẩm` 
FROM categories AS c
INNER JOIN products AS p ON p.categoryId = c.categoryId
GROUP BY c.categoryName;

-- Tìm tất cả các sản phẩm mà chưa từng có đánh giá
SELECT p.productName AS `Sản phẩm`, r.content AS `Đánh giá`
FROM products AS p
LEFT JOIN reviews AS r ON p.productId = r.productId
HAVING r.content IS NULL;

-- Hiển thị tổng số lượng hàng đã bán (quantityOrder) của từng sản phẩm
SELECT p.productName AS `Tên sản phẩm` ,SUM(od.quantityOrder) AS `Tổng số lượng hàng đã bán`
FROM order_details AS od
INNER JOIN products AS p ON p.productId = od.productId
GROUP BY p.productName;

-- Tìm các người dùng (users) chưa đặt bất kỳ đơn hàng nào
SELECT DISTINCT u.userName AS `Tên người dùng đã đặt hàng`
FROM Users AS u
RIGHT JOIN Orders AS o ON o.UserId = u.userId;

-- Hiển thị tên cửa hàng và tổng số đơn hàng được thực hiện tại từng cửa hàng
SELECT s.storeName AS `Tên cửa hàng`, SUM(o.storeId) AS `Tổng số đơn hàng được thực hiện`
FROM stores AS s
INNER JOIN orders AS o ON o.storeId = s.storeID
GROUP BY s.storeName;

-- Hiển thị thông tin của sản phẩm, kèm số lượng hình ảnh liên quan
SELECT p.* , COUNT(p.ImageProduct) AS `Số lượng hình ảnh liên quan`
FROM products AS p
GROUP BY p.productId;

-- Hiển thị các sản phẩm kèm số lượng đánh giá và đánh giá trung bình
SELECT p.productName AS `Tên sản phẩm`, COUNT(r.content) AS `Số lượng đánh giá`, r.rate `Đánh giá trung bình`
FROM products AS p
LEFT JOIN reviews AS r ON r.productId = p.productId
GROUP BY p.productName;

-- Tìm người dùng có số lượng đánh giá nhiều nhất
SELECT u.userName AS `Tên người dùng`, COUNT(r.userId) AS `Số lượng đánh giá`
FROM users AS u
INNER JOIN reviews AS r ON r.userId = u.userId
GROUP BY u.userName;

-- Hiển thị top 3 sản phẩm bán chạy nhất (dựa trên số lượng đã bán)
SELECT p.productName AS `Tên sản phẩm`, p.quantitySold AS `Số lượng đã bán`
FROM products AS p
ORDER BY p.quantitySold DESC
LIMIT 3; 

-- Tìm sản phẩm bán chạy nhất tại cửa hàng có storeId = 'S001'
SELECT p.productName AS `Tên sản phẩm`
FROM products AS p
WHERE p.storeId LIKE '%S001%'
ORDER BY p.quantitySold DESC
LIMIT 1;

-- Hiển thị danh sách tất cả các sản phẩm có giá trị tồn kho lớn hơn 1 triệu (giá * số lượng)
SELECT p.productName AS `Tên sản phẩm`, p.quantity AS `Số lượng`, (p.price * p.quantity) AS `Giá trị tồn kho`
FROM products AS p
WHERE (p.price * p.quantity) > 1000000;

-- Tìm cửa hàng có tổng doanh thu cao nhất
SELECT s.storeName AS `Tên cửa hàng`, SUM(p.price * p.quantitySold) AS `Tổng doanh thu`
FROM stores AS s
INNER JOIN products AS p ON p.storeId = s.storeId
GROUP BY s.storeName
ORDER BY SUM(p.price * p.quantitySold) DESC
LIMIT 1;

-- Hiển thị danh sách người dùng và tổng số tiền họ đã chi tiêu
SELECT u.FullName AS `Tên người dùng`, SUM(o.totalPrice) AS `Tổng tiền chi tiêu`
FROM Users AS u
INNER JOIN Orders AS o ON o.userId = u.userId
GROUP BY u.userId;

-- Tìm đơn hàng có tổng giá trị cao nhất và liệt kê thông tin chi tiết
SELECT o.orderId AS `Mã đơn hàng`, o.addressOrder AS `Địa chỉ đơn hàng`, o.nameOrder AS `Tên đơn hàng`,
u.Fullname AS `Người đặt hàng`, s.storeName AS `Cửa hàng`, o.totalPrice AS `Giá`
FROM orders AS o
INNER JOIN Users AS u ON u.userId = o.userId
INNER JOIN Stores AS s ON s.storeId = o.storeId
WHERE o.totalPrice = (
	SELECT MAX(totalPrice) FROM orders
);

-- Tính số lượng sản phẩm trung bình được bán ra trong mỗi đơn hàng
SELECT od.orderId AS `Mã đơn hàng` , AVG(od.quantityOrder) AS `Số lượng sản phẩm trung bình bán ra` 
FROM orders AS o
INNER JOIN order_details AS od ON od.orderId = o.orderId
GROUP BY o.orderId;

-- Hiển thị tên sản phẩm và số lần sản phẩm đó được thêm vào giỏ hàng
SELECT p.productName AS `Tên sản phẩm`, COUNT(od.productId) AS `Số lần được thêm vào giỏ`
FROM Products AS p
INNER JOIN Order_details AS od ON p.productId = od.productId
GROUP BY p.productId
ORDER BY `Số lần được thêm vào giỏ` DESC;

-- Tìm tất cả các sản phẩm đã bán nhưng không còn tồn kho trong kho hàng
SELECT p.productName AS `Tên sản phẩm`, (p.quantity - p.quantitySold) AS `Số lượng tồn kho`, 
SUM(od.quantityOrder) AS `Số lượng đã bán`
FROM Products AS p
INNER JOIN order_details AS od ON p.productId = od.productId
GROUP BY p.productId
HAVING `Số lượng tồn kho` = 0 AND `Số lượng đã bán` > 0;

-- Tìm các đơn hàng được thực hiện bởi người dùng có email là duong@gmail.com
SELECT o.orderId AS `Mã đơn hàng`, o.createDateOrder AS `Ngày đặt hàng`, o.totalPrice AS `Tổng số tiền`
FROM Orders AS o
INNER JOIN Users AS u ON o.userId = u.userId
WHERE u.email = 'duong@gmail.com';

-- Hiển thị danh sách các cửa hàng kèm theo tổng số lượng sản phẩm mà họ sở hữu
SELECT s.storeName AS `Tên cửa hàng`, SUM(p.quantity - p.quantitySold) AS `Tổng số lượng sản phẩm`
FROM Stores AS s
INNER JOIN Products AS p ON s.storeId = p.storeId
GROUP BY s.storeId
ORDER BY `Tổng số lượng sản phẩm` DESC;

-- Exercise 04
-- View hiển thị tên sản phẩm (productName) và giá (price) từ bảng products với giá trị giá (price) lớn hơn 500,000 có tên là expensive_products
CREATE VIEW expensive_product AS 
SELECT productName, price FROM products
WHERE price > 500000;

-- Truy vấn dữ liệu từ view vừa tạo expensive_products
SELECT * FROM expensive_product;

-- Làm thế nào để cập nhật giá trị của view? Ví dụ, cập nhật giá (price) thành 600,000 cho sản phẩm có tên Product A trong view expensive_products.
UPDATE expensive_product
SET price = 600000
WHERE productName = 'Product A';

-- Làm thế nào để xóa view expensive_products
DROP VIEW expensive_product;

-- Tạo một view hiển thị tên sản phẩm (productName), tên danh mục (categoryName) bằng cách kết hợp bảng products và categories
CREATE VIEW ViewProductNameAndCategoryName AS
SELECT p.productName AS `Tên sản phẩm`, c.categoryName AS `Tên danh mục`
FROM products AS p
INNER JOIN categories AS c ON c.categoryId = p.categoryId;

SELECT * FROM ViewProductNameAndCategoryName;

-- Exercise 05
-- Làm thế nào để tạo một index trên cột productName của bảng products
CREATE INDEX ProductName ON Products(ProductName);

-- Hiển thị danh sách các index trong cơ sở dữ liệu
SHOW INDEXES FROM Products;

-- Trình bày cách xóa index idx_productName đã tạo trước đó
DROP INDEX ProductName ON Products;

-- Tạo một procedure tên getProductByPrice để lấy danh sách sản phẩm với giá lớn hơn một giá trị đầu vào (priceInput)
DELIMITER $$

CREATE PROCEDURE getProductByPrice (IN priceInput INT)
BEGIN
	SELECT * FROM products
    WHERE price > priceInput;
END$$

DELIMITER ;

DROP PROCEDURE getProductByPrice;

-- Làm thế nào để gọi procedure getProductByPrice với đầu vào là 500000
CALL getProductByPrice(500000);

-- Tạo một procedure getOrderDetails trả về thông tin chi tiết đơn hàng với đầu vào là orderId?
DELIMITER $$

CREATE PROCEDURE getOrderDetails (IN orderId1 VARCHAR(255))
BEGIN
	SELECT * FROM orders
    WHERE orderId = orderId1;
END$$

DELIMITER ;

-- Làm thế nào để xóa procedure getOrderDetails
DROP PROCEDURE getOrderDetails;

CALL getOrderDetails ('2afea63b-7d8c-433c-a7ed-37861c7d6c01');

-- Tạo một procedure tên deleteProductById để xóa sản phẩm khỏi bảng products dựa trên tham số productId
DELIMITER $$

CREATE PROCEDURE addNewProduct(
	IN productId VARCHAR(255),
    IN productName VARCHAR(255),
    IN price DECIMAL(10, 2),
    IN description TEXT,
    IN quantity INT,
    IN storeId VARCHAR(255),
    IN imageProduct VARCHAR(255),
    IN categoryID INT
)
BEGIN
    INSERT INTO Products (productId, productName, price, description, quantity, storeId, imageProduct, categoryID)
    VALUES (productId, productName, price, description, quantity, storeId, imageProduct, categoryID);
END $$

DELIMITER ;

CALL addNewProduct('da9s5-23323','Tên sản phẩm', 100.50, 'Mô tả sản phẩm', 50, '1c930d6e-e5f1-4d01-93e4-e1f2b9825ea6',
 'https://res.cloudinary.com/dqirycujn/image/upload/v1691635865/ffpgyrszlxxmwdqug7za.jpg', 1);

-- Tạo một procedure tên deleteProductById để xóa sản phẩm khỏi bảng products dựa trên tham số productId.
SHOW FULL COLUMNS FROM Products;
ALTER TABLE Products CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

DELIMITER $$

CREATE PROCEDURE deleteProductById(
    IN inputProductId VARCHAR(255)
)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    IF EXISTS (SELECT 1 FROM Products WHERE productId COLLATE utf8mb4_general_ci = inputProductId COLLATE utf8mb4_general_ci) THEN
        DELETE FROM Products WHERE productId COLLATE utf8mb4_general_ci = inputProductId COLLATE utf8mb4_general_ci;
        SELECT CONCAT('Product with ID ', inputProductId, ' has been deleted.') AS Result;
    ELSE
        SELECT CONCAT('Product with ID ', inputProductId, ' does not exist.') AS Result;
    END IF;
END $$

DELIMITER ;

CALL deleteProductById('1e1eb0f3-0ce1-4868-9220-980beeab872a');

-- Tạo một procedure tên searchProductByName để tìm kiếm sản phẩm theo tên (tìm kiếm gần đúng) từ bảng products
DELIMITER $$

CREATE PROCEDURE searchProductByName(
    IN inputProductName VARCHAR(255)
)
BEGIN
    SELECT * 
    FROM Products
    WHERE productName LIKE CONCAT('%', inputProductName, '%') COLLATE utf8mb4_general_ci;
END $$

DELIMITER ;

CALL searchProductByName('Loa Máy tính Để Bàn');

-- Tạo một procedure tên filterProductsByPriceRange để lấy danh sách sản phẩm có giá trong khoảng từ minPrice đến maxPrice
DELIMITER $$

CREATE PROCEDURE filterProductsByPriceRange(
    IN minPrice DECIMAL(10, 2),
    IN maxPrice DECIMAL(10, 2)
)
BEGIN
    SELECT * 
    FROM Products
    WHERE price BETWEEN minPrice AND maxPrice;
END $$

DELIMITER ;

CALL filterProductsByPriceRange(3000, 70000);

-- Tạo một procedure tên paginateProducts để phân trang danh sách sản phẩm, với hai tham số pageNumber và pageSize
DELIMITER $$

CREATE PROCEDURE paginateProducts(
    IN pageNumber INT,
    IN pageSize INT
)
BEGIN
    DECLARE offsetValue INT;

    SET offsetValue = (pageNumber - 1) * pageSize;

    SELECT * 
    FROM Products
    LIMIT offsetValue, pageSize;
END $$

DELIMITER ;

CALL paginateProducts(2, 5);

