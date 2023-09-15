<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Profitability.aspx.vb" Inherits="TimeTrax.Profitability"%>
<body>
	<form id="Form1" method="post" runat="server">
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
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="tdmenu">
					<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
				</td>
			</tr>
		</table>
		<div id="divReport" runat="server">
			<table class="t4" width="100%">
				<tr>
					<th class="th">
						Profitability
					</th>
				</tr>
				<tr>
					<td vAlign="top" class="td3">
						<table class="t1" width="98%" align="center">
							<tr>
								<td class="td">Project :</td>
								<td class="td" colSpan="3"><asp:dropdownlist class="select" id="ddlProjects" runat="server" Width="100%" AutoPostBack="True"
										DataTextField="ProjectName" DataValueField="ProjectID"></asp:dropdownlist></td>
							</tr>
							<tr>
								<td class="td">Period :</td>
								<td class="td"><asp:textbox id="txtStartDate" onblur="ValidateDisplayDate('Please enter the Start date in the DD/MM/YYYY format.', this);"
										runat="server" Width="100" CssClass="input"></asp:textbox>
									<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
									<div id="divStartDate" style="POSITION: absolute"></div>
									<IMG id="StartDate" style="CURSOR: hand" onclick="imcalendar.select(document.Form1.txtStartDate, 'divStartDate', 'dd/MM/yyyy'); return false;"
										src="../images/CALENDAR.GIF" border="0" name="StartDate" runat="server">
								</td>
								<td class="td" align="center">to</td>
								<td class="td"><asp:textbox id="txtEndDate" onblur="ValidateDisplayDate('Please enter the End date in the DD/MM/YYYY format.', this);"
										runat="server" Width="100" CssClass="input"></asp:textbox>
									<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
									<div id="divEndDate" style="POSITION: absolute"></div>
									<IMG id="EndDate" style="CURSOR: hand" onclick="imcalendar.select(document.Form1.txtEndDate, 'divEndDate', 'dd/MM/yyyy'); return false;"
										src="../images/CALENDAR.GIF" border="0" name="EndDate" runat="server">
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<table width="100%">
										<tr>
											<td class="td" align="right">Show As:</td>
											<td class="td">
												<asp:RadioButtonList id="rdoOutput" runat="server" Width="20%" CssClass="select">
													<asp:ListItem Value="Financial" Selected="True">Financial</asp:ListItem>
													<asp:ListItem Value="Time">Time</asp:ListItem>
												</asp:RadioButtonList>
											</td>
											<td class="td" align="right">Show:</td>
											<td class="td">
												<asp:RadioButtonList id="rdoDisplay" runat="server" Width="20%" CssClass="select">
													<asp:ListItem Value="Both" Selected="True">Both</asp:ListItem>
													<asp:ListItem Value="Graph">Graph</asp:ListItem>
													<asp:ListItem Value="Table">Table</asp:ListItem>
												</asp:RadioButtonList>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="td" colSpan="3"></td>
								<td class="td" align="center">
									<asp:imagebutton id="imgRegenerate" runat="server" Width="16px" ImageUrl="../Images/preview.gif"
										Height="16px" AlternateText="Re-generate Report"></asp:imagebutton>
									<IMG onclick="window.print();" height="16" alt="Print Report" src="../Images/print.gif"
										width="16" >
									<asp:imagebutton id="imgExport" runat="server" Width="16px" ImageUrl="../Images/save.gif" Height="16px"
										AlternateText="Export Report to Excel"></asp:imagebutton>
								</td>
							</tr>
							<tr>
								<td class="td1" align="right">Project Duration :</td>
								<td class="td2" align="center"><asp:textbox class="InputRO" id="txtProjStart" runat="server" ReadOnly="True" name="txtProjStart"></asp:textbox></td>
								<td class="td1" align="center">to</td>
								<td class="td2" align="center"><asp:textbox class="InputRO" id="txtProjEnd" runat="server" ReadOnly="True" name="txtProjEnd"></asp:textbox></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="labelbold" align="center">Budget</td>
								<td class="labelbold" align="center">To Date</td>
								<td class="labelbold" align="center">This Period</td>
							</tr>
							<tr>
								<td class="td" align="right">Budget :</td>
								<td class="td" align="center"><asp:textbox class="Total" id="txtBudget" runat="server" ReadOnly="True" name="txtBudget"></asp:textbox></td>
								<td class="td" align="center"><asp:textbox class="Total" id="txtToDateCost" runat="server" ReadOnly="True" name="txtToDateCost"></asp:textbox></td>
								<td class="td" align="center"><asp:textbox class="Total" id="txtPeriodCost" runat="server" ReadOnly="True" name="txtPeriodCost"></asp:textbox></td>
							</tr>
							<tr>
								<td class="td" align="right">Hours :</td>
								<td class="td" align="center"><asp:textbox class="Total" id="txtBudgetHrs" runat="server" ReadOnly="True" name="txtBudgetHrs"></asp:textbox></td>
								<td class="td" align="center"><asp:textbox class="Total" id="txtToDateHrs" runat="server" ReadOnly="True" name="txtToDateHrs"></asp:textbox></td>
								<td class="td" align="center"><asp:textbox class="Total" id="txtPeriodHrs" runat="server" ReadOnly="True" name="txtPeriodHrs"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td vAlign="top" class="td3">
						<div id="divChart" runat="server">
							<table class="t1" width="100%" align="center">
								<tr>
									<td class="td2">
										<im:IMChart id="IMBarChart" runat="server" ChartType="Bar"></im:IMChart>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td vAlign="top" class="td3">
						<div id="divTable" runat="server">
							<table class="t1" width="25%" align="center">
								<tr>
									<td class="td2">
										<asp:datagrid id="dgTable" runat="server" ShowHeader="True" AutoGenerateColumns="False"
											Width="100%">
											<HeaderStyle CssClass="grid-header"></HeaderStyle>
											<ItemStyle CssClass="grid-trigalt1" Width="20%"></ItemStyle>
											<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
											<Columns>
												<asp:BoundColumn DataField="Week" ItemStyle-Wrap="False" HeaderText="Week"></asp:BoundColumn>
												<asp:BoundColumn DataField="Billable" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderText="Billable"></asp:BoundColumn>
												<asp:BoundColumn DataField="NonBillable" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderText="Non Billable"></asp:BoundColumn>
												<asp:BoundColumn DataField="CumulativeBillable" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderText="Cumulative Billable"></asp:BoundColumn>
												<asp:BoundColumn DataField="CumulativeNonBillable" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderText="Cumulative Non Billable"></asp:BoundColumn>
												<asp:BoundColumn DataField="TotHrs" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderText="Total"></asp:BoundColumn>
											</Columns>
										</asp:datagrid>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
  </body>
