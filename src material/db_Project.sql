create database db_project

use db_project


CREATE TABLE Shopkeeper (
    ShopkeeperID INT PRIMARY KEY IDENTITY(1,1),  
    FirstName VARCHAR(50) NOT NULL,             
    LastName VARCHAR(50) NOT NULL,              
    Email VARCHAR(100) NOT NULL UNIQUE,         
    Address VARCHAR(255),                       
    ShopType VARCHAR(50),                       
    PhoneNo NVARCHAR(15) NOT NULL UNIQUE,        
    ShopRegistrationNo NVARCHAR(50) UNIQUE       
);


INSERT INTO Shopkeeper (FirstName, LastName, Email, Address, ShopType, PhoneNo, ShopRegistrationNo)
VALUES 
('John', 'Doe', 'john.doe@example.com', '123 Elm St, Springfield', 'Grocery', '1234567890', 'REG123456'),
('Jane', 'Smith', 'jane.smith@example.com', '456 Maple Ave, Riverdale', 'Clothing', '0987654321', 'REG987654'),
('Michael', 'Johnson', 'michael.johnson@example.com', '789 Oak Dr, Gotham', 'Electronics', '2345678901', 'REG234567'),
('Emily', 'Williams', 'emily.williams@example.com', '135 Pine St, Metropolis', 'Bakery', '3456789012', 'REG345678'),
('David', 'Brown', 'david.brown@example.com', '246 Birch Rd, Star City', 'Furniture', '4567890123', 'REG456789'),
('Sophia', 'Jones', 'sophia.jones@example.com', '357 Cedar Ln, Central City', 'Pharmacy', '5678901234', 'REG567890'),
('Daniel', 'Garcia', 'daniel.garcia@example.com', '468 Willow St, Coast City', 'Hardware', '6789012345', 'REG678901'),
('Isabella', 'Martinez', 'isabella.martinez@example.com', '579 Ash Blvd, Bludhaven', 'Bookstore', '7890123456', 'REG789012'),
('James', 'Lopez', 'james.lopez@example.com', '680 Oak Ave, Smallville', 'Jewelry', '8901234567', 'REG890123'),
('Olivia', 'Gonzalez', 'olivia.gonzalez@example.com', '791 Sycamore St, Keystone City', 'Footwear', '9012345678', 'REG901234'),
('Matthew', 'Lee', 'matthew.lee@example.com', '902 Poplar Ln, National City', 'Grocery', '0123456789', 'REG012345'),
('Charlotte', 'Clark', 'charlotte.clark@example.com', '123 Chestnut St, Hub City', 'Clothing', '1238904567', 'REG135790'),
('Lucas', 'Kim', 'lucas.kim@example.com', '456 Walnut St, Hill Valley', 'Electronics', '7892340123', 'REG975321'),
('Amelia', 'Davis', 'amelia.davis@example.com', '789 Redwood Dr, Greenfield', 'Furniture', '6543210987', 'REG246801'),
('Ethan', 'Morris', 'ethan.morris@example.com', '135 Cedar Dr, River City', 'Bakery', '3450126789', 'REG112233');



CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),     
    ShopkeeperID INT NOT NULL,                   
    ProductCategory NVARCHAR(50),                
    ProductName NVARCHAR(100) NOT NULL,          
    Quantity INT NOT NULL,                       
    CustomerID INT,                              
    Price DECIMAL(10, 2) NOT NULL,              
    Discount DECIMAL(5, 2),
    UnitInStock INT NOT NULL,                    
    CONSTRAINT FK_Shopkeeper FOREIGN KEY (ShopkeeperID) REFERENCES Shopkeeper(ShopkeeperID),
    CONSTRAINT FK_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Products (ShopkeeperID, ProductCategory, ProductName, Quantity, CustomerID, Price, Discount, UnitInStock)
