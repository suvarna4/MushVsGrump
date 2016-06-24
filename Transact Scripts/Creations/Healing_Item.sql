USE [MushVsGrump]
GO

/****** Object:  Table [dbo].[Healing_Item]    Script Date: 4/24/2016 1:01:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Healing_Item](
	[ItID] [int] NOT NULL,
	[HP_Healed] [float] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Healing_Item]  WITH CHECK ADD  CONSTRAINT [FK_Healing_Item_Item] FOREIGN KEY([ItID])
REFERENCES [dbo].[Item] ([ItID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Healing_Item] CHECK CONSTRAINT [FK_Healing_Item_Item]
GO

ALTER TABLE [dbo].[Healing_Item]  WITH CHECK ADD  CONSTRAINT [CK_Healing_Item] CHECK  (([HP_Healed]>(0)))
GO

ALTER TABLE [dbo].[Healing_Item] CHECK CONSTRAINT [CK_Healing_Item]
GO

