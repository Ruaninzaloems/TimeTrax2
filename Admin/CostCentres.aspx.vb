Public Class CostCentres
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlCostCentre As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btngo As System.Web.UI.WebControls.Button
    Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvName As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ddlManager As System.Web.UI.WebControls.DropDownList
    Protected WithEvents rfvManager As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ddlCountry As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents txtrecid As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtpostback As System.Web.UI.WebControls.TextBox
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents rfvCountry As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents chkenabled As System.Web.UI.WebControls.CheckBox

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
        Dim Role As String = "12"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            ' FIRST PAGE LOAD DISPLAY SELECT DROPLIST
            Session("PageType") = "Admin"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Administration (Manage Cost Centres)"
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
                txtrecid.Text = ddlCostCentre.SelectedItem.Value
                If ddlCostCentre.SelectedItem.Value <> "0" Then
                    'existing user
                    LoadDetails()
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

    Private Sub LoadSelectDropdown()
        ddlCostCentre.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_AdminSelectCostCentre")
        ddlCostCentre.DataBind()
        ddlCostCentre.Items.Insert(0, "New")
        ddlCostCentre.SelectedItem.Value = "0"
    End Sub

    Private Sub LoadDropDowns()
        ddlManager.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectManagers")
        ddlManager.DataBind()
        ddlManager.Items.Insert(0, "Select ...")

        ddlCountry.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCountry")
        ddlCountry.DataBind()
        ddlCountry.Items.Insert(0, "Select ...")

    End Sub

    Sub LoadDetails()
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@CostCentreID", txtrecid.Text)
        Try
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCostCentreInfo", arParms)
        Catch ex As SqlException
            lblmessage.Text = "<b>Error(" & ex.Number & ")</b> " & ex.Message
            tblwizard3.Visible = True
        End Try

        Do While DR.Read
            txtName.Text = DR.Item("CostCentreName")
            ddlManager.SelectedIndex = ddlManager.Items.IndexOf(ddlManager.Items.FindByText(DR.Item("UserName")))
            ddlCountry.SelectedIndex = ddlCountry.Items.IndexOf(ddlCountry.Items.FindByText(DR.Item("CountryName")))
            If DR.Item("Enabled") = "1" Then
                chkenabled.Checked = True
            Else
                chkenabled.Checked = False
            End If
            txtrecid.Text = DR.Item("CostCentreID")
        Loop
        DR.Close()
    End Sub

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim arParms() As SqlParameter = New SqlParameter(5) {}
        arParms(0) = New SqlParameter("@CostCentreID", txtrecid.Text)
        arParms(1) = New SqlParameter("@Name", txtName.Text)
        arParms(2) = New SqlParameter("@ManagerID", CInt(ddlManager.SelectedItem.Value))
        arParms(3) = New SqlParameter("@CountryID", CInt(ddlCountry.SelectedItem.Value))
        If chkenabled.Checked = True Then
            arParms(4) = New SqlParameter("@Enabled", "1")
        Else
            arParms(4) = New SqlParameter("@Enabled", "0")
        End If
        arParms(5) = New SqlParameter("@ErrorStatus", SqlDbType.Int)
        arParms(5).Direction = ParameterDirection.Output

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateCostCentre", arParms)
            strErr = arParms(5).Value
        Catch ex As SqlException
            strErr = ex.Number
            strMess = ex.Message
        End Try
        Select Case strErr
            Case 0 ' No Errors
                If txtrecid.Text = "0" Then
                    ' New Record Added
                    lblmessage.Text = "The Cost Centre <b>" & txtName.Text & "</b> has been added"
                Else
                    ' Existing Record Updated
                    lblmessage.Text = "The Cost Centre <b>" & txtName.Text & "</b> has been updated"
                End If
            Case Else
                lblmessage.Text = "<b>Error(" + strErr + ")</b> - <br><br>" + strMess + ", You will need to go <a href=# onclick=javascript:history.back();>back</a> to try again"
        End Select

    End Sub

#End Region

End Class