VALUES 
(1, 'Grocery', 'Organic Apple', 50,1, 2.50, 0.00, 500),
(2, 'Clothing', 'Men’s Cotton T-shirt', 100,1, 15.99, 5.00, 150),
(3, 'Electronics', 'Wireless Headphones', 30,2, 45.99, 10.00, 70),
(4, 'Bakery', 'Chocolate Cake', 10,3, 12.00, 0.50, 40),
(5, 'Furniture', 'Wooden Coffee Table', 5,5, 120.00, 15.00, 10),
(6, 'Pharmacy', 'Vitamin D Supplements', 200,8, 9.99, 1.00, 300),
(7, 'Hardware', 'Hammer', 50,6, 14.99, 2.00, 100),
(8, 'Bookstore', 'Fiction Novel', 70,7, 18.50, 0.00, 120),
(9, 'Jewelry', 'Gold Necklace', 5,9, 499.99, 25.00, 7),
(10, 'Footwear', 'Running Shoes', 40,4, 60.00, 10.00, 90),
(1, 'Grocery', 'Almond Milk', 100,3, 3.99, 0.00, 250),
(2, 'Clothing', 'Women’s Dress', 50,5, 29.99, 7.00, 80),
(3, 'Electronics', 'Smartphone', 20,7, 599.99, 50.00, 30),
(4, 'Bakery', 'Gluten-Free Bread', 25,8, 4.50, 0.20, 60),
(5, 'Furniture', 'Office Chair', 15,10, 75.00, 5.00, 25);



CREATE TABLE Sales (
    SalesID INT PRIMARY KEY IDENTITY(1,1),       
    ProductID INT NOT NULL,                      
    ShopkeeperID INT NOT NULL,                   
    SalesMonth INT CHECK (SalesMonth >= 1 AND SalesMonth <= 12), 
    SalesYear INT,                               
    SalesDate DATE DEFAULT GETDATE(),           
    CONSTRAINT FK_Product FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT FK_SalesShopkeeper FOREIGN KEY (ShopkeeperID) REFERENCES Shopkeeper(ShopkeeperID)
);


INSERT INTO Sales (ProductID, ShopkeeperID, SalesMonth, SalesYear, SalesDate)
VALUES 
(1, 1, 1, 2024, '2024-01-15'),
(2, 2, 2, 2024, '2024-02-20'),
(3, 3, 3, 2024, '2024-03-10'),
(4, 4, 4, 2024, '2024-04-05'),
(5, 5, 5, 2024, '2024-05-25'),
(6, 6, 6, 2024, '2024-06-12'),
(7, 7, 7, 2024, '2024-07-18'),
(8, 8, 8, 2024, '2024-08-22'),
(9, 9, 9, 2024, '2024-09-30'),
(10, 10, 10, 2024, '2024-10-15'),
(11, 1, 11, 2024, '2024-11-05'),
(12, 2, 12, 2024, '2024-12-19'),
(13, 3, 1, 2025, '2025-01-11'),
(14, 4, 2, 2025, '2025-02-07'),
(15, 5, 3, 2025, '2025-03-03');



CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),    
    CustomerName NVARCHAR(100) NOT NULL,         
    PhoneNo NVARCHAR(15) NOT NULL UNIQUE,        
    Quantity INT,                                
    City NVARCHAR(50),                           
    EmailID NVARCHAR(100) UNIQUE                 
);

INSERT INTO Customer (CustomerName, PhoneNo, Quantity, City, EmailID)
VALUES 
('Alice Johnson', '9876543210', 3, 'Springfield', 'alice.johnson@example.com'),
('Bob Smith', '8765432109', 5, 'Riverdale', 'bob.smith@example.com'),
('Charlie Brown', '7654321098', 2, 'Gotham', 'charlie.brown@example.com'),
('Diana Prince', '6543210987', 1, 'Metropolis', 'diana.prince@example.com'),
('Ethan Hunt', '5432109876', 4, 'Star City', 'ethan.hunt@example.com'),
('Fiona Davis', '4321098765', 6, 'Central City', 'fiona.davis@example.com'),
('George Miller', '3210987654', 2, 'Coast City', 'george.miller@example.com'),
('Hannah Lee', '2109876543', 3, 'Bludhaven', 'hannah.lee@example.com'),
('Ian Thompson', '1098765432', 1, 'Smallville', 'ian.thompson@example.com'),
('Jessica Williams', '9087654321', 5, 'Keystone City', 'jessica.williams@example.com'),
('Kyle Reed', '8098765432', 4, 'National City', 'kyle.reed@example.com'),
('Lily Clark', '7098765431', 2, 'Hub City', 'lily.clark@example.com'),
('Mason Evans', '6098765430', 7, 'Hill Valley', 'mason.evans@example.com'),
('Natalie Green', '5098765429', 3, 'Greenfield', 'natalie.green@example.com'),
('Owen Harris', '4098765428', 2, 'River City', 'owen.harris@example.com'),
('Paige Martin', '3098765427', 5, 'Springfield', 'paige.martin@example.com'),
('Quinn Turner', '2098765426', 1, 'Riverdale', 'quinn.turner@example.com'),
('Ryan Scott', '1098765425', 6, 'Gotham', 'ryan.scott@example.com'),
('Sophia Carter', '9087654320', 4, 'Metropolis', 'sophia.carter@example.com'),
('Tyler Adams', '8087654321', 2, 'Star City', 'tyler.adams@example.com');

