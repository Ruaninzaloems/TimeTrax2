Public Class FinancialDocument
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents dgAwaitingApproval As System.Web.UI.WebControls.DataGrid
    Protected WithEvents financialDocPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancel As System.Web.UI.WebControls.Button
    Protected WithEvents plcManagerMonitor As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtManagerMonitorComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSubmitManagerMonitor As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancelManagerMonitor As System.Web.UI.WebControls.Button
    Protected WithEvents hidApprovalTypeSubmited As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents tblTeamleader As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents tblMonitor As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents divTeamleader As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents divMonitor As System.Web.UI.HtmlControls.HtmlGenericControl

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
#End Region

#Region " PAGE DECLARES "
    Dim ForDate As DateTime

    Dim DS As DataSet
    Dim count As Integer
    Dim Stage1ApprovalsOutstanding As Int16

    Dim Level1row As DataRow
    Dim Level2row As DataRow
    Dim Level3row As DataRow
    Dim Level4row As DataRow

    Dim row As HtmlTableRow = New HtmlTableRow
    Dim cell As HtmlTableCell = New HtmlTableCell
    Dim menucount As Integer = 0

    Dim FirstLevelRow As HtmlTableRow = New HtmlTableRow
    Dim FirstLevelCell As HtmlTableCell = New HtmlTableCell
    Dim tbltime As HtmlTable = New HtmlTable
    Dim Table As HtmlTable = New HtmlTable
    Dim img As HtmlImage
    Dim chk As HtmlInputCheckBox
    Dim lit As LiteralControl
    Dim spanlit As HtmlGenericControl

    Dim SecondLevelRow As HtmlTableRow = New HtmlTableRow
    Dim SecondLevelCell As HtmlTableCell = New HtmlTableCell
    Dim rdo As RadioButtonList
    Dim rdoitem As ListItem
    Dim hid As HtmlInputHidden = New HtmlInputHidden

    Dim SavLevel3ID As String = ""
    Dim hidBoxids As HtmlInputHidden
    Dim hidBoxfirstapprovals As HtmlInputHidden
    Dim strValue As String
    Dim strValue2 As String

    Dim UserID As Int16
    Dim UsrArrayL As New ArrayList

    Private Enum ApprovalType
        Teamleader = 1
        Manager = 2
        ManagerMonitor = 3
    End Enum
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "70"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Approval"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Approval (Financial Documents)"
            LoadFinancialDocumentsAwaitingApprovalAlert()
            LoadData()
        End If
    End Sub

    Private Sub LoadFinancialDocumentsAwaitingApprovalAlert()

        dgAwaitingApproval.DataSource = DAL.GetFinancialDocumentsAwaitingApproval(User.Identity.Name, Request.ApplicationPath)
        dgAwaitingApproval.DataBind()

    End Sub

    Private Sub LoadData()

        Dim enuApprovalType As ApprovalType

        If Request.QueryString("ApprovalLevel") = 1 Then
            enuApprovalType = ApprovalType.Teamleader
        Else
            enuApprovalType = ApprovalType.ManagerMonitor
        End If

        DS = New DataSet

        DS = DAL.SelectFinancialDocument(Request.QueryString("FinancialDocID"))
        LoadFinancialDocumentForApproval(DS, enuApprovalType)

    End Sub

    Private Sub LoadFinancialDocumentForApproval(ByVal DS As DataSet, ByVal enuApprovalType As ApprovalType)

        If DS.Tables.Count > 0 Then
            If DS.Tables(0).Rows.Count > 0 Then
                If enuApprovalType = ApprovalType.Teamleader Then
                    tblTeamleader.Rows.Clear()
                    AddHeaderRow(tblTeamleader)
                    AddDocumentRow(tblTeamleader, DS.Tables(0).Rows(0))
                    divMonitor.Visible = False
                ElseIf enuApprovalType = ApprovalType.ManagerMonitor Then
                    tblMonitor.Rows.Clear()
                    AddHeaderRow(tblMonitor)
                    AddDocumentRow(tblMonitor, DS.Tables(0).Rows(0))
                    divTeamleader.Visible = False
                End If
            End If
        End If

    End Sub


    Private Sub AddHeaderRow(ByVal table As HtmlTable)

        Dim row As HtmlTableRow = New HtmlTableRow

        table.Rows.Clear()

        '<tr>
        row = New HtmlTableRow
        table.Rows.Add(row)
        ' <td></td>
        CreateHeaderCell(row, "&nbsp;", "4%")
        ' <td></td>
        CreateHeaderCell(row, "&nbsp;", "4%")
        ' <td>Title</td>
        CreateHeaderCell(row, "Title", "30%")
        ' <td>Date</td>
        CreateHeaderCell(row, "Date", "15%")
        ' <td>Amount</td>
        CreateHeaderCell(row, "Amount", "19%")
        ' <td>Approval</td>
        CreateHeaderCell(row, "Approval", "14%")
        '' <td>Reject</td>
        'CreateHeaderCell(row, "Reject", "14%")

        'Add the header row to the table
        table.Rows.Add(row)

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

    Private Sub AddDocumentRow(ByVal table As HtmlTable, ByVal dr As DataRow)

        Dim row As HtmlTableRow = New HtmlTableRow
        Dim cell As HtmlTableCell
        Dim image As HtmlImage = New HtmlImage
        Dim strExt As String

        strExt = dr.Item("DocURL").ToString.Substring(dr.Item("DocURL").ToString.Length - 4, 4)

        'Add the Image Cell
        CreateImageCell(cell, strExt, dr.Item("DocURL"))
        row.Cells.Add(cell)

        CreateViewCell(cell, "../Project/ViewFinancialDocument.aspx?ProjectID=" & dr.Item("ProjectID") & "&FinancialDocumentID=" & dr.Item("FinancialDocID"), dr.Item("FinancialDocTitle"))
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

        'Add the Approve/Reject cell
        CreateRadioButtonCell(cell, "rdoApprove", dr.Item("UploadedByUserID"))
        row.Cells.Add(cell)

        'Add the row to the table
        table.Rows.Add(row)

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

    Private Sub CreateViewCell(ByRef cell As HtmlTableCell, ByVal strUrl As String, ByVal strDocTitle As String)

        Dim img As New HtmlControls.HtmlImage

        cell = New HtmlTableCell("td")
        cell.Attributes.Add("class", "td1")

        img.Attributes.Add("onclick", "javascript: openDocumentPage('" & strUrl & "');")
        img.Alt = "View Financial Document Details"
        img.Attributes.Add("style", "cursor:hand")
        img.Src = Request.ApplicationPath & "\images\order.gif"
        cell.Controls.Add(img)

        Dim hid As New HtmlControls.HtmlInputHidden
        hid.ID = "hidDocTitle"
        hid.Value = strDocTitle
        cell.Controls.Add(hid)

    End Sub

    Private Sub CreateRadioButtonCell(ByRef cell As HtmlTableCell, ByVal ID As String, ByVal UploadedByUserID As Integer)

        cell = New HtmlTableCell("td")
        cell.Attributes.Add("class", "td1")

        rdo = New RadioButtonList
        SecondLevelCell.Controls.Add(rdo)
        rdo.Attributes.Add("class", "label")
        rdo.ID = "rdoApprove"
        rdo.TextAlign = TextAlign.Right
        rdo.RepeatDirection = RepeatDirection.Horizontal

        rdoitem = New ListItem
        rdo.Items.Add(rdoitem)
        rdoitem.Value = 1
        rdoitem.Text = "Approve"
        rdoitem.Selected = True

        rdoitem = New ListItem
        rdo.Items.Add(rdoitem)
        rdoitem.Value = 0
        rdoitem.Text = "Reject"

        cell.Controls.Add(rdo)

        'Add a hidden control for storing the userid
        Dim hid As New HtmlInputHidden
        hid.ID = "hidUploadedByUserID"
        hid.Value = UploadedByUserID
        cell.Controls.Add(hid)

    End Sub


