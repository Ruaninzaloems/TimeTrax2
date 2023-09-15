Public Class StyleTemplate
  Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

  'This call is required by the Web Form Designer.
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

  End Sub
  Protected WithEvents dg As System.Web.UI.WebControls.DataGrid
  Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlTable

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
#End Region

#Region " PAGE LOAD "
  Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    If Not IsPostBack Then

      'Put user code to initialize the page here
    End If
  End Sub
#End Region

#Region " SUBMIT DETAILS "
#End Region

End Class
