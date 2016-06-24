Alter Proc [getEnemy]
	(@chName varchar(20), @lvl int)
AS
Set Nocount On;
select Base_HP from Character where ChName = @chName;
Go