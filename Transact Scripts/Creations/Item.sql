Use MushVsGrump;
GO
--IF OBJECT_ID('dbo.Item', 'U') IS NOT NULL 
	--DROP TABLE Item;
CREATE TABLE Item(
	ItID int Identity(1,1),
	ItName varchar(40),
	--This is the item description the user will see.
	ItDesc varchar(600),
	PRIMARY KEY(ItID)
	)