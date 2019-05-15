--Create new database (QLDiem)
USE MASTER
GO
--DROP DATABASE QLDiem
--GO
CREATE DATABASE QLDiem
GO
use QLDiem
GO
if exists (select name from sysobjects where name='Mark' and type='U')
 drop table Mark
if exists (select name from sysobjects where name='Subject' and type='U')
 drop table Subject
if exists (select name from sysobjects where name='Student' and type='U')
 drop table Student
if exists (select name from sysobjects where name='Class' and type='U')
 drop table Class
GO
Create Table Class
(ClassCode varchar(10) Primary key,
 HeadTeacher varchar(30),
 Room varchar(30),
 TimeSlot varchar(30),
 Stud_no int,
 CloseDate DateTime
)
GO
--Wtest=1 means that the subject needs a write-test.
Create Table Subject
(SubjectCode varchar(10) Primary key,
 SubjectName varchar(40),
 WTest bit,PTest bit,
 WTest_per smallint,PTest_per as 100-wTest_per
)
GO
Create Table Student
(RollNo varchar(10) Primary key,
 ClassCode varchar(10),
 FullName varchar(30),
 Male bit,
 BirthDate DateTime,
 Address varchar(30),
 Email varchar(30)
)
GO
Create Table Mark
(RollNo varchar(10),
 SubjectCode varchar(10),
 WMark float,
 PMark float,
 Mark float,
 constraint PK_cons Primary key (RollNo,SubjectCode) 
)
GO
alter table Student add constraint FK_ConsClassCode foreign key (ClassCode) references Class 
alter table Mark add constraint FK_ConsRollNo foreign key (RollNo) references Student 
alter table Mark add constraint FK_ConsSubjectCode foreign key (SubjectCode) references Subject 
GO

--Insert data into a table Subject
INSERT INTO Subject (SubjectCode, SubjectName,WTest,PTest,WTest_per)
 VALUES ('CF','Computer Fundamentals',1,0,100)

INSERT INTO Subject (SubjectCode, SubjectName,WTest,PTest,WTest_per)
 VALUES ('C','Elementary Programming with C',1,1,40)

INSERT INTO Subject (SubjectCode, SubjectName,WTest,PTest,WTest_per)
 VALUES ('HDJ','HTML,DHTML & JavaScript',1,1,40)

INSERT INTO Subject (SubjectCode, SubjectName,WTest,PTest,WTest_per)
 VALUES ('DWMX','Web Page Designing with Dreamweaver MX',1,1,40)

INSERT INTO Subject (SubjectCode, SubjectName,WTest,PTest,WTest_per)
 VALUES ('SQL1','SQL 1',1,0,100)

INSERT INTO Subject (SubjectCode, SubjectName,WTest,PTest,WTest_per)
 VALUES ('SQL2','SQL 2',1,1,40)
GO

--Insert data into a table Class
INSERT INTO Class (ClassCode,HeadTeacher,Room,Stud_no,CloseDate)
 VALUES ('C0611L','Phan Dang','Class 1, Lab 1',18,'10/21/2003')

INSERT INTO Class (ClassCode,HeadTeacher,Room,Stud_no,CloseDate)
 VALUES ('C0609M','Nguyen Trung','Class 2, Lab 2',22,'09/25/2004')

INSERT INTO Class (ClassCode,HeadTeacher,Room,Stud_no,CloseDate)
 VALUES ('T0611H','Vu Tran','Class 2, Lab 2',20,'1/5/2006')
GO

--Insert data into a table Student

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('B01','C0609M','Nguyen Hung',1,'11/23/1982','65 Hoang Hoa Tham')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('B02','C0609M','Thanh Binh',1,'10/21/1983','Ha Tay')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('B03','C0609M','Truong Giang',1,'10/19/1986','6 Tran Phu')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('B04','C0609M','Thao Nguyen',1,'1/20/1985','3 Kim Ma')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('B05','C0609M','Kien Tao',1,'10/10/1984','Gia Lam')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('C01','T0611H','Thanh Cong',1,'11/23/1982','65 Hoang Hoa Tham')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('C02','T0611H','Yen Binh',1,'10/21/1983','Ha Tay')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('C03','T0611H','Hoan Tat',1,'10/19/1986','6 Tran Phu')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('C04','T0611H','Manh Dat',1,'1/20/1985','3 Kim Ma')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('C05','T0611H','Phong Le',1,'10/10/1984','Gia Lam')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('C06','T0611H','Xuan Tu',0,'09/11/1986','Nam Dinh')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('A001','C0611L','Nguyen Hung',1,'11/23/1982','65 Hoang Hoa Tham')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address,Email)
 VALUES ('A002','C0611L','Thanh Trong',1,'10/21/1983','Ha Tay','trong@fpt.com.vn')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address,Email)
 VALUES ('A003','C0611L','Dinh Dung',1,'10/19/1986','6 Tran Phu','dung@fpt.vn')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('A004','C0611L','Xuan Nam',1,'1/20/1985','3 Kim Ma')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('A005','C0611L','Dinh Hieu',1,'10/10/1984','Gia Lam')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address,Email)
 VALUES ('A006','C0611L','Huong Thao',0,'09/11/1986','Nam Dinh','thao@yahoo.com')

INSERT INTO Student
(RollNo,ClassCode,FullName,Male,BirthDate,Address)
 VALUES ('A007','C0611L','Thu Huong',0,'10/22/1986','Nam Dinh')
GO

--Insert data into a table Mark
INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('B01','C',11,12.5)
INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('B02','C',23,13.5)
INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('B03','HDJ',17,14.7)
INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('B04','HDJ',24,19.75)
INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('C01','CF',15,16.75)
INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('C02','CF',22,19.7)
INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('C03','CF',18,13.6)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A001','CF',20,0)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A002','CF',23,0)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A003','CF',15,0)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A004','CF',11,0)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A005','CF',9.3,0)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A006','CF',21,0)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A001','C',20,10)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A002','C',23,15)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A003','C',15,11)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A004','C',11,22)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A005','C',9.3,12.5)

INSERT INTO Mark
  (RollNo,SubjectCode,WMark,PMark)
 VALUES ('A006','C',21,14.75)

GO
UPDATE MARK SET mark=0.4*WMark+0.6*PMark
GO
UPDATE MARK SET mark=convert(decimal(4,1),Mark)
GO
-------------------------------------------------
UPDATE CLASS
 set TimeSlot =
  CASE
    when right(ClassCode,1)='G' then '7:30 - 9:30' 
    when right(ClassCode,1)='H' then '9:30 - 11:30' 
    when right(ClassCode,1)='I' then '13:30 - 15:30' 
    when right(ClassCode,1)='K' then '15:30 - 17:30' 
    when right(ClassCode,1)='L' then '17:30 - 19:30' 
    when right(ClassCode,1)='M' then '19:30 - 21:30' 
    ELSE 'unknown'
  END
 
select * from subject
select * from mark

update mark
set mark =0.01*s.wtest_per*m.wmark + 0.01*s.ptest_per*m.pmark 
from mark m inner join subject s
on m.subjectcode = s.subjectcode




select m.* from mark m inner join v1 on m.subjectcode = v1.subjectcode