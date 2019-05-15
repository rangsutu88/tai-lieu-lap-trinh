CREATE PROCEDURE spAllCustomers
AS
Select * from Customers


CREATE PROCEDURE #spAllCustomers2
AS
Select * from Customers


CREATE PROCEDURE ##spAllCustomers3
AS
Select * from Customers

--spAllCustomers
EXEC ##spAllCustomers3
GO

ALTER PROCEDURE spGetProductRange
@toPrice float,
@fromPrice float=0
AS
SELECT * FROM Products 
WHERE UnitPrice BETWEEN @fromPrice AND @toPrice

EXEC spGetProductRange 20


ALTER PROCEDURE spGetProductRange2
@fromPrice float,
@toPrice float,
@count int OUTPUT
AS
SELECT * FROM Products 
WHERE UnitPrice BETWEEN @fromPrice AND @toPrice
SET @count = @@ROWCOUNT
return @count


DECLARE @totalProduct int
EXEC spGetProductRange2 15, 20, @totalProduct output
PRINT @totalProduct

/*
DECLARE @totalProduct int
DECLARE @result int
EXEC @result = spGetProductRange2 15, 20, @totalProduct output
print @result
*/
sp_depends spGetProductRange2


CREATE PROC spTestTRYCATCH
AS
BEGIN TRY
EXEC spAllCustomers
END TRY
BEGIN CATCH
Print 'spGetProductRange2 error'
END CATCH

EXEC spTestTRYCATCH

DROP PROCEDURE spAllCustomers
EXEC spTestTRYCATCH