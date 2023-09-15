<%@ Register TagPrefix="im" TagName="Footer" Src="/TimeTrax/Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="Orders" Src="/TimeTrax/Components/User Controls/Orders.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="/TimeTrax/Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="/TimeTrax/Components/User Controls/Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectTakeOn.aspx.vb" Inherits="TimeTrax.ProjectTakeOn"%>
<body>
	<im:Header id="ucHeader" runat="server"></im:Header>
	<!--START C A L E N D A R   C O N T R O L Include this to use the calendar-->
	<SCRIPT language="JavaScript">
			//This is needed for the Calendar styles
			document.write(CalendarPopup_getStyles());
			//To use a Pop-Up window, leave the parameter blank, otherwise put in dynamic
			var imcalendar = new CalendarPopup("dynamic");
			imcalendar.showYearNavigation();
	</SCRIPT>
	<!--END C A L E N D A R   C O N T R O L-->
	<form id="Form1" method="post" runat="server">
		<!-- This div is for receiving the result from the InsertTime webmethod call -->
		<div id="ws1" style="BEHAVIOR:url(../Components/Scripts/webservice.htc)"></div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
				</td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<td vAlign="top">
					<table width="98%" align="center">
						<tr>
							<td vAlign="top">
								<br>
								
								<table class="t1" width="98%" align="center">
									<TBODY>
										<tr>
											<th class="th">Project TakeOn Form</th>
										</tr>
										<tr>
											<td class="td2">
												<input type="hidden" id="hidProjID" name="hidProjID" runat="server" >
												<br>
												<table class="t1" width="98%" align="center">
													<TBODY>
														<tr>
															<td class="td1" valign="top" width="50%">Client:</td>
															<td class="td2">
																<asp:DropDownList id="ddlClient" runat="server" CssClass="select" onchange="CheckIfNewClient();" DataValueField="ClientID"
																	DataTextField="ClientName"></asp:DropDownList>
																<asp:requiredfieldvalidator id="rfvClient" Runat="Server" ErrorMessage="Please select a Client" Display="None"
																	ControlToValidate="ddlClient"></asp:requiredfieldvalidator>
															</td>
														</tr>
														<tr>
															<td class="td1">Contact :</td>
															<td class="td2">
																<asp:DropDownList id="ddlContact" runat="server" CssClass="select" onchange="CheckIfNewContact();"
																	DataValueField="ContactID" DataTextField="ContactName"></asp:DropDownList>
																<asp:requiredfieldvalidator id="rfvContact" Runat="Server" ErrorMessage="Please select the project Contact person"
																	Display="None" ControlToValidate="ddlContact"></asp:requiredfieldvalidator>
															</td>
														</tr>
														<tr>
															<td class="td1">Admin Contact :</td>
															<td class="td2">
																<asp:DropDownList id="ddlAdmin" runat="server" CssClass="select" onchange="CheckIfNewAdminContact();"
																	DataValueField="ContactID" DataTextField="ContactName"></asp:DropDownList>
																<asp:requiredfieldvalidator id="rfvAdmin" Runat="Server" ErrorMessage="Please select the project Admin contact person"
																	Display="None" ControlToValidate="ddlAdmin"></asp:requiredfieldvalidator>
															</td>
														</tr>
														<tr>
															<th colspan="2" class="th1">Project Detail</th>
														</tr>
														<tr>
															<td class="td1">Name :</td>
															<td class="td2">
																<asp:Textbox id="txtProjName" runat="server" CssClass="Input"></asp:Textbox>
																<asp:requiredfieldvalidator id="rfvProjName" Runat="Server" ErrorMessage="Please enter the Project Name" Display="None"
																	ControlToValidate="txtProjName"></asp:requiredfieldvalidator>
															</td>
														</tr>
														<tr>
															<td class="td1">Code :</td>
															<td class="td2">
																<asp:Textbox id="txtProjCode" runat="server" CssClass="Input"></asp:Textbox>
																<asp:requiredfieldvalidator id="rfvProjCode" Runat="Server" ErrorMessage="Please enter a Project Code" Display="None"
																	ControlToValidate="txtProjCode"></asp:requiredfieldvalidator>
															</td>
														</tr>
														<tr>
															<td class="td1">Cost Centre :</td>
															<td class="td2">
																<asp:DropDownList id="ddlCostCentre" runat="server" CssClass="select" onchange="loadCurrency();updateRates();"
																	DataValueField="CostCentreID" DataTextField="CostCentreName"></asp:DropDownList>
																<asp:requiredfieldvalidator id="rfvCostCentre" Runat="Server" ErrorMessage="Please enter the Project Cost Centre"
																	Display="None" InitialValue="0# " ControlToValidate="ddlCostCentre"></asp:requiredfieldvalidator>
															</td>
														</tr>
														<tr>
															<td class="td1">Currency :</td>
															<td class="td2">
																<asp:Textbox id="txtCurrency" name="txtCurrency" CssClass="InputRO" ReadOnly="True" runat="server"></asp:Textbox>
															</td>
														</tr>
														<tr>
															<td class="td1">Start Date :</td>
															<td class="td2">
																<asp:textbox id="txtStartDate" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"
																	runat="server" CssClass="input" Width="100"></asp:textbox>
																<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
																<div id="divStartDate" style="POSITION: absolute">
																</div>
																<img id="StartDate" style="CURSOR: hand" onclick="imcalendar.select(document.Form1.txtStartDate, 'divStartDate', 'dd/MM/yyyy'); return false;"
																	src="../images/CALENDAR.GIF" border="0" name="StartDate" runat="server">
																<asp:requiredfieldvalidator id="rfvStartDate" Runat="Server" ErrorMessage="Please enter the Project Start date"
																	Display="None" ControlToValidate="txtStartDate"></asp:requiredfieldvalidator>
															</td>
														</tr>
														<tr>
															<td colspan="2">
																<!-- This is going to be Orders User Control -->
																<im:Orders id="ucOrders" runat="server"></im:Orders>
																<!-- End of Orders User Control -->
															</td>
														</tr>
														<tr>
															<td colspan="2">
																<table id="tblResources" width="100%">
																	<tr>
																		<th class="th1" height="22">
																			<IMG id="menu3a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleDisplay(menu3a, menu3b);"
																				height="12" alt="" src="../images/up.gif" width="12" vspace="2" border="0" align="right">
																			<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleDisplay(menu3a, menu3b);">Resources</SPAN>
																			<BR clear="all">
																		</th>
																	</tr>
																	<tr>
																		<td>
																			<SPAN id="menu3b" style="DISPLAY: block">
																				<TABLE id="tblresource" width="100%" name="tblresource">
																					<tr>
																						<td colspan="4">
																							<asp:placeholder id="resourcePlace" Runat="server"></asp:placeholder>
																							<input id="resource_list" type="hidden" name="resource_list"> <input id="resourceLoadCount" type="hidden" name="resourceLoadCount" runat="server">
																						</td>
																					</tr>
																					<tr>
																						<th class="th2" width="50%">
																							Role</th>
																						<th class="th2" width="20%">
																							Name</th>
																						<th class="th2" width="10%">
																							Rate</th>
																						<th class="th3" width="6%">
																							&nbsp;</th>
																					</tr>
																					<tr>
																						<td class="td"><asp:Label ID="Approver1Role" Runat="server"></asp:Label></td>
																						<td class="td"><asp:DropDownList id="ddlApprover1" runat="server" CssClass="select" onchange="ws_getrate(this);"
																								DataValueField="UserID" DataTextField="UserName"></asp:DropDownList></td>
																						<td class="td" align="center"><asp:textbox id="txtApprover1" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																								width="70px"></asp:textbox></td>
																						<td>&nbsp;</td>
																					</tr>
																					<tr id="Stage2row" runat="server">
																						<td class="td"><asp:Label ID="Approver2Role" Runat="server"></asp:Label></td>
																						<td class="td"><asp:DropDownList id="ddlApprover2" runat="server" CssClass="select" onchange="ws_getrate(this);"
																								DataValueField="UserID" DataTextField="UserName"></asp:DropDownList></td>
																						<td class="td" align="center"><asp:textbox id="txtApprover2" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																								width="70px"></asp:textbox></td>
																						<td>&nbsp;</td>
																					</tr>
																					<tr id="TSStage1row" runat="server">
																						<td class="td"><asp:Label ID="TSApprover1Role" Runat="server"></asp:Label></td>
																						<td class="td"><asp:DropDownList id="ddlTSApprover1" runat="server" CssClass="select" onchange="ws_getrate(this);"
																								DataValueField="UserID" DataTextField="UserName"></asp:DropDownList></td>
																						<td class="td" align="center"><asp:textbox id="txtTSApprover1" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																								width="70px"></asp:textbox></td>
																						<td>&nbsp;</td>
																					</tr>
																					<tr id="TSStage2row" runat="server">
																						<td class="td"><asp:Label ID="TSApprover2Role" Runat="server"></asp:Label></td>
																						<td class="td"><asp:DropDownList id="ddlTSApprover2" runat="server" CssClass="select" onchange="ws_getrate(this);"
																								DataValueField="UserID" DataTextField="UserName"></asp:DropDownList></td>
																						<td class="td" align="center"><asp:textbox id="txtTSApprover2" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																								width="70px"></asp:textbox></td>
																						<td>&nbsp;</td>
																					</tr>
																					<tr>
																						<td class="td">Team Leader</td>
																						<td class="td"><asp:DropDownList id="ddlTeamLeader" runat="server" CssClass="select" onchange="ws_getrate(this);"
																								DataValueField="UserID" DataTextField="UserName"></asp:DropDownList></td>
																						<td class="td" align="center"><asp:textbox id="txtTeamLeader" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																								width="70px"></asp:textbox></td>
																						<td>&nbsp;</td>
																					</tr>
																					<tr id="rowresourceDefaultNone" vAlign="top" name="rowresourceDefaultNone">
																						<td class="td" width="100%" colSpan="4"></td>
																					</tr>
																					<tr>
																						<td class="td" colspan="4" align="left">Team Members</td>
																					</tr>
																					<tr id="rowresourceDefaultA" style="DISPLAY: none" vAlign="top">
																						<td class="td">&nbsp;</td>
																						<td class="td"><asp:DropDownList id="ddlResource_" runat="server" CssClass="select" onchange="checkResourceDuplicates(this);ws_getrate(this);"
																								DataValueField="UserID" DataTextField="UserName"></asp:DropDownList></td>
																						<td class="td" align="center"><asp:textbox id="txtResource_" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																								width="70px"></asp:textbox></td>
																						<td class="td">
																							<IMG id="imgDeleteresource_" style="CURSOR: hand" onclick="deleteFormSection('resource', this, document.Form1);"
																								height="13" alt="Delete this Row" src="../images/Delete.gif" border="0" name="imgDeleteresource_"
																								runat="server" align="middle">
																						</td>
																					</tr>
																				</TABLE>
																				<table id="tblresourceadd" cellSpacing="0" cellPadding="2" width="100%" border="0" name="tblresourceadd">
																					<tr>
																						<td colSpan="4" align="left" valign="bottom">
																							<input type="button" class="button" onclick="addFormSection('resource', document.Form1);" value="Add Team Member">
																						</td>
																					</tr>
																				</table>
																			</SPAN></td>
																	</tr>
																</table> <!-- END tblresource --></SPAN>
															</td>
														</tr>
													</TBODY>
												</table>
											</td>
										</tr>
									</TBODY>
								</table>
								<br>
							</td>
						</tr>
						<tr>
							<td class="td" colspan="2" align="left">Project Comments:</td>
						</tr>
						<tr>
							<td colspan="2" class="td">
								<asp:TextBox ID="txtProjComment" Runat="server" TextMode="MultiLine" Rows="5" CssClass="TextArea"
									Width="100%"></asp:TextBox>
								<br>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input type="button" class="button" value="Save" onclick="validatePage();">
								<input type="button" class="button" value="Upload Purchase Order" onclick="uploadDocument();">
								<input type="button" class="button" value="Submit for Approval" onclick="validatePage('Submit');">
								<asp:Button ID="btnSubmit" Runat="server" Text="Submit" Cssclass="button" Width="0"></asp:Button>
								<asp:Button ID="btnSave" Runat="server" Text="Save" Cssclass="button" Width="0"></asp:Button>
							</td>
						</tr>
					</table>
					<br>
					<br>
				</td>
			</tr>
			<tr>
				<td>
					<asp:validationsummary id="ValidationSummary1" style="Z-INDEX: 103; LEFT: 16px" runat="server" Width="696px"
						Height="88px" ShowSummary="False" ShowMessageBox="True"></asp:validationsummary>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
</body>
