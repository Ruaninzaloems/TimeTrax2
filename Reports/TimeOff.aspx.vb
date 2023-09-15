Public Class TimeOff
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents imgRegenerate As System.Web.UI.WebControls.ImageButton
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents ReportPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents Imagebutton1 As System.Web.UI.WebControls.ImageButton
    Protected WithEvents lstUsers As System.Web.UI.WebControls.ListBox
    Protected WithEvents txtStartDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvStartDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtEndDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvEndDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents btnGenerate As System.Web.UI.WebControls.Button
    Protected WithEvents hidProjRequired As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents IMTextBox2 As Intermap.Controls.IMTextBox
    Protected WithEvents IMTextBox1 As Intermap.Controls.IMTextBox

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
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "58"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            divReport.Visible = False

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

            ' Load Users
            Common.LoadUsersList(lstUsers)
        Else
            divReport.Visible = True
            LoadReportData()
        End If

    End Sub
    Private Sub LoadReportData()
        Dim dr1 As DataRelation
        Dim dr2 As DataRelation
        Dim DS As DataSet = New DataSet

        DS = DAL.ReportTimeOff(System.DateTime.ParseExact(Request.Form("txtStartDate"), "dd/MM/yyyy", en), _
                               System.DateTime.ParseExact(Request.Form("txtEndDate"), "dd/MM/yyyy", en), _
                               Common.CalcUserString(Request.Form("lstUsers")))

        ' Name the tables
        DS.Tables(0).TableName = "Level1" '"TimeOffType"
        DS.Tables(1).TableName = "Level2" '"User Details"
        DS.Tables(2).TableName = "Level3" '"TimeOff Details"
        ' Set up relationships
        dr1 = New DataRelation("Level1_Level2", DS.Tables("Level1").Columns("TypeID"), DS.Tables("Level2").Columns("TypeID"))
        dr1.Nested = True
        DS.Relations.Add(dr1)
        dr2 = New DataRelation("Level2_Level3", DS.Tables("Level2").Columns("KeyVal"), DS.Tables("Level3").Columns("KeyVal"))
        dr2.Nested = True
        DS.Relations.Add(dr2)

        BuildHtmlTable(DS)

    End Sub

    Private Sub BuildHtmlTable(ByVal DS As DataSet)

        Dim decUserTotal As Decimal
        Dim tblRep As HtmlTable
        Dim tblReprow As HtmlTableRow
        Dim tblRepcell As HtmlTableCell
        Dim Level1row As DataRow
        Dim DataLevel As DataRow
        Dim UserLevel As DataRow

        ReportPlace.Controls.Clear()

        tblRep = New HtmlTable
        tblRep.Attributes.Add("class", "tableReport%")
        tblRep.Attributes.Add("width", "100%")
        tblRep.Border = 1
        ReportPlace.Controls.Add(tblRep)

        ' Build Header Row Table
        BuildHeaderRow(tblRep)

        For Each Level1row In DS.Tables("Level1").Rows

            '	<TR>
            ' 	<TH class="th4"  colspan=5>
            tblReprow = New HtmlTableRow
            tblRep.Rows.Add(tblReprow)
            tblRepcell = New HtmlTableCell("th")
            tblReprow.Cells.Add(tblRepcell)
            tblRepcell.Attributes.Add("class", "th4")
            tblRepcell.ColSpan = 5

            AddLevel2(tblRep, tblReprow, Level1row)

            For Each UserLevel In Level1row.GetChildRows("Level1_Level2")

                AddUserRow(tblRep, tblReprow, UserLevel)
                decUserTotal = 0

                For Each DataLevel In UserLevel.GetChildRows("Level2_Level3")
                    AddTimeOffData(tblRep, tblReprow, DataLevel)
                    decUserTotal = decUserTotal + DataLevel.Item("Hours")
                Next

                AddTotalRow(tblRep, tblReprow, decUserTotal)

            Next

            'AddTotals(2, Level2TotHrs, Table2)
            ' Accumulate Totals
            'Level2TotHrs += Convert.ToDecimal(DataLvl.Item("Hours"))
        Next

    End Sub

