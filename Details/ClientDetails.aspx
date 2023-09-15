<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ClientDetails.aspx.vb" Inherits="TimeTrax.ClientDetails"%>
  <HEAD><TITLE>Client Details</TITLE>
		<LINK href=<%=Request.ApplicationPath & "/app_style.css"%> type="text/css" rel="stylesheet">
  </head>
<body>
	<form id="Form1" method="post" runat="server">
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Client Details</th></tr>
			<tr>
				<td class="td3" vAlign="top">
					<table width="98%" align="center">
						<tr>
							<td vAlign="top" width="100%"><br>
								<table width="100%" align="center">
									<tr>
										<td>
											<table class="t3" width="100%" align="center">
												<tr>
													<td class="td1">Client Code:</td>
													<td class="td2"><asp:textbox id="txtCode" runat="server" ReadOnly="True" CssClass="InputRO"></asp:textbox></td>
												</tr>
												<tr>
													<td class="td1">Client Name:</td>
													<td class="td2"><asp:textbox id="txtName" tabIndex="1" runat="server" ReadOnly="True" CssClass="input" Width="100%"></asp:textbox></td>
												</tr>
												<tr>
													<td class="td2" colSpan="2">
														<table cellSpacing="5" cellPadding="0" align="center" border="0">
															<tr>
																<td class="td1" width="50%">Physical Address:</td>
																<td class="td1">Postal Address:</td>
															</tr>
															<tr>
																<td class="td"><asp:textbox id="txtPhyAdd" tabIndex="3" runat="server" ReadOnly="True" CssClass="input"></asp:textbox></td>
																<td class="td"><asp:textbox id="txtPosAdd" tabIndex="7" runat="server" ReadOnly="True" CssClass="input"></asp:textbox></td>
															</tr>
															<tr>
																<td class="td"><asp:textbox id="txtPhySuburb" tabIndex="4" runat="server" ReadOnly="True" CssClass="input"></asp:textbox></td>
																<td class="td"><asp:textbox id="txtPosSuburb" tabIndex="8" runat="server" ReadOnly="True" CssClass="input"></asp:textbox></td>
															</tr>
															<tr>
																<td class="td"><asp:textbox id="txtPhyCity" tabIndex="5" runat="server" ReadOnly="True" CssClass="input"></asp:textbox></td>
																<td class="td"><asp:textbox id="txtPosCity" tabIndex="9" runat="server" ReadOnly="True" CssClass="input"></asp:textbox></td>
															</tr>
															<tr>
																<td class="td"><asp:textbox id="txtPhyProvince" tabIndex="6" runat="server" ReadOnly="True" CssClass="input"></asp:textbox></td>
																<td class="td"><asp:textbox id="txtPosProvince" tabIndex="10" runat="server" ReadOnly="True" CssClass="input"></asp:textbox></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td class="td1">Post Code:</td>
													<td class="td2"><asp:textbox id="txtPosCode" tabIndex="11" runat="server" ReadOnly="True" CssClass="input"></asp:textbox></td>
												</tr>
												<tr>
													<td class="td1" height="22">Country:</td>
													<td class="td2" height="22"><asp:dropdownlist id="ddlCountry" runat="server" CssClass="select" DataTextField="CountryName" DataValueField="CountryID"
															Enabled="False"></asp:dropdownlist></td>
												</tr>
												<tr>
													<td class="td1" align="center" colSpan="2"><asp:checkbox id="chkEnabled" runat="server" CssClass="label" Checked="True" TextAlign="Right"
															Text="Enabled" Enabled=False></asp:checkbox></td>
												</tr>
												<tr>
													<td align="center" colSpan="2"><br>
														<input type="button" value="Close Window" class="button" onclick="window.close();"></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="center" colSpan="3"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
</body>
