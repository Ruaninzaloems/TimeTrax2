Public Class TaskReg
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ReportPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtProjEnd As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtProjStart As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudget As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtBudgetHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtToDateHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPeriodCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents chtGraph As Intermap.Controls.IMChart

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
    Dim Level3row As DataRow
    Dim Level4row As DataRow

    Dim tblRep As HtmlTable
    Dim tblReprow As HtmlTableRow
    Dim tblRepcell As HtmlTableCell

    Dim FirstLevelRow As HtmlTableRow

    Dim hid As HtmlInputHidden
    Dim Level2TotHrs As Decimal
    Dim Level2TotCost As Decimal

    Dim Level3TotHrs As Decimal
    Dim Level3TotCost As Decimal

    Public SampleLabels As String = ""
    Public ValueLabels As String = ""
    Public OverlayValues As String = ""

#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "50"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            divReport.Visible = False
        Else
            LoadProjectDetails()
            divReport.Visible = True
        End If

    End Sub

    Private Sub LoadProjectDetails()
        Dim dr1 As DataRelation
        Dim dr2 As DataRelation
        Dim dr3 As DataRelation

        DS = New DataSet
        DS = DAL.ReportActivityRegister(Request.Form("ucReportFilters:ddlProject"), _
                                        System.DateTime.ParseExact(Request.Form("ucReportFilters:txtStartDate"), "dd/MM/yyyy", en), _
                                        System.DateTime.ParseExact(Request.Form("ucReportFilters:txtEndDate"), "dd/MM/yyyy", en), _
                                        Request.Form("ucReportFilters:ddlTask"), _
                                        Common.CalcUserString(Request.Form("ucReportFilters:lstUsers")), _
                                        Request.Form("ucReportFilters:grouping_list"), _
                                        Request.Form("ucReportFilters:ddlCaptureType"))

        Select Case Request.Form("ucReportFilters:grouping_list")
            Case ",User,Task,"
                ' Name the tables
                DS.Tables(0).TableName = "Level1" '"Project"
                DS.Tables(1).TableName = "Level2" '"User"
                DS.Tables(2).TableName = "Level3" '"Task"
                DS.Tables(3).TableName = "Level4" '"Timesheet"
                ' Set up relationships
                dr1 = New DataRelation("Level1_Level2", DS.Tables("Level1").Columns("ProjectID"), DS.Tables("Level2").Columns("ProjectID"))
                dr1.Nested = True
                DS.Relations.Add(dr1)
                dr2 = New DataRelation("Level2_Level3", DS.Tables("Level2").Columns("KeyVal"), DS.Tables("Level3").Columns("KeyVal"))
                dr2.Nested = True
                DS.Relations.Add(dr2)
                dr3 = New DataRelation("Level3_Level4", DS.Tables("Level3").Columns("KeyVal2"), DS.Tables("Level4").Columns("KeyVal2"))
                dr3.Nested = True
                DS.Relations.Add(dr3)
                'DS.WriteXml("D:\TaskReg.xml")  'SD: 25/09/2005 - Don't know why this is here!  It doesn't seem to be needed and causes errors if left in
            Case Else
                ' Name the tables
                DS.Tables(0).TableName = "Level1" '"Project"
                DS.Tables(1).TableName = "Level2" '"Task"
                DS.Tables(2).TableName = "Level3" '"User"
                DS.Tables(3).TableName = "Level4" '"Timesheet"
                ' Set up relationships
                dr1 = New DataRelation("Level1_Level2", DS.Tables("Level1").Columns("ProjectID"), DS.Tables("Level2").Columns("ProjectID"))
                dr1.Nested = True
                DS.Relations.Add(dr1)
                dr2 = New DataRelation("Level2_Level3", DS.Tables("Level2").Columns("KeyVal"), DS.Tables("Level3").Columns("KeyVal"))
                dr2.Nested = True
                DS.Relations.Add(dr2)
                dr3 = New DataRelation("Level3_Level4", DS.Tables("Level3").Columns("KeyVal2"), DS.Tables("Level4").Columns("KeyVal2"))
                dr3.Nested = True
                DS.Relations.Add(dr3)
        End Select

        BuildHtmlTable()

        LoadChart(DS.Tables(4))

    End Sub

    Private Sub BuildHtmlTable()

        Dim decTimesheetUserTotal As Decimal

        ReportPlace.Controls.Clear()

        tblRep = New HtmlTable
        tblRep.Attributes.Add("width", "100%")
        tblRep.Attributes.Add("class", "tableReport%")
        ReportPlace.Controls.Add(tblRep)

        If DS.Tables("Level1").Rows.Count > 0 Then
            LoadProjectHeader(DS.Tables("Level1").Rows(0))
        End If

        ' Build Header Row Table
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

            For Each Level2row In Level1row.GetChildRows("Level1_Level2")
                AddLevel2()
                For Each Level3row In Level2row.GetChildRows("Level2_Level3")
                    ClearTotals(3)
                    AddLevel3Row()

                    decTimesheetUserTotal = 0

                    For Each Level4row In Level3row.GetChildRows("Level3_Level4")
                        AddTimesheetData()
                        decTimesheetUserTotal += Convert.ToDecimal((Level4row.Item("Hours") * Level4row.Item("Rate")))
                    Next

                    AddTotalRow(decTimesheetUserTotal)
                Next
            Next
        Next

    End Sub

    Private Sub ClearTotals(ByVal level As Int16)
        If Session("Rep_Totals") = "on" Then
            Select Case level
                Case 2
                    ' Reset Totals
                    Level2TotHrs = 0
                    Level2TotCost = 0
                Case 3
                    ' Reset Totals
                    Level3TotHrs = 0
                    Level3TotCost = 0
            End Select
        End If
    End Sub

    Private Sub LoadProjectHeader(ByVal dRow As DataRow)
        txtProjStart.Text = dRow.Item("txtProjStart")
        txtProjEnd.Text = dRow.Item("txtProjEnd")
        txtBudget.Text = String.Format("{0:C}", Convert.ToDecimal(dRow.Item("Budget")))
        txtToDateCost.Text = String.Format("{0:C}", Convert.ToDecimal(dRow.Item("CostToDate")))
        txtPeriodCost.Text = String.Format("{0:C}", Convert.ToDecimal(dRow.Item("PeriodCost")))
        txtBudgetHrs.Text = Convert.ToDecimal(dRow.Item("BudgetHours"))
        txtToDateHrs.Text = Convert.ToDecimal(dRow.Item("HoursToDate"))
        txtPeriodHrs.Text = Convert.ToDecimal(dRow.Item("PeriodHours"))
    End Sub

    Private Function BuildHeaderRow(ByVal Acell As HtmlTable)
        '         <TR>
        '           <TH>Task or User</TH>
        '           <TH>User or Task</TH>
        '           <TH>Date</TH>
        '           <TH>Rate</TH>
        '           <TH>Time</TH>
        '           <TH>Cost</TH>
        '           <TH>Comment</TH>
        '         </TR>

        FirstLevelRow = New HtmlTableRow
        Acell.Controls.Add(FirstLevelRow)

        ' Add header cells here

        If Request.Form("ucReportFilters:grouping_list") = ",User,Task," Then
            Common.AddHeaderCell(FirstLevelRow, "User", "10%")
            Common.AddHeaderCell(FirstLevelRow, "Task", "10%")
        Else
            Common.AddHeaderCell(FirstLevelRow, "Task", "10%")
            Common.AddHeaderCell(FirstLevelRow, "User", "10%")
        End If

        Common.AddHeaderCell(FirstLevelRow, "Date", "10%")

        Common.AddHeaderCell(FirstLevelRow, "Rate", "10%")

        Common.AddHeaderCell(FirstLevelRow, "Time", "10%")

        Common.AddHeaderCell(FirstLevelRow, "Cost", "10%")

        Common.AddHeaderCell(FirstLevelRow, "Comment", "40%")

    End Function

    Private Sub AddLevel2()

        Dim SecondLevelCell As HtmlTableCell

        ' Create the following table details
        '       <TR>
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        '<TD colspan=2 class="tdreportTotal">UserName or Task Name</TD>
        SecondLevelCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(SecondLevelCell)
        SecondLevelCell.ColSpan = 6
        SecondLevelCell.InnerText = GetTableData(2, 4) 'UserName or Task Name
        SecondLevelCell.Attributes.Add("class", "tdreportTotal")

    End Sub

    Private Sub AddLevel3Row()

        Dim ThirdLevelCell As HtmlTableCell

        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 1)

        '         <TD colspan=5 class=label>UserName</TD>
        ThirdLevelCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(ThirdLevelCell)
        ThirdLevelCell.ColSpan = 5
        ThirdLevelCell.InnerText = GetTableData(3, 4) 'UserName or Task Name
        ThirdLevelCell.Attributes.Add("class", "td")

    End Sub

    Private Sub AddTimesheetData()

        'Add Level 4 Row
        '<TR>
        '   <TD width="5%">
        '   <TD width="5%">
        '   <TD>Date
        '   <TD>Rate
        '   <TD>Hours
        '   <TD>Cost
        '   <TD>Comment

        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 2)

        'Date
        AddFourthLevelCell(tblReprow, "txtDate")

        'Rate
        AddFourthLevelCell(tblReprow, "Rate")

        'Hours
        AddFourthLevelCell(tblReprow, "Hours")

        'Cost(Hrs * Rate)
        AddFourthLevelCell(tblReprow, "Cost")

        'Comment
        AddFourthLevelCell(tblReprow, "Comment")

    End Sub

    Private Sub AddFourthLevelCell(ByVal tableRow As HtmlTableRow, ByVal strColName As String)

        Dim TimesheetCell As New HtmlTableCell("td")

        If strColName.ToUpper = "COST" Then
            tblReprow.Cells.Add(TimesheetCell)
            TimesheetCell.Attributes.Add("align", "right")
            TimesheetCell.InnerHtml = String.Format("{0:C}", Convert.ToDecimal((Level4row.Item("Hours") * Level4row.Item("Rate"))))
            TimesheetCell.Attributes.Add("class", "tdreport")
            TimesheetCell.ColSpan = 1
        Else
            tblReprow.Cells.Add(TimesheetCell)
            TimesheetCell.Attributes.Add("align", "left")
            TimesheetCell.InnerText = IIf(Level4row.Item(strColName) Is DBNull.Value, "&nbsp;", Level4row.Item(strColName))
            TimesheetCell.Attributes.Add("class", "tdreport")
            TimesheetCell.ColSpan = 1
        End If

        TimesheetCell = Nothing
    End Sub

    Private Function GetTableData(ByVal Table As Int16, ByVal Column As Int16)
        If Request.Form("ucReportFilters:grouping_list") = ",User,Task," Then
            Select Case Table
                Case 2 ' Users
                    Select Case Column
                        Case 1
                            Return Level2row.Item("KeyVal")
                        Case 2
                            Return Level2row.Item("ProjectID")
                        Case 3
                            Return Level2row.Item("Task")
                        Case 4
                            Return Level2row.Item("UserName")
                        Case 5
                            Return Level2row.Item("Rate")
                    End Select
                Case 3 ' Tasks
                    Select Case Column
                        Case 1
                            Return Level3row.Item("KeyVal")
                        Case 2
                            Return Level3row.Item("KeyVal2")
                        Case 3
                            Return Level3row.Item("Task")
                        Case 4
                            Return Level3row.Item("TaskName")
                        Case 5
                            Return Level3row.Item("Amount")
                        Case 6
                            Return Level3row.Item("Hours")
                        Case 7
                            Return Level3row.Item("Billable")
                    End Select
            End Select
        Else
            Select Case Table
                Case 2 ' Tasks
                    Select Case Column
                        Case 1
                            Return Level2row.Item("KeyVal")
                        Case 2
                            Return Level2row.Item("ProjectID")
                        Case 3
                            Return Level2row.Item("TaskID")
                        Case 4
                            Return Level2row.Item("TaskName")
                        Case 5
                            Return Level2row.Item("Amount")
                        Case 6
                            Return Level2row.Item("Hours")
                        Case 7
                            Return Level2row.Item("Billable")
                    End Select
                Case 3 ' Users
                    Select Case Column
                        Case 1
                            Return Level3row.Item("KeyVal")
                        Case 2
                            Return Level3row.Item("KeyVal2")
                        Case 3
                            Return Level3row.Item("Task")
                        Case 4
                            Return Level3row.Item("UserName")
                        Case 5
                            Return Level3row.Item("Rate")
                    End Select
            End Select
        End If
    End Function

    Private Sub AddTotalRow(ByVal decTotal As Decimal)

        Dim TotalCell As HtmlTableCell

        'Add Total Row
        '<TR>
        '   <TD colspan=1>"Total"
        '   <TD>Total
        '   <TD>
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 1)

        '"Total"
        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.ColSpan = 4
        TotalCell.InnerText = "Total"
        TotalCell.Attributes.Add("class", "tdreportTotal")

        'Timesheet Total
        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.InnerText = decTotal
        TotalCell.Attributes.Add("align", "right")
        TotalCell.InnerHtml = String.Format("{0:C}", decTotal)
        TotalCell.Attributes.Add("class", "tdreportTotal")

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 1)

    End Sub


