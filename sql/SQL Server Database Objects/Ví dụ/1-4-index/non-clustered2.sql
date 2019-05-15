use QLDiem
GO
IF EXISTS (SELECT * FROM QLDiem..sysindexes WHERE name = 'student_index1')
DROP INDEX student.student_index1
create nonclustered index student_index1 on Student (classcode)
select * from student
GO
select * from student where classcode like '%'
GO

