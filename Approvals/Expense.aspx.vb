Public Class Expense1
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Calendar1 As System.Web.UI.WebControls.Calendar
    Protected WithEvents rdoGroupBy As System.Web.UI.WebControls.RadioButtonList
    Protected WithEvents timePlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancel As System.Web.UI.WebControls.Button
    Protected WithEvents dgAwaitingApproval As System.Web.UI.WebControls.DataGrid
    Protected WithEvents plcTimeManager As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtManagerComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSubmitManager As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancelManager As System.Web.UI.WebControls.Button
    Protected WithEvents plcTimeManagerMonitor As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtManagerMonitorComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSubmitManagerMonitor As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancelManagerMonitor As System.Web.UI.WebControls.Button
    Protected WithEvents hidApprovalTypeSubmitted As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidApprovalTypeSubmited As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents plcTimeManagerMD As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtMDComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSubmitMDMonitor As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancelMDMonitor As System.Web.UI.WebControls.Button
    Protected WithEvents divTeamleader As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents divManager As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents divManagerMonitor As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents divMD As System.Web.UI.HtmlControls.HtmlGenericControl

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
        MD = 4
    End Enum
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "9"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Approval"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Approval (Expenses)"
            LoadSystemData()
            LoadUserProfile()
            If Request.QueryString("Date") = "" Then
                ForDate = Today()
            Else
                ForDate = Request.QueryString("Date")
            End If
            GetFirstDay(ForDate)
            LoadExpensesAwaitingApprovalAlert()
            LoadData()
            'LoadExpensesForApproval()
        End If
    End Sub

    Private Sub LoadSystemData()
        DR = DAL.LoadSystemData() 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectSystem")
        If DR.Read() Then
            ' Number of approval cycles for Timesheets and Expenses
            If IsDBNull(DR.Item("TSApprovals")) Then
                ViewState("TSApprovals") = 1
            Else
                ViewState("TSApprovals") = DR.Item("TSApprovals")
            End If
            For count = 1 To ViewState("TSApprovals")
                ' Get the Approver Role
                ViewState("TSApprover" & count & "Role") = DR.Item("TSApprover" & count & "Role")
            Next
            ' Set the WeekStartDay 1:Monday, 7:Sunday
            ViewState("StartDay") = DR.Item("WeekStartDay")
        End If
        DR.Close()
    End Sub

    Private Sub LoadExpensesAwaitingApprovalAlert()

        dgAwaitingApproval.DataSource = DAL.GetExpensesAwaitingApproval(User.Identity.Name, Request.ApplicationPath)
        dgAwaitingApproval.DataBind()

    End Sub

    Private Sub LoadUserProfile()
        DR = DAL.LoadProfileTSApproval(User.Identity.Name)
        If DR.Read() Then
            ' Group By Project(0) or Resource(1)
            rdoGroupBy.Items(DR.Item("Grouping")).Selected = True
        Else
            ' User Does not Have a Profile yet so default to Client
            rdoGroupBy.Items(0).Selected = True
        End If
        DR.Close()

    End Sub

    Private Sub GetFirstDay(ByVal day As Date)

        Dim FirstDay As DateTime
        FirstDay = day.Month & "/01/" & day.Year
        Dim LastDay As DateTime
        LastDay = Common.LastOfMonth(day)

        ViewState("FirstDay") = FirstDay

        'Set Week Start Day
        '1: Monday .. 7:Sunday
        Calendar1.FirstDayOfWeek = ViewState("StartDay")
        ' Clear any selected dates.
        Calendar1.SelectedDates.Clear()
        ' Select the specified range of dates.
        Calendar1.SelectedDates.SelectRange(FirstDay, LastDay)
        Calendar1.VisibleDate = day

    End Sub

    Private Sub LoadData()

        'Retrieve the TeamLeader Timesheets for approval and load them
        DS = New DataSet

        strValue = String.Empty
        strValue2 = String.Empty
        DS = DAL.SelectExpenseForApprovals(User.Identity.Name, ViewState("FirstDay"), rdoGroupBy.SelectedItem.Text)
        If DS.Tables(0).Rows.Count > 0 Then
            LoadExpensesForApproval(DS, ApprovalType.Teamleader)
        Else
            divTeamleader.Visible = False
        End If

        strValue = String.Empty
        strValue2 = String.Empty
        DS = DAL.SelectExpenseForApprovalsManager(User.Identity.Name, ViewState("FirstDay"), rdoGroupBy.SelectedItem.Text)
        If DS.Tables(0).Rows.Count > 0 Then
            LoadExpensesForApproval(DS, ApprovalType.Manager)
        Else
            divManager.Visible = False
        End If

        strValue = String.Empty
        strValue2 = String.Empty
        DS = DAL.SelectExpenseForApprovalsManagerMonitor(User.Identity.Name, ViewState("FirstDay"), rdoGroupBy.SelectedItem.Text)
        If DS.Tables(0).Rows.Count > 0 Then
            LoadExpensesForApproval(DS, ApprovalType.ManagerMonitor)
        Else
            divManagerMonitor.Visible = False
        End If

        strValue = String.Empty
        strValue2 = String.Empty
        DS = DAL.SelectExpenseForApprovalsMD(User.Identity.Name, ViewState("FirstDay"), rdoGroupBy.SelectedItem.Text)
        If DS.Tables(0).Rows.Count > 0 Then
            LoadExpensesForApproval(DS, ApprovalType.MD)
        Else
            divMD.Visible = False
        End If

    End Sub

    Private Sub LoadExpensesForApproval(ByVal DS As DataSet, ByVal enuApprovalType As ApprovalType)
        Dim dr1 As DataRelation
        Dim dr2 As DataRelation
        Dim dr3 As DataRelation

        If rdoGroupBy.SelectedItem.Text = "Client" Then
            ' Name the tables
            DS.Tables(0).TableName = "Level1" ' Clients
            DS.Tables(1).TableName = "Level2" ' Projects
            DS.Tables(2).TableName = "Level3" ' Users
            DS.Tables(3).TableName = "Level4" ' Expense Items
            ' Set up relationships
            dr1 = New DataRelation("Level1_Level2", DS.Tables("Level1").Columns("ClientID"), DS.Tables("Level2").Columns("ClientID"))
            dr1.Nested = True
            DS.Relations.Add(dr1)
            dr2 = New DataRelation("Level2_Level3", DS.Tables("Level2").Columns("KeyVal"), DS.Tables("Level3").Columns("KeyVal"))
            dr2.Nested = True
            DS.Relations.Add(dr2)
            dr3 = New DataRelation("Level3_Level4", DS.Tables("Level3").Columns("KeyVal2"), DS.Tables("Level4").Columns("KeyVal2"))
            dr3.Nested = True
            DS.Relations.Add(dr3)
            'DS.WriteXml("D:\ExpenseApprove.xml")
        Else
            ' Name the tables
            DS.Tables(0).TableName = "Level1" ' Users
            DS.Tables(1).TableName = "Level2" ' Clients
            DS.Tables(2).TableName = "Level3" ' Projects
            DS.Tables(3).TableName = "Level4" ' Expense Items
            ' Set up relationships
            dr1 = New DataRelation("Level1_Level2", DS.Tables("Level1").Columns("UserID"), DS.Tables("Level2").Columns("UserID"))
            dr1.Nested = True
            DS.Relations.Add(dr1)
            dr2 = New DataRelation("Level2_Level3", DS.Tables("Level2").Columns("KeyVal"), DS.Tables("Level3").Columns("KeyVal"))
            dr2.Nested = True
            DS.Relations.Add(dr2)
            dr3 = New DataRelation("Level3_Level4", DS.Tables("Level3").Columns("KeyVal2"), DS.Tables("Level4").Columns("KeyVal2"))
            dr3.Nested = True
            DS.Relations.Add(dr3)
            'DS.WriteXml("D:\ExpenseApprove.xml")
        End If
        BuildHtmlTable(enuApprovalType)

    End Sub

    Private Sub BuildHtmlTable(ByVal enuApprovalType As ApprovalType)

        If enuApprovalType = ApprovalType.Teamleader Then
            timePlace.Controls.Clear()
        ElseIf enuApprovalType = ApprovalType.Manager Then
            plcTimeManager.Controls.Clear()
        ElseIf enuApprovalType = ApprovalType.ManagerMonitor Then
            plcTimeManagerMonitor.Controls.Clear()
        ElseIf enuApprovalType = ApprovalType.MD Then
            plcTimeManagerMD.Controls.Clear()
        End If

        tbltime = New HtmlTable
        tbltime.Attributes.Add("width", "100%")

        If enuApprovalType = ApprovalType.Teamleader Then
            timePlace.Controls.Add(tbltime)
        ElseIf enuApprovalType = ApprovalType.Manager Then
            plcTimeManager.Controls.Add(tbltime)
        ElseIf enuApprovalType = ApprovalType.ManagerMonitor Then
            plcTimeManagerMonitor.Controls.Add(tbltime)
        ElseIf enuApprovalType = ApprovalType.MD Then
            plcTimeManagerMD.Controls.Add(tbltime)
        End If

        For Each Level1row In DS.Tables("Level1").Rows
            ' For Each Client / User (Depends on rdoGroupBy Value)
            menucount += 1

            '	<TR>
            ' 	<TH class="th4" id="menu2" colspan=6>
            row = New HtmlTableRow
            tbltime.Rows.Add(row)
            cell = New HtmlTableCell("th")
            row.Cells.Add(cell)
            cell.Attributes.Add("class", "th4")
            cell.ID = "menu" & menucount
            'cell.ColSpan = 6

            ' Build Header Row Table
            BuildLevel1HeaderRowTable(enuApprovalType)

            ' Create a new htmlrow containing the next Level
            ' Create the following table details
            '<TR>
            '	<TD>
            '		<span id="menu2b" style="DISPLAY: block">
            '     <TABLE>
            row = New HtmlTableRow
            tbltime.Rows.Add(row)
            cell = New HtmlTableCell("td")
            row.Cells.Add(cell)
            spanlit = New HtmlGenericControl("Span")
            spanlit.ID = "menu" & menucount & "b"
            spanlit.Attributes.Add("Style", "display:block;")
            cell.Controls.Add(spanlit)

            Table = New HtmlTable
            spanlit.Controls.Add(Table)
            Table.Attributes.Add("width", "100%")

            For Each Level2row In Level1row.GetChildRows("Level1_Level2")
                AddLevel2Row(False)
                'Reset savLevel3ID
                SavLevel3ID = ""
                For Each Level3row In Level2row.GetChildRows("Level2_Level3")
                    AddLevel3Data()
                    For Each Level4row In Level3row.GetChildRows("Level3_Level4")
                        AddExpenseData(enuApprovalType)
                    Next
                Next
            Next
        Next

        hidBoxids = New HtmlInputHidden
        hidBoxfirstapprovals = New HtmlInputHidden

        If enuApprovalType = ApprovalType.Teamleader Then

            hidBoxids.ID = "hidBoxexpenseids"
            hidBoxids.Value = strValue
            timePlace.Controls.Add(hidBoxids)

            hidBoxfirstapprovals.ID = "hidBoxfirstapprovals"
            hidBoxfirstapprovals.Value = strValue2
            timePlace.Controls.Add(hidBoxfirstapprovals)

        ElseIf enuApprovalType = ApprovalType.Manager Then

            hidBoxids.ID = "hidBoxexpenseidsManager"
            hidBoxids.Value = strValue
            plcTimeManager.Controls.Add(hidBoxids)

            hidBoxfirstapprovals.ID = "hidBoxfirstapprovalsManager"
            hidBoxfirstapprovals.Value = strValue2
            plcTimeManager.Controls.Add(hidBoxfirstapprovals)

        ElseIf enuApprovalType = ApprovalType.ManagerMonitor Then

            hidBoxids.ID = "hidBoxexpenseidsManagerMonitor"
            hidBoxids.Value = strValue
            plcTimeManagerMonitor.Controls.Add(hidBoxids)

            hidBoxfirstapprovals.ID = "hidBoxfirstapprovalsManagerMonitor"
            hidBoxfirstapprovals.Value = strValue2
            plcTimeManagerMonitor.Controls.Add(hidBoxfirstapprovals)
        ElseIf enuApprovalType = ApprovalType.MD Then

            hidBoxids.ID = "hidBoxexpenseidsMD"
            hidBoxids.Value = strValue
            plcTimeManagerMD.Controls.Add(hidBoxids)

            hidBoxfirstapprovals.ID = "hidBoxfirstapprovalsMD"
            hidBoxfirstapprovals.Value = strValue2
            plcTimeManagerMD.Controls.Add(hidBoxfirstapprovals)
        End If

    End Sub

    Private Sub BuildLevel1HeaderRowTable(ByVal enuApprovalType As ApprovalType)

        Dim txtLink As HtmlGenericControl

        '       <TABLE width=100%>
        '         <TR>
        '           <TH>
        '          		<IMG id="menu2a" style="LEFT: 0px; CURSOR: hand; TOP: 3px"
        '                 onclick = "ToggleDisplay(menu2a, menu2b, 'menu2');"
        ' 			          height="16" alt="" src="../Images/down.gif" width="16" align="right" vspace="0"
        ' 			          border="0">
        '                 Project/UserName</TH>
        '           <TH>textbox id=Approve_ProjectID Approve All</TH>
        '           <TH>textbox id=Reject_ProjectID Reject All</TH>
        '         </TR>
        '       </TABLE>

        Table = New HtmlTable
        cell.Controls.Add(Table)
        Table.Attributes.Add("width", "100%")
        FirstLevelRow = New HtmlTableRow
        Table.Controls.Add(FirstLevelRow)
        ' Add header cells here
        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "4%")
        FirstLevelCell.Attributes.Add("class", "th1")
        img = New HtmlImage
        FirstLevelCell.Controls.Add(img)
        img.ID = "menu" & menucount & "a"
        img.Attributes.Add("onclick", "ToggleDisplay(" & cell.ID & "a, " & cell.ID & "b, '" & cell.ID & "');")
        img.Src = "../Images/up.gif"
        img.Attributes.Add("align", "right")
        img.Attributes.Add("Style", "LEFT: 0px; CURSOR: hand; TOP: 3px")

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "34%")
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = GetTableData(1, 2) ' Client / UserName

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "10%")
        FirstLevelCell.Attributes.Add("class", "th1")

        txtLink = New HtmlGenericControl("Div")
        FirstLevelCell.Controls.Add(txtLink)

        txtLink.InnerHtml = "<u>Approve All</u>"
        txtLink.Attributes.Add("style", "cursor:pointer")
        txtLink.Attributes.Add("onclick", "javascript:ApproveAll(this, 'expense'," & enuApprovalType & ");")
        txtLink.ID = "Approve_" & GetTableData(1, 1)

        FirstLevelCell = New HtmlTableCell("th")
        FirstLevelRow.Controls.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", "10%")
        FirstLevelCell.Attributes.Add("class", "th1")

        txtLink = New HtmlGenericControl("Div")
        FirstLevelCell.Controls.Add(txtLink)

        txtLink.InnerHtml = "<u>Reject All</u>"
        txtLink.Attributes.Add("style", "cursor:pointer")
        txtLink.Attributes.Add("onclick", "javascript:RejectAll(this, 'expense'," & enuApprovalType & ");")
        txtLink.ID = "Reject_" & GetTableData(1, 1)


    End Sub

    Private Sub AddLevel2Row(ByVal AddBlankRow As Boolean)
        ' Create the following table details
        '       <TR>
        SecondLevelRow = New HtmlTableRow
        Table.Controls.Add(SecondLevelRow)
        'SecondLevelRow.ID = "tr_" & GetTableData(2, 2) ' ProjID / ClientID  'SD: 12/10/2005 - Remove the id as it is not needed and causes errors when you have duplicate id's
        If AddBlankRow Then
            AddLevel2TD("") ' ProjectName / ClientName
        Else
            AddLevel2TD(GetTableData(2, 3)) ' ProjectName / ClientName
            If rdoGroupBy.SelectedItem.Text = "Client" Then
                If GetTableData(2, 4) < ViewState("TSApprovals") Then
                    ' Add hidden textbox containing Projects in First ApprovalStage
                    strValue2 &= "," & GetTableData(2, 2)
                End If
            End If
        End If
    End Sub
    Private Sub AddLevel2TD(ByVal TextVal As String)
        '         <TD width=40% class=label>TaskName / ProjectName</TD>
        SecondLevelCell = New HtmlTableCell("td")
        SecondLevelRow.Cells.Add(SecondLevelCell)
        SecondLevelCell.Attributes.Add("Width", "40%")
        SecondLevelCell.Attributes.Add("Align", "right")
        'SecondLevelCell.ID = "lblLevel2_" & GetTableData(2, 2) ' TaskID / ProjID   'SD: 12/10/2005 - Remove the id as it is not needed and causes errors when you have duplicate id's
        SecondLevelCell.InnerText = TextVal
        SecondLevelCell.Attributes.Add("class", "labelboldCaps")
        SecondLevelCell.ColSpan = 2
    End Sub

    Private Sub AddLevel3Data()
        ' If the Level3 Value changes then Add a blank field for the Level2 TD
        If SavLevel3ID <> CStr(GetTableData(3, 3)) Then
            If SavLevel3ID <> "" Then
                AddLevel2Row(True)
            End If
            SavLevel3ID = CStr(GetTableData(3, 3))
        End If
        If rdoGroupBy.SelectedItem.Text = "Resource" Then
            If GetTableData(3, 5) < ViewState("TSApprovals") Then
                ' Add hidden textbox containing Projects in First ApprovalStage
                strValue2 &= "," & GetTableData(3, 3)
            End If
        End If
        '         <TD colspan=5 class=label>UserName / ProjectName</TD>
        SecondLevelCell = New HtmlTableCell("td")
        SecondLevelRow.Cells.Add(SecondLevelCell)
        SecondLevelCell.ColSpan = 5
        'SecondLevelCell.ID = "lblLevel3_" & GetTableData(3, 3) ' UserID / ProjectID   'SD: 12/10/2005 - Remove the id as it is not needed and causes errors when you have duplicate id's
        SecondLevelCell.InnerText = GetTableData(3, 4) ' UserName / ProjectName
        SecondLevelCell.Attributes.Add("class", "labelBold")

    End Sub

    Private Sub AddExpenseData(ByVal enuApprovalType As ApprovalType)
        ' Create the following table details
        '       <TR id=tr_time_ExpenseID>
        SecondLevelRow = New HtmlTableRow
        Table.Controls.Add(SecondLevelRow)
        SecondLevelRow.ID = "tr_time_" & Level4row.Item("ExpenseID")
        '         <TD width=10% class=label>Date</TD>
        SecondLevelCell = New HtmlTableCell("td")
        SecondLevelRow.Controls.Add(SecondLevelCell)
        SecondLevelCell.Attributes.Add("Width", "15%")
        SecondLevelCell.Attributes.Add("class", "label")
        SecondLevelCell.InnerHtml = Level4row.Item("txtDate")
        '         <TD width=30% class=label>Comments</TD>
        SecondLevelCell = New HtmlTableCell("td")
        SecondLevelRow.Controls.Add(SecondLevelCell)
        SecondLevelCell.Attributes.Add("Width", "20%")
        SecondLevelCell.Attributes.Add("class", "label")
        SecondLevelCell.InnerHtml = Level4row.Item("txtComment")
        '         <TD width=10% class=label>ExpenseType</TD>
        SecondLevelCell = New HtmlTableCell("td")
        SecondLevelRow.Controls.Add(SecondLevelCell)
        SecondLevelCell.Attributes.Add("Width", "15%")
        SecondLevelCell.Attributes.Add("class", "label")
        SecondLevelCell.InnerHtml = Level4row.Item("ExpenseType")
        '         <TD width=10% class=label>Quantity</TD>
        SecondLevelCell = New HtmlTableCell("td")
        SecondLevelRow.Controls.Add(SecondLevelCell)
        SecondLevelCell.Attributes.Add("Width", "10%")
        SecondLevelCell.Attributes.Add("class", "label")
        SecondLevelCell.Align = "Right"
        SecondLevelCell.InnerHtml = Level4row.Item("Quantity")
        '         <TD width=10% class=label>Cost</TD>
        SecondLevelCell = New HtmlTableCell("td")
        SecondLevelRow.Controls.Add(SecondLevelCell)
        SecondLevelCell.Attributes.Add("Width", "10%")
        SecondLevelCell.Attributes.Add("class", "label")
        SecondLevelCell.Align = "Right"
        SecondLevelCell.InnerHtml = CDec(Level4row.Item("UnitCost")).ToString("C")
        '         <TD width=10% class=label>Total</TD>
        SecondLevelCell = New HtmlTableCell("td")
        SecondLevelRow.Controls.Add(SecondLevelCell)
        SecondLevelCell.Attributes.Add("Width", "10%")
        SecondLevelCell.Attributes.Add("class", "label")
        SecondLevelCell.Align = "Right"
        SecondLevelCell.InnerHtml = CDec(Level4row.Item("Quantity") * Level4row.Item("UnitCost")).ToString("C")
        '         <TD width=20% class=label>rdoApprove</TD>
        SecondLevelCell = New HtmlTableCell("td")
        SecondLevelRow.Controls.Add(SecondLevelCell)
        SecondLevelCell.Attributes.Add("Width", "20%")
        rdo = New RadioButtonList
        SecondLevelCell.Controls.Add(rdo)
        rdo.Attributes.Add("class", "label")
        rdo.ID = "rdoApprove_" & GetTableData(1, 1) & "_" & Level4row.Item("ExpenseID")
        rdo.TextAlign = TextAlign.Right
        rdo.RepeatDirection = RepeatDirection.Horizontal
        rdo.Attributes.Add("onclick", "loadComment(this," & enuApprovalType & ");")

        rdoitem = New ListItem
        rdo.Items.Add(rdoitem)
        rdoitem.Value = 1
        rdoitem.Text = "Approve"
        rdoitem.Selected = True

        rdoitem = New ListItem
        rdo.Items.Add(rdoitem)
        rdoitem.Value = 0
        rdoitem.Text = "Reject"

        ' Add UserID to Hiddenfield
        hid = New HtmlInputHidden
        hid.ID = "hidUser_" & Level4row.Item("ExpenseID")
        hid.Value = Level4row.Item("UserID")
        SecondLevelCell.Controls.Add(hid)

        hid = New HtmlInputHidden
        hid.ID = "hidComment_" & Level4row.Item("ExpenseID")
        SecondLevelCell.Controls.Add(hid)

        ' Add TimesheetID's to hidden box for processing on Submit
        strValue &= "," & GetTableData(1, 1) & "_" & Level4row.Item("ExpenseID")

    End Sub

    Private Function GetTableData(ByVal Level As Int16, ByVal Column As Int16)
        If rdoGroupBy.SelectedItem.Text = "Client" Then
            Select Case Level
                Case 1
                    Select Case Column
                        Case 1
                            Return Level1row.Item("ClientID")
                        Case 2
                            Return Level1row.Item("ClientName")
                    End Select
                Case 2
                    Select Case Column
                        Case 1
                            Return Level2row.Item("ClientID")
                        Case 2
                            Return Level2row.Item("ProjectID")
                        Case 3
                            Return Level2row.Item("ProjectName")
                            '  Case 4
                            '     Return Level2row.Item("Approver")
                    End Select
                Case 3
                    Select Case Column
                        Case 1
                            Return Level3row.Item("ClientID")
                        Case 2
                            Return Level3row.Item("ProjectID")
                        Case 3
                            Return Level3row.Item("UserID")
                        Case 4
                            Return Level3row.Item("UserName")
                        Case 5
                            Return Level3row.Item("KeyVal2")
                    End Select
            End Select
        Else
            Select Case Level
                Case 1
                    Select Case Column
                        Case 1
                            Return Level1row.Item("UserID")
                        Case 2
                            Return Level1row.Item("UserName")
                    End Select
                Case 2
                    Select Case Column
                        Case 1
                            Return Level2row.Item("UserID")
                        Case 2
                            Return Level2row.Item("ClientID")
                        Case 3
                            Return Level2row.Item("ClientName")
                    End Select
                Case 3
                    Select Case Column
                        Case 1
                            Return Level3row.Item("UserID")
                        Case 2
                            Return Level3row.Item("ClientID")
                        Case 3
                            Return Level3row.Item("ProjectID")
                        Case 4
                            Return Level3row.Item("ProjectName")
                            'Case 5
                            '    Return Level3row.Item("Approver")
                    End Select
            End Select
        End If
    End Function

