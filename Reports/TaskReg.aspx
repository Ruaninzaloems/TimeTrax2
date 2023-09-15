<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Register TagPrefix="uc1" TagName="ReportFilters" Src="../Components/User Controls/ReportFilters.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TaskReg.aspx.vb" Inherits="TimeTrax.TaskReg" Trace="False"%>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
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
				<td>
					<div id="divReport" runat="server">
						<table class="t4" style="WIDTH:100%" align="center">
							<tr>
								<td class="td" colspan="6" align="right">
									<IMG id="Printbtn" onclick="printSpecial(this,'<%=Request.ApplicationPath%>')" alt="Print Report" src="../Images/print.gif"
										style="WIDTH:16px; CURSOR:pointer; HEIGHT:16px" >
									<asp:imagebutton id="imgExport" runat="server" ImageUrl="../Images/excel.gif" AlternateText="Export Report to Excel"
										style="CURSOR:pointer" Width="16" Height="16"></asp:imagebutton>
								</td>
							</tr>
							<tr>
								<th class="th">
									Project Overview</th></tr>
							<tr>
								<td>
									<table width="100%" border="0">
										<tr>
											<td class="td" align="right">Project Duration :</td>
											<td class="td" align="center"><asp:textbox class="InputRO" id="txtProjStart" runat="server" name="txtProjStart"></asp:textbox></td>
											<td class="td" align="center">to</td>
											<td class="td" align="center"><asp:textbox class="InputRO" id="txtProjEnd" runat="server" name="txtProjEnd"></asp:textbox></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td class="labelbold" align="center">Budget</td>
											<td class="labelbold" align="center">To Date</td>
											<td class="labelbold" align="center">This Period</td>
										</tr>
										<tr>
											<td class="td" align="right">Budget :</td>
											<td class="td" align="center"><asp:textbox class="InputRO" id="txtBudget" runat="server" name="txtBudget"></asp:textbox></td>
											<td class="td" align="center"><asp:textbox class="InputRO" id="txtToDateCost" runat="server" name="txtToDateCost"></asp:textbox></td>
											<td class="td" align="center"><asp:textbox class="InputRO" id="txtPeriodCost" runat="server" name="txtPeriodCost"></asp:textbox></td>
										</tr>
										<tr>
											<td class="td" align="right">Hours :</td>
											<td class="td" align="center"><asp:textbox class="InputRO" id="txtBudgetHrs" runat="server" name="txtBudgetHrs"></asp:textbox></td>
											<td class="td" align="center"><asp:textbox class="InputRO" id="txtToDateHrs" runat="server" name="txtToDateHrs"></asp:textbox></td>
											<td class="td" align="center"><asp:textbox class="InputRO" id="txtPeriodHrs" runat="server" name="txtPeriodHrs"></asp:textbox></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th class="th">
									Project Detail Report</th></tr>
							<tr>
								<td height="20">
									<APPLET width="100%" height="400px" archive="/aspnet_client/intermap/controls/chart.jar"
										code="com.objectplanet.chart.BarChartApplet" ID="Object1" VIEWASTEXT>
										<PARAM NAME='seriesRange_0' VALUE='2'>
										<PARAM NAME='sampleValues_0' VALUE="<%=ValueLabels%>">
										<PARAM NAME='sampleLabels' VALUE="<%=SampleLabels%>">
										<PARAM NAME='valueLabelsOn' VALUE='True'>
										<PARAM NAME='barLabelsOn' VALUE='True'>
										<PARAM NAME='barLabelAngle' VALUE='270'>
										<PARAM NAME='multiSeriesOn' VALUE='False'>
										<PARAM NAME='valueLabelStyle' VALUE='floating'>
										<PARAM NAME='3DModeOn' VALUE='False'>
										<PARAM NAME='valueLinesOn' VALUE='True'>
										<PARAM NAME='gridLinesOn' VALUE='False'>
										<PARAM NAME='barOutlineOff' VALUE='False'>
										<PARAM NAME='sampleScrollerOn' VALUE='True'>
										<PARAM NAME='visibleSamples' VALUE='0,30'>
										<PARAM NAME='background' VALUE='#DEE0BC'>
										<PARAM NAME='multiColorOn' VALUE='False'>
										<param name="overlay" value="line">
										<param name="overlay_seriesCount" value="2">
										<param name="overlay_sampleValues_1" value="<%=OverlayValues%>">
										<param name="overlay_valueLabelsOn" value="false">
										<param name="overlay_lineWidth" value="3">
										<param name="rangeOn_2" value="true">
										<param name="rangeStep" value="1000">
										<param name="rangeStep_2" value="100">
										<param name="rangePosition" value="right">
										<param name="rangeposition_2" value="left">
										<param name="rangeAdjusterOn" value="true">
										<param name="rangeAdjusterOn_2" value="true">
										<param name="rangeAdjusterPosition_2" value="left">
										<param name="rangeAdjusted_1" value="both">
										<param name="sampleScrollerOn" value="true">
										<param name="sampleAxisLabel" value="Time Entry Dates">
										<param name="sampleAxisLabelFont" value="Arial, bold, 11">
										<param name="rangeAxisLabel" value="Cummulative\nAmount in Rands (R)">
										<param name="rangeAxisLabelFont" value="Arial, bold, 12">
										<param name="rangeAxisLabelAngle" value="90">
										<param name="rangeAxisLabel_2" value="Individual\nAmount in Rands (R)">
										<param name="rangeAxisLabelAngle_2" value="270">
										<param name="legendOn" value="true">
										<param name="legendPosition" value="top">
										<param name="legendLabels" value="Individual,Cummulative">
									</APPLET>
								</td>
							</tr>
							<tr>
								<td><asp:placeholder id="ReportPlace" runat="server"></asp:placeholder></td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
