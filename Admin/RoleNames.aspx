<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RoleNames.aspx.vb" Inherits="TimeTrax.RoleNames"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
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
				<th class="th">Manage Constants - Roles</th>
			</tr>
			<tr>
				<td valign="top" class="td3">
					<table width="98%" align="center">
						<tr>
							<td vAlign="top" width="100%">
								
								
								<div id="tblwizard1" runat="server">
									<table class="t1" width="80%" align="center">
										
												<asp:datalist id="dlconstant" runat="server">
													<HeaderTemplate>
														<tr>
															<th class="th1" width="60%">Role Name</th>
															<th class="th1" width="5%">Enabled</th>
														</tr>
													</HeaderTemplate>
													<ItemTemplate>
														<tr>
															<td class="td1">
																<asp:TextBox ID="txtid" Runat="server" CssClass="inputhidden" visible="true" Text='<%# DataBinder.Eval(Container.DataItem, "ConstantID") %>'>
																</asp:TextBox>
																<asp:TextBox ID="txtconstant" Runat="server" CssClass="input" width="40%" text='<%# DataBinder.Eval(Container.DataItem, "ConstantName") %>'>
																</asp:TextBox>
															</td>
															<td class="td2" align="center">
																<asp:CheckBox ID="chkenabled" runat="server" cssclass="cell" Checked='<%# DataBinder.Eval(Container.DataItem, "Enabled") %>'>
																</asp:CheckBox>
															</td>
														</tr>
													</ItemTemplate>
												</asp:datalist>
												<div id="tblDynAdd" runat="server">
													<TABLE class="t1" id="tblItem" style="DISPLAY: block" 
														align="center"  name="tblItem">
														<TR id="rowItemDefaultA" style="DISPLAY: none" vAlign="top">
															<TD class="td1" width="10">
																<IMG id="imgDeleteItem_" style="CURSOR: hand" onclick="deleteFormSection('Item', this, document.Form1);"
																	alt="Delete a Row" src="<%=Request.ApplicationPath%>/images/Delete.gif" border="0" name="imgDeleteItem_">&nbsp;
															</td>
															<TD class="td2">
																<asp:textbox id="txtconstant_" runat="server" Width="360" ReadOnly="False" CssClass="input" TextMode="SingleLine"	Rows="1"></asp:textbox>
															</TD>
															<td class="td1" align="center"><asp:CheckBox ID="chkenabled_" runat="server" cssclass="td" Checked="True"></asp:CheckBox></td>
														</TR>
													</TABLE>
													<TABLE width="100%" align="center" border="0">
														<TR>
															<TD colSpan="2"><INPUT type="hidden" name="item_list"><INPUT id="LoadCount" type="hidden" name="LoadCount" runat="server">
																<asp:TextBox id="txtVal" runat="server" CssClass="inputhidden">xxx</asp:TextBox>
																<asp:CustomValidator id="CustomValidator1" runat="server" ErrorMessage="err" ControlToValidate="txtVal"
																	ClientValidationFunction="ValidateConstantDynamic" Display="None"></asp:CustomValidator>
																<CENTER>Add Role Names by clicking the Add button.&nbsp;&nbsp;<IMG style="CURSOR: hand" onclick="addFormSection('Item', document.Form1);" alt="Add New Row"
																		src="<%=Request.ApplicationPath%>/images/add.gif" border="0"></CENTER>
															</TD>
														</TR>
													</TABLE>
												</div>
											</td>
										</tr>
										<tr>
											<td align="center">
												<asp:button id="btnSubmit" CssClass="button" Runat="server" Text="Submit"></asp:button>
											</td>
										</tr>
									</table>
								</div>
								<div id="tblwizard2" runat="server">
									<table width="100%" align="center">
										<tr>
											<td class="td" align="center"><asp:label id="lblmessage" Runat="server"></asp:label></td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<asp:validationsummary id="validationsummary1" style="Z-INDEX: 103; LEFT: 16px" runat="server" width="696px"
									height="88px" showsummary="false" showmessagebox="true"></asp:validationsummary>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
 </body>