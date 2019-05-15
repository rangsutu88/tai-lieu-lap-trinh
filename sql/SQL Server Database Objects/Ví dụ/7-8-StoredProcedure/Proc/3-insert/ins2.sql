use QLDIEM
GO
IF EXISTS(SELECT name FROM sysobjects  WHERE name = 'proc1' AND type = 'P')
   DROP PROC proc1
GO
---------------------------------
CREATE PROC proc1
@pClassCode varchar(10), @pHeadTeacher varchar(30), @pRoom varchar(30), @pTimeSlot varchar(30),@pStud_no smallint
AS
BEGIN
 set @pClassCode = UPPER(@pClassCode)
 declare @mm varchar(1)
 if left(@pClassCode,1) not in ('C','T')
   Begin
    print 'Chu cai dau tien cua ClassCode phai la C hoac T'
    return
   end
 set @mm = right(@pClassCode,1)
 set @pTimeSlot =
  CASE
    when @mm='G' then '7:30 - 9:30' 
    when @mm='H' then '9:30 - 11:30' 
    when @mm='I' then '13:30 - 15:30' 
    when @mm='K' then '15:30 - 17:30' 
    when @mm='L' then '17:30 - 19:30' 
    when @mm='M' then '19:30 - 21:30' 
    ELSE 'unknown'
  END
  insert into Class (ClassCode,HeadTeacher,Room,TimeSlot,Stud_no) 
    values(@pClassCode,@pHeadTeacher,@pRoom,@pTimeSlot,@pStud_no)
END
---------------------------------
GO
--Dung proc1 de chen du lieu
declare @mClassCode varchar(10), @mHeadTeacher varchar(30), @mRoom varchar(30), @mTimeSlot varchar(30),@mStud_no smallint
set @mClassCode='C1234H'
exec proc1 @mClassCode,@mHeadTeacher,@mRoom,@mTimeSlot,@mStud_no
GO
select * from Class