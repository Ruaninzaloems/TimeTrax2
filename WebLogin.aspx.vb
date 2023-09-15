Imports System.Web.Security
Imports System.Security.Principal

Public Class WebLogin
  Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

  'This call is required by the Web Form Designer.
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

  End Sub
  Protected WithEvents lblUsername As System.Web.UI.WebControls.Label
  Protected WithEvents txtUsername As System.Web.UI.WebControls.TextBox
  Protected WithEvents lblPassword As System.Web.UI.WebControls.Label
  Protected WithEvents txtPassword As System.Web.UI.WebControls.TextBox
  Protected WithEvents btnLogin As System.Web.UI.WebControls.Button
  Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
  Protected WithEvents RequiredFieldValidator2 As System.Web.UI.WebControls.RequiredFieldValidator
  Protected WithEvents Regularexpressionvalidator1 As System.Web.UI.WebControls.RegularExpressionValidator
  Protected WithEvents RegularExpressionValidator2 As System.Web.UI.WebControls.RegularExpressionValidator
  Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
  Protected WithEvents lblMessage As System.Web.UI.WebControls.Label
  Protected WithEvents Form1 As System.Web.UI.HtmlControls.HtmlForm
  'NOTE: The following placeholder declaration is required by the Web Form Designer.
  'Do not delete or move it.
  Private designerPlaceholderDeclaration As System.Object

  Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
    'CODEGEN: This method call is required by the Web Form Designer
    'Do not modify it using the code editor.
    InitializeComponent()
  End Sub

#End Region
  Public AppName As String = Trim(ConfigurationSettings.AppSettings("ApplicationName")) & " " & Trim(ConfigurationSettings.AppSettings("Version"))
  Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")

  Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    'Put user code to initialize the page here
    lblMessage.Visible = False
  End Sub

#Region "PAGE SUBMIT"

  Private Sub btnLogin_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        If CheckAuthentication(txtUsername.Text, txtPassword.Text) Then
            Dim userName As String = txtUsername.Text

            ' User is auhenticated so set the authentication cookie and
            FormsAuthentication.SetAuthCookie(userName, False)

            ' Redirect to the originally requested page (default.aspx?)
            Dim returnUrl As String
            If Me.Request.Cookies([Global].ReturnUrl) Is Nothing Then
                returnUrl = Me.Request.ApplicationPath
            Else
                returnUrl = Me.Request.Cookies([Global].ReturnUrl).Value
            End If
            Response.Redirect(Request.ApplicationPath & "/default.aspx")
        Else
            'Invalid credentials supplied, display message
            lblMessage.Text = "Invalid username or password!"
      lblMessage.Visible = True
    End If
  End Sub

  Private Function CheckAuthentication(ByVal strUsername As String, ByVal strPassword As String) As Boolean
    Dim UserID As Int32 = UserLogin.CustomAuthenticate(strUsername, strPassword)
    If UserID = 0 Then
      Return False
    Else
            Common.SetUserCookie(context, UserID)
      Return True
    End If
  End Function
#End Region

End Class
