USE QLDiem
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'func1' AND type = 'IF')
   DROP FUNCTION func1

IF EXISTS(SELECT name FROM sysobjects WHERE name = 'func2' AND type = 'IF')
   DROP FUNCTION func2
GO
-------------------------------------------------------
CREATE FUNCTION dbo.func1()
RETURNS TABLE
AS 
 return (SELECT * From Class)
GO
-------------------------------------------------------
CREATE FUNCTION dbo.func2(@pClassCode varchar(20)='%')
RETURNS TABLE
AS 
 return (SELECT * From Class where classCode like @pClassCode)
GO
-------------------------------------------------------
select * from func1()

declare @mm varchar(20)
set @mm='C%'
select * from func2(@mm)
GO
