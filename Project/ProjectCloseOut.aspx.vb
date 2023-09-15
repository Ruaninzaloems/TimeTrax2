Public Class ProjectCloseOut
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents ddlTeamLeader As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlClient As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlStatus As System.Web.UI.WebControls.DropDownList
    Protected WithEvents CheckBox1 As System.Web.UI.WebControls.CheckBox
    Protected WithEvents chkPassedCloseDate As System.Web.UI.WebControls.CheckBox
    Protected WithEvents btnSearch As System.Web.UI.WebControls.Button
    Protected WithEvents trProjectListing As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents tblProjectListing As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents txtProjectIDs As System.Web.UI.HtmlControls.HtmlInputHidden

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

        'Check if the the user has permission for the page else send to the start page
        UserLogin.CheckUserAccess("25", context, True)

        If Not IsPostBack Then
            Session("PageType") = "Project Close Out"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Project Close Out"
            LoadDropLists()
            chkPassedCloseDate.Checked = True
        End If

        PopulateDataGrid()

    End Sub

    Private Sub LoadDropLists()
        ' Load the Clients Droplist
        ddlClient.DataSource = DAL.LoadClients(0)
        ddlClient.DataBind()
        ddlClient.Items.Insert(0, New ListItem("All", "0"))

        ' Load the TeamLeader Droplist
        ddlTeamLeader.DataSource = DAL.LoadTeamLeaders()
        ddlTeamLeader.DataBind()
        ddlTeamLeader.Items.Insert(0, New ListItem("All", "0"))
    End Sub

    Private Sub PopulateDataGrid()

        Dim ds As DataSet
        Dim intCount As Int32
        Dim strProjectIDs As String = String.Empty

        ds = DAL.LoadProjectCloseOutList(chkPassedCloseDate.Checked, ddlTeamLeader.SelectedValue, ddlClient.SelectedValue)


        Dim row As HtmlTableRow = New HtmlTableRow

        AddHeaderRow()

        If Not ds Is Nothing Then
            For intCount = 0 To ds.Tables(0).Rows.Count - 1
                'Build the html for each row project row returned
                AddProjectRow(ds.Tables(0).Rows(intCount))
                'Create a string of the hidden id's
                strProjectIDs += ds.Tables(0).Rows(intCount).Item("ProjectID") & "#"
            Next
        End If

        'Store the project id's in a hidden text box
        txtProjectIDs.Value = strProjectIDs
    End Sub

    Private Sub AddHeaderRow()

        Dim row As HtmlTableRow = New HtmlTableRow

        tblProjectListing.Rows.Clear()

        '<tr>
        row = New HtmlTableRow
        tblProjectListing.Rows.Add(row)
        ' <td>Name</td>
        CreateHeaderCell(row, "Name")
        ' <td>Start</td>
        CreateHeaderCell(row, "Start")
        ' <td>End</td>
        CreateHeaderCell(row, "End")
        ' <td>Last Timesheet</td>
        CreateHeaderCell(row, "Last Timesheet")
        ' <td>Last Expense</td>
        CreateHeaderCell(row, "Last Expense")
        ' <td>Close Out</td>
        CreateHeaderCell(row, "Close Out")

        'Add the header row to the table
        tblProjectListing.Rows.Add(row)

    End Sub

    Private Sub CreateHeaderCell(ByRef row As HtmlTableRow, _
                                 ByVal strText As String)

        Dim cell As HtmlTableCell = New HtmlTableCell

        cell = New HtmlTableCell("th")
        cell.InnerHtml = strText
        cell.Attributes.Add("class", "th1")
        row.Cells.Add(cell)

    End Sub

    Private Sub AddProjectRow(ByVal dr As DataRow)

        Dim intProjectID As Integer = dr.Item("ProjectID")
        Dim row As HtmlTableRow = New HtmlTableRow
        Dim cell As HtmlTableCell
        Dim checkbox As HtmlInputCheckBox = New HtmlInputCheckBox

        'Add the name
        CreateProjectCell(cell, dr.Item("ProjectName"))
        row.Cells.Add(cell)

        'Add the Start
        CreateProjectCell(cell, dr.Item("StartDate"))
        row.Cells.Add(cell)

        'Add the End
        CreateProjectCell(cell, dr.Item("EndDate"))
        row.Cells.Add(cell)

        'Add the Last Time
        CreateProjectCell(cell, IIf(dr.Item("LastTimesheet") Is DBNull.Value, String.Empty, dr.Item("LastTimesheet")))
        row.Cells.Add(cell)

        'Add the Last Expense
        CreateProjectCell(cell, IIf(dr.Item("LastExpense") Is DBNull.Value, String.Empty, dr.Item("LastExpense")))
        row.Cells.Add(cell)

        'Add the checkbox to indicate closeout
        CreateProjectCell(cell, String.Empty)
        checkbox.Checked = False
        checkbox.ID = "chkClose_" & intProjectID
        'checkbox.Attributes.Add("runat", "server")
        cell.Align = "center"
        cell.Controls.Add(checkbox)
        row.Cells.Add(cell)

        'Add the row to the table
        tblProjectListing.Rows.Add(row)

    End Sub

    Private Sub CreateProjectCell(ByRef cell As HtmlTableCell, _
                                  ByVal strText As String)

        cell = New HtmlTableCell("td")
        cell.Attributes.Add("class", "td1")
        If strText.Trim.Length <> 0 Then
            cell.InnerHtml = strText
        End If

    End Sub


#End Region

#Region "Close Out Projects"

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim intCount As Int32
        Dim strProjectIDs As Array
        
        strProjectIDs = txtProjectIDs.Value.Split("#")

        For intCount = 0 To strProjectIDs.Length - 1

            If Request.Form("chkClose_" & strProjectIDs(intCount)) = "on" Then
                Common.ChangeProjectStatus(strProjectIDs(intCount), 4)
            End If

        Next

        Response.Redirect("../default.aspx")

    End Sub

#End Region
End Class
