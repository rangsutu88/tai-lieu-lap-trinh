--CREATE DATABASE THU
--GO
use THU
GO
IF EXISTS(SELECT * FROM sysobjects  WHERE NAME = 'T1' and type='U')
   DROP TABLE T1
GO   
CREATE TABLE T1 (c1 INT null, c2 varchar(10)) 
--CREATE TABLE T1 (c1 INT primary key, c2 varchar(10)) 
GO
IF not EXISTS(SELECT c1,c2 FROM T1)
 Begin
  INSERT INTO T1 values(7,'A1')
  INSERT INTO T1 values(3,'B1')
  INSERT INTO T1 values(3,'B2')
  INSERT INTO T1 values(2,'C1')
  INSERT INTO T1 values(1,'E1')
  INSERT INTO T1 values(4,'D1')
 end
GO
select * from T1
GO
--create clustered index c1_index on T1 (c1)
--create nonclustered index c1_index on T1 (c1)
/*Dong lenh sau se bao loi, vi unique index chi co the duoc tao khi cac cot tao index khong
co gia tri lap lai (gia tri c1 co lap lai)*/
IF EXISTS (SELECT name FROM THU..sysindexes WHERE name = 'c1_index')
DROP INDEX T1.c1_index
create unique nonclustered index c1_index on T1 (c1)
GO
--Nhung neu index gom ca cot c2 thi khong co duplicate key nen tao duoc
create unique clustered index c1_index on T1 (c1,c2)
--Unique index cho phep chen gia tri null, nhung chi mot lan
INSERT INTO T1 values(null,'D1')
GO
--Neu chen gia tri null mot la nua thi bao loi
INSERT INTO T1 values(null,'D1')

