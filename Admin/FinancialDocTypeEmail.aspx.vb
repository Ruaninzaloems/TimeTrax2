Public Class FinancialDocTypeEmail
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents btngo As System.Web.UI.WebControls.Button
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents lblmessage As System.Web.UI.WebControls.Label
    Protected WithEvents txtrecid As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtpostback As System.Web.UI.WebControls.TextBox
    Protected WithEvents validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents tblwizard3 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents ddlFinDocType As System.Web.UI.WebControls.DropDownList
    Protected WithEvents txtFinDocType As System.Web.UI.WebControls.TextBox
    Protected WithEvents tblEmail As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents btnCancel As System.Web.UI.WebControls.Button

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
        Dim Role As String = "71"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then

            ' FIRST PAGE LOAD DISPLAY SELECT DROPLIST
            Session("PageType") = "Admin"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Administration (Manage Financial Document Type Emails)"
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
                txtrecid.Text = ddlFinDocType.SelectedItem.Value
                LoadDetails()
                tblwizard1.Visible = False
                tblwizard2.Visible = True
                tblwizard3.Visible = False
            End If
        End If
    End Sub

    Private Sub LoadSelectDropdown()
        ddlFinDocType.DataSource = DAL.LoadFinancialDocumentTypesWithApproval()
        ddlFinDocType.DataBind()
    End Sub

    Sub LoadDetails()
        Dim ds As DataSet
        Dim intCount As Integer
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@FinancialDocTypeID", ddlFinDocType.SelectedValue)
        Try
            ds = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "TT_SelectDocumentTypeInfo", arParms)
        Catch ex As SqlException
            lblmessage.Text = "<b>Error(" & ex.Number & ")</b> " & ex.Message
            tblwizard3.Visible = True
        End Try

        If ds.Tables.Count > 0 Then
            If ds.Tables(0).Rows.Count > 0 Then
                txtFinDocType.Text = ds.Tables(0).Rows(0).Item("FinancialDocType")
            End If

            If ds.Tables(1).Rows.Count > 0 Then
                For intCount = 0 To ds.Tables(1).Rows.Count - 1
                    BuildEmailRow(ds.Tables(1).Rows(intCount))
                Next
            End If
        End If

    End Sub

    Private Sub BuildEmailRow(ByVal dRow As DataRow)

        Dim td As New HtmlControls.HtmlTableCell
        Dim tr As New HtmlControls.HtmlTableRow
        Dim img As New HtmlControls.HtmlImage

        td.InnerHtml = dRow.Item("FullName")
        td.Attributes.Add("class", "td1")
        tr.Controls.Add(td)


        td = New HtmlControls.HtmlTableCell
        td.InnerHtml = dRow.Item("Email")
        td.Attributes.Add("class", "td1")
        tr.Controls.Add(td)

        td = New HtmlControls.HtmlTableCell
        td.Align = "center"
        img.Alt = "Delete the Email"
        img.Src = "../Images/Delete.gif"
        img.ID = "imgDel_" & dRow.Item("UserID")
        img.Border = 0
        Dim href As New HtmlControls.HtmlAnchor
        href.HRef = "FinancialDocTypeEmailDelete.aspx?UserID=" & dRow.Item("UserID") & "&FinancialDocTypeID=" & ddlFinDocType.SelectedItem.Value
        href.Controls.Add(img)
        td.Attributes.Add("class", "td1")
        td.Controls.Add(href)
        tr.Controls.Add(td)

        tblEmail.Controls.Add(tr)
    End Sub

#End Region

#Region " SUBMIT DETAILS "
    Private Sub btnsubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Response.Redirect("FinancialDocTypeEmailAdd.aspx?FinancialDocTypeID=" & ddlFinDocType.SelectedValue)
    End Sub

#End Region


    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("../Default.aspx")
    End Sub
End Class
