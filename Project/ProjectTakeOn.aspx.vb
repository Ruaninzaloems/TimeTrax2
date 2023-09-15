Public Class ProjectTakeOn
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

	End Sub
    Protected WithEvents ddlClient As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlContact As System.Web.UI.WebControls.DropDownList
    Protected WithEvents rfvClient As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents rfvContact As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ddlAdmin As System.Web.UI.WebControls.DropDownList
    Protected WithEvents rfvAdmin As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtProjFullName As Intermap.Controls.IMTextBox
    Protected WithEvents txtProjName As Intermap.Controls.IMTextBox
    Protected WithEvents txtProjCode As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvProjCode As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ddlCostCentre As System.Web.UI.WebControls.DropDownList
    Protected WithEvents rfvCostCentre As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents resourcePlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents Approver2Role As System.Web.UI.WebControls.Label
    Protected WithEvents Img1 As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents resourceLoadCount As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents ddlApprover2 As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtApprover2 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Approver1Role As System.Web.UI.WebControls.Label
    Protected WithEvents ddlApprover1 As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtApprover1 As System.Web.UI.WebControls.TextBox
    Protected WithEvents ddlTeamLeader As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtTeamLeader As System.Web.UI.WebControls.TextBox
    Protected WithEvents ddlResource_ As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtResource_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents imgDeleteresource_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents txtCurrency As System.Web.UI.WebControls.TextBox
    Protected WithEvents Img2 As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents Stage2row As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents txtProjComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSave As System.Web.UI.WebControls.Button
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents Appovals As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents txtTSApprover1 As System.Web.UI.WebControls.TextBox
    Protected WithEvents TSStage1row As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents hidProjID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents chkEnabled_ As System.Web.UI.WebControls.CheckBox
    Protected WithEvents imgShowClient_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents imgShowContact_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents imgShowAdminContact_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents txtStartDate As Intermap.Controls.IMTextBox
    Protected WithEvents ddlManager As System.Web.UI.WebControls.DropDownList
    Protected WithEvents trManager As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents txtManager As System.Web.UI.WebControls.TextBox
Protected WithEvents Dropdownlist1 As System.Web.UI.WebControls.DropDownList
Protected WithEvents Requiredfieldvalidator1 As System.Web.UI.WebControls.RequiredFieldValidator
Protected WithEvents Dropdownlist2 As System.Web.UI.WebControls.DropDownList
Protected WithEvents Requiredfieldvalidator2 As System.Web.UI.WebControls.RequiredFieldValidator
Protected WithEvents Dropdownlist3 As System.Web.UI.WebControls.DropDownList
Protected WithEvents Requiredfieldvalidator3 As System.Web.UI.WebControls.RequiredFieldValidator
Protected WithEvents Imtextbox1 As Intermap.Controls.IMTextBox
Protected WithEvents Imtextbox2 As Intermap.Controls.IMTextBox
Protected WithEvents Textbox1 As System.Web.UI.WebControls.TextBox
Protected WithEvents Dropdownlist4 As System.Web.UI.WebControls.DropDownList
Protected WithEvents Requiredfieldvalidator4 As System.Web.UI.WebControls.RequiredFieldValidator
Protected WithEvents Textbox2 As System.Web.UI.WebControls.TextBox
Protected WithEvents Imtextbox3 As Intermap.Controls.IMTextBox
Protected WithEvents Placeholder1 As System.Web.UI.WebControls.PlaceHolder
Protected WithEvents Label1 As System.Web.UI.WebControls.Label
Protected WithEvents Dropdownlist5 As System.Web.UI.WebControls.DropDownList
Protected WithEvents Textbox3 As System.Web.UI.WebControls.TextBox
Protected WithEvents Label2 As System.Web.UI.WebControls.Label
Protected WithEvents Dropdownlist6 As System.Web.UI.WebControls.DropDownList
Protected WithEvents Textbox4 As System.Web.UI.WebControls.TextBox
Protected WithEvents Dropdownlist7 As System.Web.UI.WebControls.DropDownList
Protected WithEvents Textbox5 As System.Web.UI.WebControls.TextBox
Protected WithEvents Dropdownlist8 As System.Web.UI.WebControls.DropDownList
Protected WithEvents Textbox6 As System.Web.UI.WebControls.TextBox
Protected WithEvents Dropdownlist9 As System.Web.UI.WebControls.DropDownList
Protected WithEvents Textbox7 As System.Web.UI.WebControls.TextBox
Protected WithEvents Textbox8 As System.Web.UI.WebControls.TextBox
Protected WithEvents Button1 As System.Web.UI.WebControls.Button
Protected WithEvents Button2 As System.Web.UI.WebControls.Button

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " STANDARD DECLARES "
    Dim DBConn = ConfigurationSettings.AppSettings("DBConn")
    Dim sqlConn As SqlConnection
    Dim DR As SqlDataReader
    Dim arParms() As SqlParameter = New SqlParameter(0) {}
    Dim en As New System.Globalization.CultureInfo("en-Za")

    ' Required for Errorhandling
    Protected WithEvents ucHeader As TimeTrax.header
    Dim strStatus As String
    Dim strErr As String
    Dim strMess As String

