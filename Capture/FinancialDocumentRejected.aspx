<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FinancialDocumentRejected.aspx.vb" Inherits="TimeTrax.FinancialDocumentRejected"%>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<HTML>
	<script language="javascript" src="<Request.ApplicationPath%>/Components/Scripts/ExpenseRejected.js"></script>
	<body>
		<form id="Form1" method="post" runat="server">
			<im:Header id="ucHeader" runat="server"></im:Header>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td class="tdmenu"><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
				</tr>
			</table>
			<table class="t4" width="100%">
				<tr>
					<th class="th">
						Rejected Financial Document</th>
				</tr>
				<tr>
					<td vAlign="top" class="td3">
						<table class="t2" style="WIDTH:100%" align="center">
							<tr>
								<td class="td2"><asp:datagrid id="dgFinancialDocument" runat="server" Width="100%" AutoGenerateColumns="False"
										ShowHeader="True">
										<HeaderStyle CssClass="grid-header"></HeaderStyle>
										<ItemStyle CssClass="grid-trigalt1"></ItemStyle>
										<AlternatingItemStyle CssClass="grid-trigalt2"></AlternatingItemStyle>
										<Columns>
											<asp:BoundColumn DataField="FinancialDocID" HeaderText="Financial Document ID" Visible="False"></asp:BoundColumn>
											<asp:BoundColumn DataField="ProjectName" HeaderText="Project Name"></asp:BoundColumn>
											<asp:BoundColumn DataField="DocUrl" HeaderText="Document Title"></asp:BoundColumn>
											<asp:BoundColumn DataField="FinancialDocDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundColumn>
											<asp:BoundColumn DataField="Amount" HeaderText="Amount" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:c}"></asp:BoundColumn>
											<asp:BoundColumn DataField="RejectedComment" HeaderText="Reason for Rejection"></asp:BoundColumn>
										</Columns>
									</asp:datagrid>
									<br>
								</td>
							</tr>
							<tr>
								<td class="td1" align="center" colspan="2">
									<asp:Button id="btnSubmit" runat="server" Text="Acknowledge the Rejections and Delete the Documents"
										Cssclass="button"></asp:Button>
									<asp:Button id="btnCancel" runat="server" Text="Cancel" Cssclass="button"></asp:Button>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<im:Footer id="ucFooter" runat="server"></im:Footer>
		</form>
	</body>
</HTML>
