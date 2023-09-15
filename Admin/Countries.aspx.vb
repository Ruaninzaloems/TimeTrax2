Public Class Countries
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlCountries As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btngo As System.Web.UI.WebControls.Button
    Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
    Protected WithEvents ddlCurrency As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents txtrecid As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtpostback As System.Web.UI.WebControls.TextBox
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents rfvName As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents rfvCurrency As System.Web.UI.WebControls.RequiredFieldValidator
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

#End Region

#Region " PAGE LOAD "

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "14"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            ' FIRST PAGE LOAD DISPLAY SELECT COUNTRY DROPLIST
            Session("PageType") = "Admin"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Administration (Manage Countries)"
            LoadCountryDropdown()

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
                LoadCurrencyDropdown()
                txtpostback.Text = "1"
                txtrecid.Text = ddlCountries.SelectedItem.Value
                If ddlCountries.SelectedItem.Value <> "0" Then
                    'existing user
                    LoadCountryDetails()
                Else
                    'add new user
                    txtName.Text = ""
                End If
                tblwizard1.Visible = False
                tblwizard2.Visible = True
                tblwizard3.Visible = False
            End If
        End If
    End Sub

    Function LoadCountryDropdown()
        ddlCountries.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCountry")
        ddlCountries.DataBind()
        ddlCountries.Items.Insert(0, "New Country")
        ddlCountries.SelectedItem.Value = "0"
    End Function

    Function LoadCurrencyDropdown()
        ddlCurrency.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCurrency")
        ddlCurrency.DataBind()
        ddlCurrency.Items.Insert(0, "Select ...")
    End Function


    Function LoadCountryDetails()
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@CountryID", txtrecid.Text)
        Try
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_AdminSelectCountry", arParms)
        Catch ex As SqlException
            lblmessage.Text = "<b>Error(" & ex.Number & ")</b> " & ex.Message
            tblwizard3.Visible = True
        End Try

        Do While DR.Read
            txtName.Text = DR.Item("CountryName")
            ddlCurrency.SelectedIndex = ddlCurrency.Items.IndexOf(ddlCurrency.Items.FindByText(DR.Item("CurrencyName")))
            txtrecid.Text = DR.Item("CountryID")
        Loop
        DR.Close()
    End Function

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim arParms() As SqlParameter = New SqlParameter(3) {}
        arParms(0) = New SqlParameter("@CountryID", txtrecid.Text)
        arParms(1) = New SqlParameter("@Name", txtName.Text)
        arParms(2) = New SqlParameter("@CurrencyID", CInt(ddlCurrency.SelectedItem.Value))
        arParms(3) = New SqlParameter("@ErrorStatus", SqlDbType.Int)
        arParms(3).Direction = ParameterDirection.Output

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateCountry", arParms)
            strErr = arParms(3).Value
        Catch ex As SqlException
            strErr = ex.Number
            strMess = ex.Message
        End Try
        Select Case strErr
            Case 0 ' No Errors
                If txtrecid.Text = "0" Then
                    ' New Record Added
                    lblmessage.Text = "The Country <b>" & txtName.Text & "</b> has been added"
                Else
                    ' Existing Record Updated
                    lblmessage.Text = "The Country <b>" & txtName.Text & "</b> has been updated"
                End If
            Case Else
                lblmessage.Text = "<b>Error(" + strErr + ")</b> - <br><br>" + strMess + ", You will need to go <a href=# onclick=javascript:history.back();>back</a> to try again"
        End Select

    End Sub

#End Region

End Class
