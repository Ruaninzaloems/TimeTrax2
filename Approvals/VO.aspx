<%@ Page Language="vb" AutoEventWireup="false" Codebehind="VO.aspx.vb" Inherits="TimeTrax.VO"%>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="Orders" Src="../Components/User Controls/Orders.ascx" %>
<%@ Register TagPrefix="im" TagName="ProjInfo" Src="../Components/User Controls/ProjectInfo.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<script language="javascript" src="<%=Request.ApplicationPath%>\Components\Scripts\DynamicAdd.js" ></script>
<script language="javascript" src="<%=Request.ApplicationPath%>\Components\Scripts\ProjInfo.js" ></script>
<script language="javascript" src="<%=Request.ApplicationPath%>\Components\Scripts\Orders.js" ></script>
<body onload="LoadProjInfoDynamics();LoadOrderDynamics();">
	<im:Header id="ucHeader" runat="server"></im:Header>
	<form id="Form1" method="post" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="tdmenu">
					<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
				</td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th" colspan="2">
					Variation Order Approval</th>
			</tr>
			<tr>
				<td colspan="2">
					<im:ProjInfo id="ucProjInfo" runat="server"></im:ProjInfo>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<table class="t1" width="98%" align="center">
						<tr>
							<th class="th1" colspan="2">
								Order Details</th>
						</tr>
						<tr>
							<td>
								<!-- This is going to be Orders User Control -->
								<im:Orders id="ucOrders" runat="server"></im:Orders>
								<!-- End of Orders User Control -->
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr id="Appovals" runat="server">
				<td colspan="2">
					<div id="divApproval1" runat="server">
						<table id="tblapprove1" cellSpacing="0" cellPadding="2" width="100%" border="0" name="tblapprove1">
							<tr>
								<td class="td" colspan="2"><asp:CheckBox ID="chkApprove1" Checked="False" Runat="server" Text="A1"></asp:CheckBox></td>
							</tr>
							<tr>
								<td class="td" colspan="2" align="left">Reason for Rejecting:</td>
							</tr>
							<tr>
								<td class="td" colspan="2">
									<asp:TextBox ID="txtApprove1Comment" Runat="server" TextMode="MultiLine" Rows="5" CssClass="TextArea"
										Width="100%"></asp:TextBox>
									<br>
								</td>
							</tr>
						</table>
					</div>
					<div id="divApproval2" runat="server">
						<table id="tblapprove2" cellSpacing="0" cellPadding="2" width="100%" border="0" name="tblapprove2">
							<tr>
								<td class="td" colspan="2"><asp:CheckBox ID="chkApprove2" Checked="False" Runat="server" TextAlign="Right" Text="A1"></asp:CheckBox></td>
							</tr>
							<tr>
								<td class="td" colspan="2" align="left">Reason for Rejecting:</td>
							</tr>
							<tr>
								<td colspan="2" class="td">
									<asp:TextBox ID="txtApprove2Comment" Runat="server" TextMode="MultiLine" Rows="5" CssClass="TextArea"
										Width="100%"></asp:TextBox>
									<br>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
			<tr>
				<td align="center" colspan=2>
					<input id="hidProjID" type="hidden" name="hidProjID" runat="server"> <input class="button" id="btnUpload" onclick="uploadDocument();" type="button" value="Upload Documents"
						runat="server" NAME="btnUpload"> <input id="htmApprove" type="button" class="button" value="Approve" onclick="PTOApprove();"
						runat="server" NAME="htmApprove"><asp:Button ID="btnApprove" Runat="server" CssClass="inputhidden"></asp:Button><input id="hidApproval" name="hidApproval" type="hidden" runat="server">
					<input id="htmReject" type="button" class="button" value="Reject" onclick="PTOReject();"
						runat="server" NAME="htmReject"><asp:Button ID="btnReject" Runat="server" CssClass="inputhidden"></asp:Button></td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
</body>
