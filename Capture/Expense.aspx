<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Expense.aspx.vb" Inherits="TimeTrax.Expense" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<body>
	<im:header id="ucHeader" runat="server"></im:header>
	<!--START C A L E N D A R   C O N T R O L Include this to use the calendar-->
	<SCRIPT language="JavaScript">
			//This is needed for the Calendar styles
			document.write(CalendarPopup_getStyles());
			//To use a Pop-Up window, leave the parameter blank, otherwise put in dynamic
			var imcalendar = new CalendarPopup("dynamic");
			imcalendar.showYearNavigation();
	</SCRIPT>
	<!--END C A L E N D A R   C O N T R O L-->
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Expense Capture</th>
			</tr>
			<tr>
				<td class="td3">
					<table class="t2" align="right" width="20%">
						<tr>
							<td class="td1">
								<asp:calendar id="Calendar1" runat="server" Height="120px" BorderStyle="None" PrevMonthText="&amp;lt;-"
									NextMonthText="-&amp;gt;" ToolTip="Click to Select Expense Week to open" BorderColor="#999999"
									Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#A4A4A4" BackColor="#F3F4F5">
									<TodayDayStyle ForeColor="Black" BackColor="#A4A4A4"></TodayDayStyle>
									<SelectorStyle BackColor="#CCCCCC"></SelectorStyle>
									<NextPrevStyle VerticalAlign="Bottom"></NextPrevStyle>
									<DayHeaderStyle Font-Size="7pt" Font-Bold="True" BackColor="#ffffff"></DayHeaderStyle>
									<SelectedDayStyle Font-Bold="True" ForeColor="#000000" BackColor="#A4A4A4"></SelectedDayStyle>
									<TitleStyle ForeColor="#ffffff" Font-Bold="True" BorderColor="Black" BackColor="#2B3B81"></TitleStyle>
									<WeekendDayStyle BackColor="#E3E1E1"></WeekendDayStyle>
									<OtherMonthDayStyle ForeColor="Gray"></OtherMonthDayStyle>
								</asp:calendar><br>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<TR>
				<td class="td3">
					<table id="tbltime" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server"
						name="tbltime">
						<tr>
							<td class="td">
								<asp:placeholder id="timePlace" runat="server"></asp:placeholder>
							</td>
						</tr>
					</table> <!-- END tbltime -->
					<table id="tbltimefoot" cellSpacing="0" cellPadding="2" width="100%" border="0" runat="server"
						name="tbltimefoot">
						<tr>
							<td class="td1" align="right" width="93%">
								<b>Total :&nbsp;&nbsp;</b></td>
							<td class="td2" width="7%">
								<asp:textbox id="txtTotal" runat="server" ReadOnly="True" size="10" cssclass="inputR"></asp:textbox>
							</td>
						</tr>
					</table> <!-- END tbltimefoot -->
				</td>
			</TR>
			<tr>
				<td class="td3" vAlign="top" align="center" colSpan="2">
					<input class="button" id="htmProjects" onclick="openAddProject();" type="button" value="Add Project"
						name="htmProjects" runat="server"> <input id="hidExpenseDate" type="hidden" name="hidExpenseDate" runat="server">
					<asp:button id="btnSave" runat="server" Cssclass="button" text="Save"></asp:button>
					<asp:button id="btnSubmit" runat="server" Cssclass="button" text="Submit"></asp:button>
					<asp:placeholder id="listPlace" runat="server"></asp:placeholder>
					<input id="deleted_list" type="hidden" name="deleted_list"> <input id="deletedproj_list" type="hidden" name="deletedproj_list">
					<asp:customvalidator id="CustomValidator1" runat="server" Display="None" ClientValidationFunction="ValidateExpense"
						ErrorMessage="CustomValidator"></asp:customvalidator>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
