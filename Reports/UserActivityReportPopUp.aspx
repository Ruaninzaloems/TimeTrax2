<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UserActivityReportPopUp.aspx.vb" Inherits="TimeTrax.UserActivityReportPopUp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HEAD>
<TITLE><%= Session("PageTitle") %></TITLE>
	<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
	<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/imcalendar.js"></script>
	<link href="<%=Request.ApplicationPath%>/app_style.css" type="text/css" rel="stylesheet">
</HEAD>
<body>
	<form id="Form1" method="post" runat="server">
		<table class="t3" width="100%">
			<tr>
				<td vAlign="top" class="td3">
					<div id="divReport" runat="server">
						<table class="t4" align="center" width="100%">
							<tr>
								<th class="th">
									User Activity Register for
									<asp:Label ID="lblUserName" Runat="server" Width="100%"></asp:Label>
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
			<tr>
				<td align="center"><input id="btnClose" class="button" type="button" onclick="javascript: window.close();"
						value="Close">
				</td>
			</tr>
		</table>
	</form>
</body>
