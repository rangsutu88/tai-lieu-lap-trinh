USE QLDIEM
GO
--1. Liet ke danh sách lop cung so sinh vien thuc te (tinh tu bang Student)
--Cach thu nhat
select a.ClassCode, a.HeadTeacher, 
 (SELECT count(b.ClassCode) FROM student b WHERE b.ClassCode = a.ClassCode)
  as countStud_no FROM Class a

--Cach thu hai
select a.ClassCode, a.HeadTeacher, count(b.ClassCode) as countStud_no 
   from Class a inner join Student b on a.ClassCode = b.ClassCode
   group by a.ClassCode, a.HeadTeacher order by a.ClassCode

--2. Tao them cot Stud_no trong bang Class, sau do cap nhat thong tin cho truong nay tu 
--bang student

alter table Class add Stud_no smallint
GO
UPDATE Class
   SET  
    stud_no=(SELECT count(ClassCode)FROM student WHERE Student.ClassCode = Class.ClassCode)
   FROM Class, Student

--3. Liet ke cac ban ghi ma so lieu ve stud_no khong khop giua hai bang Class va Student
--Cach thu nhat
select a.ClassCode, a.HeadTeacher,a.Stud_no, 
 (SELECT count(b.ClassCode) FROM student b WHERE b.ClassCode = a.ClassCode)
  as countStud_no FROM Class a where a.stud_no <> 
 (SELECT count(b.ClassCode) FROM student b WHERE b.ClassCode = a.ClassCode)

--Cach thu hai
select a.ClassCode, a.HeadTeacher,a.Stud_no, count(b.ClassCode) as countStud_no 
   from Class a inner join Student b on a.ClassCode = b.ClassCode
   group by a.ClassCode, a.HeadTeacher, a.Stud_No having a.Stud_no<>count(b.ClassCode) 
order by a.ClassCode

--4. Viet stored procedure tao bang T1 
if exists (select name from sysobjects where name = 'proc1' and type='P')
 drop procedure proc1

create procedure proc1 
as
begin
 if exists (select name from sysobjects where name='T1' and type='U')
  drop table T1
 select a.ClassCode, a.HeadTeacher, count(b.ClassCode) as countStud_no 
   into T1 from Class a left outer join Student b on a.ClassCode = b.ClassCode
   group by a.ClassCode, a.HeadTeacher order by a.ClassCode
end

exec proc1
--5. Viet ham tra ve so sinh vien trong lop.

if exists (select name from sysobjects where name = 'func1' and type='FN')
 drop function func1
GO
CREATE function func1(@pClassCode varchar(10))
returns smallint
AS
Begin
  declare @m int
  set @m=(select count(*) from Student where ClassCode = @pClassCode)
 return @m
End

declare @mClassCode as varchar(10),@n as int
set @mClassCode='C0611L'
set @n=dbo.func1(@mClassCode)
print 'Number of students in '+ @mClassCode + ' = ' +convert(varchar(10),@n)
GO
/*Chi chu: Khi khai bao co the khong can, nhung khi su dung ham thi phai chi ro owner name
cua co so du lieu. Owner name phai la user da ton tai*/

select classcode, dbo.func1(ClassCode) as countStud_no from Class
GO

--6 Viet stored procedure tim sinh vien co diem thi cao nhat trong lop voi mon thi cho truoc 
--Su dung bien toan cuc
if exists (select name from sysobjects where name = 'proc2' and type='P')
 drop procedure proc2
GO
CREATE procedure proc2
@pClassCode varchar(10),@pSubjectCode varchar(10), @@pRollNo varchar(10) OUTPUT
AS
Begin
  select @@pRollNo=(select top 1 a.rollno from mark a inner join student b on
   a.rollno=b.rollno where b.ClassCode = @pClassCode and a.SubjectCode =@pSubjectCode
   order by mark desc)
end
GO

declare @@mRollNo as varchar(10)
exec proc2 'C0611L','CF',@@mRollNo OUTPUT
print 'Top Student = '+ @@mRollNo
select classCode, rollno, fullname,@@mRollNo as topRollNo from Student where RollNo=@@mRollNo

exec proc2 'T0611H','CF',@@mRollNo OUTPUT
print 'Top Student = '+ @@mRollNo
select classCode, rollno, fullname,@@mRollNo as topRollNo from Student where RollNo=@@mRollNo

--7 Viet ham tra ve ma so sinh vien co diem thi cao nhat trong lop voi mon thi cho truoc 
if exists (select name from sysobjects where name = 'func2' and type='FN')
 drop function func2
GO
CREATE function func2(@pClassCode varchar(10),@pSubjectCode varchar(10))
returns varchar(10)
AS
Begin
  declare @m varchar(10)
  set @m=(select top 1 a.rollno from mark a inner join student b on
   a.rollno=b.rollno where b.ClassCode = @pClassCode and a.SubjectCode =@pSubjectCode
   order by mark desc)
  return @m
End

declare @mClassCode as varchar(10),@mSubjectCode as varchar(10), @mRollNo as varchar(10) 
set @mClassCode='C0611L'
set @mSubjectCode='CF'
set @mRollNo=dbo.func2(@mClassCode,@mSubjectCode)
print 'Information about the student with highest mark ('+ @mRollNo + '):'
select a.classcode, @mRollNo as RollNo, b.SubjectCode, b.mark from
Student a, Mark b where a.RollNo=b.RollNo
 and b.SubjectCode=@mSubjectCode and b.RollNo=@mRollNo 
GO
