Alter Proc [saltedHash]
	(@Username	varchar(20),
	@Password	varchar(40),
	@saltedPass varchar(60) Output)
As
Set @saltedPass = Concat(@Username, @Password)
Set @saltedPass = HashBytes('SHA1', @saltedPass)
print'@saltedPass: ' + @saltedPass;