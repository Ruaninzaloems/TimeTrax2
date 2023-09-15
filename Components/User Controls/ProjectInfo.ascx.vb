Public Class ucProjectInfo
    Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtClient As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtContact As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtAdmin As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtProjFullName As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtProjName As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtProjCode As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtCostCentre As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtCurrency As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtStartDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents resourcePlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents Approver1Role As System.Web.UI.WebControls.Label
    Protected WithEvents txtApprover1 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Approver2Role As System.Web.UI.WebControls.Label
    Protected WithEvents txtApprover2 As System.Web.UI.WebControls.TextBox
    Protected WithEvents TSApprover1Role As System.Web.UI.WebControls.Label
    Protected WithEvents resourceLoadCount As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents Stage2row As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents txtTSApprover1 As System.Web.UI.WebControls.TextBox
    Protected WithEvents TSApprover2Role As System.Web.UI.WebControls.Label
    Protected WithEvents txtTeamLeader As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtResource_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents TSStage2row As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents addResourcerow As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents txtProjComment As System.Web.UI.WebControls.TextBox
    Protected WithEvents hidProjID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents plcBudgetSummary As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents plcTaskSummary As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents plcOrderSummary As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents spnSummaries As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents imgShowClient_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents imgShowContact_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents imgShowAdminContact_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents hidClientID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidContactID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidAdminContactID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents plcProjectDocuments As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents imgTeamLeaderChange As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents chkEnabled_ As System.Web.UI.WebControls.CheckBox
    Protected WithEvents hidResourceID_ As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents imgDisableResource_ As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents txtManager As System.Web.UI.WebControls.TextBox
    Protected WithEvents Img1 As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents spnDocuments As System.Web.UI.HtmlControls.HtmlGenericControl

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
    Dim DS As DataSet
    Dim en As New System.Globalization.CultureInfo("en-Za")

    ' Required for Errorhandling
    Protected WithEvents ucHeader As TimeTrax.header
    Dim strStatus As String
    Dim strErr As String
    Dim strMess As String

#End Region

#Region "PUBLIC VARIABLES"
    '  Public Shared ProjectID As Integer
    Public Shared ProjectID As Integer
    Public Shared blnShowSummaries As Boolean
#End Region

