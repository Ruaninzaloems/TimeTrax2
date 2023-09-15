Public Class SessionSet
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
#End Region

#Region " PAGE DECLARES "
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            Session("Rep_ClientID") = "0"
            Session("Rep_ProjectID") = Request.QueryString("ProjID").ToString
            Session("Rep_TaskID") = "0"
            Session("Rep_Users") = ""
            Session("Rep_Grouping") = ",Task,User,"
            Session("Rep_StartDate") = Request.QueryString("Start")
            Session("Rep_EndDate") = Request.QueryString("End")
            Session("Rep_Totals") = "on"
            Redirect()
            'Put user code to initialize the page here
        End If
    End Sub

    Private Sub Redirect()
        Select Case Request.QueryString("RepID")
            Case 50
                Response.Redirect("TaskReg.aspx")
            Case 51
                Response.Redirect("Expenses.aspx")
            Case 52
                Response.Redirect("ProjSummaryPopUp.aspx")
            Case 53
                Response.Redirect("ProjStatus.aspx")
            Case 54
                Response.Redirect("Profitability.aspx")
            Case 58
                Response.Redirect("TimeOff.aspx")
            Case Else
        End Select

    End Sub
#End Region

#Region " SUBMIT DETAILS "
#End Region

End Class
