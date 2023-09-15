Public Class ProjSummary
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ReportPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtStartDate As Intermap.Controls.IMTextBox
    Protected WithEvents txtEndDate As Intermap.Controls.IMTextBox
    Protected WithEvents txtProjEnd As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtProjStart As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudget As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudgetHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents imgRegenerate As System.Web.UI.WebControls.ImageButton
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents Imagebutton1 As System.Web.UI.WebControls.ImageButton
    Protected WithEvents divProjHeader As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents trFilter As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents btnGenerate As System.Web.UI.WebControls.Button
    Protected WithEvents hidClientID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidProjectID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents ddlClient As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlProject As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator

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
    Dim DS As DataSet
    Dim ucProjectSummary As TimeTrax.ProjectSummary
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "52"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            ' Load the values from the Report Selection Page
            LoadProjectsDropList()

            Dim monthstart As Date
            monthstart = Month(Today()) & "/01/" & Year(Today())
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

            'set the hidden text boxes for the drop downs
            hidClientID.Value = Session("Rep_ClientID")
            hidProjectID.Value = Session("Rep_ProjectID")

            divReport.Visible = False
        Else
            'set the hidden text boxes for the drop downs
            hidClientID.Value = Request.Form("ddlClient")
            hidProjectID.Value = Request.Form("ddlProject")

            divReport.Visible = True
        End If

    End Sub

    Private Sub LoadProjectsDropList()

        Dim DS As DataSet = DAL.LoadReportSelections()
        ' Load the Clients Droplist
        ddlClient.DataSource = DS.Tables(0)
        ddlClient.DataBind()
        ddlClient.Items.Insert(0, New ListItem("All", "0"))

        If ddlClient.Items.Count = 0 Then
            Response.Redirect("NoDataFound.aspx")
        End If

        ' Load the Projects Droplist
        ddlProject.DataSource = DS.Tables(1)
        ddlProject.DataBind()
        ddlProject.Items.Insert(0, New ListItem("All", "0#0"))

        If ddlProject.Items.Count = 0 Then
            Response.Redirect("NoDataFound.aspx")
        End If

    End Sub


#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click
        Session("Rep_StartDate") = txtStartDate.Text
        Session("Rep_EndDate") = txtEndDate.Text
        Session("Rep_ClientID") = hidClientID.Value
        Session("Rep_ProjectID") = hidProjectID.Value

        ucProjectSummary = Me.FindControl("ucProjectSummary")
        ucProjectSummary.ProjectID = Request.Form("ddlProject")
        ucProjectSummary.StartDate = txtStartDate.Text
        ucProjectSummary.EndDate = txtEndDate.Text
        ucProjectSummary.ShowExport = True
        ucProjectSummary.ShowPrint = True
        ucProjectSummary.ShowPrintPopup = False
        ucProjectSummary.LoadProjectDetails()
    End Sub

#End Region


End Class
