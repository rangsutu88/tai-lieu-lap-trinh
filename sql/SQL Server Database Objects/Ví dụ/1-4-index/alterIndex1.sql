IF EXISTS(SELECT * FROM sysobjects WHERE name = 'THU' AND type = 'U')
   DROP TABLE THU
GO   
CREATE TABLE THU (c1 INT null, c2 varchar(10)) 
GO
INSERT INTO THU values(7,'A1')
INSERT INTO THU values(3,'B1')
INSERT INTO THU values(2,'C1')
INSERT INTO THU values(1,'E1')
INSERT INTO THU values(4,'D1')
GO
IF EXISTS (SELECT * FROM QLDiem..sysindexes WHERE name = 'THU_index1')
DROP INDEX THU.THU_index1
GO
create nonclustered index THU_index1 on THU (c1)
go
alter index THU_index1 on QLDiem.THU rebuild;
