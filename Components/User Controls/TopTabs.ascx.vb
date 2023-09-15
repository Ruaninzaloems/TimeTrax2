Imports System.Web.Security

Public Class TopTab
    Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    '  Protected WithEvents btnTimer As System.Web.UI.WebControls.ImageButton

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object
    Protected WithEvents tblTabTop As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents navTop As Intermap.Controls.IMXPMenu
    Protected WithEvents TopMenu As Intermap.Controls.IMXPMenu

#Region " PAGE DECLARES "
    Protected WithEvents ucHeader As TimeTrax.header
#End Region

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'SB: 13/08/2005 - Set up permission array for constants
        Dim arrConst As New ArrayList
        arrConst.Add("10")
        arrConst.Add("11")
        arrConst.Add("12")
        arrConst.Add("13")
        arrConst.Add("14")
        arrConst.Add("16")
        arrConst.Add("17")
        arrConst.Add("19")
        arrConst.Add("20")
        arrConst.Add("21")
        arrConst.Add("22")
        arrConst.Add("27")

        'Set up the array for access to the Project Admin Menu
        Dim arrProjAdmin As New ArrayList
        arrProjAdmin.Add("25")
        arrProjAdmin.Add("2")
        arrProjAdmin.Add("23")
        arrProjAdmin.Add("26")

        'Set up the array for access to the Project Admin Menu
        Dim arrTimesheet As New ArrayList
        arrTimesheet.Add("6")
        arrTimesheet.Add("7")

        'Set up the array for access to the Expense Menu
        Dim arrExpense As New ArrayList
        arrExpense.Add("8")
        arrExpense.Add("9")

        'Set up the array for access to Reports->Admin
        Dim arrReportsAdmin As New ArrayList
        arrReportsAdmin.Add("51")
        arrReportsAdmin.Add("52")
        arrReportsAdmin.Add("50")
        arrReportsAdmin.Add("57")
        arrReportsAdmin.Add("58")
        arrReportsAdmin.Add("59")
        arrReportsAdmin.Add("66")
        arrReportsAdmin.Add("67")

        'Set up the array for access to  Reports->Project Management
        Dim arrReportsPM As New ArrayList
        arrReportsPM.Add("55")
        arrReportsPM.Add("51")
        arrReportsPM.Add("50")
        arrReportsPM.Add("53")

        'Set up the array for access to the Reports Menu
        Dim arrReports As New ArrayList
        arrReports = arrReportsAdmin
        arrReports.Add("55")
        arrReports.Add("53")

        'Set up the array for access to the Admin Menu
        Dim arrAdmin As New ArrayList
        arrAdmin = arrConst
        arrAdmin.Add("18")

        ' Top Tabs
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "0", "Alerts Page", "alerts.png", Request.ApplicationPath & "/default.aspx", True, UserLogin.CheckUserAccess("1", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "1", "Project Admin", "projectadmin.png", "", True, UserLogin.CheckUserAccess(arrProjAdmin, context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "2", "Timesheet", "time_overdue.png", "", True, UserLogin.CheckUserAccess(arrTimesheet, context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "3", "Expense", "expense_overdue.png", "", True, UserLogin.CheckUserAccess(arrExpense, context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4", "Reports", "reports.png", "", True, UserLogin.CheckUserAccess(arrReports, context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5", "Admin", "constants.png", "", True, UserLogin.CheckUserAccess(arrAdmin, context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "6", "Help", "help.png", "", True, True, False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "7", "Log Off", "logout.png", Request.ApplicationPath & "/LogOut.aspx", True, True, False, "")

        ' Project Admin Tab
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "1.0", "Projects List", "", Request.ApplicationPath & "/Project/ProjectListing.aspx", True, UserLogin.CheckUserAccess("25", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "1.1", "Project Take On", "", Request.ApplicationPath & "/Project/ProjectTakeOn.aspx", True, UserLogin.CheckUserAccess("2", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "1.2", "Project VO", "", Request.ApplicationPath & "/Project/ProjectVO.aspx", True, UserLogin.CheckUserAccess("23", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "1.3", "Project Closeout", "", Request.ApplicationPath & "/Project/ProjectCloseOut.aspx", True, UserLogin.CheckUserAccess("26", context, False), False, "")

        ' TimeSheet Tab
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "2.0", "Capture", "", Request.ApplicationPath & "/Capture/Timesheet.aspx", True, UserLogin.CheckUserAccess("6", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "2.1", "Approval", "", Request.ApplicationPath & "/Approvals/Timesheet.aspx", True, UserLogin.CheckUserAccess("7", context, False), False, "")

        ' Expense Tab
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "3.0", "Capture", "", Request.ApplicationPath & "/Capture/Expense.aspx", True, UserLogin.CheckUserAccess("8", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "3.1", "Approval", "", Request.ApplicationPath & "/Approvals/Expense.aspx", True, UserLogin.CheckUserAccess("9", context, False), False, "")

        ' Reports Tab
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.0", "Administration", "", "", True, UserLogin.CheckUserAccess(arrReportsAdmin, context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.1", "Project Management", "", "", True, UserLogin.CheckUserAccess(arrReportsPM, context, False), False, "")

        ' Administration
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.0.0", "Expense Reimbursements", "", Request.ApplicationPath & "/Reports/ExpenseReimbursements.aspx?ShowTaskFilter=0&ShowGroupBy=1&ExpenseMonthFilter=1", True, UserLogin.CheckUserAccess("51", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.0.1", "Project Cost Summary", "", Request.ApplicationPath & "/Reports/ProjSummary.aspx", True, UserLogin.CheckUserAccess("52", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.0.2", "User Activity Register", "", Request.ApplicationPath & "/Reports/UserActivityReport.aspx", True, UserLogin.CheckUserAccess("66", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.0.3", "Task Activity Register", "", Request.ApplicationPath & "/Reports/ProjectActivityRegister.aspx?ProjRequired=1&ShowGroupBy=1", True, UserLogin.CheckUserAccess("50", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.0.4", "Time Analysis", "", Request.ApplicationPath & "/Reports/TimeAnalysis.aspx", True, UserLogin.CheckUserAccess("57", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.0.5", "Time Off", "", Request.ApplicationPath & "/Reports/Timeoff.aspx", True, UserLogin.CheckUserAccess("58", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.0.6", "Timesheet Status", "", Request.ApplicationPath & "/Reports/TimesheetStatus.aspx", True, UserLogin.CheckUserAccess("59", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.0.7", "Data Extract", "", Request.ApplicationPath & "/Reports/DataExtract.aspx?ShowGroupBy=0", True, UserLogin.CheckUserAccess("67", context, False), False, "")

        ' Project Management
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.1.0", "Exceptions", "", Request.ApplicationPath & "/Reports/Exceptions.aspx", True, UserLogin.CheckUserAccess("55", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.1.1", "Expenses", "", Request.ApplicationPath & "/Reports/Expenses.aspx?ShowTaskFilter=0&UserFilter=1", True, UserLogin.CheckUserAccess("51", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.1.2", "Project Detail Report", "", Request.ApplicationPath & "/Reports/TaskReg.aspx?ProjRequired=1&ShowGroupBy=1", True, UserLogin.CheckUserAccess("50", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "4.1.3", "Project Status", "", Request.ApplicationPath & "/Reports/ProjStatus.aspx", True, UserLogin.CheckUserAccess("53", context, False), False, "")

        ' Administration Tab
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0", "Constants", "", "", True, UserLogin.CheckUserAccess(arrConst, context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.1", "System Management", "", Request.ApplicationPath & "/Admin/SystemAdmin.aspx", True, UserLogin.CheckUserAccess("18", context, False), False, "")
        ' Constants
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.0", "Approval Types", "", Request.ApplicationPath & "/Admin/ApprovalTypes.aspx", True, UserLogin.CheckUserAccess("19", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.1", "Budget Items", "", Request.ApplicationPath & "/Admin/BudgetItems.aspx", True, UserLogin.CheckUserAccess("11", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.2", "Clients", "", Request.ApplicationPath & "/Admin/Clients.aspx", True, UserLogin.CheckUserAccess("16", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.3", "Contacts", "", Request.ApplicationPath & "/Admin/Contacts.aspx", True, UserLogin.CheckUserAccess("17", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.4", "Cost Centres", "", Request.ApplicationPath & "/Admin/CostCentres.aspx", True, UserLogin.CheckUserAccess("12", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.5", "Countries", "", Request.ApplicationPath & "/Admin/Countries.aspx", True, UserLogin.CheckUserAccess("14", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.6", "Currencies", "", Request.ApplicationPath & "/Admin/Currencies.aspx", True, UserLogin.CheckUserAccess("22", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.7", "Expense Items", "", Request.ApplicationPath & "/Admin/ExpenseItems.aspx", True, UserLogin.CheckUserAccess("13", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.8", "Financial Document Type Emails", "", Request.ApplicationPath & "/Admin/FinancialDocTypeEmail.aspx", True, UserLogin.CheckUserAccess("71", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.9", "Groups", "", Request.ApplicationPath & "/Admin/GroupNames.aspx", True, UserLogin.CheckUserAccess("20", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.10", "Roles", "", Request.ApplicationPath & "/Admin/RoleNames.aspx", True, UserLogin.CheckUserAccess("21", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.11", "Time Off Types", "", Request.ApplicationPath & "/Admin/TimeOffTypes.aspx", True, UserLogin.CheckUserAccess("27", context, False), False, "")
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "5.0.12", "Users", "", Request.ApplicationPath & "/Admin/Users.aspx", True, UserLogin.CheckUserAccess("10", context, False), False, "")

        ' Help Tab
        Intermap.Controls.IMXPMenu.AddItem(TopMenu, "6.0", "User Guide", "", Request.ApplicationPath & "/Help/Links.aspx", True, True, False, "")

    End Sub

End Class
