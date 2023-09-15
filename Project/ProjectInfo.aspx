<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectInfo.aspx.vb" Inherits="TimeTrax.ProjectInfo"%>
<%@ Register TagPrefix="im" TagName="Header" Src="../Components/User Controls/Header.ascx" %>
<%@ Register TagPrefix="im" TagName="ProjInfo" Src="../Components/User Controls/ProjectInfo.ascx" %>
<%@ Register TagPrefix="im" TagName="TopTabs" Src="../Components/User Controls/TopTabs.ascx" %>
<%@ Register TagPrefix="im" TagName="Footer" Src="../Components/User Controls/Footer.ascx" %>
<script language="javascript" src="..\Components\Scripts\DynamicAdd.js" ></script>
<script language="javascript" src="..\Components\Scripts\ProjInfo.js" ></script>
<script language="javascript" src="..\Components\Scripts\Details.js" ></script>
<body onload="LoadProjInfoDynamics();">
<body>
	<im:Header id="ucHeader" runat="server"></im:Header>
	<form id="Form1" method="post" runat="server">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="tdmenu">
					<im:TopTabs id="ucTopTabs" runat="server"></im:TopTabs>
				</td>
			</tr>
		</table>
		<table class="t4" width="100%">
			<tr>
				<th class="th">
					Project Information</th>
			</tr>
			<tr>
				<td vAlign="top" class="td3">
					<table width="98%" align="center">
						<TBODY>
							<tr>
								<td>
									<br>
									<table class="t1" width="98%" align="center">
										<tr>
											<td colspan="3">
												<im:ProjInfo id="ucProjInfo" runat="server"></im:ProjInfo>
											</td>
										</tr>
										<tr>
											<td colspan="3" align="center">
												 <input id="hidProjID" type="hidden" name="hidProjID" runat="server"> 
												 <input class="button" onclick="uploadDocument();" type="button" value="Upload Documents">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</TBODY>
					</table>
				</td>
			</tr>
		</table>
		<im:Footer id="ucFooter" runat="server"></im:Footer>
	</form>
</body>
