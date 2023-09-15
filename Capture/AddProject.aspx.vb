Public Class AddProject
  Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

  'This call is required by the Web Form Designer.
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

  End Sub
  Protected WithEvents tblProjects As System.Web.UI.HtmlControls.HtmlTable
  Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
  Protected WithEvents chktest As System.Web.UI.WebControls.CheckBox
  Protected WithEvents projectPlace As System.Web.UI.WebControls.PlaceHolder

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
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " PAGE DECLARES "
  Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")
#End Region

#Region " PAGE LOAD "
  Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    If Not IsPostBack Then
      LoadUserClients()
    End If

  End Sub

  Sub LoadUserClients()
        Dim hidBoxproj As HtmlInputHidden
        Dim strValue As String
        Dim menucount As Integer = 0
        Dim row As HtmlTableRow = New HtmlTableRow
        Dim cell As HtmlTableCell = New HtmlTableCell
        Dim Table As HtmlTable = New HtmlTable
        Dim img As HtmlImage
        Dim chk As HtmlInputCheckBox
        Dim spanlit As HtmlGenericControl
        Dim lit As LiteralControl
        Dim projecttableRow As HtmlTableRow = New HtmlTableRow
        Dim projectCell As HtmlTableCell = New HtmlTableCell
        Dim clientrow As DataRow
        Dim projectrow As DataRow
        Dim arParms() As SqlParameter = New SqlParameter(1) {}

        arParms(0) = New SqlParameter("@UserID", User.Identity.Name)
        arParms(1) = New SqlParameter("@ExpenseDate", System.DateTime.ParseExact(Request.QueryString("ExpenseDate"), "dd/MM/yyyy", en))
        DS = New DataSet
        DS = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, "TT_SelectUserProjects_AddProject", arParms)
        ' Name the tables
        DS.Tables(0).TableName = "Project"
        DS.Tables(1).TableName = "Client"
        ' Set up relationships
        DS.Relations.Add("Client_Proj", DS.Tables("Client").Columns("ClientID"), DS.Tables("Project").Columns("ClientID"))

        ' Build the following:
        '	<TR>
        ' 	<TH class="th4" id="menu2">
        ' 		<IMG id="menu2a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleDisplay(menu2a, menu2b, 'menu2');"
        ' 			height="16" alt="" src="../Images/down.gif" width="16" align="right" vspace="0"
        ' 			border="0">
        '       <TABLE>
        '         <TR>
        '           <TH>Client</TH>
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
        '         <TD>Project</TD>
        '         <TD>Checkbox</TD>
        '       </TR>
        '     </TABLE>
        '   </SPAN>
        ' </TD>
        '</TR>

        If DS.Tables("Client").Rows.Count = 0 Then
            lit = New LiteralControl
            projectPlace.Controls.Add(lit)
            lit.Text = "<center><b>No Projects available for selection</b>,<br> <i>Check with Admin that you are listed as a resource for the relevant projects</i></center>"

            btnSubmit.Enabled = False
        Else
            For Each clientrow In DS.Tables("Client").Rows
                menucount += 1
                row = New HtmlTableRow
                tblProjects.Rows.Add(row)
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
                cell.InnerHtml = clientrow.Item("Client")

                cell = New HtmlTableCell("th")
                row.Controls.Add(cell)
                cell.Attributes.Add("Width", "15%")
                cell.Attributes.Add("class", "th1")
                chk = New HtmlInputCheckBox
                cell.Controls.Add(chk)
                chk.ID = clientrow.Item("ClientID")
                chk.Attributes.Add("onclick", "TogglecheckAll(this);")
                '<label for="chktest">All</label>
                lit = New LiteralControl
                cell.Controls.Add(lit)
                lit.Text = "<label for='" & clientrow.Item("ClientID") & "'>Add all</label>"

                row = New HtmlTableRow
                tblProjects.Rows.Add(row)
                cell = New HtmlTableCell("td")
                row.Cells.Add(cell)
                spanlit = New HtmlGenericControl("Span")
                spanlit.ID = "menu" & menucount & "b"
                spanlit.Attributes.Add("Style", "display:block;")
                cell.Controls.Add(spanlit)

                Table = New HtmlTable
                spanlit.Controls.Add(Table)
                Table.Attributes.Add("width", "100%")

                For Each projectrow In clientrow.GetChildRows("Client_Proj")
                    ' Add the task to hidden text box for processing on submit
                    strValue &= "," & clientrow.Item("ClientID") & "_" & projectrow("ProjectID")

                    projecttableRow = New HtmlTableRow
                    Table.Controls.Add(projecttableRow)

                    projectCell = New HtmlTableCell("td")
                    projecttableRow.Controls.Add(projectCell)
                    projectCell.Attributes.Add("Width", "85%")
                    projectCell.ID = "lblTask_" & projectrow("ProjectID")
                    projectCell.InnerText = projectrow("Project")
                    projectCell.Attributes.Add("class", "label")
                    projectCell.ColSpan = 2

                    projectCell = New HtmlTableCell("td")
                    projecttableRow.Controls.Add(projectCell)
                    projectCell.Attributes.Add("Width", "15%")
                    chk = New HtmlInputCheckBox
                    projectCell.Controls.Add(chk)
                    chk.ID = "chkProj_" & clientrow.Item("ClientID") & "_" & projectrow("ProjectID")
                    projectCell.Attributes.Add("Align", "Center")

                Next
            Next

            hidBoxproj = New HtmlInputHidden
            hidBoxproj.ID = "hidBoxproj"
            hidBoxproj.Value = strValue
            projectPlace.Controls.Add(hidBoxproj)
        End If
  End Sub
#End Region

#Region " SUBMIT DETAILS "

  Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
    ' Add Selected Projects to UserProfile
    Dim a, NoRows, ProjID As Int16
    Dim ItemNo, Client As String
    Dim TaskArray, arrData As Array

    Dim arParms() As SqlParameter = New SqlParameter(1) {}

    a = 0
    NoRows = 0
    ItemNo = ""
    ItemNo = Request.Form("hidBoxproj")
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
        Client = arrData(0)
        ProjID = CInt(arrData(1))
        If Request.Form("chkProj_" & Client & "_" & ProjID) = "on" Then
          arParms(0) = New SqlParameter("@UserID", User.Identity.Name)
          arParms(1) = New SqlParameter("@ProjectID", ProjID)
          SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_AddProfileProjects", arParms)
        End If
      End While
    End If

    ' No Errors
    ' Re Load the calling window
    Response.Write("<script language=javascript>function window.onload() {closeAdd();}</script>")
  End Sub
#End Region

End Class
