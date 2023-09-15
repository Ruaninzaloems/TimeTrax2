<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FinancialDocTypeEmailAdd.aspx.vb" Inherits="TimeTrax.FinancialDocTypeEmailAdd"%>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<body>
	<im:Header id="ucHeader" runat="server"></im:Header>
	<form id="Form1" method="post" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="tdmenu">
					<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
				</td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Manage Constants - Financial Document Type Emails</th>
			</tr>
			<tr>
				<td valign="top" class="td3">
					<table width="98%" align="center">
						<tr>
							<td vAlign="top" width="100%"><br>
								<table width="100%" align="center">
									<tr>
										<td>
											<div id="tblwizard2" runat="server">
												<table width="90%" align="center" class="t1">
													<tr>
														<td class="td1">Financial Document Type:</td>
														<td class="td2">
															<asp:TextBox id="txtFinDocType" runat="server" CssClass="InputRO" ReadOnly="True"></asp:TextBox>
														</td>
													</tr>
													<tr>
														<td class="td1">User:</td>
														<td class="td2" vAlign="top" align="left">
															<asp:dropdownlist id="ddlUser" runat="server" CssClass="select" DataTextField="UserD" DataValueField="UserID"
																Width="100%"></asp:dropdownlist>
														</td>
													</tr>
													<tr>
														<td class="td2" align="center" colspan="2">
															<asp:button id="btnSubmit" CssClass="button" Runat="server" Text="Submit"></asp:button>
															<asp:button id="btnCancel" CssClass="button" Runat="server" Text="Cancel"></asp:button>
														</td>
													</tr>
												</table>
											</div>
											<div id="tblwizard3" runat="server">
												<table cellSpacing="0" cellPadding="0" width="400" align="center" border="0">
													<tr>
														<td class="td" vAlign="top" align="center"><asp:label id="lblmessage" runat="server"></asp:label></td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<asp:validationsummary id="validationsummary1" style="Z-INDEX: 103; LEFT: 16px" runat="server" width="696px"
						height="88px" showsummary="false" showmessagebox="true"></asp:validationsummary>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
</body>
