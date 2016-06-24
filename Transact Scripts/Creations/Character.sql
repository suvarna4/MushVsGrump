Use MushVsGrump;
GO
Create TABLE Character (
	ChID int IDENTITY(1,1),
	ChName varchar(20),
	CurrentlyWielding int Not Null,
	Base_HP float(24) Not Null,
	PRIMARY KEY(ChID)
	)

Create Nonclustered Index IndexChName ON Character(ChName);

ALTER TABLE [dbo].[Character]  WITH CHECK ADD  CONSTRAINT [CK_Character] CHECK  (([BASE_HP]>(0)))
GO

ALTER TABLE [dbo].[Character]  WITH CHECK ADD  CONSTRAINT [FK_Is_Weapon] FOREIGN KEY([CurrentlyWielding])
REFERENCES [dbo].[Weapon] ([WeID])
GO

ALTER TABLE [dbo].[Character] CHECK CONSTRAINT [CK_Character]
GO