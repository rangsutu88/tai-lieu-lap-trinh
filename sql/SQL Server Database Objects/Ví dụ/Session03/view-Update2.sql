/*Update table thong qua view*/
use THU
GO

IF EXISTS(SELECT NAME FROM SysObjects
   WHERE NAME = 'T1' and TYPE='U')
   DROP TABLE T1
GO   
CREATE TABLE T1(c1 VARCHAR(10), c2 int) 
GO
INSERT INTO T1 values('A01', 11)
INSERT INTO T1 values('A02', 12)
GO
IF EXISTS(SELECT NAME FROM SysObjects
   WHERE NAME = 'v1' and TYPE='V')
   DROP VIEW v1
GO
CREATE VIEW v1
AS
SELECT * FROM T1
GO
SELECT * FROM T1
GO
update v1 set c2=99 where c1='A01'
GO
SELECT * FROM T1
GO
