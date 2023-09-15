Imports System.IO
Public Class Upload
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents rfvUpload As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtTitle As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvTitle As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtDate As System.Web.UI.WebControls.TextBox
    Protected WithEvents rfvDate As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents txtWho As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnSubmit As System.Web.UI.WebControls.Button
    Protected WithEvents Validationsummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents lblResults As System.Web.UI.WebControls.Label
    Protected WithEvents tblwizard1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents txtUpload As System.Web.UI.HtmlControls.HtmlInputFile
    Protected WithEvents tblwizard2 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents hidAppPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidUploadsPath As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidDate As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidTitle As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidSize As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidFileName As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents hidError As System.Web.UI.HtmlControls.HtmlInputHidden

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

#End Region

#Region " PAGE DECLARES "
    Public StyleSheet As String = "/" & ConfigurationSettings.AppSettings("Style")
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "2"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("ProjectID") = Request.QueryString("ProjID")
            ' Show Upload Document Section
            tblwizard1.Visible = True
            ' Show Results Section
            tblwizard2.Visible = False
            Session("PageType") = "Upload"
            Session("PageTitle") = Session("AppName") & " - Document Upload"
        Else
            ' Upload Document Section
            tblwizard1.Visible = False
            ' Upload Results Section
            tblwizard2.Visible = True
        End If

        'Set the application path
        hidAppPath.Value = Request.ApplicationPath
        hidUploadsPath.Value = ConfigurationSettings.AppSettings("UploadsVirtual")
    End Sub
#End Region

#Region " UPLOAD DOCUMENT CODE "

    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim objStream As Stream = txtUpload.PostedFile.InputStream
        Try
            Dim strExt As String
            Dim strpath As String
            strpath = txtUpload.PostedFile.FileName
            strExt = Path.GetExtension(strpath)
            Dim strFileName As String
            Dim strBaseDir As String = Server.MapPath(Request.ApplicationPath & "/" & ConfigurationSettings.AppSettings("UploadsVirtual"))
            '      Dim strBaseDir As String = Server.MapPath(ConfigurationSettings.AppSettings("UploadsVirtual"))
            'Trace.Warn("Upload Virtual Absolute Path", strBaseDir)

            'Determine the file type
            If (strExt.ToUpper = ".DOC" Or strExt.ToUpper = ".ZIP" Or strExt.ToUpper = ".XLS" Or strExt.ToUpper = ".PDF" Or _
                strExt.ToUpper = ".JPG" Or strExt.ToUpper = ".TIF" Or strExt.ToUpper = ".BMP") Then
                If (objStream.Length < 2000000) Then

                    'Load the Last Document number
                    '****************************************************************************************************************
                    Dim arParms() As SqlParameter = New SqlParameter(0) {}
                    'Add values to the parameter array
                    arParms(0) = New SqlParameter("@ProjectID", Session("ProjectID"))

                    ' Get ProjectCode from ProjectID
                    Dim ProjCode As String
                    ProjCode = SqlHelper.ExecuteScalar(DBConn, CommandType.StoredProcedure, "TT_SelectProjectCode", arParms)
                    ' Execute the stored procedure
                    DR = SqlHelper.ExecuteReader(DBConn, CommandType.StoredProcedure, "TT_SelectLastDocumentNo", arParms)

                    'Build the file name
                    If DR.Read() Then
                        Dim docNo As Int32 = DR.Item("DocNo")
                        If docNo < 9 Then
                            docNo = docNo + 1
                            strFileName = Replace(ProjCode, " ", "") & "_doc00" & docNo & strExt
                        ElseIf docNo > 8 And docNo < 99 Then
                            docNo = docNo + 1
                            strFileName = Replace(ProjCode, " ", "") & "_doc0" & docNo & strExt
                        Else
                            docNo = docNo + 1
                            strFileName = Replace(ProjCode, " ", "") & "_doc" & docNo & strExt
                        End If
                    Else
                        strFileName = Replace(ProjCode, " ", "") & "_doc001" & strExt
                    End If
                    DR.Close()

                    'Add the rest of the upload path
                    strBaseDir &= "\Documents\"
                    'Trace.Warn("Upload Base Dir", strBaseDir)

                    'Trace.Warn("Upload full Path", strBaseDir & strFileName)
                    txtUpload.PostedFile.SaveAs(strBaseDir & strFileName)
                    'Trace.Warn("Uploaded", "File is Uploaded")

                    'Write the details into the database
                    '****************************************************************************************************************
                    Dim arParms1() As SqlParameter = New SqlParameter(5) {}

                    'Add values to the parameter array
                    arParms1(0) = New SqlParameter("@ProjectID", Session("ProjectID"))
                    arParms1(1) = New SqlParameter("@DocumentName", strFileName)
                    arParms1(2) = New SqlParameter("@Title", txtTitle.Text)
                    arParms1(3) = New SqlParameter("@DocumentDate", System.DateTime.ParseExact(txtDate.Text, "dd/MM/yyyy", en))
                    arParms1(4) = New SqlParameter("@Who", txtWho.Text)
                    arParms1(5) = New SqlParameter("@Size", objStream.Length)

                    ' Execute the stored procedure
                    SqlHelper.ExecuteNonQuery(DBConn, CommandType.StoredProcedure, "TT_InsertProjectDocument", arParms1)
                    'Trace.Warn("DB", "Record in DB")

                    lblResults.Text = "<b>Success<br><br>The document has been sucessfully uploaded.<br>(Uploaded File size: <font color=red>" & objStream.Length & "</font> bytes)</b>"

                    'Indicate that the upload was successful
                    hidError.Value = 0
                Else
                    lblResults.Text = "<b>Error<br><br>File is bigger than the maximum of 2000000 bytes (2Mb).<br>(Uploaded File size: <font color=red>" & objStream.Length & "</font> bytes)<br><br>Please <a href='#' onclick='javascript:history.back();'>try again</a></b>"
                End If
            Else
                lblResults.Text = "<b>Error<br><br>File is not a .doc, .xls, .pdf, .jpg, .tif, .bmp or .zip.<br>(Uploaded File size: <font color=red>" & objStream.Length & "</font> bytes)<br><br>Please <a href='#' onclick='javascript:history.back();'>try again</a></b>"
            End If
            ' Clear the fields for new photo upload
            'txtTitle.Text = ""
            'txtDate.Text = ""
            'txtWho.Text = ""

            'Set the hidden fields
            hidDate.Value = Format("dd/MM/yyyy", txtDate.Text)
            hidTitle.Value = txtTitle.Text
            hidSize.Value = objStream.Length
            hidFileName.Value = strFileName

        Catch Ex As Exception
            lblResults.Text = "<b>Error<br><br>There has been an unresolved error with the document upload.<br><br>Please <a href='#' onclick='javascript:history.back();'>try again</a></b>"
            Exit Try
        End Try
    End Sub
#End Region

End Class
