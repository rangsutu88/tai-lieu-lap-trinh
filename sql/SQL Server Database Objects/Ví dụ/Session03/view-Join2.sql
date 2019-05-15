/*Neu view gom nhieu bang thi khong update duoc, lanh update
  sau day se bao loi
*/
use QLDiem
GO
IF EXISTS(SELECT * FROM SysObjects  WHERE NAME = 'view1' and TYPE='V')
   DROP VIEW view1
GO
CREATE VIEW view1
AS
SELECT class.classcode,class.HeadTeacher, student.RollNo, student.Fullname 
from Class Join Student on class.Classcode=class.ClassCode
GO
update view1 set class.HeadTeacher='Hoang Van Van' where class.ClassCode='C0611L'
select * from class
  
