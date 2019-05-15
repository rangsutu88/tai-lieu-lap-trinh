/*
Day la chuong trinh tao Trigger kiem tra thao tac xoa du lieu trong bang Class 
*/
use QLDIEM
GO
IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Trigg1' AND type = 'TR')
   DROP TRIGGER Trigg1
GO
---------------------------------
CREATE TRIGGER Trigg1 ON Class
FOR DELETE
AS
BEGIN
 declare @mClassCode varchar(10)
 if (select count(*)from Deleted)>1
   begin
    print 'Chi xoa duoc motlop '
   rollback transaction
  end  
 set @mClassCode = (select classcode from Deleted)
 if exists(select ClassCode from Student where ClassCode=@mClassCode)
  begin
   print 'Khong the xoa duoc lop ' + @mClassCode + ' vi trong lop con sinh vien'
   rollback transaction
  end 
END
GO
--Thu xoa du lieu
delete from Class
delete from Class where classcode='C0611L'
GO
select * from Class
