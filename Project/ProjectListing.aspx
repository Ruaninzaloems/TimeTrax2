<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectListing.aspx.vb" Inherits="TimeTrax.ProjectListing"%>
<script language="javascript" src="../Components/Scripts/sortTable.js"></script>
<body onload="initTable(document.getElementById('dgProjectListing'))">
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
					Project Listing</th></tr>
			<tr>
				<td class="td3" vAlign="top">
					<table class="t1" width="100%" align="center">
						<tr>
							<th class="th1" colSpan="4">
								Filter Selection
							</th>
						</tr>
						<tr runat="server" id="trManager">
							<td class="td1" width="25%">Manager:</td>
							<td class="td2" width="75%"><asp:dropdownlist id="ddlManager" runat="server" DataTextField="UserName" DataValueField="UserID"
									AutoPostBack="True" CssClass="select"></asp:dropdownlist></td>
						</tr>
						<tr>
							<td class="td1">Team Leader:</td>
							<td class="td2"><asp:dropdownlist id="ddlTeamLeader" runat="server" DataTextField="UserName" DataValueField="UserID"
									AutoPostBack="True" CssClass="select"></asp:dropdownlist></td>
						</tr>
						<TR>
							<td class="td1">Client:</td>
							<td class="td2"><asp:dropdownlist id="ddlClient" runat="server" DataTextField="ClientName" DataValueField="ClientID"
									AutoPostBack="True" CssClass="select"></asp:dropdownlist></td>
						</TR>
						<tr>
							<td class="td1">Status:</td>
							<td class="td2"><asp:dropdownlist id="ddlStatus" runat="server" DataTextField="StatusName" DataValueField="StatusID"
									AutoPostBack="True" CssClass="select"></asp:dropdownlist></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="td3" vAlign="top">
					<div id="divProjectListing" style="DISPLAY: none" runat="server">
						<table class="t1" width="100%" align="center">
							<tr>
								<td class="td2"><asp:datagrid id="dgProjectListing" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeader="True">
										<HeaderStyle CssClass="grid-header"></HeaderStyle>
										<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
										<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
										<Columns>
											<asp:BoundColumn DataField="Code" HeaderText="Code"></asp:BoundColumn>
											<asp:BoundColumn DataField="Name" HeaderText="Project"></asp:BoundColumn>
											<asp:BoundColumn DataField="Status" HeaderText="Status"></asp:BoundColumn>
											<asp:BoundColumn DataField="TeamLeader" HeaderText="TeamLeader"></asp:BoundColumn>
											<asp:BoundColumn DataField="Manager" HeaderText="Manager"></asp:BoundColumn>
											<asp:BoundColumn DataField="Client" HeaderText="Client"></asp:BoundColumn>
										</Columns>
									</asp:datagrid></td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer></form>
</body>
