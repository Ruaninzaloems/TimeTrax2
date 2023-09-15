/*
   05 September 2005 12:22:55 PM
   User: sa
   Server: (LOCAL)
   Database: TimeTrax
   Application: MS SQLEM - Data Tools
*/

ALTER TABLE dbo.TT_ProjectResources ADD
	Enabled bit NOT NULL CONSTRAINT DF_TT_ProjectResources_Enabled DEFAULT 1
GO

