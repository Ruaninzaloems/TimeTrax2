Public Class ChangeTeamleader
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlTeamLeader As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btnSubmit As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents Button1 As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents txtTeamLeader As Intermap.Controls.IMTextBox
    Protected WithEvents hidAppPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidCostCentreID As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents rfvTeamLeader As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents lblTableCaption As System.Web.UI.WebControls.Label
    Protected WithEvents lblCaption As System.Web.UI.WebControls.Label

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
    Private m_intProjectID As Integer
    Private m_strCaption As String
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to change the team leader
        Dim Role As String = "61"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        m_intProjectID = Request.QueryString("ProjectID")
        hidAppPath.Value = Request.ApplicationPath

        'SD: 03/02/2010 - Set whether this is a change teamleader or change manager function
        If Request.QueryString("blnTeamLeader") = "1" Then
            m_strCaption = "Team Leader"
        Else
            m_strCaption = "Manager"
        End If

        lblCaption.Text = m_strCaption
        lblTableCaption.Text = m_strCaption

        If Not IsPostBack Then
            LoadDropDownList()
            LoadCostCentre()
        End If
    End Sub

    Private Sub LoadDropDownList()

        'SD: 03/02/2010 - Load either the list of teamleaders or the list of managers
        If Request.QueryString("blnTeamLeader") = "1" Then
            ddlTeamLeader.DataSource = DAL.LoadTimesheetApprovers(7) 'RoleID = 7 = 'Timesheet Approval Level 1 (Team Leader)'
        Else
            ddlTeamLeader.DataSource = DAL.LoadTimesheetApprovers(69) 'RoleID 69 -  Timesheet Approval Level 2 (Manager)
        End If

        ddlTeamLeader.DataBind()
        ddlTeamLeader.Items.Insert(0, New ListItem("--Select a " & m_strCaption & "--", "0"))

    End Sub

    Private Sub LoadCostCentre()

        Dim dr As SqlDataReader

        dr = DAL.LoadProjectDetails(m_intProjectID)

        While dr.Read
            hidCostCentreID.Value = dr.Item("CostCentreID")
        End While

    End Sub

#End Region

#Region "SUBMIT DETAILS "

    Private Sub btnSubmit_ServerClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.ServerClick

        Dim UserID As String = ddlTeamLeader.SelectedValue

        'SD: 03/02/2010 - Change either the teamleader or the manager 
        If Request.QueryString("blnTeamLeader") = "1" Then
            DAL.ChangeTeamLeader(m_intProjectID, UserID, txtTeamLeader.Text)
        Else
            DAL.ChangeManager(m_intProjectID, UserID, txtTeamLeader.Text)
        End If

        ' Close Change Teamleader popup window and reload calling window
        Response.Write("<script language=javascript>opener.location.reload();window.close();</script>")

    End Sub

#End Region

End Class
