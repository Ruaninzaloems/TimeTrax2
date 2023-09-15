<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="ReportFilters" Src="../Components/User Controls/ReportFilters.ascx" %>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DataExtract.aspx.vb" Inherits="TimeTrax.DataExtract"%>
<body onload="initFilters();">
	<im:header id="ucHeader" runat="server"></im:header>
	<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
	<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/imcalendar.js"></script>
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
				<td><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td><uc1:ReportFilters id="ucReportFilters" runat="server"></uc1:ReportFilters>
				</td>
			</tr>
			<tr>
				<td vAlign="top" class="td3">
					<div id="divReport" runat="server">
						<table class="t4" align="center" width="100%">
							<tr>
								<td class="td">
									<asp:datagrid id="dgResult" runat="server" Width="100%">
										<HeaderStyle CssClass="grid-header"></HeaderStyle>
										<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
										<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
									</asp:datagrid>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer>
	</form>
</body>
