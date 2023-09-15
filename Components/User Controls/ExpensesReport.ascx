<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ExpensesReport.ascx.vb" Inherits="TimeTrax.ExpensesReport" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<div id="divReportExcel" runat="server">
	<table class="t4" style="WIDTH:100%; align:center">
		<tr>
			<td class="td" align="right">
				<INPUT type="hidden" id="txtHidAppPath" CssClass="inputhidden" runat="server"> <IMG id="imgPrinterPopup" onclick="window.print();" alt="Print Report" src="../../Images/print.gif"
					style="WIDTH:16px; CURSOR:pointer; HEIGHT:16px" runat="server"> <IMG id="Printbtn" onclick="printSpecial(this,document.all['ucExpensesReport_txtHidAppPath'].value)"
					alt="Print Report" src="../../Images/print.gif" runat="server" style="WIDTH:16px; CURSOR:pointer; HEIGHT:16px">
				<asp:imagebutton id="imgExport" runat="server" ImageUrl="../../Images/excel.gif" AlternateText="Export Report to Excel"
					style="CURSOR:pointer" Width="16" Height="16"></asp:imagebutton>
			</td>
		</tr>
		<TR>
			<th class="th">
				Expenses</th></TR>
		<tr>
			<td>
				<table width="100%" border="0">
					<tr>
						<td><asp:placeholder id="ReportPlace" runat="server"></asp:placeholder>
							<input id="hidUserReportType" type="hidden" name="hidUserReportType" runat="server">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
