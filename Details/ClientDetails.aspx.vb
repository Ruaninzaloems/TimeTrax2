Public Class ClientDetails
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtCode As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtName As System.Web.UI.WebControls.TextBox
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
    Protected WithEvents btnClose As System.Web.UI.WebControls.Button

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
    Private m_intClientID As Integer
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_intClientID = Request.QueryString("ClientID")
        LoadDropDowns()
        LoadDetails()
    End Sub

    Private Sub LoadDropDowns()
        ddlCountry.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectCountry")
        ddlCountry.DataBind()
    End Sub

    Sub LoadDetails()

        Dim DR As SqlDataReader

        DR = DAL.LoadClientInfo(m_intClientID)

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
        Loop
        DR.Close()
    End Sub

#End Region

#Region " SUBMIT DETAILS "
#End Region

End Class
