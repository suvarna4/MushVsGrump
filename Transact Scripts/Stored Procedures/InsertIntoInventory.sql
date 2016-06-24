Use MushVsGrump
Go

ALTER PROCEDURE [dbo].[InsertIntoInventory]
	(@InID [int],
	@ItID [int],
	@quantity [int] = 1)
AS
	if((select count(*) from Inventory where InID=@InID and ItID=@ItID) > 0)
	Begin
		update Inventory set num = num + 1 where InID = @InID and ItID = @ItID;
	End
	else
	begin
	INSERT INTO Inventory
		(InID, ItID, num)
	VALUES(@InID, @ItID, @quantity)		
	end
GO