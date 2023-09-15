<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Users.aspx.vb" Inherits="TimeTrax.Users"%>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
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
					Manage Constants - Users</th>
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
												<table width="55%" align="center" class="t1">
													<tr>
														<td class="td1" vAlign="top">
															Edit a users details:&nbsp;
														</td>
														<td class="td2" vAlign="top" align="left">
															<asp:dropdownlist id="cbxusers" runat="server" CssClass="select" DataTextField="UserD" DataValueField="UserID"></asp:dropdownlist>
														</td>
													</tr>
													<tr>
														<td class="td1">
														</td>
														<td class="td2" vAlign="top">
															<asp:button id="btngo" runat="server" Text="Submit" Cssclass="button"></asp:button></td>
													</tr>
												</table>
											</div>
											<div id="tblwizard2" runat="server">
												<table width="90%" align="center" class="t1">
													<tr>
														<td class="td1" vAlign="top" width="124">First Name:<FONT color="#ff0066">*</FONT>&nbsp;
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtFirst" runat="server" Width="160px" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter a First Name"
																ControlToValidate="txtFirst" Display="None"></asp:requiredfieldvalidator></td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">Last Name:<FONT color="#ff0066">*</FONT>
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtLast" runat="server" Width="160px" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter a Last Name"
																ControlToValidate="txtLast" Display="None"></asp:requiredfieldvalidator></td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">Initals:<FONT color="#ff0066">*</FONT>
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtInitials" MaxLength="3" runat="server" Width="160px" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="Requiredfieldvalidator6" runat="server" ErrorMessage="Please enter Initials"
																ControlToValidate="txtInitials" Display="None"></asp:requiredfieldvalidator></td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">
															E-Mail:<FONT color="#ff0066">*</FONT>
														</td>
														<td class="td2" vAlign="top">
															<asp:textbox id="txtEmail" runat="server" Width="160px" CssClass="input"></asp:textbox><asp:regularexpressionvalidator id="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter a valid Email"
																ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" Display="None"></asp:regularexpressionvalidator><asp:requiredfieldvalidator id="RequiredFieldValidator8" runat="server" ErrorMessage="Please enter an Email"
																ControlToValidate="txtEmail" Display="None"></asp:requiredfieldvalidator>
														</td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">Phone:<FONT color="#ff0066">*</FONT>
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtPhone" runat="server" Width="160px" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter a phone number"
																ControlToValidate="txtPhone" Display="None"></asp:requiredfieldvalidator>
														</td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">Business Unit:<FONT color="#ff0066">*</FONT>
														</td>
														<td class="td2" vAlign="top">
															<asp:dropdownlist id="ddlUnit" runat="server" Width="160px" CssClass="select" DataTextField="UnitName"
																DataValueField="UnitID"></asp:dropdownlist><asp:requiredfieldvalidator id="Requiredfieldvalidator5" runat="server" ErrorMessage="Please select a business unit"
																ControlToValidate="ddlUnit" Display="None" InitialValue="Select ..."></asp:requiredfieldvalidator>
														</td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">SMS:
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtSMS" runat="server" Width="160px" CssClass="input"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">Position:
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtPosition" runat="server" Width="160px" CssClass="input"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">Employee Code:
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtEmployeeCode" runat="server" Width="160px" CssClass="input"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">User Name:<FONT color="#ff0066">*</FONT>&nbsp;
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtUserName" runat="server" Width="160px" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="RequiredFieldValidator4" runat="server" ErrorMessage="Please enter a user name"
																ControlToValidate="txtUserName" Display="None"></asp:requiredfieldvalidator></td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124" TextType="Password">Password:<FONT color="#ff0066">*</FONT>
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtpass1" runat="server" Width="160px" CssClass="input" TextType="Password"
																MaxLength="25"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">Repeat Password:<FONT color="#ff0066">*</FONT>&nbsp;
														</td>
														<td class="td2" vAlign="top"><asp:textbox id="txtpass2" runat="server" Width="160px" CssClass="input" MaxLength="25"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" width="124">Role:<FONT color="#ff0066">*</FONT>
														</td>
														<td class="td2" vAlign="top"><asp:dropdownlist id="cbxRole" runat="server" Width="160px" CssClass="select" DataTextField="Descript"
																DataValueField="GroupID"></asp:dropdownlist><asp:requiredfieldvalidator id="RequiredFieldValidator7" runat="server" ErrorMessage="Please select a user role"
																ControlToValidate="cbxRole" Display="None" InitialValue="Select ..."></asp:requiredfieldvalidator></td>
													</tr>
													<div id="hideCurrpass" runat="server">
													</div>
													<tr>
														<td class="td1" vAlign="top" width="124">Current Password:&nbsp;</td>
														<td class="td2" vAlign="top">(<asp:label ID="lblcurrpass" Runat="server"></asp:label>)</td>
													</tr>
													<tr>
														<td class="td1" vAlign="top" colSpan="2">
															<asp:checkbox id="chkEnabled" runat="server" Text="Enabled" CssClass="cell"></asp:checkbox>
															<asp:textbox id="txtduplicate" runat="server" CssClass="inputhidden">zzz</asp:textbox><asp:customvalidator id="CustomValidator1" runat="server" ControlToValidate="txtduplicate" ClientValidationFunction="ValidatePassword"></asp:customvalidator>
														</td>
													</tr>
													<tr>
														<td class="td1" colSpan="2"><FONT color="#ff0066">*</FONT> Mandatory fields<br>
															<div id="hidetext" runat="server"><FONT color="#ff0066">Note: </FONT>Leave the 
																password fields blank if you do not wish to modify the password
															</div>
														</td>
													</tr>
													<tr>
														<td class="td1" colspan="2">Rates</td>
													</tr>
													<tr>
														<td width="100%" valign="top" align="center" class="td8" colspan="2">
															<div id="tblDynAdd" runat="server">
																<TABLE id="tblItem" style="DISPLAY: block" cellSpacing="0" cellPadding="0" width="100%"
																	align="center" border="0" name="tblItem">
																	<tr>
																		<td colspan="3">
																			<asp:placeholder id="itemPlace" Runat="server"></asp:placeholder>
																			<input id="item_list" type="hidden" name="item_list"> <input id="itemLoadCount" type="hidden" name="itemLoadCount" runat="server">
																		</td>
																	</tr>
																	<tr>
																		<th class="th1" width="6%">
																			&nbsp;</th>
																		<th class="th1" width="64%">
																			CostCentre</th>
																		<th class="th1" width="30%">
																			Rate</th>
																	</tr>
																	<tr id="rowItemDefaultA" style="DISPLAY: none" vAlign="top">
																		<td class="td2" width="6%" align="center">
																			<IMG id="imgDeleteItem_" style="CURSOR: hand" onclick="deleteFormSection('Item', this, document.Form1);"
																				alt="Delete a Row" src="<%=Request.ApplicationPath%>/images/Delete.gif" border="0" name="imgDeleteItem_">&nbsp;
																		</td>
																		<td class="td1" width="64%">
																			<asp:DropDownList ID="ddlCostCentre_" Runat="server" onchange="checkDuplicates(this);" DataTextField="CostCentreName"
																				DataValueField="CostCentreID" CssClass="select" Width="90%"></asp:DropDownList>
																		</td>
																		<td class="td2" width="30%" align="center">
																			<IM:IMTextBox id="txtrate_" runat="server" Width="50%" TextType="Decimal" CssClass="InputR"></IM:IMTextBox></td>
																	</tr>
																</TABLE>
																<TABLE width="100%" align="center" class="t1">
																	<TR>
																		<TD class="td1" colSpan="3">
																			<asp:TextBox id="txtVal" runat="server" CssClass="inputhidden">xxx</asp:TextBox>
																			<CENTER>Add new Cost Centre Rate by clicking the Add button.&nbsp;&nbsp;<IMG style="CURSOR: hand" onclick="addFormSection('Item', document.Form1);" alt="Add New Row"
																					src="<%=Request.ApplicationPath%>/images/add.gif" border="0"></CENTER>
																		</TD>
																	</TR>
																</TABLE>
															</div>
														</td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
									<tr>
										<td align="center" colSpan="2"><br>
											<asp:button id="btnSubmit" Cssclass="button" Runat="server" Text="Submit"></asp:button>
										</td>
									</tr>
								</table>
								<DIV></DIV>
								<div id="tblwizard3" runat="server">
									<table cellSpacing="0" cellPadding="0" width="400" align="center" border="0">
										<tr>
											<td class="td" vAlign="top" align="center"><asp:label id="lblmessage" runat="server"></asp:label></td>
										</tr>
									</table>
								</div>
								<asp:textbox id="txtuserid" runat="server" CssClass="inputhidden"></asp:textbox><asp:customvalidator id="cvCostCentre" runat="server" Display="None" ControlToValidate="txtuserid" ClientValidationFunction="validateCostCentreItems"></asp:customvalidator>
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
		</TD></TR>
		<tr>
			<td>
				<asp:validationsummary id="validationsummary1" style="Z-INDEX: 103; LEFT: 16px" runat="server" width="696px"
					height="88px" showsummary="False" showmessagebox="true" DisplayMode="List"></asp:validationsummary>
			</td>
		</tr>
		</TABLE>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
</body>