#End Region

#Region " PAGE DECLARES "
    Dim ucOrders As New TimeTrax.Orders
    Dim Approver1RoleID As Integer
    Dim Approver2RoleID As Integer
    Dim TSApprover1RoleID As Integer
    Dim TSApprover2RoleID As Integer
    Dim count As Int16
    Dim i As Int16
    Dim strValue As String
    Dim hidBoxorder As HtmlInputHidden
    Dim hidBoxtask As HtmlInputHidden
    Dim hidBoxresource As HtmlInputHidden
    Dim ItemNo, ItemID As String
    Dim a, NoRows As Integer
    Dim arrData As Array
    Dim ApproverID As Integer
    Dim ucProjectDocuments As TimeTrax.ProjectDocuments
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "2"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "TakeOn"
            Session("Page") = "TakeOn"
            Session("PageTitle") = Session("AppName") & " - Project TakeOn"
            ' hidProjID.Value = " "
            ViewState("ProjectID") = Request.QueryString("ProjID")
            hidProjID.Value = Request.QueryString("ProjID")
            LoadPageData()
        End If

    End Sub

    Private Sub LoadPageData()
        ' hide the appropriate rows
        Stage2row.Visible = False


        LoadSystemData()
        ucOrders.TaskOrderItem = ViewState("TaskOrderItem")
        ucOrders.blnReadOnly = False
        LoadDropLists()
        resourceLoadCount.Value = 0
        If ViewState("ProjectID") <> 0 Then
            ' Load Existing Project Take On Data
            LoadProjectData()
        Else
            ucOrders.OrderID = 0
            ucProjectDocuments.ProjectID = 0
        End If

    End Sub

    Private Sub LoadSystemData()
        ViewState("TaskOrderItem") = 1
        DR = DAL.LoadSystemData() 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectSystem")
        If DR.Read() Then
            ' Number of approval cycles for Project Take on
            If IsDBNull(DR.Item("PTOApprovals")) Then
                ViewState("PTOApprovals") = 1
            Else
                ViewState("PTOApprovals") = DR.Item("PTOApprovals")
            End If
            ' Number of approval cycles for Timesheets and Expenses
            If IsDBNull(DR.Item("TSApprovals")) Then
                ViewState("TSApprovals") = 1
            Else
                ViewState("TSApprovals") = DR.Item("TSApprovals")
            End If
            ' Project Budget Item (Order Item) to which Tasks total budget may not exceed
            If Not IsDBNull(DR.Item("TaskOrderItem")) Then
                ViewState("TaskOrderItem") = DR.Item("TaskOrderItem")
            End If
        End If
        DR.Close()

        ' Get The TeamLeader RoleID as TeamLeader is a fixed Resource for Projects
        ' Also used for Determining Approval Roles Etc
        DR = DAL.GetTeamLeaderRoleID() 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_GetTeamLeaderRoleID")
        If DR.Read() Then
            ' Number of approval cycles for Project Take on
            If Not IsDBNull(DR.Item("RoleID")) Then
                ViewState("TeamLeaderRoleID") = DR.Item("RoleID")
            Else
                ViewState("TeamLeaderRoleID") = 0
            End If
        End If
        DR.Close()

    End Sub

    Private Sub LoadDropLists()
        ' Load the Clients Droplist
        ddlClient.DataSource = DAL.LoadClients(0)
        ddlClient.DataBind()
        ddlClient.Items.Insert(0, New ListItem("--Add New Client--", "0"))
        ddlClient.Items.Insert(0, New ListItem("--Select a Client--", "0"))

        ' Load the Contacts Droplist
        ddlContact.DataSource = DAL.GetContacts(0)
        ddlContact.DataBind()
        ddlContact.Items.Insert(0, New ListItem("--Add New Contact--", "0"))
        ddlContact.Items.Insert(0, New ListItem("--Select a Contact--", "0"))

        ' Load the Admin Contacts Droplist
        ddlAdmin.DataSource = DAL.GetContacts(0)
        ddlAdmin.DataBind()
        ddlAdmin.Items.Insert(0, New ListItem("--Add New Contact--", "0"))
        ddlAdmin.Items.Insert(0, New ListItem("--Select a Contact--", "0"))

        ' Load the Cost Centre Droplist
        ddlCostCentre.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCostCentre_Rate")
        ddlCostCentre.DataBind()
        ddlCostCentre.Items.Insert(0, New ListItem("--Select a Cost Centre--", "0# "))

        LoadApprovers()

        ' Load the TeamLeader Droplist
        ddlTeamLeader.DataSource = DAL.LoadTimesheetApprovers(7) 'RoleID = 7 = 'Timesheet Approval Level 1 (Team Leader)'
        ddlTeamLeader.DataBind()
        ddlTeamLeader.Items.Insert(0, New ListItem("--Select a Team Leader--", "0"))

        ' Load the Resources Droplist
        ddlResource_.DataSource = DAL.LoadResources()
        ddlResource_.DataBind()
        ddlResource_.Items.Insert(0, New ListItem("--Select a Team Member--", "0"))

    End Sub

    Private Sub LoadApprovers()

        ' First Load the Project Take on Approvers
        Dim arParm2() As SqlParameter = New SqlParameter(0) {}
        For count = 1 To ViewState("PTOApprovals")
            ' Get the relevant Approver role from the system
            arParm2(0) = New SqlParameter("@RoleID", count)
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectPTOApprover" & count & "Role")
            If DR.Read() Then
                Select Case count
                    Case 1
                        ' 1 Stage PTO Approvals
                        ViewState("Approver1RoleID") = DR.Item("RoleID")
                        Approver1Role.Text = DR.Item("RoleName")
                    Case 2
                        ' 2 Stage PTO Approvals
                        ViewState("Approver2RoleID") = DR.Item("RoleID")
                        Approver2Role.Text = DR.Item("RoleName")
                        Stage2row.Visible = True
                End Select
            End If
        Next
        DR.Close()

        arParms(0) = New SqlParameter("@ApproverGroup", ViewState("Approver1RoleID"))
        ' Load the Approver1 Droplist
        ddlApprover1.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectApprover", arParms)
        ddlApprover1.DataBind()
        ddlApprover1.Items.Insert(0, New ListItem("--Select an Approver--", "0"))

        If Stage2row.Visible = True Then
            ' Only load droplists if necesary
            arParms(0) = New SqlParameter("@ApproverRole", ViewState("Approver2RoleID"))
            ' Load the First Approver(2) Droplist
            ddlApprover2.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectApprover", arParms)
            ddlApprover2.DataBind()
            ddlApprover2.Items.Insert(0, New ListItem("--Select an Approver--", "0"))
        End If

        If ViewState("TSApprovals") = "2" Then
            ddlManager.DataSource = DAL.LoadTimesheetApprovers(69) 'RoleID 69 -  Timesheet Approval Level 2 (Manager)
            ddlManager.DataBind()
            ddlManager.Items.Insert(0, New ListItem("--Select a Manager--", "0"))
        End If

    End Sub

    Private Sub LoadProjectData()
        'Dim arParms() As SqlParameter = New SqlParameter(0) {}
        'arParms(0) = New SqlParameter("@ProjID", ViewState("ProjectID"))
        DR = DAL.LoadProjectDetails(ViewState("ProjectID")) 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectPTODetails", arParms)

        ' Get The Project Details
        If DR.Read() Then
            'SB: 02/09/2005 - Don't overwrite the top value - find it in the list and set it
            'ddlClient.SelectedItem.Value = DR.Item("ClientID")
            'ddlClient.SelectedItem.Text = DR.Item("ClientName")
            'ddlContact.SelectedItem.Value = DR.Item("ContactID")
            'ddlContact.SelectedItem.Text = DR.Item("ContactName")
            ddlClient.SelectedValue = DR.Item("ClientID")
            ddlContact.SelectedValue = DR.Item("ContactID")
            If IsDBNull(DR.Item("AdminContactName")) Then
                ddlAdmin.SelectedItem.Value = 0
                ddlAdmin.SelectedItem.Text = "--Select a Contact--"
            Else
                'ddlAdmin.SelectedItem.Value = DR.Item("AdminContactID")
                'ddlAdmin.SelectedItem.Text = DR.Item("AdminContactName")
                ddlAdmin.SelectedValue = DR.Item("AdminContactID")
            End If
            txtProjFullName.Text = DR.Item("FullName")
            txtProjName.Text = DR.Item("ProjectName")
            txtProjCode.Text = DR.Item("ProjectCode")
            ddlCostCentre.SelectedItem.Value = DR.Item("CostCentreID")
            ddlCostCentre.SelectedItem.Text = DR.Item("CostCentreName")
            txtCurrency.Text = DR.Item("Currency")
            txtStartDate.Text = DR.Item("txtStart")
            'txtEndDate.Text = DR.Item("txtEnd")
            If Not IsDBNull(DR.Item("Comments")) Then
                txtProjComment.Text = DR.Item("Comments")
            End If
        End If

        ' Get The Project Resources
        DR.NextResult()
        i = 0
        While DR.Read()
            If IsDBNull(DR.Item("FirstApprover")) And IsDBNull(DR.Item("LastApprover")) And IsDBNull(DR.Item("TSLastApprover")) And IsDBNull(DR.Item("TeamLeader")) Then
                ' Team member so add to dynamic add
                i = i + 1
                hidBoxresource = New HtmlInputHidden
                hidBoxresource.ID = "hidBoxresource_" & i
                'SD: 19/10/2005 - Change dymanic adds from , to #
                strValue = DR.Item("ResourceID")
                strValue &= "#" & DR.Item("UserID")
                strValue &= "#" & DR.Item("UserName")
                strValue &= "#" & DR.Item("Rate")
                strValue &= "#" & DR.Item("Enabled")  'SD: 05/09/2005 - Return the enabled field
                hidBoxresource.Value = strValue
                resourcePlace.Controls.Add(hidBoxresource)
            Else
                If Not IsDBNull(DR.Item("TeamLeader")) Then
                    ' TeamLeader
                    ViewState("TeamLeaderResourceID") = DR.Item("ResourceID")
                    ddlTeamLeader.SelectedItem.Value = DR.Item("UserID")
                    ddlTeamLeader.SelectedItem.Text = DR.Item("UserName")
                    txtTeamLeader.Text = DR.Item("Rate")
                Else
                    If Not IsDBNull(DR.Item("LastApprover")) Then
                        ' Final Approver
                        ViewState("Approver1ResourceID") = DR.Item("ResourceID")
                        ddlApprover1.SelectedItem.Value = DR.Item("UserID")
                        ddlApprover1.SelectedItem.Text = DR.Item("UserName")
                        txtApprover1.Text = DR.Item("Rate")
                    Else
                        If Not IsDBNull(DR.Item("FirstApprover")) Then
                            If ViewState("PTOApprovals") > 1 Then
                                ' First Approver (May not exist depends on System.PTOApprovals value)
                                ViewState("Approver2ResourceID") = DR.Item("ResourceID")
                                ddlApprover2.SelectedItem.Value = DR.Item("UserID")
                                ddlApprover2.SelectedItem.Text = DR.Item("UserName")
                                txtApprover2.Text = DR.Item("Rate")
                            End If
                        Else
                            If Not IsDBNull(DR.Item("TSLastApprover")) Then
                                ' Final Timesheet Expenses Approver
                                If ViewState("TSApprovals") > 1 Then
                                    'If there is more than one level of TS Approvals show the manager row
                                    ViewState("TSApprover2ResourceID") = DR.Item("ResourceID")
                                    ddlManager.SelectedItem.Value = DR.Item("UserID")
                                    ddlManager.SelectedItem.Text = DR.Item("UserName")
                                    txtManager.Text = DR.Item("Rate")
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End While
        resourceLoadCount.Value = i

        DR.Close()

        LoadProjectOrder()

        ucProjectDocuments.ProjectID = ViewState("ProjectID")

    End Sub

    Private Sub LoadProjectOrder()
        'Dim arParms() As SqlParameter = New SqlParameter(0) {}
        'arParms(0) = New SqlParameter("@ProjID", ViewState("ProjectID"))
        DR = DAL.LoadCurrentProjectOrder(ViewState("ProjectID"), 0) 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectProjectCurrentOrder", arParms)
        ' Get The Project Orders
        If DR.Read Then
            ' Needed for Orders User Control
            ViewState("OrderID") = DR.Item("OrderID")
        End If

        DR.Close()

        ucOrders.OrderID = ViewState("OrderID")
    End Sub

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ' save changes
        SavePageData()
        ' Set Project Status to 2 (PTO Awaiting approval)
        Common.ChangeProjectStatus(ViewState("ProjectID"), 2)
        ' Send email to Approver that Project is awaiting approval
        If ViewState("PTOApprovals") > 1 Then
            ' Send email to first approver
            ApproverID = Request.Form("ddlApprover2")
        Else
            ' Send email to final approver
            ApproverID = Request.Form("ddlApprover1")
        End If
        SendEmail(Common.GetEmailForUser(ApproverID))
        ' and go to start page
        Response.Redirect(Request.ApplicationPath & "\default.aspx")
    End Sub
    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        SavePageData()
        Response.Redirect(Request.ApplicationPath & "\default.aspx")
    End Sub

    Private Sub SavePageData()
        ' Update Projects Table
        ProcessProjectData()
        ' Update Budget (Order & ProjectOrderItems)
        ViewState("OrderID") = ucOrders.ProcessProjectOrders(ViewState("ProjectID"), ViewState("OrderID"), context)
        ' Update ProjectTasks Table
        ucOrders.ProcessProjectTasks(ViewState("OrderID"), context)
        ' Update ProjectResources Table
        ProcessProjectResources()

    End Sub

    Private Sub ProcessProjectData()
        If ViewState("ProjectID") <> 0 Then
            UpdateProject()
        Else
            InsertProject()
        End If
        ' Set Project Status to 1 (Project Take On)
        ' and Delete any previous Approvals if there are any as this PTO has been changed
        ' (Delete Approvals is done in a trigger on the TT_ProjectStatus File)
        Common.ChangeProjectStatus(ViewState("ProjectID"), 1)
    End Sub

    Private Sub InsertProject()
        'Autogenerate ProjectCode

        Dim ClientID As Integer = Request.Form("ddlClient")

        txtProjCode.Text = DAL.GenerateProjectCode(ClientID)
        ' Add Project Details to DB and get ProjID
        Dim arParms() As SqlParameter = New SqlParameter(11) {}
        arParms(0) = New SqlParameter("@Code", txtProjCode.Text)
        arParms(1) = New SqlParameter("@FullName", txtProjFullName.Text)
        arParms(2) = New SqlParameter("@Name", txtProjName.Text)
        arParms(3) = New SqlParameter("@ClientID", ClientID)
        arParms(4) = New SqlParameter("@ContactID", Request.Form("ddlContact"))
        arParms(5) = New SqlParameter("@AdminID", Request.Form("ddlAdmin"))
        arParms(6) = New SqlParameter("@StartDate", System.DateTime.ParseExact(Request.Form("txtStartDate"), "dd/MM/yyyy", en))
        arParms(7) = New SqlParameter("@EndDate", System.DateTime.ParseExact(Request.Form("ucOrders:txtEndDate"), "dd/MM/yyyy", en))
        Dim CostCentreID = Request.Form("ddlCostCentre").Split("#")
        arParms(8) = New SqlParameter("@CostCentreID", CInt(CostCentreID(0)))
        arParms(9) = New SqlParameter("@Comments", IIf(txtProjComment.Text <> "", txtProjComment.Text, DBNull.Value))
        arParms(10) = New SqlParameter("@ProjID", SqlDbType.Int) ' Output
        arParms(10).Direction = ParameterDirection.Output
        arParms(11) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
        arParms(11).Direction = ParameterDirection.Output

        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_InsertProject", arParms)
        strErr = arParms(11).Value
        Select Case strErr
            Case 0 ' No Errors
                ViewState("ProjectID") = arParms(10).Value
        End Select

    End Sub
    Private Sub UpdateProject()
        ' Update Project Details to DB
        Dim arParms() As SqlParameter = New SqlParameter(11) {}

        If DAL.ValidateProjectCode(ddlClient.SelectedValue, txtProjCode.Text) = False Then
            '-- Client has changed so need to regenerate ProjectCode
            txtProjCode.Text = DAL.GenerateProjectCode(ddlClient.SelectedValue)
        End If

        arParms(0) = New SqlParameter("@ProjID", ViewState("ProjectID"))
        arParms(1) = New SqlParameter("@Code", txtProjCode.Text)
        arParms(2) = New SqlParameter("@FullName", txtProjFullName.Text)
        arParms(3) = New SqlParameter("@Name", txtProjName.Text)
        arParms(4) = New SqlParameter("@ClientID", ddlClient.SelectedValue)
        arParms(5) = New SqlParameter("@ContactID", ddlContact.SelectedValue)
        arParms(6) = New SqlParameter("@AdminID", ddlAdmin.SelectedValue)
        arParms(7) = New SqlParameter("@StartDate", System.DateTime.ParseExact(Request.Form("txtStartDate"), "dd/MM/yyyy", en))
        arParms(8) = New SqlParameter("@EndDate", System.DateTime.ParseExact(Request.Form("ucOrders:txtEndDate"), "dd/MM/yyyy", en))
        Dim CostCentreID = Request.Form("ddlCostCentre").Split("#")
        arParms(9) = New SqlParameter("@CostCentreID", CInt(CostCentreID(0)))
        arParms(10) = New SqlParameter("@Comments", IIf(txtProjComment.Text <> "", txtProjComment.Text, DBNull.Value))
        arParms(11) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
        arParms(11).Direction = ParameterDirection.Output

        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_UpdateProject", arParms)
        strErr = arParms(11).Value

    End Sub

    Private Sub ProcessProjectResources()
        ' Update Approver1 (Final Approver)
        ItemID = ViewState("Approver1ResourceID")

        'Dim arParms2() As SqlParameter = New SqlParameter(9) {}
        'arParms2(0) = New SqlParameter("@ResourceID", IIf(ItemID <> 0, ItemID, DBNull.Value))
        'arParms2(1) = New SqlParameter("@UserID", IIf(Request.Form("ddlApprover1") <> 0, Request.Form("ddlApprover1"), DBNull.Value))
        'arParms2(2) = New SqlParameter("@ProjectID", ViewState("ProjectID"))
        'arParms2(3) = New SqlParameter("@Rate", IIf(Request.Form("txtApprover1") <> "", Request.Form("txtApprover1"), 0))
        'arParms2(4) = New SqlParameter("@FirstApprover", DBNull.Value)
        'arParms2(5) = New SqlParameter("@LastApprover", "1")
        '' Check if this role is also a timesheet approver role
        'If ViewState("TSApprover2RoleID") = ViewState("Approver1RoleID") Then
        '    ' This resource is also the First Timesheet Expense Approver)
        '    arParms2(6) = New SqlParameter("@TSFirstApprover", "1")
        'Else
        '    arParms2(6) = New SqlParameter("@TSFirstApprover", DBNull.Value)
        'End If
        'If ViewState("TSApprover1RoleID") = ViewState("Approver1RoleID") Then
        '    ' This resource is also the Final Timesheet Expense Approver)
        '    arParms2(7) = New SqlParameter("@TSLastApprover", "1")
        'Else
        '    arParms2(7) = New SqlParameter("@TSLastApprover", DBNull.Value)
        'End If
        'arParms2(8) = New SqlParameter("@TeamLeader", DBNull.Value)
        'arParms2(9) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
        'arParms2(9).Direction = ParameterDirection.Output
        'SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateProjectResources", arParms2)
        'strErr = arParms2(9).Value

        'SD: 05/09/2005 - Changed to use DAL
        strErr = DAL.AddUpdateResource(IIf(ItemID <> 0, ItemID, String.Empty), IIf(Request.Form("ddlApprover1") <> 0, Request.Form("ddlApprover1"), String.Empty), _
                                        ViewState("ProjectID"), IIf(Request.Form("txtApprover1") <> "", Request.Form("txtApprover1"), 0), _
                                        String.Empty, "1", String.Empty, String.Empty, True)

        If ViewState("PTOApprovals") > 1 Then
            ' Update Approver2 
            ItemID = ViewState("Approver2ResourceID")
            'arParms2(0) = New SqlParameter("@ResourceID", IIf(ItemID <> 0, ItemID, DBNull.Value))
            'arParms2(1) = New SqlParameter("@UserID", IIf(Request.Form("ddlApprover2") <> 0, Request.Form("ddlApprover2"), DBNull.Value))
            'arParms2(2) = New SqlParameter("@ProjectID", ViewState("ProjectID"))
            'arParms2(3) = New SqlParameter("@Rate", IIf(Request.Form("txtApprover2") <> "", Request.Form("txtApprover2"), DBNull.Value))
            'arParms2(4) = New SqlParameter("@FirstApprover", "1")
            'arParms2(5) = New SqlParameter("@LastApprover", DBNull.Value)
            'If ViewState("TSApprover2RoleID") = ViewState("Approver2RoleID") Then
            '    ' This resource is also the First Timesheet Expense Approver)
            '    arParms2(6) = New SqlParameter("@TSFirstApprover", "1")
            'Else
            '    arParms2(6) = New SqlParameter("@TSFirstApprover", DBNull.Value)
            'End If
            'If ViewState("TSApprover1RoleID") = ViewState("Approver2RoleID") Then
            '    ' This resource is also the Final Timesheet Expense Approver)
            '    arParms2(7) = New SqlParameter("@TSLastApprover", "1")
            'Else
            '    arParms2(7) = New SqlParameter("@TSLastApprover", DBNull.Value)
            'End If
            'arParms2(8) = New SqlParameter("@TeamLeader", DBNull.Value)
            'arParms2(9) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
            'arParms2(9).Direction = ParameterDirection.Output
            'SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateProjectResources", arParms2)
            'strErr = arParms2(9).Value

            'SD: 05/09/2005 - Changed to use DAL
            strErr = DAL.AddUpdateResource(IIf(ItemID <> 0, ItemID, String.Empty), IIf(Request.Form("ddlApprover2") <> 0, Request.Form("ddlApprover2"), String.Empty), _
                                           ViewState("ProjectID"), IIf(Request.Form("txtApprover2") <> "", Request.Form("txtApprover2"), String.Empty), _
                                           "1", String.Empty, String.Empty, String.Empty, True)

        End If

        ' Update TeamLeader 
        ItemID = ViewState("TeamLeaderResourceID")

        strErr = DAL.AddUpdateResource(IIf(ItemID <> 0, ItemID, String.Empty), IIf(Request.Form("ddlTeamLeader") <> 0, Request.Form("ddlTeamLeader"), String.Empty), _
                                        ViewState("ProjectID"), IIf(Request.Form("txtTeamLeader") <> "", Request.Form("txtTeamLeader"), String.Empty), _
                                          String.Empty, String.Empty, String.Empty, "1", True)

        If ViewState("TSApprovals") > 1 Then
            ' Update Timesheet Last Approver ie. Manager
            ItemID = ViewState("TSApprover2ResourceID")
            strErr = DAL.AddUpdateResource(IIf(ItemID <> 0, ItemID, String.Empty), IIf(Request.Form("ddlManager") <> 0, Request.Form("ddlManager"), DBNull.Value), _
                                           ViewState("ProjectID"), IIf(Request.Form("txtManager") <> "", Request.Form("txtManager"), DBNull.Value), _
                                           String.Empty, String.Empty, "1", String.Empty, True)

        End If

        ' Update TeamMembers 
        a = 0
        NoRows = 0

        ItemNo = ""
        ItemNo = Request.Form("resource_list")

        If ItemNo <> "" And ItemNo <> "#" Then              'SD: 19/10/2005 - Change dymanic adds from , to #
            Try
                Dim RowArray As Array = ItemNo.Split("#")   'SD: 19/10/2005 - Change dymanic adds from , to #
                NoRows = RowArray((RowArray.Length - 2))
            Catch
            End Try

            If NoRows < Request.Form("resourceLoadCount") Then
                NoRows = Request.Form("resourceLoadCount")
            End If
        Else
            ' There are no dynamic add rows, if there were items on load then these need to be deleted now
            NoRows = Request.Form("resourceLoadCount")
        End If

        While a < NoRows
            a += 1

            ItemID = 0
            Dim HidBoxVal As String = Request.Form("hidBoxresource_" & a)
            If HidBoxVal <> "" Then
                arrData = HidBoxVal.Split("#")  'SD: 19/10/2005 - Change dymanic adds from , to #
                ItemID = arrData(0)
            End If

            'SD: 05/09/2005 - Change to use the Datalayer
            strErr = DAL.AddUpdateResource(IIf(ItemID <> 0, ItemID, String.Empty), IIf(Request.Form("ddlResource_" & a) <> 0, Request.Form("ddlResource_" & a), String.Empty), _
                                            ViewState("ProjectID"), IIf(Request.Form("txtResource_" & a) <> "", Request.Form("txtResource_" & a), String.Empty), _
                                            String.Empty, String.Empty, String.Empty, String.Empty, True)


        End While
    End Sub

    Sub SendEmail(ByVal email As String)
        Dim MailTo As String
        Dim Subject As String
        Dim Priority As Mail.MailPriority = Mail.MailPriority.Normal
        Dim strBody As String

        ' Send email when project Submitted for approval
        strBody = "<font size=2 face=Arial>The following project is waiting for your approval: " & vbCrLf & _
                  "<br><br><b>Project Code: </b>" & txtProjCode.Text & vbCrLf & _
                  "<br><b>Project  Name: </b>" & txtProjName.Text & vbCrLf & _
                  "<br><b>Client: </b>" & ddlClient.SelectedItem.Text & "</font>"

        Subject = "Project Awaiting Approval:" & txtProjCode.Text & " - " & txtProjName.Text
        WebMails.TrySendMail(email, Subject, strBody, Mail.MailPriority.Normal, "")

    End Sub

#End Region

End Class
