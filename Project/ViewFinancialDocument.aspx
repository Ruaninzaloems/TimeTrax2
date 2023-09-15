<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ViewFinancialDocument.aspx.vb" Inherits="TimeTrax.ViewFinancialDocument"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>View Financial Document Details</title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
		<LINK href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
		<script language="javascript">
	function closeAdd()
		{
			opener.document.Form1.ddlClient.disabled = true;
			window.close();
		}
	function closeWin()
		{
			opener.document.Form1.ddlClient[0].selected = true;
			window.close();
		}
		</script>
	</HEAD>
	<body>
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
			<table class="t4" align="center" border="0">
				<TR>
					<th class="th" align="center">
						<span>Financial Document Detail</span>
					</th>
				</TR>
				<tr>
					<td><br>
						<div id="tblwizard1" runat="server">
							<table cellSpacing="0" cellPadding="0" width="90%" align="center" border="0" height="95%">
								<TR>
									<th class="th1" colSpan="2">
										<div align="center"><label id="lblTitle" runat="server"></label> Details</div>
									</th>
								</TR>
								<TR>
									<TD class="td">Order Number:</TD>
									<TD class="td"><asp:textbox id="txtOrderNo" runat="server" CssClass="inputRO" Width="100" ReadOnly="True"></asp:textbox></TD>
								</TR>
								<TR>
									<TD class="td"><label id="lblNo" runat="server"></label> Number:</TD>
									<TD class="td"><asp:textbox id="txtNo" runat="server" CssClass="inputRO" Width="100"></asp:textbox>
										<asp:requiredfieldvalidator id="rfvNumber" Runat="Server" ControlToValidate="txtNo" Display="None" ErrorMessage="Please enter a Financial Document Number"></asp:requiredfieldvalidator></TD>
								</TR>
								<TR>
									<TD class="td"><label id="lblDate" runat="server"></label> Date:</TD>
									<TD class="td"><asp:textbox id="txtDate" runat="server" CssClass="input" Width="100"></asp:textbox></TD>
								<tr>
									<td colspan="2">
										<TABLE id="tblbudgetsummary" width="100%" name="tblbudgetsummary" class="t1">
											<tr>
												<td>
													<asp:placeholder id="plcBudgetSummary" Runat="server"></asp:placeholder>
												</td>
											</tr>
										</TABLE>
									</td>
								</tr>
								<TR>
									<TD class="td">Document Title:</TD>
									<TD class="td"><asp:textbox id="txtTitle" runat="server" CssClass="inputRO" Width="100%" ReadOnly="True"></asp:textbox></TD>
								</TR>
								<tr>
									<td class="td" colSpan="2"><div align="center"><br>
											<input type="button" value="Close Window" class="button" onclick="window.close();">
										</div>
									</td>
								</tr>
							</table>
						</div>
						<input type="hidden" id="hidTitle" name="hidTitle" runat="server"> <input type="hidden" id="hidSize" name="hidSize" runat="server">
						<input type="hidden" id="hidFileName" name="hidFileName" runat="server"> <input type="hidden" id="hidUploadsPath" name="hidUploadsPath" runat="server">
						<input type="hidden" id="hidError" name="hidError" runat="server" value="1">
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
