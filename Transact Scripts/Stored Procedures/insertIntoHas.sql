Use MushVsGrump
Go

create PROCEDURE InsertIntoHas
	(@ChID [int],
	@WeID [int],
	@quantity [int] = 1)
AS
	if((select count(*) from Has where WeID=@WeID and ChId=@ChID) > 0)
	Begin
		update Has set Number= Number + 1 where WeID = @WeID and ChID = @ChID;
	End
	else
	begin
	INSERT INTO Has
		(ChId, WeID, Weapon_Poison, Number)
	VALUES(@ChID, @WeID, 22, 1)		
	end
GO