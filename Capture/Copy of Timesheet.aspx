<%@ Register TagPrefix="im" TagName="Footer" Src="/TimeTrax/Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="/TimeTrax/Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="/TimeTrax/Components/User Controls/Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Timesheet.aspx.vb" Inherits="TimeTrax.Timesheet"%>
<body>
	<im:header id="ucHeader" runat="server"></im:header>
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<th class="th" colSpan="2">
				Timesheet Capture</TD>
			</tr>
			<tr>
				<td class="td" align="center">
					<table>
						<tr>
							<th class="header"><font color="red"><b>Outstanding Timesheets</font></th>
						</tr>
						<tr>
							<td class="td">
								<asp:datagrid id="dgOutstanding" runat="server" ShowHeader="True" HorizontalAlign="Center" AutoGenerateColumns="False"
									Width="100%">
									<AlternatingItemStyle CssClass="grid-alt2"></AlternatingItemStyle>
									<ItemStyle CssClass="grid-alt1"></ItemStyle>
									<HeaderStyle CssClass="grid-header"></HeaderStyle>
									<Columns>
										<asp:BoundColumn HeaderText="Week Period" DataField="WeekPeriod"></asp:BoundColumn>
									</Columns>
								</asp:datagrid>
							</td>
						</tr>
					</table>
				</td>
				<td class="td" align="center"><br>
					<asp:calendar id="Calendar1" runat="server" Height="120px" BorderStyle="None" PrevMonthText="&amp;lt;-"
						NextMonthText="-&amp;gt;" ToolTip="Click to Select Timesheet Week to open" BorderColor="#999999"
						Font-Names="Verdana" Font-Size="7pt" ForeColor="Black" BackColor="White">
						<TodayDayStyle ForeColor="Black" BackColor="#CCCCCC"></TodayDayStyle>
						<SelectorStyle BackColor="#CCCCCC"></SelectorStyle>
						<NextPrevStyle VerticalAlign="Bottom"></NextPrevStyle>
						<DayHeaderStyle Font-Size="7pt" Font-Bold="True" BackColor="#CCCCCC"></DayHeaderStyle>
						<SelectedDayStyle Font-Bold="True" ForeColor="White" BackColor="#666666"></SelectedDayStyle>
						<TitleStyle Font-Bold="True" BorderColor="Black" BackColor="#999999"></TitleStyle>
						<WeekendDayStyle BackColor="#FFFFCC"></WeekendDayStyle>
						<OtherMonthDayStyle ForeColor="Gray"></OtherMonthDayStyle>
					</asp:calendar><br>
				</td>
			</tr>
			<TR>
				<td colSpan="2">
					<table id="tbltime" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server"
						name="tbltime">
						<tr>
							<th class="th1" width="44%">
								&nbsp;</th>
							<th class="th1" width="7%">
								<asp:label id="lblDay1Num" Runat="server"></asp:label></th>
							<th class="th1" width="7%">
								<asp:label id="lblDay2Num" Runat="server"></asp:label></th>
							<th class="th1" width="7%">
								<asp:label id="lblDay3Num" Runat="server"></asp:label></th>
							<th class="th1" width="7%">
								<asp:label id="lblDay4Num" Runat="server"></asp:label></th>
							<th class="th1" width="7%">
								<asp:label id="lblDay5Num" Runat="server"></asp:label></th>
							<th class="th1" width="7%">
								<asp:label id="lblDay6Num" Runat="server"></asp:label></th>
							<th class="th1" width="7%">
								<asp:label id="lblDay7Num" Runat="server"></asp:label></th>
							<th class="th1" width="7%">
								&nbsp;<input id="time_base" type="hidden" name="time_base" runat="server"></th></tr>
						<tr>
							<th class="th1">
								&nbsp;</th>
							<th class="th1">
								<asp:label id="lblDay1" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay2" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay3" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay4" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay5" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay6" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay7" Runat="server"></asp:label></th>
							<th class="th1">
								Total</th></tr>
						<tr>
							<td class="td"><asp:placeholder id="timePlace" runat="server"></asp:placeholder><input id="deleted_list" type="hidden" name="deleted_list">
							</td>
						</tr>
					</table> <!-- END tbltime -->
					<table id="tbltimefoot" cellSpacing="0" cellPadding="2" width="100%" border="0" runat="server"
						name="tbltimefoot">
						<tr>
							<th class="th2" align="right" width="44%">
								<b>Total :&nbsp;&nbsp;</b></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtDay1Tot" runat="server" cssclass="Total" size="8" ReadOnly="True"></asp:textbox></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtDay2Tot" runat="server" cssclass="Total" size="8" ReadOnly="True"></asp:textbox></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtDay3Tot" runat="server" cssclass="Total" size="8" ReadOnly="True"></asp:textbox></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtDay4Tot" runat="server" cssclass="Total" size="8" ReadOnly="True"></asp:textbox></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtDay5Tot" runat="server" cssclass="Total" size="8" ReadOnly="True"></asp:textbox></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtDay6Tot" runat="server" cssclass="Total" size="8" ReadOnly="True"></asp:textbox></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtDay7Tot" runat="server" cssclass="Total" size="8" ReadOnly="True"></asp:textbox></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtTotal" runat="server" cssclass="Total" size="8" ReadOnly="True"></asp:textbox></th></tr>
					</table> <!-- END tbltimefoot --></td>
			</TR>
			<tr>
				<td vAlign="top" align="center" colSpan="2">
					<table id="tblComment">
						<tr>
							<td class="td">Comments</td>
						</tr>
						<tr>
							<td class="td"><asp:textbox id="txtComment" onblur="saveComment();" Width="300px" Runat="server" TextMode="MultiLine"
									Rows="5" CssClass="TextArea"></asp:textbox><asp:requiredfieldvalidator id="rfvComments" runat="server" InitialValue=" " ErrorMessage="Please enter comments for all red items!"
									Display="None" ControlToValidate="txtComment"></asp:requiredfieldvalidator>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr id="tr_reject" style="DISPLAY: none" runat="server">
				<td vAlign="top" align="center" colSpan="2">
					<table>
						<tr>
							<td class="td"><font color="red">Rejection Comment</font></td>
						</tr>
						<tr>
							<td class="td">
								<asp:textbox id="txtRejComment" Width="300px" BackColor="Red" ForeColor="White" Runat="server" TextMode="MultiLine"
									Rows="5" CssClass="TextArea"></asp:textbox>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td vAlign="top" align="center" colSpan="2"><input class="button" id="htmTasks" onclick="openAddTask();" type="button" value="Add tasks"
						name="htmTasks" runat="server">
					<asp:button id="btnSave" runat="server" CssClass="button" CausesValidation="False" text="Save"></asp:button><asp:button id="btnSubmit" runat="server" CssClass="button" CausesValidation="False" text="Submit for Approval"></asp:button><asp:button id="btnUnsubmit" runat="server" CssClass="button" CausesValidation="False" text="Recall Submitted Timesheet"
						Enabled="False"></asp:button></td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
