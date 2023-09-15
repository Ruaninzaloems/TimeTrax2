Public Class ExpenseReimbursements
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents pgHead As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents lblMonth As System.Web.UI.WebControls.Label
    Protected WithEvents RepeaterClient As System.Web.UI.WebControls.Repeater
    Protected WithEvents tblButtons As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents RepeaterUserByUser As System.Web.UI.WebControls.Repeater
    Protected WithEvents trByTask As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents trByUser As System.Web.UI.HtmlControls.HtmlTableRow

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
    Dim en As New System.Globalization.CultureInfo("en-Za")
    Public setBorder As String

#End Region

#Region " PAGE DECLARES "
    Dim DS As DataSet

    Dim Level1row As DataRow
    Dim Level2row As DataRow
    Dim Level3row As DataRow
    Dim Level4row As DataRow

    Dim Total As Decimal = 0
    Dim GrandTotal As Decimal = 0

#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "51"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            'Put user code to initialize the page here
            divReport.Visible = False
            tblButtons.Visible = False
        Else
            LoadProjectDetails()
            divReport.Visible = True
            tblButtons.Visible = True
        End If
        pgHead.Visible = False

    End Sub

    Private Sub LoadProjectDetails()
        Dim dr1 As DataRelation
        Dim dr2 As DataRelation
        Dim dr3 As DataRelation
        Dim dtExpenseMonth As Date = Nothing
        Dim dtStartDate As Date = Nothing
        Dim dtEndDate As Date = Nothing

        DS = New DataSet

        If Request.Form("ucReportFilters:optExpenseMonth") = "optMonthView" Then
            'Calculate the expense month
            dtExpenseMonth = Convert.ToDateTime("01/" & MonthName(Request.Form("ucReportFilters:ddlMonth"), True) & "/" & Request.Form("ucReportFilters:ddlYear"))
        Else
            'Set the date filters
            dtStartDate = System.DateTime.ParseExact(Request.Form("ucReportFilters:txtStartDate"), "dd/MM/yyyy", en)
            dtEndDate = System.DateTime.ParseExact(Request.Form("ucReportFilters:txtEndDate"), "dd/MM/yyyy", en)
        End If


        DS = DAL.ReportExpenseReimbursements(Request.Form("ucReportFilters:ddlProject"), _
                                             dtStartDate, dtEndDate, _
                                             Common.CalcUserString(Request.Form("ucReportFilters:lstUsers")), _
                                             Request.Form("ucReportFilters:grouping_list"), _
                                             Request.Form("ucReportFilters:ddlClient"), _
                                             Request.Form("ucReportFilters:ddlCaptureType"), dtExpenseMonth)
        Select Case Request.Form("ucReportFilters:grouping_list")
            Case ",User,Task,"
                ' Name the tables
                DS.Tables(0).TableName = "Level1" '"User"
                DS.Tables(1).TableName = "Level2" '"Expense Items"
                ' Set up relationships
                dr1 = New DataRelation("Level1_Level2", DS.Tables("Level1").Columns("UserID"), DS.Tables("Level2").Columns("UserID"))
                dr1.Nested = True
                DS.Relations.Add(dr1)

                RepeaterUserByUser.DataSource = DS.Tables(0).Rows
                RepeaterUserByUser.DataBind()

                'Show/Hide the relevant column headings
                trByUser.Visible = True
                trByTask.Visible = False

                'Clear the Task Grouping repeaters
                RepeaterClient.DataSource = Nothing
                RepeaterClient.DataBind()

            Case Else
                ' Name the tables
                DS.Tables(0).TableName = "Client"   'Client
                DS.Tables(1).TableName = "Project"  'Project
                DS.Tables(2).TableName = "User"     'User
                DS.Tables(3).TableName = "Expenses" 'Expenses
                ' Set up relationships
                dr1 = New DataRelation("Client_Project", DS.Tables("Client").Columns("ClientID"), DS.Tables("Project").Columns("ClientID"))
                dr1.Nested = True
                DS.Relations.Add(dr1)
                dr2 = New DataRelation("Project_User", DS.Tables("Project").Columns("ProjectID"), DS.Tables("User").Columns("ProjectID"))
                dr2.Nested = True
                DS.Relations.Add(dr2)
                dr3 = New DataRelation("User_Expenses", DS.Tables("User").Columns("KeyVal"), DS.Tables("Expenses").Columns("KeyVal"))
                dr3.Nested = True
                DS.Relations.Add(dr3)

                RepeaterClient.DataSource = DS.Tables(0).Rows
                RepeaterClient.DataBind()

                'Show/Hide the relevant column headings
                trByUser.Visible = False
                trByTask.Visible = True

                'Clear the User Grouping repeaters
                RepeaterUserByUser.DataSource = Nothing
                RepeaterUserByUser.DataBind()
        End Select



    End Sub

