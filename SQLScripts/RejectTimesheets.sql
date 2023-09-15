--select * from Usr_UserDetail
--where UserName like '%Paula%'
--order by TotalLogin desc


--1.	Paula Mtwentula   --- 1505
--2.	Orapeleng Maragelo --- 1502
--3.	Boipelo Ohentswe  --   1500
--4.	Sinethemba Sikiti -- 1503



declare @UnsubmitTimeSheets as Table (TimesheetID int)


insert @UnsubmitTimeSheets(TimesheetID)

select timesheetid
	--,Usr_UserDetail.FirstName,Usr_UserDetail.LastName, TT_Timesheets.TimesheetDate, TT_Projects.ProjectName, TT_ProjectTasks.TaskName
	
	from TT_Timesheets
	inner join TT_ProjectTasks
	on TT_Timesheets.TaskID = TT_ProjectTasks.TaskID
	inner join TT_Orders
	on TT_Orders.OrderID = TT_ProjectTasks.OrderID
	inner join [dbo].[TT_Projects]
	on TT_Projects.ProjectID = TT_Orders.ProjectID
	inner join Usr_UserDetail
	on Usr_UserDetail.UserID = TT_Timesheets.UserID

	where TT_Timesheets.UserID in ( 1500,1502,1503,1505)
	--order by TT_Timesheets.timesheetid
	and TT_Orders.ProjectID = 5631
	and 
	(
	datediff(day,TimesheetDate,'25 Apr 2016') = 0
	or datediff(day,TimesheetDate,'26 Apr 2016') = 0
	or datediff(day,TimesheetDate,'27 Apr 2016') = 0
	or datediff(day,TimesheetDate,'28 Apr 2016') = 0
	or datediff(day,TimesheetDate,'29 Apr 2016') = 0
	)


 delete from tt_approvals  where ApprovedItemID
 in (

	select timesheetid
	from @UnsubmitTimeSheets


)


WHILE EXISTS(select * from @UnsubmitTimeSheets)
BEGIN 
  
  DECLARE @timesheetid int

  SELECT top 1 @timesheetid = timesheetid from @UnsubmitTimeSheets

  EXEC TT_RejectItem @timesheetid, 2, 155 

  DELETE @UnsubmitTimeSheets where  @timesheetid = timesheetid 

END 
