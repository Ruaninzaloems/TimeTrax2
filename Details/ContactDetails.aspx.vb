Public Class ContactDetails
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlTitle As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtSurname As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtDept As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtEmail As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtTel As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtFax As System.Web.UI.WebControls.TextBox
    Protected WithEvents chkEnabled As System.Web.UI.WebControls.CheckBox

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
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " PAGE DECLARES "
    Dim DBConn = ConfigurationSettings.AppSettings("DBConn")
    Private m_intContactID As Integer
#End Region

#Region " PAGE LOAD "

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_intContactID = Request.QueryString("ContactID")
        LoadDropDowns()
        LoadDetails()
    End Sub

    Private Sub LoadDropDowns()
        ddlTitle.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectTitle")
        ddlTitle.DataBind()
    End Sub

    Sub LoadDetails()
        Dim DR As SqlDataReader

        DR = DAL.LoadContactInfo(m_intContactID)

        Do While DR.Read
            ddlTitle.SelectedIndex = ddlTitle.Items.IndexOf(ddlTitle.Items.FindByText(DR.Item("Title")))

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
        Loop
        DR.Close()
    End Sub

#End Region

#Region " SUBMIT DETAILS "
#End Region

End Class
