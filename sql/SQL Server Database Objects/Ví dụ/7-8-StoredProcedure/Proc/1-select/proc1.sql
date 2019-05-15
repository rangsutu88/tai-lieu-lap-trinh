use THU
GO
IF EXISTS(SELECT * FROM sysobjects  WHERE name = 'proc1' AND type = 'P')
   DROP PROC proc1
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'T1' AND type = 'U')
   DROP TABLE T1
GO   
CREATE TABLE T1(c1 VARCHAR(10), c2 int) 
GO
INSERT INTO T1 values('A01', 11)
INSERT INTO T1 values('A02', 12)
INSERT INTO T1 values('B01', 21)
INSERT INTO T1 values('B02', 22)
INSERT INTO T1 values('B03', 23)
GO
CREATE PROC proc1
AS
SELECT * FROM T1
GO
proc1
GO
