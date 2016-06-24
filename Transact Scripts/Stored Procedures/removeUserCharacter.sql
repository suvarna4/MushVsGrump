Create Proc [removeUserCharacter]
	(@Username	varchar(20), @UCName varchar(20))
AS
Declare @chUsernames Table (chUsername varchar(20));
Insert into @chUsernames (chUsername)
	Exec getUserCharacters @Username = @Username;
If (Select Count(*) From @chUsernames Where chUsername = @UCName) > 0
Begin
	Print 'The username ' + Convert(varchar(30), @Username) + ' already exists'
	return 0;
End
--Insert new user character into User_Character table
Declare @newChID int;
Insert Into Character (ChName, Base_HP) Values(@UCName, 10);
Select @newChID = Max(ChID) from Character;
Insert Into User_Character (ChID)
	Values (@newChID);
--Add new user chacter to this username
Insert Into UsernameToUserCharacters (Username, ChID)
	Values (@Username, @newChID);
return 1;
Go