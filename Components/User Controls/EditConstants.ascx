<%@ Control Language="vb" AutoEventWireup="false" Codebehind="EditConstants.ascx.vb" Inherits="TimeTrax.EditConstants" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table class="cell" width="100%" cellSpacing="0" cellPadding="0" align="center" border="5">
	<TR>
		<th class="th2" align="center">
			<!-- generic label --><asp:label id="LblHeader" Runat="server">Manage Constants -</asp:label></th></TR>
	<tr>
		<td>
			<br>
			<div id="tblwizard1" runat="server">
				<table cellSpacing="0" cellPadding="0" align="center" border="0">
					<tr>
						<td class="td8" vAlign="top" align="center" width="600">
							<table cellSpacing="0" cellPadding="0" width="500" border="0">
								<tr>
									<th class="th1" width="400">
										<asp:label id="LblConName" Runat="server"></asp:label></th>
									<th class="th1" width="100">
										Enabled</th>
								</tr>
							</table>
							<asp:datalist id="dlconstant" runat="server">
								<ItemTemplate>
									<table border="0" width="500" cellpadding="0" cellspacing="0">
										<tr>
											<td class="cell" width="400">
												<asp:TextBox ID="txtid" Runat="server" CssClass="input" visible="true" width="0" Text='<%# DataBinder.Eval(Container.DataItem, "ConstantID") %>'>
												</asp:TextBox>
												<asp:TextBox ID="txtconstant" Runat="server" CssClass="input" text='<%# DataBinder.Eval(Container.DataItem, "ConstantName") %>' Width="385">
												</asp:TextBox>
											</td>
											<td class="cell" width="100" align="center">
												<asp:CheckBox ID="chkenabled" runat="server" cssclass="cell" Checked='<%# DataBinder.Eval(Container.DataItem, "Enabled") %>'>
												</asp:CheckBox>
											</td>
										</tr>
									</table>
								</ItemTemplate>
							</asp:datalist>
						</td>
					</tr>
					<tr>
						<td width="600" valign="top" align="center" class="td8">
							<div id="tblDynAdd" runat="server">
								<TABLE id="tblItem" style="DISPLAY: block" cellSpacing="0" cellPadding="0" width="500"
									align="center" border="0" name="tblItem">
									<TR id="rowItemDefaultA" style="DISPLAY: none" vAlign="top">
										<TD class="cell" vAlign="middle" align="left" width="400"><IMG id="imgDeleteItem_" style="CURSOR: hand" onclick="deleteFormSection('Item', this, document.Form1);"
												alt="Delete a Row" src="/Regions/images/Delete.gif" border="0" name="imgDeleteItem_">&nbsp;
											<asp:textbox id="txtconstant_" runat="server" Width="360" ReadOnly="False" CssClass="input" TextMode="SingleLine"
												Rows="1"></asp:textbox></TD>
										<td class="cell" vAlign="middle" align="center" width="100"><asp:CheckBox ID="chkenabled_" runat="server" cssclass="td" Checked="True"></asp:CheckBox></td>
									</TR>
								</TABLE>
								<TABLE width="500" align="center" border="0">
								<TR>
									<TD class="td8" colSpan="2"><INPUT type="hidden" name="item_list"><INPUT id="LoadCount" type="hidden" name="LoadCount" runat="server">
										<asp:TextBox id="txtVal" runat="server" Width="0px">xxx</asp:TextBox>
										<asp:CustomValidator id="CustomValidator1" runat="server" ErrorMessage="err" ControlToValidate="txtVal"
											ClientValidationFunction="ValidateConstantDynamic" Display="None"></asp:CustomValidator>
										<CENTER>Add constants by clicking the Add button.&nbsp;&nbsp;<IMG style="CURSOR: hand" onclick="addFormSection('Item', document.Form1);" alt="Add New Row"
												src="/Regions/images/add.gif" border="0"></CENTER>
									</TD>
								</TR>
							</TABLE>
							</div>
						</td>
					</tr>
					<tr>
						<td class="td8" vAlign="top" align="right" width="600">
							<asp:button id="btnsubmit" runat="server" CssClass="button2" Text="Update"></asp:button>
						</td>
					</tr>
					<tr>
						<td class="td8" vAlign="top" align="center" width="600"><asp:label id="lblmenu" Runat="server"></asp:label></td>
					</tr>
				</table>
			</div>
			<div id="tblwizard2" runat="server">
				<table width="100%" align="center">
					<tr>
						<td class="td8" align="center"><asp:label id="lblmessage" Runat="server"></asp:label></td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
	<tr><td><br></td></tr>
</table>
