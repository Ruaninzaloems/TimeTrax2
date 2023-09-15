Public Class OrderInfo
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary

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
    Dim DR As SqlDataReader
    Dim DR1 As SqlDataReader
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " PAGE DECLARES "
    Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")
    Dim ucOrders As New TimeTrax.Orders
    Protected WithEvents ucHeader_hidAppPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Dim ucFinancialDocuments As New TimeTrax.FinancialDocuments
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ucOrders.OrderID = Request.QueryString("OrderID")
        ucOrders.blnReadOnly = True
        ucHeader_hidAppPath.Value = Request.ApplicationPath

        ucFinancialDocuments.ProjectID = Request.QueryString("ProjectID")

    End Sub

    Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender
        btnSubmit.Visible = ucOrders.blnAdminAccess
    End Sub
#End Region

#Region " SUBMIT PAGE "
    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ' Update ProjectEndDate
        ucOrders.ProcessProjectOrders(ucOrders.ProjID, ucOrders.OrderID, context)
        ' Update TaskNames
        ucOrders.ProcessProjectTasks(ucOrders.OrderID, context)

        Response.Write("<script language=javascript>opener.location.reload();window.close();</script>")

    End Sub
#End Region

End Class
