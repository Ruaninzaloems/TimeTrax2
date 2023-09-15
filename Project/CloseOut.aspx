<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CloseOut.aspx.vb" Inherits="TimeTrax.CloseOut"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="ProjInfo" Src="../Components/User Controls/ProjectInfo.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<body>
	<form id="Form1" method="post" runat="server">
		<im:Header id="ucHeader" runat="server"></im:Header>
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
					Project CloseOut Form
				</th>
			</tr>
			<tr>
				<td vAlign="top" class="td3">
					<table class="t1" width="100%" align="center">
						<tr>
							<td>
								<im:ProjInfo id="ucProjInfo" runat="server"></im:ProjInfo>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center">
					<asp:Button ID="btnSubmit" Text="Close Out" Runat="server" CssClass="button"></asp:Button>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
  </body>