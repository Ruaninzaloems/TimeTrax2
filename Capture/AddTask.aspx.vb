Public Class AddTask
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents tblTasks As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents chktest As System.Web.UI.WebControls.CheckBox
    Protected WithEvents taskPlace As System.Web.UI.WebControls.PlaceHolder

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
    Dim DS As DataSet
    Dim arParms() As SqlParameter = New SqlParameter(0) {}
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " PAGE DECLARES "
    Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not IsPostBack Then
            LoadUserProjects()
        End If

    End Sub

    Sub LoadUserProjects()
        Dim hidBoxtask As HtmlInputHidden
        Dim strValue As String
        Dim menucount As Integer = 0
        Dim row As HtmlTableRow = New HtmlTableRow
        Dim cell As HtmlTableCell = New HtmlTableCell
        Dim Table As HtmlTable = New HtmlTable
        Dim img As HtmlImage
        Dim chk As HtmlInputCheckBox
        Dim spanlit As HtmlGenericControl
        Dim lit As LiteralControl
        Dim tasktableRow As HtmlTableRow = New HtmlTableRow
        Dim taskCell As HtmlTableCell = New HtmlTableCell
        Dim projrow As DataRow
        Dim taskrow As DataRow

        'arParms(0) = New SqlParameter("@UserID", User.Identity.Name)
        DS = New DataSet
        DS = DAL.GetUserProjectTasks(User.Identity.Name, Request.QueryString("TimesheetDate")) 'SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "TT_SelectUserProjects_AddTask", arParms)
        ' Name the tables
        DS.Tables(0).TableName = "Task"
        DS.Tables(1).TableName = "Project"
        ' Set up relationships
        DS.Relations.Add("Proj_Task", DS.Tables("Project").Columns("Project"), DS.Tables("Task").Columns("Project"))

        ' Build the following:
        '	<TR>
        ' 	<TH class="th4" id="menu2">
        ' 		<IMG id="menu2a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleDisplay(menu2a, menu2b, 'menu2');"
        ' 			height="16" alt="" src="../Images/down.gif" width="16" align="right" vspace="0"
        ' 			border="0">
        '       <TABLE>
        '         <TR>
        '           <TH>Project</TH>
        '           <TH>Checkbox "Add All"</TH>
        '         </TR>
        '       </TABLE>
        ' 	</TH>
        ' </TR>
        '<TR>
        '	<TD>
        '		<span id="menu2b" style="DISPLAY: none">
        '     <TABLE>
        '       <TR>
        '         <TD>Taskname</TD>
        '         <TD>Checkbox</TD>
        '       </TR>
        '     </TABLE>
        '   </SPAN>
        ' </TD>
        '</TR>

        If DS.Tables("Project").Rows.Count = 0 Then
            lit = New LiteralControl
            taskPlace.Controls.Add(lit)
            lit.Text = "<center><b>No Tasks available for selection</b>,<br> <i>Check with Admin that you are listed as a resource for the relevant projects</i></center>"

            btnSubmit.Enabled = False
        Else
            For Each projrow In DS.Tables("Project").Rows
                menucount += 1
                row = New HtmlTableRow
                tblTasks.Rows.Add(row)
                cell = New HtmlTableCell("th")
                row.Cells.Add(cell)
                cell.Attributes.Add("class", "th4")
                cell.ID = "menu" & menucount

                Table = New HtmlTable
                cell.Controls.Add(Table)
                Table.Attributes.Add("width", "100%")
                row = New HtmlTableRow
                Table.Controls.Add(row)
                ' Add header cells here
                cell = New HtmlTableCell("th")
                row.Controls.Add(cell)
                cell.Attributes.Add("Width", "5%")
                cell.Attributes.Add("class", "th1")
                img = New HtmlImage
                cell.Controls.Add(img)
                img.ID = "menu" & menucount & "a"
                img.Attributes.Add("onclick", "ToggleDisplay(menu" & menucount & "a, menu" & menucount & "b, 'menu" & menucount & "');")
                img.Src = "../Images/down.gif"
                img.Attributes.Add("align", "left")
                img.Attributes.Add("Style", "LEFT: 0px; CURSOR: hand; TOP: 3px")

                cell = New HtmlTableCell("th")
                row.Controls.Add(cell)
                cell.Attributes.Add("Width", "80%")
                cell.Attributes.Add("class", "th1")
                cell.InnerHtml = projrow.Item("Project")

                cell = New HtmlTableCell("th")
                row.Controls.Add(cell)
                cell.Attributes.Add("Width", "15%")
                cell.Attributes.Add("class", "th1")
                chk = New HtmlInputCheckBox
                cell.Controls.Add(chk)
                chk.ID = projrow.Item("Project")
                chk.Attributes.Add("onclick", "TogglecheckAll(this);")
                '<label for="chktest">All</label>
                lit = New LiteralControl
                cell.Controls.Add(lit)
                lit.Text = "<label for='" & projrow.Item("Project") & "'>Add all</label>"

                row = New HtmlTableRow
                tblTasks.Rows.Add(row)
                cell = New HtmlTableCell("td")
                row.Cells.Add(cell)
                spanlit = New HtmlGenericControl("Span")
                spanlit.ID = "menu" & menucount & "b"
                spanlit.Attributes.Add("Style", "display:none;")
                cell.Controls.Add(spanlit)

                Table = New HtmlTable
                spanlit.Controls.Add(Table)
                Table.Attributes.Add("width", "100%")

                For Each taskrow In projrow.GetChildRows("Proj_Task")
                    ' Add the task to hidden text box for processing on submit
                    strValue &= "," & projrow.Item("Project") & "_" & taskrow("TaskID")

                    tasktableRow = New HtmlTableRow
                    Table.Controls.Add(tasktableRow)

                    taskCell = New HtmlTableCell("td")
                    tasktableRow.Controls.Add(taskCell)
                    taskCell.Attributes.Add("Width", "85%")
                    taskCell.ID = "lblTask_" & taskrow("TaskID")
                    taskCell.InnerText = taskrow("Task")
                    taskCell.Attributes.Add("class", "label")
                    taskCell.ColSpan = 2

                    taskCell = New HtmlTableCell("td")
                    tasktableRow.Controls.Add(taskCell)
                    taskCell.Attributes.Add("Width", "15%")
                    chk = New HtmlInputCheckBox
                    taskCell.Controls.Add(chk)
                    chk.ID = "chkTask_" & projrow.Item("Project") & "_" & taskrow("TaskID")
                    taskCell.Attributes.Add("Align", "Center")

                Next
            Next

            hidBoxtask = New HtmlInputHidden
            hidBoxtask.ID = "hidBoxtasks"
            hidBoxtask.Value = strValue
            taskPlace.Controls.Add(hidBoxtask)
        End If

    End Sub
#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ' Add Selected Tasks to UserProfile
        Dim a, NoRows, TaskID As Int16
        Dim ItemNo, Proj As String
        Dim TaskArray, arrData As Array

        Dim arParms() As SqlParameter = New SqlParameter(1) {}

        a = 0
        NoRows = 0
        ItemNo = ""
        ItemNo = Request.Form("hidBoxtasks")
        If ItemNo <> "" And ItemNo <> "," Then
            Try
                TaskArray = ItemNo.Split(",")
                NoRows = (TaskArray.Length - 1)
            Catch
            End Try

            While a < NoRows
                a += 1
                ItemNo = TaskArray(a)
                arrData = ItemNo.Split("_")
                Proj = arrData(0)
                TaskID = CInt(arrData(1))
                If Request.Form("chkTask_" & Proj & "_" & TaskID) = "on" Then
                    DAL.AddProfileTasks(User.Identity.Name, TaskID)
                End If
            End While
        End If

        ' No Errors
        ' Re Load the calling window
        Response.Write("<script language=javascript>function window.onload() {closeAdd();}</script>")
    End Sub
#End Region

End Class
