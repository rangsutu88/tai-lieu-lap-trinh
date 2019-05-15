use THU
if exists( select name from sysobjects where name='HO' and type='FN')
 drop function dbo.HO
GO
CREATE function dbo.Ho(@pFullName varchar(50))
returns varchar(20)
AS
Begin
 declare @i int, @n int,@mFName varchar(20)
 set @n=len(@pFullName)
 set @i=charindex(' ',@pFullName,1);
 if @i=0
   set @mFName=''
   else
   set @mFName=left(@pFullName,@i-1)
 return(@mFName) 
End
GO
declare @mFullName varchar(50), @mFirstName varchar(20)
set @mFullName='Hoang Van Hung'
set @mFirstName = dbo.Ho(@mFullName)
print 'Ho: '+ @mFirstName
GO
