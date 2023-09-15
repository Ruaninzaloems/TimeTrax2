Public Class SystemAdmin
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents rfvPTOApprovals As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtTSApprovals As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvTSApprovals As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents rfvPTOApprover1Role As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ddlTSApprover1Role As System.Web.UI.WebControls.DropDownList
    Protected WithEvents rfvTSApprover1Role As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtMileageCost As System.Web.UI.WebControls.TextBox
    Protected WithEvents chkEnabled As System.Web.UI.WebControls.CheckBox
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents txtuserid As System.Web.UI.WebControls.TextBox
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents ddlPTOApprover2Role As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlPTOApprover1Role As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlTSApprover2Role As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlOrderItem As System.Web.UI.WebControls.DropDownList
    Protected WithEvents rfvOrderItem As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ddlAuthenticateMethod As System.Web.UI.WebControls.DropDownList
    Protected WithEvents regexTSApprovals As System.Web.UI.WebControls.RegularExpressionValidator
    Protected WithEvents ddlPTOApprovals As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlTSApprovals As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Dropdownlist2 As System.Web.UI.WebControls.DropDownList
    Protected WithEvents chkWeeklyReminder As System.Web.UI.WebControls.CheckBox
    Protected WithEvents txtMonthReminder As System.Web.UI.WebControls.TextBox
    Protected WithEvents rvMonthReminder As System.Web.UI.WebControls.RangeValidator
    Protected WithEvents ddlDOW As System.Web.UI.WebControls.DropDownList
    Protected WithEvents divPTOApprover As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents divTSApprover As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents ddlWeekStartDay As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Img1 As System.Web.UI.HtmlControls.HtmlImage
    Protected WithEvents Img2 As System.Web.UI.HtmlControls.HtmlImage

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

#Region " PAGE DECLARES "
#End Region

