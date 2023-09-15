Public Class Clients
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlClient As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btngo As System.Web.UI.WebControls.Button
    Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvName As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtCode As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvCode As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtPhyAdd As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPosAdd As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPhySuburb As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPosSuburb As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPhyCity As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPosCity As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPhyProvince As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPosProvince As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPosCode As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvPosCode As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ddlCountry As System.Web.UI.WebControls.DropDownList
    Protected WithEvents rfvCountry As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents chkEnabled As System.Web.UI.WebControls.CheckBox
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents txtrecid As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtpostback As System.Web.UI.WebControls.TextBox
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents rfvPosAdd As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents rfvPosSuburb As System.Web.UI.WebControls.RequiredFieldValidator

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
        Dim Role As String = "16"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then

            ' FIRST PAGE LOAD DISPLAY SELECT DROPLIST
            Session("PageType") = "Admin"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Administration (Manage Clients)"
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
                txtrecid.Text = ddlClient.SelectedItem.Value
                If ddlClient.SelectedItem.Value <> "0" Then
                    'existing user
                    LoadDetails()
                Else
                    'add new user
                    txtName.Text = ""
                    txtCode.Text = ""
                    txtPhyAdd.Text = ""
                    txtPhySuburb.Text = ""
                    txtPhyCity.Text = ""
                    txtPhyProvince.Text = ""
                    txtPosAdd.Text = ""
                    txtPosSuburb.Text = ""
                    txtPosCity.Text = ""
                    txtPosProvince.Text = ""
                    txtPosCode.Text = ""
                End If
                tblwizard1.Visible = False
                tblwizard2.Visible = True
                tblwizard3.Visible = False
            End If
        End If
    End Sub

    Private Sub LoadSelectDropdown()
        ddlClient.DataSource = DAL.LoadClients(1) 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_AdminSelectClient")
        ddlClient.DataBind()
        ddlClient.Items.Insert(0, "New")
        ddlClient.SelectedItem.Value = "0"
    End Sub

    Private Sub LoadDropDowns()
        ddlCountry.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCountry")
        ddlCountry.DataBind()
        ddlCountry.Items.Insert(0, "Select ...")

    End Sub

    Sub LoadDetails()
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@CLientID", txtrecid.Text)
        Try
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectClientInfo", arParms)
        Catch ex As SqlException
            lblmessage.Text = "<b>Error(" & ex.Number & ")</b> " & ex.Message
            tblwizard3.Visible = True
        End Try

        Do While DR.Read
            txtName.Text = DR.Item("ClientName")
            txtCode.Text = DR.Item("ClientCode")
            If IsDBNull(DR.Item("PhyAddress")) Then
                txtPhyAdd.Text = ""
            Else
                txtPhyAdd.Text = DR.Item("PhyAddress")
            End If
            If IsDBNull(DR.Item("PhySuburb")) Then
                txtPhySuburb.Text = ""
            Else
                txtPhySuburb.Text = DR.Item("PhySuburb")
            End If
            If IsDBNull(DR.Item("PhyCity")) Then
                txtPhyCity.Text = ""
            Else
                txtPhyCity.Text = DR.Item("PhyCity")
            End If
            If IsDBNull(DR.Item("PhyProvince")) Then
                txtPhyProvince.Text = ""
            Else
                txtPhyProvince.Text = DR.Item("PhyProvince")
            End If
            txtPosAdd.Text = DR.Item("PostAddress")
            txtPosSuburb.Text = DR.Item("PostSuburb")
            If IsDBNull(DR.Item("PostCity")) Then
                txtPosCity.Text = ""
            Else
                txtPosCity.Text = DR.Item("PostCity")
            End If
            If IsDBNull(DR.Item("PostProvince")) Then
                txtPosProvince.Text = ""
            Else
                txtPosProvince.Text = DR.Item("PostProvince")
            End If
            txtPosCode.Text = DR.Item("PostCode")
            If DR.Item("Enabled") = "1" Then
                chkEnabled.Checked = True
            Else
                chkEnabled.Checked = False
            End If
            ddlCountry.SelectedIndex = ddlCountry.Items.IndexOf(ddlCountry.Items.FindByText(DR.Item("CountryName")))
            txtrecid.Text = DR.Item("ClientID")
        Loop
        DR.Close()
    End Sub

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim ClientCode As String = DAL.GenerateClientCode()
        Dim arParms() As SqlParameter = New SqlParameter(14) {}
        arParms(0) = New SqlParameter("@ClientID", txtrecid.Text)
        arParms(1) = New SqlParameter("@Name", txtName.Text)
        arParms(2) = New SqlParameter("@Code", ClientCode)
        arParms(3) = New SqlParameter("@PhyAddress", IIf(txtPhyAdd.Text <> "", txtPhyAdd.Text, DBNull.Value))
        arParms(4) = New SqlParameter("@PosAddress", IIf(txtPosAdd.Text <> "", txtPosAdd.Text, DBNull.Value))
        arParms(5) = New SqlParameter("@PhySuburb", IIf(txtPhySuburb.Text <> "", txtPhySuburb.Text, DBNull.Value))
        arParms(6) = New SqlParameter("@PosSuburb", IIf(txtPosSuburb.Text <> "", txtPosSuburb.Text, DBNull.Value))
        arParms(7) = New SqlParameter("@PhyCity", IIf(txtPhyCity.Text <> "", txtPhyCity.Text, DBNull.Value))
        arParms(8) = New SqlParameter("@PosCity", IIf(txtPosCity.Text <> "", txtPosCity.Text, DBNull.Value))
        arParms(9) = New SqlParameter("@PhyProvince", IIf(txtPhyProvince.Text <> "", txtPhyProvince.Text, DBNull.Value))
        arParms(10) = New SqlParameter("@PosProvince", IIf(txtPosProvince.Text <> "", txtPosProvince.Text, DBNull.Value))
        arParms(11) = New SqlParameter("@PosCode", IIf(txtPosCode.Text <> "", txtPosCode.Text, DBNull.Value))
        arParms(12) = New SqlParameter("@CountryID", ddlCountry.SelectedValue)
        If chkEnabled.Checked = True Then
            arParms(13) = New SqlParameter("@Enabled", "1")
        Else
            arParms(13) = New SqlParameter("@Enabled", "0")
        End If
        arParms(14) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
        arParms(14).Direction = ParameterDirection.Output

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateClient", arParms)
            strErr = arParms(14).Value
        Catch ex As SqlException
            strErr = ex.Number
            strMess = ex.Message
        End Try
        Select Case strErr
            Case 0 ' No Errors
                If txtrecid.Text = "0" Then
                    ' New Record Added
                    lblmessage.Text = "The Client <b>" & txtCode.Text & " - " & txtName.Text & "</b> has been added"
                Else
                    ' Existing Record Updated
                    lblmessage.Text = "The Client <b>" & txtCode.Text & " - " & txtName.Text & "</b> has been updated"
                End If
            Case Else
                lblmessage.Text = "<b>Error(" + strErr + ")</b> - <br><br>" + strMess + ", You will need to go <a href=# onclick=javascript:history.back();>back</a> to try again"
        End Select

    End Sub

#End Region

End Class
