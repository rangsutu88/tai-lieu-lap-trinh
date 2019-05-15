-- Tao INSERT TRIGGER
CREATE TRIGGER tgInsertRegion
ON Region
FOR INSERT
AS
BEGIN
Print 'Cannot insert into Region, this table is locked'
ROLLBACK TRAN
END

-- version2
CREATE TRIGGER tgInsertRegion
ON Region
FOR INSERT
AS
BEGIN
Print 'Cannot insert into Region, this table is locked'

create table Region_temp1
(regionID int, regionDesc varchar(50))

declare @regionID int, @regionDesc varchar(50)
select @regionID=regionID, @regionDesc=regionDescription from Inserted
insert into Region_temp1 values(@regionID, @regionDesc)

--ROLLBACK TRAN
END


INSERT INTO Region 
VALUES(106, 'region')

select * from Region


-- RAISE ERROR
ALTER TRIGGER tgInsertRegion
ON Region
FOR INSERT
AS
RAISERROR('Cannot insert into Region',10,1)


-- DDL Trigger
CREATE TRIGGER safety 
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE 
AS 
   PRINT 'You must disable Trigger "safety" to drop or alter tables!' 
   ROLLBACK

drop table Region_temp1


-- View Inserted
CREATE TRIGGER viewInserted
ON Region
FOR INSERT
AS
select * from Inserted
Rollback Tran

INSERT INTO Region 
VALUES(108, 'region')

-- Tao INSERT TRIGGER, kiem tra dieu kien truoc khi insert
DROP TRIGGER tgInsertRegion
CREATE TRIGGER tgInsertRegion2
ON Region
FOR INSERT
AS
IF (Select RegionID from Inserted) > 10
BEGIN
	Print 'Khong the them ma > 10'	
	ROLLBACK TRAN
END

INSERT INTO Region 
VALUES(9, 'region')
select * from Region


-- Tao DELETE TRIGGER, truong hop 1 ban ghi
ALTER TRIGGER tgDeleteRegion
ON Region
FOR DELETE
AS
select * from Deleted
DECLARE @RegionID int
SELECT @RegionID = RegionID FROM Deleted
IF @RegionID < 10
BEGIN
	PRINT 'Khong the xoa id < 10'
	ROLLBACK TRANSACTION
END

delete from Region where RegionID=9


-- Tao UPDATE TRIGGER, truong hop 1 ban ghi
CREATE TRIGGER tgUpdateRegion
ON Region
FOR UPDATE
AS
DECLARE @RegionID int
SELECT @RegionID = RegionID FROM Deleted
IF @RegionID < 4
BEGIN
	PRINT 'Khong the cap nhat voi id < 4'
	ROLLBACK TRANSACTION
END

update Region set RegionDescription = ''
where RegionID=1
update Region set RegionDescription = ''
where RegionID=106

CREATE TRIGGER tgUpdateRegion2
ON Region
FOR UPDATE
AS
IF UPDATE(RegionID)
BEGIN
	PRINT 'Khong the thay doi cot RegionID'
	ROLLBACK TRANSACTION
END

update Region set RegionID = 200
where RegionID=106


-- Truong hop xoa nhieu
delete from Region where RegionID <= 4


-- Tao bang moi

 CREATE TABLE employee  (emp_no    INTEGER NOT NULL,
                         emp_fname CHAR(20) NOT NULL,
                         emp_lname CHAR(20) NOT NULL,
                         dept_no   CHAR(4) NULL)

 insert into employee values(1,  'Matthew', 'Smith',    'd3')
 insert into employee values(2,  'Ann',     'Jones',    'd3')
 insert into employee values(3,  'John',    'Barrimore','d1')
 insert into employee values(4,  'James',   'James',    'd2')
 insert into employee values(5,  'Elsa',    'Bertoni',  'd2')
 insert into employee values(6,  'Elke',    'Hansel',   'd2')
 insert into employee values(7,  'Sybill',  'Moser',    'd1')

 select * from employee

-- Xem danh sach ban ghi bi xoa
CREATE TRIGGER tgDeleteEmployee
ON employee
FOR DELETE
AS
--Hien danh sach nhung ban ghi co the bi xoa
select * from deleted
ROLLBACK TRAN

delete from employee where emp_no <= 3

-- Tao trigger cho phep xoa nhung ban ghi co id <= 3
/*
CREATE TRIGGER tgDelete3Region
ON employee
FOR DELETE
AS
DECLARE @ID
FOR @ID IN (SELECT Emp_no FROM Deleted)
BEGIN
   IF @ID <= 3
	DELETE FROM Employee WHERE Emp_no=@ID
END
*/

CREATE TRIGGER tgDelete3Region
ON employee
FOR DELETE
AS
DELETE FROM Deleted WHERE Emp_no > 3	--error


-- Tao AFTER TRIGGER
CREATE TRIGGER tgAfterDeleteEmployee
ON employee
AFTER DELETE
AS
PRINT 'Da xoa Employee'
select * from employee

DROP TRIGGER tgDeleteEmployee
delete from employee where emp_no < 3


-- Tao INSTEAD OF trigger
CREATE TRIGGER tgInsteadOfEmployee
ON employee
INSTEAD OF DELETE
AS
PRINT 'Employee khong he bi xoa'


delete from employee
select * from employee

--
ALTER TRIGGER tgInsteadOfEmployee
ON employee
INSTEAD OF DELETE
AS
DELETE FROM employee WHERE Emp_no
IN (SELECT Emp_No FROM Deleted WHERE Emp_no <= 5)

delete from employee

select * from employee


-------------

-- Vi du viec dung cursor duyet du lieu, va cach xoa tung phan du lieu voi trigger DELETE 

-- Create another region table
select * into region_temp from region 

-- Create trigger to prohibit the deletion of region with regionid<5
CREATE TRIGGER tgDeleteRegion
ON region_temp
INSTEAD OF DELETE	-- IMPORTANT, use deleted table to find rows needed to be deleted only
AS
declare @regionid int
declare @regiondesc varchar(200)

-- Declare cursor to tranverse deleted rows
declare region_cursor cursor for
select * from deleted

open region_cursor

fetch next from region_cursor
into @regionid, @regiondesc

while @@FETCH_STATUS = 0
begin
  PRINT @regionid
  PRINT ', ' 
  PRINT @regiondesc
  
  -- Delete from region_temp
  delete from region_temp where regionid=@regionid

  fetch next from region_cursor into @regionid, @regiondesc
end

close region_cursor
deallocate region_cursor
-- END of trigger

GO
delete from region_temp where regionid=1
GO
select * from region_temp

-------------

-- LOGON trigger

USE master;
GO

CREATE LOGIN login_test WITH PASSWORD = '3KHJ6dhx(0xVYsdf' MUST_CHANGE,
    CHECK_EXPIRATION = ON;
GO

GRANT VIEW SERVER STATE TO login_test;
GO

CREATE TRIGGER connection_limit_trigger
ON ALL SERVER WITH EXECUTE AS 'login_test'
FOR LOGON
AS
BEGIN
IF ORIGINAL_LOGIN()= 'login_test' AND
    (SELECT COUNT(*) FROM sys.dm_exec_sessions
            WHERE is_user_process = 1 AND
                original_login_name = 'login_test') > 3
    ROLLBACK;
END;



--DDL trigger

CREATE TRIGGER safety 
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE 
AS 
   PRINT 'You must disable Trigger "safety" to drop or alter tables!' 
   ROLLBACK
;