#Region " PAGE LOAD "

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "18"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            ' FIRST PAGE LOAD DISPLAY SELECT USER DROPLIST
            Session("PageType") = "Admin"
            Session("Page") = "System"
            Session("PageTitle") = Session("AppName") & " - Administration (Manage System)"
            LoadDropdowns()
            LoadSystemDetails()

            tblwizard2.Visible = True
            tblwizard3.Visible = False
        Else
            tblwizard2.Visible = False
            tblwizard3.Visible = True
        End If
    End Sub

    Function LoadDropdowns()
        Dim DS As DataSet = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "TT_SelectGroup")

        'Populate the First PTO Approver role dropdown
        ddlPTOApprover2Role.Items.Clear()
        ddlPTOApprover2Role.DataSource = DS.Tables(0)
        ddlPTOApprover2Role.DataBind()
        'Populate the Final PTO Approver role dropdown
        ddlPTOApprover1Role.Items.Clear()
        ddlPTOApprover1Role.DataSource = DS.Tables(0)
        ddlPTOApprover1Role.DataBind()

        'Populate the First TS Approver role dropdown
        ddlTSApprover2Role.Items.Clear()
        ddlTSApprover2Role.DataSource = DS.Tables(0)
        ddlTSApprover2Role.DataBind()
        'Populate the Final TS Approver role dropdown
        ddlTSApprover1Role.Items.Clear()
        ddlTSApprover1Role.DataSource = DS.Tables(0)
        ddlTSApprover1Role.DataBind()

        ' Populate OrderItems
        ddlOrderItem.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectOrderItem")
        ddlOrderItem.DataBind()

    End Function

    Function LoadSystemDetails()
        Try
            DR = DAL.LoadSystemData() 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectSystem")
        Catch ex As SqlException
            lblmessage.Text = "<b>Error(" & ex.Number & ")</b> " & ex.Message
            tblwizard3.Visible = True
        End Try

        If DR.Read Then
            ddlPTOApprovals.SelectedIndex = Common.GetIndexByText(ddlPTOApprovals, DR.Item("PTOApprovals"))
            ddlTSApprovals.SelectedIndex = Common.GetIndexByText(ddlTSApprovals, DR.Item("TSApprovals"))

            ddlPTOApprover1Role.SelectedIndex = Common.GetIndexByValue(ddlPTOApprover1Role, DR.Item("PTOApprover1Role"))
            ddlPTOApprover2Role.SelectedIndex = Common.GetIndexByValue(ddlPTOApprover2Role, DR.Item("PTOApprover2Role"))
            ddlTSApprover1Role.SelectedIndex = Common.GetIndexByValue(ddlTSApprover1Role, DR.Item("TSApprover1Role"))
            ddlTSApprover2Role.SelectedIndex = Common.GetIndexByValue(ddlTSApprover2Role, DR.Item("TSApprover2Role"))
            ddlOrderItem.SelectedIndex = Common.GetIndexByValue(ddlOrderItem, DR.Item("TaskOrderItem"))
            ' If Approvals have been set, then they cant be reset as this will cause data corruption,
            ' Changes must be made by developers
            ddlPTOApprovals.Enabled = False
            ddlTSApprovals.Enabled = False
            ddlPTOApprover1Role.Enabled = False
            ddlPTOApprover2Role.Enabled = False
            ddlTSApprover1Role.Enabled = False
            ddlTSApprover2Role.Enabled = False

            If DR.Item("UseWindowsAuthentication") = False Then
                ddlAuthenticateMethod.SelectedIndex = Common.GetIndexByValue(ddlAuthenticateMethod, "0")
            Else
                ddlAuthenticateMethod.SelectedIndex = Common.GetIndexByValue(ddlAuthenticateMethod, "1")
            End If

            chkEnabled.Checked = DR.Item("ForceTSComments")

            'If DR.Item("WeeklyReminderMeridian") = False Then
            'ddlMeridian.SelectedIndex = Common.GetIndexByText(ddlMeridian, "AM")
            'Else
            'ddlMeridian.SelectedIndex = Common.GetIndexByText(ddlMeridian, "PM")
            'End If
        chkWeeklyReminder.Checked = DR.Item("WeeklyReminderEnabled")
        'ddlTime.SelectedIndex = Common.GetIndexByValue(ddlTime, DR.Item("WeeklyReminderHour"))
            ddlDow.SelectedIndex = Common.GetIndexByValue(ddlDow, DR.Item("WeeklyReminderDOW"))
        ddlWeekStartDay.SelectedIndex = Common.GetIndexByValue(ddlWeekStartDay, DR.Item("WeekStartDay"))
        txtMonthReminder.Text = DR.Item("MonthlyReminderDay")
        End If
        DR.Close()

        If ddlPTOApprovals.SelectedValue = 1 Then
            divPTOApprover.Style.Item("Display") = "none"
        Else
            divPTOApprover.Style.Item("Display") = "block"
        End If

        If ddlTSApprovals.SelectedValue = 1 Then
            divTSApprover.Style.Item("Display") = "none"
        Else
            divTSApprover.Style.Item("Display") = "block"
        End If
    End Function

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim arParms() As SqlParameter = New SqlParameter(15) {}
        arParms(0) = New SqlParameter("@PTOApprovals", ddlPTOApprovals.SelectedValue)
        arParms(1) = New SqlParameter("@TSApprovals", ddlTSApprovals.SelectedValue)
        arParms(2) = New SqlParameter("@PTOApprover1Role", ddlPTOApprover1Role.SelectedValue)
        arParms(3) = New SqlParameter("@PTOApprover2Role", ddlPTOApprover2Role.SelectedValue)
        arParms(4) = New SqlParameter("@TSApprover1Role", ddlTSApprover1Role.SelectedValue)
        arParms(5) = New SqlParameter("@TSApprover2Role", ddlTSApprover2Role.SelectedValue)
        If chkEnabled.Checked = True Then
            arParms(6) = New SqlParameter("@ForceTSComments", "1")
        Else
            arParms(6) = New SqlParameter("@ForceTSComments", "0")
        End If
        arParms(7) = New SqlParameter("@TaskOrderItem", ddlOrderItem.SelectedValue)
        arParms(8) = New SqlParameter("@UseWindowsAuthentication", ddlAuthenticateMethod.SelectedItem.Value)
        arParms(9) = New SqlParameter("@MonthlyReminderDay", Request.Form("txtMonthReminder"))
        arParms(10) = New SqlParameter("@WeeklyReminderMeridian", 0) 'ddlMeridian.SelectedValue) 'SD: 25/10/2005 - No longer need the time so just save null
        arParms(11) = New SqlParameter("@WeeklyReminderHour", 0)  'ddlTime.SelectedValue)  
        arParms(12) = New SqlParameter("@WeeklyReminderDOW", ddlDOW.SelectedValue)
        If chkWeeklyReminder.Checked = True Then
            arParms(13) = New SqlParameter("@WeeklyReminderEnabled", "1")
        Else
            arParms(13) = New SqlParameter("@WeeklyReminderEnabled", "0")
        End If
        arParms(14) = New SqlParameter("@WeekStartDay", ddlWeekStartDay.SelectedValue)
        arParms(15) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
        arParms(15).Direction = ParameterDirection.Output

        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_UpdateSystem", arParms)
        strErr = arParms(15).Value
        Select Case strErr
            Case 0 ' No Errors
                ' Existing Record Updated
                lblmessage.Text = "The <b>System Admin</b> file has been updated"
        End Select
    End Sub

#End Region

End Class
