<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ReportFilters.ascx.vb" Inherits="TimeTrax.ReportFilters" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script language=javascript 
src="<%=Request.ApplicationPath%>/Components/Scripts/Reports.js"></script>
<script language=javascript 
src="<%=Request.ApplicationPath%>/Components/Scripts/IMCalendar.js"></script>
<SCRIPT language=JavaScript 
src="<%=Request.ApplicationPath%>/Components/Scripts/filterObject.js"></SCRIPT>
<SCRIPT language=JavaScript 
src="<%=Request.ApplicationPath%>/Components/Scripts/ReportFilters.js"></SCRIPT>
<SCRIPT type="text/javascript" >

   
	<%=ProjectJavascriptKeyValue%>

    <%=TaskJavascriptKeyValue%>

	

	function AddProjects() {

		//<option value="Please select">Text 0</option>

		var ddlProject = document.getElementById("ucReportFilters_ddlProject");
        ddlProject.options.length = 0;
		var outerHTML = ddlProject.outerHTML;
        outerHTML = outerHTML.replace("</SELECT>", "");
		var ProjectSelect = document.getElementById("ProjectSelect");

        var ddlClient = document.getElementById("ucReportFilters_ddlClient");
        var ClientID = ddlClient.options[ddlClient.selectedIndex].value;

		var optionshtml = "<option value=\"0\">All</option>";

		for (index in AllProjects) {

            var arrTemp = index.split('#');
			var CurrentClientID = arrTemp[0];


			if (CurrentClientID == ClientID) {

                optionshtml = optionshtml + "<option value=\"" + arrTemp[1] + "\">" + AllProjects[index] + "</option>";
			}
        }

        ProjectSelect.innerHTML = outerHTML + optionshtml + "</SELECT>";
         
	}



    function AddTasks() {

        //<option value="Please select">Text 0</option>

        var ddlTask = document.getElementById("ucReportFilters_ddlTask");
        ddlTask.options.length = 0;
        var outerHTML = ddlTask.outerHTML;
		outerHTML = outerHTML.replace("</SELECT>", "");
		var ddlProject = document.getElementById("ucReportFilters_ddlProject");
        var ProjectID = ddlProject.options[ddlProject.selectedIndex].value;	

        var TaskSelect = document.getElementById("TaskSelect");		           

        var optionshtml = "<option value=\"0\">All</option>";
        for (index in AllTasks) {

            arrTemp = index.split('#');
            var CurrentProjectID = arrTemp[0];


            if (CurrentProjectID == ProjectID) {

                optionshtml = optionshtml + "<option value=\"" + arrTemp[1] + "\">" + AllTasks[index] + "</option>";
            }
        }

        TaskSelect.innerHTML = outerHTML + optionshtml + "</SELECT>";

    }


</SCRIPT>



