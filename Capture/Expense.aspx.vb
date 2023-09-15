Public Class Expense
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents timePlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents imgDeletetime_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents tbltime As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents tbltimefoot As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents Calendar1 As System.Web.UI.WebControls.Calendar
    Protected WithEvents btnSave As System.Web.UI.WebControls.Button
    Protected WithEvents htmProjects As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents txtTotal As System.Web.UI.WebControls.TextBox
    Protected WithEvents listPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents CustomValidator1 As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents hidExpenseDate As System.Web.UI.HtmlControls.HtmlInputHidden

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
    Dim ExpensesSubmitted As Int16
    Dim RejectedExpenses As Int16
    Dim ApprovalsExist As Int16
    Dim hidBoxexpense As HtmlInputHidden
    Dim hidBox As HtmlInputHidden
    Dim ddlExpenseType_ As DropDownList
    Dim i As Integer
    Dim strValue As String
    Dim strRows As String
    Dim DS As DataSet
    Dim RowTot As Decimal
    Dim ProjTot As Decimal
    Dim GTot As Decimal
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        UserLogin.CheckUserAccess("8", Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Expenses"
            Session("PageTitle") = Session("AppName") & " - Capture Expenses"

            'If no expense date is passed in then use today's date else use the expense month
            If Request.QueryString("ExpenseMonth") = String.Empty Then
                LoadMonthExpenses(Today())
                hidExpenseDate.Value = Format(Today, "dd/MM/yyyy")
            Else
                LoadMonthExpenses(Request.QueryString("ExpenseMonth"))
                hidExpenseDate.Value = Format(Request.QueryString("ExpenseMonth"), "dd/MM/yyyy")
            End If
        End If
    End Sub
    Private Sub LoadMonthExpenses(ByVal Day As Date)
        ' LoadSystemData()
        DR = DAL.LoadSystemData() 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectSystem")
        If DR.Read() Then
            ' Set the WeekStartDay 1:Monday, 7:Sunday
            ViewState("StartDay") = DR.Item("WeekStartDay")
        End If
        DR.Close()


        Dim FirstDay As DateTime
        Dim LastDay As DateTime
        FirstDay = Day.Month & "/01/" & Day.Year
        LastDay = Common.LastOfMonth(Day)
        ViewState("FirstDay") = FirstDay

        'Set Week Start Day
        '1: Monday .. 7:Sunday
        Calendar1.FirstDayOfWeek = ViewState("StartDay")
        ' Clear any selected dates.
        Calendar1.SelectedDates.Clear()
        ' Select the specified range of dates.
        Calendar1.SelectedDates.SelectRange(FirstDay, LastDay)
        Calendar1.VisibleDate = Day

        Dim arParms3() As SqlParameter = New SqlParameter(2) {}
        arParms3(0) = New SqlParameter("@UserID", User.Identity.Name)
        arParms3(1) = New SqlParameter("@StartDate", ViewState("FirstDay"))
        arParms3(2) = New SqlParameter("@Count", SqlDbType.Int)
        arParms3(2).Direction = ParameterDirection.Output
        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_SelectExpensesSubmitted", arParms3)
        ExpensesSubmitted = arParms3(2).Value

        ' Check if there are any rejected items, if there are then the Expenses must be able to be resubmitted
        ' The TT_UpdateUserExpense Stored Proc will ensure that the Approvals get redone
        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_SelectExpensesRejected", arParms3)
        RejectedExpenses = arParms3(2).Value

        If ExpensesSubmitted > 0 And RejectedExpenses = 0 Then
            ' If Expenses for this month have been submitted
            ' and there are no Rejected Items
            ' then the user can no longer make changes
            btnSubmit.Enabled = False
            btnSave.Enabled = False
            htmProjects.Disabled = True
        Else
            ' Enable the relevant buttons
            btnSubmit.Enabled = True
            btnSave.Enabled = True
            htmProjects.Disabled = False
        End If

        Dim ClientTable As HtmlTable = New HtmlTable
        Dim ProjTable As HtmlTable = New HtmlTable
        Dim ProjectsTable As HtmlTable = New HtmlTable
        Dim Table As HtmlTable = New HtmlTable
        Dim tblHead As HtmlTable = New HtmlTable
        Dim row As HtmlTableRow = New HtmlTableRow
        Dim headerRow As HtmlTableRow = New HtmlTableRow
        Dim Hidden As HtmlInputHidden
        Dim dynAdd As String
        Dim dynAddRow As HtmlTableRow = New HtmlTableRow
        Dim Clientcell As HtmlTableCell = New HtmlTableCell
        Dim cell As HtmlTableCell = New HtmlTableCell
        Dim headerCell As HtmlTableCell = New HtmlTableCell
        Dim dynAddCell As HtmlTableCell = New HtmlTableCell
        Dim txtbox As HtmlInputText = New HtmlInputText
        Dim rfv As RequiredFieldValidator = New RequiredFieldValidator
        Dim lbl As Label = New Label
        Dim img As HtmlImage
        Dim div As HtmlGenericControl
        'Dim ddl As DropDownList
        Dim clientrow As DataRow
        Dim projrow As DataRow
        Dim expenserow As DataRow
        Dim menucount As Integer = 0
        Dim clientcount As Integer = 0
        Dim RowCount As Integer = 0
        Dim spanlit As HtmlGenericControl
        Dim arParms2() As SqlParameter = New SqlParameter(1) {}
        arParms2(0) = New SqlParameter("@UserID", User.Identity.Name)
        arParms2(1) = New SqlParameter("@StartDate", ViewState("FirstDay")) 'Day)

        DS = New DataSet
        DS = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "TT_SelectUserExpenses", arParms2)
        ' Name the tables
        DS.Tables(0).TableName = "Client"
        DS.Tables(1).TableName = "Project"
        DS.Tables(2).TableName = "Expense"
        ' Set up relationships
        'DS.Relations.Add("Client_Proj", DS.Tables("Client").Columns("ClientID"), DS.Tables("Project").Columns("ClientID"))

        'SB: 02/08/2005 - Relationship should be on client ID else we end up with the client being returned multiple times
        'DS.Relations.Add("Client_Proj", DS.Tables("Client").Columns("KeyVal"), DS.Tables("Project").Columns("KeyVal"))
        DS.Relations.Add("Client_Proj", DS.Tables("Client").Columns("ClientID"), DS.Tables("Project").Columns("ClientID"))
        DS.Relations.Add("Proj_Expense", DS.Tables("Project").Columns("ProjectID"), DS.Tables("Expense").Columns("ProjectID"))

        GTot = 0
        tbltime.Rows.Clear()

        'AddHeaderRow()
        '<tr>
        row = New HtmlTableRow
        tbltime.Rows.Add(row)
        ' <td>
        Clientcell = New HtmlTableCell("td")
        row.Cells.Add(Clientcell)
        ' <table tblHead width=100%>
        tblHead = New HtmlTable
        Clientcell.Controls.Add(tblHead)
        tblHead.CellPadding = 0
        tblHead.CellSpacing = 0
        tblHead.Width = "100%"
        '   <tr>
        row = New HtmlTableRow
        tblHead.Rows.Add(row)
        '	<th class="th1" width="4%">&nbsp;</th>
        Clientcell = New HtmlTableCell("th")
        row.Cells.Add(Clientcell)
        Clientcell.Attributes.Add("class", "th1")
        Clientcell.Width = "6%"
        Clientcell.InnerHtml = "&nbsp;"
        '	<th class="th1" width="12%">Date</th>
        Clientcell = New HtmlTableCell("th")
        row.Cells.Add(Clientcell)
        Clientcell.Attributes.Add("class", "th1")
        Clientcell.Width = "18%"
        Clientcell.InnerText = "Date"
        '	<th class="th1" width="34%">Comment</th>
        Clientcell = New HtmlTableCell("th")
        row.Cells.Add(Clientcell)
        Clientcell.Attributes.Add("class", "th1")
        Clientcell.Width = "24%"
        Clientcell.InnerText = "Comment"
        '	<th class="th1" width="35%">Expense Type</th>
        Clientcell = New HtmlTableCell("th")
        row.Cells.Add(Clientcell)
        Clientcell.Attributes.Add("class", "th1")
        Clientcell.Width = "26%"
        Clientcell.InnerText = "Expense Type"
        '	<th class="th1" width="5%">Quantity</th>
        Clientcell = New HtmlTableCell("th")
        row.Cells.Add(Clientcell)
        Clientcell.Attributes.Add("class", "th1")
        Clientcell.Width = "6%"
        Clientcell.InnerText = "Qty"
        '	<th class="th1" width="10%">Cost</th>
        Clientcell = New HtmlTableCell("th")
        row.Cells.Add(Clientcell)
        Clientcell.Attributes.Add("class", "th1")
        Clientcell.Width = "10%"
        Clientcell.InnerText = "Cost"
        '	<th class="th1" width="15%">Total</th>
        Clientcell = New HtmlTableCell("th")
        row.Cells.Add(Clientcell)
        Clientcell.Attributes.Add("class", "th1")
        Clientcell.Width = "10%"
        Clientcell.InnerText = "Total"
        '</tr>

        For Each clientrow In DS.Tables("Client").Rows
            ' For each Client
            ' Clear Project Totals
            RowTot = 0
            ProjTot = 0
            RowCount = 0
            strRows = ""
            menucount += 1
            ' Create a new htmltable containing Client header and Total
            '	<TR>
            row = New HtmlTableRow
            tbltime.Rows.Add(row)
            ' 	<TH class="th4" id="menu2">
            Clientcell = New HtmlTableCell("td")
            row.Cells.Add(Clientcell)
            Clientcell.Attributes.Add("class", "td")
            Clientcell.ID = "menu" & menucount
            Clientcell.ColSpan = 5
            '       <TABLE id=dynAdd>
            ClientTable = New HtmlTable
            Clientcell.Controls.Add(ClientTable)
            ClientTable.Attributes.Add("width", "100%")
            ClientTable.Attributes.Add("border", "0")
            '      dynAdd = "a" & clientrow.Item("ClientID") & clientrow.Item("ProjectID")
            '         <TR>
            headerRow = New HtmlTableRow
            ClientTable.Controls.Add(headerRow)
            '           <TH class=th1 width=50% colspan=4>
            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("class", "th2")
            headerCell.Attributes.Add("Width", "86%")
            '      headerCell.ColSpan = 5
            headerCell.InnerHtml = clientrow.Item("Client")
            '           <TH class=th1 width=4%>
            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("class", "th2")
            headerCell.Attributes.Add("Width", "4%")
            ''          		<IMG src="../Images/add.gif" width="16" height="16" align="left" vspace="0"
            '' 			          border="0"
            ''                 onclick='addFormSection('ClientIDProjectID',document.Form1);'>
            ''              Client - Project</TH>
            img = New HtmlImage
            headerCell.Controls.Add(img)
            img.ID = "menu" & menucount & "a"
            img.Attributes.Add("onclick", "ToggleDisplay(" & Clientcell.ID & "a, " & Clientcell.ID & "b, '" & Clientcell.ID & "');")
            img.Src = "../Images/up.gif"
            img.Attributes.Add("align", "left")
            img.Attributes.Add("Style", "LEFT: 0px; CURSOR: hand; TOP: 3px")
            '           <TH class=th1 width=15%>ClientTotal</TH>
            headerCell = New HtmlTableCell("th")
            headerRow.Controls.Add(headerCell)
            headerCell.Attributes.Add("class", "th2")
            headerCell.Attributes.Add("Width", "10%")
            txtbox = New HtmlInputText
            txtbox.ID = "txtTotClient" & "_" & clientrow.Item("ClientID")
            txtbox.Value = 0 'clientrow.Item("ClientTot")
            txtbox.Attributes.Add("class", "inputROR")
            txtbox.Attributes.Add("size", "8")
            txtbox.Attributes.Add("readonly", "true")
            headerCell.Controls.Add(txtbox)

            '         </TR>
            '       </TABLE>
            ' 	</TH>
            ' </TR>

            'i = 0  'SB: 03/08/2005 - moved to inside the project loop

            'For Each projrow In clientrow.GetChildRows("Client_Proj")  - 'SB moved futher down

            'SB: 02/08/2005 - The menu2b span must only occur once per client therefore it has been 
            'moved to outside the project loop.
            ' Create a new htmltable containing Project header and Total
            '	<TR>
            row = New HtmlTableRow
            ClientTable.Rows.Add(row)

            'Add TD
            '	<TD colspan=3>
            cell = New HtmlTableCell("td")
            cell.ColSpan = 3
            row.Cells.Add(cell)

            'Add Span
            '		<span id="menu2b" style="DISPLAY: block">
            spanlit = New HtmlGenericControl("Span")
            spanlit.ID = "menu" & menucount & "b"
            spanlit.Attributes.Add("Style", "display:block;")
            cell.Controls.Add(spanlit)

            'Add a table
            '       <TABLE>
            ProjectsTable = New HtmlTable
            'spanlit.Controls.Add(ProjTable)
            'cell.Controls.Add(ProjTable)
            ProjectsTable.Attributes.Add("width", "100%")
            ProjectsTable.Attributes.Add("border", "0")
            ProjectsTable.CellSpacing = 0
            ProjectsTable.CellPadding = 0
            row.Cells.Add(cell)
            spanlit.Controls.Add(ProjectsTable)

            '' 	<TH class="th4" id="menu2">
            'cell = New HtmlTableCell("td")
            'row.Cells.Add(cell)
            'cell.Attributes.Add("class", "td")
            'cell.ColSpan = 5

            ''		<span id="menu2b" style="DISPLAY: block">
            'spanlit = New HtmlGenericControl("Span")
            'spanlit.ID = "menu" & menucount & "b"
            'spanlit.Attributes.Add("Style", "display:block;")
            'cell.Controls.Add(spanlit)
            'cell.ColSpan = 8
            ''cell.ID = "menu" & (menucount + 1)
            ''menucount += 1
            ''cell.ID = "menu" & menucount

            For Each projrow In clientrow.GetChildRows("Client_Proj")

                '	<TR>
                row = New HtmlTableRow
                row.ID = "trProj_" & projrow.Item("ProjectID") 'SB: 11/08/2005 - Give the row an id so that it can be hidden
                ProjectsTable.Rows.Add(row)


                ' 	<TD class="td" colspan=5>
                cell = New HtmlTableCell("td")
                row.Cells.Add(cell)
                cell.Attributes.Add("class", "td")
                cell.ColSpan = 5

                cell.ID = "menu" & (menucount + 1)
                i = 0
                menucount += 1

                '       <TABLE id=dynAdd>
                ProjTable = New HtmlTable
                cell.Controls.Add(ProjTable)
                'cell.Controls.Add(ProjTable)
                ProjTable.Attributes.Add("width", "100%")
                ProjTable.Attributes.Add("border", "0")
                dynAdd = "a" & projrow.Item("ProjectID")
                '         <TR>
                headerRow = New HtmlTableRow
                ProjTable.Controls.Add(headerRow)
                '           <TH class=th1 width=4%>
                headerCell = New HtmlTableCell("th")
                headerRow.Controls.Add(headerCell)
                headerCell.Attributes.Add("class", "th3")
                headerCell.Attributes.Add("Width", "4%")
                headerCell.Attributes.Add("valign", "Middle")  'SB: 02/08/2005 - set vertical alignment
                '          		<IMG src="../Images/add.gif" width="16" height="16" align="left" vspace="0"
                ' 			          border="0"
                '                 onclick='addFormSection('ClientIDProjectID',document.Form1);'>
                '              Client - Project</TH>
                img = New HtmlImage
                headerCell.Controls.Add(img)
                img.ID = "imgAdd" & dynAdd & "_"
                img.Attributes.Add("onclick", "tryAdd('" & dynAdd & "', document.Form1);")
                'img.Attributes.Add("onload", "cashlist('" & dynAdd & "');") 'SD: 12/10/2005 - No longer load here but on page load
                img.Src = "../Images/add.gif"
                img.Attributes.Add("align", "left")
                img.Attributes.Add("valign", "Middle")  'SB: 02/08/2005 - set vertical alignment
                img.Attributes.Add("Style", "LEFT: 0px; CURSOR: hand; TOP: 3px")
                img.Alt = "Add expense to this project"
                ' Delete Project
                img = New HtmlImage
                headerCell.Controls.Add(img)
                img.ID = "imgDel_" & projrow.Item("ProjectID")
                img.Attributes.Add("onclick", "projDelete(this);")
                img.Src = "../Images/delete.gif"
                img.Attributes.Add("align", "right")
                img.Attributes.Add("valign", "Middle")  'SB: 02/08/2005 - set vertical alignment
                img.Attributes.Add("Style", "RIGHT: 0px; CURSOR: hand; TOP: 3px")
                img.Alt = "Remove this project"
                '           <TH class=th1 width=50% colspan=4>
                headerCell = New HtmlTableCell("th")
                headerRow.Controls.Add(headerCell)
                headerCell.Attributes.Add("class", "th3")
                headerCell.Attributes.Add("Width", "82%")
                headerCell.ColSpan = 5
                headerCell.InnerHtml = projrow.Item("Project")
                '           <TH width=35% colspan=3>
                headerCell = New HtmlTableCell("th")
                headerRow.Controls.Add(headerCell)
                headerCell.Attributes.Add("class", "th3")
                ''headerCell.Attributes.Add("Width", "35%")
                ''headerCell.ColSpan = 3
                '          		<IMG id="menu2a" style="LEFT: 0px; CURSOR: hand; TOP: 3px"
                '                 onclick = "ToggleDisplay(menu2a, menu2b, 'menu2');"
                ' 			          height="16" alt="" src="../Images/down.gif" width="16" align="right" vspace="0"
                ' 			          border="0">
                '           </TH>
                img = New HtmlImage
                headerCell.Controls.Add(img)
                img.ID = "menu" & menucount & "a"
                img.Attributes.Add("onclick", "ToggleDisplay(" & cell.ID & "a, " & cell.ID & "b, '" & cell.ID & "');")
                img.Src = "../Images/up.gif"
                img.Attributes.Add("align", "left")
                img.Attributes.Add("Style", "LEFT: 0px; CURSOR: hand; TOP: 3px")
                '           <TH class=th1 width=15%>ProjectTotal</TH>
                headerCell = New HtmlTableCell("th")
                headerRow.Controls.Add(headerCell)
                headerCell.Attributes.Add("class", "th3")
                'headerCell.Attributes.Add("Width", "14%")
                txtbox = New HtmlInputText
                txtbox.ID = "txtTotProj" & "_" & projrow.Item("ProjectID")
                txtbox.Value = 0 'clientrow.Item("TaskTot")
                txtbox.Attributes.Add("class", "inputROR")
                txtbox.Attributes.Add("size", "8")
                txtbox.Attributes.Add("readonly", "true")
                headerCell.Controls.Add(txtbox)
                ' Create a new htmltable
                '<TR>
                row = New HtmlTableRow
                ProjTable.Rows.Add(row)
                '	<TD>
                cell = New HtmlTableCell("td")
                row.Cells.Add(cell)
                '		<span id="menu2b" style="DISPLAY: block">
                spanlit = New HtmlGenericControl("Span")
                spanlit.ID = "menu" & menucount & "b"
                spanlit.Attributes.Add("Style", "display:block;")
                cell.Controls.Add(spanlit)
                cell.ColSpan = 8
                '     <TABLE>
                Table = New HtmlTable
                spanlit.Controls.Add(Table)
                Table.Attributes.Add("width", "100%")
                Table.ID = "tbl" & dynAdd
                Table.Attributes.Add("name", "tbl" & dynAdd)

                ' Create a new htmlrow containing the DefaultA dynamicAdd row
                '       <TR>
                dynAddRow = New HtmlTableRow
                Table.Controls.Add(dynAddRow)
                dynAddRow.ID = "row" & dynAdd & "DefaultA"
                dynAddRow.Attributes.Add("style", "Display:none")
                dynAddRow.Attributes.Add("vAlign", "top")
                '			<td Width="8%">
                dynAddCell = New HtmlTableCell("td")
                dynAddRow.Controls.Add(dynAddCell)
                dynAddCell.Attributes.Add("Width", "4%")
                '     <img src="../Images/delete.gif" alt="Delete this expense" id="imgDeletedynAdd_" onclick="deleteFormSection('dynAdd', this, document.Form1);" align="right" Style="LEFT: 0px; CURSOR: hand; TOP: 3px" /></td>
                img = New HtmlImage
                dynAddCell.Controls.Add(img)
                img.ID = "imgDelete" & dynAdd & "_"
                img.Attributes.Add("Name", "imgDelete" & dynAdd & "_")
                If ExpensesSubmitted > 0 And RejectedExpenses = 0 Then
                    ' Expense has been submitted and there are no rejected items,
                    ' disable the delete functionality
                    img.Src = "../Images/blank.gif"
                Else
                    img.Attributes.Add("onclick", "loadDeleted(this);deleteFormSection('" & dynAdd & "',this,document.Form1);calc_total();")
                    img.Src = "../Images/delete.gif"
                End If
                img.Attributes.Add("align", "right")
                img.Attributes.Add("Style", "LEFT: 0px; CURSOR: hand; TOP: 3px")
                img.Alt = "Delete this expense"

                '         <TD colspan=2>Date</TD>
                '<td class="td4"><asp:textbox id="txtDate" runat="server" CssClass="input" Width="100"></asp:textbox>
                dynAddCell = New HtmlTableCell("td")
                dynAddRow.Cells.Add(dynAddCell)
                dynAddCell.Attributes.Add("Width", "12%")
                'Hidden box to contain ExpenseID
                hidBox = New HtmlInputHidden
                hidBox.ID = "hidExpID" & dynAdd & "_"
                dynAddCell.Controls.Add(hidBox)

                'SD: 10/10/2005 - Have a hidden text box indicating indicating if the expense is submitted
                hidBox = New HtmlInputHidden
                hidBox.ID = "hidExpSubmit" & dynAdd & "_"
                dynAddCell.Controls.Add(hidBox)

                txtbox = New HtmlInputText
                dynAddCell.Controls.Add(txtbox)
                txtbox.ID = "txtDate" & dynAdd & "_"
                txtbox.Attributes.Add("Width", "100%")
                If ExpensesSubmitted > 0 And RejectedExpenses = 0 Then
                    ' Expense has been submitted and no items are rejected
                    ' disable the field
                    txtbox.Attributes.Add("class", "InputRO")
                    txtbox.Attributes.Add("readonly", "true")
                Else
                    txtbox.Attributes.Add("class", "Input")
                    txtbox.Attributes.Remove("readonly")
                    txtbox.Attributes.Add("onblur", "ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);")
                End If
                '	<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
                '	<div id="divDate" style="POSITION: absolute"></div>
                div = New HtmlGenericControl
                dynAddCell.Controls.Add(div)
                div.ID = "divDate" & dynAdd & "_"
                div.Attributes.Add("Style", "POSITION: absolute")

                '	<IMG id="Date_" style="CURSOR: hand" onclick="imcalendar.select(document.Form1.txtDate, 'divDate', 'dd/MM/yyyy'); return false;"
                '		src="../images/CALENDAR.GIF" border="0" name="Date" runat="server">
                img = New HtmlImage
                dynAddCell.Controls.Add(img)
                img.ID = "Date" & dynAdd & "_"
                If ExpensesSubmitted > 0 And RejectedExpenses = 0 Then
                    ' Expense has been submitted and there are no rejected items,
                    ' disable the delete functionality
                    img.Src = "../Images/blank.gif"
                Else
                    '          img.Attributes.Add("onclick", "imcalendar.select(document.Form1.txtDate" & dynAdd & "_,'divDate" & dynAdd & "_','dd/MM/yyyy');return false;")
                    img.Attributes.Add("onclick", "calendar(this);")
                    img.Src = "../Images/calendar.gif"
                End If
                img.Attributes.Add("Style", "CURSOR: hand")
                img.Alt = "Show popup calendar"

                '         <TD>Comment</TD>
                dynAddCell = New HtmlTableCell("td")
                dynAddRow.Cells.Add(dynAddCell)
                dynAddCell.Attributes.Add("align", "center")
                dynAddCell.Attributes.Add("Width", "34%")
                ' Add the comment textbox
                txtbox = New HtmlInputText
                dynAddCell.Controls.Add(txtbox)
                txtbox.ID = "txtComment" & dynAdd & "_"
                If ExpensesSubmitted > 0 And RejectedExpenses = 0 Then
                    ' Expense has been submitted and there are no rejected items,
                    ' disable the deleteTask functionality
                    txtbox.Attributes.Add("class", "InputRO")
                    txtbox.Attributes.Add("readonly", "true")
                Else
                    txtbox.Attributes.Add("class", "Input")
                    txtbox.Attributes.Remove("readonly")
                End If
                'txtbox.Attributes.Add("onfocus", "loadProject(this);")
                txtbox.Attributes.Add("type", "text")
                txtbox.Attributes.Add("Width", "100%")

                '         <TD>Expense Type</TD>
                dynAddCell = New HtmlTableCell("td")
                dynAddRow.Cells.Add(dynAddCell)
                dynAddCell.Attributes.Add("align", "center")
                dynAddCell.Attributes.Add("Width", "35%")
                '' Add the type DropList
                Dim ddl As New DropDownList
                dynAddCell.Controls.Add(ddl)
                ddl.ID = "ddlExpenseType" & dynAdd & "_"
                ddl.Attributes.Add("class", "Select")
                LoadDropList(ddl)
                If ExpensesSubmitted > 0 And RejectedExpenses = 0 Then
                    ' Expenses have been submitted and there are no rejected items,
                    ' disable the field
                    ddl.Attributes.Add("readonly", "true")
                    ddl.Enabled = False
                Else
                    ddl.Attributes.Add("class", "Select")
                    ddl.Attributes.Remove("readonly")
                    ddl.Enabled = True
                End If
                ddl.Attributes.Add("onChange", "checkIfFixed(this);")
                '         <TD>Quantity</TD>
                dynAddCell = New HtmlTableCell("td")
                dynAddRow.Cells.Add(dynAddCell)
                dynAddCell.Attributes.Add("align", "center")
                dynAddCell.Attributes.Add("Width", "5%")
                ' Add the time textbox
                txtbox = New HtmlInputText
                dynAddCell.Controls.Add(txtbox)
                txtbox.ID = "txtQty" & dynAdd & "_"
                If ExpensesSubmitted > 0 And RejectedExpenses = 0 Then
                    ' Expenses have been submitted and there are no rejected items, 
                    ' disable the deleteTask functionality
                    txtbox.Attributes.Add("class", "InputROR")
                    txtbox.Attributes.Add("readonly", "true")
                Else
                    txtbox.Attributes.Add("class", "InputR")
                    txtbox.Attributes.Remove("readonly")
                End If
                txtbox.Attributes.Add("size", "5")
                ' txtbox.Attributes.Add("onfocus", "loadProject(this);")
                txtbox.Attributes.Add("onblur", "ValidateDisplayDecimal(this);calc_total();")
                txtbox.Attributes.Add("type", "text")
                '         <TD>Cost</TD>
                dynAddCell = New HtmlTableCell("td")
                dynAddRow.Cells.Add(dynAddCell)
                dynAddCell.Attributes.Add("align", "center")
                dynAddCell.Attributes.Add("Width", "10%")
                ' Add the time textbox
                txtbox = New HtmlInputText
                dynAddCell.Controls.Add(txtbox)
                txtbox.ID = "txtCost" & dynAdd & "_"
                If ExpensesSubmitted > 0 And RejectedExpenses = 0 Then
                    ' Expenses have been submitted and there are no rejected items,
                    ' disable the deleteTask functionality
                    txtbox.Attributes.Add("class", "InputROR")
                    txtbox.Attributes.Add("readonly", "true")
                Else
                    txtbox.Attributes.Add("class", "InputR")
                    txtbox.Attributes.Remove("readonly")
                End If
                txtbox.Attributes.Add("size", "10")
                ' txtbox.Attributes.Add("onfocus", "loadProject(this);")
                txtbox.Attributes.Add("onblur", "ValidateDisplayDecimal(this);calc_total();")
                txtbox.Attributes.Add("type", "text")

                '         <TD>TaskTotal</TD>
                dynAddCell = New HtmlTableCell("td")
                dynAddRow.Cells.Add(dynAddCell)
                txtbox = New HtmlInputText
                dynAddCell.Controls.Add(txtbox)
                dynAddCell.Attributes.Add("Width", "15%")
                dynAddCell.Attributes.Add("align", "center")
                dynAddCell.Attributes.Add("class", "td")
                txtbox.ID = "txtRowTot" & dynAdd & "_"
                txtbox.Attributes.Add("class", "inputR")
                txtbox.Attributes.Add("size", "10")
                txtbox.Attributes.Add("readonly", "true")

                For Each expenserow In projrow.GetChildRows("Proj_Expense")
                    ' Load the existing expense data into hidden textboxes
                    i = i + 1

                    Hidden = New HtmlInputHidden
                    listPlace.Controls.Add(Hidden)
                    Hidden.ID = "hidExpense_" & dynAdd & "ExpID_a" & i
                    Hidden.Value = expenserow.Item("ExpenseID")
                    Hidden = New HtmlInputHidden
                    listPlace.Controls.Add(Hidden)
                    Hidden.ID = "txtExpense_" & dynAdd & "Date_a" & i
                    Hidden.Value = expenserow.Item("ExpenseDate")
                    Hidden = New HtmlInputHidden
                    listPlace.Controls.Add(Hidden)
                    Hidden.ID = "txtExpense_" & dynAdd & "Comment_a" & i
                    Hidden.Value = expenserow.Item("Comment")
                    Hidden = New HtmlInputHidden
                    listPlace.Controls.Add(Hidden)
                    Hidden.ID = "txtExpense_" & dynAdd & "ExpenseType_a" & i
                    Hidden.Value = expenserow.Item("ExpenseType")
                    Hidden = New HtmlInputHidden
                    listPlace.Controls.Add(Hidden)
                    Hidden.ID = "txtExpense_" & dynAdd & "Quantity_a" & i
                    Hidden.Value = expenserow.Item("Quantity")
                    Hidden = New HtmlInputHidden
                    listPlace.Controls.Add(Hidden)
                    Hidden.ID = "txtExpense_" & dynAdd & "Cost_a" & i
                    Hidden.Value = expenserow.Item("Cost")

                    'Populate the field that indicates if the expense is submitted
                    Hidden = New HtmlInputHidden
                    listPlace.Controls.Add(Hidden)
                    Hidden.ID = "hidExpense_" & dynAdd & "Submit_a" & i
                    Hidden.Value = IIf(expenserow.Item("Submitted") Is DBNull.Value, 0, 1)
                Next
                strValue &= "#" & projrow("ClientID") & ";" & projrow("ProjectID")  'SD: 19/10/2005 - Change dymanic adds from , to #

                'This is needed for addFormsection functionality
                Dim count As New HtmlInputHidden
                listPlace.Controls.Add(count)
                count.ID = dynAdd & "_list"
                count.Name = dynAdd & "_list"
                'Next

                'SB: 03/08/2005 - needs to be inside the loop
                Dim count2 As New HtmlInputHidden
                listPlace.Controls.Add(count2)
                count2.ID = dynAdd & "_listload"
                count2.Value = i

            Next

            ' Accumulates Grand Totals
            GTot += ProjTot
        Next

        hidBoxexpense = New HtmlInputHidden
        hidBoxexpense.ID = "hidBoxexpense"
        hidBoxexpense.Value = strValue
        listPlace.Controls.Add(hidBoxexpense)

        txtTotal.Text = GTot
    End Sub
    Private Sub LoadDropList(ByVal ddl As DropDownList)
        ' Load the Expense Types Droplist
        ddl.DataTextField = "Description"
        ddl.DataValueField = "TypeID"
        ddl.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectExpenseTypes")
        ddl.DataBind()
        ddl.Items.Insert(0, New ListItem("--Expense Type--", "0#0#0"))
    End Sub
    Function Totals(ByVal Qty As Decimal, ByVal Cost As Decimal)
        ' Accumulates Project Totals
        RowTot = (Qty * Cost)
        ProjTot += RowTot
        Return RowTot
    End Function

