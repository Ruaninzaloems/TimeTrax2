<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SystemAdmin.aspx.vb" Inherits="TimeTrax.SystemAdmin"%>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
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
				<th class="th">
					System Administration</th>
			</tr>
			<tr>
				<td valign="top">
					<table class="t4a" cellSpacing="0" cellPadding="5" width="98%" align="center" border="0">
						<tr>
							<td vAlign="top" width="100%"><br>
								<br>
								<table class="t3" cellSpacing="2" cellPadding="2" width="100%" align="center" border="0">
									<tr>
										<td>
											<br>
											<div id="tblwizard2" runat="server">
												<table cellSpacing="0" cellPadding="0" width="400" align="center" border="0">
													<TBODY>
														<TR>
															<th class="th1" colspan="3">
																Approvals</th>
														</TR>
														<TR>
															<TH class="th2" colspan="2">
																Project Take On</TH>
															<th>
																<IMG id="Img2" style="CURSOR: hand" alt="Once this has been setup, it must be changed outside the application to ensure data integrity"
																	src="../images/info.gif" name="imgShowClient_" runat="server">
															</th>
														</TR>
														<tr>
															<td class="td">Number of Approvals required:<FONT color="#ff0066">*</FONT>&nbsp;</td>
															<td class="td" vAlign="top">
																<asp:DropDownList id="ddlPTOApprovals" name="ddlPTOApprovals" runat="server" CssClass="select" EnableViewState="False"
																	onchange="showPTOApprovers(this);">
																	<asp:ListItem Value="0" Selected="True">-- select --</asp:ListItem>
																	<asp:ListItem Value="1">1</asp:ListItem>
																	<asp:ListItem Value="2">2</asp:ListItem>
																</asp:DropDownList>
																<asp:requiredfieldvalidator id="rfvPTOApprovals" runat="server" ErrorMessage="Please select the number of Project take on approvals required"
																	ControlToValidate="ddlPTOApprovals" Display="None" InitialValue="0"></asp:requiredfieldvalidator>
															</td>
															<td></td>
														</tr>
														<tr id="divPTOApprover" runat="server" style="DISPLAY:block">
															<td class="td" height="21">First Approver:</td>
															<td class="td">
																<asp:DropDownList id="ddlPTOApprover2Role" runat="server" CssClass="Select" DataValueField="GroupID"
																	DataTextField="Descript"></asp:DropDownList>
															</td>
															<td></td>
														</tr>
														<tr>
															<td class="td">Final Approver:<FONT color="#ff0066">*</FONT></td>
															<td class="td">
																<asp:DropDownList id="ddlPTOApprover1Role" runat="server" CssClass="Select" DataValueField="GroupID"
																	DataTextField="Descript"></asp:DropDownList>
																<asp:requiredfieldvalidator id="rfvPTOApprover1Role" runat="server" ErrorMessage="Please enter at least 1 Project Take on Approver Role"
																	ControlToValidate="ddlPTOApprover1Role" Display="None"></asp:requiredfieldvalidator>
															</td>
															<td></td>
														</tr>
														<TR>
															<th class="th2" colspan="2">
																Timesheets and Expenses</th>
															<th>
																<IMG id="Img1" style="CURSOR: hand" alt="Once this has been setup, it must be changed outside the application to ensure data integrity"
																	src="../images/info.gif" name="imgShowClient_" runat="server">
															</th>
														</TR>
														<tr>
															<td class="td">Number of Approvals required:<FONT color="#ff0066">*</FONT>&nbsp;</td>
															<td class="td" vAlign="top" colspan="2">
																<asp:DropDownList id="ddlTSApprovals" runat="server" CssClass="select" EnableViewState="False" onchange="showTSApprovers(this);">
																	<asp:ListItem Value="0" Selected="True">-- select --</asp:ListItem>
																	<asp:ListItem Value="1">1</asp:ListItem>
																	<asp:ListItem Value="2">2</asp:ListItem>
																</asp:DropDownList>
																<asp:requiredfieldvalidator id="rfvTSApprovals" runat="server" ErrorMessage="Please select the number of Timesheet/Expense approvals required"
																	ControlToValidate="ddlTSApprovals" Display="None" InitialValue="0"></asp:requiredfieldvalidator>
															</td>
														</tr>
														<tr id="divTSApprover" runat="server" style="DISPLAY:block">
															<td class="td">First Approver:</td>
															<td class="td" colspan="2">
																<asp:DropDownList id="ddlTSApprover2Role" runat="server" CssClass="Select" DataValueField="GroupID"
																	DataTextField="Descript"></asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td class="td">Final Approver:<FONT color="#ff0066">*</FONT></td>
															<td class="td" colspan="2">
																<asp:dropdownlist id="ddlTSApprover1Role" runat="server" CssClass="select" DataTextField="Descript"
																	DataValueField="GroupID"></asp:dropdownlist>
																<asp:requiredfieldvalidator id="rfvTSApprover1Role" runat="server" ErrorMessage="Please enter at least 1 Timesheet/Expense Approver Role"
																	ControlToValidate="ddlTSApprover1Role" Display="None" InitialValue="Select ..."></asp:requiredfieldvalidator>
															</td>
														</tr>
														<TR>
															<th class="th1" colspan="3">
																Email Notifications</th>
														</TR>
														<tr>
															<th class="th2" colspan="3">
																Weekly Reminder</th>
														</tr>
														<tr>
															<td class="td" colspan="3">Every&nbsp;
																<asp:DropDownList id="ddlDow" runat="server" CssClass="select">
																	<asp:ListItem Value="1" Selected="True">Monday</asp:ListItem>
																	<asp:ListItem Value="2">Tuesday</asp:ListItem>
																	<asp:ListItem Value="3">Wednesday</asp:ListItem>
																	<asp:ListItem Value="4">Thursday</asp:ListItem>
																	<asp:ListItem Value="5">Friday</asp:ListItem>
																	<asp:ListItem Value="6">Saturday</asp:ListItem>
																	<asp:ListItem Value="7">Sunday</asp:ListItem>
																</asp:DropDownList>
																&nbsp;&nbsp;
																<asp:checkbox id="chkWeeklyReminder" runat="server" Text="Enabled" CssClass="label" TextAlign="Left"></asp:checkbox>
															</td>
														</tr>
														<tr>
															<td class="td" colSpan="3" align="center">
															</td>
														</tr>
														<tr>
															<th class="th2" colspan="3">
																Monthly Reminder</th>
														</tr>
														<tr>
															<td class="td" colspan="3" align="center">&nbsp;
																<asp:TextBox id="txtMonthReminder" runat="server" CssClass="input" Width="40px" ToolTip="Note: Zero represents the last day of the month"></asp:TextBox>
																days before end of Month
																<asp:RangeValidator id="rvMonthReminder" runat="server" Display="None" ControlToValidate="txtMonthReminder"
																	ErrorMessage="Monthly Reminder date  must be between 1 and 30" MaximumValue="30" MinimumValue="0"></asp:RangeValidator>
															</td>
														</tr>
														<tr>
															<td class="td" colspan="3"><i><b>Note: </b>Zero represents the last day of the month</i></td>
														</tr>
														<TR>
															<th class="th1" colspan="3">
																General</th>
														</TR>
														<tr>
															<td class="td">First day of week:<FONT color="#ff0066">*</FONT></td>
															<td class="td" colspan="2">
																<asp:DropDownList id="ddlWeekStartDay" runat="server" CssClass="select">
																	<asp:ListItem Value="1">Monday</asp:ListItem>
																	<asp:ListItem Value="2">Tuesday</asp:ListItem>
																	<asp:ListItem Value="3">Wednesday</asp:ListItem>
																	<asp:ListItem Value="4">Thursday</asp:ListItem>
																	<asp:ListItem Value="5">Friday</asp:ListItem>
																	<asp:ListItem Value="6">Saturday</asp:ListItem>
																	<asp:ListItem Value="7" Selected="True">Sunday</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td class="td">Tasks Budget Item:<FONT color="#ff0066">*</FONT></td>
															<td class="td" colspan="2">
																<asp:DropDownList id="ddlOrderItem" runat="server" CssClass="Select" DataValueField="OrderItemID"
																	DataTextField="ItemName"></asp:DropDownList>
																<asp:RequiredFieldValidator id="rfvOrderItem" runat="server" Display="None" ControlToValidate="ddlOrderItem"
																	ErrorMessage="Please select the Tasks Budget item"></asp:RequiredFieldValidator>
															</td>
														</tr>
														<tr>
															<td class="td">Logon Method:&nbsp;
															</td>
															<td class="td" colspan="2">
																<asp:DropDownList id="ddlAuthenticateMethod" runat="server" CssClass="select">
																	<asp:ListItem Value="0">Forms Only</asp:ListItem>
																	<asp:ListItem Value="1" Selected="True">Windows & Forms</asp:ListItem>
																</asp:DropDownList>
															</td>
														</tr>
														<tr>
															<td class="td" colSpan="3">
																<asp:checkbox id="chkEnabled" runat="server" Text="Force comments for timesheets" CssClass="label"
																	TextAlign="Left"></asp:checkbox>
															</td>
														</tr>
														<tr>
															<td class="td" colSpan="3"><FONT color="#ff0066">*</FONT> Mandatory fields</td>
														</tr>
														<tr>
															<td align="center" colSpan="2"><br>
																<input type="button" id="htmSubmit" value="Submit" onclick="checkApprovals()" class="button">
																<asp:button id="btnSubmit" Runat="server" Text="Submit" CssClass="inputhidden"></asp:button>
															</td>
														</tr>
													</TBODY>
												</table>
											</div>
											<div id="tblwizard3" runat="server">
												<table cellSpacing="0" cellPadding="0" width="400" align="center" border="0">
													<tr>
														<td class="td" vAlign="top" align="center"><asp:label id="lblmessage" runat="server"></asp:label></td>
													</tr>
												</table>
											</div>
											<asp:textbox id="txtuserid" runat="server" CssClass="inputhidden"></asp:textbox>
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
