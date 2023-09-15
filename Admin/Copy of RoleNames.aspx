<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RoleNames.aspx.vb" Inherits="TimeTrax.RoleNames"%>
<%@ Register TagPrefix="im" TagName="Header" Src="/TimeTrax/Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="/TimeTrax/Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="/TimeTrax/Components/User Controls/Footer.ascx" %>
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
				<th class="th">Manage Constants - Roles</th>
			</tr>
			<tr>
				<td valign="top">
					<table class="t4a" cellSpacing="0" cellPadding="5" width="98%" align="center" border="0">
						<tr>
							<td vAlign="top" width="100%">
								<br>
								<br>
								
								<div id="tblwizard1" runat="server">
									<table class="t3" cellSpacing="2" cellPadding="2" width="100%" align="center" border="0">
										<tr>
											<td class="td" vAlign="top" align="center">
												<asp:datalist id="dlconstant" runat="server" width="600">
													<HeaderTemplate>
														<tr>
															<th class="th1" width="95%">Role Name</th>
															<th class="th1" width="5%">Enabled</th>
														</tr>
													</HeaderTemplate>
													<ItemTemplate>
														<tr>
															<td class="td" width="400">
																<asp:TextBox ID="txtid" Runat="server" CssClass="input" visible="true" width="0" Text='<%# DataBinder.Eval(Container.DataItem, "ConstantID") %>'>
																</asp:TextBox>
																<asp:TextBox ID="txtconstant" Runat="server" CssClass="input" text='<%# DataBinder.Eval(Container.DataItem, "ConstantName") %>' Width="385">
																</asp:TextBox>
															</td>
															<td class="td" width="100" align="center">
																<asp:CheckBox ID="chkenabled" runat="server" cssclass="cell" Checked='<%# DataBinder.Eval(Container.DataItem, "Enabled") %>'>
																</asp:CheckBox>
															</td>
														</tr>
													</ItemTemplate>
												</asp:datalist>
												<div id="tblDynAdd" runat="server">
													<TABLE id="tblItem" style="DISPLAY: block" cellSpacing="0" cellPadding="0" width="500"
														align="center" border="0" name="tblItem">
														<TR id="rowItemDefaultA" style="DISPLAY: none" vAlign="top">
															<TD class="td" width="10">
																<IMG id="imgDeleteItem_" style="CURSOR: hand" onclick="deleteFormSection('Item', this, document.Form1);"
																	alt="Delete a Row" src="/TimeTrax/images/Delete.gif" border="0" name="imgDeleteItem_">&nbsp;
															</td>
															<TD class="td" width="580">
																<asp:textbox id="txtconstant_" runat="server" Width="360" ReadOnly="False" CssClass="input" TextMode="SingleLine"	Rows="1"></asp:textbox>
															</TD>
															<td class="td" width="20" align="center"><asp:CheckBox ID="chkenabled_" runat="server" cssclass="td" Checked="True"></asp:CheckBox></td>
														</TR>
													</TABLE>
													<TABLE width="100%" align="center" border="0">
														<TR>
															<TD class="td" colSpan="2"><INPUT type="hidden" name="item_list"><INPUT id="LoadCount" type="hidden" name="LoadCount" runat="server">
																<asp:TextBox id="txtVal" runat="server" Width="0px">xxx</asp:TextBox>
																<asp:CustomValidator id="CustomValidator1" runat="server" ErrorMessage="err" ControlToValidate="txtVal"
																	ClientValidationFunction="ValidateConstantDynamic" Display="None"></asp:CustomValidator>
																<CENTER>Add Role Names by clicking the Add button.&nbsp;&nbsp;<IMG style="CURSOR: hand" onclick="addFormSection('Item', document.Form1);" alt="Add New Row"
																		src="/TimeTrax/images/add.gif" border="0"></CENTER>
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