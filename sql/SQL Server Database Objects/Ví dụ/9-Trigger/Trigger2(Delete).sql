/*
Day la chuong trinh tao Trigger kiem tra thao tac xoa du lieu trong bang Class 
*/
use QLDIEM
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'Trigg1' AND type = 'TR')
   DROP TRIGGER Trigg1
GO
---------------------------------
CREATE TRIGGER Trigg1 ON Class
FOR DELETE
AS
BEGIN
 if exists(select classcode from Deleted a where exists (select classcode from Student b
 where b.classcode=a.classcode))
  begin
   print 'Khong the xoa duoc lop vi trong lop con sinh vien'
   rollback
  end 
END
GO
--Thu xoa du lieu
delete from Class
delete from Class where classcode='C0611L'
GO
select * from Class
