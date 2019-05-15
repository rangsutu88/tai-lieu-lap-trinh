--create database THU
GO
use THU
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'proc1' AND type = 'P')
   DROP PROC proc1
GO
CREATE PROC proc1
@pName varchar(20),@pAge int
AS
print 'Ten: '+ @pName
print 'Tuoi: '+ convert(varchar(20),@pAge)
GO
proc1 'Hoang Van Hung',34
GO
drop proc proc1
