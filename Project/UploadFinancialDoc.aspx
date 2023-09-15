<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UploadFinancialDoc.aspx.vb" Inherits="TimeTrax.UploadFinancialDoc"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Upload Financial Document</title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
		<LINK href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
		<script language="javascript" src="<%=Request.ApplicationPath%>/Components/Scripts/Validation.js"></script>
		<script language="javascript" src="<%=Request.ApplicationPath%>/Components/Scripts/IMCalendar.js"></script>
		<script language="JavaScript" src="<%=Request.ApplicationPath%>/Components/Scripts/uploadObject.js"></script>
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
		// This function calculates the Total for the budget items
		function createFinDocTitle() {										
			document.Form1.txtTitle.value = document.Form1.txtOrderNo.value + '_' + document.Form1.txtNo.value;		
		}
	    // This function calculates the Total for the budget items
		function calcBudgetTotal() {
			var totalBudget;
			var budget;
			var arrlist = document.Form1['hidBudgetList'].value;
			var arrlen=0;
			arrlist = arrlist.split("#");
			arrlen = arrlist.length;
			
			totalBudget = 0;
									
			for (var k=0; k<=arrlen - 1; k++)
			{ 		
				budget = document.Form1['txtBud'+arrlist[k]].value;
				// Calculate Total Budget
				if (budget > 0)
				{ 		
					totalBudget = parseFloat(totalBudget) +	parseFloat(budget);
				}		
			}									
			document.Form1.txtTotalBudget.value = totalBudget.toFixed(2);		
		}
		// This function validates that at least one budget item is captured
		function validateBudgetItem() {
			var hasBudget;
			var budget;
			var arrlist = document.Form1['hidBudgetList'].value;
			var arrlen=0;
			arrlist = arrlist.split("#");
			arrlen = arrlist.length;
			
			hasBudget = 0;
									
			for (var k=0; k<=arrlen - 1; k++)
			{ 		
				budget = document.Form1['txtBud'+arrlist[k]].value;
				// Calculate Total Budget
				if (budget > 0)
				{ 		
					hasBudget = 1;
					break;
				}		
			}	
											
			if (hasBudget == 0)
			{
				alert('Please enter at least one Budget Item');
			}
			else
			{
				document.Form1.btnSubmit.click();
			}
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
						<span>Financial Document Upload</span>
					</th>
				</TR>
				<tr>
					<td><br>
						<div id="tblwizard1" runat="server">
							<table cellSpacing="0" cellPadding="0" width="90%" align="center" border="0" height="95%">
								<TR>
									<th class="th1" colSpan="2">
										<div align="center"><label id="lblTitle" runat="server"></label>
											Details</div>
									</th>
								</TR>
								<TR>
									<TD class="td">Order Number:</TD>
									<TD class="td"><asp:textbox id="txtOrderNo" runat="server" CssClass="inputRO" Width="100" ReadOnly="True"></asp:textbox></TD>
								</TR>
								<TR>
									<TD class="td"><label id="lblNo" runat="server"></label>
										Number:<FONT color="#ff0066">*</FONT></TD>
									<TD class="td"><asp:textbox id="txtNo" runat="server" CssClass="input" Width="100" onblur="createFinDocTitle();"></asp:textbox>
										<asp:requiredfieldvalidator id="rfvNumber" Runat="Server" ControlToValidate="txtNo" Display="None" ErrorMessage="Please enter a Financial Document Number"></asp:requiredfieldvalidator></TD>
								</TR>
								<TR>
									<TD class="td"><label id="lblDate" runat="server"></label>
										Date:<FONT color="#ff0066">*</FONT></TD>
									<TD class="td"><asp:textbox id="txtDate" runat="server" CssClass="input" Width="100" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"></asp:textbox>
										<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
										<div id="divDate" style="POSITION: absolute"></div>
										<IMG id="Date" style="CURSOR: hand" onclick="imcalendar.select(document.Form1.txtDate, 'divDate', 'dd/MM/yyyy'); return false;"
											src="../images/CALENDAR.GIF" border="0" name="Date" runat="server">
										<asp:requiredfieldvalidator id="rfvDate" Runat="Server" ControlToValidate="txtDate" Display="None" ErrorMessage="Please enter a Financial Document Date"></asp:requiredfieldvalidator></TD>
								</TR>
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
									<TD class="td" width="30%">Select the document to upload in PDF format:<FONT color="#ff0066">*</FONT></TD>
									<TD class="td" width="70%">
										<input class="input" id="txtUpload" type="file" name="txtUpload" runat="server" style="WIDTH:100%">
										<asp:requiredfieldvalidator id="rfvUpload" Runat="Server" ControlToValidate="txtUpload" Display="None" ErrorMessage="Please enter a file to upload."></asp:requiredfieldvalidator>
									</TD>
								</TR>
								<TR>
									<TD class="td">Document Title:</TD>
									<TD class="td"><asp:textbox id="txtTitle" runat="server" CssClass="inputRO" Width="100%" ReadOnly="True"></asp:textbox></TD>
								</TR>
								<tr>
									<td class="td" colSpan="2" align="center"><br>
										<FONT color="#ff0066">*</FONT> Mandatory fields<br>
									</td>
								</tr>
								<TR>
									<TD class="td" width="100%" colSpan="2">
										<div align="center"><B>Note:</B> Choose a PDF document to be uploaded. Please note 
											that the document should be less than 2Mb.<br>
											Please make sure that you check the file size before uploading.<br>
											(This can be done by right-clicking on the file and choosing properties)<br>
										</div>
									</TD>
								</TR>
								<tr>
									<td class="td" colSpan="2"><div align="center"><br>
											<asp:button id="btnSubmit" CssClass="inputhidden" Runat="server" Text="Submit"></asp:button>
											<input class="button" runat="server" id="btnUpload" onclick="validateBudgetItem();" type="button"
												value="Upload Document">
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
						<input type="hidden" id="hidError" name="hidError" runat="server" value="1"> <input type="hidden" id="hidProjectID" name="hidError" runat="server">
						<input type="hidden" id="hidFinDoc" name="hidError" runat="server" value="1"> <input type="hidden" id="hidFinDocID" name="hidError" runat="server">
						<input type="hidden" id="hidBudgetList" name="hidBudgetList" runat="server"> <input type="hidden" id="hidAmount" name="hidAmount" runat="server">
						<input type="hidden" id="hidApprovalRequired" name="hidApprovalRequired" runat="server">
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
