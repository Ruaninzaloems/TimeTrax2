Public Class ExpenseRejected
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents dgProjectListing As System.Web.UI.WebControls.DataGrid
    Protected WithEvents dgExpenses As System.Web.UI.WebControls.DataGrid
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button

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

        ds = DAL.SelectRejectedExpense(User.Identity.Name, Request.QueryString("ExpenseMonth"))
        dgExpenses.DataSource = ds
        dgExpenses.DataBind()

    End Sub
#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Response.Redirect("Expense.aspx?ExpenseMonth=" & Request.QueryString("ExpenseMonth"))
    End Sub

#End Region

End Class
