
-- CALENDAR USERS
CREATE DATABASE [health_and_med_users];
GO

USE [health_and_med_users];
GO

CREATE LOGIN [migration_user]
WITH PASSWORD = '${SVC_PASS}';
GO

CREATE USER [migration_user] FOR LOGIN [migration_user];
ALTER ROLE db_owner ADD MEMBER [migration_user];
GO

CREATE LOGIN [svc_conn_users]
WITH PASSWORD = '${SVC_PASS}';
GO

CREATE USER [svc_conn_users]
FOR LOGIN [svc_conn_users];
GO


EXEC sp_addrolemember 'db_datareader', 'svc_conn_users';
GO
EXEC sp_addrolemember 'db_datawriter', 'svc_conn_users';
GO



-- CALENDAR DATABASE
CREATE DATABASE [health_and_med_calendar];
GO

USE [health_and_med_calendar];
GO

CREATE LOGIN [svc_conn_calendar]
WITH PASSWORD = '${SVC_PASS}';
GO

CREATE USER [svc_conn_calendar]
FOR LOGIN [svc_conn_calendar];
GO


EXEC sp_addrolemember 'db_datareader', 'svc_conn_calendar';
GO
EXEC sp_addrolemember 'db_datawriter', 'svc_conn_calendar';
GO



--- SANDBOX DATABASE

CREATE DATABASE [health_and_med];
GO

USE [health_and_med];
GO

CREATE LOGIN [svc_con_mngt]
WITH PASSWORD = '${SVC_PASS}';
GO

CREATE USER [svc_con_mngt]
FOR LOGIN [svc_con_mngt];
GO

EXEC sp_addrolemember 'db_datareader', 'svc_con_mngt';
GO
EXEC sp_addrolemember 'db_datawriter', 'svc_con_mngt';
GO

CREATE SCHEMA SandboxSchema;
GO

CREATE TABLE SandboxSchema.SandboxTable (
	Id int IDENTITY(1, 1) PRIMARY KEY,
	Property1 varchar(500)
);