<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ChangeTeamleader.aspx.vb" Inherits="TimeTrax.ChangeTeamleader"%>
<HTML>
	<HEAD>
		<TITLE>Change Project Resource</TITLE>
		<LINK href=<%=Request.ApplicationPath & "/app_style.css"%> type="text/css" rel="stylesheet">
		<script language="javascript" src="<%=Request.ApplicationPath%>/Components/Scripts/Takeon.js"></script>
	</HEAD>
	<body onload='ws1_init(document.all.hidAppPath.value);'>
		<form id="Form1" method="post" runat="server">
			<div id="ws1" style="BEHAVIOR:url(../Components/Scripts/webservice.htc)"></div>
			<table class="t4" width="100%">
				<tr>
					<td vAlign="top" class="td3">
						<table class="t2" width="90%" align="center">
							<tr>
								<th class="th2" colspan="2">
									Change <asp:Label ID="lblTableCaption" Runat="server"></asp:Label></th>
							</tr>
							<tr>
								<td class="td1" width="50%"><asp:Label ID="lblCaption" Runat="server"></asp:Label></td>
								<td class="td2"><asp:DropDownList id="ddlTeamLeader" runat="server" CssClass="select" DataValueField="UserID" DataTextField="UserName"
										onchange="ws_getrate(this,document.all.hidAppPath.value,document.all.hidCostCentreID.value);"></asp:DropDownList>
									<asp:requiredfieldvalidator id="rfvTeamLeader" InitialValue="0" Runat="Server" ErrorMessage="Please select a Team Leader"
										Display="None" ControlToValidate="ddlTeamLeader"></asp:requiredfieldvalidator>
									<INPUT type="hidden" runat="server" id="hidAppPath"> <INPUT type="hidden" runat="server" id="hidCostCentreID"></td>
							<tr>
								<td class="td1" width="50%">Rate</td>
								<td class="td2"><IM:IMTextBox id="txtTeamLeader" runat="server" TextType="Decimal" CssClass="InputR" RequiredValidationError="Please enter a Rate"></IM:IMTextBox></td>
							</tr>
							<tr>
								<td class="td1" align="center" colspan="2">
									<font color="red">Note:</font> If the Resource is already on the project, the Resource will be removed from his/her current role
									and you will need to set up a new person in that role.
									<input id="btnSubmit" name="btnSubmit" runat="server" type="button" class="button" value="Submit"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
