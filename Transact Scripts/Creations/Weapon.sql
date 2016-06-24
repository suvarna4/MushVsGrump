USE [MushVsGrump]
GO

/****** Object:  Table [dbo].[Weapon]    Script Date: 5/4/2016 11:27:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
--drop table Weapon;
CREATE TABLE [dbo].[Weapon](
	[WeID] [int] IDENTITY(1,1) NOT NULL,
	[WeName] [varchar](20) NOT NULL,
	[Attack_Name] [varchar](30) NOT NULL,
	[Weapon_Poison] [int] default NULL,
	[Base_Damage] [real] NOT NULL,
	[WeaponType] [varchar](12) default NULL
PRIMARY KEY CLUSTERED 
(
	[WeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].Weapon  WITH CHECK ADD FOREIGN KEY([WeaponType])
REFERENCES [dbo].[WeaponType] ([WeaponType])
ON UPDATE set default
ON DELETE set default
GO

ALTER TABLE [dbo].[Weapon]  WITH CHECK ADD  CONSTRAINT [We_dmg_pos] CHECK  (([Base_Damage]>=(0)))
GO

ALTER TABLE [dbo].[Weapon] CHECK CONSTRAINT [We_dmg_pos]
GO

