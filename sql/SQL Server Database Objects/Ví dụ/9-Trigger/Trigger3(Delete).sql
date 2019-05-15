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
 if (select count(*) from Class)=0 /*Vi tat ca cac ban ghi trong Class da chuyen sang Deleted*/
  begin 
   print 'Khong the xoa tat ca cac lop'
   rollback transaction
  end
END
GO
--Thu xoa du lieu
delete from Class
delete from Class where classcode='T9999H'
GO
select * from class