#End Region

#Region " SUBMIT DETAILS "
    Private Sub Calendar1_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Calendar1.SelectionChanged
        GetFirstDay(Calendar1.SelectedDate)
        LoadData()
        'LoadExpensesForApproval()
    End Sub

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ' Save the Users Group By Profile
        Dim arParms2() As SqlParameter = New SqlParameter(1) {}
        arParms2(0) = New SqlParameter("@UserID", User.Identity.Name)
        arParms2(1) = New SqlParameter("@GroupBy", rdoGroupBy.SelectedItem.Value)
        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateTSApprovalProfile", arParms2)

        ' Insert TT_Approvals Entries
        Dim a, NoRows As Int16
        Dim ItemNo, Item As String
        Dim arrData, ItemData As Array
        Dim enuApprovalType As ApprovalType
        Dim strPrefix As String

        'Determine which approvals have been submitted
        If hidApprovalTypeSubmited.Value = "TeamLeader" Then
            enuApprovalType = ApprovalType.Teamleader
        ElseIf hidApprovalTypeSubmited.Value = "Manager" Then
            enuApprovalType = ApprovalType.Manager
        ElseIf hidApprovalTypeSubmited.Value = "ManagerMonitor" Then
            enuApprovalType = ApprovalType.ManagerMonitor
        Else
            enuApprovalType = ApprovalType.MD
        End If

        a = 0
        NoRows = 0
        ItemNo = ""

        'Determine which approvals have been submitted and use the appropriate hidden textbox
        If enuApprovalType = ApprovalType.Teamleader Then
            ItemNo = Request.Form("hidBoxexpenseids")
        ElseIf enuApprovalType = ApprovalType.Manager Then
            ItemNo = Request.Form("hidBoxexpenseidsManager")
        ElseIf enuApprovalType = ApprovalType.ManagerMonitor Then
            ItemNo = Request.Form("hidBoxexpenseidsManagerMonitor")
        Else
            ItemNo = Request.Form("hidBoxexpenseidsMD")
        End If

        If ItemNo <> "" And ItemNo <> "," Then
            Try
                arrData = ItemNo.Split(",")
                NoRows = (arrData.Length - 1)
            Catch
            End Try

            While a < NoRows
                a += 1
                ' For each Timesheet Item
                ' separate the project and timesheetid
                Item = arrData(a)
                ItemData = Item.Split("_")
                If enuApprovalType = ApprovalType.Teamleader Then
                    ItemNo = ItemData(1)
                    strPrefix = ""
                Else
                    ItemNo = ItemData(2)
                    strPrefix = "_" & ItemData(1)
                End If

                ' Insert the Approval Record
                DAL.InsertApproval(Common.ApprovalType.Expense, User.Identity.Name, ItemNo, Request.Form("hidComment_" & ItemNo), CInt(Request.Form("rdoApprove_" & ItemData(0) & strPrefix & "_" & ItemNo)))
                If Request.Form("rdoApprove_" & ItemData(0) & strPrefix & "_" & ItemNo) = 0 Then
                    ' Add UserID to RejectedItemList
                    UserID = Request.Form("hidUser_" & ItemNo)
                    If Not UsrArrayL.Contains(UserID) Then
                        UsrArrayL.Add(UserID)
                    End If
                End If
            End While
        End If

        SendRejectedEmails()

        LoadExpensesAwaitingApprovalAlert()

    End Sub

    Private Sub SendRejectedEmails()
        ' Get the User email addresses and send email notifying them that they have rejected timesheet items
        Dim i As Int16
        Dim email As String
        If UsrArrayL.Count > 0 Then
            For i = 0 To (UsrArrayL.Count - 1)
                If UsrArrayL(i) <> 0 Then
                    ' User Email Exists
                    email = Common.GetEmailForUser(UsrArrayL(i))
                    SendEmail(email)
                End If
            Next
        End If

    End Sub

    Sub SendEmail(ByVal MailTo As String)
        ' Send email when new user is added
        Dim Subject As String
        Dim Priority As Mail.MailPriority = Mail.MailPriority.Normal
        Dim strBody As String

        ' Send email to the user that has just been added,
        strBody = "<font face=Arial size=2>You have rejected expense items for " & MonthName(Month(CDate(ViewState("FirstDay")))) & " " & _
                    Year(CDate(ViewState("FirstDay"))) & vbCrLf & _
                  "<br><br>You may access the system at the following url: <a href=" & ConfigurationSettings.AppSettings("WebAddress") & ">" & _
                  ConfigurationSettings.AppSettings("WebAddress") & "</a></font>"
        Subject = "TimeTraX - Rejected Expense"
        WebMails.TrySendMail(MailTo, Subject, strBody, Mail.MailPriority.Normal, "")

    End Sub

    Private Sub rdoGroupBy_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rdoGroupBy.SelectedIndexChanged
        LoadData()
        'LoadExpensesForApproval()
    End Sub

#End Region


End Class
