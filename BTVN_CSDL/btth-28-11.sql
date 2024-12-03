CREATE DATABASE InventoryManagement;

USE InventoryManagement;

CREATE TABLE Products (
	ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Quantity INT
);

CREATE TABLE InventoryChanges (
	ChangeID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    OldQuantity INT,
    NewQuantity INT,
    ChangeDate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

INSERT INTO Products(ProductID,ProductName,Quantity) VALUES (1,'Sản phẩm 1', 25),
(2,'Sản phẩm 2', 30),(3,'Sản phẩm 3', 40);

-- Ex01

DELIMITER $$
CREATE TRIGGER AfterProductUpdate
AFTER UPDATE
ON Products
FOR EACH ROW
BEGIN
	IF OLD.quantity <> NEW.quantity THEN
		INSERT INTO InventoryChanges(ProductID, OldQuantity, NewQuantity, ChangeDate) VALUES (OLD.ProductID, OLD.Quantity, NEW.Quantity, NOW());
	END IF;
END$$
DELIMITER ;

SHOW TRIGGERS;
DROP TRIGGER AfterProductUpdate;
SELECT NOW();

UPDATE Products
SET quantity = 90
WHERE ProductID = 3;

UPDATE Products
SET quantity = 70
WHERE ProductID = 2;

-- Ex02

DELIMITER $$
CREATE TRIGGER BeforeProductDelete 
BEFORE DELETE
ON Products
FOR EACH ROW
BEGIN
	IF OLD.Quantity > 10 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity is higher than 10';
	END IF;
END$$
DELIMITER ;

SHOW TRIGGERS;
DROP TRIGGER BeforeProductDelete;

DELETE FROM Products WHERE ProductID = 2;

-- Exercise 03
ALTER TABLE Products
ADD COLUMN LastUpdated DATETIME;

DELIMITER $$
CREATE TRIGGER BeforeProductUpdateSetDate 
BEFORE UPDATE 
ON Products
FOR EACH ROW
BEGIN
	IF OLD.ProductName <> NEW.ProductName OR OLD.Quantity <> NEW.Quantity THEN
        SET NEW.LastUpdated = NOW();
	END IF;
END$$
DELIMITER ;

SHOW TRIGGERS;
DROP TRIGGER AfterProductUpdateSetDate;

UPDATE products
SET quantity = 600
WHERE productID = 3;

-- Exercise 04
CREATE TABLE ProductSummary (
    SummaryID INT AUTO_INCREMENT PRIMARY KEY,
    TotalQuantity INT
);

INSERT INTO ProductSummary (TotalQuantity) VALUES (0);

DELIMITER $$

CREATE TRIGGER AfterProductUpdateSummary
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    DECLARE totalQty INT;
    SELECT SUM(Quantity) INTO totalQty FROM Products;

    UPDATE ProductSummary
    SET TotalQuantity = totalQty
    WHERE SummaryID = 1;
END$$

DELIMITER ;

UPDATE Products
SET Quantity = 100
WHERE ProductID = 1;

-- Exercise 05
CREATE TABLE InventoryChangeHistory (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    ChangeType VARCHAR(50),
    ChangeDate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER AfterProductUpdateHistory
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    DECLARE changeType VARCHAR(50);

    IF OLD.Quantity < NEW.Quantity THEN
        SET changeType = 'Increase';
    ELSEIF OLD.Quantity > NEW.Quantity THEN
        SET changeType = 'Decrease';
    ELSE
        SET changeType = 'No Change';
    END IF;

    INSERT INTO InventoryChangeHistory (ProductID, ChangeType, ChangeDate)
    VALUES (NEW.ProductID, changeType, NOW());
END$$

DELIMITER ;

UPDATE Products
SET Quantity = 60
WHERE ProductID = 1; 

UPDATE Products
SET Quantity = 25
WHERE ProductID = 2; 

UPDATE Products
SET Quantity = 20
WHERE ProductID = 3; 

-- Exercise 06
CREATE TABLE ProductRestock (
    RestockID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    RestockDate DATETIME,
    Status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER AfterProductUpdateRestock
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.Quantity < 10 AND NOT EXISTS (
        SELECT 1 
        FROM ProductRestock 
        WHERE ProductID = NEW.ProductID AND Status = 'Pending'
    ) THEN
        INSERT INTO ProductRestock (ProductID, RestockDate)
        VALUES (NEW.ProductID, NOW());
    END IF;
END$$

DELIMITER ;

UPDATE Products
SET Quantity = 5
WHERE ProductID = 1; 

UPDATE Products
SET Quantity = 8
WHERE ProductID = 2; 
