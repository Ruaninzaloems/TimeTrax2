Public Class AddContact
  Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

  'This call is required by the Web Form Designer.
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

  End Sub
  Protected WithEvents ddlTitle As System.Web.UI.WebControls.DropDownList
  Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtSurname As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtDept As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtTel As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtEmail As System.Web.UI.WebControls.TextBox
  Protected WithEvents txtFax As System.Web.UI.WebControls.TextBox
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
      LoadDropDowns()
      If Request.QueryString("ret") = "adm" Then
        ' Must return to Admin Contact select box
        ViewState("Type") = "Admin"
      Else
        ' Must return to Contact select box
        ViewState("Type") = ""
      End If
    End If

  End Sub
  Private Sub LoadDropDowns()
    ddlTitle.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectTitle")
    ddlTitle.DataBind()
    ddlTitle.Items.Insert(0, "Select ...")
  End Sub

#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        If Page.IsValid Then
            ' Add Client to DB
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
            arParms(8) = New SqlParameter("@ContactID", SqlDbType.Int) ' Output
            arParms(8).Direction = ParameterDirection.Output
            arParms(9) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
            arParms(9).Direction = ParameterDirection.Output

            Try
                SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_InsertContact", arParms)
                strErr = arParms(9).Value
            Catch ex As SqlException
                strErr = ex.Number
                strMess = ex.Message
            End Try
            Select Case strErr
                Case 0 ' No Errors
                    If ViewState("Type") = "Admin" Then
                        ' Load Contact name and ID into calling windows Admin contact droplist
                        Response.Write("<script language=javascript>opener.document.Form1.ddlAdmin.options[opener.document.Form1.ddlAdmin.selectedIndex].value = '" & arParms(8).Value & "';opener.document.Form1.ddlAdmin.options[opener.document.Form1.ddlAdmin.selectedIndex].text = '" & arParms(1).Value & " " & arParms(2).Value & "';function window.onload() {closeAdd('a');}</script>")
                    Else
                        Dim strJavaScript As String

                        'Load Contact name and ID into calling windows contact droplist
                        'SB: 15/07/2005 - Add the contact to the Admin list as well (do not worry about sorting - as per conversation with AdK)
                        strJavaScript = "<script language=javascript>"
                        strJavaScript += "opener.document.Form1.ddlContact.options[opener.document.Form1.ddlContact.selectedIndex].value = '" & arParms(8).Value & "';opener.document.Form1.ddlContact.options[opener.document.Form1.ddlContact.selectedIndex].text = '" & arParms(1).Value & " " & arParms(2).Value & "';"
                        strJavaScript += "opener.document.Form1.ddlAdmin.options[opener.document.Form1.ddlAdmin.selectedIndex].value = '" & arParms(8).Value & "';opener.document.Form1.ddlAdmin.options[opener.document.Form1.ddlAdmin.selectedIndex].text = '" & arParms(1).Value & " " & arParms(2).Value & "';"
                        strJavaScript += "function window.onload() {closeAdd('');}</script>"

                        Response.Write(strJavaScript)

                    End If
                Case Else
                    Response.Write("<script language='javascript'> alert('SQL error(" + strErr + ") - " + strMess + " ');</script>")
            End Select
        End If
    End Sub

#End Region

End Class
