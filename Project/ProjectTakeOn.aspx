<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectTakeOn.aspx.vb" Inherits="TimeTrax.ProjectTakeOn"%>
<%@ Register TagPrefix="uc1" TagName="ProjectDocuments" Src="../Components/User Controls/ProjectDocuments.ascx" %>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Orders" Src="../Components/User Controls/Orders.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<body>
	<im:header id="ucHeader" runat="server"></im:header>
	<form id="Form1" method="post" runat="server">
		<!-- This div is for receiving the result from the InsertTime webmethod call -->
		<div id="ws1" style="BEHAVIOR: url(../Components/Scripts/webservice.htc)"></div>
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Project TakeOn Form</th></tr>
			<tr>
				<td class="td3" vAlign="top">
					<table width="100%" align="center">
						<tr>
							<td><input id="hidProjID" type="hidden" name="hidProjID" runat="server">
								<br>
								<table class="t1" width="100%" align="center">
									<tr>
										<th class="th1" height="22">
											<IMG id="menu1a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleDisplay(menu1a, menu1b);"
												height="12" alt="" src="../images/up.gif" width="12" align="right" vspace="2" border="0">
											<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleDisplay(menu1a, menu1b);">Client Detail</SPAN>
											<BR clear="all">
										</th>
									</tr>
									<tr>
										<td><SPAN id="menu1b" style="DISPLAY: block">
												<TABLE class="t1" id="tblclient" width="100%" name="tblclient">
													<tr>
														<td class="td1" vAlign="top" width="25%">Client:</td>
														<td class="td2"><asp:dropdownlist id="ddlClient" runat="server" DataTextField="ClientName" DataValueField="ClientID"
																onchange="CheckIfNewClient();" CssClass="select"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvClient" ControlToValidate="ddlClient" Display="None" ErrorMessage="Please select a Client"
																Runat="Server"></asp:requiredfieldvalidator></td>
														<td class="td2" width="6%"><IMG id="imgShowClient_" style="CURSOR: hand" onclick="viewClientDetails(document.all.ddlClient.value);"
																alt="Show Client Details" src="../images/info.gif" name="imgShowClient_" runat="server"></td>
													</tr>
													<tr>
														<td class="td1">Contact :</td>
														<td class="td2"><asp:dropdownlist id="ddlContact" runat="server" DataTextField="ContactName" DataValueField="ContactID"
																onchange="CheckIfNewContact();" CssClass="select"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvContact" ControlToValidate="ddlContact" Display="None" ErrorMessage="Please select the Project Contact Person"
																Runat="Server" InitialValue="0"></asp:requiredfieldvalidator></td>
														<td class="td2" width="6%"><IMG id="imgShowContact_" style="CURSOR: hand" onclick="viewContactDetails(document.all.ddlContact.value);"
																alt="Show Contact Details" src="../images/info.gif" name="imgShowContact_" runat="server"></td>
													</tr>
													<tr>
														<td class="td1">Admin Contact :</td>
														<td class="td2"><asp:dropdownlist id="ddlAdmin" runat="server" DataTextField="ContactName" DataValueField="ContactID"
																onchange="CheckIfNewAdminContact();" CssClass="select"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvAdmin" ControlToValidate="ddlAdmin" Display="None" ErrorMessage="Please select the project Admin contact person"
																Runat="Server"></asp:requiredfieldvalidator></td>
														<td class="td2" width="6%"><IMG id="imgShowAdminContact_" style="CURSOR: hand" onclick="viewContactDetails(document.all.ddlAdmin.value);"
																alt="Show Admin Contact Details" src="../images/info.gif" name="imgShowAdminContact_" runat="server"></td>
													</tr>
												</TABLE>
											</SPAN></td>
									</tr>
									<tr>
										<th class="th1" height="22">
											<IMG id="menu2a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleDisplay(menu2a, menu2b);"
												height="12" alt="" src="../images/up.gif" width="12" align="right" vspace="2" border="0">
											<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleDisplay(menu2a, menu2b);">Project Detail</SPAN>
											<BR clear="all">
										</th>
									</tr>
									<tr>
										<td><SPAN id="menu2b" style="DISPLAY: block">
												<TABLE class="t1" id="tblproj" width="100%" name="tblproj">
													<tr>
														<td class="td1" width="25%">Full Name :</td>
														<td class="td2"><im:imtextbox id="txtProjFullName" runat="server" CssClass="Input" RequiredValidationError="Please enter the Full Project Name"
																TextType="AlphaNumeric" Width="90%"></im:imtextbox></td>
													</tr>
													<tr>
														<td class="td1">Short Name :</td>
														<td class="td2"><im:imtextbox id="txtProjName" runat="server" CssClass="Input" RequiredValidationError="Please enter the Short Project Name"
																TextType="AlphaNumeric" Width="45%"></im:imtextbox></td>
													</tr>
													<tr>
														<td class="td1">Code :</td>
														<td class="td2"><asp:textbox id="txtProjCode" runat="server" CssClass="InputRO" ReadOnly="True"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1">Cost Centre :</td>
														<td class="td2"><asp:dropdownlist id="ddlCostCentre" runat="server" DataTextField="CostCentreName" DataValueField="CostCentreID"
																onchange="loadCurrency();updateRates();" CssClass="select"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvCostCentre" ControlToValidate="ddlCostCentre" Display="None" ErrorMessage="Please enter the Project Cost Centre"
																Runat="Server" InitialValue="0# "></asp:requiredfieldvalidator></td>
													</tr>
													<tr>
														<td class="td1">Currency :</td>
														<td class="td2"><asp:textbox id="txtCurrency" runat="server" name="txtCurrency" CssClass="InputRO" ReadOnly="True"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1">Start Date :</td>
														<td class="td2">
															<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference--><im:imtextbox id="txtStartDate" runat="server" CssClass="Input" RequiredValidationError="Please enter the Project Start Date"
																TextType="Date" Width="92px"></im:imtextbox></td>
													</tr>
												</TABLE>
											</SPAN></td>
									</tr>
									<tr>
										<th class="th1" height="22">
											<IMG id="menu3a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleDisplay(menu3a, menu3b);"
												height="12" alt="" src="../images/up.gif" width="12" align="right" vspace="2" border="0">
											<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleDisplay(menu3a, menu3b);">Resources</SPAN>
											<BR clear="all">
										</th>
									</tr>
									<tr>
										<td><SPAN id="menu3b" style="DISPLAY: block">
												<TABLE class="t1" id="tblresource" width="100%" name="tblresource">
													<tr>
														<td colSpan="4"><asp:placeholder id="resourcePlace" Runat="server"></asp:placeholder><input id="resource_list" type="hidden" name="resource_list">
															<input id="resourceLoadCount" type="hidden" name="resourceLoadCount" runat="server">
														</td>
													</tr>
													<tr>
														<th class="th2" width="40%">
															Role</th>
														<th class="th2" width="30%">
															Name</th>
														<th class="th2" width="30%" colSpan="2">
															Rate</th></tr>
													<tr>
														<td class="td1"><asp:label id="Approver1Role" Runat="server"></asp:label></td>
														<td class="td2"><asp:dropdownlist id="ddlApprover1" runat="server" DataTextField="UserName" DataValueField="UserID"
																onchange="checkResourceDuplicates(this,1);ws_getrate(this);" CssClass="select"></asp:dropdownlist></td>
														<td class="td2" align="left" colSpan="2"><asp:textbox id="txtApprover1" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																width="70px"></asp:textbox></td>
													</tr>
													<tr id="Stage2row" runat="server">
														<td class="td1"><asp:label id="Approver2Role" Runat="server"></asp:label></td>
														<td class="td2"><asp:dropdownlist id="ddlApprover2" runat="server" DataTextField="UserName" DataValueField="UserID"
																onchange="checkResourceDuplicates(this,2);ws_getrate(this);" CssClass="select"></asp:dropdownlist></td>
														<td class="td2" align="left" colSpan="2"><asp:textbox id="txtApprover2" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																width="70px"></asp:textbox></td>
													</tr>
													<tr id="trManager" runat="server">
														<td class="td1">Manager</td>
														<td class="td2"><asp:dropdownlist id="ddlManager" runat="server" DataTextField="UserName" DataValueField="UserID"
																onchange="checkResourceDuplicates(this,3);ws_getrate(this);" CssClass="select"></asp:dropdownlist></td>
														<td class="td2" align="left" colSpan="2"><asp:textbox id="txtManager" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																width="70px"></asp:textbox></td>
													</tr>
													<tr>
														<td class="td1">Team Leader</td>
														<td class="td2"><asp:dropdownlist id="ddlTeamLeader" runat="server" DataTextField="UserName" DataValueField="UserID"
																onchange="checkResourceDuplicates(this,5);ws_getrate(this);" CssClass="select"></asp:dropdownlist></td>
														<td class="td2" align="left" colSpan="2"><asp:textbox id="txtTeamLeader" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																width="70px"></asp:textbox></td>
													</tr>
													<tr id="rowresourceDefaultNone" vAlign="top" name="rowresourceDefaultNone">
														<td class="td1" width="100%" colSpan="4"></td>
													</tr>
													<tr>
														<td class="td1" align="left" colSpan="4">Team Members</td>
													</tr>
													<tr id="rowresourceDefaultA" style="DISPLAY: none" vAlign="top">
														<td class="td1" width="40%">&nbsp;</td>
														<td class="td2" width="30%"><asp:dropdownlist id="ddlResource_" runat="server" DataTextField="UserName" DataValueField="UserID"
																onchange="checkResourceDuplicates(this,6);ws_getrate(this);" CssClass="select"></asp:dropdownlist></td>
														<td class="td2" align="left"><asp:textbox id="txtResource_" onblur="ValidateDisplayDecimal(this);" runat="server" CssClass="InputR"
																width="70px"></asp:textbox></td>
														<td class="td2" width="5%"><IMG id="imgDeleteresource_" style="CURSOR: hand" onclick="deleteFormSection('resource', this, document.Form1);"
																alt="Delete this Row" src="../images/Delete.gif" align="middle" border="0" name="imgDeleteresource_" runat="server">
														</td>
													</tr>
												</TABLE>
												<table class="t1" id="tblresourceadd" width="100%" name="tblresourceadd">
													<tr>
														<td vAlign="bottom" align="left" colSpan="4"><input class="button" onclick="addFormSection('resource', document.Form1);" type="button"
																value="Add Team Member">
														</td>
													</tr>
												</table>
											</SPAN></td>
									</tr>
									<tr>
										<td>
											<!-- This is going to be Orders User Control --><im:orders id="ucOrders" runat="server"></im:orders>
											<!-- End of Orders User Control --></td>
									</tr>
									<uc1:projectdocuments id="ucProjectDocuments" runat="server"></uc1:projectdocuments></table>
							</td>
						</tr>
						<tr>
							<td class="td1" align="left" colSpan="2">Project Comments:</td>
						</tr>
						<tr>
							<td class="td2" colSpan="2"><asp:textbox id="txtProjComment" CssClass="TextArea" Runat="server" Width="100%" Rows="5" TextMode="MultiLine"></asp:textbox><br>
							</td>
						</tr>
						<tr>
							<td align="center" colSpan="2"><input class="button" onclick="validatePage();" type="button" value="Save">
								<input class="button" onclick="uploadDocument();" type="button" value="Upload Documents">
								<input class="button" onclick="validatePage('Submit');" type="button" value="Submit for Approval">
								<asp:button id="btnSubmit" CssClass="inputhidden" Runat="server" Text="Submit"></asp:button><asp:button id="btnSave" CssClass="inputhidden" Runat="server" Text="Save"></asp:button></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
