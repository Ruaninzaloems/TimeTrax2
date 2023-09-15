Public Class ReportFilters
    Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlCaptureType As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtEndDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtStartDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnGenerate As System.Web.UI.WebControls.Button
    Protected WithEvents Validationsummary2 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents ddlProject As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlTask As System.Web.UI.WebControls.DropDownList
    Protected WithEvents hidProjectID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidTaskID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents lblTask As System.Web.UI.WebControls.Label
    Protected WithEvents lblGroupBy As System.Web.UI.WebControls.Label
    Protected WithEvents _lstGroupBy As System.Web.UI.HtmlControls.HtmlSelect
    Protected WithEvents imgGroupUp As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents imgGroupDown As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents hidProjRequired As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents CustomValidator1 As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents rfvStartDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents rfvEndDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ddlClient As System.Web.UI.WebControls.DropDownList
    Protected WithEvents lstUsers As System.Web.UI.WebControls.ListBox
    Protected WithEvents hidClientID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents grouping_list As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents trSummary As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents optUser As System.Web.UI.WebControls.RadioButton
    Protected WithEvents optDetail As System.Web.UI.WebControls.RadioButton
    Protected WithEvents trUser As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents optMonthView As System.Web.UI.WebControls.RadioButton
    Protected WithEvents optDateView As System.Web.UI.WebControls.RadioButton
    Protected WithEvents ddlMonth As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlYear As System.Web.UI.WebControls.DropDownList
    Protected WithEvents trMonth1 As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents trMonth2 As System.Web.UI.HtmlControls.HtmlTableRow

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
    Dim en As New System.Globalization.CultureInfo("en-Za")
    Public ProjectJavascriptKeyValue As String
    Public TaskJavascriptKeyValue As String
#End Region

