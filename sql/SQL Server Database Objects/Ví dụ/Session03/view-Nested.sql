--Nested view
use THU
GO
IF EXISTS(SELECT NAME FROM SysObjects WHERE NAME = 'v1' and TYPE='V') DROP VIEW v1
IF EXISTS(SELECT NAME FROM SysObjects WHERE NAME = 'v2' and TYPE='V') DROP VIEW v2
IF EXISTS(SELECT NAME FROM SysObjects WHERE NAME = 'v3' and TYPE='V') DROP VIEW v3
GO
IF EXISTS(SELECT NAME FROM SysObjects WHERE NAME = 'T1' and TYPE='U')DROP TABLE T1
IF EXISTS(SELECT NAME FROM SysObjects WHERE NAME = 'T2' and TYPE='U')DROP TABLE T2
IF EXISTS(SELECT NAME FROM SysObjects WHERE NAME = 'T3' and TYPE='U')DROP TABLE T3
GO   
CREATE TABLE T1(c1 int, c2 varchar(10)) 
CREATE TABLE T2(c1 int, c2 varchar(10)) 
CREATE TABLE T3(c1 int, c2 varchar(10)) 
GO
INSERT INTO T1 values(1,'A1')
INSERT INTO T1 values(2,'A2')
INSERT INTO T1 values(3,'A3')
GO
INSERT INTO T2 values(1,'B1')
INSERT INTO T2 values(2,'B2')
INSERT INTO T2 values(4,'B4')
GO
INSERT INTO T3 values(1,'C1')
INSERT INTO T3 values(2,'C2')
INSERT INTO T3 values(5,'C5')
GO
CREATE VIEW v3
AS
SELECT * FROM T3
GO
CREATE VIEW v2
AS
SELECT * FROM T2 where T2.c1 in (select c1 from v3)
GO
CREATE VIEW v1
AS
SELECT * FROM T1 where T1.c1 in (select c1 from v2)
GO
select * from v1