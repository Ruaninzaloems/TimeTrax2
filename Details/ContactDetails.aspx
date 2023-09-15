<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ContactDetails.aspx.vb" Inherits="TimeTrax.ContactDetails"%>
<HEAD>
	<TITLE>Contact Details</TITLE>
	<LINK href=<%=Request.ApplicationPath & "/app_style.css"%> type="text/css" rel="stylesheet">
</HEAD>
<body>
	<form id="Form1" method="post" runat="server">
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Contact Details</th>
			</tr>
			<tr>
				<td class="td3" vAlign="top">
					<table width="98%" align="center">
						<tr>
							<td vAlign="top" width="100%"><br>
									<table class="t3" width="100%" align="center">
									<tr>
										<td>
											<table width="400" align="center" border="0">
												<tr>
													<td class="td1">Title:</td>
													<td class="td2"><asp:dropdownlist id="ddlTitle" runat="server" DataValueField="TitleID" DataTextField="Title" CssClass="select"
															Enabled="False"></asp:dropdownlist></td>
												</tr>
												<tr>
													<td class="td1">First Name:</td>
													<td class="td2"><asp:textbox id="txtName" runat="server" CssClass="input" ReadOnly="True"></asp:textbox></td>
												</tr>
												<tr>
													<td class="td1" height="24">Last Name:</td>
													<td class="td2" height="24"><asp:textbox id="txtSurname" runat="server" CssClass="input" ReadOnly="True"></asp:textbox></td>
												</tr>
												<tr>
													<td class="td1">Department:</td>
													<td class="td2"><asp:textbox id="txtDept" runat="server" CssClass="input" ReadOnly="True"></asp:textbox></td>
												</tr>
												<tr>
													<td class="td1">eMail:</td>
													<td class="td2"><asp:textbox id="txtEmail" runat="server" CssClass="input" ReadOnly="True"></asp:textbox></td>
												</tr>
												<tr>
													<td class="td1" height="24">Phone Number:</td>
													<td class="td2" height="24"><asp:textbox id="txtTel" runat="server" CssClass="input" ReadOnly="True"></asp:textbox></td>
												</tr>
												<tr>
													<td class="td1">Fax:</td>
													<td class="td2"><asp:textbox id="txtFax" runat="server" CssClass="input" ReadOnly="True"></asp:textbox></td>
												</tr>
												<tr>
													<td class="td1" align="center" colSpan="2" height="19"><asp:checkbox id="chkEnabled" runat="server" Text="Enabled" Checked="True" TextAlign="Right" Enabled="False"></asp:checkbox></td>
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
