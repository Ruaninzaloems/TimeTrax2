Public Class AddClient
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
  Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtCode As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtPhyAdd As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtPosAdd As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtPhySuburb As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtPosSuburb As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtPhyCity As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtPosCity As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtPhyProvince As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtPosProvince As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtPosCode As System.Web.UI.WebControls.TextBox
  Protected WithEvents ddlCountry As System.Web.UI.WebControls.DropDownList
  Protected WithEvents chkEnabled As System.Web.UI.WebControls.CheckBox
  Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button

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
  Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")
#End Region

#Region " PAGE LOAD "
  Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    If Not IsPostBack Then
      LoadCountries()
    End If

  End Sub

  Sub LoadCountries()
    ddlCountry.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCountry")
    ddlCountry.DataBind()
    ddlCountry.Items.Insert(0, New ListItem("--Select a Country--", "0"))

  End Sub
#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim ClientCode As String = DAL.GenerateClientCode()
        ' Add Client to DB
        Dim arParms() As SqlParameter = New SqlParameter(14) {}
        arParms(0) = New SqlParameter("@Name", txtName.Text)
        arParms(1) = New SqlParameter("@Code", ClientCode)
        arParms(2) = New SqlParameter("@PhyAddress", IIf(txtPhyAdd.Text <> "", txtPhyAdd.Text, DBNull.Value))
        arParms(3) = New SqlParameter("@PosAddress", IIf(txtPosAdd.Text <> "", txtPosAdd.Text, DBNull.Value))
        arParms(4) = New SqlParameter("@PhySuburb", IIf(txtPhySuburb.Text <> "", txtPhySuburb.Text, DBNull.Value))
        arParms(5) = New SqlParameter("@PosSuburb", IIf(txtPosSuburb.Text <> "", txtPosSuburb.Text, DBNull.Value))
        arParms(6) = New SqlParameter("@PhyCity", IIf(txtPhyCity.Text <> "", txtPhyCity.Text, DBNull.Value))
        arParms(7) = New SqlParameter("@PosCity", IIf(txtPosCity.Text <> "", txtPosCity.Text, DBNull.Value))
        arParms(8) = New SqlParameter("@PhyProvince", IIf(txtPhyProvince.Text <> "", txtPhyProvince.Text, DBNull.Value))
        arParms(9) = New SqlParameter("@PosProvince", IIf(txtPosProvince.Text <> "", txtPosProvince.Text, DBNull.Value))
        arParms(10) = New SqlParameter("@PosCode", IIf(txtPosCode.Text <> "", txtPosCode.Text, DBNull.Value))
        arParms(11) = New SqlParameter("@CountryID", ddlCountry.SelectedValue)
        If chkEnabled.Checked = True Then
            arParms(12) = New SqlParameter("@Enabled", "1")
        Else
            arParms(12) = New SqlParameter("@Enabled", "0")
        End If
        arParms(13) = New SqlParameter("@ClientID", SqlDbType.Int) ' Output
        arParms(13).Direction = ParameterDirection.Output
        arParms(14) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
        arParms(14).Direction = ParameterDirection.Output

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_InsertClient", arParms)
            strErr = arParms(14).Value
        Catch ex As SqlException
            strErr = ex.Number
            strMess = ex.Message
        End Try
        Select Case strErr
            Case 0 ' No Errors
                ' Load Client name and ID into calling windows droplist
                Response.Write("<script language=javascript>opener.document.Form1.ddlClient.options[opener.document.Form1.ddlClient.selectedIndex].value = '" & arParms(13).Value & "';opener.document.Form1.ddlClient.options[opener.document.Form1.ddlClient.selectedIndex].text = '" & arParms(0).Value & "';function window.onload() {closeAdd();}</script>")
            Case Else
                Response.Write("<script language='javascript'> alert('SQL error(" + strErr + ") - " + strMess + " ');</script>")
        End Select

        ' and close the window
    End Sub
#End Region

End Class
