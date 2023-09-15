Public Class Timesheet
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents timePlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents lblDay1Num As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay2Num As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay3Num As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay4Num As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay5Num As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay6Num As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay7Num As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay1 As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay2 As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay3 As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay4 As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay5 As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay6 As System.Web.UI.WebControls.Label
    Protected WithEvents lblDay7 As System.Web.UI.WebControls.Label
    Protected WithEvents ddlTask_ As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtDay1_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay2_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay3_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay4_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay5_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay6_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay7_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents time_base As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents timeLoadCount As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents imgDeletetime_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents tbltimefoot As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents tbltimeadd As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents Calendar1 As System.Web.UI.WebControls.Calendar
    Protected WithEvents btnTasks As System.Web.UI.WebControls.Button
    Protected WithEvents btnSave As System.Web.UI.WebControls.Button
    Protected WithEvents btnUnsubmit As System.Web.UI.WebControls.Button
    Protected WithEvents projPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents htmTasks As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents htmTimeOff As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents txtDay1Tot As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay2Tot As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay3Tot As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay4Tot As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay5Tot As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay6Tot As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDay7Tot As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtTotal As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvComments As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents dgOutstanding As System.Web.UI.WebControls.DataGrid
    Protected WithEvents txtRejComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents tblRejComment As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents tbltimea As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents tbltime As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents lblWeekNo As System.Web.UI.WebControls.Label
    Protected WithEvents tdReject As System.Web.UI.HtmlControls.HtmlTableCell
    Protected WithEvents divReject As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblComment As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents tdComment As System.Web.UI.HtmlControls.HtmlTableCell
    Protected WithEvents hidTimesheetDate As System.Web.UI.HtmlControls.HtmlInputHidden

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
    Dim strStatus As String
    Dim strErr As String
    Dim strMess As String

#End Region

#Region " PAGE DECLARES "
    'Dim StartDay As Integer '= ConfigurationSettings.AppSettings("WeekStartDay")
    Dim ForDate As DateTime
    Dim DS As DataSet
    Dim TimesheetSubmitted As Int16
    Dim ApprovalsExist As Int16
    Dim RejectedTimesheet As Int16
    Dim hidBoxtask As HtmlInputHidden
    Dim i As Integer
    Dim Billable As Integer
    Dim strValue As String
    Dim strTaskID As String
    Dim TotDay1 As Decimal
    Dim TotDay2 As Decimal
    Dim TotDay3 As Decimal
    Dim TotDay4 As Decimal
    Dim TotDay5 As Decimal
    Dim TotDay6 As Decimal
    Dim TotDay7 As Decimal
    Dim RowTot As Decimal
    Dim TaskTot As Decimal
    Dim GTotDay1 As Decimal
    Dim GTotDay2 As Decimal
    Dim GTotDay3 As Decimal
    Dim GTotDay4 As Decimal
    Dim GTotDay5 As Decimal
    Dim GTotDay6 As Decimal
    Dim GTotDay7 As Decimal
    Dim GTot As Decimal

    Dim Table As HtmlTable = New HtmlTable
    Dim row As HtmlTableRow = New HtmlTableRow
    Dim headerRow As HtmlTableRow = New HtmlTableRow
    Dim tasktableRow As HtmlTableRow = New HtmlTableRow
    Dim cell As HtmlTableCell = New HtmlTableCell
    Dim headerCell As HtmlTableCell = New HtmlTableCell
    Dim taskCell As HtmlTableCell = New HtmlTableCell
    Dim txtbox As HtmlInputText = New HtmlInputText
    'Dim timetxtbox As HtmlInputText = New HtmlInputText
    Dim timetxtbox As IMTextBox = New IMTextBox
    Dim lbl As Label = New Label
    Dim img As HtmlImage
    Dim projrow As DataRow
    Dim projtask As DataTable
    Dim taskrow As DataRow
    Dim menucount As Integer = 0
    Dim spanlit As HtmlGenericControl

