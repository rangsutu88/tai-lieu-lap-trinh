/*Neu view gom nhieu bang thi khong update duoc*/
use QLDiem
GO
IF EXISTS(SELECT * FROM SysObjects  WHERE NAME = 'view1' and TYPE='V')
   DROP VIEW view1
GO
CREATE VIEW view1
AS
SELECT a.HeadTeacher, b.RollNo, b.Fullname from Class a Join Student b on a.Classcode=b.ClassCode
GO
select * from view1
  
