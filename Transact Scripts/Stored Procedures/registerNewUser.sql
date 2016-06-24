Create Proc [registerNewUser]
	(@Username	varchar(20),
	@Password	varchar(40))
AS
--Validate parameters (make sure Username doesn't already exist
If (Select Count(*) From Login Where Username = @Username) > 0
Begin
	Print 'The username ' + Convert(varchar(30), @Username) + ' already exists'
	return 1;
End
Declare @saltedPass varchar(60);
Exec saltedHash @Username = @Username, @Password = @Password, 
@saltedPass = @saltedPass Output;
Print 'salted pass: ' + @saltedPass;
Insert Into Login (Username, Password)
	Values (@Username, @saltedPass);
return 0;
Go