USE QLDIEM
GO
--1. Danh sach sinh vien da co diem thi mon CF.

select a.ClassCode,a.RollNo, a.FullName from Student a inner Join Mark b 
 on a.RollNo = b.RollNo where b.SubjectCode='CF' and b.Mark>0

--2. Danh sach cac mon hoc cung voi so sinh vien da co diem thi tuong ung cua 
--tung mon hoc, theo thu tu tang dan cua ten mon hoc. 

select a.SubjectCode,count(*) as stud_nr from subject a inner join mark b 
 on a.SubjectCode=b.SubjectCode where b.mark>0 group by a.SubjectCode order by a.SubjectCode

--3. Danh sach sinh vien que o  "HT" (Ha Tay), cung voi ten cac mon hoc 
--da thi nhung khong qua (< 10 diem).

select a.RollNo,a.FullName, b.SubjectCode, round(b.Mark,0) as Mark from student a inner join mark b 
 on a.RollNo=b.RollNo where a.Province='HT' and b.mark<10 order by a.FullName

--4. Danh sách các lop cùng voi tong so sinh viên trong lop.	

select a.ClassCode, count(b.ClassCode) as Stud_nr from Class a inner join Student b
 on a.ClassCode=b.ClassCode group by a.ClassCode 

--5.Danh sách các sinh viên, cùng voi tên day du các môn hoc mà sinh viên dó dã tham gia thi.

select a.rollNo, a.FullName,b.SubjectCode from Student a inner join Mark b
 on a.RollNo=b.RollNo where b.mark>0 order by a.FullName,b.SubjectCode
 
--6. Danh sách các sinh viên, cùng voi so lan dã tham gia thi thuc hành
--(moi record trong bang MARK có diem PMark là mot lan thi).

select a.rollNo, a.FullName,count(b.RollNo) as SoLanThiTH from Student a inner join Mark b
 on a.RollNo=b.RollNo where b.pmark>0 group by a.rollNo, a.FullName 
 order by a.FullName

--7. Danh sách các tinh, cùng voi diem trung bình tat ca các môn thi cua sinh viên 
--quê o tinh dó. Sap xep theo thu tu giam dan cua diem trung bình.

select a.Province,round(avg(b.mark),0) as avgMark from Student a inner join Mark b
 on a.RollNo=b.RollNo group by a.province order by avg(b.mark) desc

--8. Danh sách các sinh viên có diem trung bình tat ca các môn hoc >15

select a.RollNo, a.FullName, avg(b.mark) from student a inner join mark b
 on a.RollNo = b.RollNo group by a.RollNo, a.FullName having avg(b.mark)>15


--Câu 3: Viet Stored Procedure

/*Viet mot script tao stored procedure voi các yêu cau sau:
- Tên Procedure: 	procStudentList  
- Tham so: 		pClassCode as varchar(10), pMark  as float
- Xu lý: 
+ Neu tham so pClassCode duoc truyen = '' hoac không truyen, procedure se liet kê danh sách
  ClassCode, RollNo, FullName, SubjectCode, Mark  voi Mark >= pMark.
+ Neu tham so pMark không truyen thì nhan giá tri ngam dinh =0.*/

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'procStudentList' AND type = 'P')
   DROP PROC procStudentList
GO
CREATE PROCEDURE procStudentList @pClassCode varchar(10)= NULL, @pMark float = NULL
AS 
BEGIN
 if @pMark is NULL
  set @pMark=0
 IF @pClassCode IS NULL
   select a.ClassCode, a.rollNo, a.FullName,b.SubjectCode,b.Mark from Student a 
    inner join Mark b 
    on a.RollNo=b.RollNo where b.mark>@pMark order by a.RollNo
  ELSE
   select a.ClassCode,a.rollNo, a.FullName,b.SubjectCode,b.Mark from Student a 
    inner join Mark b
    on a.RollNo=b.RollNo where b.mark>@pMark and a.ClassCode = @pClassCode 
    order by a.RollNo
END
GO
exec procStudentList 'C0611L',10
exec procStudentList 'C0611L'
exec procStudentList

 