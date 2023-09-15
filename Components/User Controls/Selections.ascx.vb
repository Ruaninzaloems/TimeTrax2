Public Class Selections
    Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlLevel1 As System.Web.UI.WebControls.DropDownList
    Protected WithEvents lstUsers As System.Web.UI.WebControls.ListBox
    Protected WithEvents ddlLevel2 As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlLevel3 As System.Web.UI.WebControls.DropDownList

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
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            LoadDroplists()
        End If
    End Sub

    Private Sub LoadDroplists()

        Dim DS As DataSet = DAL.LoadReportSelections()
        ' Load the Clients Droplist
        ddlLevel1.DataSource = DS.Tables(0)
        ddlLevel1.DataBind()
        ddlLevel1.Items.Insert(0, New ListItem("All", "0"))

        ' Load the Projects Droplist
        ddlLevel2.DataSource = DS.Tables(1)
        ddlLevel2.DataBind()
        ddlLevel2.Items.Insert(0, New ListItem("All", "0#0"))

        ' Load Tasks Droplist
        ddlLevel3.DataSource = DS.Tables(2)
        ddlLevel3.DataBind()
        ddlLevel3.Items.Insert(0, New ListItem("All", "0#0"))

        ' Load Users
        lstUsers.DataSource = DAL.LoadResources()
        lstUsers.DataBind()

    End Sub

#End Region

#Region " SUBMIT DETAILS "
#End Region

End Class
