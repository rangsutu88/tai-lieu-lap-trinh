USE QLDiem
GO
IF EXISTS(SELECT * FROM sysobjects  WHERE name = 'proc1' AND type = 'P')
   DROP PROC proc1
GO

CREATE PROCEDURE proc1
AS 
      SELECT a.FullName, b.SubjectCode,convert(decimal(4,1),b.Mark)as Mark
      FROM Student a INNER JOIN Mark b 
         ON a.RollNo = b.RollNo
GO
exec proc1

sp_helptext 'proc1'

exec sp_depends 'proc1'