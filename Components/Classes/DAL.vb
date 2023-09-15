Public Class DAL
    Private Shared DBConn = ConfigurationSettings.AppSettings("DBConn")
    Private Shared Parms() As SqlParameter

#Region " protected variables "
    Protected proc As String
    Protected sparam() As SqlParameter
    Protected trans As SqlTransaction
    Protected en As New System.Globalization.CultureInfo("en-Za")
#End Region

#Region " Private: "
    '<summary>
    ' This function displays the stored procedure name and parameters of the sql parameter array
    '</summary>
    '<parm name="proc">This is the Stored Procedure name</parm>
    '<parm name="arparms">This is the sqlParameter array</parm>
    Private Shared Function DisplayParameters(ByVal proc As String, ByVal arparms() As SqlParameter) As String
        Dim k As Int16
        Dim linebreak As String = "<br>"
        Dim errmsg As String = "Error executing " & proc & ":" & linebreak

        For k = 0 To arparms.Length - 1
            errmsg &= arparms(k).ParameterName & " : " & arparms(k).Value.ToString & linebreak
        Next
        Return errmsg
    End Function

    '<summary>
    ' This function gets a stored procedures' parameters and returns the sql parameter array
    '</summary>
    '<parm name="proc">This is the Stored Procedure name</parm>
    Private Shared Function cacheParams(ByVal proc As String) As SqlParameter()
        Dim sparam() As SqlParameter
        sparam = SqlHelperParameterCache.GetCachedParameterSet(DBConn, proc)
        If (sparam Is Nothing) Then
            sparam = SqlHelperParameterCache.GetSpParameterSet(DBConn, proc)
            SqlHelperParameterCache.CacheParameterSet(DBConn, proc, sparam)
            sparam = SqlHelperParameterCache.GetCachedParameterSet(DBConn, proc)
        End If
        Return sparam

    End Function
#End Region

#Region "Admin"
    Public Shared Function AddUpdateTimeOffType(ByVal TypeID As String, ByVal Description As String, ByVal Enabled As Boolean)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_AddUpdateTimeOffType"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = TypeID
        Parms(1).Value = Description
        Parms(2).Value = Enabled
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function GenerateClientCode() As String
        ' Adding Data to the DB
        Dim MyData As String

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_GenerateClientCode"
        Parms = DAL.cacheParams(spname)
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function GetContacts(ByVal ManConst As Int16) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectContact"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ManConst
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function GetTimeOffTypes(ByVal ManConst As Int16) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectTimeOffTypes"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ManConst
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function LoadSystemData() As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectSystem"
        Parms = DAL.cacheParams(spname)
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function LoadTimeOffType(ByVal TypeID As Integer) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectTimeOffTypeInfo"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = TypeID
        Try
            MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    'Created by SB on 01/08/2005
    'Retrieve a list of enabled order items or just the order item specified
    'Inputs: OrderItemID = 0 returns all enabled OrderItems
    Public Shared Function LoadOrderItems(ByVal intOrderItemID As Integer) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectOrderItem"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = intOrderItemID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
#End Region

#Region "General"
    Public Shared Function GetUserGroup(ByVal UserID As String) As String
        ' Adding Data to the DB
        Dim MyData As String

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectUserGroup"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
#End Region

