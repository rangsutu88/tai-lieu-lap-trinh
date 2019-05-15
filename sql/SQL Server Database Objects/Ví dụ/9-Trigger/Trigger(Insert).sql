/*
Day la chuong trinh tao Trigger trong csdl QLDIEM 
*/
use QLDIEM
GO
IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Trigg1' AND type = 'TR')
   DROP TRIGGER Trigg1
GO
---------------------------------
CREATE TRIGGER Trigg1 ON Class
FOR INSERT
AS
BEGIN
 if (select count(*) from Inserted)>1
   Begin
    print 'Chi chen mot ban ghi thoi'
    rollback tran
   end
 if (select left(ClassCode,1) from Inserted) not in ('C','T')
   Begin
    print 'Chu cai dau tien cua ClassCode phai la C hoac T'
    rollback tran
   end
END
GO
--Thu chen du lieu
declare @mClassCode varchar(10), @mHeadTeacher varchar(30), @mRoom varchar(30), @mTimeSlot varchar(30),@mStud_no smallint
set @mClassCode='R1234H'
set @mHeadTeacher='Tuong Van'
set @mRoom = 'Class 2, Lab 2'
set @mTimeSlot=''
set @mStud_no=17
insert into Class Values(@mClassCode,@mHeadTeacher,@mRoom,@mTimeSlot,@mStud_no)
insert into Class (classcode, headteacher, TimeSlot) (select classcode, headteacher, TimeSlot from Class)
GO
