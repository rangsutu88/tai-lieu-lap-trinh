use THU
GO
if exists( select name from sysobjects where name='func1' and type='FN')
 drop function func1
GO
CREATE function func1(@px varchar(20) = 'ABC', @pn int = 2)
returns varchar(20)
AS
Begin
 declare @mx varchar(20)
 if @px is null
  set @mx = ''
  else
  set @mx = left(@px,@pn)
 return(@mx) 
End
GO
declare @a varchar(10)
set @a='Dang Van Hung'
print 'Ket qua 1: '+ dbo.func1(@a,3)
--print 'Ket qua 2: '+ dbo.func1(@a)
--Lenh tren bao loi, vay la khong the co gia tri ngam dinh?
GO
