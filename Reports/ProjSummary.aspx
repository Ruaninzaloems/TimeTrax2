<%@ Register TagPrefix="uc1" TagName="ProjectSummary" Src="../Components/User Controls/ProjectSummary.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjSummary.aspx.vb" Inherits="TimeTrax.ProjSummary"%>
<%@ Register TagPrefix="im" Namespace="Intermap.Controls" Assembly="Intermap.Controls, Version=1.0.0.0, Culture=neutral, PublicKeyToken=35fce467599d164a" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
<body onload="initFilters();">
	<im:header id="ucHeader" runat="server"></im:header>
	<SCRIPT language="JavaScript" src="../Components/Scripts/filterObject.js"></SCRIPT>
	<SCRIPT language="JavaScript" src="../Components/Scripts/DropDownFilter.js"></SCRIPT>
	<form id="Form1" method="post" runat="server">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td><im:toptabs id="ucTopTabs" runat="server"></im:toptabs></td>
			</tr>
		</table>
		<table class="t3" width="100%">
			<tr>
				<td>
					<table class="t4" width="100%">
						<tr>
							<th class="th" colspan="4">
								Report Filters
							</th>
						</tr>
						<tr>
							<td class="td">Client :</td>
							<td colSpan="3" class="td"><asp:dropdownlist id="ddlClient" onchange="filter('2',this,true);" DataTextField="ClientName" DataValueField="ClientID"
									CssClass="select" Width="100%" runat="server" name="ddlClient"></asp:dropdownlist>
								<INPUT id="hidClientID" type="hidden" runat="server" NAME="hidClientID">
							</td>
						</tr>
						<tr>
							<td class="td">Project :</td>
							<td class="td" colSpan="3"><asp:dropdownlist id="ddlProject" DataTextField="ProjectName" DataValueField="ProjectID" CssClass="select"
									Width="100%" runat="server" name="ddlProject"></asp:dropdownlist>
								<INPUT id="hidProjectID" type="hidden" runat="server" NAME="hidProjectID">
								<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="Please select a Project"
									ControlToValidate="ddlProject" InitialValue="0" Display="None"></asp:RequiredFieldValidator>
							</td>
						</tr>
						<tr>
							<td class="td">Period :</td>
							<td class="td"><IM:IMTextBox id="txtStartDate" runat="server" Width="100" CssClass="input" RequiredValidationError="Please enter a Period Start Date"
									TextType="Date"></IM:IMTextBox>
							</td>
							<td class="td" align="center">to</td>
							<td class="td"><im:IMTextBox id="txtEndDate" runat="server" Width="100" CssClass="input" RequiredValidationError="Please enter a Period End Date"
									TextType="Date"></im:IMTextBox>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="4">
								<asp:button CssClass="button" id="btnGenerate" runat="server" name="btnGenerate" Text="Generate Report"></asp:button>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div id="divReport" runat="server">
						<uc1:ProjectSummary id="ucProjectSummary" runat="server"></uc1:ProjectSummary>
					</div>
				</td>
			</tr>
		</table>
		<im:footer id="ucFooter" runat="server"></im:footer>
	</form>
</body>
