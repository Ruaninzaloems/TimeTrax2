<%@ Register TagPrefix="uc1" TagName="ReportFilters" Src="../Components/User Controls/ReportFilters.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Expenses.aspx.vb" Inherits="TimeTrax.Expenses"%>
<%@ Register TagPrefix="uc1" TagName="ExpensesReport" Src="../Components/User Controls/ExpensesReport.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<SCRIPT language="JavaScript" src="<%=Request.ApplicationPath%>/Components/Scripts/ReportFilters.js"></SCRIPT>
<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/imcalendar.js"></script>
<body onload="initFilters();">
	<im:header id="ucHeader" runat="server"></im:header>
	<!--START C A L E N D A R   C O N T R O L Include this to use the calendar-->
	<SCRIPT language="JavaScript">
			//This is needed for the Calendar styles
			document.write(CalendarPopup_getStyles());
			//To use a Pop-Up window, leave the parameter blank, otherwise put in dynamic
			var imcalendar = new CalendarPopup("dynamic");
			imcalendar.showYearNavigation();
	</SCRIPT>
	<!--END C A L E N D A R   C O N T R O L-->
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t3" width="100%">
			<tr>
				<td><uc1:ReportFilters id="ucReportFilters" runat="server"></uc1:ReportFilters>
				</td>
			</tr>
			<tr>
				<td>
					<div id="divReport" runat="server">
						<uc1:ExpensesReport id="ucExpensesReport" runat="server"></uc1:ExpensesReport>
					</div>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer>
	</form>
</body>
