<%@ Register TagPrefix="uc1" TagName="ReportFilters"  Src="../Components/User Controls/ReportFilters.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false"  Codebehind="ProjectActivityRegister.aspx.vb" Inherits="TimeTrax.ProjectActivityRegister"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/imcalendar.js"></script>
<body >
	<form id="Form1" method="post" runat="server">
		<im:Header id="ucHeader" runat="server"></im:Header>
		<!--START C A L E N D A R   C O N T R O L Include this to use the calendar-->
		<SCRIPT language="JavaScript">
				//This is needed for the Calendar styles
				document.write(CalendarPopup_getStyles());
				//To use a Pop-Up window, leave the parameter blank, otherwise put in dynamic
				var imcalendar = new CalendarPopup("dynamic");
				imcalendar.showYearNavigation();
		</SCRIPT>
		<!--END C A L E N D A R   C O N T R O L-->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="tdmenu">
					<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
				</td>
			</tr>
		</table>
		<table class="t3" width="100%">
			<tr>
				<td><uc1:ReportFilters id="ucReportFilters" runat="server"></uc1:ReportFilters>
				</td>
			</tr>
			<tr>
				<td vAlign="top" class="td3">
					<table align="center" width="100%" border="0" id="tblButtons" runat="server">
						<tr>
							<td class="td" align="right">
								<IMG id="Printbtn" onclick="printSpecial(this,'<%=Request.ApplicationPath%>')" alt="Print Report" src="../Images/print.gif"
										style="WIDTH:16px; CURSOR:pointer; HEIGHT:16px">
								<asp:imagebutton id="imgExport" runat="server" ImageUrl="../Images/excel.gif" AlternateText="Export Report to Excel"
									style="CURSOR:pointer" Width="16" Height="16"></asp:imagebutton>
							</td>
						</tr>
					</table>
					<div id="divReport" runat="server">
						<table class="t4" align="center" width="100%">
							<tr id="pgHead" runat="server">
								<td colspan="5" width="100%">
									<table align="center">
										<tr>
											<td colspan="5"><img src="../images/XLbanner.jpg"></td>
										</tr>
										<tr>
											<td colspan="5"></td>
										</tr>
										<tr>
											<td colspan="5"></td>
										</tr>
										<tr>
											<td colspan="5"></td>
										</tr>
										<tr>
											<td colspan="5"></td>
										</tr>
										<tr>
											<td colspan="5" align="center">
												<b>
													<asp:Label ID="lblCompany" Runat="server" Width="100%"></asp:Label></b>
											</td>
										</tr>
										<tr>
											<td colspan="5" align="center">
												Task Activity Register
											</td>
										</tr>
										<tr>
											<td colspan="5" align="center">
												<b>Project:
													<asp:Label ID="lblProjName" Runat="server" Width="100%"></asp:Label></b>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th class="th">
									Task Activity Register Report
								</th>
							</tr>
							<tr>
								<td>
									<table id="tblPage" border="1" width="100%">
										<tr>
											<th class="th1" width="10%">
												Task</th>
											<th class="th1" width="10%">
												User</th>
											<th class="th1" width="15%">
												Entry Date</th>
											<th class="th1" width="15%">
												Total Hours</th>
											<th class="th1" width="50%">
												Comments</th>
										</tr>
										<asp:Repeater id="Repeater1" runat="server">
											<ItemTemplate>
												<tr>
													<td class="tdreportTotal" colspan="5" align="left">
														<asp:Label ID="lblHead1" Runat="server"></asp:Label>
													</td>
												</tr>
												<asp:Repeater id="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
													<ItemTemplate>
														<tr>
															<td class="tdreportTotal">
															</td>
															<td class="tdreportTotal" colspan="4" style="align:left;">
																<asp:Label ID="lblHead2" Runat="server"></asp:Label>
															</td>
														</tr>
														<asp:Repeater id="Repeater3" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
															<ItemTemplate>
																<tr>
																	<td class="tdreport"></td>
																	<td class="tdreport"></td>
																	<td class="tdreport">
																		<asp:Label ID="lblDate" Runat="server" CssClass="inputReport" Width="100%"></asp:Label>
																	</td>
																	<td class="tdreport">
																		<asp:Label ID="lblHrs" Runat="server" CssClass="inputRReport" Width="100%"></asp:Label>
																	</td>
																	<td class="tdreport">
																		<asp:Label ID="lblComments" Runat="server" CssClass="inputReport" Width="100%"></asp:Label>
																	</td>
																</tr>
															</ItemTemplate>
															<FooterTemplate>
																<tr>
																	<td colspan="3" class="tdreport"></td>
																	<td align="right" class="tdreportTotal">
																		<asp:Label ID="lblTotal" Runat="server" Width="100%"></asp:Label></td>
																	<td></td>
																</tr>
															</FooterTemplate>
														</asp:Repeater>
													</ItemTemplate>
												</asp:Repeater>
											</ItemTemplate>
											<FooterTemplate>
												<tr>
													<th class="th2" colspan="3" style="text-align:left;">
														Total</th>
													<th class="th2" style="text-align:right;">
														<asp:Label ID="lblGrandTotal" Runat="server"></asp:Label></th>
													<th class="th2">
														&nbsp;
													</th>
												</tr>
											</FooterTemplate>
										</asp:Repeater>
									</table>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
</body>