#End Region

#Region " SUBMIT DETAILS "
    Private Sub Calendar1_VisibleMonthChanged(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MonthChangedEventArgs) Handles Calendar1.VisibleMonthChanged
        ' Load the relevant months expenses
        LoadMonthExpenses(e.NewDate)
        hidExpenseDate.Value = Format(e.NewDate, "dd/MM/yyyy")
    End Sub

    Private Sub Calendar1_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Calendar1.SelectionChanged
        ' Load the relevant months expenses
        LoadMonthExpenses(Calendar1.SelectedDate)
        hidExpenseDate.Value = Format(Calendar1.SelectedDate, "dd/MM/yyyy")

    End Sub

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ProcessExpenses()
        SubmitExpenses()

        'Redirect to alerts page and open a report of the submitted expenses
        Dim strUrl As String
        Dim strJavascript As String
        strUrl = "ExpenseSubmitted.aspx?UserID=" & User.Identity.Name & "&ExpenseMonth=" & ViewState("FirstDay")
        strJavascript = "window.open('" & strUrl & "',""SubmittedExpenses"",""toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=350,top=50,left=50,resizable=0"");"
        strJavascript &= " var o = window.location('../default.aspx');"
        Response.Write("<script language=javascript>" & strJavascript & "</script>")
       
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        ProcessExpenses()
        ' Reload the Expenses page
        LoadMonthExpenses(ViewState("FirstDay"))

    End Sub

    Private Sub ProcessExpenses()
        ProcessDeletedProjects()
        ProcessDeletedItems()

        ' Update the Users Expenses
        Dim arParms2() As SqlParameter = New SqlParameter(8) {}
        Dim ForDate As Date = ViewState("FirstDay")
        Dim ItemNo, Exp, ExpItems, strExpType As String
        Dim a, b, ExpID, ProjID, NoRows, Rows, ItemID As Integer
        Dim arrData, ProjArray, ExpArray, ExpTypeArray As Array
        Dim Client As String

        a = 0
        NoRows = 0
        ItemNo = ""
        ItemNo = Request.Form("hidBoxexpense")
        If ItemNo <> "" And ItemNo <> "#" Then  'SD: 19/10/2005 - Change dymanic adds from , to #
            Try
                ProjArray = ItemNo.Split("#")   'SD: 19/10/2005 - Change dymanic adds from , to #
                NoRows = (ProjArray.Length - 1)
            Catch
            End Try

            While a < NoRows
                a += 1
                ' For each Project
                ItemNo = ProjArray(a)
                arrData = ItemNo.Split(";")
                Client = arrData(0)
                ProjID = arrData(1)
                b = 0
                Rows = 0
                ExpItems = ""
                ExpItems = Request.Form("a" & ProjID & "_list")
                If ExpItems <> "" And ExpItems <> "#" Then          'SD: 19/10/2005 - Change dymanic adds from , to #
                    ' there are expense item rows to process
                    Try
                        ExpArray = ExpItems.Split("#")              'SD: 19/10/2005 - Change dymanic adds from , to #
                        Rows = (ExpArray.Length - 2)
                    Catch
                    End Try

                    While b < Rows
                        b += 1
                        ' For each expense
                        'SD: 11/10/2005 - Only save if this isn't a submitted expense
                        If Request.Form("hidExpense_a" & ProjID & "Submit_a" & ExpArray(b)) = 0 Then
                            ExpID = 0
                            If Request.Form("hidExpIDa" & ProjID & "_" & ExpArray(b)) <> "" Then
                                ExpID = Request.Form("hidExpIDa" & ProjID & "_" & ExpArray(b))
                            End If
                            ' Insert or Update the ExpenseItem
                            ' If ExpID = 0 then Insert the expense, Else Update the ExpenseItem
                            arParms2(0) = New SqlParameter("@ExpenseID", ExpID)
                            arParms2(1) = New SqlParameter("@UserID", User.Identity.Name)
                            arParms2(2) = New SqlParameter("@ProjectID", ProjID)
                            strExpType = Request.Form("ddlExpenseTypea" & ProjID & "_" & ExpArray(b))
                            ExpTypeArray = strExpType.Split("#")
                            arParms2(3) = New SqlParameter("@ExpenseTypeID", ExpTypeArray(0))
                            arParms2(4) = New SqlParameter("@ExpenseDate", System.DateTime.ParseExact(Request.Form("txtDatea" & ProjID & "_" & ExpArray(b)), "dd/MM/yyyy", en))
                            arParms2(5) = New SqlParameter("@Quantity", IIf(Request.Form("txtQtya" & ProjID & "_" & ExpArray(b)) = "", 0, Request.Form("txtQtya" & ProjID & "_" & ExpArray(b))))
                            arParms2(6) = New SqlParameter("@Cost", IIf(Request.Form("txtCosta" & ProjID & "_" & ExpArray(b)) = "", 0, Request.Form("txtCosta" & ProjID & "_" & ExpArray(b))))
                            arParms2(7) = New SqlParameter("@Comment", Request.Form("txtCommenta" & ProjID & "_" & ExpArray(b)))
                            arParms2(8) = New SqlParameter("@ExpenseMonth", ViewState("FirstDay")) 'SB: 02/08/2005 - save the expense month
                            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_UpdateUserExpense", arParms2)
                        End If
                    End While
                End If
            End While
        End If
    End Sub
    Private Sub ProcessDeletedProjects()
        ' check if there are items in the deleteprojlist to delete
        ' This will remove the project from the Users ProjectProfile

        Dim i, Rows, ProjID As Integer
        Dim Items As String
        Dim arrData As Array

        i = 0
        Rows = 0
        Items = ""
        Items = Request.Form("deletedproj_list")
        If Items <> "" And Items <> "#" Then     'SD: 19/10/2005 - Change dymanic adds from , to #
            Try
                arrData = Items.Split("#")       'SD: 19/10/2005 - Change dymanic adds from , to #
                Rows = (arrData.Length - 1)
            Catch
            End Try

            While i < Rows
                ' For each deleted project
                ProjID = arrData(i)
                DAL.DeleteProfileProject(User.Identity.Name, ProjID)
                i += 1
            End While
        End If

    End Sub
    Private Sub ProcessDeletedItems()
        ' check if there are items in the deletelist to delete

        Dim i, Rows, ProjID, delExp As Integer
        Dim Items, currItem As String
        Dim arrData, arrDel As Array
        Dim arParms() As SqlParameter = New SqlParameter(1) {}

        i = 0
        Rows = 0
        Items = ""
        Items = Request.Form("deleted_list")
        If Items <> "" And Items <> "#" Then     'SD: 19/10/2005 - Change dymanic adds from , to #
            Try
                arrData = Items.Split("#")       'SD: 19/10/2005 - Change dymanic adds from , to #
                Rows = (arrData.Length - 1)
            Catch
            End Try

            While i < Rows
                i += 1
                ' For each deleted expense
                delExp = 0
                currItem = arrData(i)
                arrDel = currItem.Split(";")
                ProjID = arrDel(0)
                delExp = arrDel(1)
                If delExp <> 0 Then
                    ' Delete the ExpenseItem from Expenses
                    arParms(0) = New SqlParameter("@UserID", User.Identity.Name)
                    arParms(1) = New SqlParameter("@ExpenseID", delExp)
                    SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_DeleteUserExpense", arParms)
                End If
            End While
        End If

    End Sub

    Private Sub SubmitExpenses()
        Dim arParms3() As SqlParameter = New SqlParameter(1) {}
        arParms3(0) = New SqlParameter("@UserID", User.Identity.Name)
        arParms3(1) = New SqlParameter("@StartDate", ViewState("FirstDay"))
        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_SubmitUserExpenses", arParms3)
    End Sub
#End Region

End Class
