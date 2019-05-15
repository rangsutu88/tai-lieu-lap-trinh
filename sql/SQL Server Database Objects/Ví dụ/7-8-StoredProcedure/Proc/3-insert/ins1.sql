--create database THU
--GO
use THU
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'proc1' AND type = 'P')
   DROP PROC proc1
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'T1' AND type = 'U')
   DROP TABLE T1
GO
CREATE TABLE T1(c1 VARCHAR(10), c2 int) 
GO
---------------------------------
CREATE PROC proc1
@pC1 varchar(10), @pC2 int
AS
insert into T1 values(@pC1,@pC2)
GO
--Dung proc1 de chen du lieu
declare @i int,@m int, @mC1 varchar(10)
set @i=1
while (@i<=5)
 begin
  set @mC1='A'+convert(varchar(2),@i)
  set @m=10+@i
  exec proc1 @mC1,@m
  set @i=@i+1
 end
GO
exec proc1 'hung',15
GO
select * from T1
GO
