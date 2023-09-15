<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ProjectSummary.ascx.vb" Inherits="TimeTrax.ProjectSummary" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table class="t4" style="WIDTH: 100%; align: center">
	<tr>
		<td class="td" align="right" colSpan="4"><IMG id="imgPrinterPopup" style="WIDTH: 16px; CURSOR: pointer; HEIGHT: 16px" onclick="window.print();"
				alt="Print Report" src="../../Images/print.gif" runat="server"> <INPUT id="txtHidAppPath" type="hidden" name="txtHidAppPath" runat="server" CssClass="inputhidden">
			<IMG id="Printbtn" style="WIDTH: 16px; CURSOR: pointer; HEIGHT: 16px" onclick="printSpecial(this,document.all['ucProjectSummary_txtHidAppPath'].value)"
				alt="Print Report" src="../../Images/print.gif" runat="server">
			<asp:imagebutton id="imgExport" style="CURSOR: pointer" runat="server" AlternateText="Export Report to Excel"
				ImageUrl="../../Images/excel.gif" Width="16" Height="16"></asp:imagebutton></td>
	</tr>
	<tr>
		<th class="th">
			Project Cost Summary<SUP>#</SUP></th></tr>
	<tr>
		<td>
			<table width="100%" border="0">
				<div id="divFilterDetails" runat="server"></div>
				<tr>
					<td class="td" align="right" width="25%">Project :</td>
					<td class="td" width="75%" colSpan="3"><asp:textbox class="InputRO" id="txtProjectName" runat="server" Width="100%" name="txtProjectName"
							ReadOnly="True"></asp:textbox></td>
				</tr>
				<tr>
					<td class="td" align="right" width="25%">Period :</td>
					<td class="td" align="left" width="25%"><asp:textbox class="InputRO" id="txtPeriodStart" runat="server" Width="100%" name="txtPeriodStart"
							ReadOnly="True"></asp:textbox></td>
					<td class="td" align="center" width="25%">to</td>
					<td class="td" align="left" width="25%"><asp:textbox class="InputRO" id="txtPeriodEnd" runat="server" Width="100%" name="txtPeriodEnd"
							ReadOnly="True"></asp:textbox></td>
				</tr>
				<DIV></DIV>
				<tr>
					<td class="td" align="right">Project Duration :</td>
					<td class="td" align="left"><asp:textbox class="InputRO" id="txtProjStart" runat="server" Width="100%" name="txtProjStart"
							ReadOnly="True"></asp:textbox></td>
					<td class="td" align="center">to</td>
					<td class="td" align="left"><asp:textbox class="InputRO" id="txtProjEnd" runat="server" Width="100%" name="txtProjEnd" ReadOnly="True"></asp:textbox></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td class="labelbold" align="center">Budget</td>
					<td class="labelbold" align="center">To Date*</td>
					<td class="labelbold" align="center">Expected*</td>
				</tr>
				<tr>
					<td class="td" align="right">Budget :</td>
					<td class="td" align="left"><asp:textbox class="InputROR" id="txtBudget" runat="server" Width="100%" name="txtBudget" ReadOnly="True"></asp:textbox></td>
					<td class="td" align="center"><asp:textbox class="InputROR" id="txtToDateCost" runat="server" Width="100%" name="txtToDateCost"
							ReadOnly="True"></asp:textbox></td>
					<td class="td" align="left"><asp:textbox class="InputROR" id="txtExpectedCost" runat="server" Width="100%" name="txtExpectedCost"
							ReadOnly="True"></asp:textbox></td>
				</tr>
				<tr>
					<td class="td" align="right">Hours :</td>
					<td class="td" align="left"><asp:textbox class="InputROR" id="txtBudgetHrs" runat="server" Width="100%" name="txtBudgetHrs"
							ReadOnly="True"></asp:textbox></td>
					<td class="td" align="center"><asp:textbox class="InputROR" id="txtToDateHrs" runat="server" Width="100%" name="txtToDateHrs"
							ReadOnly="True"></asp:textbox></td>
					<td class="td" align="left"><asp:textbox class="InputROR" id="txtExpectedHours" runat="server" Width="100%" name="txtExpectedHours"
							ReadOnly="True"></asp:textbox></td>
				</tr>
				<tr>
					<td colSpan="4"><asp:placeholder id="ReportPlace" runat="server"></asp:placeholder></td>
				</tr>
				<tr>
					<td class="td" colSpan="4">* - Excludes Expenses<br>
						# - This report is generated for approved time only</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
