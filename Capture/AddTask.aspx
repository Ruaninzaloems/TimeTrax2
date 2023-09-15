<%@ Page Language="vb" AutoEventWireup="false" Codebehind="AddTask.aspx.vb" Inherits="TimeTrax.AddTask" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
		<title>Add Task</title>
		<LINK href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
			<script language="javascript" src="<%=Request.ApplicationPath%>/Components/Scripts/AddTasks.js"></script>
			<script language="javascript">
				function closeAdd()
					{
						opener.document.Form1.btnSave.click();
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
			<table class="t4" align="center" border="0" width="100%">
				<tr>
				 <td>
						<asp:PlaceHolder ID="taskPlace" Runat="server"></asp:PlaceHolder>
			 			<table id="tblTasks" name="tblTasks" align="center" border="0" width="100%" runat="server">
			 			</table>
				 </td>
				</tr>
				<tr>
					<td align="center">
						<asp:Button id="btnSubmit" runat="server" Text="Add Selected Tasks" Cssclass="button"></asp:Button>
						<INPUT type="button" id="btnClose" onclick="closeWin();" class="button" value="Cancel">
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
