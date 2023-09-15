Public Class TimesheetStatus
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtStartDate As Intermap.Controls.IMTextBox
    Protected WithEvents txtEndDate As Intermap.Controls.IMTextBox
    Protected WithEvents imgRegenerate As System.Web.UI.WebControls.ImageButton
    Protected WithEvents dgReport As System.Web.UI.WebControls.DataGrid
    Protected WithEvents lstStatus As System.Web.UI.HtmlControls.HtmlSelect
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents btnGenerate As System.Web.UI.WebControls.Button
    Protected WithEvents imgPrint As System.Web.UI.WebControls.ImageButton
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
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
    Dim strStatus As String
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "59"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            ' Load the values from the Report Selection Page
            Dim monthstart As Date
            monthstart = Month(Today()) & "/01/" & Year(Today())
            ' Try loading Dates from Session Vars if they exist
            If Session("Rep_StartDate") <> "" Then
                txtStartDate.Text = Session("Rep_StartDate")
            Else
                txtStartDate.Text = monthstart.ToString("dd/MM/yyyy", en)
                Session("Rep_StartDate") = txtStartDate.Text
            End If
            If Session("Rep_EndDate") <> "" Then
                txtEndDate.Text = Session("Rep_EndDate")
            Else
                txtEndDate.Text = Today().ToString("dd/MM/yyyy")
                Session("Rep_EndDate") = txtEndDate.Text
            End If

        End If
        LoadReportData()
    End Sub

    Private Sub LoadReportData()

        divReport.Visible = False

        strStatus = IIf(Request.Form("lstStatus") = Nothing, "", Request.Form("lstStatus"))
        Dim strStart As String = IIf(Session("Rep_StartDate") = Nothing, txtStartDate.Text, Session("Rep_StartDate"))
        Dim strEnd As String = IIf(Session("Rep_EndDate") = Nothing, txtEndDate.Text, Session("Rep_EndDate"))

        Dim DS As DataSet
        DS = DAL.ReportTimesheetStatus(System.DateTime.ParseExact(strStart, "dd/MM/yyyy", en), System.DateTime.ParseExact(strEnd, "dd/MM/yyyy", en))

        Dim RowCount As Integer = 0
        Dim FirstUser As Boolean = True
        Dim WeekRow As DataRow
        Dim Period As String = ""
        Dim UserRow As DataRow
        Dim UserName As String = ""
        Dim StatusRow As DataRow
        Dim ResultsTable As DataTable = New DataTable("RESULTS")
        ResultsTable.Columns.Add("Period", GetType(System.String))
        ResultsTable.Columns.Add("User", GetType(System.String))
        ResultsTable.Columns.Add("Status", GetType(System.String))

        ' Load the data to the relevant fields
        For Each WeekRow In DS.Tables(0).Rows
            Period = WeekRow.Item("Period")
            FirstUser = True
            For Each UserRow In DS.Tables(1).Rows
                UserName = UserRow.Item("UserName")
                RowCount = 0
                For Each StatusRow In DS.Tables(2).Rows
                    If WeekRow.Item("wk") = StatusRow.Item("wk") And UserRow.Item("UserID") = StatusRow.Item("UserID") Then
                        If strStatus = "" Or strStatus.LastIndexOf(CStr(StatusRow.Item("StatusID"))) > 0 Or strStatus = CStr(StatusRow.Item("StatusID")) Then
                            ResultsTable = AddResultRow(IIf(FirstUser, WeekRow.Item("Period"), ""), UserRow.Item("UserName"), StatusRow.Item("Status"), ResultsTable)
                            FirstUser = False
                        End If
                        RowCount += 1
                    End If
                Next
                If RowCount = 0 Then
                    ' No Times for User
                    If strStatus = "" Or strStatus = "1" Or strStatus.LastIndexOf(",") > 0 Then
                        ' Add Not Submitted Status for User
                        ResultsTable = AddResultRow(IIf(FirstUser, WeekRow.Item("Period"), ""), UserRow.Item("UserName"), "Not Submitted", ResultsTable)
                        FirstUser = False
                    End If
                End If
            Next
        Next

        dgReport.DataSource = ResultsTable
        dgReport.DataBind()
        If dgReport.Items.Count() > 0 Then
            divReport.Style("DISPLAY") = "block"
            divReport.Visible = True
        End If

    End Sub

    Private Function AddResultRow(ByVal Period As String, ByVal UserName As String, ByVal Status As String, ByVal ResultsTable As DataTable) As DataTable
        Dim ResultsRow As DataRow
        ResultsRow = ResultsTable.NewRow()
        ResultsRow("Period") = Period
        ResultsRow("User") = UserName
        ResultsRow("Status") = Status
        ResultsTable.Rows.Add(ResultsRow)

        Return ResultsTable
    End Function

#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click
        Session("Rep_StartDate") = txtStartDate.Text
        Session("Rep_EndDate") = txtEndDate.Text

        LoadReportData()
    End Sub

    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        LoadReportData()
        Common.ExportExcel(divReport, Me)
    End Sub
#End Region

#Region "Format the grid"

    'SD: 26/09/2005 - Filter the grid with colour as per spec
    Private Sub dgReport_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgReport.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Select Case e.Item.Cells(2).Text.ToUpper
                Case "NOT SUBMITTED"
                    e.Item.Cells(2).BackColor = Color.LawnGreen
                Case "WAITING APPROVAL TEAM LEADER"
                    e.Item.Cells(2).BackColor = Color.LightBlue
                Case "REJECTED"
                    e.Item.Cells(2).BackColor = Color.Red
                Case "APPROVED"
                    e.Item.Cells(2).BackColor = Color.Yellow
                Case "WAITING APPROVAL MANAGER"
                    e.Item.Cells(2).BackColor = Color.LightPink
            End Select

        End If
    End Sub

#End Region
End Class
