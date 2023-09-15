Public Class Exceptions
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlTeamLeader As System.Web.UI.WebControls.DropDownList
    Protected WithEvents dgReport As System.Web.UI.WebControls.DataGrid
    Protected WithEvents dgLegend As System.Web.UI.WebControls.DataGrid
    Protected WithEvents btnGenerate As System.Web.UI.WebControls.Button
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents ReportPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl

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
#End Region

#Region " PAGE DECLARES "
    Dim url As String
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Check if the the user has permission for the page else send to the start page
        UserLogin.CheckUserAccess("55", context, True)

        If Not IsPostBack Then
            Session("PageType") = "Report"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Exceptions Report"
            LoadDropLists()

            divReport.Visible = False
        Else
            divReport.Visible = True
            PopulateDataGrid()
        End If
    End Sub

    Private Sub LoadDropLists()

        ' Load the TeamLeader Droplist
        ddlTeamLeader.DataSource = DAL.LoadTeamLeaders()
        ddlTeamLeader.DataBind()
        ddlTeamLeader.Items.Insert(0, New ListItem("All", "0"))
    End Sub

    Private Sub PopulateDataGrid()

        Dim ProjectsRow As DataRow
        Dim ProjectsTable As DataTable = New DataTable("RESULTS")
        ProjectsTable.Columns.Add("ID", GetType(System.String))
        ProjectsTable.Columns.Add("Start", GetType(System.String))
        ProjectsTable.Columns.Add("End", GetType(System.String))
        ProjectsTable.Columns.Add("Name", GetType(System.String))
        ProjectsTable.Columns.Add("TimeStatus", GetType(System.String))
        ProjectsTable.Columns.Add("CostStatus", GetType(System.String))

        DR = DAL.ReportExceptions(ddlTeamLeader.SelectedValue)
        While DR.Read()
            ProjectsRow = ProjectsTable.NewRow()
            ProjectsRow("ID") = DR.Item("ProjectID")
            ProjectsRow("Start") = DR.Item("StartDate")
            ProjectsRow("End") = DR.Item("EndDate")
            ProjectsRow("Name") = DR.Item("ProjectName")
            ProjectsRow("TimeStatus") = GetIndicator(DR.Item("Hrs"), DR.Item("BudHrs"), System.DateTime.ParseExact(DR.Item("StartDate"), "dd/MM/yyyy", en), System.DateTime.ParseExact(DR.Item("EndDate"), "dd/MM/yyyy", en))
            ProjectsRow("CostStatus") = GetIndicator(DR.Item("Cost"), DR.Item("BudCost"), System.DateTime.ParseExact(DR.Item("StartDate"), "dd/MM/yyyy", en), System.DateTime.ParseExact(DR.Item("EndDate"), "dd/MM/yyyy", en))
            ProjectsTable.Rows.Add(ProjectsRow)
        End While

        dgReport.DataSource = ProjectsTable
        dgReport.DataBind()
        If dgReport.Items.Count() > 0 Then
            PopulateLegendDg()
            divReport.Style("DISPLAY") = "block"
        End If
    End Sub

    Private Sub PopulateLegendDg()

        Dim LegendRow As DataRow
        Dim LegendTable As DataTable = New DataTable("RESULTS")
        LegendTable.Columns.Add("Status", GetType(System.String))
        LegendTable.Columns.Add("Colour", GetType(System.String))

        LegendRow = LegendTable.NewRow()
        LegendRow("Status") = "On Track"
        LegendRow("Colour") = StatusColour("On Track")
        LegendTable.Rows.Add(LegendRow)
        LegendRow = LegendTable.NewRow()
        LegendRow("Status") = "Over"
        LegendRow("Colour") = StatusColour("Over")
        LegendTable.Rows.Add(LegendRow)
        LegendRow = LegendTable.NewRow()
        LegendRow("Status") = "Under"
        LegendRow("Colour") = StatusColour("Under")
        LegendTable.Rows.Add(LegendRow)


        dgLegend.DataSource = LegendTable
        dgLegend.DataBind()

    End Sub

    Private Function GetIndicator(ByVal Actual As Integer, ByVal Budget As Integer, ByVal StartDate As DateTime, ByVal EndDate As DateTime) As String

        ' Over = Red, OnTrack = White, Under = Green
        Dim BudgetDays As Integer = 0 ' No of days from Project start to Project End
        Dim ActualDays As Integer = 0 ' No of Days from Project Start to Now
        Dim BudgetPerDay As Double = 0 ' Budget / BudgetDays
        Dim ActualPerDay As Double = 0 ' Actual / ActualDays

        BudgetDays = DateDiff(DateInterval.Day, StartDate, EndDate)

        'SD: 24/10/2005 - If we have already gone over buget then return over
        If Actual > Budget Then
            Return "Over"
            Exit Function
        End If

        'SD: 21/10/2005 - Need to trap for when the start and end date are the same day
        'Can't really monitor progress so return on track
        If BudgetDays = 0 Then
            Return "On Track"
            Exit Function
        End If

        ActualDays = DateDiff(DateInterval.Day, StartDate, Today())
        BudgetPerDay = Budget / BudgetDays
        ActualPerDay = Actual / ActualDays

        Select Case (BudgetPerDay - ActualPerDay)
            Case Is > 0
                'Under
                Return "Under"
            Case Is < 0
                'Over
                Return "Over"
            Case 0
                'On Track
                Return "On Track"
        End Select

    End Function

    Private Function StatusColour(ByVal Status As String) As String
        Dim Colour As String
        Select Case Status
            Case "On Track"
                Colour = "White"
            Case "Over"
                Colour = "Red"
            Case "Under"
                Colour = "Green"
        End Select
        Return Colour


    End Function

    Private Sub dgReport_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgReport.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            'e.Item.Cells(3).Attributes.Add("style", "cursor:hand")
            'url = "SessionSet.aspx?ProjID=" & e.Item.DataItem("ID") & "&Start=" & e.Item.DataItem("Start") & "&End=" & e.Item.DataItem("End") & "&RepID=50"
            'e.Item.Cells(3).Attributes.Add("onclick", "window.open('" & url & "','PopUp','toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=600,top=50,left=50,resizable=1');")
            e.Item.Cells(4).Attributes.Add("bgcolor", StatusColour(e.Item.DataItem("TimeStatus")))
            e.Item.Cells(4).Attributes.Add("style", "cursor:hand")
            url = "SessionSet.aspx?ProjID=" & e.Item.DataItem("ID") & "&Start=" & e.Item.DataItem("Start") & "&End=" & e.Item.DataItem("End") & "&RepID=52"
            e.Item.Cells(4).Attributes.Add("onclick", "window.open('" & url & "','PopUp','toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=600,top=50,left=50,resizable=1');")
            e.Item.Cells(4).ToolTip = e.Item.DataItem("TimeStatus")
            e.Item.Cells(4).Text = ""
            e.Item.Cells(5).Attributes.Add("bgcolor", StatusColour(e.Item.DataItem("CostStatus")))
            e.Item.Cells(5).ToolTip = e.Item.DataItem("CostStatus")
            e.Item.Cells(5).Text = ""
            e.Item.Cells(5).Attributes.Add("style", "cursor:hand")
            url = "SessionSet.aspx?ProjID=" & e.Item.DataItem("ID") & "&Start=" & e.Item.DataItem("Start") & "&End=" & e.Item.DataItem("End") & "&RepID=52"
            e.Item.Cells(5).Attributes.Add("onclick", "window.open('" & url & "','PopUp','toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=600,top=50,left=50,resizable=1');")
        End If
    End Sub

#End Region

#Region " SUBMIT DETAILS "

    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        Common.ExportExcel(ReportPlace, Me)
    End Sub
#End Region

    Private Sub dgLegend_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgLegend.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            e.Item.Cells(1).Attributes.Add("bgcolor", StatusColour(e.Item.DataItem("Status")))
            e.Item.Cells(1).Text = "" 'e.Item.DataItem("TimeStatus")
        End If
    End Sub
End Class
