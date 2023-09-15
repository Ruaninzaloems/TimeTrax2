<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Expense.aspx.vb" Inherits="TimeTrax.Expense1" EnableViewState="True"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<body>
	<im:header id="ucHeader" runat="server"></im:header>
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Expenses Approval</th>
			</tr>
			<tr>
				<td class="td3" valign="top">
					<table width="100%">
						<tr valign="top">
							<td width="33%" align="left">
								<table class="t1" align="left">
									<tr>
										<td class="td1">Group By:</td>
									</tr>
									<tr>
										<td class="td2">
											<asp:RadioButtonList id="rdoGroupBy" runat="server" Width="93px" class="label" AutoPostBack="True">
												<asp:ListItem Value="0">Client</asp:ListItem>
												<asp:ListItem Value="1">Resource</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
								</table>
							</td>
							<td width="34%" align="center">
								<table class="t1">
									<tr>
										<td><asp:datagrid id="dgAwaitingApproval" runat="server" Width="100%" AutoGenerateColumns="False"
												HorizontalAlign="Center" ShowHeader="True">
												<AlternatingItemStyle CssClass="grid-alt2"></AlternatingItemStyle>
												<ItemStyle CssClass="grid-alt1"></ItemStyle>
												<HeaderStyle CssClass="grid-header"></HeaderStyle>
												<Columns>
													<asp:BoundColumn HeaderText="Week Period" DataField="Detail" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
												</Columns>
											</asp:datagrid></td>
									</tr>
								</table>
							</td>
							<td align="right">
								<table class="t2">
									<tr>
										<td class="td1">
											<asp:calendar id="Calendar1" runat="server" Height="120px" BorderStyle="None" PrevMonthText="&amp;lt;-"
												NextMonthText="-&amp;gt;" ToolTip="Click to Select Expense month to open" BorderColor="#999999"
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
					</table>
				</td>
			</tr>
			<div id="divTeamleader" runat="server">
				<tr>
					<th id="menu11" class="th">
						<img src="../Images/up.gif" id="menu11a" onclick="ToggleDisplay(menu11a, menu11b, 'menu11');"
							align="right" Style="TOP: 3px; CURSOR: hand; LEFT: 0px"> Teamleader 
						Approvals</th></tr>
				<tr>
				<tr>
					<td>
						<Span id="menu11b" Style="DISPLAY:block">
							<table class="t2" width="100%" colSpan="2">
								<tr>
									<td class="td3">
										<asp:placeholder id="timePlace" runat="server" EnableViewState="False"></asp:placeholder>
									</td>
								</tr>
								<tr>
									<td vAlign="top" align="center" colspan="2" class="td3">
										<table id="tblComment">
											<tr>
												<td class="td">Reason for Rejecting</td>
											</tr>
											<tr>
												<td class="td">
													<asp:textbox id="txtComment" onblur="saveComment(1);" CssClass="TextArea" Runat="server" Width="300px"
														Rows="5" TextMode="MultiLine"></asp:textbox>
												</td>
											</tr>
											<tr>
												<td class="td3" vAlign="top" align="center" colSpan="2">
													<input type="button" class="button" value="Submit Team Leader Approvals" onclick="checkReject('exp','TeamLeader');">													
													<asp:button id="btnCancel" runat="server" Cssclass="button" text="Cancel"></asp:button>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</Span>
					</td>
				</tr>
			</div>
			<div id="divManager" runat="server">
				<tr>
					<th id="menu22" class="th">
						<img src="../Images/up.gif" id="menu22a" onclick="ToggleDisplay(menu22a, menu22b, 'menu22');"
							align="right" Style="TOP: 3px; CURSOR: hand; LEFT: 0px"> Manager Approvals</th></tr>
				<tr>
				<tr>
					<td>
						<Span id="menu22b" Style="DISPLAY:block">
							<table class="t2" width="100%" colSpan="2">
								<tr>
									<td class="td3">
										<asp:placeholder id="plcTimeManager" runat="server" EnableViewState="False"></asp:placeholder>
									</td>
								</tr>
								<tr>
									<td vAlign="top" align="center" colspan="2" class="td3">
										<table id="tblCommentManager">
											<tr>
												<td class="td">Reason for Rejecting</td>
											</tr>
											<tr>
												<td class="td">
													<asp:textbox id="txtManagerComment" onblur="saveComment(2);" CssClass="TextArea" Runat="server"
														Width="300px" Rows="5" TextMode="MultiLine"></asp:textbox>
												</td>
											</tr>
											<tr>
												<td class="td3" vAlign="top" align="center" colSpan="2">
													<input type="button" class="button" value="Submit Manager Approvals" onclick="checkReject('exp','Manager');">
													<asp:button id="btnSubmitManager" runat="server" CssClass="inputhidden" text="Submit"></asp:button>
													<asp:button id="btnCancelManager" runat="server" Cssclass="button" text="Cancel"></asp:button>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</Span>
					</td>
				</tr>
			</div>
			<div id="divManagerMonitor" runat="server">
				<tr>
					<th id="menu33" class="th">
						<img src="../Images/up.gif" id="menu33a" onclick="ToggleDisplay(menu33a, menu33b, 'menu33');"
							align="right" Style="TOP: 3px; CURSOR: hand; LEFT: 0px"> Monitor Approvals</th></tr>
				<tr>
				<tr>
					<td>
						<Span id="menu33b" Style="DISPLAY:block">
							<table class="t2" width="100%" colSpan="2">
								<tr>
									<td class="td3">
										<asp:placeholder id="plcTimeManagerMonitor" runat="server" EnableViewState="False"></asp:placeholder>
									</td>
								</tr>
								<tr>
									<td vAlign="top" align="center" colspan="2" class="td3">
										<table id="tblCommentManagerMonitor">
											<tr>
												<td class="td">Reason for Rejecting</td>
											</tr>
											<tr>
												<td class="td">
													<asp:textbox id="txtManagerMonitorComment" onblur="saveComment(3);" CssClass="TextArea" Runat="server"
														Width="300px" Rows="5" TextMode="MultiLine"></asp:textbox>
												</td>
											</tr>
											<tr>
												<td class="td3" vAlign="top" align="center" colSpan="2">
													<input type="button" class="button" value="Submit Manager Approvals on behalf of Team Leader (Override)" onclick="checkReject('exp','ManagerMonitor');">
													<asp:button id="btnSubmitManagerMonitor" runat="server" CssClass="inputhidden" text="Submit"></asp:button>
													<asp:button id="btnCancelManagerMonitor" runat="server" Cssclass="button" text="Cancel"></asp:button>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</Span>
					</td>
				</tr>
			</div>
			<div id="divMD" runat="server">
				<tr>
					<th id="menu44" class="th">
						<img src="../Images/up.gif" id="menu44a" onclick="ToggleDisplay(menu44a, menu44b, 'menu44');"
							align="right" Style="TOP: 3px; CURSOR: hand; LEFT: 0px"> MD Approvals</th></tr>
				<tr>
					<td>
						<Span id="menu44b" Style="DISPLAY:block">
							<table class="t2" width="100%" colSpan="2">
								<tr>
									<td class="td3">
										<asp:placeholder id="plcTimeManagerMD" runat="server" EnableViewState="False"></asp:placeholder>
									</td>
								</tr>
								<tr>
									<td vAlign="top" align="center" colspan="2" class="td3">
										<table id="tblCommentMD">
											<tr>
												<td class="td">Reason for Rejecting</td>
											</tr>
											<tr>
												<td class="td">
													<asp:textbox id="txtMDComment" onblur="saveComment(4);" CssClass="TextArea" Runat="server" Width="300px"
														Rows="5" TextMode="MultiLine"></asp:textbox>
												</td>
											</tr>
											<tr>
												<td class="td3" vAlign="top" align="center" colSpan="2">
													<input type="button" class="button" value="Submit MD Approvals" onclick="checkReject('exp','MD');">
													<asp:button id="btnSubmitMDMonitor" runat="server" CssClass="inputhidden" text="Submit"></asp:button>
													<asp:button id="btnCancelMDMonitor" runat="server" Cssclass="button" text="Cancel"></asp:button>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</Span>
					</td>
				</tr>
			</div>
		</table>
		<input name="hidApprovalTypeSubmited" id="hidApprovalTypeSubmited" type="hidden" runat="server">
		<asp:button id="btnSubmit" runat="server" CssClass="inputhidden" text="Submit"></asp:button>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
