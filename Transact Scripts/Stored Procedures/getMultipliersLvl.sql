alter Proc [getMultipliersLvl]
	(@lvl int)
AS
Set Nocount On;
select Damage_Multiplier, HP_Multiplier from Level_Multiplier 
	where Level_num = @lvl;
Go