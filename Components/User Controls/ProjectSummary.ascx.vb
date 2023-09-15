Public Class ProjectSummary
    Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Imagebutton1 As System.Web.UI.WebControls.ImageButton
    Protected WithEvents txtProjStart As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtProjEnd As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudget As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudgetHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents ReportPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents txtTest As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtProjectName As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodStart As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodEnd As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtExpectedCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtExpectedHours As System.Web.UI.WebControls.TextBox
    Protected WithEvents divFilterDetails As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents txtHidAppPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents Printbtn As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents imgPrinterPopup As System.Web.UI.HtmlControls.HtmlImage

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
    Dim DS As DataSet

    Dim Level1row As DataRow
    Dim Level2row As DataRow
    Dim DataLevel As DataRow

    Dim tblRep As HtmlTable
    Dim tblReprow As HtmlTableRow
    Dim tblRepcell As HtmlTableCell

    Dim Table2 As HtmlTable

    Dim SecondLevelRow As HtmlTableRow
    Dim SecondLevelCell As HtmlTableCell

    Dim DataLevelRow As HtmlTableRow
    Dim DataLevelCell As HtmlTableCell

    Dim TotHrs As Decimal = 0
    Dim TotFees As Decimal = 0
    Dim TotExpenses As Decimal = 0
    Dim TotCost As Decimal = 0
#End Region

#Region "PUBLIC VARIABLES"
    '  Public Shared ProjectID As Integer
    Public Shared ProjectID As Integer
    Public Shared StartDate As String
    Public Shared EndDate As String
    Public Shared ShowExport As Boolean = True
    Public Shared ShowPrint As Boolean = True       'This is used for using print special - ie. has to remove headers etc
    Public Shared ShowPrintPopup As Boolean = True  'This is used for when you can just print the page as is

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    End Sub

