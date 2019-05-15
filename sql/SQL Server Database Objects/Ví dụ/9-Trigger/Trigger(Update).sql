--Thu thao tac Update
use QLDIEM
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'Trigg1' AND type = 'TR')
   DROP TRIGGER Trigg1
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'Trigg2' AND type = 'TR')
   DROP TRIGGER Trigg2
GO
---------------------------------
--Trigger sau day ngan khong cho sua ClassCode
CREATE TRIGGER Trigg1 ON Class
FOR UPDATE
AS
BEGIN
 if (select classcode from deleted) not in (select classcode from Inserted)
  begin
   print 'Khong the thay doi ma lop'
   rollback
  end 
END
GO
--Thu cap nhat du lieu
update Class set ClassCode='T0611L' where ClassCode='C0611L'
GO
--Co the viet don gian hon nhu sau:
CREATE TRIGGER Trigg2
ON Class 
FOR UPDATE AS
IF UPDATE (Room)
BEGIN
	PRINT 'You cannot modify the Room!'
	ROLLBACK TRANSACTION
END
GO
--Thu cap nhat du lieu
--update Class set Room='abcd' where ClassCode='C0611L'
--GO
--Neu gia tri thuc ra khong thay doi thi SQL van cho rang co su cap nhat va thong bao
update Class set Room='Class 1, Lab 1' where ClassCode='C0611L'
GO