#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "6"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "TimeSheet"
            Session("PageTitle") = Session("AppName") & " - Capture Timesheet"
            LoadSystemData()
            LoadOutstandingTimesheets()
            If Request.QueryString("Date") = "" Then
                ForDate = Today()
            Else
                ForDate = Request.QueryString("Date")
            End If
            GetFirstDay(ForDate)
            hidTimesheetDate.Value = ViewState("FirstDay")
        End If

    End Sub

    Private Sub LoadSystemData()
        DR = DAL.LoadSystemData() 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectSystem")
        If DR.Read() Then
            ' Check if Timesheet comments are to be enforced
            If IsDBNull(DR.Item("ForceTSComments")) Then
                ViewState("ForceComments") = 0
            Else
                If DR.Item("ForceTSComments") = True Then
                    ViewState("ForceComments") = 1
                    btnSubmit.Attributes.Add("onclick", "checkEmptyComments();")
                    btnSubmit.CausesValidation = True
                Else
                    ViewState("ForceComments") = 0
                End If
            End If
            ' Set the WeekStartDay 1:Monday, 7:Sunday
            ViewState("StartDay") = DR.Item("WeekStartDay")
        End If
        DR.Close()
    End Sub

    Private Sub LoadOutstandingTimesheets()

        dgOutstanding.DataSource = DAL.OverDueTimesheets(User.Identity.Name)
        dgOutstanding.DataBind()

    End Sub

    Private Sub GetFirstDay(ByVal Day As Date)
        Dim FirstDay As DateTime
        Dim arParms1() As SqlParameter = New SqlParameter(0) {}
        arParms1(0) = New SqlParameter("@Date", Day)
        FirstDay = System.DateTime.ParseExact(SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, "TT_SelectWeekStartDate", arParms1), "dd/MM/yyyy", en)
        ViewState("FirstDay") = FirstDay
        Dim LastDay As DateTime = DateAdd(DateInterval.Day, 6, FirstDay)

        'Set Week Start Day
        '1: Monday .. 7:Sunday
        Calendar1.FirstDayOfWeek = ViewState("StartDay")
        ' Clear any selected dates.
        Calendar1.SelectedDates.Clear()
        ' Select the specified range of dates.
        Calendar1.SelectedDates.SelectRange(FirstDay, LastDay)
        Calendar1.VisibleDate = Day

        LoadDayLabels(FirstDay, ViewState("StartDay"))
        LoadWeekTimes(FirstDay)
    End Sub

    Private Sub LoadDayLabels(ByVal FirstDay As Date, ByVal StartDay As Integer)

        lblWeekNo.Text = "Week " & DatePart(DateInterval.WeekOfYear, FirstDay)  'SD: 12/09/2005 - Show the Week No
        lblDay1Num.Text = DatePart(DateInterval.Day, FirstDay)
        lblDay2Num.Text = DatePart(DateInterval.Day, FirstDay.AddDays(1))
        lblDay3Num.Text = DatePart(DateInterval.Day, FirstDay.AddDays(2))
        lblDay4Num.Text = DatePart(DateInterval.Day, FirstDay.AddDays(3))
        lblDay5Num.Text = DatePart(DateInterval.Day, FirstDay.AddDays(4))
        lblDay6Num.Text = DatePart(DateInterval.Day, FirstDay.AddDays(5))
        lblDay7Num.Text = DatePart(DateInterval.Day, FirstDay.AddDays(6))

        Select Case StartDay
            Case 1 ' Week Starts on Monday
                'Calendar1.FirstDayOfWeek = System.Web.UI.WebControls.FirstDayOfWeek.Monday
                lblDay1.Text = "Mon"
                lblDay2.Text = "Tue"
                lblDay3.Text = "Wed"
                lblDay4.Text = "Thu"
                lblDay5.Text = "Fri"
                lblDay6.Text = "Sat"
                lblDay7.Text = "Sun"
            Case 2 ' Week Starts on Tuesday
                'Calendar1.FirstDayOfWeek = System.Web.UI.WebControls.FirstDayOfWeek.Tuesday
                lblDay1.Text = "Tue"
                lblDay2.Text = "Wed"
                lblDay3.Text = "Thu"
                lblDay4.Text = "Fri"
                lblDay5.Text = "Sat"
                lblDay6.Text = "Sun"
                lblDay7.Text = "Mon"
            Case 3 ' Week Starts on Wednesday
                'Calendar1.FirstDayOfWeek = System.Web.UI.WebControls.FirstDayOfWeek.Wednesday
                lblDay1.Text = "Wed"
                lblDay2.Text = "Thu"
                lblDay3.Text = "Fri"
                lblDay4.Text = "Sat"
                lblDay5.Text = "Sun"
                lblDay6.Text = "Mon"
                lblDay7.Text = "Tue"
            Case 4 ' Week Starts on Thursday
                'Calendar1.FirstDayOfWeek = System.Web.UI.WebControls.FirstDayOfWeek.Thursday
                lblDay1.Text = "Thu"
                lblDay2.Text = "Fri"
                lblDay3.Text = "Sat"
                lblDay4.Text = "Sun"
                lblDay5.Text = "Mon"
                lblDay6.Text = "Tue"
                lblDay7.Text = "Wed"
            Case 5 ' Week Starts on Friday
                'Calendar1.FirstDayOfWeek = System.Web.UI.WebControls.FirstDayOfWeek.Friday
                lblDay1.Text = "Fri"
                lblDay2.Text = "Sat"
                lblDay3.Text = "Sun"
                lblDay4.Text = "Mon"
                lblDay5.Text = "Tue"
                lblDay6.Text = "Wed"
                lblDay7.Text = "Thu"
            Case 6 ' Week Starts on Saturday
                'Calendar1.FirstDayOfWeek = System.Web.UI.WebControls.FirstDayOfWeek.Saturday
                lblDay1.Text = "Sat"
                lblDay2.Text = "Sun"
                lblDay3.Text = "Mon"
                lblDay4.Text = "Tue"
                lblDay5.Text = "Wed"
                lblDay6.Text = "Thu"
                lblDay7.Text = "Fri"
            Case 7 ' Week Starts on Sunday
                'Calendar1.FirstDayOfWeek = System.Web.UI.WebControls.FirstDayOfWeek.Sunday
                lblDay1.Text = "Sun"
                lblDay2.Text = "Mon"
                lblDay3.Text = "Tue"
                lblDay4.Text = "Wed"
                lblDay5.Text = "Thu"
                lblDay6.Text = "Fri"
                lblDay7.Text = "Sat"
        End Select

    End Sub

    Private Sub LoadWeekTimes(ByVal Day As Date)

        Dim blnRejection As Boolean 'Variable used to indicate that at least one item has been rejected
        Dim dtProjEndDate As Date = Nothing   'Variable used to store the end date for each project 
        Dim blnExpand As Boolean = False

        Dim arParms3() As SqlParameter = New SqlParameter(2) {}
        arParms3(0) = New SqlParameter("@UserID", User.Identity.Name) ' Request.Cookies("AVMS_User").Values("UserID"))
        arParms3(1) = New SqlParameter("@StartDate", ViewState("FirstDay"))
        arParms3(2) = New SqlParameter("@Count", SqlDbType.Int)
        arParms3(2).Direction = ParameterDirection.Output
        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_SelectTimesheetSubmitted", arParms3)
        TimesheetSubmitted = arParms3(2).Value

        ' Check if there are any rejected items, if there are then the timesheet must be able to be resubmitted
        ' The TT_UpdateUserTimesheet Stored Proc will ensure that the Approvals get redone
        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_SelectTimesheetRejected", arParms3)
        RejectedTimesheet = arParms3(2).Value

        If TimesheetSubmitted > 0 And RejectedTimesheet = 0 Then
            ' If timesheet for this week has been submitted
            ' and there are no Rejected Items
            ' then the user can no longer make changes
            btnSubmit.Enabled = False
            btnSave.Enabled = False
            htmTasks.Disabled = True
            htmTimeOff.Disabled = True
            txtComment.Enabled = False
            txtComment.ReadOnly = True
            txtComment.CssClass = "TextAreaRO"
            'Otherwise Check if timesheet can be unsubmitted
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_SelectUserTimesheetApprovals", arParms3)
            ApprovalsExist = arParms3(2).Value
            If ApprovalsExist = 0 Then
                ' If no approvals have been done for this week then the user
                ' can recall the timesheet
                btnUnsubmit.Enabled = True
            End If
        Else
            ' Enable the relevant buttons
            btnUnsubmit.Enabled = False
            btnSubmit.Enabled = True
            btnSave.Enabled = True
            htmTasks.Disabled = False
            htmTimeOff.Disabled = False
            txtComment.Enabled = True
            txtComment.ReadOnly = False
            txtComment.CssClass = "TextArea"
        End If

        ' Check if the Timesheet has been Rejected, If so then Display the Rejection Comments Table
        ' and Load Rejection Comments

        Dim arParms2() As SqlParameter = New SqlParameter(2) {}
        arParms2(0) = New SqlParameter("@UserID", User.Identity.Name)
        arParms2(1) = New SqlParameter("@Date", Day)
        arParms2(2) = New SqlParameter("@TimeBase", ConfigurationSettings.AppSettings("TimeBase"))

        time_base.Value = ConfigurationSettings.AppSettings("TimeBase")

        DS = New DataSet
        DS = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "TT_SelectUserTimeSheet", arParms2)
        ' Name the tables
        DS.Tables(0).TableName = "Task"
        DS.Tables(1).TableName = "Project"
        ' Set up relationships
        DS.Relations.Add("Proj_Task", DS.Tables("Project").Columns("Project"), DS.Tables("Task").Columns("Project"))

        GTotDay1 = 0
        GTotDay2 = 0
        GTotDay3 = 0
        GTotDay4 = 0
        GTotDay5 = 0
        GTotDay6 = 0
        GTotDay7 = 0
        GTot = 0

        For Each projrow In DS.Tables("Project").Rows
            ' For each Project
            ' Clear Project Totals
            TotDay1 = 0
            TotDay2 = 0
            TotDay3 = 0
            TotDay4 = 0
            TotDay5 = 0
            TotDay6 = 0
            TotDay7 = 0
            RowTot = 0
            TaskTot = 0
            menucount += 1
            ' Create a new htmltable containing project header and totals
            ' Create the following table header
            '	<TR>
            ' 	<TH class="th4" id="menu2">
            '       <TABLE>
            '         <TR>
            '           <TH>
            '          		<IMG id="menu2a" style="LEFT: 0px; CURSOR: hand; TOP: 3px"
            '                 onclick = "ToggleDisplay(menu2a, menu2b, 'menu2');"
            ' 			          height="16" alt="" src="../Images/down.gif" width="16" align="right" vspace="0"
            ' 			          border="0">
            '              Project</TH>
            '           <TH>Day1Total</TH>
            '           <TH>Day2Total</TH>
            '           <TH>Day3Total</TH>
            '           <TH>Day4Total</TH>
            '           <TH>Day5Total</TH>
            '           <TH>Day6Total</TH>
            '           <TH>Day7Total</TH>
            '           <TH>TaskTotal</TH>
            '         </TR>
            '       </TABLE>
            ' 	</TH>
            ' </TR>
            row = New HtmlTableRow
            tbltime.Rows.Add(row)
            cell = New HtmlTableCell("td")
            row.Cells.Add(cell)
            cell.Attributes.Add("class", "td")
            cell.ID = "menu" & menucount
            cell.ColSpan = 9

            Table = New HtmlTable
            cell.Controls.Add(Table)
            Table.Attributes.Add("width", "100%")
            headerRow = New HtmlTableRow
            Table.Controls.Add(headerRow)
            ' Add header cells here
            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "4%")
            headerCell.Attributes.Add("class", "th2")
            img = New HtmlImage
            headerCell.Controls.Add(img)
            img.ID = "menu" & menucount & "a"
            img.Attributes.Add("onclick", "ToggleDisplay(" & cell.ID & "a, " & cell.ID & "b, '" & cell.ID & "');")
            img.Src = "../Images/down.gif"
            img.Attributes.Add("align", "right")
            img.Attributes.Add("Style", "LEFT: 0px; CURSOR: hand; TOP: 3px")

            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "32%")
            headerCell.Attributes.Add("class", "th2")
            headerCell.InnerHtml = projrow.Item("Project")

            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "8%")
            headerCell.Attributes.Add("class", "th2")
            txtbox = New HtmlInputText
            txtbox.ID = "txtDay1Tot" & "_" & projrow.Item("Project")
            txtbox.Value = projrow.Item("Day1Tot")
            txtbox.Attributes.Add("class", "inputTotal")
            txtbox.Attributes.Add("size", "8")
            txtbox.Attributes.Add("readonly", "true")
            headerCell.Controls.Add(txtbox)

            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "8%")
            headerCell.Attributes.Add("class", "th2")
            txtbox = New HtmlInputText
            txtbox.ID = "txtDay2Tot" & "_" & projrow.Item("Project")
            txtbox.Value = projrow.Item("Day2Tot")
            txtbox.Attributes.Add("class", "inputTotal")
            txtbox.Attributes.Add("size", "8")
            txtbox.Attributes.Add("readonly", "true")
            headerCell.Controls.Add(txtbox)

            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "8%")
            headerCell.Attributes.Add("class", "th2")
            txtbox = New HtmlInputText
            txtbox.ID = "txtDay3Tot" & "_" & projrow.Item("Project")
            txtbox.Value = projrow.Item("Day3Tot")
            txtbox.Attributes.Add("class", "inputTotal")
            txtbox.Attributes.Add("size", "8")
            txtbox.Attributes.Add("readonly", "true")
            headerCell.Controls.Add(txtbox)

            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "8%")
            headerCell.Attributes.Add("class", "th2")
            txtbox = New HtmlInputText
            txtbox.ID = "txtDay4Tot" & "_" & projrow.Item("Project")
            txtbox.Value = projrow.Item("Day4Tot")
            txtbox.Attributes.Add("class", "inputTotal")
            txtbox.Attributes.Add("size", "8")
            txtbox.Attributes.Add("readonly", "true")
            headerCell.Controls.Add(txtbox)

            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "8%")
            headerCell.Attributes.Add("class", "th2")
            txtbox = New HtmlInputText
            txtbox.ID = "txtDay5Tot" & "_" & projrow.Item("Project")
            txtbox.Value = projrow.Item("Day5Tot")
            txtbox.Attributes.Add("class", "inputTotal")
            txtbox.Attributes.Add("size", "8")
            txtbox.Attributes.Add("readonly", "true")
            headerCell.Controls.Add(txtbox)

            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "8%")
            headerCell.Attributes.Add("class", "th2")
            txtbox = New HtmlInputText
            txtbox.ID = "txtDay6Tot" & "_" & projrow.Item("Project")
            txtbox.Value = projrow.Item("Day6Tot")
            txtbox.Attributes.Add("class", "inputTotal")
            txtbox.Attributes.Add("size", "8")
            txtbox.Attributes.Add("readonly", "true")
            headerCell.Controls.Add(txtbox)

            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "8%")
            headerCell.Attributes.Add("class", "th2")
            txtbox = New HtmlInputText
            txtbox.ID = "txtDay7Tot" & "_" & projrow.Item("Project")
            txtbox.Value = projrow.Item("Day7Tot")
            txtbox.Attributes.Add("class", "inputTotal")
            txtbox.Attributes.Add("size", "8")
            txtbox.Attributes.Add("readonly", "true")
            headerCell.Controls.Add(txtbox)

            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("Width", "8%")
            headerCell.Attributes.Add("class", "th2")
            txtbox = New HtmlInputText
            txtbox.ID = "txtTotProj" & "_" & projrow.Item("Project")
            txtbox.Value = projrow.Item("TaskTot")
            txtbox.Attributes.Add("class", "inputTotal")
            txtbox.Attributes.Add("size", "8")
            txtbox.Attributes.Add("readonly", "true")
            headerCell.Controls.Add(txtbox)

            ' Create a new htmlrow containing the project task
            ' Create the following table details
            '<TR>
            '	<TD>
            '		<span id="menu2b" style="DISPLAY: none">
            '     <TABLE>
            row = New HtmlTableRow
            tbltime.Rows.Add(row)
            cell = New HtmlTableCell("td")
            row.Cells.Add(cell)
            spanlit = New HtmlGenericControl("Span")
            spanlit.ID = "menu" & menucount & "b"
            cell.Controls.Add(spanlit)
            cell.ColSpan = 9
            cell.Attributes.Add("class", "td")

            Table = New HtmlTable
            spanlit.Controls.Add(Table)
            Table.Attributes.Add("width", "100%")

            'Default that there are no rejected items therefore don't expand the div
            blnExpand = False

            For Each taskrow In projrow.GetChildRows("Proj_Task")

                'SD: 15/11/2005 - Store the project end date - this is used to determine if the endate is passed
                dtProjEndDate = IIf(taskrow.Item("ProjectEndDate") Is DBNull.Value, Nothing, taskrow.Item("ProjectEndDate"))

                ' For each task within a project
                ' Create the following table details
                '       <TR>
                '         <TD colspan=2>Taskname</TD>
                tasktableRow = New HtmlTableRow
                Table.Controls.Add(tasktableRow)
                If taskrow("Project") = "TimeOff" Then
                    strTaskID = "TO" & taskrow("TaskID")
                Else
                    strTaskID = taskrow("TaskID")
                End If
                tasktableRow.ID = "tr_" & strTaskID 'taskrow("TaskID")

                taskCell = New HtmlTableCell("td")
                tasktableRow.Controls.Add(taskCell)
                taskCell.Attributes.Add("Width", "4%")
                img = New HtmlImage
                taskCell.Controls.Add(img)
                img.ID = "imgDelete_" & taskrow("Project") & "_" & strTaskID 'taskrow("TaskID")
                If TimesheetSubmitted > 0 Then
                    ' Timesheet has been submitted, disable the deleteTask functionality
                    img.Src = "../Images/blank.gif"
                Else
                    img.Attributes.Add("onclick", "deleteItem(this);calc_total();")
                    img.Src = "../Images/delete.gif"
                End If
                img.Attributes.Add("align", "right")
                img.Attributes.Add("Style", "LEFT: 0px; CURSOR: hand; TOP: 3px")

                taskCell = New HtmlTableCell("td")
                tasktableRow.Cells.Add(taskCell)
                taskCell.Attributes.Add("Width", "32%")
                taskCell.ID = "lblTask_" & strTaskID 'taskrow("TaskID")
                taskCell.InnerText = taskrow("Task")
                taskCell.Attributes.Add("class", "label")

                For i = 1 To 7
                    ' for each day
                    '         <TD>DayX,DayXComment</TD>
                    taskCell = New HtmlTableCell("td")
                    tasktableRow.Cells.Add(taskCell)
                    taskCell.Attributes.Add("align", "center")
                    ' Add the time textbox
                    timetxtbox = New IMTextBox
                    taskCell.Attributes.Add("Width", "8%")
                    timetxtbox.ID = taskrow("Project") & "_" & strTaskID & "_" & "Day" & i
                    timetxtbox.Text = IIf(taskrow("Day" & i) = 0, String.Empty, taskrow("Day" & i)) 'SD:12/09/2005 - Show empty string if there is no value
                    timetxtbox.TextType = TextTypes.Decimal
                    timetxtbox.DecimalPlaces = 2
                    timetxtbox.MinValue = 0
                    timetxtbox.MaxValue = 24
                    timetxtbox.OnFocusFunction = "loadComment(this);"
                    taskCell.Controls.Add(timetxtbox)
                    If TimesheetSubmitted > 0 And RejectedTimesheet = 0 Then
                        ' Timesheet has been submitted, 
                        ' and no items are rejected
                        ' disable the deleteTask functionality
                        timetxtbox.Attributes.Add("class", "InputROR")
                        timetxtbox.Attributes.Add("readonly", "true")
                    Else
                        timetxtbox.Attributes.Add("class", "InputR")
                        timetxtbox.Attributes.Remove("readonly")
                    End If
                    'timetxtbox.Attributes.Add("onfocus", "loadComment(this);")
                    'timetxtbox.Attributes.Add("onblur", "calc_total();") 'SD: 06/10/2005 - Change to only calculate the relevant total - not all totals
                    timetxtbox.OnBlurFunction = "calc_ColumnTotal(this);"
                    timetxtbox.Attributes.Add("size", "6")
                    timetxtbox.Attributes.Add("type", "text")

                    ' Add the comment text into hidden field
                    txtbox = New HtmlInputText
                    taskCell.Controls.Add(txtbox)
                    ' Field id is Project_TaskID_DayxComment (TimeTrax_1_Day1Comment)
                    'txtbox.ID = taskrow("Project") & "_" & taskrow("TaskID") & "_" & "Day" & i & "Comment"
                    txtbox.ID = taskrow("Project") & "_" & strTaskID & "_" & "Day" & i & "Comment"
                    txtbox.Value = taskrow("Day" & i & "Comment")
                    txtbox.Attributes.Add("type", "hidden")

                    ' Add the Reject comment text into hidden field
                    txtbox = New HtmlInputText
                    taskCell.Controls.Add(txtbox)
                    ' Field id is Project_TaskID_DayxRejComment (TimeTrax_1_Day1RejComment)
                    'txtbox.ID = taskrow("Project") & "_" & taskrow("TaskID") & "_" & "Day" & i & "RejComment"
                    txtbox.ID = taskrow("Project") & "_" & strTaskID & "_" & "Day" & i & "RejComment"
                    txtbox.Value = taskrow("Day" & i & "RejComment")
                    ' If there is a reject comment then the reject comment row needs to be shown
                    ' and the Time Textbox must be marked red
                    If txtbox.Value <> "" Then
                        timetxtbox.Attributes.Add("style", "background-color:Red")
                        'tr_reject.Style.Item("Display") = "Block"

                        'SD: 13/09/2005 - Indicate that there is a rejection.  
                        'This is used later to set the DivReject to visible or not
                        'Setting the Divvisible here means that if you went from one time sheet with a rejected item 
                        'to an item without a rejection the div is still shown. 
                        blnRejection = True
                        blnExpand = True
                    Else
                        'timetxtbox.Attributes.Add("style", "background-color:White")

                        'SD: 15/11/2005 Determine if the date is after the project end date.  If yes - disable the text box
                        If dtProjEndDate = Nothing Or DateDiff(DateInterval.Day, dtProjEndDate, DateAdd(DateInterval.Day, i - 1, ViewState("FirstDay"))) <= 0 Then
                            timetxtbox.Enabled = True
                            timetxtbox.Attributes.Add("style", "background-color:White")
                        Else
                            timetxtbox.Enabled = False
                            timetxtbox.Attributes.Add("style", "background-color:#E9E8E6")
                        End If

                    End If

                    txtbox.Attributes.Add("type", "hidden")
                Next
                '         <TD>TaskTotal</TD>
                '       </TR>
                taskCell = New HtmlTableCell("th")
                tasktableRow.Cells.Add(taskCell)
                txtbox = New HtmlInputText
                taskCell.Controls.Add(txtbox)
                taskCell.Attributes.Add("Width", "8%")
                txtbox.ID = "txtTotTask_" & strTaskID 'taskrow("TaskID")
                txtbox.Value = Totals(taskrow("Day1"), taskrow("Day2"), taskrow("Day3"), taskrow("Day4"), taskrow("Day5"), taskrow("Day6"), taskrow("Day7"))
                txtbox.Attributes.Add("class", "inputROR")
                txtbox.Attributes.Add("size", "6")
                txtbox.Attributes.Add("readonly", "true")
                ' Add the task to the hidden box
                strValue &= "," & taskrow("Project") & ";" & strTaskID 'taskrow("TaskID")

            Next

            'If there was a rejection, expand this block
            If blnExpand Then
                spanlit.Attributes.Add("Style", "display:block;")
            Else
                spanlit.Attributes.Add("Style", "DISPLAY: none;")  'SD: 12/09/2005 - Default the display to closed
            End If


            '     </TABLE>
            '   </SPAN>
            ' </TD>
            '</TR>

            ' accumulate grand totals
            GrandTotals()
        Next

        'SD: 13/09/2005 - Set the reject comment div visible or invisible
        If blnRejection Then
            divReject.Style.Item("Display") = "Block"
        Else
            divReject.Style.Item("Display") = "None"
        End If

        hidBoxtask = New HtmlInputHidden
        hidBoxtask.ID = "hidBoxtasks"
        hidBoxtask.Value = strValue
        timePlace.Controls.Add(hidBoxtask)

        txtDay1Tot.Text = TotDay1
        txtDay2Tot.Text = TotDay2
        txtDay3Tot.Text = TotDay3
        txtDay4Tot.Text = TotDay4
        txtDay5Tot.Text = TotDay5
        txtDay6Tot.Text = TotDay6
        txtDay7Tot.Text = TotDay7
        txtTotal.Text = TaskTot
    End Sub

    Function Totals(ByVal Day1 As Decimal, ByVal Day2 As Decimal, ByVal Day3 As Decimal, ByVal Day4 As Decimal, ByVal Day5 As Decimal, ByVal Day6 As Decimal, ByVal Day7 As Decimal)
        ' Accumulates Project Totals
        TotDay1 += Day1
        TotDay2 += Day2
        TotDay3 += Day3
        TotDay4 += Day4
        TotDay5 += Day5
        TotDay6 += Day6
        TotDay7 += Day7
        RowTot = (Day1 + Day2 + Day3 + Day4 + Day5 + Day6 + Day7)
        TaskTot += RowTot
        Return RowTot
    End Function
    Sub GrandTotals()
        ' Accumulates Grand Totals
        GTotDay1 += TotDay1
        GTotDay2 += TotDay2
        GTotDay3 += TotDay3
        GTotDay4 += TotDay4
        GTotDay5 += TotDay5
        GTotDay6 += TotDay6
        GTotDay7 += TotDay7
        GTot += TaskTot
    End Sub

