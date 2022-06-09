-- Test syntax without escape hatches
CREATE LOGIN r1 WITH PASSWORD = 'abc' MUST_CHANGE, CHECK_EXPIRATION = ON;
GO

CREATE LOGIN r2 WITH PASSWORD = '123', CREDENTIAL = cred1;
GO

CREATE LOGIN r3 FROM CERTIFICATE cert1;
GO

CREATE LOGIN r4 FROM WINDOWS;
GO

CREATE LOGIN r5 WITH PASSWORD = 'xyz', SID = 0x123ABC;
GO

CREATE LOGIN r6
WITH PASSWORD = '1000101',
DEFAULT_DATABASE = master,
CHECK_POLICY = OFF,
CHECK_EXPIRATION = OFF;
GO

CREATE LOGIN r7
WITH PASSWORD = 0x789DEF HASHED MUST_CHANGE,
DEFAULT_LANGUAGE = english,
CREDENTIAL = cred2;
GO

CREATE LOGIN r8
FROM WINDOWS
WITH DEFAULT_DATABASE = db2,
DEFAULT_LANGUAGE = English;
GO

CREATE LOGIN r9 FROM ASYMMETRIC KEY asymkey1;
GO

CREATE LOGIN r10 WITH PASSWORD = N'abc', CHECK_EXPIRATION = ON;
GO

CREATE LOGIN r10 WITH PASSWORD = N'abc', CREDENTIAL = cred;
GO

-- Test ALTER LOGIN syntax without escape hatches
ALTER LOGIN r1 WITH PASSWORD = '123' OLD_PASSWORD = 'abc';
GO

ALTER LOGIN r1 WITH PASSWORD = 0xABC123 HASHED MUST_CHANGE UNLOCK;
GO

ALTER LOGIN r1 WITH PASSWORD = '123' MUST_CHANGE;
GO

ALTER LOGIN r1 WITH PASSWORD = '123' UNLOCK;
GO

ALTER LOGIN r1 WITH DEFAULT_LANGUAGE = english,
NAME = r5,
CHECK_POLICY = ON,
CHECK_EXPIRATION = ON,
NO CREDENTIAL;
GO

ALTER LOGIN r1 WITH DEFAULT_LANGUAGE = english,
CHECK_POLICY = ON,
CHECK_EXPIRATION = ON,
NO CREDENTIAL;
GO

ALTER LOGIN r1 WITH DEFAULT_LANGUAGE = english,
CHECK_EXPIRATION = ON,
NO CREDENTIAL;
GO

ALTER LOGIN r1 WITH DEFAULT_LANGUAGE = english,
NO CREDENTIAL;
GO

ALTER LOGIN r2 WITH PASSWORD = 'abc',
CREDENTIAL = cred1;
GO

ALTER LOGIN r3 ADD CREDENTIAL cred2;
GO

ALTER LOGIN r3 DROP CREDENTIAL cred2;
GO

-- Test syntax with escape hatches
SELECT set_config('babelfishpg_tsql.escape_hatch_login_hashed_password', 'ignore', 'false')
GO
SELECT set_config('babelfishpg_tsql.escape_hatch_login_old_password', 'ignore', 'false')
GO
SELECT set_config('babelfishpg_tsql.escape_hatch_login_password_must_change', 'ignore', 'false')
GO
SELECT set_config('babelfishpg_tsql.escape_hatch_login_password_unlock', 'ignore', 'false')
GO
SELECT set_config('babelfishpg_tsql.escape_hatch_login_misc_options', 'ignore', 'false')
GO

CREATE LOGIN r1 WITH PASSWORD = 'abc' MUST_CHANGE, CHECK_EXPIRATION = ON;
GO

SELECT default_database_name FROM sys.server_principals WHERE name = 'r1';
GO

SELECT sys.babelfish_get_login_default_db('r1');
GO

CREATE LOGIN r2 WITH PASSWORD = '123', CREDENTIAL = cred1;
GO

CREATE LOGIN r3 FROM CERTIFICATE cert1;
GO

CREATE LOGIN r4 FROM WINDOWS;
GO

