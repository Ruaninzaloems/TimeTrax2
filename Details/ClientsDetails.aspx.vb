Public Class ClientsDetails1
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
#End Region

#Region " PAGE LOAD "
  Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'TODO:Sort out the role here
        '' Check User Has Permissions to Access this Page
        'Dim Role As String = "2"
        'Intermap.BusinessLayer.UserLogin.CheckUserAccess(Role, Context.Current,True)

    If Not IsPostBack Then
        'Put user code to initialize the page here
    End If
  End Sub
#End Region

#Region " SUBMIT DETAILS "
#End Region

End Class
