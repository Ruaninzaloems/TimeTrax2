<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ExpenseSubmitted.aspx.vb" Inherits="TimeTrax.ExpenseSubmitted"%>
<%@ Register TagPrefix="uc1" TagName="ExpensesReport" Src="../Components/User Controls/ExpensesReport.ascx" %>
<HTML>
	<head>
		<link href="<%=Request.ApplicationPath%>/app_style.css" type="text/css" rel="stylesheet">
	</head>
	<title>Submitted Expenses</title>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="t4" width="100%">
				<tr>
					<td  class="td" >
						<uc1:ExpensesReport id="ucExpensesReport" runat="server"></uc1:ExpensesReport>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
