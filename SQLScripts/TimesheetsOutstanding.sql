

--dbo.TT_FXN_TimesheetsAwaitngApprovalForUser(67, '/TimeTrax') 
--where Message = 'TimesheetApprovalTeamLeader'

select * from 
(

	Select  Message, Detail, UserName, WeekStart , Datepart(week,WeekStart) as WeekNo  --Timesheet approval        
	From   

	(
	SELECT   -- Timesheets awaiting approval by the Teamleader to be shown on the TeamLeader's alerts      
	 DISTINCT Message, Detail, UserName, WeekStart, Period        
	FROM         
	 (
 
	 SELECT       
	   'TimesheetApprovalTeamLeaderMonitor' as Message,        
	   '<a href=''' +  '/TimeTrax' + '/Approvals/Timesheet.aspx?Date='+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate),101)+'''>' + convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c
  
    
	.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103) +'</a>' as Detail,        
	   d.FirstName + ' ' + d.LastName as UserName,        
	   dbo.WeekStartDate(c.TimesheetDate) as WeekStart,        
	   convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103)  as Period        
	  FROM      
	   (

			   SELECT     
			  TimesheetID,     
			  TimeSheetDate,     
			  ApprovalStage,     
			  UserID,     
			  TaskID,  
			  Duration,  
			  Comment      
			FROM      
			  TT_Timesheets a     
			WHERE     
			  TimesheetID not in ( SELECT TimesheetID    
					FROM 
					
					(

					    SELECT    
						TimesheetID, ApproverID     
						FROM      
						TT_Approvals a INNER JOIN  
						TT_Timesheets b on a.ApprovedItemID = b.TimesheetID   
						WHERE     
						a.ApprovalTypeID = 2 AND   
						a.Approved = 1  AND  
						b.ApprovalStage = 4  


					) ApprovedTime
					
					
					     
				   )    
			AND     
			  Submitted = 1    
			AND 
			  ApprovalStage = 3
	   
	   
	   ) c  join  -- Table c is the list of unapproved but submitted timesheets         
	   dbo.Usr_UserDetail d on c.UserID = d.UserID join        
	   dbo.TT_View_ProjectData a on c.TaskID = a.TaskID     
	    
  
		-- Current user is the relevant stage approver for the project        
	 ) mainquery
 
	
	) InnerTable

) ProcCode



full  join 

(

select count(*) as TimeCount,Usr_UserDetail.FirstName + ' ' + Usr_UserDetail.LastName as UserName ,dateadd(day, -(DATEPART(WEEKDAY, TT_Timesheets.TimesheetDate)-1), TT_Timesheets.TimesheetDate) as WeekStart,
Datepart(week,dateadd(day, -(DATEPART(WEEKDAY, TT_Timesheets.TimesheetDate)-1), TT_Timesheets.TimesheetDate)) as WeekNo
   from TT_Projects
  inner join TT_Orders
  on TT_Projects.ProjectID = TT_Orders.ProjectID
  inner join TT_ProjectTasks
  on TT_ProjectTasks.OrderID = TT_Orders.OrderID
  inner join TT_ProjectResources
  on TT_ProjectResources.ProjectID = TT_Projects.ProjectID
  inner join TT_Timesheets
  on TT_Timesheets.TaskID = TT_ProjectTasks.TaskID
  inner join Usr_UserDetail
  on TT_Timesheets.UserID = Usr_UserDetail.UserID
  left join TT_Approvals
  on TT_Approvals.ApprovedItemID = TT_Timesheets.TimesheetID
  where --TT_ProjectResources.UserID = 67
  --and (TSLastApprover = 1)
  --and
   Submitted = 1
  and ApprovalStage = 3
  and TT_Approvals.ApprovalID is null
  group by Usr_UserDetail.FirstName + ' ' + Usr_UserDetail.LastName,dateadd(day, -(DATEPART(WEEKDAY, TT_Timesheets.TimesheetDate)-1), TT_Timesheets.TimesheetDate)
  --order by Datepart(week,dateadd(day, -(DATEPART(WEEKDAY, TT_Timesheets.TimesheetDate)-1), TT_Timesheets.TimesheetDate))

) WorkCode

on ProcCode.UserName = WorkCode.UserName
and ProcCode.WeekStart = WorkCode.WeekStart

order by  WorkCode.WeekStart






--select TT_Approvals.* , TT_Timesheets.* from TT_Approvals
--inner join TT_Timesheets
--on TT_Approvals.ApprovedItemID = TT_Timesheets.TimesheetID
--where ApproverID = 67 and datediff(day,'13 Mar 2017',ApprovalDate) = 0
--order by ApprovalDate


--select * from TT_ProjectResources


--Insert TT_Approvals(ApproverID,ApprovalDate,ApprovedItemID,Comment,Approved)
--select 67,2,

--2	67	2017-03-13 09:34:00	130220		1


select *
from TT_Projects
inner join TT_Orders
on TT_Projects.ProjectID = TT_Orders.ProjectID
inner join TT_ProjectTasks
on TT_ProjectTasks.OrderID = TT_Orders.OrderID
inner join TT_ProjectResources
on TT_ProjectResources.ProjectID = TT_Projects.ProjectID
inner join TT_Timesheets
on TT_Timesheets.TaskID = TT_ProjectTasks.TaskID
inner join Usr_UserDetail
on TT_Timesheets.UserID = Usr_UserDetail.UserID
left join TT_Approvals
on TT_Approvals.ApprovedItemID = TT_Timesheets.TimesheetID
where  Submitted = 1
and ApprovalStage = 3
and TT_Approvals.ApprovalID is null
