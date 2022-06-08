-- Test normal case: @v = SP_EXECUTESQL 'SQL'
DECLARE @SQLString NVARCHAR(100);
DECLARE @P0 int;
set @SQLString = N'SELECT 123;'
EXEC @P0 = sp_executesql @SQLString;
SELECT @P0;
go

-- Test case: @v = SP_EXECUTESQL 'SQL' where @v is implicitly casted to varchar
DECLARE @SQLString NVARCHAR(100);
DECLARE @P0 varchar(3);
set @SQLString = N'SELECT 321;'
EXEC @P0 = sp_executesql @SQLString;
SELECT @P0;
go

-- Test case: @v = SP_EXECUTESQL 'SQL' where 'SQL' statement does not return result set
DECLARE @SQLString NVARCHAR(100);
DECLARE @P0 int;
set @SQLString = N'CREATE TABLE t(a INT); DROP TABLE t;';
EXEC @P0 = sp_executesql @SQLString;
SELECT @P0;
go