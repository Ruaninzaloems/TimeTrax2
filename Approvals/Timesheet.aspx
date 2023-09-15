<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Timesheet.aspx.vb" Inherits="TimeTrax.TimesheetApproval" EnableViewState="True"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<body>
	<im:header id="ucHeader" runat="server"></im:header>
	<form id="Form1" method="post" runat="server">
		<table border="0" cellSpacing="0" cellPadding="0" width="100%">
			<tr>
				<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Timesheets Approval</th></tr>
			<tr>
				<td class="td3" vAlign="top">
					<table width="100%">
						<tr vAlign="top">
							<td width="33%" align="left">
								<table class="t1">
									<tr>
										<td class="td1">Group By:</td>
									</tr>
									<tr>
										<td class="td2"><asp:radiobuttonlist id="rdoGroupBy" class="label" runat="server" EnableViewState="True" Width="93px"
												AutoPostBack="True">
												<asp:ListItem Value="0">Project</asp:ListItem>
												<asp:ListItem Value="1">Resource</asp:ListItem>
											</asp:radiobuttonlist></td>
									</tr>
								</table>
							</td>
							<td width="34%" align="center">
								<table class="t1">
									<tr>
										<td><asp:datagrid id="dgAwaitingApproval" runat="server" Width="100%" ShowHeader="True" HorizontalAlign="Center"
												AutoGenerateColumns="False">
												<AlternatingItemStyle CssClass="grid-alt2"></AlternatingItemStyle>
												<ItemStyle CssClass="grid-alt1"></ItemStyle>
												<HeaderStyle CssClass="grid-header"></HeaderStyle>
												<Columns>
													<asp:BoundColumn HeaderText="Week Period" DataField="Detail"></asp:BoundColumn>
												</Columns>
											</asp:datagrid></td>
									</tr>
								</table>
							</td>
							<td align="right">
								<table class="t2">
									<tr>
										<td class="td1"><asp:calendar id="Calendar1" runat="server" Height="120px" BorderStyle="None" PrevMonthText="&amp;lt;-"
												NextMonthText="-&amp;gt;" ToolTip="Click to Select Timesheet Week to open" BorderColor="#999999" Font-Bold="True"
												Font-Names="Verdana" Font-Size="8pt" ForeColor="#A4A4A4" BackColor="#F3F4F5">
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
					</table>
				</td>
			</tr>
			<div id="divTeamleader" runat="server">
				<tr>
					<th id="menu11" class="th">
						<IMG style="TOP: 3px; CURSOR: hand; LEFT: 0px" id="menu11a" onclick="ToggleDisplay(menu11a, menu11b, 'menu11');"
							align="right" src="../Images/up.gif"> Teamleader Approvals</th></tr>
				<tr>
				<tr>
					<td><SPAN style="DISPLAY: block" id="menu11b">
							<table class="t2" width="100%" colSpan="2">
								<tr>
									<td class="td3"><asp:placeholder id="timePlace" runat="server" EnableViewState="False"></asp:placeholder></td>
								</tr>
								<tr>
									<td class="td3" vAlign="top" colSpan="2" align="center"><table id="tblComment">
											<tr>
												<td class="td">Reason for Rejecting</td>
											</tr>
											<tr>
												<td class="td"><asp:textbox onblur="saveComment(1);" id="txtComment" Width="300px" CssClass="TextArea" Runat="server"
														Rows="5" TextMode="MultiLine"></asp:textbox></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="td3" vAlign="top" colSpan="2" align="center"><input class="button" onclick="checkReject('time','TeamLeader');" value="Submit Team Leader Approvals"
											type="button">
										<asp:button id="btnCancel" runat="server" text="Cancel" Cssclass="button"></asp:button></td>
								</tr>
							</table>
						</SPAN></td>
				</tr>
			</div>
			<div id="divManager" runat="server">
				<tr>
					<th id="menu22" class="th">
						<IMG style="TOP: 3px; CURSOR: hand; LEFT: 0px" id="menu22a" onclick="ToggleDisplay(menu22a, menu22b, 'menu22');"
							align="right" src="../Images/up.gif"> Manager Approvals</th></tr>
				<tr>
				<tr>
					<td><SPAN style="DISPLAY: block" id="menu22b">
							<table class="t2" width="100%" colSpan="2">
								<tr>
									<td class="td3"><asp:placeholder id="plcTimeManager" runat="server" EnableViewState="False"></asp:placeholder></td>
								</tr>
								<tr>
									<td class="td3" vAlign="top" colSpan="2" align="center"><table id="tblCommentManager">
											<tr>
												<td class="td">Reason for Rejecting</td>
											</tr>
											<tr>
												<td class="td"><asp:textbox onblur="saveComment(2);" id="txtManagerComment" Width="300px" CssClass="TextArea"
														Runat="server" Rows="5" TextMode="MultiLine"></asp:textbox></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="td3" vAlign="top" colSpan="2" align="center"><input class="button" onclick="checkReject('time','Manager');" value="Submit Manager Approvals"
											type="button">
										<asp:button id="btnSubmitManager" runat="server" CssClass="inputhidden" text="Submit"></asp:button><asp:button id="btnCancelManager" runat="server" text="Cancel" Cssclass="button"></asp:button></td>
								</tr>
							</table>
						</SPAN></td>
				</tr>
			</div>
			<div id="divManagerMonitor" runat="server">
				<tr>
					<th id="menu33" class="th">
						<IMG style="TOP: 3px; CURSOR: hand; LEFT: 0px" id="menu33a" onclick="ToggleDisplay(menu33a, menu33b, 'menu33');"
							align="right" src="../Images/up.gif"> Monitor Approvals</th></tr>
				<tr>
					<td><SPAN style="DISPLAY: block" id="menu33b">
							<table class="t2" width="100%" colSpan="2">
								<tr>
									<td class="td3"><asp:placeholder id="plcTimeManagerMonitor" runat="server" EnableViewState="False"></asp:placeholder></td>
								</tr>
								<tr>
									<td class="td3" vAlign="top" colSpan="2" align="center"><table id="tblCommentManagerMonitor">
											<tr>
												<td class="td">Reason for Rejecting</td>
											</tr>
											<tr>
												<td class="td"><asp:textbox onblur="saveComment(3);" id="txtManagerMonitorComment" Width="300px" CssClass="TextArea"
														Runat="server" Rows="5" TextMode="MultiLine"></asp:textbox></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="td3" vAlign="top" colSpan="2" align="center"><input class="button" onclick="checkReject('time','ManagerMonitor');" value="Submit Manager Approvals on behalf of Team Leader (Override)"
											type="button">
										<asp:button id="btnSubmitManagerMonitor" runat="server" CssClass="inputhidden" text="Submit"></asp:button><asp:button id="btnCancelManagerMonitor" runat="server" text="Cancel" Cssclass="button"></asp:button></td>
								</tr>
							</table>
						</SPAN>
					</td>
				</tr>
			</div>
			<div id="divMD" runat="server">
				<tr>
					<th id="menu44" class="th">
						<IMG style="TOP: 3px; CURSOR: hand; LEFT: 0px" id="menu44a" onclick="ToggleDisplay(menu44a, menu44b, 'menu44');"
							align="right" src="../Images/up.gif"> MD Approvals</th></tr>
				<tr>
					<td><SPAN style="DISPLAY: block" id="menu44b">
							<table class="t2" width="100%" colSpan="2">
								<tr>
									<td class="td3"><asp:placeholder id="plcTimeMD" runat="server" EnableViewState="False"></asp:placeholder></td>
								</tr>
								<tr>
									<td class="td3" vAlign="top" colSpan="2" align="center"><table id="tblCommentMD">
											<tr>
												<td class="td">Reason for Rejecting</td>
											</tr>
											<tr>
												<td class="td"><asp:textbox onblur="saveComment(4);" id="txtMDComment" Width="300px" CssClass="TextArea" Runat="server"
														Rows="5" TextMode="MultiLine"></asp:textbox></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="td3" vAlign="top" colSpan="2" align="center"><input class="button" onclick="checkReject('time','MD');" value="Submit MD Approvals" type="button">
										<asp:button id="btnSubmitMD" runat="server" CssClass="inputhidden" text="Submit"></asp:button><asp:button id="btnCancelMD" runat="server" text="Cancel" Cssclass="button"></asp:button></td>
								</tr>
							</table>
						</SPAN>
					</td>
				</tr>
			</div>
		</table>
		<input id="hidApprovalTypeSubmited" type="hidden" name="hidApprovalTypeSubmited" runat="server">
		<asp:button id="btnSubmit" runat="server" CssClass="inputhidden" text="Submit"></asp:button>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