#Region " PAGE LOAD "

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Dim monthstart As Date
        monthstart = Month(Today()) & "/01/" & Year(Today())

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"

            ' Try loading Dates from Session Vars if they exist
            If Session("Rep_StartDate") <> "" Then
                txtStartDate.Text = Session("Rep_StartDate")
            Else
                txtStartDate.Text = monthstart.ToString("dd/MM/yyyy", en)
            End If
            If Session("Rep_EndDate") <> "" Then
                txtEndDate.Text = Session("Rep_EndDate")
            Else
                txtEndDate.Text = Today().ToString("dd/MM/yyyy")
            End If

            'set the hidden text boxes
            hidClientID.Value = Session("Rep_ClientID")
            hidProjectID.Value = Session("Rep_ProjectID")
            hidTaskID.Value = Session("Rep_TaskID")
            hidProjRequired.Value = Request.QueryString("ProjRequired")

            'Set the capture type
            ddlCaptureType.SelectedValue = Session("Rep_CaptureType")

            LoadDroplists()
            LoadGroupByBox(Session("Rep_Grouping"))

            'Set the expense month details
            If Session("Rep_ExpenseMonth") Is Nothing Then
                ddlMonth.SelectedIndex = Common.GetIndexByValue(ddlMonth, Now.Month)
            Else
                ddlMonth.SelectedValue = Session("Rep_ExpenseMonth")
            End If
            If Session("Rep_ExpenseYear") = Nothing Then
                ddlYear.SelectedIndex = Common.GetIndexByValue(ddlYear, Now.Year)
            Else
                ddlYear.SelectedValue = Session("Rep_ExpenseYear")
            End If

            'Default the report to date view
            optDateView.Checked = True

        Else

            'set the hidden text boxes
            hidClientID.Value = Request.Form("ucReportFilters:ddlClient")
            hidProjectID.Value = Request.Form("ucReportFilters:ddlProject")
            hidTaskID.Value = Request.Form("ucReportFilters:ddlTask")

            LoadGroupByBox(Request.Form("ucReportFilters:grouping_list"))
            LoadProjectsTasks(DAL.LoadReportSelections())

            'Check that the start and end dates have a value - can be reset due to the Expense Reimbursement Month View filter
            'If they are empty - set some default dates
            If txtStartDate.Text = String.Empty Then
                If Session("Rep_StartDate") <> "" Then
                    txtStartDate.Text = Session("Rep_StartDate")
                Else
                    txtStartDate.Text = monthstart.ToString("dd/MM/yyyy", en)
                End If
            End If

            If txtEndDate.Text = String.Empty Then
                If Session("Rep_EndDate") <> "" Then
                    txtEndDate.Text = Session("Rep_EndDate")
                Else
                    txtEndDate.Text = Today().ToString("dd/MM/yyyy")
                End If
            End If

        End If

        'Hide the Task Filter items if they are not relevant to the report
        If Request.QueryString("ShowTaskFilter") = "0" Then
            ddlTask.Visible = False
            lblTask.Visible = False
        Else
            ddlTask.Visible = True
            lblTask.Visible = True
            '_lstGroupBy.Visible = True
            'lblGroupBy.Visible = True
            'imgGroupDown.Visible = True
            'imgGroupUp.Visible = True
        End If

        'If it indicates that we must show the group by filter then show those values.
        'By default if you don't want the Task Filter then you don't want the Group By box - 
        'however an exception now occurs in the Expenses Reimbursement Report
        If Request.QueryString("ShowGroupBy") = "1" Then
            _lstGroupBy.Visible = True
            lblGroupBy.Visible = True
            imgGroupDown.Visible = True
            imgGroupUp.Visible = True
        Else
            _lstGroupBy.Visible = False
            lblGroupBy.Visible = False
            imgGroupDown.Visible = False
            imgGroupUp.Visible = False
        End If

        'Hide or show the user type filter - Only the expense report uses this filter
        If Request.QueryString("UserFilter") = "1" Then
            trUser.Visible = True
        Else
            trUser.Visible = False
        End If

        'Hide or show the expense month filter - Only the Expense Reimbursement report uses this filter
        If Request.QueryString("ExpenseMonthFilter") = "1" Then
            trMonth1.Visible = True
            trMonth2.Visible = True
        Else
            trMonth1.Visible = False
            trMonth2.Visible = False
        End If

    End Sub

    Private Sub LoadDroplists()

        Dim DS As DataSet = DAL.LoadReportSelections()
        ' Load the Clients Droplist
        ddlClient.DataSource = DS.Tables(0)
        ddlClient.DataBind()
        ddlClient.Items.Insert(0, New ListItem("All", "0"))


        LoadProjectsTasks(DS)

        'ddlProject.DataSource = DS.Tables(1)
        'ddlProject.DataBind()
        'ddlProject.Items.Insert(0, New ListItem("All", "0#0"))

        '' Load Tasks Droplist
        'ddlTask.DataSource = DS.Tables(2)
        'ddlTask.DataBind()
        'ddlTask.Items.Insert(0, New ListItem("All", "0#0"))


        ' Load Users
        Common.LoadUsersList(lstUsers)
        '-- Modified 23/01/2007 VF 
        '-- If Logged In User does not have role 'Can View All Users Reports'
        '-- Then change listbox selection Method
        If Not (UserLogin.CheckUserAccess("68", System.Web.HttpContext.Current, False)) Then
            '-- User cannot view other users data
            lstUsers.SelectionMode = ListSelectionMode.Single
        End If


        'Load Capture Types
        Dim item As New ListItem
        item.Text = "All"
        item.Value = 0
        ddlCaptureType.Items.Add(item)

        item = New ListItem
        item.Text = "Approved"
        item.Value = 1
        ddlCaptureType.Items.Add(item)

        item = New ListItem
        item.Text = "Captured"
        item.Value = 2
        ddlCaptureType.Items.Add(item)

        item = New ListItem
        item.Text = "Submitted"
        item.Value = 3
        ddlCaptureType.Items.Add(item)

        If Request.QueryString("ExpenseMonthFilter") = "1" Then
            'Load the year and month drop downs
            Common.LoadYearDropDown(ddlYear, 5, 1)
            Common.LoadMonthDropdown(ddlMonth)
        End If

    End Sub

    Private Sub LoadProjectsTasks(DS As DataSet)


        ProjectJavascriptKeyValue = "var AllProjects = {""All"":""0"","

        Dim dtProject As DataTable = DS.Tables(1).Copy()

        For r As Integer = 0 To dtProject.Rows.Count - 1

            ProjectJavascriptKeyValue = ProjectJavascriptKeyValue + """" + dtProject.Rows(r)("ProjectID").ToString().Replace("""", "") + """:""" + dtProject.Rows(r)("ProjectName").ToString().Replace("""", "") + ""","


        Next

        ProjectJavascriptKeyValue = ProjectJavascriptKeyValue.Substring(0, ProjectJavascriptKeyValue.Length - 1)

        ProjectJavascriptKeyValue += "};"



        TaskJavascriptKeyValue = "var AllTasks = {""All"":""0"","

        Dim dtTask As DataTable = DS.Tables(2).Copy()

        For r As Integer = 0 To dtTask.Rows.Count - 1

            TaskJavascriptKeyValue = TaskJavascriptKeyValue + """" + dtTask.Rows(r)("TaskID").ToString().Replace("""", "") + """:""" + dtTask.Rows(r)("TaskName").ToString().Replace("""", "") + ""","


        Next

        TaskJavascriptKeyValue = TaskJavascriptKeyValue.Substring(0, TaskJavascriptKeyValue.Length - 1)

        TaskJavascriptKeyValue += "};"

        ddlProject.Items.Add(New ListItem("All", "0"))
        ddlTask.Items.Add(New ListItem("All", "0"))



    End Sub

    Private Sub LoadGroupByBox(ByVal strValue As String)

        Dim optValue As New ListItem

        _lstGroupBy.Items.Clear()

        If strValue = ",User,Task," Then

            optValue.Text = "User"
            _lstGroupBy.Items.Add(optValue)

            optValue = New ListItem
            optValue.Text = "Task"
            _lstGroupBy.Items.Add(optValue)

        Else

            optValue.Text = "Task"
            _lstGroupBy.Items.Add(optValue)

            optValue = New ListItem
            optValue.Text = "User"
            _lstGroupBy.Items.Add(optValue)

        End If

    End Sub


#End Region

#Region "Generate Report"

    Private Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click

        'set the session variables
        Session("Rep_ClientID") = Request.Form("ucReportFilters:ddlClient")
        Session("Rep_ProjectID") = Request.Form("ucReportFilters:ddlProject")
        Session("Rep_TaskID") = Request.Form("ucReportFilters:ddlTask")
        Session("Rep_Users") = Request.Form("ucReportFilters:lstUsers")
        Session("Rep_Grouping") = Request.Form("ucReportFilters:grouping_list")
        Session("Rep_StartDate") = Request.Form("ucReportFilters:txtStartDate")
        Session("Rep_EndDate") = Request.Form("ucReportFilters:txtEndDate")
        Session("Rep_CaptureType") = Request.Form("ucReportFilters:ddlCaptureType")
        Session("Rep_ExpenseMonth") = Request.Form("ucReportFilters:ddlMonth")
        Session("Rep_ExpenseYear") = Request.Form("ucReportFilters:ddlYear")

    End Sub

#End Region

End Class
