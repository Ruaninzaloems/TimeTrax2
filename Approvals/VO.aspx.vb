Public Class VO
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents chkApprove2 As System.Web.UI.WebControls.CheckBox
    Protected WithEvents chkApprove1 As System.Web.UI.WebControls.CheckBox
    Protected WithEvents btnApprove As System.Web.UI.WebControls.Button
    Protected WithEvents btnReject As System.Web.UI.WebControls.Button
    Protected WithEvents Appovals As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents htmApprove As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents htmReject As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents txtApprove1Comment As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtApprove2Comment As System.Web.UI.WebControls.TextBox
    Protected WithEvents divApproval1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents divApproval2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents hidApproval As System.Web.UI.HtmlControls.HtmlInputHidden
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
    Dim ucProjInfo As New TimeTrax.ucProjectInfo
    Dim ucOrders As New TimeTrax.Orders
    Dim Comment As String
    Dim res As String
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        'TODO: Project Specific Role
        ' This is dependant on the users role for the project,
        ' Not the users application role!
        ' Dim Role As String = "5"
        ' UserLogin.CheckUserAccess(Role, Context.Current)

        If Not IsPostBack Then
            Session("PageType") = "Approval"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Approval (Variation Order)"
            ViewState("ProjectID") = Request.QueryString("ProjID")
            hidProjID.Value = Request.QueryString("ProjID")
            ucProjInfo.ProjectID = ViewState("ProjectID")
            ucProjInfo.blnShowSummaries = True
            LoadPageData()
        End If
    End Sub

    Private Sub LoadPageData()
        ' Final Approval
        divApproval1.Attributes.Add("style", "DISPLAY: none")
        ' First Approval
        divApproval2.Attributes.Add("style", "DISPLAY: none")
        LoadSystemData()
        LoadApproverRoles()
        LoadProjectData()

        If User.Identity.Name <> ViewState("Approver2UserID") And User.Identity.Name <> ViewState("Approver1UserID") Then
            ' Current User is not an Approver for this project so page cannot be updated
            htmApprove.Disabled = True
            htmReject.Disabled = True
            btnUpload.Disabled = True
            ShowRelevantSections()
            If chkApprove1.Checked = False And chkApprove2.Checked = False Then
                'No Approvals have been processed yet
                'ucHeader.LitText = "<script language='javascript'>alert('No Approvals have been processed yet');</script>"
            End If
        Else
            If User.Identity.Name = ViewState("Approver2UserID") Then
                ' User is the First Approver so
                ' set the hidden field containing wich approval is being done (used by PTOReject js function)
                hidApproval.Value = 2
                ' Disable the Final Approval section (Display Only)
                chkApprove1.Enabled = False
                txtApprove1Comment.Enabled = False
                txtApprove1Comment.ReadOnly = True
                ShowRelevantSections()
            Else
                ' User is the Final Approver so 
                ' set the hidden field containing wich approval is being done (used by PTOReject js function)
                hidApproval.Value = 1
                ' Disable the First Approval section (Display Only)
                chkApprove2.Enabled = False
                txtApprove2Comment.Enabled = False
                txtApprove2Comment.ReadOnly = True
                If ViewState("PTOApprovals") > 1 Then
                    ' If First Approval does not exist then disable Final Approval Section as Final Approval
                    ' Cannot occur before First Approval if this is a multi stage approval
                    If chkApprove2.Enabled = False Then
                        chkApprove1.Enabled = False
                        txtApprove1Comment.Enabled = False
                        txtApprove1Comment.ReadOnly = True
                    End If
                End If
                ShowRelevantSections()
            End If
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

    Private Sub LoadApproverRoles()
        Dim count As Integer
        Dim arParm2() As SqlParameter = New SqlParameter(0) {}
        For count = 1 To ViewState("PTOApprovals")
            ' Get the relevant Approver role from the system
            arParm2(0) = New SqlParameter("@RoleID", count)
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectPTOApprover" & count & "Role")
            If DR.Read() Then
                Select Case count
                    Case 1
                        ' Final Stage PTO Approvals
                        chkApprove1.Text = "Approved By " & DR.Item("RoleName")
                    Case 2
                        ' First Stage PTO Approvals
                        chkApprove2.Text = "Approved By " & DR.Item("RoleName")
                End Select
            End If
        Next
        DR.Close()
    End Sub

    Private Sub ShowRelevantSections()
        ' Determine which Approval sections to display
        If ViewState("PTOApprovals") > 1 Then
            ' 2 Stage Approval process
            ' Check if First Stage approval has been done
            If chkApprove2.Checked = True Then
                ' First Approval has been done
                divApproval2.Attributes.Add("style", "DISPLAY: block")
                If User.Identity.Name = ViewState("Approver1UserID") Then
                    ' If the current user is the Final Approver
                    divApproval1.Attributes.Add("style", "DISPLAY: block")
                End If
            Else
                ' First Approval has not been done
                ' Show First Approval section
                divApproval2.Attributes.Add("style", "DISPLAY: block")
                ' Hide Final Approval section
                divApproval1.Attributes.Add("style", "DISPLAY: none")
            End If
        Else
            ' 1 Stage Approval (Final Approver Only)
            divApproval1.Attributes.Add("style", "DISPLAY: block")
        End If
    End Sub

    Private Sub LoadProjectData()
        DR = DAL.LoadProjectDetails(ViewState("ProjectID"))
        If DR.Read Then
            ViewState("ProjectCode") = DR.Item("ProjectCode")
            ViewState("ProjectName") = DR.Item("ProjectName")
        End If

        DR.NextResult()
        LoadProjectApprovers()
        DR.Close()

        LoadProjectApprovals()

        LoadProjectOrder()

    End Sub

    Private Sub LoadProjectApprovers()

        While DR.Read
            If Not IsDBNull(DR.Item("FirstApprover")) Then
                ' This resource is Approver2
                ViewState("Approver2UserID") = DR.Item("UserID")
            End If
            If Not IsDBNull(DR.Item("LastApprover")) Then
                ' This resource is Approver1
                ViewState("Approver1UserID") = DR.Item("UserID")
            End If
            If Not IsDBNull(DR.Item("TeamLeader")) Then
                ' This resource is the Team Leader
                ViewState("TeamLeaderUserID") = DR.Item("UserID")
            End If
        End While

    End Sub
    Private Sub LoadProjectApprovals()

        chkApprove1.Checked = False
        chkApprove2.Checked = False
        Dim arParms2() As SqlParameter = New SqlParameter(1) {}
        arParms2(0) = New SqlParameter("@ApprovalItemID", ViewState("ProjectID"))
        arParms2(1) = New SqlParameter("@ApprovalType", "4")

        DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectApprovals", arParms2)
        While DR.Read()
            If DR.Item("ApproverID") = ViewState("Approver2UserID") Then
                ' Final Approver Approval
                If DR.Item("Approved") = 1 Then
                    chkApprove2.Checked = True
                End If
                If Not IsDBNull(DR.Item("Comment")) Then
                    txtApprove2Comment.Text = DR.Item("Comment")
                Else
                    txtApprove2Comment.Text = ""
                End If
            End If
            If DR.Item("ApproverID") = ViewState("Approver1UserID") Then
                ' First Approver Approval
                If DR.Item("Approved") = 1 Then
                    chkApprove1.Checked = True
                End If
                If Not IsDBNull(DR.Item("Comment")) Then
                    txtApprove1Comment.Text = DR.Item("Comment")
                Else
                    txtApprove1Comment.Text = ""
                End If
            End If
        End While

    End Sub
    Private Sub LoadProjectOrder()
        'Dim arParms() As SqlParameter = New SqlParameter(0) {}
        'arParms(0) = New SqlParameter("@ProjID", ViewState("ProjectID"))
        DR = DAL.LoadCurrentProjectOrder(ViewState("ProjectID"), 0) 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectProjectCurrentOrder", arParms)
        ' Get The Project Orders
        If DR.Read Then
            ' Needed for Orders User Control
            ViewState("OrderID") = DR.Item("OrderID")
            ViewState("EndDate") = DR.Item("txtEnd")
        End If

        DR.Close()

        ucOrders.OrderID = ViewState("OrderID")
        ucOrders.blnReadOnly = True
    End Sub

