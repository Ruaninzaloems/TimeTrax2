Public Class UserActivityReportPopUp
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents lblUserName As System.Web.UI.WebControls.Label
    Protected WithEvents Repeater1 As System.Web.UI.WebControls.Repeater
    Protected WithEvents tblButtons As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents pgHead As System.Web.UI.HtmlControls.HtmlTableRow

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
        Dim Role As String = "66"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        'If Not IsPostBack Then
        '    Session("PageType") = "Reports"
        '    Session("Page") = ""
        '    Session("PageTitle") = Session("AppName") & " - Reports"

        '    LoadDropLists()
        '    divReport.Visible = False
        '    tblButtons.Visible = False
        'Else
            LoadReportDetails()
        '    divReport.Visible = True
        '    tblButtons.Visible = True
        'End If
        'pgHead.Visible = False
    End Sub

    Private Sub LoadReportDetails()
        Dim dr1 As DataRelation
        Dim dr2 As DataRelation

        DS = New DataSet

        Dim UserId As Integer = Request.QueryString("U")
        Dim strDate As String = Request.QueryString("Date")
        Dim strUser As String

        DS = DAL.ReportUserActivityRegister(UserId, _
                                        System.DateTime.ParseExact(strDate, "dd/MM/yyyy", en), _
                                        System.DateTime.ParseExact(strDate, "dd/MM/yyyy", en))

        DS.Tables(0).TableName = "Level1" '"Project"
        DS.Tables(1).TableName = "Level2" '"Task"
        DS.Tables(2).TableName = "Level3" '"Timesheet"
        DS.Tables(3).TableName = "Username" 'UserName
        ' Set up relationships
        dr1 = New DataRelation("Level1_Level2", DS.Tables("Level1").Columns("ProjectID"), DS.Tables("Level2").Columns("ProjectID"))
        dr1.Nested = True
        DS.Relations.Add(dr1)
        dr2 = New DataRelation("Level2_Level3", DS.Tables("Level2").Columns("KeyVal"), DS.Tables("Level3").Columns("KeyVal"))
        dr2.Nested = True
        DS.Relations.Add(dr2)

        Repeater1.DataSource = DS.Tables(0).Rows
        Repeater1.DataBind()

        strUser = DS.Tables("Username").Rows(0)("Username")
        lblUserName.Text = strUser


    End Sub

    Private Sub Repeater1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        ' This is the First Header row (Project)
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            ' Load TaskName or UserName (4th Column)

            DirectCast(e.Item.FindControl("lblHead1"), Label).Text = CType(e.Item.DataItem, DataRow)(2) & " (" & CType(e.Item.DataItem, DataRow)(1) & ")"
            DirectCast(e.Item.FindControl("Repeater2"), Repeater).DataSource = CType(e.Item.DataItem, DataRow).GetChildRows("Level1_Level2")
            DirectCast(e.Item.FindControl("Repeater2"), Repeater).DataBind()
        End If
        If e.Item.ItemType = ListItemType.Footer Then
            DirectCast(e.Item.FindControl("lblGrandTotal"), Label).Text = GrandTotal
            GrandTotal = 0
        End If
    End Sub

    Sub Repeater2_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        ' This is the Second Header row (Task)
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            DirectCast(e.Item.FindControl("lblHead2"), Label).Text = CType(e.Item.DataItem, DataRow)(4)
            DirectCast(e.Item.FindControl("Repeater3"), Repeater).DataSource = CType(e.Item.DataItem, DataRow).GetChildRows("Level2_Level3")
            DirectCast(e.Item.FindControl("Repeater3"), Repeater).DataBind()
        End If
    End Sub

    Sub Repeater3_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        ' This is the Details row
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            DirectCast(e.Item.FindControl("lblDate"), Label).Text = CType(e.Item.DataItem, DataRow)(2)
            DirectCast(e.Item.FindControl("lblHrs"), Label).Text = CType(e.Item.DataItem, DataRow)(3)
            DirectCast(e.Item.FindControl("lblComments"), Label).Text = CType(e.Item.DataItem, DataRow)(4)
            ' Accumulate Total
            Total += CType(e.Item.DataItem, DataRow)(3)
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


End Class
