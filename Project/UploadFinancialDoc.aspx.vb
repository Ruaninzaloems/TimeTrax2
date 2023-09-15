Imports System.IO
Imports Intermap.Controls

Public Class UploadFinancialDoc
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents rfvUpload As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents Validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents lblResults As System.Web.UI.WebControls.Label
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents txtUpload As System.Web.UI.HtmlControls.HtmlInputFile
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents hidAppPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidDate As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidTitle As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidSize As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidFileName As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidUploadsPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidError As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents txtOrderNo As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtNo As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvNumber As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
    Protected WithEvents lblNo As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents lblDate As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents lblUpload As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents plcBudgetSummary As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtTitle As System.Web.UI.WebControls.TextBox
    Protected WithEvents lblTitle As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents hidBudgetList As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidProjectID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidFinDoc As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidFinDocID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidAmount As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents btnUpload As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents hidApprovalRequired As System.Web.UI.HtmlControls.HtmlInputHidden

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

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "2"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("ProjectID") = Request.QueryString("ProjID")
            ' Show Upload Document Section
            tblwizard1.Visible = True
            ' Show Results Section
            tblwizard2.Visible = False
            Session("PageType") = "Upload"
            Session("PageTitle") = Session("AppName") & " - Document Upload"
            LoadOrderInfo(Request.QueryString("OrderID"))
            LoadBudgetItems(Request.QueryString("ProjectID"))
            LoadFinancialDocumentType(Request.QueryString("FinancialDocumentTypeID"))
        Else
            ' Upload Document Section
            tblwizard1.Visible = False
            ' Upload Results Section
            tblwizard2.Visible = True
        End If

        'Set the application path
        hidAppPath.Value = Request.ApplicationPath
        hidUploadsPath.Value = ConfigurationSettings.AppSettings("UploadsVirtual")
        hidProjectID.Value = Request.QueryString("ProjectID")
    End Sub

    Private Sub LoadOrderInfo(ByVal OrderID As Integer)

        Dim DS As DataSet
        
        plcBudgetSummary.Controls.Clear()

        DS = DAL.LoadOrderInfo(OrderID)
        ' Get The Project Orders Summaries
        If DS.Tables.Count > 0 Then
            ' Budget Summary 
            If DS.Tables(0).Rows.Count > 0 Then
                txtOrderNo.Text = DS.Tables(0).Rows(0).Item("OrderNumber")
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

                If DS.Tables(0).Rows(0).Item("ApprovalRequired") = True Then
                    btnUpload.Value = "Upload Document and Submit for Approval"
                    hidApprovalRequired.Value = 1
                Else
                    btnUpload.Value = "Upload Document"
                    hidApprovalRequired.Value = 0
                End If
            End If
        End If
    End Sub

    Private Sub LoadBudgetItems(ByVal ProjectID As Integer)

        Dim tbl As HtmlTable
        Dim BudgetRow As DataRow
        Dim TaskRow As DataRow
        Dim OrderRow As DataRow
        Dim TotAmount As Double
        Dim TotHours As Double
        Dim DS As DataSet
        Dim strList As String = String.Empty

        plcBudgetSummary.Controls.Clear()

        DS = DAL.LoadProjectOrderSummaries(ProjectID)
        ' Get The Project Orders Summaries
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
                    TotAmount += BudgetRow.Item("Amount")
                    strList += "#" & BudgetRow.Item("OrderItemID")
                Next
                tbl = BuildTableFooter(TotAmount, TotHours, tbl)
                hidBudgetList.Value = strList.Substring(1)
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
        txt.ID = "txtTotalBudget"
        txt.ReadOnly = True
        'txt.Text = String.Format("{0:C}", Convert.ToDecimal(Amount))
        txt.Text = "0"
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
        txt.Attributes.Add("onblur", "ValidateDisplayDecimal(this);calcBudgetTotal();")
        txt.ID = "txtBud" & RowData.Item("OrderItemID")
        txt.Text = "0"
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

