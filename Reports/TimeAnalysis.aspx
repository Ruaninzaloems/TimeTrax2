<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TimeAnalysis.aspx.vb" Inherits="TimeTrax.TimeAnalysis" %>
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
							<td class="td">Period:</td>
							<td class="td"><im:IMTextBox id="txtStartDate" CssClass="input" Width="100" runat="server" TextType="Date" RequiredValidationError="Please enter a Period Start Date"></im:IMTextBox>
							</td>
							<td class="td" align="center">to</td>
							<td class="td"><im:IMTextBox id="txtEndDate" CssClass="input" Width="100" runat="server" TextType="Date" RequiredValidationError="Please enter a Period End Date"></im:IMTextBox>
							</td>
						</tr>
						<tr>
							<td class="td" align="center" colSpan="4">
								<table width="100%">
									<tr>
										<td class="td" vAlign="top" width="20%">Project:
											<select class="select" id="lstTaskType" style="WIDTH: 100%" multiple size="2" name="lstTaskTypes"
												runat="server">
												<option value="1">Billable</option>
												<option value="0">Non Billable</option>
											</select>
										</td>
										<td class="td" vAlign="top" width="30%">Time Off:<br>
											<asp:listbox id="lstTOTypes" CssClass="select" DataValueField="TypeID" DataTextField="TypeName"
												Rows="5" SelectionMode="Multiple" Runat="server"></asp:listbox></td>
										<td class="td" vAlign="top" width="20%">Show As:
											<asp:radiobuttonlist id="rdoOutput" runat="server" CssClass="select" Width="100%">
												<asp:ListItem Value="Daily" Selected="True">Daily</asp:ListItem>
												<asp:ListItem Value="Weekly">Weekly</asp:ListItem>
											</asp:radiobuttonlist></td>
									</tr>
									<tr>
										<td class="td" vAlign="top" align="left">Capture Type:
											<select class="select" id="lstCaptureType" style="WIDTH: 100%" multiple size="2" name="lstCaptureTypes"
												runat="server">
												<option value="1">Approved</option>
												<option value="0">Not Approved</option>
											</select>
										<td class="td" vAlign="top" width="30%">Users:
											<asp:listbox id="lstUsers" CssClass="select" Width="100%" DataValueField="UserID" DataTextField="UserName"
												Rows="5" SelectionMode="Multiple" Runat="server"></asp:listbox></td>
									</tr>
									<tr>
										<td align="center" colSpan="4"><asp:button id="btnGenerate" runat="server" CssClass="button" Text="Generate Report" name="btnGenerate"></asp:button></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table class="t4" style="WIDTH: 100%; align: center">
						<tr>
							<td class="td" align="right">
								<IMG id="Printbtn" onclick="printSpecial(this,'<%=Request.ApplicationPath%>')" alt="Print Report" src="../Images/print.gif"
										style="WIDTH:16px; CURSOR:pointer; HEIGHT:16px" >
							</td>
						</tr>
						<tr>
							<th class="th">
								Time Analysis Report
							</th>
						</tr>
						<tr>
							<td class="td3" vAlign="top">
								<div id="divReport" style="DISPLAY: none" runat="server">
									<table class="t1" width="100%" align="center">
										<tr>
											<td class="td2">
												<im:IMChart id="IMLineChart" runat="server" ChartType="Line" appletHeight="400px" EnableViewState="False"></im:IMChart></td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer></form>
</body>
