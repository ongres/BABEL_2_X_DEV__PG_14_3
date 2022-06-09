-- simple batch start

CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO

INSERT INTO t556(id, results)
EXECUTE proc_556;
GO
DROP PROC proc_556
GO
DROP TABLE t556
GO

begin transaction
GO
CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO

INSERT INTO t556(id, results)
EXECUTE proc_556;
GO

-- Below output is only applicable if query is special case. for example, CREATE/ALTER TRIGGER, CREATE/ALTER FUNCTION, CREATE/ALTER PROC, CREATE/ALTER VIEW etc

if (@@trancount > 0) select cast('compile time error' as text) else select cast('runtime error' as text)
GO

if (@@trancount > 0) rollback tran
GO

DROP PROC proc_556
GO
DROP TABLE t556
GO

-- simple batch end
GO

create schema error_mapping;
GO
-- Next portion is to check if error is being raised during parse analysis phase
GO

create table error_mapping.temp1 (a int)
GO

CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO

create procedure error_mapping.ErrorHandling1 as
begin
insert into error_mapping.temp1 values(1)
INSERT INTO t556(id, results)
EXECUTE proc_556;
end
GO

DROP PROC proc_556
GO
DROP TABLE t556
GO

create table error_mapping.temp2 (a int)
GO

CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO

insert into error_mapping.temp2 values(1)
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO

DROP PROC proc_556
GO
DROP TABLE t556
GO

-- Here we are assuming that error_mapping.ErrorHandling1 is created with no error
GO

create table error_mapping.temp3 (a int)
GO

CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO

insert into error_mapping.temp3 values(1)
exec error_mapping.ErrorHandling1;
GO

DROP PROC proc_556
GO
DROP TABLE t556
GO

if ((select count(*) from error_mapping.temp1) = 0 and (select count(*) from error_mapping.temp2) = 0 and (select count(*) from error_mapping.temp3) > 0) select cast('parse analysis phase error' as text)
GO

drop procedure error_mapping.ErrorHandling1;
GO
drop table error_mapping.temp1;
drop table error_mapping.temp2;
drop table error_mapping.temp3;
GO

-- Parse analysis phase end
GO

-- compile time error portion

-- Executing test error_mapping.ErrorHandling1
CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO


create procedure error_mapping.ErrorHandling1 as
begin
INSERT INTO t556(id, results)
EXECUTE proc_556;
if @@error > 0 select cast('STATEMENT TERMINATING ERROR' as text);
select @@trancount;
end

GO

if @@error > 0 select cast('Compile time error' as text);
if @@trancount > 0 rollback transaction;
drop procedure error_mapping.ErrorHandling1;
set xact_abort OFF;
set implicit_transactions OFF;
GO
DROP PROC proc_556
GO
DROP TABLE t556
GO


CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO

begin transaction
GO
-- Executing test error_mapping.ErrorHandling1
create procedure error_mapping.ErrorHandling1 as
begin
INSERT INTO t556(id, results)
EXECUTE proc_556;
if @@error > 0 select cast('STATEMENT TERMINATING ERROR' as text);
end

GO

declare @err int = @@error; if (@err > 0 and @@trancount > 0) select cast('BATCH ONLY TERMINATING' as text) else if @err > 0 select cast('BATCH TERMINATING\ txn rolledback' as text);
if @@trancount > 0 rollback transaction;
drop procedure error_mapping.ErrorHandling1;
set xact_abort OFF;
set implicit_transactions OFF;
GO

GO
DROP PROC proc_556
GO
DROP TABLE t556
GO


-- Checking xact_abort_flag for compile time error --
set xact_abort ON;
GO
CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO

begin transaction
GO
-- Executing test error_mapping.ErrorHandling1
create procedure error_mapping.ErrorHandling1 as
begin
INSERT INTO t556(id, results)
EXECUTE proc_556;
if @@error > 0 select cast('STATEMENT TERMINATING ERROR' as text);
end

