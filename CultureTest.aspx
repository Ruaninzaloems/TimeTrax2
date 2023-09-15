<%@ Page Language="VB" EnableViewState="false" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Threading" %>


<script runat="server">


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)


        Dim currentUserCulture As CultureInfo = Thread.CurrentThread.CurrentCulture

        Response.Write("The current culture : " + currentUserCulture.Name + "<br/>")
        Response.Write("The Display Name : " + currentUserCulture.DisplayName + "<br/>")
        Response.Write("The Native Name : " + currentUserCulture.NativeName + "<br/>")
        Response.Write("The ISO Abbreviation : " + currentUserCulture.TwoLetterISOLanguageName + "<br/>")
        Response.Write("The current culture CurrencyDecimalSeparator : " + currentUserCulture.NumberFormat.CurrencyDecimalSeparator + "<br/>")
        Response.Write("The current culture of NumberDecimalSeparator : " + currentUserCulture.NumberFormat.NumberDecimalSeparator + "<br/>")


        Dim currentUseUICulture As CultureInfo = Thread.CurrentThread.CurrentUICulture
        Response.Write("The current UI culture of this app : " + currentUseUICulture.Name + "<br/>")
        Response.Write("The current UI culture of CurrencyDecimalSeparator : " + currentUseUICulture.NumberFormat.CurrencyDecimalSeparator + "<br/>")
        Response.Write("The current UI culture of NumberDecimalSeparator : " + currentUseUICulture.NumberFormat.NumberDecimalSeparator + "<br/>")



    End Sub


</script>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
