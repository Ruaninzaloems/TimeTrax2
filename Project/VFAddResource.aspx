<%@ Page Language="vb" AutoEventWireup="false" Codebehind="AddResource.aspx.vb" Inherits="TimeTrax.AddResource"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
		<title>Add New Resource</title>
		<LINK href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
			<script language="javascript">
	function closeAdd()
		{
			// Resource Added so close window and reload opener window
			opener.location.reload();
			window.close();
		}
	function closeWin()
		{
			// Cancel button clicked
			window.close();
		}
			</script>
</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="t4" align="center" border="0">
				<tr>
					<th colspan="4" class="th">
						New Project Resource</th>
				</tr>
				<tr><td colspan="4"><br></td></tr>
				<tr>
					<td class="td" width="25%" align="right">User:</td>
					<td class="td" colspan="3">
						<asp:DropDownList id="ddlResource" runat="server" CssClass="select" DataValueField="UserID" DataTextField="UserName"></asp:DropDownList>
						<asp:RequiredFieldValidator id="rfvResource" runat="server" InitialValue="0" ControlToValidate="ddlResource" Display="None" ErrorMessage="Please select a User"></asp:RequiredFieldValidator>
					</td>
				</tr>
				<tr><td colspan="4"><br></td></tr>
				<tr>
					<td align="right" colspan="2" width="50%">
						<asp:Button id="btnSubmit" runat="server" Text="Submit" Cssclass="button"></asp:Button>
					</td>
					<td align="left" colspan="2">
						<INPUT type="button" id="btnClose" onclick="closeWin();" class="button" value="Cancel">
					</td>
				</tr>
			<tr>
				<td><asp:validationsummary id="ValidationSummary1" style="Z-INDEX: 103; LEFT: 16px" runat="server" Width="696px"
						Height="88px" ShowSummary="False" ShowMessageBox="True"></asp:validationsummary></td>
			</tr>
			</table>
		</form>
	</body>
</HTML>
