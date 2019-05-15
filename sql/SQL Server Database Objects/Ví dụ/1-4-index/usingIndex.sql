--CREATE DATABASE THU
--GO
use THU
GO
if exists (select name from sysobjects where name='T1' and type='U')
 drop table T1
GO   
CREATE TABLE T1 (c1 INT null, c2 varchar(10)) 
--CREATE TABLE T1 (c1 INT primary key, c2 varchar(10)) 
GO
IF not EXISTS(SELECT c1,c2 FROM T1)
 Begin
  INSERT INTO T1 values(7,'A1')
  INSERT INTO T1 values(3,'B1')
  INSERT INTO T1 values(6,'F1')
  INSERT INTO T1 values(2,'C1')
  INSERT INTO T1 values(1,'E1')
  INSERT INTO T1 values(4,'D1')
 end
GO
IF EXISTS (SELECT name FROM THU..sysindexes WHERE name = 'c1_index')
DROP INDEX T1.c1_index
create nonclustered index c1_index on T1 (c1)
GO
select * from T1
GO
select * from T1 where c1 in ('3','2','4','1')
GO
select * from T1 (index=c1_index) where c1 in ('3','2','4','1')
GO
drop index T1.c1_index
GO
/*Co the thay rang khi co them dieu kien where thi sql server moi tan dung index de hien thi
du lieu, va do do du lieu duoc sap xep neu dieu kien where lien quan den cot duoc index
Neu dieu kien where lai lien quan den cot khac thi khong nhu vay*/
select * from T1 where c2 in ('F1','E1','D1')
GO
