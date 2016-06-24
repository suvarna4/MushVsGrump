Use MushVsGrump;
GO
--If we need to really reset the table delete rows and reset identity seed
--before inserting again.
INSERT INTO Healing_Item (ItID, HP_Healed)
	VALUES (1, 0.15);
INSERT INTO Healing_Item (ItID, HP_Healed)
	VALUES (2, 0.25);
INSERT INTO Healing_Item (ItID, HP_Healed)
	VALUES (3, 0.50);
INSERT INTO Healing_Item (ItID, HP_Healed)
	VALUES (4, 0.75);
INSERT INTO Healing_Item (ItID, HP_Healed)
	VALUES (5, 1);