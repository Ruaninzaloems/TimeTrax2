<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ExpenseReimbursements.aspx.vb" Inherits="TimeTrax.ExpenseReimbursements"%>
<%@ Register TagPrefix="uc1" TagName="ReportFilters" Src="../Components/User Controls/ReportFilters.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<SCRIPT language="JavaScript" src="<%=Request.ApplicationPath%>/Components/Scripts/ReportFilters.js"></SCRIPT>
<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
<body onload="initFilters();ShowHideExpenseMonth();">
	<form id="Form1" method="post" runat="server">
		<im:Header id="ucHeader" runat="server"></im:Header>
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
					<div id="printReady">
						<table width="100%" align="center" border="0" id="tblButtons" runat="server">
							<tr>
								<td class="td" align="right">
									<IMG id="Printbtn" onclick="printSpecial(this,'<%=Request.ApplicationPath%>')" alt="Print Report" src="../Images/print.gif"
										style="WIDTH:16px; CURSOR:pointer; HEIGHT:16px" >
									<asp:imagebutton id="imgExport" runat="server" ImageUrl="../Images/excel.gif" style="CURSOR:pointer"
										AlternateText="Export Report to Excel" Width="16" Height="16"></asp:imagebutton>
								</td>
							</tr>
						</table>
						<div>
							<table id="divReport" runat="server" class="t4" width="100%" align="center">
								<tr>
									<th class="th">
										Expense Reimbursement Report
									</th>
								</tr>
								<tr>
									<td>
										<table <%=setBorder%> align="center" width="100%">
											<tr id="pgHead" runat="server">
												<td colspan="7">
													<table align="center">
														<tr>
															<td colspan="7" align="center">
																Expense Reimbursement
															</td>
														</tr>
														<tr>
															<td colspan="7" align="center">
																<b>
																	<asp:Label ID="lblMonth" Runat="server" Width="100%"></asp:Label></b>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<!-- By Task Header -->
											<tr id="trByTask" runat="server">
												<th class="th1" width="10%">
													Client</th>
												<th class="th1" width="10%">
													Project</th>
												<th class="th1" width="10%">
													User</th>
												<th class="th1" width="10%">
													Type</th>
												<th class="th1" width="10%">
													Date</th>
												<th class="th1" width="20%">
													Description</th>
												<th class="th1" width="10%">
													Quantity</th>
												<th class="th1" width="10%">
													Rate (R)</th>
												<th class="th1" width="10%">
													Total (R)</th>
											</tr>
											<!-- End By Task Header -->
											<!-- By Group Header -->
											<tr id="trByUser" runat="server">
												<th class="th1" width="20%">
													Project</th>
												<th class="th1" width="10%">
													Type</th>
												<th class="th1" width="10%">
													Date</th>
												<th class="th1" width="20%">
													Description</th>
												<th class="th1" width="10%">
													Quantity</th>
												<th class="th1" width="10%">
													Rate (R)</th>
												<th class="th1" width="10%">
													Total (R)</th>
											</tr>
											<!-- End By Group Header -->
											<!-- By Task Grouping -->
											<asp:Repeater id="RepeaterClient" runat="server">
												<ItemTemplate>
													<tr>
														<td class="tdreportTotal" colspan="9" align="left">
															<asp:Label ID="lblClient" Runat="server"></asp:Label>
														</td>
													</tr>
													<asp:Repeater id="RepeaterProject" runat="server" OnItemDataBound="RepeaterProject_ItemDataBound">
														<ItemTemplate>
															<tr>
																<td>&nbsp;</td>
																<td class="td" colspan="8" align="left">
																	<asp:Label ID="lblProject" Runat="server"></asp:Label>
																</td>
															</tr>
															<asp:Repeater id="RepeaterUser" runat="server" OnItemDataBound="RepeaterUser_ItemDataBound">
																<ItemTemplate>
																	<tr>
																		<td>&nbsp;</td>
																		<td>&nbsp;</td>
																		<td class="td" colspan="7" align="left">
																			<asp:Label ID="lblUser" Runat="server"></asp:Label>
																		</td>
																	</tr>
																	<asp:Repeater id="RepeaterExpenses" runat="server" OnItemDataBound="RepeaterExpenses_ItemDataBound">
																		<ItemTemplate>
																			<tr border="1">
																				<td>&nbsp;</td>
																				<td>&nbsp;</td>
																				<td>&nbsp;</td>
																				<td class="tdreport">
																					<asp:Label ID="lblExpType" Runat="server" CssClass="inputReport" Width="100%"></asp:Label>
																				</td>
																				<td class="tdreport">
																					<asp:Label ID="lblDate" Runat="server" CssClass="inputReport" Width="100%"></asp:Label>
																				</td>
																				<td class="tdreport">
																					<asp:Label ID="lblComments" Runat="server" CssClass="inputReport" Width="100%"></asp:Label>
																				</td>
																				<td class="tdreport">
																					<asp:Label ID="lblQty" Runat="server" CssClass="inputRReport" Width="100%"></asp:Label>
																				</td>
																				<td class="tdreport">
																					<asp:Label ID="lblRate" Runat="server" CssClass="inputRReport" Width="100%"></asp:Label>
																				</td>
																				<td class="tdreport">
																					<asp:Label ID="lblExpTot" Runat="server" CssClass="inputRReport" Width="100%"></asp:Label>
																				</td>
																			</tr>
																		</ItemTemplate>
																		<FooterTemplate>
																			<tr>
																				<td></td>
																				<td></td>
																				<td class="tdreportTotal">Total:</td>
																				<td colspan="5"></td>
																				<td align="right" class="tdreportTotal">
																					<asp:Label ID="lblTotal" Runat="server"></asp:Label></td>
																			</tr>
																		</FooterTemplate>
																	</asp:Repeater>
																</ItemTemplate>
															</asp:Repeater> <!--User Repeater -->
														</ItemTemplate>
													</asp:Repeater>
													<tr>
														<td colspan="9">
															<hr>
														</td>
													</tr>
												</ItemTemplate>
											</asp:Repeater>
											<!-- End By Task Grouping -->
											<!-- By User Grouping -->
											<asp:Repeater id="RepeaterUserByUser" runat="server">
												<ItemTemplate>
													<tr>
														<td class="tdreportTotal" colspan="9" align="left">
															<asp:Label ID="lblUserByUser" Runat="server"></asp:Label>
														</td>
													</tr>
													<asp:Repeater id="RepeaterExpensesByUser" runat="server" OnItemDataBound="RepeaterExpensesByUser_ItemDataBound">
														<ItemTemplate>
															<tr>
																<td class="tdreport">
																	<asp:Label ID="lblProject" Runat="server" CssClass="inputReport" Width="100%"></asp:Label>
																</td>
																<td class="tdreport">
																	<asp:Label ID="lblExpTypeByUser" Runat="server" CssClass="inputReport" Width="100%"></asp:Label>
																</td>
																<td class="tdreport">
																	<asp:Label ID="lblDateByUser" Runat="server" CssClass="inputReport" Width="100%"></asp:Label>
																</td>
																<td class="tdreport">
																	<asp:Label ID="lblCommentsByUser" Runat="server" CssClass="inputReport" Width="100%"></asp:Label>
																</td>
																<td class="tdreport">
																	<asp:Label ID="lblQtyByUser" Runat="server" CssClass="inputRReport" Width="100%"></asp:Label>
																</td>
																<td class="tdreport">
																	<asp:Label ID="lblRateByUser" Runat="server" CssClass="inputRReport" Width="100%"></asp:Label>
																</td>
																<td class="tdreport">
																	<asp:Label ID="lblExpTotByUser" Runat="server" CssClass="inputRReport" Width="100%"></asp:Label>
																</td>
															</tr>
														</ItemTemplate>
														<FooterTemplate>
															<tr>
																<td class="tdreportTotal">Total:</td>
																<td colspan="5"></td>
																<td align="right" class="tdreportTotal">
																	<asp:Label ID="lblTotalByUser" Runat="server"></asp:Label></td>
															</tr>
															<tr>
																<td colspan="7">&nbsp;</td>
															</tr>
														</FooterTemplate>
													</asp:Repeater>
												</ItemTemplate>
											</asp:Repeater> <!--User Repeater -->
											<!-- End By User Grouping -->
											<tr>
												<td colspan="9">
													<hr>
												</td>
											</tr>
											</ITEMTEMPLATE> <!-- Client Repeater -->
										</table>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
</body>
