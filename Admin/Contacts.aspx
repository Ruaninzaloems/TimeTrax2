<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Contacts.aspx.vb" Inherits="TimeTrax.Contacts"%>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<body>
	<im:header id="ucHeader" runat="server"></im:header>
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<th class="th">Manage Constants - Contacts</th>
			</tr>
			<tr>
				<td vAlign="top">
					<table class="t4a" cellSpacing="0" cellPadding="5" width="98%" align="center" border="0">
						<tr>
							<td vAlign="top" width="100%"><br>
								<table class="t3" cellSpacing="2" cellPadding="2" width="100%" align="center" border="0">
									<tr>
										<td>
											<div id="tblwizard1" runat="server">
												<table cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
													<tr>
														<td class="td1" vAlign="top" align="right" width="50%">Edit a Contacts Details:&nbsp;
														</td>
														<td class="td2" vAlign="top" align="left" width="50%"><asp:dropdownlist id="ddlContact" runat="server" DataValueField="ContactID" DataTextField="ContactName"
																CssClass="select" Width="216px"></asp:dropdownlist></td>
													</tr>
													<tr>
														<td vAlign="top" align="center" colSpan="2" class="td1" ><br>
															<asp:button id="btngo" runat="server" CssClass="button" Text="Submit"></asp:button></td>
													</tr>
												</table>
											</div>
											<div id="tblwizard2" runat="server">
												<table cellSpacing="0" cellPadding="0" width="400" align="center" border="0">
													<tr>
														<td class="td1">Title:</td>
														<td class="td2"><asp:dropdownlist id="ddlTitle" runat="server" DataValueField="TitleID" DataTextField="Title" CssClass="select"></asp:dropdownlist></td>
													</tr>
													<tr>
														<td class="td1">First Name:<FONT color="#ff0066">*</FONT></td>
														<td class="td2"><asp:textbox id="txtName" runat="server" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="rfvName" runat="server" ErrorMessage="Please enter a First Name" Display="None"
																ControlToValidate="txtName" InitialValue=""></asp:requiredfieldvalidator></td>
													</tr>
													<tr>
														<td class="td1">Last Name:<FONT color="#ff0066">*</FONT></td>
														<td class="td2"><asp:textbox id="txtSurname" runat="server" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="rfvSurname" runat="server" ErrorMessage="Please enter a Last Name" Display="None"
																ControlToValidate="txtSurname" InitialValue=""></asp:requiredfieldvalidator></td>
													</tr>
													<tr>
														<td class="td1">Department:</td>
														<td class="td2"><asp:textbox id="txtDept" runat="server" CssClass="input"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1">eMail:</td>
														<td class="td2"><asp:textbox id="txtEmail" runat="server" CssClass="input"></asp:textbox><asp:regularexpressionvalidator id="regexEmail" runat="server" ErrorMessage="Please enter a valid Email" Display="None"
																ControlToValidate="txtEmail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:regularexpressionvalidator></td>
													</tr>
													<tr>
														<td class="td1">Phone Number:<FONT color="#ff0066">*</FONT></td>
														<td class="td2"><asp:textbox id="txtTel" runat="server" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="rfvTel" runat="server" ErrorMessage="Please enter a Phone number" Display="None"
																ControlToValidate="txtTel" InitialValue=""></asp:requiredfieldvalidator></td>
													</tr>
													<tr>
														<td class="td1">Fax:</td>
														<td class="td2"><asp:textbox id="txtFax" runat="server" CssClass="input"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1" align="center" colSpan="2"><asp:checkbox id="chkEnabled" runat="server" Text="Enabled" Checked="True" TextAlign="Right"></asp:checkbox></td>
													</tr>
													<tr>
														<td align="center" colSpan="2" class="td1"><br>
															<asp:button id="btnSubmit" CssClass="button" Text="Submit" Runat="server"></asp:button></td>
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
											<asp:textbox id="txtrecid" runat="server" CssClass="inputhidden"></asp:textbox><asp:textbox id="txtpostback" runat="server" CssClass="inputhidden"></asp:textbox></td>
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
			<tr>
				<td>
					<asp:validationsummary id="validationsummary1" style="Z-INDEX: 103; LEFT: 16px" runat="server" width="696px"
						height="88px" showsummary="false" showmessagebox="true"></asp:validationsummary>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer></form>
</body>
