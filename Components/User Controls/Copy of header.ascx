<%@ Control Language="vb" AutoEventWireup="false" Codebehind="header.ascx.vb" Inherits="TimeTrax.header" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<script language="javascript">
//SB: 12/08/2005 - Code removed as this doesn't work for an environment which is not like DIMS ie.
//Pressing the back button, CTRL F5, or entering on the navigation bar - cause this to pop up as well
//function window.onbeforeunload() 
//{
//	if ((event.clientX < 0) || (event.clientY < 0))
//	{
//		event.returnValue = 'By closing this window, you will be closing Timetrax™. \nPlease ensure that you have saved your information before you leave.';
//	}
//}
</script>
<HTML>
  <HEAD><TITLE><%= Session("PageTitle") %></TITLE>
		<link href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
			<script language="javascript" src="/TimeTrax/Components/Scripts/countdown.js"></script>
			<script language="javascript" src="/TimeTrax/Components/Scripts/common.js"></script>
			<%= Session("PageScripts") %>
	</HEAD>
	<%= Session("PageBody") %>
	<!-- Hidden fields used for timepopup page and openTimePopUp function -->
	<input type="hidden" id="hidAppPath" name="hidAppPath" runat="server" />
	<input type="hidden" id="hidUserID" name="hidUserID" runat="server" />
	<asp:placeholder id="phError" runat="server"></asp:placeholder>		
	<table id="tblPage" class="PageFrame">
		<tr>
			<td>
				<table id="tblHeader">
					<tr>
						<td><img src="/TimeTrax/images/banner.jpg"></td>
					</tr>
					<tr>
						<td class="td" vAlign="top" align="center">Welcome <%= Session("usrName") %><br>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
			<table id="tblTopTabs">
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
					