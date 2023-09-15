Public Class DataExtract
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents dgResult As System.Web.UI.WebControls.DataGrid
    Protected WithEvents tblButtons As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents pgHead As System.Web.UI.HtmlControls.HtmlTableRow

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
    Dim arParms() As SqlParameter = New SqlParameter(0) {}
    Dim en As New System.Globalization.CultureInfo("en-Za")

    ' Required for Errorhandling
    Protected WithEvents ucHeader As TimeTrax.header
    Dim strStatus As String
    Dim strErr As String
    Dim strMess As String

#End Region

#Region " PAGE DECLARES "
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "50"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
        Else
            CreateDataExtract()
        End If

    End Sub

    Private Sub CreateDataExtract()
        Dim DS = New DataSet
        DS = DAL.ReportDataExtract(Request.Form("ucReportFilters:ddlProject"), _
                                        System.DateTime.ParseExact(Request.Form("ucReportFilters:txtStartDate"), "dd/MM/yyyy", en), _
                                        System.DateTime.ParseExact(Request.Form("ucReportFilters:txtEndDate"), "dd/MM/yyyy", en), _
                                        Request.Form("ucReportFilters:ddlTask"), _
                                        Common.CalcUserString(Request.Form("ucReportFilters:lstUsers")), _
                                        Request.Form("ucReportFilters:ddlCaptureType"))

        dgResult.DataSource = DS
        dgResult.DataBind()
        '-- Uncomment for debugging purposes only
        'dgResult.ShowHeader = True
        'Exit Sub
        Common.ExportExcel(divReport, Me)
    End Sub
#End Region

End Class
