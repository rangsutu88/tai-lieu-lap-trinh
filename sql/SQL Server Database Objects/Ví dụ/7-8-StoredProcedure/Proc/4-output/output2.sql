use THU
GO
IF EXISTS(SELECT name FROM sysobjects  WHERE name = 'proc1' AND type = 'P')
   DROP PROC proc1
GO
CREATE procedure proc1
@pFullName varchar(50),@pAge int,@pFirstName varchar(20) OUTPUT
AS
Begin
 declare @i int, @n int
 set @n=len(@pFullName)
 set @i=charindex(' ',@pFullName,1);
 if @i=0
   set @pFirstName=''
   else
   set @pFirstName=left(@pFullName,@i-1)
 print 'Ho ten: '+ @pFullName
 print 'Tuoi: '+ convert(varchar(20),@pAge)
End
GO
declare @mFirstName varchar(20)
exec proc1 'Hoang Van Hung',34,@mFirstName OUTPUT
print 'Ho: '+ @mFirstName
GO
