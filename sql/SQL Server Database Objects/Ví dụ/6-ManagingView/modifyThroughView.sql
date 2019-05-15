use QLDiem
GO
IF EXISTS(SELECT * FROM SysObjects WHERE NAME = 'view1' and TYPE='V')
   DROP VIEW view1
GO
CREATE VIEW view1
AS
SELECT * from dbo.Class
GO
select * from view1
GO
insert into view1 (classcode,headTeacher) values ('Z01','Hoang Oang') 
GO
select * from view1
GO
update view1 set HeadTeacher='Hoang Quan' where classcode='Z01'
GO
delete from view1  where classcode='Z01'
GO
select * from view1
