Public Class TimeOffTypes
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlTimeOffTypes As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btngo As System.Web.UI.WebControls.Button

    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl

    Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvName As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents chkEnabled As System.Web.UI.WebControls.CheckBox
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents txtrecid As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtpostback As System.Web.UI.WebControls.TextBox
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary

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
    Dim DR As SqlDataReader
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " PAGE DECLARES "
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        UserLogin.CheckUserAccess("27", Context.Current, True)

        If Not IsPostBack Then
            ' FIRST PAGE LOAD DISPLAY SELECT DROPLIST
            Session("PageType") = "Admin"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Administration (Manage TimeOff Types)"
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
                txtrecid.Text = ddlTimeOffTypes.SelectedItem.Value
                If ddlTimeOffTypes.SelectedItem.Value <> "0" Then
                    'existing user
                    LoadDetails()
                Else
                    'add new type
                    txtName.Text = ""
                End If
                tblwizard1.Visible = False
                tblwizard2.Visible = True
                tblwizard3.Visible = False
            End If
        End If
    End Sub

    Private Sub LoadSelectDropdown()
        ddlTimeOffTypes.DataSource = DAL.GetTimeOffTypes("1") 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_AdminSelectClient")
        ddlTimeOffTypes.DataBind()
        ddlTimeOffTypes.Items.Insert(0, "New")
        ddlTimeOffTypes.SelectedItem.Value = "0"
    End Sub

    Sub LoadDetails()
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@TypeID", txtrecid.Text)
        Try
            DR = DAL.LoadTimeOffType(txtrecid.Text) 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectClientInfo", arParms)
        Catch ex As SqlException
            lblmessage.Text = "<b>Error(" & ex.Number & ")</b> " & ex.Message
            tblwizard3.Visible = True
        End Try

        While DR.Read
            txtName.Text = DR.Item("Description")
            If DR.Item("Enabled") = "1" Then
                chkEnabled.Checked = True
            Else
                chkEnabled.Checked = False
            End If
            txtrecid.Text = DR.Item("TypeID")
        End While
        DR.Close()
    End Sub


#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        DAL.AddUpdateTimeOffType(txtrecid.Text, txtName.Text, chkEnabled.Checked) 'SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddUpdateClient", arParms)

        If txtrecid.Text = "0" Then
            ' New Record Added
            lblmessage.Text = "The Type <b>" & txtName.Text & "</b> has been added"
        Else
            ' Existing Record Updated
            lblmessage.Text = "The Type <b>" & txtName.Text & "</b> has been updated"
        End If

    End Sub
#End Region

End Class