#End Region

#Region "Load Chart"

    Private Sub LoadChart(ByVal dt As DataTable)

        Dim CummulativeTotal As Decimal = 0
        Dim i As Integer

        If dt.Rows.Count > 0 Then

            For i = 0 To dt.Rows.Count - 1


                With dt.Rows(i)

                    SampleLabels = SampleLabels & "," & (.Item("TimesheetDate").ToString.Replace(",", " ")).Replace("'", "")
                    ValueLabels = ValueLabels & "," & .Item("Cost").ToString

                    CummulativeTotal += .Item("Cost")
                    OverlayValues = OverlayValues & "," & CummulativeTotal.ToString

                End With
            Next

            SampleLabels = SampleLabels.Trim(",")
            ValueLabels = ValueLabels.Trim(",")
            OverlayValues = OverlayValues.Trim(",")
        Else
            SampleLabels = String.Empty
            ValueLabels = String.Empty
            OverlayValues = String.Empty
        End If

        'arrData.Insert(0, ValueLabels)

        'With chtGraph
        '    ' Applet Layout
        '    .ChartType = ChartTypes.Bar

        '    ' Values
        '    .sampleCount = dt.Rows.Count
        '    .sampleValues = arrData

        '    '' Range
        '    .rangeAxisLabel = RangeAxisLabel
        '    .rangeAxisLabelFont = "Arial, bold, 11"
        '    .rangeAxisLabelAngle = "270"

        '    '' Labels
        '    .chartTitle = ChartTitle
        '    '.seriesLabels = SeriesLabels
        '    .sampleLabels = SampleLabels
        '    .sampleLabelAngle = "90"
        '    .barLabelsOn = "True"
        '    .barLabelAngle = "270"
        '    .valueLabelsOn = "True"
        '    .valueLabelStyle = "floating"
        '    .legendOn = "False"
        '    '.legendPosition = "right"
        '    .sampleAxisLabel = SampleAxisLabel
        '    .sampleAxisLabelFont = "Arial, bold, 11"

        '    '' Style
        '    .visibleSamples = "0,30" ' 1 weeks data

        '    '' Colors
        '    .multiColorOn = False
        '    .background = "#DEE0BC"

        'End With

    End Sub


#End Region

#Region " SUBMIT DETAILS "
    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        LoadProjectDetails()
        Common.ExportExcel(ReportPlace, Me)
    End Sub
#End Region

End Class