#Region "Add Rows"
    Private Sub BuildHeaderRow(ByVal RepTable As HtmlTable)

        Dim FirstLevelRow As HtmlTableRow
        Dim FirstLevelCell As HtmlTableCell
        '         <TR>
        '           <TH>Type</TH>
        '           <TH>Name</TH>
        '           <TH>Date</TH>
        '           <TH>Hours</TH>
        '           <TH>Comment</TH>
        '         </TR>

        FirstLevelRow = New HtmlTableRow
        RepTable.Controls.Add(FirstLevelRow)
        ' Add header cells here

        Common.AddHeaderCell(FirstLevelRow, "Type", "20%")
        Common.AddHeaderCell(FirstLevelRow, "Name", "20%")
        Common.AddHeaderCell(FirstLevelRow, "Date", "20%")
        Common.AddHeaderCell(FirstLevelRow, "Hours", "10%")
        Common.AddHeaderCell(FirstLevelRow, "Comment", "30%")

    End Sub

    Private Sub AddTimeOffData(ByVal tblRep As HtmlTable, ByVal tblReprow As HtmlTableRow, ByVal dr As DataRow)

        'Add Time Off Row
        '<TR>
        '   <TD colspan=2>
        '   <TD>Date
        '   <TD>Hours
        '   <TD>Comment
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 2)

        'Date
        AddTimeOffCell(tblReprow, "txtDate", dr)

        'Hours
        AddTimeOffCell(tblReprow, "Hours", dr)

        'Comment
        AddTimeOffCell(tblReprow, "Comment", dr)


    End Sub

    Private Sub AddTotalRow(ByVal tblRep As HtmlTable, ByVal tblReprow As HtmlTableRow, ByVal decTotal As Decimal)

        Dim TotalCell As HtmlTableCell

        'Add Total Row
        '<TR>
        '   <TD>
        '   <TD colspan=2>Total
        '   <TD>The total
        '   <TD>
        tblReprow = New HtmlTableRow
        tblRep.Rows.Add(tblReprow)

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 1)

        '"Total"
        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.ColSpan = 2
        TotalCell.InnerText = "Total"
        TotalCell.Attributes.Add("class", "tdreportTotal")

        'TimeOff Total
        TotalCell = New HtmlTableCell("td")
        tblReprow.Cells.Add(TotalCell)
        TotalCell.InnerText = decTotal
        TotalCell.Attributes.Add("align", "right")
        TotalCell.InnerHtml = Decimal.Round(decTotal, 2)
        TotalCell.Attributes.Add("class", "tdreportTotal")

        'Spacer Cells
        Common.AddSpacerCell(tblReprow, 1)

    End Sub

