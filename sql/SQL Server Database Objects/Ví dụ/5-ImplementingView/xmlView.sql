use QLDiem
GO
if exists (select name from sysobjects where name='testXML' and type='U')
 drop table testXML
GO
Create Table testXML (id int primary key, name varchar(30),address xml)
GO

--Insert data into a table xml
INSERT INTO testXML values(1,'Hoang','<Province name="HP"><District>Tien Lang</District></Province>')
INSERT INTO testXML values(2,'Bong','<Province name="HN"><District>Hoan Kiem</District></Province>')
INSERT INTO testXML values(3,'Lan','<Province name="HP"><District>An Lao</District></Province>')
INSERT INTO testXML values(4,'Bien','<Province name="TN"><District>Dai Tu</District></Province>')

select * from testXML
GO
CREATE PRIMARY XML INDEX XML_index1 ON  testXML  (Address)
GO
CREATE XML INDEX XML_index2 on testXML (Address) USING XML INDEX XML_index1 FOR PATH
GO
IF EXISTS(SELECT * FROM SysObjects WHERE NAME = 'view1' and TYPE='V') DROP VIEW view1
GO
CREATE VIEW view1 AS
SELECT Address.value('(/Province/@Name)[1]','varchar(50)')  AS ProvName  FROM testXML
GO
select * from View1