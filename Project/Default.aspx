<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Default.aspx.vb" Inherits="TimeTrax._Default2"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="LeftTab" Src="../Components/User Controls/LeftTab.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
  <im:Header id="ucHeader" runat="server"></im:Header>
    <form id="Form1" method="post" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
    			<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
    		</td>
			</tr>
		</table>

		<table class="t4" width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td valign="top">
					<table class="t4a" cellSpacing="0" cellPadding="5" width="98%" align="center" border="0">
						<tr>
							<im:LeftTab id="ucLeftTab" runat="server"></im:LeftTab>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
		<im:Footer id="ucFooter" runat="server"></im:Footer>
		</form>
  </body>
</html>
