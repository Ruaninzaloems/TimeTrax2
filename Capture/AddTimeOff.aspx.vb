Public Class AddTimeOff
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents tblTypes As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents chktest As System.Web.UI.WebControls.CheckBox
    Protected WithEvents typesPlace As System.Web.UI.WebControls.PlaceHolder

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
            LoadTimeOffTypes()
        End If

    End Sub

    Sub LoadTimeOffTypes()
        Dim hidBoxtype As HtmlInputHidden
        Dim strValue As String
        Dim menucount As Integer = 0
        Dim row As HtmlTableRow = New HtmlTableRow
        Dim cell As HtmlTableCell = New HtmlTableCell
        Dim Table As HtmlTable = New HtmlTable
        Dim img As HtmlImage
        Dim chk As HtmlInputCheckBox
        Dim spanlit As HtmlGenericControl
        Dim lit As LiteralControl
        Dim typetableRow As HtmlTableRow = New HtmlTableRow
        Dim typeCell As HtmlTableCell = New HtmlTableCell
        Dim typerow As DataRow

        DS = New DataSet
        DS = DAL.GetTimeOffTypes_AddTimeOff(User.Identity.Name)
        ' Name the tables
        DS.Tables(0).TableName = "Type"

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

        If DS.Tables("Type").Rows.Count = 0 Then
            lit = New LiteralControl
            typesPlace.Controls.Add(lit)
            lit.Text = "<center><b>No TimeOff Types available for selection !</b></center>"

            btnSubmit.Enabled = False
        Else
            menucount += 1
            row = New HtmlTableRow
            tblTypes.Rows.Add(row)
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
            cell.InnerHtml = "TimeOff"

            cell = New HtmlTableCell("th")
            row.Controls.Add(cell)
            cell.Attributes.Add("Width", "15%")
            cell.Attributes.Add("class", "th1")
            chk = New HtmlInputCheckBox
            cell.Controls.Add(chk)
            chk.ID = "TimeOff"
            chk.Attributes.Add("onclick", "TogglecheckAll(this);")
            '<label for="chktest">All</label>
            lit = New LiteralControl
            cell.Controls.Add(lit)
            lit.Text = "<label for='TimeOff'>Add all</label>"

            row = New HtmlTableRow
            tblTypes.Rows.Add(row)
            cell = New HtmlTableCell("td")
            row.Cells.Add(cell)
            spanlit = New HtmlGenericControl("Span")
            spanlit.ID = "menu" & menucount & "b"
            spanlit.Attributes.Add("Style", "display:block;")
            cell.Controls.Add(spanlit)

            Table = New HtmlTable
            spanlit.Controls.Add(Table)
            Table.Attributes.Add("width", "100%")

            For Each typerow In DS.Tables("Type").Rows
                ' Add the task to hidden text box for processing on submit
                strValue &= ",TimeOff_" & typerow("TypeID")

                typetableRow = New HtmlTableRow
                Table.Controls.Add(typetableRow)

                typeCell = New HtmlTableCell("td")
                typetableRow.Controls.Add(typeCell)
                typeCell.Attributes.Add("Width", "85%")
                typeCell.ID = "lblTask_" & typerow("TypeID")
                typeCell.InnerText = typerow("Type")
                typeCell.Attributes.Add("class", "label")
                typeCell.ColSpan = 2

                typeCell = New HtmlTableCell("td")
                typetableRow.Controls.Add(typeCell)
                typeCell.Attributes.Add("Width", "15%")
                chk = New HtmlInputCheckBox
                typeCell.Controls.Add(chk)
                chk.ID = "chkTask_TimeOff_" & typerow("TypeID")
                typeCell.Attributes.Add("Align", "Center")

                Next

            hidBoxtype = New HtmlInputHidden
            hidBoxtype.ID = "hidBoxtasks"
            hidBoxtype.Value = strValue
            typesPlace.Controls.Add(hidBoxtype)
        End If

    End Sub
#End Region

#Region " SUBMIT DETAILS "

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        ' Add Selected Tasks to UserProfile
        Dim a, NoRows, TypeID As Int16
        Dim ItemNo As String
        Dim TypeArray, arrData As Array

        Dim arParms() As SqlParameter = New SqlParameter(1) {}

        a = 0
        NoRows = 0
        ItemNo = ""
        ItemNo = Request.Form("hidBoxtasks")
        If ItemNo <> "" And ItemNo <> "," Then
            Try
                TypeArray = ItemNo.Split(",")
                NoRows = (TypeArray.Length - 1)
            Catch
            End Try

            While a < NoRows
                a += 1
                ItemNo = TypeArray(a)
                arrData = ItemNo.Split("_")
                TypeID = CInt(arrData(1))
                If Request.Form("chkTask_TimeOff_" & TypeID) = "on" Then
                    DAL.AddProfileTOTypes(User.Identity.Name, TypeID)
                End If
            End While
        End If

        ' No Errors
        ' Re Load the calling window
        Response.Write("<script language=javascript>function window.onload() {closeAdd();}</script>")
    End Sub
#End Region

End Class
