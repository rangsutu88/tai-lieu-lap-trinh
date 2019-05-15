create database QLSinhvien
use QLSinhvien
--Cau 1
create table Student(rn int,name varchar(25),age int,gender bit)
create table Subject(sID int,sName varchar(10))
create table StudentSubject(rn int,sID int,Mark int,Date datetime)
go
--Cau 1a
alter table Student
alter column rn int not null
go
alter table Student
add constraint PK1 primary key(rn)
go
--
alter table Subject
alter column sID int not null
go
alter table Subject
add constraint PK2 primary key(sID)
go
--
alter table StudentSubject
alter column sID int not null
go
alter table StudentSubject
alter column RN int not null
go
alter table StudentSubject
add constraint PK3 primary key(rn,sID)
go

--1b
alter table StudentSubject
add constraint check1 check (mark>=0 and mark <=10)
go

--1c
alter table studentSubject
add constraint FK1 foreign key(RN) references Student(RN)
go

--Cau 2
--2a
Insert student (rn,name) values(1,'My Linh')
Insert subject values(1,'SQL')
go
Insert StudentSubject values(1,1,8,'7/28/2005')

--2b
Insert student (rn,name) values(2,'Dam Vinh Hung')
Insert subject values(2,'LGC')
go
Insert StudentSubject values(2,2,3,'7/29/2005')

--2c
Insert student (rn,name) values(3,'Kim Tu Long')
Insert subject values(3,'HTML')
go
Insert StudentSubject values(3,3,9,'7/31/2005')

--2d
Insert student (rn,name) values(4,'Tai Linh')
go
Insert StudentSubject values(4,1,5,'7/30/2005')

--2e
Insert student (rn,name) values(5,'My Le')
Insert subject values(4,'CF')
go
Insert StudentSubject values(5,4,10,'7/19/2005')

--2f
Insert student (rn,name) values(6,'Ngoc Oanh')
go
Insert StudentSubject values(6,1,9,'7/25/2005')
go

--Cau 3
--3a
update student 
set gender=0
where name in ('My Linh','Tai Linh','My Le')
go

--3b
update student 
set gender=1
where name in ('Kim Tu Long')
go

--3c
update student 
set gender=Null
where name in ('Ngoc Oanh')
go
select * from student
select * from subject
select * from studentsubject
--Cau 4
--4a
Insert subject values(5,'Core Java')
Insert subject values(6,'VB.NET')
go

--Cau 5
select sName,mark from subject s left join studentsubject ss on s.sID=ss.sID
where ss.sID is null

--Cau 6
select sName,max(mark) from subject s left join studentsubject ss on s.sID=ss.sID
group by sName

--Cau 7
select sName,count(*) from subject s left join studentsubject ss on s.sID=ss.sID
group by sName
having count(*)>1

--select sName from subject
--where sID in (select sID from studentsubject ss where subject.sID=ss.sID group by sID having count(*)>1)

--Cau 8
go
create view StudentInfo
as 
select S.Rn,Su.sID,Name,Age,
	(Case gender 
	when 0 then 'Male' 
	when 1 then 'Female' 
	else 'Unknow' end) as Gender,
	sName,Mark,Date
from Student s join StudentSubject ss on s.rn=ss.rn join Subject su on ss.sid=su.sid
go
select * from studentinfo

--Cau 9
go
alter view StudentInfo with schemabinding
as 
select S.Rn,Su.sID,Name,Age,
	(Case gender 
	when 0 then 'Male' 
	when 1 then 'Female' 
	else 'Unknow' end) as Gender,
	sName,Mark,Date
from dbo.Student s join dbo.StudentSubject ss on s.rn=ss.rn join dbo.Subject su on ss.sid=su.sid
go
set arithabort on
create unique clustered index ixStudentInfo on studentinfo(rn,sID)
sp_helpindex StudentInfo
drop index studentinfo.ixStudentinfo
go
sp_help studentinfo