CREATE LOGIN r5 WITH PASSWORD = 'xyz', SID = 0x123ABC;
GO

CREATE LOGIN r6
WITH PASSWORD = '1000101',
DEFAULT_DATABASE = master,
CHECK_POLICY = OFF,
CHECK_EXPIRATION = OFF;
GO

SELECT default_database_name FROM sys.server_principals WHERE name = 'r6';
GO

SELECT sys.babelfish_get_login_default_db('r6');
GO

CREATE LOGIN r7
WITH PASSWORD = 0x789DEF HASHED MUST_CHANGE,
DEFAULT_LANGUAGE = english,
CREDENTIAL = cred2;
GO

CREATE LOGIN r8
FROM WINDOWS
WITH DEFAULT_DATABASE = db2,
DEFAULT_LANGUAGE = English;
GO

CREATE LOGIN r9 FROM ASYMMETRIC KEY asymkey1;
GO

CREATE LOGIN r10 WITH PASSWORD = N'abc';
GO

CREATE LOGIN r11 WITH PASSWORD = N'abc' MUST_CHANGE, CHECK_EXPIRATION = ON;
GO

-- Test ALTER syntax
ALTER LOGIN r1 ENABLE;
GO

ALTER LOGIN r1 DISABLE;
GO

ALTER LOGIN r1 WITH PASSWORD = '123';
GO

ALTER LOGIN r1 WITH PASSWORD = '123' OLD_PASSWORD = 'abc';
GO

ALTER LOGIN r1 WITH PASSWORD = 0xABC123 HASHED MUST_CHANGE UNLOCK;
GO

ALTER LOGIN r1 WITH DEFAULT_DATABASE = tempdb;
GO

SELECT default_database_name FROM sys.server_principals WHERE name = 'r1';
GO

SELECT sys.babelfish_get_login_default_db('r1');
GO

ALTER LOGIN r1 WITH DEFAULT_LANGUAGE = english,
NAME = r10,
CHECK_POLICY = ON,
CHECK_EXPIRATION = ON,
NO CREDENTIAL;
GO

ALTER LOGIN r2 WITH PASSWORD = 'abc' UNLOCK,
DEFAULT_LANGUAGE = english,
NAME = r10,
CHECK_POLICY = ON,
CHECK_EXPIRATION = ON,
CREDENTIAL = cred1;
GO

ALTER LOGIN r3 ADD CREDENTIAL cred2;
GO

ALTER LOGIN r3 DROP CREDENTIAL cred2;
GO

ALTER LOGIN r10 WITH PASSWORD = N'123';
GO

ALTER LOGIN r11 WITH PASSWORD = N'123' OLD_PASSWORD = N'abc';
GO

SELECT set_config('babelfishpg_tsql.escape_hatch_login_hashed_password', 'strict', 'false')
GO
SELECT set_config('babelfishpg_tsql.escape_hatch_login_old_password', 'strict', 'false')
GO
SELECT set_config('babelfishpg_tsql.escape_hatch_login_password_must_change', 'strict', 'false')
GO
SELECT set_config('babelfishpg_tsql.escape_hatch_login_password_unlock', 'strict', 'false')
GO
SELECT set_config('babelfishpg_tsql.escape_hatch_login_misc_options', 'strict', 'false')
GO

-- Expect errors. Try creating login with non-existent db
CREATE LOGIN r12 WITH PASSWORD = '123',
DEFAULT_DATABASE = zzz;
GO

ALTER LOGIN r1 WITH DEFAULT_DATABASE = zzz;
GO

-- Clean up
DROP LOGIN r1;
GO
DROP LOGIN r2;
GO
DROP LOGIN r3;
GO
DROP LOGIN r4;
GO
DROP LOGIN r5;
GO
DROP LOGIN r6;
GO
DROP LOGIN r7;
GO
DROP LOGIN r8;
GO
DROP LOGIN r9;
GO
DROP LOGIN r10;
GO
DROP LOGIN r11;
GO

SELECT sys.babelfish_get_login_default_db('r1');
GO
