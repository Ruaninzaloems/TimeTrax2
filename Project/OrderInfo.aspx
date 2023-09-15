<%@ Register TagPrefix="im" TagName="Orders" Src="../Components/User Controls/Orders.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="OrderInfo.aspx.vb" Inherits="TimeTrax.OrderInfo"%>
<%@ Register TagPrefix="uc2" TagName="FinancialDocuments" Src="../Components/User Controls/FinancialDocuments.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Order Info Page</title>
		<LINK href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
		<META content="text/html; charset=windows-1252" http-equiv="Content-Type">
		<script language="javascript" src="<%=Request.ApplicationPath%>\Components\Scripts\Common.js" ></script>
		<script language="javascript" src="<%=Request.ApplicationPath%>\Components\Scripts\DynamicAdd.js" ></script>
		<script language="javascript" src="<%=Request.ApplicationPath%>\Components\Scripts\Validation.js" ></script>
		<script language="javascript" src="<%=Request.ApplicationPath%>\Components\Scripts\Orders.js" ></script>
		<script language='javascript' src="<%=Request.ApplicationPath%>\Components\Scripts\IMCalendar.js"></script>	
		<script language="javascript" src="<%=Request.ApplicationPath%>\Components\Scripts\Details.js" ></script>	
		<script language="javascript">
	function closeWin()
		{
			// Cancel button clicked
			window.close();
		}
		</script>
		<!--START C A L E N D A R   C O N T R O L Include this to use the calendar-->
		<SCRIPT language="JavaScript">
			//This is needed for the Calendar styles
			document.write(CalendarPopup_getStyles());
			//To use a Pop-Up window, leave the parameter blank, otherwise put in dynamic
			var imcalendar = new CalendarPopup("dynamic");
			imcalendar.showYearNavigation();
		</SCRIPT>
		<!--END C A L E N D A R   C O N T R O L-->
	</HEAD>
	<body onload="LoadOrderDynamics();">
		<form id="Form1" method="post" runat="server">
			<input type="hidden" id="ucHeader_hidAppPath" name="ucHeader_hidAppPath" runat="server">
			<table class="t4" align="center" border="0" width="100%">
				<tr>
					<th class="th">
						Order Information</th>
				</tr>
				<tr>
					<td>
						<!-- This is going to be Orders User Control -->
						<im:Orders id="ucOrders" runat="server"></im:Orders>
						<!-- End of Orders User Control -->
					</td>
				</tr>
				<tr>
					<td>
				<span runat="server" id="spnFinancialDocuments">
						<uc2:FinancialDocuments id="ucFinancialDocuments" runat="server"></uc2:FinancialDocuments></UC2:FINANCIALDOCUMENTS>
					</span>
					</td>
				</tr>
				<tr>
					<td align="center">
						<asp:Button ID="btnSubmit" Runat="server" Text="Update" Visible="False" CssClass="button"></asp:Button>
						<INPUT type="button" id="btnClose" onclick="closeWin();" class="button" value="Close">
						<asp:validationsummary id="ValidationSummary1" style="Z-INDEX: 103; LEFT: 16px" runat="server" ShowSummary="False"
							ShowMessageBox="True"></asp:validationsummary>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
