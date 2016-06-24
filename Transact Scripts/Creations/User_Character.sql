Use MushVsGrump;
GO
--drop table User_Character;
CREATE TABLE User_Character(
	ChID int,
	InID int Identity(1,1),
	Floor int default 1,
	Room int default 1,
	Exp float Default 100,
	--To be updated when the player saves the game.
	--Loaded into game when player loads the game.
	Actual_hp float(24) default 100,
	PRIMARY KEY(ChID),
	CONSTRAINT UCh_to_Ch FOREIGN KEY (ChID) REFERENCES
		Character (ChID) ON DELETE CASCADE ON UPDATE CASCADE,
	)