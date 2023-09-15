


--TeamLeader

DECLARE @TimeSheetApproval table( TimesheetID int);  


Insert TT_Approvals(ApprovalTypeID,ApproverID,ApprovalDate,ApprovedItemID,Comment,Approved)
 OUTPUT INSERTED.ApprovedItemID  INTO @TimeSheetApproval  

select 2,67,getdate(),TT_Timesheets.TimesheetID,'',1
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
where TT_ProjectResources.UserID = 67
and (TeamLeader = 1)
and Submitted = 1
and ApprovalStage = 1
and TT_Approvals.ApprovalID is null


update TT_Timesheets
set ApprovalStage = 4
from TT_Timesheets
inner join 
@TimeSheetApproval ApprovalData
on ApprovalData.TimesheetID = TT_Timesheets.TimesheetID


GO


--TeamLeaderMonitor

DECLARE @TimeSheetApproval table( TimesheetID int);  


Insert TT_Approvals(ApprovalTypeID,ApproverID,ApprovalDate,ApprovedItemID,Comment,Approved)
 OUTPUT INSERTED.ApprovedItemID  INTO @TimeSheetApproval  

select 2,67,getdate(),TT_Timesheets.TimesheetID,'',1
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
where TT_ProjectResources.UserID = 67
and (TSLastApprover = 1)
and Submitted = 1
and ApprovalStage = 1
and TT_Approvals.ApprovalID is null


update TT_Timesheets
set ApprovalStage = 4
from TT_Timesheets
inner join 
@TimeSheetApproval ApprovalData
on ApprovalData.TimesheetID = TT_Timesheets.TimesheetID



GO

--MD Approval

DECLARE @TimeSheetApproval table( TimesheetID int);  


Insert TT_Approvals(ApprovalTypeID,ApproverID,ApprovalDate,ApprovedItemID,Comment,Approved)
OUTPUT INSERTED.ApprovedItemID  INTO @TimeSheetApproval  

select 2,67,getdate(),TT_Timesheets.TimesheetID,'',1
from TT_Projects
inner join TT_Orders
on TT_Projects.ProjectID = TT_Orders.ProjectID
inner join TT_ProjectTasks
on TT_ProjectTasks.OrderID = TT_Orders.OrderID
inner join TT_Timesheets
on TT_Timesheets.TaskID = TT_ProjectTasks.TaskID
inner join Usr_UserDetail
on TT_Timesheets.UserID = Usr_UserDetail.UserID
left join TT_Approvals
on TT_Approvals.ApprovedItemID = TT_Timesheets.TimesheetID
where Submitted = 1
and ApprovalStage = 3
and TT_Approvals.ApprovalID is null


update TT_Timesheets
set ApprovalStage = 4
from TT_Timesheets
inner join 
@TimeSheetApproval ApprovalData
on ApprovalData.TimesheetID = TT_Timesheets.TimesheetID

