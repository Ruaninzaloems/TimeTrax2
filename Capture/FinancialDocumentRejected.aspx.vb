Public Class FinancialDocumentRejected
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents dgFinancialDocument As System.Web.UI.WebControls.DataGrid
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancel As System.Web.UI.WebControls.Button

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

        LoadGrid()

    End Sub

    Private Sub LoadGrid()

        Dim ds As DataSet

        ds = DAL.SelectRejectedFinancialDocument(User.Identity.Name)
        dgFinancialDocument.DataSource = ds
        dgFinancialDocument.DataBind()

    End Sub
#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim intCount As Integer
        Dim ds As DataSet = dgFinancialDocument.DataSource
        'Loop through the grid and delete the documents
        If ds.Tables.Count > 0 Then
            For intCount = 0 To ds.Tables(0).Rows.Count - 1
                DAL.DeleteFinancialDocument(ds.Tables(0).Rows(intCount).Item("FinancialDocID"), User.Identity.Name)
            Next
        End If
        Response.Redirect("../Default.aspx")
    End Sub

#End Region

#Region " CANCEL"

    Private Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("../Default.aspx")
    End Sub

#End Region

End Class
