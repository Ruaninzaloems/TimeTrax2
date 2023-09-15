Imports System.Web.Security
Imports System.Security.Principal

Public Class WinLogin
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

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Dim DBConn = ConfigurationSettings.AppSettings("DBConn")
        ''-- Check if Win Authentication must be used
        'If SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, "TT_GetAuthenticationMethod") Then
        ' Get the username of the User
        Dim logonuser As Array = Me.Request.ServerVariables("LOGON_USER").Split("\")
        ' Get the username and drop the Domain
        Dim userName As String = logonuser(1)
        If CheckWinAuthentication(userName) Then
            ' This sets the authentication cookie and redirects to the original page (default.aspx?)
            FormsAuthentication.RedirectFromLoginPage(userName, False)
        Else
            ' Access is denied
            Response.Redirect("Redirect401.htm")
        End If
        'Else
        '    'Go to WebLogin.aspx
        '    Response.Redirect("Redirect401.htm")
        'End If
    End Sub

    Private Function CheckWinAuthentication(ByVal strUsername As String) As Boolean
        Dim UserID As Int32 = UserLogin.CustomWinAuthenticate(strUsername)
        If UserID = 0 Then
            Return False
        Else
            Common.SetUserCookie(context, UserID)
            Return True
        End If
    End Function

#End Region

End Class
