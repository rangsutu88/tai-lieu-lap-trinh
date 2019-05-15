use THU
drop function dbo.f1
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
CREATE function dbo.f1()
 returns table
AS
return
(SELECT c1 FROM T1)
GO
select * from dbo.f1()
GO
