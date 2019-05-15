USE Northwind
GO
EXEC sp_fulltext_database 'enable'
GO
EXEC sp_fulltext_table 'Categories', 'create', 'Cat_Desc', 'PK_Categories'
GO