-- recursive procedure
-- should fail with stack depth reached error
CREATE PROC p1 AS
BEGIN
    exec p1
END
GO

exec p1
go

-- recursive trigger
-- should fail with stack depth reached error
CREATE TABLE table2_1963 (a int)
GO

CREATE TRIGGER trig2_1963 
ON table2_1963 
AFTER INSERT   
AS insert into table2_1963 values (1)
GO

insert into table2_1963 values(5)
go


-- cleanup
drop table table2_1963;
go

drop procedure p1
go