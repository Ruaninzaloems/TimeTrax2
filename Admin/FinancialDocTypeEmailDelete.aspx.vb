Public Class FinancialDocTypeEmailDelete
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents lblMessage As System.Web.UI.WebControls.Label

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
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not IsPostBack Then
            DeleteEmail()
        End If
    End Sub

    Private Sub DeleteEmail()
        Dim strErr As String = String.Empty
        Dim strMess As String
        Dim arParms() As SqlParameter = New SqlParameter(1) {}

        arParms(0) = New SqlParameter("@FinancialDocTypeID", Request.QueryString("FinancialDocTypeID"))
        arParms(1) = New SqlParameter("@UserID", Request.QueryString("UserID"))

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_DeleteFinancialDocTypeEmail", arParms)
        Catch ex As SqlException
            strErr = ex.Number
            strMess = ex.Message
        End Try
        If strErr = String.Empty Then
            lblMessage.Text = "The Email has been successfully deleted"
        Else
            lblMessage.Text = "<b>Error(" + strErr + ")</b> - <br><br>" + strMess + ", You will need to go <a href=# onclick=javascript:history.back();>back</a> to try again"
        End If
    End Sub

End Class
