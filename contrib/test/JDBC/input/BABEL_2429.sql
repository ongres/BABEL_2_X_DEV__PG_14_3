create login newlogin with password = '12345678' , default_database=master;
go

select db_name(), user_name()
go

create database zzz
go

drop database zzz
go

create login newlogin2 with password = '12345678' , default_database=master;
go

create login newlogin3 with password = '12345678' , default_database=master;
go

create database zzz
go

drop database zzz
go

drop login newlogin
go
drop login newlogin2
go
drop login newlogin3
go
