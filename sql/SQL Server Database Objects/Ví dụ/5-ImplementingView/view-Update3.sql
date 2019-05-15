/*Neu view gom nhieu bang thi khong update duoc*/
use THU
GO
IF EXISTS(SELECT NAME FROM SysObjects
   WHERE NAME = 'Student' and TYPE='U')
   DROP TABLE Student
IF EXISTS(SELECT NAME FROM SysObjects
   WHERE NAME = 'Mark' and TYPE='U')
   DROP TABLE Mark
GO   
CREATE TABLE Student (SoThe VARCHAR(10), HoTen VARCHAR(30)) 
CREATE TABLE Mark (SoThe VARCHAR(10), MonHoc VARCHAR(10), diem decimal) 
GO
INSERT INTO Student values('A01', 'Hoang A')
INSERT INTO Student values('A02', 'Tran B')

INSERT INTO Mark values('A01', 'CF',14.6)
INSERT INTO Mark values('A01', 'C',11.5)
INSERT INTO Mark values('A01', 'HDJ',18.4)

INSERT INTO Mark values('A02', 'CF',11.9)
INSERT INTO Mark values('A02', 'C',18.5)
INSERT INTO Mark values('A02', 'HDJ',12.4)
GO
IF EXISTS(SELECT NAME FROM SysObjects
   WHERE NAME = 'v1' and TYPE='V')
   DROP VIEW v1
GO
CREATE VIEW v1
AS
SELECT s.SoThe, s.HoTen, m.MonHoc,m.Diem from Mark m inner join Student S on
m.SoThe = s.SoThe
GO
select * from v1
GO
--update v1 set Hoten='xyz' where SoThe ='A01'
--select * from v1
GO
/*Lenh sau day khong duoc thuc hien va thong bao la
View or function 'v1' is not updatable because 
the modification affects multiple base tables*/

update v1 set Hoten='xyz',Diem=99  where SoThe ='A01' and MonHoc='CF'
select * from v1
GO

