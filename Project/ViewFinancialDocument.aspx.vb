Public Class ViewFinancialDocument
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtOrderNo As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtNo As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvNumber As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents plcBudgetSummary As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtTitle As System.Web.UI.WebControls.TextBox
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents lblTitle As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents lblNo As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents lblDate As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents hidAppPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidDate As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidTitle As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidSize As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidFileName As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidUploadsPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidError As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidBudgetList As System.Web.UI.HtmlControls.HtmlInputHidden

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

#End Region

#Region " PAGE DECLARES "
    Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not IsPostBack Then
            Session("ProjectID") = Request.QueryString("ProjID")
            ' Show Upload Document Section
            tblwizard1.Visible = True
            Session("PageType") = "Upload"
            Session("PageTitle") = Session("AppName") & " - Document Upload"
            LoadFinancialDocumentDetails(Request.QueryString("FinancialDocumentID"))
            LoadBudgetItems(Request.QueryString("ProjectID"), Request.QueryString("FinancialDocumentID"))
        End If

    End Sub

    Private Sub LoadFinancialDocumentDetails(ByVal FinancialDocumentID As Integer)
        Dim DS As DataSet

        DS = DAL.LoadFinancialDocumentDetails(FinancialDocumentID)

        If DS.Tables.Count > 0 Then
            If DS.Tables(0).Rows.Count > 0 Then
                txtOrderNo.Text = DS.Tables(0).Rows(0).Item("OrderNumber")
                txtNo.Text = DS.Tables(0).Rows(0).Item("FinancialDocNo")
                txtDate.Text = Format(DS.Tables(0).Rows(0).Item("FinancialDocDate"), "dd/MM/yyyy")
                txtTitle.Text = DS.Tables(0).Rows(0).Item("FinancialDocTitle")

                LoadFinancialDocumentType(DS.Tables(0).Rows(0).Item("FinancialDocTypeId"))
            End If
        End If
    End Sub

    Private Sub LoadFinancialDocumentType(ByVal FinancialDocumentTypeID As Integer)

        Dim DS As DataSet

        DS = DAL.LoadFinancialDocumentType(FinancialDocumentTypeID)
        ' Get The Project Orders Summaries
        If DS.Tables.Count > 0 Then
            ' Budget Summary 
            If DS.Tables(0).Rows.Count > 0 Then
                lblTitle.InnerText = DS.Tables(0).Rows(0).Item("FinancialDocType")
                lblDate.InnerText = DS.Tables(0).Rows(0).Item("FinancialDocType")
                lblNo.InnerText = DS.Tables(0).Rows(0).Item("FinancialDocType")
            End If
        End If
    End Sub

    Private Sub LoadBudgetItems(ByVal ProjectID As Integer, ByVal FinancialDocumentID As Integer)

        Dim tbl As HtmlTable
        Dim BudgetRow As DataRow
        Dim TaskRow As DataRow
        Dim OrderRow As DataRow
        Dim TotAmount As Double
        Dim TotHours As Double
        Dim DS As DataSet

        plcBudgetSummary.Controls.Clear()

        DS = DAL.LoadFinancialDocumentOrderSummaries(ProjectID, FinancialDocumentID)
        ' Get The Financial Document Orders Summaries
        If DS.Tables.Count > 0 Then
            ' Budget Summary 
            If DS.Tables(0).Rows.Count > 0 Then
                tbl = New HtmlTable
                'add the new table to the placeholder
                tbl = BuildTableHeader(tbl)
                plcBudgetSummary.Controls.Add(tbl)
                TotAmount = 0
                TotHours = 0
                For Each BudgetRow In DS.Tables(0).Rows
                    tbl = BuildSummaryTable("Budget", tbl, BudgetRow)
                    TotAmount += BudgetRow.Item("InvoicedAmount")
                Next
                tbl = BuildTableFooter(TotAmount, TotHours, tbl)
            End If
        End If
    End Sub

    Private Function BuildTableHeader(ByVal tbl As HtmlTable)
        tbl.Attributes.Add("width", "100%")
        tbl.CellPadding = 0
        tbl.CellSpacing = 0
        tbl.Border = 0

        'Add the row to the table
        Dim tr As HtmlTableRow = New HtmlTableRow
        tbl.Controls.Add(tr)

        Dim td As HtmlTableCell

        td = New HtmlTableCell("th")
        td = AddCell(td, "50%", "th2", String.Empty, "Budget Item", String.Empty)
        tr.Controls.Add(td)
        td = New HtmlTableCell("th")
        td = AddCell(td, String.Empty, "th2", String.Empty, "Budget", String.Empty)
        tr.Controls.Add(td)

        Return tbl

    End Function

    Private Function BuildTableFooter(ByVal Amount As Double, ByVal Hours As Double, ByVal tbl As HtmlTable)

        Dim txt As TextBox
        Dim tr As HtmlTableRow = New HtmlTableRow
        tbl.Controls.Add(tr)

        Dim td As HtmlTableCell

        td = New HtmlTableCell("td")
        td = AddCell(td, String.Empty, "td1", String.Empty, String.Empty, "<b>Total</b>")
        tr.Controls.Add(td)


        td = New HtmlTableCell("td")
        td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
        txt = New TextBox
        txt.CssClass = "InputROR"
        txt.ReadOnly = True
        txt.Text = String.Format("{0:C}", Convert.ToDecimal(Amount))
        td.Controls.Add(txt)
        tr.Controls.Add(td)

        Return tbl

    End Function

    Private Function BuildSummaryTable(ByVal Type As String, ByVal tbl As HtmlTable, ByVal RowData As DataRow) As HtmlTable

        Dim td As HtmlTableCell
        Dim txt As TextBox
        Dim img As HtmlImage
        Dim imgOrder As HtmlImage
        Dim imgInvoice As HtmlImage

        'Add the row to the table
        Dim tr As HtmlTableRow = New HtmlTableRow
        tbl.Controls.Add(tr)

        td = New HtmlTableCell("td")
        td = AddCell(td, String.Empty, "td1", String.Empty, RowData.Item("ItemName"), String.Empty)
        tr.Controls.Add(td)

        td = New HtmlTableCell("td")
        td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
        txt = New TextBox
        txt.CssClass = "InputR"
        txt.ID = "txt" & RowData.Item("OrderItemID")
        txt.Text = String.Format("{0:C}", Convert.ToDecimal(RowData.Item("InvoicedAmount")))
        td.Controls.Add(txt)
        tr.Controls.Add(td)

        Return tbl

    End Function

    Private Function AddCell(ByVal td As HtmlTableCell, ByVal width As String, ByVal cssclass As String, ByVal align As String, ByVal text As String, ByVal html As String)
        If width <> "" Then
            td.Attributes.Add("Width", width)
        End If
        If cssclass <> "" Then
            td.Attributes.Add("class", cssclass)
        End If
        If align <> "" Then
            td.Attributes.Add("align", align)
        End If
        If text <> "" Then
            td.InnerText = text
        End If
        If html <> "" Then
            td.InnerHtml = html
        End If

        Return td
    End Function

#End Region

End Class
