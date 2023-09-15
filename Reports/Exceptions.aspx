<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Exceptions.aspx.vb" Inherits="TimeTrax.Exceptions"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
<body>
	<form id="Form1" method="post" runat="server">
		<im:Header id="ucHeader" runat="server"></im:Header>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="tdmenu">
					<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
				</td>
			</tr>
		</table>
		<table class="t3" width="100%">
			<tr>
				<td>
					<table class="t4" width="100%">
						<tr>
							<th class="th" colspan="4">
								Report Filters
							</th>
						</tr>
						<tr>
							<td class="td" width="30%">Team Leader:</td>
							<td class="td">
								<asp:DropDownList id="ddlTeamLeader" runat="server" CssClass="select" AutoPostBack="False" DataValueField="UserID"
									DataTextField="UserName"></asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="4">
								<asp:button CssClass="button" id="btnGenerate" runat="server" name="btnGenerate" Text="Generate Report"></asp:button>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<div id="divReport" runat="server">
						<table class="t4" style="WIDTH: 100%">
							<tr>
								<td class="td" align="right" colSpan="4">
									<IMG id="Printbtn" onclick="printSpecial(this,'<%=Request.ApplicationPath%>')" alt="Print Report" src="../Images/print.gif"
										style="WIDTH:16px; CURSOR:pointer; HEIGHT:16px" >
									<asp:imagebutton id="imgExport" runat="server" ImageUrl="../Images/excel.gif" AlternateText="Export Report to Excel"
										style="CURSOR:pointer" Width="16" Height="16"></asp:imagebutton>
								</td>
							</tr>
							<asp:placeholder id="ReportPlace" runat="server">
								<TR>
									<TH class="th">
										Exceptions Report</TH></TR>
								<TR>
									<TD class="td3" vAlign="top">
										<TABLE class="t1" width="25%" align="center">
											<TR>
												<TH class="th1">
													Legend
												</TH>
											</TR>
											<TR>
												<TD class="td2">
													<asp:datagrid id="dgLegend" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="False">
														<HeaderStyle CssClass="grid-header"></HeaderStyle>
														<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
														<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
														<Columns>
															<asp:BoundColumn DataField="Status" HeaderText="Status" ItemStyle-Width="50%"></asp:BoundColumn>
															<asp:BoundColumn DataField="Colour" HeaderText="Colour" ItemStyle-Width="50%"></asp:BoundColumn>
														</Columns>
													</asp:datagrid></TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
								<TR>
									<TD class="td3" vAlign="top">
										<TABLE class="t1" width="100%" align="center">
											<TR>
												<TD class="td2">
													<asp:datagrid id="dgReport" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="True">
														<HeaderStyle CssClass="grid-header"></HeaderStyle>
														<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
														<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
														<Columns>
															<asp:BoundColumn DataField="ID" Visible="False"></asp:BoundColumn>
															<asp:BoundColumn DataField="Start" Visible="False"></asp:BoundColumn>
															<asp:BoundColumn DataField="End" Visible="False"></asp:BoundColumn>
															<asp:BoundColumn DataField="Name" HeaderText="Project" ItemStyle-Width="50%"></asp:BoundColumn>
															<asp:BoundColumn DataField="TimeStatus" HeaderText="Time" ItemStyle-Width="25%"></asp:BoundColumn>
															<asp:BoundColumn DataField="CostStatus" HeaderText="Cost" ItemStyle-Width="25%"></asp:BoundColumn>
														</Columns>
													</asp:datagrid></TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
							</asp:placeholder>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
</body>
