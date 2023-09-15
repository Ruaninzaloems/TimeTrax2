<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjStatus.aspx.vb" Inherits="TimeTrax.ProjStatus"%>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<body onload='initFilters()'>
	<form id="Form1" method="post" runat="server">
		<im:Header id="ucHeader" runat="server"></im:Header>
		<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
		<SCRIPT language="JavaScript" src="<%=Request.ApplicationPath%>/Components/Scripts/filterObject.js"></SCRIPT>
		<SCRIPT language="JavaScript" src="<%=Request.ApplicationPath%>/Components/Scripts/DropDownFilter.js"></SCRIPT>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="tdmenu">
					<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
				</td>
			</tr>
		</table>
		<table class="t3" width="100%">
			<tr>
				<td>
					<table class="t4" width="100%">
						<tr>
							<th class="th" colspan="4">
								Report Filters
							</th>
						</tr>
						<tr>
							<td class="td">Client :</td>
							<td colSpan="3" class="td"><asp:dropdownlist id="ddlClient" onchange="filter('2',this,true);" DataTextField="ClientName" DataValueField="ClientID"
									CssClass="select" Width="100%" runat="server" name="ddlClient"></asp:dropdownlist>
								<INPUT id="hidClientID" type="hidden" runat="server" NAME="hidClientID">
							</td>
						</tr>
						<tr>
							<td class="td">Project :</td>
							<td class="td" colSpan="3"><asp:dropdownlist id="ddlProject" DataTextField="ProjectName" DataValueField="ProjectID" CssClass="select"
									Width="100%" runat="server" name="ddlProject"></asp:dropdownlist>
								<INPUT id="hidProjectID" type="hidden" runat="server" NAME="hidProjectID">
								<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="Please select a Project"
									ControlToValidate="ddlProject" InitialValue="0" Display="None"></asp:RequiredFieldValidator>
							</td>
						</tr>
						<tr>
							<td class="td">Period :</td>
							<td class="td"><im:IMTextBox id="txtStartDate" Width="100" CssClass="input" runat="server" TextType="Date" RequiredValidationError="Please enter a Period Start Date"></im:IMTextBox>
							</td>
							<td class="td" align="center">to</td>
							<td class="td"><im:IMTextBox id="txtEndDate" Width="100" CssClass="input" runat="server" TextType="Date" RequiredValidationError="Please enter a Period End Date"></im:IMTextBox>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<table width="100%">
									<tr>
										<td class="td" align="right"><B>Show As :</B></td>
										<td class="td">
											<asp:RadioButtonList id="rdoOutput" runat="server" Width="20%" CssClass="select">
												<asp:ListItem Value="Financial" Selected="True">Financial</asp:ListItem>
												<asp:ListItem Value="Time">Time</asp:ListItem>
											</asp:RadioButtonList>
										</td>
										<td class="td" align="right"><B>Show :</B></td>
										<td class="td">
											<asp:RadioButtonList id="rdoDisplay" runat="server" Width="20%" CssClass="select">
												<asp:ListItem Value="Both" Selected="True">Both</asp:ListItem>
												<asp:ListItem Value="Graph">Graph</asp:ListItem>
												<asp:ListItem Value="Table">Table</asp:ListItem>
											</asp:RadioButtonList>
										</td>
										<td class="td" align="right"><B>Show As :</B></td>
										<td class="td">
											<asp:RadioButtonList id="rdoCumulative" runat="server" Width="20%" CssClass="select">
												<asp:ListItem Value="True" Selected="True">Cumulative</asp:ListItem>
												<asp:ListItem Value="False">By Month</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr>
										<td colspan="6" align="center"><asp:button class="button" id="btnGenerate" runat="server" name="btnGenerate" Text="Generate Report"></asp:button></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<TR>
				<td colspan="4">
					<table align="center" width="100%" border="0" id="tblButtons" runat="server">
						<tr>
							<td class="td" align="right" colSpan="4">
								<IMG id="Printbtn" onclick="printSpecial(this,'<%=Request.ApplicationPath%>')" height="16" alt="Print Report" src="../Images/print.gif"
										width="16" style="CURSOR:pointer">
								<asp:imagebutton id="imgExport" style="CURSOR: pointer" Height="16" Width="16" ImageUrl="../Images/excel.gif"
									AlternateText="Export Report to Excel" runat="server"></asp:imagebutton></td>
						</tr>
					</table>
					<div id="divReport" runat="server">
						<table class="t4" style="WIDTH: 100%; align: center" align="center" width="100%">
							<TR>
								<TH class="th">
									Project Status Summary<SUP>#</SUP></TH></TR>
							<TR>
								<TD>
									<TABLE width="100%" border="0">
										<TR>
											<TD class="td" align="right">Project Duration :</TD>
											<TD class="td" align="center">
												<asp:textbox class="InputRO" id="txtProjStart" runat="server" name="txtProjStart" ReadOnly="True"></asp:textbox></TD>
											<TD class="td" align="center">to</TD>
											<TD class="td" align="center">
												<asp:textbox class="InputRO" id="txtProjEnd" runat="server" name="txtProjEnd" ReadOnly="True"></asp:textbox></TD>
										</TR>
										<TR>
											<TD>&nbsp;</TD>
											<TD class="labelbold" align="center">Budget</TD>
											<TD class="labelbold" align="center">To Date*
											</TD>
											<TD class="labelbold" align="center">This Period*</TD>
										</TR>
										<TR>
											<TD class="td" align="right">Budget :</TD>
											<TD class="td" align="center">
												<asp:textbox class="InputRO" id="txtBudget" runat="server" name="txtBudget" ReadOnly="True"></asp:textbox></TD>
											<TD class="td" align="center">
												<asp:textbox class="InputRO" id="txtToDateCost" runat="server" name="txtToDateCost" ReadOnly="True"></asp:textbox></TD>
											<TD class="td" align="center">
												<asp:textbox class="InputRO" id="txtPeriodCost" runat="server" name="txtPeriodCost" ReadOnly="True"></asp:textbox></TD>
										</TR>
										<TR>
											<TD class="td" align="right">Hours :</TD>
											<TD class="td" align="center">
												<asp:textbox class="InputRO" id="txtBudgetHrs" runat="server" name="txtBudgetHrs" ReadOnly="True"></asp:textbox></TD>
											<TD class="td" align="center">
												<asp:textbox class="InputRO" id="txtToDateHrs" runat="server" name="txtToDateHrs" ReadOnly="True"></asp:textbox></TD>
											<TD class="td" align="center">
												<asp:textbox class="InputRO" id="txtPeriodHrs" runat="server" name="txtPeriodHrs" ReadOnly="True"></asp:textbox></TD>
										</TR>
										<TR>
											<TD class="td3" vAlign="top" colSpan="4">
												<DIV id="divChart" runat="server">
													<TABLE class="t1" width="100%" align="center">
														<TR>
															<TD class="td2">
																<im:IMChart id="IMLineChart" runat="server" ChartType="Line"></im:IMChart></TD>
														</TR>
													</TABLE>
												</DIV>
											</TD>
										</TR>
										<TR>
											<TD class="td3" vAlign="top" colSpan="4">
												<DIV id="divTable" runat="server">
													<TABLE class="t1" width="100%" align="center">
														<TR>
															<TD class="td2">
																<asp:datagrid id="dgTable" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="True">
																	<HeaderStyle CssClass="grid-header"></HeaderStyle>
																	<ItemStyle CssClass="grid-trigalt1" Width="20%"></ItemStyle>
																	<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
																	<Columns>
																		<asp:BoundColumn DataField="Month" ItemStyle-Wrap="False" HeaderText="Month"></asp:BoundColumn>
																		<asp:BoundColumn DataField="Budget" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderText="Planned"></asp:BoundColumn>
																		<asp:BoundColumn DataField="TimeCost" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderText="Actual"></asp:BoundColumn>
																		<asp:BoundColumn DataField="ExpCost" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderText="Expenses"></asp:BoundColumn>
																		<asp:BoundColumn DataField="TotCost" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="False" HeaderText="Total"></asp:BoundColumn>
																	</Columns>
																</asp:datagrid><br>
																* - Excludes Expenses<br>
																# - This report is generated for approved time only
															</TD>
														</TR>
													</TABLE>
												</DIV>
											</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
						</table>
					</div>
				</td>
			</TR>
		</table>
		<im:Footer id="Footer2" runat="server"></im:Footer>
	</form>
</body>
