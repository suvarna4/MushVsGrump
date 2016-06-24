USE MushVsGrump
GO

CREATE VIEW dbo.InventoryView AS

	SELECT ItName AS Name,ItDesc AS 'Description'
	FROM Item, Inventory
	Where Inventory.ItID = Item.ItID