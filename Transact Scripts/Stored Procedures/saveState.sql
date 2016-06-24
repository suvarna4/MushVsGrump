USE [MushVsGrump]
GO
/****** Object:  StoredProcedure [dbo].[setHP]    Script Date: 5/10/2016 10:53:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[saveState]
	-- Add the parameters for the stored procedure here
	@chID int,
	@floor int,
	@room int,
	@hp real
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE User_Character
	SET Room = @room, [Floor] = @floor, [Actual_hp] = @hp
	WHERE ChID = @ChID
	RETURN
END
