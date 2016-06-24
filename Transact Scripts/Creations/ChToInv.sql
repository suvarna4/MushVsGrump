Use MushVsGrump;
GO
--Table that points a specific user-character to a specific inventory
CREATE TABLE ChToInv(
	InID int Unique,
	ChID int Unique,
	PRIMARY KEY(ChID),
	CONSTRAINT ChToInv_FK_ChID FOREIGN KEY (ChID) REFERENCES
		Character (ChID) ON DELETE CASCADE ON UPDATE CASCADE,
	)