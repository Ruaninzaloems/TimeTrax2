<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TimesheetStatus.aspx.vb" Inherits="TimeTrax.TimesheetStatus"%>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<body>
	<form id="Form1" method="post" runat="server">
		<im:header id="ucHeader" runat="server"></im:header>
		<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t3" width="100%">
			<tr>
				<td>
					<table class="t4" width="100%">
						<tr>
							<th class="th" colSpan="4">
								Report Filters
							</th>
						</tr>
						<tr>
							<td class="td">Period :</td>
							<td class="td"><IM:IMTEXTBOX id="txtStartDate" runat="server" CssClass="input" Width="100" RequiredValidationError="Please enter a Period Start Date"
									TextType="Date"></IM:IMTEXTBOX></td>
							<td class="td" align="center">to</td>
							<td class="td"><im:imtextbox id="txtEndDate" runat="server" CssClass="input" Width="100" RequiredValidationError="Please enter a Period End Date"
									TextType="Date"></im:imtextbox></td>
						</tr>
						<tr>
							<td class="td" align="center" colSpan="4">
								<table width="100%">
									<tr>
										<td class="td" align="center">Approval Status:</td>
									</tr>
									<tr>
										<td class="td" vAlign="top" align="center"><select class="select" id="lstStatus" multiple size="4" name="lstTaskTypes" runat="server">
												<option value="1">Not Submitted</option>
												<option value="3">Waiting Approval</option>
												<option value="2">Approved</option>
												<option value="4">Rejected</option>
											</select>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="center" colSpan="4"><asp:button id="btnGenerate" runat="server" CssClass="button" Text="Generate Report" name="btnGenerate"></asp:button></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colSpan="4">
					<table border="0" runat="server" style="WIDTH: 100%; align: center">
						<tr>
							<td class="td" align="right"><IMG id=Printbtn onclick="printSpecial(this,'<%=Request.ApplicationPath%>')" alt="Print Report" src="../Images/print.gif" style="WIDTH:16px; CURSOR:pointer; HEIGHT:16px"  >
								<asp:imagebutton id="imgExport" style="CURSOR: pointer" runat="server" Width="16" AlternateText="Export Report to Excel"
									ImageUrl="../Images/excel.gif" Height="16"></asp:imagebutton></td>
						</tr>
					</table>
					<div id="divReport" style="DISPLAY: none" runat="server">
						<table class="t4" style="WIDTH: 100%; align: center">
							<tr>
								<th class="th">
									Timesheet Status Report
								</th>
							</tr>
							<tr>
								<td class="td2"><asp:datagrid id="dgReport" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="True">
										<HeaderStyle CssClass="grid-header"></HeaderStyle>
										<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
										<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
										<Columns>
											<asp:BoundColumn DataField="Period" HeaderText="Period" ItemStyle-Width="25%"></asp:BoundColumn>
											<asp:BoundColumn DataField="User" HeaderText="User" ItemStyle-Width="50%"></asp:BoundColumn>
											<asp:BoundColumn DataField="Status" HeaderText="Status" ItemStyle-Width="25%"></asp:BoundColumn>
										</Columns>
									</asp:datagrid></td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