--Cau 10
select * from subject
select * from studentsubject
so
Create Trigger CasUpdate
on Subject
for update
As
if update(sID)
Begin
	update StudentSubject set sID=(select top 1 sID from inserted)
	where sID in (select sID from Deleted)
end
go
select * from subject
update subject set sid=1 where sid=10
go
select * from studentsubject

--Cau 11

select * from student
select * from studentsubject
delete student where rn=1

drop trigger casDel1
create trigger casDel1
on student
for delete
as
	delete studentsubject where rn in (select rn from deleted)
go

go
Create Trigger casDel
on Student
instead of Delete
As
delete StudentSubject where rn in (select rn from deleted)
delete Student where rn in (select rn from deleted)
go

--Cau 12
go
create proc DelStudent
@name varchar(25),
@mark int
as
if @name='*'
Begin
	delete studentsubject
	delete student
end
else
begin
	declare @rn int
	select @rn=rn from student where name=@name
	if (select count(*) from studentsubject where rn =@rn and mark>@mark)=0
	begin
		delete studentsubject where rn=@rn
		delete student where rn=@rn
	end
end
go

select * from student
select * from studentsubject
exec delStudent 'Dam Vinh Hung',4
begin tran
	exec delStudent '*',8
	select * from student
	select * from studentsubject
rollback tran
	

--Cau 13
go
select right(name,charindex(' ',reverse(name))),* from studentinfo
order by right(name,charindex(' ',reverse(name)))

--Cau 14
go
create table Top3
(Rank int, Rn int, Name varchar(25),Mark int, sName varchar(25),Date datetime)
go
declare curTop3 cursor
for select Rn,Name,Mark,sName from studentInfo order by mark desc
declare @cnt int,@rn int,@Name varchar(25),@mark int,@sName varchar(25)
open curtop3
set @cnt=0
while @cnt<3
begin
	set @cnt=@cnt+1
	fetch next from curtop3 into @rn,@Name,@Mark,@sName
	insert Top3 (Rank,Rn,Name,Mark,sName,Date)
	values(@cnt,@Rn,@Name,@Mark,@sName,getdate())
end
close curTop3
deallocate curTop3

--Cau 15
go
create trigger chkTop3
on StudentSubject
for insert, delete, update
as
declare curTop3 cursor
for select Rn,Name,Mark,sName from studentInfo order by mark desc
declare @cnt int,@rn int,@Name varchar(25),@mark int,@sName varchar(25)
delete Top3
open curtop3
set @cnt=0
while @cnt<3
begin
	set @cnt=@cnt+1
	fetch next from curtop3 into @rn,@Name,@Mark,@sName
	insert Top3 (Rank,Rn,Name,Mark,sName,Date)
	values(@cnt,@Rn,@Name,@Mark,@sName,getdate())
end
close curTop3
deallocate curTop3
go

--Cau 16
select Name,Avg(Mark) from StudentInfo
where rn not in (select rn from StudentInfo where mark<5)
group by Rn,Name
having avg(mark)>8

--Cau 17
select Name,Avg(Mark) from StudentInfo B
where (rn not in (select rn from StudentInfo where mark<3))
	and (select count(*) from StudentInfo where mark<5 and rn=b.rn)<=1
group by Rn,Name
having avg(mark)>6.5

--Cau 18
go
alter proc DelStudent
@name varchar(25),
@mark int
as
if @name='*'
Begin
	delete studentsubject
	where rn not in (select rn from top3)
	delete student
	where rn not in (select rn from top3)
end
else
begin
	declare @rn int
	select @rn=rn from student where name=@name
	if (select count(*) from studentsubject where rn =@rn and mark>@mark)=0
	begin
		delete studentsubject where rn=@rn
		and rn not in (select rn from top3)
		delete student where rn=@rn
		and rn not in (select rn from top3)
	end
end
go
exec delStudent 'My Linh',10
