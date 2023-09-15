Public Class ProjectDocuments
    Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents tblProjectDocuments As System.Web.UI.HtmlControls.HtmlTable

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
        LoadProjectDocuments()
    End Sub

#Region "PUBLIC VARIABLES"
    Public Shared ProjectID As Integer
#End Region

#Region "Loading Documents Grid"
    'SD: /08/09/2005 - Retrieves the documents for this projects and displays them
    'in the documents datagrid
    Private Sub LoadProjectDocuments()

        Dim ds As DataSet
        Dim intCount As Int32

        ds = DAL.LoadProjectDocuments(ProjectID)

        Dim row As HtmlTableRow = New HtmlTableRow

        AddHeaderRow()

        If Not ds Is Nothing Then
            For intCount = 0 To ds.Tables(0).Rows.Count - 1
                'Build the html for each row document row returned
                AddDocumentRow(ds.Tables(0).Rows(intCount))
            Next
        End If

    End Sub

    Private Sub AddHeaderRow()

        Dim row As HtmlTableRow = New HtmlTableRow

        tblProjectDocuments.Rows.Clear()

        '<tr>
        row = New HtmlTableRow
        tblProjectDocuments.Rows.Add(row)
        ' <td></td>
        CreateHeaderCell(row, "", "4%")
        ' <td>Title</td>
        CreateHeaderCell(row, "Title", "46%")
        ' <td>Date</td>
        CreateHeaderCell(row, "Date", "25%")
        ' <td>Size</td>
        CreateHeaderCell(row, "Size (KB)", "25%")
        ' <td>View</td>
        'CreateHeaderCell(row, "View")

        'Add the header row to the table
        tblProjectDocuments.Rows.Add(row)

    End Sub

    Private Sub CreateHeaderCell(ByRef row As HtmlTableRow, _
                                 ByVal strText As String, _
                                 ByVal strWidth As String)

        Dim cell As HtmlTableCell = New HtmlTableCell

        cell = New HtmlTableCell("th")
        cell.InnerHtml = strText
        cell.Width = strwidth
        cell.Attributes.Add("class", "th2")
        row.Cells.Add(cell)

    End Sub

    Private Sub AddDocumentRow(ByVal dr As DataRow)

        Dim row As HtmlTableRow = New HtmlTableRow
        Dim cell As HtmlTableCell
        Dim image As HtmlImage = New HtmlImage
        Dim strExt As String

        strExt = dr.Item("DocURL").ToString.Substring(dr.Item("DocURL").ToString.Length - 4, 4)

        'Add the Image Cell
        CreateImageCell(cell, strExt, dr.Item("DocURL"))
        row.Cells.Add(cell)

        'Add the Title
        CreateDocumentCell(cell, "<a href=" & dr.Item("DocURL") & " Target='_blank'>" & dr.Item("Title") & "</a>", "Left")
        row.Cells.Add(cell)

        'Add the date
        CreateDocumentCell(cell, dr.Item("DocumentDate"), "Left")
        row.Cells.Add(cell)

        'Add the Size
        CreateDocumentCell(cell, dr.Item("DocSize"), "Right")
        row.Cells.Add(cell)

        ''Add the image to open the file
        'CreateDocumentCell(cell, String.Empty)
        'image.Src = "../../images/Detail.gif"
        'image.ID = "imgDetail_" & dr.Item("DocID")
        'image.Attributes.Add("onclick", dr.Item("DocURL"))
        'image.Alt = "View Document"
        'image.Attributes.Add("style", "cursor:hand")
        'cell.Align = "center"
        'cell.Controls.Add(image)
        'row.Cells.Add(cell)

        'Add the row to the table
        tblProjectDocuments.Rows.Add(row)

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
                Case ".DOC"
                    img.Src = Request.ApplicationPath & "\images\doc.gif"
                Case ".XLS"
                    img.Src = Request.ApplicationPath & "\images\xls.gif"
                Case ".TIF"
                    img.Src = Request.ApplicationPath & "\images\tif.gif"
                Case ".BMP"
                    img.Src = Request.ApplicationPath & "\images\bmp.gif"
                Case Else
                    img.Src = Request.ApplicationPath & "\images\Detail.gif"
            End Select

            img.Attributes.Add("onclick", "javascript: openDocumentPage('" & strUrl & "');")
            img.Alt = "View Document"
            img.Attributes.Add("style", "cursor:hand")
            cell.Controls.Add(img)
        End If
    End Sub

#End Region


End Class
