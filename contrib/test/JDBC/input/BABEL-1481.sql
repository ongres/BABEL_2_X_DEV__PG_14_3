CREATE TABLE babel_1481_t(a VARCHAR(8000))
GO

INSERT INTO babel_1481_t VALUES ('Test Value 1'), ('Test Value 2');
GO

SELECT * FROM babel_1481_t;
GO

DROP TABLE babel_1481_t;
GO

CREATE TABLE babel_1481_t(a CHAR(8000));
GO

INSERT INTO babel_1481_t VALUES ('Test Value 1'), ('Test Value 2');
GO

SELECT * FROM babel_1481_t;
GO

DROP TABLE babel_1481_t;
GO

CREATE TABLE babel_1481_t(a VARCHAR(8001))
GO

CREATE TABLE babel_1481_t(a CHAR(8001));
GO

CREATE TABLE babel_1481_t(a NVARCHAR(4000))
GO

INSERT INTO babel_1481_t VALUES ('Test Value 1'), ('Test Value 2');
GO

SELECT * FROM babel_1481_t;
GO

DROP TABLE babel_1481_t;
GO

CREATE TABLE babel_1481_t(a NCHAR(4000))
GO

INSERT INTO babel_1481_t VALUES ('Test Value 1'), ('Test Value 2');
GO

SELECT * FROM babel_1481_t;
GO

DROP TABLE babel_1481_t;
GO

CREATE TABLE babel_1481_t(a NVARCHAR(4001))
GO

CREATE TABLE babel_1481_t(a NCHAR(4001))
GO

SELECT cast(12 as VARCHAR(8000))
GO

SELECT cast(12 as CHAR(8000))
GO

SELECT cast(12 as NVARCHAR(4000))
GO

SELECT cast(12 as NCHAR(4000))
GO

SELECT cast(12 as VARCHAR(8001))
GO

SELECT cast(12 as CHAR(8001))
GO

SELECT cast(12 as NVARCHAR(4001))
GO

SELECT cast(12 as NCHAR(4001))
GO
