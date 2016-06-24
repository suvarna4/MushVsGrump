Use MushVsGrump;
GO
--If we need to really reset the table delete rows and reset identity seed
--before inserting again.
--Delete From Item;
/*DBCC CHECKIDENT ('Item', RESEED, 0);
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Weak Healing Potion', 
	'This potion heals your health by 15% of your maximum possible health.');
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Moderate Healing Potion',
	'This potion heals your health by 25% of your maximum possible health.');
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Strong Healing Potion', 
	'This potion heals your health by 50% of your maximum possible health.');
INSERT INTO Item (ItName, ItDesc)
	VALUES ('L33t Healing Potion', 
	'This potion heals your health by 75% of your maximum possible health.');
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Max Healing Potion', 
	'This potion heals you to full health.');
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Weak Blade Poison',
	'This poison increases the damage dealt by any blade by 5% when applied.  ' +
	'Once applied to a blade type weapon, it cannot be reused.');
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Moderate Blade Poison',
	'This poison increases the damage dealt by any blade by 10% when applied.  ' +
	'Once applied to a blade type weapon, it cannot be reused.');
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Strong Blade Poison',
	'This poison increases the damage dealt by any blade by 20% when applied.  ' +
	'Once applied to a blade type weapon, it cannot be reused.');
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Alchemist''s Blade Poison',
	'This is an alchemist''s special poison to be used on any blade weapon.  ' + 
	'This poison increases the damage dealt by any sword by 30%.' +
	'Once applied to a blade type weapon, it cannot be reused.');
Insert Into Item (ItName, ItDesc)
	Values ('Weak Melee Poison',
	'This poison increases the damage dealt by melee attacks by 5% when applied.  ' +
	'Once applied to a melee weapon, it cannot be reused.')
Insert Into Item (ItName, ItDesc)
	Values ('Moderate Melee Poison',
	'This poison increases the damage dealt by melee attacks by 10% when applied.  ' +
	'Once applied to a melee weapon, it cannot be reused.')
Insert Into Item (ItName, ItDesc)
	Values ('Strong Melee Poison',
	'This poison increases the damage dealt by melee attacks by 20% when applied.  ' +
	'Once applied to a melee weapon, it cannot be reused.')
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Alchemist''s Melee Poison',
	'This is an alchemist''s special poison to be used on any melee weapon.  ' + 
	'This poison increases the damage dealt by any melee attack by 30%.' +
	'Once applied to a melee weapon, it cannot be reused.');
Insert Into Item (ItName, ItDesc)
	Values ('Weak Blunt Poison',
	'This poison increases the damage dealt by blunt weapon attacks by 5% when applied.  ' +
	'Once applied to a blunt type weapon, it cannot be reused.')
Insert Into Item (ItName, ItDesc)
	Values ('Moderate Blunt Poison',
	'This poison increases the damage dealt by blunt weapon attacks by 10% when applied.  ' +
	'Once applied to a blunt type weapon, it cannot be reused.')
Insert Into Item (ItName, ItDesc)
	Values ('Strong Blunt Poison',
	'This poison increases the damage dealt by blunt weapon attacks by 20% when applied.  ' +
	'Once applied to a blunt type weapon, it cannot be reused.')
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Alchemist''s Blunt Poison',
	'This is an alchemist''s special poison to be used on any blunt type weapon.  ' + 
	'This poison increases the damage dealt by any blunt attack by 30%.' +
	'Once applied to a blunt type weapon, it cannot be reused.');
Insert Into Item (ItName, ItDesc)
	Values ('Weak Ranged Poison',
	'This poison increases the damage dealt by range attacks by 5% when applied.  ' +
	'Once applied to a range weapon, it cannot be reused.')
Insert Into Item (ItName, ItDesc)
	Values ('Moderate Ranged Poison',
	'This poison increases the damage dealt by range attacks by 10% when applied.  ' +
	'Once applied to a range weapon, it cannot be reused.')
Insert Into Item (ItName, ItDesc)
	Values ('Strong Ranged Poison',
	'This poison increases the damage dealt by range attacks by 20% when applied.  ' +
	'Once applied to a range weapon, it cannot be reused.')
INSERT INTO Item (ItName, ItDesc)
	VALUES ('Alchemist''s Ranged Poison',
	'This is an alchemist''s special poison to be used on any range weapon.  ' + 
	'This poison increases the damage dealt by any range attack by 30%.' +
	'Once applied to a range weapon, it cannot be reused.'); */
INSERT INTO Item (ItName, ItDesc)
	VALUES ('No Poison',
	'Placeholder instead of null.');