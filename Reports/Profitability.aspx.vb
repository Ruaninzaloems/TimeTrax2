Public Class Profitability
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlProjects As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtStartDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtEndDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents rdoOutput As System.Web.UI.WebControls.RadioButtonList
    Protected WithEvents rdoDisplay As System.Web.UI.WebControls.RadioButtonList
    Protected WithEvents imgRegenerate As System.Web.UI.WebControls.ImageButton
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents txtProjStart As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtProjEnd As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudget As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudgetHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents IMBarChart As Intermap.Controls.IMChart
    Protected WithEvents dgTable As System.Web.UI.WebControls.DataGrid
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents StartDate As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents EndDate As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents divChart As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents divTable As System.Web.UI.HtmlControls.HtmlGenericControl

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
#End Region

#Region " PAGE DECLARES "
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "54"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            ' Load the values from the Report Selection Page
            LoadProjectsDropList()
            txtStartDate.Text = Session("Rep_StartDate")
            txtEndDate.Text = Session("Rep_EndDate")
        End If
        LoadReportData()
    End Sub

    Private Sub LoadProjectsDropList()
        ddlProjects.DataSource = DAL.ReportSelectProjects(IIf(Session("Rep_ClientID") Is Nothing, "0", Session("Rep_ClientID")), System.DateTime.ParseExact(Session("Rep_StartDate"), "dd/MM/yyyy", en), System.DateTime.ParseExact((Session("Rep_EndDate")), "dd/MM/yyyy", en), IIf(Session("Rep_TaskID") Is Nothing, "0", Session("Rep_TaskID")), IIf(Session("Rep_Users") Is Nothing, "", Session("Rep_Users")))
        ddlProjects.DataBind()
        If ddlProjects.Items.Count = 0 Then
            Response.Redirect("NoDataFound.aspx")
        End If
        If Session("Rep_ProjectID") = "0" Then
            ' Select the first project in the list
            ddlProjects.SelectedIndex = 0
        Else
            ddlProjects.SelectedValue = Session("Rep_ProjectID")
        End If
    End Sub

    Private Sub LoadProjectHeader()
        Dim DR As SqlDataReader
        DR = DAL.LoadProjectHeader(ddlProjects.SelectedValue, System.DateTime.ParseExact(Session("Rep_StartDate"), "dd/MM/yyyy", en), System.DateTime.ParseExact(Session("Rep_EndDate"), "dd/MM/yyyy", en))
        If DR.Read() Then
            txtProjStart.Text = DR.Item("txtProjStart")
            txtProjEnd.Text = DR.Item("txtProjEnd")
            txtBudget.Text = String.Format("{0:C}", Convert.ToDecimal(DR.Item("Budget")))
            txtToDateCost.Text = String.Format("{0:C}", Convert.ToDecimal(DR.Item("CostToDate")))
            txtPeriodCost.Text = String.Format("{0:C}", Convert.ToDecimal(DR.Item("PeriodCost")))
            txtBudgetHrs.Text = Convert.ToDecimal(DR.Item("BudgetHours"))
            txtToDateHrs.Text = Convert.ToDecimal(DR.Item("HoursToDate"))
            txtPeriodHrs.Text = Convert.ToDecimal(DR.Item("PeriodHours"))
        End If

    End Sub

    Private Sub LoadReportData()
        Dim DR As SqlDataReader

        divTable.Visible = False
        divChart.Visible = False

        LoadProjectHeader()
        'TODO: These will eventually be set by calling page

        Session("Display") = rdoDisplay.SelectedValue '"Both"
        Session("OutputBase") = rdoOutput.SelectedValue '"Financial"

        If Session("OutputBase") = "Time" Then
            DR = DAL.ReportProfitability(ddlProjects.SelectedValue, System.DateTime.ParseExact(Session("Rep_StartDate"), "dd/MM/yyyy", en), System.DateTime.ParseExact(Session("Rep_EndDate"), "dd/MM/yyyy", en), "Time")
        Else
            ' Output as Financial
            DR = DAL.ReportProfitability(ddlProjects.SelectedValue, System.DateTime.ParseExact(Session("Rep_StartDate"), "dd/MM/yyyy", en), System.DateTime.ParseExact(Session("Rep_EndDate"), "dd/MM/yyyy", en), "Fin")
        End If
        Dim SummaryRow As DataRow
        Dim TempBill As Decimal = 0
        Dim TempNonBill As Decimal = 0
        Dim SummaryTable As DataTable = New DataTable("RESULTS")
        SummaryTable.Columns.Add("Week", GetType(System.String))
        SummaryTable.Columns.Add("Billable", GetType(System.String))
        SummaryTable.Columns.Add("NonBillable", GetType(System.String))
        SummaryTable.Columns.Add("CumulativeBillable", GetType(System.String))
        SummaryTable.Columns.Add("CumulativeNonBillable", GetType(System.String))
        SummaryTable.Columns.Add("TotHrs", GetType(System.String))

        Dim ChartRow As DataRow
        Dim ChartTable As DataTable = New DataTable("RESULTS")
        ChartTable.Columns.Add("Week", GetType(System.String))
        ChartTable.Columns.Add("Billable", GetType(System.String))
        ChartTable.Columns.Add("NonBillable", GetType(System.String))

        While DR.Read()
            SummaryRow = SummaryTable.NewRow()
            SummaryRow("Week") = DR.Item("Week") & " (" & DR.Item("Yr") & ")"

            ChartRow = ChartTable.NewRow()
            ChartRow("Week") = DR.Item("Week")
            TempBill += Convert.ToDecimal(DR.Item("Billable"))
            TempNonBill += Convert.ToDecimal(DR.Item("NonBillable"))
            ChartRow("Billable") = DR.Item("Billable")
            ChartRow("NonBillable") = DR.Item("NonBillable")
            '            ChartRow("CumulativeBillable") = TempBill
            '            ChartRow("CumulativeNonBillable") = TempNonBill
            ChartTable.Rows.Add(ChartRow)

            SummaryRow("Billable") = Convert.ToDecimal(DR.Item("Billable")).ToString("#,##0.00")
            SummaryRow("NonBillable") = Convert.ToDecimal(DR.Item("NonBillable")).ToString("#,##0.00")
            SummaryRow("CumulativeBillable") = TempBill.ToString("#,##0.00")
            SummaryRow("CumulativeNonBillable") = TempNonBill.ToString("#,##0.00")
            SummaryRow("TotHrs") = Calc(DR.Item("Billable"), DR.Item("NonBillable")).ToString("#,##0.00")
            SummaryTable.Rows.Add(SummaryRow)
        End While

        DR.Close()

        If Session("Display") = "Table" Or Session("Display") = "Both" Then
            LoadDataGrid(SummaryTable)
        End If

        If Session("Display") = "Graph" Or Session("Display") = "Both" Then
            LoadChart(ChartTable)
        End If

    End Sub

    Private Sub LoadDataGrid(ByVal SummaryTable As DataTable)
        dgTable.DataSource = SummaryTable
        dgTable.DataBind()
        If dgTable.Items.Count() > 0 Then
            divReport.Style("DISPLAY") = "block"
            divTable.Visible = True
        End If

    End Sub

    Private Function Calc(ByVal dblA As Decimal, ByVal dblB As Decimal) As Decimal
        Dim RetVal As Decimal = 0
        RetVal = (dblA + dblB)
        Return RetVal
    End Function

    Private Sub LoadChart(ByVal SummaryTable As DataTable)
        ' Load the data to the relevant fields

        ' Set Chart Labels
        Dim ChartTitle As String = "" '"Scenario " & Session("ScenarioA_Name") & ":\n" & Session("ScenarioA_LevelName") & " Year on Year Change"
        Dim RangeAxisLabel As String = "Hours"
        Dim SampleAxisLabel As String = "Week" '"Month"
        Dim SampleLabels As String
        Dim SeriesLabels As String
        SeriesLabels = "Billable,Non Billable"

        ' Set Chart Data
        Dim Sample_0 As String = ""
        Dim Sample_1 As String = ""
        'Dim Sample_2 As String = ""
        'Dim Sample_3 As String = ""

        Dim Row As DataRow
        For Each Row In SummaryTable.Rows
            '' Exclude the Totals Row Data
            'If Left(Row.Item("Item"), 1) <> "<" Then
            ' Replace commas in value with space as Samples and SampleLabels are comma delimited
            Sample_0 = Sample_0 & "," & Row.Item("Billable").ToString.Replace(",", " ")
            Sample_1 = Sample_1 & "," & Row.Item("NonBillable").ToString.Replace(",", " ")
            SampleLabels = SampleLabels & "," & (Row.Item("Week").ToString.Replace(",", " ")).Replace("'", "")
            'End If
        Next
        'Trimming the extra comas that were generated 
        Sample_0 = Sample_0.Trim(",")
        Sample_1 = Sample_1.Trim(",")
        'Sample_2 = Sample_2.Trim(",")
        'Sample_3 = Sample_3.Trim(",")
        SampleLabels = SampleLabels.Trim(",")

        Dim arrData As New Collections.Specialized.StringCollection
        arrData.Add(Sample_0)
        arrData.Add(Sample_1)
        'arrData.Add(Sample_2)
        'arrData.Add(Sample_3)

        With IMBarChart
            ' Applet Layout
            .ChartType = ChartTypes.Bar

            ' Values
            .seriesCount = "2"
            .sampleValues = arrData

            '' Range
            .rangeAxisLabel = RangeAxisLabel
            .rangeAxisLabelFont = "Arial, bold, 11"
            .rangeAxisLabelAngle = "270"
            '.rangeLabelPrefix = "R"

            '' Labels
            .chartTitle = ChartTitle
            .seriesLabels = SeriesLabels
            .sampleLabels = SampleLabels
            .barLabelStyle = "below"
            .valueLabelsOn = True
            .valueLabelStyle = "floating"
            .legendOn = "true"
            .legendPosition = "bottom"
            .sampleAxisLabel = SampleAxisLabel
            .sampleAxisLabelFont = "Arial, bold, 11"

            '' Style
            .visibleSamples = "0,26"
            .barType = "stacked"

            '' Colors
            .multiColorOn = True
            .background = "#DEE0BC"

            ''' Overlay
            '.overlay = "line"
            'With .overlay_
            '    sampleValues = arrData
            '    multiColorOn = True

            'End With
        End With

        If SummaryTable.Rows.Count() > 0 Then
            divReport.Style("DISPLAY") = "block"
            divChart.Visible = True
        End If

    End Sub
#End Region

#Region " SUBMIT DETAILS "
    Private Sub imgRegenerate_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgRegenerate.Click
        Session("Rep_StartDate") = txtStartDate.Text
        Session("Rep_EndDate") = txtEndDate.Text
        ' Reload Project Droplist
        LoadProjectsDropList()

        LoadReportData()

    End Sub

    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        LoadReportData()
        Common.ExportExcel(divTable, Me)
    End Sub
#End Region

End Class
