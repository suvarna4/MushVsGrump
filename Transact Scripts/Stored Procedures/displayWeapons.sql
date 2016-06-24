
alter proc displayWeapons
	(@ChID int)
AS
	/*SELECT WeName AS Name, H.Weapon_Poison, H.WeID
	FROM Has as H, Weapon As W, Weapon_Changer as wc, Inventory as i
	Where W.WeID = H.WeID and H.ChId = @ChID
	group by H.WeID, H.Weapon_Poison, W.Base_Damage, WeName; */

	SELECT WeName, H.Weapon_Poison, H.WeID, it.ItName, wc.Amt_Changed, W.WeaponType
	FROM Has as H, Weapon As W, Weapon_Changer as wc, item as it
	Where W.WeID = H.WeID and H.ChId = @ChID and it.ItId = wc.ItID and
	it.ItID = h.Weapon_Poison
	group by W.WeaponType, H.WeID, H.Weapon_Poison, W.Base_Damage, WeName, it.ItName, wc.Amt_Changed;
GO