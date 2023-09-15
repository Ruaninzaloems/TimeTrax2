Imports System.Web
Imports System.Web.SessionState
Imports System.Collections
Imports System.Security
Imports System.Security.Principal
Imports System.Threading
Imports System
Imports System.Data.SqlClient

Namespace BusinessLogicLayer

#Region " User Login Class "

    Public NotInheritable Class UserLogin


        Public Overloads Shared Function CustomAuthenticate(ByVal strUsername As String, ByVal strPassword As String) As Int32
            ' Set up parameters (2 input and 1 output) 
            Dim arParms() As SqlParameter = New SqlParameter(2) {}

            ' @Username Input Parameter 
            arParms(0) = New SqlParameter("@Username", SqlDbType.VarChar)
            arParms(0).Value = strUsername
            ' @Password Input Parameter 
            arParms(1) = New SqlParameter("@Password", SqlDbType.VarChar)
            arParms(1).Value = strPassword
            ' @UserID Output Parameter
            arParms(2) = New SqlParameter("@UserID", SqlDbType.Int)
            arParms(2).Direction = ParameterDirection.Output

            Try
                ' Execute the stored procedure
                SqlHelper.ExecuteNonQuery(ConfigurationSettings.AppSettings("DBConn"), CommandType.StoredProcedure, "Usr_ValidateUser", arParms)

                Dim UserID As Int32 = arParms(2).Value
                Return UserID

            Catch ex1 As Exception
                Throw ex1
            End Try
        End Function

        Public Overloads Shared Function CustomWinAuthenticate(ByVal strUsername As String) As Int32
            ' This function is used when WindowsAuthentication is used with FormsAuthentication,
            ' As WindowsAuthentication uses windows ACL (Access Control Lists) we do not need to verify the users password,
            ' because windows does all that for us, we only need to get the users UserID from the Db
            Dim arParms() As SqlParameter = New SqlParameter(1) {}

            ' @Username Input Parameter 
            ' look for the user in the DB and get roles if found
            arParms(0) = New SqlParameter("@UserName", strUsername)
            arParms(1) = New SqlParameter("@UserID", SqlDbType.Int)
            arParms(1).Direction = ParameterDirection.Output

            Try
                ' Execute the stored procedure
                SqlHelper.ExecuteNonQuery(ConfigurationSettings.AppSettings("DBConn"), CommandType.StoredProcedure, "Usr_getUserID", arParms)

                Dim UserID As Int32 = arParms(1).Value
                Return UserID

            Catch ex1 As Exception
                Throw ex1
            End Try
        End Function
        Public Overloads Shared Function GetUserRoles(ByVal authID As String)
            ' This is currently called from Global.asax.vb file
            Dim strRoles() As String
            Dim arrRoles As New ArrayList

            arrRoles = GetModuleRoles("Usr_SelectUserRoles", arrRoles, authID)

            strRoles = CType(arrRoles.ToArray(GetType(String)), String())
            Return strRoles
        End Function

        Public Overloads Shared Function GetModuleRoles(ByVal SProc As String, ByVal arrRoles As ArrayList, ByVal authID As String) As ArrayList

            Dim DR As SqlDataReader
            DR = SqlHelper.ExecuteReader(ConfigurationSettings.AppSettings("DBConn"), SProc, authID)
            While DR.Read()
                arrRoles.Add(DR("Role"))
            End While
            DR.Close()

            'return the updated roles array list
            Return arrRoles
        End Function

        Public Overloads Shared Function CheckUserAccess(ByVal strRole As String, ByVal Context As HttpContext, ByVal Redirect As Boolean) As Boolean
            ' A list of strRoles can be found in the RoleName Table
            If Not Context.User.IsInRole(strRole) Then
                ' User Does not have Access to requested page
                If Redirect Then
                    ' redirect to start Page
                    Context.Response.Redirect(Context.Request.ApplicationPath & "/default.aspx")
                End If
                Return False
            End If
            Return True
        End Function

        '/// Checks if User has any one of the Roles passed in
        Public Overloads Shared Function CheckUserAccess(ByVal strRole As ArrayList, ByVal Context As HttpContext, ByVal Redirect As Boolean) As Boolean

            ' A list of strRoles can be found in the RoleName Table
            Dim i As Integer
            Dim blnAllOK As Boolean = False
            For i = 0 To (strRole.Count - 1)
                If Not Context.User.IsInRole(strRole(i)) Then
                    blnAllOK = False
                Else
                    blnAllOK = True
                    Exit For
                End If
            Next

            If blnAllOK = False Then
                If Redirect Then
                    ' User Does not have Access to requested page so redirect to start Page
                    Context.Response.Redirect(Context.Request.ApplicationPath & "/Start.aspx")
                End If
            End If

            Return blnAllOK
        End Function

    End Class

