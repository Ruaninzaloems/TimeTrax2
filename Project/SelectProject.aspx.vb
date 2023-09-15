Public Class SelectProject
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlProjects As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents btnSave As System.Web.UI.WebControls.Button

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
    Dim DBConn = ConfigurationSettings.AppSettings("DBConnStr")
    Dim LoginDBConn = ConfigurationSettings.AppSettings("LoginDBConnStr")
    Dim DR As SqlDataReader
    Dim DR1 As SqlDataReader
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " PAGE DECLARES "
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not IsPostBack Then
            Session("PageType") = ""
            ' Load Project Droplist with all Projects in Status 3 (In Progress)
            ddlProjects.DataSource = DAL.GetProjects(3)
            ddlProjects.DataBind()
        End If
    End Sub
#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ' Redirect to the Page that Called it passing the SelectedProjectID
        Dim returnUrl As String
        If Session("ReturnUrl") Is Nothing Then
            returnUrl = Me.Request.ApplicationPath
        Else
            returnUrl = Session("ReturnUrl") & "?ProjID=" & ddlProjects.SelectedValue
        End If
        Me.Response.Redirect(returnUrl)
        'Response.Redirect("ProjectVO.aspx?ProjID=" & ddlProjects.SelectedValue)

    End Sub
#End Region
End Class
