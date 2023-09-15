Public Class ProjStatus
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtStartDate As Intermap.Controls.IMTextBox
    Protected WithEvents txtEndDate As Intermap.Controls.IMTextBox

    Protected WithEvents txtProjStart As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtProjEnd As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudget As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudgetHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents dgTable As System.Web.UI.WebControls.DataGrid
    Protected WithEvents IMLineChart As Intermap.Controls.IMChart
    Protected WithEvents StartDate As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents EndDate As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents divTable As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents divChart As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents divChart2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents dgTable2 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents rdoOutput As System.Web.UI.WebControls.RadioButtonList
    Protected WithEvents rdoDisplay As System.Web.UI.WebControls.RadioButtonList
    Protected WithEvents rdoCumulative As System.Web.UI.WebControls.RadioButtonList
    Protected WithEvents btnGenerate As System.Web.UI.WebControls.Button
    Protected WithEvents ddlClient As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlProject As System.Web.UI.WebControls.DropDownList
    Protected WithEvents hidClientID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidProjectID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents Imagebutton1 As System.Web.UI.WebControls.ImageButton
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents ReportPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents IMTextBox1 As Intermap.Controls.IMTextBox
    Protected WithEvents IMTextBox2 As Intermap.Controls.IMTextBox
    Protected WithEvents tblButtons As System.Web.UI.HtmlControls.HtmlTable

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
        Dim Role As String = "53"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            ' Load the values from the Report Selection Page
            LoadDropLists()

            Dim monthstart As Date
            monthstart = Month(Today()) & "/01/" & Year(Today())
            ' Try loading Dates from Session Vars if they exist
            If Session("Rep_StartDate") <> "" Then
                txtStartDate.Text = Session("Rep_StartDate")
            Else
                txtStartDate.Text = monthstart.ToString("dd/MM/yyyy", en)
            End If
            If Session("Rep_EndDate") <> "" Then
                txtEndDate.Text = Session("Rep_EndDate")
            Else
                txtEndDate.Text = Today().ToString("dd/MM/yyyy")
            End If

            'set the hidden text boxes for the drop downs
            hidClientID.Value = Session("Rep_ClientID")
            hidProjectID.Value = Session("Rep_ProjectID")

            divReport.Visible = False
            tblButtons.Visible = False
        Else

            'set the hidden text boxes for the drop downs
            hidClientID.Value = Request.Form("ddlClient")
            hidProjectID.Value = Request.Form("ddlProject")

            divReport.Visible = True
            tblButtons.Visible = True
        End If

    End Sub

    Private Sub LoadDropLists()
        Dim DS As DataSet = DAL.LoadReportSelections()
        ' Load the Clients Droplist
        ddlClient.DataSource = DS.Tables(0)
        ddlClient.DataBind()
        ddlClient.Items.Insert(0, New ListItem("All", "0"))

        If ddlClient.Items.Count = 0 Then
            Response.Redirect("NoDataFound.aspx")
        End If

        ' Load the Projects Droplist
        ddlProject.DataSource = DS.Tables(1)
        ddlProject.DataBind()
        ddlProject.Items.Insert(0, New ListItem("All", "0#0"))

        If ddlProject.Items.Count = 0 Then
            Response.Redirect("NoDataFound.aspx")
        End If
    End Sub

    Private Sub LoadProjectHeader()
        Dim DR As SqlDataReader
        DR = DAL.LoadProjectHeader(Request.Form("ddlProject"), System.DateTime.ParseExact(Session("Rep_StartDate"), "dd/MM/yyyy", en), System.DateTime.ParseExact(Session("Rep_EndDate"), "dd/MM/yyyy", en))
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
        Session("Cumulative") = rdoCumulative.SelectedValue '"False"

        If Session("OutputBase") = "Time" Then
            DR = DAL.ReportProjStatus(Request.Form("ddlProject"), System.DateTime.ParseExact(Session("Rep_StartDate"), "dd/MM/yyyy", en), System.DateTime.ParseExact(Session("Rep_EndDate"), "dd/MM/yyyy", en), "Time")
        Else
            ' Output as Financial
            DR = DAL.ReportProjStatus(Request.Form("ddlProject"), System.DateTime.ParseExact(Session("Rep_StartDate"), "dd/MM/yyyy", en), System.DateTime.ParseExact(Session("Rep_EndDate"), "dd/MM/yyyy", en), "Fin")
        End If
        Dim SummaryRow As DataRow
        Dim TempBud As Decimal = 0
        Dim TempTime As Decimal = 0
        Dim TempExp As Decimal = 0
        Dim SummaryTable As DataTable = New DataTable("RESULTS")
        SummaryTable.Columns.Add("Month", GetType(System.String))
        SummaryTable.Columns.Add("Budget", GetType(System.String))
        SummaryTable.Columns.Add("TimeCost", GetType(System.String))
        SummaryTable.Columns.Add("ExpCost", GetType(System.String))
        SummaryTable.Columns.Add("TotCost", GetType(System.String))

        Dim ChartRow As DataRow
        Dim ChartTable As DataTable = New DataTable("RESULTS")
        ChartTable.Columns.Add("Month", GetType(System.String))
        ChartTable.Columns.Add("Budget", GetType(System.String))
        ChartTable.Columns.Add("TimeCost", GetType(System.String))
        If Session("OutputBase") = "Financial" Then
            ChartTable.Columns.Add("ExpCost", GetType(System.String))
            ChartTable.Columns.Add("TotCost", GetType(System.String))
        End If

        While DR.Read()
            SummaryRow = SummaryTable.NewRow()
            SummaryRow("Month") = GetMonth(DR.Item("Mnth"), DR.Item("Yr"))

            ChartRow = ChartTable.NewRow()
            ChartRow("Month") = GetMonth(DR.Item("Mnth"), DR.Item("Yr"))
            If Session("Cumulative") = "True" Then
                TempBud += Convert.ToDecimal(Common.cNull(DR.Item("Budget")))
                TempTime += Convert.ToDecimal(Common.cNull(DR.Item("TimeCost")))
                TempExp += Convert.ToDecimal(Common.cNull(DR.Item("ExpCost")))
            Else
                TempBud = Convert.ToDecimal(Common.cNull(DR.Item("Budget")))
                TempTime = Convert.ToDecimal(Common.cNull(DR.Item("TimeCost")))
                TempExp = Convert.ToDecimal(Common.cNull(DR.Item("ExpCost")))
            End If
            ChartRow("Budget") = TempBud
            ChartRow("TimeCost") = TempTime
            If Session("OutputBase") = "Financial" Then
                ChartRow("ExpCost") = TempExp
                ChartRow("TotCost") = Calc(TempTime, TempExp)
            End If
            ChartTable.Rows.Add(ChartRow)

            SummaryRow("Budget") = TempBud.ToString("#,##0.00")
            SummaryRow("TimeCost") = TempTime.ToString("#,##0.00")
            SummaryRow("ExpCost") = TempExp.ToString("#,##0.00")
            SummaryRow("TotCost") = Calc(TempTime, TempExp).ToString("#,##0.00") 'String.Format("{0:D}", Calc(TempTime, TempExp))
            SummaryTable.Rows.Add(SummaryRow)
        End While

        DR.Close()

        If Session("Display") = "Table" Or Session("Display") = "Both" Then
            LoadDataGrid(SummaryTable)
        End If

        If Session("Display") = "Graph" Or Session("Display") = "Both" Then
            LoadLineChart(ChartTable)
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

    Private Function GetMonth(ByVal Mnth As Int16, ByVal Yr As String, Optional ByVal includeYr As Boolean = False) As String
        Dim RetVal As String
        If includeYr = True Then
            RetVal = MonthName(Mnth, True) & " " & Yr
        Else
            RetVal = MonthName(Mnth, True)
        End If
        Return RetVal
    End Function

    Private Function Calc(ByVal dblA As Decimal, ByVal dblB As Decimal) As Decimal
        Dim RetVal As Decimal = 0
        RetVal = (dblA + dblB)
        Return RetVal
    End Function

    Private Sub LoadLineChart(ByVal SummaryTable As DataTable)
        ' Load the data to the relevant fields

        ' Set Chart Labels
        Dim ChartTitle As String = "" '"Scenario " & Session("ScenarioA_Name") & ":\n" & Session("ScenarioA_LevelName") & " Year on Year Change"
        Dim RangeAxisLabel As String = ""
        Dim SampleAxisLabel As String = "" '"Month"
        Dim SampleLabels As String
        Dim SeriesLabels As String
        If Session("OutputBase") = "Financial" Then
            SeriesLabels = "Planned,Actual,Expenses,Total"
        Else
            SeriesLabels = "Planned,Actual"
        End If

        ' Set Chart Data
        Dim Sample_0 As String = ""
        Dim Sample_1 As String = ""
        Dim Sample_2 As String = ""
        Dim Sample_3 As String = ""

        Dim Row As DataRow
        For Each Row In SummaryTable.Rows
            '' Exclude the Totals Row Data
            'If Left(Row.Item("Item"), 1) <> "<" Then
            ' Replace commas in value with space as Samples and SampleLabels are comma delimited
            Sample_0 = Sample_0 & "," & Row.Item("Budget").ToString.Replace(",", " ")
            Sample_1 = Sample_1 & "," & Row.Item("TimeCost").ToString.Replace(",", " ")
            If Session("OutputBase") = "Financial" Then
                Sample_2 = Sample_2 & "," & Row.Item("ExpCost").ToString.Replace(",", " ")
                Sample_3 = Sample_3 & "," & Row.Item("TotCost").ToString.Replace(",", " ")
            End If
            SampleLabels = SampleLabels & "," & (Row.Item("Month").ToString.Replace(",", " ")).Replace("'", "")
            'End If
        Next
        'Trimming the extra comas that were generated 
        Sample_0 = Sample_0.Trim(",")
        Sample_1 = Sample_1.Trim(",")
        Sample_2 = Sample_2.Trim(",")
        Sample_3 = Sample_3.Trim(",")
        SampleLabels = SampleLabels.Trim(",")

        Dim arrData As New Collections.Specialized.StringCollection
        arrData.Add(Sample_0)
        arrData.Add(Sample_1)
        If Session("OutputBase") = "Financial" Then
            arrData.Add(Sample_2)
            arrData.Add(Sample_3)
        End If

        With IMLineChart
            ' Applet Layout
            .ChartType = ChartTypes.Line

            ' Values
            If Session("OutputBase") = "Financial" Then
                .seriesCount = "4"
            Else
                .seriesCount = "2"
            End If
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
            .barLabelStyle = "floating"
            .valueLabelsOn = False
            .valueLabelStyle = "floating"
            .legendOn = "true"
            .legendPosition = "bottom"
            .sampleAxisLabel = SampleAxisLabel
            .sampleAxisLabelFont = "Arial, bold, 11"

            '' Style
            .visibleSamples = "0,9"

            '' Colors
            .multiColorOn = True
            .background = "#DEE0BC"
        End With

        If SummaryTable.Rows.Count() > 0 Then
            divReport.Style("DISPLAY") = "block"
            divChart.Visible = True
        End If

    End Sub
#End Region

#Region " SUBMIT DETAILS "

    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        LoadReportData()
        Common.ExportExcel(divTable, Me)
    End Sub
#End Region

    Private Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click
        Session("Rep_StartDate") = txtStartDate.Text
        Session("Rep_EndDate") = txtEndDate.Text
        Session("Rep_ClientID") = hidClientID.Value
        Session("Rep_ProjectID") = hidProjectID.Value

        LoadReportData()
    End Sub
End Class
