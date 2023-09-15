Public Class ExpenseSubmitted
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
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " PAGE DECLARES "
    Dim ucExpensesReport As TimeTrax.ExpensesReport
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Don't set a permission as everyone can see what expenses they submited

        If Not IsPostBack Then
            'Set the values for the user control
            ucExpensesReport = Me.FindControl("ucExpensesReport")
            ucExpensesReport.ProjectID = 0
            ucExpensesReport.StartDate = String.Empty
            ucExpensesReport.EndDate = String.Empty
            ucExpensesReport.Users = Common.CalcUserString(Request.QueryString("UserID"))
            ucExpensesReport.ClientID = 0
            ucExpensesReport.CaptureTypeID = 3
            ucExpensesReport.ExpenseMonth = Request.QueryString("ExpenseMonth")
            ucExpensesReport.ShowReport = True
            ucExpensesReport.ShowExport = False
            ucExpensesReport.ShowPrint = False
            ucExpensesReport.ShowPrintPopup = True
            ucExpensesReport.LoadProjectDetails()
        End If
    End Sub
#End Region



End Class
