--Function Based Query
CREATE FUNCTION dbo.record(@MaxQuantity DECIMAL(10,2))
RETURNS TABLE
AS
RETURN 
(
    SELECT ProductID, ProductName, Quantity, Price
    FROM Products
    WHERE Quantity > @MaxQuantity
)

--RUN
SELECT * FROM dbo.record(50);


--To Add the firstname & lastname from the Shopkeeper table
CREATE FUNCTION dbo.value(@Value CHAR)
RETURNS TABLE
AS 
RETURN
(
	SELECT CONCAT(FirstName, ' ', LastName) AS Full_name
	FROM Shopkeeper
);
--Run
SELECT * FROM dbo.Value(5);

--
CREATE FUNCTION dbo.combine(@CombineTable NVARCHAR)
RETURNS TABLE
AS
RETURN
(
	SELECT DISTINCT P.ProductID, P.ProductName ,S.FirstName, S.LastName
	FROM Shopkeeper S
	JOIN Products P ON S.ShopkeeperID = P.ShopkeeperID
	JOIN Sales Sa ON P.ProductID = Sa.ProductID
	WHERE SalesMonth BETWEEN 1 AND 5
);
--RUN
SELECT * FROM dbo.combine(10);










--Basic Stored Procedure:
--One non paremeterised SP
CREATE PROCEDURE GetAllData
AS
BEGIN
    SELECT * FROM Shopkeeper;
    SELECT * FROM Products;
    SELECT * FROM Sales;
    SELECT * FROM Customer;
END;
--RUN
EXEC GetAllData


--Paremeterised SP
CREATE PROCEDURE GetProductsByCategory
    @Category NVARCHAR(50)
AS
BEGIN
    SELECT ProductID, ProductName, Price, Quantity, UnitInStock
    FROM Products
    WHERE ProductCategory = @Category;
END;
--Run
EXEC GetProductsByCategory @Category = 'Grocery';
 
--Try & Catch Stored Procedure
CREATE PROCEDURE UpdateDetails
@ShopkeeperID INT,
@ProductName CHAR(50),
@ProductCategory NVARCHAR(50),
@Quantity INT,
@Price INT,
@UnitInStock INT
AS
BEGIN
BEGIN TRY
INSERT INTO Products (ShopkeeperID, ProductName, ProductCategory, Quantity, Price, UnitInStock)
        VALUES (@ShopkeeperID, @ProductName, @ProductCategory, @Quantity, @Price, @UnitInStock);
PRINT 'Order updated successfully';
END TRY
BEGIN CATCH
PRINT 'An error occurred while updating the salary';
END CATCH
END
--RUN
EXEC UpdateDetails 
    @ShopkeeperID = 1, 
    @ProductCategory = 'Electronics', 
    @ProductName = 'Bluetooth Speaker', 
    @Quantity = 20,  
    @Price = 150, 
    @UnitInStock = 50;

SELECT * FROM Products




--CURSOR Based Query.
DECLARE @ShopkeeperID INT, @FirstName NVARCHAR(50), @LastName NVARCHAR(50), @Address NVARCHAR(50);

DECLARE RecordCursor CURSOR FOR
SELECT ShopkeeperID, FirstName, LastName, Address
FROM Shopkeeper

OPEN RecordCursor
FETCH NEXT FROM RecordCursor INTO @ShopkeeperID, @FirstName, @LastName , @Address

WHILE @@FETCH_STATUS=0

BEGIN 
	PRINT 'ShopkeeperID: ' +CAST(@ShopkeeperID AS NVARCHAR(10)) +
	',Name: '+@FirstName+' '+@LastName + ', Address: '+@Address;

	FETCH NEXT FROM RecordCursor INTO @ShopkeeperID, @FirstName,
	@LastName , @Address;
END
CLOSE RecordCursor
DEALLOCATE RecordCursor


--Cursor Based
DECLARE @ProductID INT, @ProductName NVARCHAR(50), @ProductCategory NVARCHAR(50), 
@FirstName NVARCHAR(50), @LastName NVARCHAR(50), @SalesDate DATE;

DECLARE DetailCursor CURSOR FOR
SELECT DISTINCT P.ProductID, P.ProductName ,P.ProductCategory,S.FirstName, S.LastName, Sa.SalesDate
FROM Shopkeeper S
JOIN Products P ON S.ShopkeeperID = P.ShopkeeperID
JOIN Sales Sa ON P.ProductID = Sa.ProductID;

OPEN DetailCursor
FETCH NEXT FROM DetailCursor INTO @ProductID, @ProductName, @ProductCategory,@FirstName, @LastName , @SalesDate

WHILE @@FETCH_STATUS=0

BEGIN 
	 PRINT 'ProductID: ' + CAST(@ProductID AS NVARCHAR(10)) +
          ', Name: ' + @FirstName + ' ' + @LastName + 
          ', ProductName: ' + @ProductName + 
          ', Category: ' + @ProductCategory + 
          ', SalesDate: ' + CAST(@SalesDate AS NVARCHAR(20));

	FETCH NEXT FROM DetailCursor INTO  @ProductID, @ProductName, @ProductCategory,@FirstName, @LastName , @SalesDate
END
CLOSE DetailCursor
DEALLOCATE DetailCursor
