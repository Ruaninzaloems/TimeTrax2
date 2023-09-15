Public Class FinancialDocuments
    Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents tblFinancialDocuments As System.Web.UI.HtmlControls.HtmlTable

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        LoadFinancialDocuments()
    End Sub

#Region "PUBLIC VARIABLES"
    Public Shared ProjectID As Integer
#End Region

#Region "Loading Documents Grid"
    'Retrieves the documents for this projects and displays them in the documents datagrid
    Private Sub LoadFinancialDocuments()

        Dim ds As DataSet
        Dim intCount As Int32

        ds = DAL.LoadFinancialDocuments(ProjectID)

        Dim row As HtmlTableRow = New HtmlTableRow

        AddHeaderRow()

        If Not ds Is Nothing Then
            For intCount = 0 To ds.Tables(0).Rows.Count - 1
                'Build the html for each row document row returned
                AddDocumentRow(ds.Tables(0).Rows(intCount), ProjectID)
            Next
        End If

    End Sub

    Private Sub AddHeaderRow()

        Dim row As HtmlTableRow = New HtmlTableRow

        tblFinancialDocuments.Rows.Clear()

        '<tr>
        row = New HtmlTableRow
        tblFinancialDocuments.Rows.Add(row)
        ' <td></td>
        CreateHeaderCell(row, "", "4%")
        ' <td></td>
        CreateHeaderCell(row, "", "4%")
        ' <td>Title</td>
        CreateHeaderCell(row, "Title", "30%")
        ' <td>Date</td>
        CreateHeaderCell(row, "Date", "21%")
        ' <td>Amount</td>
        CreateHeaderCell(row, "Amount", "25%")
        ' <td>Size</td>
        CreateHeaderCell(row, "Size (KB)", "16%")
        
        'Add the header row to the table
        tblFinancialDocuments.Rows.Add(row)

    End Sub

    Private Sub CreateHeaderCell(ByRef row As HtmlTableRow, _
                                 ByVal strText As String, _
                                 ByVal strWidth As String)

        Dim cell As HtmlTableCell = New HtmlTableCell

        cell = New HtmlTableCell("th")
        cell.InnerHtml = strText
        cell.Width = strWidth
        cell.Attributes.Add("class", "th2")
        row.Cells.Add(cell)

    End Sub

    Private Sub AddDocumentRow(ByVal dr As DataRow, ByVal ProjectID As Integer)

        Dim row As HtmlTableRow = New HtmlTableRow
        Dim cell As HtmlTableCell
        Dim image As HtmlImage = New HtmlImage
        Dim strExt As String

        strExt = dr.Item("DocURL").ToString.Substring(dr.Item("DocURL").ToString.Length - 4, 4)

        'Add the Image Cell
        CreateImageCell(cell, strExt, dr.Item("DocURL"))
        row.Cells.Add(cell)

        CreateViewCell(cell, "../Project/ViewFinancialDocument.aspx?ProjectID=" & ProjectID & "&FinancialDocumentID=" & dr.Item("FinancialDocID"))
        row.Cells.Add(cell)

        'Add the Title
        CreateDocumentCell(cell, "<a href=" & dr.Item("DocURL") & " Target='_blank'>" & dr.Item("FinancialDocTitle") & "</a>", "Left")
        row.Cells.Add(cell)

        'Add the date
        CreateDocumentCell(cell, dr.Item("FinancialDocDate"), "Left")
        row.Cells.Add(cell)

        'Add the Amount
        CreateDocumentCell(cell, String.Format("{0:C}", Convert.ToDecimal(dr.Item("Amount"))), "Right")
        row.Cells.Add(cell)

        'Add the Size
        CreateDocumentCell(cell, dr.Item("FileSize"), "Right")
        row.Cells.Add(cell)

        'Add the row to the table
        tblFinancialDocuments.Rows.Add(row)

    End Sub

    Private Sub CreateDocumentCell(ByRef cell As HtmlTableCell, ByVal strText As String, ByVal Align As String)

        cell = New HtmlTableCell("td")
        cell.Attributes.Add("class", "td1")
        cell.Align = Align

        If strText.Trim.Length <> 0 Then
            cell.InnerHtml = strText
        End If

    End Sub

    Private Sub CreateImageCell(ByRef cell As HtmlTableCell, ByVal Ext As String, ByVal strUrl As String)

        Dim img As New HtmlControls.HtmlImage

        cell = New HtmlTableCell("td")
        cell.Attributes.Add("class", "td1")

        If Ext <> String.Empty Then
            Select Case Ext.ToUpper
                Case ".JPG"
                    img.Src = Request.ApplicationPath & "\images\jpg.gif"
                Case ".PDF"
                    img.Src = Request.ApplicationPath & "\images\pdf.gif"
                Case ".ZIP"
                    img.Src = Request.ApplicationPath & "\images\zip.gif"
                Case ".DOC", ".DOCX"
                    img.Src = Request.ApplicationPath & "\images\doc.gif"
                Case ".XLS", ".XLSX"
                    img.Src = Request.ApplicationPath & "\images\xls.gif"
                Case ".TIF"
                    img.Src = Request.ApplicationPath & "\images\tif.gif"
                Case ".BMP"
                    img.Src = Request.ApplicationPath & "\images\bmp.gif"
                Case Else
                    img.Src = Request.ApplicationPath & "\images\Detail.gif"
            End Select

            img.Attributes.Add("onclick", "javascript: openDocumentPage('" & strUrl & "');")
            img.Alt = "View Financial Document"
            img.Attributes.Add("style", "cursor:hand")
            cell.Controls.Add(img)
        End If
    End Sub

    Private Sub CreateViewCell(ByRef cell As HtmlTableCell, ByVal strUrl As String)

        Dim img As New HtmlControls.HtmlImage

        cell = New HtmlTableCell("td")
        cell.Attributes.Add("class", "td1")

        img.Attributes.Add("onclick", "javascript: openDocumentPage('" & strUrl & "');")
        img.Alt = "View Financial Document Details"
        img.Attributes.Add("style", "cursor:hand")
        img.Src = Request.ApplicationPath & "\images\order.gif"
        cell.Controls.Add(img)

    End Sub

#End Region



End Class
