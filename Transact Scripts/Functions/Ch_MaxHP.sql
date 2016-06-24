use MushVsGrump;
go
create function ChMaxHP (@baseHP As float(24),
	@HPMult float, @level int)
as
returns float(24)
as
begin
