create schema error_mapping;
GO
-- Executing test error_mapping.ErrorHandling1
GO

create procedure error_mapping.ErrorHandling1 as
begin
CREATE SEQUENCE s11701 INCREMENT BY 6
    MINVALUE 5
    MAXVALUE 10
  

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
GO


GO
begin transaction
GO
-- Executing test error_mapping.ErrorHandling1
create procedure error_mapping.ErrorHandling1 as
begin
CREATE SEQUENCE s11701 INCREMENT BY 6
    MINVALUE 5
    MAXVALUE 10
  

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
GO


-- Checking xact_abort_flag for compile time error --
set xact_abort ON;
GO
GO
begin transaction
GO
-- Executing test error_mapping.ErrorHandling1
create procedure error_mapping.ErrorHandling1 as
begin
CREATE SEQUENCE s11701 INCREMENT BY 6
    MINVALUE 5
    MAXVALUE 10
  

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
GO
set xact_abort OFF;
GO

-- Next portion is for runtime error --
-- Executing test error_mapping.ErrorHandling10000000
GO

create procedure error_mapping.ErrorHandling1 as
begin
CREATE SEQUENCE s11701 INCREMENT BY 6
    MINVALUE 5
    MAXVALUE 10
  

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
GO


set xact_abort ON;
GO
-- Executing test error_mapping.ErrorHandling10000000
GO

create procedure error_mapping.ErrorHandling1 as
begin
CREATE SEQUENCE s11701 INCREMENT BY 6
    MINVALUE 5
    MAXVALUE 10
  

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
GO



set xact_abort OFF;
GO

-- Error classification is done --
-- Executing test error_mapping.ErrorHandling10000000
GO

begin try
select 1
CREATE SEQUENCE s11701 INCREMENT BY 6
    MINVALUE 5
    MAXVALUE 10
  

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
GO



GO
drop schema error_mapping;
GO
