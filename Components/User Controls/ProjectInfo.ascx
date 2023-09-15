<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ProjectInfo.ascx.vb" Inherits="TimeTrax.ucProjectInfo" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc2" TagName="FinancialDocuments" Src="FinancialDocuments.ascx" %>
<%@ Register TagPrefix="uc1" TagName="ProjectDocuments" Src="ProjectDocuments.ascx" %>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<table id="tblProjInfo" width="100%">
	<tr>
		<td>
			<table class="t1" width="98%" align="center">
				<TBODY>
					<tr>
						<th class="th1" height="22">
							<IMG id="menu1a" style="TOP: 3px; CURSOR: hand; LEFT: 0px" onclick="ToggleDisplay(menu1a, menu1b);"
								height="12" alt="" src="../images/down.gif" width="12" align="right" vspace="2" border="0">
							<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleDisplay(menu1a, menu1b);">Client 
								Detail</SPAN>
							<BR clear="all">
						</th>
					</tr>
					<tr>
						<td>
							<input type="hidden" id="hidProjID" name="hidProjID" runat="server"> <SPAN id="menu1b" style="DISPLAY: none">
								<TABLE id="tblclient" cellSpacing="0" cellPadding="2" width="100%" border="0" name="tblclient">
									<tr>
										<td class="td1" valign="top" width="25%">Client:</td>
										<td class="td2">
											<asp:TextBox ID="txtClient" Runat="server" CssClass="InputRO" ReadOnly="True" Width="90%"></asp:TextBox>
											<input type="hidden" id="hidClientID" name="hidClientID" runat="server">
										</td>
										<td width="6%" class="td2"><IMG id="imgShowClient_" style="CURSOR: hand" onclick="viewClientDetails(document.Form1['ucProjInfo_hidClientID'].value);"
												alt="Show Client Details" src="../../images/info.gif" name="imgShowClient_" runat="server"></td>
									</tr>
									<tr>
										<td class="td1">Contact :</td>
										<td class="td2">
											<asp:TextBox ID="txtContact" Runat="server" CssClass="InputRO" ReadOnly="True"></asp:TextBox>
											<input type="hidden" id="hidContactID" name="hidContactID" runat="server">
										</td>
										<td width="6%" class="td2"><IMG id="imgShowContact_" style="CURSOR: hand" onclick="viewContactDetails(document.Form1['ucProjInfo_hidContactID'].value);"
												alt="Show Contact Details" src="../../images/info.gif" name="imgShowContact_" runat="server"></td>
									<tr>
										<td class="td1">Admin Contact :</td>
										<td class="td2">
											<asp:TextBox ID="txtAdmin" Runat="server" CssClass="InputRO" ReadOnly="True"></asp:TextBox>
											<input type="hidden" id="hidAdminContactID" name="hidAdminContactID" runat="server">
										</td>
										<td width="6%" class="td2"><IMG id="imgShowAdminContact_" style="CURSOR: hand" onclick="viewContactDetails(document.Form1['ucProjInfo_hidAdminContactID'].value);"
												alt="Show Admin Contact Details" src="../../images/info.gif" name="imgShowAdminContact_" runat="server"></td>
									</tr>
								</TABLE>
							</SPAN>
						</td>
					</tr>
					<tr>
						<th class="th1" height="22">
							<IMG id="menu2a" style="TOP: 3px; CURSOR: hand; LEFT: 0px" onclick="ToggleDisplay(menu2a, menu2b);"
								height="12" alt="" src="../images/up.gif" width="12" align="right" vspace="2" border="0">
							<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleDisplay(menu2a, menu2b);">Project 
								Detail</SPAN>
							<BR clear="all">
						</th>
					</tr>
					<tr>
						<td>
							<SPAN id="menu2b" style="DISPLAY: block">
								<TABLE id="tblproj" cellSpacing="0" cellPadding="2" width="100%" border="0" name="tblproj">
									<tr>
										<td class="td1" width="25%">Full Name :</td>
										<td class="td2">
											<asp:Textbox id="txtProjFullName" runat="server" CssClass="InputRO" ReadOnly="True" Width="90%"></asp:Textbox>
										</td>
									</tr>
									<tr>
										<td class="td1">Short Name :</td>
										<td class="td2">
											<asp:Textbox id="txtProjName" runat="server" CssClass="InputRO" ReadOnly="True" Width="45%"></asp:Textbox>
										</td>
									</tr>
									<tr>
										<td class="td1">Code :</td>
										<td class="td2">
											<asp:Textbox id="txtProjCode" runat="server" CssClass="InputRO" ReadOnly="True"></asp:Textbox>
										</td>
									</tr>
									<tr>
										<td class="td1">Cost Centre :</td>
										<td class="td2">
											<asp:Textbox id="txtCostCentre" runat="server" CssClass="InputRO" ReadOnly="True"></asp:Textbox>
										</td>
									</tr>
									<tr>
										<td class="td1">Currency :</td>
										<td class="td2">
											<asp:Textbox id="txtCurrency" CssClass="InputRO" ReadOnly="True" runat="server"></asp:Textbox>
										</td>
									</tr>
									<tr>
										<td class="td1">Start Date :</td>
										<td class="td2">
											<asp:textbox id="txtStartDate" runat="server" CssClass="InputRO" ReadOnly="True" Width="100"></asp:textbox>
										</td>
									</tr>
								</TABLE>
							</SPAN>
						</td>
					</tr>
					<tr>
						<th class="th1" height="22">
							<IMG id="menu3a" style="TOP: 3px; CURSOR: hand; LEFT: 0px" onclick="ToggleDisplay(menu3a, menu3b);"
								height="12" alt="" src="../images/down.gif" width="12" vspace="2" border="0" align="right">
							<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleDisplay(menu3a, menu3b);">Resources</SPAN>
							<BR clear="all">
						</th>
					</tr>
					<tr>
						<td>
							<SPAN id="menu3b" style="DISPLAY: none">
								<TABLE id="tblresource" width="100%" name="tblresource" class="t1">
									<tr>
										<td colspan="2">
											<asp:placeholder id="resourcePlace" Runat="server"></asp:placeholder>
											<input id="resource_list" type="hidden" name="resource_list"> <input id="resourceLoadCount" type="hidden" name="resourceLoadCount" runat="server">
										</td>
									</tr>
									<tr>
										<th class="th2" width="50%">
											Role</th>
										<th class="th2">
											Name</th>
										<th class="th2">
											Enabled</th>
									</tr>
									<tr>
										<td class="td1"><asp:Label ID="Approver1Role" Runat="server"></asp:Label></td>
										<td class="td2" colspan="2"><asp:Textbox ID="txtApprover1" Runat="server" CssClass="InputRO" ReadOnly="True"></asp:Textbox></td>
									</tr>
									<tr id="Stage2row" runat="server">
										<td class="td1"><asp:Label ID="Approver2Role" Runat="server"></asp:Label></td>
										<td class="td2" colspan="2"><asp:Textbox ID="txtApprover2" Runat="server" CssClass="InputRO" ReadOnly="True"></asp:Textbox></td>
									</tr>
									<tr id="TSStage2row" runat="server">
										<td class="td1">Manager</td>
										<td class="td2" colspan="2"><asp:Textbox ID="txtManager" Runat="server" CssClass="InputRO" ReadOnly="True"></asp:Textbox>
											<IMG id="Img1" style="CURSOR: hand" onclick="ChangeTeamLeader(ucProjInfo_hidProjID.value,0);"
												alt="Change the Project Manager" src="../../images/detail.gif" border="0" name="imgManager"
												runat="server" align="middle"></td>
									</tr>
									<tr>
										<td class="td1">Team Leader</td>
										<td class="td2" colspan="2"><asp:Textbox ID="txtTeamLeader" Runat="server" CssClass="InputRO" ReadOnly="True"></asp:Textbox>
											<IMG id="imgTeamLeaderChange" style="CURSOR: hand" onclick="ChangeTeamLeader(ucProjInfo_hidProjID.value,1);"
												alt="Change the Project Team Leader" src="../../images/detail.gif" border="0" name="imgTeamLeaderChange"
												runat="server" align="middle"></td>
									</tr>
									<tr id="rowresourceDefaultNone" vAlign="top" name="rowresourceDefaultNone">
										<td class="td1" width="100%" colSpan="3"></td>
									</tr>
									<tr>
										<td class="td1" colspan="3" align="left">Team Members</td>
									</tr>
									<tr id="rowresourceDefaultA" style="DISPLAY: none" vAlign="top">
										<td class="td1" width="50%">&nbsp;</td>
										<td class="td2">
											<INPUT type="hidden" runat="server" id="hidResourceID_" NAME="hidResourceID_">
											<asp:Textbox ID="txtResource_" Runat="server" CssClass="InputRO" ReadOnly="True"></asp:Textbox>
										</td>
										<td class="td2" align="center">
											<asp:checkbox id="chkEnabled_" runat="server" Enabled="False"></asp:checkbox>
											<IMG id="imgDisableResource_" style="CURSOR: hand" onclick="DisableResource(this,ucProjInfo_hidProjID.value);"
												alt="Disable/Enable the Resource" src="../../images/detail.gif" border="0" name="imgDisableResource_"
												runat="server" align="middle">
										</td>
									</tr>
								</TABLE>
								<table id="tblresourceadd" width="100%" name="tblresourceadd">
									<tr id="addResourcerow" runat="server">
										<td colSpan="2" align="left" valign="bottom">&nbsp; <input type="button" class="button" onclick="addResource();" value="Add Team Member">
										</td>
									</tr>
								</table>
							</SPAN>
						</td>
					</tr>
					<span runat="server" id="spnSummaries">
						<tr>
							<th class="th1" height="22">
								<IMG id="menu4a" style="TOP: 3px; CURSOR: hand; LEFT: 0px" onclick="ToggleDisplay(menu4a, menu4b);"
									height="12" alt="" src="../images/up.gif" width="12" vspace="2" border="0" align="right">
								<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleDisplay(menu4a, menu4b);">Budget 
									Summary</SPAN>
								<BR clear="all">
							</th>
						</tr>
						<tr>
							<td>
								<SPAN id="menu4b" style="DISPLAY: block">
									<TABLE id="tblbudgetsummary" width="100%" name="tblbudgetsummary" class="t1">
										<tr>
											<td colspan="3" id="tdInvoiceAmtWarning"></td>
										</tr>
										<tr>
											<td>
												<asp:placeholder id="plcBudgetSummary" Runat="server"></asp:placeholder>
											</td>
										</tr>
									</TABLE>
								</SPAN>
							</td>
						</tr>
						<tr>
							<th class="th1" height="22">
								<IMG id="menu5a" style="TOP: 3px; CURSOR: hand; LEFT: 0px" onclick="ToggleDisplay(menu5a, menu5b);"
									height="12" alt="" src="../images/down.gif" width="12" vspace="2" border="0" align="right">
								<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleDisplay(menu5a, menu5b);">Task 
									Summary</SPAN>
								<BR clear="all">
							</th>
						</tr>
						<tr>
							<td>
								<SPAN id="menu5b" style="DISPLAY: none">
									<TABLE id="tbltasksummary" width="100%" name="tbltasksummary" class="t1">
										<tr>
											<td>
												<asp:placeholder id="plcTaskSummary" Runat="server"></asp:placeholder>
											</td>
										</tr>
									</TABLE>
								</SPAN>
							</td>
						</tr>
						<tr>
							<th class="th1" height="22">
								<IMG id="menu6a" style="TOP: 3px; CURSOR: hand; LEFT: 0px" onclick="ToggleDisplay(menu6a, menu6b);"
									height="12" alt="" src="../images/up.gif" width="12" vspace="2" border="0" align="right">
								<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleDisplay(menu6a, menu6b);">Order 
									Summary</SPAN>
								<BR clear="all">
							</th>
						</tr>
						<tr>
							<td>
								<SPAN id="menu6b" style="DISPLAY: block">
									<TABLE id="tblordersummary" width="100%" name="tblordersummary" class="t1">
										<tr>
											<td>
												<asp:placeholder id="plcOrderSummary" Runat="server"></asp:placeholder>
											</td>
										</tr>
									</TABLE>
								</SPAN>
							</td>
						</tr>
					</span><!-- End spnSummaries -->
					<span runat="server" id="spnDocuments">
						<uc1:ProjectDocuments id="ucProjectDocuments" runat="server"></uc1:ProjectDocuments>
					</span>
					<tr>
						<td class="td1" colspan="2" align="left">Project Comments:</td>
					</tr>
					<tr>
						<td colspan="2" class="td2">
							<asp:TextBox ID="txtProjComment" Runat="server" TextMode="MultiLine" Rows="5" CssClass="TextArea"
								Width="100%" ReadOnly="True"></asp:TextBox>
							<br>
						</td>
					</tr>
				</TBODY>
			</table>
		</td>
	</tr>
</table>
