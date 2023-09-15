<%@ Register TagPrefix="im" TagName="Footer" Src="/TimeTrax/Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="/TimeTrax/Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="/TimeTrax/Components/User Controls/Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Expense.aspx.vb" Inherits="TimeTrax.Expense" %>
<body onload="LoadDynamics();">
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
				<td><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<th class="th" colSpan="2">
					Expense Capture</th>
			</tr>
			<tr>
				<td class="td" vAlign="top" align="center">
					<br>
					<asp:calendar id="Calendar1" runat="server" BackColor="White" ForeColor="Black" Font-Size="7pt"
						Font-Names="Verdana" BorderColor="#999999" ToolTip="Click to Select Expense Week to open" NextMonthText="-&amp;gt;"
						PrevMonthText="&amp;lt;-" BorderStyle="None" Height="120px">
						<TodayDayStyle ForeColor="Black" BackColor="#CCCCCC"></TodayDayStyle>
						<SelectorStyle BackColor="#CCCCCC"></SelectorStyle>
						<NextPrevStyle VerticalAlign="Bottom"></NextPrevStyle>
						<DayHeaderStyle Font-Size="7pt" Font-Bold="True" BackColor="#CCCCCC"></DayHeaderStyle>
						<SelectedDayStyle Font-Bold="True" ForeColor="White" BackColor="#666666"></SelectedDayStyle>
						<TitleStyle Font-Bold="True" BorderColor="Black" BackColor="#999999"></TitleStyle>
						<WeekendDayStyle BackColor="#FFFFCC"></WeekendDayStyle>
						<OtherMonthDayStyle ForeColor="Gray"></OtherMonthDayStyle>
					</asp:calendar>
					<br>
				</td>
			</tr>
			<TR>
				<td>
					<table id="tbltime" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server"
						name="tbltime">
						<tr>
							<th class="th1" width="50%">
								&nbsp;</th>
							<th class="th1" width="31%">
								Expense Type</th>
							<th class="th1" width="5%">
								Quantity</th>
							<th class="th1" width="7%">
								Cost</th>
							<th class="th1" width="7%">
								Total</th>
						</tr>
						<tr>
							<td colspan="5">
								<asp:placeholder id="timePlace" runat="server"></asp:placeholder>
							</td>
						</tr>
					</table> <!-- END tbltime -->
					<table id="tbltimefoot" cellSpacing="0" cellPadding="2" width="100%" border="0" runat="server"
						name="tbltimefoot">
						<tr>
							<th class="th2" align="left" width="93%">
								<b>Total :&nbsp;&nbsp;</b></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtTotal" runat="server" ReadOnly="True" size="10" cssclass="inputR"></asp:textbox></th>
						</tr>
					</table> <!-- END tbltimefoot -->
				</td>
			</TR>
			<tr>
				<td vAlign="top" align="center">
					<input class="button" id="htmProjects" onclick="openAddProject();" type="button" value="Add Project"
						name="htmProjects" runat="server">
					<asp:button id="btnSave" runat="server" Cssclass="button" text="Save"></asp:button>
					<asp:button id="btnSubmit" runat="server" Cssclass="button" text="Submit"></asp:button>
					<asp:placeholder id="listPlace" runat="server"></asp:placeholder>
					<input id="deleted_list" type="hidden" name="deleted_list">
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
