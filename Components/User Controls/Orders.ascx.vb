Public Class Orders
    Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents orderPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents rfvOrderNo As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtProjBudget As System.Web.UI.WebControls.TextBox
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
    Protected WithEvents imgDeleteorder_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents taskLoadCount As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents task_maxbudget As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents imgDeletetask_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents cvEndDate As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents cvBudget As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents txtItemID As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtItemID_ As System.Web.UI.WebControls.TextBox
    ' These are used in parent page
    Protected WithEvents txtOrderNo As System.Web.UI.WebControls.TextBox
    Protected WithEvents ddlOrderItem_ As System.Web.UI.WebControls.DropDownList
    Protected WithEvents cvProjectBudget As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents tblorderadd As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents tbltaskadd As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents txtHidTaskOrderItemDesc As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents txtEndDate As Intermap.Controls.IMTextBox
    Protected WithEvents txtOrderDate As Intermap.Controls.IMTextBox
    Protected WithEvents rfvOrderDate As System.Web.UI.WebControls.RequiredFieldValidator
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

#Region "PUBLIC VARIABLES"
    '  Public Shared ProjectID As Integer
    Public Shared ProjID As Integer
    Public Shared OrderID As Integer
    Public Shared TaskOrderItem As Integer
    Public Shared blnReadOnly As Boolean
    Public Shared blnAdminAccess As Boolean
#End Region

#Region "PAGE DECLARES"
    Dim i As Int16
    Dim strValue As String
    Dim hidBoxorder As HtmlInputHidden
    Dim hidBoxtask As HtmlInputHidden
    Dim ItemNo, ItemID As String
    Dim a, NoRows As Integer
    Dim arrData As Array
#End Region

