Public Class RoleNames
    Inherits System.Web.UI.Page
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents dlconstant As System.Web.UI.WebControls.DataList
    Protected WithEvents txtconstant_ As System.Web.UI.WebControls.TextBox
    Protected WithEvents chkenabled_ As System.Web.UI.WebControls.CheckBox
    Protected WithEvents txtVal As System.Web.UI.WebControls.TextBox
    Protected WithEvents CustomValidator1 As System.Web.UI.WebControls.CustomValidator
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblDynAdd As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents LoadCount As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl

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
    Dim FilterType As String
    Dim FilterHeader As String
    Dim FilterConName As String
    Dim FilterSP As String
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "21"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        FilterType = "Role Names"
        FilterSP = "Usr_AddUpdateRoleName"
        If Not IsPostBack Then

            Session("PageType") = "Admin"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Administration (Manage " & FilterType & ")"

            ' Enable Dynamic Add functionality
            tblDynAdd.Visible = True
            Dim arParms() As SqlParameter = New SqlParameter(0) {}
            arParms(0) = New SqlParameter("@constant", FilterType)
            dlconstant.DataSource = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_AdminSelectConstants", arParms)
            dlconstant.DataBind()
            tblwizard1.Visible = True
            tblwizard2.Visible = False
        Else
            tblwizard1.Visible = False
            tblwizard2.Visible = True
            lblmessage.Text = "The " & FilterType & " have been updated<br><br>"
        End If
    End Sub
#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        'Update datalist Items
        Dim id As TextBox
        Dim constant As TextBox
        Dim chkVal As CheckBox
        Dim item As DataListItem

        Dim i As Integer = 0

        For i = 0 To dlconstant.Items.Count - 1

            Dim arParms() As SqlParameter = New SqlParameter(3) {}

            id = CType(dlconstant.Items(i).FindControl("txtid"), TextBox)
            constant = CType(dlconstant.Items(i).FindControl("txtconstant"), TextBox)
            chkVal = CType(dlconstant.Items(i).FindControl("chkenabled"), CheckBox)

            arParms(0) = New SqlParameter("@ID", id.Text)
            arParms(1) = New SqlParameter("@Constant", constant.Text)

            If chkVal.Checked Then
                arParms(2) = New SqlParameter("@Enabled", "1")
            Else
                arParms(2) = New SqlParameter("@Enabled", "0")
            End If
            arParms(3) = New SqlParameter("@AddUpdate", "0")
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, FilterSP, arParms)

        Next i

        'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        'Insert Dynamically added items
        Dim NoRows As Integer
        Dim ItemNo As String
        Dim a As Int32 = 0
        'Loop through all the  added rows
        ItemNo = ""
        ItemNo = Request.Form("item_list")

        If ItemNo <> "" And ItemNo <> "," Then

            Dim RowArray As Array = ItemNo.Split(",")
            NoRows = RowArray((RowArray.Length - 2))

            a = 0
            While a < Convert.ToInt32(NoRows)
                a += 1

                'Write TO Database
                Dim arParms2() As SqlParameter = New SqlParameter(3) {}
                arParms2(0) = New SqlParameter("@ID", "0")
                arParms2(1) = New SqlParameter("@Constant", Request.Form("txtconstant_" & RowArray(a)))
                If Request.Form("chkenabled_" & RowArray(a)) = "on" Then
                    arParms2(2) = New SqlParameter("@Enabled", "1")
                Else
                    arParms2(2) = New SqlParameter("@Enabled", "0")
                End If
                arParms2(3) = New SqlParameter("@AddUpdate", "1")
                SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, FilterSP, arParms2)
            End While
        End If
    End Sub
#End Region

End Class
