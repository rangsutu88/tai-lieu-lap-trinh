/*
Day la chuong trinh tao Trigger trong csdl QLDIEM nhung ket qua chua dung 
*/
use QLDIEM
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'Trigg1' AND type = 'TR')
   DROP TRIGGER Trigg1
GO
---------------------------------
CREATE TRIGGER Trigg1 ON Class
INSTEAD OF INSERT 
AS
BEGIN
 if (select count(*) from Inserted)>1
   Begin
    print 'Chi chen mot ban ghi thoi'
    ROLLBACK TRANSACTION
   end
   else
   Begin
    if (select top 1 left(ClassCode,1) from Inserted) not in ('C','T')
     Begin
       print 'Chu cai dau tien cua ClassCode phai la C hoac T'
       rollback transaction
     end
    declare @mClassCode varchar(10), @mHeadTeacher varchar(30), @mRoom varchar(30), @mTimeSlot varchar(30),@mStud_no smallint
    set @mClassCode = (select top 1 ClassCode from Inserted)  
    set @mHeadTeacher = (select top 1 HeadTeacher from Inserted)  
    set @mRoom = (select top 1 Room from Inserted)  
    set @mStud_no = (select top 1 Stud_no from Inserted)
    declare @mm varchar(1)
    set @mm = right(@mClassCode,1)
    set @mTimeSlot =
     CASE
       when @mm='G' then '7:30 - 9:30' 
       when @mm='H' then '9:30 - 11:30' 
       when @mm='I' then '13:30 - 15:30' 
       when @mm='K' then '15:30 - 17:30' 
       when @mm='L' then '17:30 - 19:30' 
       when @mm='M' then '19:30 - 21:30' 
       ELSE 'unknown'
     END
     insert into Class values(@mClassCode,@mHeadTeacher,@mRoom,@mTimeSlot,@mStud_no)
   end
END
GO
--Thu chen du lieu
declare @mClassCode varchar(10), @mHeadTeacher varchar(30), @mRoom varchar(30), @mTimeSlot varchar(30),@mStud_no smallint
set @mClassCode='C9999H'
set @mHeadTeacher='xyz'
set @mRoom = 'Class 2, Lab 2'
set @mTimeSlot=''
set @mStud_no=17
insert into Class Values(@mClassCode,@mHeadTeacher,@mRoom,@mTimeSlot,@mStud_no)
insert into Class (classcode, headteacher, TimeSlot) (select classcode, headteacher, TimeSlot from Class)
GO
select * from class
