/*Neu view gom nhieu bang thi khong update duoc*/
use QLDiem
GO
IF EXISTS(SELECT * FROM SysObjects WHERE NAME = 'view1' and TYPE='V')
   DROP VIEW view1
GO
CREATE VIEW view1
AS
SELECT * from Class
GO

update view1 set HeadTeacher='Hoang Van Van' where ClassCode='C0611L'
go
select * from Class
  
