Use MushVsGrump;
GO
CREATE TABLE Inventory(
	InID int,
	ItID int,
	num int Not Null,
	PRIMARY KEY(InID, ItID),
	Constraint num_items_constraint	Check (num > -1),
	CONSTRAINT Inv_to_Item FOREIGN KEY (ItID) REFERENCES
		Item (ItID) ON DELETE CASCADE ON UPDATE CASCADE,
	)