#End Region

#Region " SUBMIT DETAILS "

    Private Sub Calendar1_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Calendar1.SelectionChanged
        ' Load the relevant Weeks Times
        GetFirstDay(Calendar1.SelectedDate)
        hidTimesheetDate.Value = ViewState("FirstDay")
    End Sub

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ProcessTimesheet()
        DAL.SubmitTimeSheet(User.Identity.Name, ViewState("FirstDay"))
        'SubmitTimesheet()
        DAL.SubmitTimeOff(User.Identity.Name, ViewState("FirstDay"))
        'SubmitTimeOff()
        ' redirect to start page
        Response.Redirect("../default.aspx")

    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        ProcessTimesheet()
        ' Reload the Timesheet page
        GetFirstDay(ViewState("FirstDay"))

    End Sub

    Private Sub btnUnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUnsubmit.Click
        ' Mark submitted fields for all items for this timesheet week as null
        ' Note this button is only available if no approvals have been done for any items for this timesheet week
        ' see LoadWeekTimes subroutine
        DAL.RecallTimesheet(User.Identity.Name, ViewState("FirstDay"))

        ' Reload the Timesheet page
        GetFirstDay(ViewState("FirstDay"))

    End Sub

    Private Sub ProcessTimesheet()
        ' Handle Deleted Items
        ' Update the Timesheet
        Dim arParms() As SqlParameter = New SqlParameter(1) {}
        Dim arParms2() As SqlParameter = New SqlParameter(5) {}
        Dim ForDate As Date = ViewState("FirstDay")
        Dim ItemNo, Task, delTask, TaskID As String
        Dim a, b, x, NoRows As Integer
        Dim arrData, TaskArray, taskData, delData As Array
        Dim Proj As String
        Dim TimeOff As Boolean

        a = 0
        NoRows = 0
        ItemNo = ""
        ItemNo = Request.Form("hidBoxtasks")
        If ItemNo <> "" And ItemNo <> "," Then
            Try
                TaskArray = ItemNo.Split(",")
                NoRows = (TaskArray.Length - 1)
            Catch
            End Try

            While a < NoRows
                a += 1
                ' For each Task
                ItemNo = TaskArray(a)
                arrData = ItemNo.Split(";")
                Proj = arrData(0)
                TaskID = arrData(1)

                ' check if the task id is in the deleted list
                Task = Request.Form("deleted_list")
                delData = Task.Split(",")
                delTask = ""
                x = 0
                While x < (delData.Length - 1)
                    ' Get the Task Id from the value (imgDelete_X)
                    ItemNo = delData(x)
                    taskData = ItemNo.Split("_")
                    If taskData(2) = TaskID Then
                        delTask = TaskID
                        Exit While
                    End If
                    x += 1
                End While
                ' If taskid is in the delete list then delete the task from the timesheet
                If delTask <> "" Then
                    ' Delete the task from the timesheet
                    If TaskID.StartsWith("TO") Then
                        ' TimeOff Item
                        Dim Len As Int16 = TaskID.Length
                        Dim TypeID As String = TaskID.Substring(2, (Len - 2))
                        DAL.DeleteTimeOff(User.Identity.Name, TypeID)
                    Else
                        ' Timesheet Item
                        DAL.DeleteTimesheet(User.Identity.Name, TaskID)
                    End If
                Else
                    ' Insert or Update the Task
                    For b = 0 To 6
                        ' For Each Day in the row
                        Dim Hours As String = IIf(Request.Form(Proj & "_" & TaskID & "_Day" & (b + 1)) = "", 0, Request.Form(Proj & "_" & TaskID & "_Day" & (b + 1)))
                        Dim Comment As String = IIf(Request.Form(Proj & "_" & TaskID & "_Day" & (b + 1) & "Comment") = "", "", Request.Form(Proj & "_" & TaskID & "_Day" & (b + 1) & "Comment"))
                        If TaskID.StartsWith("TO") Then
                            ' TimeOff Item
                            Dim Len As Int16 = TaskID.Length
                            Dim TypeID As String = TaskID.Substring(2, (Len - 2))
                            DAL.UpdateTimeOff(User.Identity.Name, ConfigurationSettings.AppSettings("TimeBase"), TypeID, DateAdd(DateInterval.Day, b, ForDate), Hours, Comment)
                        Else
                            ' Timesheet Item
                            DAL.UpdateTimesheet(User.Identity.Name, ConfigurationSettings.AppSettings("TimeBase"), TaskID, DateAdd(DateInterval.Day, b, ForDate), Hours, Comment)
                        End If
                    Next
                End If
            End While
        End If
    End Sub

    'Private Sub ProcessDeletedItems()
    '    Dim Task As String
    '    Dim taskData, delData As Array
    '    Dim x, TaskID, delTask, NoRows As Integer


    '    ' check if the task id is in the deleted list
    '    Task = Request.Form("deleted_list")
    '    delData = Task.Split(",")
    '    delTask = 0
    '    x = 0
    '    While x < (delData.Length - 1)
    '        ' Get the Task Id from the value (imgDelete_X)
    '        ItemNo = delData(x)
    '        taskData = ItemNo.Split("_")
    '        If taskData(2) = TaskID Then
    '            delTask = TaskID
    '            Exit While
    '        End If
    '        x += 1
    '    End While
    '    ' If taskid is in the delete list then delete the task from the timesheet
    '    If delTask <> 0 Then
    '        ' Delete the task from the timesheet
    '        arParms(0) = New SqlParameter("@UserID", User.Identity.Name)
    '        arParms(1) = New SqlParameter("@TaskID", TaskID)
    '        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_DeleteUserTimeSheet", arParms)
    '    End If

    '    'Dim strData As String
    '    'Dim a As Int16 = 0
    '    'strData = Request.Form("hidDeleted")
    '    'Dim Rows As Int16 = 0
    '    'Dim arrTemp As Array
    '    'Dim LineItemID As Int16
    '    'Dim SubItemID As Int16

    '    'If strData <> "" Then
    '    '    Dim arrData As Array = strData.Split(",")
    '    '    Rows = (arrData.Length - 1)
    '    '    While a < Rows
    '    '        '' Get LineItemID and SubItemID
    '    '        LineItemID = 0
    '    '        SubItemID = 0

    '    '        arrTemp = arrData(a).Split("#")
    '    '        LineItemID = arrTemp(1)
    '    '        SubItemID = arrTemp(2)

    '    '        If LineItemID <> 0 And SubItemID <> 0 Then
    '    '            '' Get ItemID from FullyQualifiedName
    '    '            Dim FQN As String = DAL.GetFQNfromItemID(Session("ItemID"))

    '    '            ' Insert a BudgetItem record
    '    '            DAL.DeleteBudgetItem(Session("ScenarioID"), SubItemID, FQN, Session("VoteID"), Common.GetCurrentFinYear())
    '    '        End If
    '    '        a += 1
    '    '    End While
    '    'End If
    'End Sub

    'Private Sub SubmitTimesheet()
    '    Dim arParms3() As SqlParameter = New SqlParameter(1) {}
    '    arParms3(0) = New SqlParameter("@UserID", User.Identity.Name)
    '    arParms3(1) = New SqlParameter("@StartDate", ViewState("FirstDay"))
    '    SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_SubmitUserTimesheet", arParms3)

    'End Sub

    'Private Sub SubmitTimeOff()
    '    Dim arParms3() As SqlParameter = New SqlParameter(1) {}
    '    arParms3(0) = New SqlParameter("@UserID", User.Identity.Name)
    '    arParms3(1) = New SqlParameter("@StartDate", ViewState("FirstDay"))
    '    SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_SubmitUserTimeOff", arParms3)

    'End Sub
#End Region

End Class