#End Region

    Private Function AddLevel2(ByVal tblRep As HtmlTable, ByVal tblRepRow As HtmlTableRow, ByVal dr As DataRow)
        Dim Level2Cell As HtmlTableCell

        '<TR>
        '   <TD colspan=5>Type Name
        tblRepRow = New HtmlTableRow
        tblRep.Rows.Add(tblRepRow)

        'Type Name
        Level2Cell = New HtmlTableCell("td")
        tblRepRow.Cells.Add(Level2Cell)
        Level2Cell.ColSpan = 5
        Level2Cell.InnerText = dr.Item("TypeName")
        Level2Cell.Attributes.Add("class", "tdreportTotal")

    End Function

    Private Function AddUserRow(ByVal tblRep As HtmlTable, ByVal tblRepRow As HtmlTableRow, ByVal dr As DataRow)
        Dim Level2Cell As HtmlTableCell

        '<TR>
        '   <TD width=5%>
        '   <TD colspan=4>User Name
        tblRepRow = New HtmlTableRow
        tblRep.Rows.Add(tblRepRow)

        Common.AddSpacerCell(tblRepRow, 1)

        'Usser Name
        Level2Cell = New HtmlTableCell("td")
        tblRepRow.Cells.Add(Level2Cell)
        Level2Cell.ColSpan = 4
        Level2Cell.InnerText = dr.Item("UserName")
        Level2Cell.Attributes.Add("class", "td")

    End Function


    Private Sub AddTotals(ByVal level As Int16, ByVal Level2TotHrs As Decimal, ByVal Table2 As HtmlTable)
        If Session("Rep_Totals") = "on" Then
            Dim TotTable As HtmlTable
            Dim TotHrs As Decimal = 0
            Dim strClass As String = "td" & level
            Dim SecondLevelCell As HtmlTableCell
            Dim DataLevelCell As HtmlTableCell
            Select Case level
                Case 2
                    TotHrs = Level2TotHrs
                    ' Create Row and td to Add TotalTable to
                    ' <TR>
                    Dim SecondLevelRow As HtmlTableRow = New HtmlTableRow
                    Table2.Controls.Add(SecondLevelRow)
                    '   <td>
                    SecondLevelCell = New HtmlTableCell("td")
                    SecondLevelRow.Cells.Add(SecondLevelCell)
                    ' Create totaltable and row
                    TotTable = New HtmlTable
                    SecondLevelCell.Controls.Add(TotTable)
                    'TotTable.ID = "TotTable"
            End Select

            TotTable.Width = "100%"
            '       <TR>
            Dim DataLevelRow As HtmlTableRow = New HtmlTableRow
            TotTable.Controls.Add(DataLevelRow)
            '         <TD width=10% class=td>Total</TD>
            DataLevelCell = New HtmlTableCell("td")
            DataLevelRow.Controls.Add(DataLevelCell)
            DataLevelCell.Attributes.Add("Width", "10%")
            DataLevelCell.Attributes.Add("class", strClass)
            DataLevelCell.InnerHtml = "<b>Total</b>"
            '         <TD width=55% class=td>Cost</TD>
            DataLevelCell = New HtmlTableCell("td")
            DataLevelRow.Controls.Add(DataLevelCell)
            DataLevelCell.Attributes.Add("Width", "55%")
            DataLevelCell.ColSpan = 4
            DataLevelCell.Attributes.Add("class", strClass)
            DataLevelCell.Attributes.Add("align", "right")
            DataLevelCell.InnerHtml = "<b>" & TotHrs & "</b>"
            '         <TD class=label>Comments</TD>
            'DataLevelCell = New HtmlTableCell("td")
            'DataLevelRow.Controls.Add(DataLevelCell)
            'DataLevelCell.Attributes.Add("class", "td")
            'DataLevelCell.InnerHtml = "&nbsp;"
        End If
    End Sub

#End Region

#Region "Add Cells"

    Private Sub AddTimeOffCell(ByVal tableRow As HtmlTableRow, ByVal strColName As String, ByVal dr As DataRow)

        Dim TimeOffCell As New HtmlTableCell("td")

        If strColName.ToUpper = "HOURS" Then
            tableRow.Cells.Add(TimeOffCell)
            TimeOffCell.Attributes.Add("align", "right")
            TimeOffCell.InnerHtml = Decimal.Round(Convert.ToDecimal(dr.Item(strColName)), 2)
            TimeOffCell.Attributes.Add("class", "tdreport")
            TimeOffCell.ColSpan = 1
        Else
            tableRow.Cells.Add(TimeOffCell)
            TimeOffCell.Attributes.Add("align", "left")
            TimeOffCell.InnerText = IIf(dr.Item(strColName) Is DBNull.Value, "&nbsp;", dr.Item(strColName))
            TimeOffCell.Attributes.Add("class", "tdreport")
            TimeOffCell.ColSpan = 1
        End If
    End Sub

#End Region

#Region " SUBMIT DETAILS "

    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        LoadReportData()
        Common.ExportExcel(ReportPlace, Me)
    End Sub
#End Region

    Private Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click
        'set the session variables
        Session("Rep_Users") = Request.Form("ucReportFilters:lstUsers")
        Session("Rep_StartDate") = Request.Form("ucReportFilters:txtStartDate")
        Session("Rep_EndDate") = Request.Form("ucReportFilters:txtEndDate")
    End Sub
End Class
