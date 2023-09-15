/**********************************************************************
Created by:	SD
Created on:	09/09/2005
Does:		Inserts the Change TeamLeader Role (ID = 61) into the Timetrax
		database and adds the role to the following groups:
		- Super User
		- Developer
		- Admin
		- Admin Manager
**********************************************************************/
Declare @RoleID int
Declare @GroupID int

Select @RoleID = 61



--Check if there is no Change TeamLeader Role
IF	(Select 	Count(*) 
	 From 	Usr_RoleName
	 Where	RoleID = @RoleID) = 0 
BEGIN

	Set Identity_Insert Usr_RoleName On

	--Insert the Change TeamLeader Role	
	Insert Into Usr_RoleName(RoleID, RoleName, Enabled)
	Values (@RoleID, 'Change TeamLeader', 1)

	Set Identity_Insert Usr_RoleName Off

END

--Check if there is no Change TeamLeader Role for Super Users
IF	(Select Count(*) 
	 From 	Usr_GroupPermission a
	 Inner Join Usr_GroupName b on a.GroupID = b.GroupID
	 Where	Upper(b.Descript) = 'SUPER USER'
	 And	a.RoleID = @RoleID) = 0 
BEGIN
	--Retrive the Super User GroupID 
	Select @GroupID = GroupID 
	From   Usr_GroupName
 	Where  Upper(Descript) = 'SUPER USER'
	

	--Add the Project Change TeamLeader Role to the Super Users Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END

--Check if there is no Change TeamLeader Role for Developers
IF	(Select Count(*) 
	 From 	Usr_GroupPermission a
	 Inner Join Usr_GroupName b on a.GroupID = b.GroupID
	 Where	Upper(b.Descript) = 'DEVELOPER'
	 And	a.RoleID = @RoleID) = 0 
BEGIN
	--Retrive the Developer GroupID 
	Select @GroupID = GroupID 
	From   Usr_GroupName
 	Where  Upper(Descript) = 'DEVELOPER'
	

	--Add the Change TeamLeader Role to the Developer Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END

--Check if there is no Change TeamLeader Role for Admin 
IF	(Select Count(*) 
	 From 	Usr_GroupPermission a
	 Inner Join Usr_GroupName b on a.GroupID = b.GroupID
	 Where	Upper(b.Descript) = 'ADMIN'
	 And	a.RoleID = @RoleID) = 0 
BEGIN
	--Retrive the Admin GroupID 
	Select @GroupID = GroupID 
	From   Usr_GroupName
 	Where  Upper(Descript) = 'ADMIN'
	

	--Add the Change TeamLeader Role to the Admin Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END

--Check if there is no Change TeamLeader Role for Admin Manager
IF	(Select Count(*) 
	 From 	Usr_GroupPermission a
	 Inner Join Usr_GroupName b on a.GroupID = b.GroupID
	 Where	Upper(b.Descript) = 'ADMIN MANAGER'
	 And	a.RoleID = @RoleID) = 0 
BEGIN
	--Retrive the Admin Manager GroupID 
	Select @GroupID = GroupID 
	From   Usr_GroupName
 	Where  Upper(Descript) = 'ADMIN MANAGER'
	

	--Add the Change TeamLeader Role to the Admin Manager Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END




