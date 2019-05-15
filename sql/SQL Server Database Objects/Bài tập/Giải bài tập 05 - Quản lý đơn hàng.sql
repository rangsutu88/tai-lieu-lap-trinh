--QL Don hang
CREATE DATABASE QLDonHang
GO

USE QLDonHang
GO
-- Q1. Create 2 tables and insert data 
CREATE TABLE Customers
(
	CustomerID INT NOT NULL,
	Name NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE [Orders]
(
	OrderID INT NOT NULL,
	CustomerID INT NOT NULL,
 	ProductName NVARCHAR(50) NOT NULL,
	DateProcessed DATETIME NOT NULL
)
GO

INSERT INTO Customers VALUES (1,'John Nguyen')
INSERT INTO Customers VALUES (2,'Bin Laden')
INSERT INTO Customers VALUES (3,'Bill Clinton')
INSERT INTO Customers VALUES (4,'Thomas Hardy')
INSERT INTO Customers VALUES (5,'Ana Tran')
INSERT INTO Customers VALUES (6,'Bob Carr')

INSERT INTO Orders VALUES (1,2,'Nuclear Bomb','2002-12-01')
INSERT INTO Orders VALUES (2,3,'Missile','2000-03-02')
INSERT INTO Orders VALUES (3,2,'Jet 1080','2004-08-03')
INSERT INTO Orders VALUES (4,1,'Beers','2001-05-12')
INSERT INTO Orders VALUES (5,4,'Asian Food','2002-10-04')
INSERT INTO Orders VALUES (6,6,'Wine','2002-03-08')
INSERT INTO Orders VALUES (7,5,'Milk','2002-05-02')

ALTER TABLE Customers
	ADD CONSTRAINT PK_Customers PRIMARY KEY(CustomerID)
GO

ALTER TABLE Orders
	ADD CONSTRAINT PK_Orders PRIMARY KEY(OrderID)
GO

ALTER TABLE Orders 
	ADD CONSTRAINT FK_Customers_Orders FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
GO

ALTER TABLE Orders
	ADD CONSTRAINT CK_DateProcessed CHECK(DateProcessed BETWEEN '1970-01-01' AND '2005-01-01')
GO

ALTER TABLE Customers
	ADD CONSTRAINT UNQ_Name UNIQUE(Name)
GO

-- Q2. Create a new table called “Processed Orders” ...
SELECT * INTO [Processed Orders]
FROM Orders
WHERE DateProcessed < '2002-10-05'

DELETE FROM Orders WHERE DateProcessed < '2002-10-05' 
GO

-- Q3. Create a view named vw_All_Orders that ...
CREATE VIEW vw_All_Orders
AS
 	SELECT * FROM Orders
	UNION
 	SELECT * FROM [Processed Orders]
GO

-- Q4. Create a view named vw_Customer_Order that ...
CREATE VIEW vw_Customer_Order
AS
 	SELECT a.OrderID,ISNULL(b.[Name],'New Customer') AS CustomerName,
        	a.ProductName,a.DateProcessed,
        	CASE
           		WHEN a.DateProcessed > GETDATE() THEN 'Pending'
           		ELSE 'History'
        	END AS Status
 	FROM Orders a JOIN Customers b ON a.CustomerID=b.CustomerID
GO

--Q5. Create a stored procedure named sp_Order_by_Date that ...
CREATE PROC sp_Order_by_Date
	@Date DATETIME
AS
	SELECT a.OrderID,b.Name AS CustomerName,
       		a.ProductName,a.DateProcessed
	FROM   Orders AS a JOIN Customers AS b ON a.CustomerID=b.CustomerID
	WHERE  a.DateProcessed=@Date
GO

-- Q6. Create a DELETE trigger named trg_Delete_Order_Audit to ...
CREATE TABLE aud_Orders
(
	OrderID INT NOT NULL,
	CustomerID INT NOT NULL,
 	ProductName NVARCHAR(50) NOT NULL,
	DateProcessed DATETIME NOT NULL,
	AuditDateTime DATETIME NOT NULL
)
GO

CREATE TRIGGER trg_Delete_Order_Audit ON Orders
FOR DELETE
AS
  INSERT INTO aud_Orders 
	SELECT *, GETDATE() FROM DELETED
GO
