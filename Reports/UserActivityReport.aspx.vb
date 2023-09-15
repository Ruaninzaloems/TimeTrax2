Public Class UserActivityReport
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlUser As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtStartDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvStartDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtEndDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvEndDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents btnGenerate As System.Web.UI.WebControls.Button
    Protected WithEvents CustomValidator1 As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents imgExport As System.Web.UI.WebControls.ImageButton
    Protected WithEvents Repeater1 As System.Web.UI.WebControls.Repeater
    Protected WithEvents tblButtons As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents divReport As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents pgHead As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents lblUserName As System.Web.UI.WebControls.Label
    Protected WithEvents rfvUser As System.Web.UI.WebControls.RequiredFieldValidator

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
    Dim lblProjectHeader As String
    Dim lblItemHeader As String

#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "66"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"

            LoadDropLists()
            divReport.Visible = False
            tblButtons.Visible = False
        Else
            LoadReportDetails()
            divReport.Visible = True
            tblButtons.Visible = True
        End If
        pgHead.Visible = False
    End Sub
    Private Sub LoadDropLists()
        Dim ds As DataSet
        Dim monthstart As Date
        Dim dsUsers As DataSet = Common.LoadUsers() 'DAL.LoadResourcesDS(True)



        '-- Modified 23/01/2007 VF 
        '-- If Logged In User does not have role 'Can View All Users Reports'
        '-- Then there will only be 1 name in the droplist
        If UserLogin.CheckUserAccess("68", System.Web.HttpContext.Current, False) Then
            dsUsers.Tables(0).Rows(0).Delete()
            Dim drRow As DataRow = dsUsers.Tables(0).NewRow
            drRow.Item(0) = -1
            drRow.Item(1) = "All Users"
            dsUsers.Tables(0).Rows.InsertAt(drRow, 0)
            ddlUser.DataSource = dsUsers
            ddlUser.DataBind()
            '-- User can view other users data
            ddlUser.Items.Insert(0, New ListItem("-- Please Select --", "0"))
        Else

            ddlUser.DataSource = dsUsers
            ddlUser.DataBind()

        End If


        '-- Load Dates
        monthstart = Month(Today()) & "/01/" & Year(Today())

        '-- Populate dates if they do not already have values
        If txtStartDate.Text = "" Then
            txtStartDate.Text = monthstart.ToString("dd/MM/yyyy", en)
        End If
        If txtEndDate.Text = "" Then
            txtEndDate.Text = Today().ToString("dd/MM/yyyy")
        End If


    End Sub

    Private Sub LoadReportDetails()
        Dim dr1 As DataRelation
        Dim dr2 As DataRelation

        DS = New DataSet

        DS = DAL.ReportUserActivityRegister(ddlUser.SelectedItem.Value, _
                                        System.DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", en), _
                                        System.DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", en))

        DS.Tables(0).TableName = "Level1" '"Project"
        DS.Tables(1).TableName = "Level2" '"Task"
        DS.Tables(2).TableName = "Level3" '"Timesheet"
        ' Set up relationships
        dr1 = New DataRelation("Level1_Level2", DS.Tables("Level1").Columns("ProjectID"), DS.Tables("Level2").Columns("ProjectID"))
        dr1.Nested = True
        DS.Relations.Add(dr1)
        dr2 = New DataRelation("Level2_Level3", DS.Tables("Level2").Columns("KeyVal"), DS.Tables("Level3").Columns("KeyVal"))
        dr2.Nested = True
        DS.Relations.Add(dr2)

        Repeater1.DataSource = DS.Tables(0).Rows
        Repeater1.DataBind()

        lblUserName.Text = ddlUser.SelectedItem.Text

    End Sub

    Private Sub Repeater1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        ' This is the First Header row (Project)
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            ' Load TaskName or UserName (4th Column)
            lblProjectHeader = CType(e.Item.DataItem, DataRow)(2) & " (" & CType(e.Item.DataItem, DataRow)(1) & ")"
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

            lblItemHeader = CType(e.Item.DataItem, DataRow)(4)
            DirectCast(e.Item.FindControl("lblHead2"), Label).Text = CType(e.Item.DataItem, DataRow)(4)
            DirectCast(e.Item.FindControl("Repeater3"), Repeater).DataSource = CType(e.Item.DataItem, DataRow).GetChildRows("Level2_Level3")
            DirectCast(e.Item.FindControl("Repeater3"), Repeater).DataBind()
        End If
    End Sub

    Sub Repeater3_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        ' This is the Details row
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            DirectCast(e.Item.FindControl("lblProject"), Label).Text = lblProjectHeader
            DirectCast(e.Item.FindControl("lblItem"), Label).Text = lblItemHeader
            DirectCast(e.Item.FindControl("lblHrs"), Label).Text = CType(e.Item.DataItem, DataRow)(3)
            DirectCast(e.Item.FindControl("lblDate"), Label).Text = CType(e.Item.DataItem, DataRow)(2)
            DirectCast(e.Item.FindControl("lblHrs"), Label).Text = CType(e.Item.DataItem, DataRow)(3)
            DirectCast(e.Item.FindControl("lblComments"), Label).Text = CType(e.Item.DataItem, DataRow)(4)
            DirectCast(e.Item.FindControl("lblUser"), Label).Text = CType(e.Item.DataItem, DataRow)(5)
            DirectCast(e.Item.FindControl("lblEmployeeCode"), Label).Text = CType(e.Item.DataItem, DataRow)(6)
            DirectCast(e.Item.FindControl("lblClientName"), Label).Text = CType(e.Item.DataItem, DataRow)(7)
            DirectCast(e.Item.FindControl("lblBillable"), Label).Text = CType(e.Item.DataItem, DataRow)(8)



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

#Region " SUBMIT DETAILS "
    Private Sub imgExport_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgExport.Click
        LoadReportDetails()
        pgHead.Visible = True
        Common.ExportExcel(divReport, Me)
    End Sub

#End Region
End Class
