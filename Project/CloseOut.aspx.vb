Public Class CloseOut
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
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
    Dim DR As SqlDataReader
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " PAGE DECLARES "
    Dim ucProjInfo As New TimeTrax.ucProjectInfo
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        UserLogin.CheckUserAccess("26", Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "CloseOut"
            Session("PageTitle") = Session("AppName") & " - Project Close Out"
            ' If No ProjectID is sent then redirect to Select Project Page
            If Request.QueryString("ProjID") Is Nothing Then
                ' Set the Page that SelectProject will return to
                Session("ReturnUrl") = Me.Request.Path
                Response.Redirect("SelectProject.aspx")
            End If
            ViewState("ProjectID") = Request.QueryString("ProjID")
            'Needed for Project Info Usercontrol
            ucProjInfo.ProjectID = ViewState("ProjectID")
            ucProjInfo.blnShowSummaries = True
        End If
    End Sub
#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ' Set Project Status to 4 (Closed)
        Common.ChangeProjectStatus(ViewState("ProjectID"), 4)

        ' and go to start page
        Response.Redirect(Me.Request.ApplicationPath)
        'Response.Redirect(Request.ApplicationPath & "\default.aspx")
    End Sub
#End Region

End Class
