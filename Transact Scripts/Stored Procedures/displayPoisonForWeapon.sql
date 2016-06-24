use MushVsGrump;
go
alter proc displayPoisonForWeapon
	(@Weapon_Poison [int],
	@ChID int)
AS
	select i.ItName, wc.Amt_Changed from Weapon_Changer as wc, item as i, has as h 
	where i.ItID = h.Weapon_Poison and i.ItID = wc.ItID
	and h.ChId = @ChID and h.Weapon_Poison = @Weapon_Poison;