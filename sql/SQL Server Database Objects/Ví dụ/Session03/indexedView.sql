use QLDiem
GO
IF EXISTS(SELECT * FROM SysObjects WHERE NAME = 'view1' and TYPE='V')
   DROP VIEW view1
GO
CREATE VIEW view1  with SCHEMABINDING
AS
SELECT HeadTeacher, stud_no from dbo.Class
GO
select * from view1
GO
create unique clustered index idx1 on view1 (stud_no)
GO
select * from view1 where stud_no>18
 