#Region "PAGE LOAD"
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        task_orderitem.Value = TaskOrderItem
        orderLoadCount.Value = 0
        taskLoadCount.Value = 0
        LoadDropLists()
        LoadTaskOrderItemDesc()
        '    If ProjectID <> 0 Then
        ' New Order (Project VO)
        '    LoadProjectOrder()
        '    Else
        If OrderID <> 0 Then
            ' Update ExistingOrder (Project VO)
            LoadOrderDetails()
        End If
        If blnReadOnly Then
            ' Disable Order Details
            txtOrderNo.ReadOnly = True
            txtOrderNo.CssClass = "InputRO"
            txtOrderDate.ReadOnly = True
            txtOrderDate.CssClass = "InputRO"
            txtOrderDate.TextType = TextTypes.Text
            txtEndDate.ReadOnly = True
            txtEndDate.CssClass = "InputRO"
            ddlOrderItem_.Enabled = False
            txtOrderAmount_.ReadOnly = True
            txtOrderAmount_.CssClass = "InputROR"
            imgDeleteorder_.Disabled = True
            imgDeleteorder_.Alt = ""
            imgDeleteorder_.Src = "../../images/blank.gif"
            imgDeleteorder_.Style.Item("CURSOR") = "default"
            tblorderadd.Visible = False
            ' Disable Task Details
            tbltaskadd.Visible = False
            imgDeletetask_.Disabled = True
            imgDeletetask_.Alt = ""
            imgDeletetask_.Src = "../../images/blank.gif"
            imgDeletetask_.Style.Item("CURSOR") = "default"
            txtTask_.ReadOnly = True
            txtTask_.CssClass = "InputRO"
            txtTaskAmount_.ReadOnly = True
            txtTaskAmount_.CssClass = "InputROR"
            txtHours_.ReadOnly = True
            txtHours_.CssClass = "InputROR"
            chkBillable_.Enabled = False
            If AdminAccess() = True Then
                ' Check that the order being updtaed is the latest order,
                If ViewState("LastOrderID") = OrderID Then
                    txtEndDate.ReadOnly = False
                    txtEndDate.CssClass = "Input"
                End If
                txtTask_.ReadOnly = False
                txtTask_.CssClass = "Input"
                txtTaskAmount_.ReadOnly = False
                txtTaskAmount_.CssClass = "InputR"
                txtHours_.ReadOnly = False
                txtHours_.CssClass = "InputR"
                chkBillable_.Enabled = True
                txtOrderDate.ReadOnly = True
                txtOrderDate.CssClass = "InputRO"
                txtOrderDate.TextType = TextTypes.Text

                'Switch off the validation on order date if this is readonly mode so that the end date can still be changed
                rfvOrderDate.Enabled = False
            End If

        Else
            txtOrderDate.TextType = TextTypes.Date
        End If
        '    End If
    End Sub

    Private Function AdminAccess() As Boolean
        ' If the User is a Administrator or The Project Team Leader
        ' Then grant access to change Tasknames and Project EndDates
        blnAdminAccess = False
        Dim UserGroup As String = DAL.GetUserGroup(context.User.Identity.Name)
        'If UserGroup = "Admin" Or UserGroup = "Admin Manager" Or UserGroup = "Super User" Then - SD: 24/04/2006 - This is now role based
        If UserLogin.CheckUserAccess("63", context, False) Then
            blnAdminAccess = True
        End If

        Dim DR As SqlDataReader = DAL.LoadProjectResources(ProjID)
        While DR.Read
            If DR.Item("UserID") = context.User.Identity.Name And Not IsDBNull(DR.Item("TeamLeader")) Then
                blnAdminAccess = True
                Exit While
            End If
        End While
        DR.Close()

        Return blnAdminAccess

    End Function

    'Created by SB on 01/08/2005
    'Retrieves the Task Order Item Description
    Private Sub LoadTaskOrderItemDesc()
        DR = DAL.LoadOrderItems(TaskOrderItem)
        If DR.Read() Then
            txtHidTaskOrderItemDesc.Value = IIf(IsDBNull(DR.Item("ItemName")), String.Empty, DR.Item("ItemName"))
        End If
        DR.Close()
    End Sub

    Private Sub LoadDropLists()
        ' Load the OrderItems Droplist
        ddlOrderItem_.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectOrderItem")
        ddlOrderItem_.DataBind()
        ddlOrderItem_.Items.Insert(0, New ListItem("--Select a Budget Item--", "0"))
    End Sub

    Private Sub LoadOrderDetails()
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        orderLoadCount.Value = 0
        arParms(0) = New SqlParameter("@OrderID", OrderID)
        DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectOrderDetails", arParms)
        If DR.Read Then
            txtEndDate.Text = DR.Item("txtEnd")
            txtOrderDate.Text = DR.Item("txtOrderDate")
            ViewState("savEndDate") = txtEndDate.Text
            txtOrderNo.Text = DR.Item("OrderNumber")
            ProjID = DR.Item("ProjectID")
            ' Get The Order Budgets
            DR.NextResult()
            LoadBudgets()
            ' Get The Order Tasks
            DR.NextResult()
            LoadTasks()
        End If
        DR.Close()

        ' Load the Last Approved OrderID
        ' This will be used to determine if EndDate can be changed or not
        ViewState("LastOrderID") = DAL.LoadLastApprovedProjectOrder(ProjID)


    End Sub

    Private Sub LoadBudgets()
        i = 0
        While DR.Read()
            i = i + 1
            hidBoxorder = New HtmlInputHidden
            hidBoxorder.ID = "hidBoxorder_" & i
            strValue = DR.Item("ItemID")
            strValue &= "#" & DR.Item("OrderItemID")    'SD: 19/10/2005 - Change dymanic adds from , to #
            strValue &= "#" & DR.Item("Amount")         'SD: 19/10/2005 - Change dymanic adds from , to #
            hidBoxorder.Value = strValue
            orderPlace.Controls.Add(hidBoxorder)
            If DR.Item("OrderItemID") = TaskOrderItem Then
                ' Total task budget may not exceed this amount
                task_maxbudget.Value = DR.Item("Amount")
            End If
        End While
        orderLoadCount.Value = i
    End Sub

    Private Sub LoadTasks()
        ' Get The Order Tasks
        i = 0
        While DR.Read()
            i = i + 1
            hidBoxtask = New HtmlInputHidden
            hidBoxtask.ID = "hidBoxtask_" & i
            strValue = DR.Item("TaskID")
            'SD: 19/10/2005 - Change dymanic adds from , to #
            strValue &= "#" & DR.Item("TaskName")
            strValue &= "#" & DR.Item("Amount")
            strValue &= "#" & DR.Item("Hours")
            strValue &= "#" & DR.Item("Billable")
            hidBoxtask.Value = strValue
            taskPlace.Controls.Add(hidBoxtask)
        End While
        taskLoadCount.Value = i

    End Sub
#End Region

