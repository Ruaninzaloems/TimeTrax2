/*
   25 October 2005 03:45:25 PM
   User: TimeTraxWeb
   Server: ROUGE
   Database: TimeTrax
   Application: MS SQLEM - Data Tools
*/

BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_TT_System
	(
	PTOApprovals int NOT NULL,
	TSApprovals int NOT NULL,
	PTOApprover1Role int NOT NULL,
	PTOApprover2Role int NULL,
	TSApprover1Role int NOT NULL,
	TSApprover2Role int NULL,
	ForceTSComments bit NOT NULL,
	TaskOrderItem int NOT NULL,
	UseWindowsAuthentication bit NOT NULL,
	MonthlyReminderDay int NOT NULL,
	WeeklyReminderMeridian bit NULL,
	WeeklyReminderHour int NULL,
	WeeklyReminderDOW int NOT NULL,
	WeeklyReminderEnabled bit NOT NULL,
	WeekStartDay int NOT NULL
	)  ON [PRIMARY]
GO
DECLARE @v sql_variant 
SET @v = N'No of approvals required for Project Take on'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'PTOApprovals'
GO
DECLARE @v sql_variant 
SET @v = N'No of approvals required for Timesheets'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'TSApprovals'
GO
DECLARE @v sql_variant 
SET @v = N'Role to appear for Project Take On approver 1'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'PTOApprover1Role'
GO
DECLARE @v sql_variant 
SET @v = N'Role to appear for Project Take On approver 2'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'PTOApprover2Role'
GO
DECLARE @v sql_variant 
SET @v = N'Role to appear for Timesheet approver 1'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'TSApprover1Role'
GO
DECLARE @v sql_variant 
SET @v = N'Role to appear for Timesheet approver 1'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'TSApprover2Role'
GO
DECLARE @v sql_variant 
SET @v = N'Define whether or not users have to enter comments for timesheet items'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'ForceTSComments'
GO
DECLARE @v sql_variant 
SET @v = N'Budget Item to be used for Tasks'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'TaskOrderItem'
GO
DECLARE @v sql_variant 
SET @v = N'Determines if Windows & Forms authentication is used or just forms authentication'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'UseWindowsAuthentication'
GO
DECLARE @v sql_variant 
SET @v = N'AM=0,PM=1'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'WeeklyReminderMeridian'
GO
DECLARE @v sql_variant 
SET @v = N'1 thru 12'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'WeeklyReminderHour'
GO
DECLARE @v sql_variant 
SET @v = N'Day of week 1=Mon, 7=Sun'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'WeeklyReminderDOW'
GO
DECLARE @v sql_variant 
SET @v = N'1:Monday, 7:Sunday'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_TT_System', N'column', N'WeekStartDay'
GO
IF EXISTS(SELECT * FROM dbo.TT_System)
	 EXEC('INSERT INTO dbo.Tmp_TT_System (PTOApprovals, TSApprovals, PTOApprover1Role, PTOApprover2Role, TSApprover1Role, TSApprover2Role, ForceTSComments, TaskOrderItem, UseWindowsAuthentication, MonthlyReminderDay, WeeklyReminderMeridian, WeeklyReminderHour, WeeklyReminderDOW, WeeklyReminderEnabled, WeekStartDay)
		SELECT PTOApprovals, TSApprovals, PTOApprover1Role, PTOApprover2Role, TSApprover1Role, TSApprover2Role, ForceTSComments, TaskOrderItem, UseWindowsAuthentication, MonthlyReminderDay, WeeklyReminderMeridian, WeeklyReminderHour, WeeklyReminderDOW, WeeklyReminderEnabled, WeekStartDay FROM dbo.TT_System TABLOCKX')
GO
DROP TABLE dbo.TT_System
GO
EXECUTE sp_rename N'dbo.Tmp_TT_System', N'TT_System', 'OBJECT'
GO
-- This trigger will remove any additional approvers from the project resources
-- as approvers and set them as a team member 
CREATE   TRIGGER TT_Trig_System
ON dbo.TT_System
FOR UPDATE 
AS 
BEGIN
	Declare @PTOApprovals as Bit
	Select @PTOApprovals = PTOApprovals from TT_System
	If @PTOApprovals = 1
	Begin
		--Delete dbo.TT_ProjectResources where FirstApprover is not null
		Update dbo.TT_ProjectResources
		Set FirstApprover = null
		Where FirstApprover is not null
	End
END
GO
COMMIT
