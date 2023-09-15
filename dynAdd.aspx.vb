Public Class dynAdd
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents listPlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents timePlace As System.Web.UI.WebControls.PlaceHolder
    Protected WithEvents txtTotal As System.Web.UI.WebControls.TextBox
    Protected WithEvents tbltime As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents tbltimefoot As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents CashPlace As System.Web.UI.WebControls.PlaceHolder

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
        Dim Role As String = "8"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Expenses"
            Session("PageTitle") = Session("AppName") & " - Capture Expenses"
            LoadMonthExpenses(Today())
        End If
    End Sub

    Private Sub LoadMonthExpenses(ByVal Day As Date)
        Dim DS As DataSet
        Dim clientrow As DataRow
        Dim projrow As DataRow
        Dim Hidden As HtmlInputHidden
        Dim dynAdd As String
        Dim a As Int32 = 0
        Dim b As Int32 = 0

        Dim FirstDay As DateTime
        FirstDay = Day.Month & "/01/" & Day.Year
        ViewState("FirstDay") = FirstDay
        Dim arParms2() As SqlParameter = New SqlParameter(1) {}
        arParms2(0) = New SqlParameter("@UserID", User.Identity.Name)
        arParms2(1) = New SqlParameter("@StartDate", ViewState("FirstDay")) 'Day)

        DS = New DataSet
        DS = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "TT_SelectUserExpenses", arParms2)
        ' Name the tables
        DS.Tables(0).TableName = "Client"
        DS.Tables(1).TableName = "Project"
        ' Set up relationships
        DS.Relations.Add("Client_Proj", DS.Tables("Client").Columns("ProjectID"), DS.Tables("Project").Columns("ProjectID"))

        tbltime.Rows.Clear()

        For Each clientrow In DS.Tables("Client").Rows
            a += 1
            b = 0
            For Each projrow In clientrow.GetChildRows("Client_Proj")
                ' Load the existing expense data into hidden textboxes
                b += 1

                Hidden = New HtmlInputHidden
                listPlace.Controls.Add(Hidden)
                Hidden.ID = "txtExpense_" & a & "Date_a" & b
                Hidden.Value = projrow.Item("ExpenseDate")
                Hidden = New HtmlInputHidden
                listPlace.Controls.Add(Hidden)
                Hidden.ID = "txtExpense_" & a & "ExpenseType_a" & b
                Hidden.Value = projrow.Item("ExpenseType")
                Hidden = New HtmlInputHidden
                listPlace.Controls.Add(Hidden)
                Hidden.ID = "txtExpense_" & a & "Quantity_a" & b
                Hidden.Value = projrow.Item("Quantity")
                Hidden = New HtmlInputHidden
                listPlace.Controls.Add(Hidden)
                Hidden.ID = "txtExpense_" & a & "Cost_a" & b
                Hidden.Value = projrow.Item("Cost")
            Next
            '      LoadCount += i
            'write hidden counter for no of items
            Dim count As New HtmlInputHidden
            listPlace.Controls.Add(count)
            count.ID = "expense_" & a & "_listload"
            count.Value = b
        Next
    End Sub

#End Region

#Region " SUBMIT DETAILS "
#End Region

End Class
