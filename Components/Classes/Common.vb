Imports System.Security.Principal


Public NotInheritable Class Common
    Public Enum ApprovalType
        ProjectTakeOn = 1
        Timesheet = 2
        Expense = 3
        VariationOrder = 4
        TimeOff = 5
        FinancialDocument = 6
    End Enum

    'Public Shared Function BuildXMLFile(ByVal StoredProc As String)
    '  Dim strXml As String
    '  Dim xr As XmlTextReader
    '  Dim Conn As New SqlConnection(DBConn)

    '  'Conn.Open()
    '  xr = SqlHelper.ExecuteXmlReader(Conn, CommandType.StoredProcedure, StoredProc)

    '  'create the document prolog
    '  strXml = "<?xml version='1.0'?>" & _
    '                "<DOCUMENT>"
    '  'read the first result row and then read remainder
    '  strXml &= xr.GetRemainder().ReadToEnd()

    '  'add the document epilog
    '  strXml &= "</DOCUMENT>"

    '  xr.Close() ' close the reader
    '  Conn.Close() ' close the connection
    '  Xmlresult.DocumentContent = strXml

    '  ViewState("xmlfile") = "data.xml"
    '  Xmlresult.Document.Save(Server.MapPath(ViewState("xmlfile")))
    '  'return the path to the XML document object to the calling routine
    '  Return strXml
    'End Function
    Public Shared Function ChangeProjectStatus(ByVal ProjID As Integer, ByVal Status As Integer) As String

        Dim DBConn = ConfigurationSettings.AppSettings("DBConn")
        Dim arParms() As SqlParameter = New SqlParameter(2) {}
        Dim strStatus As String
        Dim strErr As String
        Dim strMess As String

        arParms(0) = New SqlParameter("@ProjID", ProjID)
        arParms(1) = New SqlParameter("@StatusID", Status)
        arParms(2) = New SqlParameter("@ErrorStatus", SqlDbType.Int)    ' Output
        arParms(2).Direction = ParameterDirection.Output

        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_UpdateProjectStatus", arParms)
        Return ""

    End Function

    Public Shared Sub SetUserCookie(ByVal contxt As HttpContext, ByVal UserID As Int32)
        ' Set up parameters (1 input and 4 output) 
        Dim arParms() As SqlParameter = New SqlParameter(5) {}

        ' @Username Input Parameter 
        arParms(0) = New SqlParameter("@UserID", SqlDbType.Int)
        arParms(0).Value = UserID
        ' @FirstName Output Parameter 
        arParms(1) = New SqlParameter("@FirstName", SqlDbType.VarChar, 50)
        arParms(1).Direction = ParameterDirection.Output
        ' @LastName Output Parameter
        arParms(2) = New SqlParameter("@LastName", SqlDbType.VarChar, 50)
        arParms(2).Direction = ParameterDirection.Output
        ' @AccessID Output Parameter 
        arParms(3) = New SqlParameter("@GroupID", SqlDbType.Int)
        arParms(3).Direction = ParameterDirection.Output
        ' @BusinessUnitID Output Parameter 
        arParms(4) = New SqlParameter("@UnitID", SqlDbType.Int)
        arParms(4).Direction = ParameterDirection.Output
        arParms(5) = New SqlParameter("@UnitName", SqlDbType.VarChar, 100)
        arParms(5).Direction = ParameterDirection.Output

        ' Execute the stored procedure
        SqlHelper.ExecuteNonQuery(ConfigurationSettings.AppSettings("DBConn"), CommandType.StoredProcedure, "Usr_getUserDetails", arParms)

        Dim cookie As HttpCookie
        cookie = New HttpCookie("User")
        cookie.Values.Add("FirstName", arParms(1).Value.ToString())
        cookie.Values.Add("FullName", arParms(1).Value.ToString() & " " & arParms(2).Value.ToString())
        cookie.Values.Add("UserID", UserID)
        cookie.Values.Add("GroupID", arParms(3).Value.ToString())
        cookie.Values.Add("UnitID", arParms(4).Value.ToString())
        cookie.Values.Add("UnitName", arParms(5).Value.ToString())
        contxt.Response.AppendCookie(cookie)

    End Sub

    Public Shared Sub LoadRoles(ByVal contxt As HttpContext, ByVal authID As Int32)
        Dim strRoles() As String = UserLogin.GetUserRoles(authID)
        Dim objIdentity As GenericIdentity = New GenericIdentity(authID)
        contxt.Current.User = New GenericPrincipal(objIdentity, strRoles)
    End Sub

    Public Shared Function GetEmailForUser(ByVal UserID As Integer) As String
        Dim DR As SqlDataReader
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@UserID", UserID)

        DR = SqlHelper.ExecuteReader(ConfigurationSettings.AppSettings("DBConn"), CommandType.StoredProcedure, "Usr_LoadUserDetails", arParms)
        If DR.Read Then
            ' No Errors
            If Not IsDBNull(DR.Item("eMail")) Then
                Return DR.Item("eMail")
            Else
                Return ""
            End If
        End If
    End Function

    Public Shared Function GetIndexByValue(ByVal ddl As DropDownList, ByVal val As Object) As Int16
        Return ddl.Items.IndexOf(ddl.Items.FindByValue(val))
    End Function

    Public Shared Function GetIndexByText(ByVal ddl As DropDownList, ByVal txt As Object) As Int16
        Return ddl.Items.IndexOf(ddl.Items.FindByText(txt))
    End Function

    Public Shared Function LastOfMonth(ByVal day As Date) As Date
        Dim MonthEnd As Date
        Dim MonthStart As Date
        ' simple: get the 1st day of the month,
        MonthStart = DateSerial(day.Year, day.Month, 1)
        ' add a month to it, then it is the 1st day of next month
        ' then subtract a day, and it is the last day of this month
        MonthEnd = DateAdd(DateInterval.Day, -1, DateAdd(DateInterval.Month, 1, MonthStart))

        Return MonthEnd
    End Function


