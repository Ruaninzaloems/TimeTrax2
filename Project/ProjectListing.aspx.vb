Public Class ProjectListing
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlTeamLeader As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlClient As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlStatus As System.Web.UI.WebControls.DropDownList
    Protected WithEvents dgProjectListing As System.Web.UI.WebControls.DataGrid
    Protected WithEvents divProjectListing As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents ddlManager As System.Web.UI.WebControls.DropDownList
    Protected WithEvents trManager As System.Web.UI.HtmlControls.HtmlTableRow

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
    Dim DR As SqlDataReader
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " PAGE DECLARES "
    Private m_intTSApprovals As String
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Check if the the user has permission for the page else send to the start page
        UserLogin.CheckUserAccess("25", context, True)

        'SD: 03/02/2010 - Cater for showing the Manager column if there are 2 levels of approval
        DR = DAL.LoadSystemData()
        If DR.Read() Then
            If IsDBNull(DR.Item("TSApprovals")) Then
                m_intTSApprovals = 1
            Else
                m_intTSApprovals = DR.Item("TSApprovals")
            End If
        End If
        DR.Close()

        If m_intTSApprovals = 2 Then
            trManager.Visible = True
            dgProjectListing.Columns(0).Visible = True
        Else
            trManager.Visible = False
            dgProjectListing.Columns(0).Visible = False
        End If

        If Not IsPostBack Then
            Session("PageType") = "Project Listing"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Project Listing"
            LoadDropLists()
        End If

        PopulateDataGrid()
    End Sub

    Private Sub LoadDropLists()
        ' Load the Clients Droplist
        ddlClient.DataSource = DAL.LoadClients(0) 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectClient")
        ddlClient.DataBind()
        ddlClient.Items.Insert(0, New ListItem("All", "0"))

        ' Load the TeamLeader Droplist
        ddlTeamLeader.DataSource = DAL.LoadTimesheetApprovers(7)  'RoleID = 7 = 'Timesheet Approval Level 1 (Team Leader)'
        ddlTeamLeader.DataBind()
        ddlTeamLeader.Items.Insert(0, New ListItem("All", "0"))


        ddlStatus.DataSource = DAL.LoadStatuses()
        ddlStatus.DataBind()
        ddlStatus.Items.Insert(0, New ListItem("Open", "0"))

        'SD: 03/02/2010 - Load the manager dropdown if there are 2 levels of approval
        If m_intTSApprovals = 2 Then
            ddlManager.DataSource = DAL.LoadTimesheetApprovers(69) 'RoleID 69 -  Timesheet Approval Level 2 (Manager)
            ddlManager.DataBind()
            ddlManager.Items.Insert(0, New ListItem("All", "0"))
        End If

    End Sub

    Private Sub PopulateDataGrid()
        Dim ProjectsRow As DataRow
        Dim ProjectsTable As DataTable = New DataTable("RESULTS")
        ProjectsTable.Columns.Add("Code", GetType(System.String))
        ProjectsTable.Columns.Add("Name", GetType(System.String))
        ProjectsTable.Columns.Add("Status", GetType(System.String))
        ProjectsTable.Columns.Add("Manager", GetType(System.String))
        ProjectsTable.Columns.Add("TeamLeader", GetType(System.String))
        ProjectsTable.Columns.Add("Client", GetType(System.String))

        Dim managerID As Int32
        If (ddlManager.Items.Count > 0) Then
            managerID = Convert.ToInt32(ddlManager.SelectedValue)
        Else
            managerID = 0
        End If


        DR = DAL.LoadProjectListing(managerID, ddlTeamLeader.SelectedValue, ddlClient.SelectedValue, ddlStatus.SelectedValue, User.Identity.Name)
        While DR.Read()
            ProjectsRow = ProjectsTable.NewRow()
            ProjectsRow("Code") = DR.Item("HRef")
            ProjectsRow("Name") = DR.Item("ProjectName")
            ProjectsRow("Status") = DR.Item("StatusName")
            ProjectsRow("TeamLeader") = DR.Item("TeamLeader")
            ProjectsRow("Client") = DR.Item("ClientName")
            ProjectsRow("Manager") = DR.Item("Manager")
            ProjectsTable.Rows.Add(ProjectsRow)
        End While

        dgProjectListing.DataSource = ProjectsTable
        dgProjectListing.DataBind()
        If dgProjectListing.Items.Count() > 0 Then
            divProjectListing.Style("DISPLAY") = "block"
        End If
    End Sub
#End Region

End Class
