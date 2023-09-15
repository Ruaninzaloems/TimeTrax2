Public Class ExpensesReport
    Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents ReportPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents Printbtn As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents divReportExcel As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents txtHidAppPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents imgPrinterPopup As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents hidUserReportType As System.Web.UI.HtmlControls.HtmlInputHidden

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
    Dim en As New System.Globalization.CultureInfo("en-Za")

    ' Required for Errorhandling
    Protected WithEvents ucHeader As TimeTrax.header
    Dim strStatus As String
    Dim strErr As String
    Dim strMess As String

#End Region

#Region "Public Variables"

    Public Shared ProjectID As Integer
    Public Shared StartDate As String
    Public Shared EndDate As String
    Public Shared Users As String
    Public Shared Shadows ClientID As Integer
    Public Shared CaptureTypeID As Integer
    Public Shared ExpenseMonth As String
    Public Shared ShowReport As Boolean = False
    Public Shared ShowExport As Boolean = True
    Public Shared ShowPrint As Boolean = True       'This is used for using print special - ie. has to remove headers etc
    Public Shared ShowPrintPopup As Boolean = True  'This is used for when you can just print the page as is

#End Region

#Region " PAGE DECLARES "

    Dim DS As DataSet

    Dim ClientRow As DataRow
    Dim ProjectRow As DataRow
    Dim UserRow As DataRow
    Dim ExpenseRow As DataRow

    Dim tblRep As HtmlTable
    Dim tblReprow As HtmlTableRow
    Dim tblRepcell As HtmlTableCell

    Dim FirstLevelRow As HtmlTableRow
    Dim FirstLevelCell As HtmlTableCell

#End Region

    'SD: 19/10/2005 - I've now learnt about the printer.js file and printSpecial.  I could have used that instead of doing the user control
    'It however is currently not worth the effort of changing to the printSpecial as this does work

#Region "Loading"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        If Not IsPostBack Then
            If ShowReport Then
                divReportExcel.Visible = True
            Else
                divReportExcel.Visible = False
            End If
        Else
            divReportExcel.Visible = True
        End If

        If ShowExport Then
            imgExport.Visible = True
        Else
            imgExport.Visible = False
        End If

        If ShowPrint Then
            Printbtn.Visible = True
        Else
            Printbtn.Visible = False
        End If

        If ShowPrintPopup Then
            imgPrinterPopup.Visible = True
        Else
            imgPrinterPopup.Visible = False
        End If

        'Set the app path - used for the printer window
        txtHidAppPath.Value = Request.ApplicationPath
    End Sub

#Region "Standard Report Layout"

    Private Sub BuildHtmlTable()

        Dim decExpenseUserTotal As Decimal

        ReportPlace.Controls.Clear()

        tblRep = New HtmlTable
        tblRep.Attributes.Add("class", "tableReport%")
        tblRep.Attributes.Add("width", "100%")
        tblRep.Border = 1
        ReportPlace.Controls.Add(tblRep)

        ' Build Header Row Table
        BuildHeaderRow(tblRep)

        For Each ClientRow In DS.Tables("Client").Rows
            'For Each Client

            '	<TR>
            ' 	<TH class="th4"  colspan=9>
            tblReprow = New HtmlTableRow
            tblRep.Rows.Add(tblReprow)
            tblRepcell = New HtmlTableCell("th")
            tblReprow.Cells.Add(tblRepcell)
            tblRepcell.Attributes.Add("class", "th4")
            tblRepcell.ColSpan = 9

            'Add Client Row
            AddClientRow()

            For Each ProjectRow In ClientRow.GetChildRows("Client_Project")
                'Add Project Row
                AddProjectRow()

                For Each UserRow In ProjectRow.GetChildRows("Project_User")
                    'Add User Row
                    AddUserRow()

                    decExpenseUserTotal = 0

                    For Each ExpenseRow In UserRow.GetChildRows("User_Expense")
                        'Add Expense Row
                        AddExpenseRow()
                        decExpenseUserTotal = decExpenseUserTotal + ExpenseRow.Item("Cost")

                    Next 'Expense

                    AddTotalRow(decExpenseUserTotal)

                Next 'User
            Next 'Project

            'Add <HR>
            AddLine()

        Next 'Client

    End Sub

