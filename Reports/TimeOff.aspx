<%@ Register TagPrefix="uc1" TagName="ReportFilters" Src="../Components/User Controls/ReportFilters.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TimeOff.aspx.vb" Inherits="TimeTrax.TimeOff"%>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<body>
	<im:header id="ucHeader" runat="server"></im:header>
	<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t3" width="100%">
			<tr>
				<td>
					<table class="t4" width="100%" align="center">
						<tr>
							<th class="th" colspan="4">
								Report Filters</th></tr>
						<tr>
							<td class="td" align="right" width="25%" height="69">Start :</td>
							<td width="25%" height="69"><im:IMTextBox id="txtStartDate" cssclass="input"  Width="100" runat="server" TextType="Date" RequiredValidationError="Please enter a Start date"></im:IMTextBox></td>
							<td class="td" align="right" width="25%" height="69">End :</td>
							<td width="25%" height="69"><im:IMTextBox id="txtEndDate" cssclass="input" Width="100" runat="server" TextType="Date" RequiredValidationError="Please enter an End date"></im:IMTextBox></td>
						</tr>
						<TR>
							<td class="td" valign="top" align="right" width="20%">Select Users :</td>
							<td class="td" width="30%">
								<P><asp:listbox id="lstUsers" DataTextField="UserName" DataValueField="UserID" CssClass="select"
										Width="90%" name="_lstUsers" Rows="9" SelectionMode="Multiple" Runat="server" Height="120px"></asp:listbox></P>
							</td>
						</TR>
						<TR>
							<td align="center" colspan="4">
								<asp:button CssClass="button" id="btnGenerate" runat="server" name="btnGenerate" Text="Generate Report"></asp:button>
							</td>
						</TR>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<div id="divReport" runat="server">
						<table class="t4" style="WIDTH:100%; align:center">
							<tr>
								<td class="td" align="right">
									<IMG id="Printbtn" onclick="printSpecial(this,'<%=Request.ApplicationPath%>')" alt="Print Report" src="../Images/print.gif"
										style="WIDTH:16px; CURSOR:pointer; HEIGHT:16px">
									<asp:imagebutton id="imgExport" runat="server" ImageUrl="../Images/excel.gif" AlternateText="Export Report to Excel"
										style="CURSOR:pointer" Width="16" Height="16"></asp:imagebutton>
								</td>
							</tr>
							<tr>
								<th class="th">
									TimeOff Report<sup>#</sup></th>
							</tr>
							<tr>
								<td><asp:placeholder id="ReportPlace" runat="server"></asp:placeholder></td>
							</tr>
							<tr>
							<td class="td"># - Approved TimeOff only</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
