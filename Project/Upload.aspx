<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Upload.aspx.vb" Inherits="TimeTrax.Upload"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Upload Purchase Order</title>
		<LINK href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
		<script language="javascript" src="<%=Request.ApplicationPath%>/Components/Scripts/Validation.js"></script>
		<script language="javascript" src="<%=Request.ApplicationPath%>/Components/Scripts/IMCalendar.js"></script>
		<script language="JavaScript" src="<%=Request.ApplicationPath%>/Components/Scripts/uploadObject.js"></script>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
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
						<span>Project Purchase Order Upload</span>
					</th>
				</TR>
				<tr>
					<td><br>
						<div id="tblwizard1" runat="server">
							<table cellSpacing="0" cellPadding="0" width="90%" align="center" border="0" height="95%">
								<TR>
									<th class="th1" colSpan="2">
										<div align="center">PLEASE NOTE</div>
									</th>
								</TR>
								<TR>
									<TD class="td" width="100%" colSpan="2">
										<div align="center">Choose a document to be uploaded. Please note that the document 
											should be less than 2Mb.<br>
											Please make sure that you check the file size before uploading.<br>
											(This can be done by right-clicking on the file and choosing properties)<br>
										</div>
									</TD>
								</TR>
								<TR>
									<TD class="td">Date of document:<FONT color="#ff0066">*</FONT></TD>
									<TD class="td"><asp:textbox id="txtDate" runat="server" CssClass="input" Width="100" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"></asp:textbox>
										<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
										<div id="divDate" style="POSITION: absolute"></div>
										<IMG id="Date" style="CURSOR: hand" onclick="imcalendar.select(document.Form1.txtDate, 'divDate', 'dd/MM/yyyy'); return false;"
											src="../images/CALENDAR.GIF" border="0" name="Date" runat="server">
										<asp:requiredfieldvalidator id="rfvDate" Runat="Server" ControlToValidate="txtDate" Display="None" ErrorMessage="Please enter a document date"></asp:requiredfieldvalidator></TD>
								</TR>
								<TR>
									<TD class="td">Document title:<FONT color="#ff0066">*</FONT></TD>
									<TD class="td">
										<asp:textbox id="txtTitle" runat="server" Width="100%" CssClass="input"></asp:textbox><asp:requiredfieldvalidator id="rfvTitle" Runat="Server" ControlToValidate="txtTitle" Display="None" ErrorMessage="Please enter a document title."></asp:requiredfieldvalidator></TD>
								</TR>
								<TR>
									<TD class="td">Author:</TD>
									<TD class="td"><asp:textbox id="txtWho" runat="server" CssClass="input" Width="320px"></asp:textbox></TD>
								</TR>
								<TR>
									<TD class="td" width="30%">Select the document to upload:<FONT color="#ff0066">*</FONT></TD>
									<TD class="td" width="70%">
										<input class="input" id="txtUpload" type="file" name="txtUpload" runat="server" style="WIDTH:100%">
										<asp:requiredfieldvalidator id="rfvUpload" Runat="Server" ControlToValidate="txtUpload" Display="None" ErrorMessage="Please enter a file to upload."></asp:requiredfieldvalidator>
									</TD>
								</TR>
								<tr>
									<td class="td" colSpan="2" align="center"><br>
										<FONT color="#ff0066">*</FONT> Mandatory fields<br>
									</td>
								</tr>
								<tr>
									<td class="td" colSpan="2"><div align="center"><br>
											<asp:button id="btnSubmit" runat="server" Text="Upload Document" CssClass="button"></asp:button>
											<asp:ValidationSummary id="Validationsummary1" runat="server" ShowMessageBox="True" ShowSummary="False"></asp:ValidationSummary><br>
										</div>
									</td>
								</tr>
							</table>
						</div>
						<div id="tblwizard2" runat="server">
							<table align="center" width="500" border="0">
								<tr>
									<td class="td" align="center">
										<asp:label id="lblResults" runat="server"></asp:label>
									</td>
								</tr>
								<tr>
									<td class="td" align="center">
										<input type="button" value="Close Window" class="button" onclick="window.close();">
									</td>
								</tr>
							</table>
						</div>
						<input type="hidden" id="hidAppPath" name="hidAppPath" runat="server"> <input type="hidden" id="hidDate" name="hidDate" runat="server">
						<input type="hidden" id="hidTitle" name="hidTitle" runat="server"> <input type="hidden" id="hidSize" name="hidSize" runat="server">
						<input type="hidden" id="hidFileName" name="hidFileName" runat="server"> <input type="hidden" id="hidUploadsPath" name="hidUploadsPath" runat="server">
						<input type="hidden" id="hidError" name="hidError" runat="server" value=1>
						<input type="hidden" id="hidFinDoc" name="hidError" runat="server" value="0">
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
