<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="TopTabs.ascx.vb" Inherits="TimeTrax.TopTab" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" EnableViewState="False"%>
<TABLE class="t5" id="tblTabTop" cellspacing="0" cellpadding="0" border="0"
	runat="server">
	<TR>
		<TD>
			<img src="/TimeTrax/Images/leftendtab.gif" width="16" />
			<IM:IMXPMenu id="TopMenu" runat="server" spacerwidth="25px" ShowNavigationBar="False"></IM:IMXPMenu>
			<img src="/TimeTrax/Images/rightendtab.gif" align="left" width="16" />
		</TD>
	</TR>
</TABLE> <!-- End tblTabTop -->
