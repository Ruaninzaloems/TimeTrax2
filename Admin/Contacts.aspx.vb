Public Class Contacts
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlContact As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btngo As System.Web.UI.WebControls.Button
    Protected WithEvents txtTitle As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvName As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtSurname As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvSurname As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtDept As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtEmail As System.Web.UI.WebControls.TextBox
    Protected WithEvents regexEmail As System.Web.UI.WebControls.RegularExpressionValidator
    Protected WithEvents txtTel As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvTel As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtFax As System.Web.UI.WebControls.TextBox
    Protected WithEvents chkEnabled As System.Web.UI.WebControls.CheckBox
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents txtrecid As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtpostback As System.Web.UI.WebControls.TextBox
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents ddlTitle As System.Web.UI.WebControls.DropDownList

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
        Dim Role As String = "17"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            ' FIRST PAGE LOAD DISPLAY SELECT DROPLIST
            Session("PageType") = "Admin"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Administration (Manage Contacts)"
            LoadSelectDropdown()

            tblwizard1.Visible = True
            tblwizard2.Visible = False
            tblwizard3.Visible = False
            txtpostback.Text = "0"
        Else
            If txtpostback.Text = "1" Then
                'Details have been loaded go into messages window
                tblwizard1.Visible = False
                tblwizard2.Visible = False
                tblwizard3.Visible = True
                txtpostback.Text = "2"
            Else
                'Go into details section
                txtpostback.Text = "1"
                LoadDropDowns()
                txtrecid.Text = ddlContact.SelectedItem.Value
                If ddlContact.SelectedItem.Value <> "0" Then
                    'existing user
                    LoadDetails()
                Else
                    'add new user
                    txtName.Text = ""
                    txtSurname.Text = ""
                    txtDept.Text = ""
                    txtEmail.Text = ""
                    txtTel.Text = ""
                    txtFax.Text = ""
                End If
                tblwizard1.Visible = False
                tblwizard2.Visible = True
                tblwizard3.Visible = False
            End If
        End If
    End Sub

    Private Sub LoadSelectDropdown()
        ddlContact.DataSource = DAL.GetContacts(1) 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_AdminSelectContact")
        ddlContact.DataBind()
        ddlContact.Items.Insert(0, "New")
        ddlContact.SelectedItem.Value = "0"
    End Sub

    Private Sub LoadDropDowns()
        ddlTitle.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectTitle")
        ddlTitle.DataBind()
        ddlTitle.Items.Insert(0, "Select ...")

    End Sub

    Sub LoadDetails()
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@ContactID", txtrecid.Text)
        Try
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectContactInfo", arParms)
        Catch ex As SqlException
            lblmessage.Text = "<b>Error(" & ex.Number & ")</b> " & ex.Message
            tblwizard3.Visible = True
        End Try

        Do While DR.Read
            ddlTitle.SelectedIndex = ddlTitle.Items.IndexOf(ddlTitle.Items.FindByText(DR.Item("Title")))
            '      If IsDBNull(DR.Item("Title")) Then
            '      txtTitle.Text = ""
            '      Else
            '        txtTitle.Text = DR.Item("Title")
            '      End If
            txtName.Text = DR.Item("FirstName")
            txtSurname.Text = DR.Item("LastName")
            If IsDBNull(DR.Item("Department")) Then
                txtDept.Text = ""
            Else
                txtDept.Text = DR.Item("Department")
            End If
            If IsDBNull(DR.Item("Email")) Then
                txtEmail.Text = ""
            Else
                txtEmail.Text = DR.Item("Email")
            End If
            txtTel.Text = DR.Item("Phone")
            If IsDBNull(DR.Item("Fax")) Then
                txtFax.Text = ""
            Else
                txtFax.Text = DR.Item("Fax")
            End If
            If DR.Item("Enabled") = "1" Then
                chkEnabled.Checked = True
            Else
                chkEnabled.Checked = False
            End If
            txtrecid.Text = DR.Item("ContactID")
        Loop
        DR.Close()
    End Sub

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        If Page.IsValid Then
            ' Write Client to DB
            'strErr = DAL.AddUpdateContact(IIf(ddlTitle.SelectedIndex = 0, "", ddlTitle.SelectedItem.Text), txtName.Text, txtSurname.Text, IIf(txtDept.Text <> "", txtDept.Text, DBNull.Value), txtTel.Text, IIf(txtEmail.Text <> "", txtEmail.Text, DBNull.Value), IIf(txtFax.Text <> "", txtFax.Text, DBNull.Value), IIf(chkEnabled.Checked = True, "1", "0"), txtrecid.Text)
            Dim arParms() As SqlParameter = New SqlParameter(9) {}
            arParms(0) = New SqlParameter("@Title", IIf(ddlTitle.SelectedIndex = 0, "", ddlTitle.SelectedItem.Text))
            arParms(1) = New SqlParameter("@Name", txtName.Text)
            arParms(2) = New SqlParameter("@LastName", txtSurname.Text)
            arParms(3) = New SqlParameter("@Department", IIf(txtDept.Text <> "", txtDept.Text, DBNull.Value))
            arParms(4) = New SqlParameter("@TelNo", txtTel.Text)
            arParms(5) = New SqlParameter("@Email", IIf(txtEmail.Text <> "", txtEmail.Text, DBNull.Value))
            arParms(6) = New SqlParameter("@Fax", IIf(txtFax.Text <> "", txtFax.Text, DBNull.Value))
            If chkEnabled.Checked = True Then
                arParms(7) = New SqlParameter("@Enabled", "1")
            Else
                arParms(7) = New SqlParameter("@Enabled", "0")
            End If
            arParms(8) = New SqlParameter("@ContactID", txtrecid.Text) ' Output
            arParms(8).SqlDbType = SqlDbType.Int
            arParms(8).Direction = ParameterDirection.InputOutput
            arParms(9) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
            arParms(9).Direction = ParameterDirection.Output

            Try
                SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateContact", arParms)
                strErr = arParms(9).Value
            Catch ex As SqlException
                strErr = ex.Number
                strMess = ex.Message
            End Try
            Select Case strErr
                Case 0 ' No Errors
                    If txtrecid.Text = "0" Then
                        ' New Record Added
                        lblmessage.Text = "The Contact <b>" & txtName.Text & " - " & txtSurname.Text & "</b> has been added"
                    Else
                        ' Existing Record Updated
                        lblmessage.Text = "The Contact <b>" & txtName.Text & " - " & txtSurname.Text & "</b> has been updated"
                    End If
                Case Else
                    lblmessage.Text = "<b>Error(" + strErr + ")</b> - <br><br>" + strMess + ", You will need to go <a href=# onclick=javascript:history.back();>back</a> to try again"
            End Select
        End If

    End Sub

#End Region

End Class
