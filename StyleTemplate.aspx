<%@ Page Language="vb" CodeBehind="StyleTemplate.aspx.vb" AutoEventWireup="false" Inherits="TimeTrax.StyleTemplate" %>
<HTML>
	<HEAD>
		<LINK href="app_style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" runat="server">
			<p></p>
			<p></p>
			<table class="PageFrame" id="Table1" width="100%" bgColor="#e0e0e0" border="0">
				<tbody>
					<tr>
						<td>
							<table class="t4" id="Table2" style="WIDTH: 1084px; HEIGHT: 202px" width="1084" align="center"
								bgColor="#c0c0ff">
								<tbody>
									<tr>
										<th class="th" align="center">
											Header Text</th></tr>
									<tr>
										<td align="center">
											<p></p>
											<p><br>
												&nbsp;
											</p>
											<table class="t1" id="tblwizard1" style="WIDTH: 984px; HEIGHT: 186px" runat="server">
												<tbody>
													<tr>
														<td class="td">
															<p><input class="input" id="Text1" type="text" value="input" name="Text1">
															</p>
															<p><input class="inputR" id="Text2" type="text" value="inputR" name="Text2">
															</p>
															<p><input class="inputRO" id="Text3" type="text" value="inputRO" name="Text3">
															</p>
															<p><input class="inputROR" id="Text4" type="text" value="inputROR" name="Text4">
															</p>
															<p><span><label class="label">Label</label>
																</span></p>
															<p><span><label class="labelbold">Labelbold</label>
																</span></p>
															<p><span><label class="labelbold"><span><label class="labelU">LabelU</label>
																		</span>
																	</label>
																</span></p>
															<p></p>
															<textarea class="textarea" id="Textarea1" name="Textarea1">TextArea</textarea> &nbsp;
															<p><input class="label" id="Checkbox1" type="checkbox" name="Checkbox1"> CheckBox 
																(Can use any Label class)
															</p>
															<p><input class="label" id="Radio1" type="radio" value="Radio1" name="RadioGroup">
																Radio Button(Can use any Label class)
															</p>
															<p></p>
															<select class="select" id="Select1" style="WIDTH: 160px" name="Select1">
															</select>&nbsp; Select Style
															<p><input class="button" id="Button1" type="button" value="Button" name="Button1">&nbsp;<input class="button1" id="Button2" type="button" value="Button1" name="Button2">&nbsp; 
																Button2, button3 etc....
															</p>
															<table id="Table3" style="WIDTH: 824px; HEIGHT: 39px" align="center">
																<tbody>
																	<tr>
																		<th class="th1">
																			th1</th>
																		<th class="th2">
																			th2</th></tr>
																	<tr>
																		<td class="td">td</td>
																		<td class="td">td</td>
																	</tr>
																	<tr>
																		<td class="td1">td1</td>
																		<td class="td1">td1</td>
																	</tr>
																	<tr>
																		<td class="td2">td2</td>
																		<td class="td2">td2</td>
																	</tr>
																	<tr>
																		<td class="td3">td3</td>
																		<td class="td3">td3</td>
																	</tr>
																</tbody></table>
															<p></p>
															<p align="center"><asp:datagrid id="dg" runat="server" width="423px" AllowCustomPaging="True" AllowPaging="True"
																	ShowFooter="True">
																	<alternatingitemstyle cssclass="grid-alt2"></alternatingitemstyle>
																	<itemstyle cssclass="grid-alt1"></itemstyle>
																	<footerstyle cssclass="grid-footer"></footerstyle>
																	<headerstyle cssclass="grid-header"></headerstyle>
																	<pagerstyle cssclass="grid-pager"></pagerstyle>
																</asp:datagrid></p>
															<p align="center">
																<table id="Table4" style="WIDTH: 824px; HEIGHT: 39px" align="center">
																	<tbody>
																		<tr>
																			<th class="Thtrigger">
																				Thtrigger</th></tr>
																		<tr>
																			<td class="grid-trigalt1">grid-trigalt1</td>
																		</tr>
																		<tr>
																			<td class="grid-trigalt1">grid-trigalt1</td>
																		</tr>
																	</tbody></table>
															</p>
															<p align="center"></p>
															<p align="center"></p>
															<p align="center"></p>
															<p align="center"></p>
														</td>
													</tr>
												</tbody></table>
										</td>
									</tr>
								</tbody></table>
						</td>
					</tr>
				</tbody></table>
		</form>
	</body>
</HTML>
