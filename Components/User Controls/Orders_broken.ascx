<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Orders.ascx.vb" Inherits="TimeTrax.Orders" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

					<th class="th1" height="22"><IMG id="menu1a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleDisplay(menu1a, menu1b);"
							 alt="" src="../images/up.gif"  align="right" vspace="2" border="0">
						<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleDisplay(menu1a, menu1b);">Project 
							Budget</SPAN>
						<BR clear="all">
					</th>
				</tr>
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
									<td class="td1">End Date :</td>
									<td class="td2" colspan="2"><asp:textbox id="txtEndDate" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"
											runat="server" CssClass="input" Width="100"></asp:textbox>
										<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
										<div id="divEndDate" style="POSITION: absolute"></div>
										<IMG id="EndDate" style="CURSOR: hand" onclick="imcalendar.select(document.Form1.ucOrders_txtEndDate, 'divEndDate', 'dd/MM/yyyy'); return false;"
											src="../../images/CALENDAR.GIF" border="0" name="EndDate" runat="server">
										<asp:requiredfieldvalidator id="rfvEndDate" Runat="Server" ControlToValidate="txtEndDate" Display="None" ErrorMessage="Please enter the End date"></asp:requiredfieldvalidator></td>
								</tr>
								<tr>
									<td class="td1" align="left"><b>Total</b></td>
									<td class="td2" align="left" colSpan="2"><asp:textbox id="txtProjBudget" Runat="server" CssClass="inputR"></asp:textbox></td>
								</tr>
								<tr id="roworderDefaultNone" vAlign="top" name="roworderDefaultNone">
									<td class="td1" width="100%" colSpan="3"></td>
								</tr>
								<tr id="roworderDefaultA" style="DISPLAY: none" vAlign="top">
									<td class="td1"><asp:textbox id="txtItemID_" runat="server" width="0"></asp:textbox>
										<asp:dropdownlist id="ddlOrderItem_" runat="server" CssClass="select" DataTextField="ItemName" DataValueField="OrderItemID"
											onchange="checkOrderDuplicates(this);"></asp:dropdownlist>
									</td>
									<td class="td2"><asp:textbox id="txtOrderAmount_" onblur="ValidateDisplayDecimal(this);calcBudget();" runat="server"
											CssClass="InputR"></asp:textbox></td>
									<td class="td1" width="6%"><IMG id="imgDeleteorder_" style="CURSOR: hand" onclick="deleteFormSection('order', this, document.Form1);calcBudget();"
											 alt="Delete this Row" src="../../images/Delete.gif" border="0" name="imgDeleteorder_" runat="server">
									
							<TABLE id="tblorderadd"  width="100%" border="0" name="tblorderadd">
								<tr>
									<td align="left" colSpan="3"><input onclick="addFormSection('order', document.Form1);calcBudget();" class="button" type="button" value="Add Budget Item">
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
			<table id="tblTasks"  width="100%" border="0">
				<tr>
					<th class="th1" height="22"><IMG id="menu2a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleDisplay(menu2a, menu2b);"
							height="12" alt="" src="../images/up.gif" width="12" align="right" vspace="2" border="0">
						<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleDisplay(menu2a, menu2b);">Tasks</SPAN>
						<BR clear="all">
					</th>
				</tr>
				<tr>
					<td><SPAN id="menu2b" style="DISPLAY: block">
							<TABLE id="tbltask"  width="100%" border="0" name="tbltask">
								<tr>
									<td colSpan="5"><asp:placeholder id="taskPlace" Runat="server"></asp:placeholder><input id="task_list" type="hidden" name="task_list">
										<input id="taskLoadCount" type="hidden" name="taskLoadCount" runat="server"> <input id="task_maxbudget" type="hidden" name="task_maxbudget" runat="server">
									</td>
								</tr>
								<tr>
									<th class="th2" width="6%">
										&nbsp;</th>
									<th class="th2" width="44%">
										&nbsp;</th>
									<th class="th2" width="25%">
										Budget</th>
									<th class="th2" width="15%">
										Hours</th>
									<th class="th2" width="10%">
										Billable</th>
								</tr>
								<tr>
									<td class="td1" colSpan="2"><b>Total</b></td>
									<td class="td2"><asp:textbox id="txtTotBudget" Runat="server" CssClass="inputr" width="100%"></asp:textbox></td>
									<td class="td1" align="center"><asp:textbox id="txtTotHrs" Runat="server" CssClass="Total" Width="50%"></asp:textbox></td>
									<td class="td2">&nbsp;</td>
								</tr>
								<tr id="rowtaskDefaultNone" vAlign="top" name="rowtaskDefaultNone">
									<td class="td1" width="100%" colSpan="5"></td>
								</tr>
								<tr id="rowtaskDefaultA" style="DISPLAY: none" vAlign="top">
									<td class="td1"><IMG id="imgDeletetask_" style="CURSOR: hand" onclick="deleteFormSection('task', this, document.Form1);calcTasks();"
											 alt="Delete this Row" src="../../images/Delete.gif" align="right" border="0"
											name="imgDeletetask_" runat="server">
									</td>
									<td class="td1"><asp:textbox id="txtTask_" runat="server" CssClass="input" width="100%"></asp:textbox></td>
									<td class="td2"><asp:textbox id="txtTaskAmount_" onblur="ValidateDisplayDecimal(this);calcTasks();" runat="server"
											CssClass="InputR" width="100%"></asp:textbox></td>
									<td class="td1" align="center"><asp:textbox id="txtHours_" onblur="ValidateDisplayInteger(this);calcTasks();" runat="server"
											CssClass="Input" width="50%"></asp:textbox></td>
									<td class="td2" align="center"><asp:checkbox id="chkBillable_" runat="server" width="22px"></asp:checkbox></td>
								</tr>
							</TABLE>
							<table id="tbltaskadd"  width="100%" border="0" name="tbltaskadd">
								<tr>
									<td vAlign="bottom" align="left" colSpan="4"><input onclick="addFormSection('task', document.Form1);calcTasks();" type="button" class="button" value="Add Task">
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
		<td>
			<asp:customvalidator id="cvEndDate" runat="server" ControlToValidate="txtEndDate" Display="None" ErrorMessage="End Date may not be before Start Date"
				ClientValidationFunction="validateEndDate" EnableClientScript="False"></asp:customvalidator>
			<asp:customvalidator id="cvBudget" runat="server" ControlToValidate="txtTotBudget" Display="None" ClientValidationFunction="validateTaskBudget"></asp:customvalidator>
			<asp:customvalidator id="cvProjectBudget" runat="server" ControlToValidate="txtProjBudget" Display="None" ClientValidationFunction="validateProjBudget"></asp:customvalidator>


