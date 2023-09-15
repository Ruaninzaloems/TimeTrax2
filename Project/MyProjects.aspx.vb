Public Class MyProject
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.ID = "MyProject"

    End Sub
    Protected WithEvents labMyProjects As System.Web.UI.WebControls.Label
    Protected WithEvents dgMyProjects As System.Web.UI.WebControls.DataGrid
    Protected WithEvents labCurrentProjects As System.Web.UI.WebControls.Label
    Protected WithEvents dgCurrentProjects As System.Web.UI.WebControls.DataGrid
    Protected WithEvents divProjects As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents CurrentProjects As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents MyProj As System.Web.UI.HtmlControls.HtmlTableRow
    Protected WithEvents labAllProjects As System.Web.UI.WebControls.Label
    Protected WithEvents dgAllProjects As System.Web.UI.WebControls.DataGrid
    Protected WithEvents AllProjects As System.Web.UI.HtmlControls.HtmlTableRow

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
        Dim Role As String = "2"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Project"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - My Projects"
            LoadProjects()
        End If
    End Sub

    Private Sub LoadProjects()
        Dim MyProjRow As DataRow
        Dim CurrentProjectsRow As DataRow
        Dim AllProjectsRow As DataRow
        Dim MyProjTable As DataTable = New DataTable("RESULTS")
        Dim CurrentProjectsTable As DataTable = New DataTable("RESULTS")
        Dim AllProjectsTable As DataTable = New DataTable("RESULTS")
        MyProjTable.Columns.Add("Mess", GetType(System.String))
        CurrentProjectsTable.Columns.Add("Mess", GetType(System.String))
        AllProjectsTable.Columns.Add("Mess", GetType(System.String))
        'Dim arParms() As SqlParameter = New SqlParameter(0) {}
        'arParms(0) = New SqlParameter("@UserID", User.Identity.Name)
        ' Execute the stored procedure
        DR = DAL.LoadProjects(User.Identity.Name) 'SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectMyProjects", arParms)
        Dim UserGroup As String = DAL.GetUserGroup(User.Identity.Name)
        Select Case UserGroup
            Case "Admin", "Admin Manager", "Director", "Super User"
                ' All Projects (For Admin Managers, Administrators, Directors and Super Users
                While DR.Read()
                    If Not DR.Item("Message") Is DBNull.Value Then
                        ' AllProjects
                        AllProjectsRow = AllProjectsTable.NewRow()
                        AllProjectsRow("Mess") = DR.Item("Detail")
                        AllProjectsTable.Rows.Add(AllProjectsRow)
                    End If
                End While

                DR.NextResult()
        End Select

        ' Users Projects
        While DR.Read()
            If Not DR.Item("Message") Is DBNull.Value Then
                Select Case DR.Item("Message")
                    Case "MyProjects"
                        MyProjRow = MyProjTable.NewRow()
                        MyProjRow("Mess") = DR.Item("Detail")
                        MyProjTable.Rows.Add(MyProjRow)
                    Case "CurrentProjects"
                        CurrentProjectsRow = CurrentProjectsTable.NewRow()
                        CurrentProjectsRow("Mess") = DR.Item("Detail")
                        CurrentProjectsTable.Rows.Add(CurrentProjectsRow)
                End Select
            End If
        End While

        DR.Close()

        dgMyProjects.DataSource = MyProjTable
        dgMyProjects.DataBind()
        ItemCounter(dgMyProjects, MyProj, labMyProjects, "Project")
        If dgMyProjects.Items.Count() > 0 Then
            divProjects.Style("DISPLAY") = "block"
        Else
            MyProj.Visible = False
        End If
        dgCurrentProjects.DataSource = CurrentProjectsTable
        dgCurrentProjects.DataBind()
        ItemCounter(dgCurrentProjects, CurrentProjects, labCurrentProjects, "Project")
        If dgCurrentProjects.Items.Count() > 0 Then
            divProjects.Style("DISPLAY") = "block"
        Else
            CurrentProjects.Visible = False
        End If
        Select Case UserGroup
            Case "Admin", "Admin Manager", "Director", "Super User"
                dgAllProjects.DataSource = AllProjectsTable
                dgAllProjects.DataBind()
                ItemCounter(dgAllProjects, AllProjects, labAllProjects, "Project")
                labAllProjects.Text = "All Projects"
                If dgAllProjects.Items.Count() > 0 Then
                    divProjects.Style("DISPLAY") = "block"
                End If
            Case Else
                AllProjects.Visible = False
        End Select

    End Sub

    Function ItemCounter(ByVal dg As DataGrid, ByVal tr As HtmlTableRow, ByVal lab As Label, ByVal txt As String)
        Dim a As Int32 = 0
        Dim ICount As Int32 = 0

        ICount = CountDataGridRows(dg)
        a = ICount
        If a = 0 Then
            tr.Visible = False
        End If
        If a > 1 Then
            lab.Text = "You have " & a & " " & txt & "s " & lab.Text
        Else
            lab.Text = "You have " & a & " " & txt & " " & lab.Text
        End If
    End Function

    Function CountDataGridRows(ByVal dg As DataGrid)
        Dim a As Int32 = dg.Items.Count
        Dim Count As Int32 = 0
        While a >= 0
            Try
                If dg.Items(a).Visible = True Then
                    Count += 1
                End If
            Catch
            End Try
            a -= 1
        End While
        Return Count
    End Function

#End Region

End Class
