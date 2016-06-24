USE [MushVsGrump]
GO

/****** Object:  Table [dbo].[HasType]    Script Date: 4/21/2016 4:57:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[HasType](
	[WeID] [int] NULL,
	[WeaponType] [varchar](12) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[HasType]  WITH CHECK ADD FOREIGN KEY([WeaponType])
REFERENCES [dbo].[WeaponType] ([WeaponType])
ON UPDATE set null
ON DELETE set null
GO

ALTER TABLE [dbo].[HasType]  WITH CHECK ADD FOREIGN KEY([WeID])
REFERENCES [dbo].[Weapon] ([WeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

