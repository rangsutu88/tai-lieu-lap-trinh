--CREATE DATABASE THU
--GO
use THU
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'T1' AND type = 'U')
   DROP TABLE T1
GO   
CREATE TABLE T1 (c1 INT null, c2 varchar(10), c3 int) 
GO
IF not EXISTS(SELECT c1,c2 FROM T1)
 Begin
  INSERT INTO T1 values(7,'A1',11)
  INSERT INTO T1 values(3,'B2',12)
  INSERT INTO T1 values(3,'B1',13)
  INSERT INTO T1 values(3,'B3',13)
  INSERT INTO T1 values(2,'C1',14)
  INSERT INTO T1 values(1,'E1',14)
  INSERT INTO T1 values(4,'D1',15)
 end
GO
select * from T1
GO
--Dong lenh sau day se bao loi, vi khong the tao unique index khi cot co gia tri lap lai
IF EXISTS (SELECT name FROM THU..sysindexes WHERE name = 'c1_index')
DROP INDEX T1.c1_index
create unique nonclustered index c1_index1 on T1 (c1)
create unique clustered index c1_index2 on T1 (c1)
GO
create clustered index c1_index on T1 (c1,c2)
select * from T1
GO