#Region "SHARED FUNCTIONS"
    Public Function ProcessProjectOrders(ByVal ProjectID As Integer, ByVal OrderID As Integer, ByVal contxt As HttpContext)
        ' Update Project Order Data
        Dim arParms() As SqlParameter = New SqlParameter(4) {}
        arParms(0) = New SqlParameter("@ProjID", ProjectID)
        arParms(1) = New SqlParameter("@OrderID", IIf(OrderID <> 0, OrderID, DBNull.Value))
        arParms(1).Direction = ParameterDirection.InputOutput
        arParms(1).DbType = DbType.Int16
        arParms(2) = New SqlParameter("@OrderNo", contxt.Request.Form("ucOrders:txtOrderNo"))
        arParms(3) = New SqlParameter("@EndDate", System.DateTime.ParseExact(contxt.Request.Form("ucOrders:txtEndDate"), "dd/MM/yyyy", en))
        If contxt.Request.Form("ucOrders:txtOrderDate") = "" Then
            arParms(4) = New SqlParameter("@OrderDate", DBNull.Value)
        Else
            arParms(4) = New SqlParameter("@OrderDate", System.DateTime.ParseExact(contxt.Request.Form("ucOrders:txtOrderDate"), "dd/MM/yyyy", en))
        End If
        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateOrders", arParms)
        If Not IsDBNull(arParms(1).Value) Then
            ' If the Stored proc Inserted an Order then the OrderID is returned
            OrderID = arParms(1).Value
        End If
        ' If the Project EndDate has been changed
        ' This can only happen if the order is the last Approved Order
        If contxt.Request.Form("ucOrders:txtEndDate") <> ViewState("savEndDate") Then
            DAL.ChangeProjectEndDate(ProjectID, contxt.Request.Form("ucOrders:txtEndDate"))
        End If
        ProcessProjectOrderItems(OrderID, contxt)

        Return OrderID
    End Function

    Public Sub ProcessProjectOrderItems(ByVal OrderID As Integer, ByVal contxt As HttpContext)

        ' Then process Project Order Items
        a = 0
        NoRows = 0

        ItemNo = ""
        ItemNo = contxt.Request.Form("order_list")

        If ItemNo <> "" And ItemNo <> "#" Then            'SD: 19/10/2005 - Change dymanic adds from , to #
            Try
                Dim RowArray As Array = ItemNo.Split("#") 'SD: 19/10/2005 - Change dymanic adds from , to #
                NoRows = RowArray((RowArray.Length - 2))
            Catch
            End Try

            If NoRows < contxt.Request.Form("ucOrders:orderLoadCount") Then
                NoRows = contxt.Request.Form("ucOrders:orderLoadCount")
            End If
        Else
            ' There are no dynamic add rows, if there were items on load then these need to be deleted now
            NoRows = contxt.Request.Form("ucOrders:orderLoadCount")
        End If

        While a < NoRows
            a += 1

            ' Get the OrderItemID from the hiddenbox
            ItemID = ""
            Dim HidBoxVal As String = contxt.Request.Form("ucOrders:hidBoxorder_" & a)
            If HidBoxVal <> "" Then
                arrData = HidBoxVal.Split("#")  'SD: 19/10/2005 - Change dymanic adds from , to #
                ItemID = arrData(0)
            End If

            'Write to Database
            Dim arParms2() As SqlParameter = New SqlParameter(3) {}
            arParms2(0) = New SqlParameter("@OrderID", OrderID)
            arParms2(1) = New SqlParameter("@ItemID", IIf(ItemID <> "", ItemID, DBNull.Value))
            arParms2(2) = New SqlParameter("@OrderItemID", contxt.Request.Form("ucOrders:ddlOrderItem_" & a))
            Dim Amt As Decimal
            If contxt.Request.Form("ucOrders:txtOrderAmount_" & a) = "" Then
                Amt = 0
            Else
                Amt = contxt.Request.Form("ucOrders:txtOrderAmount_" & a)
            End If
            arParms2(3) = New SqlParameter("@Amount", IIf(Amt > 0, Amt, DBNull.Value))
            '            arParms2(3) = New SqlParameter("@Amount", IIf(contxt.Request.Form("ucOrders:txtOrderAmount_" & a) <> "", CDec(contxt.Request.Form("ucOrders:txtOrderAmount_" & a)), DBNull.Value))
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateProjectOrderItems", arParms2)
        End While

    End Sub

    Public Sub ProcessProjectTasks(ByVal OrderID As Integer, ByVal contxt As HttpContext)
        a = 0
        NoRows = 0

        ItemNo = ""
        ItemNo = contxt.Request.Form("task_list")

        If ItemNo <> "" And ItemNo <> "#" Then
            Try
                Dim RowArray As Array = ItemNo.Split("#") 'SD: 19/10/2005 - Change dymanic adds from , to #
                NoRows = RowArray((RowArray.Length - 2))
            Catch
            End Try

            If NoRows < contxt.Request.Form("ucOrders:taskLoadCount") Then
                NoRows = contxt.Request.Form("ucOrders:taskLoadCount")
            End If
        Else
            ' There are no dynamic add rows, if there were items on load then these need to be deleted now
            NoRows = contxt.Request.Form("ucOrders:taskLoadCount")
        End If

        While a < NoRows
            a += 1

            ' Get the OrderItemID from the hiddenbox
            ItemID = ""
            Dim HidBoxVal As String = contxt.Request.Form("ucOrders:hidBoxtask_" & a)
            If HidBoxVal <> "" Then
                arrData = HidBoxVal.Split("#")  'SD: 19/10/2005 - Change dymanic adds from , to #
                ItemID = arrData(0)
            End If

            'Write to Database
            Dim arParms2() As SqlParameter = New SqlParameter(5) {}
            arParms2(0) = New SqlParameter("@TaskID", IIf(ItemID <> "", ItemID, DBNull.Value))
            arParms2(1) = New SqlParameter("@OrderID", OrderID)
            arParms2(2) = New SqlParameter("@Name", IIf(contxt.Request.Form("ucOrders:txtTask_" & a) <> "", contxt.Request.Form("ucOrders:txtTask_" & a), DBNull.Value))
            arParms2(3) = New SqlParameter("@Amount", contxt.Request.Form("ucOrders:txtTaskAmount_" & a))
            arParms2(4) = New SqlParameter("@Hours", contxt.Request.Form("ucOrders:txtHours_" & a))
            If contxt.Request.Form("ucOrders:chkBillable_" & a) = "on" Then
                arParms2(5) = New SqlParameter("@Billable", "1")
            Else
                arParms2(5) = New SqlParameter("@Billable", "0")
            End If
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateProjectTasks", arParms2)
        End While
    End Sub

#End Region

End Class
