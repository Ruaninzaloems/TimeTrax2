Public Class FinancialDocTypeEmailAdd
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtFinDocType As System.Web.UI.WebControls.TextBox
    Protected WithEvents ddlUser As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancel As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl

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
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not IsPostBack() Then
            LoadDetails()
            LoadUserDropdown()
        End If
    End Sub

    Sub LoadDetails()
        Dim ds As DataSet
        Dim intCount As Integer
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@FinancialDocTypeID", Request.QueryString("FinancialDocTypeID"))
        ds = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "TT_SelectDocumentTypeInfo", arParms)

        If ds.Tables.Count > 0 Then
            If ds.Tables(0).Rows.Count > 0 Then
                txtFinDocType.Text = ds.Tables(0).Rows(0).Item("FinancialDocType")
            End If
        End If
    End Sub

    Function LoadUserDropdown()

        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@EnabledUsersOnly", 1)
        Dim DS As DataSet = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "Usr_UserDropDowns", arParms)

        'Populate the users dropdown
        ddlUser.Items.Clear()
        ddlUser.DataSource = DS.Tables(0)
        ddlUser.DataBind()
    End Function

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim strErr As String
        Dim strMess As String
        Dim arParms() As SqlParameter = New SqlParameter(2) {}

        arParms(0) = New SqlParameter("@FinancialDocTypeID", Request.QueryString("FinancialDocTypeID"))
        arParms(1) = New SqlParameter("@UserID", ddlUser.SelectedValue)
        arParms(2) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
        arParms(2).Direction = ParameterDirection.Output

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddFinancialDocTypeEmail", arParms)
            strErr = arParms(2).Value
        Catch ex As SqlException
            strErr = ex.Number
            strMess = ex.Message
        End Try
        Select Case strErr
            Case 0 ' No Errors               
                lblmessage.Text = "The Email has been added"
                tblwizard2.Visible = False

            Case Else
                lblmessage.Text = "<b>Error(" + strErr + ")</b> - <br><br>" + strMess + ", You will need to go <a href=# onclick=javascript:history.back();>back</a> to try again"
        End Select
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("FinancialDocTypeEmail.aspx?FinancialDocTypeID=" & Request.QueryString("FinancialDocTypeID"))
    End Sub
End Class