#Region " UPLOAD DOCUMENT CODE "

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim objStream As Stream = txtUpload.PostedFile.InputStream
        Dim intFinancialDocumentID As Integer
        Try
            Dim strExt As String
            Dim strpath As String
            strpath = txtUpload.PostedFile.FileName
            strExt = Path.GetExtension(strpath)
            Dim strFileName As String
            Dim strBaseDir As String = Server.MapPath(Request.ApplicationPath & "/" & ConfigurationSettings.AppSettings("UploadsVirtual"))

            'Determine the file type
            If (strExt.ToUpper = ".PDF") Then
                If (objStream.Length < 2000000) Then

                    Dim DR1 As SqlDataReader
                    Dim arParms1() As SqlParameter = New SqlParameter(1) {}
                    arParms1(0) = New SqlParameter("@OrderID", CInt(Request.QueryString("OrderID")))
                    arParms1(1) = New SqlParameter("@DocNo", txtNo.Text)

                    DR1 = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectFinancialDocumentFileName", arParms1)

                    If DR1.Read Then
                        strFileName = DR1.Item("FileName")
                    End If
                    DR1.Close()

                    'Load the Last Financial Document number
                    Dim arParms() As SqlParameter = New SqlParameter(0) {}
                    Dim intOrderID As Integer

                    intOrderID = CInt(Request.QueryString("OrderID"))
                    arParms(0) = New SqlParameter("@OrderID", intOrderID)

                    ' Execute the stored procedure
                    DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectLastFinancialDocumentNo", arParms)

                    ''Build the file name
                    If DR.Read() Then
                        Dim docNo As Int32 = DR.Item("DocNo")
                        If docNo < 9 Then
                            docNo = docNo + 1
                            strFileName = Replace(strFileName, " ", "") & "_doc00" & docNo & strExt
                        ElseIf docNo > 8 And docNo < 99 Then
                            docNo = docNo + 1
                            strFileName = Replace(strFileName, " ", "") & "_doc0" & docNo & strExt
                        Else
                            docNo = docNo + 1
                            strFileName = Replace(strFileName, " ", "") & "_doc" & docNo & strExt
                        End If
                    Else
                        strFileName = Replace(strFileName, " ", "") & "_doc001" & strExt
                    End If
                    DR.Close()

                    'Add the rest of the upload path
                    strBaseDir &= "\Documents\"
                    'Trace.Warn("Upload Base Dir", strBaseDir)

                    'Trace.Warn("Upload full Path", strBaseDir & strFileName)
                    txtUpload.PostedFile.SaveAs(strBaseDir & strFileName)
                    'Trace.Warn("Uploaded", "File is Uploaded")

                    'Write the details into the database
                    '****************************************************************************************************************
                    Dim arParms2() As SqlParameter = New SqlParameter(8) {}
                    Dim DR2 As SqlDataReader

                    'Add values to the parameter array
                    arParms2(0) = New SqlParameter("@OrderID", intOrderID)
                    arParms2(1) = New SqlParameter("@FinancialDocNo", txtNo.Text)
                    arParms2(2) = New SqlParameter("@FinancialDocDate", System.DateTime.ParseExact(txtDate.Text, "dd/MM/yyyy", en))
                    arParms2(3) = New SqlParameter("@FinancialDocTypeID", CInt(Request.QueryString("FinancialDocumentTypeID")))
                    arParms2(4) = New SqlParameter("@FinancialDocumentName", strFileName)
                    arParms2(5) = New SqlParameter("@FinancialDocTitle", txtTitle.Text)
                    arParms2(6) = New SqlParameter("@FileSize", objStream.Length)
                    arParms2(7) = New SqlParameter("@ApprovalRequired", hidApprovalRequired.Value)
                    arParms2(8) = New SqlParameter("@UserID", User.Identity.Name)

                    ' Execute the stored procedure
                    DR2 = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_InsertFinancialDocument", arParms2)
                    'Trace.Warn("DB", "Record in DB")

                    If DR2.Read Then
                        intFinancialDocumentID = DR2.Item("FinancialDocumentID")
                        hidFinDocID.Value = intFinancialDocumentID
                    End If

                    If SaveBudgetItems(CInt(Request.QueryString("ProjectID")), intFinancialDocumentID) Then

                        lblResults.Text = "<b>Success<br><br>The document has been successfully uploaded.<br>(Uploaded File size: <font color=red>" & objStream.Length & "</font> bytes)</b>"

                        'Indicate that the upload was successful
                        hidError.Value = 0
                    Else
                        CleanUpFinDoc(intFinancialDocumentID)
                        lblResults.Text = "<b>Error<br><br>Unable to save the Budget Items.<br>Please <a href='#' onclick='javascript:history.back();'>try again</a></b>"
                    End If
                Else
                        lblResults.Text = "<b>Error<br><br>File is bigger than the maximum of 2000000 bytes (2Mb).<br>(Uploaded File size: <font color=red>" & objStream.Length & "</font> bytes)<br><br>Please <a href='#' onclick='javascript:history.back();'>try again</a></b>"
                    End If
                Else
                lblResults.Text = "<b>Error<br><br>File is not a .pdf.<br>(Uploaded File size: <font color=red>" & objStream.Length & "</font> bytes)<br><br>Please <a href='#' onclick='javascript:history.back();'>try again</a></b>"
            End If

            'Set the hidden fields
            hidDate.Value = Format("dd/MM/yyyy", txtDate.Text)
            hidTitle.Value = txtTitle.Text
            hidSize.Value = objStream.Length
            hidFileName.Value = strFileName
            hidAmount.Value = Request.Form("txtTotalBudget")

        Catch Ex As Exception
            CleanUpFinDoc(intFinancialDocumentID)
            lblResults.Text = "<b>Error<br><br>There has been an unresolved error with the document upload.<br><br>Please <a href='#' onclick='javascript:history.back();'>try again</a></b>"
            Exit Try
        End Try
    End Sub

    Private Function SaveBudgetItems(ByVal ProjectID As Integer, ByVal FinancialDocumentID As Integer) As Boolean

        Dim BudgetRow As DataRow
        Dim DS As DataSet
        Dim intCount As Integer

        Try

            DS = DAL.LoadProjectOrderSummaries(ProjectID)

            ' Get The Project Orders Summaries
            If DS.Tables.Count > 0 Then
                For intCount = 0 To DS.Tables(0).Rows.Count - 1
                    If Request.Form("txtBud" & DS.Tables(0).Rows(intCount).Item("OrderItemID")) > 0 Then
                        Dim arParms() As SqlParameter = New SqlParameter(2) {}

                        arParms(0) = New SqlParameter("@FinancialDocumentID", FinancialDocumentID)
                        arParms(1) = New SqlParameter("@OrderItemID", DS.Tables(0).Rows(intCount).Item("OrderItemID"))
                        arParms(2) = New SqlParameter("@Amount", Request.Form("txtBud" & DS.Tables(0).Rows(intCount).Item("OrderItemID")))

                        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_InsertFinancialDocumentOrderItem", arParms)
                        'Trace.Warn("DB", "Record in DB")
                    End If
                Next
            End If

            Return True

        Catch Ex As Exception
            Return False
        End Try
    End Function

    Private Sub CleanUpFinDoc(ByVal FinancialDocumentID As Integer)

        Dim DS As DataSet
        Dim arParms() As SqlParameter = New SqlParameter(0) {}

        arParms(0) = New SqlParameter("@FinancialDocumentID", FinancialDocumentID)

        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_CleanUpFinancialDocument", arParms)

    End Sub
#End Region


End Class
