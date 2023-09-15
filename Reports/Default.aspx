<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Default.aspx.vb" Inherits="TimeTrax._Default1"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="RepSelections" Src="../Components/User Controls/Selections.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<body onload="init();">
	<im:header id="ucHeader" runat="server"></im:header>
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="top">
					<table class="t4a" cellSpacing="0" cellPadding="5" width="98%" align="center" border="0">
						<tr>
							<th class="th">
								Report Filters</th></tr>
						<tr>
							<td><im:repselections id="ucRepSelections" runat="server"></im:repselections>
								<!--								<asp:xml id="Xmlresult" runat="server" TransformSource="/TimeTrax/Components/XSL/Rep_Default.xsl"></asp:xml> --></td>
						</tr>
						<tr>
							<td>
								<table cellSpacing="0" cellPadding="2" width="100%" border="0">
									<tr>
										<td class="td" align="right" width="20%">Start :</td>
										<td width="30%"><asp:textbox id="txtStartDate" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"
												Width="100" Runat="server" cssclass="input" name="txtStartDate"></asp:textbox>
											<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
											<div id="divStartDate" style="POSITION: absolute"></div>
											<IMG id="StartDate" style="CURSOR: hand" onclick="imcalendar.select(document.Form1.txtStartDate, 'divStartDate', 'dd/MM/yyyy'); return false;"
												src="<%=Request.ApplicationPath%>/images/CALENDAR.GIF" border="0" name="StartDate">
											<asp:requiredfieldvalidator id="rfvStartDate" Runat="Server" ErrorMessage="Please enter a Start date" Display="None"
												ControlToValidate="txtStartDate"></asp:requiredfieldvalidator></td>
										<td class="td" align="right" width="20%">End :</td>
										<td width="30%"><asp:textbox id="txtEndDate" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"
												Width="100" Runat="server" cssclass="input" name="txtEndDate"></asp:textbox>
											<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
											<div id="divEndDate" style="POSITION: absolute"></div>
											<IMG id="EndDate" style="CURSOR: hand" onclick="imcalendar.select(document.Form1.txtEndDate, 'divEndDate', 'dd/MM/yyyy'); return false;"
												src="<%=Request.ApplicationPath%>/images/CALENDAR.GIF" border="0" name="EndDate">
											<asp:requiredfieldvalidator id="rfvEndDate" Runat="Server" ErrorMessage="Please enter an End date" Display="None"
												ControlToValidate="txtEndDate"></asp:requiredfieldvalidator></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="center"><input id="grouping_list" type="hidden" name="grouping_list"> <input class="button" id="htmlGenerate" onclick="loadList(document.Form1);" type="button"
									value="Generate Report">
								<asp:button CssClass="inputhidden" id="btnGenerate" runat="server" name="btnGenerate" Text="Generate Report"></asp:button></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><asp:validationsummary id="validationsummary1" style="Z-INDEX: 103; LEFT: 16px" runat="server" showmessagebox="true"
						showsummary="false" height="88px" width="696px"></asp:validationsummary></td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
