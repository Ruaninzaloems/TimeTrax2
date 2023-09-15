<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="ProjInfo" Src="../Components/User Controls/ProjectInfo.ascx" %>
<%@ Register TagPrefix="im" TagName="Orders" Src="../Components/User Controls/Orders.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PTO.aspx.vb" Inherits="TimeTrax.PTO"%>
<%@ Register TagPrefix="uc1" TagName="ProjectDocuments" Src="../Components/User Controls/ProjectDocuments.ascx" %>
<script language=javascript 
src="<%=Request.ApplicationPath%>\Components\Scripts\DynamicAdd.js"></script>
<script language=javascript 
src="<%=Request.ApplicationPath%>\Components\Scripts\ProjInfo.js"></script>
<script language=javascript 
src="<%=Request.ApplicationPath%>\Components\Scripts\Orders.js"></script>
<body onload="LoadProjInfoDynamics();LoadOrderDynamics();">
	<im:header id="ucHeader" runat="server"></im:header>
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th" colSpan="2">
					Project Take On Approval</th></tr>
			<tr>
				<td colSpan="2"><im:projinfo id="ucProjInfo" runat="server"></im:projinfo></td>
			</tr>
			<tr>
				<td colSpan="2">
					<table class="t1" width="98%" align="center">
						<tr>
							<th class="th1" colSpan="2">
								Order Details</th></tr>
						<tr>
							<td>
								<!-- This is going to be Orders User Control --><im:orders id="ucOrders" runat="server"></im:orders>
								<!-- End of Orders User Control --></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr id="Appovals" runat="server">
				<td colSpan="2">
					<div id="divApproval1" runat="server">
						<table id="tblapprove1" cellSpacing="0" cellPadding="2" width="100%" border="0" name="tblapprove1">
							<tr>
								<td class="td" colSpan="2"><asp:checkbox id="chkApprove1" Visible="False" Text="A1" Runat="server" Checked="False"></asp:checkbox></td>
							</tr>
							<tr>
								<td class="td" align="left" colSpan="2">Reason for Rejecting:</td>
							</tr>
							<tr>
								<td class="td" colSpan="2"><asp:textbox id="txtApprove1Comment" Runat="server" Width="100%" CssClass="TextArea" Rows="5"
										TextMode="MultiLine"></asp:textbox><br>
								</td>
							</tr>
						</table>
					</div>
					<div id="divApproval2" runat="server">
						<table id="tblapprove2" cellSpacing="0" cellPadding="2" width="100%" border="0" name="tblapprove2">
							<tr>
								<td class="td" colSpan="2"><asp:checkbox id="chkApprove2" Text="A1" Runat="server" Checked="False" TextAlign="Right"></asp:checkbox></td>
							</tr>
							<tr>
								<td class="td" align="left" colSpan="2">Reason for Rejecting:</td>
							</tr>
							<tr>
								<td class="td" colSpan="2"><asp:textbox id="txtApprove2Comment" Runat="server" Width="100%" CssClass="TextArea" Rows="5"
										TextMode="MultiLine"></asp:textbox><br>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
			<tr>
				<td align="center" colSpan="2"><input id="hidProjID" type="hidden" name="hidProjID" runat="server">
					<input class="button" id="btnUpload" onclick="uploadDocument();" type="button" value="Upload Documents"
						runat="server"> <input class="button" id="htmApprove" onclick="PTOApprove();" type="button" value="Approve"
						name="htmApprove" runat="server"><asp:button id="btnApprove" Runat="server" CssClass="inputhidden"></asp:button><input id="hidApproval" type="hidden" name="hidApproval" runat="server">
					<input class="button" id="htmReject" onclick="PTOReject();" type="button" value="Reject"
						name="htmReject" runat="server"><asp:button id="btnReject" Runat="server" CssClass="inputhidden"></asp:button></td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
