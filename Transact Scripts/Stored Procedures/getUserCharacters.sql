Alter Proc [getUserCharacters]
	(@Username	varchar(20))
AS
Set Nocount On;
--Insert all character IDs that belong to this user
Declare @ChIDs Table (ChIDT int);
Insert Into @ChIDs (ChIDT) 
	Select ChID From UsernameToUserCharacters Where Username = @Username;
Declare @Usernames Table (UsernameT varchar(20));
DECLARE @MyCursor CURSOR;
Declare @UserN varchar(20);
Declare @tempChID int;
BEGIN
    SET @MyCursor = CURSOR FOR
    select ChIDT From @ChIDs; 
    OPEN @MyCursor;
    FETCH NEXT FROM @MyCursor Into @tempChID;
    WHILE @@FETCH_STATUS = 0
    BEGIN
		Select @UserN = ChName From Character Where ChID = @tempChID;
		Insert Into @Usernames (UsernameT)
		Values (@UserN);
		FETCH NEXT FROM @MyCursor Into @tempChID;
    END; 
    CLOSE @MyCursor;
    DEALLOCATE @MyCursor;
END;
Begin
Select UsernameT From @Usernames;
End;
Go