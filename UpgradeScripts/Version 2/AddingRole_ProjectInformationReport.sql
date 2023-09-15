/**********************************************************************
Created by:	SB
Created on:	05/09/2005
Does:		Inserts the Project Information Role (ID = 60) into the Timetrax
		database and adds the role to the following groups:
		- Super User
		- Developer
		- Teamleader
		- Supervisor
		- Director
		- Admin
		- Admin Manager
**********************************************************************/
Declare @RoleID int
Declare @GroupID int

Select @RoleID = 60

--Check if there is no Project Information Report Role
IF	(Select 	Count(*) 
	 From 	Usr_RoleName
	 Where	RoleID = @RoleID) = 0 
BEGIN

	Set Identity_Insert Usr_RoleName On

	--Insert the Project Information Report Role	
	Insert Into Usr_RoleName(RoleID, RoleName, Enabled)
	Values (@RoleID, 'Project Information Report', 1)

	Set Identity_Insert Usr_RoleName Off

END

--Check if there is no Project Information Role for Super Users
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
	

	--Add the Project Information Report Role to the Super Users Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END

--Check if there is no Project Information Role for Developers
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
	

	--Add the Project Information Report Role to the Developer Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END

--Check if there is no Project Information Role for Developers
IF	(Select Count(*) 
	 From 	Usr_GroupPermission a
	 Inner Join Usr_GroupName b on a.GroupID = b.GroupID
	 Where	Upper(b.Descript) = 'TEAM LEADER'
	 And	a.RoleID = @RoleID) = 0 
BEGIN
	--Retrive the Team Leader GroupID 
	Select @GroupID = GroupID 
	From   Usr_GroupName
 	Where  Upper(Descript) = 'TEAM LEADER'
	

	--Add the Project Information Report Role to the Team Leader Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END

--Check if there is no Project Information Role for Supervisor
IF	(Select Count(*) 
	 From 	Usr_GroupPermission a
	 Inner Join Usr_GroupName b on a.GroupID = b.GroupID
	 Where	Upper(b.Descript) = 'SUPERVISOR'
	 And	a.RoleID = @RoleID) = 0 
BEGIN
	--Retrive the Supervisor GroupID 
	Select @GroupID = GroupID 
	From   Usr_GroupName
 	Where  Upper(Descript) = 'SUPERVISOR'
	

	--Add the Project Information Report Role to the Supervisor Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END

--Check if there is no Project Information Role for Director
IF	(Select Count(*) 
	 From 	Usr_GroupPermission a
	 Inner Join Usr_GroupName b on a.GroupID = b.GroupID
	 Where	Upper(b.Descript) = 'DIRECTOR'
	 And	a.RoleID = @RoleID) = 0 
BEGIN
	--Retrive the Director GroupID 
	Select @GroupID = GroupID 
	From   Usr_GroupName
 	Where  Upper(Descript) = 'DIRECTOR'
	

	--Add the Project Information Report Role to the Director Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END

--Check if there is no Project Information Role for Admin 
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
	

	--Add the Project Information Report Role to the Admin Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END

--Check if there is no Project Information Role for Admin Manager
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
	

	--Add the Project Information Report Role to the Admin Manager Group
	Insert Into Usr_GroupPermission(GroupID, RoleID)
	Values (@GroupID, @RoleID)

END




