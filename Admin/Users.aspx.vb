Public Class Users
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents cbxusers As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btngo As System.Web.UI.WebControls.Button
    Protected WithEvents txtFirst As System.Web.UI.WebControls.TextBox
    Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtLast As System.Web.UI.WebControls.TextBox
    Protected WithEvents RequiredFieldValidator2 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtInitials As System.Web.UI.WebControls.TextBox
    Protected WithEvents Requiredfieldvalidator6 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtEmail As System.Web.UI.WebControls.TextBox
    Protected WithEvents RegularExpressionValidator1 As System.Web.UI.WebControls.RegularExpressionValidator
    Protected WithEvents RequiredFieldValidator8 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtPhone As System.Web.UI.WebControls.TextBox
    Protected WithEvents RequiredFieldValidator3 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ddlUnit As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Requiredfieldvalidator5 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtSMS As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPosition As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtRate As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtUserName As System.Web.UI.WebControls.TextBox
    Protected WithEvents RequiredFieldValidator4 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtpass1 As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtpass2 As System.Web.UI.WebControls.TextBox
    Protected WithEvents cbxRole As System.Web.UI.WebControls.DropDownList
    Protected WithEvents RequiredFieldValidator7 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents lblcurrpass As System.Web.UI.WebControls.Label
    Protected WithEvents chkEnabled As System.Web.UI.WebControls.CheckBox
    Protected WithEvents txtduplicate As System.Web.UI.WebControls.TextBox
    Protected WithEvents CustomValidator1 As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents txtuserid As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtpostback As System.Web.UI.WebControls.TextBox
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents hidetext As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents hideCurrpass As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents txtVal As System.Web.UI.WebControls.TextBox
    Protected WithEvents tblDynAdd As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents chkDelete As System.Web.UI.WebControls.CheckBox
    Protected WithEvents dlUserRates As System.Web.UI.WebControls.DataList
    Protected WithEvents ddlCostCentre_ As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtrate_ As Intermap.Controls.IMTextBox
    Protected WithEvents itemPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents itemLoadCount As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents cvCostCentre As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents txtEmployeeCode As System.Web.UI.WebControls.TextBox

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
    Dim en As New System.Globalization.CultureInfo("en-Au")

    ' Required for Errorhandling
    Protected WithEvents ucHeader As TimeTrax.header
    Dim strStatus As String
    Dim strErr As String
    Dim strMess As String

#End Region

#Region " PAGE DECLARES "
    Dim i As Int16
    Dim strValue As String
    Dim hidBoxitem As HtmlInputHidden
    Dim ItemNo, ItemID As String
    Dim a, NoRows As Integer
    Dim arrData As Array

#End Region

