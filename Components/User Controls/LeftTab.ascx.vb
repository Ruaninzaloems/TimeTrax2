Public Class LeftTab
  Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

  'This call is required by the Web Form Designer.
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

  End Sub
  Protected WithEvents LeftTab As System.Web.UI.WebControls.DataList

  'NOTE: The following placeholder declaration is required by the Web Form Designer.
  'Do not delete or move it.
  Private designerPlaceholderDeclaration As System.Object

  Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
    'CODEGEN: This method call is required by the Web Form Designer
    'Do not modify it using the code editor.
    InitializeComponent()
  End Sub

#End Region

#Region " PAGE DECLARES "
  Dim TopTabSelected As String
  Dim LeftTabItems As New ArrayList
#End Region

  Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    TopTabSelected = Request.QueryString("indextop")

    Select Case TopTabSelected
      Case 0 ' Start Page
      Case 1 ' Project Admin
        LeftTabItems.Add(New LeftTabs("Home", "Project/Default.aspx?indextop=1&indexleft=" & LeftTabItems.Count, "block"))
        If Context.User.IsInRole("2") Then
          LeftTabItems.Add(New LeftTabs("Take On", "Project/ProjectTakeOn.aspx?indextop=1&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("5") Then
          LeftTabItems.Add(New LeftTabs("Approval", "Approvals/PTO.aspx?indextop=1&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("23") Then
          LeftTabItems.Add(New LeftTabs("Variation Order", "Project/ProjectVO.aspx?indextop=1&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("24") Then
          LeftTabItems.Add(New LeftTabs("VO Approval", "Approvals/VO.aspx?indextop=1&indexleft=" & LeftTabItems.Count, "block"))
        End If
      Case 2 ' Timesheet Capture
      Case 3 ' Expense Capture
      Case 4 ' Timesheet Approval
      Case 5 ' Expense Approval
      Case 6 ' Admin
        LeftTabItems.Add(New LeftTabs("Home", "Admin/Default.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        If Context.User.IsInRole("10") Then
          LeftTabItems.Add(New LeftTabs("Users", "Admin/Users.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("11") Then
          LeftTabItems.Add(New LeftTabs("Budget Items", "Admin/BudgetItems.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("12") Then
          LeftTabItems.Add(New LeftTabs("Cost Centres", "Admin/CostCentres.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("13") Then
          LeftTabItems.Add(New LeftTabs("Expense Items", "Admin/ExpenseItems.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("14") Then
          LeftTabItems.Add(New LeftTabs("Countries", "Admin/Countries.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        'If Context.User.IsInRole("15") Then
        '  LeftTabItems.Add(New LeftTabs("User Roles", "Admin/UserRoles.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        'End If
        If Context.User.IsInRole("16") Then
          LeftTabItems.Add(New LeftTabs("Clients", "Admin/Clients.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("17") Then
          LeftTabItems.Add(New LeftTabs("Contacts", "Admin/Contacts.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("18") Then
          LeftTabItems.Add(New LeftTabs("System", "Admin/SystemAdmin.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("19") Then
          LeftTabItems.Add(New LeftTabs("Approval Types", "Admin/ApprovalTypes.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("20") Then
          LeftTabItems.Add(New LeftTabs("Groups", "Admin/GroupNames.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("21") Then
          LeftTabItems.Add(New LeftTabs("Roles", "Admin/RoleNames.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
        If Context.User.IsInRole("22") Then
          LeftTabItems.Add(New LeftTabs("Currencies", "Admin/Currencies.aspx?indextop=6&indexleft=" & LeftTabItems.Count, "block"))
        End If
      Case 7 ' Reports
        LeftTabItems.Add(New LeftTabs("Home", "Reports/Default.aspx?indextop=7&indexleft=" & LeftTabItems.Count, "block"))
      Case Else
    End Select

    LeftTab.DataSource = LeftTabItems
    LeftTab.SelectedIndex = IIf(Len(Request("indexleft")) < 1, 0, Mid(Request("indexleft"), 1, Len(Request("indexleft"))))
    LeftTab.DataBind()
  End Sub

End Class