#Region " This is to export to Excel"
    Public Overloads Shared Function ExportExcel(ByVal Control As System.Object, ByVal Page As System.Object)
        Page.Response.ContentType = "application/vnd.ms-excel"
        ' Remove the charset from the Content-Type header.
        Page.Response.Charset = ""
        ' Turn off the view state.
        Page.EnableViewState = False

        Dim tw As New System.IO.StringWriter
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)

        ' Get the HTML for the control.
        Control.RenderControl(hw)
        ' Write the HTML back to the browser.
        Page.Response.Write(tw.ToString())
        ' End the response.
        Page.Response.End()

    End Function
#End Region

#Region "Report Functions"

    'Created by SD on 20/09/2005
    'Determines if the user string contains 0 (ie. Return all users) in which case
    'the filter is nothing/empty string
    Public Shared Function CalcUserString(ByVal strUserFilter As String) As String

        Dim strTemp() As String
        Dim intCount As Int16
        Dim blnAllFound As Boolean = False

        If strUserFilter Is Nothing Then
            'Return an empty filter
            Return String.Empty
        Else
            'Determine if All users has been selected
            strTemp = strUserFilter.Split(",")
        End If

        For intCount = 0 To strTemp.Length() - 1
            If strTemp(intCount) = 0 Then
                blnAllFound = True
                Exit For
            End If
        Next

        If blnAllFound Or strUserFilter Is Nothing Then
            'Return an empty filter indicating return all users 
            Return String.Empty
        Else

            'Put a comma on either end so that all users are searched for
            strUserFilter = "," & strUserFilter & ","

            'Return the original filter
            Return strUserFilter
        End If

    End Function

    'Created by: SD on 05/10/2005
    'Fills a list box with users for filtering reports
    Public Shared Sub LoadUsersList(ByVal lstUsers As ListBox)
        '-- Modified 23/01/2007 VF 
        '-- Only populate list with Logged In User, unless logged in user has role 'Can View All Users Reports'

        Dim ds As DataSet
        Dim drRow As DataRow
        ds = DAL.LoadResourcesDS(False)

        If Not (UserLogin.CheckUserAccess("68", System.Web.HttpContext.Current, False)) Then
            '-- User cannot view other users data
            ds = ApplyFilter(ds, "UserID = " & System.Web.HttpContext.Current.User.Identity.Name)
        Else
            drRow = ds.Tables(0).NewRow
            drRow.Item(0) = 0
            drRow.Item(1) = "All Users"
            ds.Tables(0).Rows.InsertAt(drRow, 0)
        End If


        lstUsers.DataSource = ds
        lstUsers.DataBind()

        lstUsers.SelectedIndex = 0

    End Sub

    'Created by: VF on 23/01/2007
    'Returns a Dataset with users for filtering reports
    Public Shared Function LoadUsers() As System.Data.DataSet
        '-- Modified 23/01/2007 VF 
        '-- Only populate list with Logged In User, unless logged in user has role 'Can View All Users Reports'

        Dim ds As DataSet
        Dim drRow As DataRow
        ds = DAL.LoadResourcesDS(False)

        If Not (UserLogin.CheckUserAccess("68", System.Web.HttpContext.Current, False)) Then
            '-- User cannot view other users data
            ds = ApplyFilter(ds, "UserID = " & System.Web.HttpContext.Current.User.Identity.Name)
        Else
            drRow = ds.Tables(0).NewRow
            drRow.Item(0) = 0
            drRow.Item(1) = "All Users"
            ds.Tables(0).Rows.InsertAt(drRow, 0)
        End If


        Return ds
    End Function

    Public Shared Function ApplyFilter(ByVal Ds As System.Data.DataSet, ByVal Filter As String) As System.Data.DataSet


        Dim dt As DataTable = Ds.Tables(0).Select(Filter).CopyToDataTable()
        Ds.Tables.Clear()
        Ds.Tables.Add(dt)
        Return Ds


    End Function

