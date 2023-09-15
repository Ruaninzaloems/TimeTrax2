<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Timesheet.aspx.vb" Inherits="TimeTrax.Timesheet"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>

<im:header id="ucHeader" runat="server"></im:header>
<body>
	<form id="Form1" method="post" runat="server">
		
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Timesheet Capture</th>
			</tr>
			<tr>
				<td class="td3">
					<table class="t1" align="left" style="WIDTH:25%">
						<tr>
							<td class="td1">Outstanding Timesheets</td>
						</tr>
						<tr>
							<td class="td2">
								<asp:datagrid id="dgOutstanding" runat="server" ShowHeader="True" HorizontalAlign="Center" AutoGenerateColumns="False"
									Width="100%">
									<AlternatingItemStyle CssClass="grid-alt2"></AlternatingItemStyle>
									<ItemStyle CssClass="grid-alt1"></ItemStyle>
									<HeaderStyle CssClass="grid-header"></HeaderStyle>
									<Columns>
										<asp:BoundColumn HeaderText="Week Period" DataField="WeekPeriod"></asp:BoundColumn>
									</Columns>
								</asp:datagrid>
							</td>
						</tr>
					</table>
					<table class="t2" align="right" width="20%">
						<tr>
							<td class="td1">
								<asp:calendar id="Calendar1" runat="server" Height="120px" BorderStyle="None" PrevMonthText="&amp;lt;-"
									NextMonthText="-&amp;gt;" ToolTip="Click to Select Timesheet Week to open" BorderColor="#999999"
									Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#A4A4A4" BackColor="#F3F4F5">
									<TodayDayStyle ForeColor="Black" BackColor="#A4A4A4"></TodayDayStyle>
									<SelectorStyle BackColor="#CCCCCC"></SelectorStyle>
									<NextPrevStyle VerticalAlign="Bottom"></NextPrevStyle>
									<DayHeaderStyle Font-Size="7pt" Font-Bold="True" BackColor="#ffffff"></DayHeaderStyle>
									<SelectedDayStyle Font-Bold="True" ForeColor="#000000" BackColor="#A4A4A4"></SelectedDayStyle>
									<TitleStyle ForeColor="#ffffff" Font-Bold="True" BorderColor="Black" BackColor="#2B3B81"></TitleStyle>
									<WeekendDayStyle BackColor="#E3E1E1"></WeekendDayStyle>
									<OtherMonthDayStyle ForeColor="Gray"></OtherMonthDayStyle>
								</asp:calendar><br>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="td3">
					<table id="tbltimea" width="98%" runat="server" name="tbltimea">
						<tr>
							<th class="th1" width="36%">
								<asp:label id="lblWeekNo" Runat="server"></asp:label>
								&nbsp;</th>
							<th class="th1" width="8%">
								<asp:label id="lblDay1Num" Runat="server"></asp:label></th>
							<th class="th1" width="8%">
								<asp:label id="lblDay2Num" Runat="server"></asp:label></th>
							<th class="th1" width="8%">
								<asp:label id="lblDay3Num" Runat="server"></asp:label></th>
							<th class="th1" width="8%">
								<asp:label id="lblDay4Num" Runat="server"></asp:label></th>
							<th class="th1" width="8%">
								<asp:label id="lblDay5Num" Runat="server"></asp:label></th>
							<th class="th1" width="8%">
								<asp:label id="lblDay6Num" Runat="server"></asp:label></th>
							<th class="th1" width="8%">
								<asp:label id="lblDay7Num" Runat="server"></asp:label></th>
							<th class="th1" width="8%">
								&nbsp;<input id="time_base" type="hidden" name="time_base" runat="server"></th>
						</tr>
						<tr>
							<th class="th1">
								&nbsp;</th>
							<th class="th1">
								<asp:label id="lblDay1" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay2" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay3" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay4" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay5" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay6" Runat="server"></asp:label></th>
							<th class="th1">
								<asp:label id="lblDay7" Runat="server"></asp:label></th>
							<th class="th1">
								Total</th>
						</tr>
					</table> <!-- END tbltime -->
					<hr>
					<div width="100%" id="timesScroller" style="BORDER-RIGHT:3px;  BORDER-TOP:1px;  OVERFLOW:auto;  BORDER-LEFT:1px;  WIDTH:750px;  BORDER-BOTTOM:1px;  HEIGHT:400px">
						<table id="tbltime" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server"
							name="tbltime">
							<tr>
								<td class="td">
									<asp:placeholder id="timePlace" runat="server"></asp:placeholder>
									<input id="deleted_list" type="hidden" name="deleted_list">
								</td>
							</tr>
						</table>
					</div>
					<hr>
					<table id="tbltimefoot" width="98%" runat="server" name="tbltimefoot">
						<tr>
							<th class="th1" align="left" width="36%">
								<b>TOTAL :&nbsp;&nbsp;</b></th>
							<th class="th1" width="8%" align="right">
								<asp:textbox id="txtDay1Tot" runat="server" cssclass="inputGrandTotal" size="6" ReadOnly="True"></asp:textbox></th>
							<th class="th1" width="8%" align="right">
								<asp:textbox id="txtDay2Tot" runat="server" cssclass="inputGrandTotal" size="6" ReadOnly="True"></asp:textbox></th>
							<th class="th1" width="8%" align="right">
								<asp:textbox id="txtDay3Tot" runat="server" cssclass="inputGrandTotal" size="6" ReadOnly="True"></asp:textbox></th>
							<th class="th1" width="8%" align="right">
								<asp:textbox id="txtDay4Tot" runat="server" cssclass="inputGrandTotal" size="6" ReadOnly="True"></asp:textbox></th>
							<th class="th1" width="8%" align="right">
								<asp:textbox id="txtDay5Tot" runat="server" cssclass="inputGrandTotal" size="6" ReadOnly="True"></asp:textbox></th>
							<th class="th1" width="8%" align="right">
								<asp:textbox id="txtDay6Tot" runat="server" cssclass="inputGrandTotal" size="6" ReadOnly="True"></asp:textbox></th>
							<th class="th1" width="8%" align="right">
								<asp:textbox id="txtDay7Tot" runat="server" cssclass="inputGrandTotal" size="6" ReadOnly="True"></asp:textbox></th>
							<th class="th1" width="8%" align="right">
								<asp:textbox id="txtTotal" runat="server" cssclass="inputGrandTotal" size="6" ReadOnly="True"></asp:textbox></th>
						</tr>
					</table> <!-- END tbltimefoot -->
				</td>
			</tr>
			<tr>
				<td class="t3" colspan="9">
				</td>
			</tr>
			<tr>
				<td vAlign="top" align="center" colSpan="2" class="td3">
					<table width="100%">
						<tr>
							<td width="50%">
								<table id="tblComment" width="100%">
									<tr>
										<td class="td">Comments</td>
									</tr>
									<tr>
										<td class="td"><asp:textbox id="txtComment" onblur="saveComment();validateLength();" Width="300px" Runat="server" TextMode="MultiLine"
												Rows="5" CssClass="TextArea" MaxLength="1500"></asp:textbox><asp:requiredfieldvalidator id="rfvComments" runat="server" InitialValue=" " ErrorMessage="Please enter comments for all red items!"
												Display="None" ControlToValidate="txtComment"></asp:requiredfieldvalidator>
										</td>
									</tr>
								</table>
							</td>
							<td width="50%">
								<div id="divReject" style="DISPLAY: none" runat="server">
									<table id="tblRejectComment" width="100%">
										<tr>
											<td class="td"><font color="red">Rejection Comment</font></td>
										</tr>
										<tr>
											<td class="td">
												<asp:textbox id="txtRejComment" Width="300px" BackColor="Red" ForeColor="White" Runat="server"
													TextMode="MultiLine" Rows="5" CssClass="TextArea" MaxLength="500"></asp:textbox>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="td3" vAlign="top" align="center" colSpan="2">
					<input class="button" id="htmTimeOff" onclick="openAddTimeOff();" type="button" value="Add TimeOff"
						name="htmTimeOff" runat="server"> <input class="button" id="htmTasks" onclick="openAddTask();" type="button" value="Add tasks"
						name="htmTasks" runat="server"> <input id="hidTimesheetDate" type="hidden" name="hidTimesheetDate" runat="server">
					<asp:button id="btnSave" runat="server" CssClass="button" CausesValidation="False" text="Save"></asp:button>
					<asp:button id="btnSubmit" runat="server" CssClass="button" CausesValidation="False" text="Submit for Approval"></asp:button>
					<asp:button id="btnUnsubmit" runat="server" CssClass="button" CausesValidation="False" text="Recall Submitted Timesheet"
						Enabled="False"></asp:button>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