#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        ' Insert TT_Approvals Entries
        Dim arrData, ItemData As Array
        Dim strComment As String
        Dim blnApproved As Boolean

        'Determine which approvals have been submitted
        If hidApprovalTypeSubmited.Value = "TeamLeader" Then
            strComment = txtComment.Text
        Else
            strComment = txtManagerMonitorComment.Text
        End If

        If Request.Form("rdoApprove") = 1 Then
            blnApproved = True
        Else
            blnApproved = False
        End If

        ' Insert the Approval Record
        DAL.InsertApproval(Common.ApprovalType.FinancialDocument, User.Identity.Name, Request.QueryString("FinancialDocID"), strComment, blnApproved)
        If blnApproved Then
            SendApprovedEmail(Request.QueryString("FinancialDocTypeID"))
        Else
            SendRejectedEmail(Request.Form("hidUploadedByUserID"))
        End If

        LoadFinancialDocumentsAwaitingApprovalAlert()

    End Sub

    Private Sub SendRejectedEmail(ByVal UserID As String)
        ' Get the User email addresses and send email notifying them that they have rejected timesheet items
        Dim i As Int16
        Dim email As String
        Dim Subject As String
        Dim Priority As Mail.MailPriority = Mail.MailPriority.Normal
        Dim strBody As String

        If UserID <> 0 Then
            ' User Email Exists
            email = Common.GetEmailForUser(UserID)

            ' Send email to the user that has just been added,
            strBody = "<font face=Arial size=2>Financial Document " & Request.Form("hidDocTitle") & " has been rejected." & vbCrLf & _
                      "<br><br>You may access the system at the following url: <a href=" & ConfigurationSettings.AppSettings("WebAddress") & ">" & _
                      ConfigurationSettings.AppSettings("WebAddress") & "</a></font>"
            Subject = "TimeTraX - Rejected Financial Document"
            WebMails.TrySendMail(email, Subject, strBody, Mail.MailPriority.Normal, "")
        End If
           
    End Sub

    Private Sub SendApprovedEmail(ByVal FinancialTypeDocID As String)
        ' Get the User email addresses and send email notifying them that they have rejected timesheet items
        Dim Subject As String
        Dim Priority As Mail.MailPriority = Mail.MailPriority.Normal
        Dim strBody As String
        Dim DR As SqlDataReader

        If FinancialTypeDocID <> 0 Then
            ' Send email to the user that has just been added,
            strBody = "<font face=Arial size=2>Financial Document " & Request.Form("hidDocTitle") & " has been approved." & vbCrLf & _
                      "<br><br>You may access the system at the following url: <a href=" & ConfigurationSettings.AppSettings("WebAddress") & ">" & _
                      ConfigurationSettings.AppSettings("WebAddress") & "</a></font>"
            Subject = "TimeTraX - Approved Financial Document"

            DR = DAL.GetEmailForFinancialDocType(FinancialTypeDocID)
            While DR.Read
                WebMails.TrySendMail(DR.Item("Email"), Subject, strBody, Mail.MailPriority.Normal, "")
            End While
        End If

    End Sub



#End Region


End Class
