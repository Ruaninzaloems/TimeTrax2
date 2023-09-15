<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Selections.ascx.vb" Inherits="TimeTrax.Selections" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<SCRIPT language="JavaScript" src="../Components/Scripts/filterObject.js"></SCRIPT>
<SCRIPT language="JavaScript">
	var objLevel2;
	var objLevel3;

	function init() {
	// Load the array objects with the initial values
		try {objLevel2 = new filterObj(Form1.ucRepSelections_ddlLevel2);}
		catch(ex) {}
		try {objLevel3 = new filterObj(Form1.ucRepSelections_ddlLevel3);}
		catch(ex) {}

	// Populate the droplists with the related parent id options
		try {
			objLevel2.populate(Form1.ucRepSelections_ddlLevel1.value,false,false);
			if(document.all.hidLvl2.value!='') {
				Form1.ucRepSelections_ddlLevel2.value = document.all.hidLvl2.value;
			}
		}
		catch(ex) {}
		try {
			objLevel3.populate(Form1.ucRepSelections_ddlLevel2.value,false,false);
			if(document.all.hidLvl3.value!='') {
				Form1.ddlLevel3.value = document.all.hidLvl3.value;
			}
		}
		catch(ex) {}
	}

	function filter(type,obj,allowAll) {
		if(allowAll==undefined) { var allowAll=false; }
		switch(type)
		{
			case '2':
				objLevel2.populate(obj.value,allowAll,false);
				// Repopulate nested levels also
				filter('3',Form1.ucRepSelections_ddlLevel2,allowAll,false);
				break;
			case '3':
				objLevel3.populate(obj.value,allowAll,false);
				break;
		}
	}
</SCRIPT>
<table cellSpacing="0" cellPadding="2" width="100%" border="0">
	<tr>
		<td class="td" vAlign="top" align="right" width="20%">Client :</td>
		<td vAlign="top" align="left" width="30%"><asp:dropdownlist id="ddlLevel1" onchange="filter('2',this,true);" DataTextField="ClientName" DataValueField="ClientID"
				CssClass="select" Width="90%" runat="server" name="ddlLevel1"></asp:dropdownlist></td>
		<td>&nbsp;</td>
		<td class="td" vAlign="top" align="right" width="20%" rowSpan="3">Select Users :</td>
		<td class="td" vAlign="top" width="30%" rowSpan="3">
			<P><asp:listbox id="lstUsers" DataTextField="UserName" DataValueField="UserID" CssClass="select"
					Width="90%" name="_lstUsers" Rows="9" SelectionMode="Multiple" Runat="server" Height="120px"></asp:listbox></P>
			<P><b>Note:</b> By default all users are selected</P>
		</td>
	</tr>
	<tr>
		<td class="td" vAlign="top" align="right">Project :</td>
		<td vAlign="top" align="left"><asp:dropdownlist id="ddlLevel2" onchange="filter('3',this,true);" DataTextField="ProjectName" DataValueField="ProjectID"
				CssClass="select" Width="90%" runat="server" name="ddlLevel2"></asp:dropdownlist></td>
		<td colSpan="3"></td>
	</tr>
	<tr>
		<td class="td" vAlign="top" align="right">Task :</td>
		<td vAlign="top" align="left"><asp:dropdownlist id="ddlLevel3" DataTextField="TaskName" DataValueField="TaskID" CssClass="select"
				Width="90%" runat="server" name="ddlLevel3"></asp:dropdownlist></td>
		<td colSpan="3"></td>
	</tr>
	<tr>
		<td class="td" vAlign="top" align="right">Group By&nbsp;: 1<br>
			2</td>
		<td vAlign="top"><select class="select" id="_lstGroupBy" style="WIDTH: 90%" size="2" name="_lstGroupBy">
				<option value="Task">Task</option>
				<option value="User">User</option>
			</select>
		</td>
		<td width="10"><IMG style="CURSOR: hand" onclick="MoveUp(_lstGroupBy);" alt="Click to move the selected item up"
				src="../images/up.gif" border="0"> <IMG style="CURSOR: hand" onclick="MoveDown(_lstGroupBy);" alt="Click to move the selected item down"
				src="../images/down.gif" border="0">
		</td>
		<td>&nbsp;</td>
		<td class="td"><input id="chkTotals" type="checkbox" name="chkTotals"> Show 
			Sub-totals</td>
	</tr>
</table>
