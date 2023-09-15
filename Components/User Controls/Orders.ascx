<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Orders.ascx.vb" Inherits="TimeTrax.Orders" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<table id="tblOrders" class="t4" width="100%">
	<tr>
		<td>
			<table id="tblBudget" border="0" width="100%">
				<tr>
					<th class="th1" height="22">
						<IMG style="TOP: 3px; CURSOR: hand; LEFT: 0px" id="menu7a" onclick="ToggleDisplay(menu7a, menu7b);"
							border="0" alt="" vspace="2" align="right" src="../images/up.gif" width="12" height="12">
						<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleDisplay(menu7a, menu7b);">Project 
							Budget</SPAN>
						<BR clear="all">
					</th>
				</tr>
				<tr>
					<td><SPAN style="DISPLAY: block" id="menu7b">
							<TABLE id="tblorder" class="t1" border="0" width="100%" name="tblorder">
								<tr>
									<td colSpan="3"><asp:placeholder id="orderPlace" Runat="server"></asp:placeholder><input id="order_list" type="hidden" name="order_list">
										<input id="orderLoadCount" type="hidden" name="orderLoadCount" runat="server"> <input id="task_orderitem" type="hidden" name="task_orderitem" runat="server">
									</td>
								</tr>
								<tr>
									<td class="td1" width="50%">Order Number :</td>
									<td class="td2" width="50%" colSpan="2"><asp:textbox id="txtOrderNo" runat="server" CssClass="Input"></asp:textbox><asp:requiredfieldvalidator id="rfvOrderNo" Runat="Server" ControlToValidate="txtOrderNo" Display="None" ErrorMessage="Please enter an Order Number"></asp:requiredfieldvalidator></td>
								</tr>
								<tr>
									<td class="td1">Order Date :</td>
									<td class="td2" colSpan="2"><IM:IMTEXTBOX id="txtOrderDate" runat="server" CssClass="Input" Width="96"></IM:IMTEXTBOX><asp:requiredfieldvalidator id="rfvOrderDate" Runat="Server" ControlToValidate="txtOrderDate" Display="None" ErrorMessage="Please enter an Order Date"></asp:requiredfieldvalidator></td>
								</tr>
								<tr>
									<td class="td1">End Date :</td>
									<td class="td2" colSpan="2"><IM:IMTEXTBOX id="txtEndDate" runat="server" CssClass="Input" RequiredValidationError="Please enter a Project End Date"
											TextType="Date" Width="96"></IM:IMTEXTBOX></td>
								</tr>
								<tr>
									<td class="td1" align="left"><b>Total</b></td>
									<td class="td2" colSpan="2" align="left"><asp:textbox id="txtProjBudget" Runat="server" CssClass="InputROR" ReadOnly="True"></asp:textbox></td>
								</tr>
								<tr style="DISPLAY: none" id="roworderDefaultA" vAlign="top">
									<td class="td1"><asp:textbox id="txtItemID_" runat="server" CssClass="inputhidden"></asp:textbox><asp:dropdownlist id="ddlOrderItem_" runat="server" CssClass="select" Width="50%" DataTextField="ItemName"
											DataValueField="OrderItemID" onchange="checkOrderDuplicates(this);"></asp:dropdownlist></td>
									<td class="td2"><asp:textbox onblur="ValidateDisplayDecimal(this);calcBudget();" id="txtOrderAmount_" runat="server"
											CssClass="InputR"></asp:textbox></td>
									<td class="td2" width="5%"><IMG style="CURSOR: hand" id="imgDeleteorder_" onclick="deleteFormSection('order', this, document.Form1);calcBudget();"
											name="imgDeleteorder_" alt="Delete this Row" src="../../images/Delete.gif" runat="server">
									</td>
								</tr>
							</TABLE>
							<TABLE id="tblorderadd" border="0" cellSpacing="0" cellPadding="2" width="100%" name="tblorderadd"
								runat="server">
								<tr>
									<td colSpan="3" align="left"><input class="button" onclick="addFormSection('order', document.Form1);calcBudget();" value="Add Budget Item"
											type="button">
									</td>
								</tr>
							</TABLE>
						</SPAN>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table id="tblTasks" border="0" cellSpacing="0" cellPadding="0" width="100%">
				<tr>
					<th class="th1" height="22">
						<IMG style="TOP: 3px; CURSOR: hand; LEFT: 0px" id="menu8a" onclick="ToggleDisplay(menu8a, menu8b);"
							border="0" alt="" vspace="2" align="right" src="../images/up.gif" width="12" height="12">
						<SPAN style="TOP: 2px; CURSOR: hand" onclick="ToggleDisplay(menu8a, menu8b);">Tasks</SPAN>
						<BR clear="all">
					</th>
				</tr>
				<tr>
					<td><SPAN style="DISPLAY: block" id="menu8b">
							<TABLE id="tbltask" border="0" cellSpacing="0" cellPadding="2" width="100%" name="tbltask">
								<tr>
									<td colSpan="5"><asp:placeholder id="taskPlace" Runat="server"></asp:placeholder><input id="task_list" type="hidden" name="task_list">
										<input id="taskLoadCount" type="hidden" name="taskLoadCount" runat="server"> <input id="task_maxbudget" type="hidden" name="task_maxbudget" runat="server">
									</td>
								</tr>
								<tr>
									<th class="th2" width="6%">
										&nbsp;
									</th>
									<th class="th2" width="44%">
										&nbsp;
									</th>
									<th class="th2" width="25%">
										Budget</th>
									<th class="th2" width="15%">
										Hours</th>
									<th class="th2" width="10%">
										Billable</th></tr>
								<tr>
									<td class="labelbold" colSpan="2">Total</td>
									<td class="td"><asp:textbox id="txtTotBudget" Runat="server" CssClass="InputROR" ReadOnly="True"></asp:textbox></td>
									<td class="td" align="center"><asp:textbox id="txtTotHrs" Runat="server" CssClass="InputROR" Width="50%" ReadOnly="True"></asp:textbox></td>
									<td>&nbsp;</td>
								</tr>
								<tr id="rowtaskDefaultNone" vAlign="top" name="rowtaskDefaultNone">
									<td class="td" width="100%" colSpan="5"></td>
								</tr>
								<tr style="DISPLAY: none" id="rowtaskDefaultA" vAlign="top">
									<td class="td"><IMG style="CURSOR: hand" id="imgDeletetask_" onclick="deleteFormSection('task', this, document.Form1);calcTasks();"
											border="0" name="imgDeletetask_" alt="Delete this Row" align="right" src="../../images/Delete.gif"
											height="13" runat="server">
									</td>
									<td class="td"><asp:textbox id="txtTask_" runat="server" CssClass="input" Width="100%"></asp:textbox></td>
									<td class="td"><asp:textbox onblur="ValidateDisplayDecimal(this);calcTasks();" id="txtTaskAmount_" runat="server"
											CssClass="InputR"></asp:textbox></td>
									<td class="td" align="center"><asp:textbox onblur="ValidateDisplayInteger(this);calcTasks();" id="txtHours_" runat="server"
											CssClass="Input" width="50%"></asp:textbox></td>
									<td align="center"><asp:checkbox id="chkBillable_" runat="server" width="22px" Checked="True"></asp:checkbox></td>
								</tr>
							</TABLE>
							<table id="tbltaskadd" border="0" cellSpacing="0" cellPadding="2" width="100%" name="tbltaskadd"
								runat="server">
								<tr>
									<td vAlign="bottom" colSpan="4" align="left"><input class="button" onclick="addFormSection('task', document.Form1);calcTasks();" value="Add Task"
											type="button">
									</td>
								</tr>
							</table>
						</SPAN>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td><asp:customvalidator id="cvEndDate" runat="server" ErrorMessage="End Date may not be before Start Date"
				Display="None" ControlToValidate="txtEndDate" EnableClientScript="False" ClientValidationFunction="validateEndDate"></asp:customvalidator>
			<asp:customvalidator id="cvBudget" runat="server" Display="None" ControlToValidate="txtTotBudget" ClientValidationFunction="validateTaskBudget"></asp:customvalidator>
			<asp:customvalidator id="cvProjectBudget" runat="server" Display="None" ControlToValidate="txtProjBudget"
				ClientValidationFunction="validateProjBudget"></asp:customvalidator>
			<INPUT id="txtHidTaskOrderItemDesc" type="hidden" name="txtHidTaskOrderItemDesc" runat="server">
		</td>
	</tr>
</table>
