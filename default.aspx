<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="TimeTrax.Default1" SmartNavigation=true%>
<%@ Register TagPrefix="im" TagName="Header" Src="Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="Components/User Controls/Footer.ascx" %>
<im:header id="ucHeader" runat="server"></im:header>
<form id="Form1" method="post" runat="server">
	<table cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
		</tr>
	</table>
	<table class="t4" cellSpacing="0" cellPadding="0" width="100%" border="1">
		<tr>
			<td class="td3" vAlign="top">
				<table class="t2" width="45%" align="left">
					<tr>
						<td>
							<!-- Alerts ************************************************************************************************-->
							<div id="divPTO" style="DISPLAY: none" runat="server">
								<table>
									<tr>
										<th class="thtrigger">
											Project Take On</th></tr>
									<tr id="ProjTakeOn" runat="server">
										<td class="td1"><IMG id=menu2a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu2a, menu2b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu2a, menu2b);"><u>
													<asp:label id="labProjTakeOn" Runat="server"></asp:label></u>&nbsp; 
                  </SPAN><BR clear="all">
											<div id="menu2b" style="DISPLAY: none" align="center"><asp:datagrid id="dgProjTakeOn" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
													<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="PTOApprove" runat="server">
										<td class="td1"><IMG id=menu3a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu3a, menu3b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu3a, menu3b);"><u>
													<asp:label id="labPTOApprove" Runat="server">awaiting approval</asp:label></u>&nbsp; 
                  </SPAN><BR clear="all">
											<div id="menu3b" style="DISPLAY: none" align="center"><asp:datagrid id="dgPTOApprove" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
													<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
								</table>
							</div>
							<div id="divVO" style="DISPLAY: none" runat="server">
								<table>
									<tr>
										<th class="thtrigger">
											Variation Orders</th></tr>
									<tr id="VOApprove" runat="server">
										<td class="td1"><IMG id=menu1a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu1a, menu1b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu1a, menu1b);"><u>
													<asp:label id="labVOApprove" Runat="server">awaiting approval</asp:label></u>&nbsp; 
                  </SPAN><BR clear="all">
											<div id="menu1b" style="DISPLAY: none" align="center"><asp:datagrid id="dgVOApprove" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
													<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
								</table>
							</div>
							<div id="DivTS" style="DISPLAY: none" runat="server">
								<table>
									<tr>
										<th class="thtrigger">
											Time Sheets</th></tr>
									<tr id="TimesheetOverdue" runat="server">
										<td class="td1"><IMG id=menu4a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu4a, menu4b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu4a, menu4b);"><u>
													<asp:label id="labTimesheetOverdue" Runat="server">overdue</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu4b" style="DISPLAY: none" align="center"><asp:datagrid id="dgTimesheetOverdue" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="TimesheetRejected" runat="server">
										<td class="td1"><IMG id=menu24a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu24a, menu24b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu24a, menu24b);"><u>
													<asp:label id="labRejectedTimesheet" Runat="server"></asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu24b" style="DISPLAY: none" align="center"><asp:datagrid id="dgRejectedTimesheet" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="TimesheetApproval" runat="server">
										<td class="td1"><IMG id=menu7a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu7a, menu7b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu7a, menu7b);"><u>
													<asp:label id="labTimesheetApproval" Runat="server">awaiting approval (Team Leader)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu7b" style="DISPLAY: none" align="center"><asp:datagrid id="dgTimesheetApproval" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="trTimesheetApprovalManager" runat="server">
										<td class="td1"><IMG id=menu25a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu25a, menu25b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu25a, menu25b);"><u>
													<asp:label id="labTimesheetManagerApproval" Runat="server">awaiting approval (Manager)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu25b" style="DISPLAY: none" align="center"><asp:datagrid id="dgTimesheetApprovalManager" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="trTimesheetApprovalManagerMonitoring" runat="server">
										<td class="td1"><IMG id=menu26a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu26a, menu26b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu26a, menu26b);"><u>
													<asp:label id="labTimesheetManagerMonitorApproval" Runat="server">awaiting approval (Monitoring)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu26b" style="DISPLAY: none" align="center"><asp:datagrid id="dgTimesheetApprovalManagerMonitoring" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="trTimesheetApprovalMD" runat="server">
										<td class="td1"><IMG id=menu33a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu33a, menu33b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu33a, menu33b);"><u>
													<asp:label id="labTimesheetMDApproval" Runat="server">awaiting approval (MD)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu33b" style="DISPLAY: none" align="center"><asp:datagrid id="dgTimesheetApprovalMD" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
								</table>
							</div>
							<div id="DivEXP" style="DISPLAY: none" runat="server">
								<table>
									<tr>
										<th class="thtrigger">
											Expenses</th></tr>
									<tr id="ExpenseApproval" runat="server">
										<td class="td1"><IMG id=menu15a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu15a, menu15b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu15a, menu15b);"><u>
													<asp:label id="labExpenseApproval" Runat="server">awaiting approval (Team Leader)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu15b" style="DISPLAY: none" align="center"><asp:datagrid id="dgExpenseApproval" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="trExpenseApprovalManager" runat="server">
										<td class="td1"><IMG id=menu27a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu27a, menu27b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu27a, menu27b);"><u>
													<asp:label id="labExpenseApprovalManager" Runat="server">awaiting approval (Manager)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu27b" style="DISPLAY: none" align="center"><asp:datagrid id="dgExpenseApprovalManager" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="trExpenseApprovalManagerMonitor" runat="server">
										<td class="td1"><IMG id=menu28a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu28a, menu28b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu28a, menu28b);"><u>
													<asp:label id="labExpenseApprovalMonitor" Runat="server">awaiting approval (Monitoring)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu28b" style="DISPLAY: none" align="center"><asp:datagrid id="dgExpenseApprovalMonitor" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="trExpenseApprovalMD" runat="server">
										<td class="td1"><IMG id=menu34a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu34a, menu34b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu34a, menu34b);"><u>
													<asp:label id="labExpenseApprovalMD" Runat="server">awaiting approval (MD)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu34b" style="DISPLAY: none" align="center"><asp:datagrid id="dgExpenseApprovalMD" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="ExpenseRejected" runat="server">
										<td class="td1"><IMG id=menu22a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu22a, menu22b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu22a, menu22b);"><u>
													<asp:label id="labRejectedExpense" Runat="server"></asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu22b" style="DISPLAY: none" align="center"><asp:datagrid id="dgRejectedExpense" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
								</table>
							</div>
							<div id="divFinancialDocuments" style="DISPLAY: none" runat="server">
								<table>
									<tr>
										<th class="thtrigger">
											Financial Documents</th></tr>
									<tr id="trFinDocTeamleaderApproval" runat="server">
										<td class="td1"><IMG id=menu29a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu29a, menu29b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu29a, menu29b);"><u>
													<asp:label id="labFinDocTeamleader" Runat="server">awaiting approval (Team Leader)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu29b" style="DISPLAY: none" align="center"><asp:datagrid id="dgFinDocTeamleader" runat="server" Width="100%" AutoGenerateColumns="False"
													ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="trFinDocManagerMonitorApproval" runat="server">
										<td class="td1"><IMG id=menu31a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu31a, menu31b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu31a, menu31b);"><u>
													<asp:label id="labFinDocMonitor" Runat="server">awaiting approval (Monitoring)</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu31b" style="DISPLAY: none" align="center"><asp:datagrid id="dgFinDocMonitor" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="trFinDocRejected" runat="server">
										<td class="td1"><IMG id=menu32a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu32a, menu32b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu32a, menu32b);"><u>
													<asp:label id="labFinDocRejected" Runat="server"></asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu32b" style="DISPLAY: none" align="center"><asp:datagrid id="dgFinDocRejected" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
								</table>
							</div>
							<div id="DivStatus" style="DISPLAY: none" runat="server">
								<table>
									<tr>
										<th class="thtrigger">
											Project Status</th></tr>
									<tr id="OverBudget" runat="server">
										<td class="td1"><IMG id=menu18a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu18a, menu18b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu18a, menu18b);"><u>
													<asp:label id="labOverBudget" Runat="server">over resourced</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu18b" style="DISPLAY: none" align="center"><asp:datagrid id="dgOverBudget" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="UnderBudget" runat="server">
										<td class="td1"><IMG id=menu19a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu19a, menu19b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu19a, menu19b);"><u>
													<asp:label id="labUnderBudget" Runat="server">under resourced</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu19b" style="DISPLAY: none" align="center"><asp:datagrid id="dgUnderBudget" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="Expiring" runat="server">
										<td class="td1"><IMG id=menu20a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu20a, menu20b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu20a, menu20b);"><u>
													<asp:label id="labExpiring" Runat="server">Expiring</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu20b" style="DISPLAY: none" align="center"><asp:datagrid id="dgExpiring" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<itemstyle cssclass="grid-trigalt1"></itemstyle>
													<alternatingitemstyle cssclass="grid-trigalt2"></alternatingitemstyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
				<table class="t2" width="45%" align="right">
					<tr>
						<td>
							<div id="divProjects" style="DISPLAY: none" runat="server">
								<table>
									<tr>
										<th class="thtrigger">
											My Projects</th></tr>
									<tr id="MyProj" runat="server">
										<td class="td1"><IMG id=menu21a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu21a, menu21b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu21a, menu21b);"><u>
													<asp:label id="labMyProjects" Runat="server"> on which you are active</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu21b" style="DISPLAY: none" align="center"><asp:datagrid id="dgMyProjects" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
													<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
									<tr id="CurrentProjects" runat="server">
										<td class="td1"><IMG id=menu23a 
                  style="TOP: 3px; CURSOR: pointer; LEFT: 0px" 
                  onclick="ToggleAlerts(menu23a, menu23b);" height=12 alt="" 
                  src="<%=Request.ApplicationPath%>/Images/down.gif" width=12 
                  align=right vspace=2 border=0>
											<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleAlerts(menu23a, menu23b);"><u>
													<asp:label id="labCurrentProjects" Runat="server"> for which you are a team leader</asp:label></u>&nbsp;</SPAN>
											<BR clear="all">
											<div id="menu23b" style="DISPLAY: none" align="center"><asp:datagrid id="dgCurrentProjects" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
													<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
													<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
													<Columns>
														<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
													</Columns>
												</asp:datagrid></div>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<im:footer id="ucFooter" runat="server"></im:footer></form>
