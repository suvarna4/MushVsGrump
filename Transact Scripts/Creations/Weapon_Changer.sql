USE [MushVsGrump]
GO

/****** Object:  Table [dbo].[Weapon_Changer]    Script Date: 4/22/2016 9:19:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
--drop table Weapon_Changer;
CREATE TABLE [dbo].[Weapon_Changer](
	[ItID] [int] NOT NULL,
	[Amt_Changed] [float] NOT NULL,
	[Weapon_Type] [varchar](12) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Weapon_Changer]  WITH CHECK ADD  CONSTRAINT [FK_Weapon_Changer_Item] FOREIGN KEY([ItID])
REFERENCES [dbo].[Item] ([ItID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Weapon_Changer] CHECK CONSTRAINT [FK_Weapon_Changer_Item]
GO

ALTER TABLE [dbo].[Weapon_Changer]  WITH CHECK ADD  CONSTRAINT [FK_Weapon_Changer_WeaponType] FOREIGN KEY([Weapon_Type])
REFERENCES [dbo].[WeaponType] ([WeaponType])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Weapon_Changer] CHECK CONSTRAINT [FK_Weapon_Changer_WeaponType]
GO