#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnApprove_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        ' Write Approval Details to DB
        WriteApprovalToDb(1)
        ' If this was the final approval then change the Project Status
        If User.Identity.Name = ViewState("Approver1UserID") Then
            Common.ChangeProjectStatus(ViewState("ProjectID"), 3)
            ' Set the Order Approval Flag
            DAL.ChangeOrderStage(ViewState("OrderID"), 2)
            'Update the Project EndDate
            DAL.ChangeProjectEndDate(ViewState("ProjectID"), ViewState("EndDate"))
        Else
            ' Set the Order Approval Flag
            DAL.ChangeOrderStage(ViewState("OrderID"), 1)
            BuildAndSendEmail(ViewState("Approver1UserID"), "Approve")
        End If
        ' Goto Start Page if no Errors
        Response.Redirect(Request.ApplicationPath & "/default.aspx")
    End Sub

    Private Sub btnReject_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnReject.Click
        ' Write Approval Details to DB
        WriteApprovalToDb(0)
        ' Email Project Leader
        BuildAndSendEmail(ViewState("TeamLeaderUserID"), "Reject")
        ' Change the Project Status to In Progress
        Common.ChangeProjectStatus(ViewState("ProjectID"), 3)
        ' Goto Start Page if no Errors
        Response.Redirect(Request.ApplicationPath & "/default.aspx")
    End Sub

    Private Sub WriteApprovalToDb(ByVal Approval As Int16)
        If User.Identity.Name = ViewState("Approver2UserID") Then
            Comment = Request.Form("txtApprove2Comment")
        Else
            Comment = Request.Form("txtApprove1Comment")
        End If
        DAL.InsertApproval(Common.ApprovalType.VariationOrder, User.Identity.Name, ViewState("ProjectID"), Comment, Approval)

    End Sub

    Private Sub BuildAndSendEmail(ByVal UserID As Integer, ByVal Type As String)
        Dim MailTo As String
        Dim Subject As String
        Dim Priority As Mail.MailPriority = Mail.MailPriority.Normal
        Dim strBody As String
        MailTo = Common.GetEmailForUser(UserID)
        If MailTo <> "" Then
            Select Case Type
                Case "Reject"
                    ' Send email to Team Leader to notify Variation Order has been rejected
                    strBody = "<font face=Arial size=2>The Variation Order has been rejected for:" & vbCrLf & _
                              "<br><br><b>Project: </b>" & ViewState("ProjectCode") & " - " & ViewState("ProjectName") & vbCrLf & _
                              "<br><b>Rejected By: </b>" & Request.Cookies("User").Values("FullName") & vbCrLf & _
                              "<br><b>Comment: </b>" & Comment & "</font>"
                    Subject = "Variation Order Rejected"
                Case "Approve"
                    ' Send email when project Submitted for approval
                    strBody = "<font face=Arial size=2>The following project has a Variation Order waiting for your approval: " & vbCrLf & _
                              "<br><br><b>Project Code: </b>" & ViewState("ProjectCode") & vbCrLf & _
                              "<br><b>Project  Name: </b>" & ViewState("ProjectName") & "</font>"

                    Subject = "Variation Order Awaiting Approval:" & ViewState("ProjectCode") & " - " & ViewState("ProjectName")
            End Select
            WebMails.TrySendMail(MailTo, Subject, strBody, Mail.MailPriority.Normal, "")
        End If
    End Sub

#End Region

End Class
