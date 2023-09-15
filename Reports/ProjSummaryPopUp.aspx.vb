Public Class ProjSummaryPopUp
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
    Dim ucProjectSummary As TimeTrax.ProjectSummary
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "52"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        ucProjectSummary = Me.FindControl("ucProjectSummary")
        ucProjectSummary.ProjectID = Session("Rep_ProjectID")
        ucProjectSummary.StartDate = Session("Rep_StartDate")
        ucProjectSummary.EndDate = Session("Rep_EndDate")
        ucProjectSummary.ShowExport = False
        ucProjectSummary.ShowPrint = False
        ucProjectSummary.ShowPrintPopup = True
        ucProjectSummary.LoadProjectDetails()

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
        End If
    End Sub
#End Region

#Region " SUBMIT DETAILS "
#End Region

End Class
