Public Class TimeAnalysis
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents IMBarChart As Intermap.Controls.IMChart
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents txtStartDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtEndDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents imgRegenerate As System.Web.UI.WebControls.ImageButton
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents StartDate As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents EndDate As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents rdoOutput As System.Web.UI.WebControls.RadioButtonList
    Protected WithEvents lstTOTypes As System.Web.UI.WebControls.ListBox
    Protected WithEvents lstUsers As System.Web.UI.WebControls.ListBox
    Protected WithEvents lstTaskType As System.Web.UI.HtmlControls.HtmlSelect
    Protected WithEvents IMLineChart As Intermap.Controls.IMChart
    Protected WithEvents btnGenerate As System.Web.UI.WebControls.Button
    Protected WithEvents ddlCaptureType As System.Web.UI.WebControls.DropDownList
    Protected WithEvents lstCaptureType As System.Web.UI.HtmlControls.HtmlSelect
    Protected WithEvents IMTextBox1 As Intermap.Controls.IMTextBox
    Protected WithEvents IMTextBox2 As Intermap.Controls.IMTextBox

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
        Dim Role As String = "57"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            ' Load the values from the Report Selection Page
            LoadFilters()
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

        Else
            'Store the session variables
            Session("Rep_StartDate") = txtStartDate.Text
            Session("Rep_EndDate") = txtEndDate.Text

        End If
        LoadReportData()
    End Sub
    Private Sub LoadFilters()
        lstTOTypes.DataSource = DAL.GetTimeOffTypes(0)
        lstTOTypes.DataBind()

        Common.LoadUsersList(lstUsers)
        'SD: 25/01/2007 - If Logged In User does not have role 'Can View All Users Reports'
        'Then change listbox selection Method
        If Not (UserLogin.CheckUserAccess("68", System.Web.HttpContext.Current, False)) Then
            '-- User cannot view other users data
            lstUsers.SelectionMode = ListSelectionMode.Single
        End If

    End Sub

    Private Sub LoadReportData()

        divReport.Visible = False

        '    'TODO: These will eventually be set by calling page or UserProfile
        Session("OutputBase") = rdoOutput.SelectedValue '"Daily/Weekly"
        Dim strTasks As String = IIf(Request.Form("lstTaskType") = Nothing, "", Request.Form("lstTaskType"))
        Dim strTOTypes As String = IIf(Request.Form("lstTOTypes") = Nothing, "", Request.Form("lstTOTypes"))
        Dim strUsers As String = IIf(Request.Form("lstUsers") = Nothing, "", Request.Form("lstUsers"))
        Dim strStart As String = IIf(Session("Rep_StartDate") = Nothing, txtStartDate.Text, Session("Rep_StartDate"))
        Dim strEnd As String = IIf(Session("Rep_EndDate") = Nothing, txtEndDate.Text, Session("Rep_EndDate"))
        Dim strCaptureTypes As String

        'Set the Capture types - empty string means return all
        If Request.Form("lstCaptureType") = Nothing Then
            'Nothing set so by default return all
            strCaptureTypes = String.Empty
        Else
            If Request.Form("lstCaptureType").Split(",").Length > 1 Then
                'Means that more than one item selected (ie. all selected) so return all
                strCaptureTypes = String.Empty
            Else
                'Return just the specified capture type
                strCaptureTypes = Request.Form("lstCaptureType")
            End If
        End If

        Dim DR As SqlDataReader

        ' Set Chart Data

        If Session("OutputBase") = "Weekly" Then
            DR = DAL.ReportTimeAnalysis(System.DateTime.ParseExact(strStart, "dd/MM/yyyy", en), System.DateTime.ParseExact(strEnd, "dd/MM/yyyy", en), strUsers, strTOTypes, strTasks, "Week", strCaptureTypes)
        Else
            ' Output as Daily
            DR = DAL.ReportTimeAnalysis(System.DateTime.ParseExact(strStart, "dd/MM/yyyy", en), System.DateTime.ParseExact(strEnd, "dd/MM/yyyy", en), strUsers, strTOTypes, strTasks, "Day", strCaptureTypes)
        End If

        LoadChart(DR)

    End Sub

    Private Sub LoadChart(ByVal DR As SqlDataReader)
        ' Load the data to the relevant fields

        ' Set Chart Labels
        Dim ChartTitle As String = "" '"Scenario " & Session("ScenarioA_Name") & ":\n" & Session("ScenarioA_LevelName") & " Year on Year Change"
        Dim RangeAxisLabel As String = ""
        Dim SampleAxisLabel As String = ""
        Dim SampleLabels As String = ""
        Dim SeriesLabels As String = ""

        Dim tmpDate As String = ""
        Dim tmpUser As String = ""

        Dim UserCount As Int16 = 0
        Dim arrUsers As New Collections.Specialized.StringCollection
        Dim arrData As New Collections.Specialized.StringCollection

        'Get the Users into the SeriesLabel, Collection and the user count
        While DR.Read
            If SeriesLabels = "" Then
                SeriesLabels = (DR.Item("UserName").ToString.Replace(",", " ")).Replace("'", "")
            Else
                SeriesLabels = SeriesLabels & "," & (DR.Item("UserName").ToString.Replace(",", " ")).Replace("'", "")
            End If
            arrUsers.Insert(UserCount, (DR.Item("UserName").ToString.Replace(",", " ")).Replace("'", ""))
            'Add 1 to the user count
            UserCount += 1
        End While

        Dim a As Int16
        Dim b As Int16 = 0

        DR.NextResult()
        While DR.Read
            'Check if the date changes,
            ' if it has changed then add to the SampleLabel,
            ' Reset the counter used to loop through the users and their series
            If tmpDate <> DR.Item("dd") Then
                ' Before resetting counter make sure all users in user array have been processed
                If a < arrUsers.Count And tmpDate <> "" Then
                    FindAndProcessUser((DR.Item("UserName").ToString.Replace(",", " ")).Replace("'", ""), (DR.Item("Duration").ToString.Replace(",", " ")).Replace("'", ""), a, arrUsers, arrData)
                End If
                a = 0
                SampleLabels = SampleLabels & "," & (DR.Item("dd").ToString.Replace(",", " ")).Replace("'", "")
                tmpDate = DR.Item("dd")
            End If

            FindAndProcessUser((DR.Item("UserName").ToString.Replace(",", " ")).Replace("'", ""), (DR.Item("Duration").ToString.Replace(",", " ")).Replace("'", ""), a, arrUsers, arrData)

            b += 1

        End While

        DR.Close()


        SampleLabels = SampleLabels.Trim(",")
        'arrData = arrSample
        'arrData.Add(Sample_0)
        'arrData.Add(Sample_1)

        With IMLineChart
            ' Applet Layout
            .ChartType = ChartTypes.Line

            ' Values
            .seriesCount = UserCount
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
            .sampleLabelAngle = "90"
            .valueLabelsOn = False
            .legendOn = "true"
            .legendPosition = "right"
            .sampleAxisLabel = SampleAxisLabel
            .sampleAxisLabelFont = "Arial, bold, 11"

            Dim arrTargets As New Collections.Specialized.StringCollection
            If Session("OutputBase") = "Weekly" Then
                '' Style
                .visibleSamples = "0,4" ' 1 months data
                '' Targets
                arrTargets.Add("Required, 40, red")
            Else
                '' Style
                .visibleSamples = "0,28" ' 4 weeks data
                '' Targets
                arrTargets.Add("Required, 8, red")
            End If
            .targetValueLine = arrTargets

            '' Colors
            .multiColorOn = True
            .background = "#DEE0BC"

        End With

        If UserCount > 0 Then
            divReport.Style("DISPLAY") = "block"
            divReport.Visible = True
        End If

    End Sub

    Private Function FindAndProcessUser(ByVal UserName As String, ByVal Duration As String, ByRef idx As Int16, ByVal Users As Collections.Specialized.StringCollection, ByRef SampleData As Collections.Specialized.StringCollection) As Collections.Specialized.StringCollection
        Dim str As String
        While (idx < Users.Count)
            If UserName = Users.Item(idx) Then
                ' Found user
                Exit While
            Else
                ' User does not have duration data
                ' If no sampledata exists yet for the user then add it
                ' else Insert it to correct user series
                If Fix(SampleData.Count / Users.Count) = 0 Then
                    ' Insert data
                    SampleData.Insert(idx, "0,")
                Else
                    ' Append data
                    str = SampleData.Item(idx) & "0,"
                    SampleData(idx) = str
                End If
            End If
            idx += 1
        End While

        If (idx < Users.Count) Then
            ' Found user
            ' Add the duration to the collection that belongs to the user
            If Fix(SampleData.Count / Users.Count) = 0 Then
                ' Insert data
                SampleData.Insert(idx, Duration & ",")
            Else
                ' Append data
                str = SampleData.Item(idx) & Duration & ","
                SampleData(idx) = str
            End If
            idx += 1
        End If
        Return SampleData

    End Function

#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click
        'LoadReportData()  - Don't need this as taken care of in page load
    End Sub

#End Region

End Class
