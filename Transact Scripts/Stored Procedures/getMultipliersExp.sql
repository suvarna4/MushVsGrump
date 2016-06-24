Create Proc [getMultipliersExp]
	(@exp float)
AS
Set Nocount On;
--Insert all character IDs that belong to this user
Declare @lvl int;
--ch lvl is max lvl that is below this exp value
Select @lvl = max(level_num) from Level where exp <= @exp;
--Retrieve the character that belongs to this user and has chName passed in
select Damage_Multiplier, HP_Multiplier from Level_Multiplier 
	where Level_num = @lvl;
Go