#Region " PAGE LOAD "

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "10"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        hidetext.Visible = False
        If Not IsPostBack Then
            ' FIRST PAGE LOAD DISPLAY SELECT USER DROPLIST
            Session("PageType") = "Admin"
            Session("Page") = "Users"
            Session("PageTitle") = Session("AppName") & " - Administration (Manage Users)"
            LoadUserDropdowns()

            tblwizard1.Visible = True
            tblwizard2.Visible = False
            btnSubmit.Visible = False
            tblwizard3.Visible = False
            txtpostback.Text = "0"
        Else
            If txtpostback.Text = "1" Then
                'Details have been loaded go into messages window
                tblwizard1.Visible = False
                tblwizard2.Visible = False
                btnSubmit.Visible = False
                tblwizard3.Visible = True
                txtpostback.Text = "2"
            Else
                'Go into details section
                'LoadBUnitDropdowns()
                'LoadRoleDropdowns()
                LoadCostCentreDropdowns()
                txtpostback.Text = "1"
                txtuserid.Text = cbxusers.SelectedItem.Value
                If cbxusers.SelectedItem.Value <> "0" Then
                    'existing user
                    LoadUserDetails()
                    ' ucHeader.LitText = "<script language=javascript>loadRates();</script>"
                    hidetext.Visible = True
                    hideCurrpass.Visible = True
                Else
                    'add new user
                    txtFirst.Text = ""
                    txtLast.Text = ""
                    txtEmail.Text = ""
                    txtPhone.Text = ""
                    txtSMS.Text = ""
                    txtPosition.Text = ""
                    txtUserName.Text = ""
                    txtpass1.Text = ""
                    txtpass2.Text = ""
                    itemLoadCount.Value = 0
                    chkEnabled.Checked = True
                    hidetext.Visible = False
                    hideCurrpass.Visible = False
                End If
                tblwizard1.Visible = False
                tblwizard2.Visible = True
                btnSubmit.Visible = True
                tblwizard3.Visible = False
            End If
        End If
    End Sub

    Function LoadUserDropdowns()
        Dim DS As DataSet = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "Usr_UserDropDowns")

        'Populate the users dropdown
        cbxusers.Items.Clear()
        cbxusers.DataSource = DS.Tables(0)
        cbxusers.DataBind()
        cbxusers.Items.Insert(0, "New User")
        cbxusers.SelectedItem.Value = "0"

        'Populate the roles dropdown
        ddlUnit.Items.Clear()
        ddlUnit.DataSource = DS.Tables(2)
        ddlUnit.DataBind()
        ddlUnit.Items.Insert(0, "Select ...")

        'Populate the roles dropdown
        cbxRole.Items.Clear()
        cbxRole.DataSource = DS.Tables(1)
        cbxRole.DataBind()
        cbxRole.Items.Insert(0, "Select ...")


    End Function

    'Function LoadBUnitDropdowns()
    '  Dim DS As DataSet = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "Usr_UserDropDowns")

    '  'Populate the roles dropdown
    '  ddlUnit.Items.Clear()
    '  ddlUnit.DataSource = DS.Tables(2)
    '  ddlUnit.DataBind()
    '  ddlUnit.Items.Insert(0, "Select ...")

    'End Function

    'Function LoadRoleDropdowns()
    '  Dim DS As DataSet = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "Usr_UserDropDowns")

    '  'Populate the roles dropdown
    '  cbxRole.Items.Clear()
    '  cbxRole.DataSource = DS.Tables(1)
    '  cbxRole.DataBind()
    '  cbxRole.Items.Insert(0, "Select ...")

    'End Function

    Function LoadCostCentreDropdowns()

        ddlCostCentre_.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCostCentre")
        ddlCostCentre_.DataBind()
        ddlCostCentre_.Items.Insert(0, "Select ...")

    End Function

    Function LoadUserDetails()
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@UserID", txtuserid.Text)
        Try
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "Usr_LoadUserDetails", arParms)
        Catch ex As SqlException
            lblmessage.Text = "<b>Error(" & ex.Number & ")</b> " & ex.Message
            tblwizard3.Visible = True
        End Try

        Do While DR.Read
            txtFirst.Text = DR.Item("FirstName")
            txtLast.Text = DR.Item("LastName")
            txtInitials.Text = DR.Item("Initials")
            lblcurrpass.Text = DR.Item("Password")
            If IsDBNull(DR.Item("eMail")) Then
                txtEmail.Text = ""
            Else
                txtEmail.Text = DR.Item("eMail")
            End If
            If IsDBNull(DR.Item("TelNo")) Then
                txtPhone.Text = ""
            Else
                txtPhone.Text = DR.Item("TelNo")
            End If
            If IsDBNull(DR.Item("SMSNo")) Then
                txtSMS.Text = ""
            Else
                txtSMS.Text = DR.Item("SMSNo")
            End If
            If IsDBNull(DR.Item("Position")) Then
                txtPosition.Text = ""
            Else
                txtPosition.Text = DR.Item("Position")
            End If
            If IsDBNull(DR.Item("EmployeeCode")) Then
                txtEmployeeCode.Text = ""
            Else
                txtEmployeeCode.Text = DR.Item("EmployeeCode")
            End If
           
            txtUserName.Text = DR.Item("UserName")
            txtpass1.Text = ""
            txtpass2.Text = ""
            ddlUnit.SelectedItem.Value = DR.Item("UnitID")
            ddlUnit.SelectedItem.Text = DR.Item("UnitName")
            cbxRole.SelectedItem.Value = DR.Item("GroupID")
            cbxRole.SelectedItem.Text = DR.Item("Descript")

            If DR.Item("Enabled") = "1" Then
                chkEnabled.Checked = True
            Else
                chkEnabled.Checked = False
            End If
            txtuserid.Text = DR.Item("UserID")
        Loop
        DR.Close()

        'dlUserRates.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_AdminSelectUserRates", arParms)
        'dlUserRates.DataBind()
        DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_AdminSelectUserRates", arParms)
        i = 0
        While DR.Read()
            ' add to dynamic add
            i = i + 1
            hidBoxitem = New HtmlInputHidden
            hidBoxitem.ID = "hidBoxitem_" & i
            strValue = DR.Item("RateID")
            'SD: 19/10/2005 - Change dymanic adds from , to #
            strValue &= "#" & DR.Item("UserID")
            strValue &= "#" & DR.Item("CostCentreID")
            strValue &= "#" & DR.Item("Rate")
            hidBoxitem.Value = strValue
            itemPlace.Controls.Add(hidBoxitem)
        End While
        itemLoadCount.Value = i

        DR.Close()


    End Function

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim arParms() As SqlParameter = New SqlParameter(14) {}
        arParms(0) = New SqlParameter("@UserID", txtuserid.Text)
        arParms(0).DbType = DbType.Int64
        arParms(0).Direction = ParameterDirection.InputOutput
        arParms(1) = New SqlParameter("@First", txtFirst.Text)
        arParms(2) = New SqlParameter("@Last", txtLast.Text)
        arParms(3) = New SqlParameter("@Initials", txtInitials.Text)
        arParms(4) = New SqlParameter("@Email", txtEmail.Text)
        arParms(5) = New SqlParameter("@Tel", txtPhone.Text)
        arParms(6) = New SqlParameter("@SMSNo", txtSMS.Text)
        arParms(7) = New SqlParameter("@Position", txtPosition.Text)
        arParms(8) = New SqlParameter("@UnitID", CInt(ddlUnit.SelectedItem.Value))
        arParms(9) = New SqlParameter("@username", txtUserName.Text)
        arParms(10) = New SqlParameter("@Password", txtpass1.Text)
        arParms(11) = New SqlParameter("@groupID", CInt(cbxRole.SelectedItem.Value))
        If chkEnabled.Checked = True Then
            arParms(12) = New SqlParameter("@Enabled", "1")
        Else
            arParms(12) = New SqlParameter("@Enabled", "0")
        End If
        arParms(13) = New SqlParameter("@EmployeeCode", txtEmployeeCode.Text)
        arParms(14) = New SqlParameter("@Error", SqlDbType.Int)
        arParms(14).Direction = ParameterDirection.Output

        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "Usr_AddUpdateUser", arParms)

        If arParms(13).Value.ToString() = "1" Then
            lblmessage.Text = "<b>Error</b><br><br>The username, password confirmation has already been used, You will need to go <a href=# onclick=javascript:history.back();>back</a> to try a different combination"
        Else
            If txtuserid.Text = "0" Then
                ' New User Added
                ViewState("UserID") = arParms(0).Value
                SendEmail()
                lblmessage.Text = "The user <b>" & txtFirst.Text & " " & txtLast.Text & "</b> with username <b>" & txtUserName.Text & "</b> has been added"
            Else
                ' Existing User Updated
                lblmessage.Text = "The user <b>" & txtFirst.Text & " " & txtLast.Text & "</b> with username <b>" & txtUserName.Text & "</b> has been updated"
            End If
            ProcessUserRates()
        End If

    End Sub
    Private Sub ProcessUserRates()

        'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        'Process Dynamic add items
        'Loop through all the  added rows
        a = 0
        NoRows = 0

        ItemNo = ""
        ItemNo = Request.Form("item_list")

        If ItemNo <> "" And ItemNo <> "#" Then              'SD: 19/10/2005 - Change dymanic adds from , to #
            Try
                Dim RowArray As Array = ItemNo.Split("#")   'SD: 19/10/2005 - Change dymanic adds from , to #
                NoRows = RowArray((RowArray.Length - 2))
            Catch
            End Try

            If NoRows < Request.Form("itemLoadCount") Then
                NoRows = Request.Form("itemLoadCount")
            End If
        Else
            ' There are no dynamic add rows, if there were items on load then these need to be deleted now
            NoRows = Request.Form("itemLoadCount")
        End If

        While a < NoRows
            a += 1

            ItemID = 0
            Dim HidBoxVal As String = Request.Form("hidBoxitem_" & a)
            If HidBoxVal <> "" Then
                arrData = HidBoxVal.Split("#")              'SD: 19/10/2005 - Change dymanic adds from , to #
                ItemID = arrData(0)
            End If

            'Write to Database
            Dim arParms2() As SqlParameter = New SqlParameter(3) {}
            arParms2(0) = New SqlParameter("@RateID", IIf(ItemID <> 0, ItemID, DBNull.Value))
            arParms2(1) = New SqlParameter("@UserID", IIf(cbxusers.SelectedValue = 0, CInt(ViewState("UserID")), cbxusers.SelectedValue))
            arParms2(2) = New SqlParameter("@CostCentreID", IIf(Request.Form("ddlCostCentre_" & a) <> 0, Request.Form("ddlCostCentre_" & a), DBNull.Value))
            arParms2(3) = New SqlParameter("@Rate", IIf(Request.Form("txtrate_" & a) <> "", Request.Form("txtrate_" & a), DBNull.Value))
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateUserRates", arParms2)
        End While
    End Sub

    Sub SendEmail()
        ' Send email when new user is added
        Dim MailTo As String
        Dim Subject As String
        Dim Priority As Mail.MailPriority = Mail.MailPriority.Normal
        Dim strBody As String

        '' Send email to Business Unit Manager for new users unit,
        'strBody = "The following user has been added to the " & ConfigurationSettings.AppSettings("ApplicationName") & " system: " & vbCrLf & "User Detail:" & vbCrLf & _
        '          "Username : " & txtUserName.Text & vbCrLf & _
        '          "Full Name: " & txtFirst.Text & ", " & txtLast.Text & vbCrLf & _
        '          "Category : " & cbxRole.SelectedItem.Text

        'Subject = "New User Added:" & txtFirst.Text & ", " & txtLast.Text & "(" & txtUserName.Text & ")"
        'WebMails.TrySendMail(WebMails.SendToType.BUManager, Subject, strBody, Mail.MailPriority.Normal, ddlUnit.SelectedItem.Value)


        ' Send email to the user that has just been added,
        strBody = "<font face=Arial size=2>You have been added as a user to the " & ConfigurationSettings.AppSettings("ApplicationName") & " system. " & vbCrLf & _
                  "<br><br>Your details as captured in the system are as follows: " & vbCrLf & _
                  "<br><br><b>Username: </b>" & txtUserName.Text & vbCrLf & _
                  "<br><b>Password: </b>" & txtpass1.Text & vbCrLf & _
                  "<br><b>Unit    : </b>" & ddlUnit.SelectedItem.Text & vbCrLf & _
                  "<br><b>Category: </b>" & cbxRole.SelectedItem.Text & vbCrLf & _
                  "<br><br>You may access the system via your internet browser (Internet Explorer 5.5 or later or a compatible substitute) " & _
                  "at the following url: " & ConfigurationSettings.AppSettings("WebAddress") & "</font>"
        Subject = "You have been added as a user"
        WebMails.TrySendMail(txtEmail.Text, Subject, strBody, Mail.MailPriority.Normal, "")

    End Sub

#End Region

End Class
