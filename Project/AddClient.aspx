<%@ Page Language="vb" AutoEventWireup="false" Codebehind="AddClient.aspx.vb" Inherits="TimeTrax.AddClient"%>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
		<title>Add New Client</title>
		<LINK href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
			<script language="javascript">
	function closeAdd()
		{
			//opener.document.Form1.ddlClient.disabled = true; - SB: 02/09/2005 - Don't disable the drop down as it is no longer needed
			window.close();
		}
	function closeWin()
		{
			opener.document.Form1.ddlClient[0].selected = true;
			window.close();
		}
			</script>
</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="t4" width="100%">
				<tr>
					<th class="th">
						New Client</th>
				</tr>
				<tr>
					<td valign="top" class="td3">
						<table width="90%" align="center" class="t1">
							<tr>
								<td class="td1">Client Code:</td>
								<td class="td2">
									<asp:TextBox id="txtCode" runat="server" CssClass="InputRO" ReadOnly="True"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="td1">Client Name:<FONT color="#ff0066">*</FONT></td>
								<td class="td2">
									<im:imtextbox id="txtName" runat="server" CssClass="Input" RequiredValidationError="Please enter the Client Name"
																TextType="AlphaNumeric" Width="100%" tabindex=1></im:imtextbox>
								</td>
							</tr>
							<tr>
								<td class="td2" colspan="2">
									<table cellpadding="0" cellspacing="5" align="center" border="0">
										<tr>
											<td class="td1" width="50%">Physical Address:</td>
											<td class="td1">Postal Address:<FONT color="#ff0066">*</FONT></td>
										</tr>
										<tr>
											<td class="td">
												<asp:TextBox id="txtPhyAdd" runat="server" CssClass="input" tabIndex="3"></asp:TextBox>
											</td>
											<td class="td">
												<asp:TextBox id="txtPosAdd" runat="server" CssClass="input" tabIndex="7"></asp:TextBox>
												<asp:RequiredFieldValidator id="rfvPosAdd" runat="server" InitialValue="" ControlToValidate="txtPosAdd" Display="None"
													ErrorMessage="Please enter the Postal Address"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td class="td">
												<asp:TextBox id="txtPhySuburb" runat="server" CssClass="input" tabIndex="4"></asp:TextBox>
											</td>
											<td class="td">
												<asp:TextBox id="txtPosSuburb" runat="server" CssClass="input" tabIndex="8"></asp:TextBox>
												<asp:RequiredFieldValidator id="rfvPosSuburb" runat="server" InitialValue="" ControlToValidate="txtPosSuburb"
													Display="None" ErrorMessage="Postal Address requires at least 2 lines"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td class="td">
												<asp:TextBox id="txtPhyCity" runat="server" CssClass="input" tabIndex="5"></asp:TextBox>
											</td>
											<td class="td">
												<asp:TextBox id="txtPosCity" runat="server" CssClass="input" tabIndex="9"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="td">
												<asp:TextBox id="txtPhyProvince" runat="server" CssClass="input" tabIndex="6"></asp:TextBox>
											</td>
											<td class="td">
												<asp:TextBox id="txtPosProvince" runat="server" CssClass="input" tabIndex="10"></asp:TextBox>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="td1">Post Code:<FONT color="#ff0066">*</FONT></td>
								<td class="td2">
									<asp:TextBox id="txtPosCode" runat="server" CssClass="input" tabIndex="11"></asp:TextBox>
									<asp:RequiredFieldValidator id="rfvPosCode" runat="server" InitialValue="" ControlToValidate="txtPosCode" Display="None"
										ErrorMessage="Please enter the Postal Code"></asp:RequiredFieldValidator>
								</td>
							</tr>
							<tr>
								<td class="td1">Country:<FONT color="#ff0066">*</FONT></td>
								<td class="td2">
									<asp:DropDownList id="ddlCountry" runat="server" CssClass="select" DataValueField="CountryID" DataTextField="CountryName"></asp:DropDownList>
									<asp:RequiredFieldValidator id="rfvCountry" runat="server" InitialValue="0" ControlToValidate="ddlCountry" Display="None"
										ErrorMessage="Please select a Country"></asp:RequiredFieldValidator>
								</td>
							</tr>
							<tr>
								<td class="td2" colspan="2" align="center">
									<asp:CheckBox id="chkEnabled" CssClass="label" Text="Enabled" TextAlign="Right" Checked="True"
										runat="server"></asp:CheckBox>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="td3" vAlign="top" align="center" colSpan="2">
						<asp:Button id="btnSubmit" runat="server" Text="Submit" Cssclass="button"></asp:Button>
						<INPUT type="button" id="btnClose" onclick="closeWin();" class="button" value="Cancel">
				</tr>
			</table>
		</form>
	</body>
</HTML>
