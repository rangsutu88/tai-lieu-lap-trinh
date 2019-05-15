use QLDIEM
GO
IF EXISTS(SELECT name FROM sysobjects  WHERE name = 'proc1' AND type = 'P')
   DROP PROC proc1
GO
---------------------------------
CREATE PROC proc1
@maxMark float OUTPUT
AS
BEGIN
 select @maxMark=max(mark) from Mark 
END
---------------------------------
GO
declare @mMax float
exec proc1 @mMax OUTPUT
print 'Maximum mark is ' + cast(@mMax as char(10)) 