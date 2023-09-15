<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WebLogin.aspx.vb" Inherits="TimeTrax.WebLogin" %>

<!DOCTYPE HTML >
<html>
<head>
    <title><%=AppName%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" type="text/css" href="<%=Request.ApplicationPath & StyleSheet%>">

    <script type="text/javascript">

        function ValidateData() {


            var ErrorMessage = "";


            if (document.getElementById('txtUsername').value == "") {
                ErrorMessage = ErrorMessage + "\nPlease enter the User Name";
            }

            if (document.getElementById('txtPassword').value == "") {
                ErrorMessage = ErrorMessage + "\nPlease enter the Password";
            }


            if (ErrorMessage.length > 0) {
                alert(ErrorMessage);
                return false;
            }
            else {
                return true;
            }


        }

   
        function load() {
            // Do not close the window if it is the Application
            if (window.name != "LOGIN") {
                window.open("WebLogin.aspx", "LOGIN", "toolbar=1,location=1,status=1,menubar=1,scrollbars=1, top=150, left=150,width=810,height=410,resizable=1");
                //window.open("WebLogin.aspx","LOGIN", "toolbar=0,location=0,status=1,menubar=0,scrollbars=1, top=150, left=150,width=810,height=410,resizable=1");

                // Destroy this Window and reopen as Regions_LOGIN window
                var oMe = window.self;
                oMe.opener = window.self;
                oMe.close();
            }
            else {
                // Set the position and size of the login window
                self.moveTo(0, 0);
                //width,height
                //self.resizeTo(810,410);
                self.resizeTo(screen.availWidth, screen.availHeight)
            }
        }

        function OpenWindow(URL) {
            alert('openwindow');
            var win = window.open(URL, "NewWindow", "height=500, width=780, top=0, left=0, menubar=0, scrollbars=1,location=0, resizable=1, status=1");
        }


        function browser() {
            var BrType, BrVersion, BrVersionNo;
            BrType = navigator.appName;
            BrVersion = navigator.appVersion;
            BrVersionNo = BrVersion.substring(BrVersion.search('MSIE') + 5, BrVersion.search('MSIE') + 8)
            if (BrVersionNo < 5.5)
                alert("Your browser " + BrType + "\nVersion " + BrVersionNo + "\nShould be Internet Explorer Version 5.5 or greater!\nPlease note your current browser will not fully work in Dims!\nGo here to update http://www.microsoft.com/ie");
        }

		</script>


</head>
<body bgcolor="#ffffff" onload="load();">
    <form id="Form1" runat="server" >
        <table width="540" border="0" cellspacing="0" cellpadding="0" class="t4">


            <tr>
                <td>
                    <table width="350" border="0" cellspacing="0" cellpadding="0" align="center" class="t2">

                        <tr>
                            <td>
                                <br>
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table width="96%" class="t1">
                                    <tr>
                                        <th class="th" colspan="2">Login</th>
                                    </tr>


                                    <tr>
                                        <td colspan="2" class="td3">
                                            <table width="350" border="0" cellspacing="0" cellpadding="0" align="center" class="t3">

                                                <tr>
                                                    <td class="td1" colspan="2">Please enter your username and password</td>
                                                </tr>
                                                <tr>
                                                    <td class="td1" width="120">Username:</td>
                                                    <td class="td2" width="130">
                                                        <asp:TextBox ID="txtUsername"
                                                            runat="server" Width="130" CssClass="input"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="td1" width="120">Password:</td>
                                                    <td class="td2">
                                                        <asp:TextBox ID="txtPassword"
                                                            runat="server" Width="130" CssClass="input" TextMode="Password"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="td1">&nbsp;</td>
                                                    <td class="td2">
                                                        <div>
                                                            <br>
                                                            <asp:Button ID="btnLogin" OnClientClick="if (!ValidateData()) return false" runat="server" CssClass="button" Text="Log On"></asp:Button>

                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="td1" colspan="3">
                                                        <asp:Label ID="lblMessage" Style="font-size: 10px; color: red; font-family: Verdana, Arial, Helvetica, sans-serif; text-align: center"
                                                            runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">&nbsp;</td>
                                                </tr>
                                            </table>

                                        </td>
                                    </tr>

                                </table>
                            </td>
                        </tr>

                    </table>
                </td>
                <tr>
                    <td>
                        <br>
                    </td>
                </tr>
        </table>
    </form>
</body>
</html>
