<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Countries.aspx.vb" Inherits="TimeTrax.Countries"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<body>
<im:Header id="ucHeader" runat="server"></im:Header>
<form id="Form1" method="post" runat="server">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
			</td>
		</tr>
	</table>
	<table class="t4" width="100%" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<th class="th">Manage Constants - Countries</th>
		</tr>
		<tr>
			<td valign="top">
				<table class="t4a" cellSpacing="0" cellPadding="5" width="98%" align="center" border="0">
					<tr>
						<td vAlign="top" width="100%"><br>
							<table class="t3" cellSpacing="2" cellPadding="2" width="100%" align="center" border="0">
								<tr>
									<td>
										<div id="tblwizard1" runat="server">
											<table cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
												<tr>
													<td class="td1" vAlign="top" align="right" width="50%"> Edit a Country:&nbsp;
													</td>
													<td class="td2" vAlign="top" align="left" width="50%"><asp:dropdownlist id="ddlCountries" runat="server" Width="216px" CssClass="select" DataTextField="CountryName"
															DataValueField="CountryID"></asp:dropdownlist></td>
												</tr>
												<tr>
													<td class="td1" vAlign="top" align="center" colSpan="2"><br>
														<asp:button id="btngo" runat="server" Text="Submit" CssClass="button"></asp:button></td>
												</tr>
											</table>
										</div>
										<div id="tblwizard2" runat="server">
											<table cellSpacing="0" cellPadding="0" width="400" align="center" border="0">
												<tr>
													<td class="td1" vAlign="top" width="124">Country&nbsp;Name:<FONT color="#ff0066">*</FONT>&nbsp;
													</td>
													<td class="td2" vAlign="top">
														<asp:textbox id="txtName" runat="server" Width="160px" CssClass="input"></asp:textbox>
														<asp:requiredfieldvalidator id="rfvName" runat="server" ErrorMessage="Please enter the Country Name"
															ControlToValidate="txtName" Display="None"></asp:requiredfieldvalidator></td>
												</tr>
												<tr>
													<td class="td1" vAlign="top" width="124"> Currency:<FONT color="#ff0066">*</FONT>
													</td>
													<td class="td2" vAlign="top">
														<asp:dropdownlist id="ddlCurrency" runat="server" Width="160px" CssClass="select" DataTextField="CurrencyName"
															DataValueField="CurrencyID"></asp:dropdownlist>
														<asp:requiredfieldvalidator id="rfvCurrency" runat="server" ErrorMessage="Please select a Currency"
															ControlToValidate="ddlCurrency" Display="None" InitialValue="Select ..."></asp:requiredfieldvalidator>
													</td>
												</tr>
												<tr>
													<td align="center" colSpan="2" class="td1"><br>
														<asp:button id="btnSubmit" CssClass="button" Runat="server" Text="Submit"></asp:button>
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
