<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Clients.aspx.vb" Inherits="TimeTrax.Clients"%>
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
					Manage Constants - Clients</th>
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
															Edit a Clients Details:&nbsp;
														</td>
														<td class="td2" vAlign="top" align="left">
															<asp:dropdownlist id="ddlClient" runat="server" CssClass="select" DataTextField="ClientName" DataValueField="ClientID"
																Width="100%"></asp:dropdownlist>
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
														<td class="td1">Client Code:</td>
														<td class="td2">
															<asp:TextBox id="txtCode" runat="server" CssClass="InputRO" ReadOnly="True"></asp:TextBox>
														</td>
													</tr>
													<tr>
														<td class="td1">Client Name:<FONT color="#ff0066">*</FONT></td>
														<td class="td2">
															<asp:TextBox id="txtName" runat="server" CssClass="input" tabIndex="1" Width="100%"></asp:TextBox>
															<asp:RequiredFieldValidator id="rfvName" runat="server" InitialValue="" ControlToValidate="txtName" Display="None"
																ErrorMessage="Please enter the Client Name"></asp:RequiredFieldValidator>
														</td>
													</tr>
													<tr>
														<td class="td2" colspan="2">
															<table cellpadding="0" cellspacing="5" align="center" border="0">
																<tr>
																	<td class="td1" width="50%">Physical Address:</td>
																	<td class="td1">Postal Address:<FONT color="#ff0066">*</FONT></td>
																</tr>
																<tr>
																	<td class="td">
																		<asp:TextBox id="txtPhyAdd" runat="server" CssClass="input" tabIndex="3"></asp:TextBox>
																	</td>
																	<td class="td">
																		<asp:TextBox id="txtPosAdd" runat="server" CssClass="input" tabIndex="7"></asp:TextBox>
																		<asp:RequiredFieldValidator id="rfvPosAdd" runat="server" InitialValue="" ControlToValidate="txtPosAdd" Display="None"
																			ErrorMessage="Please enter the Postal Address"></asp:RequiredFieldValidator>
																	</td>
																</tr>
																<tr>
																	<td class="td">
																		<asp:TextBox id="txtPhySuburb" runat="server" CssClass="input" tabIndex="4"></asp:TextBox>
																	</td>
																	<td class="td">
																		<asp:TextBox id="txtPosSuburb" runat="server" CssClass="input" tabIndex="8"></asp:TextBox>
																		<asp:RequiredFieldValidator id="rfvPosSuburb" runat="server" InitialValue="" ControlToValidate="txtPosSuburb"
																			Display="None" ErrorMessage="Postal Address requires at least 2 lines"></asp:RequiredFieldValidator>
																	</td>
																</tr>
																<tr>
																	<td class="td">
																		<asp:TextBox id="txtPhyCity" runat="server" CssClass="input" tabIndex="5"></asp:TextBox>
																	</td>
																	<td class="td">
																		<asp:TextBox id="txtPosCity" runat="server" CssClass="input" tabIndex="9"></asp:TextBox>
																	</td>
																</tr>
																<tr>
																	<td class="td">
																		<asp:TextBox id="txtPhyProvince" runat="server" CssClass="input" tabIndex="6"></asp:TextBox>
																	</td>
																	<td class="td">
																		<asp:TextBox id="txtPosProvince" runat="server" CssClass="input" tabIndex="10"></asp:TextBox>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td class="td1">Post Code:<FONT color="#ff0066">*</FONT></td>
														<td class="td2">
															<asp:TextBox id="txtPosCode" runat="server" CssClass="input" tabIndex="11"></asp:TextBox>
															<asp:RequiredFieldValidator id="rfvPosCode" runat="server" InitialValue="" ControlToValidate="txtPosCode" Display="None"
																ErrorMessage="Please enter the Postal Code"></asp:RequiredFieldValidator>
														</td>
													</tr>
													<tr>
														<td class="td1">Country:<FONT color="#ff0066">*</FONT></td>
														<td class="td2">
															<asp:DropDownList id="ddlCountry" runat="server" CssClass="select" DataValueField="CountryID" DataTextField="CountryName"></asp:DropDownList>
															<asp:RequiredFieldValidator id="rfvCountry" runat="server" InitialValue="" ControlToValidate="ddlCountry" Display="None"
																ErrorMessage="Please select a Country"></asp:RequiredFieldValidator>
														</td>
													</tr>
													<tr>
														<td class="td2" colspan="2" align="center">
															<asp:CheckBox id="chkEnabled" CssClass="label" Text="Enabled" TextAlign="Right" Checked="True"
																runat="server"></asp:CheckBox>
														</td>
													</tr>
												</table>
												<table width="90%" align="center" class="t1">
													<tr>
														<td class="td2" align="center">
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
