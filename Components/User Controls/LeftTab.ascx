<%@ Control Language="vb" AutoEventWireup="false" Codebehind="LeftTab.ascx.vb" Inherits="TimeTrax.LeftTab" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<td vAlign="top" width="130px">
	<br>
	<br>
	<table width="98%" id="tblLeftTab" border="0" cellspacing="0" cellpadding="0" class="t4a"
		align="center">
		<tr>
			<td align="center" class="td8">
				<asp:datalist id="LeftTab" RepeatDirection="Vertical" EnableViewState="false" CellPadding="0"
					CellSpacing="0" runat="server">
					<itemtemplate>
						<div Style='Display:<%# CType(Container.DataItem, TimeTrax.BusinessLogicLayer.LeftTabs).Display %>'>
							<a Class="menuoff2" href='<%= Request.ApplicationPath %>/<%# CType(Container.DataItem, TimeTrax.BusinessLogicLayer.LeftTabs).Path %>'>
								<%# CType(Container.DataItem, TimeTrax.BusinessLogicLayer.LeftTabs).Name %>
							</a>
						<br>
						<br>
						</div>
					</itemtemplate>
					<selecteditemtemplate>
						<a Class="menuon2" href='<%= Request.ApplicationPath %>/<%# CType(Container.DataItem, TimeTrax.BusinessLogicLayer.LeftTabs).Path %>'>
							<%# CType(Container.DataItem, TimeTrax.BusinessLogicLayer.LeftTabs).Name %>
						</a>
						<br>
						<br>
					</selecteditemtemplate>
				</asp:datalist>
			</td>
		</tr>
	</table>
</td>
