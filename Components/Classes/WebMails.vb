Imports System
Imports System.Web
Imports System.Data
Imports System.Web.Mail
Imports Intermap.Communication

Namespace Portal.Emailing

	Public NotInheritable Class WebMails
		'*********************************************************************************
		'Send Email sends an email.
		'In particular sends the requested dataSets.
		'*********************************************************************************
		Enum SendToType
      User            ' Regions
      PSO             ' Regions
      ProjectManager  ' Regions
      Finance         ' Regions
      Executive       ' Regions
      BUManager       ' AVMS
		End Enum

    Public Shared Sub SendEmail(ByVal mailTo As String, ByVal mailFrom As String, ByVal subject As String, ByVal Body As String, ByVal priority As MailPriority, ByVal SMTPServerAdd As String, ByVal AttachList As String)
      ' This is now accessible from Intermap.Communications

      Dim objMail As New MailMessage

      objMail.BodyFormat = MailFormat.Html
      objMail.To = mailTo
      objMail.From = mailFrom
      objMail.Priority = priority
      objMail.Subject = subject
      objMail.Body = Body

      objMail.Fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
      objMail.Fields("http://schemas.microsoft.com/cdo/configuration/sendusername") = "Dims@sebata.co.za"
      objMail.Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "D!ms2016"


      ' Add attachments to mail message
      Dim Attachment As String
      For Each Attachment In AttachList.Split(",")
        If Attachment <> "" Then
          Dim objAttach As MailAttachment = New MailAttachment(Attachment)
          objMail.Attachments.Add(objAttach)
        End If
      Next

      SmtpMail.SmtpServer = SMTPServerAdd
      SmtpMail.Send(objMail)

    End Sub

    Public Shared Sub TrySendMail(ByVal MailTo As String, ByVal Subject As String, ByVal Body As String, ByVal Priority As Mail.MailPriority, ByVal AttachList As String)
      'This Function will send try send an email to the email specified in the mailto field
      ' The email may or may not contain a list of files to attach
      Dim From As String = ConfigurationSettings.AppSettings("AdminEmailAddress")
      Dim SubjectPrefix = ConfigurationSettings.AppSettings("ApplicationName") & " " & ConfigurationSettings.AppSettings("Version") & " Notification: "
      Dim MailServer As String = ConfigurationSettings.AppSettings("SMTPserver")
       


      ' First add a footer to the body,
      Dim strBody As String = AddFooter(Body)

      ' Add the subject prefix
      Subject = SubjectPrefix & Subject

      ' Try Sending the email (using Intermap.Communication.WebMail.SendEmail),
      Try
                SendEmail(MailTo, From, Subject, strBody, Priority, MailServer, AttachList)
            Catch ex As Exception
                ' if it Fails write the details to a file for sending later
                WriteToFile(MailTo, From, Subject, Body, Priority, AttachList)
                Exit Sub
            End Try

            ' Success, now check if there are any mails waiting to be sent,
            ' and send them now
            SendWaiting(MailServer)
    End Sub

    Public Shared Sub TrySendMail(ByVal MailTo As SendToType, ByVal Subject As String, ByVal Body As String, ByVal Priority As Mail.MailPriority, ByVal AttachList As String, ByVal RegionID As String)
      ' This does the same as the above function except that it will retreive the relevant email address
      ' from the WebMail_Addresses Table using the SendToType (WebMail_Types)
      Dim From As String = ConfigurationSettings.AppSettings("AdminEmailAddress")
      Dim SubjectPrefix As String = ConfigurationSettings.AppSettings("ApplicationName") & " " & ConfigurationSettings.AppSettings("Version") & " :"
      Dim MailServer As String = ConfigurationSettings.AppSettings("SMTPserver")
      Dim SendTo As String
      ' First add a footer to the body,
      Dim strBody As String = AddFooter(Body)

      ' Add the subject prefix
      Subject = SubjectPrefix & Subject

      ' Get the email address for the relative recipient
      SendTo = GetRecipient(MailTo, RegionID)

      ' Try Sending the email (using Intermap.Communication.WebMail.SendEmail),
      Try
                SendEmail(SendTo, From, Subject, strBody, Priority, MailServer, AttachList)
      Catch ex As Exception
        ' if it Fails write the details to a file for sending later
        WriteToFile(SendTo, From, Subject, Body, Priority, AttachList)
        Exit Sub
      End Try

      ' Success, now check if there are any mails waiting to be sent,
      ' and send them now
      SendWaiting(MailServer)
    End Sub

    Public Shared Function GetRecipient(ByVal MailTo As SendToType, ByVal RegionID As String)
      Dim SendTo As String
      Dim arParms1() As SqlParameter = New SqlParameter(1) {}
      arParms1(0) = New SqlParameter("@Type", MailTo)
      If RegionID = "" Then
        arParms1(1) = New SqlParameter("@RegionID", DBNull.Value)
      Else
        arParms1(1) = New SqlParameter("@RegionID", CInt(RegionID))
      End If
      SendTo = SqlHelper.ExecuteScalar(ConfigurationSettings.AppSettings("DBConn"), CommandType.StoredProcedure, "WebMail_GetRecipient", arParms1)
      Return SendTo
    End Function

    Public Shared Function AddFooter(ByVal strBody) As String
      Dim AppName As String = ConfigurationSettings.AppSettings("ApplicationName")
      Dim SupportTel As String = ConfigurationSettings.AppSettings("SupportNumber")
      Dim SupportEmail As String = ConfigurationSettings.AppSettings("SupportEmail")
      Dim WebAddress As String = ConfigurationSettings.AppSettings("WebAddress")
      Dim strFooter As String

            strFooter = vbCrLf & vbCrLf & vbCrLf & _
                  "<br><br><Font face=Arial size=1 color=gray>__________________________________________________" & vbCrLf & _
                  "<br>This email has been generated by an automatic system " & _
                  "<br>as part of the functionality of the " & AppName & " application " & _
                  "<br>and is intended for informational purposes only." & vbCrLf & _
                  "<br>Please do NOT reply to this email" & _
                  "<br>__________________________________________________<br><br>" & vbCrLf & _
                 "If you need assistance, please contact " & SupportEmail & " or phone <font color=blue>" & SupportTel & "</font></font>"

      strBody = strBody & strFooter
      Return (strBody)

    End Function

    Public Shared Sub WriteToFile(ByVal MailTo As String, ByVal From As String, ByVal Subject As String, ByVal Body As String, ByVal Priority As Mail.MailPriority, ByVal AttachList As String)
      Dim arParms5() As SqlParameter = New SqlParameter(5) {}
      If MailTo Is Nothing Then
        arParms5(0) = New SqlParameter("@To", "No Recipient found in DB")
      Else
        arParms5(0) = New SqlParameter("@To", MailTo)
      End If
      arParms5(1) = New SqlParameter("@From", From)
      arParms5(2) = New SqlParameter("@Subject", Subject)
      arParms5(3) = New SqlParameter("@Body", Body)
      arParms5(4) = New SqlParameter("@Priority", Priority)
      arParms5(5) = New SqlParameter("@AttachList", AttachList)
      SqlHelper.ExecuteNonQuery(ConfigurationSettings.AppSettings("DBConn"), CommandType.StoredProcedure, "WebMail_SendLater", arParms5)
    End Sub

    Public Shared Sub SendWaiting(ByVal MailServer As String)
      Dim DR As SqlDataReader
      DR = SqlHelper.ExecuteReader(ConfigurationSettings.AppSettings("DBConn"), CommandType.StoredProcedure, "WebMail_SendWaiting")
      While DR.Read
        Try
                    WebMail.SendHtmlEmail(DR.Item("MailTo"), DR.Item("Sender"), DR.Item("Subject"), DR.Item("Body"), DR.Item("Priority"), ConfigurationSettings.AppSettings("SMTPserver"), DR.Item("AttachList"))
          ' Send successful so delete from waiting Table
          Dim arParms() As SqlParameter = New SqlParameter(0) {}
          arParms(0) = New SqlParameter("@ID", DR.Item("ID"))
          SqlHelper.ExecuteNonQuery(ConfigurationSettings.AppSettings("DBConn"), CommandType.StoredProcedure, "WebMail_DeleteSendWaiting", arParms)
        Catch ex As Exception
          ' Cant send again for some reason so stop trying,
          ' Will be tried again later
          Exit While
        End Try
      End While
      DR.Close()

    End Sub

  End Class

End Namespace

