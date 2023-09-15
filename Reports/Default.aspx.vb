Imports System.Xml
Imports System.Xml.Xsl
Imports System.Xml.XPath
Imports System.IO

Public Class _Default1
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Xmlresult As System.Web.UI.WebControls.Xml
    Protected WithEvents btnGenerate As System.Web.UI.WebControls.Button
    Protected WithEvents rfvStartDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtStartDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtEndDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvEndDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary

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
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
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

        End If
    End Sub

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnGenerate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGenerate.Click

        ' Load Session variables from form values
        'Session("Rep_ClientID") = Request.Form("pOptionClient")
        'Session("Rep_ProjectID") = Request.Form("pOptionProject")
        'Session("Rep_TaskID") = Request.Form("pOptionTask")
        Session("Rep_ClientID") = Request.Form("ucRepSelections:ddlLevel1")
        Session("Rep_ProjectID") = Request.Form("ucRepSelections:ddlLevel2")
        Session("Rep_TaskID") = Request.Form("ucRepSelections:ddlLevel3")
        Session("Rep_Users") = Request.Form("ucRepSelections:lstUsers")
        Session("Rep_Grouping") = Request.Form("grouping_list")
        Session("Rep_StartDate") = Request.Form("txtStartDate")
        Session("Rep_EndDate") = Request.Form("txtEndDate")
        If Request.Form("chkTotals") = "on" Then
            Session("Rep_Totals") = "on"
        Else
            Session("Rep_Totals") = "off"
        End If

        Select Case Request.QueryString("RepID")
            Case 50
                Response.Redirect("TaskReg.aspx")
            Case 51
                Response.Redirect("Expenses.aspx")
            Case 52
                Response.Redirect("ProjSummary.aspx")
            Case 53
                Response.Redirect("ProjStatus.aspx")
            Case 54
                Response.Redirect("Profitability.aspx")
            Case 58
                Response.Redirect("TimeOff.aspx")
            Case 59
                Response.Redirect("ProjectActivityRegister.aspx")
            Case 60
                Response.Redirect("ExpenseReimbursements.aspx")
            Case Else
        End Select

    End Sub
#End Region
End Class
