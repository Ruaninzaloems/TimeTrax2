<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UpdateResource.aspx.vb" Inherits="TimeTrax.UpdateResource"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<HTML>
	<HEAD>
		<TITLE>Update Resource</TITLE>
		<LINK href=<%=Request.ApplicationPath & "/app_style.css"%> type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="t4" width="100%">
				<tr>
					<td vAlign="top" class="td3">
						<table class="t2" width="90%" align="center">
							<tr>
								<th class="th2" colspan="2">
									Update Resource</th>
							</tr>
							<tr>
								<td class="td1" width="50%">Resource</td>
								<td class="td2" id="tdResource" runat="server"></td>
							<tr>
								<td class="td1" colspan="2"><asp:checkbox id="chkEnabled" runat="server" text="Enabled"></asp:checkbox></td>
							</tr>
							<tr>
								<td class="td1" align="center" colspan="2">
									<input id="btnSubmit" name="btnSubmit" runat="server" type="button" class="button" value="Submit">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
