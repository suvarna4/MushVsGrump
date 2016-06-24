Use MushVsGrump
Go

delete from Weapon;

DBCC CHECKIDENT ('Weapon', RESEED, 0); 

INSERT INTO Weapon (WeName, Attack_Name, Base_Damage, WeaponType)
	Values('Fist', 'Crunch Punch', 10, 'Melee')
INSERT INTO Weapon (WeName, Attack_Name, Base_Damage, WeaponType)
	Values('Sock', 'Stinky Breakfast', 15, 'Ranged')
INSERT INTO Weapon (WeName, Attack_Name, Base_Damage, WeaponType)
	Values('Hammer', 'Strike Thee Down', 20, 'Blunt')
INSERT INTO Weapon (WeName, Attack_Name, Base_Damage, WeaponType)
	Values('Suitcase', 'Paperwork Barrage', 16, 'Melee')
INSERT INTO Weapon (WeName, Attack_Name, Base_Damage, WeaponType)
	Values('Shotgun', 'Shotgun Blast', 19, 'Ranged')
INSERT INTO Weapon (WeName, Attack_Name, Base_Damage, WeaponType)
	Values('Costs Spreadsheet', 'Marginalization', 18, 'Managerial')
INSERT INTO Weapon (WeName, Attack_Name, Base_Damage, WeaponType)
	Values('Pencils', 'Pencil Puncture', 11, 'Dagger') 
	