#Region "Add Rows"

    Private Function BuildHeaderRow(ByVal RepTable As HtmlTable)
        '         <TR>
        '           <TH>Client</TH>
        '           <TH>Project</TH>
        '           <TH>User</TH>
        '           <TH>Date</TH>
        '           <TH>Type</TH>
        '           <TH>Quantity</TH>
        '           <TH>Rate</TH>
        '           <TH>Expense</TH>
        '           <TH>Comment</TH>
        '         </TR>


        FirstLevelRow = New HtmlTableRow
        RepTable.Controls.Add(FirstLevelRow)
        ' Add header cells here

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "5%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Client"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "5%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Project"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "5%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "User"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "15%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Date"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "10%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Type"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "5%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Quantity"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "10%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Rate"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "15%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Expense"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "25%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Comment"

    End Function


    Private Sub AddTotalRow(ByVal decTotal As Decimal)

        Dim TotalCell As HtmlTableCell

        'Add Total Row
        '<TR>
        '   <TD width="5%">
        '   <TD width="5%">
        '   <TD width="5%">
        '   <TD colspan=5>Total
        '   <TD>
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 2)

        '"Total"
        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.ColSpan = 5
        TotalCell.InnerText = "Total"
        TotalCell.Attributes.Add("class", "tdreportTotal")

        'Expense Total
        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.InnerText = decTotal
        TotalCell.Attributes.Add("align", "right")
        TotalCell.InnerHtml = String.Format("{0:C}", decTotal)
        TotalCell.Attributes.Add("class", "tdreportTotal")

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 1)

    End Sub

    Private Sub AddClientRow()
        Dim ClientCell As HtmlTableCell

        '<TR>
        '   <TD colspan=9>Client Name
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Client Name
        ClientCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(ClientCell)
        ClientCell.ColSpan = 9
        ClientCell.InnerText = ClientRow.Item("ClientName")
        ClientCell.Attributes.Add("class", "tdreportTotal")
    End Sub

    Private Sub AddLine()

        Dim LineCell As New HtmlTableCell("td")
        Dim liter As New Literal

        '<TR>
        '   <TD colspan=11>Client Name
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Line
        tblReprow.Cells.Add(LineCell)
        LineCell.ColSpan = 11
        LineCell.InnerText = " "
        LineCell.Attributes.Add("class", "td")

        LineCell.Controls.Add(liter)
        liter.Text = "<HR>"
    End Sub

    Private Sub AddProjectRow()

        Dim ProjectCell As HtmlTableCell

        'For Each Project
        '<TR>
        '   <TD width="5%">
        '   <TD width="5%">
        '   <TD colspan=4>Project Name
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 1)

        'Project Name
        ProjectCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(ProjectCell)
        ProjectCell.ColSpan = 8
        ProjectCell.InnerText = ProjectRow.Item("ProjectName")
        ProjectCell.Attributes.Add("class", "td")

    End Sub

    Private Sub AddUserRow()

        Dim UserCell As HtmlTableCell

        'Add User Row
        '<TR>
        '   <TD width="5%">
        '   <TD width="5%">
        '   <TD width="5%">
        '   <TD colspan=3>User Name
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 2)

        'Project Name
        UserCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(UserCell)
        UserCell.ColSpan = 7
        UserCell.InnerText = UserRow.Item("UserName")
        UserCell.Attributes.Add("class", "td")

    End Sub

    Private Sub AddExpenseRow()
        'Add Expense Row
        '<TR>
        '   <TD width="5%">
        '   <TD width="5%">
        '   <TD width="5%">
        '   <TD width="5%">
        '   <TD>Date
        '   <TD>Expense Type
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 3)

        'Date 
        AddExpenseCell(tblReprow, "txtDate")

        'Expense Type
        AddExpenseCell(tblReprow, "Type")

        'Quantity
        AddExpenseCell(tblReprow, "Quantity")

        'Rate
        AddExpenseCell(tblReprow, "Rate")

        'Cost
        AddExpenseCell(tblReprow, "Cost")

        'Comment
        AddExpenseCell(tblReprow, "Comment")
    End Sub

#End Region

