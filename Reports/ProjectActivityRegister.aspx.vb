Public Class ProjectActivityRegister
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Repeater1 As System.Web.UI.WebControls.Repeater
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents lblCompany As System.Web.UI.WebControls.Label
    Protected WithEvents lblProjName As System.Web.UI.WebControls.Label
    Protected WithEvents pgHead As System.Web.UI.HtmlControls.HtmlTableRow
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
        Dim Role As String = "50"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
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

        DS = New DataSet

        DS = DAL.ReportActivityRegister(Request.Form("ucReportFilters:ddlProject"), _
                                        System.DateTime.ParseExact(Request.Form("ucReportFilters:txtStartDate"), "dd/MM/yyyy", en), _
                                        System.DateTime.ParseExact(Request.Form("ucReportFilters:txtEndDate"), "dd/MM/yyyy", en), _
                                        Request.Form("ucReportFilters:ddlTask"), _
                                         Common.CalcUserString(Request.Form("ucReportFilters:lstUsers")), _
                                        Request.Form("ucReportFilters:grouping_list"), _
                                        Request.Form("ucReportFilters:ddlCaptureType"))

        Select Case Request.Form("grouping_list")
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
                'DS.WriteXml("D:\TaskReg.xml") 'SD: 25/09/2005 - Don't know why this is here!  It doesn't seem to be needed and causes errors if left in
            Case Else
                ' Name the tables
                DS.Tables(0).TableName = "Level1" '"Project"
                DS.Tables(1).TableName = "Level2" '"Task"
                DS.Tables(2).TableName = "Level3" '"User"
                DS.Tables(3).TableName = "Level4" '"Timesheet"
                ' Set up relationships
                'DS.Relations.Add("Proj_Task", DS.Tables("Project").Columns("Project"), DS.Tables("Task").Columns("Project"))
                'DS.Relations.Add("Task_User", DS.Tables("Task").Columns("Task"), DS.Tables("User").Columns("Task"))
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

        Repeater1.DataSource = DS.Tables(1).Rows
        Repeater1.DataBind()


    End Sub

    Private Sub Repeater1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        ' This is the First Header row
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            ' Load TaskName or UserName (4th Column)
            DirectCast(e.Item.FindControl("lblHead1"), Label).Text = CType(e.Item.DataItem, DataRow)(3)
            DirectCast(e.Item.FindControl("Repeater2"), Repeater).DataSource = CType(e.Item.DataItem, DataRow).GetChildRows("Level2_Level3")
            DirectCast(e.Item.FindControl("Repeater2"), Repeater).DataBind()
        End If
        If e.Item.ItemType = ListItemType.Footer Then
            DirectCast(e.Item.FindControl("lblGrandTotal"), Label).Text = GrandTotal
            GrandTotal = 0
        End If
    End Sub

    Sub Repeater2_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        ' This is the Second Header row
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            ' Load UserName or TaskName (4th Column from Table 2)
            DirectCast(e.Item.FindControl("lblHead2"), Label).Text = CType(e.Item.DataItem, DataRow)(3)
            DirectCast(e.Item.FindControl("Repeater3"), Repeater).DataSource = CType(e.Item.DataItem, DataRow).GetChildRows("Level3_Level4")
            DirectCast(e.Item.FindControl("Repeater3"), Repeater).DataBind()
        End If
    End Sub

    Sub Repeater3_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        ' This is the Details row
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            DirectCast(e.Item.FindControl("lblDate"), Label).Text = CType(e.Item.DataItem, DataRow)(5)
            DirectCast(e.Item.FindControl("lblHrs"), Label).Text = CType(e.Item.DataItem, DataRow)(6)
            DirectCast(e.Item.FindControl("lblComments"), Label).Text = CType(e.Item.DataItem, DataRow)(7)
            ' Accumulate Total
            Total += CType(e.Item.DataItem, DataRow)(6)
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

#Region " SUBMIT DETAILS "

    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        LoadProjectDetails()
        pgHead.Visible = True
        lblCompany.Text = "Intermap (Pty) Ltd"
        lblProjName.Text = Request.Form("ucReportFilters:ddlProject")  'TODO - Must be text
        'tblPage.Border = 1
        Common.ExportExcel(divReport, Me)
    End Sub
#End Region

End Class
