Public Class ProjectVO
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents lblClient As System.Web.UI.WebControls.Label
    Protected WithEvents lblContact As System.Web.UI.WebControls.Label
    Protected WithEvents lblName As System.Web.UI.WebControls.Label
    Protected WithEvents lblStart As System.Web.UI.WebControls.Label
    Protected WithEvents lblCostCentre As System.Web.UI.WebControls.Label
    Protected WithEvents lblAdmin As System.Web.UI.WebControls.Label
    Protected WithEvents lblCurrency As System.Web.UI.WebControls.Label
    Protected WithEvents orderPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtOrderNo As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvOrderNo As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtEndDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvEndDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtProjBudget As System.Web.UI.WebControls.TextBox
    Protected WithEvents ddlOrderItem_ As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtOrderAmount_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents taskPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtTotBudget As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtTotHrs As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtTask_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtTaskAmount_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtHours_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents chkBillable_ As System.Web.UI.WebControls.CheckBox
    Protected WithEvents orderLoadCount As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents task_orderitem As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents EndDate As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents imgDeleteorder_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents taskLoadCount As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents task_maxbudget As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents imgDeletetask_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents cvEndDate As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents hidProjID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents btnUpload As System.Web.UI.HtmlControls.HtmlInputButton

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

    ' Required for Errorhandling
    Protected WithEvents ucHeader As TimeTrax.header
    Dim strStatus As String
    Dim strErr As String
    Dim strMess As String

#End Region

#Region " PAGE DECLARES "
    Dim ucProjInfo As New TimeTrax.ucProjectInfo
    Dim ucOrders As New TimeTrax.Orders
    Dim ItemNo, ItemID As String
    Dim a, NoRows As Integer
    Dim arrData As Array
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "23"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "TakeOn"
            Session("Page") = "VO"
            Session("PageTitle") = Session("AppName") & " - Project Variation Order"
            ' If No ProjectID is sent then redirect to Select Project Page
            If Request.QueryString("ProjID") Is Nothing Then
                ' Set the Page that SelectProject will return to
                Session("ReturnUrl") = Me.Request.Path
                Response.Redirect("SelectProject.aspx")
            End If
            ViewState("ProjectID") = Request.QueryString("ProjID")
            hidProjID.Value = Request.QueryString("ProjID")
            'Needed for Project Info Usercontrol
            ucProjInfo.ProjectID = ViewState("ProjectID")
            ucProjInfo.blnShowSummaries = True
            LoadSystemData()
            'Needed for Orders Usercontrol
            ucOrders.OrderID = 0
            ucOrders.blnReadOnly = False
            ucOrders.TaskOrderItem = ViewState("TaskOrderItem")
        End If
    End Sub

    Private Sub LoadSystemData()
        ViewState("TaskOrderItem") = 1
        DR = DAL.LoadSystemData() 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectSystem")
        If DR.Read() Then
            ' Number of approval cycles for Project Take on
            If IsDBNull(DR.Item("PTOApprovals")) Then
                ViewState("PTOApprovals") = 1
            Else
                ViewState("PTOApprovals") = DR.Item("PTOApprovals")
            End If
            ' Project Budget Item (Order Item) to which Tasks total budget may not exceed
            If Not IsDBNull(DR.Item("TaskOrderItem")) Then
                ViewState("TaskOrderItem") = DR.Item("TaskOrderItem")
            End If
        End If
        DR.Close()
    End Sub
#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ' Insert Order Details
        ' Insert Budget (Order & ProjectOrderItems)
        ViewState("OrderID") = ucOrders.ProcessProjectOrders(ViewState("ProjectID"), 0, context)
        ' Insert ProjectTasks Table
        ucOrders.ProcessProjectTasks(ViewState("OrderID"), context)

        ' Set Project Status to 5 (VO Awaiting approval)
        Common.ChangeProjectStatus(ViewState("ProjectID"), 5)

        ' and go to start page
        Response.Redirect(Request.ApplicationPath & "\default.aspx")
    End Sub
#End Region

End Class
