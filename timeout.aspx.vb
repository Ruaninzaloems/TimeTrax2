Imports System.Web.Security
Public Class timeout
  Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

  'This call is required by the Web Form Designer.
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

  End Sub
  Protected WithEvents lbltimeleft As System.Web.UI.WebControls.Label
  Protected WithEvents txttime As System.Web.UI.WebControls.TextBox
  Protected WithEvents btnLogout As System.Web.UI.WebControls.Button

  'NOTE: The following placeholder declaration is required by the Web Form Designer.
  'Do not delete or move it.
  Private designerPlaceholderDeclaration As System.Object

  Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
    'CODEGEN: This method call is required by the Web Form Designer
    'Do not modify it using the code editor.
    InitializeComponent()
  End Sub

#End Region

  Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")

  Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    'Put user code to initialize the page here
    Select Case Request.QueryString("time")

      Case "5"
        lbltimeleft.Text = "Your session will expire in <b>" & Request.QueryString("time") & " minutes</b><br><br>If your session expires you will loose any unsaved data.<br>To prevent a session timeout, we recommend you complete and submit your form (if applicable)"
      Case "1"
        lbltimeleft.Text = "Your session will expire in <b>" & Request.QueryString("time") & " minute.</b><br><br>If your session expires you will loose any unsaved data.<br>To prevent a session timeout, we recommend you complete and submit your form (if applicable)"
      Case Else
				lbltimeleft.Text = "<b>Your session has expired.</b><br><br>Submitting or refreshing your page will redirect you to the login page. Any data you have entered will not be saved into the database. We recommend you make a note of all the data you have captured so as to be able to re-enter it at a later stage (if applicable)"
        LogOut()
    End Select

    txttime.Text = Request.QueryString("time")
  End Sub

  Private Sub LogOut()
    FormsAuthentication.SignOut()
    ' Clear all Site specific cookies
    Response.Cookies("User").Value = ""
  End Sub

  Private Sub btnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogout.Click
    LogOut()
    'Response.Redirect("LogIn.aspx")
  End Sub
End Class
