use QLDiem
GO
if exists (select name from sysobjects where name='testXML' and type='U')
 drop table testXML
GO
Create Table testXML
(id int primary key, name varchar(30),address xml)
GO

--Insert data into a table xml
INSERT INTO testXML values(1,'Hoang','<Province name="HP"><District>Tien Lang</District></Province>')
INSERT INTO testXML values(2,'Bong','<Province name="HN"><District>Hoan Kiem</District></Province>')
INSERT INTO testXML values(3,'Lan','<Province name="HP"><District>An Lao</District></Province>')
INSERT INTO testXML values(4,'Bien','<Province name="TN"><District>Dai Tu</District></Province>')

 select * from testXML