Public Class UpdateResource
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents chkEnabled As System.Web.UI.WebControls.CheckBox
    Protected WithEvents tdResource As System.Web.UI.HtmlControls.HtmlTableCell
    Protected WithEvents btnSubmit As System.Web.UI.HtmlControls.HtmlInputButton

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
    Private m_intProjectID As Integer
    Private m_intResourceID As Integer
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to change the team leader
        'Dim Role As String = "61"
        'UserLogin.CheckUserAccess(Role, Context.Current, True)

        m_intProjectID = Request.QueryString("ProjectID")
        m_intResourceID = Request.QueryString("ResourceID")

        If Not IsPostBack Then
            LoadProjectResourceDetails()
        End If
    End Sub

    Private Sub LoadProjectResourceDetails()
        Dim dr As SqlDataReader

        dr = DAL.LoadProjectResourcesDetails(m_intProjectID, m_intResourceID)


        While dr.Read
            tdResource.InnerHtml = (dr.Item("FirstName") & " " & dr.Item("LastName")).ToString.Trim()
            chkEnabled.Checked = dr.Item("Enabled")
        End While
    End Sub


#End Region

#Region "SUBMIT DETAILS "

    Private Sub btnSubmit_ServerClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.ServerClick

        DAL.EnableDisableProjectResource(m_intProjectID, m_intResourceID, chkEnabled.Checked)

        ' Close Change Teamleader popup window and reload calling window
        Response.Write("<script language=javascript>opener.location.reload();window.close();</script>")

    End Sub

#End Region

End Class
