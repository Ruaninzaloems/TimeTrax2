<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UserActivityReport.aspx.vb" Inherits="TimeTrax.UserActivityReport" %>

<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/imcalendar.js"></script>
<body>
    <form id="Form1" method="post" runat="server">
        <im:Header ID="ucHeader" runat="server"></im:Header>
        <!--START C A L E N D A R   C O N T R O L Include this to use the calendar-->
        <script language="JavaScript">
            //This is needed for the Calendar styles
            document.write(CalendarPopup_getStyles());
            //To use a Pop-Up window, leave the parameter blank, otherwise put in dynamic
            var imcalendar = new CalendarPopup("dynamic");
            imcalendar.showYearNavigation();
        </script>
        <!--END C A L E N D A R   C O N T R O L-->
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="tdmenu">
                    <im:TopTabs ID="ucTopTabs" runat="server"></im:TopTabs>
                </td>
            </tr>
        </table>
        <table class="t3" width="100%">
            <tr>
                <td>
                    <table class="t4" width="100%" align="center">
                        <tr>
                            <th class="th" colspan="4">Report Filters</th>
                        </tr>
                        <tr>
                            <td class="td" align="right">User :</td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="ddlUser" DataTextField="UserName" DataValueField="UserID" CssClass="select"
                                    Width="30%" runat="server" name="ddlUser">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="ddlUser" Display="None" ErrorMessage="Please select a User"
                                    InitialValue="0"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td class="td" align="right" width="20%">Start :</td>
                            <td width="30%">
                                <asp:TextBox ID="txtStartDate" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"
                                    name="txtStartDate" Width="100" runat="server" CssClass="input"></asp:TextBox>
                                <!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
                                <div id="divStartDate" style="position: absolute"></div>
                                <img id="StartDate" style="cursor: hand" onclick="imcalendar.select(document.Form1['txtStartDate'], 'divStartDate', 'dd/MM/yyyy'); return false;"
                                    src="<%=Request.ApplicationPath%>/Images/CALENDAR.GIF" border="0" name="StartDate">
                                <asp:RequiredFieldValidator ID="rfvStartDate" runat="Server" ErrorMessage="Please enter a Start date" Display="None"
                                    ControlToValidate="txtStartDate"></asp:RequiredFieldValidator></td>
                            <td class="td" align="right" width="20%">End :</td>
                            <td width="30%">
                                <asp:TextBox ID="txtEndDate" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"
                                    name="txtEndDate" Width="100" runat="server" CssClass="input"></asp:TextBox>
                                <!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
                                <div id="divEndDate" style="position: absolute"></div>
                                <img id="EndDate" style="cursor: hand" onclick="imcalendar.select(document.Form1['txtEndDate'], 'divEndDate', 'dd/MM/yyyy'); return false;"
                                    src="<%=Request.ApplicationPath%>/Images/CALENDAR.GIF" border="0" name="EndDate">
                                <asp:RequiredFieldValidator ID="rfvEndDate" runat="Server" ErrorMessage="Please enter an End date" Display="None"
                                    ControlToValidate="txtEndDate"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                                <asp:Button ID="btnGenerate" CssClass="button" runat="server" name="btnGenerate" Text="Generate Report"></asp:Button></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:ValidationSummary ID="ValidationSummary1" Style="z-index: 103; left: 16px" Width="696px" runat="server"
                                    Height="88px" ShowSummary="False" ShowMessageBox="True"></asp:ValidationSummary>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" class="td3">
                    <table align="center" width="100%" border="0" id="tblButtons" runat="server">
                        <tr>
                            <td class="td" align="right">
                                <img id="Printbtn" onclick="printSpecial(this,'<%=Request.ApplicationPath%>')" alt="Print Report" src="../Images/print.gif"
                                    style="width: 16px; cursor: pointer; height: 16px">
                                <asp:ImageButton ID="imgExport" runat="server" ImageUrl="../Images/excel.gif" AlternateText="Export Report to Excel"
                                    Style="cursor: pointer" Width="16" Height="16"></asp:ImageButton>
                            </td>
                        </tr>
                    </table>
                    <div id="divReport" runat="server">
                        <table class="t4" align="center" width="100%">
                            <tr id="pgHead" runat="server">
                                <td colspan="5" width="100%">
                                    <table align="center">
                                        <tr>
                                            <td colspan="5">
                                                <img src="../images/XLbanner.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <th class="th">User Activity Register for
									<asp:Label ID="lblUserName" runat="server" Width="100%"></asp:Label>
                                </th>
                            </tr>
                            <tr>
                                <td>
                                    <table id="tblPage" border="1" width="100%">
                                        <tr>
                                            <th class="th1" width="50%" style="display: none">ClientName</th>
                                            <th class="th1" width="10%">Task</th>
                                            <th class="th1" width="10%">User</th>
                                            <th class="th1" width="15%">Entry Date</th>
                                            <th class="th1" width="15%">Total Hours</th>
                                            <th class="th1" width="50%">Comments</th>
                                            <th class="th1" width="50%" style="display: none">FullName</th>
                                            <th class="th1" width="50%" style="display: none">EmployeeCode</th>
                                            <th class="th1" width="50%" style="display: none">Billable</th>
                                        </tr>
                                        <asp:Repeater ID="Repeater1" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="tdreportTotal" colspan="5" align="left">
                                                        <asp:Label ID="lblHead1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="tdreportTotal"></td>
                                                            <td class="tdreportTotal" colspan="4" style="align: left;">
                                                                <asp:Label ID="lblHead2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <asp:Repeater ID="Repeater3" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td class="tdreport" style="display: none">
                                                                        <span >
                                                                            <asp:Label ID="lblClientName" runat="server" CssClass="inputReport" Width="100%"></asp:Label>
                                                                        </span>

                                                                    </td>
                                                                    <td class="tdreport">
                                                                        <span style="display: none">
                                                                            <asp:Label ID="lblProject" runat="server" CssClass="inputReport" Width="100%"></asp:Label>
                                                                        </span>

                                                                    </td>
                                                                    <td class="tdreport">
                                                                        <span style="display: none">
                                                                            <asp:Label ID="lblItem" runat="server" CssClass="inputReport" Width="100%"></asp:Label>
                                                                        </span>
                                                                    </td>
                                                                    <td class="tdreport">
                                                                        <asp:Label ID="lblDate" runat="server" CssClass="inputReport" Width="100%"></asp:Label>
                                                                    </td>
                                                                    <td class="tdreport">
                                                                        <asp:Label ID="lblHrs" runat="server" CssClass="inputRReport" Width="100%"></asp:Label>
                                                                    </td>
                                                                    <td class="tdreport">
                                                                        <asp:Label ID="lblComments" runat="server" CssClass="inputReport" Width="100%"></asp:Label>
                                                                    </td>
                                                                    <td class="tdreport" style="display: none">
                                                                        <asp:Label ID="lblUser" runat="server" CssClass="inputReport" Width="100%"></asp:Label>
                                                                    </td>
                                                                    <td class="tdreport" style="display: none">
                                                                        <asp:Label ID="lblEmployeeCode" runat="server" CssClass="inputReport" Width="100%"></asp:Label>
                                                                    </td>
                                                                    <td class="tdreport" style="display: none" >
                                                                        <span >
                                                                            <asp:Label ID="lblBillable" runat="server" CssClass="inputReport" Width="100%"></asp:Label>
                                                                        </span>

                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <tr>
                                                                    <td colspan="3" class="tdreport"></td>
                                                                    <td align="right" class="tdreportTotal">
                                                                        <asp:Label ID="lblTotal" runat="server" Width="100%"></asp:Label></td>
                                                                    <td></td>
                                                                </tr>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <tr>
                                                    <th class="th2" colspan="3" style="text-align: left;">Total</th>
                                                    <th class="th2" style="text-align: right;">
                                                        <asp:Label ID="lblGrandTotal" runat="server"></asp:Label></th>
                                                    <th class="th2">&nbsp;
                                                    </th>
                                                </tr>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <im:Footer ID="ucFooter" runat="server"></im:Footer>
    </form>
</body>
