use QLDiem
GO
IF EXISTS (SELECT * FROM QLDiem..sysindexes WHERE name = 'student_index1')
DROP INDEX student.student_index1
GO
create nonclustered index student_index1 on Student (classcode)
go
alter index student_index1 on Student rebuild
go
ALTER INDEX ALL ON Student REBUILD WITH (FILLFACTOR = 80);
go
alter index student_index1 on Student (classcode) REORGANIZE 
go
alter index student_index1 on Student (classcode) DISABLE ;

