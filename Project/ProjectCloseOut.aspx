<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectCloseOut.aspx.vb" Inherits="TimeTrax.ProjectCloseOut" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<script language="javascript" src="../Components/Scripts/ProjectCloseOut.js"></script>
<body onload="DisableDropDowns(this);">
	<form id="Form1" method="post" runat="server">
		<im:header id="ucHeader" runat="server"></im:header>
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Project Close Out</th></tr>
			<tr>
				<td class="td3" vAlign="top">
					<table class="t1" width="100%" align="center">
						<tr>
							<th class="th1" colSpan="6">
								Filter Selection
							</th>
						</tr>
						<tr>
							<td class="td1" width="13%">Team Leader:</td>
							<td class="td2" width="25%"><asp:dropdownlist id="ddlTeamLeader" runat="server" DataTextField="UserName" DataValueField="UserID"
									AutoPostBack="True" CssClass="select" width="95%"></asp:dropdownlist></td>
							<td class="td1" width="7%">Client:</td>
							<td class="td2" width="35%"><asp:dropdownlist id="ddlClient" runat="server" DataTextField="ClientName" DataValueField="ClientID"
									CssClass="select" AutoPostBack="True" width="95%"></asp:dropdownlist></td>
							<td class="td1" width="20%"><asp:checkbox id="chkPassedCloseDate" runat="server" AutoPostBack="True"></asp:checkbox>Awaiting 
								Close Out
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="td3" vAlign="top" colspan="4">
					<table class="t1" id="tblProjectListing" width="100%" align="center" runat="server" name="tblProjectListing">
					</table>
				</td>
			</tr>
			<tr>
				<td class="td3" colspan="4" align="center"><asp:button id="btnSubmit" runat="server" Cssclass="button" text="Submit"></asp:button>
					<INPUT id="txtProjectIDs" type="hidden" runat="server">
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer>
	</form>
</body>
