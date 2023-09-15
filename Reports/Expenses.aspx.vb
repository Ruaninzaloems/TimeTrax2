Public Class Expenses
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

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

    ' Required for Errorhandling
    Protected WithEvents ucHeader As TimeTrax.header
    Dim strStatus As String
    Dim strErr As String
    Dim strMess As String

#End Region

#Region " PAGE DECLARES "
    Dim ucExpensesReport As TimeTrax.ExpensesReport
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "51"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
        Else

            'Set the values for the user control
            ucExpensesReport = Me.FindControl("ucExpensesReport")
            ucExpensesReport.ProjectID = Request.Form("ucReportFilters:ddlProject")
            ucExpensesReport.StartDate = Request.Form("ucReportFilters:txtStartDate")
            ucExpensesReport.EndDate = Request.Form("ucReportFilters:txtEndDate")
            ucExpensesReport.Users = Common.CalcUserString(Request.Form("ucReportFilters:lstUsers"))
            ucExpensesReport.ClientID = Request.Form("ucReportFilters:ddlClient")
            ucExpensesReport.CaptureTypeID = Request.Form("ucReportFilters:ddlCaptureType")
            ucExpensesReport.ExpenseMonth = String.Empty
            ucExpensesReport.ShowPrint = True
            ucExpensesReport.ShowPrintPopup = False
            ucExpensesReport.ShowExport = True

            'If the user has selected thje user expense report then load the user Report else load the standard expense report
            If Request.Form("ucReportFilters:optUser") = "optUser" Then
                ucExpensesReport.LoadExpensesByUser()
            Else
                ucExpensesReport.LoadProjectDetails()
            End If
        End If

    End Sub

#End Region

End Class
