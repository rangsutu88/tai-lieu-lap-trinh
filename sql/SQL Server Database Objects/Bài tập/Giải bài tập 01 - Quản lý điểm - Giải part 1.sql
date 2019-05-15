USE QLDIEM
/*Chen cac ban ghi de thu cau 2.a
Hien thi cac lop co ngay ket thuc la 21/10/2003 va khong co sinh vien nao tham gia,
tuc la lop chi dang ky ma khong khai giang
*/
GO		
delete from Class where ClassCode in ('T1234G','T2345H')
GO
insert into Class values ('T1234G','Thu','','','2001-10-21')
insert into Class values ('T1234H','Xem','','','10/21/2001')
GO
delete from Student where ClassCode = 'T1234H' or RollNo='Z123'
GO
insert into Student (RollNo,ClassCode,FullName) values ('Z123','T1234H','Hong Ha')
select * from Class 
select * from Student
GO
--2.1 Hien thi khong lap lai ten nhung sinh vien co dia chi chua chuoi fpt.vn hoac fpt.com.vn  
SELECT DISTINCT FullName FROM Student
WHERE Email LIKE '%fpt.vn%' OR Email LIKE '%fpt.com.vn%'

--2.2 Them rang buoc khoa ngai	
ALTER TABLE STUDENT ADD CONSTRAINT FK_consClassCode FOREIGN KEY (ClassCode) REFERENCES Class
--In Class table ClassCode should be Primary Key
	
--2.3	
/*Hien thi danh sach lop khong co sinh vien va ket thuc ngay 21/10/2001
LEFT JOIN hien thi ca cac ban ghi cua bang 1 ma khong co ban ghi tuong ung trong bang 2
*/ 
SELECT a.* FROM CLASS a LEFT JOIN STUDENT b ON a.ClassCode=b.ClassCode 
 WHERE b.ClassCode IS NULL AND CloseDate='2001-10-21'
--Cung lenh nhu tren nhung chi dung Join thi khong co ban ghi nao hien ra	
SELECT a.* FROM CLASS a JOIN STUDENT b ON a.ClassCode=b.ClassCode 
 WHERE b.ClassCode IS NULL AND CloseDate='2001-10-21'
	
--2.4	
/*Them ban ghi vao bang MARK de thu lenh xoa mot lop cung cac ban ghi lien quan*/
delete from Mark where RollNo='z123' and SubjectCode='HDJ'
GO
insert into Mark (RollNo,SubjectCode,Mark) values ('Z123','HDJ',29.9)
GO

--Thu lai
select * from mark where RollNo='Z123'
--Bat dau xoa

DELETE from MARK WHERE RollNo IN (SELECT RollNo FROM Student a inner join Class b 
 on a.ClassCode=b.ClassCode WHERE CloseDate < '2001-10-22') 
DELETE from Student WHERE ClassCode IN (SELECT ClassCode FROM Class WHERE CloseDate<'2001-10-22') 
DELETE from Class WHERE CloseDate < '2001-10-22' 
	
--2.5	
/* Hien thi ClassCode,  RollNo, FullName và tong so  sinh viên voi moi lop.
Hien thi tong so  sinh viên cho tat ca các lop.*/

SELECT a.ClassCode,a.RollNo,FullName FROM Student a INNER JOIN Mark b
 ON a.RollNo=b.RollNo ORDER BY a.ClassCode 
 COMPUTE count(FullName) BY a.ClassCode 
 COMPUTE count(FullName) 
	
	
--2.6 Tao  view  viewClass1 chua danh sách lop doi voi các lop có hon  17  sinh viên.

create view viewClass1 as
select * from Class where ClassCode in (select ClassCode 
from Student group by ClassCode having count(*)>6)
	
	
--2.7	
/*Hien thi  SubjectCode (mã môn hoc) , SubjectName (tên môn hoc) và so sinh viên dã thi
môn dó voi so sinh viên tham gia dông nhat*/

SELECT a.SubjectCode,a.SubjectName,count(*) FROM Subject a INNER JOIN Mark b
ON a.SubjectCode=b.SubjectCode GROUP BY a.SubjectCode,a.SubjectName HAVING count(*)=
(SELECT TOP 1 count(*) FROM Mark GROUP BY SubjectCode ORDER BY count(*) DESC)
	
--Tao bang CLASS_HIST

if exists (select name from sysobjects where name='Class_hist' and type='U')
 drop table Class_hist
GO

Create Table Class_hist
(ClassCode varchar(10),
 HeadTeacher varchar(30),
 DelDate DateTime
)
GO
IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'TrigDelClass' AND type = 'TR')
   DROP TRIGGER TrigDelClass
GO
---------------------------------

/* Tao Trigger cho thao tac xoa lop. Khi xoa lop thi dua thong tin ClassCode, HeadTeacher
va ngay xoa vao bang Class_Hist*/

CREATE TRIGGER TrigDelClass ON Class
FOR DELETE
AS
Begin
 declare @mClassCode varchar(10)
 set @mClassCode = (select ClassCode from deleted)
 insert into Class_hist (ClassCode, HeadTeacher) (select ClassCode, HeadTeacher from deleted)
 update Class_hist set DelDate=getdate() where ClassCode = @mClassCode 
End
GO


/*Loai bo cac foreign key reference de thu trigger
if exists (select name from SysObjects where name ='FK_consClassCode' and type = 'F')
 ALTER TABLE STUDENT DROP CONSTRAINT FK_consClassCode

if exists (select name from SysObjects where name ='FK_ConsRollNo' and type = 'F')
 ALTER TABLE MARK DROP CONSTRAINT FK_ConsRollNo

if exists (select name from SysObjects where name ='FK_ConsSubjectCode' and type = 'F')
 ALTER TABLE MARK DROP CONSTRAINT FK_ConsSubjectCode
GO
*/
delete from Class where ClassCode='T1234G'
GO

/*
Su dung cursor hien thi classcode, rollno, fullname cua sinh vien o ban ghi chan trong bang
sinh vien
*/
declare cur1 cursor for select classcode, rollno,fullname from Student
GO
open cur1
GO
declare @mClasscode varchar(10),@mRollno varchar(10), @mFullname varchar(30)
declare @i int
set @i=1
FETCH NEXT FROM cur1 into @mClasscode,@mRollno, @mFullname
while @@Fetch_status=0
 begin
  if @i%2=0
    print @mClasscode+' '+@mRollno+' '+@mFullname
    FETCH NEXT FROM cur1 into @mClasscode,@mRollno, @mFullname
    set @i=@i+1
 end
CLOSE Cur1
DEALLOCATE Cur1

/*
Su dung cursor sua lai gia tri mark = 25  cua cac sinh vien o ban ghi 3, 6, 9,... trong bang
sinh vien
*/
declare cur2 cursor for select Rollno from Mark
GO
open cur2
GO
declare @mRollno varchar(10)
declare @i int
set @i=1
--Su dung into de khong hien thi ra man hinh
FETCH NEXT FROM cur2 into @mRollno
while @@Fetch_status=0
 begin
  if @i%3=0
    UPDATE Mark SET mark = 25 WHERE CURRENT OF cur2
    FETCH NEXT FROM cur2 into @mRollno
    set @i=@i+1
 end
CLOSE Cur2
DEALLOCATE Cur2
select Rollno, mark from mark