<table class="t4" width="100%" align="center">
	<tr>
		<th class="th" colSpan="4">
			Report Filters</th></tr>
	<tr>
		<td class="td" align="right" width="20%">Client :</td>
		<td align="left" width="30%"><asp:dropdownlist id="ddlClient" onchange="AddProjects();" DataTextField="ClientName" DataValueField="ClientID"
				CssClass="select" Width="90%" runat="server" name="ddlClient"></asp:dropdownlist><INPUT id="hidClientID" type="hidden" name="hidClientID" runat="server"></td>
		<td class="td" vAlign="top" align="right" width="20%" rowSpan="3">Select Users :</td>
		<td class="td" width="30%" rowSpan="5">
			<P><asp:listbox id="lstUsers" DataTextField="UserName" DataValueField="UserID" CssClass="select"
					Width="90%" name="_lstUsers" Rows="9" SelectionMode="Multiple" Runat="server" Height="120px"></asp:listbox></P>
		</td>
	</tr>
	<tr>
		<td class="td" align="right">Project :</td>
		<td align="left">
			<span id="ProjectSelect"><asp:dropdownlist id="ddlProject" onchange="AddTasks();" DataTextField="ProjectName" DataValueField="ProjectID"
				CssClass="select" Width="90%" runat="server" name="ddlProject">
			                         </asp:dropdownlist></span><INPUT id="hidProjectID" type="hidden" name="hidProjectID" runat="server"></td>
	</tr>
	<tr>
		<td class="td" align="right"><asp:label id="lblTask" runat="server">Task :</asp:label></td>
		<td align="left"><span id="TaskSelect"><asp:dropdownlist id="ddlTask" DataTextField="TaskName" DataValueField="TaskID" CssClass="select"
				Width="90%" runat="server" name="ddlTask"></asp:dropdownlist></span><INPUT id="hidTaskID" type="hidden" name="hidTaskID" runat="server"></td>
	</tr>
	<tr>
		<td class="td" align="right"><asp:label id="lblGroupBy" runat="server">Group By&nbsp;: 1<br>
			2</asp:label></td>
		<td><select class="select" id="_lstGroupBy" style="WIDTH: 90%" size="2" name="_lstGroupBy" runat="server"></select>
		</td>
		<td align="left" width="10"><IMG id="imgGroupUp" style="CURSOR: hand" onclick="MoveUp(ucReportFilters__lstGroupBy);"
				alt="Click to move the selected item up" src="../../images/up.gif" border="0" runat="server">
			<IMG id="imgGroupDown" style="CURSOR: hand" onclick="MoveDown(ucReportFilters__lstGroupBy);"
				alt="Click to move the selected item down" src="../../images/down.gif" border="0"
				runat="server">
		</td>
	</tr>
	<tr>
		<td class="td" align="right">Capture Type :</td>
		<td align="left"><asp:dropdownlist id="ddlCaptureType" DataTextField="ProjectName" DataValueField="ProjectID" CssClass="select"
				Width="90%" runat="server" name="ddlLevel2"></asp:dropdownlist></td>
		<td colSpan="2"></td>
	</tr>
	<tr id="trMonth1" runat="server">
		<td class="td" align="right">View by :</td>
		<td>
			<asp:radiobutton id="optDateView" CssClass="select" onclick="ShowHideExpenseMonth();" runat="server"
				GroupName="optExpenseMonth" Text="Expense Date"></asp:radiobutton>
			<asp:radiobutton id="optMonthView" CssClass="select" runat="server" GroupName="optExpenseMonth" Text="Expense Month"
				onclick="ShowHideExpenseMonth();"></asp:radiobutton>
		</td>
		<td colspan="2"></td>
	</tr>
	<tr id="trMonth2" runat="server">
		<td align="right" class="td">Expense Month :</td>
		<td align="left"><asp:dropdownlist id="ddlMonth" CssClass="select" runat="server" name="ddlMonth"></asp:dropdownlist>&nbsp;
			<asp:dropdownlist id="ddlYear" CssClass="select" runat="server" name="ddlYear"></asp:dropdownlist>
		</td>
		<td colSpan="2"></td>
	</tr>
	<tr>
		<td class="td" align="right" width="20%">Start :</td>
		<td width="30%"><asp:textbox id="txtStartDate" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"
				name="txtStartDate" Width="100" Runat="server" cssclass="input"></asp:textbox>
			<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
			<div id="divStartDate" style="POSITION: absolute"></div>
			<IMG id="StartDate" style="CURSOR: hand" onclick="imcalendar.select(document.Form1['ucReportFilters_txtStartDate'], 'divStartDate', 'dd/MM/yyyy'); return false;"
				src="<%=Request.ApplicationPath%>/Images/CALENDAR.GIF" border="0" name="StartDate">
			<asp:requiredfieldvalidator id="rfvStartDate" Runat="Server" ErrorMessage="Please enter a Start date" Display="None"
				ControlToValidate="txtStartDate"></asp:requiredfieldvalidator></td>
		<td class="td" align="right" width="20%">End :</td>
		<td width="30%"><asp:textbox id="txtEndDate" onblur="ValidateDisplayDate('Please enter the date in the DD/MM/YYYY format.', this);"
				name="txtEndDate" Width="100" Runat="server" cssclass="input"></asp:textbox>
			<!--For the calendar, you need the div tag to show where to position the calendar, and the image to click on. Update the textbox to populate, and the anchor to reference-->
			<div id="divEndDate" style="POSITION: absolute"></div>
			<IMG id="EndDate" style="CURSOR: hand" onclick="imcalendar.select(document.Form1['ucReportFilters_txtEndDate'], 'divEndDate', 'dd/MM/yyyy'); return false;"
				src="<%=Request.ApplicationPath%>/Images/CALENDAR.GIF" border="0" name="EndDate">
			<asp:requiredfieldvalidator id="rfvEndDate" Runat="Server" ErrorMessage="Please enter an End date" Display="None"
				ControlToValidate="txtEndDate"></asp:requiredfieldvalidator></td>
	</tr>
	<tr id="trUser" runat="server">
		<td align="right"><asp:radiobutton id="optDetail" CssClass="select" Width="152px" runat="server" GroupName="optUser"
				Text="Show Details" Checked="True"></asp:radiobutton></td>
		<td><asp:radiobutton id="optUser" CssClass="select" runat="server" GroupName="optUser" Text="Show User Summary"></asp:radiobutton></td>
		<td colSpan="2"></td>
	</tr>
	<tr>
		<td align="center" colSpan="4"><input id="grouping_list" type="hidden" name="grouping_list" runat="server">
			<input id="hidProjRequired" type="hidden" name="hidProjRequired" runat="server">
			<input class="button" id="htmlGenerate" onclick="loadGroupList(document.Form1);" type="button"
				value="Generate Report">
			<asp:button id="btnGenerate" CssClass="inputhidden" runat="server" name="btnGenerate" Text="Generate Report"></asp:button></td>
	</tr>
	<tr>
		<td colSpan="4"><asp:customvalidator id="CustomValidator1" runat="server" ErrorMessage="CustomValidator" Display="None"
				ClientValidationFunction="ValidateProject"></asp:customvalidator><asp:validationsummary id="ValidationSummary1" style="Z-INDEX: 103; LEFT: 16px" Width="696px" runat="server"
				Height="88px" ShowSummary="False" ShowMessageBox="True"></asp:validationsummary>
		
		</td>
	</tr>
</table>

<SCRIPT type="text/javascript" >

    var ddlClient = document.getElementById("ucReportFilters_ddlClient");
	var ClientID = ddlClient.options[ddlClient.selectedIndex].value;

	if (ClientID > 0) {

		AddProjects();
        document.getElementById("ucReportFilters_ddlProject").value = document.getElementById("ucReportFilters_hidProjectID").value
        AddTasks();
        document.getElementById("ucReportFilters_ddlTask").value = document.getElementById("ucReportFilters_hidTaskID").value



    }


</SCRIPT>
