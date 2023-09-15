
/****** Object:  StoredProcedure [dbo].[TT_AddFinancialDocTypeEmail]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*********************************************************
Created by:	SD
Created on:	11/01/2012
Does:		Insert an email for a Financial Document Type

Modified:

*********************************************************/
CREATE procedure [dbo].[TT_AddFinancialDocTypeEmail]  
@FinancialDocTypeID int,  
@UserID int,
@ErrorStatus Int Output  

AS  

IF (SELECT COUNT(*)
	FROM	TT_FinancialDocTypeUsers
	WHERE	FinancialDocTypeID = @FinancialDocTypeID
	AND		UserID = @UserID) = 0
BEGIN

	INSERT INTO TT_FinancialDocTypeUsers
           (FinancialDocTypeID
           ,UserID)
     VALUES
           (@FinancialDocTypeID
           ,@UserID)
END 
  
SET @ErrorStatus = @@Error  
  
  
  
  
  
  



GO
/****** Object:  StoredProcedure [dbo].[TT_AddProfileProjects]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_AddProfileProjects]
@UserID int,
@ProjectID  int
AS
	Insert Into	dbo.TT_ProfileProjects
			(
			UserID,
			ProjectID
			)
	Values
			(
			@UserID,
			@ProjectID
			)





GO
/****** Object:  StoredProcedure [dbo].[TT_AddProfileTasks]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_AddProfileTasks]
@UserID int,
@TaskID  int
AS
	Insert Into	dbo.TT_ProfileTasks
			(
			UserID,
			TaskID
			)
	Values
			(
			@UserID,
			@TaskID
			)




GO
/****** Object:  StoredProcedure [dbo].[TT_AddProfileTOTypes]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_AddProfileTOTypes]
@UserID int,
@TypeID  int
AS
	Insert Into	dbo.TT_ProfileTOTypes
			(
			UserID,
			TypeID
			)
	Values
			(
			@UserID,
			@TypeID
			)





GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateApprovalTypes]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_AddUpdateApprovalTypes]
@ID int,
@constant varchar(30), 
@Enabled bit,
@AddUpdate int --0 For update , 1 for add
AS
If @AddUpdate = 0 
Begin
	Update dbo.TT_ApprovalTypes
	Set	[Description]	   = @constant,
		Enabled    = @Enabled
	Where 	ApprovalTypeID	   = @ID
End
Else 
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- NOT UPDATE THEN INSERT
Begin
	Insert Into	dbo.TT_ApprovalTypes
			(
			[Description],
			Enabled
			)
	Values
			(
			@constant,
			@Enabled
			)
End





GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateClient]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE procedure [dbo].[TT_AddUpdateClient]
@ClientID Int,
@Name varchar(50),
@Code varchar(10),
@PhyAddress varchar(50),
@PosAddress varchar(50),
@PhySuburb varchar(20),
@PosSuburb varchar(20),
@PhyCity varchar(20),
@PosCity varchar(20),
@PhyProvince varchar(20),
@PosProvince varchar(20),
@PosCode varchar(10),
@CountryID Int,
@Enabled bit,
@ErrorStatus Int Output
AS
If @ClientID = 0 
Begin
--  INSERT
Insert Into dbo.TT_Clients
(ClientName, ClientCode, PhyAddress, PostAddress, PhySuburb, PostSuburb, PhyCity, PostCity, PhyProvince, PostProvince, PostCode, CountryID, Enabled)
Values
(@Name, @Code, @PhyAddress, @PosAddress, @PhySuburb, @PosSuburb, @PhyCity, @PosCity, @PhyProvince, @PosProvince, @PosCode, @CountryID, @Enabled)
End
Else 
Begin
--  UPDATE
	Update dbo.TT_Clients
	Set
		ClientName = @Name,
		ClientCode = @Code,
		PhyAddress = @PhyAddress,
		PostAddress = @PosAddress,
		PhySuburb = @PhySuburb,
		PostSuburb = @PosSuburb,
		PhyCity = @PhyCity,
		PostCity = @PosCity,
		PhyProvince = @PhyProvince,
		PostProvince = @PosProvince,
		PostCode = @PosCode,
		CountryID = @CountryID,
		Enabled = @Enabled
	Where 	ClientID	   = @ClientID
End

Set @ErrorStatus = @@Error









GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateContact]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_AddUpdateContact]
@Title varchar(5),
@Name varchar(50),
@LastName varchar(50),
@Department varchar(20),
@TelNo varchar(20),
@Email varchar(50),
@Fax varchar(20),
@Enabled bit,
@ContactID Int Output,
@ErrorStatus Int Output

AS
If @ContactID = 0
Begin
	Insert Into dbo.TT_Contacts
	(Title, FirstName, LastName, Department, Phone, Fax, Email, Enabled)
	Values
	(@Title, @Name, @LastName, @Department, @TelNo, @Fax, @Email, @Enabled)
End
Else
Begin
	Update dbo.TT_Contacts
	Set
		Title = @Title,
		FirstName = @Name, 
		LastName = @LastName, 
		Department = @Department, 
		Phone = @TelNo,
		Fax = @Fax, 
		Email = @Email, 
		Enabled = @Enabled
	Where ContactID = @ContactID
End
Set @ErrorStatus = @@ERROR
Select @ContactID = ContactID From dbo.TT_Contacts Where FirstName = @Name and LastName = @LastName









GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateCostCentre]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE procedure [dbo].[TT_AddUpdateCostCentre]
@CostCentreID Int,
@Name Varchar(50), 
@ManagerID Int,
@CountryID Int,
@Enabled Bit,
@ErrorStatus Int Output
AS
If @CostCentreID = 0 
Begin
--  INSERT
	Insert Into	dbo.TT_CostCentres
			(
			CostCentreName,
			ManagerID,
			CountryID,
			Enabled
			)
	Values
			(
			@Name,
			@ManagerID,
			@CountryID,
			@Enabled
			)
End
Else 
Begin
--  UPDATE
	Update dbo.TT_CostCentres
	Set
		CostCentreName 	= @Name,
		ManagerID				= @ManagerID,
		CountryID				= @CountryID,
		Enabled    			= @Enabled
	Where 	CostCentreID	   = @CostCentreID
End

Set @ErrorStatus = @@Error






GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateCountry]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_AddUpdateCountry]
@CountryID Int,
@Name varchar(50),
@CurrencyID Int,
@ErrorStatus Int Output
AS
IF @CountryID = 0
Begin
  -- Insert
	Insert Into dbo.TT_Countries
	(CountryName,CurrencyID)
	Values
	(@Name,@CurrencyID)
	Set @ErrorStatus = @@ERROR
End
Else
Begin
	-- Update
	Update dbo.TT_Countries
	Set CountryName = @Name,
			CurrencyID = @CurrencyID
	Where CountryID = @CountryID
	Set @ErrorStatus = @@ERROR
End







GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateCurrency]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_AddUpdateCurrency]
@CurrencyID Int,
@Name varchar(50),
@Symbol varchar(3),
@Exchange float,
@ErrorStatus Int Output
AS
IF @CurrencyID = 0
Begin
  -- Insert
	Insert Into dbo.TT_Currencies
	(CurrencyName,CurrencySymbol,ExchangeRate)
	Values
	(@Name,@Symbol,@Exchange)
	Set @ErrorStatus = @@ERROR
End
Else
Begin
	-- Update
	Update dbo.TT_Currencies
	Set CurrencyName = @Name,
			CurrencySymbol = @Symbol,
			ExchangeRate = @Exchange
	Where CurrencyID = @CurrencyID
	Set @ErrorStatus = @@ERROR
End








GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateExpenseItems]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_AddUpdateExpenseItems]
@ID int,
@constant varchar(30), 
@Amount float, 
@Fixed bit,
@Enabled bit
AS
If @ID = 0 
Begin
-- INSERT
	Insert Into	dbo.TT_ExpenseTypes
			(
			[Description],
			Amount,
			Fixed,
			Enabled
			)
	Values
			(
			@constant,
			@Amount,
			@Fixed,
			@Enabled
			)
End
Else 
-- UPDATE
Begin
	Update dbo.TT_ExpenseTypes
	Set	[Description]	   = @constant,
		Amount    = @Amount,
		Fixed    = @Fixed,
		Enabled    = @Enabled
	Where 	ExpenseTypeID  = @ID
End






GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateOrderItems]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_AddUpdateOrderItems]
@ID int,
@constant varchar(30), 
@Enabled bit,
@AddUpdate int --0 For update , 1 for add
AS
If @AddUpdate = 0 
Begin
	Update dbo.TT_OrderItems
	Set	ItemName	   = @constant,
		Enabled    = @Enabled
	Where 	OrderItemID	   = @ID
End
Else 
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- NOT UPDATE THEN INSERT
Begin
	Insert Into	dbo.TT_OrderItems
			(
			ItemName,
			Enabled
			)
	Values
			(
			@constant,
			@Enabled
			)
End





GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateOrders]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**********************************************************
Created by:	VF
Created on: ???
Does:		Saves the order details for the Order Info control

Modified:

03/01/2012 by SD: Added the OrderDate
**********************************************************/
CREATE procedure [dbo].[TT_AddUpdateOrders]  
@ProjID Int,  
@OrderID Int Output,  
@OrderNo varchar(10),  
@EndDate SmallDateTime,
@OrderDate SmallDateTime  

AS  

set dateformat dmy  
  
IF @OrderID is null  
Begin  
 Begin  
  Insert Into dbo.TT_Orders  
    (ProjectID, OrderNumber, EndDate, Approval, OrderDate)  
  Values  
    (@ProjID, @OrderNo, @EndDate, 0, @OrderDate)  
 End  
 IF @@RowCount <> 0  
 Begin  
  -- Return the OrderID  
  Select @OrderID = OrderID From dbo.TT_Orders where ProjectID = @ProjID and OrderNumber = @OrderNo  
 End   
End  
Else  
 Begin  
  Update dbo.TT_Orders  
  Set  
  EndDate = @EndDate
  Where OrderID = @OrderID  
 End  
  
  
  
  
  
  
  



GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateProjectOrderItems]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE procedure [dbo].[TT_AddUpdateProjectOrderItems]
@ItemID Int,
@OrderID Int,
@OrderItemID Int,
@Amount float
AS
If @Amount is not Null
Begin
	If @ItemID is not Null
	Begin
		-- Update Item
		Update dbo.TT_ProjectOrderItems
		Set Amount = @Amount
		Where ItemID = @ItemID
	End
	Else
	Begin
		-- Item does not exist so Insert
		Insert into dbo.TT_ProjectOrderItems
		(OrderID,OrderItemID,Amount)
		Values
		(@OrderID,@OrderItemID,@Amount)
	End
End
Else
Begin
	-- Delete Item
	Delete From dbo.TT_ProjectOrderItems Where ItemID = @ItemID
End










GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateProjectResources]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  /******************************************************************************************************************************    
Created by: VF    
Created on: ???    
Does:  Either inserts, updates or deletes a record from TT_ProjectResources    
Used in:  Timetrax.DAL.AddUpdateResource plus various other places in Timetrax.ProjectTakeOn.aspx.vb    
    
Modified:    
    
07/09/2005 by SD: Added enabled field    
21/12/2005 by SD: If the user adds and then deletes a resource while editing a project, the resource may already exist, so delete.    
03/02/2010 by SD: Remove the TSFirstApprover column as this is always the team leader  
23/02/2012 by SD: Enable the Manager and Teamleader to be the same person
******************************************************************************************************************************/    
CREATE Procedure [dbo].[TT_AddUpdateProjectResources]    
@ResourceID Int,    
@UserID Int,    
@ProjectID Int,    
@Rate float,    
@FirstApprover Int,    
@LastApprover Int,    
@TSLastApprover Int,    
@TeamLeader Int,    
@Enabled bit,    
@ErrorStatus Int Output    
AS    
If @ResourceID is not Null     
Begin    
 If @UserID is Not Null    
 Begin    
    
  --Check that this user doesn't exist already    
  If ( Select  Count(*)     
   From    dbo.TT_ProjectResources    
   Where  ResourceID <> @ResourceID    
   And UserID = @UserID    
   And ProjectID = @ProjectID) > 0    
  Begin    
    
   Delete From dbo.TT_ProjectResources     
   Where ProjectID = @ProjectID     
   And UserID = @UserID    
    
  End    
    
  Update dbo.TT_ProjectResources    
  Set    
   UserID = @UserID,    
   Rate = @Rate,    
   FirstApprover = @FirstApprover,    
   LastApprover = @LastApprover,    
   TSLastApprover = @TSLastApprover,    
   TeamLeader = @TeamLeader,    
   Enabled = @Enabled    
  Where ResourceID = @ResourceID    
 End    
 Else    
 Begin    
  -- ResourceID is not Null, UserID is Null    
  -- Delete Item    
  Delete From dbo.TT_ProjectResources Where ResourceID = @ResourceID    
 End    
End    
Else    
Begin    
 If @UserID is not Null    
 Begin   
   
   If (Select Count(*)
	   From TT_ProjectResources 
	   Where ProjectID = @ProjectID
	   And UserID = @UserID
	   And TeamLeader = 1) > 0
   Begin
		--Allow for Teamleader and Manager to be the same resourc
		Update dbo.TT_ProjectResources    
		Set		       
		   Rate = @Rate,    
		   FirstApprover = @FirstApprover,    
		   LastApprover = @LastApprover,    
		   TSLastApprover = @TSLastApprover,    
		   --TeamLeader = @TeamLeader,    
		   Enabled = @Enabled    
		Where ProjectID = @ProjectID
	    And UserID = @UserID  
	     
   End
   Else
   Begin  
		-- Update Failed so Insert    
		Insert into dbo.TT_ProjectResources    
		(ProjectID,UserID,Rate,FirstApprover,LastApprover,TSLastApprover,TeamLeader, Enabled)    
		Values    
		(@ProjectID,@UserID,@Rate,@FirstApprover,@LastApprover,@TSLastApprover,@TeamLeader, @Enabled)    
    End
 End    
End    
    
Set @ErrorStatus = @@Error    


GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateProjectTasks]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE procedure [dbo].[TT_AddUpdateProjectTasks]
@TaskID Int,
@OrderID Int,
@Name varchar(50),
@Amount float,
@Hours float,
@Billable Bit
AS
If @Name is not Null
Begin
	If @TaskID is not null
	Begin
		-- Update TaskItem
		Update dbo.TT_ProjectTasks
		Set
			TaskName = @Name,
			Amount = @Amount,
			Hours = @Hours,
			Billable = @Billable
		Where TaskID = @TaskID
		And		OrderID = @OrderID
	End
	Else
	Begin
		-- Item does not exist so Insert
		Insert into dbo.TT_ProjectTasks
		(OrderID,TaskName,Amount,Hours,Billable)
		Values
		(@OrderID,@Name,@Amount,@Hours,@Billable)
	End
End
Else
Begin
-- Delete Item
Delete From dbo.TT_ProjectTasks Where TaskID = @TaskID
End










GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateTimeOffType]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE procedure [dbo].[TT_AddUpdateTimeOffType]
@TypeID Int,
@Name Varchar(50), 
@Enabled Bit
AS
If @TypeID = 0 
Begin
--  INSERT
	Insert Into	dbo.TT_TimeOffTypes
			(
			[Description],
			Enabled
			)
	Values
			(
			@Name,
			@Enabled
			)
End
Else 
Begin
--  UPDATE
	Update dbo.TT_TimeOffTypes
	Set
		[Description] 	= @Name,
		Enabled    			= @Enabled
	Where 	TypeID	  = @TypeID
End







GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateTSApprovalProfile]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_AddUpdateTSApprovalProfile]
@UserID Int,
@GroupBy Int
AS
-- TRY UPDATE
	Update dbo.TT_ProfileTSApproval
	Set	[Grouping]	   = @GroupBy
	Where 	UserID  = @UserID
If @@RowCount = 0
Begin
-- INSERT
	Insert Into	dbo.TT_ProfileTSApproval
			(
			UserID,
			[Grouping]
			)
	Values
			(
			@UserID,
			@GroupBy
			)
End






GO
/****** Object:  StoredProcedure [dbo].[TT_AddUpdateUserRates]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[TT_AddUpdateUserRates]
@RateID Int,
@UserID Int,
@CostCentreID Int,
@Rate float
AS
If @RateID is not Null 
Begin
	If @CostCentreID is Not Null
	Begin
		Update dbo.TT_Rates
		Set
			UserID = @UserID,
			CostCentreID = @CostCentreID,
			Rate = @Rate
		Where RateID = @RateID
	End
	Else
	Begin
		-- RateID is not Null, CostCentreID is Null
		-- Delete Item
		Delete From dbo.TT_Rates Where RateID = @RateID
	End
End
Else
Begin
	If @CostCentreID is not Null
	Begin
		-- Update Failed so Insert
		Insert into dbo.TT_Rates
		(UserID,CostCentreID,Rate)
		Values
		(@UserID,@CostCentreID,@Rate)
	End
End







GO
/****** Object:  StoredProcedure [dbo].[TT_AdminSelectClient]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_AdminSelectClient]
AS
Select *
From dbo.TT_Clients
Order By ClientName





GO
/****** Object:  StoredProcedure [dbo].[TT_AdminSelectConstants]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE procedure [dbo].[TT_AdminSelectConstants]
	@Constant varchar(50)
AS
	
	If @constant='Budget Items'
	Begin
		Select 
			isnull(OrderItemID,-1) as [ConstantID],
			isnull(ItemName,'') as [ConstantName],
			isnull(Enabled,0) as [Enabled]
		From dbo.TT_OrderItems
		order by ItemName
	End

	If @constant='Approval Types'
	Begin
		Select 
			isnull(ApprovalTypeID,-1) as [ConstantID],
			isnull([Description],'') as [ConstantName],
			isnull(Enabled,0) as [Enabled]
		From dbo.TT_ApprovalTypes
		order by [Description]
	End

	If @constant='Group Names'
	Begin
		Select 
			isnull(GroupID,-1) as [ConstantID],
			isnull(Descript,'') as [ConstantName],
			isnull(Enabled,0) as [Enabled]
		From dbo.Usr_GroupName
		order by Descript
	End

	If @constant='Role Names'
	Begin
		Select 
			isnull(RoleID,-1) as [ConstantID],
			isnull(RoleName,'') as [ConstantName],
			isnull(Enabled,0) as [Enabled]
		From dbo.Usr_RoleName
		order by RoleName
	End







GO
/****** Object:  StoredProcedure [dbo].[TT_AdminSelectContact]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[TT_AdminSelectContact]
AS
Select ContactID, LastName + ', ' + FirstName as ContactName
From dbo.TT_Contacts
Order by LastName,FirstName








GO
/****** Object:  StoredProcedure [dbo].[TT_AdminSelectCostCentre]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE procedure [dbo].[TT_AdminSelectCostCentre]
AS
Select CostCentreID , CostCentreName
From dbo.TT_CostCentres a
Order by CostCentreName









GO
/****** Object:  StoredProcedure [dbo].[TT_AdminSelectCountry]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_AdminSelectCountry]
@CountryID Int
AS
Select a.*, b.CurrencyName + '(' + b.CurrencySymbol + ')' as CurrencyName
From dbo.TT_Countries a
Join dbo.TT_Currencies b on  a.CurrencyID = b.CurrencyID
Where CountryID = @CountryID






GO
/****** Object:  StoredProcedure [dbo].[TT_AdminSelectCurrency]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_AdminSelectCurrency]
@CurrencyID Int
AS
Select *
From dbo.TT_Currencies
Where CurrencyID = @CurrencyID






GO
/****** Object:  StoredProcedure [dbo].[TT_AdminSelectExpenseItems]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO














CREATE procedure [dbo].[TT_AdminSelectExpenseItems]
AS
	
		Select 
			isnull(ExpenseTypeID,-1) as [ConstantID],
			isnull([Description],'') as [ConstantName],
			Cast(isnull(Amount,0) as Decimal(5,2)) as [Amount],
			isnull(Fixed,0) as [Fixed],
			isnull(Enabled,0) as [Enabled]
		From dbo.TT_ExpenseTypes
		order by [Description]







GO
/****** Object:  StoredProcedure [dbo].[TT_AdminSelectUserRates]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_AdminSelectUserRates]
@UserID Int
AS
Select *
From dbo.TT_Rates a
join dbo.TT_CostCentres b on a.CostCentreID = b.CostCentreID
Where UserID = @UserID
Order By b.CostCentreName





GO
/****** Object:  StoredProcedure [dbo].[TT_CleanUpFinancialDocument]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************  
Created by: SD  
Created on: 28/11/2011  
Does:		Cleans up any inserts that may have happened during
			a failed Financial Document upload 
*****************************************************/  
CREATE procedure [dbo].[TT_CleanUpFinancialDocument]  
	@FinancialDocumentID int
      
AS  

DELETE FROM TT_FinancialDocumentOrderItems
WHERE FinancialDocumentID = @FinancialDocumentID

DELETE FROM TT_FinancialDocuments
WHERE FinancialDocID = @FinancialDocumentID
    




GO
/****** Object:  StoredProcedure [dbo].[TT_DailyEmailNotifications]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/**************************************************************************************
Created by:	SD
Created on:	24/10/2005
Used in:		SQL job running daily checks
Does:		Checks if their are emails to be sent for
		a) Overdue Timesheets	
		b) Timesheets awaiting approval
	    	c) Expenses awaiting approval
		Then builds and sends the emails	
**************************************************************************************/
CREATE procedure [dbo].[TT_DailyEmailNotifications]

AS

Declare @UserID int,
	@FullName varchar(50),
	@Email varchar(50),
	@Now datetime,
	@Interval bigint,
	@RunType int,
	@Body varchar(5000),
	@Subject varchar(50)

--First determine if we must run the notifications now
set dateformat dmy

Declare @DOW int,
	@MonthlyReminderDay int,
	@DayOfMonth datetime,
	@WeeklyEnabled bit

--Retrieve the day of the week to run the weekly reminder and the number of days
--before the end of the month to run the monthly reminder
Select 	@DOW = WeeklyReminderDOW,
	@MonthlyReminderDay = MonthlyReminderDay,
	@WeeklyEnabled = WeeklyReminderEnabled
From 	TT_System

--Get the first day of this month
Select @DayOfMonth = '01/' + convert(varchar(2),Month(getdate())) + '/' + convert(varchar(4),Year(getdate()))
--Get the first day of next month
Select @DayOfMonth = dateadd(m,1,@DayOfMonth)
--Get the last day of this month
Select @DayOfMonth = dateadd(d, -1, @DayOfMonth)

--Get the day to run the monthly reminder
Select @DayOfMonth = dateadd(d, -(@MonthlyReminderDay), @DayOfMonth)

--If today is the day of the week to run the Weekly reminder OR the day of the month to run
--the monthly reminder - then send the emails
If ((datepart(dw,getdate()) = (@DOW + 1)) And (@WeeklyEnabled=1)) Or (DateDiff(d, getdate(), @DayOfMonth) = 0)
Begin

	--It's time to send the emails

	--Set @Now to today's date -- needs to be a variable as we can't pass getdate() into a function
	Select @Now = getdate()  
	
	If  ((datepart(dw,getdate()) = (@DOW + 1)) And (@WeeklyEnabled=1))
	begin
		Select @Subject = 'Timetrax Weekly Notification'
		Select @RunType = 0
	End
	Else
	Begin
		Select @Subject = 'Timetrax Monthly Notification'
		Select @RunType = 1
	End 
		
	--Check if there are any emails to send (Taken from existing stored proc TT_WinS_GetNotificationReceivers)
	DECLARE email_cursor CURSOR FOR
	select
		UserID,
		isnull(FirstName,'') +' ' + isnull(LastName,'') as FullName,
		isnull(Email,'') as Email
	from
		dbo.Usr_UserDetail
	where
	Enabled = 1
	and (
	UserID in (Select UserID from dbo.TT_FXN_AllTimesheetsOverdue(@Now))
	or
	UserID in (Select UserID from dbo.TT_FXN_ExpensesForApproval())
	or
	UserID in (Select UserID from dbo.TT_FXN_TimesheetsForApproval())
	)
	
	OPEN email_cursor
	
	FETCH NEXT FROM email_cursor
	INTO @UserID, @FullName, @Email
	
	-- Determine if their is another email address to send to
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		   -- Concatenate and display the current values in the variables.
		   Set @Body = dbo.TT_FXN_MailReport(@UserID, @FullName, @RunType, @Now) 

		   If (Len(@Body) > 0)
		   Begin
		   	--Send the email
		   	Exec master.dbo.sp_SMTPMail 'info@timetrax.co.za', @Email, @Subject, @Body, 2 	
		   End
	
		   -- This is executed as long as the previous fetch succeeds.
		   FETCH NEXT FROM email_cursor
		   INTO @UserID, @FullName, @Email
	END
	
	CLOSE email_cursor
	DEALLOCATE email_cursor

End  --End Check to see if time to send email



GO
/****** Object:  StoredProcedure [dbo].[TT_DeleteApprovals]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_DeleteApprovals]
@ApprovalItemID Int,
@ApprovalTypeID int
AS

Delete From dbo.TT_Approvals
Where ApprovalTypeID = @ApprovalTypeID
And ApprovedItemID = @ApprovalItemID






GO
/****** Object:  StoredProcedure [dbo].[TT_DeleteFinancialDocTypeEmail]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************************************  
Created by: SD  
Created on: 30/01/2012  
Does:  Deletes an email for a Financial Document Type  
  
Modified:  
  
*********************************************************/  
CREATE procedure [dbo].[TT_DeleteFinancialDocTypeEmail]    
@FinancialDocTypeID int,    
@UserID int
  
AS    
  
IF (SELECT COUNT(*)  
 FROM TT_FinancialDocTypeUsers  
 WHERE FinancialDocTypeID = @FinancialDocTypeID  
 AND  UserID = @UserID) > 0  
BEGIN  
  
 DELETE TT_FinancialDocTypeUsers  
 WHERE	FinancialDocTypeID = @FinancialDocTypeID
 AND	UserID = @UserID
 
END   
    

    
    
    
    
    



GO
/****** Object:  StoredProcedure [dbo].[TT_DeleteFinancialDocument]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************
Created by:	SD
Created on:	06/01/2012
Does:		Deletes a Financial Document
*****************************************************/
Create PROCEDURE [dbo].[TT_DeleteFinancialDocument]
@FinancialDocID int,
@UserID int

AS

INSERT INTO TT_DeletedFinancialDocuments
           (FinancialDocID,OrderID,FinancialDocNo,FinancialDocDate,FinancialDocTypeID,FinancialDocName
           ,FinancialDocTitle,Filesize,Submitted,ApprovalStage,UploadedByUserID,DeletedByUserID,DeletedDate)
SELECT 
	  FinancialDocID
      ,OrderID
      ,FinancialDocNo
      ,FinancialDocDate
      ,FinancialDocTypeID
      ,FinancialDocName
      ,FinancialDocTitle
      ,Filesize
      ,Submitted
      ,ApprovalStage
      ,UploadedByUserID
      ,@UserID
      ,getdate()
FROM 
	TT_FinancialDocuments
WHERE
	FinancialDocID = @FinancialDocID

INSERT INTO TT_DeletedFinancialDocumentOrderItems
           (FinDocOrderItemsID
           ,FinancialDocumentID
           ,OrderItemID
           ,Amount
           ,DeletedByID
           ,DeletedDate)
SELECT FinDocOrderItemsID
      ,FinancialDocumentID
      ,OrderItemID
      ,Amount
      ,@UserID
      ,getdate()
FROM 
	TT_FinancialDocumentOrderItems
WHERE
	FinancialDocumentID = @FinancialDocID


DELETE	TT_FinancialDocumentOrderItems
WHERE	FinancialDocumentID = @FinancialDocID

DELETE	TT_FinancialDocuments
WHERE	FinancialDocID = @FinancialDocID






GO
/****** Object:  StoredProcedure [dbo].[TT_DeleteProfileProject]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_DeleteProfileProject]
@UserID Int,
@ProjectID int
AS

Delete From dbo.TT_ProfileProjects
Where UserID = @UserID
And ProjectID = @ProjectID







GO
/****** Object:  StoredProcedure [dbo].[TT_DeleteUserExpense]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_DeleteUserExpense]
@UserID Int,
@ExpenseID Int
AS

-- delete the values from Expenses
Delete From dbo.TT_Expenses
Where UserID = @UserID and ExpenseID = @ExpenseID






GO
/****** Object:  StoredProcedure [dbo].[TT_DeleteUserTimeOff]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_DeleteUserTimeOff]
@UserID Int,
@TypeID Int
AS

-- delete the values from the timesheet
Delete From dbo.TT_TimeOff
Where UserID = @UserID and TypeID = @TypeID
And Duration = 0
	
-- Also remove the deleted Item from the Users Profile
Delete From dbo.TT_ProfileTOTypes
Where UserID = @UserID and TypeID = @TypeID








GO
/****** Object:  StoredProcedure [dbo].[TT_DeleteUserTimeSheet]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_DeleteUserTimeSheet]
@UserID Int,
@TaskID Int
AS

-- delete the values from the timesheet
Delete From dbo.TT_Timesheets
Where UserID = @UserID and TaskID = @TaskID
And Duration = 0

-- Also remove the deleted Task from the Users TaskProile
Delete From dbo.TT_ProfileTasks
Where UserID = @UserID and TaskID = @TaskID
	






GO
/****** Object:  StoredProcedure [dbo].[TT_EnableDisableProjectResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/**************************************************************************************
Created by:	SD
Created on:	24/10/2005
Used in:		Timetrax.DAL.EnableDisableProjectResource
Does:		Either enables or disables the specified user for the specified Project
**************************************************************************************/
CREATE procedure [dbo].[TT_EnableDisableProjectResource]
@ProjectID Int,
@UserID int,
@Enabled bit

AS

Update		dbo.TT_ProjectResources
Set		Enabled = @Enabled
Where 		ProjectID = @ProjectID
And		UserID = @UserID



GO
/****** Object:  StoredProcedure [dbo].[TT_GenerateClientCode]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_GenerateClientCode]
As

Declare @Code as varchar(4)
Declare @Count as int

Select @Count = (isnull(Max(SUBSTRING(ClientCode,2,3)),0) + 1)--Count(isnull(ClientID,0)) + 1
From dbo.TT_Clients

If @Count > 99
	Begin
		Set @Code = 'C' + Cast(@Count as varchar)
	End
Else
	Begin
		If @Count < 10
			Begin
				Set @Code = 'C00' + Cast(@Count as varchar)
			End
		Else
			Begin
				Set @Code = 'C0' + Cast(@Count as varchar)
			End
	End

Select @Code




GO
/****** Object:  StoredProcedure [dbo].[TT_GenerateProjectCode]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_GenerateProjectCode]
@ClientID as Int
As

Declare @ClientCode as varchar(4)
Declare @Count as int
Declare @Code as varchar(4)

Select @ClientCode = ClientCode
From dbo.TT_Clients
Where ClientID = @ClientID

Select @Count = (isnull(Max(SUBSTRING(ProjectCode, 6, 3)),0) + 1) --Count(ProjectID) + 1
From dbo.TT_Projects
Where ClientID = @ClientID

If @Count > 99
	Begin
		Set @Code = 'J' + Cast(@Count as varchar)
	End
Else
	Begin
		If @Count < 10
			Begin
				Set @Code = 'J00' + Cast(@Count as varchar)
			End
		Else
			Begin
				Set @Code = 'J0' + Cast(@Count as varchar)
			End
	End

Select @ClientCode + @Code










GO
/****** Object:  StoredProcedure [dbo].[TT_GetAuthenticationMethod]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_GetAuthenticationMethod]
AS
Select isnull(UseWindowsAuthentication,0)
From dbo.TT_System






GO
/****** Object:  StoredProcedure [dbo].[TT_GetProjectCloseOutList]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*****************************************************************************************************
Created by:	SB
Created on:	10/08/2005
Does:		Returns a list of project indicating recent activity
*****************************************************************************************************/
CREATE procedure [dbo].[TT_GetProjectCloseOutList]
@PassedEndDate bit,
@TeamLeaderID int,
@ClientID int

AS

Select 	Distinct a.ProjectID, 
	a.ProjectCode, 
	a.ProjectName, 
	convert(varchar, a.StartDate, 103) as StartDate, 
	convert(varchar, a.EndDate, 103) as EndDate, 
	convert(varchar, c.LastTimesheet, 103) as LastTimesheet, 
	convert(varchar, b.LastExpense, 103) as LastExpense
From 	TT_Projects a
left join 	dbo.TT_FXN_GetLastExpense() b on a.ProjectID = b.ProjectID
left join 	dbo.TT_FXN_GetLastTimesheet() c on a.ProjectID = c.ProjectID
inner join TT_ProjectStatus d on a.ProjectID = d.ProjectID
inner join TT_ProjectResources e on a.ProjectID = e.ProjectID and e.TeamLeader = 1
Where	StatusID <> 4
And	((@PassedEndDate = 1 And DateDiff(d, getdate(), a.EndDate) < 0)
Or	(@PassedEndDate = 0 And ((a.ClientID = @ClientID or @ClientID = 0) And (e.UserID = @TeamleaderID or @TeamleaderID = 0))))
Order by a.ProjectName



GO
/****** Object:  StoredProcedure [dbo].[TT_GetTeamLeaderRoleID]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_GetTeamLeaderRoleID]
AS
Select isnull(GroupID,0) as RoleID
From dbo.Usr_GroupName
Where Descript = 'Team Leader'






GO
/****** Object:  StoredProcedure [dbo].[TT_IncrementApprovalStage]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_IncrementApprovalStage]
@ItemID Int,
@ApprovalType Int

As

-- This procedure will depending on the ApprovalType
-- 1) PTO - Take a given ProjectID,
-- 2) Timesheet - Take a given TimesheetID,
-- 3) Expense - Take a given ExpenseID,
-- and Increment the Approval Stage for that Item
-- by setting ApprovalStage to ApprovalStage + 1
-- ApprovalStage may not be greater than 2


If @ApprovalType = 1
Begin
	-- Project Take On Item
	
	Update TT_ProjectStatus
	Set ApprovalStage = Case When ApprovalStage is Null Then 1 Else 2 End
	Where ProjectID = @ItemID
End

If @ApprovalType = 2
Begin
	-- Timesheet Item
--	Declare @TaskID as Int
--	Declare @StartDate as SmallDateTime
	
--	Select @TaskID = TaskID, @StartDate = dbo.WeekStartDate(TimesheetDate)
--	From dbo.TT_Timesheets
--	Where TimesheetID = @ItemID
	
	Update TT_Timesheets
	Set ApprovalStage = Case When ApprovalStage is Null Then 1 Else 2 End
	Where TimesheetID = @ItemID
--	Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)
--	And TaskID = @TaskID 
End

If @ApprovalType = 3
Begin
	-- Expense Item
	
	Update TT_Expenses
	Set ApprovalStage = Case When ApprovalStage is Null Then 1 Else 2 End
	Where ExpenseID = @ItemID
End







GO
/****** Object:  StoredProcedure [dbo].[TT_InsertApproval]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /**************************************************************************************************************        
Created by: VF        
Created on: ??        
Does:  Inserts an item in the Approvals table and either increments the approval stage        
  or rejects the item        
        
Modified:        
        
13/09/2005 by SD:  Need to pass in the UserID so that when a timesheet is rejected, only the         
        timesheets for the relevant user are rejected        
15/02/2010 by SD:  Removed incrementing the ApprovalStageID as the field was changed to mean:      
 Null - Not submitted      
 1 - Submitted and awaiting approval by Teamleader      
 2 - Submitted and awaiting approval by Manager      
 3 - Approved (either by Teamleader or Manager)      
       
 So this procedure was changed to always set the ApprovalStage to 3     
   
 05/01/2012 by SD: Added Financial Documents      
 
 06/02/2012 by SD: Now 3 levels of approval so the procedure was changed to 
			always set ApprovalStage = 4.  Approval stages are now as follows:
			
 1 - Submitted and awaiting approval by Teamleader      
 2 - Submitted and awaiting approval by Manager      
 3 - Submitted and awaiting approval by MD
 4 - Approved (either by Teamleader, Manager or MD)        
       
**************************************************************************************************************/        
CREATE procedure [dbo].[TT_InsertApproval]        
 @ApprovalType Int,        
 @ApproverID Int,        
 @ApprovedItemID Int,        
 @Comment VarChar(200),        
 @Approved Bit, -- 0 = Rejected, 1 = Approved        
 @UserID int        
        
As        
-- First Try Deleting Existing Record        
DELETE FROM       
 dbo.TT_Approvals         
WHERE       
 ApprovalTypeID = @ApprovalType AND       
 ApproverID = ApproverID AND       
 ApprovedItemID = @ApprovedItemID        
        
-- Then Insert a new Record        
INSERT INTO dbo.TT_Approvals        
 (ApprovalTypeID,ApproverID,ApprovalDate,ApprovedItemID,Comment, Approved)        
VALUES        
 (@ApprovalType,@ApproverID,GetDate(),@ApprovedItemID,@Comment,@Approved)        
        
IF @Approved = 0        
BEGIN      
 EXEC TT_RejectItem @ApprovedItemID, @ApprovalType, @UserID        
END        
ELSE        
BEGIN      
 -- Increment the ApprovalStage for the Item        
 -- Exec TT_IncrementApprovalStage @ApprovedItemID, @ApprovalType        
        
IF @ApprovalType = 2    
BEGIN    
 UPDATE       
  TT_Timesheets        
 SET       
  ApprovalStage = 4      
 WHERE       
  TimesheetID = @ApprovedItemID        
END    
    
IF @ApprovalType = 3    
BEGIN    
 UPDATE       
  TT_Expenses        
 SET       
  ApprovalStage = 4     
 WHERE       
  ExpenseID = @ApprovedItemID        
END    
  
IF @ApprovalType = 6    
BEGIN    
 UPDATE       
  TT_FinancialDocuments  
 SET       
  ApprovalStage = 3      
 WHERE       
  FinancialDocID = @ApprovedItemID        
END   
      
END 



GO
/****** Object:  StoredProcedure [dbo].[TT_InsertClient]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_InsertClient]
@Name varchar(50),
@Code varchar(10),
@PhyAddress varchar(50),
@PosAddress varchar(50),
@PhySuburb varchar(20),
@PosSuburb varchar(20),
@PhyCity varchar(20),
@PosCity varchar(20),
@PhyProvince varchar(20),
@PosProvince varchar(20),
@PosCode varchar(10),
@CountryID Int,
@Enabled bit,
@ClientID Int Output,
@ErrorStatus Int Output

AS

Insert Into dbo.TT_Clients
(ClientName, ClientCode, PhyAddress, PostAddress, PhySuburb, PostSuburb, PhyCity, PostCity, PhyProvince, PostProvince, PostCode, CountryID, Enabled)
Values
(@Name, @Code, @PhyAddress, @PosAddress, @PhySuburb, @PosSuburb, @PhyCity, @PosCity, @PhyProvince, @PosProvince, @PosCode, @CountryID, @Enabled)
Set @ErrorStatus = @@ERROR

Select @ClientID = ClientID From dbo.TT_Clients Where ClientName = @Name and ClientCode = @Code






GO
/****** Object:  StoredProcedure [dbo].[TT_InsertContact]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_InsertContact]
@Title varchar(5),
@Name varchar(50),
@LastName varchar(50),
@Department varchar(20),
@TelNo varchar(10),
@Email varchar(50),
@Fax varchar(10),
@Enabled bit,
@ContactID Int Output,
@ErrorStatus Int Output

AS

if not exists (Select * From dbo.TT_Contacts Where FirstName = @Name and LastName = @LastName and Email = @Email)
Begin
	Insert Into dbo.TT_Contacts
	(Title, FirstName, LastName, Department, Phone, Fax, Email, Enabled)
	Values
	(@Title, @Name, @LastName, @Department, @TelNo, @Fax, @Email, @Enabled)
End

Set @ErrorStatus = @@ERROR
Select @ContactID = ContactID From dbo.TT_Contacts Where FirstName = @Name and LastName = @LastName and Email = @Email





GO
/****** Object:  StoredProcedure [dbo].[TT_InsertFinancialDocument]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    
/*****************************************************      
Created by: SD      
Created on: 24/11/2011      
Does:  Inserts a financial document     
  
Modified:  
  
04/01/2012 by SD: Added the approvals   
*****************************************************/      
CREATE procedure [dbo].[TT_InsertFinancialDocument]        
        
@OrderID Int,      
@FinancialDocNo varchar(50),         
@FinancialDocDate datetime,       
@FinancialDocTypeID int,       
@FinancialDocumentName varchar(50),        
@FinancialDocTitle varchar(50),        
@FileSize int,  
@ApprovalRequired bit,  
@UserID int        
        
AS     
  
DECLARE @FinancialDocumentID int  
     
INSERT INTO TT_FinancialDocuments      
           (OrderID      
           ,FinancialDocNo      
           ,FinancialDocDate      
           ,FinancialDocTypeID      
           ,FinancialDocName      
           ,FinancialDocTitle      
           ,Filesize  
           ,Submitted  
           ,ApprovalStage
           ,UploadedByUserID)      
     VALUES      
           (@OrderID      
           ,@FinancialDocNo      
           ,@FinancialDocDate      
           ,@FinancialDocTypeID      
           ,@FinancialDocumentName      
           ,@FinancialDocTitle      
           ,@FileSize  
           ,CASE @ApprovalRequired  
    WHEN 0 THEN 1  -- Automatically approve it  
    WHEN 1 THEN 1  -- Submit it for approval  
   END  
     ,CASE @ApprovalRequired  
    WHEN 0 THEN 3  -- Automatically approve it  
    WHEN 1 THEN 1  -- Submit it for approval  
   END,
   @UserID)      
      
SELECT @FinancialDocumentID = @@Identity   
  
IF @ApprovalRequired = 0  -- If Approval is not required, then automatically insert the approval  
BEGIN  
 INSERT INTO TT_Approvals (ApprovalTypeID, ApproverID, ApprovalDate, ApprovedItemID, Comment, Approved)  
    VALUES (6    
           ,@UserID  
           ,getdate()  
           ,@FinancialDocumentID  
           ,'Automatically approved as no Approval required for this Financial Document Type'  
           ,1)  
    
 END  
   
 SELECT @FinancialDocumentID AS FinancialDocumentID 



GO
/****** Object:  StoredProcedure [dbo].[TT_InsertFinancialDocumentOrderItem]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************
Created by:	SD
Created on:	24/11/2011
Does:		Inserts a financial document OrderItem
*****************************************************/
CREATE procedure [dbo].[TT_InsertFinancialDocumentOrderItem]
	@FinancialDocumentID int,
    @OrderItemID int,
    @Amount money
    
AS

INSERT INTO TT_FinancialDocumentOrderItems
	(FinancialDocumentID
    ,OrderItemID
    ,Amount)
VALUES
    (@FinancialDocumentID
    ,@OrderItemID
    ,@Amount)





GO
/****** Object:  StoredProcedure [dbo].[TT_InsertProject]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_InsertProject]
@Code varchar(10),
@FullName varchar(50),
@Name varchar(50),
@ClientID Int,
@ContactID Int,
@AdminID Int,
@StartDate SmallDateTime,
@EndDate SmallDateTime,
@CostCentreID Int,
@Comments varchar(500),
@ProjID Int Output,
@ErrorStatus Int Output

As
set dateformat dmy
Insert Into dbo.TT_Projects
(ProjectCode,FullName,ProjectName,ClientID,ContactID,AdminContactID,StartDate,EndDate,CostCentreID,Approval1,Approval2,Comments)
Values
(@Code,@FullName,@Name,@ClientID,@ContactID,@AdminID,@StartDate,@EndDate,@CostCentreID,null,null,@Comments)
Set @ErrorStatus = @@ERROR

Select @ProjID = ProjectID From dbo.TT_Projects Where ProjectName = @Name and ProjectCode = @Code








GO
/****** Object:  StoredProcedure [dbo].[TT_InsertProjectDocument]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_InsertProjectDocument]

@ProjectID Int,
@DocumentName varchar(50),
@Title varchar(255),
@DocumentDate smalldatetime,
@Who varchar(50),
@Size int

AS

	Insert into dbo.TT_ProjectDocuments
	(ProjectID, DocumentName, Title, DocumentDate, Who, FileSize)
	Values
	(@ProjectID, @DocumentName, @Title, @DocumentDate, @Who, @Size)









GO
/****** Object:  StoredProcedure [dbo].[TT_RecallUserTimesheet]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_RecallUserTimesheet]
@UserID Int,
@StartDate SmallDateTime
AS

Update TT_Timesheets
Set Submitted = Null,
	ApprovalStage = Null
Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)
And UserID = @UserID 

-- Recall TimeOff Entries (if any)
Update TT_TimeOff
Set Submitted = Null,
	ApprovalStage = Null
Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)
And UserID = @UserID 







GO
/****** Object:  StoredProcedure [dbo].[TT_RejectItem]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /*********************************************************************************************    
Created by: VF    
Created on: ???    
Does:  Rejects an item    
Used in:  TT_InsertApproval    
    
Modified:    
    
13/09/2004 by SD: Fix the error where timesheets were randomly becoming unsubmitted.  This was happening because all timesheets for a given    
       task were being updated to Submitted Null and ApprovalStage Null.  This must only be done for the User who's timesheet has    
       been unsubmitted so I have added a UserID parameter     
15/02/2010 by SD: Only unsubmit the timesheet that is being rejected instead of all timesheets for that task for that week    
05/01/2012 by SD: Add Financial Documents
*********************************************************************************************/    
CREATE procedure [dbo].[TT_RejectItem]    
@ItemID Int,    
@ApprovalType Int,    
@UserID int    
    
As    
    
  Declare @TaskID as Int    
  Declare @TypeID as Int    
  Declare @StartDate as SmallDateTime    
    
-- This procedure will take a given ItemID and process it according to the ApprovalTypeID    
If @ApprovalType = 1    
Begin    
 -- Project Take On Item    
 Update TT_ProjectStatus    
 Set ApprovalStage = Null    
 Where ProjectID = @ItemID    
End    
   
If @ApprovalType = 2    
Begin    
  
/*  
 -- Get the TaskID and WeekStartDate and     
 -- Unsubmit each day for that week for that task    
 -- by setting Submitted and ApprovalStage to Null    
      
 Select @TaskID = TaskID, @StartDate = dbo.WeekStartDate(TimesheetDate)    
 From dbo.TT_Timesheets    
 Where TimesheetID = @ItemID    
      
 Update TT_Timesheets    
 Set  Submitted = Null,    
  ApprovalStage = Null    
 Where  TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)    
 And TaskID = @TaskID     
 And  UserID = @UserID   --SD - Fix for timesheets randomly being unsubmitted    
   
*/  
 Update   
  TT_Timesheets    
 Set    
  Submitted = Null,    
  ApprovalStage = Null    
 Where    
  TimesheetID = @ItemID  
  
End    
  
If @ApprovalType = 3    
Begin    
 -- Expense Item    
 Update TT_Expenses    
 Set Submitted = Null,    
  ApprovalStage = Null    
 Where ExpenseID = @ItemID    
End    
  
If @ApprovalType = 5    
Begin    
 -- Get the TypeID and WeekStartDate and     
 -- Unsubmit each day for that week for that TimeOff type    
 -- by setting Submitted and ApprovalStage to Null    
      
 Select @TypeID = TypeID, @StartDate = dbo.WeekStartDate(TimeOffDate)    
 From dbo.TT_TimeOff    
 Where TimeOffID = @ItemID    
      
 Update TT_TimeOff    
 Set Submitted = Null,    
  ApprovalStage = Null    
 Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)    
 And TypeID = @TypeID     
   
End    

If @ApprovalType = 6   
Begin    
 -- Financial Document
 Update TT_FinancialDocuments 
 Set Submitted = Null,    
  ApprovalStage = Null    
 Where FinancialDocID = @ItemID    
End 



GO
/****** Object:  StoredProcedure [dbo].[TT_RejectTaskWeek]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_RejectTaskWeek]
@TimesheetID Int
As

-- This procedure will take a given TimesheetID,
-- Get the TaskID and WeekStartDate and 
-- Unsubmit each day for that week for that task
-- by setting Submitted and ApprovalStage to Null

Declare @TaskID as Int
Declare @StartDate as SmallDateTime

Select @TaskID = TaskID, @StartDate = dbo.WeekStartDate(TimesheetDate)
From dbo.TT_Timesheets
Where TimesheetID = @TimesheetID

Update TT_Timesheets
Set Submitted = Null,
	ApprovalStage = Null
Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)
And TaskID = @TaskID 





GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_DataExtract]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/************************************************************************
Created by:	SD
Created on:	??
Does:		Retrieves the data for the Data Extract

Modified:

03/02/2012 by SD: Included Employee Code
06/02/2012 by SD: Included Billable
************************************************************************/
CREATE Procedure [dbo].[TT_Rep_DataExtract]  
	@ProjectID Int,  
	@Start SmallDateTime,  
	@End SmallDateTime,  
	@Task Int,  
	@Users varchar(5000),  
	@CaptureTypeID int  
AS  
  
Select  
 convert(varchar, a.TimesheetDate,103) 'Date',  
 DateName(mm,a.TimesheetDate) as 'Month',  
 DateName(yy,a.TimesheetDate) as 'Year',  
 c.FirstName + ' ' + c.Lastname as 'User',
 isNULL(c.EmployeeCode,'') as 'Employee Code',  
 e.ProjectCode,  
 e.ProjectName,  
 b.TaskName,  
 a.duration 'Minutes',  
 dbo.converttohours(a.duration,100) as 'Hours',  
 a.Comment,
 a.TimesheetID,
 CASE b.Billable 
	WHEN 0 THEN 'No'
	WHEN 1 THEN 'Yes'
 End As Billable
From   
 dbo.TT_FXN_TimesheetsByCaptureType(@CaptureTypeID, @ProjectID) aa inner join   
 TT_Timesheets a on  a.TimesheetID = aa.TimesheetID inner join   
 TT_ProjectTasks b on a.TaskID = b.TaskID inner join   
 Usr_UserDetail c on a.UserID = c.UserID inner join   
 TT_Orders d on b.OrderID = d.OrderID inner join   
 TT_Projects e on d.ProjectID = e.ProjectID   
where   
 (e.ProjectID = @ProjectID Or @ProjectID = 0) and    
 (a.TimesheetDate Between @Start and @End) and    
 Case When @Task = 0 Then 0 Else b.TaskID End = @Task  and    
 ((PATINDEX('%,' + Cast(c.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))  
Union  
Select  
 convert(varchar, a.TimeOffDate,103) 'Date',  
 DateName(mm,a.TimeOffDate) as 'Month',  
 DateName(yy,a.TimeOffDate) as 'Year',  
 c.FirstName + ' ' + c.Lastname as 'User',  
 isNULL(c.EmployeeCode,'') as 'Employee Code',  
 '',  
 'Time Off' as Project,   
 b.Description,  
 a.duration 'Minutes',  
 dbo.converttohours(a.duration,100) as 'Hours',  
 a.Comment,
 a.TimeOffID,
 'No' AS Billable
From   
 dbo.TT_FXN_TimeOffByCaptureType(@CaptureTypeID) aa inner join   
 TT_TimeOff a on  a.TimeOffID = aa.TimeOffID inner join   
 TT_TimeOffTypes b on a.TypeID = b.TypeID inner join   
 Usr_UserDetail c on a.UserID = c.UserID   
where   
 (@ProjectID = 0) and    
 (@Task = 0) and  
 (a.TimeOffDate Between @Start and @End) and    
 ((PATINDEX('%,' + Cast(c.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))  
order by 'Date'  
  
  
  
  



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_Exceptions]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the data for the Exceptions Report
Used in:		Timetrax.DAL.ReportExceptions

Modified:

21/10/2005 by SD:  Added Order by
***************************************************************************/
CREATE Procedure [dbo].[TT_Rep_Exceptions]
@TeamLeaderID Int
As

Select 	a.ProjectID, 
	Coalesce(a.ProjectName,'') as ProjectName,
	Coalesce(Convert(varchar,a.StartDate,103), '') as StartDate, 
	Coalesce(Convert(varchar,a.EndDate,103),'') as EndDate,
	Coalesce(dbo.CalcProjectBudgetCost(a.ProjectID), '') as BudCost,
	Coalesce(dbo.CalcProjectBudgetHours(a.ProjectID),'') as BudHrs,
	Coalesce(dbo.CalcProjectCurrentCost(a.ProjectID,GetDate()),'') as Cost, 
	Coalesce(dbo.CalcProjectCurrentHours(a.ProjectID,GetDate()), '') as Hrs
From dbo.TT_Projects a
Left Join dbo.TT_ProjectResources b on a.ProjectID = b.ProjectID and TeamLeader = 1
Left Join dbo.TT_ProjectStatus c on a.ProjectID = c.ProjectID
Where c.StatusID = 3 -- In Progress
And Case @TeamLeaderID When 0 Then 0 Else b.UserID End = @TeamLeaderID
Order by a.ProjectName



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_Expenses]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the expenses matching the search criteria
Used in:		Timetrax.DAL.ReportExpenses

Modified:

16/09/2005 by SD: Add filters for client
05/10/2005 by SD: Fix users filter and add Capture Type Filter
09/10/2005 by SD: Add expense month filter
*********************************************************************************************************************************/
CREATE procedure [dbo].[TT_Rep_Expenses]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime,
@Users varchar(5000),
@ClientID int,
@CaptureTypeID int,
@ExpenseMonth smalldatetime

As

-- Get the Client Details
Select 	ClientID, ClientName
From 	dbo.TT_Clients a
--Where 	(a.ClientID = @ClientID OR @ClientID = 0)
--And       (a.ClientID IN (Select ClientID From dbo.TT_Projects where ProjectID = @ProjectID) OR (@ProjectID = 0) )
Where a.ClientID in (	Select 	Distinct d.ClientID
			From 	TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) e
			inner join dbo.TT_Expenses a on a.ExpenseID = e.ExpenseID
			Join 	dbo.TT_ExpenseTypes b on a.ExpenseTypeID = b.ExpenseTypeID
			Join 	dbo.TT_Projects d on a.ProjectID = d.ProjectID
			Where 	((a.ProjectID = @ProjectID OR @ProjectID = 0) AND (d.ClientID = @ClientID OR @ClientID = 0))
			and 	((a.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
			--and 	a.ExpenseID in (select ExpenseID from dbo.ApprovedExpenses(@ProjectID))
			and 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
			and       (datediff(d,a.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null))


-- Get the Project Details
--SD: 19/09/2005 Removed calcs as I don't think they're used
Select  ProjectID, ProjectCode, ProjectName, ClientID
From 	dbo.TT_Projects Proj
--Where 	(Proj.ProjectID = @ProjectID OR @ProjectID = 0)
--And	(Proj.ClientID = @ClientID OR @ClientID = 0) 
Where ProjectID in (	Select 	Distinct a.ProjectID
			From 	TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) e 
			inner join dbo.TT_Expenses a on a.ExpenseID = e.ExpenseID
			Join 	dbo.TT_ExpenseTypes b on a.ExpenseTypeID = b.ExpenseTypeID
			Join 	dbo.TT_Projects d on a.ProjectID = d.ProjectID
			Where 	((a.ProjectID = @ProjectID OR @ProjectID = 0) AND (d.ClientID = @ClientID OR @ClientID = 0))
			and 	((a.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
			--and 	a.ExpenseID in (select ExpenseID from dbo.ApprovedExpenses(@ProjectID))
			and	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
			and       (datediff(d,a.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null))



-- Get the User Details
Select Distinct Cast(ProjectID as varchar) + '_' + Cast(UserID as varchar) as KeyVal, ProjectID, UserID, UserName
From (
	Select 	a.ProjectID, a.ExpenseID as Expense, e.UserID, e.LastName + ', ' + e.FirstName as UserName
	From 	TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) ex
	inner join dbo.TT_Expenses a on a.ExpenseID = ex.ExpenseID
	Join 	dbo.TT_Projects d on a.ProjectID = d.ProjectID 
	Join 	dbo.Usr_UserDetail e on a.UserID = e.UserID
	Where 	((a.ProjectID = @ProjectID OR @ProjectID = 0) AND (d.ClientID = @ClientID OR @ClientID = 0))
	and 	((a.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
	--and 	a.ExpenseID in (select ExpenseID from dbo.ApprovedExpenses(@ProjectID))
	and 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
	and       (datediff(d,a.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null)
) a


-- Get the Expense Items Details
Select
	 Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar) as KeyVal, 
	 ProjectID, UserID, Expense, 
	 Convert(varchar,ExpenseDate,6) as txtDate,
	 a.[Description] as Type,
	 Quantity, 
	 UnitCost as Rate,
	 (Quantity * UnitCost) as Cost,
	 Comment
From (
	Select 	a.ExpenseID, a.UserID, a.ProjectID, a.ExpenseTypeID, a.ExpenseDate, a.Quantity, a.UnitCost, a.Comment, a.Submitted, a.ApprovalStage, a.ExpenseMonth, a.ExpenseID as Expense, b.[Description]
	From 	TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) e
	inner join dbo.TT_Expenses a on a.ExpenseID = e.ExpenseID
	Join 	dbo.TT_ExpenseTypes b on a.ExpenseTypeID = b.ExpenseTypeID
	Join 	dbo.TT_Projects d on a.ProjectID = d.ProjectID
	Where 	((a.ProjectID = @ProjectID OR @ProjectID = 0) AND (d.ClientID = @ClientID OR @ClientID = 0))
	and 	((a.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
	--and 	a.ExpenseID in (select ExpenseID from dbo.ApprovedExpenses(@ProjectID))
	and 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
	and       (datediff(d,a.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null)
) a



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_Expenses_Proj]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/***********************************************************************************************************************
Created by:	VF
Created on:	??
Used in:		Timetrax.DAL.ReportExpenseReimbursements
Does:		Returns the Expense reimbursments for the given filters

Modified:

21/09/2005 by SD: Filter by Client ID and add returning client and user  information
05/10/2005 by SD: Correct User Filter and add capture type filter
28/02/2006 by SD: Cater for Expense Month
***********************************************************************************************************************/
CREATE procedure [dbo].[TT_Rep_Expenses_Proj]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime,
@Users varchar(5000),
@ClientID int,
@CaptureTypeID int,
@ExpenseMonth smalldatetime

As

--Get the Client Details
Select 		Distinct a.ClientID, ClientName
From 		dbo.TT_Clients a
Inner Join  	dbo.TT_Projects b on  a.ClientID = b.ClientID
Inner Join 	dbo.TT_Expenses c on b.ProjectID = c.ProjectID
Inner Join 	dbo.TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) e on c.ExpenseID = e.ExpenseID
Where 		Case When @ProjectID = 0 Then 0 Else b.ProjectID End = @ProjectID
and 		((c.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
and 		((PATINDEX('%,' + Cast(c.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
and 		(a.ClientID = @ClientID or @ClientID = 0)
and      		(datediff(d,c.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null)

-- Get the Project Details
Select Distinct ProjectID, ProjectName, ClientID
From (
	Select 	a.ProjectID, d.ProjectName, d.ClientID
	From 	dbo.TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) e
	Inner Join dbo.TT_Expenses a on a.ExpenseID = e.ExpenseID
	Join 	dbo.TT_Projects d on a.ProjectID = d.ProjectID
	Where 	Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
	and 	((a.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
	and 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
	and 	(d.ClientID = @ClientID or @ClientID = 0)
	and       (datediff(d,a.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null)
) a

-- Get the User Details
Select		Distinct convert(varchar,c.ProjectID) + '_' + convert(varchar,b.UserID) as KeyVal,
 		c.ProjectID, 
		b.UserID,
		b.LastName + ', ' + b.FirstName as UserName
From 		dbo.TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) e
Inner Join	dbo.TT_Expenses a on a.ExpenseID = e.ExpenseID
Join 		dbo.Usr_UserDetail b on a.UserID = b.UserID
Inner Join	dbo.TT_Projects c on a.ProjectID = c.ProjectID
Where	 	Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
and 		((a.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
and 		((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
and 		(c.ClientID = @ClientID or @ClientID = 0)
and      		(datediff(d,a.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null)
order by c.ProjectID, Username

-- Get the Expense Items Details
Select   Distinct convert(varchar,a.ProjectID) + '_' + convert(varchar,a.UserID) as KeyVal,
 	ProjectID, 
 	Expense, 
 	Convert(varchar,ExpenseDate,6) as txtDate,
 	a.[Description] as Type,
 	Quantity, 
 	UnitCost as Rate,
 	(Quantity * UnitCost) as Cost,
 	Comment
From (
	Select 		a.*, a.ExpenseID as Expense, b.[Description]
	From 		dbo.TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) e
	Inner Join	dbo.TT_Expenses a on a.ExpenseID = e.ExpenseID
	Join 		dbo.TT_ExpenseTypes b on a.ExpenseTypeID = b.ExpenseTypeID
	Inner Join	dbo.TT_Projects f on f.ProjectID = a.ProjectID
Where	 Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
and 	((a.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
and 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
and 	(f.ClientID = @ClientID or @ClientID = 0)
and       (datediff(d,a.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null)
) a
order by ProjectID, txtDate



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_Expenses_Usr]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




/***********************************************************************************************************************
Created by:	VF
Created on:	??
Used in:		Timetrax.DAL.ReportExpenseReimbursements
Does:		Returns the Expense reimbursments for the given filters

Modified:

21/09/2005 by SD: Filter by Client ID and add returning client and user  information
05/10/2005 by SD: Correct user filter and add capture type filter
30/11/2005 by SD: Remove client table - not needed for showing Expenses by User
28/02/2006 by SD: Cater for Expense Month
21/04/2006 by SD: Add comma so that Project Name is returned
***********************************************************************************************************************/
CREATE  Procedure [dbo].[TT_Rep_Expenses_Usr]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime,
@Users varchar(5000),
@ClientID int,
@CaptureTypeID int,
@ExpenseMonth smalldatetime

As

--Get the Client Details
/*
Select 		Distinct a.ClientID, ClientName
From 		dbo.TT_Clients a
Inner Join  	dbo.TT_Projects b on  a.ClientID = b.ClientID
Inner Join 	dbo.TT_Expenses c on b.ProjectID = c.ProjectID
Inner Join	dbo.TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) e on c.ExpenseID = e.ExpenseID
Where 		Case When @ProjectID = 0 Then 0 Else b.ProjectID End = @ProjectID
and 		(c.ExpenseDate Between @Start and @End)
and 		((PATINDEX('%,' + Cast(c.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
and 		(a.ClientID = @ClientID or @ClientID = 0)*/

-- Get the User Details
Select Distinct UserID, UserName
From (
	Select 	e.UserID, e.LastName + ', ' + e.FirstName as UserName
	From 	dbo.TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) ee 
	Inner Join dbo.TT_Expenses a on a.ExpenseID = ee.ExpenseID
	Join 	dbo.TT_Projects d on a.ProjectID = d.ProjectID
	Join	dbo.Usr_UserDetail e on a.UserID = e.UserID
	Where 	Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
	and 	((a.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
	and 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
	and 	(d.ClientID = @ClientID or @ClientID = 0)
	and      	(datediff(d,a.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null)
) a


-- Get the Expense Items Details
Select
	 UserID, 
	 ProjectName,
	 Expense, 
	 Convert(varchar,ExpenseDate,6) as txtDate,
	 a.[Description] as Type,
	 Quantity, 
	 UnitCost as Rate,
	 (Quantity * UnitCost) as Cost,
	 Comment
From (
	Select 	a.*, a.ExpenseID as Expense, b.[Description],d.ProjectName
	From 	dbo.TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) e
	Inner Join dbo.TT_Expenses a on a.ExpenseID = e.ExpenseID
	Join 	dbo.TT_ExpenseTypes b on a.ExpenseTypeID = b.ExpenseTypeID
	Join 	dbo.TT_Projects d on a.ProjectID = d.ProjectID
	Where 	Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
	and 	((a.ExpenseDate Between @Start and @End) OR (@Start is null and @End is null))
	and 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
	and 	(d.ClientID = @ClientID or @ClientID = 0)
	and      	(datediff(d, a.ExpenseMonth, @ExpenseMonth) = 0 OR @ExpenseMonth is null)
) a
Order By UserID,ProjectName,ExpenseDate




GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_ExpensesSummarisedUsr]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/***********************************************************************************************************************
Created by:	SD
Created on:	24/02/2006
Used in:		Timetrax.DAL.ReportExpenses
Does:		Returns the Expenses summarised for the user

Modified:

***********************************************************************************************************************/
CREATE Procedure [dbo].[TT_Rep_ExpensesSummarisedUsr]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime,
@Users varchar(5000),
@ClientID int,
@CaptureTypeID int

As

Select  a.UserID, c.Fullname, b.Description as ExpenseType, Sum(Quantity * UnitCost) as Amount
From 
	dbo.TT_FXN_ExpensesByCaptureType(@CaptureTypeID, @ProjectID) ee Inner Join
	TT_Expenses a on a.ExpenseID = ee.ExpenseID Inner Join
	TT_ExpenseTypes b on a.ExpenseTypeID = b.ExpenseTypeID Inner Join
	TT_View_UserDetails c on a.UserID = c.UserID Inner Join
	TT_Projects d on a.ProjectID = d.ProjectID
Where
 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = '')) And
	(Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID) And
	(d.ClientID = @ClientID or @ClientID = 0) And
	(a.ExpenseDate Between @Start and @End)
Group By
	a.UserId, c.FullName, a.ExpenseTypeID, b.Description
Order By 
	c.FullName, b.Description



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_Profitability_Financial]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_Rep_Profitability_Financial]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime
As


-- For Each Week in the Time Range return
-- Billable, NonBillable
Set dateformat dmy
select * from dbo.TT_FXN_ProfitTable_Fin(@ProjectID, @Start, @End)
Order by Yr, [Week]









GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_Profitability_Time]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_Rep_Profitability_Time]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime
As


-- For Each Week in the Time Range return
-- Billable, NonBillable
-- as Hours
--Set dateformat dmy
select * from dbo.TT_FXN_ProfitTable_Time(@ProjectID, @Start, @End)
Order by Yr, [Week]









GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_ProjectHeader]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   Procedure [dbo].[TT_Rep_ProjectHeader]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime
As

Set dateformat dmy

-- Get the Project Details
Select *,
	Convert(varchar,StartDate,103) as txtProjStart,Convert(varchar,EndDate,103) as txtProjEnd, 
	dbo.CalcProjectBudgetCost(@ProjectID) as Budget, 
	dbo.CalcProjectBudgetHours(@ProjectID) as BudgetHours,
	dbo.CalcProjectCurrentCost(@ProjectID,GetDate()) as CostToDate, 
	dbo.CalcProjectCurrentHours(@ProjectID,GetDate()) as HoursToDate, 
	dbo.CalcProjectPeriodCost(@ProjectID,@Start,@End) as PeriodCost, 
	dbo.CalcProjectPeriodHours(@ProjectID,@Start,@End) as PeriodHours 
From dbo.TT_Projects Proj
Where Proj.ProjectID = @ProjectID



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_ProjStatus_Financial]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the project status
Used in:		Timetrax.DAL.ReportProjStatus

Modified:

21/10/2005 by SD: Had to rewrite to return correct data as can't just do a join.
***************************************************************************************/
CREATE   Procedure [dbo].[TT_Rep_ProjStatus_Financial]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime
As


-- For Each Month in the Time Range return
-- Budget, TimeCost, ExpCost,TotalCost
--Set dateformat dmy
/*select * from dbo.TT_FXN_ProjStatusTable_Fin(@ProjectID, @Start, @End)
Order by Yr, Mnth*/

Create Table #TempValues
(
	Mnth int,
	Yr   int,
	Budget float DEFAULT (0),
	TimeCost float DEFAULT (0),
	ExpCost float DEFAULT (0)
)

Insert Into #TempValues (Mnth, Yr, Budget)
Select 	Month(a.dd) as Mnth,
  	Year(a.dd) as Yr, 
	Sum(isNull(DayBud, 0)) as Budget--,
	--Sum(isNull(Hours, 0) * isNull(dbo.GetProjectUserRate(UserID,@ProjectID), 0)) as TimeCost --, 
From 	dbo.TT_FXN_MonthBudgetTable(@ProjectID, @Start, @End) a 
--left join dbo.ApprovedUserHours(0,@ProjectID) b on Convert(varchar, a.dd, 103) = Convert(varchar, b.TimeSheetDate, 103) 
Where 	a.dd Between @Start and @End
Group By Year(a.dd), Month(a.dd)

Update 	#TempValues 
Set 	TimeCost = (Select 	Sum(isNull(Hours, 0) * isNull(dbo.GetProjectUserRate(UserID,@ProjectID), 0)) as TimeCost
		      From 	dbo.ApprovedUserHours(0,@ProjectID) b
		      Where	Month(b.TimesheetDate) = Mnth
		      And		Year(b.TimesheetDate) = Yr)

Update 	#TempValues 
Set	ExpCost = (Select 	Sum(isNull(Quantity, 0) * isNull(UnitCost, 0))
		   From		dbo.ApprovedUserExpenses(0,@ProjectID) b
		   Where	Month(b.ExpenseDate) = Mnth
		   And		Year(b.ExpenseDate) = Yr)

Select 	Mnth, 
	Yr,
	Budget,
	TimeCost,
	Isnull(ExpCost, 0) as ExpCost
From #TempValues
Order By Yr, Mnth


Drop Table #TempValues



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_ProjStatus_Time]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_Rep_ProjStatus_Time]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime
As


-- For Each Month in the Time Range return
-- Budget, TimeCost, ExpCost,TotalCost
-- as Hours
--Set dateformat dmy
select * from dbo.TT_FXN_ProjStatusTable_Time(@ProjectID, @Start, @End)
Order by Yr, Mnth







GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_ProjSummary]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the project Cost Summary for the given filters
Used in:		Timetrax.DAL.ReportProjectSummary

Modified:

21/10/2005 by SD: Set dateformat
****************************************************************************************************************/
CREATE        procedure [dbo].[TT_Rep_ProjSummary]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime
As

Set Dateformat dmy

-- Get the Project Details
Select *,
	Convert(varchar,StartDate,103) as txtProjStart,Convert(varchar,EndDate,103) as txtProjEnd, 
	dbo.CalcProjectBudgetCost(@ProjectID) as Budget, dbo.CalcProjectBudgetHours(@ProjectID) as BudgetHours,
	dbo.CalcProjectCurrentCost(@ProjectID,GetDate()) as CostToDate, dbo.CalcProjectCurrentHours(@ProjectID,GetDate()) as HoursToDate, 
	dbo.CalcProjectPeriodCost(@ProjectID,@Start,@End) as PeriodCost, dbo.CalcProjectPeriodHours(@ProjectID,@Start,@End) as PeriodHours 
From dbo.TT_Projects Proj
Where Proj.ProjectID = @ProjectID

-- Get The Project Costs
Select
	ProjectID,
	UserID,
	UserName,
	Rate,
	TimeCost,
	ExpCost
Into #RetTemp
From
(	Select 	a.ProjectID,a.UserID,b.LastName +', '+b.FirstName as UserName,
		a.Rate,dbo.FXN_CalcUserCost(a.ProjectID,a.UserID,@Start,@End,1) as TimeCost,
		dbo.FXN_CalcUserCost(a.ProjectID,a.UserID,@Start,@End,2) as ExpCost
	From 	dbo.TT_ProjectResources a
	Join 	dbo.Usr_UserDetail b on a.UserID = b.UserID
	Where 	a.ProjectID = @ProjectID) a

Select * from #RetTemp
Order By ProjectID, UserName



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_SelectClientProjects]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_Rep_SelectClientProjects]
@ClientID Int,
@Start SmallDateTime,
@End SmallDateTime
As

Declare @strClient as varchar

If @ClientID = 0
	Begin
		Set @strClient = '%'
	End
Else
	Begin
		Set @strClient = @ClientID
	End

Select a.ProjectID, b.ClientCode + ' - ' + a.ProjectName + ' (' + a.ProjectCode + ')' as ProjectName
From dbo.TT_Projects a
Join dbo.TT_Clients b on a.ClientID = b.ClientID 
Where a.ClientID like @strClient
and (a.StartDate <= @End
and a.EndDate >= @Start)





GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_Selections]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the Client, Project and Task list for the reports filter
Used in:		Timetrax.DAL.LoadReportSelections

Modifications:  

14/09/2005 by SD: Added order by to clients and changed order by for Tasks
22/09/2005 by SD: Changed order for projects to ProjectName and not ClientID
************************************************************************************************************************/
CREATE procedure [dbo].[TT_Rep_Selections]
As

Select ClientID, ClientCode + ' - ' + ClientName as ClientName, ClientName as SortBy
From dbo.TT_Clients
Where Enabled = 1
Order by SortBy

Select Cast(ClientID as varchar) + '#' + Cast(ProjectID as varchar) as ProjectID, ProjectCode + ' - ' + ProjectName as ProjectName, ProjectName as SortBy
From dbo.TT_Projects
Order By SortBy

Select Cast(b.ProjectID as varchar) + '#' + Cast(a.TaskID as varchar) as TaskID, a.TaskName
From dbo.TT_ProjectTasks a left join
		 dbo.TT_Orders b on a.OrderID = b.OrderID
Order By TaskName --ProjectID, TaskID



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_SelectProjects]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************************************************************
Created by:	VF
Created on:	???
Does:
	-- This function returns all projects that satisfy
	-- the filter criteria
	-- 0 Values for ClientID and TaskID return all,
	-- "" value for Users returns all

Used in:		Timetrax.DAL.ReportSelectProjects

Modified:

01/09/2005 by SB: Added Order By Clause

************************************************************************************************************************************/

CREATE procedure [dbo].[TT_Rep_SelectProjects]
@ClientID Int,
@Start SmallDateTime,
@End SmallDateTime,
@Task Int,
@Users varchar
As

Select *
From dbo.FXN_Rep_SelectedProjects(@ClientID,@Start,@End,@Task,@Users) 
Order by ProjectName



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_TaskRegister_Task_Usr]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the data for the Project Detail Report filtered by the relevant filters
Used in:		Timetrax.DAL.ReportActivityRegister

Modified

SD on 23/09/2005 - Return the rate as part of the timesheet data and not the user data
SD on 30/09/2005 - Return the daily total cost
SD on 04/10/2005 - Pass through Capture type and limit tasks accordingly
SD on 05/10/2005 - Correct User Filter
********************************************************************************************************************************/
CREATE procedure [dbo].[TT_Rep_TaskRegister_Task_Usr]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime,
@Task Int,
@Users varchar(5000),
@CaptureTypeID int

As

-- Get the Project Details
Select *,
	Convert(varchar,StartDate,103) as txtProjStart,Convert(varchar,EndDate,103) as txtProjEnd, 
	dbo.CalcProjectBudgetCost(@ProjectID) as Budget, dbo.CalcProjectBudgetHours(@ProjectID) as BudgetHours,
	dbo.CalcProjectCurrentCost(@ProjectID,GetDate()) as CostToDate, dbo.CalcProjectCurrentHours(@ProjectID,GetDate()) as HoursToDate, 
	dbo.CalcProjectPeriodCost(@ProjectID,@Start,@End) as PeriodCost, dbo.CalcProjectPeriodHours(@ProjectID,@Start,@End) as PeriodHours 
From dbo.TT_Projects Proj
Where Proj.ProjectID = @ProjectID
-- Getting data for a specific project, Dates are irrelevant here
--and (Proj.StartDate <= @End
--and Proj.EndDate >= @Start)

-- Get the Task Details
Select 		Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal, 
		c.ProjectID, a.TaskID, TaskName, Sum(isnull(Amount,0)) as Amount, Sum(isnull(Hours,0)) as Hours
From 		dbo.TT_FXN_TimesheetsByCaptureType(@CaptureTypeID, @ProjectID) t
Inner Join 	dbo.TT_Timesheets b on b.TimesheetID = t.TimesheetID
Inner Join 	dbo.TT_ProjectTasks a  on a.TaskID = b.TaskID
Join 		dbo.TT_Orders c on a.OrderID = c.OrderID
Where 		c.ProjectID = @ProjectID
and 		(b.TimesheetDate Between @Start and @End)
--and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
and 		Case When @Task = 0 Then 0 Else a.TaskID End = @Task 
and 		((PATINDEX('%,' + Cast(b.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
Group by Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar),c.ProjectID, a.TaskID, TaskName

-- Get the User Details
Select Distinct Cast(ProjectID as varchar) + '_' + Cast(Task as varchar) as KeyVal, Cast(ProjectID as varchar) + '_' + Cast(Task as varchar) + '_' + Cast(UserID as varchar) as KeyVal2, Task, UserName
From (
	Select 		c.ProjectID, a.TaskID as Task, e.UserID, e.LastName + ', ' + e.FirstName as UserName
	From  		dbo.TT_FXN_TimesheetsByCaptureType(@CaptureTypeID, @ProjectID) t
	Inner Join 	dbo.TT_Timesheets b on b.TimesheetID = t.TimesheetID
	Inner Join 	dbo.TT_ProjectTasks a on a.TaskID = b.TaskID
	Join 		dbo.TT_Orders c on a.OrderID = c.OrderID
	Join 		dbo.TT_Projects d on c.ProjectID = d.ProjectID
	Join 		dbo.Usr_UserDetail e on b.UserID = e.UserID
	--Join dbo.TT_Rates f on e.UserID = f.UserID and f.CostCentreID = d.CostCentreID
	Where 		c.ProjectID = @ProjectID
	and 		(b.TimesheetDate Between @Start and @End)
	--and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
	and 		Case When @Task = 0 Then 0 Else a.TaskID End = @Task 
	and 		((PATINDEX('%,' + Cast(b.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
) a


-- Get the Timesheet Items Details
Select	 Cast(ProjectID as varchar) + '_' + Cast(Task as varchar) as KeyVal,
	 Cast(ProjectID as varchar) + '_' + Cast(Task as varchar) + '_' + Cast(UserID as varchar) as KeyVal2,
	 ProjectID, Task, UserID, 
	 Convert(varchar,TimesheetDate,6) as txtDate,
	 dbo.ConvertToHours(Duration,100) as Hours,
	 Comment,
	 Rate
From (
	Select 	c.ProjectID, a.TaskID as Task,   Cast(e.Rate as Decimal(5,2)) as Rate, b.*
	From 	dbo.TT_FXN_TimesheetsByCaptureType(@CaptureTypeID, @ProjectID) t 
	Inner Join dbo.TT_Timesheets b on b.TimesheetID = t.TimesheetID
	Inner Join dbo.TT_ProjectTasks a on a.TaskID = b.TaskID
	Join 	dbo.TT_Orders c on a.OrderID = c.OrderID
	Join 	dbo.TT_Projects d on c.ProjectID = d.ProjectID
	Join 	dbo.TT_ProjectResources e on (c.ProjectID = e.ProjectID and b.UserID = e.UserID)
	Where   c.ProjectID = @ProjectID
	and	 (b.TimesheetDate Between @Start and @End)
	--and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
	and 	Case When @Task = 0 Then 0 Else a.TaskID End = @Task 
	and 	((PATINDEX('%,' + Cast(b.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
) a
Order by TimesheetDate

--Get the daily totals
Select TimesheetDate, Cost 
From   TT_FXN_GetDailyCostForProject (@Start, @End, @ProjectID, @Task, @Users, @CaptureTypeID)



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_TaskRegister_Usr_Task]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the data for the Project Detail Report filtered by the relevant filters
Used in:		Timetrax.DAL.ReportActivityRegister

Modified

SD on 25/09/2005 - Return the rate as part of the timesheet data and not the user data
SD on 30/09/2005 - Return the daily total cost
SD on 05/10/2005 - Pass through Capture type and limit tasks accordingly
SD on 05/10/2005 - Correct User Filter
********************************************************************************************************************************/
CREATE procedure [dbo].[TT_Rep_TaskRegister_Usr_Task]
@ProjectID Int,
@Start SmallDateTime,
@End SmallDateTime,
@Task Int,
@Users varchar(5000),
@CaptureTypeID int
As

-- Get the Project Details
Select *,
	Convert(varchar,StartDate,103) as txtProjStart,Convert(varchar,EndDate,103) as txtProjEnd, 
	dbo.CalcProjectBudgetCost(@ProjectID) as Budget, dbo.CalcProjectBudgetHours(@ProjectID) as BudgetHours,
	dbo.CalcProjectCurrentCost(@ProjectID,GetDate()) as CostToDate, dbo.CalcProjectCurrentHours(@ProjectID,GetDate()) as HoursToDate, 
	dbo.CalcProjectPeriodCost(@ProjectID,@Start,@End) as PeriodCost, dbo.CalcProjectPeriodHours(@ProjectID,@Start,@End) as PeriodHours 
From dbo.TT_Projects Proj
Where Proj.ProjectID = @ProjectID

-- Get the User Details
Select Distinct Cast(ProjectID as varchar) + '_' + Cast(UserID as varchar) as KeyVal, ProjectID, UserID, UserName, Rate
From (
	Select 		c.ProjectID, a.TaskID as Task, e.UserID, e.LastName + ', ' + e.FirstName as UserName, Cast(f.Rate as Decimal(5,2)) as Rate
	From 		dbo.TT_FXN_TimesheetsByCaptureType(@CaptureTypeID, @ProjectID) t 
	Inner Join 	 dbo.TT_Timesheets b on b.TimesheetID = t.TimesheetID
	Inner Join	dbo.TT_ProjectTasks a on  a.TaskID = b.TaskID
	Join 		dbo.TT_Orders c on a.OrderID = c.OrderID
	Join 		dbo.TT_Projects d on c.ProjectID = d.ProjectID
	Join 		dbo.Usr_UserDetail e on b.UserID = e.UserID
	Join 		dbo.TT_Rates f on e.UserID = f.UserID and f.CostCentreID = d.CostCentreID
	Where 		c.ProjectID = @ProjectID
	and 		(b.TimesheetDate Between @Start and @End)
	--and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
	and Case When @Task = 0 Then 0 Else a.TaskID End = @Task 
	and ((PATINDEX('%,' + Cast(b.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
) a

-- Get the Task Details
Select Cast(c.ProjectID as varchar) + '_' + Cast(b.UserID as varchar) as KeyVal, 
			 Cast(c.ProjectID as varchar) + '_' + Cast(b.UserID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal2,
			 a.TaskID, TaskName, Sum(isnull(Amount,0)) as Amount, Sum(isnull(Hours,0)) as Hours
--			 b.UserID, a.TaskID, TaskName, Sum(isnull(Amount,0)) as Amount, Sum(isnull(Hours,0)) as Hours
From 		dbo.TT_FXN_TimesheetsByCaptureType(@CaptureTypeID, @ProjectID) t
Inner Join 	dbo.TT_Timesheets b on b.TimesheetID = t.TimesheetID
Inner Join 	dbo.TT_ProjectTasks a on a.TaskID = b.TaskID
Join 		dbo.TT_Orders c on a.OrderID = c.OrderID
Where 		c.ProjectID = @ProjectID
and 		(b.TimesheetDate Between @Start and @End)
and		((PATINDEX('%,' + Cast(b.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
--and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
and Case When @Task = 0 Then 0 Else a.TaskID End = @Task
Group by Cast(c.ProjectID as varchar) + '_' + Cast(b.UserID as varchar),Cast(c.ProjectID as varchar) + '_' + Cast(b.UserID as varchar) + '_' + Cast(a.TaskID as varchar),b.UserID, a.TaskID, TaskName

-- Get the Timesheet Items Details
Select
	 Cast(ProjectID as varchar) + '_' + Cast(Task as varchar) as KeyVal,
	 Cast(ProjectID as varchar) + '_' + Cast(UserID as varchar) + '_' + Cast(Task as varchar) as KeyVal2,
	 ProjectID, UserID, Task, 
	 Convert(varchar,TimesheetDate,6) as txtDate,
	 dbo.ConvertToHours(Duration,100) as Hours,
	 Comment,
	 Rate
From (
	Select 	c.ProjectID, a.TaskID as Task, b.*, e.Rate
	From 	dbo.TT_FXN_TimesheetsByCaptureType(@CaptureTypeID, @ProjectID) t
	Inner Join dbo.TT_Timesheets b on b.TimesheetID = t.TimesheetID
	Inner Join dbo.TT_ProjectTasks a  on a.TaskID = b.TaskID
	Join 	dbo.TT_Orders c on a.OrderID = c.OrderID
	Join 	dbo.TT_Projects d on c.ProjectID = d.ProjectID
	Join 	dbo.TT_ProjectResources e on (c.ProjectID = e.ProjectID and b.UserID = e.UserID)
	Where 	c.ProjectID = @ProjectID
	and 	(b.TimesheetDate Between @Start and @End)
	--and	 b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
	and 	Case When @Task = 0 Then 0 Else a.TaskID End = @Task 
	and 	((PATINDEX('%,' + Cast(b.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
) a
Order by TimesheetDate

--Get the daily totals
Select TimesheetDate, Cost 
From   TT_FXN_GetDailyCostForProject (@Start, @End, @ProjectID, @Task, @Users, @CaptureTypeID)



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_TimeAnalysis_Day]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the timesheet entries that match the given filters for the Time Analysis Report
Used in:		Timetrax.DAL.ReportTimeAnalysis

Modified:

SD on 26/09/2005:	Add Approved Filter 
			- '' Returns Approved and non-Approved
			- 1 Returns Approved
			- 0 Returns Not Approved
*****************************************************************************************************************/
CREATE procedure [dbo].[TT_Rep_TimeAnalysis_Day]
@Start SmallDateTime,
@End SmallDateTime,
@Users varchar(5000),
@TOTypes varchar(500),
@TaskTypes varchar(10),
@Approved varchar(10)

As

-- This Procedure Calculates Hours booked per day per user 
-- Filters are (DateRange, Users, TimeOffTypes(User Defined), TaskTypes(Billable,NonoBillable)
-- If Users is empty then return all users,

Set dateformat dmy

-- Get the Week Start Day (1:Monday,7:Sunday) from the DB
	Declare @WeekStartDay as Int
	Select @WeekStartDay = WeekStartDay from dbo.TT_System
	Set DateFirst @WeekStartDay

-- Get the First and last day of week based on input date and startday
Declare @StartDate as smalldatetime
Declare @EndDate as smalldatetime
Set @StartDate = dbo.WeekStartDate(@Start)
Set @EndDate = DateAdd(dd,6,dbo.WeekStartDate(@End))
-- prepare Vars for PATINDEX use
If @Users != ''
Begin
	Set @Users = ',' + @Users + ','
End
If @TOTypes != ''
Begin
	Set @TOTypes = ',' + @TOTypes + ','
End
If @TaskTypes != ''
Begin
	Set @TaskTypes = ',' + @TaskTypes + ','
End

Select	LastName + ', ' + FirstName as UserName
From dbo.Usr_UserDetail
Where	((PATINDEX('%,' + Cast(UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
Order By UserName

-- For Each Day in the Time Range return
-- DateLabel, UserName, Hours
select Convert(varchar,a.dd,103) as dd, isNull(b.UserName, '') as UserName, dbo.ConvertToHours(isNull(b.Duration, 0),100) as Duration
From dbo.TT_FXN_DatesTable(@StartDate, @EndDate) a
left join
(
	Select LastName + ', ' + FirstName as UserName, dd, Duration From
	(
		Select UserID,dd, Sum(Duration) as Duration
		From
		(
				select UserID, TimeOffDate as dd, Duration
				From dbo.TT_TimeOff
				Where (PATINDEX('%,' + Cast(TypeID as varchar) + ',%', @TOTypes) > 0)
				And ((PATINDEX('%,' + Cast(UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
				And ( ((@Approved = 1 OR @Approved = '') AND (dbo.TT_FXN_TimeOffApproved(TimeOffID) = 1))   --Return Approved time off if filter is approved 1 or ''
		                                    OR ((@Approved = 0 OR @Approved = '') AND (dbo.TT_FXN_TimeOffApproved(TimeOffID) = 0)))  --Return Not Approved time off if filter is approved 0 or ''
		
			union all
		 
				select UserID, TimesheetDate, Duration
				From dbo.TT_Timesheets a
				Left Join dbo.TT_ProjectTasks b on a.TaskID = b.TaskID
				Where (PATINDEX('%,' + Cast(Billable as varchar) + ',%', @TaskTypes) > 0) 
				And ((PATINDEX('%,' + Cast(UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
				And ( ((@Approved = 1 OR @Approved = '') AND (dbo.TT_FXN_TimesheetApproved(a.TimesheetID) = 1))   --Return Approved timesheets if filter is approved 1 or ''
		                                    OR ((@Approved = 0 OR @Approved = '') AND (dbo.TT_FXN_TimesheetApproved(a.TimesheetID) = 0)))  --Return Not Approved timesheets if filter is approved 0 or ''
		) a
		Group by UserID, dd
	) a
	Left Join
	dbo.Usr_UserDetail b on a.UserID = b.UserID
) b on a.dd = b.dd

Order by Cast(a.dd as smalldatetime),UserName



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_TimeAnalysis_Week]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the timesheet entries that match the given filters for the Time Analysis Report
Used in:		Timetrax.DAL.ReportTimeAnalysis

Modified:

SD on 26/09/2005:	Add Approved Filter 
			- '' Returns Approved and non-Approved
			- 1 Returns Approved
			- 0 Returns Not Approved
*****************************************************************************************************************/
CREATE procedure [dbo].[TT_Rep_TimeAnalysis_Week]
@Start SmallDateTime,
@End SmallDateTime,
@Users varchar(5000),
@TOTypes varchar(500),
@TaskTypes varchar(10),
@Approved varchar(10)

As

-- This Procedure Calculates Hours booked per week per user 
-- Filters are (DateRange, Users, TimeOffTypes(User Defined), TaskTypes(Billable,NonoBillable)
-- If Users is empty then return all users,

Set dateformat dmy

-- Get the Week Start Day (1:Monday,7:Sunday) from the DB
	Declare @WeekStartDay as Int
	Select @WeekStartDay = WeekStartDay from dbo.TT_System
	Set DateFirst @WeekStartDay

-- Get the First and last day of week based on input date and startday
Declare @StartDate as smalldatetime
Declare @EndDate as smalldatetime
Set @StartDate = dbo.WeekStartDate(@Start)
Set @EndDate = DateAdd(dd,6,dbo.WeekStartDate(@End))
-- prepare Vars for PATINDEX use
If @Users != ''
Begin
	Set @Users = ',' + @Users + ','
End
If @TOTypes != ''
Begin
	Set @TOTypes = ',' + @TOTypes + ','
End
If @TaskTypes != ''
Begin
	Set @TaskTypes = ',' + @TaskTypes + ','
End

Select	LastName + ', ' + FirstName as UserName
From dbo.Usr_UserDetail
Where	((PATINDEX('%,' + Cast(UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
Order by UserName

-- For Each Day in the Time Range return
-- DateLabel, UserName, Hours
select Cast(a.ww as varchar) + ' (' + Cast(a.yr as varchar) + ')' as dd, isNull(b.UserName, '') as UserName, dbo.ConvertToHours(isNull(b.Duration, 0),100) as Duration
From 
(
	Select Distinct(DatePart(wk,dd)) as ww, Year(dd) as yr 
	From dbo.TT_FXN_DatesTable(@StartDate, @EndDate)
) a
left join
(
	Select LastName + ', ' + FirstName as UserName, ww, yr, Duration From
	(
		Select UserID, ww, yr, Sum(isNull(Duration, 0)) as Duration
		From
		(
				select UserID, DatePart(wk,TimeOffDate) as ww, Year(TimeOffDate) as yr, Duration
				From dbo.TT_TimeOff
				Where (PATINDEX('%,' + Cast(TypeID as varchar) + ',%', @TOTypes) > 0)
				And ((PATINDEX('%,' + Cast(UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
				--And dbo.TT_FXN_TimeOffApproved(TimeOffID) = 1
				And ( ((@Approved = 1 OR @Approved = '') AND (dbo.TT_FXN_TimeOffApproved(TimeOffID) = 1))   --Return Approved time off if filter is approved 1 or ''
		                                    OR ((@Approved = 0 OR @Approved = '') AND (dbo.TT_FXN_TimeOffApproved(TimeOffID) = 0)))  --Return Not Approved time off if filter is approved 0 or ''
		
			union all
		 
				select UserID, DatePart(wk,TimesheetDate) as ww, Year(TimesheetDate) as yr, Duration
				From dbo.TT_Timesheets a
				Left Join dbo.TT_ProjectTasks b on a.TaskID = b.TaskID
				Where (PATINDEX('%,' + Cast(Billable as varchar) + ',%', @TaskTypes) > 0) 
				And ((PATINDEX('%,' + Cast(UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
				--And dbo.TT_FXN_TimesheetApproved(a.TimesheetID) = 1 
				And ( ((@Approved = 1 OR @Approved = '') AND (dbo.TT_FXN_TimesheetApproved(a.TimesheetID) = 1))   --Return Approved timesheets if filter is approved 1 or ''
		                                    OR ((@Approved = 0 OR @Approved = '') AND (dbo.TT_FXN_TimesheetApproved(a.TimesheetID) = 0)))  --Return Not Approved timesheets if filter is approved 0 or ''
		) a
		Group by UserID, yr, ww 
	) a
	Left Join
	dbo.Usr_UserDetail b on a.UserID = b.UserID
) b on a.ww = b.ww and a.yr = b.yr

Order by a.yr, a.ww, UserName



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_TimeOff]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************
Created by:	VF
Created on:	???
Does:		Returns the time off times for the specified filters
Used in:		Timetrax.DAL.ReportTimeOff

Modified:

15/10/2005 by SD: Return extra grouping for User  and add filtering by user
******************************************************************************************/
CREATE procedure [dbo].[TT_Rep_TimeOff]
@Start SmallDateTime,
@End SmallDateTime,
@Users varchar(5000)
As


-- Get the TimeOff Types
Select TypeID, [Description] as TypeName
From    dbo.TT_TimeOffTypes
Where Enabled = 1
and      TypeID in (Select Distinct TypeID From TT_TimeOff 
		   where TimeOffDate Between @Start and @End
		   and TimeOffID in (select TimeOffID from dbo.TT_FXN_ApprovedTimeOff())
		   and ((PATINDEX('%,' + Cast(UserID as varchar) + ',%', @Users) > 0) OR (@Users = '')))
Order By TypeName

--Select User Details
Select	Distinct UserID, UserName, TypeID,
	convert(varchar(10), UserID) + '_' + convert(varchar(10), TypeID) as KeyVal
From 	(Select b.UserID,  b.FirstName + ' ' + b.LastName as UserName, TypeID
	 From dbo.TT_TimeOff a
	Join dbo.Usr_UserDetail b on a.UserID = b.UserID
	Where (a.TimeOffDate Between @Start and @End)
	and a.TimeOffID in (select TimeOffID from dbo.TT_FXN_ApprovedTimeOff())
	and 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
) a
Order By UserName

-- Get the TimeOff Item Details
Select	 UserID,
	 TypeID,
	 Convert(varchar,TimeOffDate,6) as txtDate,
	 dbo.ConvertToHours(Duration,100) as Hours,
	 Comment,
	convert(varchar(10), UserID) + '_' + convert(varchar(10), TypeID) as KeyVal
From 	(Select a.TypeID, a.TimeOffDate, a.Duration, a.Comment, UserID
	 From dbo.TT_TimeOff a
	 Where (a.TimeOffDate Between @Start and @End)
	and a.TimeOffID in (select TimeOffID from dbo.TT_FXN_ApprovedTimeOff())
	and 	((PATINDEX('%,' + Cast(a.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
) a
Order By TimeOffDate



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_TimesheetStatus]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  /*****************************************************************************************************************************    
Created by: VF    
Created on: ??    
Does:  Returns a list of the user timesheet statuses for each week between the start and end dates    
    
Modified:    
    
21/04/2006 by SD: Optimize query    
24/04/2006 by SD: Don't show users don't capture time    
18/02/2010 by SD: Added the section for waiting approval by Manager  
20/02/2012 by SD: Added the section for waiting approval by MD  
*****************************************************************************************************************************/    
CREATE procedure [dbo].[TT_Rep_TimesheetStatus]    
@Start SmallDateTime,    
@End SmallDateTime    
    
As    
    
-- This Procedure returns each users timesheet status for the requested period    
-- grouped by Week    
-- Filters are (DateRange, StatusTypes(Not Submitted, Waiting Approval, Approved or Rejected)    
-- If @Status is empty then return all Statuses,    
    
Set dateformat dmy    
    
-- Get the Week Start Day (1:Monday,7:Sunday) from the DB    
 Declare @WeekStartDay as Int    
 Select @WeekStartDay = WeekStartDay from dbo.TT_System    
 Set DateFirst @WeekStartDay    
    
-- Get the First and last day of week based on input date and startday    
Declare @StartDate as smalldatetime    
Declare @EndDate as smalldatetime    
Set @StartDate = dbo.WeekStartDate(@Start)    
Set @EndDate = DateAdd(dd,6,dbo.WeekStartDate(@End))    
    
--Return all the weeks for the period    
Select Distinct(dbo.WeekStartDate(dd)) as wk, Convert(varchar, dbo.WeekStartDate(dd), 103) +' - '+ Convert(varchar, dbo.WeekStartDate(dd) + 6, 103) as Period    
From dbo.TT_FXN_DatesTable(@StartDate,@EndDate)     
Order by dbo.WeekStartDate(dd)    
    
-- Return all enabled Users    
Select Distinct UserID, LastName + ', ' + FirstName as UserName    
From dbo.Usr_UserDetail    
Where Enabled = 1    
And UserID in (  Select UserID     
  From  Usr_GroupPermission a Inner Join    
   Usr_UserGroup b on a.GroupID = b.GroupID     
  Where RoleID = 6)    
Order By UserName    
    
    
-- Return all User Timesheets Status for the period    
Select wk, UserID,StatusID,    
Case    
  When StatusID = 1 or StatusID is null Then 'Not Submitted'    
  When StatusID = 2 Then 'Approved'    
  When StatusID = 3 Then 'Waiting Approval Team Leader'    
  When StatusID = 4 Then 'Rejected'    
  When StatusID = 5 Then 'Waiting Approval Manager'  
  When StatusID = 6 Then 'Waiting Approval MD'  
End as Status    
From    
(    
 Select dbo.WeekStartDate(a.dd) as wk, UserID, Max(StatusID) as StatusID    
 From     
  (    
   (    
    Select  TimesheetDate as dd, UserID, 1 as StatusID    
    From dbo.TT_Timesheets    
    Where  Submitted is null    
    Union    
    Select  TimeOffDate, UserID, 1 as StatusID    
    From  dbo.TT_TimeOff    
    Where  Submitted is null    
   )    
   Union    
   (    
    Select  TimesheetDate as dd, UserID, 2 as StatusID    
    From  dbo.TT_Timesheets a Inner Join    
          dbo.TT_FXN_TimesheetApprovedTable() b on a.TimesheetID = b.TimesheetID    
    Union    
    Select  TimeOffDate, UserID, 2 as StatusID    
    From  dbo.TT_TimeOff a Inner Join    
      dbo.TT_FXN_TimeOffApprovedTable() b on a.TimeOffID = b.TimeOffID    
   )    
   Union    
   (    
    Select   TimesheetDate as dd, UserID, 3 as StatusID    
    From   dbo.TT_Timesheets a    
    Left Join  dbo.TT_FXN_TimesheetApprovedTable() b on a.TimesheetID = b.TimesheetID    
    Where   b.TimesheetID is Null    
    And   Submitted = 1    
    And ApprovalStage = 1  
    Union    
    Select   TimeOffDate, UserID, 3 as StatusID    
    From   dbo.TT_TimeOff    
    Where   dbo.TT_FXN_TimeOffApproved(TimeOffID) = 0    
    And   Submitted = 1    
   )    
   Union    
   (    
    Select  TimesheetDate as dd, UserID, 4 as StatusID    
    From  dbo.TT_Timesheets a Inner Join    
      dbo.TT_FXN_TimesheetRejectedTable() b on a.TimesheetID = b.TimesheetID    
    Union    
    Select  TimeOffDate, UserID, 4 as StatusID    
    From  dbo.TT_TimeOff a Inner Join    
      dbo.TT_FXN_TimeOffRejectedTable() b on a.TimeOffId = b.TimeOffID    
   )    
   Union    
   (    
    Select   TimesheetDate as dd, UserID, 5 as StatusID    
    From   dbo.TT_Timesheets a    
    Left Join  dbo.TT_FXN_TimesheetApprovedTable() b on a.TimesheetID = b.TimesheetID    
    Where   b.TimesheetID is Null    
    And   Submitted = 1  
    And ApprovalStage = 2    
   )   
   Union    
   (    
    Select   TimesheetDate as dd, UserID, 6 as StatusID    
    From   dbo.TT_Timesheets a    
    Left Join  dbo.TT_FXN_TimesheetApprovedTable() b on a.TimesheetID = b.TimesheetID    
    Where   b.TimesheetID is Null    
    And   Submitted = 1  
    And ApprovalStage = 3    
   )     
  ) a    
    
 Where a.dd between @StartDate and @EndDate    
 And UserID in (  Select UserID     
   From  Usr_GroupPermission a Inner Join    
    Usr_UserGroup b on a.GroupID = b.GroupID     
   Where RoleID = 6)    
 Group By dbo.WeekStartDate(a.dd), UserID    
) a     
    
    
    
/*    
    
-- Return all User Timesheets Status for the period    
Select wk, UserID,StatusID,    
Case    
  When StatusID = 1 or StatusID is null Then 'Not Submitted'    
  When StatusID = 2 Then 'Approved'    
  When StatusID = 3 Then 'Waiting Approval'    
  When StatusID = 4 Then 'Rejected'    
End as Status    
From    
(    
 Select dbo.WeekStartDate(a.dd) as wk, UserID, Max(StatusID) as StatusID    
 From     
  (    
   (    
    Select  TimesheetDate as dd, UserID, 1 as StatusID    
    From dbo.TT_Timesheets    
    Where  Submitted is null    
    Union    
    Select  TimeOffDate, UserID, 1 as StatusID    
    From  dbo.TT_TimeOff    
    Where  Submitted is null    
   )    
   Union    
   (    
    Select  TimesheetDate as dd, UserID, 2 as StatusID    
    From  dbo.TT_Timesheets    
    Where  dbo.TT_FXN_TimesheetApproved(TimesheetID) = 1    
    Union    
    Select  TimeOffDate, UserID, 2 as StatusID    
    From  dbo.TT_TimeOff    
    Where  dbo.TT_FXN_TimeOffApproved(TimeOffID) = 1    
   )    
   Union    
   (    
    Select  TimesheetDate as dd, UserID, 3 as StatusID    
    From  dbo.TT_Timesheets    
    Where  dbo.TT_FXN_TimesheetApproved(TimesheetID) = 0    
    And  Submitted = 1    
    Union    
    Select  TimeOffDate, UserID, 3 as StatusID    
    From  dbo.TT_TimeOff    
    Where  dbo.TT_FXN_TimeOffApproved(TimeOffID) = 0    
    And  Submitted = 1    
   )    
   Union    
   (    
    Select  TimesheetDate as dd, UserID, 4 as StatusID    
    From  dbo.TT_Timesheets    
    Where  dbo.TT_FXN_TimesheetRejected(TimesheetID) = 1    
    Union    
    Select  TimeOffDate, UserID, 4 as StatusID    
    From  dbo.TT_TimeOff    
    Where  dbo.TT_FXN_TimeOffRejected(TimeOffID) = 1    
   )    
  ) a    
    
 Where a.dd between @StartDate and @EndDate    
 Group By dbo.WeekStartDate(a.dd), UserID    
) a     
    
*/    



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_UserActivity]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************************  
Created by: Vince Friday  
Created on: 17/01/2007  
Does:  Returns the data for the Project Detail Report filtered by the relevant filters  
Used in:  Timetrax.DAL.ReportActivityRegister  
Modifications:  
11/05/2009 CB Added a four selection of the user's name to be used by pop up report on user's activities for a particular day  
20/02/2012 SD: Added ordering
********************************************************************************************************************************/  
CREATE  procedure [dbo].[TT_Rep_UserActivity]   
@UserID Int,  
@StartDate SmallDateTime,  
@EndDate SmallDateTime  
  
As  
  
-- Select relevant userdata into temp table  
select * into #Temp  
from   
(  
Select  
 d.ProjectID,  
 e.ProjectCode,  
 e.ProjectName as ProjectName,  
 1 as TaskType,  
 b.TaskID,  
 b.TaskName as TaskName,  
 a.TimesheetID,  
 convert(varchar, a.TimesheetDate,103) 'Date',  
 a.duration 'Minutes',  
 dbo.converttohours(a.duration,100) as 'Hours',  
 a.Comment  
from TT_Timesheets a  
inner join TT_ProjectTasks b on a.TaskID = b.TaskID  
inner join Usr_UserDetail c on a.UserID = c.UserID  
inner join TT_Orders d on b.OrderID = d.OrderID  
inner join TT_Projects e on d.ProjectID = e.ProjectID  
where c.UserID = @UserID  
and (a.TimesheetDate between @StartDate and @EndDate)  
Union   
select  
 0 as ProjectID,  
 'None',  
 'TimeOff' as ProjectName,  
 0 as TaskType,  
 b.TypeID as TaskID,  
 b.Description as TaskName,  
 a.TimeOffID as TimesheetID,  
 convert(varchar, a.TimeOffDate,103) 'Date',  
 a.duration 'Minutes',  
 dbo.converttohours(a.duration,100) as 'Hours',  
 a.Comment  
from TT_TimeOff a  
inner join TT_TimeOffTypes b on a.TypeID = b.TypeID  
inner join Usr_UserDetail c on a.UserID = c.UserID  
where c.UserID = @UserID  
and a.TimeOffDate between @StartDate and @EndDate  
--order by ProjectName,TaskName,'Date'   
) a  
  
-- Return Projects  
Select Distinct ProjectID, ProjectCode, ProjectName from #Temp 
Order By ProjectName  
  
-- Return Tasks  
Select Distinct Cast(TaskType as varchar) + '_' + Cast(TaskID as varchar) as KeyVal, ProjectID, TaskType, TaskID, TaskName from #Temp   
Order By TaskName
  
-- Return Timesheets  
Select Distinct Cast(TaskType as varchar) + '_' + Cast(TaskID as varchar) as KeyVal, TimesheetID, [Date], Hours, Comment from #Temp   
Order By Date 
  
-- Return UserName  
Select (FirstName + ' ' + LastName) as UserName From Usr_UserDetail where Userid = @UserID  
Order By FirstName, LastName
  



GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_XML_Select]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_Rep_XML_Select]
As
	SELECT 1          as Tag, 
	       NULL       as Parent,
	       ClientID 	as [Client!1!ClientID],
	       ClientName as [Client!1!ClientName],
	       NULL			 	as [Project!2!ClientID],
	       NULL       as [Project!2!ProjectID],
	       NULL       as [Project!2!ProjectName],
	       NULL			 	as [Task!3!ClientID],
	       NULL       as [Task!3!ProjectID],
	       NULL       as [Task!3!TaskID],
	       NULL       as [Task!3!TaskName],
	       NULL       as [User!4!UserID],
	       NULL       as [User!4!UserName]
	From dbo.TT_Clients
Union
	SELECT 
				 2, 
	       1,
	       a.ClientID,
				 NUll,
	       a.ClientID,
				 ProjectID,
				 ProjectName,
	       NULL,
	       NULL,
	       NULL,
	       NULL,
				 NULL,
				 NULL
	FROM dbo.TT_Clients a, dbo.TT_Projects b
	WHERE a.ClientID = b.ClientID
Union
	SELECT 3, 
	       2,
	       a.ClientID,
				 NULL,
	       NULL,
				 a.ProjectID,
				 NULL, 
	       a.ClientID,
				 a.ProjectID,
				 b.TaskID,
				 b.TaskName,
				 NULL,
				 NULL

From 
(Select Client.ClientID, Project.ProjectID, Ord.OrderID From dbo.TT_Clients Client
Left Join dbo.TT_Projects Project on Client.ClientID = Project.ClientID
Left Join dbo.TT_Orders Ord on Project.ProjectID = Ord.ProjectID) a, dbo.TT_ProjectTasks b
Where a.OrderID = b.OrderID
Union
	SELECT 4,
	       NULL,
	       NULL,
				 NULL,
	       NULL,
				 NULL,
				 NULL, 
				 NULL,
				 NULL, 
				 NULL,
				 NULL,
	       UserID,
				 LastName + ', ' + FirstName as UserName

From dbo.Usr_UserDetail
Where Enabled = 1

ORDER BY [Client!1!ClientID], [Project!2!ProjectID], [Task!3!TaskID]
For XML EXPLICIT

/*



Select Client.ClientID, Client.ClientName,
  Project.ClientID, Project.ProjectID, Project.ProjectName,
	Project.ClientID as TClientID, Task.TaskID, Task.TaskName,
	[User].UserID, [User].FirstName + ' ' + [User].LastName as UserName
From dbo.TT_Clients Client
Left Join dbo.TT_Projects Project on Client.ClientID = Project.ClientID
Left Join dbo.TT_Orders Ord on Project.ProjectID = Ord.ProjectID
Left Join dbo.TT_ProjectTasks Task on Ord.OrderID = Task.OrderID 
Left Join dbo.TT_ProjectResources Res on Project.ProjectID = Res.ProjectID
Left Join dbo.Usr_UserDetail [User] on Res.UserID = [User].UserID 
*/









GO
/****** Object:  StoredProcedure [dbo].[TT_Rep_XML_TaskRegister]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_Rep_XML_TaskRegister]
--@Where as varchar(2000)
as

	SELECT 1          as Tag, 
	       NULL       as Parent,
	       ClientID 	as [Client!1!ClientID],
	       ClientName as [Client!1!ClientName]
	From dbo.TT_Clients
ORDER BY [Client!1!ClientID]
For XML EXPLICIT
--Union
	SELECT 
				 2 as Tag, 
	       NULL as Parent,
	       a.ClientID as [Project!2!ClientID],
				 ProjectID as [Project!2!ProjectID],
				 ProjectName as [Project!2!ProjectName]
	FROM dbo.TT_Clients a, dbo.TT_Projects b
	WHERE a.ClientID = b.ClientID
ORDER BY [Project!2!ClientID], [Project!2!ProjectID]
For XML EXPLICIT
--Union
	SELECT 3 as Tag, 
	       NULL as Parent,
	       a.ClientID			 	as [Task!3!ClientID],
	       a.ProjectID      as [Task!3!ProjectID],
	       b.TaskID    		  as [Task!3!TaskID],
	       b.TaskName       as [Task!3!TaskName]
From 
(Select Client.ClientID, Project.ProjectID, Ord.OrderID From dbo.TT_Clients Client
Left Join dbo.TT_Projects Project on Client.ClientID = Project.ClientID
Left Join dbo.TT_Orders Ord on Project.ProjectID = Ord.ProjectID) a, dbo.TT_ProjectTasks b
Where a.OrderID = b.OrderID
ORDER BY [Task!3!ClientID], [Task!3!ProjectID], [Task!3!TaskID]
For XML EXPLICIT
--Union
	SELECT 4 as Tag,
	       NULL as Parent,
	       UserID       as [User!4!UserID],
	       FirstName + ' ' + LastName       as [User!4!UserName]
From dbo.Usr_UserDetail
Where Enabled = 1

--ORDER BY [Client!1!ClientID], [Project!2!ProjectID], [Task!3!TaskID]
For XML EXPLICIT






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectApprovals]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_SelectApprovals]
@ApprovalItemID Int,
@ApprovalType int
AS

Select *
From dbo.TT_Approvals
Where ApprovalTypeID = @ApprovalType
And ApprovedItemID = @ApprovalItemID






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectApprover]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/********************************************************************    
Created by: VF    
Created on: ??    
Does: Returns all users who belong to the user Group passed in    
    
Modified:    
    
01/02/2010 by SD: Return only enabled users and order by the LastName    
********************************************************************/    
CREATE procedure [dbo].[TT_SelectApprover]      
 @ApproverGroup Int      
AS      
    
SELECT     
 a.UserID, (LastName + ', ' + FirstName) as UserName      
FROM    
 dbo.Usr_UserDetail a INNER JOIN    
 dbo.Usr_UserGroup b on a.UserID = b.UserID    
WHERE     
 GroupID = @ApproverGroup AND     
 [Enabled] = 1    
ORDER BY    
 LastName





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectClient]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_SelectClient]
@ManConst Int
AS
If @ManConst = 1
	-- For Administartion, select all Clients
	Begin
		Select ClientID, ClientName + ' (' + ClientCode + ')' as ClientName
		From dbo.TT_Clients
		Order by ClientName
	End
Else
	Begin
		Select ClientID, ClientName + ' (' + ClientCode + ')' as ClientName
		From dbo.TT_Clients
		Where Enabled = 1
		Order by ClientName
	End






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectClientInfo]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_SelectClientInfo]
@ClientID Int
AS
Select a.*, b.CountryName
From dbo.TT_Clients a
Join dbo.TT_Countries b on a.CountryID = b.CountryID
Where ClientID = @ClientID





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectContact]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[TT_SelectContact]
@ManConst int 
AS
	If @ManConst = 1
	-- Administration
	Begin
		Select ContactID, LastName + ', ' + FirstName as ContactName
		From dbo.TT_Contacts
		Order by LastName,FirstName
	End
	Else
	Begin
		Select ContactID, LastName + ', ' + FirstName as ContactName
		From dbo.TT_Contacts
		Where Enabled = 1
		Order by LastName,FirstName
	End







GO
/****** Object:  StoredProcedure [dbo].[TT_SelectContactInfo]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE procedure [dbo].[TT_SelectContactInfo]
@ContactID Int
AS
Select *
From dbo.TT_Contacts
Where ContactID = @ContactID









GO
/****** Object:  StoredProcedure [dbo].[TT_SelectCostCentre]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[TT_SelectCostCentre]
AS
Select CostCentreID , CostCentreName
From dbo.TT_CostCentres a
Where Enabled = 1
Order by CostCentreName







GO
/****** Object:  StoredProcedure [dbo].[TT_SelectCostCentre_Rate]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_SelectCostCentre_Rate]
AS
Select Cast(CostCentreID as varchar) + '#' + CurrencySymbol + ' (' + CurrencyName + ')' as CostCentreID , CostCentreName
From dbo.TT_CostCentres a
Join dbo.TT_Countries b on a.CountryID = b.CountryID
Join dbo.TT_Currencies c on b.CurrencyID = c.CurrencyID
Where Enabled = 1






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectCostCentreInfo]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_SelectCostCentreInfo]
@CostCentreID int
AS
Select a.*,b.FirstName + ' ' + b.LastName as UserName, c.CountryName 
From dbo.TT_CostCentres a
join dbo.Usr_UserDetail b on a.ManagerID = b.UserID
join dbo.TT_Countries c on a.CountryID = c.CountryID
Where CostCentreID = @CostCentreID





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectCountry]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_SelectCountry]
AS
Select CountryID, CountryName
From dbo.TT_Countries
Order By CountryName






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectCurrency]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_SelectCurrency]
AS
Select CurrencyID, CurrencyName + '(' + CurrencySymbol + ')' as CurrencyName
From dbo.TT_Currencies







GO
/****** Object:  StoredProcedure [dbo].[TT_SelectDocumentTypeInfo]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************  
Created by: SD  
Created on: 09/01/2012  
Does:  Displays Financial Document Types Info and Email Users
*****************************************************/  
CREATE PROCEDURE [dbo].[TT_SelectDocumentTypeInfo]  
@FinancialDocTypeID int  
  
AS  
  
SELECT   
 FinancialDocTypeID  
    ,FinancialDocType        
FROM   
 TT_FinancialDocumentType  
WHERE  
 FinancialDocTypeID = @FinancialDocTypeID  
  
  
SELECT  
 a.UserID  
 ,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') as FullName  
 ,Email  
FROM  
 TT_FinancialDocTypeUsers a  
  INNER JOIN Usr_UserDetail b  
   ON a.UserID = b.UserID  
WHERE  
 FinancialDocTypeID = @FinancialDocTypeID   
  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseApprovals_ByClient]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /****************************************************************************************************************  
Created by: VF  
Created on: ???  
Does:  Retrieves a list of exepenses for approval  
Used in:  Timetrax.DAL.SelectExpenseForApprovals  
  
Modified:  
  
03/05/2005 by SB - Changed to work off ExpenseMonth  
22/02/2010 by SD - Changed to work off Teamleader not TSFirstApprover
****************************************************************************************************************/  
CREATE procedure [dbo].[TT_SelectExpenseApprovals_ByClient]  
@UserID Int,  
@StartDate SmallDateTime  
AS  
  
-- Get the Clients for each project that this user is an approver for  
-- that has expenses for the required period  
Select Distinct c.ClientID, c.ClientName  
From TT_Expenses a  
Join (  
 Select ProjectID,  
 Case When Teamleader is not Null Then '1' Else '2' End  as Approver  
 From TT_ProjectResources  
 Where (Teamleader is not Null  
 Or Teamleader is not Null)  
 and UserID = @UserID) e on a.ProjectID = e.ProjectID and a.ApprovalStage = e.Approver  
Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID  
Left Join TT_Projects h on e.ProjectID = h.ProjectID  
Left Join TT_Clients c on h.ClientID = c.ClientID  
--Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))  
Where Datediff(m, @StartDate, ExpenseMonth) = 0  
And Submitted is Not Null  
And (f.Approved = 0 or f.Approved is Null)  
Order by c.ClientName  
  
-- Get the Projects that the User is an approver for  
Select Distinct c.ClientID, a.ProjectID, h.ProjectName, Approver, Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) as KeyVal  
From TT_Expenses a  
Join (  
 Select ProjectID,  
 Case When Teamleader is not Null Then '1' Else '2' End  as Approver  
 From TT_ProjectResources  
 Where (Teamleader is not Null  
 Or Teamleader is not Null)  
 and UserID = @UserID) e on a.ProjectID = e.ProjectID and a.ApprovalStage = e.Approver  
Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID  
Left Join TT_Projects h on e.ProjectID = h.ProjectID  
Left Join TT_Clients c on h.ClientID = c.ClientID  
--Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))  
Where Datediff(m, @StartDate, ExpenseMonth) = 0  
And Submitted is Not Null  
And (f.Approved = 0 or f.Approved is Null)  
Order By c.ClientID, h.ProjectName  
  
-- Get User Names for Expense Items  
Select Distinct a.ClientID, a.ProjectID, a.UserID, UserName, Cast(a.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) as KeyVal, Cast(a.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar) as KeyVal2  
From (  
 Select a.*, c.ClientID, g.FirstName + ' ' + g.LastName as UserName  
 From TT_Expenses a  
-- This Join limits the Expenses to ??  
 Join (  
  Select ProjectID,  
  Case When Teamleader is not Null Then '1' Else '2' End  as Approver  
  From TT_ProjectResources  
  Where (Teamleader is not Null  
  Or Teamleader is not Null)  
  and UserID = @UserID) b on a.ProjectID = b.ProjectID and a.ApprovalStage = b.Approver  
 Left Join TT_Projects d on a.ProjectID = d.ProjectID  
 Left Join TT_Clients c on d.ClientID = c.ClientID  
 Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID  
 Left Join Usr_UserDetail g on a.UserID = g.UserID  
 --Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))  
 Where Datediff(m, @StartDate, ExpenseMonth) = 0  
 And Submitted is Not Null  
 And (f.Approved = 0 or f.Approved is Null)  
) a  
Order By UserName  
  
-- Get All Expense items for Selected Month that have been submitted  
-- and are ready to be approved  
-- and which are at the correct approval stage for this approver  
-- and have not been previously approved  
Select 
	Cast(h.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar) as KeyVal2, 
	h.ClientID, a.ProjectID, a.UserID, a.ExpenseID, Convert(varchar, a.ExpenseDate,6) as txtDate, 
	i.[Description] as ExpenseType, isnull(a.Quantity,0) as Quantity, isnull(a.UnitCost,0) as UnitCost, isnull(a.Comment,'') as txtComment  
From TT_Expenses a  
Join (  
 Select ProjectID,  
 Case When Teamleader is not Null Then '1' Else '2' End  as Approver  
 From TT_ProjectResources  
 Where (Teamleader is not Null  
 Or Teamleader is not Null)  
 and UserID = @UserID) e on a.ProjectID = e.ProjectID and a.ApprovalStage = e.Approver  
Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID  
Left Join Usr_UserDetail g on a.UserID = g.UserID  
Left Join TT_Projects h on e.ProjectID = h.ProjectID  
Left Join TT_ExpenseTypes i on a.ExpenseTypeID = i.ExpenseTypeID  
--Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))  
Where Datediff(m, @StartDate, ExpenseMonth) = 0  
And Submitted is Not Null  
And (f.Approved = 0 or f.Approved is Null)  
Order By a.ExpenseDate  




GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseApprovals_ByClient_Backup]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_SelectExpenseApprovals_ByClient_Backup]
@UserID Int,
@StartDate SmallDateTime
AS

-- Get the Clients for each project that this user is an approver for
Select Distinct c.ClientID, c.ClientName
From TT_Expenses a
Join (
	Select ProjectID,
	Case When TSFirstApprover is not Null Then '1' Else '2' End  as Approver
	From TT_ProjectResources
	Where (TSFirstApprover is not Null
	Or TSLastApprover is not Null)
	and UserID = @UserID) e on a.ProjectID = e.ProjectID and a.ApprovalStage = e.Approver
Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID
Left Join TT_Projects h on e.ProjectID = h.ProjectID
Left Join TT_Clients c on h.ClientID = c.ClientID
Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))
And Submitted is Not Null
And (f.Approved = 0 or f.Approved is Null)
Order by c.ClientName

-- Get the Projects that the User is an approver for
Select Distinct c.ClientID, a.ProjectID, h.ProjectName, Approver, Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) as KeyVal
From TT_Expenses a
Join (
	Select ProjectID,
	Case When TSFirstApprover is not Null Then '1' Else '2' End  as Approver
	From TT_ProjectResources
	Where (TSFirstApprover is not Null
	Or TSLastApprover is not Null)
	and UserID = @UserID) e on a.ProjectID = e.ProjectID and a.ApprovalStage = e.Approver
Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID
Left Join TT_Projects h on e.ProjectID = h.ProjectID
Left Join TT_Clients c on h.ClientID = c.ClientID
Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))
And Submitted is Not Null
And (f.Approved = 0 or f.Approved is Null)
Order By c.ClientID, h.ProjectName

-- Get User Names for Expense Items
Select Distinct a.ClientID, a.ProjectID, a.UserID, UserName, Cast(a.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) as KeyVal, Cast(a.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar) as KeyVal2
From (
	Select a.*, c.ClientID, g.FirstName + ' ' + g.LastName as UserName
	From TT_Expenses a
-- This Join limits the Expenses to ??
	Join (
		Select ProjectID,
		Case When TSFirstApprover is not Null Then '1' Else '2' End  as Approver
		From TT_ProjectResources
		Where (TSFirstApprover is not Null
		Or TSLastApprover is not Null)
		and UserID = @UserID) b on a.ProjectID = b.ProjectID and a.ApprovalStage = b.Approver
	Left Join TT_Projects d on a.ProjectID = d.ProjectID
	Left Join TT_Clients c on d.ClientID = c.ClientID
	Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID
	Left Join Usr_UserDetail g on a.UserID = g.UserID
	Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))
	And Submitted is Not Null
	And (f.Approved = 0 or f.Approved is Null)
) a
Order By UserName

-- Get All Expense items for Selected Month that have been submitted
-- and are ready to be approved
-- and which are at the correct approval stage for this approver
-- and have not been previously approved
Select Cast(h.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar) as KeyVal2, h.ClientID, a.ProjectID, a.UserID, a.ExpenseID, Convert(varchar, a.ExpenseDate,6) as txtDate, i.[Description] as ExpenseType, isnull(a.Quantity,0) as Quantity, isnull(a.UnitCost,0) as UnitCost, isnull(a.Comment,'') as txtComment
From TT_Expenses a
Join (
	Select ProjectID,
	Case When TSFirstApprover is not Null Then '1' Else '2' End  as Approver
	From TT_ProjectResources
	Where (TSFirstApprover is not Null
	Or TSLastApprover is not Null)
	and UserID = @UserID) e on a.ProjectID = e.ProjectID and a.ApprovalStage = e.Approver
Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID
Left Join Usr_UserDetail g on a.UserID = g.UserID
Left Join TT_Projects h on e.ProjectID = h.ProjectID
Left Join TT_ExpenseTypes i on a.ExpenseTypeID = i.ExpenseTypeID
Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))
And Submitted is Not Null
And (f.Approved = 0 or f.Approved is Null)
Order By a.ExpenseDate









GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseApprovals_ByResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /****************************************************************************************************************  
Created by: VF  
Created on: ???  
Does:  Retrieves a list of exepenses for approval  
Used in:  Timetrax.DAL.SelectExpenseForApprovals  
  
Modified:  
  
05/09/2005 by SB - Changed to work off ExpenseMonth 
23/02/2010 by SD - Changed to use Teamleader instead of TSFirstApprover as this column has been removed 
****************************************************************************************************************/  
CREATE procedure [dbo].[TT_SelectExpenseApprovals_ByResource]  
@UserID Int,  
@StartDate SmallDateTime  
AS  
  
-- Get User Names for Expense Items  
Select Distinct UserID, UserName  
From (  
 Select a.UserID, g.FirstName + ' ' + g.LastName as UserName  
 From TT_Expenses a  
 Join (  
  Select ProjectID,  
  Case When Teamleader is not Null Then '1' Else '2' End  as Approver  
  From TT_ProjectResources  
  Where (Teamleader is not Null  
  Or Teamleader is not Null)  
  and UserID = @UserID) b on a.ProjectID = b.ProjectID and a.ApprovalStage = b.Approver  
 Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID  
 Left Join Usr_UserDetail g on a.UserID = g.UserID  
 --Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))  
 Where Datediff(m, @StartDate, ExpenseMonth) = 0  
 And Submitted is Not Null  
 And (f.Approved = 0 or f.Approved is Null)  
) a  
Order By UserName  
  
-- Get the Clients for each project that this user is an approver for  
Select Distinct a.UserID, c.ClientID, c.ClientName,Cast(a.UserID as varchar) + '_' + Cast(h.ClientID as varchar) as KeyVal  
From TT_Expenses a  
Join (  
 Select ProjectID,  
 Case When Teamleader is not Null Then '1' Else '2' End  as Approver  
 From TT_ProjectResources  
 Where (Teamleader is not Null  
 Or Teamleader is not Null)  
 and UserID = @UserID) e on a.ProjectID = e.ProjectID and a.ApprovalStage = e.Approver  
Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID  
Left Join TT_Projects h on e.ProjectID = h.ProjectID  
Left Join TT_Clients c on h.ClientID = c.ClientID  
--Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))  
Where Datediff(m, @StartDate, ExpenseMonth) = 0  
And Submitted is Not Null  
And (f.Approved = 0 or f.Approved is Null)  
Order by c.ClientName  
  
-- Get the Projects that the User is an approver for  
Select Distinct a.UserID
	, c.ClientID
	, a.ProjectID
	, h.ProjectName
	, Approver,Cast(a.UserID as varchar) + '_' + Cast(h.ClientID as varchar) as KeyVal
	, Cast(a.UserID as varchar) + '_' + Cast(h.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) as KeyVal2  
From TT_Expenses a  
Join (  
 Select ProjectID,  
 Case When Teamleader is not Null Then '1' Else '2' End  as Approver  
 From TT_ProjectResources  
 Where (Teamleader is not Null  
 Or Teamleader is not Null)  
 and UserID = @UserID) e on a.ProjectID = e.ProjectID and a.ApprovalStage = e.Approver  
Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID  
Left Join TT_Projects h on e.ProjectID = h.ProjectID  
Left Join TT_Clients c on h.ClientID = c.ClientID  
--Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))  
Where Datediff(m, @StartDate, ExpenseMonth) = 0  
And Submitted is Not Null  
And (f.Approved = 0 or f.Approved is Null)  
Order By c.ClientID, h.ProjectName  
  
-- Get All Expense items for Selected Month that have been submitted  
-- and are ready to be approved  
-- and which are at the correct approval stage for this approver  
-- and have not been previously approved  
Select 
	Cast(a.UserID as varchar) + '_' + Cast(h.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) as KeyVal2
	, h.ClientID
	, a.ProjectID
	, a.UserID
	, a.ExpenseID
	, Convert(varchar, a.ExpenseDate,6) as txtDate
	, i.[Description] as ExpenseType
	, isnull(a.Quantity,0) as Quantity
	, isnull(a.UnitCost,0) as UnitCost
	, isnull(a.Comment,'') as txtComment  
From TT_Expenses a  
Join (  
 Select ProjectID,  
 Case When Teamleader is not Null Then '1' Else '2' End  as Approver  
 From TT_ProjectResources  
 Where (Teamleader is not Null  
 Or Teamleader is not Null)  
 and UserID = @UserID) e on a.ProjectID = e.ProjectID and a.ApprovalStage = e.Approver  
Left Join TT_Approvals f on a.ExpenseID = f.ApprovedItemID and f.ApprovalTypeID = 3 and f.ApproverID = @UserID  
Left Join Usr_UserDetail g on a.UserID = g.UserID  
Left Join TT_Projects h on e.ProjectID = h.ProjectID  
Left Join TT_ExpenseTypes i on a.ExpenseTypeID = i.ExpenseTypeID  
--Where ExpenseDate Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))  
Where Datediff(m, @StartDate, ExpenseMonth) = 0  
And Submitted is Not Null  
And (f.Approved = 0 or f.Approved is Null)  
Order By a.ExpenseDate  




GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseApprovalsManager_ByClient]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /****************************************************************************************************************        
Created by: SD             
Created on: 22/02/2010              
Does:   Retrieves the expenses awaiting approval for the given week for the specified user             
  who is a Manager (Based on TT_SelectExpenseApprovals_ByClient)        
        
Modified:      
      
          
****************************************************************************************************************/        
CREATE procedure [dbo].[TT_SelectExpenseApprovalsManager_ByClient]        
@UserID Int,        
@StartDate SmallDateTime        
AS        
        
-- Get the Clients for each project that this user is an approver for        
-- that has expenses for the required period        
SELECT       
 DISTINCT     
  cast(c.ClientID as varchar) + '_M' as ClientID    
 , c.ClientName        
FROM TT_View_SubmittedExpensesUnapprovedByManager a      
 INNER JOIN TT_Projects b       
  on a.ProjectID = b.ProjectID        
 INNER JOIN TT_Clients c       
  on b.ClientID = c.ClientID        
WHERE      
 Datediff(m, @StartDate, ExpenseMonth) = 0        
 AND a.ProjectID in ( SELECT ProjectID               
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)              
       WHERE  Approver = 2)       
ORDER BY       
 c.ClientName        
        
-- Get the Projects that the User is an approver for        
Select       
 Distinct     
  cast(c.ClientID as varchar)  + '_M' as ClientID    
 , c.ClientName      
 , a.ProjectID      
 , b.ProjectName      
 , Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_M' as KeyVal        
FROM TT_View_SubmittedExpensesUnapprovedByManager a      
 INNER JOIN TT_Projects b       
  on a.ProjectID = b.ProjectID        
 INNER JOIN TT_Clients c       
  on b.ClientID = c.ClientID       
WHERE      
 Datediff(m, @StartDate, ExpenseMonth) = 0        
 AND a.ProjectID in ( SELECT ProjectID               
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)              
       WHERE  Approver = 2)      
ORDER BY       
 c.ClientName         
        
-- Get User Names for Expense Items        
SELECT       
 Distinct     
 c.ClientID      
 , a.ProjectID      
 , a.UserID      
 , d.FirstName + ' ' + d.LastName as UserName      
 , Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar)  + '_M' as KeyVal      
 , Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar)  + '_M' as KeyVal2        
FROM       
 TT_View_SubmittedExpensesUnapprovedByManager a      
  INNER JOIN TT_Projects b       
   ON a.ProjectID = b.ProjectID        
  INNER JOIN TT_Clients c       
   ON b.ClientID = c.ClientID       
  INNER JOIN Usr_UserDetail d      
   ON a.UserID = d.UserID      
WHERE      
 Datediff(m, @StartDate, ExpenseMonth) = 0        
 AND a.ProjectID in ( SELECT ProjectID               
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)              
       WHERE  Approver = 2)      
ORDER BY       
 UserName        
        
-- Get All Expense items for Selected Month that have been submitted        
-- and are ready to be approved        
-- and which are at the correct approval stage for this approver        
-- and have not been previously approved        
Select       
 Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar) + '_M' as KeyVal2,       
 c.ClientID,       
 a.ProjectID,       
 a.UserID,       
 a.ExpenseID,       
 Convert(varchar, a.ExpenseDate,6) as txtDate,       
 d.[Description] as ExpenseType, isnull(a.Quantity,0) as Quantity,       
 isnull(a.UnitCost,0) as UnitCost,       
 isnull(a.Comment,'') as txtComment        
FROM       
 TT_View_SubmittedExpensesUnapprovedByManager a      
  INNER JOIN TT_Projects b       
   ON a.ProjectID = b.ProjectID        
  INNER JOIN TT_Clients c       
   ON b.ClientID = c.ClientID       
  INNER JOIN TT_ExpenseTypes d      
   ON a.ExpenseTypeID = d.ExpenseTypeID      
WHERE      
 Datediff(m, @StartDate, ExpenseMonth) = 0   
 AND a.ProjectID in ( SELECT ProjectID               
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)              
       WHERE  Approver = 2)      
ORDER BY       
 a.ExpenseDate 



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseApprovalsManager_ByResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /****************************************************************************************************************            
Created by: SD                 
Created on: 23/02/2010                  
Does:   Retrieves the expenses awaiting approval for the given week for the specified user                 
  who is a Manager (Based on TT_SelectExpenseApprovals_ByClient)            
            
Modified:          
          
23/02/2012 by SD: Added distinct when selecting the user to ensure a unique key              
****************************************************************************************************************/            
CREATE procedure [dbo].[TT_SelectExpenseApprovalsManager_ByResource]            
@UserID Int,            
@StartDate SmallDateTime            
AS            
       
-- Get User Names for Expense Items            
SELECT Distinct          
 cast(a.UserID as varchar) + '_M' as UserID  
 , d.FirstName + ' ' + d.LastName as UserName          
FROM           
 TT_View_SubmittedExpensesUnapprovedByManager a          
  INNER JOIN TT_Projects b           
   ON a.ProjectID = b.ProjectID            
  INNER JOIN TT_Clients c           
   ON b.ClientID = c.ClientID           
  INNER JOIN Usr_UserDetail d          
   ON a.UserID = d.UserID          
WHERE          
 Datediff(m, @StartDate, ExpenseMonth) = 0            
 AND a.ProjectID in ( SELECT ProjectID                   
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                  
       WHERE  Approver = 2)          
ORDER BY           
 UserName        
            
-- Get the Clients for each project that this user is an approver for            
-- that has expenses for the required period            
SELECT           
 Distinct  cast(a.UserID as varchar) + '_M' as UserID  
 , c.ClientID  
 , c.ClientName  
 ,Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_M' as KeyVal          
FROM TT_View_SubmittedExpensesUnapprovedByManager a          
 INNER JOIN TT_Projects b           
  on a.ProjectID = b.ProjectID            
 INNER JOIN TT_Clients c           
  on b.ClientID = c.ClientID            
WHERE          
 Datediff(m, @StartDate, ExpenseMonth) = 0            
 AND a.ProjectID in ( SELECT ProjectID                   
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                  
       WHERE  Approver = 2)           
ORDER BY           
 c.ClientName            
            
-- Get the Projects that the User is an approver for            
Select           
 Distinct         
 c.ClientID        
 , c.ClientName          
 , a.ProjectID          
 , b.ProjectName          
 , Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_M' as KeyVal    
 , Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_M' as KeyVal2            
FROM TT_View_SubmittedExpensesUnapprovedByManager a          
 INNER JOIN TT_Projects b           
  on a.ProjectID = b.ProjectID            
 INNER JOIN TT_Clients c           
  on b.ClientID = c.ClientID           
WHERE          
 Datediff(m, @StartDate, ExpenseMonth) = 0            
 AND a.ProjectID in ( SELECT ProjectID                   
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                  
       WHERE  Approver = 2)          
ORDER BY           
 c.ClientName             
            
          
            
-- Get All Expense items for Selected Month that have been submitted            
-- and are ready to be approved            
-- and which are at the correct approval stage for this approver            
-- and have not been previously approved            
Select           
 Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_M' as KeyVal2,           
 c.ClientID,           
 a.ProjectID,           
 a.UserID,           
 a.ExpenseID,           
 Convert(varchar, a.ExpenseDate,6) as txtDate,           
 d.[Description] as ExpenseType, isnull(a.Quantity,0) as Quantity,           
 isnull(a.UnitCost,0) as UnitCost,           
 isnull(a.Comment,'') as txtComment            
FROM           
 TT_View_SubmittedExpensesUnapprovedByManager a          
  INNER JOIN TT_Projects b           
   ON a.ProjectID = b.ProjectID            
  INNER JOIN TT_Clients c           
   ON b.ClientID = c.ClientID           
  INNER JOIN TT_ExpenseTypes d          
   ON a.ExpenseTypeID = d.ExpenseTypeID          
WHERE          
 Datediff(m, @StartDate, ExpenseMonth) = 0       
 AND a.ProjectID in ( SELECT ProjectID                   
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                  
       WHERE  Approver = 2)          
ORDER BY           
 a.ExpenseDate   
 



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseApprovalsManagerMonitor_ByClient]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****************************************************************************************************************    
Created by: SD         
Created on: 22/02/2010          
Does:   Retrieves the expenses awaiting approval by the teamleader for the given week         
  for projects on which the user is a manager        
    
Modified:  
  
      
****************************************************************************************************************/    
CREATE procedure [dbo].[TT_SelectExpenseApprovalsManagerMonitor_ByClient]    
@UserID Int,    
@StartDate SmallDateTime    
AS    
    
-- Get the Clients for each project that this user is an approver for    
-- that has expenses for the required period    
SELECT   
 DISTINCT   
  cast(c.ClientID as varchar) + '_MM' as ClientID  
  , c.ClientName    
FROM TT_View_SubmittedExpensesUnapprovedByTeamleader a  
 INNER JOIN TT_Projects b   
  on a.ProjectID = b.ProjectID    
 INNER JOIN TT_Clients c   
  on b.ClientID = c.ClientID    
WHERE  
 Datediff(m, @StartDate, ExpenseMonth) = 0    
 AND a.ProjectID in ( SELECT ProjectID           
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)          
       WHERE  Approver = 2)   
ORDER BY   
 c.ClientName    
    
-- Get the Projects that the User is an approver for    
Select   
 Distinct cast(c.ClientID as varchar) + '_MM' as ClientID  
 , c.ClientName  
 , a.ProjectID  
 , b.ProjectName  
 , Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_MM' as KeyVal    
FROM TT_View_SubmittedExpensesUnapprovedByTeamleader a  
 INNER JOIN TT_Projects b   
  on a.ProjectID = b.ProjectID    
 INNER JOIN TT_Clients c   
  on b.ClientID = c.ClientID   
WHERE  
 Datediff(m, @StartDate, ExpenseMonth) = 0    
 AND a.ProjectID in ( SELECT ProjectID           
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)          
       WHERE  Approver = 2)  
ORDER BY   
 c.ClientName     
    
-- Get User Names for Expense Items    
SELECT   
 Distinct c.ClientID  
 , a.ProjectID  
 , a.UserID  
 , d.FirstName + ' ' + d.LastName as UserName  
 , Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_MM' as KeyVal  
 , Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar) + '_MM' as KeyVal2    
FROM   
 TT_View_SubmittedExpensesUnapprovedByTeamleader a  
  INNER JOIN TT_Projects b   
   ON a.ProjectID = b.ProjectID    
  INNER JOIN TT_Clients c   
   ON b.ClientID = c.ClientID   
  INNER JOIN Usr_UserDetail d  
   ON a.UserID = d.UserID  
WHERE  
 Datediff(m, @StartDate, ExpenseMonth) = 0    
 AND a.ProjectID in ( SELECT ProjectID           
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)          
       WHERE  Approver = 2)  
ORDER BY   
 UserName    
    
-- Get All Expense items for Selected Month that have been submitted    
-- and are ready to be approved    
-- and which are at the correct approval stage for this approver    
-- and have not been previously approved    
Select   
 Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar) + '_MM' as KeyVal2,   
 c.ClientID,   
 a.ProjectID,   
 a.UserID,   
 a.ExpenseID,   
 Convert(varchar, a.ExpenseDate,6) as txtDate,   
 d.[Description] as ExpenseType, isnull(a.Quantity,0) as Quantity,   
 isnull(a.UnitCost,0) as UnitCost,   
 isnull(a.Comment,'') as txtComment    
FROM   
 TT_View_SubmittedExpensesUnapprovedByTeamleader a  
  INNER JOIN TT_Projects b   
   ON a.ProjectID = b.ProjectID    
  INNER JOIN TT_Clients c   
   ON b.ClientID = c.ClientID   
  INNER JOIN TT_ExpenseTypes d  
   ON a.ExpenseTypeID = d.ExpenseTypeID  
WHERE  
 Datediff(m, @StartDate, ExpenseMonth) = 0    
 AND a.ProjectID in ( SELECT ProjectID           
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)          
       WHERE  Approver = 2)  
ORDER BY   
 a.ExpenseDate 



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseApprovalsManagerMonitor_ByResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /****************************************************************************************************************            
Created by: SD                 
Created on: 23/02/2010                  
Does:   Retrieves the expenses awaiting approval by the teamleader for the given week for projects  
 that the user is a Manager on  
            
Modified:          
          
23/02/2012 by SD: Added distinct when selecting the user to ensure a unique key                            
****************************************************************************************************************/            
CREATE procedure [dbo].[TT_SelectExpenseApprovalsManagerMonitor_ByResource]            
@UserID Int,            
@StartDate SmallDateTime            
AS            
       
-- Get User Names for Expense Items            
SELECT Distinct         
 cast(a.UserID as varchar) + '_M' as UserID  
 , d.FirstName + ' ' + d.LastName as UserName          
FROM           
 TT_View_SubmittedExpensesUnapprovedByTeamleader a          
  INNER JOIN TT_Projects b           
   ON a.ProjectID = b.ProjectID            
  INNER JOIN TT_Clients c           
   ON b.ClientID = c.ClientID           
  INNER JOIN Usr_UserDetail d          
   ON a.UserID = d.UserID          
WHERE          
 Datediff(m, @StartDate, ExpenseMonth) = 0            
 AND a.ProjectID in ( SELECT ProjectID                   
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                  
       WHERE  Approver = 2)          
ORDER BY           
 UserName        
            
-- Get the Clients for each project that this user is an approver for            
-- that has expenses for the required period            
SELECT           
 Distinct  cast(a.UserID as varchar) + '_M' as UserID  
 , c.ClientID  
 , c.ClientName  
 ,Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_M' as KeyVal          
FROM TT_View_SubmittedExpensesUnapprovedByTeamleader a          
 INNER JOIN TT_Projects b           
  on a.ProjectID = b.ProjectID            
 INNER JOIN TT_Clients c           
  on b.ClientID = c.ClientID            
WHERE          
 Datediff(m, @StartDate, ExpenseMonth) = 0            
 AND a.ProjectID in ( SELECT ProjectID                   
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                  
       WHERE  Approver = 2)           
ORDER BY           
 c.ClientName            
            
-- Get the Projects that the User is an approver for            
Select           
 Distinct         
 c.ClientID        
 , c.ClientName          
 , a.ProjectID          
 , b.ProjectName          
 , Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_M' as KeyVal    
 , Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_M' as KeyVal2            
FROM TT_View_SubmittedExpensesUnapprovedByTeamleader a          
 INNER JOIN TT_Projects b           
  on a.ProjectID = b.ProjectID            
 INNER JOIN TT_Clients c           
  on b.ClientID = c.ClientID           
WHERE          
 Datediff(m, @StartDate, ExpenseMonth) = 0            
 AND a.ProjectID in ( SELECT ProjectID                   
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                  
       WHERE  Approver = 2)          
ORDER BY           
 c.ClientName             
            
          
            
-- Get All Expense items for Selected Month that have been submitted            
-- and are ready to be approved            
-- and which are at the correct approval stage for this approver            
-- and have not been previously approved            
Select           
 Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_M' as KeyVal2,           
 c.ClientID,           
 a.ProjectID,           
 a.UserID,           
 a.ExpenseID,           
 Convert(varchar, a.ExpenseDate,6) as txtDate,           
 d.[Description] as ExpenseType, isnull(a.Quantity,0) as Quantity,           
 isnull(a.UnitCost,0) as UnitCost,           
 isnull(a.Comment,'') as txtComment            
FROM           
 TT_View_SubmittedExpensesUnapprovedByTeamleader a          
  INNER JOIN TT_Projects b           
   ON a.ProjectID = b.ProjectID            
  INNER JOIN TT_Clients c           
   ON b.ClientID = c.ClientID           
  INNER JOIN TT_ExpenseTypes d          
   ON a.ExpenseTypeID = d.ExpenseTypeID          
WHERE          
 Datediff(m, @StartDate, ExpenseMonth) = 0       
 AND a.ProjectID in ( SELECT ProjectID                   
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                  
       WHERE  Approver = 2)          
ORDER BY           
 a.ExpenseDate   
 



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseApprovalsMD_ByClient]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /****************************************************************************************************************              
Created by: SD                   
Created on: 08/02/2012    
Does:   Retrieves the expenses awaiting approval for the given week for the specified user                   
  who is a MD (Based on TT_SelectExpenseApprovals_ByClient)              
              
Modified:            
            
                
****************************************************************************************************************/              
CREATE procedure [dbo].[TT_SelectExpenseApprovalsMD_ByClient]              
@UserID Int,              
@StartDate SmallDateTime              
AS        
              
-- Get the Clients for each project that this user is an approver for              
-- that has expenses for the required period              
SELECT             
 DISTINCT           
  cast(c.ClientID as varchar) + '_MD' as ClientID          
 , c.ClientName              
FROM TT_View_SubmittedExpensesUnapprovedByMD a            
 INNER JOIN TT_Projects b             
  on a.ProjectID = b.ProjectID              
 INNER JOIN TT_Clients c             
  on b.ClientID = c.ClientID              
WHERE            
 Datediff(m, @StartDate, ExpenseMonth) = 0              
 AND  @UserID IN (            
     SELECT  UserID         
     From TT_View_MDApprovers)                      
ORDER BY             
 c.ClientName              
              
-- Get the Projects that the User is an approver for              
Select             
 Distinct           
  cast(c.ClientID as varchar)  + '_MD' as ClientID          
 , c.ClientName            
 , a.ProjectID            
 , b.ProjectName            
 , Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_MD' as KeyVal              
FROM TT_View_SubmittedExpensesUnapprovedByMD a            
 INNER JOIN TT_Projects b             
  on a.ProjectID = b.ProjectID              
 INNER JOIN TT_Clients c             
  on b.ClientID = c.ClientID             
WHERE            
 Datediff(m, @StartDate, ExpenseMonth) = 0              
 AND  @UserID IN (            
     SELECT  UserID         
     From TT_View_MDApprovers)            
ORDER BY             
 c.ClientName               
              
-- Get User Names for Expense Items              
SELECT             
 Distinct           
 c.ClientID            
 , a.ProjectID            
 , a.UserID            
 , d.FirstName + ' ' + d.LastName as UserName            
 , Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar)  + '_MD' as KeyVal            
 , Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar)  + '_MD' as KeyVal2              
FROM             
 TT_View_SubmittedExpensesUnapprovedByMD a            
  INNER JOIN TT_Projects b             
   ON a.ProjectID = b.ProjectID              
  INNER JOIN TT_Clients c             
   ON b.ClientID = c.ClientID             
  INNER JOIN Usr_UserDetail d            
   ON a.UserID = d.UserID            
WHERE            
 Datediff(m, @StartDate, ExpenseMonth) = 0              
 AND  @UserID IN (            
     SELECT  UserID         
     From TT_View_MDApprovers)             
ORDER BY             
 UserName              
              
-- Get All Expense items for Selected Month that have been submitted              
-- and are ready to be approved              
-- and which are at the correct approval stage for this approver              
-- and have not been previously approved              
Select             
 Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.UserID as varchar) + '_MD' as KeyVal2,             
 c.ClientID,             
 a.ProjectID,             
 a.UserID,             
 a.ExpenseID,             
 Convert(varchar, a.ExpenseDate,6) as txtDate,             
 d.[Description] as ExpenseType, isnull(a.Quantity,0) as Quantity,             
 isnull(a.UnitCost,0) as UnitCost,             
 isnull(a.Comment,'') as txtComment              
FROM          
 TT_View_SubmittedExpensesUnapprovedByMD a            
  INNER JOIN TT_Projects b             
   ON a.ProjectID = b.ProjectID            INNER JOIN TT_Clients c             
   ON b.ClientID = c.ClientID             
  INNER JOIN TT_ExpenseTypes d            
   ON a.ExpenseTypeID = d.ExpenseTypeID            
WHERE            
 Datediff(m, @StartDate, ExpenseMonth) = 0         
 AND  @UserID IN (            
     SELECT  UserID         
     From TT_View_MDApprovers)            
ORDER BY             
 a.ExpenseDate 
 



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseApprovalsMD_ByResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****************************************************************************************************************              
Created by: SD                   
Created on: 08/02/2012  
Does:   Retrieves the expenses awaiting approval for the given week for the specified user                   
  who is a MD (Based on TT_SelectExpenseApprovals_ByClient)              
              
Modified:            
            
23/02/2012 by SD: Added the Distinct select on UserName to ensure we have a unique key                
****************************************************************************************************************/              
CREATE procedure [dbo].[TT_SelectExpenseApprovalsMD_ByResource]              
@UserID Int,              
@StartDate SmallDateTime              
AS              
         
-- Get User Names for Expense Items              
SELECT Distinct            
 cast(a.UserID as varchar) + '_MD' as UserID    
 , d.FirstName + ' ' + d.LastName as UserName            
FROM             
 TT_View_SubmittedExpensesUnapprovedByMD a            
  INNER JOIN TT_Projects b             
   ON a.ProjectID = b.ProjectID              
  INNER JOIN TT_Clients c             
   ON b.ClientID = c.ClientID             
  INNER JOIN Usr_UserDetail d            
   ON a.UserID = d.UserID            
WHERE            
 Datediff(m, @StartDate, ExpenseMonth) = 0              
 AND  @UserID IN (          
     SELECT  UserID       
     From TT_View_MDApprovers)              
ORDER BY             
 UserName          
              
-- Get the Clients for each project that this user is an approver for              
-- that has expenses for the required period              
SELECT             
 Distinct  cast(a.UserID as varchar) + '_MD' as UserID    
 , c.ClientID    
 , c.ClientName    
 ,Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_MD' as KeyVal            
FROM TT_View_SubmittedExpensesUnapprovedByMD a            
 INNER JOIN TT_Projects b             
  on a.ProjectID = b.ProjectID              
 INNER JOIN TT_Clients c             
  on b.ClientID = c.ClientID              
WHERE            
 Datediff(m, @StartDate, ExpenseMonth) = 0              
 AND  @UserID IN (          
     SELECT  UserID       
     From TT_View_MDApprovers)                 
ORDER BY             
 c.ClientName              
              
-- Get the Projects that the User is an approver for              
Select             
 Distinct           
 c.ClientID          
 , c.ClientName            
 , a.ProjectID            
 , b.ProjectName            
 , Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_MD' as KeyVal      
 , Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_MD' as KeyVal2              
FROM TT_View_SubmittedExpensesUnapprovedByMD a            
 INNER JOIN TT_Projects b             
  on a.ProjectID = b.ProjectID              
 INNER JOIN TT_Clients c             
  on b.ClientID = c.ClientID             
WHERE            
 Datediff(m, @StartDate, ExpenseMonth) = 0              
 AND  @UserID IN (          
     SELECT  UserID       
     From TT_View_MDApprovers)                
ORDER BY             
 c.ClientName               
              
            
              
-- Get All Expense items for Selected Month that have been submitted              
-- and are ready to be approved              
-- and which are at the correct approval stage for this approver              
-- and have not been previously approved              
Select             
 Cast(a.UserID as varchar) + '_' + Cast(c.ClientID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_MD' as KeyVal2,             
 c.ClientID,             
 a.ProjectID,             
 a.UserID,             
 a.ExpenseID,             
 Convert(varchar, a.ExpenseDate,6) as txtDate,             
 d.[Description] as ExpenseType, isnull(a.Quantity,0) as Quantity,             
 isnull(a.UnitCost,0) as UnitCost,             
 isnull(a.Comment,'') as txtComment              
FROM             
 TT_View_SubmittedExpensesUnapprovedByMD a            
  INNER JOIN TT_Projects b             
  ON a.ProjectID = b.ProjectID              
  INNER JOIN TT_Clients c             
   ON b.ClientID = c.ClientID             
  INNER JOIN TT_ExpenseTypes d            
   ON a.ExpenseTypeID = d.ExpenseTypeID            
WHERE            
 Datediff(m, @StartDate, ExpenseMonth) = 0         
 AND  @UserID IN (          
     SELECT  UserID       
     From TT_View_MDApprovers)               
ORDER BY             
 a.ExpenseDate 


GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpensesAwaitingApprovalForUser]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /*******************************************************************************************************************    
Created by: SD    
Created on: 11/10/2005    
Used in:  Timetrax.DAL.GetExpensesAwaitingApproval    
Does:  Returns a list of expense for the selected user to approve. The application path is used to build up the URL.    
  
Modified:  
  
24/02/2010 by SD: Added the Manager and Monitoring levels 
07/02/2012 by SD: Added the MD level 
*******************************************************************************************************************/    
CREATE procedure [dbo].[TT_SelectExpensesAwaitingApprovalForUser]    
@UserID int,    
@ApplicationPath as varchar(100)    
    
AS    
    
Select  Distinct Detail + Case Message    
        When 'ExpenseApprovalTeamleader' then ' (Team Leader)'  
        When 'ExpenseApprovalManager' then ' (Manager)'  
        When 'ExpenseApprovalManagerMonitor' then ' (Monitoring)'  
        Else ' (MD)'
        End as Detail  
From  TT_FXN_ExpensesAwaitngApprovalForUser(@UserID, @ApplicationPath)    





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpensesRejected]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns a count of the number of Expenses rejected
Used in:		Timetrax.Expenses.LoadMonthExpenses

Modified:

06/10/2005 by SD: Change to check agains Expense Month and not Expense Date
********************************************************************************************/
CREATE procedure [dbo].[TT_SelectExpensesRejected]
@UserID Int,
@StartDate SmallDateTime,
@Count as Int Output
AS

Select @Count = Count(ExpenseDate) From TT_Expenses 
Where ExpenseMonth Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))
And UserID = @UserID 
And Submitted is Null

--select @Count



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpensesSubmitted]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns a count of the number of Expenses Submitted
Used in:		Timetrax.Expenses.LoadMonthExpenses

Modified:

06/10/2005 by SD: Change to check agains Expense Month and not Expense Date
********************************************************************************************/
CREATE procedure [dbo].[TT_SelectExpensesSubmitted]
@UserID Int,
@StartDate SmallDateTime,
@Count as Int Output
AS

--Select ExpenseDate, ProjectID, ExpenseID From TT_Expenses 
Select @Count = Count(ExpenseDate) From TT_Expenses 
Where ExpenseMonth Between @StartDate and DateAdd(dd,-1,DateAdd(mm,1,@StartDate))
And UserID = @UserID 
And Submitted is Not Null

--select @Count



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectExpenseTypes]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[TT_SelectExpenseTypes]
AS
Select (Cast(ExpenseTypeID as varchar) + '#' + Cast(isnull(Fixed,0) as varchar) + '#' + Cast(Cast(isnull(Amount,0) as Decimal(5,2)) as varchar)) as TypeID, [Description]
From dbo.TT_ExpenseTypes
Where Enabled = 1
Order by [Description]  --SD: 12/10/2005 - Added Order By



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectFinancialDocsAwaitingApprovalForUser]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /*******************************************************************************************************************    
Created by: SD    
Created on: 05/01/2011   
Used in:  Timetrax.DAL.GetFinancialDocsAwaitingApproval    
Does:  Returns a list of expense for the selected user to approve. The application path is used to build up the URL.    
  

*******************************************************************************************************************/    
CREATE procedure [dbo].[TT_SelectFinancialDocsAwaitingApprovalForUser]    
@UserID int,    
@ApplicationPath as varchar(100)    
    
AS    
    
Select  Distinct Detail + Case Message    
        When 'FinDocTeamLeaderApproval' then ' (Team Leader)'  
        When 'FinDocManagerMonitorApproval' Then ' (Monitoring)'  
        End as Detail  
From  TT_FXN_FinancialDocsAwaitngApprovalForUser(@UserID, @ApplicationPath)    



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectFinancialDocTypeEmails]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************
Created by:	SD
Created on:	09/01/2012
Does:		Retrieves the email addresses for the FinancialDocumentTypeID
*****************************************************/
Create PROCEDURE [dbo].[TT_SelectFinancialDocTypeEmails]
@FinancialDocTypeID int

AS

SELECT
	a.UserID	
	,Email
FROM
	TT_FinancialDocTypeUsers a
		INNER JOIN Usr_UserDetail b
			ON a.UserID = b.UserID
WHERE
	FinancialDocTypeID = @FinancialDocTypeID	





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectFinancialDocument]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /****************************************************************************************************************      
Created by: SD      
Created on: 05/01/2012  
Does:  Retrieves a the given financial document   
Used in:  Timetrax.DAL.SelectFinancialDocument    
      
Modified:      
       
****************************************************************************************************************/      
CREATE procedure [dbo].[TT_SelectFinancialDocument]      
@FinancialDocID int,  
@DocVirtual varchar(250)    
  
AS      
 SELECT     
  FinancialDocID     
  ,@DocVirtual + '/Documents/' + FinancialDocName as DocURL    
  ,ISNULL(FinancialDocName, '')  as FinancialDocName     
  ,ISNULL(FinancialDocTitle,'') as FinancialDocTitle      
  ,ISNULL(CONVERT(varchar, FinancialDocDate, 103), '') as FinancialDocDate    
  ,CAST(ISNULL(FileSize,0) / 1024 as decimal(19,0))   as FileSize    
  ,ISNULL(Amount,0) as Amount  
  ,b.ProjectID  
  ,UploadedByUserID  
 FROM     
  TT_FinancialDocuments a     
   INNER JOIN TT_Orders b     
    ON a.OrderID = b.OrderID    
   LEFT JOIN  (SELECT  FinancialDocumentID, SUM(Amount) as Amount    
      FROM  TT_FinancialDocumentOrderItems     
      GROUP BY FinancialDocumentID) c    
    ON a.FinancialDocID = c.FinancialDocumentID    
 WHERE    
  a.FinancialDocID = @FinancialDocID  
  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectFinancialDocumentDetails]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************************   
Created by:	SD
Created on: 29/11/2011
Does:		Returns the FinancialDocument Details for the given 
			Financial Document

Modified:  

***********************************************************************/
CREATE procedure [dbo].[TT_SelectFinancialDocumentDetails]    
@FinancialDocumentID Int    

AS

SELECT
	FinancialDocID,
	a.OrderID,
	FinancialDocNo,
	FinancialDocDate,
	FinancialDocTypeId,
	FinancialDocName,
	FinancialDocTitle,
	CAST(ISNULL(FileSize,0) / 1024 as decimal(19,0)) as FileSize,
	OrderNumber
FROM
	TT_FinancialDocuments a
		INNER JOIN TT_Orders b 
			ON a.OrderID = b.OrderID
WHERE
	FinancialDocID = @FinancialDocumentID
	




GO
/****** Object:  StoredProcedure [dbo].[TT_SelectFinancialDocumentFileName]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************  
Created by: SD  
Created on: 24/11/2011  
Does:  Retrieves the Financial Document FileName based on the OrderID 
********************************************************/  
CREATE PROCEDURE [dbo].[TT_SelectFinancialDocumentFileName]
	@OrderID int,
	@DocNo varchar(50)
AS	
	
DECLARE @ProjCode varchar(10)

SELECT 
	@ProjCode = ProjectCode
FROM
	TT_Projects a
		INNER JOIN TT_Orders b ON a.ProjectID = b.ProjectID
WHERE
	OrderID = @OrderID		
		

SELECT @ProjCode + '_' + @DocNo as [FileName]



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectFinancialDocumentOrderSummaries]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************************   
Created by:	SD
Created on: 29/11/2011
Does:		Returns the FinancialDocumentOrderItem Amounts for the given 
			Financial Document

Modified:  

***********************************************************************/
Create procedure [dbo].[TT_SelectFinancialDocumentOrderSummaries]    
@ProjectID int, 
@FinancialDocumentID Int    
AS    

Select Distinct ItemName, Sum(Isnull(b.Amount,0)) as Amount, c.OrderItemID , ISNULL(InvoicedAmount,0) as InvoicedAmount
From dbo.TT_Orders a    
left join dbo.TT_ProjectOrderItems b on a.OrderID = b.OrderID    
left join dbo.TT_OrderItems c on b.OrderItemID = c.OrderItemID 
left join (	Select		OrderItemID, SUM(Amount) as InvoicedAmount
			From		TT_FinancialDocumentOrderItems a 
						inner join TT_FinancialDocuments b on a.FinancialDocumentID = b.FinancialDocID
						inner join TT_Orders c on c.OrderID = b.OrderID
			Where		b.FinancialDocID = @FinancialDocumentID 
			Group By	OrderItemID   ) d on c.OrderItemID = d.OrderItemID
Where a.OrderID in    
 (    
 Select OrderID    
 From dbo.TT_Orders    
 Where ProjectID = @ProjectID    
 and Approval = 2    
 )    
Group By ItemName, c.OrderItemID, d.InvoicedAmount    

   



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectFinancialDocuments]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /************************************************************************************************************************************************  
Created by: SD  
Created on: 29/11/2011
Used in:	Timetrax.DAL.LoadFinancialDocuments  
Does:		Retrieves a list of the documents associated withh a project.  To be bound to a datagrid so that the DocUrl can be clicked on  
  
Modified:  


************************************************************************************************************************************************/  
CREATE procedure [dbo].[TT_SelectFinancialDocuments]  
@ProjectID int,  
@DocVirtual varchar(250)  
  
AS  
  
	SELECT 
		FinancialDocID 
		,@DocVirtual + '/Documents/' + FinancialDocName as DocURL
		,ISNULL(FinancialDocName, '')  as FinancialDocName 
		,ISNULL(FinancialDocTitle,'') as FinancialDocTitle  
		,ISNULL(CONVERT(varchar, FinancialDocDate, 103), '') as FinancialDocDate
		,CAST(ISNULL(FileSize,0) / 1024 as decimal(19,0))   as FileSize
		,ISNULL(Amount,0) as Amount
	FROM 
		TT_FinancialDocuments a 
			INNER JOIN TT_Orders b 
				ON a.OrderID = b.OrderID
			LEFT JOIN  (SELECT		FinancialDocumentID, SUM(Amount) as Amount
						FROM		TT_FinancialDocumentOrderItems 
						GROUP BY	FinancialDocumentID) c
				ON a.FinancialDocID = c.FinancialDocumentID
	WHERE
		b.ProjectID = @ProjectID
	ORDER BY  
		FinancialDocDate  





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectFinancialDocumentType]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
/**********************************************************  
Created by: SD  
Created on: 02/12/2011  
Does:  Retrieves the Financial Document Type Description  

Modified:

04/01/2012 by SD: Added ApprovalRequired
**********************************************************/  
CREATE Procedure [dbo].[TT_SelectFinancialDocumentType]  
@FinancialDocTypeID int  
  
AS  
  
SELECT   
 FinancialDocType, 
 ApprovalRequired  
FROM   
 TT_FinancialDocumentType  
WHERE  
 FinancialDocTypeID = @FinancialDocTypeID  
  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectFinancialDocumentTypeWithApproval]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************
Created by:	SD
Created on:	09/01/2012
Does:		Displays Financial Document Types requiring approval
*****************************************************/
CREATE PROCEDURE [dbo].[TT_SelectFinancialDocumentTypeWithApproval]

AS

SELECT 
	FinancialDocTypeID
    ,FinancialDocType      
FROM 
	TT_FinancialDocumentType
WHERE
	ApprovalRequired = 1





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectGroup]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_SelectGroup]
AS
Select *
From dbo.Usr_GroupName
Where Enabled = 1





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectLastApprovedProjectOrder]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- This Procedure Returns the last Approved Order for a Project
CREATE procedure [dbo].[TT_SelectLastApprovedProjectOrder]
@ProjectID Int
AS
Declare @LastApprovalStage Int
Set @LastApprovalStage = (
	Select Case When PTOApprovals = 1 then 2 Else PTOApprovals End
	From dbo.TT_System
)

Select isnull(Max(OrderID),0) as OrderID
From dbo.TT_Orders
Where ProjectID = @ProjectID
And Approval = @LastApprovalStage













GO
/****** Object:  StoredProcedure [dbo].[TT_SelectLastDocumentNo]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_SelectLastDocumentNo]
@ProjectID Int
AS
	Select Max(Cast((Substring(DocumentName, (Len(DocumentName) - 6), 3)) as int)) as DocNo
	From dbo.TT_ProjectDocuments
	Where ProjectID = @ProjectID
	Group by ProjectID





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectLastFinancialDocumentNo]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************  
Created by: SD  
Created on: 14/11/2011  
Does:  Retrieves the latest document number  
********************************************************/  
CREATE procedure [dbo].[TT_SelectLastFinancialDocumentNo]    
 @OrderID Int    
 
AS  
  
 Select   
	Max(Cast((Substring(FinancialDocName, (Len(FinancialDocName) - 6), 3)) as int)) as DocNo    
 From   
	dbo.TT_FinancialDocuments    
 Where   
	OrderID = @OrderID  
 Group by   
	OrderID    
  




GO
/****** Object:  StoredProcedure [dbo].[TT_SelectLeadResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/********************************************************************
Created by:	VF
Created on:	??
Does:	Returns all users who are Team Leaders

Modified:

01/02/2010 by SD: Return only users in the Group = 3 (ie. Teamleaders) 
	instead of users in any group where GroupID >= 3.  Timetrax will now 
	allow users to be in more than one user group
********************************************************************/
CREATE procedure [dbo].[TT_SelectLeadResource]  

AS
  
SELECT 
	a.UserID, LastName + ', ' + FirstName as UserName  
FROM
	dbo.Usr_UserDetail a join  
	dbo.Usr_UserGroup b on a. UserID = b.UserID  
WHERE 
	Enabled = 1 AND
	GroupID = 3  
ORDER BY
	UserName  
  
  
  
  
  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectManagers]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_SelectManagers]
AS
Select a.UserID, (LastName + ', ' + FirstName) as UserName
From dbo.Usr_UserDetail a
Join dbo.Usr_UserGroup b on a.UserID = b.UserID
-- Managers are determined from System PTO Approver Groups
Where GroupID in 
(Select PTOApprover1Role From dbo.TT_System) 
OR GroupID in
(Select PTOApprover2Role From dbo.TT_System)









GO
/****** Object:  StoredProcedure [dbo].[TT_SelectMyProjects]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns a list of projects for the alerts screen
Used in:		Timetrax.DAL.LoadProjects

Modified:

12/07/2005 by SB:  a) Show only active projects
		      b) Filter CurrentProjects by teamleader
06/09/2005 by SD:  Only show projects where the resource is enabled
06/10/2005 by SD: Don't need to show completed projects
********************************************************************************************/
CREATE procedure [dbo].[TT_SelectMyProjects]
@UserID as Int
AS

-- Return Project Specific Data Table

	Select 
	-- Projects in Take On stage
	'MyProjects' as Message,
	'<a href=''Project\ProjectTakeOn.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'+ '&nbsp;-&nbsp;'+ ProjectName + '&nbsp;('+ c.StatusName + ')' as Detail,
	a.ProjectCode,
	a.ProjectName
	From 
	dbo.TT_Projects a join
	dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID join
	dbo.TT_Status c on b.StatusID = c.StatusID
	Where b.StatusID = 1  -- Project Take On
	and a.ProjectID in (select ProjectID From dbo.TT_FXN_UserProjects(@UserID, 1))  -- Current user is a resource for the project
	and Datediff(d, a.StartDate, getdate()) >= 0  -- SB: 12/07/2005 - Current project is active
	and Datediff(d, getdate(), a.EndDate) >= 0
Union
	Select
	-- Projects Awaiting TakeOn approval stage 
	'MyProjects' as Message,
	'<a href=''Approvals\PTO.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'+ '&nbsp;-&nbsp;'+ ProjectName + '&nbsp;('+ c.StatusName + ')' as Detail,
	a.ProjectCode,
	a.ProjectName
	From 
	dbo.TT_Projects a join
	dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID join
	dbo.TT_Status c on b.StatusID = c.StatusID
	Where b.StatusID = 2  -- PTO Awaiting Approval
	and a.ProjectID in (select ProjectID From dbo.TT_FXN_UserProjects(@UserID, 1))  -- Current user is a resource for the project
	and Datediff(d, a.StartDate, getdate()) >= 0  -- SB: 12/07/2005 - Current project is active
	and Datediff(d, getdate(), a.EndDate) >= 0
/*
Union
	Select
	-- Projects in Completed stage 
	'MyProjects' as Message,
	'<a href=''Project\ProjectInfo.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'+ '&nbsp;-&nbsp;'+ ProjectName + '&nbsp;('+ c.StatusName + ')' as Detail,
	a.ProjectCode,
	a.ProjectName
	From 
	dbo.TT_Projects a join
	dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID join
	dbo.TT_Status c on b.StatusID = c.StatusID
	Where b.StatusID = 4  -- Completed
	and a.ProjectID in (select ProjectID From dbo.TT_FXN_UserProjects(@UserID, 1))  -- Current user is a resource for the project
	and Datediff(d, a.StartDate, getdate()) >= 0  -- SB: 12/07/2005 - Current project is active
	and Datediff(d, getdate(), a.EndDate) >= 0 */
Union
	Select
	-- Projects (OverDue)
	'MyProjects' as Message,
	'<a href=''Project\ProjectInfo.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'+ '&nbsp;-&nbsp;'+ ProjectName + '&nbsp;('+ c.StatusName + ' - OverDue)' as Detail,
	a.ProjectCode,
	a.ProjectName
	From 
	dbo.TT_Projects a join
	dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID join
	dbo.TT_Status c on b.StatusID = c.StatusID
	Where b.StatusID = 3  -- In Progress
	and a.ProjectID in (
		select ProjectID 
		From dbo.TT_FXN_UserProjects(@UserID, 1)
		Where a.EndDate < GetDate()
		)  -- Current user is a resource for the project
	and Datediff(d, a.StartDate, getdate()) >= 0  -- SB: 12/07/2005 - Current project is active
	and Datediff(d, getdate(), a.EndDate) >= 0
Union
	Select
	-- Projects in Progress stage 
	'MyProjects' as Message,
	'<a href=''Project\ProjectInfo.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'+ '&nbsp;-&nbsp;'+ ProjectName + '&nbsp;('+ c.StatusName + ')' as Detail,
	a.ProjectCode,
	a.ProjectName
	From 
	dbo.TT_Projects a join
	dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID join
	dbo.TT_Status c on b.StatusID = c.StatusID
	Where b.StatusID = 3  -- In Progress
	and a.ProjectID in (
		select ProjectID 
		From dbo.TT_FXN_UserProjects(@UserID,1)
		Where a.EndDate > GetDate()
		)  -- Current user is a resource for the project
	and Datediff(d, a.StartDate, getdate()) >= 0  -- SB: 12/07/2005 - Current project is active
	and Datediff(d, getdate(), a.EndDate) >= 0
Union
	Select
	-- Projects Awaiting VO approval stage 
	'MyProjects' as Message,
	'<a href=''Approvals\VO.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'+ '&nbsp;-&nbsp;'+ ProjectName + '&nbsp;('+ c.StatusName + ')' as Detail,
	a.ProjectCode,
	a.ProjectName
	From 
	dbo.TT_Projects a join
	dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID join
	dbo.TT_Status c on b.StatusID = c.StatusID
	Where b.StatusID = 5  -- VO Awaiting Approval
	and a.ProjectID in (select ProjectID From dbo.TT_FXN_UserProjects(@UserID,1))  -- Current user is a resource for the project
	and Datediff(d, a.StartDate, getdate()) >= 0  -- SB: 12/07/2005 - Current project is active
	and Datediff(d, getdate(), a.EndDate) >= 0
Union
	Select 
	'CurrentProjects' as Message,
	'<a href=''Project\ProjectInfo.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'+ '&nbsp;-&nbsp;'+ ProjectName as Detail,
	a.ProjectCode,
	a.ProjectName
	From 
	dbo.TT_Projects a join
	dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID
	Where StatusID = 3  -- Project currently in Progress
--	and a.EndDate > GetDate()
	and a.ProjectID in (
		Select ProjectID 
		From dbo.TT_FXN_UserProjects(@UserID,1)
		Where a.EndDate > GetDate()
	)  -- Current user is a resource for the project
	and Datediff(d, a.StartDate, getdate()) >= 0  -- SB: 12/07/2005 - Current project is active
	and Datediff(d, getdate(), a.EndDate) >= 0
	and dbo.FXN_GetUserProjectRole(@UserID, a.ProjectID) = 'TeamLeader'  -- SB: 12/07/2005 - Show only projects for which you are a team leader

Order By Message, ProjectName, ProjectCode



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectOrderDetails]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**********************************************************
Created by:	VF
Created on: ???
Does:		Returns the order details for the Order Info control

Modified:

03/01/2012 by SD: Added the OrderDate
**********************************************************/
CREATE procedure [dbo].[TT_SelectOrderDetails]  
	@OrderID Int  
AS  
  
Select OrderID, OrderNumber, Convert(varchar,EndDate,103) as txtEnd, ProjectID, ISNULL(Convert(varchar,OrderDate,103),'') as txtOrderDate
From dbo.TT_Orders  
Where OrderID = @OrderID  
  
-- Return Order - OrderItems  
Select ItemID, OrderItemID, Cast(Amount as decimal(19,2)) as Amount  
From dbo.TT_ProjectOrderItems  
Where OrderID = @OrderID  
  
-- Return Orders - Tasks  
Select TaskID, TaskName, Cast(Amount as Decimal(19,2)) as Amount, Cast(Hours as Decimal(19,0)) as Hours, Billable  
From dbo.TT_ProjectTasks  
Where OrderID = @OrderID  
  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectOrderInfo]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****************************************************************
Created by:	SD
Created on:	30/11/2011
Does:		Returns the details of the order for the given
			order id
****************************************************************/
CREATE PROCEDURE [dbo].[TT_SelectOrderInfo]
@OrderID int

AS

SELECT
	OrderNumber,
	EndDate,
	Approval,
	ProjectID
FROM
	TT_Orders
WHERE 
	OrderID = @OrderID
	




GO
/****** Object:  StoredProcedure [dbo].[TT_SelectOrderItem]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************  
Created by: VF  
Created on: ??  
Does:  Retrieves a list of Order Items  
Used in: SystemAdmin.LoadDropdowns, Order.LoadDropLists  
  and now DAL.GetOrderItems  
  
Modified:  
  
SB on 01/08/2005 - Added a filter to retrieve just one Order Item 
SD on 01/02/2010 - Added the Order By Statement 
*************************************************************/  
CREATE procedure [dbo].[TT_SelectOrderItem]  
@OrderItemID int = 0  
AS  
  
SELECT  
	OrderItemID, ItemName  
FROM  
	dbo.TT_OrderItems  
WHERE  
	Enabled = 1 AND 
	(OrderItemID = @OrderItemID OR
	@OrderItemID = 0)
ORDER BY
	ItemName  
  
  
  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectOverDueTimesheets]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_SelectOverDueTimesheets]
@UserID Int
As

-- Get the Week Start Day (1:Monday,7:Sunday) from the DB
	Declare @WeekStartDay as Int
	Declare @Now as smalldatetime
	Set @Now = Getdate()
	Select @WeekStartDay = WeekStartDay from dbo.TT_System
	Set DateFirst @WeekStartDay

	Select 
	--WeekPeriod
	'<a href=''Timesheet.aspx?Date='+ Convert(varchar,TimesheetDate,101)+'''>'+ WeekPeriod + '</a>' as WeekPeriod
	From TT_FXN_TimesheetsOverdue(@UserID, @Now)
	Order By TimesheetDate desc









GO
/****** Object:  StoredProcedure [dbo].[TT_SelectProjectCode]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_SelectProjectCode]
@ProjectID Int
AS
	-- Get the Project Code
	Select ProjectCode
	From dbo.TT_Projects
	Where ProjectID = @ProjectID







GO
/****** Object:  StoredProcedure [dbo].[TT_SelectProjectCurrentOrder]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- This Procedure Returns the last Order for a Project
-- If @Approval = 0 then returns last unapproved order 
-- or last approved order if there are no unapproved orders
-- Else Returns last order in relevant approval stage
CREATE procedure [dbo].[TT_SelectProjectCurrentOrder]
@ProjID Int,
@Approval Int
AS
Declare @OrderID Int
-- Return Project - Orders
Set @OrderID = (
Select Top 1 OrderID
From dbo.TT_Orders
Where ProjectID = @ProjID
and Case When @Approval = 0 Then 0 Else Approval End = @Approval
Order by OrderID Desc)

Select OrderID, OrderNumber, Convert(varchar,EndDate,103) as txtEnd
From dbo.TT_Orders
Where OrderID = @OrderID











GO
/****** Object:  StoredProcedure [dbo].[TT_SelectProjectDocuments]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************************************************************************************************
Created by:	SD
Created on:	08/09/2005
Used in:		Timetrax.DAL.LoadProjectDocuments
Does:		Retrieves a list of the documents associated withh a project.  To be bound to a datagrid so that the DocUrl can be clicked on

Modified:

10/12/2006 by SD: Change DocUrl to be a href
************************************************************************************************************************************************/
CREATE procedure [dbo].[TT_SelectProjectDocuments]
@ProjectID int,
@DocVirtual varchar(250)

AS

Select 		isnull(DocID, 0) as DocID,
		--'javascript: openDocumentPage(''' + @DocVirtual + '/Documents/' + DocumentName + ''')' as DocURL,
		@DocVirtual + '/Documents/' + DocumentName as DocURL,
		isnull(DocumentName, '')  as DocName,
		isnull(Title,'') as Title,
		isnull(convert(varchar, DocumentDate, 103), '') as DocumentDate,
		cast(isnull(FileSize,0) / 1024 as decimal(19,0))   as DocSize,
		isnull(Who, '') as Who
From 		TT_ProjectDocuments 
Where		ProjectID = @ProjectID
Order by 	DocumentDate




GO
/****** Object:  StoredProcedure [dbo].[TT_SelectProjectListing]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /*************************************************************************************************  
Created by: VF  
Created on: ???  
Does:  Returns a list of all projects for the given team leader, client and status  
Used in:  Timetrax.DAL.LoadProjectListing  
  
Modified:  
  
05/09/2005 by SB: Changed to return just the project code as the href, if the user does not  
       have permission to fiew the Project Information Report 
03/02/2010 by SD: Return the Project Manager for the project if it has one 
*************************************************************************************************/  
CREATE procedure [dbo].[TT_SelectProjectListing]  
	@TeamLeaderID as Int,  
	@ClientID as Int,  
	@StatusID as Int,  
	@LoggedOnUser as int,
	@ManagerID as int
AS  
  
Declare @InReportRole bit  
  
--Determine if the user is in the "Project Information Report Role"  
IF ( Select  Count(*)  
 From Usr_GroupPermission a inner join  
  Usr_UserGroup b on a.GroupID = b.GroupID  
 Where  RoleID = 60  
 And b.UserID = @LoggedOnUser) > 0  
Begin  
 Select @InReportRole = 1  
End  
Else  
Begin  
 Select @InReportRole = 0  
End  
  
-- A StatusID of 0 means all Open Projects, ie Projects in status 1,2,3 and 5  
  
  Select  
   Case   
    When @inReportRole = 0 then a.ProjectCode  
   Else  
    Case  
     When b.StatusID = 1 Then '<a href=''ProjectTakeOn.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'  
     When b.StatusID = 2 Then '<a href=''..\Approvals\PTO.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'  
     When b.StatusID = 3 Then '<a href=''ProjectInfo.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'  
     When b.StatusID = 4 Then '<a href=''ProjectInfo.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'  
     When b.StatusID = 5 Then '<a href=''..\Approvals\VO.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+ a.ProjectCode +'</a>'  
    End  
   End as HRef,  
   a.ProjectName,  
   c.StatusName,  
   f.FirstName + ' ' + f.LastName as TeamLeader,  
   e.ClientName,
   h.FirstName + ' ' + h.LastName as Manager	  
  From   
  dbo.TT_Projects a  
  join dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID  
  join dbo.TT_Status c on b.StatusID = c.StatusID  
  join dbo.TT_ProjectResources d on a.ProjectID = d.ProjectID and d.TeamLeader = 1  
  join dbo.TT_Clients e on a.ClientID = e.ClientID  
  join dbo.Usr_UserDetail f on d.UserID = f.UserID  
  left join dbo.TT_ProjectResources g on (a.ProjectID = g.ProjectID and g.TSLastApprover = 1)  
  left join dbo.Usr_UserDetail h on g.UserID = h.UserID  
  Where   
  (  
   (b.StatusID <> 4 and @StatusID = 0) or (b.StatusID = @StatusID and @StatusID <> 0)  
  )  
  And Case When @ClientID = 0 Then 0 Else a.ClientID End = @ClientID  
  And Case When @TeamLeaderID = 0 Then 0 Else d.UserID End = @TeamLeaderID  
  And Case When @ManagerID = 0 Then 0 Else h.UserID End = @ManagerID  
    
  Order By ProjectName, ProjectCode  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectProjectOrders]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- Doesnt seem to be used anywhere
CREATE procedure [dbo].[TT_SelectProjectOrders]
@ProjID Int
AS
Declare @OrderID Int
-- Return Project - Orders
Set @OrderID = (
Select Top 1 OrderID
From dbo.TT_Orders
Where ProjectID = @ProjID
Order by OrderID Desc)

Select OrderID as OrdLink, OrderNumber, Convert(varchar,EndDate,103) as txtEnd
From dbo.TT_Orders
Where OrderID = @OrderID

-- Return Order - OrderItems
Select a.OrderID as OrdLink, b.OrderItemID, Cast(b.Amount as decimal(19,2)) as Amount
From dbo.TT_Orders a
left join dbo.TT_ProjectOrderItems b on a.OrderID = b.OrderID
Where a.OrderID = @OrderID

-- Return Orders - Tasks
Select a.OrderID as OrdLink, TaskID, TaskName, Cast(Amount as Decimal(19,2)) as Amount, Cast(Hours as Decimal(19,0)) as Hours, Billable
From dbo.TT_Orders a
Join dbo.TT_ProjectTasks b on a.OrderID = b.OrderID
Where a.OrderID = @OrderID











GO
/****** Object:  StoredProcedure [dbo].[TT_SelectProjectOrderSummaries]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    
-- Used by Project Info Control        
-- This Procedure returns all Approved Project Orders, seperated into 3 tables        
-- 1) Budget Summary        
-- 2) Tasks Summary        
-- 3) Orders        
--      
-- Modified:      
--      
-- 24/11/2011 by SD: Added returning OrderItemID      
-- 29/11/2011 by SD: Added returning the Invoiced Amount    
-- 03/01/2012 by SD: Added the Order Date  
CREATE procedure [dbo].[TT_SelectProjectOrderSummaries]        
@ProjID Int        
AS        
        
--Select OrderID as OrdLink, OrderNumber, Convert(varchar,EndDate,103) as txtEnd        
--From dbo.TT_Orders        
--Where OrderID = @OrderID        
        
-- Return Order - OrderItems        
Select Distinct ItemName, Sum(Isnull(b.Amount,0)) as Amount, c.OrderItemID , ISNULL(InvoicedAmount,0) as InvoicedAmount    
From dbo.TT_Orders a        
left join dbo.TT_ProjectOrderItems b on a.OrderID = b.OrderID        
left join dbo.TT_OrderItems c on b.OrderItemID = c.OrderItemID     
left join ( Select  OrderItemID, SUM(Amount) as InvoicedAmount    
   From  TT_FinancialDocumentOrderItems a     
      inner join TT_FinancialDocuments b on a.FinancialDocumentID = b.FinancialDocID    
      inner join TT_Orders c on c.OrderID = b.OrderID    
      inner join (Select * FROM TT_Approvals Where Approved = 1 and ApprovalTypeID = 6) d on d.ApprovedItemID = b.FinancialDocID    
   Where  FinancialDocTypeID = 2    
   And   c.ProjectID = @ProjID     
   Group By OrderItemID   ) d on c.OrderItemID = d.OrderItemID    
Where a.OrderID in        
 (        
 Select OrderID        
 From dbo.TT_Orders        
 Where ProjectID = @ProjID        
 and Approval = 2        
 )        
Group By ItemName, c.OrderItemID, d.InvoicedAmount        
    
        
-- Return Orders - Tasks        
Select Distinct TaskName, Sum(Isnull(Amount,0)) as Amount, Sum(Isnull(Hours,0)) as Hours        
From dbo.TT_Orders a        
Join dbo.TT_ProjectTasks b on a.OrderID = b.OrderID        
Where a.OrderID in        
 (        
 Select OrderID        
 From dbo.TT_Orders        
 Where ProjectID = @ProjID        
 and Approval = 2        
 )        
Group By TaskName        
        
-- Return Orders        
Select a.OrderID, OrderNumber, Sum(Isnull(b.Amount,0)) as Amount, Convert(varchar,EndDate,103) as txtEndDate, ISNULL(Convert(varchar,OrderDate,103),'') as txtOrderDate        
From dbo.TT_Orders a        
left join dbo.TT_ProjectOrderItems b on a.OrderID = b.OrderID        
Where ProjectID = @ProjID        
and Approval = 2        
Group By a.OrderID, OrderNumber, EndDate, OrderDate       
        
        
        



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectProjectResourceDetail]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/**************************************************************************************
Created by:	SD
Created on:	24/10/2005
Used in:		Timetrax.DAL.LoadProjectResourcesDetails
Does:		Returns a list of resources for the specified project or a list of Projects for the specified Resource
		Passing in 0 returns all for either of the parameters
**************************************************************************************/
CREATE procedure [dbo].[TT_SelectProjectResourceDetail]
@ProjectID Int,
@UserID int

AS

Select	 	a.ProjectID,
		a.UserID,
		b.ProjectCode,
		b.ProjectName,
		c.UserName,
		c.FirstName,
		c.LastName,
		a.Enabled
From 		dbo.TT_ProjectResources a
Inner Join	dbo.TT_Projects b on a.ProjectID = b.ProjectID
Inner Join	dbo.Usr_UserDetail c on a.UserID = c.UserID
Where 		(a.ProjectID = @ProjectID Or @ProjectID = 0)
And		(a.UserID = @UserID Or @UserID = 0)



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectProjectResources]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************
Created by:	VF
Created on:	???
Used in:		Timetrax.DAL.LoadProjectResources
Does:		Returns a list of resources for a project
**************************************************************************************/
CREATE procedure [dbo].[TT_SelectProjectResources]
@ProjectID Int

AS

Select *
From 	dbo.TT_ProjectResources
Where 	ProjectID = @ProjectID



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectProjects]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************************************************
Created by:	VF
Created on:	??
Does:		-- Returns a list of Projects in a particular Status,
		-- If @Status = 0 then returns all projects
Used in:		Timetrax.DAL.GetProjects

Modified:

SD: 19/10/2005 - Order by Project Name then Project Code
***********************************************************************************************/
CREATE      procedure [dbo].[TT_SelectProjects]
@Status Int
AS
	Select a.ProjectID, ProjectCode + ' - ' + ProjectName As ProjDesc
	From dbo.TT_Projects a
	Join dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID
	Where Case When @Status = 0 then 0 Else b.StatusID End = @Status
	Order By ProjectName, ProjectCode



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectPTOApprover1Role]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_SelectPTOApprover1Role]
As
Select  b.GroupID as RoleID, b.Descript as RoleName
from dbo.TT_System a
Join dbo.Usr_GroupName b on a.PTOApprover1Role = b.GroupID






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectPTOApprover2Role]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_SelectPTOApprover2Role]
As
Select  b.GroupID as RoleID, b.Descript as RoleName
from dbo.TT_System a
Join dbo.Usr_GroupName b on a.PTOApprover2Role = b.GroupID






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectPTODetails]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /***************************************************************************************************************  
Created by: VF  
Created on: ??  
Does:  Returns the Project Take On Details  
Used in:  Timetrax.DAL.LoadProjectDetails  
  
Modified:  
  
05/09/2005 by SD: Return whether the project resource is enabled or not  
09/09/2005 by SD: Return Cost Centre ID  
20/10/2005 by SD: Added Order by for Project resources  
03/02/2010 by SD: Remove TSFirstApprover column as this is always the teamleader
***************************************************************************************************************/  
CREATE Procedure [dbo].[TT_SelectPTODetails]  
@ProjID Int  
As  
  
-- Return Project Details  
Select a.* , b.ClientName, c.FirstName + ' ' + c.LastName as ContactName,  
d.FirstName + ' ' + d.LastName as AdminContactName, e.CostCentreName,  
CurrencySymbol + '(' + CurrencyName + ')' as Currency,  
Convert(varchar,StartDate,103) as txtStart ,Convert(varchar,EndDate,103) as txtEnd,  
a.CostCentreID  
From dbo.TT_Projects a  
left join dbo.TT_Clients b on a.ClientID = b.ClientID  
left join dbo.TT_Contacts c on a.ContactID = c.ContactID  
left join dbo.TT_Contacts d on a.AdminContactID = d.ContactID  
left join dbo.TT_CostCentres e on a.CostCentreID = e.CostCentreID  
left join dbo.TT_Countries f on e.CountryID = f.CountryID  
left join dbo.TT_Currencies g on f.CurrencyID = g.CurrencyID  
Where ProjectID = @ProjID  
  
-- Return Project Resources  
Select a.ResourceID,a.UserID, Cast(a.Rate as decimal(19,2)) as Rate, 
	a.FirstApprover, a.LastApprover, 
	a.TSLastApprover, 
	a.TeamLeader , b.FirstName + ' ' + b.LastName as UserName, 
	a.Enabled  
From dbo.TT_ProjectResources a  
left join dbo.Usr_UserDetail b on a.UserID = b.UserID  
Where ProjectID = @ProjID  
Order by b.LastName, b.FirstName  
  
/*  
-- Return Project Approvals  
Select ApproverID, Convert(varchar,ApprovalDate,103) as txtDate, Comment  
From dbo.TT_Approvals  
Where ApprovalTypeID = 1 --Project Take On Approvals  
and ApprovedItemID = @ProjID  
*/  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectRejectedExpenseDetails]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /***************************************************************************************************  
Created by: SD  
Created on: 10/10/2005  
Does:  Returns the Expense Details reasons for rejecting  
Used in:  Timetrax.DAL.SelectRejectedExpense  

24/02/2010 by SD - Changed to use TT_View_ApprovalDetails so that we can see who rejected the expense
***************************************************************************************************/  
CREATE procedure [dbo].[TT_SelectRejectedExpenseDetails]  
@UserID int,  
@ExpenseMonth smalldatetime  
  
AS  
  
Select   ExpenseID,   
  c.ProjectName,   
  b.ExpenseDate,  
  Quantity,   
  UnitCost,   
  Quantity * UnitCost as TotalCost,  
  b.Comment as ExpenseComment,   
  a.Comment as RejectedComment  
From   TT_View_ApprovalDetails a  
Inner Join  TT_Expenses b on a.ApprovedItemID = b.ExpenseID  
Inner Join  TT_Projects c on b.ProjectID = c.ProjectID  
Where   Approved = 0  
And   ApprovalTypeID = 3  
And   Submitted is null  
And  Datediff(d, b.ExpenseMonth, @ExpenseMonth) = 0  
And   UserID = @UserID  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectRejectedFinancialDocuments]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************
Created by:	SD
Created on:	06/01/2012
Does:		Lists the rejected Financial Documents
*****************************************************/
CREATE PROCEDURE [dbo].[TT_SelectRejectedFinancialDocuments]
@UserID int,
@DocVirtual varchar(250)

AS

SELECT
   FinancialDocID          
  ,'<a href=' + @DocVirtual + '/Documents/' + FinancialDocName + ' target="_blank">' + FinancialDocTitle + '</a>' as DocURL      
  ,ISNULL(FinancialDocName, '')  as FinancialDocName       
  ,ISNULL(FinancialDocTitle,'') as FinancialDocTitle        
  ,ISNULL(CONVERT(varchar, FinancialDocDate, 103), '') as FinancialDocDate        
  ,ISNULL(Amount,0) as Amount    
  ,b.ProjectID    
  ,UploadedByUserID
  ,d.ProjectName 
  ,Comment as RejectedComment
 FROM       
  TT_FinancialDocuments a       
   INNER JOIN TT_Orders b       
    ON a.OrderID = b.OrderID      
   LEFT JOIN  (SELECT  FinancialDocumentID, SUM(Amount) as Amount      
      FROM  TT_FinancialDocumentOrderItems       
      GROUP BY FinancialDocumentID) c      
    ON a.FinancialDocID = c.FinancialDocumentID   
   INNER JOIN TT_Projects d
    ON b.ProjectID = d.ProjectID      
   INNER JOIN (SELECT	ApprovalID, ApprovedItemID, Comment	
			   FROM		TT_Approvals
			   WHERE	Approved = 0      
			   AND		ApprovalTypeID = 6) e on a.FinancialDocID = e.ApprovedItemID

WHERE   
/*
	FinancialDocID in ( SELECT	ApprovedItemID 
						FROM	TT_Approvals       
						WHERE	Approved = 0      
						AND		ApprovalTypeID = 6)   */   
	 Submitted is null      
AND  UploadedByUserID = @UserID  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /******************************************************************************************  
Created by: VF  
Created on: ??  
Does:  Returns a list of users  
Used in:  Timetrax.DAL.LoadResourcesDS  and Timetrax.DAL.LoadResources
  
Modified:  
  
14/10/2005 by SD: Added EnabledOnly filter 
	@EnabledOnly = 
		1 = Return only enabled users  
		0 = Return all  
03/02/2010 by SD: Added ProjectID filter.  
	@ProjectID = 
		0 = show all users
		An ID = show all users not on the project - this prevents users being added to a project
				twice
******************************************************************************************/  
CREATE   procedure [dbo].[TT_SelectResource]  
	@EnabledOnly as bit,
	@ProjectID as int
AS  
  
SELECT 
	UserID, 
	LastName + ', ' + FirstName as UserName  
FROM 
	dbo.Usr_UserDetail  
WHERE 
	( (@EnabledOnly = 1 And Enabled = 1)  Or @EnabledOnly = 0) AND
	( (@ProjectID = 0) OR (UserID NOT IN  (	SELECT 
												UserID
											FROM
												TT_ProjectResources
											WHERE
												ProjectID = @ProjectID)))										
ORDER BY 
	UserName  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectStartAlerts]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  /***************************************************************************************************************        
Created by: VF        
Created on: ??        
Does:  Displays the alerts for the on the start page        
Used in:  loadAlerts on default.aspx.vb        
        
Modified:        
        
12/07/2005 by SB - Speed up the  Timesheet Specific Data Table query and return week number not user name        
11/08/2005 by SB - Remove the project information ie. over or under budget as per AdK request        
02/09/2005 by SM and SB - Fix issue of timesheets awaiting approval not showing - had to change structure of select so that it was still optimised and removed use of TT_FXN_TimesheetApproved        
05/09/2005 by SB - Change Expenses awaiting approval to work on Expense Month        
10/10/2005 by SD - Add the rejected expenses alert        
20/10/2005 by SD - Add rejected timesheet alert and made VO Approve only show on approving users alert page        
02/11/2005 by SD - Limit VO approval and Project approval  alert to only showing on the approvers alert page        
01/12/2005 by SD - Show the VO Appproval and Project Approval on both Teamleader and Approver pages        
08/05/2006 by SD - Change the order by for the Timesheet section        
04/01/2012 by SD - Added the Financial Document Approvals   
06/01/2012 by SD - Added the Financial Document Rejections         
***************************************************************************************************************/        
CREATE Procedure [dbo].[TT_SelectStartAlerts]        
@UserID as Int,        
@ApplicationPath as varchar(100)        
AS        
-- This is required for Determining Overdue Timesheets        
-- Get the Week Start Day (1:Monday,7:Sunday) from the DB        
 Declare @WeekStartDay as Int        
 Declare @Now as smalldatetime        
 Set @Now = Getdate()        
 Select @WeekStartDay = WeekStartDay from dbo.TT_System        
 Set DateFirst @WeekStartDay        
        
-- Return Users Project Specific Data Table        
-- 1.  Retrieve Project Take on awaiting approval        
Select   Message, Detail        
From   TT_FXN_PTOProjectsAwaitingApproval(@UserID)        
Where  ApproverID = @UserID        
Union        
Select   Message, Detail        
From   TT_FXN_PTOProjectsAwaitingApproval(@UserID) a        
Inner Join TT_ProjectResources b on (a.ProjectID = b.ProjectID and b.UserID = @UserID)        
Where  Teamleader = 1        
        
UNION        
        
Select   Message, Detail        
From   TT_FXN_VOAwaitingApproval(@UserID)        
Where  ApproverID = @UserID        
Union        
Select   Message, Detail        
From   TT_FXN_VOAwaitingApproval(@UserID) a        
Inner Join TT_ProjectResources b on (a.ProjectID = b.ProjectID and b.UserID = @UserID)        
Where  Teamleader = 1        
        
        
UNION        
        
--Project Take On        
Select         
 'ProjTakeOn' as Message,        
 '<a href=''Project/ProjectTakeOn.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+a.ProjectCode +'</a>'+ '&nbsp;&nbsp;'+ ProjectName as Detail        
From         
 (Select ProjectID, ProjectCode, ProjectName from TT_Projects where ProjectID in (select ProjectID From dbo.UserProjects(@UserID))) a inner join        
 dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID inner join        
 dbo.TT_ProjectResources c on (a.ProjectID = c.ProjectID and UserID = @UserID and Teamleader = 1)        
Where StatusID = 1        
        
union        
        
Select 'Expiring' as Message,        
'<a href=''Project/ProjectInfo.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+a.ProjectCode +'</a>'+ '&nbsp;&nbsp;'+ ProjectName +' expires in ' + Cast(DateDiff(Day,Getdate(),a.EndDate) as varchar) + ' days'        
as Detail        
From dbo.TT_Projects a join        
dbo.TT_ProjectStatus e on a.ProjectID = e.ProjectID        
Where StatusID = 3 and DateDiff(Day,Getdate(),a.EndDate) Between 0 and 14        
-- Amended by Vince 18/03/2005        
and dbo.FXN_GetUserProjectRole(@UserID,a.ProjectID) = 'TeamLeader'        
        
        
Select Distinct Message, Detail, UserName, WeekStart  --Timesheet approval        
From   dbo.TT_FXN_TimesheetsAwaitngApprovalForUser(@UserID, @ApplicationPath)        
        
Union        
        
Select  'TimesheetRejected' as Message,        
        '<a href=''Capture/Timesheet.aspx?Date='+ convert(varchar,WeekStartDate, 101) +'''>'+ WeekNo + ':&nbsp;&nbsp;'+ WeekPeriod +'</a>' as Detail,        
        '' as UserName,        
 WeekStartDate        
From dbo.TT_FXN_TimesheetsRejected(@UserID)        
        
Union        
        
Select Message, Detail, UserName, WeekStart        
From        
( Select  'TimesheetOverdue' as Message,        
  '<a href=''Capture/Timesheet.aspx?Date='+ Convert(varchar,a.TimesheetDate,101)+'''>'+ convert(varchar,datepart(wk,dbo.WeekStartDate(a.TimesheetDate))) + ':&nbsp;&nbsp;'+ a.WeekPeriod +'</a>' as Detail,        
  b.FirstName + ' ' + b.LastName as UserName,        
  TimesheetDate as WeekStart        
 From  dbo.TT_FXN_TimesheetsOverdue(@UserID,@Now) a join        
  dbo.Usr_UserDetail b on a.UserID = b.UserID        
 Where  a.UserID = @UserID        
) b        
Group By Message, UserName, WeekStart, Detail        
Order By Detail -- UserName, WeekStart, Detail        
        
-- Return Expense Specific Data Table        
        
--Expenses Awaiting approval        
Select  Message,         
 Detail,        
 UserName        
From TT_FXN_ExpensesAwaitngApprovalForUser(@UserID,@ApplicationPath)        
        
Union        
        
Select  Distinct 'RejectedExpense' as Message,        
 '<a href=''Capture/ExpenseRejected.aspx?ExpenseMonth='+ Convert(varchar,a.ExpenseMonth,101)+'&UserID=' +  convert(varchar(500),@UserID)  + '''>'+ DateName(month,ExpenseMonth)+ '&nbsp;'+ Cast(Year(ExpenseMonth) as varchar) +'</a>' as Detail,        
 '' as UserName        
From  TT_Expenses a        
Where   ExpenseID in ( Select ApprovedItemID from TT_Approvals         
   where Approved = 0        
   and ApprovalTypeID = 3)        
And  Submitted is null        
and  UserID = @UserID        
        
Order By UserName, Detail        
    
--Financial Documents      
Select     
 Message,    
 Detail    
From TT_FXN_FinancialDocsAwaitngApprovalForUser(@UserID,@ApplicationPath)         
UNION  
Select  Distinct 'FinDocRejected' as Message,        
 '<a href=''Capture/FinancialDocumentRejected.aspx?FinancialDocID='+ Convert(varchar,FinancialDocID) + '''>'+ FinancialDocTitle +'</a>' as Detail           
From  TT_FinancialDocuments a        
Where   FinancialDocID in ( Select ApprovedItemID from TT_Approvals         
   where Approved = 0        
   and ApprovalTypeID = 6)        
And  Submitted is null        
and  UploadedByUserID = @UserID        
Order By Detail 



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectStatus]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_SelectStatus]
AS
Select StatusID, StatusName
From dbo.TT_Status
Order By StatusName





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectSystem]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[TT_SelectSystem]
AS
Select *
From dbo.TT_System






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimeOffApprovals_ByProject]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************************************
Created by:	VF
Created on:	??
Does:		Retrieves the timeoffs awaiting approval for the given week for the specified user

Modified:

15/04/2009 by SD: Removed the checks that the timeoff must have been approved by
	the specified users (ie. and f.ApproverID = @UserID ) as if that person leaves and a 
	new person takes over the previous approvals must stay approved
*************************************************************************************/
CREATE procedure [dbo].[TT_SelectTimeOffApprovals_ByProject]  
@UserID Int,  
@StartDate SmallDateTime,  
@TimeBase Int  
AS  

-- Get the Projects that the User is an approver for  
Select Distinct 'TO' as ProjectID, 'TimeOff' as ProjectName, '2' as Approver  
From (  
 Select a.TimeOffDate  
 From TT_TimeOff a  
 left Join TT_Approvals f on a.TimeOffID = f.ApprovedItemID and f.ApprovalTypeID = 5 
--and f.ApproverID = @UserID  
 Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)  
 And Submitted is Not Null  
 And (f.Approved = 0 or f.Approved is Null)  
) a  
  
-- Get TimeOff Types  
Select Distinct 'TO' as ProjectID, a.TypeID, a.[Description] as TaskName, 'TO_' + Cast(a.TypeID as varchar) as KeyVal  
From (  
 Select a.TypeID,b.[Description]  
 From TT_TimeOff a  
 Left Join dbo.TT_TimeOffTypes b on a.TypeID = b.TypeID  
 Left Join TT_Approvals f on a.TimeOffID = f.ApprovedItemID and f.ApprovalTypeID = 5 
--and f.ApproverID = @UserID  
 Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)  
 And Submitted is Not Null  
 And (f.Approved = 0 or f.Approved is Null)  
) a  
Order By TaskName  
  
-- Get User Names  
Select Distinct 'TO' as ProjectID, a.TypeID, a.UserID, UserName, 'TO_' + Cast(a.TypeID as varchar) as KeyVal, 'TO_' + Cast(a.TypeID as varchar) + '_' + Cast(a.UserID as varchar) as KeyVal2  
From (  
 Select a.TypeID,a.UserID, g.FirstName + ' ' + g.LastName as UserName  
 From TT_TimeOff a  
 Left Join TT_Approvals f on a.TimeOffID = f.ApprovedItemID and f.ApprovalTypeID = 5 
--and f.ApproverID = @UserID  
 Left Join Usr_UserDetail g on a.UserID = g.UserID  
 Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)  
 And Submitted is Not Null  
 And (f.Approved = 0 or f.Approved is Null)  
) a  
Order By UserName  
  
-- Get All TimeOff items for Selected Week that have been submitted  
-- and are ready to be approved  
-- and have not been previously approved  
Select 'TO_' + Cast(a.TypeID as varchar) + '_' + Cast(a.UserID as varchar) as KeyVal2, 'TO' as ProjectID, a.TypeID, a.UserID, a.TimeOffID, Convert(varchar, a.TimeOffDate,6) as txtDate, isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration, isnull(
a.Comment,'') as txtComment  
From TT_TimeOff a  
Left Join TT_Approvals f on a.TimeOffID = f.ApprovedItemID and f.ApprovalTypeID = 5 
--and f.ApproverID = @UserID  
Left Join Usr_UserDetail g on a.UserID = g.UserID  
Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)  
And Submitted is Not Null  
And (f.Approved = 0 or f.Approved is Null)  
Order By a.TimeOffDate  
  



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimeOffApprovals_ByResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_SelectTimeOffApprovals_ByResource]
@UserID Int,
@StartDate SmallDateTime,
@TimeBase Int
AS

-- Get User Names
Select Distinct a.UserID, UserName
From (
	Select 'U' + Cast(a.UserID as varchar) as UserID, g.FirstName + ' ' + g.LastName as UserName
	From TT_TimeOff a
	Left Join TT_Approvals f on a.TimeOffID = f.ApprovedItemID and f.ApprovalTypeID = 5 and f.ApproverID = @UserID
	Left Join Usr_UserDetail g on a.UserID = g.UserID
	Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)
	And Submitted is Not Null
	And (f.Approved = 0 or f.Approved is Null)
) a
Order By UserName

-- Get the Projects that the User is an approver for
Select Distinct a.UserID, 'TO' as ProjectID, 'TimeOff' as ProjectName, '2' as Approver, Cast(a.UserID as varchar) + '_TO' as KeyVal
From (
	Select 'U' + Cast(a.UserID as varchar) as UserID
	From TT_TimeOff a
	Left Join TT_Approvals f on a.TimeOffID = f.ApprovedItemID and f.ApprovalTypeID = 5 and f.ApproverID = @UserID
	Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)
	And Submitted is Not Null
	And (f.Approved = 0 or f.Approved is Null)
) a

-- Get Tasks ordered by TaskName
Select Distinct a.UserID, 'TO' as ProjectID, a.TypeID as TaskID, TaskName, Cast(a.UserID as varchar) + '_TO' as KeyVal, Cast(a.UserID as varchar) + '_TO_' + Cast(a.TypeID as varchar) as KeyVal2
From (
	Select 'U' + Cast(a.UserID as varchar) as UserID,a.TypeID, b.[Description] as TaskName
	From TT_TimeOff a
	Left Join TT_Approvals f on a.TimeOffID = f.ApprovedItemID and f.ApprovalTypeID = 5 and f.ApproverID = @UserID
	Left Join TT_TimeOffTypes b on a.TypeID = b.TypeID
	Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)
	And Submitted is Not Null
	And (f.Approved = 0 or f.Approved is Null)
) a
Order By TaskName


-- Get All TimeOff items for Selected Week that have been submitted
-- and are ready to be approved
-- and have not been previously approved
Select 'U' + Cast(a.UserID as varchar) + '_TO_' + Cast(a.TypeID as varchar) as KeyVal2, 'TO' as ProjectID, a.TypeID as TaskID, a.UserID, a.TimeOffID, Convert(varchar, a.TimeOffDate,6) as txtDate, isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration, isnull(a.Comment,'') as txtComment
From TT_TimeOff a
Left Join TT_Approvals f on a.TimeOffID = f.ApprovedItemID and f.ApprovalTypeID = 5 and f.ApproverID = @UserID
Left Join Usr_UserDetail g on a.UserID = g.UserID
Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)
And Submitted is Not Null
And (f.Approved = 0 or f.Approved is Null)
Order By a.TimeOffDate









GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimeOffTypeInfo]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[TT_SelectTimeOffTypeInfo]
@TypeID int 
AS

Select *
From dbo.TT_TimeOffTypes
Where TypeID = @TypeID








GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimeOffTypes]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[TT_SelectTimeOffTypes]
@ManConst int 
AS
	If @ManConst = 1
	-- Administration
	Begin
		Select TypeID, [Description] as TypeName
		From dbo.TT_TimeOffTypes
		Order by [Description]
	End
	Else
	Begin
		Select TypeID, [Description] as TypeName
		From dbo.TT_TimeOffTypes
		Where Enabled = 1
		Order by [Description]
	End








GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimeOffTypes_AddTimeOff]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE procedure [dbo].[TT_SelectTimeOffTypes_AddTimeOff]
@UserID as Int
As

-- Get the TimeOff Types and Remove user profile types that already exist
Select Project, TypeID, Type
Into #Types
From (
	Select 'TimeOff' as Project,TypeID,[Description] as Type
	From dbo.TT_TimeOffTypes
	Where TypeID not in (
		Select TypeID
		From TT_ProfileTOTypes
		Where UserID = @UserID) 
	 	and Enabled = 1
) a
Order by Type
-- Return Tasks
select * from #Types

Drop Table #Types















GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetApprovals_ByProject]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
/*************************************************************************************    
Created by: VF    
Created on: ??    
Does:  Retrieves the timesheets awaiting approval for the given week for the specified user    
   order by project    
    
Modified:    
    
15/04/2009 by SD: Removed the checks that the timesheet must have been approved by    
 the specified users (ie. and f.ApproverID = @UserID ) as if that person leaves and a     
 new person takes over the previous approvals must stay approved    
11/05/2009 by CB: Changed the timesheet date to be retrieved as a hyperlink to link to a pop up report    
     to display resource's timesheet for the day.    
16/02/2010 by SD: Changed the stored procedure to cater for the two level approvals so only show  ApprovalStage = 1        
*************************************************************************************/    
CREATE procedure [dbo].[TT_SelectTimesheetApprovals_ByProject]     
@UserID Int,      
@StartDate SmallDateTime,      
@TimeBase Int      
AS      
      
set dateformat dmy      
      
-- Get the Projects that the User is an approver for      
Select Distinct a.ProjectID, a.ProjectName, a.Approver      
From       
(      
 Select a.*, d.ProjectID, d.ProjectName, e.Approver      
 From dbo.TT_FXN_TSApproverProjects(@UserID) e      
 Left Join dbo.TT_Projects d on e.ProjectID = d.ProjectID      
 Left Join dbo.TT_Orders c on e.ProjectID = c.ProjectID      
 Left Join dbo.TT_ProjectTasks b on c.OrderID = b.OrderID      
 Left Join dbo.TT_Timesheets a on b.TaskID = a.TaskID      
 Left Join dbo.TT_Approvals f on a.TimesheetID = f.ApprovedItemID and f.ApprovalTypeID = 2     
--and f.ApproverID = @UserID      
 Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)      
 And a.ApprovalStage = e.Approver    
 And a.ApprovalStage = 1     
 And Submitted is Not Null      
 And (f.Approved = 0 or f.Approved is Null)      
) a      
Order By a.ProjectName      
      
-- Get Tasks ordered by Project      
Select Distinct a.ProjectID, a.TaskID, TaskName, Cast(a.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal      
From (      
 Select a.*, d.ProjectID, b.TaskName      
 From dbo.TT_FXN_TSApproverProjects(@UserID) e      
 Left Join dbo.TT_Projects d on e.ProjectID = d.ProjectID      
 Left Join dbo.TT_Orders c on e.ProjectID = c.ProjectID      
 Left Join dbo.TT_ProjectTasks b on c.OrderID = b.OrderID      
 Left Join dbo.TT_Timesheets a on b.TaskID = a.TaskID      
 Left Join dbo.TT_Approvals f on a.TimesheetID = f.ApprovedItemID and f.ApprovalTypeID = 2     
--and f.ApproverID = @UserID      
 Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)      
 And a.ApprovalStage = e.Approver  
 And a.ApprovalStage = 1       
 And Submitted is Not Null      
 And (f.Approved = 0 or f.Approved is Null)      
) a      
Order By TaskName      
      
-- Get User Names      
Select Distinct a.ProjectID, a.TaskID, a.UserID, UserName, Cast(a.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal, Cast(a.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_' + Cast(a.UserID as varchar) as KeyVal2      
From (      
 Select d.ProjectID, a.*, g.FirstName + ' ' + g.LastName as UserName      
 From dbo.TT_FXN_TSApproverProjects(@UserID) e      
 Left Join dbo.TT_Projects d on e.ProjectID = d.ProjectID      
 Left Join dbo.TT_Orders c on e.ProjectID = c.ProjectID      
 Left Join dbo.TT_ProjectTasks b on c.OrderID = b.OrderID      
 Left Join dbo.TT_Timesheets a on b.TaskID = a.TaskID      
 Left Join dbo.TT_Approvals f on a.TimesheetID = f.ApprovedItemID and f.ApprovalTypeID = 2     
--and f.ApproverID = @UserID      
 Left Join Usr_UserDetail g on a.UserID = g.UserID      
 Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)      
 And a.ApprovalStage = e.Approver     
 And a.ApprovalStage = 1    
 And Submitted is Not Null      
 And (f.Approved = 0 or f.Approved is Null)      
) a      
Order By UserName      
    
-- Get All Timesheet items for Selected Week that have been submitted      
-- and are ready to be approved      
-- and which are at the correct approval stage for this approver      
-- and have not been previously approved      
Select Cast(d.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_' + Cast(a.UserID as varchar) as KeyVal2,     
 d.ProjectID, a.TaskID, a.UserID, a.TimesheetID,     
 '<a onclick=window.open(' + '''../Reports/UserActivityReportPopUp.aspx?U=' + Cast(a.UserID as varchar) + '&Date=' + Convert(varchar, a.TimesheetDate,103) + ''',''Search'',' + '''toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=700,height=475,top=25,left=25,resizable=1''); href="#">' + Convert(varchar, a.TimesheetDate,6) +  '</a>' as txtdate,    
     
 --Convert(varchar, a.TimesheetDate,6) as txtDate,      
 isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration,     
 isnull(a.Comment,'') as txtComment -- ,a.*      
 From dbo.TT_FXN_TSApproverProjects(@UserID) e      
 Left Join dbo.TT_Projects d on e.ProjectID = d.ProjectID      
 Left Join dbo.TT_Orders c on e.ProjectID = c.ProjectID      
 Left Join dbo.TT_ProjectTasks b on c.OrderID = b.OrderID      
 Left Join dbo.TT_Timesheets a on b.TaskID = a.TaskID      
 Left Join dbo.TT_Approvals f on a.TimesheetID = f.ApprovedItemID and f.ApprovalTypeID = 2     
--and f.ApproverID = @UserID      
 Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)      
 And a.ApprovalStage = e.Approver    
 And a.ApprovalStage = 1     
 And Submitted is Not Null      
 And (f.Approved = 0 or f.Approved is Null)      
Order By a.TimesheetDate      



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetApprovals_ByResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /*************************************************************************************    
Created by: VF    
Created on: ??    
Does:  Retrieves the timesheets awaiting approval for the given week for the specified user ordering    
   by resource    
    
Modified:    
11/05/2009 by CB: Changed the timesheet date to be retrieved as a hyperlink to link to a pop up report    
     to display resource's timesheet for the day.    
16/02/2010 by SD: Changed the stored procedure to cater for the two level approvals so only show  ApprovalStage = 1   
*************************************************************************************/     
CREATE procedure [dbo].[TT_SelectTimesheetApprovals_ByResource]    
@UserID Int,    
@StartDate SmallDateTime,    
@TimeBase Int    
AS    
    
-- Get User Names    
Select Distinct a.UserID, UserName    
From (    
 Select d.ProjectID, a.*, g.FirstName + ' ' + g.LastName as UserName    
 From dbo.TT_FXN_TSApproverProjects(@UserID) e    
 Left Join dbo.TT_Projects d on e.ProjectID = d.ProjectID    
 Left Join dbo.TT_Orders c on e.ProjectID = c.ProjectID    
 Left Join dbo.TT_ProjectTasks b on c.OrderID = b.OrderID    
 Left Join dbo.TT_Timesheets a on b.TaskID = a.TaskID    
 Left Join dbo.TT_Approvals f on a.TimesheetID = f.ApprovedItemID and f.ApprovalTypeID = 2 and f.ApproverID = @UserID    
 Left Join Usr_UserDetail g on a.UserID = g.UserID    
 Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)    
 And a.ApprovalStage = e.Approver    
 And a.ApprovalStage = 1    
 And Submitted is Not Null    
 And (f.Approved = 0 or f.Approved is Null)    
) a    
Order By UserName    
    
-- Get the Projects that the User is an approver for    
Select Distinct a.UserID, a.ProjectID, a.ProjectName, a.Approver, Cast(a.UserID as varchar) + '_' + Cast(a.ProjectID as varchar) as KeyVal    
From (    
 Select a.*, d.ProjectID, d.ProjectName, e.Approver    
 From dbo.TT_FXN_TSApproverProjects(@UserID) e    
 Left Join dbo.TT_Projects d on e.ProjectID = d.ProjectID    
 Left Join dbo.TT_Orders c on e.ProjectID = c.ProjectID    
 Left Join dbo.TT_ProjectTasks b on c.OrderID = b.OrderID    
 Left Join dbo.TT_Timesheets a on b.TaskID = a.TaskID    
 Left Join dbo.TT_Approvals f on a.TimesheetID = f.ApprovedItemID and f.ApprovalTypeID = 2 and f.ApproverID = @UserID    
 Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)    
 And a.ApprovalStage = e.Approver    
 And a.ApprovalStage = 1    
 And Submitted is Not Null    
 And (f.Approved = 0 or f.Approved is Null)    
) a    
Order By a.ProjectName    
    
-- Get Tasks ordered by TaskName    
Select Distinct a.UserID, a.ProjectID, a.TaskID, TaskName, Cast(a.UserID as varchar) + '_' + Cast(a.ProjectID as varchar) as KeyVal, Cast(a.UserID as varchar) + '_' + Cast(a.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal2    
From (    
 Select a.*, d.ProjectID, b.TaskName    
 From dbo.TT_FXN_TSApproverProjects(@UserID) e    
 Left Join dbo.TT_Projects d on e.ProjectID = d.ProjectID    
 Left Join dbo.TT_Orders c on e.ProjectID = c.ProjectID    
 Left Join dbo.TT_ProjectTasks b on c.OrderID = b.OrderID    
 Left Join dbo.TT_Timesheets a on b.TaskID = a.TaskID    
 Left Join dbo.TT_Approvals f on a.TimesheetID = f.ApprovedItemID and f.ApprovalTypeID = 2 and f.ApproverID = @UserID    
 Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)    
 And a.ApprovalStage = e.Approver   
 And a.ApprovalStage = 1     
 And Submitted is Not Null    
 And (f.Approved = 0 or f.Approved is Null)    
)a    
Order By TaskName    
    
    
-- Get All Timesheet items for Selected Week that have been submitted    
-- and are ready to be approved    
-- and which are at the correct approval stage for this approver    
-- and have not been previously approved    
Select Cast(a.UserID as varchar) + '_' + Cast(d.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal2, d.ProjectID, a.TaskID, a.UserID, a.TimesheetID,     
 '<a onclick=window.open(' + '''../Reports/UserActivityReportPopUp.aspx?U=' + Cast(a.UserID as varchar) + '&Date=' + Convert(varchar, a.TimesheetDate,103) + ''',''Search'',' + '''toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=700,height=475,top=25,left=25,resizable=1''); href="#">' + Convert(varchar, a.TimesheetDate,6) +  '</a>' as txtdate,    
 --Convert(varchar, a.TimesheetDate,6) as txtDate,     
 isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration, isnull(a.Comment,'') as txtComment -- ,a.*    
 From dbo.TT_FXN_TSApproverProjects(@UserID) e    
 Left Join dbo.TT_Projects d on e.ProjectID = d.ProjectID    
 Left Join dbo.TT_Orders c on e.ProjectID = c.ProjectID    
 Left Join dbo.TT_ProjectTasks b on c.OrderID = b.OrderID    
 Left Join dbo.TT_Timesheets a on b.TaskID = a.TaskID    
 Left Join dbo.TT_Approvals f on a.TimesheetID = f.ApprovedItemID and f.ApprovalTypeID = 2 and f.ApproverID = @UserID    
 Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)    
 And a.ApprovalStage = e.Approver    
 And a.ApprovalStage = 1    
 And Submitted is Not Null    
 And (f.Approved = 0 or f.Approved is Null)    
Order By a.TimesheetDate    
    
    



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetApprovalsManager_ByProject]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
                
/*************************************************************************************                
Created by: SD               
Created on: 08/02/2010                
Does:   Retrieves the timesheets awaiting approval for the given week for the specified user               
  who is a Manager (Based on TT_SelectTimesheetApprovals_ByProject)              
                
Modified:                
        
23/02/2012 by SD: Fix the join for getting the tasks so that only task that are unapproved
		are returned           
*************************************************************************************/                
CREATE procedure [dbo].[TT_SelectTimesheetApprovalsManager_ByProject]                 
@UserID Int,                  
@StartDate SmallDateTime,                  
@TimeBase Int                  
AS                  
                  
set dateformat dmy                  
                  
-- Get the Projects that the User is an approver for                  
Select Distinct Cast(c.ProjectID as varchar) + '_M' as ProjectID, c.ProjectName --, a.Approver                  
     FROM              
   TT_View_SubmittedTimesheetsUnapprovedByManager a  join                  
   dbo.Usr_UserDetail b on a.UserID = b.UserID join                
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID            
 WHERE               
  c.ProjectID in ( SELECT ProjectID                 
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                
       WHERE  Approver = 2)                
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                    
Order By c.ProjectName                  
                  
-- Get Tasks ordered by Project                  
Select Distinct Cast(c.ProjectID as varchar) + '_M' as ProjectID, c.TaskID, c.TaskName,          
  Cast(c.ProjectID as varchar) + '_' + Cast(c.TaskID as varchar) + '_M' as KeyVal                  
    FROM              
   TT_View_SubmittedTimesheetsUnapprovedByManager a  join                  
   dbo.Usr_UserDetail b on a.UserID = b.UserID join                
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID  join              
   TT_Orders e on e.ProjectID = c.ProjectID join              
   TT_ProjectTasks f on (f.OrderID = e.OrderID  and f.TaskID = a.TaskID)        
 WHERE               
  c.ProjectID in ( SELECT ProjectID                 
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                
       WHERE  Approver = 2)                  
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                 
Order By c.TaskName                  
                  
-- Get User Names                  
 Select Distinct Cast(c.ProjectID as varchar) + '_M' as ProjectID, a.TaskID, a.UserID, b.FirstName + ' ' + b.LastName UserName,           
 Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_M' as KeyVal,           
 Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_' + Cast(a.UserID as varchar) + '_M' as KeyVal2                  
 FROM              
   TT_View_SubmittedTimesheetsUnapprovedByManager a  join                  
   dbo.Usr_UserDetail b on a.UserID = b.UserID join                
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID               
 WHERE               
  c.ProjectID in ( SELECT ProjectID                 
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                
       WHERE  Approver = 2)                
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                
 Order By UserName                  
                
-- Get All Timesheet items for Selected Week that have been submitted                  
-- and are ready to be approved by the Manager (ie. already approved by the Team Leader)                 
-- and have not been previously approved                  
Select Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_' + Cast(a.UserID as varchar) + '_M'  as KeyVal2,                 
 c.ProjectID, a.TaskID, a.UserID, a.TimesheetID,                 
 '<a onclick=window.open(' + '''../Reports/UserActivityReportPopUp.aspx?U=' + Cast(a.UserID as varchar) + '&Date=' + Convert(varchar, a.TimesheetDate,103) + ''',''Search'',' + '''toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=700,height=475,top=25,left=25,resizable=1''); href="#">' + Convert(varchar, a.TimesheetDate,6) +  '</a>' as txtdate,                
                 
 isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration,                 
 isnull(a.Comment,'') as txtComment -- ,a.*                  
     FROM              
   TT_View_SubmittedTimesheetsUnapprovedByManager a  join                  
   dbo.Usr_UserDetail b on a.UserID = b.UserID join                
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID               
 WHERE               
  c.ProjectID in ( SELECT ProjectID                 
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)                
       WHERE  Approver = 2)  -- Timesheet Last approver ie. Manager               
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                     
 Order By a.TimesheetDate 
 



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetApprovalsManager_ByResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************************************      
Created by: SD     
Created on: 16/02/2010      
Does:  Retrieves the timesheets awaiting approval for the given week for the specified user ordering      
   by resource      
      
*************************************************************************************/       
CREATE procedure [dbo].[TT_SelectTimesheetApprovalsManager_ByResource]      
@UserID Int,      
@StartDate SmallDateTime,      
@TimeBase Int      
AS      
      
-- Get User Names      
 Select Distinct 'M_' + convert(varchar,a.UserID) as UserID,b.FirstName + ' ' + b.LastName as UserName      
 FROM        
   TT_View_SubmittedTimesheetsUnapprovedByManager a  join            
   dbo.Usr_UserDetail b on a.UserID = b.UserID join          
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID         
 WHERE         
  c.ProjectID in ( SELECT ProjectID           
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)          
       WHERE  Approver = 2)          
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)          
 Order By UserName       
      
-- Get the Projects that the User is an approver for      
Select Distinct 'M_' + convert(varchar,a.UserID) as UserID, c.ProjectID, c.ProjectName, 'M_' + Cast(a.UserID as varchar) + '_' + Cast(c.ProjectID as varchar) as KeyVal  , 2 as Approver    
     FROM        
   TT_View_SubmittedTimesheetsUnapprovedByManager a  join            
   dbo.Usr_UserDetail b on a.UserID = b.UserID join          
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID      
 WHERE         
  c.ProjectID in ( SELECT ProjectID           
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)          
       WHERE  Approver = 2)          
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)              
Order By c.ProjectName       
      
-- Get Tasks ordered by TaskName      
Select Distinct c.ProjectID, c.TaskID, f.TaskName,   
 'M_' + Cast(b.UserID as varchar) + '_' + Cast(c.ProjectID as varchar) as KeyVal,   
 'M_' + Cast(a.UserID as varchar) + '_' + Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal2      
    FROM        
   TT_View_SubmittedTimesheetsUnapprovedByManager a  join            
   dbo.Usr_UserDetail b on a.UserID = b.UserID join          
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID  join        
   TT_Orders e on e.ProjectID = c.ProjectID join        
   TT_ProjectTasks f on (f.OrderID = e.OrderID and f.TaskID = a.TaskID)    
 WHERE         
  c.ProjectID in ( SELECT ProjectID           
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)          
       WHERE  Approver = 2)            
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)           
Order By f.TaskName        
       
-- Get All Timesheet items for Selected Week that have been submitted            
-- and are ready to be approved by the Manager (ie. already approved by the Team Leader)           
-- and have not been previously approved            
Select     
 'M_' + Cast(a.UserID as varchar) + '_' + Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal2, c.ProjectID, a.TaskID, a.UserID, a.TimesheetID,       
 '<a onclick=window.open(' + '''../Reports/UserActivityReportPopUp.aspx?U=' + Cast(a.UserID as varchar) + '&Date=' + Convert(varchar, a.TimesheetDate,103) + ''',''Search'',' + '''toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=700,height=475,top=25,left=25,resizable=1''); href="#">' + Convert(varchar, a.TimesheetDate,6) +  '</a>' as txtdate,      
 isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration, isnull(a.Comment,'') as txtComment        
 FROM        
   TT_View_SubmittedTimesheetsUnapprovedByManager a  join            
   dbo.Usr_UserDetail b on a.UserID = b.UserID join          
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID         
 WHERE         
  c.ProjectID in ( SELECT ProjectID           
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)          
       WHERE  Approver = 2)  -- Timesheet Last approver ie. Manager         
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)               
 Order By a.TimesheetDate     
      



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetApprovalsManagerMonitor_ByProject]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

              
/*************************************************************************************              
Created by: SD             
Created on: 12/02/2010              
Does:   Retrieves the timesheets awaiting approval by the teamleader for the given week             
  for projects on which the user is a manager             
              
Modified:              
          
20/02/2012 by SD: Fix the join for getting the tasks so that only task that are unapproved
		are returned    
*************************************************************************************/              
CREATE procedure [dbo].[TT_SelectTimesheetApprovalsManagerMonitor_ByProject]               
@UserID Int,                
@StartDate SmallDateTime,                
@TimeBase Int                
AS                
                
set dateformat dmy                
                
-- Get the Projects that the User is an approver for                
Select Distinct Cast(c.ProjectID as varchar) + '_MM' as ProjectID, c.ProjectName --, a.Approver                
     FROM            
   TT_View_SubmittedTimesheetsUnapprovedByTeamleader a  join                
   dbo.Usr_UserDetail b on a.UserID = b.UserID join              
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID           
 WHERE             
  c.ProjectID in ( SELECT ProjectID               
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)              
       WHERE  Approver = 2)              
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                  
Order By c.ProjectName                
                
-- Get Tasks ordered by Project                
Select Distinct Cast(c.ProjectID as varchar) + '_MM' as ProjectID, f.TaskID, f.TaskName,         
  Cast(c.ProjectID as varchar) + '_' + Cast(f.TaskID as varchar) + '_MM' as KeyVal                
    FROM            
   TT_View_SubmittedTimesheetsUnapprovedByTeamleader a  join                
   dbo.Usr_UserDetail b on a.UserID = b.UserID join              
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID join            
   TT_Orders e on e.ProjectID = c.ProjectID join            
   TT_ProjectTasks f on (f.OrderID = e.OrderID  and f.TaskID = a.TaskID)       
 WHERE             
  c.ProjectID in ( SELECT ProjectID               
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)              
       WHERE  Approver = 2)                
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)               
Order By f.TaskName                
                
-- Get User Names                
 Select Distinct Cast(c.ProjectID as varchar) + '_MM' as ProjectID, a.TaskID, a.UserID, b.FirstName + ' ' + b.LastName as UserName,         
 Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_MM' as KeyVal,         
 Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_' + Cast(a.UserID as varchar) + '_MM' as KeyVal2                
 FROM            
   TT_View_SubmittedTimesheetsUnapprovedByTeamleader a  join                
   dbo.Usr_UserDetail b on a.UserID = b.UserID join              
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID             
 WHERE             
  c.ProjectID in ( SELECT ProjectID               
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)              
       WHERE  Approver = 2)              
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)              
 Order By UserName                
            
-- Get All Timesheet items for Selected Week that have been submitted                
-- and are ready to be approved by the Manager (ie. already approved by the Team Leader)               
-- and have not been previously approved                
Select Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_' + Cast(a.UserID as varchar) + '_MM' as KeyVal2,               
 c.ProjectID, a.TaskID, a.UserID, a.TimesheetID,               
 '<a onclick=window.open(' + '''../Reports/UserActivityReportPopUp.aspx?U=' + Cast(a.UserID as varchar) + '&Date=' + Convert(varchar, a.TimesheetDate,103) + ''',''Search'',' + '''toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=700,height=475,to
p=25,left=25,resizable=1''); href="#">' + Convert(varchar, a.TimesheetDate,6) +  '</a>' as txtdate,             
 isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration,               
 isnull(a.Comment,'') as txtComment -- ,a.*           
     FROM            
   TT_View_SubmittedTimesheetsUnapprovedByTeamleader a  join                
   dbo.Usr_UserDetail b on a.UserID = b.UserID join              
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID           
 WHERE             
  c.ProjectID in ( SELECT ProjectID               
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)              
       WHERE  Approver = 2)  -- Timesheet Last approver ie. Manager             
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                   
 Order By a.TimesheetDate   



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetApprovalsManagerMonitor_ByResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************************************    
Created by: SD   
Created on: 16/02/2010    
Does:  Retrieves the timesheets awaiting approval for by a Teamleader which the specified  
 user is a Manager on - ordered by resource  
    
*************************************************************************************/     
CREATE procedure [dbo].[TT_SelectTimesheetApprovalsManagerMonitor_ByResource]    
@UserID Int,    
@StartDate SmallDateTime,    
@TimeBase Int    
AS    
    
-- Get User Names    
 Select Distinct 'MM_' + convert(varchar,a.UserID) as UserID,b.FirstName + ' ' + b.LastName as UserName    
 FROM      
   TT_View_SubmittedTimesheetsUnapprovedByTeamLeader a  join          
   dbo.Usr_UserDetail b on a.UserID = b.UserID join        
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID       
 WHERE       
  c.ProjectID in ( SELECT ProjectID         
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)        
       WHERE  Approver = 2)        
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)        
 Order By UserName     
    
-- Get the Projects that the User is an approver for    
Select Distinct 'MM_' + convert(varchar,a.UserID)  as UserID, c.ProjectID, c.ProjectName, 'MM_' + convert(varchar,a.UserID) + '_' + Cast(c.ProjectID as varchar) as KeyVal  , 2 as Approver  
     FROM      
   TT_View_SubmittedTimesheetsUnapprovedByTeamLeader a  join          
   dbo.Usr_UserDetail b on a.UserID = b.UserID join        
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID    
 WHERE       
  c.ProjectID in ( SELECT ProjectID         
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)        
       WHERE  Approver = 2)        
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)            
Order By c.ProjectName     
    
-- Get Tasks ordered by TaskName    
Select Distinct c.ProjectID, c.TaskID, f.TaskName,   
 'MM_' + convert(varchar,a.UserID) + '_' + Cast(c.ProjectID as varchar) as KeyVal,   
 'MM_' + Cast(a.UserID as varchar) + '_' + Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal2    
    FROM      
   TT_View_SubmittedTimesheetsUnapprovedByTeamLeader a  join          
   dbo.Usr_UserDetail b on a.UserID = b.UserID join        
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID  join      
   TT_Orders e on e.ProjectID = c.ProjectID join      
   TT_ProjectTasks f on (f.OrderID = e.OrderID and f.TaskID = a.TaskID)  
 WHERE       
  c.ProjectID in ( SELECT ProjectID         
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)        
       WHERE  Approver = 2)          
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)         
Order By f.TaskName      
     
-- Get All Timesheet items for Selected Week that have been submitted          
-- and are ready to be approved by the Manager (ie. already approved by the Team Leader)         
-- and have not been previously approved          
Select   
 'MM_' + convert(varchar,a.UserID) + '_' + Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal2, c.ProjectID, a.TaskID, a.UserID, a.TimesheetID,     
 '<a onclick=window.open(' + '''../Reports/UserActivityReportPopUp.aspx?U=' + Cast(a.UserID as varchar) + '&Date=' + Convert(varchar, a.TimesheetDate,103) + ''',''Search'',' + '''toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=700,height=475,top=25,left=25,resizable=1''); href="#">' + Convert(varchar, a.TimesheetDate,6) +  '</a>' as txtdate,    
 isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration, isnull(a.Comment,'') as txtComment      
 FROM      
   TT_View_SubmittedTimesheetsUnapprovedByTeamleader a  join          
   dbo.Usr_UserDetail b on a.UserID = b.UserID join        
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID       
 WHERE       
  c.ProjectID in ( SELECT ProjectID         
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)        
       WHERE  Approver = 2)  -- Timesheet Last approver ie. Manager       
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)             
 Order By a.TimesheetDate   
    
    



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetApprovalsMD_ByProject]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

                  
/*************************************************************************************                  
Created by: SD                 
Created on: 06/02/2012  
Does:   Retrieves the timesheets awaiting approval for the given week for the specified user                 
  who is a MD (Based on TT_SelectTimesheetApprovals_ByProject)                
                  
Modified:                  
                  
*************************************************************************************/                  
CREATE procedure [dbo].[TT_SelectTimesheetApprovalsMD_ByProject]                   
@UserID Int,                    
@StartDate SmallDateTime,                    
@TimeBase Int                    
AS                    
                    
set dateformat dmy                    
                    
-- Get the Projects that the User is an approver for                    
Select Distinct Cast(c.ProjectID as varchar) + '_MD' as ProjectID, c.ProjectName --, a.Approver                    
     FROM                
   TT_View_SubmittedTimesheetsUnapprovedByMD a  join                    
   dbo.Usr_UserDetail b on a.UserID = b.UserID join                  
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID              
 WHERE                 
 @UserID IN (      
  SELECT  UserID   
  From TT_View_MDApprovers)                
 AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                      
Order By c.ProjectName                    
                    
-- Get Tasks ordered by Project                    
Select Distinct Cast(c.ProjectID as varchar) + '_MD' as ProjectID, c.TaskID, c.TaskName,            
  Cast(c.ProjectID as varchar) + '_' + Cast(c.TaskID as varchar) + '_MD' as KeyVal                    
    FROM                
   TT_View_SubmittedTimesheetsUnapprovedByMD a  join                    
   dbo.Usr_UserDetail b on a.UserID = b.UserID join                  
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID  join                
   TT_Orders e on e.ProjectID = c.ProjectID join                
   TT_ProjectTasks f on f.OrderID = e.OrderID                
 WHERE                 
   @UserID IN (      
  SELECT  UserID   
  From TT_View_MDApprovers)                    
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                   
Order By c.TaskName                    
                    
-- Get User Names                    
 Select Distinct Cast(c.ProjectID as varchar) + '_MD' as ProjectID, a.TaskID, a.UserID, b.FirstName + ' ' + b.LastName UserName,             
 Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_MD' as KeyVal,             
 Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_' + Cast(a.UserID as varchar) + '_MD' as KeyVal2                    
 FROM                
   TT_View_SubmittedTimesheetsUnapprovedByMD a  join                    
   dbo.Usr_UserDetail b on a.UserID = b.UserID join                  
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID                 
 WHERE                 
 @UserID IN (      
  SELECT  UserID   
  From TT_View_MDApprovers)                     
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                  
 Order By UserName                    
                  
-- Get All Timesheet items for Selected Week that have been submitted                    
-- and are ready to be approved by the Manager (ie. already approved by the Team Leader)                   
-- and have not been previously approved                    
Select Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) + '_' + Cast(a.UserID as varchar) + '_MD'  as KeyVal2,                   
 c.ProjectID, a.TaskID, a.UserID, a.TimesheetID,                   
 '<a onclick=window.open(' + '''../Reports/UserActivityReportPopUp.aspx?U=' + Cast(a.UserID as varchar) + '&Date=' + Convert(varchar, a.TimesheetDate,103) + ''',''Search'',' + '''toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=700,height=475,to
p=25,left=25,resizable=1''); href="#">' + Convert(varchar, a.TimesheetDate,6) +  '</a>' as txtdate,                  
                   
 isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration,                   
 isnull(a.Comment,'') as txtComment -- ,a.*                    
     FROM                
   TT_View_SubmittedTimesheetsUnapprovedByMD a  join                    
   dbo.Usr_UserDetail b on a.UserID = b.UserID join                  
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID                 
 WHERE                 
  @UserID IN (      
  SELECT  UserID   
  From TT_View_MDApprovers)     
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                       
 Order By a.TimesheetDate 



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetApprovalsMD_ByResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************************************          
Created by: SD         
Created on: 07/02/2012  
Does:  Retrieves the timesheets awaiting approval for the given week for the specified user ordering          
   by resource          
          
*************************************************************************************/           
CREATE procedure [dbo].[TT_SelectTimesheetApprovalsMD_ByResource]          
@UserID Int,          
@StartDate SmallDateTime,          
@TimeBase Int          
AS          
          
-- Get User Names          
 Select Distinct 'MD_' + convert(varchar,a.UserID) as UserID,b.FirstName + ' ' + b.LastName as UserName          
 FROM            
   TT_View_SubmittedTimesheetsUnapprovedByMD a  join                
   dbo.Usr_UserDetail b on a.UserID = b.UserID join              
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID             
 WHERE             
 @UserID IN (        
  SELECT  UserID     
  From TT_View_MDApprovers)              
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)              
 Order By UserName           
          
-- Get the Projects that the User is an approver for          
Select Distinct 'MD_' + convert(varchar,a.UserID) as UserID, c.ProjectID, c.ProjectName, 'MD_' + Cast(a.UserID as varchar) + '_' + Cast(c.ProjectID as varchar) as KeyVal  , 2 as Approver        
     FROM            
   TT_View_SubmittedTimesheetsUnapprovedByMD a  join                
   dbo.Usr_UserDetail b on a.UserID = b.UserID join              
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID          
 WHERE             
 @UserID IN (        
  SELECT  UserID     
  From TT_View_MDApprovers)               
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                  
Order By c.ProjectName           
          
-- Get Tasks ordered by TaskName          
Select Distinct c.ProjectID, c.TaskID, f.TaskName,       
 'MD_' + Cast(b.UserID as varchar) + '_' + Cast(c.ProjectID as varchar) as KeyVal,       
 'MD_' + Cast(a.UserID as varchar) + '_' + Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal2          
    FROM            
   TT_View_SubmittedTimesheetsUnapprovedByMD a  join                
   dbo.Usr_UserDetail b on a.UserID = b.UserID join              
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID  join            
   TT_Orders e on e.ProjectID = c.ProjectID join            
   TT_ProjectTasks f on (f.OrderID = e.OrderID and f.TaskID = a.TaskID)        
 WHERE             
 @UserID IN (        
  SELECT  UserID     
  From TT_View_MDApprovers)              
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)               
Order By f.TaskName            
           
-- Get All Timesheet items for Selected Week that have been submitted                
-- and are ready to be approved by the Manager (ie. already approved by the Team Leader)               
-- and have not been previously approved                
Select         
 'MD_' + Cast(a.UserID as varchar) + '_' + Cast(c.ProjectID as varchar) + '_' + Cast(a.TaskID as varchar) as KeyVal2, c.ProjectID, a.TaskID, a.UserID, a.TimesheetID,           
 '<a onclick=window.open(' + '''../Reports/UserActivityReportPopUp.aspx?U=' + Cast(a.UserID as varchar) + '&Date=' + Convert(varchar, a.TimesheetDate,103) + ''',''Search'',' + '''toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=700,height=475,to
p=25,left=25,resizable=1''); href="#">' + Convert(varchar, a.TimesheetDate,6) +  '</a>' as txtdate,          
 isNull(dbo.ConvertToHours(Duration,@TimeBase), 0) as Duration, isnull(a.Comment,'') as txtComment            
 FROM            
   TT_View_SubmittedTimesheetsUnapprovedByMD a  join                
   dbo.Usr_UserDetail b on a.UserID = b.UserID join              
   dbo.TT_View_ProjectData c on a.TaskID = c.TaskID             
 WHERE        
 @UserID IN (        
  SELECT  UserID     
  From TT_View_MDApprovers)               
  AND  a.TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)                   
 Order By a.TimesheetDate         



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetApprover]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************************    
Created by: SD    
Created on: 02/02/2010    
Does: Returns all users who belong to the user role passed in        
********************************************************************/    
CREATE procedure [dbo].[TT_SelectTimesheetApprover]      
 @ApproverRole Int      
AS      
    
SELECT     
 a.UserID, (LastName + ', ' + FirstName) as UserName      
FROM    
 dbo.Usr_UserDetail a INNER JOIN    
 dbo.Usr_UserGroup b on a.UserID = b.UserID   INNER JOIN  
 dbo.Usr_GroupPermission c  on b.GroupID = c.GroupID   
WHERE     
 --GroupID = @ApproverRole AND    
 c.RoleID = @ApproverRole AND    
 [Enabled] = 1    
ORDER BY    
 LastName





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetRejected]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_SelectTimesheetRejected]
@UserID Int,
@StartDate SmallDateTime,
@Count as Int Output
AS

Set @Count = 0

-- Check how many Timesheets have been rejected
Select @Count = Count(TimesheetDate) From TT_Timesheets 
Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)
And UserID = @UserID 
And Submitted is Null

-- Only check TimeOff Times if no Timesheets have been submitted
If @Count = 0
Begin
	Select @Count = Count(TimeOffDate) From TT_TimeOff 
	Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)
	And UserID = @UserID 
	And Submitted is Null
End

Select @Count







GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetsAwaitingApprovalForUser]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /*******************************************************************************************************************      
Created by: SD      
Created on: 07/10/2005      
Used in:  Timetrax.DAL.GetTimesheetsAwaitingApproval      
      
Modified:      
      
24/04/2006 by SD: Add the setting of the WeekStartDay     
24/02/2010 by SD: Added the Manager and Monitoring levels     
07/02/2012 by SD: Added the MD level  
*******************************************************************************************************************/      
CREATE procedure [dbo].[TT_SelectTimesheetsAwaitingApprovalForUser]      
@UserID int,      
@ApplicationPath as varchar(100)      
      
AS      
      
Declare @WeekStartDay as Int      
Select @WeekStartDay = WeekStartDay from dbo.TT_System      
Set DateFirst @WeekStartDay      
      
Select  Distinct Detail + Case Message      
        When 'TimesheetApprovalTeamLeader' then ' (Team Leader)'    
        When 'TimesheetApprovalManager' then ' (Manager)'    
        When 'TimesheetApprovalTeamLeaderMonitor' then ' (Monitoring)'    
        Else ' (MD)'  
        End as Detail    
From  TT_FXN_TimesheetsAwaitngApprovalForUser(@UserID, @ApplicationPath) 



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTimesheetSubmitted]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_SelectTimesheetSubmitted]
@UserID Int,
@StartDate SmallDateTime,
@Count as Int Output
AS

Set @Count = 0

-- Check how many Timesheets have been submitted
Select @Count = Count(TimesheetDate) From TT_Timesheets 
Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)
And UserID = @UserID 
And Submitted is Not Null

-- Only check TimeOff Times if no Timesheets have been submitted
If @Count = 0
Begin
	-- Check how many TimeOff times have been submitted
	Select @Count = Count(TimeOffDate) From TT_TimeOff 
	Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)
	And UserID = @UserID 
	And Submitted is Not Null
End

Select @Count






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTitle]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_SelectTitle]
AS
Select *
From dbo.TT_Title





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTSApprover1Role]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_SelectTSApprover1Role]
As
Select  b.GroupID as RoleID, b.Descript as RoleName
from dbo.TT_System a
Join dbo.Usr_GroupName b on a.TSApprover1Role = b.GroupID






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectTSApprover2Role]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_SelectTSApprover2Role]
As
Select  b.GroupID as RoleID, b.Descript as RoleName
from dbo.TT_System a
Join dbo.Usr_GroupName b on a.TSApprover2Role = b.GroupID






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserExpenses]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /********************************************************************************************  
Created by: VF  
Created on: ??  
Does:  Returns 3 tables  
  Table 1 =  List of User Clients  
  Table 2 = List of User Projects  
  Table 3 = List of User Expenses  
Used in:  Expenses.aspx.vb.LoadMonthExpenses  
  
Modified:  
  
02/08/2005 by SB: Return a distince list of clients for the first table  
03/08/2005 by SB: Compare StartDate to ExpenseMonth not StartDate  
11/08/2005 by SB: Added a clean up routine for the project profile table  
13/08/2005 by SB: Modify the clean up routine to also delete completed projects  
06/09/2005 by SD: Only show tasks/projects for which the user is enabled - do this as part of the clean up routine  
********************************************************************************************/  
  
CREATE procedure [dbo].[TT_SelectUserExpenses]  
@UserID Int,  
@StartDate SmallDateTime  
AS  
  
--SB: 11/08/2005 - Clean up the Project Profile table so that it doesn't contain any projects for expenses that were captured more than a month ago  
Delete  dbo.TT_ProfileProjects  
Where  UserID = @UserID  
And (ProjectID in (Select Distinct ProjectID from TT_Expenses where UserID = @UserID)  
And ProjectID in (Select Distinct ProjectID from TT_Expenses where UserID = @UserID and datediff(m, @StartDate, ExpenseDate) >= -1)  
And  ProjectID not in (Select Distinct ProjectID from TT_ProjectStatus where StatusID = 4))  
Or (ProjectID in (Select ProjectID from TT_ProjectResources where UserID = @UserID and Enabled = 0))  --Delete the project from the profile if the user is not enabled on the project  
  
  
-- Get the users Projects that have expenses for the required month (if any)  
Select  Distinct ProjectID into #Temp  
From  TT_Expenses  
Where   DateDiff(m, @StartDate, ExpenseMonth) = 0  
And  UserID = @UserID   
  
-- Add any User Projects that had expenses for the previous month (if any)  
-- that dont already exist in #Temp  
Insert into #Temp  
 (ProjectID)  
Select  Distinct ProjectID  
From  TT_Expenses  
Where  DateDiff(m, DateAdd(m,-1,@StartDate), ExpenseMonth) = 0  
And  UserID = @UserID   
And  ProjectID not in (Select ProjectID From #Temp)  
  
-- Add any User profile projects that dont already exist in #Temp  
Insert into #Temp  
(ProjectID)  
Select  ProjectID  
From  dbo.TT_ProfileProjects  
Where  UserID = @UserID  
And  ProjectID not in (Select ProjectID From #Temp)  
  
-- Return Headers and Totals  
-- Get the Project and Client Details  
Select  c.ClientID,   
 isnull(c.ClientName,'') as Client,   
 d.ProjectID,  
 Cast(c.ClientID as varchar) +'_'+ Cast(d.ProjectID as varchar) as KeyVal  
Into #Temp2  
From #Temp a  
Inner Join dbo.TT_Projects d on a.ProjectID = d.ProjectID  
Inner Join dbo.TT_Clients c on d.ClientID = c.ClientID  
Order By c.ClientName  
  
--SB: 02/08/2005 - Need to select a distinct client here.   
select  Distinct ClientID,  
 Client  
from #Temp2  
  
-- Get the Project and Client Details  
Select distinct(c.ClientID), isnull(d.ProjectName,'') as Project, d.ProjectID,  
 Cast(c.ClientID as varchar) +'_'+ Cast(d.ProjectID as varchar) as KeyVal  
Into  #Temp3  
From  #Temp a  
Inner Join dbo.TT_Projects d on a.ProjectID = d.ProjectID  
Inner Join dbo.TT_Clients c on d.ClientID = c.ClientID 
--Order By c.ClientID, d.ProjectName, d.ProjectID  
  
select * from #Temp3  
  
-- Get the expense records for the users projects for the selected month  
Select  
 a.ProjectID, b.ExpenseID,  
 Convert(varchar, b.ExpenseDate, 103) as ExpenseDate, isNull(b.Comment,'') as Comment,  
 b.ExpenseTypeID, c.[Description] as ExpenseType, isNull(b.Quantity,0) as Quantity,  
 Cast(isNull(b.UnitCost,0) as Decimal(7,2)) as Cost,   
 b.Submitted  
From  #Temp3 a  
Join  dbo.TT_Expenses b on a.ProjectID = b.ProjectID  
Inner Join TT_ExpenseTypes c on b.ExpenseTypeID = c.ExpenseTypeID  
--left Join dbo.ApprovedExpenses(0) d on b.ExpenseID = d.ExpenseId  
Where   DateDiff(m, @StartDate, ExpenseMonth) = 0  
And  b.UserID = @UserID  
Order By b.ProjectID, b.ExpenseDate  
  
Drop Table #Temp3  
Drop Table #Temp2  
Drop Table #Temp  


GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserExpensesVince]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_SelectUserExpensesVince]
@UserID Int,
@StartDate SmallDateTime
AS

-- Select The Clients for the Projects
Select Distinct c.ClientID, c.ClientName, a.ProjectID, b.ProjectName
From TT_Expenses a
Join TT_Projects b on a.ProjectID = b.ProjectID
Join TT_Clients c on b.ClientID = c.ClientID
Where Convert(varchar, ExpenseDate, 103) Between Convert(varchar, @StartDate, 103) and Convert(varchar, DateAdd(mm,1,@StartDate), 103)
And UserID = @UserID 
And Submitted is Null
Order By c.ClientName

-- Select the Expenses for each project
Select a.*
From TT_Expenses a
Join TT_Projects b on a.ProjectID = b.ProjectID
Where Convert(varchar, ExpenseDate, 103) Between Convert(varchar, @StartDate, 103) and Convert(varchar, DateAdd(mm,1,@StartDate), 103)
And UserID = @UserID 
And Submitted is Null
Order By b.ProjectName






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserGroup]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_SelectUserGroup]
@UserID Int
As

Select dbo.FXN_GetUserGroup(@UserID)





GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserProjectRate]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/***************************************************************************************
Created by: 	??
Created on:	??
Does:		Returns the user's rate for a given project

Modified:

24/04/2006 by SD:  If there is no record in the Project Resource table, default the rate to the
		      value in the Rate table
***************************************************************************************/
CREATE procedure [dbo].[TT_SelectUserProjectRate]
@UserID Int,
@ProjectID Int

AS

Declare @Rate Decimal(19,2)

Select @Rate =  Isnull(dbo.GetProjectUserRate(@UserID,@ProjectID),0) 

If @Rate = 0 
Begin

	Select 	@Rate = isnull(Rate,0)
	From 	dbo.TT_Projects a
	Join 	dbo.TT_Rates b on a.CostCentreID = b.CostCentreID

End

Select @Rate



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserProjectRole]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_SelectUserProjectRole]
@UserID Int,
@ProjectID Int
As

Select dbo.FXN_GetUserProjectRole(@UserID,@ProjectID)






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserProjects_AddProject]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**********************************************************************************************************
Created by:	VF
Created on:	???
Does:		Retrieves a list of tasks and projects that the user can capture time against
Used in:		Timetrax.Capture.AddProjects.LoadUserClients

Modified:

06/09/2005 by SD: Only show tasks/projects for which the user is enabled
19/01/2006 by SD: Use the date for the week you are trying to add the project for and not today's date
**********************************************************************************************************/
CREATE procedure [dbo].[TT_SelectUserProjects_AddProject]
@UserID as Int,
@ExpenseDate datetime

As

-- Get the users Projects
-- Which he can book expenses to (Project In Progress and Endate has not passed)
Create Table #Projects(
	ProjectID int,
	ClientID int
) ON [PRIMARY]
Insert into #Projects (ProjectID,ClientID)
(	Select 
		a.ProjectID, 
		a.ClientID 
	 From 	TT_Projects a
	 left join TT_Orders b on a.ProjectID = b.ProjectID 
 	left join TT_ProjectStatus c on a.ProjectID = c.ProjectID
	where a.ProjectID in (select ProjectID from TT_ProjectResources where UserID = @UserID and Enabled = 1)
 	-- Project is in Progress
	And c.StatusID = 3
	-- Project End Date has not passed
	--And b.EndDate > GetDate() 
	And Datediff(m, @ExpenseDate, b.EndDate) >= 0   -- The date of the expense must be in the month of the start date or after it
	And Datediff(m, @ExpenseDate, StartDate) <= 0  -- The date of the expense must be in the month of the ned date or before it
)

-- Remove user profile projects that already exist from #Projects

Select b.ClientID, isnull(b.ClientName,'') as Client,a.ProjectID,ProjectName as Project
Into #Client_Proj
From #Projects a
Left Join dbo.TT_Clients b on a.ClientID = b.ClientID
Left Join dbo.TT_Projects c on a.ProjectID = c.ProjectID
Where a.ProjectID not in (
	Select ProjectID
	From TT_ProfileProjects
	Where UserID = @UserID) 
Group By b.ClientID, b.ClientName, a.ProjectID, ProjectName

-- Return Projects
select * from #Client_Proj

-- Return Clients
Select Distinct ClientID, Client
From #Client_Proj
Group By Client, ClientID

Drop Table #Projects
Drop Table #Client_Proj




GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserProjects_AddTask]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/**********************************************************************************************************
Created by:	VF
Created on:	???
Does:		Retrieves a list of tasks and projects that the user can capture time against
Used in:		Timetrax.DAL.GetUserProjectTasks

Modified:

06/09/2005 by SD: Only show tasks/projects for which the user is enabled
21/12/2005 by SD: Use the date for the week you are trying to add the task for and not today's date
		     Also check against start date
19/01/2005 by SD: Change Tasks showing to be based on the project end date and not the VO end date
**********************************************************************************************************/
CREATE procedure [dbo].[TT_SelectUserProjects_AddTask]
@UserID as Int,
@TimesheetDate as datetime

As

-- Get the users Projects and Tasks
-- That User can book time to (Project In Progress and EndDate has not Passed)
Create Table #Tasks(
	TaskID int
) ON [PRIMARY]
Insert into #Tasks
(TaskID)
(	Select 
		a.TaskID 
	From 
		TT_ProjectTasks a left join 
		TT_Orders b on a.OrderID = b.OrderID left join 
		TT_ProjectStatus c on b.ProjectID = c.ProjectID Inner Join
		TT_Projects d on b.ProjectID = d.ProjectID
	where 
		b.ProjectID in (select ProjectID from TT_ProjectResources where UserID = @UserID and Enabled = 1)
	 -- Project is in Progress
		And c.StatusID = 3
	-- Project End Date has not passed
	--And b.EndDate > GetDate() 
		And Datediff(ww, @TimesheetDate, d.EndDate) >= 0   -- The date of the timesheet must be before the end date of the project
		And Datediff(ww, @TimesheetDate, StartDate) <= 0  -- The date of the timesheet must be after the start date of the project
)

-- Remove user profile projects that already exist from #Tasks
-- And Link Tasks to Projects
Select Project, TaskID, Task
Into #Proj_Tasks
From (
	Select isnull(d.ProjectName,'') as Project,a.TaskID,TaskName as Task
	From #Tasks a
	Left Join dbo.TT_ProjectTasks b on a.TaskID = b.TaskID
	Left Join dbo.TT_Orders c on b.OrderID = c.OrderID
	Left Join dbo.TT_Projects d on c.ProjectID = d.ProjectID
	Where a.TaskID not in (
		Select TaskID
		From TT_ProfileTasks
		Where UserID = @UserID) 
--	and a.TaskID > 20
	Group By d.ProjectName, a.TaskID, TaskName
/*
Union
	Select 'TimeOff' as Project,TypeID,[Description] as Task
	From dbo.TT_TimeOffTypes
	Where TypeID not in (
		Select TaskID
		From TT_ProfileTasks
		Where UserID = @UserID) 
 	and Enabled = 1
--		Group By a.TaskID, b.[Description]
*/
) a
-- Return Tasks
select * from #Proj_Tasks

-- Return Projects
Select Distinct Project
From #Proj_Tasks
Group By Project

Drop Table #Tasks
Drop Table #Proj_Tasks



GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserTimeSheet]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    /*******************************************************************************************    
Created by: VF    
Created on: ??    
Does:  Retrieves a list of the user's captured time as well as tasks that the user can capture against for the given date    
Used in:  Timetrax.Timesheet.aspx.vb.LoadWeekTimes    
    
Modified:    
    
13/08/2005 by SB - Only add the profile tasks if the project is not closed off and if the status is not set to complete    
15/11/2005 by SD - Return the project end date    
07/12/2005 by SD - Ensure duplicate Task ID's don't exist in #Temp    
24/02/2010 by SD - Changed to use TT_View_ApprovalDetails so that we can see who rejected the timesheet  
03/12/2012 by SD - Increased the rejection comment field as fields were being truncated
*******************************************************************************************/    
CREATE Procedure [dbo].[TT_SelectUserTimeSheet]    
@UserID as Int,    
@Date as smalldatetime,    
@TimeBase as Int    
As    
    
-- Get the Week Start Day (1:Monday,7:Sunday) from the DB    
 Declare @WeekStartDay as Int    
 Select @WeekStartDay = WeekStartDay from dbo.TT_System    
 Set DateFirst @WeekStartDay    
    
-- Get the First day of week based on input date and startday    
Declare @StartDate as smalldatetime    
Set @StartDate = dbo.WeekStartDate(@Date)    
    
-- Get the users times (if any) for the requested week    
Create Table #Temp(    
 TaskID int,    
 Day1 int,    
 Day1Comment varchar(1500),    
 Day1RejComment varchar(250),    
 Day2 int,    
 Day2Comment varchar(1500),    
 Day2RejComment varchar(250),    
 Day3 int,    
 Day3Comment varchar(1500),    
 Day3RejComment varchar(250),    
 Day4 int,    
 Day4Comment varchar(1500),    
 Day4RejComment varchar(250),    
 Day5 int,    
 Day5Comment varchar(1500),    
 Day5RejComment varchar(250),    
 Day6 int,    
 Day6Comment varchar(1500),    
 Day6RejComment varchar(250),    
 Day7 int,    
 Day7Comment varchar(1500),    
 Day7RejComment varchar(250),    
 ProjectEndDate smalldatetime    
) ON [PRIMARY]    
    
--Insert Items for each date    
--Day1    
Insert into #Temp    
(TaskID, Day1, Day1Comment, Day1RejComment, ProjectEndDate)    
(Select a.TaskID, Sum(isNull(Duration, 0)), a.Comment, b.Comment, e.EndDate    
From  TT_Timesheets a left join    
   TT_View_ApprovalDetails b on a.TimesheetID = b.ApprovedItemID and ApprovalTypeID = 2  Inner Join    
 dbo.TT_ProjectTasks c on a.TaskID = c.TaskID Inner Join    
 dbo.TT_Orders d on c.OrderID = d.OrderID Inner Join    
 dbo.TT_Projects e on d.ProjectID = e.ProjectID    
Where Convert(varchar, TimesheetDate, 103) = Convert(varchar, @StartDate, 103) and UserID = @UserID    
Group By a.TaskID, a.Comment, b.Comment, e.EndDate)    
    
--Day2    
Insert into #Temp    
(TaskID, Day2, Day2Comment, Day2RejComment, ProjectEndDate)    
(Select a.TaskID, Sum(isNull(Duration, 0)), a.Comment, b.Comment, e.EndDate    
From TT_Timesheets a left join    
 TT_View_ApprovalDetails b on a.TimesheetID = b.ApprovedItemID and ApprovalTypeID = 2  Inner Join    
 dbo.TT_ProjectTasks c on a.TaskID = c.TaskID Inner Join    
 dbo.TT_Orders d on c.OrderID = d.OrderID Inner Join    
 dbo.TT_Projects e on d.ProjectID = e.ProjectID    
Where Convert(varchar, TimesheetDate, 103) = Convert(varchar, DateAdd(Day,1,@StartDate),103) and UserID = @UserID    
Group By a.TaskID, a.Comment, b.Comment, e.EndDate)    
    
--Day3    
Insert into #Temp    
(TaskID, Day3,Day3Comment, Day3RejComment, ProjectEndDate)    
(Select a.TaskID, Sum(isNull(Duration, 0)), a.Comment, b.Comment, e.EndDate    
From TT_Timesheets a left join    
 TT_View_ApprovalDetails b on a.TimesheetID = b.ApprovedItemID and ApprovalTypeID = 2 Inner Join    
 dbo.TT_ProjectTasks c on a.TaskID = c.TaskID Inner Join    
 dbo.TT_Orders d on c.OrderID = d.OrderID Inner Join    
 dbo.TT_Projects e on d.ProjectID = e.ProjectID    
Where Convert(varchar, TimesheetDate, 103) = Convert(varchar, DateAdd(Day,2,@StartDate),103) and UserID = @UserID    
Group By a.TaskID, a.Comment, b.Comment, e.EndDate)    
    
--Day4    
Insert into #Temp    
(TaskID, Day4, Day4Comment, Day4RejComment, ProjectEndDate)    
(Select a.TaskID, Sum(isNull(Duration, 0)), a.Comment, b.Comment, e.EndDate    
From TT_Timesheets a left join    
 TT_View_ApprovalDetails b on a.TimesheetID = b.ApprovedItemID and ApprovalTypeID = 2  Inner Join    
 dbo.TT_ProjectTasks c on a.TaskID = c.TaskID Inner Join    
 dbo.TT_Orders d on c.OrderID = d.OrderID Inner Join   dbo.TT_Projects e on d.ProjectID = e.ProjectID    
Where Convert(varchar, TimesheetDate, 103) = Convert(varchar, DateAdd(Day,3,@StartDate),103) and UserID = @UserID    
Group By a.TaskID, a.Comment, b.Comment, e.EndDate)    
    
--Day5    
Insert into #Temp    
(TaskID, Day5, Day5Comment, Day5RejComment, ProjectEndDate)    
(Select a.TaskID, Sum(isNull(Duration, 0)), a.Comment, b.Comment, e.EndDate    
From TT_Timesheets a left join    
 TT_View_ApprovalDetails b on a.TimesheetID = b.ApprovedItemID and ApprovalTypeID = 2  Inner Join    
 dbo.TT_ProjectTasks c on a.TaskID = c.TaskID Inner Join    
 dbo.TT_Orders d on c.OrderID = d.OrderID Inner Join    
 dbo.TT_Projects e on d.ProjectID = e.ProjectID    
Where Convert(varchar, TimesheetDate, 103) = Convert(varchar, DateAdd(Day,4,@StartDate),103) and UserID = @UserID    
Group By a.TaskID, a.Comment, b.Comment, e.EndDate)    
    
--Day6    
Insert into #Temp    
(TaskID, Day6, Day6Comment, Day6RejComment, ProjectEndDate)    
(Select a.TaskID, Sum(isNull(Duration, 0)), a.Comment, b.Comment, e.EndDate    
From TT_Timesheets a left join    
 TT_View_ApprovalDetails b on a.TimesheetID = b.ApprovedItemID and ApprovalTypeID = 2  Inner Join    
 dbo.TT_ProjectTasks c on a.TaskID = c.TaskID Inner Join    
 dbo.TT_Orders d on c.OrderID = d.OrderID Inner Join    
 dbo.TT_Projects e on d.ProjectID = e.ProjectID    
Where Convert(varchar, TimesheetDate, 103) = Convert(varchar, DateAdd(Day,5,@StartDate),103) and UserID = @UserID    
Group By a.TaskID, a.Comment, b.Comment, e.EndDate)    
    
--Day7    
Insert into #Temp    
(TaskID, Day7, Day7Comment, Day7RejComment, ProjectEndDate)    
(Select a.TaskID, Sum(isNull(Duration, 0)), a.Comment, b.Comment, e.EndDate    
From TT_Timesheets a left join    
 TT_View_ApprovalDetails b on a.TimesheetID = b.ApprovedItemID and ApprovalTypeID = 2  Inner Join    
 dbo.TT_ProjectTasks c on a.TaskID = c.TaskID Inner Join    
 dbo.TT_Orders d on c.OrderID = d.OrderID Inner Join    
 dbo.TT_Projects e on d.ProjectID = e.ProjectID    
Where Convert(varchar, TimesheetDate, 103) = Convert(varchar, DateAdd(Day,6,@StartDate),103) and UserID = @UserID    
Group By a.TaskID, a.Comment, b.Comment, e.EndDate)    
    
-- Add any User profile projects that dont already exist in #Temp    
/*Insert into #Temp    
(TaskID)    
Select TaskID    
From dbo.TT_ProfileTasks    
Where UserID = @UserID    
And TaskID not in (Select TaskID From #Temp)*/    
--SB: 13/08/2005 - Changed to check against closed date and if the Status is not Complete    
Insert into #Temp    
(TaskID, ProjectEndDate)    
Select Distinct a.TaskID, d.EndDate    
From  dbo.TT_ProfileTasks a    
Inner Join dbo.TT_ProjectTasks b on a.TaskID = b.TaskID    
Inner Join dbo.TT_Orders c on b.OrderID = c.OrderID    
Inner Join dbo.TT_Projects d on c.ProjectID = d.ProjectID    
Inner Join dbo.TT_ProjectStatus e on d.ProjectID = e.ProjectID    
Inner Join dbo.TT_ProjectResources f on (d.ProjectID = f.ProjectID and f.UserID = @UserID)    
Where  a.UserID = @UserID    
and    DateDiff(wk, @Date, d.EndDate) >= 0    
and  e.StatusID <> 4    
and f.Enabled = 1    
and  a.TaskID not in (Select TaskID from #Temp)    
    
-- Get the users timeoff times (if any) for the requested week    
Create Table #TimeOff(    
 TypeID int,    
 Day1 int,    
 Day1Comment varchar(500),    
 Day1RejComment varchar(200),    
 Day2 int,    
 Day2Comment varchar(500),    
 Day2RejComment varchar(200),    
 Day3 int,    
 Day3Comment varchar(500),    
 Day3RejComment varchar(200),    
 Day4 int,    
 Day4Comment varchar(500),    
 Day4RejComment varchar(200),    
 Day5 int,    
 Day5Comment varchar(500),    
 Day5RejComment varchar(200),    
 Day6 int,    
 Day6Comment varchar(500),    
 Day6RejComment varchar(200),    
 Day7 int,    
 Day7Comment varchar(500),    
 Day7RejComment varchar(200)    
) ON [PRIMARY]    
    
--Insert Items for each date    
--Day1    
Insert into #TimeOff    
(TypeID, Day1, Day1Comment, Day1RejComment)    
(Select TypeID, Sum(isNull(Duration, 0)), a.Comment, b.Comment    
From TT_TimeOff a left join    
 TT_View_ApprovalDetails b on a.TimeOffID = b.ApprovedItemID and ApprovalTypeID = 5    
Where Convert(varchar, TimeOffDate, 103) = Convert(varchar, @StartDate, 103) and UserID = @UserID    
Group By TypeID, a.Comment, b.Comment)    
    
--Day2    
Insert into #TimeOff    
(TypeID, Day2, Day2Comment, Day2RejComment)    
(Select TypeID, Sum(isNull(Duration, 0)), a.Comment, b.Comment    
From TT_TimeOff a left join    
 TT_View_ApprovalDetails b on a.TimeOffID = b.ApprovedItemID and ApprovalTypeID = 5    
Where Convert(varchar, TimeOffDate, 103) = Convert(varchar, DateAdd(Day,1,@StartDate),103) and UserID = @UserID    
Group By TypeID, a.Comment, b.Comment)    
    
--Day3    
Insert into #TimeOff    
(TypeID, Day3,Day3Comment, Day3RejComment)    
(Select TypeID, Sum(isNull(Duration, 0)), a.Comment, b.Comment    
From TT_TimeOff a left join    
 TT_View_ApprovalDetails b on a.TimeOffID = b.ApprovedItemID and ApprovalTypeID = 5    
Where Convert(varchar, TimeOffDate, 103) = Convert(varchar, DateAdd(Day,2,@StartDate),103) and UserID = @UserID    
Group By TypeID, a.Comment, b.Comment)    
    
--Day4    
Insert into #TimeOff    
(TypeID, Day4, Day4Comment, Day4RejComment)    
(Select TypeID, Sum(isNull(Duration, 0)), a.Comment, b.Comment    
From TT_TimeOff a left join    
 TT_View_ApprovalDetails b on a.TimeOffID = b.ApprovedItemID and ApprovalTypeID = 5    
Where Convert(varchar, TimeOffDate, 103) = Convert(varchar, DateAdd(Day,3,@StartDate),103) and UserID = @UserID    
Group By TypeID, a.Comment, b.Comment)    
    
--Day5    
Insert into #TimeOff    
(TypeID, Day5, Day5Comment, Day5RejComment)    
(Select TypeID, Sum(isNull(Duration, 0)), a.Comment, b.Comment    
From TT_TimeOff a left join    
 TT_View_ApprovalDetails b on a.TimeOffID = b.ApprovedItemID and ApprovalTypeID = 5    
Where Convert(varchar, TimeOffDate, 103) = Convert(varchar, DateAdd(Day,4,@StartDate),103) and UserID = @UserID    
Group By TypeID, a.Comment, b.Comment)    
    
--Day6    
Insert into #TimeOff    
(TypeID, Day6, Day6Comment, Day6RejComment)    
(Select TypeID, Sum(isNull(Duration, 0)), a.Comment, b.Comment    
From TT_TimeOff a left join    
 TT_View_ApprovalDetails b on a.TimeOffID = b.ApprovedItemID and ApprovalTypeID = 5    
Where Convert(varchar, TimeOffDate, 103) = Convert(varchar, DateAdd(Day,5,@StartDate),103) and UserID = @UserID    
Group By TypeID, a.Comment, b.Comment)    
    
--Day7    
Insert into #TimeOff    
(TypeID, Day7, Day7Comment, Day7RejComment)    
(Select TypeID, Sum(isNull(Duration, 0)), a.Comment, b.Comment    
From TT_TimeOff a left join    
 TT_View_ApprovalDetails b on a.TimeOffID = b.ApprovedItemID and ApprovalTypeID = 5    
Where Convert(varchar, TimeOffDate, 103) = Convert(varchar, DateAdd(Day,6,@StartDate),103) and UserID = @UserID    
Group By TypeID, a.Comment, b.Comment)    
    
-- Add any User profile items that dont already exist in #TimeOff    
Insert into #TimeOff    
(TypeID)    
Select TypeID    
From dbo.TT_ProfileTOTypes    
Where UserID = @UserID    
And TypeID not in (Select TypeID From #TimeOff)    
    
--select * From #TimeOff    
    
-- Link #Temp Timesheet Tasks to Projects    
Select  OrderNo,Project,TaskID,Task,     
 Day1,Day1Comment ,Day1RejComment,    
 Day2,Day2Comment ,Day2RejComment,    
 Day3,Day3Comment ,Day3RejComment,    
 Day4,Day4Comment ,Day4RejComment,    
 Day5,Day5Comment ,Day5RejComment,    
 Day6,Day6Comment ,Day6RejComment,    
 Day7,Day7Comment ,Day7RejComment,    
 ProjectEndDate    
Into #Temp2    
From    
 (    
  Select '1' as OrderNo, isnull(d.ProjectName,'') as Project, a.TaskID, TaskName as Task,    
   Sum(isNull(dbo.ConvertToHours(Day1,@TimeBase), 0)) as Day1, Max(isnull(Day1Comment,'')) as Day1Comment, Max(isnull(Day1RejComment,'')) as Day1RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day2,@TimeBase), 0)) as Day2, Max(isnull(Day2Comment,'')) as Day2Comment, Max(isnull(Day2RejComment,'')) as Day2RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day3,@TimeBase), 0)) as Day3, Max(isnull(Day3Comment,'')) as Day3Comment, Max(isnull(Day3RejComment,'')) as Day3RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day4,@TimeBase), 0)) as Day4, Max(isnull(Day4Comment,'')) as Day4Comment, Max(isnull(Day4RejComment,'')) as Day4RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day5,@TimeBase), 0)) as Day5, Max(isnull(Day5Comment,'')) as Day5Comment, Max(isnull(Day5RejComment,'')) as Day5RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day6,@TimeBase), 0)) as Day6, Max(isnull(Day6Comment,'')) as Day6Comment, Max(isnull(Day6RejComment,'')) as Day6RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day7,@TimeBase), 0)) as Day7, Max(isnull(Day7Comment,'')) as Day7Comment, Max(isnull(Day7RejComment,'')) as Day7RejComment,    
   ProjectEndDate    
  From #Temp a    
  Left Join dbo.TT_ProjectTasks b on a.TaskID = b.TaskID    
  Left Join dbo.TT_Orders c on b.OrderID = c.OrderID    
  Left Join dbo.TT_Projects d on c.ProjectID = d.ProjectID    
  Group By d.ProjectName, a.TaskID, TaskName, ProjectEndDate    
 Union    
  Select '2' as OrderNo,'TimeOff' as Project,a.TypeID,b.[Description] as Task,     
   Sum(isNull(dbo.ConvertToHours(Day1,@TimeBase), 0)) as Day1, Max(isnull(Day1Comment,'')) as Day1Comment, Max(isnull(Day1RejComment,'')) as Day1RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day2,@TimeBase), 0)) as Day2, Max(isnull(Day2Comment,'')) as Day2Comment, Max(isnull(Day2RejComment,'')) as Day2RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day3,@TimeBase), 0)) as Day3, Max(isnull(Day3Comment,'')) as Day3Comment, Max(isnull(Day3RejComment,'')) as Day3RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day4,@TimeBase), 0)) as Day4, Max(isnull(Day4Comment,'')) as Day4Comment, Max(isnull(Day4RejComment,'')) as Day4RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day5,@TimeBase), 0)) as Day5, Max(isnull(Day5Comment,'')) as Day5Comment, Max(isnull(Day5RejComment,'')) as Day5RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day6,@TimeBase), 0)) as Day6, Max(isnull(Day6Comment,'')) as Day6Comment, Max(isnull(Day6RejComment,'')) as Day6RejComment,    
   Sum(isNull(dbo.ConvertToHours(Day7,@TimeBase), 0)) as Day7, Max(isnull(Day7Comment,'')) as Day7Comment, Max(isnull(Day7RejComment,'')) as Day7RejComment,    
   Null as ProjectEndDate    
  From #TimeOff a    
  Left Join dbo.TT_TimeOffTypes b on a.TypeID = b.TypeID    
  Where b.Enabled = 1    
  Group By a.TypeID, b.[Description]    
 ) a    
--Group By Project, TaskID, TaskName    
    
select * from #Temp2    
    
-- Return Project Headers and Totals    
select a.Project, Day1Tot, Day2Tot,Day3Tot, Day4Tot, Day5Tot, Day6Tot, Day7Tot, TaskTot from(    
Select Distinct Project,    
Sum(isnull(Day1,0)) as Day1Tot,     
Sum(isnull(Day2,0)) as Day2Tot,     
Sum(isnull(Day3,0)) as Day3Tot,     
Sum(isnull(Day4,0)) as Day4Tot,     
Sum(isnull(Day5,0)) as Day5Tot,     
Sum(isnull(Day6,0)) as Day6Tot,     
Sum(isnull(Day7,0)) as Day7Tot    
From #Temp2    
Group By Project    
)a left join    
(    
select Project,Day1Tot+Day2Tot+Day3Tot+Day4Tot+Day5Tot+Day6Tot+Day7Tot as TaskTot from (    
Select Distinct Project,    
Sum(isnull(Day1,0)) as Day1Tot,     
Sum(isnull(Day2,0)) as Day2Tot,     
Sum(isnull(Day3,0)) as Day3Tot,     
Sum(isnull(Day4,0)) as Day4Tot,     
Sum(isnull(Day5,0)) as Day5Tot,     
Sum(isnull(Day6,0)) as Day6Tot,     
Sum(isnull(Day7,0)) as Day7Tot    
From #Temp2    
Group By Project) b    
)b on a.project = b.project     
    
Drop Table #Temp    
Drop Table #Temp2    
    


GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserTimesheetApprovals]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_SelectUserTimesheetApprovals]
@UserID Int,
@StartDate SmallDateTime,
@Count as Int Output
AS
-- This stored procedure will return the number of items for this timesheet that have been approved

/*
		Select a.TimesheetID
		From TT_Timesheets a
		Join TT_Approvals b on a.TimesheetID = b.ApprovedItemID and b.ApprovalTypeID = 2
		Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)
		And UserID = @UserID
		Set @Count = @@RowCount 
*/

Set @Count = 0

-- Check how many Timesheets have been approved
Select @Count = Count(a.TimesheetID)
From TT_Timesheets a
Join TT_Approvals b on a.TimesheetID = b.ApprovedItemID and b.ApprovalTypeID = 2
Where TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate)
And UserID = @UserID

-- Only check TimeOff Times if no Timesheets have been approved
If @Count = 0
Begin	
	-- Check how many TimeOff times have been approved
	Select @Count = Count(a.TimeOffID)
	From TT_TimeOff a
	Join TT_Approvals b on a.TimeOffID = b.ApprovedItemID and b.ApprovalTypeID = 5
	Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)
	And UserID = @UserID
End

Select @Count






GO
/****** Object:  StoredProcedure [dbo].[TT_SelectUserTSApprovalProfile]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[TT_SelectUserTSApprovalProfile]
@UserID Int
AS
Select * From TT_ProfileTSApproval
Where UserID = @UserID




GO
/****** Object:  StoredProcedure [dbo].[TT_SelectWeekStartDate]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_SelectWeekStartDate]
@Date as smalldatetime
AS

-- Set the First day of week to Monday
-- Default DateFirst = 7
-- Monday(1) Tuesday(2) ... Sunday(7)
	Declare @WeekStartDay as Int
	Select @WeekStartDay = WeekStartDay from dbo.TT_System
	Set DATEFIRST @WeekStartDay
  Set DateFormat DMY

select Convert(varchar,dbo.WeekStartDate(@Date),103)










GO
/****** Object:  StoredProcedure [dbo].[TT_SubmitUserExpenses]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /************************************************************************************************  
Created by: VF  
Created on: ??  
Does:  Submits expenses for a given user for a given month  
Used in:  Timetrax.Expenses.aspx.vb.SubmitExpenses  
  
Modified:  
  
04/08/2005 by SB: Changed to work off ExpenseMonth   
22/02/2010 by SD: Set the approval stage as follows:  
  
 a) If this user is neither the Teamleader nor the Manager for the project, then the timesheet must be   
   submitted to the TeamLeader for approval  
  b) If this user is the Teamleader for the project then the timesheet must be submitted to the Manager  
   for approval  
     c) If this user is the Manager for the project then the timesheet must be submitted to himself (ie. the   
   Manager for approval  
************************************************************************************************/  
CREATE procedure [dbo].[TT_SubmitUserExpenses]  
@UserID Int,  
@StartDate SmallDateTime  
AS  
  
Set Dateformat dmy  
  
  
Update 
	TT_Expenses  
Set 
	Submitted = 1,  
	ApprovalStage = dbo.TT_FXN_GetExpenseApprovalStage(UserID,ProjectID)    
Where 
	Datediff(m, @StartDate, ExpenseMonth) = 0  
	And UserID = @UserID  
	And Submitted is Null  




GO
/****** Object:  StoredProcedure [dbo].[TT_SubmitUserTimeOff]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE procedure [dbo].[TT_SubmitUserTimeOff]
@UserID Int,
@StartDate SmallDateTime
AS

-- TimeOff Only gets approved By Admin Manager, so set ApprovalStage to 2
Update TT_TimeOff
Set Submitted = 1,
	ApprovalStage = 2
Where TimeOffDate Between @StartDate and DateAdd(dd,6,@StartDate)
And UserID = @UserID
And Submitted is Null

-- Check if there are any outstanding Timesheets
	Declare @WeekStartDay as Int
	Declare @Now as smalldatetime
	Set @Now = Getdate()
	Select @WeekStartDay = WeekStartDay from dbo.TT_System
	Set DateFirst @WeekStartDay

Declare @Outstanding as Int
Select @Outstanding = Count(TimesheetDate) from dbo.TT_FXN_TimesheetsOverdue(@UserID,@Now)
Where UserID = @UserID

If @Outstanding = 0
	Begin
			Update dbo.TT_ProfileUser
			Set
			LastSubDate=@StartDate
			Where UserID = @UserID
	End






GO
/****** Object:  StoredProcedure [dbo].[TT_SubmitUserTimesheet]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***************************************************************  
Created by: VF  
Created on: ??  
Does:  Submit the timesheets for the specified user for the given week  
  
Modified:  
  
15/02/2010 by SD: Set the approval stage as follows:  
  
 a) If this user is neither the Teamleader nor the Manager for the project, then the timesheet must be   
   submitted to the TeamLeader for approval  
 b) If this user is the Teamleader for the project then the timesheet must be submitted to the Manager  
   for approval  
 c) If this user is the Manager for the project then the timesheet must be submitted to the MD
***************************************************************/  
CREATE procedure [dbo].[TT_SubmitUserTimesheet]      
 @UserID Int,      
 @StartDate SmallDateTime      
AS        
     
UPDATE   
 TT_Timesheets      
SET   
 Submitted = 1,      
 --ApprovalStage = @ApprovalStage      
 ApprovalStage = dbo.TT_FXN_GetApprovalStage(UserID,TimesheetID)  
WHERE   
 TimesheetDate Between @StartDate and DateAdd(dd,6,@StartDate) AND  
 UserID = @UserID AND  
 Submitted is Null      
      
-- Check if there are any outstanding Timesheets      
Declare @WeekStartDay as Int      
Declare @Now as smalldatetime      
Set @Now = Getdate()      
Select @WeekStartDay = WeekStartDay from dbo.TT_System      
Set DateFirst @WeekStartDay      
      
Declare @Outstanding as Int      
Select @Outstanding = Count(TimesheetDate) from dbo.TT_FXN_TimesheetsOverdue(@UserID,@Now)      
Where UserID = @UserID      
      
If @Outstanding = 0      
 Begin      
   Update dbo.TT_ProfileUser      
   Set      
   LastSubDate=@StartDate      
   Where UserID = @UserID      
 End      
      
      



GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateManager]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /*****************************************************************************************************************************    
Created by:  SD    
Created on:  03/02/2010    
Does:   Changes the Manager (Timesheet second approver) of the given project    
Used in:  Timetrax.DAL.ChangeManager    

Modified:

15/02/2012 by SD: Allow the Teamleader to be the Manager as well
*****************************************************************************************************************************/    
CREATE PROCEDURE [dbo].[TT_UpdateManager]     
 @ProjectID int,    
 @UserID int,    
 @Rate float    
    
AS    
    
declare @NumApprovals int    
    
--Retrieve the number of approvals    
Select  @NumApprovals = TSApprovals    
From TT_System    
    
IF @NumApprovals > 1  
BEGIN  
  
 --Change the existing Manager to be a normal Team Member  
 UPDATE   
  TT_ProjectResources    
 SET  
  TSLastApprover = Null  
 WHERE   
  ProjectID = @ProjectID    
  
 --Check if the user is an existing resource on the project    
 IF ( SELECT count(*)    
   FROM TT_ProjectResources    
   WHERE ProjectID = @ProjectID    
   AND UserID = @UserID) = 0    
 BEGIN  
     
  --If not then add the resource    
  Exec TT_AddUpdateProjectResources null, @UserID, @ProjectID, @Rate, Null, Null, 1 , Null, 1, Null    
     
 END    
 ELSE    
 BEGIN    
   
  --Update the Project Resource to be the Manager   
  --Allow the user to be the teamleader as well so leave that setting as is
  UPDATE TT_ProjectResources    
  SET    
    --Teamleader = Null,    
    LastApprover = Null,  
    FirstApprover = Null,  
    TSLastApprover = 1,  
    Rate = @Rate   
  WHERE   
   ProjectID = @ProjectID AND   
   UserID = @UserID    
 END    
  
END --  @NumApprovals > 1  




GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateOrderApprovalStage]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_UpdateOrderApprovalStage]
@OrderID Int,
@Approval Int
AS

Update dbo.TT_Orders
Set
Approval = @Approval
Where OrderID = @OrderID










GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateProject]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_UpdateProject]
@ProjID Int,
@Code varchar(10),
@FullName varchar(50),
@Name varchar(50),
@ClientID Int,
@ContactID Int,
@AdminID Int,
@StartDate SmallDateTime,
@EndDate SmallDateTime,
@CostCentreID Int,
@Comments varchar(500),
@ErrorStatus Int Output

As
set dateformat dmy
Update dbo.TT_Projects
Set
	ProjectCode			= @Code,
	FullName				= @FullName,
	ProjectName			= @Name,
	ClientID				= @ClientID,
	ContactID				= @ContactID,
	AdminContactID	= @AdminID,
	StartDate				= @StartDate,
	EndDate					= @EndDate,
	CostCentreID		= @CostCentreID,
	Approval1				= null,
	Approval2				= null,
	Comments				= @Comments
Where ProjectID = @ProjID

Set @ErrorStatus = @@ERROR






GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateProjectEndDate]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- This procedure is called when a VO is approved by the FinalApprover
CREATE procedure [dbo].[TT_UpdateProjectEndDate]
@ProjID Int,
@EndDate SmallDateTime

As
set dateformat dmy
Update dbo.TT_Projects
Set
	EndDate					= @EndDate
Where ProjectID = @ProjID






GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateProjectStatus]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/****** Object:  Stored Procedure dbo.TT_UpdateProjectStatus    Script Date: 04/01/2005 01:38:43 PM ******/



CREATE procedure [dbo].[TT_UpdateProjectStatus]
@ProjID Int,
@StatusID Int,
@ErrorStatus Int OutPut
AS

Declare @ApprovalStage as Int


If @StatusID = 1
	-- Reset the Approval Stage to Null
	Begin
		Update dbo.TT_ProjectStatus
		Set StatusID = @StatusID,
		ApprovalStage = Null
		Where ProjectID = @ProjID
	End
Else
	Begin
		Select @ApprovalStage = ApprovalStage
		From dbo.TT_ProjectStatus
		Where ProjectID = @ProjID
		If @StatusID = 2
			-- 2=PTO Awaiting Approval
			Begin
				If @ApprovalStage = 1
					Begin
						-- Increment Approval Stage
						Set @ApprovalStage = @ApprovalStage + 1
					End
				Else
					Begin
					-- Set approvalstage to relevant start stage
					-- When 1 Approval stage then start Approver Stage is 2 otherwise it is 1
						Select @ApprovalStage = Case PTOApprovals When 1 Then 2 Else 1 End
						From dbo.TT_System
					End
			End

		Update dbo.TT_ProjectStatus
		Set StatusID = @StatusID,
		ApprovalStage = @ApprovalStage
		Where ProjectID = @ProjID
	End


If @@RowCount = 0
Begin
	Insert into dbo.TT_ProjectStatus
	(ProjectID,StatusID,ApprovalStage)
	Values
	(@ProjID,@StatusID,Null)
End

Set @ErrorStatus = @@Error












GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateSystem]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_UpdateSystem]
@PTOApprovals Int,
@TSApprovals Int,
@PTOApprover1Role Int,
@PTOApprover2Role Int,
@TSApprover1Role Int,
@TSApprover2Role Int,
@ForceTSComments bit,
@TaskOrderItem Int,
@UseWindowsAuthentication Bit,
@MonthlyReminderDay Int,
@WeeklyReminderMeridian Bit,
@WeeklyReminderHour Int,
@WeeklyReminderDOW Int,
@WeeklyReminderEnabled Bit,
@WeekStartDay Int,
@ErrorStatus Int Output

As
Update dbo.TT_System
Set
PTOApprovals = @PTOApprovals,
TSApprovals = @TSApprovals,
PTOApprover1Role = @PTOApprover1Role,
PTOApprover2Role = @PTOApprover2Role,
TSApprover1Role = @TSApprover1Role,
TSApprover2Role = @TSApprover2Role,
ForceTSComments = @ForceTSComments,
TaskOrderItem = @TaskOrderItem,
UseWindowsAuthentication = @UseWindowsAuthentication,
MonthlyReminderDay = @MonthlyReminderDay,
WeeklyReminderMeridian = @WeeklyReminderMeridian,
WeeklyReminderHour = @WeeklyReminderHour,
WeeklyReminderDOW = @WeeklyReminderDOW,
WeeklyReminderEnabled = @WeeklyReminderEnabled,
WeekStartDay = @WeekStartDay

Set @ErrorStatus = @@ERROR









GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateTeamLeader]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /*****************************************************************************************************************************    
Created by: SD    
Created on: 09/09/2005    
Does:  Changes the Teamleader of the given project    
Used in:  Timetrax.DAL.ChangeTeamLeader    
    
Modified:    
    
25/10/2005 by SD: Need to set the TSFirstApprover and TSLastApprover in the update as well as the add    
03/02/2020 by SD: Remove the logic for TSFirstApprover and TSLastApprover as the front end only allows  
  for a user to be once on a project and those columns have now been deleted from the System table  
  as it works off the Roles in Usr_RoleName where RoleID = 7 or 69
15/02/2012 by SD: Allow the Teamleader to be the Manager as well  
*****************************************************************************************************************************/    
CREATE PROCEDURE [dbo].[TT_UpdateTeamLeader]     
 @ProjectID int,    
 @UserID int,    
 @Rate float    
    
AS    
  
 --Change the existing Team Leader to be a normal Team Member  
 UPDATE   
  TT_ProjectResources    
 SET  
  TeamLeader = Null  
 WHERE   
  ProjectID = @ProjectID    
    
 --Check if the user is an existing resource on the project    
 IF ( SELECT count(*)    
   FROM TT_ProjectResources    
   WHERE ProjectID = @ProjectID    
   AND UserID = @UserID) = 0    
 BEGIN  
     
  --If not then add the resource    
  Exec TT_AddUpdateProjectResources null, @UserID, @ProjectID, @Rate, Null, Null, Null , 1, 1, Null    
     
 END    
 ELSE    
 BEGIN    
   
  --Update the Project Resource to be the Team Leader   
  --Allow the user to be the Manager (TS Last Approver) as well so leave that setting as is
  UPDATE TT_ProjectResources    
  SET    
    Teamleader = 1,    
    LastApprover = Null,  
    FirstApprover = Null,  
    --TSLastApprover = Null,  
    Rate = @Rate  
  WHERE   
   ProjectID = @ProjectID AND   
   UserID = @UserID    
 END    
   
/* 03/02/2010 - Backup of the stored proc before the changes  
   
declare @TeamLeaderRoleID as int    
declare @TSApprover1RoleID as int    
declare @TSApprover2RoleID as int    
declare @IsTSApprover1 bit    
declare @IsTSApprover2 bit    
declare @NumApprovals int    
    
    
--Note: this logic is taken from Vince's logic in Timetrax.ProjectTakeOn.ProcessProjectResources     
    
--Retrieve the number of approvals    
Select  @NumApprovals = TSApprovals    
From TT_System    
    
--Retrieve the team leader, TSApprover1 and TSApprover2 roles from the DB    
Select @TeamLeaderRoleID = dbo.TT_FXN_GetTeamLeaderRole()    
Select @TSApprover1RoleID = dbo.TT_FXN_GetTSApprover1RoleID()    
Select @TSApprover2RoleID = dbo.TT_FXN_GetTSApprover2RoleID()    
    
If @TSApprover2RoleID = @TeamLeaderRoleID     
Begin    
 If @NumApprovals > 1 --Check that there is a second approval before setting it    
 Begin    
  -- This resource is also the First Timesheet Expense Approver)    
  Select @IsTSApprover2 = 1    
 End    
 Else    
 Begin    
  Select @IsTSApprover2 = null    
 End    
End    
Else    
Begin    
 Select @IsTSApprover2 = null    
End     
    
If @TSApprover1RoleID = @TeamLeaderRoleID     
Begin    
 -- This resource is also the Final Timesheet Expense Approver)    
 Select @IsTSApprover1 = 1    
End    
Else    
Begin    
        Select @IsTSApprover1 = null    
End     
    
    
--Remove the existing teamleader role from the project - as per discussion with AdK the resource can be deleted    
Delete TT_ProjectResources    
Where ProjectID = @ProjectID    
And TeamLeader = 1    
    
--Check if the user is an existing resource on the project    
If ( Select  count(*)    
 From  TT_ProjectResources    
 Where ProjectID = @ProjectID    
 And UserID = @UserID) = 0    
Begin    
    
 --If not then add the resource    
 Exec TT_AddUpdateProjectResources null, @UserID, @ProjectID, @Rate, Null, Null, @IsTSApprover2, @IsTSApprover1, 1, 1, Null    
    
end    
else    
Begin    
 --Update the Project Resource to be the team leader    
 Update  TT_ProjectResources    
 Set Teamleader = 1,    
  TSFirstApprover = @IsTSApprover2,    
  TSLastApprover = @IsTSApprover1    
 Where ProjectID = @ProjectID    
 And UserID = @UserID    
end    
  
*/  




GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateUserExpense]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************
Created by:	VF
Created on:	???
Does:		Either inserts a new expense or updates an existing expense
Used in:		Expenses.aspx.vb.ProcessExpenses

Modified:

02/08/2005 by SB - Added extra parameter ExpenseMonth
***************************************************************************************************************/
CREATE procedure [dbo].[TT_UpdateUserExpense]
@ExpenseID Int,
@UserID Int,
@ProjectID Int,
@ExpenseTypeID Int,
@ExpenseDate SmallDateTime,
@Quantity float,
@Cost float,
@Comment varchar(200),
@ExpenseMonth smalldatetime
AS

-- If ExpenseID is 0 then Insert the Expense
-- Otherwise update the existing expense
If @ExpenseID = 0
	Begin
		-- Insert
		Insert Into dbo.TT_Expenses
		(UserID, ProjectID, ExpenseTypeID, ExpenseDate, Quantity, UnitCost, Comment, Submitted, ApprovalStage, ExpenseMonth)
		Values
		(@UserID, @ProjectID, @ExpenseTypeID, @ExpenseDate, @Quantity, @Cost, @Comment, Null, Null, @ExpenseMonth)
	End
Else
	Begin
		Update dbo.TT_Expenses
		Set 
		ExpenseTypeID = @ExpenseTypeID,
 		ExpenseDate = @ExpenseDate,
		Quantity = @Quantity, 
		UnitCost = @Cost, 
		Comment = @Comment,
		-- If Date or Qty or Cost or comments have changed then resubmit the item for approval
		Submitted = Case When ExpenseDate != @ExpenseDate or Quantity != @Quantity or UnitCost != @Cost or Comment != @Comment Then
			Null
		Else
			Submitted
		End,
		ApprovalStage = Case When ExpenseDate != @ExpenseDate or Quantity != @Quantity or UnitCost != @Cost or Comment != @Comment Then
			Null
		Else
			ApprovalStage
		End,
		ExpenseMonth = @ExpenseMonth
		Where UserID = @UserID and ExpenseID = @ExpenseID
	End



GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateUserTimeOff]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE procedure [dbo].[TT_UpdateUserTimeOff]
@UserID Int,
@TimeBase Int,
@TypeID Int,
@ForDate SmallDateTime,
@Hours float,
@Comment varchar(500)
AS

Declare @TimeOffID int
Set @TimeOffID = 0
-- If Hours is zero then dont store the value in the DB, 
-- Try delete the record in case the record was in the db but is being updated to 0
-- Convert the Hours from the timesheet into minutes to be stored on the DB
If @Hours = 0
	Begin
		Delete From dbo.TT_TimeOff
		Where UserID = @UserID and TypeID = @TypeID and TimeOffDate = @ForDate
	End
Else
	Begin
		Declare @Duration Int
		Select @Duration = dbo.ConvertToMinutes(@Hours,@TimeBase)

		-- Try
		-- Update
		Update dbo.TT_TimeOff
		Set 
			Duration = @Duration,
			Comment = @Comment
/*
,
-- Not sure why I need to do this as in order to update any timesheet values 
-- Submitted and Approval stage must be Null so this seems irrelevant
-- Removed on 23 May 2005 as I suspect this may be the cause of submitted timesheets coming back
			Comment = @Comment,
			-- If Duration or comments have changed then resubmit all days for this Task
			@TimeOffID = Case When Duration != @Duration or Comment != @Comment Then
				TimeOffID
			Else
				0
			End
*/
		Where UserID = @UserID and TypeID = @TypeID and TimeOffDate = @ForDate
		If @@ROWCOUNT = 0
		Begin
		-- If Fails
			-- Insert
			Insert Into dbo.TT_TimeOff
			(UserID, TypeID, TimeOffDate, Duration, Comment, Submitted, ApprovalStage)
			Values
			(@UserID, @TypeID, @ForDate, @Duration, @Comment, null, null)
		End
	End	
/*
-- Removed on 23 May 2005 as I suspect this may be the cause of submitted timesheets coming back
-- See note above

-- If Duration or comments have changed then resubmit all days for this Type
If @TimeOffID > 0
Begin
	Exec TT_RejectItem @TimeOffID, 5
End
*/



GO
/****** Object:  StoredProcedure [dbo].[TT_UpdateUserTimeSheet]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  /*********************************************************************************  
Created by: VF  
Created on: ??  
Does:  Either updates or inserts a user's timesheet entry  
  
Modified:  
  
27/11/2006 by SD: Changed so that rejected timesheets always cause an alert on the approving users  
   home page.  This is done by deleting the approval recorded on updating a timesheet  
   where it is not submitted  
16/02/2010 by SD: Changed the stored procedure to unsubmit a timesheet if the time has changed.
*********************************************************************************/  
CREATE procedure [dbo].[TT_UpdateUserTimeSheet]  
 @UserID Int,  
 @TimeBase Int,  
 @TaskID Int,  
 @ForDate SmallDateTime,  
 @Hours float,  
 @Comment varchar(1500)  
AS  
  
Declare @TimeSheetID int  
Declare @Submitted bit 
Declare @OrigDuration float 
  
Set @TimeSheetID = 0  
-- If Hours is zero then dont store the value in the DB,   
-- Try delete the record in case the record was in the db but is being updated to 0  
-- Convert the Hours from the timesheet into minutes to be stored on the DB  
If @Hours = 0  
Begin 
	--Delete 
	Delete From dbo.TT_Timesheets  
	Where UserID = @UserID and TaskID = @TaskID and TimesheetDate = @ForDate  
End  
Else  
Begin  
	--Insert/Update

	Declare @Duration Int  
	Select @Duration = dbo.ConvertToMinutes(@Hours,@TimeBase)  
	
	--Determine if this is an existing record or not by selecting the TimesheetID
	Select 
		@TimesheetID = TimesheetID,
		@OrigDuration = Duration,
		@Submitted = Submitted
	From 
		TT_Timesheets  
	Where 
		UserID = @UserID and 
		TaskID = @TaskID and 
		TimesheetDate = @ForDate  
	
	--Determine if this is an existing record or not
	If (@TimesheetID > 0)
	Begin  
		--Exists so update

		Update dbo.TT_Timesheets  
		Set   
			Duration = @Duration,  
			Comment = @Comment    
		Where 
			TimesheetID = @TimesheetID
			 
	   --Delete the approval record, if it exists and this item is not submitted (ie. has been rejected).   
	   --This is so that if an entry has been rejected in the past it is now submitted again  
	   If @Submitted Is Null  
	   Begin  
			Delete 
				TT_Approvals  
			Where 
				ApprovedItemID = @TimeSheetID And  
				ApprovalTypeID = 2  
	   End 
	   
	   --Check if the time has changed.  If it has the record must be unsubmitted 
	   --and existing approvals deleted 
	   If (@OrigDuration <> @Duration)
	   Begin
	   
			--Unsubmit the timesheet
			Update 
				dbo.TT_Timesheets  
			Set   
				Submitted = Null,
				ApprovalStage = Null
			Where 
				TimesheetID = @TimesheetID
			
			--Delete any existing approval records	
			Delete 
				TT_Approvals  
			Where 
				ApprovedItemID = @TimeSheetID And  
				ApprovalTypeID = 2  
	   End
  
	End
	Else
	Begin  
	
		--Doesn't exist so insert
		Insert Into dbo.TT_Timesheets  
			(UserID, TaskID, TimesheetDate, Duration, Comment, Submitted, ApprovalStage)  
		Values  
			(@UserID, @TaskID, @ForDate, @Duration, @Comment, null, null) 
			 
	End -- Record exists 
	 		
End   --@Hours = 0
  



GO
/****** Object:  StoredProcedure [dbo].[TT_ValidateProjectCode]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







Create  procedure [dbo].[TT_ValidateProjectCode]
@ClientID as Int,
@ProjCode as varchar(8)
As

Declare @ClientCode as varchar(4)
Declare @Code as varchar(4)
Declare @RetVal as bit

Select @ClientCode = ClientCode
From dbo.TT_Clients
Where ClientID = @ClientID

Set @Code = Substring(@ProjCode,1,4)

If @ClientCode <> @Code
Begin
	-- Validation Fails
	Select 0
End
Else
Begin
	Select 1
End










GO
/****** Object:  StoredProcedure [dbo].[TT_WinS_ExpensesForApproval_User]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_WinS_ExpensesForApproval_User]
@UserID as Int
As
Select UserName, Period
From (
select --*
b.FirstName + ' ' + b.LastName as UserName,
DateName(month,a.ExpenseDate)+ '&nbsp;'+ Cast(Year(a.ExpenseDate) as varchar)+ ')' as Period
From dbo.TT_FXN_ExpensesForApproval() a join
dbo.Usr_UserDetail b on a.UserID = b.UserID
Where a.UserID = @UserID
and a.ProjectID in (select ProjectID From dbo.TT_FXN_TSApproverProjects(@UserID))
) a
Group By UserName, Period
Order By Period









GO
/****** Object:  StoredProcedure [dbo].[TT_WinS_GetNotificationReceivers]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[TT_WinS_GetNotificationReceivers]
As
-- This procedure returns the email addresses for all users that have:
-- 1) Timesheets overdue,
-- 2) Timesheets for Approval or,
-- 3) Expense Items for Approval
Declare @Now as DateTime
Declare @WeekStartDay as Int
Select @WeekStartDay = WeekStartDay from dbo.TT_System
Set DateFirst @WeekStartDay
Set @Now = GetDate()
--set @Now = dbo.WeekStartDate(GetDate())

select
	UserID,
	isnull(FirstName,'') +' ' + isnull(LastName,'') as FullName,
	isnull(Email,'') as Email
from
	dbo.Usr_UserDetail
where
Enabled = 1
and (
UserID in (Select UserID from dbo.TT_FXN_AllTimesheetsOverdue(@Now))
or
UserID in (Select UserID from dbo.TT_FXN_ExpensesForApproval())
or
UserID in (Select UserID from dbo.TT_FXN_TimesheetsForApproval())
)








GO
/****** Object:  StoredProcedure [dbo].[TT_WinS_SelectEmailTime]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns how long until the emails must be sent and also whether it is a weekly or monthly notification
Used in:		NotificationService.TimetraxDailyCheck.Autorun 
		
Modified:

24/10/2005 by SD: Now being written for a SQL job - so you need to return both the items as output parameter
**************************************************************************************************************/
CREATE  Procedure [dbo].[TT_WinS_SelectEmailTime]
@Interval bigint output,
@RunType int output

AS

Set Dateformat dmy
Declare @Delay as bigint
Declare @MonthDelay as int
Declare @WeekDelay as int
--Declare @RunType as int
Declare @Meridian as varchar(2)
Declare @DOW as int
Declare @Hour as int
Declare @WeekDate as smalldatetime
Declare @Day as int
Declare @Month as int
Declare @Year as int
Declare @WeeklyReminder as smalldatetime
Declare @MonthlyReminder as smalldatetime

-- Get Weekly Notification interval from System Table
-- Set the First day of week
-- Default DateFirst = 7
-- Monday(1) Tuesday(2) ... Sunday(7)
	Set DATEFIRST 1

Set @WeekDelay = 0
select
@Meridian =
Case When WeeklyReminderMeridian = 1 Then
	 'PM'
Else
	'AM'
End,
	@Hour = WeeklyReminderHour,
	@DOW = WeeklyReminderDOW
From dbo.TT_System
Where WeeklyReminderEnabled = 1

-- Get the date for the relevant DayOfWeek
select @WeekDate = dbo.TT_FXN_DateFromDayofWeek(@DOW,Getdate())
set @Day = Day(@WeekDate)
Set @Month = Month(@WeekDate)
Set @Year = Year(@WeekDate)
set @WeekDate = Cast(convert(varchar,@Day) + '/' + convert(varchar,@Month) + '/' + convert(varchar,@Year) + ' ' + convert(varchar,@Hour) + ':00' + @Meridian as smalldatetime)
--print 'WeekDate: ' + Cast(@WeekDate as varchar)
Set @WeekDelay = DateDiff(Second, GetDate(),@WeekDate)
If @WeekDelay < 0
	Begin
		Set @WeekDelay = DateDiff(Second, Getdate(), DateAdd(Day, 7, @WeekDate))
--		print 'Add 7 Days: ' + Cast(DateAdd(Day, 7, @WeekDate) as varchar)
	End

-- Get Monthly Notification interval from System Table
Set @MonthDelay = 0
select @Day = MonthlyReminderDay 
From dbo.TT_System

If @Day = 0
Begin
	Select @Day = Day(dbo.TT_FXN_MonthLastDay(GetDate()))
End

Set @Month = Month(GetDate())
Set @Year = Year(GetDate())

set @MonthlyReminder = Cast(convert(varchar,@Day) + '/' + convert(varchar,@Month) + '/' + convert(varchar,@Year) + ' 06:00' as smalldatetime)
--print 'MonthlyReminder: ' + Cast(@MonthlyReminder as varchar)
Set @MonthDelay = DateDiff(Second, GetDate(),@MonthlyReminder)
If @MonthDelay < 0
	Begin
		Set @MonthDelay = DateDiff(Second, Getdate(), DateAdd(Month, 1, @MonthlyReminder))
--		print 'Add 1 Month: ' + Cast(DateAdd(Month, 1, @MonthlyReminder) as varchar)
	End
--print 'WeekDelay: ' + Cast(@WeekDelay as varchar)
--print 'MonthDelay: ' + Cast(@MonthDelay as varchar)

-- Return the shortest delay interval and runtype and 
If @MonthDelay < @WeekDelay
	Begin
		Set @Delay = @MonthDelay
		Set @RunType = 1
	End
Else
	Begin
		Set @Delay = @WeekDelay
		Set @RunType = 0
	End
	--Returns the seconds until the next occurance of the email time
	--Convert Seconds to Milliseconds as Windows service interval is Milliseconds
print 'Delay '+ Cast(@Delay as varchar)	

--Select (@Delay * 1000) as Interval, @RunType as RunType 
Select @Interval = (@Delay * 1000)



GO
/****** Object:  StoredProcedure [dbo].[TT_WinS_TimesheetsForApproval_User]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE procedure [dbo].[TT_WinS_TimesheetsForApproval_User]
@UserID as Int
As
Select UserName, Period
From (
select --*
b.FirstName + ' ' + b.LastName as UserName,
Convert(varchar,dbo.WeekStartDate(a.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(a.TimesheetDate)), 103) as Period
From dbo.TT_FXN_TimesheetsForApproval() a join
dbo.Usr_UserDetail b on a.UserID = b.UserID join
dbo.TT_View_ProjectData c on a.TaskID = c.TaskID
Where a.UserID = @UserID
and c.ProjectID in (select ProjectID From dbo.TT_FXN_TSApproverProjects(@UserID))
) a
Group By UserName, Period
Order By Period











GO
/****** Object:  StoredProcedure [dbo].[TT_WinS_TimesheetsOverdue_User]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[TT_WinS_TimesheetsOverdue_User]
@UserID Int
As
Declare @Now as DateTime
Declare @WeekStartDay as Int
Select @WeekStartDay = WeekStartDay from dbo.TT_System
Set DateFirst @WeekStartDay
set @Now = dbo.WeekStartDate(GetDate())

Select UserName, Period
From (
select --*
b.FirstName + ' ' + b.LastName as UserName,
a.WeekPeriod as Period
From dbo.TT_FXN_TimesheetsOverdue(@UserID,@Now) a join
dbo.Usr_UserDetail b on a.UserID = b.UserID
Where a.UserID = @UserID
) a
Group By UserName, Period
Order By Period









GO
/****** Object:  StoredProcedure [dbo].[TT_WS_CheckIfProjectResource]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/***************************************************************************************************************
Created by:	SB
Created on:	08/08/2005
Does:		Checks to see if a user already exists as a resource for the given project
Used in:		Webservice.TTX.asmx.CheckIfProjectResource
***************************************************************************************************************/
CREATE procedure [dbo].[TT_WS_CheckIfProjectResource]
@UserID int,
@ProjectID int

AS

SELECT	COUNT(*) as ResourceCount
FROM		TT_ProjectResources
WHERE	UserID = @UserID
AND		ProjectID = @ProjectID



GO
/****** Object:  StoredProcedure [dbo].[TT_WS_GetUserRate]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_WS_GetUserRate]
@UserID Int,
@CostCentreID Int,
@Rate float Output
AS

Select @Rate = Rate
From dbo.TT_Rates
Where UserID = @UserID and CostCentreID = @CostCentreID






GO
/****** Object:  StoredProcedure [dbo].[TT_XML_Flat_Sample]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[TT_XML_Flat_Sample]
as

SELECT 1          as Tag, 
       NULL       as Parent,
       ClientID 	as [Client!1!ClientID],
       ClientName as [Client!1!ClientName]
From dbo.TT_Clients
ORDER BY [Client!1!ClientID]
For XML EXPLICIT

SELECT 
			 2 as Tag, 
       NULL as Parent,
       a.ClientID as [Project!2!ClientID],
			 ProjectID as [Project!2!ProjectID],
			 ProjectName as [Project!2!ProjectName]
FROM dbo.TT_Clients a, dbo.TT_Projects b
WHERE a.ClientID = b.ClientID
ORDER BY [Project!2!ClientID], [Project!2!ProjectID]
For XML EXPLICIT

SELECT 3 as Tag, 
       NULL as Parent,
       a.ClientID			 	as [Task!3!ClientID],
       a.ProjectID      as [Task!3!ProjectID],
       b.TaskID    		  as [Task!3!TaskID],
       b.TaskName       as [Task!3!TaskName]
From 
	(Select Client.ClientID, Project.ProjectID, Ord.OrderID From dbo.TT_Clients Client
	Left Join dbo.TT_Projects Project on Client.ClientID = Project.ClientID
	Left Join dbo.TT_Orders Ord on Project.ProjectID = Ord.ProjectID) a, dbo.TT_ProjectTasks b
Where a.OrderID = b.OrderID
ORDER BY [Task!3!ClientID], [Task!3!ProjectID], [Task!3!TaskID]
For XML EXPLICIT

SELECT 4 as Tag,
       NULL as Parent,
       UserID       as [User!4!UserID],
       FirstName + ' ' + LastName       as [User!4!UserName]
From dbo.Usr_UserDetail
Where Enabled = 1
For XML EXPLICIT






GO
/****** Object:  StoredProcedure [dbo].[TT_XML_Nested_Sample]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[TT_XML_Nested_Sample]
As
	SELECT 1          as Tag, 
	       NULL       as Parent,
	       ClientID 	as [Client!1!ClientID],
	       ClientName as [Client!1!ClientName],
	       NULL			 	as [Project!2!ClientID],
	       NULL       as [Project!2!ProjectID],
	       NULL       as [Project!2!ProjectName],
	       NULL			 	as [Task!3!ClientID],
	       NULL       as [Task!3!ProjectID],
	       NULL       as [Task!3!TaskID],
	       NULL       as [Task!3!TaskName],
	       NULL       as [User!4!UserID],
	       NULL       as [User!4!UserName]
	From dbo.TT_Clients
Union
	SELECT 
				 2, 
	       1,
	       a.ClientID,
				 NUll,
	       a.ClientID,
				 ProjectID,
				 ProjectName,
	       NULL,
	       NULL,
	       NULL,
	       NULL,
				 NULL,
				 NULL
	FROM dbo.TT_Clients a, dbo.TT_Projects b
	WHERE a.ClientID = b.ClientID
Union
	SELECT 3, 
	       2,
	       a.ClientID,
				 NULL,
	       NULL,
				 a.ProjectID,
				 NULL, 
	       a.ClientID,
				 a.ProjectID,
				 b.TaskID,
				 b.TaskName,
				 NULL,
				 NULL

From 
(Select Client.ClientID, Project.ProjectID, Ord.OrderID From dbo.TT_Clients Client
Left Join dbo.TT_Projects Project on Client.ClientID = Project.ClientID
Left Join dbo.TT_Orders Ord on Project.ProjectID = Ord.ProjectID) a, dbo.TT_ProjectTasks b
Where a.OrderID = b.OrderID
Union
	SELECT 4,
	       NULL,
	       NULL,
				 NULL,
	       NULL,
				 NULL,
				 NULL, 
				 NULL,
				 NULL, 
				 NULL,
				 NULL,
	       UserID,
				 FirstName + ' ' + LastName as UserName

From dbo.Usr_UserDetail
Where Enabled = 1

ORDER BY [Client!1!ClientID], [Project!2!ProjectID], [Task!3!TaskID]
For XML EXPLICIT

/*



Select Client.ClientID, Client.ClientName,
  Project.ClientID, Project.ProjectID, Project.ProjectName,
	Project.ClientID as TClientID, Task.TaskID, Task.TaskName,
	[User].UserID, [User].FirstName + ' ' + [User].LastName as UserName
From dbo.TT_Clients Client
Left Join dbo.TT_Projects Project on Client.ClientID = Project.ClientID
Left Join dbo.TT_Orders Ord on Project.ProjectID = Ord.ProjectID
Left Join dbo.TT_ProjectTasks Task on Ord.OrderID = Task.OrderID 
Left Join dbo.TT_ProjectResources Res on Project.ProjectID = Res.ProjectID
Left Join dbo.Usr_UserDetail [User] on Res.UserID = [User].UserID 
*/









GO
/****** Object:  StoredProcedure [dbo].[Usr_AddUpdateGroupName]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[Usr_AddUpdateGroupName]
@ID int,
@constant varchar(30), 
@Enabled bit,
@AddUpdate int --0 For update , 1 for add
AS
If @AddUpdate = 0 
Begin
	Update dbo.Usr_GroupName
	Set	Descript	   = @constant,
		Enabled    = @Enabled
	Where GroupID	   = @ID
End
Else 
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- NOT UPDATE THEN INSERT
Begin
	Insert Into	dbo.Usr_GroupName
			(
			Descript,
			Enabled
			)
	Values
			(
			@constant,
			@Enabled
			)
End





GO
/****** Object:  StoredProcedure [dbo].[Usr_AddUpdateRoleName]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[Usr_AddUpdateRoleName]
@ID int,
@constant varchar(30), 
@Enabled bit,
@AddUpdate int --0 For update , 1 for add
AS
If @AddUpdate = 0 
Begin
	Update dbo.Usr_RoleName
	Set	RoleName	   = @constant,
		Enabled    = @Enabled
	Where RoleID	   = @ID
End
Else 
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- NOT UPDATE THEN INSERT
Begin
	Insert Into	dbo.Usr_RoleName
			(
			RoleName,
			Enabled
			)
	Values
			(
			@constant,
			@Enabled
			)
End





GO
/****** Object:  StoredProcedure [dbo].[Usr_AddUpdateUser]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /************************************************************************ 
 Created by: VF 
 Created on: ?? 
 Does:  Either Adds or updates a user  
 
 Modified:  
 
 10/12/2006 by SD: Change to have a password length of 25 
 03/02/2012 by SD: Added Employee Code
 ************************************************************************/ 
CREATE procedure [dbo].[Usr_AddUpdateUser]  
	@UserID int output,  
	@First varchar(20),  
	@Last varchar(20),  
	@Initials varchar(3),  
	@Email varchar(150),  
	@Tel varchar(50),  
	@SMSNo varchar(30),  
	@Position varchar(30),  
	@UnitID int,  
	@username varchar(30),  
	@Password char(25),  
	@Enabled bit,  
	@groupID int, 
	@EmployeeCode varchar(6), 
	@Error int = 0 output  
AS  

Select *   
From dbo.Usr_UserDetail   
Where Username=@username AND Password=@Password  
If @@Rowcount = 0  
Begin  
 If @UserID = 0  
 Begin  
  Insert into dbo.Usr_UserDetail  
  (FirstName, LastName, Initials, eMail, TelNo, SMSNo, Position, UnitID, UserName, [Password], Enabled, EmployeeCode)  
  Values  
  (@First, @Last, @Initials, @Email, @Tel, @SMSNo, @Position, @UnitID, @username, @Password, @Enabled, @EmployeeCode)  
    
  --Declare @NewId int  
  --Select @NewId = UserID from dbo.Usr_UserDetail Where Username=@username AND Password=@password  
  Select @UserID = @@Identity  
    
  Insert Into dbo.Usr_UserGroup  
  (UserId,GroupID)  
  Values  
  (@UserID,@GroupID)  
  -- Create User Profile  
  Insert Into dbo.TT_ProfileUser  
  (UserId,TimeBase,LastSubDate)  
  Values  
  (@UserID,100,GetDate())  
 End  
 Else  
 Begin  
  If @Password = ' '  
  Begin  
   Update dbo.Usr_UserDetail  
   Set  
   FirstName=@First, LastName=@Last,Initials=@Initials,eMail=@Email,TelNo=@Tel,SMSNo=@SMSNo,Position=@Position,UnitID=@UnitID,UserName=@username,Enabled=@Enabled, EmployeeCode = @EmployeeCode
   Where UserId = @UserID  
  End  
  Else  
  Begin  
   Update dbo.Usr_UserDetail  
   Set  
   FirstName=@First, LastName=@Last,Initials=@Initials,eMail=@Email,TelNo=@Tel,SMSNo=@SMSNo,Position=@Position,UnitID=@UnitID,UserName=@username,Password=@Password,Enabled=@Enabled, EmployeeCode = @EmployeeCode  
   Where UserId = @UserID  
  End  
  Update dbo.Usr_UserGroup  
  Set  
  GroupID = @GroupID  
  Where UserID=@UserID  
--  Update dbo.Usr_Rates  
--  Set  
--  Hourly = @Rate  
--  Where UserID=@UserID  
    
 End  
End  
Else  
Begin  
 Select @Error=1  
End  
  



GO
/****** Object:  StoredProcedure [dbo].[Usr_getUserDetails]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[Usr_getUserDetails]
	@UserID Int, 
	@FirstName varchar(50) OUTPUT, 
	@LastName varchar(50) OUTPUT,
	@GroupID int = 0 OUTPUT,
	@UnitID int = 0 OUTPUT,
	@UnitName varchar(100) OUTPUT
	AS
	Select @FirstName = FirstName, @LastName = LastName, @GroupID = b.GroupID, @UnitID = a.UnitID, @UnitName = c.UnitName
	from dbo.Usr_UserDetail a
	Left Join dbo.Usr_UserGroup b on a.UserID = b.UserID
	Left Join dbo.Usr_BusinessUnit c on a.UnitID = c.UnitID
	WHERE a.UserID = @UserID





GO
/****** Object:  StoredProcedure [dbo].[Usr_getUserID]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/***************************************************************************
Created by:	VF
Created on:	??
Does:		Retrieves the User ID given the UserName and updates the Total Login count
Used in:		Timetrax.BusinessLogicLayer.CustomWinAuthenticate

Modified:

13/07/2005 by SB: Only returns enabled users
***************************************************************************/
CREATE procedure [dbo].[Usr_getUserID]
@UserName varchar(30),
@UserID Int = 0 OUTPUT

AS
	
Select	 	@UserID = UserID
from 		dbo.Usr_UserDetail a
WHERE 	a.UserName = @UserName
AND		a.Enabled = 1
	
If @@RowCount < 1
Begin
	SELECT @UserID = 0
End
Else
Begin
	Update dbo.Usr_UserDetail Set TotalLogin = isNull(TotalLogin, 0) + 1, LastLoginDate = GetDate() Where UserID = @UserID
End



GO
/****** Object:  StoredProcedure [dbo].[Usr_getUserModules]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[Usr_getUserModules] 
	@UserID int
AS
	Select Cast(ModuleID as varchar) as ModuleID
	From dbo.Usr_UserModules 
	Where UserID = @UserID




GO
/****** Object:  StoredProcedure [dbo].[Usr_GetUserName]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[Usr_GetUserName]
	@UserID Int 
	AS
	Select Cast(FirstName + ' ' + LastName as varchar) as FullName
	from dbo.Usr_UserDetail 
	WHERE dbo.Usr_UserDetail.UserID = @UserID




GO
/****** Object:  StoredProcedure [dbo].[Usr_LoadUserDetails]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************
Created by:	VF
Created on:	??
Does:		Retrieves the users information

Modified:

03/02/2012 by SD: Added EmployeeCode
********************************************************/
CREATE procedure [dbo].[Usr_LoadUserDetails]  
@UserID int  
AS  

Select 
	a.UserID,
	a.FirstName,
	a.LastName,
	a.Initials,
	a.UserName,
	a.Password,  
	a.Enabled,
	a.eMail,
	a.TelNo,
	a.SMSNo,
	a.Position,
	a.RecSMS,
	a.UnitID,  
	b.GroupId,
	c.Descript,
	d.UnitName,
	a.EmployeeCode  
From 
	dbo.Usr_UserDetail a left Join  
	dbo.Usr_UserGroup b On b.UserID = a.UserID left Join  
	dbo.Usr_GroupName c On c.GroupID = b.GroupID left Join  
	dbo.Usr_BusinessUnit d on a.UnitID = d.UnitID  
Where 
	a.UserId=@UserID  
  



GO
/****** Object:  StoredProcedure [dbo].[Usr_SelectUserDetails]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[Usr_SelectUserDetails]
@Username varchar(30)
AS

Select FirstName + ' ' + LastName as FullName, isnull(Email,'') as Email, isnull(TelNo,'') as TelNo
From dbo.Usr_UserDetail
Where UserName = @Username






GO
/****** Object:  StoredProcedure [dbo].[Usr_SelectUserRoles]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[Usr_SelectUserRoles]
	@UserID int
AS
	Select Cast(RoleID as varchar) as Role
	From dbo.Usr_UserGroup a inner join
	dbo.Usr_GroupPermission b on a.GroupID = b.GroupID
	Where UserID = @UserID




GO
/****** Object:  StoredProcedure [dbo].[Usr_UserDropDowns]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************************************
Created by:	VF
Created on:	??

Modified:

11/01/2012 by SD: Add EnabledUsersOnly Flag
*********************************************************/
CREATE procedure [dbo].[Usr_UserDropDowns]  
@EnabledUsersOnly bit = 0
AS  

Select	UserId, LastName + ', ' + FirstName As UserD  
From	dbo.Usr_UserDetail  
Where	(@EnabledUsersOnly = 1 And Enabled = 1) OR (@EnabledUsersOnly = 0)
Order By LastName  
  
Select * From dbo.Usr_GroupName  
Where Enabled = 1  
Order by Descript  
  
Select * From dbo.Usr_BusinessUnit  
Where Enabled = 1  
Order by UnitName  
  
  



GO
/****** Object:  StoredProcedure [dbo].[Usr_ValidateUser]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[Usr_ValidateUser]
	@Username varchar(50), 
	@Password varchar(50), 
	@UserID int = 0 OUTPUT
	
AS
	
	Select @UserID = UserID 
	from dbo.Usr_UserDetail 
	WHERE UserName = @Username
	and Password = @Password
	and Enabled = 1
If @@RowCount < 1
Begin
	SELECT @UserID = 0
End
Else
Begin
	Update dbo.Usr_UserDetail Set TotalLogin = isNull(TotalLogin, 0) + 1, LastLoginDate = GetDate() Where UserID = @UserID
End





GO
/****** Object:  StoredProcedure [dbo].[WebMail_DeleteSendWaiting]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[WebMail_DeleteSendWaiting]
@ID int
As
	Delete From dbo.WebMail_Waiting
	Where [ID] = @ID





GO
/****** Object:  StoredProcedure [dbo].[WebMail_GetRecipient]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[WebMail_GetRecipient]
@Type As Int,
@RegionID As Int
AS
If @RegionID is Null
	BEGIN
		Select email
		From dbo.WebMail_Recipients
		Join dbo.WebMail_Addresses on RecipientID = Recipient
		Where TypeID = @Type
		And RegionID is null
	END
	Else
	BEGIN
		Select email
		From dbo.WebMail_Recipients
		Join dbo.WebMail_Addresses on RecipientID = Recipient
		Where TypeID = @Type
		And RegionID = @RegionID
	END





GO
/****** Object:  StoredProcedure [dbo].[WebMail_SelectRecipients]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[WebMail_SelectRecipients]
AS
Select
email,Description,RegionID,
Cast('<img alt="Click to delete this notice" src="../Images/delete.gif" onclick="DelRow2(this)" style="cursor:hand" id="' + Convert(varchar,Recipient) + '">' as varchar(255))
	as RowID
From dbo.WebMail_Addresses a
Join dbo.WebMail_Recipients b on a.Recipient = b.RecipientID
Join dbo.WebMail_Types c on b.TypeID = c.TypeID





GO
/****** Object:  StoredProcedure [dbo].[WebMail_SelectWaiting]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[WebMail_SelectWaiting]
AS
Select
MailTo,Sender,Subject,Body,Priority,
Cast('<img alt="Click to delete this notice" src="../Images/delete.gif" onclick="DelRow(this)" style="cursor:hand" id="' + Convert(varchar,[ID]) + '">' as varchar(255))
	as RowID
From dbo.WebMail_Waiting





GO
/****** Object:  StoredProcedure [dbo].[WebMail_SendLater]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[WebMail_SendLater]
@To As VarChar(255),
@From As VarChar(255),
@Subject As VarChar(50),
@Body As VarChar(1000),
@Priority As VarChar(50),
@AttachList As VarChar(500)
AS
Set DATEFORMAT dmy 
Insert into dbo.WebMail_Waiting
(MailTo, Sender, Subject, Body, Priority,AttachList, Cap_Date) 
VALUES
(@To, @From, @Subject, @Body, @Priority, @AttachList, GetDate())





GO
/****** Object:  StoredProcedure [dbo].[WebMail_SendWaiting]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[WebMail_SendWaiting]
As
Select * From dbo.WebMail_Waiting Order By Cap_Date





GO
/****** Object:  StoredProcedure [dbo].[X_BuildGolfersXML]    Script Date: 2016/12/01 04:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[X_BuildGolfersXML]
As

Select  
	golfer.firstName, golfer.lastName, golfer.skill, golfer.handicap, golfer.clubs, 
	favoriteCourses.Golfer, course.city, course.state, course.[name]
From X_Golfers golfer
--Left Join X_Golfers [name] on golfer.Golfer = [name].Golfer
Left Join X_GolferCourses favoriteCourses on golfer.Golfer = favoriteCourses.Golfer
Left Join X_GolfCourses course on favoriteCourses.Course = course.Course
For XML AUTO




GO
/****** Object:  UserDefinedFunction [dbo].[CalcProjectBudgetCost]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Function [dbo].[CalcProjectBudgetCost](@ProjectID as Int)
Returns Decimal(19,2)
AS
Begin
	Declare @Budget as Decimal(19,2)
	
	Select @Budget = isnull(Sum(Amount),0)
	From dbo.TT_View_ProjectData
	where ProjectID = @ProjectID
	
	Return @Budget
End






GO
/****** Object:  UserDefinedFunction [dbo].[CalcProjectBudgetHours]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Function [dbo].[CalcProjectBudgetHours](@ProjectID as Int)
Returns Decimal(19,2)
AS
Begin
	Declare @Hours as Decimal(19,2)
	
	Select @Hours = isnull(Sum(Hours),0)
	From dbo.TT_View_ProjectData
	where ProjectID = @ProjectID
	
	Return @Hours
End






GO
/****** Object:  UserDefinedFunction [dbo].[CalcProjectCurrentCost]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************************************************
Created by:	VF
Created on:	???
Does:		Returns the current cost for a specified project at the given date
Used in:		TT_Rep_ProjectHeader

Modified:

25/10/2005 by SD: Exclude Project Expenses
*******************************************************************************************************************************/
CREATE  Function [dbo].[CalcProjectCurrentCost](@ProjectID as Int,@EndDate as SmallDateTime)
Returns Decimal(19,2)
AS
Begin
	Declare @Cost as Decimal(19,2)
	Declare @TimeCost as Decimal(19,2)
	--Declare @ExpenseCost as Decimal(19,2)
	
	Select @TimeCost = isnull(Sum(Hours * dbo.GetProjectUserRate(UserID,@ProjectID)),0)
	From dbo.ApprovedUserHours(0,@ProjectID)
	Where TimesheetDate <= @EndDate
	
	/*Select @ExpenseCost = isnull(Sum(Quantity * UnitCost),0)
	From dbo.ApprovedUserExpenses(0,@ProjectID) a
	Where ExpenseDate <= @EndDate*/

	Set @Cost = @TimeCost --+ @ExpenseCost

	Return @Cost
End








GO
/****** Object:  UserDefinedFunction [dbo].[CalcProjectCurrentHours]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Function [dbo].[CalcProjectCurrentHours](@ProjectID as Int,@EndDate as SmallDateTime)
Returns Decimal(19,2)
AS
Begin
	Declare @Hrs as Decimal(19,2)
	
	Select @Hrs = isnull(Sum(dbo.ConvertToHours(Duration,100)),0)
	From dbo.TT_View_ProjectData a
	join  dbo.TT_Timesheets b on a.TaskID = b.TaskID
	where a.ProjectID = @ProjectID
	and b.TimesheetDate <= @EndDate
	and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
	
	Return @Hrs
End







GO
/****** Object:  UserDefinedFunction [dbo].[CalcProjectPeriodCost]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************************************************
Created by:	VF
Created on:	???
Does:		Returns the current cost for a specified project for a specified period
Used in:		TT_Rep_ProjectHeader

Modified:

25/10/2005 by SD: Exclude Project Expenses
*******************************************************************************************************************************/
CREATE  Function [dbo].[CalcProjectPeriodCost](@ProjectID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns Decimal(19,2)
AS
Begin
	Declare @Cost as Decimal(19,2)
	Declare @TimeCost as Decimal(19,2)
	--Declare @ExpenseCost as Decimal(19,2)
	
	Select @TimeCost = isnull(Sum(Hours * dbo.GetProjectUserRate(UserID,@ProjectID)),0)
	From dbo.ApprovedUserHours(0,@ProjectID)
	Where TimesheetDate Between @StartDate and @EndDate
	
	/*Select @ExpenseCost = isnull(Sum(Quantity * UnitCost),0)
	From dbo.ApprovedUserExpenses(0,@ProjectID) a
	Where ExpenseDate Between @StartDate and @EndDate*/

	Set @Cost = @TimeCost -- + @ExpenseCost

	Return @Cost
End







GO
/****** Object:  UserDefinedFunction [dbo].[CalcProjectPeriodHours]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Function [dbo].[CalcProjectPeriodHours](@ProjectID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns Decimal(19,2)
AS
Begin
	Declare @Hrs as Decimal(19,2)
	
	Select @Hrs = isnull(Sum(dbo.ConvertToHours(Duration,100)),0)
	From dbo.TT_View_ProjectData a
	join  dbo.TT_Timesheets b on a.TaskID = b.TaskID
	where a.ProjectID = @ProjectID
	and b.TimesheetDate Between @StartDate and @EndDate
	and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
	
	Return @Hrs
End







GO
/****** Object:  UserDefinedFunction [dbo].[ConvertToHours]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Function [dbo].[ConvertToHours](@Mins as Int, @TimeBase as Int)
Returns Decimal(16,2)
AS
Begin
	Declare @Hrs as Decimal(16,2)
	If @TimeBase = 100
		Begin
			Set @Hrs =	Cast(Cast(@Mins as Decimal(16, 2)) / 60 as Decimal(16,2))
		End
	Else
		Begin
			Declare @HrsInMin as int
			Set @HrsInMin  = Round((@Mins / 60), 0, 1)
			Set @Hrs = @HrsInMin + ((Cast(@Mins as Decimal(16, 2)) - (@HrsInMin*60)) /100)
		End
	Return @Hrs
End






GO
/****** Object:  UserDefinedFunction [dbo].[ConvertToMinutes]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Function [dbo].[ConvertToMinutes](@Hrs as decimal(4, 2), @TimeBase as Int)
Returns Int
AS
Begin
	Declare @Mins as Int
	If @TimeBase = 100
		Begin
			Set @Mins =	Cast(@Hrs * 60 as Int)
		End
	Else
		Begin
			Set @Mins =	Round(((Round(@Hrs,0,1) + ((@Hrs - Round(@Hrs,0,1)) / 0.6)) * 60),0)
		End
	Return @Mins
End





GO
/****** Object:  UserDefinedFunction [dbo].[FXN_CalcUserCost]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE Function [dbo].[FXN_CalcUserCost](@ProjectID as Int,@UserID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime,@Type as int)
Returns Decimal(19,2)
AS
Begin
	Declare @Cost as Decimal(19,2)
	Declare @TimeCost as Decimal(19,2)
	Declare @ExpenseCost as Decimal(19,2)

	Select @TimeCost = isnull(Sum(Hours * dbo.GetProjectUserRate(UserID,@ProjectID)),0)
	From dbo.ApprovedUserHours(@UserID,@ProjectID)
	Where TimesheetDate Between @StartDate and @EndDate

	Select @ExpenseCost = isnull(Sum(Quantity * UnitCost),0)
	From dbo.ApprovedUserExpenses(@UserID,@ProjectID) a
	Where ExpenseDate Between @StartDate and @EndDate

	If @Type = 0
	Begin
		Set @Cost = @TimeCost + @ExpenseCost
	End
	
	If @Type = 1
	Begin
		Set @Cost = @TimeCost
	End
	If @Type = 2
	Begin
		Set @Cost = @ExpenseCost
	End

	Return @Cost
End








GO
/****** Object:  UserDefinedFunction [dbo].[FXN_GetUserGroup]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Function [dbo].[FXN_GetUserGroup](@UserID as Int)
Returns varchar(15)
AS
Begin
	Declare @Group as Varchar(15)
	
	Select @Group = Descript
	From dbo.Usr_UserGroup a
	join dbo.Usr_GroupName b on a.GroupID = b.GroupID
	where a.UserID = @UserID
	
	Return isnull(@Group,'None')
End







GO
/****** Object:  UserDefinedFunction [dbo].[FXN_GetUserProjectRole]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************************
Created by:	VF
Created on: ??
Does:		Returns a users role on a given project

Modified:

02/02/2010 by SD: Remove TSFirstApprover as the TSFirstApprover 
	is always the TeamLeader
*************************************************************************/
CREATE Function [dbo].[FXN_GetUserProjectRole](@UserID as Int,@ProjectID as Int)  
Returns varchar(15)  
AS  
Begin  
 Declare @Role as Varchar(15)  
   
 Select @Role =  
  Case  
  When TeamLeader = 1 Then 'TeamLeader'  
  When FirstApprover = 1 Then 'FirstApprover'  
  When LastApprover = 1 Then 'LastApprover'  
  --When TSFirstApprover = 1 Then 'TSFirstApprover'  
  When TSLastApprover = 1 Then 'TSLastApprover'  
  Else 'TeamMember'  
 End  
 From dbo.TT_ProjectResources  
 Where UserID = @UserID  
 And ProjectID = @ProjectID  
   
 Return isnull(@Role,'None')  
End  
  
  
  
  
  



GO
/****** Object:  UserDefinedFunction [dbo].[GetLastDay]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Function [dbo].[GetLastDay](@Month int, @Year int)
RETURNS int
AS
BEGIN
	Declare @Ldaycm datetime -- Last Day of Current Month
	Declare @myday as int
	set @Ldaycm = dateadd(day,-1,dateadd(month,1,
	cast(
	cast(datepart(year,Cast(Cast(@Year as varchar)+ '-' + Cast(@month As varchar)+ '-15'     as smalldatetime)) as char(4)) + '-' +
	substring(convert(char(2),Cast(Cast(@Year as varchar) + '-' + Cast(@month As varchar) + '-15'  as smalldatetime),101),1,2) + '-01'
	as datetime)))
	Set @myday = Day(@Ldaycm)
	RETURN @myday
END





GO
/****** Object:  UserDefinedFunction [dbo].[GetProjectUserRate]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns the users rate for a given project
Used in:		Various Stored Procedures

Modified:

28/09/2005 by SD: Returns the rate from the ProjectResources table and not the TT_Rate table
***********************************************************************************************************************/
CREATE Function [dbo].[GetProjectUserRate](@UserID as Int,@ProjectID as Int)
Returns Decimal(19,2)
AS
Begin
	Declare @Rate as Decimal(19,2)
	
	--Select 	@Rate = isnull(Rate,0)
	--From 	dbo.TT_Projects a
	--join 	dbo.TT_Rates b on a.CostCentreID = b.CostCentreID
	
	Select 	@Rate = isnull(Rate,0)
	From 	dbo.TT_ProjectResources a
	where 	a.ProjectID = @ProjectID
	and 	a.UserID = @UserID
	
	Return @Rate
End






GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_BuildEmailBody]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*************************************************************************************************
Created by:	SD
Created on:	??
Does:		Build up the weekly/monthly notification emai
		This consists of 3 parts:
		a) Overdue Timesheets	
		b) Timesheets awaiting approval
		c) Expenses awaiting approval
Used in:		
Based on:	NotificationService.TimetraxDailyCheck.BuildEmailBody
*************************************************************************************************/
CREATE Function [dbo].[TT_FXN_BuildEmailBody](@UserID int, @Today datetime)
Returns varchar(8000)

As

Begin

Declare @Body varchar(8000),
	@RowCount int,
	@RowColor varchar(10),
	@UserName varchar(50),
	@WeekPeriod varchar(50),
	@TimesheetBody varchar(1500),
	@TimesheetOverdueBody varchar(5000),
	@ExpenseOverdueBody varchar(1500)

-------------------------------------------- Overdue Timesheets --------------------------------------------

        	Select @TimesheetBody = 'The following timesheets are overdue:<br><br>'
        	Select @TimesheetBody =  @TimesheetBody + '<table width="40%" bgcolor="#c6dde3" cellpadding=0 cellspacing=1 style="font-family: verdana; font-size: xx-small;text-align: center;">'

        	--The headers for the table
        	Select @TimesheetBody =  @TimesheetBody + '<tr>'
        	Select @TimesheetBody =  @TimesheetBody + '<td bgcolor="#c6dde3" align="center"><font face=verdana size=1 color=#000000><b>Week Period</b></font></td>'
        	Select @TimesheetBody =  @TimesheetBody + '</tr>'

	DECLARE overdue_timesheets CURSOR FOR
	Select UserName, Period
	From (	select 	b.FirstName + ' ' + b.LastName as UserName,
			a.WeekPeriod as Period
		From 	dbo.TT_FXN_TimesheetsOverdue(@UserID,@Today) a join
			dbo.Usr_UserDetail b on a.UserID = b.UserID
		Where a.UserID = @UserID
	) a
	Group By UserName, Period
	Order By Period
	
	Select @RowCount = 0

	OPEN overdue_timesheets
	
	FETCH NEXT FROM overdue_timesheets
	INTO @UserName, @WeekPeriod
	
	--See if there are any more timesheets
	WHILE @@FETCH_STATUS = 0
	BEGIN

		If @RowCount % 2 = 0 
	    	Begin
                		Select @RowColor = '#ffffea'
	    	End
	            	Else
		    	Begin
	                	Select @RowColor = '#ffffff'
	            	End 

	            	Select @TimesheetBody =  @TimesheetBody + '<tr>'
	            	Select @TimesheetBody =  @TimesheetBody + '<td bgcolor=' + @RowColor + '>' + @WeekPeriod + '</td>'
	            	Select @TimesheetBody =  @TimesheetBody + '</tr>'
	
	            	Select @RowCount = @RowCount + 1
			
	   	FETCH NEXT FROM overdue_timesheets
	   	INTO @UserName, @WeekPeriod
	END
	
	CLOSE overdue_timesheets
	DEALLOCATE overdue_timesheets

       	If @RowCount > 0 
       	Begin
            		Select @TimesheetBody =  @TimesheetBody  + '</table><br><br>'
        	End
	Else
	Begin
		Select @TimesheetBody = ''
	End 

--------------------------------------------  Timesheets Awaiting Approval  --------------------------------------------

  	Select @TimesheetOverdueBody =  '<table width="40%" bgcolor="#c6dde3" cellpadding=0 cellspacing=1 style="font-family: verdana; font-size: xx-small;text-align: center;">'

        	--The headers for the table
        	Select @TimesheetOverdueBody =  @TimesheetOverdueBody +  '<tr>'
        	Select @TimesheetOverdueBody =  @TimesheetOverdueBody +  '<td colspan="2" bgcolor="#c6dde3" align="center"><font face=verdana size=1 color=#000000><b>Timesheets</b></font></td>'
        	Select @TimesheetOverdueBody =  @TimesheetOverdueBody +  '</tr>'

        	Select @RowCount = 0
	
	DECLARE approval_timesheets CURSOR FOR
	Select	Distinct UserName, Period 
	From   	dbo.TT_FXN_TimesheetsAwaitngApprovalForUser(@UserID, '')
	Order By Period
	
	OPEN approval_timesheets
	
	FETCH NEXT FROM approval_timesheets
	INTO @UserName, @WeekPeriod
	
	-- Check if there are any more timesheets awaiting approval
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		If @RowCount % 2 = 0
	    	Begin
	                	Select @RowColor = '#ffffea'
		End
	            	Else
		Begin
	                	Select @RowColor = '#ffffff'
	            	End 
	
	            	Select @TimesheetOverdueBody =  @TimesheetOverdueBody +  '<tr>'
	            	Select @TimesheetOverdueBody =  @TimesheetOverdueBody +  '<td width="50%" bgcolor=' + @RowColor + '>' + @UserName + '</td>'
	            	Select @TimesheetOverdueBody =  @TimesheetOverdueBody +  '<td width="50%" bgcolor=' + @RowColor + '>' + @WeekPeriod + '</td>'
	            	Select @TimesheetOverdueBody =  @TimesheetOverdueBody +  '</tr>'
	
	            	Select @RowCount = @RowCount + 1

	   	FETCH NEXT FROM approval_timesheets
	   	INTO @UserName, @WeekPeriod
	END
	
	CLOSE approval_timesheets
	DEALLOCATE approval_timesheets

        	If @RowCount > 0 
        	Begin
            		Select @TimesheetOverdueBody =  @TimesheetOverdueBody + '</table><br><br>'
        	End 
	Else
	Begin
		Select @TimesheetOverdueBody = ''
	End

-------------------------------------------- Expenses Awaiting Approval --------------------------------------------

        	Select @ExpenseOverdueBody =  '<br><table width="40%" bgcolor="#c6dde3" cellpadding=0 cellspacing=1 style="font-family: verdana; font-size: xx-small;text-align: center;">'
        	--The headers for the table
        	Select @ExpenseOverdueBody =  @ExpenseOverdueBody + '<tr>'
        	Select @ExpenseOverdueBody =  @ExpenseOverdueBody + '<td colspan="2" bgcolor="#c6dde3" align="center"><font face=verdana size=1 color=#000000><b>Expenses</b></font></td>'
        	Select @ExpenseOverdueBody =  @ExpenseOverdueBody + '</tr>'

        	Select @RowCount = 0
	
	DECLARE approval_expenses CURSOR FOR
	Select 	UserName, Period
	From 	TT_FXN_ExpensesAwaitngApprovalForUser(@UserID,'')
	Order By Period
	
	OPEN approval_expenses
	
	FETCH NEXT FROM approval_expenses
	INTO @UserName, @WeekPeriod
	
	-- Check if there are more expenses awaiting approval
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
	            	If @RowCount % 2 = 0 
		Begin
	                	Select @RowColor = '#ffffea'
		End
		Else
		Begin
	                	Select @RowColor = '#ffffff'
	            	End 
	
	            	Select @ExpenseOverdueBody =  @ExpenseOverdueBody + '<tr>'
	            	Select @ExpenseOverdueBody =  @ExpenseOverdueBody + '<td bgcolor=' + @RowColor + '>' + @UserName + '</td>'
	            	Select @ExpenseOverdueBody =  @ExpenseOverdueBody + '<td bgcolor=' + @RowColor + '>' + @WeekPeriod + '</td>'
	            	Select @ExpenseOverdueBody =  @ExpenseOverdueBody + '</tr>'
	
	            	Select @RowCount = @RowCount + 1
	
	   	FETCH NEXT FROM approval_expenses
	   	INTO @UserName, @WeekPeriod
	END
	
	CLOSE approval_expenses
	DEALLOCATE approval_expenses

        	If @RowCount > 0 
	Begin
            		Select @ExpenseOverdueBody =  @ExpenseOverdueBody + '</table>'
        	End  
	Else
	Begin
		Select @ExpenseOverdueBody = ''
	End 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	--Build up the body
	If (len(@TimesheetOverdueBody) > 0) Or (len(@ExpenseOverdueBody) > 0)
	Begin
		Select @Body = coalesce(@TimesheetBody, '') +  'The following items are awaiting your approval:<br><br>' + coalesce(@TimesheetOverdueBody, '')  +  coalesce(@ExpenseOverdueBody, '') 
	End
	Else
	Begin
	        	Select  @Body = coalesce(@TimesheetBody, '') 
	End
	
	Return @Body

End











GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_DateFromDayofWeek]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Function [dbo].[TT_FXN_DateFromDayofWeek](@DOW as Int,@DateNow as smalldatetime)
Returns SmallDateTime

Begin
	Declare @Now int
	Declare @DOWDate smalldatetime
	
	Set @Now = DatePart(DW, @DateNow)
	
	If @Now < @DOW
	Begin
	 Set @DOWDate = DateAdd(Day, (@DOW - @Now), @DateNow)
	End
	Else
	Begin
	If @Now = @DOW
		Begin
		 Set @DOWDate = @DateNow
		End
	Else
		Begin
		 Set @DOWDate = DateAdd(Day, (7 - @Now + @DOW), @DateNow)
		End
	End
	
	Return @DOWDate
End





GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_DatesTable]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Function [dbo].[TT_FXN_DatesTable] (@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns @Months Table 
	(dd smalldatetime)

As
Begin

	While @StartDate <= @EndDate
		Begin
			Insert @Months select @StartDate
			Select @StartDate = dateadd(dd,1,@StartDate)
		End

Return
End









GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ExpensesByCaptureType]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

/****************************************************************************************************************************************
Created by:	SD
Created on:	05/10/2005 
Does: 		Returns a list of expenses for the specified capture type
Used in:		???
Parameters:	CaptureTypeID = The CaptureType to filter by:
			0 = All
			1 = Approved
			2 = Capture
			3 = Submitted
		ProjectID = The project to filter by
****************************************************************************************************************************************/
CREATE Function [dbo].[TT_FXN_ExpensesByCaptureType](@CaptureTypeID int, @ProjectID int)
Returns @Expenses Table 
	(ExpenseID int)
As
Begin


	If @CaptureTypeId = 0
	Begin
		Insert Into @Expenses
		Select  Distinct ExpenseID 
		From 	TT_FXN_ExpensesAllForProject(@ProjectID)
	End 
	Else
	Begin 
		If @CaptureTypeId = 1 
		Begin
	
			Insert Into @Expenses
			select  Distinct ExpenseID  
			From 	ApprovedExpenses(@ProjectID)
	
		End
		Else
		Begin
			If @CaptureTypeId = 2 
			Begin
				Insert Into @Expenses
				select  Distinct ExpenseID  
				From 	TT_FXN_ExpensesCapturedForProject(@ProjectID)
			End
			Else
			Begin
				If @CaptureTypeId = 3 
				Begin
					Insert Into @Expenses
					select  Distinct ExpenseID  
					From 	TT_FXN_ExpensesSubmittedForProject(@ProjectID)
				End
			End
		End
	End

Return

End















GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_GetApprovalStage]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***************************************************************      
Created by: SD      
Created on: 15/02/2010      
Does:  This function will return whether the timesheet should be submitted to the TeamLeader or    
  the Manager for approval.     
      
  For a 1 level approval system there is 1 possibility:    
      
   a) The timesheet is always submitted for TeamLeader approval    
      
  For a 2 level approval system there are 3 possibilities:    
      
   a) If this user is neither the Teamleader nor the Manager, then the timesheet must be     
    submitted to the TeamLeader for approval    
   b) If this user is the Teamleader then the timesheet must be submitted to the Manager    
    for approval    
   c) If this user is the Manager then the timesheet must be submitted to the MD  
      
Modified:      
  
06/02/2012 by SD: Cater for the MD Approval  
15/02/2012 by SD: Cater for resource being teamleader and project manager
    
***************************************************************/      
CREATE Function [dbo].[TT_FXN_GetApprovalStage](@UserID as int, @TimesheetID int)        
Returns int        
As        
BEGIN    
    
 DECLARE @ProjectID INT    
 DECLARE @ApprovalStage INT    
 DECLARE @TSApprovals INT        
     
 SET @ApprovalStage = 1        
    
 --Get the number of approvals required    
 SELECT    
  @TSApprovals = TSApprovals     
 FROM     
  dbo.TT_System        
    
 IF @TSApprovals = 1        
 BEGIN        
  --If there is only one level of approval, the approval stage is always 1.      
  --ie. Submitted and awaiting approval by the Teamleader    
  SELECT @ApprovalStage = 1    
 END    
 ELSE    
 BEGIN    
  --There are 2 levels of approval    
     
  --Determine the Project for this Timesheet    
  SELECT     
   @ProjectID = ProjectID    
  FROM    
    TT_Orders a    
   INNER JOIN TT_ProjectTasks b    
    ON a.OrderID = b.OrderID    
   INNER JOIN TT_Timesheets c     
    ON b.TaskID = c.TaskID    
  WHERE    
   TimesheetID = @TimesheetID    
         
  --Get the level of approval for the project based on who the timesheet belongs to    
  --1 = Submitted and awaiting approval by the Teamleader    
  --2 = Submitted and awaiting approval by the Manager    
  --3 = Submitted and awaiting approval by MD  
  SELECT @ApprovalStage =        
   CASE       
    WHEN TSLastApprover IS NOT NULL THEN 3   
    WHEN TeamLeader IS NOT NULL THEN 2     
    ELSE 1    
   END     
  FROM    
   dbo.TT_ProjectResources       
  WHERE       
   UserID = @UserID AND       
   (TeamLeader = 1 or TSLastApprover = 1) AND    
   ProjectID = @ProjectID     
 END    
      
 RETURN ISNULL(@ApprovalStage,1)    
    
END        
        
        
        
        
        



GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_GetExpenseApprovalStage]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************      
Created by: SD      
Created on: 22/02/2010      
Does:  This function will return whether the expense should be submitted to the TeamLeader or    
  the Manager for approval.     
      
  For a 1 level approval system there is 1 possibility:    
      
   a) The timesheet is always submitted for TeamLeader approval    
      
  For a 2 level approval system there are 3 possibilities:    
      
   a) If this user is neither the Teamleader nor the Manager, then the timesheet must be     
    submitted to the TeamLeader for approval    
   b) If this user is the Teamleader then the timesheet must be submitted to the Manager    
    for approval    
   c) If this user is the Manager then the timesheet must be submitted to himself (ie. the     
    Manager for approval    
      
Modified:      

07/02/2012 by SD: Cater for 3rd level (MD) approval
15/02/2012 by SD: Cater for the Teamleader being the Manager as well   
***************************************************************/      
CREATE Function [dbo].[TT_FXN_GetExpenseApprovalStage](@UserID as int, @ProjectID int)        
Returns int        
As        
BEGIN    
    
 DECLARE @ApprovalStage INT    
 DECLARE @TSApprovals INT        
     
 SET @ApprovalStage = 1        
    
 --Get the number of approvals required    
 SELECT    
  @TSApprovals = TSApprovals     
 FROM     
  dbo.TT_System        
    
 IF @TSApprovals = 1        
 BEGIN        
  --If there is only one level of approval, the approval stage is always 1.      
  --ie. Submitted and awaiting approval by the Teamleader    
  SELECT @ApprovalStage = 1    
 END    
 ELSE    
 BEGIN    
  --There are 2 levels of approval    
       
  --Get the level of approval for the project based on who the timesheet belongs to    
  --1 = Submitted and awaiting approval by the Teamleader    
  --2 = Submitted and awaiting approval by the Manager   
  --3 = Submitted and awaiting approval by MD   
  SELECT @ApprovalStage =        
   CASE       
    WHEN TSLastApprover IS NOT NULL THEN 3
    WHEN TeamLeader IS NOT NULL THEN 2     
    ELSE 1    
   END     
  FROM    
   dbo.TT_ProjectResources       
  WHERE       
   UserID = @UserID AND       
   (TeamLeader = 1 or TSLastApprover = 1) AND    
   ProjectID = @ProjectID     
 END    
      
 RETURN ISNULL(@ApprovalStage,1)    
    
END        
        



GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_GetTeamLeaderRole]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/**********************************************************************************************************
Created by:	SD
Created on:	11/09/2005
Does:		Returns the TeamLeader Role ID
Used in:		TT_UpdateTeamLeader
**********************************************************************************************************/
CREATE Function [dbo].[TT_FXN_GetTeamLeaderRole]()
Returns int
AS
Begin

	declare @TeamLeaderRoleID as int

	Select @TeamLeaderRoleID = isnull(GroupID,0) 
	From dbo.Usr_GroupName
	Where Upper(Descript) = 'TEAM LEADER'
	
	Return @TeamLeaderRoleID
End




GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_GetTSApprover1RoleID]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/**********************************************************************************************************
Created by:	SD
Created on:	11/09/2005
Does:		Returns the TSApprover1RoleID
Used in:		TT_UpdateTeamLeader
**********************************************************************************************************/
CREATE Function [dbo].[TT_FXN_GetTSApprover1RoleID]()
Returns int
AS
Begin

	declare @TSApprover1RoleID as int

	Select  @TSApprover1RoleID = b.GroupID 
	from dbo.TT_System a
	Join dbo.Usr_GroupName b on a.TSApprover1Role = b.GroupID
	
	Return @TSApprover1RoleID
End





GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_GetTSApprover2RoleID]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/**********************************************************************************************************
Created by:	SD
Created on:	11/09/2005
Does:		Returns the TSApprover2RoleID
Used in:		TT_UpdateTeamLeader
**********************************************************************************************************/
CREATE Function [dbo].[TT_FXN_GetTSApprover2RoleID]()
Returns int
AS
Begin

	declare @TSApprover2RoleID as int

	Select  @TSApprover2RoleID = b.GroupID 
	From dbo.TT_System a
	Join dbo.Usr_GroupName b on a.TSApprover2Role = b.GroupID
	
	Return @TSApprover2RoleID
End





GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_MailReport]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*************************************************************************************************
Created by:	SD
Created on:	??
Does:		Based on the Report Type, it builds the skeleton for the email to be sent out
Used in:		
Based on:	NotificationService.TimetraxDailyCheck.MailReport
*************************************************************************************************/
CREATE Function [dbo].[TT_FXN_MailReport](@UserID int, @FullName varchar(50), @ReportType int, @Today datetime)
Returns varchar(8000)

As

Begin
	Declare @Body varchar(8000)
	

	--Retrieve the overdue alerts
	Select @Body =	dbo.TT_FXN_BuildEmailBody(@UserID, @Today)
	
	--Check if this is a weekly or monthly report
	If (@ReportType = 1) And  (Len(@Body) > 0)
	Begin
	
		Select @Body = @Body + '<br><br><br><font color=red><b>Please Note:<br>'
		Select @Body = @Body + 'These are critical to efficiently close out month end,<br>'	
		Select @Body = @Body + 'Please complete A.S.A.P.</b></font><br>'
	End

	--If there are alerts add the formatting (not adding the alerts means that a blank string is returned as the body so we can check against this before emailing)
	If (Len(@Body) > 0)
	Begin

		Select @Body = '<font face="Arial" size="2">' + @FullName + ',<br><br>' + @Body	
		Select @Body = @Body + '</font>'
	
	End

	Return @Body
End











GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_MonthBudgetTable]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************************************************************************
Created by:	VF
Created on:	??
Does:		Creates a table of the days for a project and their expected cost per day
Used in:		TT_Rep_ProjStatus_Financial 

Modified:

25/10/2005 by SD: Need to divide by the datediff + 1 to get the correct budget per day.  Project is incl of start and end date
***********************************************************************************************************************/
CREATE   Function [dbo].[TT_FXN_MonthBudgetTable] (@ProjectID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns @Months Table 
	(dd smalldatetime,
	DayBud float)

As
Begin
Declare @ProjBud float
Declare @ProjStart smalldatetime
Declare @ProjEnd smalldatetime
Declare @CostPerDay float

--Get project budget, start and end dates
Select @ProjBud = dbo.CalcProjectBudgetCost(@ProjectID)
Select @ProjStart = StartDate, @ProjEnd = EndDate
From dbo.TT_Projects 
Where ProjectID = @ProjectID

--Work out project duration and cost per day
Select @CostPerDay = (@ProjBud / (DateDiff(dd, @ProjStart, @ProjEnd) + 1))  -- SD: Divide by datediff + 1

	While @StartDate <= @EndDate
		Begin
			If @StartDate between @ProjStart and @ProjEnd
			Begin
				Insert @Months select @StartDate, @CostPerDay
			End
			Else
			Begin
				Insert @Months select @StartDate, 0
			End
			Select @StartDate = dateadd(dd,1,@StartDate)
		End

Return
End









GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_MonthHoursTable]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



-- Calculate Project Daily Hours


CREATE Function [dbo].[TT_FXN_MonthHoursTable] (@ProjectID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns @Months Table 
	(dd smalldatetime,
	DayBud float)

As
Begin
Declare @ProjBud float
Declare @ProjStart smalldatetime
Declare @ProjEnd smalldatetime
Declare @HrsPerDay float

--Get project budget, start and end dates
Select @ProjBud = dbo.CalcProjectBudgetHours(@ProjectID)
Select @ProjStart = StartDate, @ProjEnd = EndDate
From dbo.TT_Projects 
Where ProjectID = @ProjectID

--Work out project duration and cost per day
Select @HrsPerDay = (@ProjBud / DateDiff(dd, @ProjStart, @ProjEnd))

	While @StartDate <= @EndDate
		Begin
			If @StartDate between @ProjStart and @ProjEnd
			Begin
				Insert @Months select @StartDate, @HrsPerDay
			End
			Else
			Begin
				Insert @Months select @StartDate, 0
			End
			Select @StartDate = dateadd(dd,1,@StartDate)
		End

Return
End









GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_MonthLastDay]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Function [dbo].[TT_FXN_MonthLastDay](@date as smalldatetime)
Returns smalldatetime

begin
		declare @endMonth as smalldatetime
		declare @startmonth as smalldatetime
	
		-- simple: get the 1st day of the month,
		set @startmonth = cast('01/' + convert(varchar,month(@date)) + '/' + convert(varchar,year(@date)) as smalldatetime)
		-- add a month to it, then it is the 1st day of next month
		-- then subtract a day, and it is the last day of this month
		set @endMonth = dateadd(day,-1,dateadd(month,1,@startmonth))
	
		return @endMonth
	end






GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimeOffApproved]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE  Function [dbo].[TT_FXN_TimeOffApproved](@TimeOffID as int)
Returns bit
As
Begin
Declare @App as bit

Select @App = Count(ApprovedItemID) 
From dbo.TT_Approvals a
Where a.ApprovalTypeID = 5
And a.Approved = 1
And ApprovedItemID = @TimeOffID

Return @App
End








GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimeOffByCaptureType]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****************************************************************************************************************************************  
Created by: SD  
Created on: 24/01/2007
Does:   Returns a list of timeoff for the specified capture type  
Used in:  Data Extraction
Parameters: CaptureTypeID = The CaptureType to filter by:  
   0 = All  
   1 = Approved  
   2 = Capture  
   3 = Submitted  
****************************************************************************************************************************************/  
Create Function [dbo].[TT_FXN_TimeOffByCaptureType](@CaptureTypeID int)  
Returns @TimeOff Table   
 (TimeOffID int)  
As  
Begin  
  
  
If @CaptureTypeId = 0  
Begin  
	Insert Into @TimeOff  
	Select    Distinct TimeOffID  
	From      TT_TimeOff a  
End   
Else  
Begin   
	If @CaptureTypeId = 1   
	Begin  
		--Approved Time Off
		Insert Into @TimeOff  
		Select  
			Distinct TimeOffID    
		From	dbo.TT_Approvals a inner join  
				dbo.TT_TimeOff b on a.ApprovedItemID = b.TimeOffID   
		Where   a.ApprovalTypeID = 5 and   
				b.ApprovalStage = 2 and   
				Approved = 1   
	End  
	Else  
	Begin  
		If @CaptureTypeId = 2   
		Begin  
			--Capture 
			Insert Into @TimeOff  
			Select Distinct TimeOffID  
			From   (Select 
						TimeOffID
					From 
						TT_TimeOffs   
					Where 
						TimeOffID not in ( Select ApprovedItemID   
											 From	TT_Approvals   
											 Where	ApprovalTypeID = 5)  
					And submitted is null) a  
		End  
		Else  
		Begin  
			If @CaptureTypeId = 3   
			Begin
				--Submitted  
				Insert Into @TimeOff  
				Select  Distinct TimeOffID    
				From	(Select TimeOffID
						 From  
								TT_TimeOff
						 Where  
								Submitted is Not Null  
						 And  
								TimeOffID not in (	Select 
															Distinct TimeOffID 
													From	dbo.TT_Approvals a inner join  
															dbo.TT_TimeOff b on a.ApprovedItemID = b.TimeOffID   
													Where   a.ApprovalTypeID = 5 and   
															b.ApprovalStage = 2 and   
															Approved = 1   )) a  
			End  
		End  
	End  
End  

Return  

End  
  
  
  
  
  
  
  
  
  
  



GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimeOffRejected]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**********************************************************************************************************
Created by:	VF
Created on:	??
Does:		Determines if a particular TimeOffID has been rejected

Modified:

24/01/2006 by SD:  This function wasn't checking against the TimeOffID hence it would return
		      if any TimeOff had been rejected.  I've added a check against TimeOffID
**********************************************************************************************************/
CREATE Function [dbo].[TT_FXN_TimeOffRejected](@TimeOffID as int)
Returns bit
As
Begin
Declare @App as bit

Select 	
	@App = Count(TimeOffID) 
From 
	dbo.TT_Approvals a inner join
	(Select 
		TimeOffID 
	From 
		dbo.TT_TimeOff
	Where
		TimeOffID = @TimeOffID) b on a.ApprovedItemID = b.TimeOffID
Where 	a.ApprovalTypeID = 5
And 	a.Approved = 0

Return @App
End










GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetApproved]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Function [dbo].[TT_FXN_TimesheetApproved](@TimesheetID as int)
Returns bit
As
Begin
Declare @App as bit

Select @App = Count(TimesheetID) 
From 
(Select TimesheetID, TaskID, ApproverID, ApprovedItemID 
	From dbo.TT_Timesheets a inner join
	dbo.TT_Approvals b on a.TimesheetID = b.ApprovedItemID
	Where TimesheetID = @TimesheetID and ApprovalTypeID = 2 And Approved = 1 
) a inner join
(Select TaskID, UserID 
	From dbo.TT_ProjectTasks a inner join
	dbo.TT_Orders b on a.OrderID = b.OrderID inner join
	dbo.TT_ProjectResources c on b.ProjectID = c.ProjectID
	Where TSLastApprover = 1
) b on a.TaskID = b.TaskID and a.ApproverID = b.UserID

Return @App
End








GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetRejected]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE Function [dbo].[TT_FXN_TimesheetRejected](@TimesheetID as int)
Returns bit
As
Begin
Declare @App as bit

Select @App = Count(TimesheetID) 
From dbo.TT_Approvals a inner join
(Select TimesheetID, TaskID From 
dbo.TT_Timesheets 
Where TimesheetID = @TimesheetID) b on a.ApprovedItemID = b.TimesheetID inner join
	(Select TaskID, UserID From
	dbo.TT_ProjectTasks a inner join
	dbo.TT_Orders b on a.OrderID = b.OrderID inner join
	dbo.TT_ProjectResources c on b.ProjectID = c.ProjectID
	Where TSLastApprover = 1) c on b.TaskID = c.TaskID and a.ApproverID = c.UserID
Where a.ApprovalTypeID = 2
And a.Approved = 0

Return @App
End







GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetsByCaptureType]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

/****************************************************************************************************************************************
Created by:	SD
Created on:	04/10/2005 
Does: 		Returns a list of timesheets for the specified capture type
Used in:		???
Parameters:	CaptureTypeID = The CaptureType to filter by:
			0 = All
			1 = Approved
			2 = Capture
			3 = Submitted
		ProjectID = The project to filter by
****************************************************************************************************************************************/
CREATE Function [dbo].[TT_FXN_TimesheetsByCaptureType](@CaptureTypeID int, @ProjectID int)
Returns @Timesheet Table 
	(TimesheetID int)
As
Begin


	If @CaptureTypeId = 0
	Begin
		Insert Into @Timesheet
		Select  Distinct TimesheetID 
		From 	TT_FXN_TimesheetsAllForProject(@ProjectID)
	End 
	Else
	Begin 
		If @CaptureTypeId = 1 
		Begin
	
			Insert Into @Timesheet
			select  Distinct TimesheetID  
			From 	ApprovedTimesheets(@ProjectID)
	
		End
		Else
		Begin
			If @CaptureTypeId = 2 
			Begin
				Insert Into @Timesheet
				select  Distinct TimesheetID  
				From 	TT_FXN_TimesheetsCapturedForProject(@ProjectID)
			End
			Else
			Begin
				If @CaptureTypeId = 3 
				Begin
					Insert Into @Timesheet
					select  Distinct TimesheetID  
					From 	TT_FXN_TimesheetsForApprovalForProject(@ProjectID)
				End
			End
		End
	End

Return

End













GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetsOverdue]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


/*******************************************************************************
Created by:	VF
Created on:	??
Does:		Returns a list of overdue timesheets for the user
Used:		TT_SelectStartAlerts and maybe else where

Modified:

24/04/2006 by SD: Added check for permission - Add/Update Timesheet (6)
*******************************************************************************/
CREATE Function [dbo].[TT_FXN_TimesheetsOverdue] (@UserID Int, @Now smalldatetime)
Returns @TempTable Table (UserID int, TimesheetDate smalldatetime, WeekPeriod varchar(50) Collate Latin1_General_CI_AS)
As
Begin

--Check if the user has permission to capture time
If 	(Select 	count(*)		
	From 	Usr_GroupPermission a Inner Join
		Usr_UserGroup b on a.GroupID = b.GroupID 
	Where	RoleID = 6
	And 	UserID = @UserID) > 0 

Begin

	Declare @StartDate as DateTime
	Select @StartDate = dbo.WeekStartDate(LastSubDate) from dbo.TT_ProfileUser
	Where UserID = @UserID

	-- Get No of weeks from LastSubDate to Today
	Declare @Weeks as Int
	Set @Weeks = DateDiff(wk,@StartDate,@Now)


	-- Create a table containing the startday of each week since Users LastSubDate
	Declare @Counter as Int
	Declare @FirstDayofWeek as DateTime
	
	Declare @Temp table
		(TimesheetDate SmallDateTime,
			UserID Int, WeekPeriod varchar(50))
	
	Set @Counter = 0
	While (@Counter < @Weeks)
		Begin
			Set @FirstDayofWeek = DateAdd(wk,@Counter,@StartDate)
			Insert Into @Temp (TimesheetDate,UserID, WeekPeriod)
			Values (@FirstDayofWeek, @UserID,  Convert(varchar, @FirstDayofWeek, 103) +' - '+ Convert(varchar, @FirstDayofWeek + 6, 103))
	
			Set @Counter = (@Counter + 1)
		End

	Declare @Temp2 table
		(TimesheetDate SmallDateTime,
			UserID Int, WeekPeriod varchar(50))

	-- Return all weeks that dont have timesheets/timeoff submitted for the user
	Insert into @Temp2
	(UserID, TimesheetDate, WeekPeriod)
	(Select a.UserID, a.TimesheetDate ,a.WeekPeriod
		From @Temp a left join (
				(
					Select UserID,dbo.WeekStartDate(TimesheetDate) as TimesheetDate,Count(Submitted) as Submitted
					From dbo.TT_Timesheets b
					Where b.UserID = @UserID
					Group By UserID,dbo.WeekStartDate(TimesheetDate),Submitted
				)
				Union
				(
					Select UserID,dbo.WeekStartDate(TimeOffDate) as TimesheetDate,Count(Submitted) as Submitted
					From dbo.TT_TimeOff b
					Where b.UserID = @UserID
					Group By UserID,dbo.WeekStartDate(TimeOffDate),Submitted
				)
			) b on a.UserID = b.UserID and Convert(varchar,a.TimesheetDate,103) = Convert(varchar,b.TimesheetDate,103)
		Where b.Submitted is null
		or b.Submitted = 0
		Group By a.UserID,a.TimesheetDate,a.WeekPeriod
	)
	
	Insert Into @TempTable
	(UserID, TimesheetDate, WeekPeriod)
	(Select Distinct UserID, TimesheetDate, WeekPeriod
	From @Temp2)
End -- Check if user has permission to capture time

Return
End
















GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_WeeksTable]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




-- Calculate Project Weeks


CREATE Function [dbo].[TT_FXN_WeeksTable] (@ProjectID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns @Weeks Table 
	(dd smalldatetime)

As
Begin
--Declare @ProjBud float
Declare @ProjStart smalldatetime
Declare @ProjEnd smalldatetime
--Declare @HrsPerDay float

--Get project budget, start and end dates
--Select @ProjBud = dbo.CalcProjectBudgetHours(@ProjectID)
Select @ProjStart = StartDate, @ProjEnd = EndDate
From dbo.TT_Projects 
Where ProjectID = @ProjectID

--Work out project duration and cost per day
--Select @HrsPerDay = (@ProjBud / DateDiff(dd, @ProjStart, @ProjEnd))

	While @StartDate <= @EndDate
		Begin
			If @StartDate between @ProjStart and @ProjEnd
			Begin
				Insert @Weeks select @StartDate
			End
			Else
			Begin
				Insert @Weeks select @StartDate
			End
			Select @StartDate = dateadd(dd,1,@StartDate)
		End

Return
End










GO
/****** Object:  UserDefinedFunction [dbo].[WeekStartDate]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE Function [dbo].[WeekStartDate](@Date smalldatetime)
RETURNS smalldatetime
AS
BEGIN
----------- NB NB NB NB NB NB NB NB NB NB -----------
-- This function depends on DateFirst being set, 
-- All calling procedures should set DateFirst
-- before calling this Function
----------- NB NB NB NB NB NB NB NB NB NB -----------

-- Work out date of first day of selected week
	Declare @StartDate as smalldatetime
	Set @StartDate = (@Date - (DatePart(dw,@Date) -1))
	RETURN @StartDate
END








GO
/****** Object:  Table [dbo].[Licensing]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Licensing](
	[LicenseKey] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TargetTimeView]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TargetTimeView](
	[targetTime_Id] [int] IDENTITY(1,1) NOT NULL,
	[isAssigned] [bit] NOT NULL,
	[assignedDate] [smalldatetime] NULL,
	[importedDate] [smalldatetime] NOT NULL,
	[TimetraxProjectCode] [nvarchar](50) NOT NULL,
	[TimetraxProjectName] [nvarchar](50) NOT NULL,
	[description] [nvarchar](1350) NULL,
	[firstname] [nvarchar](150) NOT NULL,
	[lastname] [nvarchar](150) NOT NULL,
	[spent] [decimal](18, 4) NOT NULL,
	[spentdate] [smalldatetime] NOT NULL,
	[TargetProcessProject] [text] NULL,
	[EntityName] [text] NULL,
	[EntityID] [int] NULL,
	[EntityType] [nvarchar](100) NULL,
	[TimeID] [int] NULL,
 CONSTRAINT [PK_TargetTimeView1] PRIMARY KEY CLUSTERED 
(
	[targetTime_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_Approvals]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Approvals](
	[ApprovalID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ApprovalTypeID] [int] NOT NULL,
	[ApproverID] [int] NOT NULL,
	[ApprovalDate] [smalldatetime] NOT NULL,
	[ApprovedItemID] [int] NOT NULL,
	[Comment] [varchar](200) NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_TT_Approvals] PRIMARY KEY CLUSTERED 
(
	[ApprovalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_ApprovalTypes]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_ApprovalTypes](
	[ApprovalTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](20) NOT NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_TT_ApprovalTypes] PRIMARY KEY CLUSTERED 
(
	[ApprovalTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_Clients]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Clients](
	[ClientID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ClientCode] [varchar](10) NOT NULL,
	[ClientName] [varchar](50) NOT NULL,
	[PostAddress] [varchar](50) NOT NULL,
	[PostSuburb] [varchar](20) NOT NULL,
	[PostCity] [varchar](20) NULL,
	[PostProvince] [varchar](20) NULL,
	[PostCode] [varchar](10) NOT NULL,
	[PhyAddress] [varchar](50) NULL,
	[PhySuburb] [varchar](20) NULL,
	[PhyCity] [varchar](20) NULL,
	[PhyProvince] [varchar](20) NULL,
	[CountryID] [int] NOT NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_Contacts]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Contacts](
	[ContactID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Title] [varchar](5) NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NULL,
	[Department] [varchar](20) NULL,
	[Phone] [varchar](20) NOT NULL,
	[Fax] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_TT_Contacts] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_CostCentres]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_CostCentres](
	[CostCentreID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CostCentreName] [varchar](50) NOT NULL,
	[ManagerID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_TT_CostCentres] PRIMARY KEY CLUSTERED 
(
	[CostCentreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_Countries]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Countries](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](50) NOT NULL,
	[CurrencyID] [int] NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_Currencies]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Currencies](
	[CurrencyID] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyName] [varchar](20) NULL,
	[CurrencySymbol] [varchar](3) NOT NULL,
	[ExchangeRate] [float] NULL,
 CONSTRAINT [PK_Currencies] PRIMARY KEY CLUSTERED 
(
	[CurrencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_DeletedFinancialDocumentOrderItems]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_DeletedFinancialDocumentOrderItems](
	[DeletedFinDocOrderItemsID] [int] IDENTITY(1,1) NOT NULL,
	[FinDocOrderItemsID] [int] NOT NULL,
	[FinancialDocumentID] [int] NOT NULL,
	[OrderItemID] [int] NOT NULL,
	[Amount] [money] NOT NULL,
	[DeletedByID] [int] NOT NULL,
	[DeletedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TT_DeletedFinancialDocumentOrderItems] PRIMARY KEY CLUSTERED 
(
	[FinDocOrderItemsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_DeletedFinancialDocuments]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_DeletedFinancialDocuments](
	[DeletedFinancialDocID] [int] IDENTITY(1,1) NOT NULL,
	[FinancialDocID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[FinancialDocNo] [varchar](50) NOT NULL,
	[FinancialDocDate] [datetime] NOT NULL,
	[FinancialDocTypeID] [int] NOT NULL,
	[FinancialDocName] [varchar](50) NOT NULL,
	[FinancialDocTitle] [varchar](50) NOT NULL,
	[Filesize] [int] NOT NULL,
	[Submitted] [bit] NULL,
	[ApprovalStage] [int] NULL,
	[UploadedByUserID] [int] NULL,
	[DeletedByUserID] [int] NOT NULL,
	[DeletedDate] [datetime] NULL,
 CONSTRAINT [PK_TT_DeletedFinancialDocuments] PRIMARY KEY CLUSTERED 
(
	[FinancialDocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_Expenses]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Expenses](
	[ExpenseID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserID] [int] NOT NULL,
	[ProjectID] [int] NOT NULL,
	[ExpenseTypeID] [int] NOT NULL,
	[ExpenseDate] [smalldatetime] NOT NULL,
	[Quantity] [float] NOT NULL,
	[UnitCost] [float] NOT NULL,
	[Comment] [varchar](200) NULL,
	[Submitted] [bit] NULL,
	[ApprovalStage] [int] NULL,
	[ExpenseMonth] [smalldatetime] NULL,
 CONSTRAINT [PK_TT_Expenses] PRIMARY KEY CLUSTERED 
(
	[ExpenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_ExpenseTypes]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_ExpenseTypes](
	[ExpenseTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Fixed] [bit] NULL,
	[Amount] [money] NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_TT_ExpenseTypes] PRIMARY KEY CLUSTERED 
(
	[ExpenseTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_FinancialDocTypeUsers]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_FinancialDocTypeUsers](
	[FinancialDocTypeEmailID] [int] IDENTITY(1,1) NOT NULL,
	[FinancialDocTypeID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_TT_FinancialDocTypeUsers] PRIMARY KEY CLUSTERED 
(
	[FinancialDocTypeEmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_FinancialDocumentOrderItems]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_FinancialDocumentOrderItems](
	[FinDocOrderItemsID] [int] IDENTITY(1,1) NOT NULL,
	[FinancialDocumentID] [int] NOT NULL,
	[OrderItemID] [int] NOT NULL,
	[Amount] [money] NOT NULL,
 CONSTRAINT [PK_TT_FinancialDocumentOrderItems] PRIMARY KEY CLUSTERED 
(
	[FinDocOrderItemsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_FinancialDocuments]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_FinancialDocuments](
	[FinancialDocID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[FinancialDocNo] [varchar](50) NOT NULL,
	[FinancialDocDate] [datetime] NOT NULL,
	[FinancialDocTypeID] [int] NOT NULL,
	[FinancialDocName] [varchar](50) NOT NULL,
	[FinancialDocTitle] [varchar](50) NOT NULL,
	[Filesize] [int] NOT NULL,
	[Submitted] [bit] NULL,
	[ApprovalStage] [int] NULL,
	[UploadedByUserID] [int] NULL,
 CONSTRAINT [PK_TT_FinancialDocuments] PRIMARY KEY CLUSTERED 
(
	[FinancialDocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_FinancialDocumentType]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_FinancialDocumentType](
	[FinancialDocTypeID] [int] NOT NULL,
	[FinancialDocType] [varchar](50) NOT NULL,
	[ApprovalRequired] [bit] NOT NULL,
 CONSTRAINT [PK_TT_FinancialDocumentType] PRIMARY KEY CLUSTERED 
(
	[FinancialDocTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_OrderItems]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_OrderItems](
	[OrderItemID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ItemName] [varchar](50) NOT NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_TT_BudgetItems] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_Orders]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Orders](
	[OrderID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ProjectID] [int] NOT NULL,
	[OrderNumber] [varchar](50) NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
	[Approval] [int] NOT NULL,
	[OrderDate] [smalldatetime] NULL,
 CONSTRAINT [PK_TT_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_ProfileProjects]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_ProfileProjects](
	[UserID] [int] NOT NULL,
	[ProjectID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_ProfileTasks]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_ProfileTasks](
	[UserID] [int] NOT NULL,
	[TaskID] [int] NOT NULL,
 CONSTRAINT [PK_TT_ProfileTasks] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[TaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_ProfileTOTypes]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_ProfileTOTypes](
	[UserID] [int] NOT NULL,
	[TypeID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_ProfileTSApproval]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_ProfileTSApproval](
	[UserID] [int] NOT NULL,
	[Grouping] [int] NOT NULL,
 CONSTRAINT [PK_TT_ProfileTSApproval] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_ProfileUser]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_ProfileUser](
	[UserID] [int] NOT NULL,
	[TimeBase] [int] NOT NULL,
	[LastSubDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_TT_ProfileUser] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_ProjectDocuments]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_ProjectDocuments](
	[DocID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ProjectID] [int] NOT NULL,
	[DocumentName] [varchar](50) NULL,
	[Title] [varchar](50) NULL,
	[DocumentDate] [smalldatetime] NULL,
	[Who] [varchar](50) NULL,
	[Filesize] [int] NULL,
 CONSTRAINT [PK_TT_Documents] PRIMARY KEY CLUSTERED 
(
	[DocID] ASC,
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_ProjectOrderItems]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_ProjectOrderItems](
	[ItemID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrderID] [int] NOT NULL,
	[OrderItemID] [int] NOT NULL,
	[Amount] [float] NOT NULL,
 CONSTRAINT [PK_TT_ProjectOrderItems] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_ProjectResources]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_ProjectResources](
	[ResourceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ProjectID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Rate] [float] NOT NULL,
	[FirstApprover] [bit] NULL,
	[LastApprover] [bit] NULL,
	[TSLastApprover] [bit] NULL,
	[TeamLeader] [bit] NULL,
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK_TT_ProjectResources] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_Projects]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Projects](
	[ProjectID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ProjectCode] [varchar](10) NOT NULL,
	[ProjectName] [varchar](50) NOT NULL,
	[FullName] [varchar](100) NOT NULL,
	[ClientID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[AdminContactID] [int] NOT NULL,
	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
	[CostCentreID] [int] NOT NULL,
	[Approval1] [bit] NULL,
	[Approval2] [bit] NULL,
	[Comments] [varchar](500) NULL,
 CONSTRAINT [PK_TT_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_ProjectStatus]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_ProjectStatus](
	[ProjectID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[ApprovalStage] [int] NULL,
 CONSTRAINT [PK_TT_ProjectStatus] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_ProjectTasks]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_ProjectTasks](
	[TaskID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrderID] [int] NOT NULL,
	[TaskName] [varchar](50) NOT NULL,
	[Amount] [float] NOT NULL,
	[Hours] [float] NOT NULL,
	[Billable] [bit] NULL,
 CONSTRAINT [PK_TT_ProjectTasks] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_Rates]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_Rates](
	[RateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserID] [int] NOT NULL,
	[CostCentreID] [int] NOT NULL,
	[Rate] [float] NOT NULL,
 CONSTRAINT [PK_TT_Rates] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[CostCentreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_Status]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Status](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TT_Status] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_System]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TT_System](
	[PTOApprovals] [int] NOT NULL,
	[TSApprovals] [int] NOT NULL,
	[PTOApprover1Role] [int] NOT NULL,
	[PTOApprover2Role] [int] NULL,
	[TSApprover1Role] [int] NOT NULL,
	[TSApprover2Role] [int] NULL,
	[ForceTSComments] [bit] NOT NULL,
	[TaskOrderItem] [int] NOT NULL,
	[UseWindowsAuthentication] [bit] NOT NULL,
	[MonthlyReminderDay] [int] NOT NULL,
	[WeeklyReminderMeridian] [bit] NULL,
	[WeeklyReminderHour] [int] NULL,
	[WeeklyReminderDOW] [int] NOT NULL,
	[WeeklyReminderEnabled] [bit] NOT NULL,
	[WeekStartDay] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TT_TimeOff]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_TimeOff](
	[TimeOffID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[TimeOffDate] [smalldatetime] NOT NULL,
	[Duration] [int] NOT NULL,
	[Comment] [varchar](500) NULL,
	[Submitted] [bit] NULL,
	[ApprovalStage] [int] NULL,
 CONSTRAINT [PK_TT_TimeOff] PRIMARY KEY CLUSTERED 
(
	[TimeOffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_TimeOffTypes]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_TimeOffTypes](
	[TypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_TT_TimeOffTypes] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_Timesheets]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Timesheets](
	[TimesheetID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserID] [int] NOT NULL,
	[TaskID] [int] NOT NULL,
	[TimesheetDate] [smalldatetime] NOT NULL,
	[Duration] [int] NOT NULL,
	[Comment] [varchar](1500) NULL,
	[Submitted] [bit] NULL,
	[ApprovalStage] [int] NULL,
 CONSTRAINT [PK_TT_Timesheets] PRIMARY KEY CLUSTERED 
(
	[TimesheetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TT_Title]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TT_Title](
	[TitleID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](5) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usr_BusinessUnit]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usr_BusinessUnit](
	[UnitID] [int] NOT NULL,
	[UnitName] [varchar](100) NOT NULL,
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK_BusinessUnit] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usr_GroupName]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usr_GroupName](
	[GroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Descript] [varchar](30) NULL,
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK_GroupName] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usr_GroupPermission]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usr_GroupPermission](
	[GroupID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_GroupPermission] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usr_RoleName]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usr_RoleName](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_RoleName] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usr_UserDetail]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usr_UserDetail](
	[UserID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserName] [varchar](30) NOT NULL,
	[Password] [char](25) NOT NULL,
	[Position] [varchar](100) NULL,
	[TelNo] [varchar](30) NULL,
	[SMSNo] [varchar](30) NULL,
	[EMail] [varchar](50) NULL,
	[RecSMS] [bit] NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[Initials] [varchar](3) NOT NULL,
	[UnitID] [int] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[TotalLogin] [int] NULL,
	[LastLoginDate] [smalldatetime] NULL,
	[EmployeeCode] [varchar](6) NULL,
 CONSTRAINT [PK_UserDetail] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usr_UserGroup]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usr_UserGroup](
	[UserID] [int] NOT NULL,
	[GroupID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebMail_Addresses]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WebMail_Addresses](
	[Recipient] [int] NOT NULL,
	[email] [varchar](255) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WebMail_Recipients]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebMail_Recipients](
	[RecipientID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[RegionID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebMail_Types]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WebMail_Types](
	[TypeID] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WebMail_Waiting]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WebMail_Waiting](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[MailTo] [varchar](255) NULL,
	[Sender] [varchar](255) NULL,
	[Subject] [varchar](50) NOT NULL,
	[Body] [varchar](1000) NULL,
	[Priority] [varchar](50) NOT NULL,
	[AttachList] [varchar](500) NULL,
	[Cap_Date] [smalldatetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[ApprovedTimesheets]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /************************************************************************************************************  
Created by: VF  
Created on: ???  
Does:  Returns a list of Approved Timesheet ID's for the given project  
  
Modified:  
  
05/10/2005 by SD: Make this work for when a ProjectID of 0 is passed in
25/04/2012 by SD: Change the approval stage from 2 to 4 as there are now 3 levels of approval  
************************************************************************************************************/  
CREATE Function [dbo].[ApprovedTimesheets](@ProjectID as int)  
Returns Table  
As  
Return  
(  
/*Select TimesheetID From  
dbo.TT_Approvals a inner join  
dbo.TT_Timesheets b on a.ApprovedItemID = b.TimesheetID inner join  
 (Select TaskID, UserID From  
 dbo.TT_ProjectTasks a inner join  
 dbo.TT_Orders b on a.OrderID = b.OrderID inner join  
 dbo.TT_ProjectResources c on b.ProjectID = c.ProjectID  
 Where TSLastApprover = 1 and Case When @ProjectID = 0 Then 0 Else b.ProjectID End = @ProjectID) c on b.TaskID = c.TaskID and a.ApproverID = c.UserID  
Where a.ApprovalTypeID = 2  
And a.Approved = 1*/  
  
  
Select   Distinct TimesheetID   
From  dbo.TT_Approvals a   
inner join  dbo.TT_Timesheets b on a.ApprovedItemID = b.TimesheetID   
inner join  dbo.TT_ProjectTasks c on c.TaskID = b.TaskID  
inner join dbo.TT_Orders d on d.OrderID = c.OrderID  
Where   a.ApprovalTypeID = 2  
and   b.ApprovalStage = 4  
and   Approved = 1    
and   Case When @ProjectID = 0 Then 0 Else d.ProjectID End = @ProjectID  
  
)  
  



GO
/****** Object:  View [dbo].[TT_View_ProjectData]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[TT_View_ProjectData]
AS
Select a.*,
	b.OrderId, b.OrderNumber, b.EndDate as OrderEndDate, b.Approval,
	c.TaskID, c.TaskName, Cast(isnull(c.Amount,0) as Decimal(19,2)) as Amount, c.Hours, c.Billable
From dbo.TT_Projects a
Join dbo.TT_Orders b on a.ProjectID = b.ProjectID
Join dbo.TT_ProjectTasks c on b.OrderID = c.OrderID





GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ApprovedUserHours]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE Function [dbo].[TT_FXN_ApprovedUserHours](@UserID as Int,@ProjectID as Int)
Returns Table
AS
Return(	
	Select a.UserID, isnull(dbo.ConvertToHours(BillDuration,100),0) as BillHours,isnull(dbo.ConvertToHours(NonBillDuration,100),0) as NonBillHours, a.TimesheetDate 
	From
	(
		Select b.UserID, Duration as BillDuration, b.TimesheetDate
		From dbo.TT_View_ProjectData a
		join  dbo.TT_Timesheets b on a.TaskID = b.TaskID
		where Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
		and Case When @UserID = 0 Then 0 Else b.UserID End = @UserID
		and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
		and a.Billable = 1
	) a left join
	(
		Select b.UserID, Duration as NonBillDuration, b.TimesheetDate
		From dbo.TT_View_ProjectData a
		join  dbo.TT_Timesheets b on a.TaskID = b.TaskID
		where Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
		and Case When @UserID = 0 Then 0 Else b.UserID End = @UserID
		and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
		and a.Billable <> 1
	) b on a.UserID = b.UserID and a.TimesheetDate = b.TimesheetDate
)








GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ProfitTable_Fin]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE Function [dbo].[TT_FXN_ProfitTable_Fin](@ProjectID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns Table
/*
(
Week as Int,
Billable as Decimal(19,2),
NonBillable as Decimal(19,2)
)
*/
Return(
	Select DatePart(wk,a.dd) as [Week], Year(a.dd) as Yr, Sum(isNull(BillHours, 0) * isNull(dbo.GetProjectUserRate(UserID,@ProjectID), 0)) as Billable, Sum(isNull(NonBillHours, 0) * isNull(dbo.GetProjectUserRate(UserID,@ProjectID), 0)) as NonBillable
	From dbo.TT_FXN_WeeksTable(@ProjectID, @StartDate, @EndDate) a left join
	dbo.TT_FXN_ApprovedUserHours(0,@ProjectID) b on Convert(varchar, a.dd, 103) = Convert(varchar, b.TimeSheetDate, 103)
	Where a.dd Between @StartDate and @EndDate
	Group By Year(a.dd), DatePart(wk,a.dd)
)










GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ProfitTable_Time]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE Function [dbo].[TT_FXN_ProfitTable_Time](@ProjectID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns Table
/*
(
Week as Int,
Billable as Decimal(19,2),
NonBillable as Decimal(19,2)
)
*/
Return(
	Select DatePart(wk,a.dd) as [Week], Year(a.dd) as Yr, Sum(isNull(BillHours, 0)) as Billable, Sum(isNull(NonBillHours, 0)) as NonBillable
	From dbo.TT_FXN_WeeksTable(@ProjectID, @StartDate, @EndDate) a left join
	dbo.TT_FXN_ApprovedUserHours(0,@ProjectID) b on Convert(varchar, a.dd, 103) = Convert(varchar, b.TimeSheetDate, 103)
	Where a.dd Between @StartDate and @EndDate
	Group By Year(a.dd), DatePart(wk,a.dd)
)










GO
/****** Object:  UserDefinedFunction [dbo].[ApprovedUserHours]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE Function [dbo].[ApprovedUserHours](@UserID as Int,@ProjectID as Int)
Returns Table
AS
Return(	
	Select b.UserID, isnull(dbo.ConvertToHours(Duration,100),0) as Hours, TimesheetDate 
--Select *
	From dbo.TT_View_ProjectData a
	join  dbo.TT_Timesheets b on a.TaskID = b.TaskID
	where Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
	and Case When @UserID = 0 Then 0 Else b.UserID End = @UserID
	and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
)








GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ProjStatusTable_Time]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE Function [dbo].[TT_FXN_ProjStatusTable_Time](@ProjectID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns Table
/*
(
Mnth as DateTime,
Budget as Decimal(19,2),
TimeCost as Decimal(19,2),
ExpCost as Decimal(19,2),
Total as Decimal(19,2)
)
*/
Return(

	
	Select Month(a.dd) as Mnth, Year(a.dd) as Yr, Sum(isNull(DayBud, 0)) as Budget, Sum(isNull(Hours, 0)) as TimeCost, .00 as ExpCost
	From dbo.TT_FXN_MonthHoursTable(@ProjectID, @StartDate, @EndDate) a left join
	dbo.ApprovedUserHours(0,@ProjectID) b on Convert(varchar, a.dd, 103) = Convert(varchar, b.TimeSheetDate, 103)
  --left join dbo.ApprovedUserExpenses(0,@ProjectID) c on Convert(varchar, a.dd, 103)  = Convert(varchar, c.ExpenseDate, 103)
	Where a.dd Between @StartDate and @EndDate
	Group By Year(a.dd), Month(a.dd)
)







GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_PTOApproverProjects]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- This function will return a list of projects for which the user is a Project Take On approver
-- and whether the user is FIRST or LAST approver
--
--Modified:
--14/07/2005 by SB - return UserID so that it can be used in joins and it returns all users that are approvers if a zero is passed in
CREATE Function [dbo].[TT_FXN_PTOApproverProjects](@UserID as int)
Returns Table
As
Return
(
Select 	a.ProjectID,
	Case When b.FirstApprover is not Null Then 
		'1' 
	Else 
		'2' End  as Approver,
	b.UserID
From 	dbo.TT_Projects a 
join	dbo.TT_ProjectResources b on a.ProjectID = b.ProjectID
Where 	(b.UserID = @UserID OR @UserID = 0)
-- And User is a PTO Approver
and 	(FirstApprover = 1 or LastApprover = 1)
)














GO
/****** Object:  View [dbo].[TT_View_UserDetails]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TT_View_UserDetails]
AS
SELECT     UserID AS UserID, UserName AS UserName, LastName AS LastName, FirstName AS FirstName, FirstName + ' ' + LastName AS FullName
FROM         dbo.Usr_UserDetail




GO
/****** Object:  UserDefinedFunction [dbo].[UserProjects]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Function [dbo].[UserProjects](@UserID as int)
Returns Table
As
Return
(
Select a.ProjectID
From dbo.TT_Projects a join
dbo.TT_ProjectResources b on a.ProjectID = b.ProjectID
Where b.UserID = @UserID
)







GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_PTOProjectsAwaitingApproval]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*****************************************************************************************************************
Created by:	SD
Created on:	01/12/2005
Does:		Returns a list of all projects awaiting approval for a user
Used in:		TT_SelectStartAlerts
*****************************************************************************************************************/
CREATE         Function [dbo].[TT_FXN_PTOProjectsAwaitingApproval](@UserID as int)
Returns Table
As
Return
(
Select 
		'PTOApprove' as Message,
		'<a href=''Approvals/PTO.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+a.ProjectCode +'</a>'+ '&nbsp;&nbsp;'+ ProjectName + ' - ' + d.FullName as Detail,
		a.ProjectID,
		d.UserID as ApproverID
From 
		(Select 
			ProjectID, ProjectCode, ProjectName 
	 	From 	
			TT_Projects 
	 	Where  
			ProjectID in (select ProjectID From dbo.UserProjects(@UserID))) a 
Inner Join  	dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID
Inner Join  	 TT_FXN_PTOApproverProjects(0) c ON b.ProjectID = c.ProjectID and b.ApprovalStage = c.Approver
Inner Join  	TT_View_UserDetails d ON d.UserID = c.UserID
Where StatusID = 2
)

















GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_VOAwaitingApproval]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*****************************************************************************************************************
Created by:	SD
Created on:	01/12/2005
Does:		Returns a list of all VO's awaiting approval for a user
Used in:		TT_SelectStartAlerts
*****************************************************************************************************************/
CREATE         Function [dbo].[TT_FXN_VOAwaitingApproval](@UserID as int)
Returns Table
As
Return
(

Select  	
	'VOApprove' as Message,
	'<a href=''Approvals/VO.aspx?ProjID='+ Cast(a.ProjectID as varchar)+'''>'+a.ProjectCode +'</a>'+ '&nbsp;&nbsp;'+ ProjectName as Detail,
	a.ProjectID,
	c.UserID as ApproverID
From 
(	Select 
		ProjectID, ProjectCode, ProjectName 
	From 
		TT_Projects where ProjectID in (select ProjectID From dbo.UserProjects(@UserID))) a 
Inner Join 	dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID
Inner Join	TT_FXN_PTOApproverProjects(0) c ON a.ProjectID = c.ProjectID and b.ApprovalStage = c.Approver
Where 		StatusID not in (2, 3, 4) 

)

















GO
/****** Object:  View [dbo].[TT_View_ApprovedByMDExpenses]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    
/***********************************************************    
Created by: SD    
Created on: 07/02/2012
Does:  Lists all expenses that have been approved by the MD     
***********************************************************/    
CREATE View [dbo].[TT_View_ApprovedByMDExpenses]    
    
AS    
    
SELECT      
  ExpenseID, ApproverID       
FROM        
  TT_Approvals a INNER JOIN    
  TT_Expenses b on a.ApprovedItemID = b.ExpenseID     
WHERE       
  a.ApprovalTypeID = 3 AND     
  a.Approved = 1  AND    
  b.ApprovalStage = 4    
    
  
    



GO
/****** Object:  View [dbo].[TT_View_SubmittedExpensesUnapprovedByMD]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

            
/***********************************************************            
Created by: SD            
Created on: 07/02/2012            
Does:  Lists all submitted expenses that haven't been approved            
   by the MD            
***********************************************************/            
CREATE View [dbo].[TT_View_SubmittedExpensesUnapprovedByMD]            
            
AS            
            
SELECT             
 ExpenseID    
 ,UserID    
 ,ProjectID    
 ,ExpenseDate    
 ,ExpenseTypeID     
 ,Quantity    
 ,UnitCost    
 ,Comment  
 ,ExpenseMonth     
 ,Submitted     
FROM              
 TT_Expenses a             
WHERE             
 ExpenseID not in ( SELECT ExpenseID            
      FROM TT_View_ApprovedByMDExpenses             
      )            
 AND Submitted = 1       
 AND ApprovalStage = 3	



GO
/****** Object:  View [dbo].[TT_View_ApprovedByMDTimesheets]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
/***********************************************************  
Created by: SD  
Created on: 06/02/2012
Does:  Lists all timesheets that have been approved by the MD   
***********************************************************/  
CREATE View [dbo].[TT_View_ApprovedByMDTimesheets]  
  
AS  
  
SELECT    
  TimesheetID, ApproverID     
FROM      
  TT_Approvals a INNER JOIN  
  TT_Timesheets b on a.ApprovedItemID = b.TimesheetID   
WHERE     
  a.ApprovalTypeID = 2 AND   
  a.Approved = 1  AND  
  b.ApprovalStage = 4  
  
  



GO
/****** Object:  View [dbo].[TT_View_SubmittedTimesheetsUnapprovedByMD]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

            
/***********************************************************            
Created by: SD            
Created on: 06/02/2012            
Does:  Lists all submitted timesheets that haven't been approved            
   by the MD            
***********************************************************/            
CREATE View [dbo].[TT_View_SubmittedTimesheetsUnapprovedByMD]            
            
AS            
            
SELECT             
 TimesheetID          
 , TimeSheetDate             
 , ApprovalStage        
 , UserID        
 , TaskID          
 , Comment        
 , Duration            
FROM              
 TT_Timesheets a             
WHERE             
 TimesheetID not in ( SELECT TimesheetID            
      FROM TT_View_ApprovedByMDTimesheets             
      )            
 AND Submitted = 1       
 AND ApprovalStage = 3 



GO
/****** Object:  UserDefinedFunction [dbo].[ApprovedExpenses]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
 /*****************************************************************************************************  
Created by: VF  
Created on: ??  
Does:  Returns a list of approved expenses  
Used in:  TT_SelectStartAlerts  
  
Modified:  
  
11/08/2005 by SB:  Changed the filter on @Project = 0 to work the same as Timesheets  
05/10/2005 by SD: Changed function to use approval stage as this means that the function will work for 
25/04/2012 by SD: Change the approval stage from 2 to 4 as there are now 3 levels of approval    
*****************************************************************************************************/  
CREATE Function [dbo].[ApprovedExpenses](@ProjectID as int)  
Returns Table  
As  
Return  
(  
/*Select Distinct ExpenseID From  
dbo.TT_Approvals a inner join  
dbo.TT_Expenses b on a.ApprovedItemID = b.ExpenseID inner join  
( Select  UserID   
 From dbo.TT_ProjectResources  
 Where  TSLastApprover = 1 and Case When @ProjectID = 0 Then 0 Else ProjectID End = @ProjectID) c on a.ApproverID = c.UserID  
Where a.ApprovalTypeID = 3*/  
  
Select Distinct ExpenseID From  
dbo.TT_Approvals a inner join  
dbo.TT_Expenses b on a.ApprovedItemID = b.ExpenseID   
Where a.ApprovalTypeID = 3  
and b.ApprovalStage = 4 
and Approved = 1    
and Case When @ProjectID = 0 Then 0 Else ProjectID End = @ProjectID  
  
)  
  



GO
/****** Object:  UserDefinedFunction [dbo].[ApprovedUserExpenses]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE Function [dbo].[ApprovedUserExpenses](@UserID as Int, @ProjectID as Int)
Returns Table
AS
Return(
	Select isnull(UnitCost,0) as UnitCost, isnull(Quantity,0) as Quantity, ExpenseDate
	From dbo.TT_Expenses
	where Case When @ProjectID = 0 Then 0 Else ProjectID End = @ProjectID
	and Case When @UserID = 0 Then 0 Else UserID End = @UserID
	and ExpenseID in (select ExpenseID from dbo.ApprovedExpenses(@ProjectID))
)







GO
/****** Object:  View [dbo].[TT_View_ApprovedByManagerExpenses]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/***********************************************************  
Created by: SD  
Created on: 22/02/2010  
Does:  Lists all expenses that have been approved by the manager   
***********************************************************/  
CREATE View [dbo].[TT_View_ApprovedByManagerExpenses]  
  
AS  
  
SELECT    
  ExpenseID, ApproverID     
FROM      
  TT_Approvals a INNER JOIN  
  TT_Expenses b on a.ApprovedItemID = b.ExpenseID   
WHERE     
  a.ApprovalTypeID = 3 AND   
  a.Approved = 1  AND  
  b.ApprovalStage = 3  
  

  



GO
/****** Object:  View [dbo].[TT_View_SubmittedExpensesUnapprovedByManager]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
          
/***********************************************************          
Created by: SD          
Created on: 22/02/2010          
Does:  Lists all submitted expenses that haven't been approved          
   by the Manager          
***********************************************************/          
CREATE View [dbo].[TT_View_SubmittedExpensesUnapprovedByManager]          
          
AS          
          
SELECT           
 ExpenseID  
 ,UserID  
 ,ProjectID  
 ,ExpenseDate  
 ,ExpenseTypeID   
 ,Quantity  
 ,UnitCost  
 ,Comment
 ,ExpenseMonth   
 ,Submitted   
FROM            
 TT_Expenses a           
WHERE           
 ExpenseID not in ( SELECT ExpenseID          
      FROM TT_View_ApprovedByManagerExpenses           
      )          
 AND Submitted = 1     
 AND ApprovalStage = 2  



GO
/****** Object:  View [dbo].[TT_View_ApprovedByTeamleaderExpenses]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***********************************************************  
Created by: SD  
Created on: 22/02/2010  
Does:  Lists all expenses that have been approved by the teamleader   
***********************************************************/  
CREATE View [dbo].[TT_View_ApprovedByTeamleaderExpenses]  
  
AS  
  
SELECT    
  ExpenseID
  , ApproverID     
FROM      
  TT_Approvals a 
	INNER JOIN TT_Expenses b 
		ON a.ApprovedItemID = b.ExpenseID   
WHERE     
  a.ApprovalTypeID = 3 AND   
  a.Approved = 1  AND  
  b.ApprovalStage = 2  
  



GO
/****** Object:  View [dbo].[TT_View_SubmittedExpensesUnapprovedByTeamLeader]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
/***********************************************************      
Created by: SD      
Created on: 22/02/2010      
Does:  Lists all submitted expenses that haven't been approved      
   by the teamleader      
***********************************************************/      
CREATE View [dbo].[TT_View_SubmittedExpensesUnapprovedByTeamLeader]      
      
AS      
      
SELECT       
  ExpenseID
  , UserID
  , ProjectID
  , ExpenseTypeID
  , ExpenseDate
  , Quantity
  , UnitCost
  , Comment
  , Submitted
  , ApprovalStage
  , ExpenseMonth
FROM        
  TT_Expenses a       
WHERE       
  ExpenseID not in ( SELECT ExpenseID      
        FROM TT_View_ApprovedByTeamleaderExpenses       
       )      
AND       
  Submitted = 1      
AND   
  ApprovalStage = 1  
  
  




GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TSApproverProjects]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************
Created by: VF
Created on: ??
Does:		This function will return a list of projects for which the user is a Timesheet/Expense approver  
			and whether the user is FIRST or LAST approver  
Modified:

02/02/2010 by SD: Changed TSFirstApprover to Teamleader since the Teamleader
			is always the first approver
***************************************************************/
CREATE Function [dbo].[TT_FXN_TSApproverProjects](@UserID as int)  
Returns Table  
As  
Return  
(  
	Select 
		a.ProjectID,   
	Case 
		When b.TeamLeader is not Null Then '1' Else '2' End  as Approver  
	From 
		dbo.TT_Projects a join  
		dbo.TT_ProjectResources b on a.ProjectID = b.ProjectID  
	Where 
		b.UserID = @UserID  
	and (TeamLeader = 1 or TSLastApprover = 1)  
)  
  
  



GO
/****** Object:  View [dbo].[TT_View_MDApprovers]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************************************                
Created by: SD               
Created on: 06/02/2012
Does:   Retrieves the timesheets awaiting approval for the given week for the specified user               
  who is a MD (Based on TT_SelectTimesheetApprovals_ByProject)              
                
Modified:                
                
*************************************************************************************/  
CREATE VIEW [dbo].[TT_View_MDApprovers]
AS

SELECT 	Distinct UserID 
FROM	Usr_GroupPermission a 
				INNER JOIN Usr_UserGroup b ON a.GroupID = b.GroupID
WHERE	a.RoleID = 72



GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ExpensesAwaitngApprovalForUser]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /************************************************************************************************************    
Created by: SD    
Created on: 11/10/2005    
Does:  Returns a list of expenses awaiting approval for a user    
Used in:  TT_SelectStartAlerts and TT_GetimesheetsAwaitngApprovalForUser    
  
Modified:  
  
22/02/2010 by SD: Added the Manager and ManagerMonitor alerts  
07/02/2012 by SD: Added the MD alerts
************************************************************************************************************/    
CREATE Function [dbo].[TT_FXN_ExpensesAwaitngApprovalForUser](@UserID as Int, @ApplicationPath as varchar(100))    
Returns Table    
Return(    
     
 Select  Message,     
  Detail,     
  UserName,    
  Period    
 From    
  (Select    
  Distinct 'ExpenseApprovalTeamleader' as Message,    
  '<a href=''' + @ApplicationPath + '/Approvals/Expense.aspx?Date='+ Convert(varchar,a.ExpenseMonth,101)+'''>'+d.FirstName + ' ' + d.LastName +'</a>'+ '&nbsp;&nbsp;('+ DateName(month,a.ExpenseMonth)+ '&nbsp;'+ Cast(Year(a.ExpenseMonth) as varchar)+ ')' as
 Detail,    
  d.FirstName + ' ' + d.LastName as UserName,    
  DateName(month,a.ExpenseMonth)+ '&nbsp;'+ Cast(Year(a.ExpenseMonth) as varchar) as Period    
  From    
  TT_View_SubmittedExpensesUnapprovedByTeamleader a    
  INNER JOIN TT_Projects b     
  on a.ProjectID = b.ProjectID      
  INNER JOIN TT_Clients c     
  on b.ClientID = c.ClientID    
  INNER JOIN Usr_UserDetail d  
  on a.UserID = d.UserID      
 WHERE    
      a.ProjectID in ( SELECT ProjectID             
   FROM   dbo.TT_FXN_TSApproverProjects(@UserID)            
   WHERE  Approver = 1)  -- Timesheet First approver ie. Teamleader        
   ) a    
 Group By Message, UserName, Detail, Period    
UNION  
 Select  Message,     
  Detail,     
  UserName,    
  Period    
 From    
  (Select    
  Distinct 'ExpenseApprovalManager' as Message,    
  '<a href=''' + @ApplicationPath + '/Approvals/Expense.aspx?Date='+ Convert(varchar,a.ExpenseMonth,101)+'''>'+d.FirstName + ' ' + d.LastName +'</a>'+ '&nbsp;&nbsp;('+ DateName(month,a.ExpenseMonth)+ '&nbsp;'+ Cast(Year(a.ExpenseMonth) as varchar)+ ')' as
 Detail,    
  d.FirstName + ' ' + d.LastName as UserName,    
  DateName(month,a.ExpenseMonth)+ '&nbsp;'+ Cast(Year(a.ExpenseMonth) as varchar) as Period    
  From    
  TT_View_SubmittedExpensesUnapprovedByManager a    
  INNER JOIN TT_Projects b     
  on a.ProjectID = b.ProjectID      
  INNER JOIN TT_Clients c     
  on b.ClientID = c.ClientID    
  INNER JOIN Usr_UserDetail d  
  on a.UserID = d.UserID      
 WHERE    
      a.ProjectID in ( SELECT ProjectID             
   FROM   dbo.TT_FXN_TSApproverProjects(@UserID)            
   WHERE  Approver = 2)  -- Timesheet Last approver ie. Manager       
   ) a    
 Group By Message, UserName, Detail, Period    
UNION  
 Select  Message,     
  Detail,     
  UserName,    
  Period    
 From    
  (Select    
  Distinct 'ExpenseApprovalManagerMonitor' as Message,    
  '<a href=''' + @ApplicationPath + '/Approvals/Expense.aspx?Date='+ Convert(varchar,a.ExpenseMonth,101)+'''>'+d.FirstName + ' ' + d.LastName +'</a>'+ '&nbsp;&nbsp;('+ DateName(month,a.ExpenseMonth)+ '&nbsp;'+ Cast(Year(a.ExpenseMonth) as varchar)+ ')' as
 Detail,    
  d.FirstName + ' ' + d.LastName as UserName,    
  DateName(month,a.ExpenseMonth)+ '&nbsp;'+ Cast(Year(a.ExpenseMonth) as varchar) as Period    
  From    
  TT_View_SubmittedExpensesUnapprovedByTeamleader a    
  INNER JOIN TT_Projects b     
  on a.ProjectID = b.ProjectID      
  INNER JOIN TT_Clients c     
  on b.ClientID = c.ClientID   
  INNER JOIN Usr_UserDetail d  
  on a.UserID = d.UserID     
 WHERE    
      a.ProjectID in ( SELECT ProjectID             
   FROM   dbo.TT_FXN_TSApproverProjects(@UserID)            
   WHERE  Approver = 2)  -- Timesheet Last approver ie. Manager       
   ) a    
 Group By Message, UserName, Detail, Period    
 UNION  
 Select  Message,     
  Detail,     
  UserName,    
  Period    
 From    
  (Select    
  Distinct 'ExpenseApprovalMD' as Message,    
  '<a href=''' + @ApplicationPath + '/Approvals/Expense.aspx?Date='+ Convert(varchar,a.ExpenseMonth,101)+'''>'+d.FirstName + ' ' + d.LastName +'</a>'+ '&nbsp;&nbsp;('+ DateName(month,a.ExpenseMonth)+ '&nbsp;'+ Cast(Year(a.ExpenseMonth) as varchar)+ ')' as
 Detail,    
  d.FirstName + ' ' + d.LastName as UserName,    
  DateName(month,a.ExpenseMonth)+ '&nbsp;'+ Cast(Year(a.ExpenseMonth) as varchar) as Period    
  From    
  TT_View_SubmittedExpensesUnapprovedByMD a    
  INNER JOIN TT_Projects b     
  on a.ProjectID = b.ProjectID      
  INNER JOIN TT_Clients c     
  on b.ClientID = c.ClientID    
  INNER JOIN Usr_UserDetail d  
  on a.UserID = d.UserID      
 WHERE    
      @UserID in (SELECT UserID 
				  FROM dbo.TT_View_MDApprovers)
   ) a    
 Group By Message, UserName, Detail, Period    
)  
  
  
/*    
     
   dbo.TT_Projects a  join    
   dbo.TT_ProjectStatus b on a.ProjectID = b.ProjectID join    
   dbo.TT_Expenses c on a.ProjectID = c.ProjectID join    
   dbo.Usr_UserDetail d on c.UserID = d.UserID    
  Where  StatusID = 3  -- Project currently in Progress    
  And  c.Submitted = 1 -- Submitted Expenses    
  And  c.ExpenseID not in (select ExpenseID from dbo.ApprovedExpenses(0)) -- Expense is Not yet approved    
  And  a.ProjectID in (select ProjectID From dbo.TT_FXN_TSApproverProjects(@UserID))  -- Current user is relevant stage approver for the project    
  ) a    
 Group By Message, UserName, Detail, Period    
)  */  
    
    
    
    
    
    
    
    
    
    
    
    
    
    



GO
/****** Object:  View [dbo].[TT_View_ApprovedByManagerTimesheets]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
/***********************************************************  
Created by: SD  
Created on: 04/02/2010  
Does:  Lists all timesheets that have been approved by the manager   
***********************************************************/  
CREATE View [dbo].[TT_View_ApprovedByManagerTimesheets]  
  
AS  
  
SELECT    
  TimesheetID, ApproverID     
FROM      
  TT_Approvals a INNER JOIN  
  TT_Timesheets b on a.ApprovedItemID = b.TimesheetID   
WHERE     
  a.ApprovalTypeID = 2 AND   
  a.Approved = 1  AND  
  b.ApprovalStage = 4  
  
  



GO
/****** Object:  View [dbo].[TT_View_SubmittedTimesheetsUnapprovedByManager]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        
/***********************************************************        
Created by: SD        
Created on: 05/02/2010        
Does:  Lists all submitted timesheets that haven't been approved        
   by the Manager        
***********************************************************/        
CREATE View [dbo].[TT_View_SubmittedTimesheetsUnapprovedByManager]        
        
AS        
        
SELECT         
 TimesheetID      
 , TimeSheetDate         
 , ApprovalStage    
 , UserID    
 , TaskID      
 , Comment    
 , Duration        
FROM          
 TT_Timesheets a         
WHERE         
 TimesheetID not in ( SELECT TimesheetID        
      FROM TT_View_ApprovedByManagerTimesheets         
      )        
 AND Submitted = 1   
 AND ApprovalStage = 2



GO
/****** Object:  View [dbo].[TT_View_ApprovedByTeamleaderTimesheets]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************  
Created by: SD  
Created on: 04/02/2010  
Does:  Lists all timesheets that have been approved by the teamleader   
***********************************************************/  
CREATE View [dbo].[TT_View_ApprovedByTeamleaderTimesheets]  
  
AS  
  
SELECT    
  TimesheetID, ApproverID     
FROM      
  TT_Approvals a INNER JOIN  
  TT_Timesheets b on a.ApprovedItemID = b.TimesheetID   
WHERE     
  a.ApprovalTypeID = 2 AND   
  a.Approved = 1  AND  
  b.ApprovalStage = 4  
  
  



GO
/****** Object:  View [dbo].[TT_View_SubmittedTimesheetsUnapprovedByTeamLeader]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
/***********************************************************    
Created by: SD    
Created on: 04/02/2010    
Does:  Lists all submitted timesheets that haven't been approved    
   by the teamleader    
***********************************************************/    
CREATE View [dbo].[TT_View_SubmittedTimesheetsUnapprovedByTeamLeader]    
    
AS    
    
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
        FROM TT_View_ApprovedByTeamleaderTimesheets     
       )    
AND     
  Submitted = 1    
AND 
  ApprovalStage = 1




GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetsAwaitngApprovalForUser]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

        
        
        
        
/************************************************************************************************************        
Created by: SD        
Created on: 07/10/2005        
Does:  Returns a list of timesheets awaiting approval for a user        
Used in:  TT_SelectStartAlerts and TT_GetimesheetsAwaitngApprovalForUser        
        
Modified:        
        
27/02/2006 - Put in an extra check for not showing approved time.  This check is needed as the team leader may         
      have changed, and hence the previous team leader may have approved items        
05/01/2010 by SD - Added the Manager Timesheet Approval Alert and the Manager Monitoring Timesheet Alert      
06/02/2012 by SD - Added the MD Approval Alert
************************************************************************************************************/        
CREATE Function [dbo].[TT_FXN_TimesheetsAwaitngApprovalForUser](@UserID as Int, @ApplicationPath as varchar(100))        
Returns Table        
Return(        
         
SELECT   -- Timesheets awaiting approval by the Teamleader to be shown on the TeamLeader's alerts      
 DISTINCT Message, Detail, UserName, WeekStart, Period        
FROM         
 (SELECT       
   'TimesheetApprovalTeamLeader' as Message,        
   '<a href=''' + @ApplicationPath + '/Approvals/Timesheet.aspx?Date='+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate),101)+'''>' + convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c
  
    
.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103) +'</a>' as Detail,        
   d.FirstName + ' ' + d.LastName as UserName,        
   dbo.WeekStartDate(c.TimesheetDate) as WeekStart,        
   convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103)  as Period        
  FROM      
   TT_View_SubmittedTimesheetsUnapprovedByTeamLeader c  join  -- Table c is the list of unapproved but submitted timesheets         
   dbo.Usr_UserDetail d on c.UserID = d.UserID join        
   dbo.TT_View_ProjectData a on c.TaskID = a.TaskID     
 WHERE       
  a.ProjectID in ( SELECT ProjectID         
       FROM dbo.TT_FXN_TSApproverProjects(@UserID)        
       WHERE  Approver = 1  -- Timesheet First approver ie. Teamleader        
  )  -- Current user is the relevant stage approver for the project        
 ) a        
UNION       
SELECT   -- Timesheets awaiting approval by the Manager to be shown on the Managers alerts      
 DISTINCT Message, Detail, UserName, WeekStart, Period        
FROM         
 (SELECT       
   'TimesheetApprovalManager' as Message,        
   '<a href=''' + @ApplicationPath + '/Approvals/Timesheet.aspx?Date='+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate),101)+'''>' + convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c
  
    
.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103) +'</a>' as Detail,        
   d.FirstName + ' ' + d.LastName as UserName,        
   dbo.WeekStartDate(c.TimesheetDate) as WeekStart,        
   convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103)  as Period        
  FROM      
   TT_View_SubmittedTimesheetsUnapprovedByManager c  join          
   dbo.Usr_UserDetail d on c.UserID = d.UserID join        
   dbo.TT_View_ProjectData a on c.TaskID = a.TaskID    
 WHERE       
  a.ProjectID in ( SELECT ProjectID         
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)        
       WHERE  Approver = 2  -- Timesheet 2nd approver ie. Manager       
  )  -- Current user is the relevant stage approver for the project        
 ) a        
UNION      
SELECT -- Timesheets awaiting approval by the Teamleader but to be shown on the Managers alerts       
 DISTINCT Message, Detail, UserName, WeekStart, Period        
FROM         
 (SELECT       
   'TimesheetApprovalTeamLeaderMonitor' as Message,        
   '<a href=''' + @ApplicationPath + '/Approvals/Timesheet.aspx?Date='+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate),101)+'''>' + convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c
  
.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103) +'</a>' as Detail,        
   d.FirstName + ' ' + d.LastName as UserName,        
   dbo.WeekStartDate(c.TimesheetDate) as WeekStart,        
   convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103)  as Period        
  FROM      
   TT_View_SubmittedTimesheetsUnapprovedByTeamleader c  join          
   dbo.Usr_UserDetail d on c.UserID = d.UserID join        
   dbo.TT_View_ProjectData a on c.TaskID = a.TaskID       
 WHERE       
  a.ProjectID in ( SELECT ProjectID         
       FROM   dbo.TT_FXN_TSApproverProjects(@UserID)        
       WHERE  Approver = 2  -- Timesheet Last approver ie. Manager       
  )  -- Current user is the relevant stage approver for the project        
 ) a   
 UNION       
SELECT   -- Timesheets awaiting approval by the MD to be shown on the MD's alerts      
 DISTINCT Message, Detail, UserName, WeekStart, Period        
FROM         
 (SELECT       
   'TimesheetApprovalMD' as Message,        
   '<a href=''' + @ApplicationPath + '/Approvals/Timesheet.aspx?Date='+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate),101)+'''>' + convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103) +'</a>' as Detail,        
   d.FirstName + ' ' + d.LastName as UserName,        
   dbo.WeekStartDate(c.TimesheetDate) as WeekStart,        
   convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103)  as Period        
  FROM      
   TT_View_SubmittedTimesheetsUnapprovedByMD c  join          
   dbo.Usr_UserDetail d on c.UserID = d.UserID join        
   dbo.TT_View_ProjectData a on c.TaskID = a.TaskID    
 WHERE @UserID IN (    
	SELECT 	Distinct UserID 
	From	Usr_GroupPermission a 
			INNER JOIN Usr_UserGroup b ON a.GroupID = b.GroupID
	WHERE	a.RoleID = 72)  -- Where the User is in the Director/MD group ie. has permission to do 3rd level approvals     
 ) a         
 UNION         
 --TimeOff Timesheets         
 Select   'TimesheetApprovalTeamLeader' as Message,        
   '<a href=''' + @ApplicationPath + '/Approvals/Timesheet.aspx?Date='+ Convert(varchar,dbo.WeekStartDate(a.TimeOffDate),101)+'''>' + convert(varchar,datepart(wk,dbo.WeekStartDate(a.TimeOffDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(a.TimeOffDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(a.TimeOffDate)), 103) +'</a>' as Detail,        
   c.FirstName + ' ' + c.LastName as UserName,        
   dbo.WeekStartDate(a.TimeOffDate) as WeekStart,        
   convert(varchar,datepart(wk,dbo.WeekStartDate(a.TimeOffDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(a.TimeOffDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(a.TimeOffDate)), 103) as Period        
 From   TT_TimeOff a        
 Left Join  TT_Approvals b on a.TimeOffID = b.ApprovedItemID and b.ApprovalTypeID = 5 /*and b.ApproverID = @UserID*/  --removed by CB because number of different people could approve time off        
 Left Join  Usr_UserDetail c on a.UserID = c.UserID        
 Where  Submitted is Not Null        
 And   (b.Approved = 0 or b.Approved is Null)        
 And   @UserID in ( Select   a.UserID         
     From   Usr_UserGroup a        
     Inner Join Usr_GroupName b on a.GroupID = b.GroupID         
     Where  Upper(Descript) = 'ADMIN MANAGER')        
        
)        
      
/*  Backup of the Ordinary Timesheets Approval code as at 05/02/2010       
 --Ordinary Timesheets        
 Select  DISTINCT Message, Detail, UserName, WeekStart, Period        
 From        
 (Select 'TimesheetApproval' as Message,        
  '<a href=''' + @ApplicationPath + '/Approvals/Timesheet.aspx?Date='+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate),101)+'''>' + convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c.
  
    
      
TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103) +'</a>' as Detail,        
  d.FirstName + ' ' + d.LastName as UserName,        
  dbo.WeekStartDate(c.TimesheetDate) as WeekStart,        
  convert(varchar,datepart(wk,dbo.WeekStartDate(c.TimesheetDate))) + ':&nbsp;&nbsp;'+ Convert(varchar,dbo.WeekStartDate(c.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(c.TimesheetDate)), 103)  as Period        
 From         
 (Select a.TimesheetID, a.TimeSheetDate, a.ApprovalStage, a.UserID, a.TaskID        
  From dbo.TT_Timesheets a left join        
  dbo.TT_Approvals b on a.TimesheetID = b.ApprovedItemID left join        
  (Select a.TimesheetID        
   From dbo.TT_Timesheets a inner join        
   dbo.TT_Approvals b on a.TimesheetID = b.ApprovedItemID        
   Where ApprovalTypeID = 2 And Approved = 1 and ApproverID = @UserID        
   Group By a.TimesheetID        
  ) c on a.TimesheetID = c.TimesheetID        
  Where a.Submitted = 1 -- Submitted Timesheets        
  And c.TimesheetID is null        
  And Approved is null -- Additional check to cater for the fact that a previous team leader may have approved the timesheets so exclude all approved        
 ) c join         
 dbo.Usr_UserDetail d on c.UserID = d.UserID join        
 dbo.TT_View_ProjectData a on c.TaskID = a.TaskID join        
 (Select ProjectID         
  From dbo.TT_ProjectStatus        
  Where StatusID = 3        
 ) b on a.ProjectID = b.ProjectID        
 Where a.ProjectID in (        
  select ProjectID         
  From dbo.TT_FXN_TSApproverProjects(@UserID)        
  Where Approver = c.ApprovalStage        
  )  -- Current user is the relevant stage approver for the project        
 ) a  */        
        
        
        
        
        
        
        
        
        
        
        
        
        
        



GO
/****** Object:  UserDefinedFunction [dbo].[Rep_SelectedProjects]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Function [dbo].[Rep_SelectedProjects](@ClientID as Int,@Start as SmallDateTime,@End as SmallDateTime,@TaskID as Int,@Users as varchar)
Returns Table
As
Return
(
Select Distinct a.ProjectID, b.ClientCode + ' - ' + a.ProjectName + ' (' + a.ProjectCode + ')' as ProjectName
From dbo.TT_Projects a
Join dbo.TT_Clients b on a.ClientID = b.ClientID
Join dbo.TT_ProjectResources c on a.ProjectID = c.ProjectID 
Join dbo.TT_Orders d on a.ProjectID = d.ProjectID
Join dbo.TT_ProjectTasks e on d.OrderID = e.OrderID
Join dbo.TT_Timesheets f on e.TaskID = f.TaskID
Where
 		Case When @ClientID = 0 Then 0 Else b.ClientID End = @ClientID
and Case When @TaskID = 0 Then 0 Else e.TaskID End = @TaskID
and Case When @Users != '' Then	f.UserID Else	(@Users) End in (@Users)
and f.TimesheetID in (Select * From dbo.ApprovedTimeSheets(0))
and f.TimesheetDate between @Start and @End
)






GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ExpensesForApproval]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Function [dbo].[TT_FXN_ExpensesForApproval]()
Returns Table
As
Return
(Select * from dbo.TT_Expenses
where submitted is not null
and ExpenseID not in (Select ExpenseID from dbo.ApprovedExpenses(0))
)







GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ExpensesSubmittedForProject]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/****************************************************************************************************************************************
Created by:	SD
Created on:	05/10/2005 
Does: 		Returns a list of all the submitted expenses for a given project
Used in:		???
****************************************************************************************************************************************/
CREATE Function [dbo].[TT_FXN_ExpensesSubmittedForProject](@ProjectID int)
Returns Table
As
Return
(

Select 	Distinct ExpenseID
From 	TT_Expenses 
Where  	(ProjectID = @ProjectID or @ProjectID = 0)
And 	Submitted is not null
and 	ExpenseID not in (Select ExpenseID from dbo.ApprovedExpenses(@ProjectID))


)













GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetsForApproval]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[TT_FXN_TimesheetsForApproval]()
Returns Table
As
Return
(Select * from dbo.TT_Timesheets
where submitted is not null
and TimeSheetID not in (Select TimesheetID from dbo.ApprovedTimesheets(0))
)








GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetsForApprovalForProject]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/****************************************************************************************************************************************
Created by:	SD
Created on:	04/10/2005 
Does: 		Returns a list of timesheets waiting for approval (ie. Submitted timesheets)
Used in:		???
Modified:

23/01/2007 by VF: Make this work for when a ProjectID of 0 is passed in
****************************************************************************************************************************************/
CREATE  Function [dbo].[TT_FXN_TimesheetsForApprovalForProject](@ProjectID int)
Returns Table
As
Return
(

Select 	Distinct TimesheetID 
From 	(Select TimesheetID, TaskID
	 From 	TT_Timesheets 
	 Where 	Submitted is Not Null
	 And 	TimesheetID not in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))) a
inner join TT_ProjectTasks b on a.TaskID = b.TaskID
inner join TT_Orders c on b.OrderID = c.OrderID
Where 		Case When @ProjectID = 0 Then 0 Else ProjectID End = @ProjectID

)











GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_AllUserHours]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*********************************************************************************************************
Created by:	SD
Created on:	21/10/2005
Does:		Returns a list of all users hours
Used in:		TT_FXN_ProfitTable_Fin
*********************************************************************************************************/
CREATE     Function [dbo].[TT_FXN_AllUserHours](@UserID as Int,@ProjectID as Int)
Returns Table
AS
Return(	
	Select a.UserID, isnull(dbo.ConvertToHours(BillDuration,100),0) as BillHours,isnull(dbo.ConvertToHours(NonBillDuration,100),0) as NonBillHours, a.TimesheetDate 
	From
	(
		Select b.UserID, Duration as BillDuration, b.TimesheetDate
		From dbo.TT_View_ProjectData a
		join  dbo.TT_Timesheets b on a.TaskID = b.TaskID
		where Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
		and Case When @UserID = 0 Then 0 Else b.UserID End = @UserID
		and a.Billable = 1
	) a left join
	(
		Select b.UserID, Duration as NonBillDuration, b.TimesheetDate
		From dbo.TT_View_ProjectData a
		join  dbo.TT_Timesheets b on a.TaskID = b.TaskID
		where Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
		and Case When @UserID = 0 Then 0 Else b.UserID End = @UserID
		and a.Billable <> 1
	) b on a.UserID = b.UserID and a.TimesheetDate = b.TimesheetDate
)






GO
/****** Object:  UserDefinedFunction [dbo].[AllUserHours]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*********************************************************************************************************
Created by:	SD
Created on:	21/10/2005
Does:		Returns a list of all users hours
Used in:		TT_FXN_ProfitTable_Fin
*********************************************************************************************************/
CREATE    Function [dbo].[AllUserHours](@UserID as Int,@ProjectID as Int)
Returns Table
AS
Return(	
	Select b.UserID, isnull(dbo.ConvertToHours(Duration,100),0) as Hours, TimesheetDate 
	From dbo.TT_View_ProjectData a
	join  dbo.TT_Timesheets b on a.TaskID = b.TaskID
	where Case When @ProjectID = 0 Then 0 Else a.ProjectID End = @ProjectID
	and Case When @UserID = 0 Then 0 Else b.UserID End = @UserID
	
)





GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ProjStatusTable_Fin]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE     Function [dbo].[TT_FXN_ProjStatusTable_Fin](@ProjectID as Int,@StartDate as SmallDateTime,@EndDate as SmallDateTime)
Returns Table
/*
(
Mnth as DateTime,
Budget as Decimal(19,2),
TimeCost as Decimal(19,2),
ExpCost as Decimal(19,2),
Total as Decimal(19,2)
)
*/
Return(

	
	Select 	Month(a.dd) as Mnth,
		 Year(a.dd) as Yr, 
		Sum(isNull(DayBud, 0)) as Budget, 
		Sum(isNull(Hours, 0) * isNull(dbo.GetProjectUserRate(UserID,@ProjectID), 0)) as TimeCost, 
		Sum(isNull(Quantity, 0) * isNull(UnitCost, 0)) as ExpCost
	From 	dbo.TT_FXN_MonthBudgetTable(@ProjectID, @StartDate, @EndDate) a left join
		dbo.ApprovedUserHours(0,@ProjectID) b on Convert(varchar, a.dd, 103) = Convert(varchar, b.TimeSheetDate, 103) left join
  		dbo.ApprovedUserExpenses(0,@ProjectID) c on Convert(varchar, a.dd, 103)  = Convert(varchar, c.ExpenseDate, 103)
	Where 	a.dd Between @StartDate and @EndDate
	Group By Year(a.dd), Month(a.dd)
)











GO
/****** Object:  UserDefinedFunction [dbo].[FXN_Rep_SelectedProjects]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- This function returns all projects that satisfy
-- the filter criteria
-- 0 Values for ClientID and TaskID return all,
-- "" value for Users returns all


CREATE Function [dbo].[FXN_Rep_SelectedProjects](@ClientID as Int,@Start as SmallDateTime,@End as SmallDateTime,@TaskID as Int,@Users as varchar)
Returns Table
As
Return
(
--Select Distinct a.ProjectID, b.ClientCode + ' - ' + a.ProjectName + ' (' + a.ProjectCode + ')' as ProjectName
Select Distinct a.ProjectID, a.ProjectName + ' (' + a.ProjectCode + ')' as ProjectName
From dbo.TT_Projects a
Join dbo.TT_Clients b on a.ClientID = b.ClientID
Join dbo.TT_ProjectResources c on a.ProjectID = c.ProjectID 
Join dbo.TT_Orders d on a.ProjectID = d.ProjectID
Join dbo.TT_ProjectTasks e on d.OrderID = e.OrderID
Where
 		Case When @ClientID = 0 Then 0 Else b.ClientID End = @ClientID
and Case When @TaskID = 0 Then 0 Else e.TaskID End = @TaskID
-- This needs to be sorted out
--and Case When @Users != '' Then	c.UserID Else	(@Users) End in (@Users)
and (a.StartDate <= @End and a.EndDate >= @Start)
)








GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_AllTimesheetsOverdue]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/******************************************************************************************************
Created by:	VF
Created on:	??
Does:		Returns a list of all timesheets that are overdue
Used in:		Emailing notifications (and maybe elsewhere)

Modified:

24/04/2006 by SD: Added the check that a user must have permission to capture time
******************************************************************************************************/
CREATE Function [dbo].[TT_FXN_AllTimesheetsOverdue](@Date as DateTime)
Returns Table
As
Return
(



	Select 	* 
	From 	dbo.TT_Timesheets
	Where 	Submitted is null 	And 
		TimesheetDate < @Date  And 
		Duration > 0 And
		UserID in ( 	Select 	b.UserID
				From 	Usr_GroupPermission a Inner Join
					Usr_UserGroup b on a.GroupID = b.GroupID 
				Where	RoleID = 6)

)









GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ApprovedTimeOff]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE Function [dbo].[TT_FXN_ApprovedTimeOff]()
Returns Table
As
Return
(Select TimeOffID From
dbo.TT_Approvals a inner join
dbo.TT_TimeOff b on a.ApprovedItemID = b.TimeOffID
Where a.ApprovalTypeID = 5
And a.Approved = 1)










GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ExpensesAllForProject]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/****************************************************************************************************************************************
Created by:	SD
Created on:	05/10/2005 
Does: 		Returns a list of all the expenses for a given project
Used in:		???
****************************************************************************************************************************************/
CREATE Function [dbo].[TT_FXN_ExpensesAllForProject](@ProjectID int)
Returns Table
As
Return
(

Select 	Distinct ExpenseID 
From 	dbo.TT_Expenses
where 	(ProjectID = @ProjectID or @ProjectID = 0)


)













GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_ExpensesCapturedForProject]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/****************************************************************************************************************************************
Created by:	SD
Created on:	05/10/2005 
Does: 		Returns a list of all the captured expenses for a given project
Used in:		???
****************************************************************************************************************************************/
CREATE Function [dbo].[TT_FXN_ExpensesCapturedForProject](@ProjectID int)
Returns Table
As
Return
(

Select 	Distinct ExpenseID
From 	TT_Expenses 
Where  	(ProjectID = @ProjectID or @ProjectID = 0)
And 	Submitted is null


)












GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_FinancialDocsAwaitngApprovalForUser]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /************************************************************************************************************        
Created by: SD        
Created on: 05/01/2011        
Does:  Returns a list of Financial Documents awaiting approval for a user        
Used in:  TT_SelectStartAlerts and TT_SelectFinancialDocsAwaitingApprovalForUser        
      
************************************************************************************************************/        
CREATE Function [dbo].[TT_FXN_FinancialDocsAwaitngApprovalForUser](@UserID as Int, @ApplicationPath as varchar(100))        
Returns Table        
Return(        
         
Select  Distinct 'FinDocTeamLeaderApproval' as Message,        
 '<a href=''' + @ApplicationPath + '/Approvals/FinancialDocument.aspx?UserID=' +  convert(varchar(500),@UserID) + '&FinancialDocID=' + convert(varchar(50),FinancialDocID) + '&ApprovalLevel=1&FinancialDocTypeID=' + convert(varchar(50),FinancialDocTypeID)   + '''>'+ FinancialDocTitle +'</a>' as Detail,    
 '' as Username
From  TT_FinancialDocuments fd      
Inner Join  TT_Orders o on fd.OrderID = o.OrderID      
Inner Join TT_ProjectResources pr on pr.ProjectID = o.ProjectID      
Where  Submitted = 1      
And   ApprovalStage = 1      
And   TeamLeader = 1      
and  UserID = @UserID        
UNION      
Select  Distinct 'FinDocManagerMonitorApproval' as Message,        
 '<a href=''' + @ApplicationPath + '/Approvals/FinancialDocument.aspx?UserID=' +  convert(varchar(500),@UserID) + '&ApprovalLevel=3&FinancialDocID=' + convert(varchar(50),FinancialDocID)  + '&FinancialDocTypeID=' + convert(varchar(50),FinancialDocTypeID)  + '''>'+ FinancialDocTitle +'</a>' as Detail,    
 '' as Username  
From  TT_FinancialDocuments fd      
Inner Join  TT_Orders o on fd.OrderID = o.OrderID      
Inner Join TT_ProjectResources pr on pr.ProjectID = o.ProjectID      
Where  Submitted = 1      
And   ApprovalStage = 1      
And   TSLastApprover = 1      
and  UserID = @UserID        
    
    
)      
      
      
    
        
        
        
        
        
        
        
        
        
        
        



GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_GetDailyCostForProject]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*******************************************************************************************************
Created by:	SD
Created on:	30/09/2005
Used in:		TT_Rep_TaskRegister_Task_Usr and TT_Rep_TaskRegister_Usr_Task
Does:		Returns the daily timesheet cost of a project
*******************************************************************************************************/
CREATE Function [dbo].[TT_FXN_GetDailyCostForProject] (@Start as SmallDateTime,@End as SmallDateTime, @ProjectID as int, @TaskID as int, @Users as varchar(50), @CaptureTypeID int)
Returns Table 
as
Return
(

	select 	Convert(varchar,dt.dd,103) as TimesheetDate, 
		coalesce(tot.Cost, 0) as Cost
	From dbo.TT_FXN_DatesTable(@Start, @End) dt
	left join
	(	Select	 TimesheetDate,
			 sum(dbo.ConvertToHours(Duration,100) * Rate) as Cost
		From (
			Select 	c.ProjectID, a.TaskID as Task,   Cast(e.Rate as Decimal(5,2)) as Rate, b.*
			From 	TT_FXN_TimesheetsByCaptureType(@CaptureTypeID, @ProjectID) t
			Inner Join dbo.TT_Timesheets b on b.TimesheetID = t.TimesheetID
			Inner Join dbo.TT_ProjectTasks a on a.TaskID = b.TaskID
			Join 	dbo.TT_Orders c on a.OrderID = c.OrderID
			Join 	dbo.TT_Projects d on c.ProjectID = d.ProjectID
			Join 	dbo.TT_ProjectResources e on (c.ProjectID = e.ProjectID and b.UserID = e.UserID)
		Where c.ProjectID = @ProjectID
		and (b.TimesheetDate Between @Start and @End)
		--and b.TimesheetID in (select TimesheetID from dbo.ApprovedTimesheets(@ProjectID))
		and Case When @TaskID = 0 Then 0 Else a.TaskID End = @TaskID
		and ((PATINDEX('%,' + Cast(b.UserID as varchar) + ',%', @Users) > 0) OR (@Users = ''))
		) a
		Group By TimesheetDate
	) tot on dt.dd = tot.TimesheetDate

)












GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_GetLastExpense]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/**************************************************************************************************************
Created by:	SB
Created on:	10/08/2005
Does:		Returns the last expense for a given project
Used in:		TT_GetProjectCloseOutList
**************************************************************************************************************/
CREATE Function [dbo].[TT_FXN_GetLastExpense] ()  
RETURNS Table 

/*
Return (
	Select 	Top 1 ExpenseDate, ProjectID
	From	TT_Expenses
	Where	ProjectID = @ProjectID
	Order by ExpenseDate desc) */

Return (
	Select    ProjectID, Max(ExpenseDate) as LastExpense
	From	TT_Expenses
	Group By ProjectID )





GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_GetLastTimesheet]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/**************************************************************************************************************
Created by:	SB
Created on:	10/08/2005
Does:		Returns the last expense for a given project
Used in:		TT_GetProjectCloseOutList
**************************************************************************************************************/
CREATE Function [dbo].[TT_FXN_GetLastTimesheet] ()  
RETURNS Table 

Return (
	select 		c.ProjectID, Max(TimeSheetDate) LastTimesheet
	From 		TT_Timesheets a
	Inner Join 	TT_ProjectTasks b on a.TaskID = b.TaskID
	Inner Join 	TT_Orders c on b.OrderID = c.OrderID
	Group By	c.ProjectID )






GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimeOffApprovedTable]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









/*******************************************************************
Created by:	SD
Created on:	21/04/2006
Does:		Returns a table of all Approved Time Offs
		(Based on TT_FXN_TimeOffApproved)
*******************************************************************/
Create Function [dbo].[TT_FXN_TimeOffApprovedTable]()
Returns Table
As

Return

(Select TimeOffID
From dbo.TT_Approvals a inner join
dbo.TT_TimeOff b on a.ApprovedItemID = b.TimeOffID
Where a.ApprovalTypeID = 5
And a.Approved = 1)










GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimeOffRejectedTable]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*******************************************************************
Created by:	SD
Created on:	21/04/2006
Does:		Returns a table of all Rejected TimeOff
		(Based on TT_FXN_TimeOffRejected)
*******************************************************************/
Create Function [dbo].[TT_FXN_TimeOffRejectedTable]()
Returns Table
As

Return
(
Select 	
	TimeOffID 
From 
	dbo.TT_Approvals a inner join
	(Select 
		TimeOffID 
	From 
		dbo.TT_TimeOff) b on a.ApprovedItemID = b.TimeOffID
Where 	a.ApprovalTypeID = 5
And 	a.Approved = 0

)







GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetApprovedTable]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*******************************************************************  
Created by: SD  
Created on: 21/04/2006  
Does:  Returns a table of all approved times  
  (Based on TT_FXN_TimesheetApproved)  

Modified:

27/03/2008 by SD: Remove the check on TSLastApprover as the person doing this role may
	have changed since the timesheet was approved.
*******************************************************************/  
CREATE  Function [dbo].[TT_FXN_TimesheetApprovedTable]()  
Returns Table  
As  
Return  
  
  
(  

Select TimesheetID  
 From   
 (Select TimesheetID, TaskID, ApproverID, ApprovedItemID   
  From dbo.TT_Timesheets a inner join  
  dbo.TT_Approvals b on a.TimesheetID = b.ApprovedItemID  
  Where ApprovalTypeID = 2 And Approved = 1   
 ) a

 /*
 Select TimesheetID  
 From   
 (Select TimesheetID, TaskID, ApproverID, ApprovedItemID   
  From dbo.TT_Timesheets a inner join  
  dbo.TT_Approvals b on a.TimesheetID = b.ApprovedItemID  
  Where ApprovalTypeID = 2 And Approved = 1   
 ) a 
inner join  
 (Select TaskID, UserID   
  From dbo.TT_ProjectTasks a inner join  
  dbo.TT_Orders b on a.OrderID = b.OrderID inner join  
  dbo.TT_ProjectResources c on b.ProjectID = c.ProjectID  
  Where TSLastApprover = 1  
 ) b on a.TaskID = b.TaskID and a.ApproverID = b.UserID   */
)  
  
  
  
  
  
  
  
  
  
  
  
  



GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetRejectedTable]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*******************************************************************
Created by:	SD
Created on:	21/04/2006
Does:		Returns a table of all Rejected Timesheets
		(Based on TT_FXN_TimesheetRejected)
*******************************************************************/
Create Function [dbo].[TT_FXN_TimesheetRejectedTable]()
Returns Table
As

Return
(
Select 	TimesheetID
From 	dbo.TT_Approvals a inner join
	(Select TimesheetID, TaskID 
	 From 
		dbo.TT_Timesheets ) b on a.ApprovedItemID = b.TimesheetID inner join
	(Select TaskID, UserID 
	 From
		dbo.TT_ProjectTasks a inner join
		dbo.TT_Orders b on a.OrderID = b.OrderID inner join
		dbo.TT_ProjectResources c on b.ProjectID = c.ProjectID
	Where 	TSLastApprover = 1) c on b.TaskID = c.TaskID and a.ApproverID = c.UserID
Where a.ApprovalTypeID = 2
And a.Approved = 0)










GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetsAllForProject]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/****************************************************************************************************************************************
Created by:	SD
Created on:	04/10/2005 
Does: 		Returns a list of all the timesheets for a given project
Used in:		???
Modified:

23/01/2007 by VF: Make this work for when a ProjectID of 0 is passed in
****************************************************************************************************************************************/
CREATE  Function [dbo].[TT_FXN_TimesheetsAllForProject](@ProjectID int)
Returns Table
As
Return
(

Select 	   	Distinct TimesheetID
From 	   	TT_Timesheets a
inner join 	TT_ProjectTasks c on a.TaskID = c.TaskID
inner join 	TT_Orders d on d.OrderID = c.OrderID
Where 		Case When @ProjectID = 0 Then 0 Else ProjectID End = @ProjectID

)











GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetsCapturedForProject]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/****************************************************************************************************************************************
Created by:	SD
Created on:	04/10/2005 
Does: 		Returns a list of all captured times for a project
Used in:		???
Modified:

23/01/2007 by VF: Make this work for when a ProjectID of 0 is passed in
****************************************************************************************************************************************/
CREATE  Function [dbo].[TT_FXN_TimesheetsCapturedForProject](@ProjectID int)
Returns Table
As
Return
(
Select Distinct TimesheetID
From 		(Select TimesheetID, TaskID 
		 From TT_Timesheets 
		 Where TimesheetID not in (	Select ApprovedItemID 
						From TT_Approvals 
						Where ApprovalTypeID = 2)
		 And submitted is null) a
inner join 	TT_ProjectTasks c on a.TaskID = c.TaskID
inner join	TT_Orders d on d.OrderID = c.OrderID
Where 		Case When @ProjectID = 0 Then 0 Else ProjectID End = @ProjectID

)













GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_TimesheetsRejected]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/****************************************************************************************************************************************
Created by:	SD
Created on:	20/10/2005 
Does: 		Returns a list of rejected timesheets for a user
Used in:		TT_SelectStartAlerts

Modified:

24/01/2006 by SD: Need to check against TimeOff as well as this can also be rejected and hence we must show the alert
****************************************************************************************************************************************/
CREATE   Function [dbo].[TT_FXN_TimesheetsRejected](@UserID int)
Returns Table
As
Return
(

/*
Select  TimesheetDate,
	Convert(varchar,dbo.WeekStartDate(a.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(a.TimesheetDate)), 103) as WeekPeriod,
	convert(varchar,datepart(wk,dbo.WeekStartDate(a.TimesheetDate))) as WeekNo,
	dbo.WeekStartDate(a.TimesheetDate) as WeekStartDate
From 	TT_Timesheets a
Where   TimesheetID in (	Select ApprovedItemID from TT_Approvals 
				where Approved = 0
				and ApprovalTypeID = 2)
And 	Submitted is null
and 	UserID = @UserID */


Select 	
	Distinct TimesheetDate,
	WeekPeriod,
	WeekNo,
	WeekStartDate
From
      (
	Select  TimesheetDate,
		Convert(varchar,dbo.WeekStartDate(a.TimesheetDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(a.TimesheetDate)), 103) as WeekPeriod,
		convert(varchar,datepart(wk,dbo.WeekStartDate(a.TimesheetDate))) as WeekNo,
		dbo.WeekStartDate(a.TimesheetDate) as WeekStartDate
	From 	TT_Timesheets a
	Where   TimesheetID in (	Select ApprovedItemID from TT_Approvals 
					where Approved = 0
					and ApprovalTypeID = 2)
	And 	Submitted is null
	and 	UserID = @UserID
	Union
	Select  TimeOffDate,
		Convert(varchar,dbo.WeekStartDate(a.TimeOffDate), 103) +' - '+ Convert(varchar,DateAdd(Day, 7,dbo.WeekStartDate(a.TimeOffDate)), 103) as WeekPeriod,
		convert(varchar,datepart(wk,dbo.WeekStartDate(a.TimeOffDate))) as WeekNo,
		dbo.WeekStartDate(a.TimeOffDate) as WeekStartDate
	From 	TT_TimeOff a
	Where   TimeOffID in (		Select ApprovedItemID from TT_Approvals 
					where Approved = 0
					and ApprovalTypeID = 5)
	And 	Submitted is null
	and 	UserID = @UserID
      )	a

)














GO
/****** Object:  UserDefinedFunction [dbo].[TT_FXN_UserProjects]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************
Created by:	VF
Created on:	??
Does:		This Function Returns all Projects that the User is a resource for
Used in:		Various stored procedures

Modified:

06/09/2005 by SD:  Only show projects where the resource is enabled
********************************************************************************************************************/
CREATE Function [dbo].[TT_FXN_UserProjects](@UserID as int, @EnabledOnly as bit)
Returns Table
As
Return
(
Select 	a.ProjectID, 
	a.EndDate
From	dbo.TT_Projects a join
	dbo.TT_ProjectResources b on a.ProjectID = b.ProjectID
Where 	b.UserID = @UserID
And     	(b.Enabled = @EnabledOnly OR @EnabledOnly = 0)
)










GO
/****** Object:  View [dbo].[TT_View_ApprovalDetails]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*********************************************************************
Created by:	SD
Created on:	24/02/2010
Does:		Retrieves the approval details and inserts who rejected the item
Used in:	TT_SelectRejectedExpenseDetails and TT_SelectUserTimeSheet
*********************************************************************/
CREATE VIEW [dbo].[TT_View_ApprovalDetails]
AS

SELECT ApprovalID
	, ApprovalTypeID
	, ApproverID
	, ApprovalDate
	, ApprovedItemID
	, CASE Approved
		WHEN 1 THEN Comment
		WHEN 0 THEN Comment  + char(10) + char(13) + char(10) + char(13) + 'Rejected by: ' + b.FirstName + ' ' + b.LastName + ' on ' + convert(varchar,ApprovalDate,103)
	END as Comment
	, Approved 
FROM 
	TT_Approvals a
	INNER JOIN Usr_UserDetail b
		on b.UserID = a.ApproverID



GO
/****** Object:  View [dbo].[TT_View_InProgressProjects]    Script Date: 2016/12/01 04:01:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************
Created by:	SD
Created on: 04/02/2010
Does:		Lists all Project ID's that are currently in progress
***********************************************************/
CREATE View [dbo].[TT_View_InProgressProjects]

AS

SELECT 
		ProjectID   
FROM    
		TT_ProjectStatus  
WHERE 
		StatusID = 3  





GO


SET IDENTITY_INSERT [dbo].[TT_ApprovalTypes] ON 

INSERT [dbo].[TT_ApprovalTypes] ([ApprovalTypeID], [Description], [Enabled]) VALUES (1, N'Project Take On', 1)
INSERT [dbo].[TT_ApprovalTypes] ([ApprovalTypeID], [Description], [Enabled]) VALUES (2, N'Timesheet', 1)
INSERT [dbo].[TT_ApprovalTypes] ([ApprovalTypeID], [Description], [Enabled]) VALUES (3, N'Expense', 1)
INSERT [dbo].[TT_ApprovalTypes] ([ApprovalTypeID], [Description], [Enabled]) VALUES (4, N'Variation Order', 1)
INSERT [dbo].[TT_ApprovalTypes] ([ApprovalTypeID], [Description], [Enabled]) VALUES (5, N'TimeOff', 1)
INSERT [dbo].[TT_ApprovalTypes] ([ApprovalTypeID], [Description], [Enabled]) VALUES (6, N'Financial Document', 1)
SET IDENTITY_INSERT [dbo].[TT_ApprovalTypes] OFF
SET IDENTITY_INSERT [dbo].[TT_Clients] ON 

INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (56, N'C175', N'Ba - Phalaborwa Local Municipality', N'PRIVATE BAG X 1020', N'PHALABORWA', NULL, NULL, N'1390', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (57, N'C177', N'Bela Bela Local Municipality', N'P o Box x 1609', N'Bela Bela ', NULL, NULL, N'0480', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (58, N'C190', N'Greater Letaba Local Municipality', N'P o Box 36', N'Duiwelskloof', NULL, NULL, N'0835', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (59, N'C194', N'Lephalale Local Municipality', N'Private Bag x 136', N'Lephalale', NULL, NULL, N'0555', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (60, N'C199', N'Modimolle Local Municipality', N'Private Bag X 1008', N'Nylstroom', NULL, NULL, N'0510', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (61, N'C202', N'Mookgophong Local Municipality', N'Private Bag X 340', N'Naboomspruit', NULL, NULL, N'0560', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (62, N'C206', N'Nokeng Tsa Taemane Local Municipality', N'P o Box 204', N'Rayton', NULL, NULL, N'1001', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (63, N'C173', N'Albert Luthuli Local Municipality', N'P o Box 24', N'Carolina ', NULL, NULL, N'1185', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (64, N'C180', N'Delmas Local Municipality', N'P o Box 6', N'Delmas', NULL, NULL, N'2210', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (65, N'C182', N'Dipaleseng Local Municipality', N'Private Bag X 1005', N'Balfour', NULL, NULL, N'2410', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (66, N'C209', N'Pixley ka Seme Local Municipality ', N'Private Bag X 9011', N'Volksrust', NULL, NULL, N'2470', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (67, N'C216', N'Thaba Chweu Local Municipality', N'P o Box 61', N'Lydenburg', NULL, NULL, N'1120', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (68, N'C222', N'Umjindi Local Municipality', N'Po Box ', N'Baberton ', NULL, NULL, N'0000', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (69, N'C223', N'Umzinyathi District Municipality', N'P o Box 1965', N'Dundee', NULL, NULL, N'3000', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (70, N'C183', N'Ditsobotla Local Municipality', N'P O Box 7', N'Lichtenburg', NULL, NULL, N'2740', N'P O Box 7', N'Lichtenburg', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (71, N'C193', N'Kopanong Local Municipality', N'P o Box 23', N'Trompsburg', NULL, NULL, N'9913', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (72, N'C197', N'Mantsopa Local Municipality', N'P o Box 64', N'Ladybrand', NULL, NULL, N'9745', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (73, N'C201', N'Mohokare Local Municipality', N'P o Box 20', N'Zastron', NULL, NULL, N'9950', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (74, N'C204', N'Nketoana Local Municipality', N'P o Box 26', N'Reitz', NULL, NULL, N'9810', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (75, N'C212', N'Setsoto Local Municipality', N'P o Box 116', N'Ficksburg', NULL, NULL, N'9730', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (76, N'C220', N'Tswelopele Local Municipality', N'P o Box 3', N'Bultfontein', NULL, NULL, N'9670', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (77, N'C205', N'Tokologo Local Municipality', N'Private Bag X 46', N'Boshof ', NULL, NULL, N'8340', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (78, N'C185', N'Emalahleni Local Municipality', N'P O Box 23', N'Lady Frere', N'Witbank', NULL, N'5410', N'P O Box 23', N'Lady Frere', N'Witbank', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (79, N'C184', N'Elundini Local Municipality', N'P O Box 10', N'Ugie', N'Maclear', NULL, N'5470', N'P O Box 10', N'Ugie', N'Maclear', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (80, N'C187', N'Gariep Local Municipality', N'P O Box 13', N'Burgersdorp', NULL, NULL, N'9744', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (81, N'C280', N'Maletswai Local Municipality', N'P o Box ', N'Alival North', NULL, NULL, N'0000', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (82, N'C198', N'Mnquma Local Municipality', N'P o Box 36', N'Butterworth', NULL, NULL, N'4960', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (83, N'C210', N'Sakhisizwe Local Municipality', N'P o Box 21', N'Elliot', NULL, NULL, N'5460', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (84, N'C211', N'Senqu Local Municipality', N'P o Box 18', N'Lady Grey', NULL, NULL, N'9755', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (85, N'C219', N'Tsolwana Local Municipality', N'P o Box 21', N'Tarkastad', NULL, NULL, N'5370', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (86, N'C033', N'Maseru City Council', N'P o Box 911', N'Maseru', NULL, NULL, N'100', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (87, N'C176', N'Beaufort West Local Municipality', N'Private Bag 582', N'Beaufort west', NULL, NULL, N'6970', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (88, N'C186', N'Gamagara Local Municipality', N'P O Box 1001', N'Kathu', NULL, NULL, N'8446', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (89, N'C192', N'Karoo Hoogland Local Municipality', N'P o Box 114', N'Fraserburg', NULL, NULL, N'6960', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (90, N'C224', N'Kai! Garib Local Municipality', N'P o Box 174', N'Kakamas', NULL, NULL, N'8870', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (91, N'C038', N'Letsemeng', N'P o Box 7', N'Koffiefontein', NULL, NULL, N'9986', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (92, N'C039', N'Magareng', N'P o Box 10', N'Warrenton', NULL, NULL, N'8530', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (93, N'C208', N'Phokwane Local Municipality', N'P o Box 83', N'Hartswater', NULL, NULL, N'8570', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (94, N'C213', N'Siyancuma Local Municipality', N'P o Box 27', N'Douglas', NULL, NULL, N'8730', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (95, N'C214', N'Siyathemba Local Municipality', N'P o Box 16', N'Prieska', NULL, NULL, N'8940', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (96, N'C217', N'Thembelihle Local Municipality', N'Private Bag X 3', N'Hopetown', NULL, NULL, N'8750', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (97, N'C218', N'Tsantsabane Local Municipality', N'P o Box 5', N'Postmasburg', NULL, NULL, N'8420', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (98, N'C084', N'Ubunto ', N'Private Bag x 329', N'Victoria West', NULL, NULL, N'7070', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (99, N'C174', N'Amajuba District Municipality', N'Private Bag x 6615', N'Newcastle', NULL, NULL, N'2940', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (100, N'C179', N'Cenored Limited', N'P o Box 560', N'Otjiwarongo ', N'Namibia ', NULL, N'0000', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (101, N'C292', N'Govan Mbeki Local Municipality', N'Private Bag X 1017', N'Secunda', NULL, NULL, N'2302', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (102, N'C083', N'Kgalagadi DM', N'P o Box 1480', N'Kuruman', NULL, NULL, N'8460', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (103, N'C050', N'Walvis Bay ', N'Private Bag xxxx', N'Walvis Bay', N'Namibia ', NULL, N'0000', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (104, N'C055', N'FMS Centurion Admin work', N'P o Box 50818', N'Wierda Park', NULL, NULL, N'0149', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (105, N'C052', N'FMS Kimberley Admin Work', N'P o Box 997', N'Kimberley', NULL, NULL, N'8300', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (106, N'C053', N'FMS East London Admin Work', N'P o Box 50818', N'Wierda Park', NULL, NULL, N'0149', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (107, N'C056', N'Sebata Municipal Solution Centurion', N'P O Box 50818', N'Wierda Park', NULL, NULL, N'0149', N'Building 25', N'Cambridge Office Par', N'5 Bauhinia Street, T', N'Centurion, Pretoria', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (108, N'C057', N'Sebata Municipal Solutions Kimberley', N'P O Box 997', N'Kimberley', N'8300', NULL, N'8301', N'6 Monridge Park', N'2 Kekewich Drive', N'Monument Heights', N'Kimberley', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (109, N'C058', N'Gert Sibande DM', N'Po Box 550', N'Secunda', NULL, NULL, N'2302', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (110, N'C203', N'Moshaweng Local Municipality', N'Private Bag X117', N'MOTHIBISTAD', NULL, NULL, N'8474', N'D320 Cardington Street', N'Mothibistad', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (111, N'C060', N'Thulamela Municipality', N'Private Bag X5066', N'Thohoyandou', NULL, NULL, N'0950', N'Old Agriven Buildiing', N'Thohoyandou', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (112, N'C082', N'Botswana Dept of Industrial Court', N'It Office', N'Gabarone ', NULL, NULL, N'0000', N'Gabarone ', NULL, NULL, NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (113, N'C062', N'Chris Hani District Municipality ', N'15 Bells Road ', N'Queenstown', NULL, NULL, N'0000', N'15 Bells Road', N'Queenstown', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (114, N'C063', N'Thabazimbi Local Municipality ', N'Private Bag x530', N'Thabazimbi', NULL, NULL, N'0380', N'7 Rietbok Street', N'Thabazimbi', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (115, N'C064', N'SITA', N'P O Box 26100', N'Monument Park ', NULL, NULL, N'0105', N'John Voster Drive', N'Centurion', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (116, N'C065', N'Steve Tshwete Local Municipality', N'P O Box 14', N'Middelburg', NULL, NULL, N'1050', N'Wanderers Avenue', N'Middelburg', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (117, N'C066', N'University of Witwatersrand', N'West Campus', N'Johannesburg', NULL, NULL, N'0001', N'West Campus', N'Joahnnesburg', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (118, N'C067', N'National Health Laboratory Service', N'1 Modderfontein Road', N'Sandringham', NULL, NULL, N'0001', N'1 Modderfontein Road', N'Sandringham', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (119, N'C068', N'Project Management', N'qwerty', N'qwerty', N'qwerty', N'qwerty', N'1234', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (120, N'C069', N'Implementations', N'2', N'2', N'2', N'2', N'2', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (121, N'C207', N'Nquthu Local Municipality', N'Private Bag X5521', N'Nquthu', N'3135', NULL, N'3135', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (122, N'C071', N'John Taolo Gaetsewe District Municipality', N'PO Box 1480', N'Kuruman', NULL, NULL, N'8460', N'Federale Mainbou Street nr 4', N'Kuruman', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (123, N'C072', N'Classroom Training Centurion', N'PO Box 50818', N'Wierda Park', NULL, N'0149', N'0157', N'Cambridge Office Park  nr 25', N'5 Bauhinia Street', N'Highveld Tecno Park', N'Centurion', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (124, N'C073', N'Greater Taung Local Municipality', N'Private Bag X 1048', N'.', NULL, N'Taung', N'6580', N'Private Bag X 1048', N'.', NULL, N'Taung', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (125, N'C074', N'Classroom Training Kimberley', N'P O Box 997', N'.', NULL, N'Kimberley', N'8301', N'55 Gerrit Schouten Drive', N'2 Velvet lodge', NULL, N'Kimberley', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (126, N'C075', N'Sebata GIS Department', N'Sebata Centurion', N'Cambridge Office Par', NULL, NULL, N'0157', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (127, N'C076', N'Sebata GIS', N'Bldg 25 ', N'Cambridge Office Par', NULL, NULL, N'0157', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (128, N'C077', N'Rehoboth', N'Private bag 2500', N'Rehoboth', N'Namibia', NULL, N'Nam', NULL, NULL, NULL, NULL, 6, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (129, N'C078', N'MICROmega Groupe IT', N'P O Box 13672', N'Cascades', N'Pietermaritzburg', NULL, N'3202', N'Block D 1st Floor', N'Hilltops Office Park', N'73 Villiers Drive', N'Clarendon', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (130, N'C079', N'MICROmega Group IT', N'P O Box 13672', N'Cascades', N'Pietermaritzburg', NULL, N'3202', N'Block D 1st Floor', N'Hilltops Office Park', N'73 Villiers Drive', N'Clarendon', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (131, N'C221', N'Ubuntu Local Municipality', N'Private Bag X329', N'Victoria Wes', NULL, NULL, N'7070', N'Private Bag X329', N'Victoria Wes', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (132, N'C215', N'Sundays River Valley Local Municipality', N'PO Box 47', N'Kirkwood', N'6120', NULL, N'6120', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (133, N'C085', N'Trudon Ltd', N'P.O. Box 10474', N' Johannesburg', NULL, NULL, N' 2000', N'24 South Boulevard', N' Block F Eastgate', N' Bruma,  Johannesbur', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (134, N'C086', N'Sebata Mnicipal Solution Free State', N'Private Bag 9966', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (135, N'C087', N'Sebata Admin Easten Cape', N'Private Bag X 9966', N'Sandton', NULL, NULL, N'2196', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (136, N'C270', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (137, N'C251', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (138, N'C252', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (139, N'C253', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (140, N'C254', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (141, N'C255', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (142, N'C256', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (143, N'C257', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (144, N'C258', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (145, N'C259', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (146, N'C260', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (147, N'C261', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (148, N'C262', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (149, N'C263', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (150, N'C264', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (151, N'C265', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (152, N'C266', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (153, N'C267', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (154, N'C268', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
GO
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (155, N'C269', N'Pioneer Foods CPT', N'32 Market street', N'ceares house', N'Paarl', NULL, N'1746', N'32 Market street', N'ceares house ', N'Paarl', NULL, 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (156, N'C108', N'Phokwane Municipality', N'Private Bag X3', N'Hartswater', NULL, NULL, N'8570', N'24 Hertozog Sterrt', N'Hartswater', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (157, N'C109', N'Virgin Active', N'1st Floor,MontClare Place', N'cnr Main & Campgroun', N'Claremont', NULL, N'7700', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (158, N'C110', N'Shoprite', N'Cnr William Dabs and Old Paarl Roads', N'Brackenfell ', NULL, NULL, N'7560', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (159, N'C111', N'Victor Khanye Local Municipality', N'PO Box 6', N'Delmas', NULL, NULL, N'2210', NULL, N'P O Box 6', N'Delmas', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (160, N'C112', N'Aard Mining Equipment', N'PO Box 3992', N'Witbeeck', NULL, NULL, N'1729', N'44 Jacobs Street', N'Chamdor', N'Krugersdorp', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (161, N'C113', N'Micromega Holdings', N'Private Bag X9966', N'Sandton', N'Johannesburg', NULL, N'2196', N'66 Park Lane', N'Sandton', N'Johannesburg', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (162, N'C114', N'Dikgatlong Local Municipality', N'Private Bag X5', N'Barkly West', NULL, NULL, N'8375', N'Private Bag X5', N'Barkly West', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (163, N'C115', N'Micromega Revenue', N'P O Box 15087', N'Lambton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (164, N'C116', N'Joe Morolong Local Municipality', N'Private Bag X117', N'Nothibistad', NULL, NULL, N'8474', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (165, N'C189', N'Greater Giyani Local Municipality ', N'Private Bag X9559', N'Giyani', NULL, NULL, N'0826', N'BA59 Civic Centre', N'Giyani Road', N'Giyani', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (166, N'C118', N'O R Tambo District Municipality', N'66 Park Lane', N'Sandton', NULL, NULL, N'2146', N'Private Bag X9966', N'sANDTON', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (167, N'C119', N'Langeberg Local Municipality', N'Private Bag X9966', N'Sandton', NULL, NULL, N'6715', N'28 Main Road', N'Ashton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (168, N'C120', N'Inkwanca Local Municipality', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2196', N'66 Park Lane', N'Sandto', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (169, N'C121', N'Servest Group', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2194', N'281 Honeydew Road West', N'Northriding', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (170, N'C122', N'Lekwa Local Municipality', N'PO Box 66', N'Standarton', NULL, NULL, N'4196', N'66 Parl Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (171, N'C123', N'Endumeni Local Municipality', N'64 Victoria Street', N'Dundee', NULL, NULL, N'3000', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (172, N'C124', N'Sebata Municipal Solution', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2196', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (173, N'C181', N'Department of Public Work Eastern Cape', N'Private Bag X3913', N'Port Elizabeth', NULL, NULL, N'6065', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (174, N'C126', N'Frances Baard District Municipality', N'Private Bag X6088', N'Kimberley', NULL, NULL, N'8301', N'51 Drakenburg Avenue', N'Carters Glen', N'Kimberley', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (175, N'C127', N'Midvaal Local Municipality', N'P O Box 9', N'Meyertown', NULL, NULL, N'9060', N'66 Park Lane', N'Sandto', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (176, N'C128', N'Randfontein Local Municipality', N'PO Box 218', N'Randfontein', NULL, NULL, N'1760', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (177, N'C129', N'Abaqulusi Local Municipality', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2196', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (178, N'C178', N'Bojanala Platinum District Municipality', N'P O Box 1993', N'Rustenburg', NULL, NULL, N'0300', N'P O Box 1993', N'Rustenburg', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (179, N'C131', N'International SOA', N'PO BOX 4561', N'Halfwayhouse', NULL, NULL, N'1682', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (180, N'C132', N'MECS Africa', N'P O Box 527', N'Umbogintwini', NULL, NULL, N'4120', N'Office 2, ', N'42 Beechgate Crescen', N'Southgate Business P', N'Umbogintwini', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (181, N'C133', N'Amathole District Municipality', N'PO Box 320', N'East London', NULL, NULL, N'5200', N'Caxton House', N'East London', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (182, N'C134', N'KZN Department of Agriculture and Environmental Af', N'Private Bag X9059', N'Pietermaritzburg', NULL, NULL, N'3201', N'Hilltops Office Park', N'73 Villiers Drive', N'Clarendon', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (183, N'C135', N'IMASP Application', N'P O Box 13672', N'Cascades', N'Pietermaritzburg', NULL, N'3202', N'Hilltops Office Park', N'73 Villiers Drice', N'Clarendon', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (184, N'C136', N'Alfred  Nzo District Municipality', N'Private Bag X511,', N'Mount Ayliff', NULL, NULL, N'4735', N'Erf 1400', N'Ntsizwa Street,', N'Mount Ayliff', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (185, N'C137', N'TF Manufacturing Pty Ltd', N'PO Box 7580', N'East London', NULL, NULL, N'5201', N'2 Penkop Street', N'Woodbrook', N'East London', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (186, N'C138', N'COD Adhoc Sales', N'P O Box 13672', N'Pietermaritzburg', NULL, NULL, N'3201', N'Hilltops Office Park', N'73 Villies Drive', N'Clarendon', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (187, N'C139', N'Intermap SA', N'P O Box 13672', N'Cascades', N'Pietermaritzburg', NULL, N'3202', N'Hilltops Office Park', N'73 Villiers Drice', N'Clarendon', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (188, N'C140', N'Sappi Forest Products', N'PO Box 13124', N'Cascades', N'Pietermaritzburg', NULL, N'3203', N'Hilltops Office Park', N'73 Villiers Drive', N'Clarendon', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (189, N'C141', N'EMPOWRrisk', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (190, N'C142', N'Sponsorship', N'P O Box 13672', N'Cascades', N'Pietermaritzburg', NULL, N'3201', N'Hilltops Office Park', N'73 Villiers Drive', N'Clarendon', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (191, N'C143', N'Hlabisa Local Municipality', N'P O Box 387', N'Hlabisa', NULL, NULL, N'3937', N'4-6/2 Masson Street', N'Hlabisa', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (192, N'C144', N'Ilembe District Municipality', N'P O Box 49726', N'Durban', NULL, NULL, N'4000', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (193, N'C145', N'Imbabazane Local Municipality', N'PO BOX 750', N'Escourt', NULL, NULL, N'3310', N'Ntabamhlophe', N'Escourt', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (194, N'C146', N'IMASP Networking', N'P.O. Box 13672', N'Cascades', N'Pietermaritzburg', NULL, N'3201', N'Hilltops Office Park', N'73 Villiers Drive', N'Clarendon', N'Pieteramaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (195, N'C147', N'Johannesburg Water', N'P O Box 338', N'North Riding', NULL, NULL, N'2162', N'Hilltops Office Park', N'73 Villiers Drive', N'Clarendon', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (196, N'C148', N'Mandeni Local Municipality', N'PO Box 144', N'Mandeni', NULL, NULL, N'4490', N'Hilltops Office Park', N'73 Villiers Drive', N'Clarendon', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (197, N'C149', N'Metflux PTY Ltd', N'5008 Celtis Road', N'Hilton', N'Pietermaritzburg', NULL, N'3245', N'5008 Celtis Road', N'Hilton', N'Pietermaritzburg', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (198, N'C150', N'MICROmega Technologies', N'P.O Box 5457', N'Halfway House', N'Gauteng', NULL, N'1687', N'66 Park Lane', N'Sandton', N'Johannesburg', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (199, N'C151', N'Newcastle Local Municipality', N'Private Bag X6621', N'NewCastle', NULL, NULL, N'2940', N'Private Bag X6621', N'NewCastle', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (200, N'C152', N'Red Earth cc', N'278 Bulwer Street', N'Pietermaritzburg', NULL, NULL, N'3201', N'278 Bulwer Street', N'Pietermaritzburg', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (201, N'C153', N'Sappi Fibre Processing', N'P O Box 12796', N'Hatfield', N'Pietermaritzburg', NULL, N'0028', N'The Innovation Hub', N'Lynwood', N'Pretoria', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (202, N'C154', N'Sappi Southern Africa', N'PO Box 6', N'The Innovation Hub ', N'Lynnwood', N'Pretoria', N'0087', N'1 Sydney Brenner Street ', N'Innovation Hub', N'Lynnwood', N'Pretoria', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (203, N'C155', N'Sareal', N'Gejakes@iafrica.com', N'Use Email', N'no postal address', NULL, N'3202', N'Hilltops Office Park', N'73 Villiers Drive', N'Clarendon', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (204, N'C156', N'Sisonke District Municipality', N'Private Bag X501', N'Ixopo', NULL, NULL, N'3276', N'Private Bag X501', N'Ixopo', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (205, N'C157', N'Sisonke District Municipality', N'Private Bag X501', N'Ixopo', NULL, NULL, N'3276', N'Private Bag X501', N'Ixopo', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (206, N'C158', N'Ecomotion', N'Unknown', N'Unknown', NULL, NULL, N'3201', N'Unknown', N'Unknown', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (207, N'C159', N'Stable Net', N'P O Box 5457', N'Halfway House', NULL, NULL, N'1685', N'809/1 Mathews House', N'Hamits crossing offi', N'Celbourne avenue, 4 ', N'2068', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (208, N'C160', N'Uthungulu District Municipality', N'Private Bag X1025', N'Richards Bay', NULL, NULL, N'3900', N'Private Bag X1025', N'Richards Bay', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (209, N'C161', N'Ugu District Municipality', N'P O Box 33', N'Port Shepstone', NULL, NULL, N'4240', N'P O Box 33', N'Port Shepstone', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (210, N'C162', N'Umgungundlovu District Municipality', N'P O Box 3235', N'Pietermaritzburg', NULL, NULL, N'3200', N'P O Box 3235', N'Pietermaritzburg', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (211, N'C163', N'Umkhanyakude District Municipality ', N'P.O Box 449', N'Mkhuze', NULL, NULL, N'3965', N'Harlingen No.13433', N'King Fisher Rd', N'Mkhuze', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (212, N'C164', N'Uthukela District Municipality', N'P O Box 116', N'76 Murchison Strret', N'Ladysmith', NULL, N'3370', N'P O Box 116', N'76 Murchison Strret', N'Ladysmith', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (213, N'C165', N'Wildlands Conservation Trust', N'P O BOx 1138', N'Hilton', NULL, NULL, N'3245', N'Quarry Centre', N'Hilton', N'Kwazulu Natal', N'South Africa', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (214, N'C166', N'Zululand District Municipality', N'Private Bag X76', N'Ulundi', NULL, NULL, N'3838', N'Private Bag X76', N'Ulundi', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (215, N'C167', N'Mopani District Municipality', N'Private Bag X9687', N'Giyani', NULL, NULL, N'0826', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (216, N'C196', N'Maluti-a-Phofung Local Municipality', N'Private Bag X9966', N'Phuthaditjaba', NULL, NULL, N'Sandton', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (217, N'C169', N'PEC Metering Group', N'Private Bag X9966', N'Sandton', NULL, NULL, N'4162', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (218, N'C200', N'Mogale City Local Municipality', N'Private Bag X9966', N'Sandton', NULL, NULL, N'4126', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (219, N'C171', N'Dihlabeng Local Municipality', N'66 Park Lane', N'Sandton', NULL, NULL, N'9700', N'P O Box 551', N'Bethelehem', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (220, N'C172', N'The Commission of Water', N'Private Bag A440', N'Maseru', N'Lesotho', NULL, N'0000', N'Private Bag A440', N'Maseru', N'Lesotho', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (221, N'C225', N'City of Tswane Local Municipality', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (222, N'C226', N'Geldenhuys Botha Incorporated', N'66 Park Lane', N'Sandton', NULL, NULL, N'2146', N'Private Bag X9966', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (223, N'C227', N'Deltec Power', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2416', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (224, N'C228', N'Turrito Networks', N'Private Bag X 996', N'Sandton', NULL, NULL, N'2196', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (225, N'C229', N'Electrocuts', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2146', N'7 Golden Gate Boulevard', N'Vaalpark', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (226, N'C230', N'MNCA', N'Private Bag X996', N'Sandton', NULL, NULL, N'4126', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (227, N'C231', N'Tarkastad Tsolwana Local Municipality ', N'P O Box 21', N'Tarkastad', NULL, NULL, N'5370', N'P O Box 21', N'Tarkastad', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (228, N'C232', N'Moffat Optical', N'73 Villiers Drive', N'Clarendon', N'Pietermaritzburg', NULL, N'3201', N'73 Villiers Drive', N'Clarendon', N'Pietermaritzburgg', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (229, N'C233', N'Blue Crane Route Local Municipality', N'PO Box 0000', N'Somerset East', NULL, NULL, N'0000', NULL, N'Somerset East', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (230, N'C234', N'Eskom', N'P O Box 0000', N'Eskom', NULL, NULL, N'0000', NULL, N'Eskom', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (231, N'C235', N'George Local Municipality', N'PO Box 0000', N'George', NULL, NULL, N'0000', NULL, N'George', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (232, N'C236', N'Lesedi Local Municipality', N'P O Box 0000', N'Heidelberg', NULL, NULL, N'0000', NULL, N'Heidelberg', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (233, N'C237', N'Madibeng Local Municipality', N'P O Box 0000', N'Brits', NULL, NULL, N'0000', NULL, N'Brits', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (234, N'C238', N'Mamusa Local Municipality', N'PO Box 0000', N'Schweizer-Reneke', NULL, NULL, N'0000', NULL, N'Schweizer-Reneke', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (235, N'C240', N'Sub Project', N'PO Box 0000', N'JHB', NULL, NULL, N'0000', NULL, N'JHB', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (236, N'C241', N'Mbombela Local Municipality', N'P O Box 0000', N'Nulspruit', NULL, NULL, N'0000', NULL, N'Nelspruit', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (237, N'C242', N'Naledi Local Municipality', N'P O Box 0000', N'Dewetsdorp', NULL, NULL, N'0000', NULL, N'Dewetsdorp', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (238, N'C243', N'Sandspruit', N'Snadspruit', N'Sandspruit', NULL, NULL, N'0000', NULL, N'Sandspruit', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (239, N'C244', N'Sedibeng District Municipality', N'Vereeniging', N'Vereeniging', NULL, NULL, N'0000', NULL, N'Vereeniging', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (240, N'C245', N'Silulumanzi ', N'Silulumanzi ', N'Silulumanzi ', NULL, NULL, N'0000', NULL, N'Silulumanzi ', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (241, N'C246', N'uMhlathuze Local Municipality', N'Richards Bay', N'Richards Bay', NULL, NULL, N'0000', NULL, N'Richards Bay', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (242, N'C247', N'NOSA', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2196', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (243, N'C248', N'Sebata Namibia', N'PO Box 111984', N'Klein Windhoek', NULL, NULL, N'00000', N'Room 1, Ground', N'YngTze Village', N'Klein Windhoek', N'Namibia', 6, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (244, N'C249', N'Nkangala District Municipality', N'PO Box 437', N'Middelburg', NULL, NULL, N'1050', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (245, N'C271', N'Sekhukhune District Municipality', N'Private Bag X 8611', N'Groblersdal', NULL, NULL, N'0470', N'No 3 Wes Street', N'Groblersdal', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (246, N'C272', N'Maletswai', N'Private Bag X1011', N'9750', N'Aliwal North', NULL, N'9750', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (247, N'C273', N'MNQUMA LM', N'PO Box 36', N'Butterworth', NULL, NULL, N'4960', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (248, N'C274', N'Govan Mbeki Municipality', N'Private Bag X1017', N'Secunda', NULL, NULL, N'2302', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (249, N'C275', N'Maletswai MMS Statement', N'Private Bag X1011', N'Aliwal North', NULL, NULL, N'9750', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (250, N'C276', N'Maletswai', N'Private Bag X1011', N'Aliwal North', NULL, NULL, N'9750', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (251, N'C279', N'Maletswai ', N'Private Bag X1011', N'Aliwal North', NULL, NULL, N'9750', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (252, N'C282', N'Workshops', N'Stone Safari', N'Freestate', NULL, NULL, N'0000', N'Stone Safari', N'Freestate', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (253, N'C283', N'HP', N'150 Route du Nant d'' Avril', N'1217 Meyrin 2 Geneva', N'Switzerland', NULL, N'Switzerlan', NULL, NULL, NULL, NULL, 5, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (254, N'C284', N'Gigima', N'PO Box 10629', N'Centurion', N'0046', NULL, N'0046', N'47 Landmarks Avenue', N'Kosmosdal', N'Samrand', N'0157', 1, 1)
GO
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (255, N'C285', N'IMFO Institute for Municipal Finanace Officers ', N'Po Box 28', N'Kempton Park', NULL, NULL, N'0001', N'28 Fortress Street ', N'Rhodesfield ', N'Kempton Park ', N'0001', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (256, N'C286', N'Wanda Michelle Interior ', N'Postnet Suite #251', N'P BAG X11', N'Craighall', N'2024', N'2024', N'223 Jan Smuts Avenue', N'Parktown North', N'Johannesburg', N'South Africa', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (257, N'C287', N'Kimberley Junior School', N'O''Brien Street', N'Monument Heights', N'Kimberley', NULL, N'8301', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (258, N'C288', N'Greater Kokstad Municipality', N'P.O. Box 8', N'Kokstad', N'4700', NULL, N'4700', N'75 Hope Street', N'Kokstad', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (259, N'C289', N'Genasys Technologies Pty Ltd', N'PO Box 133', N'Bergbron', N'1712', NULL, N'1712', N'1st Floor Willowbrook house', N'Constancia Office Pa', N'Cnr 14th Ave & Henri', N'Weltevredenpark', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (260, N'C290', N'DR Kenneth Kaunda District Municipality', N'Private Bag X5017 ', N'Klerksdorp, 2570 ', N'2570', NULL, N'2619 ', N'Orkney,', N'2619 ', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (261, N'C291', N'Micromega Securities', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (262, N'C293', N'Ekurhuleni Metro Municipality', N'Private Bag X65', N'Benoni', NULL, NULL, N'1501', N'Sanburn Building', N'68 Woburn Avenue', N'Benoni', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (263, N'C294', N'Galway Primary School', N'PO BOX 4001', N'Delville', N'Germiston South', N'Gauteng', N'1411', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (264, N'C295', N'NOSA Namibia', N'PO Box 111984', N'Kein Windhoek', N'Namibia', NULL, N'Namibia', NULL, NULL, NULL, NULL, 6, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (265, N'C296', N'Mjindi Farming Pty Ltd', N'PO Box 28', N'Jozini', NULL, NULL, N'3969', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (266, N'C297', N'Department of Agriculture and Enviromental', N'Private Bag X9059', N'Pietermaritzburg ', N'South Africa', NULL, N'3200', N'Private Bag X9059', N'Pietermaritzburg ', N'South Africa', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (267, N'C298', N'Telephones for Africa Pty Ltd', N'PO Box 467', N'Halfway House', N'Midrand', N'1684', N'1684', N'134 Walton Road', N'Carlswad', N'Midrand', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (268, N'C299', N'Oranjemund Town Council', N'PO Box 178', N'Orjanemund', NULL, NULL, N'1111', N'Corner 8 & 12 Ave', N'Oranjemund', NULL, NULL, 6, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (269, N'C300', N'Umtshezi Local Municipality', N'Umtshezi Mun - Stores', N'Water Works Road', N'Estcourt', NULL, N'3310', N'P.O. Box 15', N'Estcourt', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (270, N'C301', N'Joe Gqabi District Municipality', N'Private Bag x102', N'Barkly East', N'9786', NULL, N'9786', N'Cnr Graham & Coles street', N'Barkly East', N'9786', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (271, N'C302', N'North West Development Corportation', N'22 James Watt Crescent', N'Mafikeng', N'Noth West', NULL, N'2745', N'PO Box 3011', N'Mmabatho', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (272, N'C303', N'MICT SETA', N'PO Box 5585', N'Halfway house', N'1685', N'Gauteng', N'1685', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (273, N'C304', N'Di Siena Attorneys', N'PO Box 78333', N'Sandton City', NULL, NULL, N'2146', N'22 Fredman Drive', N'Sandton', N'Johannesburg', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (274, N'C305', N'UKS', N'PO Box 7195', N'Weltevrenden Park', N'1715', NULL, N'1709', N'Cnr 14th & Hendrik Potgieter Avenue', N'Gateview Office Park', N'Weltevreden Park', N'1709', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (275, N'C306', N'Sebata Internship 2014 ', N'Private Bag X9966', N'Sandton', N'Johannesburg', NULL, N'2146', N'66 Park Lane', N'Sandton', N'Johannesburg', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (276, N'C307', N'Moqhaka Municipality', N'PO Box 302', N'Kroonstad', NULL, NULL, N'9500', N'Hill Street', N'Kroonstad', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (277, N'C308', N'Ndlambe Municipality', N'Causeway', N'PO Box 13', N'Port Alfredo', NULL, N'6170', N'Bathurs, Kenton on Sea', N'Boersmansriviermond', N'Alexandria, Seafield', N'Bokness', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (278, N'C309', N'Makana Local Municipality', N'PO Box 176', N'Grahamstown', NULL, NULL, N'6140', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (279, N'C310', N'Baatsuma Electrical CC', N'PO Box 2907', N'Bela Bela', NULL, NULL, N'0480', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (280, N'C311', N'Sebata Municipal Solutions Bloem ', N'Private Bag X9966', N'sANDTO', NULL, NULL, N'2401', N'66 Park Lnae', N'2Sandto', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (281, N'C312', N'Mafube Local Municipality', N'P O Box 2', N'Frankfort', NULL, NULL, N'9830', N'P O Box 2', N'Frankfort', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (282, N'C313', N'Living Africa Commercial Pty Ltd', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (283, N'C314', N'Living Africa Commercial Pty Ltd', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (284, N'C315', N'Living Africa Commercial Pty Ltd', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (285, N'C316', N'Living Africa Commercial Pty Ltd', N'Private Bag X9966', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1282, N'C317', N'Amanzi ', N'Pricate Bag X9966', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandto', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1283, N'C318', N'Xhariep District Municipality', N'20 Louw Street', N'Trompsburg', N'South Africa', N'9913', N'9913', N'Private BAg x136', N'Trompsburg', N'9913', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1334, N'C319', N'Agricbusiness  Development Agency', N'Private Bag X01', N'Cascades', N'Pietermaritzburg', N'KZN', N'3202', N'Chief Executive Officer', N'5 Cascades Crescent', N'Cascades Office Park', N'Pietermaritzburg', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1335, N'C320', N'Department of Public Works Free State', N'P O Box 690', N'Bloemfontain', NULL, NULL, N'9300', N'Room 419', N'Meadfontein Block', N'ST Andrews Street', N'Bloemfontein', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1336, N'C321', N'Ramotshere Moiloa Local Municipality', N'P O Box 92', N'Zeerust', NULL, NULL, N'2865', N'C/N President and Coetzee Street', N'Zeerust', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1337, N'C322', N'R DATA', N'218 Buitungracht ', N'Cape Town', NULL, NULL, N'803', N'218 Buitungracht ', N'Level 3', N'Cape Town', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1338, N'C323', N'GoMobile Johannesburg Head Office', N'Private Bag 50051', N'Randjtiespark', N'JHB', NULL, N'1683', N'Jonadale Avenue', N'Halfway Gardens', N'1685', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1339, N'C324', N'Ayavelisa Network Consulting', N'688 Ghallagher Business Exchange', N'Midrand', N'Gauteng', N'South Africa', N'0000', N'688 Ghallagher Business Exchange', N'Midrand', N'Gauteng', N'South Africa', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1340, N'C325', N'tesy', N'test', N'test', N'test', N'test', N'test', N'test', N'test', N'test', N'test', 1, 0)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1341, N'C326', N'FreshMark System', N'Private Bag X9966', N'Sandton', N'JHB', NULL, N'4106', N'66 Park Lane', N'Sandton', N'JHB', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1342, N'C327', N'Utility Systems Hardware and Software Sales', N'66 Park Lane', N'Sandton', NULL, NULL, N'4126', N'Private Bag X9966', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1343, N'C328', N'Mubesko Africa', N'66 Park Lane', N'Sandton', NULL, NULL, N'2146', N'Private Bag X9966', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1356, N'C329', N'Nelson Mandela Bay Municipality', N'PO Box 3188', N'Port Elizabeth', N'6052', NULL, N'6052', NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1357, N'C330', N'Regucom Kano JV', N'No Adress', N'No Address', NULL, NULL, N'0000', N'No Adrees', N'No Adress', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1358, N'C332', N'Mossel bay Municipality', N'Private Bag X 9966', N'Sandton', N'JHB', NULL, N'2146', N'66 Park Lane', N'Sandton', N'JHB', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1359, N'C333', N'LGSETA', N'Private Bag X9966', N'Sandtom', N'JHB', NULL, N'3241', N'66 Park Lane ', N'Sandton', N'JHB', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1360, N'C334', N'CQS Technology Holdings Pty Ltd ', N'66 Park Lane', N'Sandton', N'JHB', NULL, N'2146', N'Private Bag X9966', N'Sandton', N'JHB', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1361, N'C335', N'MECS Growth', N'Private Bag x 9966', N'Sandton', NULL, N'2146', N'2146', N'66 Parklane Street', N'Sandton', NULL, N'2146', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1362, N'C336', N'MIA Telecomms', N'PO Box 467', N'Halfway house', N'Midrand', NULL, N'1685', N'134 Walton Rd', N'Midrand', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1363, N'C337', N'Department of Education in Free State', N'Dept of Education', N'Private Bag X 20565', N'Bloemfontein', NULL, N'9301', N'Room 28', N'Syfrets Building', N'65 Charlotte Maxeke', N'Bloemfontein', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1364, N'C338', N'IQ Business', N'Private Bag x 9966', N'Sandton', NULL, NULL, N'2146', N'66 Parklane', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1365, N'C339', N'Unique X Ray Services', N'57 Joan Road ', N'Winternest', N'Pretoria', NULL, N'0001', N'57 Joan Road ', N'Winternest', N'Pretoria', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1366, N'C340', N'Merchant Links PVT LTD', N'30 Rayden Drive', N'Borrowdale', N'Harare', N'Zimbabwe', N'12478', N'30 Rayden Drive', N'Borrowdale', N'Harare', N'Zimbabwe', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1367, N'C341', N'Ansys Limited', N'P.O Box 95361', N'Waterkloof', NULL, NULL, N'0157', N'140 Bauhinia Str', N'Highveld', N'Cape Town', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1368, N'C342', N'AV Alliance Pty Ltd', N'116 Edward Str', N'Bellville', N'Cape Town', NULL, N'7530', N'116 Edward Str', N'Bellville', N'Cape Town', NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1369, N'C343', N'Core 2Africa PTY LTD', N'66 Peter Place', N'Bryanston', NULL, NULL, N'2191', N'66 Peter Place', N'Bryanston', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1370, N'C344', N'CSD Targus PTY LTD', N'6 Slate Ave', N'N1 Business Park', N'Old Johannesburg Roa', N'Midrand', N'1684', N'6 Slate Ave', N'N1 Business Park', N'Old Johannesburg Roa', N'Midrand', 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1371, N'C345', N'Lan Solutions PTY LTD', N'P.O Box 1230', N'Sandton', NULL, NULL, N'2146', N'66 Park Lane', N'Sandton ', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1372, N'C346', N'Securedata Pty Ltd', N'P.O Box 1230', N'Sandton', NULL, NULL, N'2146', N'66 Parklane Rd', N'Sandton', NULL, NULL, 1, 1)
INSERT [dbo].[TT_Clients] ([ClientID], [ClientCode], [ClientName], [PostAddress], [PostSuburb], [PostCity], [PostProvince], [PostCode], [PhyAddress], [PhySuburb], [PhyCity], [PhyProvince], [CountryID], [Enabled]) VALUES (1373, N'C347', N'Smart Client Services PTY LTD', N'P.O Box 1463', N'Faerie Glen', NULL, NULL, N'0041', N'457 Witherite Rd', N'Alenti Office Park', N'The Willows', NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[TT_Clients] OFF


SET IDENTITY_INSERT [dbo].[TT_CostCentres] ON 

INSERT [dbo].[TT_CostCentres] ([CostCentreID], [CostCentreName], [ManagerID], [CountryID], [Enabled]) VALUES (1, N'RData', 169, 1, 1)
SET IDENTITY_INSERT [dbo].[TT_CostCentres] OFF

SET IDENTITY_INSERT [dbo].[TT_Countries] ON 

INSERT [dbo].[TT_Countries] ([CountryID], [CountryName], [CurrencyID]) VALUES (1, N'South Africa', 1)
INSERT [dbo].[TT_Countries] ([CountryID], [CountryName], [CurrencyID]) VALUES (2, N'Australia', 2)
INSERT [dbo].[TT_Countries] ([CountryID], [CountryName], [CurrencyID]) VALUES (3, N'Germany', 3)
INSERT [dbo].[TT_Countries] ([CountryID], [CountryName], [CurrencyID]) VALUES (4, N'USA', 6)
INSERT [dbo].[TT_Countries] ([CountryID], [CountryName], [CurrencyID]) VALUES (5, N'UK', 5)
INSERT [dbo].[TT_Countries] ([CountryID], [CountryName], [CurrencyID]) VALUES (6, N'Namibia ', 1)
SET IDENTITY_INSERT [dbo].[TT_Countries] OFF
SET IDENTITY_INSERT [dbo].[TT_Currencies] ON 

INSERT [dbo].[TT_Currencies] ([CurrencyID], [CurrencyName], [CurrencySymbol], [ExchangeRate]) VALUES (1, N'Rand', N'R', 1)
INSERT [dbo].[TT_Currencies] ([CurrencyID], [CurrencyName], [CurrencySymbol], [ExchangeRate]) VALUES (2, N'Australian Dollar', N'AU$', 4.78533)
INSERT [dbo].[TT_Currencies] ([CurrencyID], [CurrencyName], [CurrencySymbol], [ExchangeRate]) VALUES (3, N'Danisk Krone', N'DK', 1.09781)
INSERT [dbo].[TT_Currencies] ([CurrencyID], [CurrencyName], [CurrencySymbol], [ExchangeRate]) VALUES (4, N'Euro', N'€', 8.16907)
INSERT [dbo].[TT_Currencies] ([CurrencyID], [CurrencyName], [CurrencySymbol], [ExchangeRate]) VALUES (5, N'Pound', N'£', 12.0957)
INSERT [dbo].[TT_Currencies] ([CurrencyID], [CurrencyName], [CurrencySymbol], [ExchangeRate]) VALUES (6, N'US Dollar', N'$', 6.605)
INSERT [dbo].[TT_Currencies] ([CurrencyID], [CurrencyName], [CurrencySymbol], [ExchangeRate]) VALUES (7, N'Namibian dolar', N'N$', 1)
SET IDENTITY_INSERT [dbo].[TT_Currencies] OFF
SET IDENTITY_INSERT [dbo].[TT_ExpenseTypes] ON 

INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (8, N'Mileage 1', 1, 2.5000, 1)
INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (9, N'Telephone', 0, 0.0000, 1)
INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (10, N'Tolls', 0, 0.0000, 1)
INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (11, N'Meals', 0, 0.0000, 1)
INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (12, N'Parking', 0, 0.0000, 1)
INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (13, N'Miscellaneous', 0, 0.0000, 1)
INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (14, N'Mileage Management', 1, 3.3000, 1)
INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (15, N'', 0, 0.0000, 0)
INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (16, N'Outsource Mileage', 1, 3.2000, 1)
INSERT [dbo].[TT_ExpenseTypes] ([ExpenseTypeID], [Description], [Fixed], [Amount], [Enabled]) VALUES (17, N'Mileage 2', 0, 3.0000, 0)
SET IDENTITY_INSERT [dbo].[TT_ExpenseTypes] OFF
SET IDENTITY_INSERT [dbo].[TT_FinancialDocTypeUsers] ON 

INSERT [dbo].[TT_FinancialDocTypeUsers] ([FinancialDocTypeEmailID], [FinancialDocTypeID], [UserID]) VALUES (1, 2, 3)
SET IDENTITY_INSERT [dbo].[TT_FinancialDocTypeUsers] OFF
INSERT [dbo].[TT_FinancialDocumentType] ([FinancialDocTypeID], [FinancialDocType], [ApprovalRequired]) VALUES (1, N'Internal Order', 0)
INSERT [dbo].[TT_FinancialDocumentType] ([FinancialDocTypeID], [FinancialDocType], [ApprovalRequired]) VALUES (2, N'Invoice', 1)
SET IDENTITY_INSERT [dbo].[TT_OrderItems] ON 

INSERT [dbo].[TT_OrderItems] ([OrderItemID], [ItemName], [Enabled]) VALUES (1, N'Professional Fees', 1)
INSERT [dbo].[TT_OrderItems] ([OrderItemID], [ItemName], [Enabled]) VALUES (2, N'Travel', 1)
INSERT [dbo].[TT_OrderItems] ([OrderItemID], [ItemName], [Enabled]) VALUES (3, N'Training', 1)
INSERT [dbo].[TT_OrderItems] ([OrderItemID], [ItemName], [Enabled]) VALUES (4, N'Other', 1)
INSERT [dbo].[TT_OrderItems] ([OrderItemID], [ItemName], [Enabled]) VALUES (5, N'Accomodation', 1)
SET IDENTITY_INSERT [dbo].[TT_OrderItems] OFF

INSERT [dbo].[TT_ProfileTasks] ([UserID], [TaskID]) VALUES (3, 2)
INSERT [dbo].[TT_ProfileTSApproval] ([UserID], [Grouping]) VALUES (2, 0)






SET IDENTITY_INSERT [dbo].[TT_Rates] ON 

INSERT [dbo].[TT_Rates] ([RateID], [UserID], [CostCentreID], [Rate]) VALUES (4, 1, 1, 1000)
INSERT [dbo].[TT_Rates] ([RateID], [UserID], [CostCentreID], [Rate]) VALUES (1, 2, 1, 1000)
INSERT [dbo].[TT_Rates] ([RateID], [UserID], [CostCentreID], [Rate]) VALUES (2, 3, 1, 1000)
INSERT [dbo].[TT_Rates] ([RateID], [UserID], [CostCentreID], [Rate]) VALUES (3, 4, 1, 1000)
SET IDENTITY_INSERT [dbo].[TT_Rates] OFF

SET IDENTITY_INSERT [dbo].[TT_Status] ON 

INSERT [dbo].[TT_Status] ([StatusID], [StatusName]) VALUES (1, N'Take On')
INSERT [dbo].[TT_Status] ([StatusID], [StatusName]) VALUES (2, N'PTO Awaiting Approval')
INSERT [dbo].[TT_Status] ([StatusID], [StatusName]) VALUES (3, N'In Progress')
INSERT [dbo].[TT_Status] ([StatusID], [StatusName]) VALUES (4, N'Complete')
INSERT [dbo].[TT_Status] ([StatusID], [StatusName]) VALUES (5, N'VO Awaiting Approval')
SET IDENTITY_INSERT [dbo].[TT_Status] OFF
INSERT [dbo].[TT_System] ([PTOApprovals], [TSApprovals], [PTOApprover1Role], [PTOApprover2Role], [TSApprover1Role], [TSApprover2Role], [ForceTSComments], [TaskOrderItem], [UseWindowsAuthentication], [MonthlyReminderDay], [WeeklyReminderMeridian], [WeeklyReminderHour], [WeeklyReminderDOW], [WeeklyReminderEnabled], [WeekStartDay]) VALUES (1, 2, 7, 7, 7, 0, 1, 1, 0, 0, NULL, NULL, 1, 1, 7)
SET IDENTITY_INSERT [dbo].[TT_TimeOffTypes] ON 

INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (1, N'Compassionate Leave', 0)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (2, N'Public Holiday', 1)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (3, N'Sick Leave', 1)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (4, N'Annual Leave', 1)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (5, N'Family Responsibility', 1)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (6, N'Unpaid Leave', 1)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (7, N'Maternity Leave', 1)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (8, N'Study Leave', 1)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (9, N'In Liew of Overtime', 1)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (10, N'Relocation Leave', 1)
INSERT [dbo].[TT_TimeOffTypes] ([TypeID], [Description], [Enabled]) VALUES (11, N'Injury on Duty Leave', 1)
SET IDENTITY_INSERT [dbo].[TT_TimeOffTypes] OFF

SET IDENTITY_INSERT [dbo].[TT_Title] ON 

INSERT [dbo].[TT_Title] ([TitleID], [Title]) VALUES (1, N'Mr')
INSERT [dbo].[TT_Title] ([TitleID], [Title]) VALUES (2, N'Ms')
INSERT [dbo].[TT_Title] ([TitleID], [Title]) VALUES (3, N'Mrs')
INSERT [dbo].[TT_Title] ([TitleID], [Title]) VALUES (4, N'Dr')
INSERT [dbo].[TT_Title] ([TitleID], [Title]) VALUES (5, N'Prof')
SET IDENTITY_INSERT [dbo].[TT_Title] OFF
INSERT [dbo].[Usr_BusinessUnit] ([UnitID], [UnitName], [Enabled]) VALUES (1, N'RData', 1)
SET IDENTITY_INSERT [dbo].[Usr_GroupName] ON 

INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (0, N'Super User', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (1, N'Developer', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (2, N'User', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (3, N'Team Leader', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (4, N'Manager', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (5, N'MD', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (6, N'Admin', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (7, N'Admin Manager', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (8, N'System Administrator', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (9, N'Admin Support', 1)
INSERT [dbo].[Usr_GroupName] ([GroupID], [Descript], [Enabled]) VALUES (10, N'System Admin Support', 1)
SET IDENTITY_INSERT [dbo].[Usr_GroupName] OFF
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 2)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 3)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 4)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 5)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 6)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 7)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 8)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 9)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 10)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 11)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 12)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 13)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 14)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 15)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 16)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 17)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 18)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 22)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 23)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 24)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 26)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 27)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 61)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 62)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 63)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 67)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 68)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (0, 71)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 2)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 3)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 4)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 5)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 6)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 7)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 8)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 9)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 10)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 11)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 12)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 13)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 14)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 15)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 16)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 17)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 18)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 19)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 20)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 21)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 22)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 23)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 24)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 26)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 27)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 61)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 67)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 68)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (1, 71)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 6)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 8)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (2, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 2)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 3)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 4)
GO
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 6)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 7)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 8)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 9)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 67)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 68)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (3, 70)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 2)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 3)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 4)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 5)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 6)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 7)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 8)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 9)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 23)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 24)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 61)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 62)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 68)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 69)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (4, 70)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 2)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 3)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 4)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 5)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 6)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 7)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 8)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 9)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 23)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 24)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 68)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 69)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 70)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (5, 72)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 2)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 3)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 4)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 6)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 8)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 10)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 11)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 12)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 13)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 14)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 15)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 16)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 17)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 22)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 23)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 26)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 55)
GO
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 61)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 62)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 63)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 67)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 68)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (6, 71)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 2)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 3)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 4)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 6)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 7)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 8)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 9)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 10)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 11)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 12)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 13)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 14)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 15)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 16)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 17)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 18)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 22)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 23)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 26)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 27)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 61)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 62)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 63)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 65)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 67)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 68)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 69)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 70)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (7, 71)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 2)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 3)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 4)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 10)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 11)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 12)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 13)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 14)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 15)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 16)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 17)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 22)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 23)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 26)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 61)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 62)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 63)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 67)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 68)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (8, 71)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 4)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 6)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 8)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 10)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 11)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 13)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 16)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 23)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 50)
GO
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 61)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 62)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 63)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 67)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 68)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (9, 71)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 1)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 2)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 3)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 4)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 23)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 25)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 50)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 51)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 52)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 53)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 54)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 55)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 56)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 57)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 58)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 59)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 60)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 61)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 62)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 63)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 66)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 67)
INSERT [dbo].[Usr_GroupPermission] ([GroupID], [RoleID]) VALUES (10, 68)
SET IDENTITY_INSERT [dbo].[Usr_RoleName] ON 

INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (1, N'Start Page', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (2, N'Project Take On', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (3, N'Add New Client', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (4, N'Add New Contact', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (5, N'Project Approval', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (6, N'Add/Update Timesheet', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (7, N'Timesheet Approval Level 1 (Team Leader)', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (8, N'Add/Update Expenses', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (9, N'Expense Approval', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (10, N'Add/Update Users', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (11, N'Add/Update Budget Items', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (12, N'Add/Update Cost Centre', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (13, N'Add/Update Expense Items', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (14, N'Add/Update Countries', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (15, N'Add/Update User Roles', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (16, N'Update Client Details', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (17, N'Update Contact details', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (18, N'System Administration', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (19, N'Add/Update Approval Types', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (20, N'Add/Update Group Names', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (21, N'Role Names', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (22, N'Add/Update Currencies', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (23, N'Project Variation Order', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (24, N'Variation Order Approval', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (25, N'Project Listing', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (26, N'Project Closure', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (27, N'Add/Update TimeOff Types', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (50, N'Task Register Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (51, N'Expense & Disbursements Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (52, N'Project Summary Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (53, N'Project Status Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (54, N'Profitability Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (55, N'Exceptions Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (56, N'Project Listing Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (57, N'Time Analysis Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (58, N'Time Off Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (59, N'Timesheet Status Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (60, N'Project Information Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (61, N'Change TeamLeader', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (62, N'Can Change Project Resources', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (63, N'Can Change Project Dates', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (65, N'Approve Time Off', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (66, N'User Activity Register', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (67, N'Data Extract Report', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (68, N'Can View All Users Reports', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (69, N'Timesheet Approval Level 2 (Manager)', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (70, N'Financial Document Approval', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (71, N'Update Financial Document Type Emails', 1)
INSERT [dbo].[Usr_RoleName] ([RoleID], [RoleName], [Enabled]) VALUES (72, N'Timesheet Approval Level 3/Top Level (MD)', 1)
SET IDENTITY_INSERT [dbo].[Usr_RoleName] OFF
SET IDENTITY_INSERT [dbo].[Usr_UserDetail] ON 

INSERT [dbo].[Usr_UserDetail] ([UserID], [UserName], [Password], [Position], [TelNo], [SMSNo], [EMail], [RecSMS], [FirstName], [LastName], [Initials], [UnitID], [Enabled], [TotalLogin], [LastLoginDate], [EmployeeCode]) VALUES (1, N'admin', N'imint098                 ', N'', N'0333456981', N'', N'customer.care@intermap.co.za', NULL, N'Super', N'User', N'SU', 1, 1, 6604, CAST(0xA6CF0375 AS SmallDateTime), N'')
INSERT [dbo].[Usr_UserDetail] ([UserID], [UserName], [Password], [Position], [TelNo], [SMSNo], [EMail], [RecSMS], [FirstName], [LastName], [Initials], [UnitID], [Enabled], [TotalLogin], [LastLoginDate], [EmployeeCode]) VALUES (2, N'happiness', N'happiness                ', N'Admin Assistant', N'0827373410', N'', N'happiness.hlongwana@sebata.co.za', NULL, N'Happiness', N'Hlongwana', N'H H', 1, 1, 220, CAST(0xA6CF0392 AS SmallDateTime), N'235')
INSERT [dbo].[Usr_UserDetail] ([UserID], [UserName], [Password], [Position], [TelNo], [SMSNo], [EMail], [RecSMS], [FirstName], [LastName], [Initials], [UnitID], [Enabled], [TotalLogin], [LastLoginDate], [EmployeeCode]) VALUES (3, N'Charlene', N'Charlene123              ', N'Admin and Finance Manager', N'01121880000', N'', N'charlene@micromega.co.za', NULL, N'Charlene', N'Jaftha', N'CJ', 1, 1, 1816, CAST(0xA6CF038A AS SmallDateTime), N'')
INSERT [dbo].[Usr_UserDetail] ([UserID], [UserName], [Password], [Position], [TelNo], [SMSNo], [EMail], [RecSMS], [FirstName], [LastName], [Initials], [UnitID], [Enabled], [TotalLogin], [LastLoginDate], [EmployeeCode]) VALUES (4, N'sizwe', N'sizwem012                ', N'Business Development', N'0833189588', N'', N'sizwe.moosa@sebata.co.za', NULL, N'Sizwe', N'Moosa', N'S M', 1, 1, 245, CAST(0xA5F601CA AS SmallDateTime), N'0094')
SET IDENTITY_INSERT [dbo].[Usr_UserDetail] OFF
INSERT [dbo].[Usr_UserGroup] ([UserID], [GroupID]) VALUES (1, 0)
INSERT [dbo].[Usr_UserGroup] ([UserID], [GroupID]) VALUES (2, 4)
INSERT [dbo].[Usr_UserGroup] ([UserID], [GroupID]) VALUES (3, 7)
INSERT [dbo].[Usr_UserGroup] ([UserID], [GroupID]) VALUES (4, 4)





/****** Object:  Index [_dta_index_TT_Approvals_13_663009443__K5_K3_K2_K7]    Script Date: 2016/12/01 04:01:56 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_TT_Approvals_13_663009443__K5_K3_K2_K7] ON [dbo].[TT_Approvals]
(
	[ApprovedItemID] ASC,
	[ApproverID] ASC,
	[ApprovalTypeID] ASC,
	[Approved] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_TT_Timesheets_13_938486422__K2_K7_K1_K4_K3_8]    Script Date: 2016/12/01 04:01:56 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_TT_Timesheets_13_938486422__K2_K7_K1_K4_K3_8] ON [dbo].[TT_Timesheets]
(
	[UserID] ASC,
	[Submitted] ASC,
	[TimesheetID] ASC,
	[TimesheetDate] ASC,
	[TaskID] ASC
)
INCLUDE ( 	[ApprovalStage]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TT_FinancialDocumentType] ADD  CONSTRAINT [DF_TT_FinancialDocumentType_ApprovalRequired]  DEFAULT ((0)) FOR [ApprovalRequired]
GO
ALTER TABLE [dbo].[TT_ProjectResources] ADD  CONSTRAINT [DF_TT_ProjectResources_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[TT_Approvals]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Approvals_TT_ApprovalTypes] FOREIGN KEY([ApprovalTypeID])
REFERENCES [dbo].[TT_ApprovalTypes] ([ApprovalTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Approvals] CHECK CONSTRAINT [FK_TT_Approvals_TT_ApprovalTypes]
GO
ALTER TABLE [dbo].[TT_Approvals]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Approvals_Usr_UserDetail] FOREIGN KEY([ApproverID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Approvals] CHECK CONSTRAINT [FK_TT_Approvals_Usr_UserDetail]
GO
ALTER TABLE [dbo].[TT_Clients]  WITH NOCHECK ADD  CONSTRAINT [FK_Clients_Countries] FOREIGN KEY([CountryID])
REFERENCES [dbo].[TT_Countries] ([CountryID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Clients] CHECK CONSTRAINT [FK_Clients_Countries]
GO
ALTER TABLE [dbo].[TT_CostCentres]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_CostCentres_TT_Countries] FOREIGN KEY([CountryID])
REFERENCES [dbo].[TT_Countries] ([CountryID])
GO
ALTER TABLE [dbo].[TT_CostCentres] CHECK CONSTRAINT [FK_TT_CostCentres_TT_Countries]
GO
ALTER TABLE [dbo].[TT_CostCentres]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_CostCentres_Usr_UserDetail] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
GO
ALTER TABLE [dbo].[TT_CostCentres] CHECK CONSTRAINT [FK_TT_CostCentres_Usr_UserDetail]
GO
ALTER TABLE [dbo].[TT_Countries]  WITH NOCHECK ADD  CONSTRAINT [FK_Countries_Currencies] FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[TT_Currencies] ([CurrencyID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Countries] CHECK CONSTRAINT [FK_Countries_Currencies]
GO
ALTER TABLE [dbo].[TT_DeletedFinancialDocumentOrderItems]  WITH CHECK ADD  CONSTRAINT [FK_TT_DeletedFinancialDocumentOrderItems_TT_DeletedFinancialDocuments] FOREIGN KEY([FinancialDocumentID])
REFERENCES [dbo].[TT_DeletedFinancialDocuments] ([FinancialDocID])
GO
ALTER TABLE [dbo].[TT_DeletedFinancialDocumentOrderItems] CHECK CONSTRAINT [FK_TT_DeletedFinancialDocumentOrderItems_TT_DeletedFinancialDocuments]
GO
ALTER TABLE [dbo].[TT_DeletedFinancialDocumentOrderItems]  WITH CHECK ADD  CONSTRAINT [FK_TT_DeletedFinancialDocumentOrderItems_TT_OrderItems] FOREIGN KEY([OrderItemID])
REFERENCES [dbo].[TT_OrderItems] ([OrderItemID])
GO
ALTER TABLE [dbo].[TT_DeletedFinancialDocumentOrderItems] CHECK CONSTRAINT [FK_TT_DeletedFinancialDocumentOrderItems_TT_OrderItems]
GO
ALTER TABLE [dbo].[TT_DeletedFinancialDocuments]  WITH CHECK ADD  CONSTRAINT [FK_TT_DeletedFinancialDocuments_TT_FinancialDocumentType] FOREIGN KEY([FinancialDocTypeID])
REFERENCES [dbo].[TT_FinancialDocumentType] ([FinancialDocTypeID])
GO
ALTER TABLE [dbo].[TT_DeletedFinancialDocuments] CHECK CONSTRAINT [FK_TT_DeletedFinancialDocuments_TT_FinancialDocumentType]
GO
ALTER TABLE [dbo].[TT_DeletedFinancialDocuments]  WITH CHECK ADD  CONSTRAINT [FK_TT_DeletedFinancialDocuments_TT_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[TT_Orders] ([OrderID])
GO
ALTER TABLE [dbo].[TT_DeletedFinancialDocuments] CHECK CONSTRAINT [FK_TT_DeletedFinancialDocuments_TT_Orders]
GO
ALTER TABLE [dbo].[TT_Expenses]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Expenses_TT_ExpenseTypes] FOREIGN KEY([ExpenseTypeID])
REFERENCES [dbo].[TT_ExpenseTypes] ([ExpenseTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Expenses] CHECK CONSTRAINT [FK_TT_Expenses_TT_ExpenseTypes]
GO
ALTER TABLE [dbo].[TT_Expenses]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Expenses_TT_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[TT_Projects] ([ProjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Expenses] CHECK CONSTRAINT [FK_TT_Expenses_TT_Projects]
GO
ALTER TABLE [dbo].[TT_Expenses]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Expenses_Usr_UserDetail] FOREIGN KEY([UserID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Expenses] CHECK CONSTRAINT [FK_TT_Expenses_Usr_UserDetail]
GO
ALTER TABLE [dbo].[TT_FinancialDocTypeUsers]  WITH CHECK ADD  CONSTRAINT [FK_TT_FinancialDocTypeUsers_TT_FinancialDocumentType] FOREIGN KEY([FinancialDocTypeID])
REFERENCES [dbo].[TT_FinancialDocumentType] ([FinancialDocTypeID])
GO
ALTER TABLE [dbo].[TT_FinancialDocTypeUsers] CHECK CONSTRAINT [FK_TT_FinancialDocTypeUsers_TT_FinancialDocumentType]
GO
ALTER TABLE [dbo].[TT_FinancialDocumentOrderItems]  WITH CHECK ADD  CONSTRAINT [FK_TT_FinancialDocumentOrderItems_TT_FinancialDocuments] FOREIGN KEY([FinancialDocumentID])
REFERENCES [dbo].[TT_FinancialDocuments] ([FinancialDocID])
GO
ALTER TABLE [dbo].[TT_FinancialDocumentOrderItems] CHECK CONSTRAINT [FK_TT_FinancialDocumentOrderItems_TT_FinancialDocuments]
GO
ALTER TABLE [dbo].[TT_FinancialDocumentOrderItems]  WITH CHECK ADD  CONSTRAINT [FK_TT_FinancialDocumentOrderItems_TT_OrderItems] FOREIGN KEY([OrderItemID])
REFERENCES [dbo].[TT_OrderItems] ([OrderItemID])
GO
ALTER TABLE [dbo].[TT_FinancialDocumentOrderItems] CHECK CONSTRAINT [FK_TT_FinancialDocumentOrderItems_TT_OrderItems]
GO
ALTER TABLE [dbo].[TT_FinancialDocuments]  WITH CHECK ADD  CONSTRAINT [FK_TT_FinancialDocuments_TT_FinancialDocumentType] FOREIGN KEY([FinancialDocTypeID])
REFERENCES [dbo].[TT_FinancialDocumentType] ([FinancialDocTypeID])
GO
ALTER TABLE [dbo].[TT_FinancialDocuments] CHECK CONSTRAINT [FK_TT_FinancialDocuments_TT_FinancialDocumentType]
GO
ALTER TABLE [dbo].[TT_FinancialDocuments]  WITH CHECK ADD  CONSTRAINT [FK_TT_FinancialDocuments_TT_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[TT_Orders] ([OrderID])
GO
ALTER TABLE [dbo].[TT_FinancialDocuments] CHECK CONSTRAINT [FK_TT_FinancialDocuments_TT_Orders]
GO
ALTER TABLE [dbo].[TT_Orders]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Orders_TT_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[TT_Projects] ([ProjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Orders] CHECK CONSTRAINT [FK_TT_Orders_TT_Projects]
GO
ALTER TABLE [dbo].[TT_ProfileTasks]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProfileTasks_TT_ProjectTasks] FOREIGN KEY([TaskID])
REFERENCES [dbo].[TT_ProjectTasks] ([TaskID])
GO
ALTER TABLE [dbo].[TT_ProfileTasks] CHECK CONSTRAINT [FK_TT_ProfileTasks_TT_ProjectTasks]
GO
ALTER TABLE [dbo].[TT_ProfileTasks]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProfileTasks_Usr_UserDetail] FOREIGN KEY([UserID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
GO
ALTER TABLE [dbo].[TT_ProfileTasks] CHECK CONSTRAINT [FK_TT_ProfileTasks_Usr_UserDetail]
GO
ALTER TABLE [dbo].[TT_ProfileTSApproval]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProfileTSApproval_Usr_UserDetail] FOREIGN KEY([UserID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
GO
ALTER TABLE [dbo].[TT_ProfileTSApproval] CHECK CONSTRAINT [FK_TT_ProfileTSApproval_Usr_UserDetail]
GO
ALTER TABLE [dbo].[TT_ProfileUser]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProfileUser_Usr_UserDetail] FOREIGN KEY([UserID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_ProfileUser] CHECK CONSTRAINT [FK_TT_ProfileUser_Usr_UserDetail]
GO
ALTER TABLE [dbo].[TT_ProjectDocuments]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProjectDocuments_TT_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[TT_Projects] ([ProjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_ProjectDocuments] CHECK CONSTRAINT [FK_TT_ProjectDocuments_TT_Projects]
GO
ALTER TABLE [dbo].[TT_ProjectOrderItems]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProjectBudgetItems_TT_BudgetItems] FOREIGN KEY([OrderItemID])
REFERENCES [dbo].[TT_OrderItems] ([OrderItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_ProjectOrderItems] CHECK CONSTRAINT [FK_TT_ProjectBudgetItems_TT_BudgetItems]
GO
ALTER TABLE [dbo].[TT_ProjectOrderItems]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProjectOrderItems_TT_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[TT_Orders] ([OrderID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_ProjectOrderItems] CHECK CONSTRAINT [FK_TT_ProjectOrderItems_TT_Orders]
GO
ALTER TABLE [dbo].[TT_ProjectResources]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProjectResources_TT_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[TT_Projects] ([ProjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_ProjectResources] CHECK CONSTRAINT [FK_TT_ProjectResources_TT_Projects]
GO
ALTER TABLE [dbo].[TT_ProjectResources]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProjectResources_Usr_UserDetail] FOREIGN KEY([UserID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
GO
ALTER TABLE [dbo].[TT_ProjectResources] CHECK CONSTRAINT [FK_TT_ProjectResources_Usr_UserDetail]
GO
ALTER TABLE [dbo].[TT_ProjectStatus]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProjectStatus_TT_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[TT_Projects] ([ProjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_ProjectStatus] CHECK CONSTRAINT [FK_TT_ProjectStatus_TT_Projects]
GO
ALTER TABLE [dbo].[TT_ProjectStatus]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProjectStatus_TT_Status] FOREIGN KEY([StatusID])
REFERENCES [dbo].[TT_Status] ([StatusID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_ProjectStatus] CHECK CONSTRAINT [FK_TT_ProjectStatus_TT_Status]
GO
ALTER TABLE [dbo].[TT_ProjectTasks]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_ProjectTasks_TT_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[TT_Orders] ([OrderID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_ProjectTasks] CHECK CONSTRAINT [FK_TT_ProjectTasks_TT_Orders]
GO
ALTER TABLE [dbo].[TT_Rates]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Rates_TT_CostCentres] FOREIGN KEY([CostCentreID])
REFERENCES [dbo].[TT_CostCentres] ([CostCentreID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Rates] CHECK CONSTRAINT [FK_TT_Rates_TT_CostCentres]
GO
ALTER TABLE [dbo].[TT_Rates]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Rates_Usr_UserDetail] FOREIGN KEY([UserID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Rates] CHECK CONSTRAINT [FK_TT_Rates_Usr_UserDetail]
GO
ALTER TABLE [dbo].[TT_TimeOff]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_TimeOff_TT_TimeOffTypes] FOREIGN KEY([TypeID])
REFERENCES [dbo].[TT_TimeOffTypes] ([TypeID])
GO
ALTER TABLE [dbo].[TT_TimeOff] CHECK CONSTRAINT [FK_TT_TimeOff_TT_TimeOffTypes]
GO
ALTER TABLE [dbo].[TT_Timesheets]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Timesheets_TT_ProjectTasks] FOREIGN KEY([TaskID])
REFERENCES [dbo].[TT_ProjectTasks] ([TaskID])
GO
ALTER TABLE [dbo].[TT_Timesheets] CHECK CONSTRAINT [FK_TT_Timesheets_TT_ProjectTasks]
GO
ALTER TABLE [dbo].[TT_Timesheets]  WITH NOCHECK ADD  CONSTRAINT [FK_TT_Timesheets_Usr_UserDetail] FOREIGN KEY([UserID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TT_Timesheets] CHECK CONSTRAINT [FK_TT_Timesheets_Usr_UserDetail]
GO
ALTER TABLE [dbo].[Usr_GroupPermission]  WITH NOCHECK ADD  CONSTRAINT [FK_GroupPermission_RoleName] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Usr_RoleName] ([RoleID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Usr_GroupPermission] CHECK CONSTRAINT [FK_GroupPermission_RoleName]
GO
ALTER TABLE [dbo].[Usr_GroupPermission]  WITH NOCHECK ADD  CONSTRAINT [FK_Usr_GroupPermission_Usr_GroupName] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Usr_GroupName] ([GroupID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Usr_GroupPermission] CHECK CONSTRAINT [FK_Usr_GroupPermission_Usr_GroupName]
GO
ALTER TABLE [dbo].[Usr_UserDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_UserDetail_BusinessUnit] FOREIGN KEY([UnitID])
REFERENCES [dbo].[Usr_BusinessUnit] ([UnitID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Usr_UserDetail] CHECK CONSTRAINT [FK_UserDetail_BusinessUnit]
GO
ALTER TABLE [dbo].[Usr_UserGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_UserGroup_UserDetail] FOREIGN KEY([UserID])
REFERENCES [dbo].[Usr_UserDetail] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Usr_UserGroup] CHECK CONSTRAINT [FK_UserGroup_UserDetail]
GO
ALTER TABLE [dbo].[Usr_UserGroup]  WITH CHECK ADD  CONSTRAINT [FK_Usr_UserGroup_Usr_GroupName] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Usr_GroupName] ([GroupID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Usr_UserGroup] CHECK CONSTRAINT [FK_Usr_UserGroup_Usr_GroupName]
GO

