USE [MushVsGrump]
GO

/****** Object:  Table [dbo].[Level_Multiplier]    Script Date: 4/20/2016 9:26:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Level_Multiplier](
	[Level_num] [tinyint] NULL,
	[Damage_Multiplier] [float] NULL,
	[HP_Multiplier] [float] NULL
) ON [PRIMARY]

GO
Alter table Level_Multiplier Add Constraint Dmg_mult_pos 
Check (Damage_Multiplier > 0);
Alter table Level_Multiplier Add Constraint HP_mult_pos 
Check (HP_Multiplier > 0);
ALTER TABLE [dbo].[Level_Multiplier]  WITH CHECK ADD FOREIGN KEY([Level_num])
REFERENCES [dbo].[Level] ([Level_num])
GO

