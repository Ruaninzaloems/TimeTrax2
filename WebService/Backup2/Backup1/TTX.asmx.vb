Imports System.Web.Services
Imports Intermap.DataLayer

<System.Web.Services.WebService(Namespace:="http://tempuri.org/TimeTraX/TTX")> _
Public Class TTX
  Inherits System.Web.Services.WebService

#Region " Web Services Designer Generated Code "

  Public Sub New()
    MyBase.New()

    'This call is required by the Web Services Designer.
    InitializeComponent()

    'Add your own initialization code after the InitializeComponent() call

  End Sub

  'Required by the Web Services Designer
  Private components As System.ComponentModel.IContainer

  'NOTE: The following procedure is required by the Web Services Designer
  'It can be modified using the Web Services Designer.  
  'Do not modify it using the code editor.
  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
    components = New System.ComponentModel.Container
  End Sub

  Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
    'CODEGEN: This procedure is required by the Web Services Designer
    'Do not modify it using the code editor.
    If disposing Then
      If Not (components Is Nothing) Then
        components.Dispose()
      End If
    End If
    MyBase.Dispose(disposing)
  End Sub

#End Region

#Region " STANDARD DECLARES "
  Dim DBConn = ConfigurationSettings.AppSettings("DBConnStr")
  Dim sqlConn As SqlConnection
  Dim DR As SqlDataReader
  Dim arParms() As SqlParameter = New SqlParameter(0) {}
    Dim en As New System.Globalization.CultureInfo("en-Za")
#End Region

  <WebMethod()> _
 Public Function GetCostCentreRate(ByVal UserID As Integer, ByVal CostCentreID As Integer, ByVal FieldName As String) As String
    ' This function returns the users relevant costcentre rate
    Dim arParms1() As SqlParameter = New SqlParameter(2) {}
    arParms1(0) = New SqlParameter("@UserID", UserID)
    arParms1(1) = New SqlParameter("@CostCentreID", CostCentreID)
    arParms1(2) = New SqlParameter("@Rate", SqlDbType.Float, 8) ' Output
    arParms1(2).Direction = ParameterDirection.Output

    SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_WS_GetUserRate", arParms1)
    Dim res As String = arParms1(2).Value
    ' Return the field that the value was retreived for in the result string delimited by a #
    res = res & "#" & FieldName
    Return res

    End Function

    <WebMethod()> _
   Public Function InsertTime(ByVal UserID As Integer, ByVal CasePlanID As Integer, ByVal EventID As Integer, ByVal Hrs As Decimal, ByVal TimeBase As Integer) As String()
        Dim ReturnArray() As String = New String(4) {}
        Dim arParms2() As SqlParameter = New SqlParameter(6) {}
        arParms2(0) = New SqlParameter("@UserID", UserID)
        arParms2(1) = New SqlParameter("@TaskID", "1") ' Only Case Tasks can be inserted using AVMS Time Popup
        arParms2(2) = New SqlParameter("@CasePlanID", CasePlanID)
        arParms2(3) = New SqlParameter("@EventID", IIf(EventID = 0, DBNull.Value, EventID))
        arParms2(4) = New SqlParameter("@ForDate", Today())
        arParms2(5) = New SqlParameter("@Hours", Hrs)
        arParms2(6) = New SqlParameter("@TimeBase", TimeBase)
        'arParms2(7) = New SqlParameter("@ErrorStatus", SqlDbType.Int) ' Output
        'arParms2(7).Direction = ParameterDirection.Output

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "AVMS_WS_InsertUserTime", arParms2)
            ReturnArray(0) = ""
            ReturnArray(1) = ""
            ReturnArray(2) = ""
            ReturnArray(3) = ""
            ReturnArray(4) = ""
        Catch ex As SqlException
            ReturnArray(0) = ex.Number & " - " & ex.Message
            ReturnArray(1) = UserID
            ReturnArray(2) = CasePlanID
            ReturnArray(3) = EventID
            ReturnArray(4) = Hrs
        End Try

        Return ReturnArray

    End Function

    <WebMethod()> _
    Public Function CheckIfProjectResource(ByVal intUserID As Integer, _
                                       ByVal intProjectID As Integer) As Boolean

        Dim blnIsResource As Boolean = False

        Dim arParms() As SqlParameter = New SqlParameter(1) {}
        arParms(0) = New SqlParameter("@UserID", intUserID)
        arParms(1) = New SqlParameter("@ProjectID", intProjectID)

        Dim result As Int16 = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, "TT_WS_CheckIfProjectResource", arParms)

        If result > 0 Then
            blnIsResource = True
        Else
            blnIsResource = False
        End If

        Return blnIsResource

    End Function


    Private Function GetUserName(ByVal UserID As Integer) As String
        Dim arParms1() As SqlParameter = New SqlParameter(1) {}
        arParms1(0) = New SqlParameter("@UserID", UserID)
        arParms1(1) = New SqlParameter("@FullName", SqlDbType.VarChar, 50) ' Output
        arParms1(1).Direction = ParameterDirection.Output

        SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "AVMS_WS_GetUserName", arParms1)
        Dim res As String = arParms1(1).Value
        Return res

    End Function


End Class
