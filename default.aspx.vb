Public Class Default1
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents HyperLink1 As System.Web.UI.WebControls.HyperLink
    Protected WithEvents imgHelp0_1 As System.Web.UI.WebControls.Image
    Protected WithEvents labProjTakeOn As System.Web.UI.WebControls.Label
    Protected WithEvents dgProjTakeOn As System.Web.UI.WebControls.DataGrid
    Protected WithEvents ProjTakeOn As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labPTOApprove As System.Web.UI.WebControls.Label
    Protected WithEvents dgPTOApprove As System.Web.UI.WebControls.DataGrid
    Protected WithEvents PTOApprove As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labVOApprove As System.Web.UI.WebControls.Label
    Protected WithEvents dgVOApprove As System.Web.UI.WebControls.DataGrid
    Protected WithEvents VOApprove As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labTimesheetOverdue As System.Web.UI.WebControls.Label
    Protected WithEvents dgTimesheetOverdue As System.Web.UI.WebControls.DataGrid
    Protected WithEvents TimesheetOverdue As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labTimesheetApproval As System.Web.UI.WebControls.Label
    Protected WithEvents TimesheetApproval As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents ExpenseApproval As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labOverBudget As System.Web.UI.WebControls.Label
    Protected WithEvents dgOverBudget As System.Web.UI.WebControls.DataGrid
    Protected WithEvents OverBudget As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labUnderBudget As System.Web.UI.WebControls.Label
    Protected WithEvents dgUnderBudget As System.Web.UI.WebControls.DataGrid
    Protected WithEvents UnderBudget As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labExpiring As System.Web.UI.WebControls.Label
    Protected WithEvents dgExpiring As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Expiring As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents divPTO As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents divVO As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents DivTS As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents DivEXP As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents DivStatus As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents labMyProjects As System.Web.UI.WebControls.Label
    Protected WithEvents dgMyProjects As System.Web.UI.WebControls.DataGrid
    Protected WithEvents labCurrentProjects As System.Web.UI.WebControls.Label
    Protected WithEvents dgCurrentProjects As System.Web.UI.WebControls.DataGrid
    Protected WithEvents divProjects As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents CurrentProjects As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents MyProj As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents dgRejectedExpense As System.Web.UI.WebControls.DataGrid
    Protected WithEvents ExpenseRejected As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labRejectedExpense As System.Web.UI.WebControls.Label
    Protected WithEvents labRejectedTimesheet As System.Web.UI.WebControls.Label
    Protected WithEvents dgRejectedTimesheet As System.Web.UI.WebControls.DataGrid
    Protected WithEvents TimesheetRejected As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents dgTimesheetApproval As System.Web.UI.WebControls.DataGrid
    Protected WithEvents dgTimesheetApprovalManager As System.Web.UI.WebControls.DataGrid
    Protected WithEvents trTimesheetApprovalManager As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labTimesheetManagerApproval As System.Web.UI.WebControls.Label
    Protected WithEvents labTimesheetManagerMonitorApproval As System.Web.UI.WebControls.Label
    Protected WithEvents labExpenseApproval As System.Web.UI.WebControls.Label
    Protected WithEvents dgExpenseApproval As System.Web.UI.WebControls.DataGrid
    Protected WithEvents labExpenseApprovalManager As System.Web.UI.WebControls.Label
    Protected WithEvents dgExpenseApprovalManager As System.Web.UI.WebControls.DataGrid
    Protected WithEvents labExpenseApprovalMonitor As System.Web.UI.WebControls.Label
    Protected WithEvents trExpenseApprovalManager As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents divFinancialDocuments As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents Tr1 As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents Tr2 As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents Tr3 As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labFinDocTeamleader As System.Web.UI.WebControls.Label
    Protected WithEvents dgFinDocTeamleader As System.Web.UI.WebControls.DataGrid
    Protected WithEvents labFinDocManager As System.Web.UI.WebControls.Label
    Protected WithEvents dgFinDocManager As System.Web.UI.WebControls.DataGrid
    Protected WithEvents labFinDocMonitor As System.Web.UI.WebControls.Label
    Protected WithEvents dgFinDocMonitor As System.Web.UI.WebControls.DataGrid
    Protected WithEvents trFinDocTeamleaderApproval As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents trFinDocManagerApproval As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents trFinDocManagerMonitorApproval As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labFinDocRejected As System.Web.UI.WebControls.Label
    Protected WithEvents dgFinDocRejected As System.Web.UI.WebControls.DataGrid
    Protected WithEvents trFinDocRejected As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents dgTimesheetApprovalMD As System.Web.UI.WebControls.DataGrid
    Protected WithEvents dgExpenseApprovalMD As System.Web.UI.WebControls.DataGrid
    Protected WithEvents trTimesheetApprovalMD As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents trExpenseApprovalMD As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents dgTimesheetApprovalManagerMonitoring As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents dgExpenseApprovalMonitor As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents trTimesheetApprovalManagerMonitoring As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents trExpenseApprovalManagerMonitor As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labTimesheetMDApproval As System.Web.UI.WebControls.Label
    Protected WithEvents labExpenseApprovalMD As System.Web.UI.WebControls.Label


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
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        UserLogin.CheckUserAccess("1", Context.Current, False)

        If Not IsPostBack Then
            Session("PageType") = "Start"
            Session("Page") = "Start"
            Session("PageTitle") = Session("AppName") & " - Start Page"
            loadAlerts()
            LoadProjects()
        End If
    End Sub

    Sub loadAlerts()

        'Project Triggers
        Dim ProjTakeOnRow As DataRow
        Dim PTOApproveRow As DataRow
        Dim VOApproveRow As DataRow
        Dim TimesheetOverdueRow As DataRow
        Dim TimesheetApprovalRow As DataRow
        Dim ExpenseApprovalRow As DataRow
        Dim OverBudgetRow As DataRow
        Dim UnderBudgetRow As DataRow
        Dim ExpiringRow As DataRow
        Dim RejectedExpenseRow As DataRow
        Dim RejectedTimesheetRow As DataRow
        Dim TimesheetManagerApprovalRow As DataRow
        Dim TimesheetManagerMonitorApprovalRow As DataRow
        Dim TimesheetMDApprovalRow As DataRow
        Dim ExpenseManagerApprovalRow As DataRow
        Dim ExpenseManagerMonitorApprovalRow As DataRow
        Dim ExpenseMDApprovalRow As DataRow
        Dim FinDocTeamleaderApprovalRow As DataRow
        Dim FinDocManagerMonitorApprovalRow As DataRow
        Dim FinDocRejectedApprovalRow As DataRow

        Dim ProjTakeOnTable As DataTable = New DataTable("RESULTS")
        Dim PTOApproveTable As DataTable = New DataTable("RESULTS")
        Dim VOApproveTable As DataTable = New DataTable("RESULTS")
        Dim TimesheetOverdueTable As DataTable = New DataTable("RESULTS")
        Dim TimesheetApprovalTable As DataTable = New DataTable("RESULTS")
        Dim ExpenseApprovalTable As DataTable = New DataTable("RESULTS")
        Dim OverBudgetTable As DataTable = New DataTable("RESULTS")
        Dim UnderBudgetTable As DataTable = New DataTable("RESULTS")
        Dim ExpiringTable As DataTable = New DataTable("RESULTS")
        Dim RejectedExpensesTable As DataTable = New DataTable("RESULTS")
        Dim TimesheetRejectedTable As DataTable = New DataTable("RESULTS")
        Dim TimesheetManagerApprovalTable As DataTable = New DataTable("RESULTS")
        Dim TimesheetManagerMonitorApprovalTable As DataTable = New DataTable("RESULTS")
        Dim TimesheetMDApprovalTable As DataTable = New DataTable("RESULTS")
        Dim ExpenseManagerApprovalTable As DataTable = New DataTable("RESULTS")
        Dim ExpenseManagerMonitorApprovalTable As DataTable = New DataTable("RESULTS")
        Dim ExpenseMDApprovalTable As DataTable = New DataTable("RESULTS")

        Dim FinDocTeamLeaderApprovalTable As DataTable = New DataTable("RESULTS")
        Dim FinDocManagerMonitorApprovalTable As DataTable = New DataTable("RESULTS")
        Dim FinDocRejectedApprovalTable As DataTable = New DataTable("RESULTS")

        'set up columns in the results table
        ProjTakeOnTable.Columns.Add("Mess", GetType(System.String))
        PTOApproveTable.Columns.Add("Mess", GetType(System.String))
        VOApproveTable.Columns.Add("Mess", GetType(System.String))
        TimesheetOverdueTable.Columns.Add("Mess", GetType(System.String))
        TimesheetApprovalTable.Columns.Add("Mess", GetType(System.String))
        ExpenseApprovalTable.Columns.Add("Mess", GetType(System.String))
        OverBudgetTable.Columns.Add("Mess", GetType(System.String))
        UnderBudgetTable.Columns.Add("Mess", GetType(System.String))
        ExpiringTable.Columns.Add("Mess", GetType(System.String))
        RejectedExpensesTable.Columns.Add("Mess", GetType(System.String))
        TimesheetRejectedTable.Columns.Add("Mess", GetType(System.String))
        TimesheetManagerApprovalTable.Columns.Add("Mess", GetType(System.String))
        TimesheetManagerMonitorApprovalTable.Columns.Add("Mess", GetType(System.String))
        TimesheetMDApprovalTable.Columns.Add("Mess", GetType(System.String))
        ExpenseManagerApprovalTable.Columns.Add("Mess", GetType(System.String))
        ExpenseManagerMonitorApprovalTable.Columns.Add("Mess", GetType(System.String))
        ExpenseMDApprovalTable.Columns.Add("Mess", GetType(System.String))
        FinDocTeamLeaderApprovalTable.Columns.Add("Mess", GetType(System.String))
        FinDocManagerMonitorApprovalTable.Columns.Add("Mess", GetType(System.String))
        FinDocRejectedApprovalTable.Columns.Add("Mess", GetType(System.String))

        'SB: 01/09/2005 - Set up a primary key for the Timesheet Approval Table as we don't want to add 
        'the rows multiple times for each users time ie. want one link shown for each relevant week
        Dim ColArray(0) As DataColumn
        ColArray(0) = TimesheetApprovalTable.Columns(0)
        TimesheetApprovalTable.PrimaryKey = ColArray

        'SD: 22/02/2010 - Add the primary key for the two new timesheet approval tables and the expense tables
        ColArray(0) = TimesheetManagerApprovalTable.Columns(0)
        TimesheetManagerApprovalTable.PrimaryKey = ColArray

        ColArray(0) = TimesheetManagerMonitorApprovalTable.Columns(0)
        TimesheetManagerMonitorApprovalTable.PrimaryKey = ColArray

        ColArray(0) = TimesheetMDApprovalTable.Columns(0)
        TimesheetMDApprovalTable.PrimaryKey = ColArray

        ColArray(0) = ExpenseManagerApprovalTable.Columns(0)
        ExpenseManagerApprovalTable.PrimaryKey = ColArray

        ColArray(0) = ExpenseManagerMonitorApprovalTable.Columns(0)
        ExpenseManagerMonitorApprovalTable.PrimaryKey = ColArray

        ColArray(0) = ExpenseMDApprovalTable.Columns(0)
        ExpenseMDApprovalTable.PrimaryKey = ColArray

        ColArray(0) = TimesheetRejectedTable.Columns(0)
        TimesheetRejectedTable.PrimaryKey = ColArray

        Dim arParms() As SqlParameter = New SqlParameter(1) {}
        arParms(0) = New SqlParameter("@UserID", User.Identity.Name)  'Request.Cookies("User").Values("UserID"))
        arParms(1) = New SqlParameter("@ApplicationPath", Request.ApplicationPath)

        ' Execute the stored procedure
        DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectStartAlerts", arParms)

        ' Project Data
        While DR.Read()
            If Not DR.Item("Message") Is DBNull.Value Then
                Select Case DR.Item("Message")
                    Case "ProjTakeOn"
                        ProjTakeOnRow = ProjTakeOnTable.NewRow()
                        ProjTakeOnRow("Mess") = DR.Item("Detail")
                        ProjTakeOnTable.Rows.Add(ProjTakeOnRow)
                    Case "PTOApprove"
                        PTOApproveRow = PTOApproveTable.NewRow()
                        PTOApproveRow("Mess") = DR.Item("Detail")
                        PTOApproveTable.Rows.Add(PTOApproveRow)
                    Case "VOApprove"
                        VOApproveRow = VOApproveTable.NewRow()
                        VOApproveRow("Mess") = DR.Item("Detail")
                        VOApproveTable.Rows.Add(VOApproveRow)
                    Case "OverBudget"
                        OverBudgetRow = OverBudgetTable.NewRow()
                        OverBudgetRow("Mess") = DR.Item("Detail")
                        OverBudgetTable.Rows.Add(OverBudgetRow)
                    Case "UnderBudget"
                        UnderBudgetRow = UnderBudgetTable.NewRow()
                        UnderBudgetRow("Mess") = DR.Item("Detail")
                        UnderBudgetTable.Rows.Add(UnderBudgetRow)
                    Case "Expiring"
                        ExpiringRow = ExpiringTable.NewRow()
                        ExpiringRow("Mess") = DR.Item("Detail")
                        ExpiringTable.Rows.Add(ExpiringRow)
                End Select
            End If
        End While

        ' Timesheet Data
        DR.NextResult()

        Dim drow As DataRow

        While DR.Read()
            If Not DR.Item("Message") Is DBNull.Value Then
                Select Case DR.Item("Message")
                    Case "TimesheetOverdue"
                        TimesheetOverdueRow = TimesheetOverdueTable.NewRow()
                        TimesheetOverdueRow("Mess") = DR.Item("Detail")
                        TimesheetOverdueTable.Rows.Add(TimesheetOverdueRow)
                    Case "TimesheetApprovalTeamLeader"
                        'SD: 01/09/2005 - Don't add the row multiple times for each user's time
                        drow = TimesheetApprovalTable.Rows.Find(DR.Item("Detail"))
                        If drow Is Nothing Then
                            TimesheetApprovalRow = TimesheetApprovalTable.NewRow()
                            TimesheetApprovalRow("Mess") = DR.Item("Detail")
                            TimesheetApprovalTable.Rows.Add(TimesheetApprovalRow)
                        End If
                    Case "TimesheetRejected"
                        'SD: 20/10/2005 - Add the rejected timesheet alert
                        drow = TimesheetRejectedTable.Rows.Find(DR.Item("Detail"))
                        If drow Is Nothing Then
                            RejectedTimesheetRow = TimesheetRejectedTable.NewRow()
                            RejectedTimesheetRow("Mess") = DR.Item("Detail")
                            TimesheetRejectedTable.Rows.Add(RejectedTimesheetRow)
                        End If
                    Case "TimesheetApprovalManager"
                        'SD: 08/02/2010 - Add the Manager Timesheet approval
                        drow = TimesheetManagerApprovalTable.Rows.Find(DR.Item("Detail"))
                        If drow Is Nothing Then
                            TimesheetManagerApprovalRow = TimesheetManagerApprovalTable.NewRow()
                            TimesheetManagerApprovalRow("Mess") = DR.Item("Detail")
                            TimesheetManagerApprovalTable.Rows.Add(TimesheetManagerApprovalRow)
                        End If
                    Case "TimesheetApprovalTeamLeaderMonitor"
                        'SD: 08/02/2010 - Add the Manager Timesheet approval for monitoring the teamleaders
                        drow = TimesheetManagerMonitorApprovalTable.Rows.Find(DR.Item("Detail"))
                        If drow Is Nothing Then
                            TimesheetManagerMonitorApprovalRow = TimesheetManagerMonitorApprovalTable.NewRow()
                            TimesheetManagerMonitorApprovalRow("Mess") = DR.Item("Detail")
                            TimesheetManagerMonitorApprovalTable.Rows.Add(TimesheetManagerMonitorApprovalRow)
                        End If
                    Case "TimesheetApprovalMD"
                        'SD: 06/02/2012 - Add the MD Timesheet approval 
                        drow = TimesheetMDApprovalTable.Rows.Find(DR.Item("Detail"))
                        If drow Is Nothing Then
                            TimesheetMDApprovalRow = TimesheetMDApprovalTable.NewRow()
                            TimesheetMDApprovalRow("Mess") = DR.Item("Detail")
                            TimesheetMDApprovalTable.Rows.Add(TimesheetMDApprovalRow)
                        End If
                End Select
            End If
        End While

        ' Expense Data
        DR.NextResult()
        While DR.Read()
            If Not DR.Item("Message") Is DBNull.Value Then
                'SD: 22/02/2010 - Add the Expense approval for the Manager and monitoring
                Select Case DR.Item("Message")
                    Case "ExpenseApprovalTeamleader"
                        ExpenseApprovalRow = ExpenseApprovalTable.NewRow()
                        ExpenseApprovalRow("Mess") = DR.Item("Detail")
                        ExpenseApprovalTable.Rows.Add(ExpenseApprovalRow)
                    Case "ExpenseApprovalManager"
                        ExpenseManagerApprovalRow = ExpenseManagerApprovalTable.NewRow()
                        ExpenseManagerApprovalRow("Mess") = DR.Item("Detail")
                        ExpenseManagerApprovalTable.Rows.Add(ExpenseManagerApprovalRow)
                    Case "ExpenseApprovalManagerMonitor"
                        ExpenseManagerMonitorApprovalRow = ExpenseManagerMonitorApprovalTable.NewRow()
                        ExpenseManagerMonitorApprovalRow("Mess") = DR.Item("Detail")
                        ExpenseManagerMonitorApprovalTable.Rows.Add(ExpenseManagerMonitorApprovalRow)
                    Case "ExpenseApprovalMD"
                        ExpenseMDApprovalRow = ExpenseMDApprovalTable.NewRow()
                        ExpenseMDApprovalRow("Mess") = DR.Item("Detail")
                        ExpenseMDApprovalTable.Rows.Add(ExpenseMDApprovalRow)
                    Case "RejectedExpense"
                        RejectedExpenseRow = RejectedExpensesTable.NewRow()
                        RejectedExpenseRow("Mess") = DR.Item("Detail")
                        RejectedExpensesTable.Rows.Add(RejectedExpenseRow)
                End Select
            End If
        End While

        ' Financial Documents
        DR.NextResult()
        While DR.Read()
            If Not DR.Item("Message") Is DBNull.Value Then
                Select Case DR.Item("Message")
                    Case "FinDocTeamLeaderApproval"
                        FinDocTeamleaderApprovalRow = FinDocTeamLeaderApprovalTable.NewRow()
                        FinDocTeamleaderApprovalRow("Mess") = DR.Item("Detail")
                        FinDocTeamLeaderApprovalTable.Rows.Add(FinDocTeamleaderApprovalRow)
                    Case "FinDocManagerMonitorApproval"
                        FinDocManagerMonitorApprovalRow = FinDocManagerMonitorApprovalTable.NewRow()
                        FinDocManagerMonitorApprovalRow("Mess") = DR.Item("Detail")
                        FinDocManagerMonitorApprovalTable.Rows.Add(FinDocManagerMonitorApprovalRow)
                    Case "FinDocRejected"
                        FinDocRejectedApprovalRow = FinDocRejectedApprovalTable.NewRow()
                        FinDocRejectedApprovalRow("Mess") = DR.Item("Detail")
                        FinDocRejectedApprovalTable.Rows.Add(FinDocRejectedApprovalRow)
                End Select
            End If
        End While
        DR.Close()

        'Determine if you need to bind and show dg
        'If UserLogin.CheckUserAccess("2", Context.Current, False) Then
        ' Project Take On
        dgProjTakeOn.DataSource = ProjTakeOnTable
        dgProjTakeOn.DataBind()
        ItemCounter(dgProjTakeOn, ProjTakeOn, labProjTakeOn, "PTO")
        If dgProjTakeOn.Items.Count() > 0 Then
            divPTO.Style("DISPLAY") = "block"
        End If
        ' Project Over Budget
        dgOverBudget.DataSource = OverBudgetTable
        dgOverBudget.DataBind()
        ItemCounter(dgOverBudget, OverBudget, labOverBudget, "project")
        If dgOverBudget.Items.Count() > 0 Then
            DivStatus.Style("DISPLAY") = "block"
        End If
        ' Project Under Budget
        dgUnderBudget.DataSource = UnderBudgetTable
        dgUnderBudget.DataBind()
        ItemCounter(dgUnderBudget, UnderBudget, labUnderBudget, "project")
        If dgUnderBudget.Items.Count() > 0 Then
            DivStatus.Style("DISPLAY") = "block"
        End If
        ' Project Expiring
        dgExpiring.DataSource = ExpiringTable
        dgExpiring.DataBind()
        ItemCounter(dgExpiring, Expiring, labExpiring, "project")
        If dgExpiring.Items.Count() > 0 Then
            DivStatus.Style("DISPLAY") = "block"
        End If

        'Else
        'ProjTakeOn.Visible = False
        'OverBudget.Visible = False
        'UnderBudget.Visible = False
        'Expiring.Visible = False
        'End If
        'If UserLogin.CheckUserAccess("5", Context.Current, False) Then
        'If Context.User.IsInRole("5") Then
        dgPTOApprove.DataSource = PTOApproveTable
        dgPTOApprove.DataBind()
        ItemCounter(dgPTOApprove, PTOApprove, labPTOApprove, "PTO")
        If dgPTOApprove.Items.Count() > 0 Then
            divPTO.Style("DISPLAY") = "block"
        End If
        dgVOApprove.DataSource = VOApproveTable
        dgVOApprove.DataBind()
        ItemCounter(dgVOApprove, VOApprove, labVOApprove, "VO")
        If dgVOApprove.Items.Count() > 0 Then
            divVO.Style("DISPLAY") = "block"
        End If

        dgTimesheetOverdue.DataSource = TimesheetOverdueTable
        dgTimesheetOverdue.DataBind()
        ItemCounter(dgTimesheetOverdue, TimesheetOverdue, labTimesheetOverdue, "Timesheet")
        'If dgTimesheetOverdue.Items.Count() > 0 Then
        '    DivTS.Style("DISPLAY") = "block"
        'End If

        dgRejectedTimesheet.DataSource = TimesheetRejectedTable
        dgRejectedTimesheet.DataBind()
        ItemCounter(dgRejectedTimesheet, TimesheetRejected, labRejectedTimesheet, "Rejected Timesheet")

        dgTimesheetApproval.DataSource = TimesheetApprovalTable
        dgTimesheetApproval.DataBind()
        ItemCounter(dgTimesheetApproval, TimesheetApproval, labTimesheetApproval, "Timesheet")
        'If dgTimesheetApproval.Items.Count() > 0 Then
        '    DivTS.Style("DISPLAY") = "block"
        'End If

        dgTimesheetApprovalManager.DataSource = TimesheetManagerApprovalTable
        dgTimesheetApprovalManager.DataBind()
        ItemCounter(dgTimesheetApprovalManager, trTimesheetApprovalManager, labTimesheetManagerApproval, "Timesheet")

        dgTimesheetApprovalManagerMonitoring.DataSource = TimesheetManagerMonitorApprovalTable
        dgTimesheetApprovalManagerMonitoring.DataBind()
        ItemCounter(dgTimesheetApprovalManagerMonitoring, trTimesheetApprovalManagerMonitoring, labTimesheetManagerMonitorApproval, "Timesheet")

        dgTimesheetApprovalMD.DataSource = TimesheetMDApprovalTable
        dgTimesheetApprovalMD.DataBind()
        ItemCounter(dgTimesheetApprovalMD, trTimesheetApprovalMD, labTimesheetMDApproval, "Timesheet")


        'Check if any timesheet grids are available
        If dgTimesheetOverdue.Items.Count() > 0 Or dgRejectedTimesheet.Items.Count() > 0 Or _
           dgTimesheetApproval.Items.Count() > 0 Or dgTimesheetApprovalManager.Items.Count() > 0 Or _
           dgTimesheetApprovalManagerMonitoring.Items.Count() > 0 Or dgTimesheetApprovalMD.Items.Count() > 0 Then

            DivTS.Style("DISPLAY") = "block"
        End If

        dgExpenseApproval.DataSource = ExpenseApprovalTable
        dgExpenseApproval.DataBind()
        ItemCounter(dgExpenseApproval, ExpenseApproval, labExpenseApproval, "Expense")

        dgExpenseApprovalManager.DataSource = ExpenseManagerApprovalTable
        dgExpenseApprovalManager.DataBind()
        ItemCounter(dgExpenseApprovalManager, trExpenseApprovalManager, labExpenseApprovalManager, "Expense")

        dgExpenseApprovalMonitor.DataSource = ExpenseManagerMonitorApprovalTable
        dgExpenseApprovalMonitor.DataBind()
        ItemCounter(dgExpenseApprovalMonitor, trExpenseApprovalManagerMonitor, labExpenseApprovalMonitor, "Expense")

        dgExpenseApprovalMD.DataSource = ExpenseMDApprovalTable
        dgExpenseApprovalMD.DataBind()
        ItemCounter(dgExpenseApprovalMD, trExpenseApprovalMD, labExpenseApprovalMD, "Expense")

        dgRejectedExpense.DataSource = RejectedExpensesTable
        dgRejectedExpense.DataBind()
        ItemCounter(dgRejectedExpense, ExpenseRejected, labRejectedExpense, "Rejected Expense")

        If dgExpenseApproval.Items.Count() > 0 Or dgRejectedExpense.Items.Count() > 0 Or _
            dgExpenseApprovalManager.Items.Count() > 0 Or dgExpenseApprovalMonitor.Items.Count() > 0 Or _
            dgExpenseApprovalMD.Items.Count() > 0 Then
            DivEXP.Style("DISPLAY") = "block"
        End If

        dgFinDocTeamleader.DataSource = FinDocTeamLeaderApprovalTable
        dgFinDocTeamleader.DataBind()
        ItemCounter(dgFinDocTeamleader, trFinDocTeamleaderApproval, labFinDocTeamleader, "Financial Document")

        dgFinDocMonitor.DataSource = FinDocManagerMonitorApprovalTable
        dgFinDocMonitor.DataBind()
        ItemCounter(dgFinDocMonitor, trFinDocManagerMonitorApproval, labFinDocMonitor, "Financial Document")

        dgFinDocRejected.DataSource = FinDocRejectedApprovalTable
        dgFinDocRejected.DataBind()
        ItemCounter(dgFinDocRejected, trFinDocRejected, labFinDocRejected, "Rejected Financial Document")

        If dgFinDocTeamleader.Items.Count() > 0 Or dgFinDocMonitor.Items.Count() > 0 Or dgFinDocRejected.Items.Count() > 0 Then
            divFinancialDocuments.Style("DISPLAY") = "block"
        End If

    End Sub

    Private Sub LoadProjects()
        Dim MyProjRow As DataRow
        Dim CurrentProjectsRow As DataRow
        Dim MyProjTable As DataTable = New DataTable("RESULTS")
        Dim CurrentProjectsTable As DataTable = New DataTable("RESULTS")
        MyProjTable.Columns.Add("Mess", GetType(System.String))
        CurrentProjectsTable.Columns.Add("Mess", GetType(System.String))
        DR = DAL.LoadProjects(User.Identity.Name)
        ' Users Projects
        While DR.Read()
            If Not DR.Item("Message") Is DBNull.Value Then
                Select Case DR.Item("Message")
                    Case "MyProjects"
                        MyProjRow = MyProjTable.NewRow()
                        MyProjRow("Mess") = DR.Item("Detail")
                        MyProjTable.Rows.Add(MyProjRow)
                    Case "CurrentProjects"
                        CurrentProjectsRow = CurrentProjectsTable.NewRow()
                        CurrentProjectsRow("Mess") = DR.Item("Detail")
                        CurrentProjectsTable.Rows.Add(CurrentProjectsRow)
                End Select
            End If
        End While

        DR.Close()

        dgMyProjects.DataSource = MyProjTable
        dgMyProjects.DataBind()
        ItemCounter(dgMyProjects, MyProj, labMyProjects, "Project")
        If dgMyProjects.Items.Count() > 0 Then
            divProjects.Style("DISPLAY") = "block"
        Else
            MyProj.Visible = False
        End If
        dgCurrentProjects.DataSource = CurrentProjectsTable
        dgCurrentProjects.DataBind()
        ItemCounter(dgCurrentProjects, CurrentProjects, labCurrentProjects, "Project")
        If dgCurrentProjects.Items.Count() > 0 Then
            divProjects.Style("DISPLAY") = "block"
        Else
            CurrentProjects.Visible = False
        End If

    End Sub

    Function ItemCounter(ByVal dg As DataGrid, ByVal tr As HtmlTableRow, ByVal lab As Label, ByVal txt As String)
        Dim a As Int32 = 0
        Dim ICount As Int32 = 0

        ICount = CountDataGridRows(dg)
        a = ICount
        If a = 0 Then
            tr.Visible = False
        End If
        If a > 1 Then
            If txt = "VO" Or txt = "BP" Then
                lab.Text = "You have " & a & " " & txt & "'s " & lab.Text
            Else
                lab.Text = "You have " & a & " " & txt & "s " & lab.Text
            End If
        Else
            lab.Text = "You have " & a & " " & txt & " " & lab.Text
        End If
    End Function

    Function CountDataGridRows(ByVal dg As DataGrid)
        Dim a As Int32 = dg.Items.Count
        Dim Count As Int32 = 0
        While a >= 0
            Try
                If dg.Items(a).Visible = True Then
                    Count += 1
                End If
            Catch
            End Try
            a -= 1
        End While
        Return Count
    End Function

#End Region

End Class
