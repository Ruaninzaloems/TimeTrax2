<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SelectProject.aspx.vb" Inherits="TimeTrax.SelectProject"%>
<body>
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
					Select Project</th>
			</tr>
			<tr>
				<td class="td" align="center">
					<asp:DropDownList ID="ddlProjects" Runat="server" CssClass="select" DataValueField="ProjectID" DataTextField="ProjDesc"></asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<asp:Button ID="btnSubmit" Runat="server" Text="Select" Cssclass="button"></asp:Button>
					<asp:Button ID="btnSave" Runat="server" Text="Save" CssClass="inputhidden"></asp:Button>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
  </body>
