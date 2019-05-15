use pubs
EXEC sp_fulltext_database 'enable'
--EXEC sp_fulltext_database 'disable'
GO
select title from titles where contains(title,'"Computer" or "cooking" or "silicon"')
GO