GO

declare @err int = @@error; if (@err > 0 and @@trancount > 0) select cast('BATCH ONLY TERMINATING' as text) else if @err > 0 select cast('BATCH TERMINATING\ txn rolledback' as text);
if @@trancount > 0 rollback transaction;
drop procedure error_mapping.ErrorHandling1;
set xact_abort OFF;
set implicit_transactions OFF;
GO

GO
DROP PROC proc_556
GO
DROP TABLE t556
GO
set xact_abort OFF;
GO

-- comiple time error portion end --
-- Next portion is for runtime error --

-- Executing test error_mapping.ErrorHandling10000000
CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO


create procedure error_mapping.ErrorHandling1 as
begin
INSERT INTO t556(id, results)
EXECUTE proc_556;
if @@error > 0 select cast('STATEMENT TERMINATING ERROR' as text);
select @@trancount;
end

GO

if @@error > 0 select cast('CURRENT BATCH TERMINATING ERROR' as text);
GO
create procedure error_mapping.ErrorHandling2 as
begin
exec error_mapping.ErrorHandling1;
if @@error > 0 select cast('CURRENT BATCH TERMINATING ERROR' as text);
end

GO

begin transaction;
GO
exec error_mapping.ErrorHandling2;
GO
declare @err int = @@error; if (@err > 0 and @@trancount > 0) select cast('BATCH ONLY TERMINATING' as text) else if @err > 0 select cast('BATCH TERMINATING\ txn rolledback' as text);
if @@trancount > 0 rollback transaction;
drop procedure error_mapping.ErrorHandling1;
drop procedure error_mapping.ErrorHandling2;
set xact_abort OFF;
set implicit_transactions OFF;
GO
DROP PROC proc_556
GO
DROP TABLE t556
GO


set xact_abort ON;
GO
-- Executing test error_mapping.ErrorHandling10000000
CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO


create procedure error_mapping.ErrorHandling1 as
begin
INSERT INTO t556(id, results)
EXECUTE proc_556;
if @@error > 0 select cast('STATEMENT TERMINATING ERROR' as text);
select @@trancount;
end

GO

if @@error > 0 select cast('CURRENT BATCH TERMINATING ERROR' as text);
GO
create procedure error_mapping.ErrorHandling2 as
begin
exec error_mapping.ErrorHandling1;
if @@error > 0 select cast('CURRENT BATCH TERMINATING ERROR' as text);
end

GO

begin transaction;
GO
exec error_mapping.ErrorHandling2;
GO
declare @err int = @@error; if (@err > 0 and @@trancount > 0) select cast('BATCH ONLY TERMINATING' as text) else if @err > 0 select cast('BATCH TERMINATING\ txn rolledback' as text);
if @@trancount > 0 rollback transaction;
drop procedure error_mapping.ErrorHandling1;
drop procedure error_mapping.ErrorHandling2;
set xact_abort OFF;
set implicit_transactions OFF;
GO
DROP PROC proc_556
GO
DROP TABLE t556
GO



set xact_abort OFF;
GO

-- Error classification is done --

-- Executing test error_mapping.ErrorHandling10000000
CREATE TABLE t556 (
    id int NOT NULL
  , results varchar(50) NOT NULL
);
GO

CREATE PROCEDURE proc_556
AS
BEGIN
    ALTER TABLE t556 ADD test_type INT;
END;
GO
INSERT INTO t556(id, results)
EXECUTE proc_556;
GO


begin try
select 1
INSERT INTO t556(id, results)
EXECUTE proc_556;
end try
begin catch
	select xact_state();
end catch

if @@trancount > 0 rollback transaction;
drop procedure error_mapping.ErrorHandling1;
drop procedure error_mapping.ErrorHandling2;
set xact_abort OFF;
set implicit_transactions OFF;
GO
DROP PROC proc_556
GO
DROP TABLE t556
GO



GO
drop schema error_mapping;
GO
