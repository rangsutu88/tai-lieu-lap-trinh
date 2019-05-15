use qldiem
select * from student

CREATE PROC ins_student 
@RollNo varchar(10),
@ClassCode varchar(10),
@FullName varchar(30),
@Male bit,
@Birthday datetime,
@Address varchar(30),
@Email varchar(30)
AS
	INSERT INTO student VALUES(@RollNo,@ClassCode, @FullName,@Male,@Birthday,@Address,@Email)

exec ins_student 'B101','C0611L','CuongNC',1,'9/1/1990','Ha Noi','BVcuong@yahoo.com'

--insert 1 sinh vien

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

--Store procedure xoa mot sinh vien
CREATE PROC del_Student @id varchar(10)
AS
	DELETE FROM Student WHERE RollNo = @id
--run
exec del_student 'C06'

--store procedure get all student in student table
CREATE PROC sp_student_list
AS
	SELECT * FROM Student

exec sp_student_list

- Dem so sinh vien trong bang student
CREATE PROC sp_count_student @count int OUTPUT
AS
	set @count = (SELECT COUNT(*) FROM student)

declare @count int
exec sp_count_student @count output
print @count

-- cau lenh return
CREATE PROC sp_number_student
AS
	declare @num int
	set @num = (SELECT COUNT(*) FROM student)
	return @num

declare @sosv int
exec @sosv = sp_number_student
print @sosv

-- Modify store procedure
ALTER PROC sp_number_student
with recompile
AS
	declare @num int
	set @num = (SELECT COUNT(*) FROM student)
	return @num

-- drop
DROP PROC sp_number_student
-- view store procedure

sp_helptext sp_count_student

-- sp_depends

sp_depends 'ins_student'

---Nested procedure
CREATE PROC sp_class_list
WITH ENCRYPTION
AS
	exec sp_student_list
	SELECT * FROM class

exec sp_class_list
--
SELECT @@VERSION
SELECT @@ERROR