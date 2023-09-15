<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FinancialDocument.aspx.vb" Inherits="TimeTrax.FinancialDocument" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
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
					Financial Document Approval</th>
			</tr>
			<tr>
				<td class="td3" valign="top">
					<table width="100%">
						<tr valign="top">
							<td width="33%" align="left">
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
									<TABLE id="tblTeamleader" runat="server">
									</TABLE>
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
												<input type="button" class="button" value="Submit" onclick="checkFinancialDocReject('TeamLeader');">
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
			<div id="divMonitor" runat="server">
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
									<TABLE id="tblMonitor" runat="server">
									</TABLE>
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
												<input type="button" class="button" value="Submit" onclick="checkFinancialDocReject('ManagerMonitor');">
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
		</table>
		<input name="hidApprovalTypeSubmited" id="hidApprovalTypeSubmited" type="hidden" runat="server">
		<asp:button id="btnSubmit" runat="server" CssClass="inputhidden" text="Submit"></asp:button>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