#Region "By Task Grouping"
    Private Sub RepeaterClient_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RepeaterClient.ItemDataBound
        ' This is the First Header row ie. Client Row
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            ' Load Client (2nd Column)
            DirectCast(e.Item.FindControl("lblClient"), Label).Text = CType(e.Item.DataItem, DataRow)(1)
            DirectCast(e.Item.FindControl("RepeaterProject"), Repeater).DataSource = CType(e.Item.DataItem, DataRow).GetChildRows("Client_Project")
            DirectCast(e.Item.FindControl("RepeaterProject"), Repeater).DataBind()
        End If
        'If e.Item.ItemType = ListItemType.Footer Then
        '    DirectCast(e.Item.FindControl("lblGrandTotal"), Label).Text = GrandTotal
        '    GrandTotal = 0
        'End If
    End Sub

    Sub RepeaterProject_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        ' This is the Second Header row ie. Project
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            ' Load Project (2nd Column)
            DirectCast(e.Item.FindControl("lblProject"), Label).Text = CType(e.Item.DataItem, DataRow)(1)
            DirectCast(e.Item.FindControl("RepeaterUser"), Repeater).DataSource = CType(e.Item.DataItem, DataRow).GetChildRows("Project_User")
            DirectCast(e.Item.FindControl("RepeaterUser"), Repeater).DataBind()
        End If
    End Sub

    Sub RepeaterUser_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        ' This is the Second Header row ie. Project
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            ' Load UserName (2nd Column)
            DirectCast(e.Item.FindControl("lblUser"), Label).Text = CType(e.Item.DataItem, DataRow)(3)
            DirectCast(e.Item.FindControl("RepeaterExpenses"), Repeater).DataSource = CType(e.Item.DataItem, DataRow).GetChildRows("User_Expenses")
            DirectCast(e.Item.FindControl("RepeaterExpenses"), Repeater).DataBind()
        End If
    End Sub

    Sub RepeaterExpenses_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        ' This is the Details row
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            DirectCast(e.Item.FindControl("lblExpType"), Label).Text = CType(e.Item.DataItem, DataRow)(4)
            DirectCast(e.Item.FindControl("lblDate"), Label).Text = CType(e.Item.DataItem, DataRow)(3)
            DirectCast(e.Item.FindControl("lblComments"), Label).Text = CType(e.Item.DataItem, DataRow)(8)
            DirectCast(e.Item.FindControl("lblQty"), Label).Text = CType(e.Item.DataItem, DataRow)(5)
            DirectCast(e.Item.FindControl("lblRate"), Label).Text = CType(e.Item.DataItem, DataRow)(6)
            DirectCast(e.Item.FindControl("lblExpTot"), Label).Text = CType(e.Item.DataItem, DataRow)(7)
            ' Accumulate Total
            Total += CType(e.Item.DataItem, DataRow)(7)
        End If
        If e.Item.ItemType = ListItemType.Footer Then
            DirectCast(e.Item.FindControl("lblTotal"), Label).Text = Total
            ' Accumulate Grand Total
            GrandTotal += Total
            ' Reset Total
            Total = 0
        End If

    End Sub

#End Region
#Region "By User Grouping"

    Private Sub RepeaterUserByUser_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RepeaterUserByUser.ItemDataBound
        ' This is the First Header row ie. Client Row
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            ' Load User (1st Column)
            DirectCast(e.Item.FindControl("lblUserByUser"), Label).Text = CType(e.Item.DataItem, DataRow)(1)
            DirectCast(e.Item.FindControl("RepeaterExpensesByUser"), Repeater).DataSource = CType(e.Item.DataItem, DataRow).GetChildRows("Level1_Level2")
            DirectCast(e.Item.FindControl("RepeaterExpensesByUser"), Repeater).DataBind()
        End If
    End Sub

    Sub RepeaterExpensesByUser_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        ' This is the Details row
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            DirectCast(e.Item.FindControl("lblExpTypeByUser"), Label).Text = CType(e.Item.DataItem, DataRow)(4)
            DirectCast(e.Item.FindControl("lblDateByUser"), Label).Text = CType(e.Item.DataItem, DataRow)(3)
            DirectCast(e.Item.FindControl("lblCommentsByUser"), Label).Text = CType(e.Item.DataItem, DataRow)(8)
            DirectCast(e.Item.FindControl("lblQtyByUser"), Label).Text = CType(e.Item.DataItem, DataRow)(5)
            DirectCast(e.Item.FindControl("lblRateByUser"), Label).Text = CType(e.Item.DataItem, DataRow)(6)
            DirectCast(e.Item.FindControl("lblExpTotByUser"), Label).Text = CType(e.Item.DataItem, DataRow)(7)
            DirectCast(e.Item.FindControl("lblProject"), Label).Text = CType(e.Item.DataItem, DataRow)(1)
            ' Accumulate Total
            Total += CType(e.Item.DataItem, DataRow)(7)
        End If
        If e.Item.ItemType = ListItemType.Footer Then
            DirectCast(e.Item.FindControl("lblTotalByUser"), Label).Text = Total
            ' Accumulate Grand Total
            GrandTotal += Total
            ' Reset Total
            Total = 0
        End If
    End Sub

#End Region
#End Region

#Region " SUBMIT DETAILS "

    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        LoadProjectDetails()
        pgHead.Visible = True
       
        setBorder = "border='5px'"




       


        ' Set Month Period Header
        If Request.Form("ucReportFilters:optExpenseMonth") = "optMonthView" Then
            'Calculate the expense month
            lblMonth.Text = MonthName(Request.Form("ucReportFilters:ddlMonth")) & " " & Request.Form("ucReportFilters:ddlYear")
        Else
            Dim StartName As String = MonthName(Month(System.DateTime.ParseExact(Request.Form("ucReportFilters:txtStartDate"), "dd/MM/yyyy", en))) & " " & Year(System.DateTime.ParseExact(Request.Form("ucReportFilters:txtStartDate"), "dd/MM/yyyy", en))
            Dim EndName As String = MonthName(Month(System.DateTime.ParseExact(Request.Form("ucReportFilters:txtEndDate"), "dd/MM/yyyy", en))) & " " & Year(System.DateTime.ParseExact(Request.Form("ucReportFilters:txtEndDate"), "dd/MM/yyyy", en))
            If StartName = EndName Then
                lblMonth.Text = StartName
            Else
                lblMonth.Text = StartName & " - " & EndName
            End If
        End If

        'tblPage.Border = 1
        Common.ExportExcel(divReport, Me)
    End Sub
#End Region

End Class
