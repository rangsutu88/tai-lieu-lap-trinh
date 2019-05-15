--CREATE DATABASE THU
--GO
use THU
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'T1' AND type = 'U')
   DROP TABLE T1
GO   
CREATE TABLE T1 (c1 INT null, c2 varchar(10)) 
--CREATE TABLE T1 (c1 INT primary key, c2 varchar(10)) 
GO
IF not EXISTS(SELECT c1,c2 FROM T1)
 Begin
  INSERT INTO T1 values(7,'A1')
  INSERT INTO T1 values(3,'B1')
  INSERT INTO T1 values(2,'C1')
  INSERT INTO T1 values(1,'E1')
  INSERT INTO T1 values(4,'D1')
 end
GO
select * from T1
GO
IF EXISTS (SELECT name FROM THU..sysindexes WHERE name = 'c1_index')
DROP INDEX T1.c1_index
create nonclustered index c1_index on T1 (c1)
select * from T1
GO

