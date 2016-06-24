Use MushVsGrump
Go

alter PROCEDURE applyPoison
	(@ChID [int],
	@ItID [int],
	@WeID [int],
	@InID int)
AS
	set nocount on;
	if((select distinct(wc.Weapon_Type) from Weapon_Changer as wc, Inventory as i 
		where i.ItID = wc.ItID and i.ItID = @ItID and i.InID = @inID) !=
		(select distinct(w.WeaponType) from Has as h, Weapon as w where 
		h.WeID = w.WeID and w.WeID = @WeID and h.ChId=@ChID))
	Begin
		print('weapon poison not same type as weapon')
		return 0;
	End
	Else
	Begin
	Update Has set Has.Weapon_Poison=@ItID where Has.ChId=@ChID 
	and Has.WeID = @WeID;
	
	Update Inventory Set num = (num - 1) 
	where Inventory.InID = @InID and Inventory.ItID = @ItID;
	If((Select num from Inventory where InID=@InID and ItID=@ItID)=0)
	Begin
		delete from Inventory where InID=@InID and ItID=@ItID;
	End
	return 1;
	End
GO