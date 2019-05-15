/*Neu view gom nhieu bang thi khong update duoc*/
use QLDiem
GO
IF EXISTS(SELECT * FROM SysObjects WHERE NAME = 'view1' and TYPE='V')
   DROP VIEW view1
GO
CREATE VIEW view1
AS
SELECT * from Class where Stud_no <22
with CHECK OPTION
GO
select * from Class
go
select * from view1
go
update view1 set HeadTeacher='Hoang Van' where ClassCode='C0609M'
-- Luu y la with CHECK OPTION phai o phia sau SELECT,
-- khac voi SCHEMABINDING  
