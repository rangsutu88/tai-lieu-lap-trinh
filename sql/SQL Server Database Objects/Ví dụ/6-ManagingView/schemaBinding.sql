use QLDiem
GO
IF EXISTS(SELECT * FROM SysObjects WHERE NAME = 'view1' and TYPE='V')
   DROP VIEW view1
GO
CREATE VIEW view1  with SCHEMABINDING
AS
SELECT HeadTeacher from dbo.Class
GO
alter table Class alter column HeadTeacher char(50)
GO
sp_help class  
