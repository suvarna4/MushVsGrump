Use MushVsGrump
Go

CREATE PROCEDURE [dbo].[UpdateItemInInventory]
	(@InID [int],
	@ItID [int],
	@quantity [int] = 1)
AS

		UPDATE Inventory
		SET Inventory.num += @quantity
		Where InID = @InID AND ItID = @ItID

GO