#Region "Add Cells"

    Private Sub AddExpenseCell(ByVal tableRow As HtmlTableRow, ByVal strColName As String)

        Dim ExpenseCell As New HtmlTableCell("td")

        If strColName.ToUpper = "COST" Then
            tblReprow.Cells.Add(ExpenseCell)
            ExpenseCell.Attributes.Add("align", "right")
            ExpenseCell.InnerHtml = String.Format("{0:C}", Convert.ToDecimal(ExpenseRow.Item(strColName)))
            ExpenseCell.Attributes.Add("class", "tdreport")
            ExpenseCell.ColSpan = 1
        Else
            tblReprow.Cells.Add(ExpenseCell)
            ExpenseCell.Attributes.Add("align", "left")
            ExpenseCell.InnerText = IIf(ExpenseRow.Item(strColName) Is DBNull.Value, "&nbsp;", ExpenseRow.Item(strColName))
            ExpenseCell.Attributes.Add("class", "tdreport")
            ExpenseCell.ColSpan = 1
        End If
    End Sub

#End Region

    Public Sub LoadProjectDetails()
        Dim dr1 As DataRelation
        Dim dr2 As DataRelation
        Dim dr3 As DataRelation
        Dim StartDt As String
        Dim EndDt As String

        DS = New DataSet

        'DS = DAL.ReportExpenses(Request.Form("ucReportFilters:ddlProject"), _
        '                        System.DateTime.ParseExact(Request.Form("ucReportFilters:txtStartDate"), "dd/MM/yyyy", en), _
        '                        System.DateTime.ParseExact(Request.Form("ucReportFilters:txtEndDate"), "dd/MM/yyyy", en), _
        '                        Common.CalcUserString(Request.Form("ucReportFilters:lstUsers")), _
        '                        Request.Form("ucReportFilters:ddlClient"), _
        '                        Request.Form("ucReportFilters:ddlCaptureType"))


        If StartDate = String.Empty Then
            StartDt = String.Empty
        Else
            StartDt = System.DateTime.ParseExact(StartDate, "dd/MM/yyyy", en)
        End If

        If EndDate = String.Empty Then
            EndDt = EndDate
        Else
            EndDt = System.DateTime.ParseExact(EndDate, "dd/MM/yyyy", en)
        End If

        DS = DAL.ReportExpenses(ProjectID, StartDt, EndDt, Users, ClientID, CaptureTypeID, ExpenseMonth)

        ' Name the tables
        DS.Tables(0).TableName = "Client"
        DS.Tables(1).TableName = "Project" '"Project"
        DS.Tables(2).TableName = "User" '"User"
        DS.Tables(3).TableName = "Expense" '"Expenses"

        ' Set up relationships
        dr1 = New DataRelation("Client_Project", DS.Tables("Client").Columns("ClientID"), DS.Tables("Project").Columns("ClientID"))
        dr1.Nested = True
        DS.Relations.Add(dr1)
        dr2 = New DataRelation("Project_User", DS.Tables("Project").Columns("ProjectID"), DS.Tables("User").Columns("ProjectID"))
        dr2.Nested = True
        DS.Relations.Add(dr2)
        dr3 = New DataRelation("User_Expense", DS.Tables("User").Columns("KeyVal"), DS.Tables("Expense").Columns("KeyVal"))
        dr3.Nested = True
        DS.Relations.Add(dr3)

        BuildHtmlTable()

        'Indicate that the user has selected a normal report
        hidUserReportType.Value = "0"

    End Sub

#End Region

