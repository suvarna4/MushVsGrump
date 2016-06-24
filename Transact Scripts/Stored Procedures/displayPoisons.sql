Use MushVsGrump
Go

alter PROCEDURE displayPoisons
	(@InID [int])
AS

	SELECT ItName AS Name, num, Amt_Changed, Weapon_Type, wc.ItID
	FROM Item, Inventory, Weapon_Changer as wc
	Where Inventory.ItID = Item.ItID AND Inventory.InID = @InID
	and wc.ItID = Inventory.ItID;
GO