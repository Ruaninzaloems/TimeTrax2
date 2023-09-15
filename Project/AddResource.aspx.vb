Public Class AddResource
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents rfvResource As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents ddlResource As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtHidProjectID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidAppPath As System.Web.UI.HtmlControls.HtmlInputHidden

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
    Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")
    Dim ProjID As String
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ProjID = Request.QueryString("ProjID")

        'SB: 08/08/2005 - Set the Application Path and Project ID so that the web service can check
        'if the user is already a resource on the project
        hidAppPath.Value = Request.ApplicationPath
        txtHidProjectID.Value = ProjID

        If Not IsPostBack Then
            ' Load the Resources Droplist
            ddlResource.DataSource = DAL.LoadResources(True, ProjID)
            ddlResource.DataBind()
            ddlResource.Items.Insert(0, New ListItem("--Select a Team Member--", "0"))
            ' This is to Initialize WS
            Response.Write("<script language=javascript>function window.onload() {ws1_init();}</script>")
        End If
    End Sub
#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ' Get Resources Rate for the Project
        Dim UserID As String = Request.Form("ddlResource")
        Dim Rate As String = DAL.GetUserProjectRate(UserID, ProjID)
        Dim strErr = DAL.AddUpdateResource(String.Empty, UserID, ProjID, Rate, String.Empty, String.Empty, String.Empty, String.Empty, True)
        Select Case strErr
            Case 0 ' No Errors
                ' Close Add Resource popup window and reload calling window
                Response.Write("<script language=javascript>function window.onload() {closeAdd();}</script>")
            Case Else
                Response.Write("<script language='javascript'> alert('Error(" + strErr + ")');</script>")
        End Select
    End Sub
#End Region

End Class
