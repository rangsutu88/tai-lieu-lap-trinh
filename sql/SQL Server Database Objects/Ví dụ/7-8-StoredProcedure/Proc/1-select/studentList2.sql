USE QLDiem
GO
IF EXISTS(SELECT * FROM sysobjects  WHERE name = 'proc1' AND type = 'P')
   DROP PROC proc1
GO

CREATE PROCEDURE proc1 @mClassCode varchar(20)
AS 
IF @mClassCode IS NULL
   BEGIN
      PRINT 'You must give a ClassCode'
      RETURN
   END
ELSE
   BEGIN
      SELECT a.ClassCode,a.FullName, b.SubjectCode,convert(decimal(4,1),b.Mark) as Mark
      FROM Student a INNER JOIN Mark b 
         ON a.RollNo = b.RollNo
      WHERE a.ClassCode = @mClassCode
   END
GO
exec proc1 'C0611L'