#Region "Build HTML Table"

    Private Sub SetDefaults()
        'Set the app path - used for the printer window
        txtHidAppPath.Value = Request.ApplicationPath

        'Hide/Show the relevant icons
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
    End Sub

    Public Sub LoadProjectDetails()

        SetDefaults()

        Dim dr1 As DataRelation

        DS = New DataSet

        DS = DAL.ReportProjectSummary(ProjectID, StartDate, EndDate)

        ' Name the tables
        DS.Tables(0).TableName = "Level1" '"Project"
        DS.Tables(1).TableName = "Level2" '"Project Costs"
        ' Set up relationships
        dr1 = New DataRelation("Level1_Level2", DS.Tables("Level1").Columns("ProjectID"), DS.Tables("Level2").Columns("ProjectID"))
        dr1.Nested = True
        DS.Relations.Add(dr1)

        BuildHtmlTable()

    End Sub

    Private Sub BuildHtmlTable()

        ReportPlace.Controls.Clear()

        tblRep = New HtmlTable
        tblRep.Attributes.Add("class", "tableReport%")
        tblRep.Attributes.Add("width", "100%")
        tblRep.Border = 1
        ReportPlace.Controls.Add(tblRep)

        'Load the project header
        If DS.Tables("Level1").Rows.Count > 0 Then
            LoadProjectHeader(DS.Tables("Level1").Rows(0))
        End If

        ' Build Header Row
        BuildHeaderRow(tblRep)

        For Each Level1row In DS.Tables("Level1").Rows
            ' For Each Project

            '	<TR>
            ' 	<TH class="th4" colspan=6>
            tblReprow = New HtmlTableRow
            tblRep.Rows.Add(tblReprow)
            tblRepcell = New HtmlTableCell("th")
            tblReprow.Cells.Add(tblRepcell)
            tblRepcell.Attributes.Add("class", "th4")
            tblRepcell.ColSpan = 6

            ClearTotals()
            For Each DataLevel In Level1row.GetChildRows("Level1_Level2")
                AddData()
            Next
            AddTotals()
        Next

    End Sub

    Private Sub AddTotalCell(ByVal TotalRow As HtmlTableRow, ByVal Amount As Decimal, ByVal blnCurrency As Boolean)

        Dim TotalCell As HtmlTableCell

        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.Attributes.Add("align", "right")
        TotalCell.InnerHtml = String.Format("{0:C}", Amount)
        TotalCell.Attributes.Add("class", "tdreportTotal")

        If blnCurrency Then
            TotalCell.InnerHtml = String.Format("{0:C}", Amount)
        Else
            TotalCell.InnerHtml = Decimal.Round(Amount, 2)
        End If

    End Sub

    Private Sub AddTotals()

        Dim TotalCell As HtmlTableCell

        'Add Total Row
        '<TR>
        '   <TD>"Total"
        '   <TD>Time Total
        '   <TD>
        '   <TD>Fees Total
        '   <TD>Expenses Total
        '   <TD>Total Total
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.Attributes.Add("align", "left")
        TotalCell.InnerHtml = "Total"
        TotalCell.Attributes.Add("class", "tdreportTotal")

        AddTotalCell(tblReprow, TotHrs, False)
        Common.AddSpacerCell(tblReprow, 1)
        AddTotalCell(tblReprow, TotFees, True)
        AddTotalCell(tblReprow, TotExpenses, True)
        AddTotalCell(tblReprow, TotCost, True)

    End Sub

    Private Sub ClearTotals()
        TotHrs = 0
        TotFees = 0
        TotExpenses = 0
        TotCost = 0
    End Sub

    Private Sub LoadProjectHeader(ByVal HeaderRow As DataRow)

        txtProjStart.Text = HeaderRow.Item("txtProjStart")
        txtProjEnd.Text = HeaderRow.Item("txtProjEnd")
        txtBudget.Text = String.Format("{0:C}", Convert.ToDecimal(HeaderRow.Item("Budget")))
        txtToDateCost.Text = String.Format("{0:C}", Convert.ToDecimal(HeaderRow.Item("CostToDate")))
        txtBudgetHrs.Text = Convert.ToDecimal(HeaderRow.Item("BudgetHours"))
        txtToDateHrs.Text = Convert.ToDecimal(HeaderRow.Item("HoursToDate"))
        txtProjectName.Text = HeaderRow.Item("ProjectName")
        txtPeriodStart.Text = StartDate
        txtPeriodEnd.Text = EndDate

        CalculateExpected(Convert.ToDecimal(HeaderRow.Item("Budget")), _
                          Convert.ToDecimal(HeaderRow.Item("BudgetHours")), _
                          System.DateTime.ParseExact(HeaderRow.Item("txtProjStart"), "dd/MM/yyyy", en), _
                          System.DateTime.ParseExact(HeaderRow.Item("txtProjEnd"), "dd/MM/yyyy", en), _
                          System.DateTime.ParseExact(EndDate, "dd/MM/yyyy", en))
    End Sub

    Private Sub CalculateExpected(ByVal Budget As Double, ByVal BudgetHours As Double, ByVal ProjectStartDate As DateTime, _
                                  ByVal ProjectEndDate As DateTime, ByVal PeriodEndDate As DateTime)

        Dim BudgetDays As Integer = 0 ' No of days from Project start to Project End
        Dim ActualDays As Integer = 0 ' No of Days from Project Start to End of Period
        Dim BudgetPerDay As Double = 0 ' Budget / BudgetDays
        Dim BudgetHoursPerDay As Double = 0 'Budget Hours/ BudgetDays
        Dim Expected As Double
        Dim ExpectedHours As Double

        BudgetDays = DateDiff(DateInterval.Day, ProjectStartDate, ProjectEndDate)
        ActualDays = DateDiff(DateInterval.Day, ProjectStartDate, PeriodEndDate)

        BudgetPerDay = Budget / BudgetDays
        BudgetHoursPerDay = BudgetHours / BudgetDays

        Expected = BudgetPerDay * ActualDays
        ExpectedHours = BudgetHoursPerDay * ActualDays


        txtExpectedCost.Text = String.Format("{0:C}", Convert.ToDecimal(Expected))
        txtExpectedHours.Text = Decimal.Round(Convert.ToDecimal(ExpectedHours), 2)

        'If the expected cost/time is greater than the bugetted cost/time - set the value to the budget amount
        If txtExpectedCost.Text > txtBudget.Text Then
            txtExpectedCost.Text = txtBudget.Text
        End If

        If txtExpectedHours.Text > txtBudgetHrs.Text Then
            txtExpectedHours.Text = txtBudgetHrs.Text
        End If

    End Sub

    Private Sub BuildHeaderRow(ByVal RepTable As HtmlTable)
        '         <TR>
        '           <TH>User</TH>
        '           <TH>Time</TH>
        '           <TH>Rate</TH>
        '           <TH>Fees</TH>
        '           <TH>Expenses</TH>
        '           <TH>Total</TH>
        '         </TR>

        Dim HeaderCell As HtmlTableCell
        Dim HeaderRow As HtmlTableRow

        HeaderRow = New HtmlTableRow
        RepTable.Controls.Add(HeaderRow)

        Common.AddHeaderCell(HeaderRow, "User", "20%")
        Common.AddHeaderCell(HeaderRow, "Time", "6%")
        Common.AddHeaderCell(HeaderRow, "Rate", "10%")
        Common.AddHeaderCell(HeaderRow, "Fees", "20%")
        Common.AddHeaderCell(HeaderRow, "Expenses", "20%")
        Common.AddHeaderCell(HeaderRow, "Total", "20%")

    End Sub

    Private Sub AddDataCell(ByVal tableRow As HtmlTableRow, ByVal strColName As String)

        Dim DataCell As New HtmlTableCell("td")

        tblReprow.Cells.Add(DataCell)

        If strColName.ToUpper = "USERNAME" Then
            DataCell.Attributes.Add("align", "left")
            DataCell.InnerText = IIf(DataLevel.Item(strColName) Is DBNull.Value, "&nbsp;", DataLevel.Item(strColName))
        ElseIf strColName.ToUpper = "TIME" Then
            DataCell.Attributes.Add("align", "right")
            If DataLevel.Item("Rate") <> 0 Then 'Check for division by 0
                DataCell.InnerHtml = Decimal.Round(DataLevel.Item("TimeCost") / DataLevel.Item("Rate"), 2)
            Else
                DataCell.InnerHtml = "&nbsp;"
            End If
        ElseIf strColName.ToUpper = "TOTAL" Then
            DataCell.Attributes.Add("align", "right")
            DataCell.InnerHtml = String.Format("{0:C}", Convert.ToDecimal((DataLevel.Item("TimeCost") + DataLevel.Item("ExpCost"))))
        Else
            DataCell.Attributes.Add("align", "right")
            'DataCell.InnerHtml = String.Format("{0:C}", Convert.ToDecimal(DataLevel.Item(strColName)))
            DataCell.InnerHtml = String.Format("{0:C}", Convert.ToDecimal(IIf(DataLevel.Item(strColName) Is DBNull.Value, 0, DataLevel.Item(strColName))))
        End If

        DataCell.Attributes.Add("class", "tdreport")

    End Sub

    Private Sub AddData()

        'Add Data Row
        '<TR>
        '   <TD>UserName
        '   <TD>Time
        '   <TD>Rate
        '   <TD>TimeCost
        '   <TD>ExpCost
        '   <TD>Total
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        AddDataCell(tblReprow, "UserName")
        AddDataCell(tblReprow, "Time")
        AddDataCell(tblReprow, "Rate")
        AddDataCell(tblReprow, "TimeCost")
        AddDataCell(tblReprow, "ExpCost")
        AddDataCell(tblReprow, "Total")

        ' Accumulate Values
        If DataLevel.Item("Rate") <> 0 And Not DataLevel.Item("Rate") Is DBNull.Value Then
            TotHrs += (DataLevel.Item("TimeCost") / DataLevel.Item("Rate"))
        End If
        TotFees += DataLevel.Item("TimeCost")
        TotExpenses += DataLevel.Item("ExpCost")
        TotCost += (DataLevel.Item("TimeCost") + DataLevel.Item("ExpCost"))

    End Sub

#End Region

#Region "Export to Excel"
    Private Sub imgExport_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        LoadProjectDetails()
        Common.ExportExcel(ReportPlace, Me)
    End Sub
#End Region

End Class