#Region "Building HTML Report Cells"

    Public Shared Sub AddSpacerCell(ByVal tableRow As HtmlTableRow, ByVal intNoToAdd As Int16)

        Dim tableCell As HtmlTableCell
        Dim intNo As Int16

        tableCell = New HtmlTableCell("td")
        tableRow.Cells.Add(tableCell)
        tableCell.Width = (intNoToAdd * 5).ToString & "%"
        tableCell.ColSpan = intNoToAdd
        tableCell.Attributes.Add("class", "td")
        tableCell.InnerHtml = ""

    End Sub

    Public Shared Sub AddHeaderCell(ByVal row As HtmlTableRow, ByVal strText As String, ByVal strWidth As String)

        Dim FirstLevelCell As New HtmlTableCell("th")

        row.Cells.Add(FirstLevelCell)
        FirstLevelCell.Attributes.Add("Width", strWidth)
        FirstLevelCell.Attributes.Add("class", "th1")
        FirstLevelCell.InnerHtml = strText

    End Sub

#End Region

#End Region

#Region "Null Functions"

    '--------------------------------------------------------------------------
    'Created by: SB
    'Created on: 26/11/2004
    'Purpose:    Returns a default value if the value passed in is blank
    'Inputs:     Value - the value that you are formatting
    '            DataType - the data type of the value to be formatted
    'Outputs:    The value passed in if it is not null OR
    '            a blank string if the data type is string OR
    '            zero if the data type is any numeric or money data type
    '--------------------------------------------------------------------------
    Public Overloads Shared Function cNull(ByVal Value As Object, ByVal DataType As VariantType) As Object

        Dim objRetVal As Object

        Select Case DataType

            Case VariantType.String

                If Value Is DBNull.Value Then
                    objRetVal = ""
                Else
                    objRetVal = Value
                End If

            Case VariantType.Variant.Date

                If Value Is DBNull.Value Then
                    objRetVal = Nothing
                Else
                    If Value = #12:00:00 AM# Then
                        objRetVal = Nothing
                    Else
                        objRetVal = Value
                    End If
                End If

            Case Else

                If Value Is DBNull.Value Then
                    objRetVal = 0
                ElseIf CStr(Value) = "" Then
                    objRetVal = 0
                Else
                    objRetVal = Value
                End If

        End Select

        Return objRetVal

    End Function

    '--------------------------------------------------------------------------
    'Created by: SB
    'Created on: 26/11/2004
    'Purpose:    Returns a default value if the numeric value passed in is blank
    'Inputs:     Value - the numeric value that you are formatting
    'Outputs:    The value passed in if it is not null OR
    '            zero if the value passed in is null
    '--------------------------------------------------------------------------
    Public Overloads Shared Function cNull(ByVal NumericValue As Object) As Object

        Dim objRetVal As Object

        objRetVal = cNull(NumericValue, VariantType.Integer)

        Return objRetVal

    End Function

#End Region

#Region "Loading Dropdowns"

    Public Shared Sub LoadMonthDropdown(ByVal ddlMonth As System.Web.Ui.webcontrols.DropDownList)

        AddDropDownItem(ddlMonth, "January", 1)
        AddDropDownItem(ddlMonth, "February", 2)
        AddDropDownItem(ddlMonth, "March", 3)
        AddDropDownItem(ddlMonth, "April", 4)
        AddDropDownItem(ddlMonth, "May", 5)
        AddDropDownItem(ddlMonth, "June", 6)
        AddDropDownItem(ddlMonth, "July", 7)
        AddDropDownItem(ddlMonth, "August", 8)
        AddDropDownItem(ddlMonth, "September", 9)
        AddDropDownItem(ddlMonth, "October", 10)
        AddDropDownItem(ddlMonth, "November", 11)
        AddDropDownItem(ddlMonth, "December", 12)

    End Sub

    Public Shared Function AddDropDownItem(ByVal ddl As System.Web.Ui.webcontrols.DropDownList, _
                                           ByVal strDesc As String, ByVal intValue As Int16)

        Dim ddlItem As New WebControls.ListItem
        ddlItem.Text = strDesc
        ddlItem.Value = intValue
        ddl.Items.Add(ddlItem)

    End Function

    Public Shared Sub LoadYearDropDown(ByRef ddlYear As System.Web.Ui.webcontrols.DropDownList, _
                                       ByVal intNoYearsBack As Int16, ByVal intNoYearsForward As Int16)

        Dim intCurrentYear As Integer
        Dim item As ListItem
        Dim intCount As Int16

        intCurrentYear = Now.Year

        For intCount = intCurrentYear - intNoYearsBack To intCurrentYear + intNoYearsForward
            ddlYear.Items.Add(intCount)
        Next
        item = ddlYear.Items.FindByValue(intCurrentYear)
        If (Not item Is Nothing) Then item.Selected = True

    End Sub

#End Region

End Class

