<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TimeOffTypes.aspx.vb" Inherits="TimeTrax.TimeOffTypes"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<body>
	<form id="Form1" method="post" runat="server">
		<im:Header id="ucHeader" runat="server"></im:Header>
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
					Manage Constants - TimeOff Types
				</th>
			</tr>
			<tr>
				<td vAlign="top" class="td3">
					<table class="t1" width="98%" align="center">
						<tr>
							<td>
								<table width="100%" align="center">
									<tr>
										<td>
											<div id="tblwizard1" runat="server">
												<table align="center" width="55%">
													<tr>
														<td  class="td1" vAlign="top">
															Edit a TimeOff Type:&nbsp;
														</td>
														<td class="td2" vAlign="top" align="left">
															<asp:dropdownlist id="ddlTimeOffTypes" runat="server" CssClass="select" DataTextField="TypeName" DataValueField="TypeID"></asp:dropdownlist>
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
												<table width="80%" align="center" class="t1">
													<tr>
														<td class="td1" width="50%">Description:<FONT color="#ff0066">*</FONT></td>
														<td class="td2">
															<asp:TextBox id="txtName" runat="server" CssClass="input" tabIndex="1" Width="100%"></asp:TextBox>
															<asp:RequiredFieldValidator id="rfvName" runat="server" InitialValue="" ControlToValidate="txtName" Display="None"
																ErrorMessage="Please enter a Description"></asp:RequiredFieldValidator>
														</td>
													</tr>
													<tr>
														<td class="td2" colspan="2" align="center">
															<asp:CheckBox id="chkEnabled" CssClass="label" Text="Enabled" TextAlign="Right" Checked="True"
																runat="server"></asp:CheckBox>
														</td>
													</tr>
													<tr>
														<td colspan="2" class="td2">
															<table align="center">
																<tr>
																	<td>
																		<asp:button id="btnSubmit" CssClass="button" Runat="server" Text="Submit"></asp:button>
																	</td>
																</tr>
															</table>
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