#Region "User Report Layout"

    Public Sub LoadExpensesByUser()
        Dim strUsers As String
        Dim StartDt As String
        Dim EndDt As String

        DS = New DataSet

        If StartDate = String.Empty Then
            StartDt = String.Empty
        Else
            StartDt = System.DateTime.ParseExact(StartDate, "dd/MM/yyyy", en)
        End If

        If EndDate = String.Empty Then
            EndDt = EndDate
        Else
            EndDt = System.DateTime.ParseExact(EndDate, "dd/MM/yyyy", en)
        End If

        DS = DAL.ReportExpensesSummarisedByUser(ProjectID, StartDt, EndDt, Users, ClientID, CaptureTypeID)

        BuildUserHtmlTable()

        'Indicate that the user has selected a user report
        hidUserReportType.Value = "1"

    End Sub

    Private Sub BuildUserHtmlTable()

        Dim decExpenseUserTotal As Decimal
        Dim ExpenseRow As DataRow
        Dim UserID As Integer = 0

        ReportPlace.Controls.Clear()

        tblRep = New HtmlTable
        tblRep.Attributes.Add("class", "tableReport%")
        tblRep.Attributes.Add("width", "100%")
        tblRep.Border = 1
        ReportPlace.Controls.Add(tblRep)

        ' Build Header Row Table
        BuildUserHeaderRow(tblRep)

        For Each ExpenseRow In DS.Tables(0).Rows
            'For Each Expense Item

            '	<TR>
            ' 	<TH class="th4"  colspan=9>
            tblReprow = New HtmlTableRow
            tblRep.Rows.Add(tblReprow)
            'tblRepcell = New HtmlTableCell("th")
            'tblReprow.Cells.Add(tblRepcell)
            'tblRepcell.Attributes.Add("class", "th4")
            'tblRepcell.ColSpan = 3

            'Check if this is a new User, if it is - add a row
            If UserID <> ExpenseRow.Item("UserID") Then

                'Add the total for the previous user
                If UserID <> 0 Then
                    AddUserTotalRow(decExpenseUserTotal)
                    AddLine()
                End If

                AddUserNameRow(ExpenseRow.Item("Fullname"))
                decExpenseUserTotal = 0
                UserID = ExpenseRow.Item("UserID")
            End If

            AddUserExpenseRow(ExpenseRow.Item("ExpenseType"), ExpenseRow.Item("Amount"))
            decExpenseUserTotal += ExpenseRow.Item("Amount")

        Next

        'Add the last user's total row
        AddUserTotalRow(decExpenseUserTotal)
        AddLine()

    End Sub

#Region "Build User Rows"

    Private Function BuildUserHeaderRow(ByVal RepTable As HtmlTable)
        '         <TR>
        '           <TH>User</TH>
        '           <TH>Expense Type</TH>
        '           <TH>Amount</TH>
        '         </TR>


        FirstLevelRow = New HtmlTableRow
        RepTable.Controls.Add(FirstLevelRow)
        ' Add header cells here

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "5%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "User"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "50%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Expense Type"

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "45%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = "Amount"


    End Function

    Private Sub AddUserNameRow(ByVal strUserName As String)
        Dim UserCell As HtmlTableCell

        '<TR>
        '   <TD colspan=3>User Name
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'User Name
        UserCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(UserCell)
        UserCell.ColSpan = 3
        UserCell.InnerText = strUserName
        UserCell.Attributes.Add("class", "tdreportTotal")
    End Sub

    Private Sub AddUserExpenseRow(ByVal strExpenseType As String, ByVal decAmount As Decimal)

        Dim ExpenseCell As New HtmlTableCell("td")

        'Add Expense Row
        '<TR>
        '   <TD width="5%">
        '   <TD>Expense Type
        '   <TD>Amount
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 1)

        'Expense Type
        tblReprow.Cells.Add(ExpenseCell)
        ExpenseCell.Attributes.Add("align", "left")
        ExpenseCell.InnerText = strExpenseType
        ExpenseCell.Attributes.Add("class", "tdreport")
        ExpenseCell.ColSpan = 1


        'Amount
        ExpenseCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(ExpenseCell)
        ExpenseCell.Attributes.Add("align", "right")
        ExpenseCell.InnerHtml = String.Format("{0:C}", decAmount)
        ExpenseCell.Attributes.Add("class", "tdreport")
        ExpenseCell.ColSpan = 1

    End Sub

    Private Sub AddUserTotalRow(ByVal decTotal As Decimal)

        Dim TotalCell As New HtmlTableCell

        'Add Total Row
        '<TR>
        '   <TD>Total
        '   <TD>
        '   <TD>Amount
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        '"Total"
        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.InnerText = "Total"
        TotalCell.ColSpan = 1
        TotalCell.Attributes.Add("class", "tdreportTotal")

        'Spacer Cell
        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.Attributes.Add("class", "td")
        TotalCell.InnerHtml = ""
        TotalCell.ColSpan = 1

        'Expense Total
        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.InnerText = decTotal
        TotalCell.Attributes.Add("align", "right")
        TotalCell.InnerHtml = String.Format("{0:C}", decTotal)
        TotalCell.Attributes.Add("class", "tdreportTotal")
        TotalCell.ColSpan = 1

    End Sub

#End Region

#End Region

#End Region

#Region " SUBMIT DETAILS "

    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        If hidUserReportType.Value = "1" Then
            LoadExpensesByUser()
        Else
            LoadProjectDetails()
        End If
        Common.ExportExcel(ReportPlace, Me)
    End Sub
#End Region

End Class
