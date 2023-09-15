<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FinancialDocTypeEmail.aspx.vb" Inherits="TimeTrax.FinancialDocTypeEmail"%>
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
											<div id="tblwizard1" runat="server">
												<table width="80%" align="center">
													<tr>
														<td class="td1" vAlign="top" width="25%">
															Edit a Financial Document Type Email Details:&nbsp;
														</td>
														<td class="td2" vAlign="top" align="left">
															<asp:dropdownlist id="ddlFinDocType" runat="server" CssClass="select" DataTextField="FinancialDocType"
																DataValueField="FinancialDocTypeID" Width="100%"></asp:dropdownlist>
														</td>
													</tr>
													<tr>
														<td class="td2" colspan="2" align="center">
															<asp:button id="btngo" runat="server" Text="Submit" Cssclass="button"></asp:button>
														</td>
													</tr>
												</table>
											</div>
											<div id="tblwizard2" runat="server">
												<table width="90%" align="center" class="t1">
													<tr>
														<td class="td1">Financial Document Type:</td>
														<td class="td2">
															<asp:TextBox id="txtFinDocType" runat="server" CssClass="InputRO" ReadOnly="True"></asp:TextBox>
														</td>
													</tr>
													<tr>
														<td colspan="2">
															<table runat="server" id="tblEmail" width="95%" class="t2">
																<tr>
																	<th class="th1" width="40%">
																		Full Name</th>
																	<th class="th1" width="50%">
																		Email</th>
																	<th class="th1" width="10%">
																		Delete</th>
																</tr>
															</table>
														</td>
													</tr>
												</table>
												<table width="90%" align="center" class="t1">
													<tr>
														<td class="td2" align="center">
															<asp:button id="btnSubmit" CssClass="button" Runat="server" Text="Add Email"></asp:button>
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
											<asp:textbox id="txtrecid" runat="server" CssClass="inputhidden"></asp:textbox>
											<asp:textbox id="txtpostback" runat="server" CssClass="inputhidden"></asp:textbox>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="center" colSpan="3">
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
