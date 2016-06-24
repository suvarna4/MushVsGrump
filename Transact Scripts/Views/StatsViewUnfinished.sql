USE MushVsGrump
GO

CREATE VIEW dbo.StatsView AS

	SELECT (Character.Base_HP * Level_Multiplier.HP_Multiplier) AS MaxHealth
	FROM Character, Level_Multiplier
	Where Character.ChID = uses.