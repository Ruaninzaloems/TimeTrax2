<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectVO.aspx.vb" Inherits="TimeTrax.ProjectVO"%>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="Orders" Src="../Components/User Controls/Orders.ascx" %>
<%@ Register TagPrefix="im" TagName="ProjInfo" Src="../Components/User Controls/ProjectInfo.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<script language="javascript" src="..\Components\Scripts\DynamicAdd.js"></script>
<script language="javascript" src="..\Components\Scripts\ProjInfo.js"></script>
<script language="javascript" src="..\Components\Scripts\Orders.js"></script>
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
				<th class="th">
					Project Variation Order</th>
			</tr>
			<tr>
				<td>
					<im:ProjInfo id="ucProjInfo" runat="server"></im:ProjInfo>
				</td>
			</tr>
			<tr>
				<td><br>
					<br>
				</td>
			</tr>
			<tr>
				<td>
					<table class="t1" width="98%" align="center">
						<tr>
							<th class="th1" colspan="2">
								Variation Order Details</th>
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
			<tr>
				<td align="center">
					<input id="hidProjID" type="hidden" name="hidProjID" runat="server"> <input class="button" id="btnUpload" onclick="uploadDocument();" type="button" value="Upload Documents"
						runat="server" NAME="btnUpload">
					<asp:Button ID="btnSubmit" Runat="server" Text="Submit for Approval" Cssclass="button"></asp:Button>
				</td>
			</tr>
			<tr>
				<td>
					<asp:validationsummary id="ValidationSummary1" style="Z-INDEX: 103; LEFT: 16px" runat="server" Width="696px"
						Height="88px" ShowSummary="False" ShowMessageBox="True"></asp:validationsummary>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
</body>
