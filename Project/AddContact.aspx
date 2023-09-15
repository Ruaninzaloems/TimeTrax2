<%@ Page Language="vb" AutoEventWireup="false" Codebehind="AddContact.aspx.vb" Inherits="TimeTrax.AddContact"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
		<title>Add New Contact</title>
		<LINK href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
			<script language="javascript">
	function closeAdd(typ)
		{
			//SB: 15/07/2005 - Removed as disabeling the drop down means that the value can't be 
			//read when the page is submitted and hence you get an error
			//if(typ=='a'){
			//opener.document.Form1.ddlAdmin.disabled = true;
			//} else {
			//opener.document.Form1.ddlContact.disabled = true;
			//}
			window.close();
		}
	function closeWin()
		{
			window.close();
		}
			</script>
</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="t4" align="center" border="0">
				<tr>
					<th colspan="3" class="th">
						New Contact</th>
				</tr>
				<tr>
					<td class="td">Title: <font color="red">*</font></td>
					<td class="td" colspan="2">
						<asp:dropdownlist id=ddlTitle runat="server" DataValueField="TitleID" DataTextField="Title" CssClass="select"></asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td class="td">First Name:</td>
					<td class="td" colspan="2">
						<asp:TextBox id="txtName" runat="server" CssClass="input"></asp:TextBox>
						<asp:RequiredFieldValidator id="rfvName" runat="server" InitialValue="" ControlToValidate="txtName" Display="None" ErrorMessage="Please enter a First Name"></asp:RequiredFieldValidator>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="td">Last Name:</td>
					<td class="td" colspan="2">
						<asp:TextBox id="txtSurname" runat="server" CssClass="input"></asp:TextBox>
						<asp:RequiredFieldValidator id="rfvSurname" runat="server" InitialValue="" ControlToValidate="txtSurname" Display="None" ErrorMessage="Please enter a Last Name"></asp:RequiredFieldValidator>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="td">Department:</td>
					<td class="td" colspan="2">
						<asp:TextBox id="txtDept" runat="server" CssClass="input"></asp:TextBox>
						<asp:RequiredFieldValidator id="rfvDept" runat="server" InitialValue="" ControlToValidate="txtDept" Display="None" ErrorMessage="Please enter a Department"></asp:RequiredFieldValidator>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="td">eMail:</td>
					<td class="td" colspan="2">
						<asp:TextBox id="txtEmail" runat="server" CssClass="input"></asp:TextBox>
						<asp:regularexpressionvalidator id="regexEmail" runat="server" ErrorMessage="Please enter a valid Email"
							ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" Display="None"></asp:regularexpressionvalidator>
						<asp:RequiredFieldValidator id="rfvEmail" runat="server" InitialValue="" ControlToValidate="txtEmail" Display="None" ErrorMessage="Please enter an email address"></asp:RequiredFieldValidator>
							<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="td">Phone Number:</td>
					<td class="td" colspan="2">
						<asp:TextBox id="txtTel" runat="server" CssClass="input"></asp:TextBox>
						<asp:RequiredFieldValidator id="rfvTel" runat="server" InitialValue="" ControlToValidate="txtTel" Display="None" ErrorMessage="Please enter a Phone number"></asp:RequiredFieldValidator>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="td">Fax:</td>
					<td class="td" colspan="2">
						<asp:TextBox id="txtFax" runat="server" CssClass="input"></asp:TextBox>
						<asp:RequiredFieldValidator id="rfvFax" runat="server" InitialValue="" ControlToValidate="txtFax" Display="None" ErrorMessage="Please enter a Fax number"></asp:RequiredFieldValidator>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="td" align="right">
						<asp:CheckBox id="chkEnabled" Text="Enabled" TextAlign="Right" Checked="True" runat="server"></asp:CheckBox>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<asp:Button id="btnSubmit" runat="server" Text="Submit" Cssclass="button"></asp:Button>
					</td>
					<td align="left" width="50%">
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
