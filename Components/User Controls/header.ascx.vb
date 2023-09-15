Public Class header
  Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

  'This call is required by the Web Form Designer.
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

  End Sub
    Protected WithEvents litHelp As System.Web.UI.WebControls.Literal
    Protected WithEvents lblSupportNumber As System.Web.UI.WebControls.Label
  'NOTE: The following placeholder declaration is required by the Web Form Designer.
  'Do not delete or move it.
  Private designerPlaceholderDeclaration As System.Object

  Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
    'CODEGEN: This method call is required by the Web Form Designer
    'Do not modify it using the code editor.
    InitializeComponent()
  End Sub

#End Region

#Region "STANDARD DECLARES"
  Dim DBConn = ConfigurationSettings.AppSettings("DBConn")
  Dim sqlConn As SqlConnection
  Dim arParms() As SqlParameter = New SqlParameter(0) {}
  Dim DR As SqlDataReader
  Dim en As New System.Globalization.CultureInfo("en-Za")
  Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")

    'Public Support As String = Trim(ConfigurationSettings.AppSettings("SupportNumber"))
  Public AppName As String = Trim(ConfigurationSettings.AppSettings("ApplicationName"))
  Dim Ver As String = Trim(ConfigurationSettings.AppSettings("Version"))
  ' Dim Ver as System.Reflection.AssemblyVersionAttribute

  Public usrName As String

  ' This is used for returning errors to the page in a neat fashion
  Dim lit As New System.Web.UI.WebControls.Literal
#End Region

#Region "PAGE DECLARES"
  Protected WithEvents phError As System.Web.UI.WebControls.PlaceHolder
  Public hidAppPath As System.Web.UI.HtmlControls.HtmlInputHidden
  Public hidUserID As System.Web.UI.HtmlControls.HtmlInputHidden
#End Region


  Public WriteOnly Property LitText()
    Set(ByVal Value)
      lit.Text = Value
      phError.Controls.Add(lit)
    End Set
  End Property

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'UserName.Text = Request.Cookies("User").Values("FullName")


        'Put user code to initialize the page here
        Session("Version") = Ver
        Session("AppName") = Trim(AppName) & " " & Ver
        Session("usrName") = Request.Cookies("User").Values("FullName") 'Session("FirstName")
        hidAppPath.Value = Request.ApplicationPath
        hidUserID.Value = Request.Cookies("User").Values("UserID")

        Session("PageBody") = "<body class='main'>"
        Session("PageScripts") = "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Validation.js'></script>"
        Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/IMTime.js'></script>"
        Select Case Session("PageType")
            Case "Approval"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/IMCalendar.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Approvals.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Details.js'></script>"
            Case "Admin"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/IMCalendar.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/DynamicAdd.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Admin.js'></script>"
                Select Case Session("Page")
                    Case "Users"
                        Session("PageBody") = "<body class='main' onload='LoadDynamics();'>"
                        Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Users.js'></script>"
                End Select
            Case "Expenses"
                Session("PageBody") = "<body class='main' onload='LoadDynamics();'>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/DynamicAdd.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Expense.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/IMCalendar.js'></script>"
            Case "Info"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/DynamicAdd.js'></script>"
                Session("PageBody") = "<body class='main'>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/ProjInfo.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/IMCalendar.js'></script>"
            Case "Reports"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Reports.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/ReportFilters.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/printer.js'></script>"
            Case "TakeOn"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/DynamicAdd.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Details.js'></script>"
                Select Case Session("Page")
                    Case "TakeOn"
                        Session("PageBody") = "<body class='main' onload='ws1_init();LoadDynamics();'>"
                        Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Orders.js'></script>"
                        Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/TakeOn.js'></script>"
                    Case "VO"
                        Session("PageBody") = "<body class='main' onload='LoadOrderDynamics();'>"
                        Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Orders.js'></script>"
                        Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/VO.js'></script>"
                        Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/IMCalendar.js'></script>"
                End Select
            Case "TimeSheet"
                Session("PageBody") = "<body class='main' onload='LoadDynamics();'>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/DynamicAdd.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/Timesheet.js'></script>"
                Session("PageScripts") = Session("PageScripts") & "<script language='javascript' src='" & Request.ApplicationPath & "/Components/Scripts/IMCalendar.js'></script>"
        End Select

        'SD: 26/10/2005 - Load the support number
        If ConfigurationSettings.AppSettings("SupportNumber").Trim() = String.Empty Then
            lblSupportNumber.Visible = False
        Else
            lblSupportNumber.Visible = True
            lblSupportNumber.Text = "Support Number: " & ConfigurationSettings.AppSettings("SupportNumber").Trim()
        End If

    End Sub

End Class
