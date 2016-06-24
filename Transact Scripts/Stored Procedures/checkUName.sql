Create Proc [checkUName]
	(@Username	varchar(20))
AS
--Validate parameters (make sure Username doesn't already exist
If (Select Count(*) From Login Where Username = @Username) > 0
Begin
	Print 'The username ' + Convert(varchar(30), @Username) + ' already exists'
	return 1;
End
return 0;
Go