#End Region

#Region " TabItem Class "

    '*********************************************************************
    '
    ' TabItem Class
    '
    ' A class is used instead
    ' of a struct so a parameterized constructor could be used.
    '
    'Should add Target for the option  to open in a new window
    '
    '*********************************************************************

    Public Class TabItem 'portal tabs
        Private _name As String
        Private _path As String
        Private _display As String

        Public Sub New(ByVal newName As String, ByVal newPath As String)
            _name = newName
            _path = newPath
            _display = "block"
        End Sub 'New without passing in display type

        Public Sub New(ByVal newName As String, ByVal newPath As String, ByVal newDisplay As String)
            _name = newName
            If newDisplay = "none" Then
                _path = "#"
            Else
                _path = newPath
            End If
            _display = newDisplay
        End Sub 'New

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal Value As String)
                _name = Value
            End Set
        End Property

        Public Property Path() As String
            Get
                Return _path
            End Get
            Set(ByVal Value As String)
                _path = Value
            End Set
        End Property

        Public Property Display() As String
            Get
                Return _display
            End Get
            Set(ByVal Value As String)
                _display = Value
            End Set
        End Property

    End Class 'TabItem

    Public Class LeftTabs 'for modules left tab
        Private _name As String
        Private _path As String
        Private _display As String

        Public Sub New(ByVal newName As String, ByVal newPath As String)
            _name = newName
            _path = newPath
            _display = "block"
        End Sub 'New without passing in display type

        Public Sub New(ByVal newName As String, ByVal newPath As String, ByVal newDisplay As String)
            _name = newName
            If newDisplay = "none" Then
                _path = "#"
            Else
                _path = newPath
            End If
            _display = newDisplay
        End Sub 'New

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal Value As String)
                _name = Value
            End Set
        End Property

        Public Property Path() As String
            Get
                Return _path
            End Get
            Set(ByVal Value As String)
                _path = Value
            End Set
        End Property

        Public Property Display() As String
            Get
                Return _display
            End Get
            Set(ByVal Value As String)
                _display = Value
            End Set
        End Property

    End Class 'LeftTabs

    Public Class TopTabs 'for modules Top tab
        Private _name As String
        Private _path As String
        Private _display As String

        Public Sub New(ByVal newName As String, ByVal newPath As String)
            _name = newName
            _path = newPath
            _display = "block"
        End Sub 'New without passing in display type

        Public Sub New(ByVal newName As String, ByVal newPath As String, ByVal newDisplay As String)
            _name = newName
            If newDisplay = "none" Then
                _path = "#"
            Else
                _path = newPath
            End If
            _display = newDisplay
        End Sub 'New

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal Value As String)
                _name = Value
            End Set
        End Property

        Public Property Path() As String
            Get
                Return _path
            End Get
            Set(ByVal Value As String)
                _path = Value
            End Set
        End Property

        Public Property Display() As String
            Get
                Return _display
            End Get
            Set(ByVal Value As String)
                _display = Value
            End Set
        End Property
    End Class 'TopTabs
#End Region


End Namespace