#Region "Project Info"
    Public Shared Function AddUpdateResource(ByVal ResourceID As String, _
                                             ByVal UserID As String, _
                                             ByVal ProjectID As String, _
                                             ByVal Rate As String, _
                                             ByVal Approver1 As String, _
                                             ByVal Approver2 As String, _
                                             ByVal TSLastApprover As String, _
                                             ByVal TeamLeader As String, _
                                             ByVal Enabled As Boolean) As String
        Dim MyData As String
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_AddUpdateProjectResources"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = IIf(ResourceID = "", DBNull.Value, ResourceID)
        Parms(1).Value = IIf(UserID = String.Empty, DBNull.Value, UserID)
        Parms(2).Value = ProjectID
        Parms(3).Value = IIf(Rate = String.Empty, DBNull.Value, Rate)
        Parms(4).Value = IIf(Approver1 = "", DBNull.Value, Approver1)
        Parms(5).Value = IIf(Approver2 = "", DBNull.Value, Approver2)
        Parms(6).Value = IIf(TSLastApprover = "", DBNull.Value, TSLastApprover)
        Parms(7).Value = IIf(TeamLeader = "", DBNull.Value, TeamLeader)
        Parms(8).Value = IIf(Enabled, 1, 0)  'SD: 05/09/2005 - Add field inidcating if the user is enabled

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
            MyData = Parms(9).Value
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
        Return MyData
    End Function

    Public Shared Function EnableDisableProjectResource(ByVal ProjectID As String, _
                                                        ByVal ResourceID As String, _
                                                        ByVal Enabled As Boolean)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_EnableDisableProjectResource"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = ResourceID
        Parms(2).Value = IIf(Enabled, 1, 0)

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

    End Function


    Public Shared Function ChangeOrderStage(ByVal OrderID As String, ByVal ApprovalStage As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_UpdateOrderApprovalStage"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = OrderID
        Parms(1).Value = ApprovalStage
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function ChangeProjectEndDate(ByVal ProjectID As String, ByVal EndDate As String)
        ' Set Parameters needed for stored proc
        Dim en As New System.Globalization.CultureInfo("en-Za")
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_UpdateProjectEndDate"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = System.DateTime.ParseExact(EndDate, "dd/MM/yyyy", en)
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function GetProjects(ByVal StatusID As Int16) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectProjects"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = StatusID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function GetPTOApproverRole(ByVal count As Int32) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectPTOApprover" & count & "Role"
        Parms = DAL.cacheParams(spname)
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function GetTeamLeaderRoleID() As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_GetTeamLeaderRoleID"
        Parms = DAL.cacheParams(spname)
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function GetTSApproverRole(ByVal count As Int32) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectTSApprover" & count & "Role"
        Parms = DAL.cacheParams(spname)
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function GetUserProjectRate(ByVal UserID As String, ByVal ProjectID As String) As String
        ' Adding Data to the DB
        Dim MyData As String

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectUserProjectRate"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = ProjectID
        Try
            MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function LoadCurrentProjectOrder(ByVal ProjectID As Integer, ByVal Approval As Int16) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectProjectCurrentOrder"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = Approval
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadLastApprovedProjectOrder(ByVal ProjectID As Integer) As Integer
        ' Adding Data to the DB
        Dim MyData As Integer

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectLastApprovedProjectOrder"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Try
            MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function LoadProjectDetails(ByVal ProjectID As Integer) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectPTODetails"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadProjectListing(ByVal ManagerID As Integer, _
                                              ByVal TeamLeaderID As Integer, _
                                              ByVal ClientID As Integer, _
                                              ByVal StatusID As Integer, _
                                              ByVal UserID As Integer) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectProjectListing"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = TeamLeaderID
        Parms(1).Value = ClientID
        Parms(2).Value = StatusID
        Parms(3).Value = UserID       'SB: 05/09/2005 - Pass in the logged on user so that we can check if they have the role("Project Information Report")
        Parms(4).Value = ManagerID    'SD: 03/02/2010 - Add manager as a filter
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadOrderInfo(ByVal OrderID As Integer) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectOrderInfo"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = OrderID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadFinancialDocumentType(ByVal FinancialDocTypeID As Integer) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectFinancialDocumentType"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = FinancialDocTypeID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadProjectOrderSummaries(ByVal ProjectID As Integer) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectProjectOrderSummaries"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadFinancialDocumentOrderSummaries(ByVal ProjectID As Integer, ByVal FinancialDocumentID As Integer) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectFinancialDocumentOrderSummaries"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = FinancialDocumentID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadFinancialDocumentDetails(ByVal FinancialDocumentID As Integer) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectFinancialDocumentDetails"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = FinancialDocumentID

        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadProjects(ByVal UserID As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectMyProjects"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function LoadProjectResources(ByVal ProjectID As Integer) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectProjectResources"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID

        Try
            MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadProjectResourcesDetails(ByVal ProjectID As Integer, _
                                                       ByVal ResourceID As Integer) As SqlDataReader
        ' Adding Data to the DB
        Dim dr As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectProjectResourceDetail"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = ResourceID

        Try
            dr = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return dr
    End Function

    'SD: 03/02/2010 - Add the ProjectID so that if you are adding a team member you can load only people
    '       who are not on the project already  - ProjectID = 0 show all resources otherwise only show people not 
    '       on the specified project
    Public Shared Function LoadResources(Optional ByVal blnEnabledOnly As Boolean = True, _
                                         Optional ByVal intProjectID As Integer = 0) As SqlDataReader

        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectResource"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = blnEnabledOnly
        Parms(1).Value = intProjectID

        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    'SD: 03/02/2010 - Add the ProjectID so that if you are adding a team member you can load only  people
    '       who are not on the project already - ProjectID = 0 = show all resources otherwise only show people not 
    '       on the specified project
    Public Shared Function LoadResourcesDS(Optional ByVal blnEnabledOnly As Boolean = True, _
                                           Optional ByVal intProjectID As Integer = 0) As DataSet

        ' Adding Data to the DB
        Dim MyData As DataSet
        Dim spname As String = "TT_SelectResource"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = blnEnabledOnly
        Parms(1).Value = intProjectID

        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)

        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadProjectDocuments(ByVal ProjectID As Integer) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectProjectDocuments"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = HttpContext.Current.Request.ApplicationPath & "/" & ConfigurationSettings.AppSettings("UploadsVirtual")

        Try

            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)

        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadFinancialDocuments(ByVal ProjectID As Integer) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectFinancialDocuments"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = HttpContext.Current.Request.ApplicationPath & "/" & ConfigurationSettings.AppSettings("UploadsVirtual")

        Try

            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)

        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    'Created by:    SB on 10/08/2005
    'Retrieves a list of project indicating their recent activity
    Public Shared Function LoadProjectCloseOutList(ByVal blnPassedEndDate As Boolean, _
                                                   ByVal intTeamLeaderID As Integer, _
                                                   ByVal intClientID As Integer) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_GetProjectCloseOutList"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = IIf(blnPassedEndDate, 1, 0)
        Parms(1).Value = intTeamLeaderID
        Parms(2).Value = intClientID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    'SD: 09/09/2005 - Function updates the teamleader for the specified project
    Public Shared Sub ChangeTeamLeader(ByVal ProjectID As Integer, _
                                       ByVal UserID As Integer, _
                                       ByVal Rate As Decimal)

        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_UpdateTeamLeader"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = UserID
        Parms(2).Value = Rate

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)

        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

    End Sub

    'SD: 03/02/2010 - Function updates the manager for the specified project
    Public Shared Sub ChangeManager(ByVal ProjectID As Integer, _
                                       ByVal UserID As Integer, _
                                       ByVal Rate As Decimal)

        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_UpdateManager"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = UserID
        Parms(2).Value = Rate

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)

        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

    End Sub


