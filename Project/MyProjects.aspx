<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MyProjects.aspx.vb" Inherits="TimeTrax.MyProject"%>
<body>
  <im:Header id="ucHeader" runat="server"></im:Header>
    <form id="Form1" method="post" runat="server">
		<table width="100%">
			<tr>
				<td class="tdmenu">
    			<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
    		</td>
			</tr>
		</table>

		<table class="t4" width="100%">

			<tr>
				<td class="td3">
					<div id="divProjects" style="DISPLAY: none" runat="server">
						<table>
							<tr>
								<th class="thtrigger">My Projects</th>
							</tr>
							<tr id="AllProjects" runat="server">
								<td class="td1">
									<IMG id="menu4a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleAlerts(menu4a, menu4b);"
										height="12" alt="" src="<%=Request.ApplicationPath%>/images/down.gif" width="12" align="right" vspace="2" border="0">
									<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleAlerts(menu4a, menu4b);"><u>
											<asp:label id="labAllProjects" Runat="server"></asp:label></u>&nbsp;</SPAN>
									<BR clear="all">
									<div id="menu4b" style="DISPLAY: none" align="center"><asp:datagrid id="dgAllProjects" runat="server" ShowHeader="False" AutoGenerateColumns="False"
											Width="100%">
											<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
											<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
											<Columns>
												<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
											</Columns>
										</asp:datagrid></div>
								</td>
							</tr>
							<tr id="MyProj" runat="server">
								<td class="td1">
									<IMG id="menu2a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleAlerts(menu2a, menu2b);"
										height="12" alt="" src="<%=Request.ApplicationPath%>/images/down.gif" width="12" align="right" vspace="2" border="0">
									<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleAlerts(menu2a, menu2b);"><u>
											<asp:label id="labMyProjects" Runat="server">for which you are a Resource</asp:label></u>&nbsp;</SPAN>
									<BR clear="all">
									<div id="menu2b" style="DISPLAY: none" align="center">
										<asp:datagrid id="dgMyProjects" runat="server" ShowHeader="False" AutoGenerateColumns="False"
											Width="100%">
											<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
											<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
											<Columns>
												<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
											</Columns>
										</asp:datagrid></div>
								</td>
							</tr>
							<tr id="CurrentProjects" runat="server">
								<td class="td1">
									<IMG id="menu3a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleAlerts(menu3a, menu3b);"
										height="12" alt="" src="<%=Request.ApplicationPath%>/images/down.gif" width="12" align="right" vspace="2" border="0">
									<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleAlerts(menu3a, menu3b);"><u>
											<asp:label id="labCurrentProjects" Runat="server">currently in progress</asp:label></u>&nbsp;</SPAN>
									<BR clear="all">
									<div id="menu3b" style="DISPLAY: none" align="center"><asp:datagrid id="dgCurrentProjects" runat="server" ShowHeader="False" AutoGenerateColumns="False"
											Width="100%">
											<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
											<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
											<Columns>
												<asp:BoundColumn DataField="Mess"></asp:BoundColumn>
											</Columns>
										</asp:datagrid></div>
								</td>
							</tr>
						</table>
					</div>
				<br></td>
			</tr>
		</table>
		
		<im:Footer id="ucFooter" runat="server"></im:Footer>
		</form>
  </body>
