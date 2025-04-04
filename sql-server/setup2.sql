
-- USERS
CREATE DATABASE [medusers];
GO

USE [medusers];
GO

CREATE LOGIN [migration_user]
WITH PASSWORD = '${SVC_PASS}';
GO

CREATE USER [migration_user] FOR LOGIN [migration_user];
ALTER ROLE db_owner ADD MEMBER [migration_user];
GO


-- SCHEDULE
CREATE DATABASE [medschedule];
GO

USE [medschedule];
GO

CREATE LOGIN [migration_user]
WITH PASSWORD = '${SVC_PASS}';
GO

CREATE USER [migration_user] FOR LOGIN [migration_user];
ALTER ROLE db_owner ADD MEMBER [migration_user];
GO
