<%@ Register TagPrefix="im" TagName="Footer" Src="/TimeTrax/Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="/TimeTrax/Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="/TimeTrax/Components/User Controls/Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Expense.aspx.vb" Inherits="TimeTrax.Expense1" EnableViewState="True"%>
<body>
	<im:header id="ucHeader" runat="server"></im:header>
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<TBODY>
				<tr>
					<th class="th" colSpan="2">
					Expenses Approval</th>
				</tr>
				<tr>
					<br>
					<td vAlign="top" align="center">
						<asp:calendar id="Calendar1" runat="server" EnableViewState="True" BackColor="White" ForeColor="Black" Font-Size="7pt"
							Font-Names="Verdana" BorderColor="#999999" ToolTip="Click to Select Expense month to open"
							NextMonthText="-&amp;gt;" PrevMonthText="&amp;lt;-" BorderStyle="None" Height="120px">
							<TodayDayStyle ForeColor="Black" BackColor="#CCCCCC"></TodayDayStyle>
							<SelectorStyle BackColor="#CCCCCC"></SelectorStyle>
							<NextPrevStyle VerticalAlign="Bottom"></NextPrevStyle>
							<DayHeaderStyle Font-Size="7pt" Font-Bold="True" BackColor="#CCCCCC"></DayHeaderStyle>
							<SelectedDayStyle Font-Bold="True" ForeColor="White" BackColor="#666666"></SelectedDayStyle>
							<TitleStyle Font-Bold="True" BorderColor="Black" BackColor="#999999"></TitleStyle>
							<WeekendDayStyle BackColor="#FFFFCC"></WeekendDayStyle>
							<OtherMonthDayStyle ForeColor="Gray"></OtherMonthDayStyle>
						</asp:calendar>
					</td>
					<td class="td">&nbsp; Group By:
						<asp:RadioButtonList id="rdoGroupBy" runat="server" Width="93px" class="label" AutoPostBack="True">
							<asp:ListItem Value="0">Client</asp:ListItem>
							<asp:ListItem Value="1">Resource</asp:ListItem>
						</asp:RadioButtonList>
					</td>
					<br>
				</tr>
				<TR>
					<td colspan="2">
						<asp:placeholder id="timePlace" runat="server" EnableViewState="False"></asp:placeholder>
					</td>
				</TR>
		</table> <!-- END tbltime --></TD>
		<tr>
			<td vAlign="top" align="center" colspan="2">
				<table id="tblComment">
					<tr>
						<td class="td">Reason for Rejecting</td>
					</tr>
					<tr>
						<td class="td">
							<asp:textbox id="txtComment" onblur="saveComment();" CssClass="TextArea" Runat="server" Width="300px"
								Rows="5" TextMode="MultiLine"></asp:textbox></td>
					</tr>
				</table>
			</td>
		<tr>
			<td vAlign="top" align="center" colspan="2">
				<asp:button id="btnSubmit" runat="server" Cssclass="button" text="Submit"></asp:button>
				<asp:button id="btnCancel" runat="server" Cssclass="button" text="Cancel"></asp:button>
			</td>
		</tr></TBODY></TABLE>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
