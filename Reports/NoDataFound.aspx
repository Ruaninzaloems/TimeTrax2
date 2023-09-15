<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="NoDataFound.aspx.vb" Inherits="TimeTrax.NoDataFound"%>
<body>
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
				<td align="center">
					<br>
					<br>
						No Data found for selected criteria click 
						<a onclick="history.back();" href="#"><font face="Verdana" color="black" size="2"><strong>Back</strong></font></a>
					 to try again with different criteria
					<br>
					<br>
				</td>
			</tr>
		</table>
		
		<im:Footer id="ucFooter" runat="server"></im:Footer>
		</form>
  </body>
