Alter Proc [deleteUserCharacter]
	(@Username	varchar(20), @UCName varchar(20))
AS
Declare @chUsernames Table (chUsername varchar(20));
Insert into @chUsernames (chUsername)
	Exec getUserCharacters @Username = @Username;
If (Select Count(*) From @chUsernames Where chUsername = @UCName) < 1
Begin
	Print 'The username ' + Convert(varchar(30), @Username) + ' does not exist'
	return 0;
End
--Delete user character into User_Character table
Declare @delChID int;
--Select the ID of the character to be deleted
Select @delChID = C.ChID From UsernameToUserCharacters As U, Character As C Where 
	U.Username = @Username And C.ChName = @UCName And U.ChID = C.ChID;
Delete From Character Where ChID = @delChID;
return 1;
Go