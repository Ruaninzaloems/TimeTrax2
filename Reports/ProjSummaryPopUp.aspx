<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjSummaryPopUp.aspx.vb" Inherits="TimeTrax.ProjSummaryPopUp"%>
<%@ Register TagPrefix="uc1" TagName="ProjectSummary" Src="../Components/User Controls/ProjectSummary.ascx" %>
<script language='javascript' src="<%=Request.ApplicationPath%>/Components/Scripts/printer.js"></script>
<head>
	<link href="<%=Request.ApplicationPath%>/app_style.css" type="text/css" rel="stylesheet">
</head>
<body>
	<title>Project Cost Summary</title>
	<form id="Form1" method="post" runat="server">
		<table class="t3" width="100%">			
			<tr>
				<td>
					<uc1:ProjectSummary id="ucProjectSummary" runat="server"></uc1:ProjectSummary>
				</td>
			</tr>
		</table>
	</form>
</body>