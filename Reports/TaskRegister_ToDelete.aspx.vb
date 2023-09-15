Imports System.Xml
Imports System.Xml.Xsl
Imports System.Xml.XPath
Imports System.IO

Public Class TaskRegister
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Xmlresult As System.Web.UI.WebControls.Xml

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
    Dim strStatus As String
    Dim strErr As String
    Dim strMess As String

#End Region

#Region " PAGE DECLARES "
#End Region

#Region " PAGE LOAD "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' Check User Has Permissions to Access this Page
        Dim Role As String = "50"
        UserLogin.CheckUserAccess(Role, Context.Current, True)

        If Not IsPostBack Then
            Session("PageType") = "Reports"
            Session("Page") = ""
            Session("PageTitle") = Session("AppName") & " - Reports"
            GetXMLBlob("TT_Rep_XML_TaskRegister")
        Else
            Xmlresult.DocumentSource = ViewState("xmlfile")
            Xmlresult.TransformSource = "../Components/XSL/Rep_TaskRegister.xsl"
            Dim arg As New XsltArgumentList
            If Request.Form("pOptionClient") Is Nothing Then
                arg.AddParam("SelectedClientID", "", "0")
            Else
                arg.AddParam("SelectedClientID", "", Request.Form("pOptionClient"))
            End If
            If Request.Form("pOptionProject") Is Nothing Then
                arg.AddParam("SelectedProjectID", "", "0")
            Else
                arg.AddParam("SelectedProjectID", "", Request.Form("pOptionProject"))
            End If

            Xmlresult.TransformArgumentList = arg
            Xmlresult.DataBind()
        End If
    End Sub

    Private Sub GetXMLBlob(ByVal StoredProc As String)

        BuildXMLFile(StoredProc)
        'ViewState("xmlfile") = "report.xml"
        Dim xmlPath As String = Server.MapPath(ViewState("xmlfile"))
        Xmlresult.DocumentSource = ViewState("xmlfile") 'xmlPath
        Xmlresult.TransformSource = "../Components/XSL/Rep_TaskRegister.xsl"
    End Sub

    Public Function BuildXMLFile(ByVal StoredProc As String)
        Dim strXml As String
        Dim xr As XmlTextReader
        Dim Conn As New SqlConnection(DBConn)

        'Conn.Open()
        xr = SqlHelper.ExecuteXmlReader(Conn, CommandType.StoredProcedure, StoredProc)

        'create the document prolog
        strXml = "<?xml version='1.0'?>" & _
                      "<DOCUMENT>"
        'read the first result row and then read remainder
        strXml &= xr.GetRemainder().ReadToEnd()

        'add the document epilog
        strXml &= "</DOCUMENT>"

        xr.Close() ' close the reader
        Conn.Close() ' close the connection
        Xmlresult.DocumentContent = strXml

        ViewState("xmlfile") = "data.xml"
        Xmlresult.Document.Save(Server.MapPath(ViewState("xmlfile")))
        'return the path to the XML document object to the calling routine
        Return strXml
    End Function

#End Region

#Region " SUBMIT DETAILS "
#End Region

End Class