#Region " PAGE DECLARES "
    'Dim ucOrders As New TimeTrax.Orders
    Dim PTOApprovals As Int16
    Dim TaskOrderItem As Int16
    Dim TSApprovals As Int16
    Dim TeamLeaderRoleID As Int16
    Dim Approver1RoleID As Int16
    Dim Approver2RoleID As Int16
    Dim count As Int32
    Dim OrderID As Integer
    Dim i As Int32
    Dim strValue As String
    Dim hidBoxresource As HtmlInputHidden
    Dim ucProjectDocuments As New TimeTrax.ProjectDocuments
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ' hidProjID is used to pass ProjectID to Add Resource popup
        hidProjID.Value = ProjectID
        LoadPageData()
    End Sub

    Private Sub LoadPageData()
        ' hide the appropriate rows
        Stage2row.Visible = False
        TSStage2row.Visible = False

        If UserLogin.CheckUserAccess("62", context, False) Then
            addResourcerow.Visible = True
        Else
            addResourcerow.Visible = False
        End If

        LoadSystemData()
        LoadApprovers()
        resourceLoadCount.Value = 0
        If ProjectID <> 0 Then
            ' Load Project Data
            LoadProjectData()
        End If

        ucProjectDocuments.ProjectID = ProjectID

        'SD: 06/10/2005 - Don't show the change team leader image if the user doesn't have permission
        If UserLogin.CheckUserAccess("61", Context.Current, False) = False Then
            If Not imgTeamLeaderChange Is Nothing Then
                imgTeamLeaderChange.Visible = False
            End If
        End If

    End Sub
    Private Sub LoadSystemData()
        TaskOrderItem = 1
        DR = DAL.LoadSystemData()
        If DR.Read() Then
            ' Number of approval cycles for Project Take on
            If IsDBNull(DR.Item("PTOApprovals")) Then
                PTOApprovals = 1
            Else
                PTOApprovals = DR.Item("PTOApprovals")
            End If
            ' Number of approval cycles for Timesheets and Expenses
            If IsDBNull(DR.Item("TSApprovals")) Then
                TSApprovals = 1
            Else
                TSApprovals = DR.Item("TSApprovals")
            End If
            ' Project Budget Item (Order Item) to which Tasks total budget may not exceed
            If Not IsDBNull(DR.Item("TaskOrderItem")) Then
                TaskOrderItem = DR.Item("TaskOrderItem")
            End If
        End If
        DR.Close()

        ' Get The TeamLeader RoleID as TeamLeader is a fixed Resource for Projects
        ' Also used for Determining Approval Roles Etc
        DR = DAL.GetTeamLeaderRoleID()
        If DR.Read() Then
            ' Number of approval cycles for Project Take on
            If Not IsDBNull(DR.Item("RoleID")) Then
                TeamLeaderRoleID = DR.Item("RoleID")
            Else
                TeamLeaderRoleID = 0
            End If
        End If
        DR.Close()

    End Sub
    Private Sub LoadApprovers()

        ' First Load the Project Take on Approvers
        'Dim arParm2() As SqlParameter = New SqlParameter(0) {}
        For count = 1 To PTOApprovals
            ' Get the relevant Approver role from the system
            'arParm2(0) = New SqlParameter("@RoleID", count)
            DR = DAL.GetPTOApproverRole(count) 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectPTOApprover" & count & "Role")
            If DR.Read() Then
                Select Case count
                    Case 1
                        ' 1 Stage PTO Approvals
                        Approver1RoleID = DR.Item("RoleID")
                        Approver1Role.Text = DR.Item("RoleName")
                    Case 2
                        ' 2 Stage PTO Approvals
                        Approver2RoleID = DR.Item("RoleID")
                        Approver2Role.Text = DR.Item("RoleName")
                        Stage2row.Visible = True
                End Select
            End If
        Next
        DR.Close()

        'SD: 03/02/2010 - No longer required as approval is based on TSApprovals setting
        '' Then Load the Timesheet and Expense Approvers
        'For count = 1 To TSApprovals
        '    ' Get the relevant Approver role from the system
        '    DR = DAL.GetTSApproverRole(count)
        '    If DR.Read() Then
        '        Select Case count
        '            Case 1
        '                ' 1 Stage TS Approvals
        '                ' If the Role is not already in the resource roles list
        '                TSApprover1RoleID = DR.Item("RoleID")
        '                TSApprover1Role.Text = DR.Item("RoleName")
        '                If TSApprover1RoleID = Approver1RoleID Or TSApprover1RoleID = Approver2RoleID Or TSApprover1RoleID = TeamLeaderRoleID Then
        '                    ' Hide the TS Approver 1 Row
        '                    TSStage1row.Visible = False
        '                Else
        '                    TSStage1row.Visible = True
        '                End If
        '            Case 2
        '                ' 2 Stage TS Approvals
        '                TSApprover2RoleID = DR.Item("RoleID")
        '                TSApprover2Role.Text = DR.Item("RoleName")
        '                If TSApprover2RoleID = Approver1RoleID Or TSApprover2RoleID = Approver2RoleID Or TSApprover2RoleID = TeamLeaderRoleID Then
        '                    ' Hide the TS Approver 2 Row
        '                    TSStage2row.Visible = False
        '                Else
        '                    TSStage2row.Visible = True
        '                End If
        '        End Select
        '    End If
        'Next
        'DR.Close()

        If TSApprovals = 2 Then
            TSStage2row.Visible = True
        Else
            TSStage2row.Visible = False
        End If
    End Sub
    Private Sub LoadProjectData()
        DR = DAL.LoadProjectDetails(ProjectID)

        ' Get The Project Details
        If DR.Read() Then
            txtClient.Text = DR.Item("ClientName")
            txtContact.Text = DR.Item("ContactName")
            'SD: 07/09/2005 - Put the ID's into hidden boxes so that the details can be displayed
            hidClientID.Value = DR.Item("ClientID")
            hidContactID.Value = DR.Item("ContactID")
            If IsDBNull(DR.Item("AdminContactName")) Then
                txtAdmin.Text = DR.Item("ContactName")
                hidAdminContactID.Value = DR.Item("AdminContactID")
            Else
                txtAdmin.Text = DR.Item("AdminContactName")
                hidAdminContactID.Value = DR.Item("AdminContactID")
            End If
            txtProjFullName.Text = DR.Item("FullName")
            txtProjName.Text = DR.Item("ProjectName")
            txtProjCode.Text = DR.Item("ProjectCode")
            txtCostCentre.Text = DR.Item("CostCentreName")
            txtCurrency.Text = DR.Item("Currency")
            txtStartDate.Text = DR.Item("txtStart")
            'txtEndDate.Text = DR.Item("txtEnd")
            If Not IsDBNull(DR.Item("Comments")) Then
                txtProjComment.Text = DR.Item("Comments")
            End If
        End If

        ' Get The Project Resources
        DR.NextResult()
        i = 0
        While DR.Read()
            If IsDBNull(DR.Item("FirstApprover")) And IsDBNull(DR.Item("LastApprover")) And IsDBNull(DR.Item("TSLastApprover")) And IsDBNull(DR.Item("TeamLeader")) Then
                ' Team member so add to dynamic add
                i = i + 1
                hidBoxresource = New HtmlInputHidden
                hidBoxresource.ID = "hidBoxresource_" & i
                strValue = DR.Item("UserID") & "#" & DR.Item("UserName") & "#" & DR.Item("Enabled")  'SD: 24/10/2005 - Allow for enabling and disabling of resources
                hidBoxresource.Value = strValue
                resourcePlace.Controls.Add(hidBoxresource)
            Else
                If Not IsDBNull(DR.Item("TeamLeader")) Then
                    ' TeamLeader
                    txtTeamLeader.Text = DR.Item("UserName")
                End If

                If Not IsDBNull(DR.Item("TSLastApprover")) Then
                    ' Final Timesheet Expenses Approver
                    If TSApprovals > 1 Then
                        ' First Approver (May not exist depends on System.TSApprovals value)
                        If Not IsDBNull(DR.Item("TSLastApprover")) Then
                            txtManager.Text = DR.Item("UserName")
                        End If
                    End If
                Else
                If Not IsDBNull(DR.Item("LastApprover")) Then
                    ' Final Approver
                    txtApprover1.Text = DR.Item("UserName")
                Else
                    If Not IsDBNull(DR.Item("FirstApprover")) Then
                        If PTOApprovals > 1 Then
                            ' First Approver (May not exist depends on System.PTOApprovals value)
                            txtApprover2.Text = DR.Item("UserName")
                        End If
                    End If
                End If
            End If
            End If
        End While
        resourceLoadCount.Value = i

        DR.Close()

        If blnShowSummaries Then
            spnSummaries.Visible = True
            LoadProjectOrders()
        Else
            spnSummaries.Visible = False
        End If

    End Sub
    Private Sub LoadProjectOrders()

        Dim tbl As HtmlTable
        Dim BudgetRow As DataRow
        Dim TaskRow As DataRow
        Dim OrderRow As DataRow
        Dim TotAmount As Double
        Dim TotInvoicedAmount As Double
        Dim TotHours As Double

        plcBudgetSummary.Controls.Clear()
        plcTaskSummary.Controls.Clear()
        plcOrderSummary.Controls.Clear()

        DS = DAL.LoadProjectOrderSummaries(ProjectID)
        ' Get The Project Orders Summaries
        If DS.Tables.Count > 0 Then
            ' Budget Summary 
            If DS.Tables(0).Rows.Count > 0 Then
                tbl = New HtmlTable
                'add the new table to the placeholder
                tbl = BuildTableHeader("Budget", tbl)
                plcBudgetSummary.Controls.Add(tbl)
                TotAmount = 0
                TotHours = 0
                For Each BudgetRow In DS.Tables(0).Rows
                    tbl = BuildSummaryTable("Budget", tbl, BudgetRow)
                    TotAmount += BudgetRow.Item("Amount")
                    TotInvoicedAmount += BudgetRow.Item("InvoicedAmount")
                Next
                tbl = BuildTableFooter("Budget", TotAmount, TotHours, tbl, TotInvoicedAmount)
            End If

            ' Task Summary 
            If DS.Tables(1).Rows.Count > 0 Then
                tbl = New HtmlTable
                'add the new table to the placeholder
                tbl = BuildTableHeader("Task", tbl)
                plcTaskSummary.Controls.Add(tbl)
                TotAmount = 0
                TotHours = 0
                For Each TaskRow In DS.Tables(1).Rows
                    tbl = BuildSummaryTable("Task", tbl, TaskRow)
                    TotAmount += TaskRow.Item("Amount")
                    TotHours += TaskRow.Item("Hours")
                Next
                tbl = BuildTableFooter("Task", TotAmount, TotHours, tbl, 0)
            End If

            ' Order Summary 
            If DS.Tables(2).Rows.Count > 0 Then
                tbl = New HtmlTable
                'add the new table to the placeholder
                tbl = BuildTableHeader("Order", tbl)
                plcOrderSummary.Controls.Add(tbl)
                TotAmount = 0
                TotHours = 0
                For Each OrderRow In DS.Tables(2).Rows
                    tbl = BuildSummaryTable("Order", tbl, OrderRow)
                    TotAmount += OrderRow.Item("Amount")
                Next
                tbl = BuildTableFooter("Order", TotAmount, TotHours, tbl, 0)
            End If
        End If
    End Sub

    Private Function BuildTableHeader(ByVal Type As String, ByVal tbl As HtmlTable)
        tbl.Attributes.Add("width", "100%")
        tbl.CellPadding = 0
        tbl.CellSpacing = 0
        tbl.Border = 0

        'Add the row to the table
        Dim tr As HtmlTableRow = New HtmlTableRow
        tbl.Controls.Add(tr)

        Dim td As HtmlTableCell
        Select Case Type
            Case "Budget"
                td = New HtmlTableCell("th")
                td = AddCell(td, "50%", "th2", String.Empty, "Budget Item", String.Empty)
                tr.Controls.Add(td)
                td = New HtmlTableCell("th")
                td = AddCell(td, String.Empty, "th2", String.Empty, "Budget", String.Empty)
                tr.Controls.Add(td)
                td = New HtmlTableCell("th")
                td = AddCell(td, String.Empty, "th2", String.Empty, "Invoiced Amount", String.Empty)
                tr.Controls.Add(td)
            Case "Task"
                td = New HtmlTableCell("th")
                td = AddCell(td, "50%", "th2", String.Empty, "Task", String.Empty)
                tr.Controls.Add(td)
                td = New HtmlTableCell("th")
                td = AddCell(td, "30%", "th2", String.Empty, "Budget", String.Empty)
                tr.Controls.Add(td)
                td = New HtmlTableCell("th")
                td = AddCell(td, "20%", "th2", String.Empty, "Hours", String.Empty)
                tr.Controls.Add(td)
            Case "Order"
                td = New HtmlTableCell("th")
                td = AddCell(td, "20%", "th2", String.Empty, "Order No", String.Empty)
                tr.Controls.Add(td)
                td = New HtmlTableCell("th")
                td = AddCell(td, "20%", "th2", String.Empty, "Order Date", String.Empty)
                tr.Controls.Add(td)
                td = New HtmlTableCell("th")
                td = AddCell(td, "20%", "th2", String.Empty, "End Date", String.Empty)
                tr.Controls.Add(td)
                td = New HtmlTableCell("th")
                td = AddCell(td, "30%", "th2", String.Empty, "Budget", String.Empty)
                tr.Controls.Add(td)
                td = New HtmlTableCell("th")
                td = AddCell(td, "10%", "th2", String.Empty, String.Empty, "&nbsp;") 'Send through the &nbsp; so that the style is set correctly
                tr.Controls.Add(td)
        End Select


        Return tbl

    End Function
    Private Function BuildTableFooter(ByVal Type As String, ByVal Amount As Double, ByVal Hours As Double, ByVal tbl As HtmlTable, ByVal InvoicedAmount As Double)

        Dim txt As TextBox
        'Add the row to the table
        Dim tr As HtmlTableRow = New HtmlTableRow
        tbl.Controls.Add(tr)

        Dim td As HtmlTableCell

        td = New HtmlTableCell("td")
        td = AddCell(td, String.Empty, "td1", String.Empty, String.Empty, "<b>Total</b>")
        If Type = "Order" Then
            td.ColSpan = 3
        End If
        tr.Controls.Add(td)

        Select Case Type
            Case "Budget"
                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                txt.Text = String.Format("{0:C}", Convert.ToDecimal(Amount))
                td.Controls.Add(txt)
                tr.Controls.Add(td)

                'Invoiced Amount
                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                txt.Text = String.Format("{0:C}", Convert.ToDecimal(InvoicedAmount))
                td.Controls.Add(txt)
                tr.Controls.Add(td)
            Case "Task"
                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Currency
                'txt.ThousandsSeperator = ","
                'txt.Text = Amount
                txt.Text = String.Format("{0:C}", Convert.ToDecimal(Amount))
                td.Controls.Add(txt)
                tr.Controls.Add(td)
                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Decimal
                'txt.Text = Amount
                txt.Text = Hours
                td.Controls.Add(txt)
                tr.Controls.Add(td)
            Case "Order"
                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", "left", String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Currency
                'txt.ThousandsSeperator = ","
                'txt.Text = Amount
                txt.Text = String.Format("{0:C}", Convert.ToDecimal(Amount))
                td.Controls.Add(txt)
                td.ColSpan = "2"
                tr.Controls.Add(td)
        End Select


        Return tbl

    End Function
    Private Function BuildSummaryTable(ByVal Type As String, ByVal tbl As HtmlTable, ByVal RowData As DataRow) As HtmlTable

        Dim td As HtmlTableCell
        'Dim txt As Intermap.Controls.IMTextBox
        Dim txt As TextBox
        Dim img As HtmlImage
        Dim imgOrder As HtmlImage
        Dim imgInvoice As HtmlImage

        'Add the row to the table
        Dim tr As HtmlTableRow = New HtmlTableRow
        tbl.Controls.Add(tr)

        Select Case Type
            Case "Budget"
                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td1", String.Empty, RowData.Item("ItemName"), String.Empty)
                tr.Controls.Add(td)

                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Currency
                'txt.ThousandsSeperator = ","
                txt.Text = String.Format("{0:C}", Convert.ToDecimal(RowData.Item("Amount")))
                td.Controls.Add(txt)
                tr.Controls.Add(td)

                'Invoiced Amount
                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Currency
                'txt.ThousandsSeperator = ","
                txt.Text = String.Format("{0:C}", Convert.ToDecimal(RowData.Item("InvoicedAmount")))
                td.Controls.Add(txt)
                tr.Controls.Add(td)
            Case "Task"
                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td1", String.Empty, RowData.Item("TaskName"), String.Empty)
                tr.Controls.Add(td)

                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Currency
                'txt.ThousandsSeperator = ","
                txt.Text = String.Format("{0:C}", Convert.ToDecimal(RowData.Item("Amount")))
                td.Controls.Add(txt)
                tr.Controls.Add(td)

                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Decimal
                txt.Text = RowData.Item("Hours")
                td.Controls.Add(txt)
                tr.Controls.Add(td)
            Case "Order"
                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td1", String.Empty, RowData.Item("OrderNumber"), String.Empty)
                tr.Controls.Add(td)

                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td1", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Date
                txt.Text = RowData.Item("txtOrderDate")
                td.Controls.Add(txt)
                tr.Controls.Add(td)

                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td1", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Date
                txt.Text = RowData.Item("txtEndDate")
                td.Controls.Add(txt)
                tr.Controls.Add(td)

                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", String.Empty, String.Empty, String.Empty)
                'txt = New Intermap.Controls.IMTextBox
                txt = New TextBox
                txt.CssClass = "InputROR"
                txt.ReadOnly = True
                'txt.TextType = Intermap.Controls.TextTypes.Currency
                'txt.ThousandsSeperator = ","
                txt.Text = String.Format("{0:C}", Convert.ToDecimal(RowData.Item("Amount")))
                td.Controls.Add(txt)
                tr.Controls.Add(td)

                td = New HtmlTableCell("td")
                td = AddCell(td, String.Empty, "td2", "center", String.Empty, String.Empty)
                img = New HtmlImage
                img.Src = "..\..\Images\detail.gif"
                img.Alt = "View Order Details"
                img.Attributes.Add("onclick", "viewOrder(" & RowData.Item("OrderID") & "," & Request.QueryString("ProjID") & ");")
                img.Attributes.Add("style", "cursor:hand")
                imgOrder = New HtmlImage
                imgOrder.Src = "..\..\Images\order.gif"
                imgOrder.Alt = "Upload Order"
                imgOrder.Attributes.Add("onclick", "uploadFinancialDoc(" & ProjectID & "," & RowData.Item("OrderID") & ",1);")
                imgOrder.Attributes.Add("style", "cursor:hand")
                imgInvoice = New HtmlImage
                imgInvoice.Src = "..\..\Images\Invoice.gif"
                imgInvoice.Alt = "Upload Invoice"
                imgInvoice.Attributes.Add("onclick", "uploadFinancialDoc(" & ProjectID & "," & RowData.Item("OrderID") & ",2);")
                imgInvoice.Attributes.Add("style", "cursor:hand")
                td.Controls.Add(img)
                td.Controls.Add(imgOrder)
                td.Controls.Add(imgInvoice)
                tr.Controls.Add(td)
        End Select

        Return tbl

    End Function
    Private Function AddCell(ByVal td As HtmlTableCell, ByVal width As String, ByVal cssclass As String, ByVal align As String, ByVal text As String, ByVal html As String)
        If width <> "" Then
            td.Attributes.Add("Width", width)
        End If
        If cssclass <> "" Then
            td.Attributes.Add("class", cssclass)
        End If
        If align <> "" Then
            td.Attributes.Add("align", align)
        End If
        If text <> "" Then
            td.InnerText = text
        End If
        If html <> "" Then
            td.InnerHtml = html
        End If

        Return td
    End Function

    Private Sub txtProjComment_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtProjComment.TextChanged

    End Sub
End Class
