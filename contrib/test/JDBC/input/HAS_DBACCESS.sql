SELECT HAS_DBACCESS('master');
GO

SELECT HAS_DBACCESS('does_not_exist');
GO

CREATE DATABASE TestDb;
GO
SELECT HAS_DBACCESS('TestDb');
GO

SELECT HAS_DBACCESS('TestDb   ');
GO

SELECT HAS_DBACCESS('   TestDb');
GO

DROP DATABASE TestDb;
GO
SELECT HAS_DBACCESS('TestDb');
GO

SELECT HAS_DBACCESS('babelfish_db');
GO