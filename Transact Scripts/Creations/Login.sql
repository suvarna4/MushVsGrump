Use MushVsGrump;
GO
--IF OBJECT_ID('dbo.Login', 'U') IS NOT NULL 
	--DROP TABLE Login;
CREATE TABLE Login(
	Username varchar(20) Unique Not Null,
	Password nvarchar(50) Not Null,
	PRIMARY KEY(Username),
)