select *from Shopkeeper
select * from Products
select *from Sales
select *from Customer

select ProductCategory , MAX(PRICE) AS TotalPrice
FROM Products
Group by ProductCategory





select Shopkeeper.FirstName as Info, Shopkeeper.Email, Products.ProductName, Sales.SalesDate
FROM Shopkeeper
INNER JOIN Products ON Shopkeeper.ShopkeeperID = Products.ShopkeeperID
INNER JOIN Sales ON Products.ProductID = Sales.ProductID






select	DISTINCT ShopRegistrationNo FROM Shopkeeper


SELECT CONCAT(FirstName, ' ', LastName) AS Full_name
FROM Shopkeeper;

SELECT SUM(Quantity) AS total_Quantity
FROM Products;


SELECT FirstName
FROM Shopkeeper
INNER JOIN Products
ON Shopkeeper.ShopkeeperID = Products.ProductID

SELECT DISTINCT ProductCategory
FROM Products;

SELECT DISTINCT P.ProductID, P.ProductName ,P.ProductCategory,S.FirstName, S.LastName, Sa.SalesDate
FROM Shopkeeper S
JOIN Products P ON S.ShopkeeperID = P.ShopkeeperID
JOIN Sales Sa ON P.ProductID = Sa.ProductID;

SELECT S.ShopkeeperID,S.FirstName,P.Quantity
FROM Shopkeeper S
JOIN Products P
ON S.ShopkeeperID = P.ShopkeeperID;

select ROUND(AVG(Price), 2) as AVERAGEPRICE
FROM Products

select DISTINCT PhoneNo from Customer Order by PhoneNo DESC

select DISTINCT CustomerName, CustomerID, PhoneNo from Customer Order by PhoneNo DESC


select MIN(Quantity) as TotalQuantity from Products

SELECT COUNT(*)
FROM Products;

SELECT SalesMonth, MAX(SalesID) AS MaxSalesID
FROM Sales
WHERE SalesYear = 2024
GROUP BY SalesMonth;

select ProductName , ProductCategory, Price, ShopRegistrationNo
FROM Products
INNER JOIN Shopkeeper
ON Products.ProductID=Shopkeeper.ShopkeeperID

SELECT ProductCategory, COUNT(*) AS ProductCount
FROM Products
GROUP BY ProductCategory;

Select Email FRom Shopkeeper Where Email like '_a%'
Select Email FRom Shopkeeper Where Email like '%a%'

select ROUND(AVG(Quantity), 2) as AVERAGEQuantity
FROM Customer
select AVG(Quantity) as AVERAGEQuantity
FROM Customer

select  CustomerName FROM Customer WHERE CustomerName
LIKE 'a%';

select * From Sales ORDER BY  SalesDate;

select ProductName , ProductCategory, Price, SalesMonth
FROM Products
INNER JOIN Sales
ON Products.ProductID=Sales.SalesID
WHERE SalesMonth BETWEEN 1 AND 5

SELECT ProductID,ProductName,Price,Discount,
CAST(ROUND((Price - (Price * Discount / 100)),2) AS DECIMAL(10, 2))AS FinalPrice
FROM Products;

UPDATE Shopkeeper
SET PhoneNo = '9876543210'
WHERE ShopkeeperID = 1;


