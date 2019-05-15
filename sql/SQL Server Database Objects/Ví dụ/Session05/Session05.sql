USE QLDIEM
-- INSERT TRIGGER
CREATE TRIGGER tg_insert ON STUDENT
FOR INSERT
AS
	IF(SELECT birthdate FROM INSERTED)> getdate()
	BEGIN
		PRINT 'NGAY SINH KO DUOC LON HON NGAY HIEN TAI'
		ROLLBACK TRANSACTION
	END

insert into student 
values('c101','C0609M','Fpt','1','1/1/2010','ha noi','fpt@fpt.com.vn')

-- DELTE TRIGGER

CREATE TRIGGER tg_del ON MARK
FOR DELETE
AS
	IF(SELECT COUNT(*) FROM DELETED)>1
	BEGIN
		PRINT 'KHONG DUOC XOA NHIEU HON 1 BAN GHI'
		ROLLBACK TRAN
	END

DELETE FROM MARK WHERE ROLLNO = 'A001'

--UPDATE TRIGGER
CREATE TRIGGER tg_up ON MARK
FOR UPDATE
AS
	IF 'A001' IN (SELECT ROLLNO FROM DELETED)
	BEGIN
		PRINT 'KO DUOC UPDATE DIEM CUA SV A001'
		ROLLBACK TRAN
	END
select * from mark

UPDATE MARk SET pmark = 25 where rollno='A001'
-- APTER Trigger
CREATE TRIGGER tg_after ON STUDENT
AFTER INSERT
AS
	declare @count int
	set @count = (SELECT COUNT(*) FROM STUDENT)
	PRINT 'TONG SO SV:' + Convert(CHAR(5),@count)

INSERT INTO STUDENT 
VALUES('C0101','C0609M','DungTV','1','1/1/1989','HN','Dungtv@fpt.com.vn')

-- INSTEAD OF trigger
CREATE TRIGGER tg_instead_of
ON STUDENT
INSTEAD OF DELETE
AS
	DELETE FROM MARK WHERE ROLLNO 
	IN (SELECT ROLLNO FROM DELETED)
	DELETE FROM STUDENT WHERE ROLLNO 
	IN	(SELECT ROLLNO FROM DELETED)

DELETE FROM STUDENT WHERE ROLLNO = 'A001'
------
SELECT * FROM MARK

CREATE TRIGGER tg_del_mark ON MARK
INSTEAD OF INSERT
AS
	DELETE FROM MARK WHERE ROLLNo = 'A003'


INSERT INTO MARK VALUES('A002','HDJ',25,10,10)

-- sp_settriggerorder

CREATE TRIGGER tg_after_1 on Mark
AFTER  INSERT
AS
	declare @count int
	select @count = (SELECT Count(*) FROM mark)
	print 'Tong so sv:' + convert(char(5),@count)

CREATE TRIGGER tg_after_2 on Mark
AFTER INSERT
AS
	declare @max int
	set @max = (select max(pmark)  FROM mark)
	print 'Diem cao nhat:' + convert(char(2),@max)

sp_settriggerorder @triggername ='tg_after_2',
@order='FIRST',@stmttype ='INSERT'

sp_settriggerorder @triggername ='tg_after_1',
@order='LAST',@stmttype ='INSERT'

INSERT INTO Mark values('A004','HDJ',5,5,5)
select * from mark
--DDL Trigger
-- Tao trigger khong cho phep tao bang tren database
CREATE TRIGGER tg_permission
ON DATABASE
FOR CREATE_TABLE
AS
	PRINT 'BAN KO CO QUYEN TAO BANG TREN DB'
	ROLLBACK TRAN

create table abc
(
	col1 int primary key
)
disable trigger tg_permission on database

CREATE TRIGGER tg_on_server
ON ALL SERVER
FOR CREATE_DATABASE
AS
	print 'ban ko duoc quyen tao database'
	rollback transaction
create database fptaptech

disable trigger tg_on_server on all server

-- alter trigger
ALTER TRIGGER tg_on_server
on all server
FOR Create_Database
AS
	print 'alter trigger'
	rollback tran
--

SELECT * FROM sys.triggers

