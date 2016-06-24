Use MushVsGrump
Go

ALTER PROCEDURE [dbo].[Display Inventory]
	(@InID [int])
AS

	SELECT ItName AS Name, num
	FROM Item, Inventory
	Where Inventory.ItID = Item.ItID AND Inventory.InID = @InID;
GO