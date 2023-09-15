<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="dynAdd.aspx.vb" Inherits="TimeTrax.dynAdd"%>
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
				<td valign="top">
					<asp:placeholder id="listPlace" runat="server"></asp:placeholder>
				</td>
			</tr>
			<TR>
				<td>
					<table id="tbltime" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server"
						name="tbltime">
						<tr>
							<th class="th1" width="50%">
								&nbsp;</th>
							<th class="th1" width="31%">
								Expense Type</th>
							<th class="th1" width="5%">
								Quantity</th>
							<th class="th1" width="7%">
								Cost</th>
							<th class="th1" width="7%">
								Total</th>
						</tr>
						<tr>
							<asp:PlaceHolder ID="CashPlace" Runat="server"></asp:PlaceHolder>
						</tr>
					</table> <!-- END tbltime -->
					<table id="tbltimefoot" cellSpacing="0" cellPadding="2" width="100%" border="0" runat="server"
						name="tbltimefoot">
						<tr>
							<th class="th2" align="left" width="93%">
								<b>Total :&nbsp;&nbsp;</b></th>
							<th class="th2" width="7%">
								<asp:textbox id="txtTotal" runat="server" ReadOnly="True" size="10" cssclass="inputR"></asp:textbox></th>
						</tr>
					</table> <!-- END tbltimefoot -->
				</td>
			</TR>
		</table>
		
		<im:Footer id="ucFooter" runat="server"></im:Footer>
		</form>
  </body>
