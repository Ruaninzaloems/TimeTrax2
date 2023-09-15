Public Class Currencies
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlCurrency As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btngo As System.Web.UI.WebControls.Button
    Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvName As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtSymbol As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvSymbol As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtExchange As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents txtrecid As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtpostback As System.Web.UI.WebControls.TextBox
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl

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
        Dim Role As String = "22"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            ' FIRST PAGE LOAD DISPLAY SELECT DROPLIST
            Session("PageType") = "Admin"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Administration (Manage Currencies)"
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
                txtrecid.Text = ddlCurrency.SelectedItem.Value
                If ddlCurrency.SelectedItem.Value <> "0" Then
                    'existing user
                    LoadDetails()
                Else
                    'add new user
                    txtName.Text = ""
                    txtSymbol.Text = ""
                    txtExchange.Text = ""
                End If
                tblwizard1.Visible = False
                tblwizard2.Visible = True
                tblwizard3.Visible = False
            End If
        End If
    End Sub

    Private Sub LoadSelectDropdown()
        ddlCurrency.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCurrency")
        ddlCurrency.DataBind()
        ddlCurrency.Items.Insert(0, "New")
        ddlCurrency.SelectedItem.Value = "0"
    End Sub

    Sub LoadDetails()
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@CurrencyID", txtrecid.Text)
        Try
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_AdminSelectCurrency", arParms)
        Catch ex As SqlException
            lblmessage.Text = "<b>Error(" & ex.Number & ")</b> " & ex.Message
            tblwizard3.Visible = True
        End Try

        Do While DR.Read
            txtName.Text = DR.Item("CurrencyName")
            txtSymbol.Text = DR.Item("CurrencySymbol")
            If IsDBNull(DR.Item("ExchangeRate")) Then
                txtExchange.Text = "0"
            Else
                txtExchange.Text = DR.Item("ExchangeRate")
            End If
            txtrecid.Text = DR.Item("CurrencyID")
        Loop
        DR.Close()
    End Sub

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim arParms() As SqlParameter = New SqlParameter(4) {}
        arParms(0) = New SqlParameter("@CurrencyID", txtrecid.Text)
        arParms(1) = New SqlParameter("@Name", txtName.Text)
        arParms(2) = New SqlParameter("@Symbol", Request.Form("txtSymbol"))
        arParms(3) = New SqlParameter("@Exchange", IIf(Request.Form("txtExchange") <> "", Request.Form("txtExchange"), DBNull.Value))
        arParms(4) = New SqlParameter("@ErrorStatus", SqlDbType.Int)
        arParms(4).Direction = ParameterDirection.Output

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateCurrency", arParms)
            strErr = arParms(4).Value
        Catch ex As SqlException
            strErr = ex.Number
            strMess = ex.Message
        End Try
        Select Case strErr
            Case 0 ' No Errors
                If txtrecid.Text = "0" Then
                    ' New Record Added
                    lblmessage.Text = "The Currency <b>" & txtName.Text & "</b> has been added"
                Else
                    ' Existing Record Updated
                    lblmessage.Text = "The Currency <b>" & txtName.Text & "</b> has been updated"
                End If
            Case Else
                lblmessage.Text = "<b>Error(" + strErr + ")</b> - <br><br>" + strMess + ", You will need to go <a href=# onclick=javascript:history.back();>back</a> to try again"
        End Select

    End Sub

#End Region

End Class
