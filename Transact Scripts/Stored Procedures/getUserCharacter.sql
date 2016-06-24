Alter Proc [getUserCharacter]
	(@Username	varchar(20), @chName varchar(20))
AS
Set Nocount On;
--Insert all character IDs that belong to this user
Declare @ChIDs Table (ChIDT int);
Insert Into @ChIDs (ChIDT) 
	Select ChID From UsernameToUserCharacters Where Username = @Username;
--Retrieve the character that belongs to this user and has chName passed in
select U.Actual_hp, C.Base_HP, U.Exp, U.Floor, U.Room, U.ChID, U.InID
	from Character As C, User_Character as U 
	where C.ChID In (Select ChIDT from @ChIDs) And 
	U.ChID In (Select ChIDT from @ChIDs) And 
	C.ChName = @chName And C.ChID = U.ChID;
Go