#End Region

#Region "Take On"
    Public Shared Function GenerateProjectCode(ByVal ClientID As String) As String
        ' Adding Data to the DB
        Dim MyData As String

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_GenerateProjectCode"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ClientID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function ValidateProjectCode(ByVal ClientID As String, ByVal ProjectCode As String) As Boolean
        ' Adding Data to the DB
        Dim MyData As Boolean

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_ValidateProjectCode"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ClientID
        Parms(1).Value = ProjectCode
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadClients(ByVal ManConst As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectClient"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ManConst
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadClientInfo(ByVal intClientID As Integer) As SqlDataReader

        Dim MyData As SqlDataReader
        Dim spname As String = "TT_SelectClientInfo"

        Parms = DAL.cacheParams(spname)
        Parms(0).Value = intClientID

        Try
            MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadContactInfo(ByVal intContactID As Integer) As SqlDataReader

        Dim MyData As SqlDataReader
        Dim spname As String = "TT_SelectContactInfo"

        Parms = DAL.cacheParams(spname)
        Parms(0).Value = intContactID

        Try
            MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadStatuses() As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectStatus"
        Parms = DAL.cacheParams(spname)
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function LoadTeamLeaders() As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectLeadResource"
        Parms = DAL.cacheParams(spname)
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function LoadTimesheetApprovers(ByVal ApproverRoleID As Integer) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectTimesheetApprover"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ApproverRoleID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
#End Region

#Region "Profiles"
    Public Shared Function AddProfileTOTypes(ByVal UserID As String, ByVal TypeID As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_AddProfileTOTypes"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = TypeID
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function AddProfileTasks(ByVal UserID As String, ByVal TaskID As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_AddProfileTasks"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = TaskID
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function UpdateProfileTSApproval(ByVal UserID As String, ByVal Grouping As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_AddUpdateTSApprovalProfile"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = Grouping
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function LoadProfileTSApproval(ByVal UserID As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectUserTSApprovalProfile"
        Parms = DAL.cacheParams(spname)
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                Parms(0).Value = UserID
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function DeleteProfileProject(ByVal UserID As String, ByVal ProjectID As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_DeleteProfileProject"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = ProjectID
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
#End Region

#Region "Timesheet Capture"
    Public Shared Function GetTimeOffTypes_AddTimeOff(ByVal UserID As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectTimeOffTypes_AddTimeOff"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function GetUserProjectTasks(ByVal UserID As String, _
                                               ByVal TimesheetDate As Date) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectUserProjects_AddTask"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = TimesheetDate
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function OverDueTimesheets(ByVal UserID As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectOverDueTimesheets"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function GetTimesheetsAwaitingApproval(ByVal UserID As String, ByVal ApplicationPath As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectTimesheetsAwaitingApprovalForUser"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = ApplicationPath
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function DeleteTimeOff(ByVal UserID As String, ByVal TypeID As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_DeleteUserTimeOff"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = TypeID
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function UpdateTimeOff(ByVal UserID As String, ByVal TimeBase As String, ByVal TypeID As String, ByVal ForDate As String, ByVal Hours As String, ByVal Comment As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_UpdateUserTimeOff"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = TimeBase
        Parms(2).Value = TypeID
        Parms(3).Value = ForDate
        Parms(4).Value = Hours
        Parms(5).Value = Comment
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function DeleteTimesheet(ByVal UserID As String, ByVal TaskID As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_DeleteUserTimeSheet"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = TaskID
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function UpdateTimesheet(ByVal UserID As String, ByVal TimeBase As String, ByVal TaskID As String, ByVal ForDate As String, ByVal Hours As String, ByVal Comment As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_UpdateUserTimeSheet"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = TimeBase
        Parms(2).Value = TaskID
        Parms(3).Value = ForDate
        Parms(4).Value = Hours
        Parms(5).Value = Comment
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function RecallTimesheet(ByVal UserID As String, ByVal StartDate As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_RecallUserTimesheet"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = StartDate
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function SubmitTimeSheet(ByVal UserID As String, ByVal StartDate As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_SubmitUserTimesheet"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = StartDate
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
    Public Shared Function SubmitTimeOff(ByVal UserID As String, ByVal StartDate As String)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_SubmitUserTimeOff"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = StartDate
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
#End Region

#Region "Approvals"
    Public Shared Function SelectTimesheetsForApproval(ByVal UserID As String, ByVal StartDate As String, ByVal TimeBase As String, ByVal Grouping As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = "Project" Then
            spname = "TT_SelectTimesheetApprovals_ByProject"
        Else
            spname = "TT_SelectTimesheetApprovals_ByResource"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = StartDate
        Parms(2).Value = TimeBase
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function SelectTimesheetsForApprovalManager(ByVal UserID As String, ByVal StartDate As String, ByVal TimeBase As String, ByVal Grouping As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = "Project" Then
            spname = "TT_SelectTimesheetApprovalsManager_ByProject"
        Else
            spname = "TT_SelectTimesheetApprovalsManager_ByResource"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = StartDate
        Parms(2).Value = TimeBase
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function SelectTimesheetsForApprovalManagerMonitor(ByVal UserID As String, ByVal StartDate As String, ByVal TimeBase As String, ByVal Grouping As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = "Project" Then
            spname = "TT_SelectTimesheetApprovalsManagerMonitor_ByProject"
        Else
            spname = "TT_SelectTimesheetApprovalsManagerMonitor_ByResource"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = StartDate
        Parms(2).Value = TimeBase
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function SelectTimesheetsForApprovalMD(ByVal UserID As String, ByVal StartDate As String, ByVal TimeBase As String, ByVal Grouping As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = "Project" Then
            spname = "TT_SelectTimesheetApprovalsMD_ByProject"
        Else
            spname = "TT_SelectTimesheetApprovalsMD_ByResource"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = StartDate
        Parms(2).Value = TimeBase
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function SelectTimeOffForApproval(ByVal UserID As String, ByVal StartDate As String, ByVal TimeBase As String, ByVal Grouping As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = "Project" Then
            spname = "TT_SelectTimeOffApprovals_ByProject"
        Else
            spname = "TT_SelectTimeOffApprovals_ByResource"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = StartDate
        Parms(2).Value = TimeBase
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function SelectExpenseForApprovals(ByVal UserID As String, ByVal FirstDay As String, ByVal Grouping As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = "Client" Then
            spname = "TT_SelectExpenseApprovals_ByClient"
        Else
            spname = "TT_SelectExpenseApprovals_ByResource"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = FirstDay
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function SelectExpenseForApprovalsManager(ByVal UserID As String, ByVal FirstDay As String, ByVal Grouping As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = "Client" Then
            spname = "TT_SelectExpenseApprovalsManager_ByClient"
        Else
            spname = "TT_SelectExpenseApprovalsManager_ByResource"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = FirstDay
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function SelectExpenseForApprovalsManagerMonitor(ByVal UserID As String, ByVal FirstDay As String, ByVal Grouping As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = "Client" Then
            spname = "TT_SelectExpenseApprovalsManagerMonitor_ByClient"
        Else
            spname = "TT_SelectExpenseApprovalsManagerMonitor_ByResource"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = FirstDay
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function SelectExpenseForApprovalsMD(ByVal UserID As String, ByVal FirstDay As String, ByVal Grouping As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = "Client" Then
            spname = "TT_SelectExpenseApprovalsMD_ByClient"
        Else
            spname = "TT_SelectExpenseApprovalsMD_ByResource"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = FirstDay
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    'SD: 13/09/2005 - Added UserID parameter.  This was required because when a timesheet is unsubmitted
    '                 it must be all timesheets for that week, that task and that user id.  Excluding the
    '                 User ID leads to Timesheets randomly being unsubmitted.  For all other types
    '                 of approvals UserID can be left out
    Public Shared Function InsertApproval(ByVal ApprovalType As String, ByVal ApproverID As String, _
                                          ByVal ApprovedItemID As String, ByVal Comment As String, _
                                          ByVal Approved As Object, Optional ByVal UserID As Integer = 0)
        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_InsertApproval"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ApprovalType
        Parms(1).Value = ApproverID
        Parms(2).Value = ApprovedItemID
        Parms(3).Value = Comment
        Parms(4).Value = CBool(Approved)
        Parms(5).Value = UserID

        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try
    End Function
#End Region

#Region "Expenses"
    Public Shared Function SelectRejectedExpense(ByVal UserID As Integer, ByVal ExpenseMonth As Date) As DataSet

        Dim ds As DataSet

        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_SelectRejectedExpenseDetails"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = ExpenseMonth

        Try
            ds = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return ds

    End Function

    Public Shared Function GetExpensesAwaitingApproval(ByVal UserID As String, ByVal ApplicationPath As String) As SqlDataReader
        ' Adding Data to the DB
        Dim DR As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectExpensesAwaitingApprovalForUser"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = ApplicationPath

        Try
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return DR
    End Function
#End Region

#Region "Financial Documents"
    Public Shared Function GetFinancialDocumentsAwaitingApproval(ByVal UserID As String, ByVal ApplicationPath As String) As SqlDataReader
        ' Adding Data to the DB
        Dim DR As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectFinancialDocsAwaitingApprovalForUser"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = ApplicationPath

        Try
            DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return DR
    End Function

    Public Shared Function SelectFinancialDocument(ByVal FinancialDocID As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        spname = "TT_SelectFinancialDocument"
        
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = FinancialDocID
        Parms(1).Value = HttpContext.Current.Request.ApplicationPath & "/" & ConfigurationSettings.AppSettings("UploadsVirtual")
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function SelectRejectedFinancialDocument(ByVal UserID As Integer) As DataSet

        Dim ds As DataSet

        ' Set Parameters needed for stored proc
        Dim Parms() As SqlParameter
        Dim spname As String = "TT_SelectRejectedFinancialDocuments"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = HttpContext.Current.Request.ApplicationPath & "/" & ConfigurationSettings.AppSettings("UploadsVirtual")

        Try
            ds = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return ds

    End Function

    Public Shared Sub DeleteFinancialDocument(ByVal FinancialDocID As String, ByVal UserID As Integer)

        ' Set Parameters needed for stored proc
        Dim spname As String
        spname = "TT_DeleteFinancialDocument"

        Parms = DAL.cacheParams(spname)
        Parms(0).Value = FinancialDocID
        Parms(1).Value = UserID
        Try
            SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

    End Sub

    Public Shared Function LoadFinancialDocumentTypesWithApproval() As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_SelectFinancialDocumentTypeWithApproval"

        Try
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function GetEmailForFinancialDocType(ByVal FinancialDocTypeID As Integer) As SqlDataReader
        Dim DR As SqlDataReader
        Dim arParms() As SqlParameter = New SqlParameter(0) {}
        arParms(0) = New SqlParameter("@FinancialDocTypeID", FinancialDocTypeID)

        DR = SqlHelper.ExecuteReader(ConfigurationSettings.AppSettings("DBConn"), CommandType.StoredProcedure, "TT_SelectFinancialDocTypeEmails", arParms)
        Return DR
    End Function
#End Region

#Region "Reports"
    Public Shared Function LoadReportSelections() As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_Rep_Selections"
        Parms = DAL.cacheParams(spname)
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function LoadProjectHeader(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_Rep_ProjectHeader"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = StartDate
        Parms(2).Value = EndDate
        Try
            MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportActivityRegister(ByVal ProjectID As String, ByVal StartDate As String, _
                                                  ByVal EndDate As String, ByVal TaskID As String, _
                                                  ByVal Users As String, ByVal Grouping As String, _
                                                  ByVal CaptureTypeID As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = ",User,Task," Then
            spname = "TT_Rep_TaskRegister_Usr_Task"
        Else
            spname = "TT_Rep_TaskRegister_Task_Usr"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = StartDate
        Parms(2).Value = EndDate
        Parms(3).Value = TaskID
        Parms(4).Value = Users
        Parms(5).Value = CaptureTypeID
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportExceptions(ByVal TeamLeaderID As Integer) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_Rep_Exceptions"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = TeamLeaderID
        Try
            If Parms Is Nothing Then
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname)
            Else
                MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
            End If
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportExpenses(ByVal ProjectID As String, ByVal StartDate As String, _
                                          ByVal EndDate As String, ByVal Users As String, _
                                          ByVal ClientID As Integer, ByVal CaptureTypeID As Integer, _
                                          ByVal ExpenseMonth As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_Rep_Expenses"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = IIf(StartDate = String.Empty, DBNull.Value, StartDate)
        Parms(2).Value = IIf(EndDate = String.Empty, DBNull.Value, EndDate)
        Parms(3).Value = Users
        Parms(4).Value = ClientID
        Parms(5).Value = CaptureTypeID
        Parms(6).Value = IIf(ExpenseMonth = String.Empty, DBNull.Value, ExpenseMonth)

        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportExpenseReimbursements(ByVal ProjectID As String, _
                                                       ByVal StartDate As Date, _
                                                       ByVal EndDate As Date, _
                                                       ByVal Users As String, _
                                                       ByVal Grouping As String, _
                                                       ByVal ClientiD As Integer, _
                                                       ByVal CaptureTypeID As Integer, _
                                                       ByVal ExpenseMonth As Date) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Grouping = ",User,Task," Then
            spname = "TT_Rep_Expenses_Usr"
        Else
            spname = "TT_Rep_Expenses_Proj"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = IIf(StartDate = Nothing, DBNull.Value, StartDate)
        Parms(2).Value = IIf(EndDate = Nothing, DBNull.Value, EndDate)
        Parms(3).Value = Users
        Parms(4).Value = ClientiD
        Parms(5).Value = CaptureTypeID
        Parms(6).Value = IIf(ExpenseMonth = Nothing, DBNull.Value, ExpenseMonth)
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportExpensesSummarisedByUser(ByVal ProjectID As String, ByVal StartDate As String, _
                                                          ByVal EndDate As String, ByVal Users As String, _
                                                          ByVal ClientID As Integer, ByVal CaptureTypeID As Integer) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_Rep_ExpensesSummarisedUsr"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = IIf(StartDate = String.Empty, DBNull.Value, StartDate)
        Parms(2).Value = IIf(EndDate = String.Empty, DBNull.Value, EndDate)
        Parms(3).Value = Users
        Parms(4).Value = ClientID
        Parms(5).Value = CaptureTypeID

        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportProfitability(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String, ByVal Output As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Output = "Fin" Then
            spname = "TT_Rep_Profitability_Financial"
        Else
            spname = "TT_Rep_Profitability_Time"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = StartDate
        Parms(2).Value = EndDate
        Try
            MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportProjStatus(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String, ByVal Output As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Output = "Fin" Then
            spname = "TT_Rep_ProjStatus_Financial"
        Else
            spname = "TT_Rep_ProjStatus_Time"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = StartDate
        Parms(2).Value = EndDate
        Try
            MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportSelectProjects(ByVal ClientID As String, ByVal StartDate As String, ByVal EndDate As String, ByVal TaskID As String, ByVal Users As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_Rep_SelectProjects"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ClientID
        Parms(1).Value = StartDate
        Parms(2).Value = EndDate
        Parms(3).Value = TaskID
        Parms(4).Value = Users
        Try
            MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportTimeAnalysis(ByVal StartDate As String, ByVal EndDate As String, _
                                              ByVal Users As String, ByVal TOTypes As String, _
                                              ByVal TaskTypes As String, ByVal Output As String, _
                                              ByVal CaptureType As String) As SqlDataReader
        ' Adding Data to the DB
        Dim MyData As SqlDataReader

        ' Set Parameters needed for stored proc
        Dim spname As String
        If Output = "Week" Then
            spname = "TT_Rep_TimeAnalysis_Week"
        Else
            spname = "TT_Rep_TimeAnalysis_Day"
        End If
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = StartDate
        Parms(1).Value = EndDate
        Parms(2).Value = Users
        Parms(3).Value = TOTypes
        Parms(4).Value = TaskTypes
        Parms(5).Value = CaptureType
        Try
            MyData = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportTimeOff(ByVal StartDate As String, ByVal EndDate As String, _
                                         ByVal Users As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_Rep_TimeOff"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = StartDate
        Parms(1).Value = EndDate
        Parms(2).Value = Users
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function
    Public Shared Function ReportTimesheetStatus(ByVal StartDate As String, ByVal EndDate As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_Rep_TimesheetStatus"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = StartDate
        Parms(1).Value = EndDate
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function ReportProjectSummary(ByVal ProjectID As String, ByVal StartDate As String, _
                                                ByVal EndDate As String)

        Dim en As New System.Globalization.CultureInfo("en-Za")

        Dim MyData = New DataSet
        Dim spname As String = "TT_Rep_ProjSummary"

        Dim arParms2() As SqlParameter = New SqlParameter(2) {}
        arParms2(0) = New SqlParameter("@ProjectID", ProjectID)
        arParms2(1) = New SqlParameter("@Start", System.DateTime.ParseExact(StartDate, "dd/MM/yyyy", en))
        arParms2(2) = New SqlParameter("@End", System.DateTime.ParseExact(EndDate, "dd/MM/yyyy", en))

        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, arParms2)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData

    End Function

    Public Shared Function ReportUserActivityRegister(ByVal UserID As Integer, ByVal StartDate As String, _
                                              ByVal EndDate As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String = "TT_Rep_UserActivity"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = UserID
        Parms(1).Value = StartDate
        Parms(2).Value = EndDate
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function

    Public Shared Function ReportDataExtract(ByVal ProjectID As String, ByVal StartDate As String, _
                                              ByVal EndDate As String, ByVal TaskID As String, _
                                              ByVal Users As String, ByVal CaptureTypeID As String) As DataSet
        ' Adding Data to the DB
        Dim MyData As DataSet

        ' Set Parameters needed for stored proc
        Dim spname As String
        spname = "TT_Rep_DataExtract"
        Parms = DAL.cacheParams(spname)
        Parms(0).Value = ProjectID
        Parms(1).Value = StartDate
        Parms(2).Value = EndDate
        Parms(3).Value = TaskID
        Parms(4).Value = Users
        Parms(5).Value = CaptureTypeID
        Try
            MyData = SqlHelper.ExecuteDataset(DBConn, CommandType.StoredProcedure, spname, Parms)
        Catch ex As Exception
            Dim errmsg As String = DisplayParameters(spname, Parms) & "<br> orginal msg: " & ex.Message
            Throw New ApplicationException(errmsg, ex.InnerException)
        End Try

        Return MyData
    End Function


#End Region

End Class
