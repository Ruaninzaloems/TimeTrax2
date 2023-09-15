<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ProjectDocuments.ascx.vb" Inherits="TimeTrax.ProjectDocuments" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script language="javascript" src="<%=Request.ApplicationPath%>\Components\Scripts\ProjectDocument.js" ></script>
<tr> <!--Document Uploads-->
	<th class="th1" height="22">
		<IMG id="menu10a" style="LEFT: 0px; CURSOR: hand; TOP: 3px" onclick="ToggleDisplay(menu10a, menu10b);"
			height="12" alt="" src="../images/up.gif" width="12" vspace="2" border="0" align="right">
		<SPAN style="CURSOR: hand; TOP: 2px" onclick="ToggleDisplay(menu10a, menu10b);">Project 
			Documents</SPAN>
		<BR clear="all">
	</th>
</tr>
<tr>
	<td>
		<SPAN id="menu10b" style="DISPLAY: block">
			<TABLE id="tblProjectDocuments" width="100%" name="tblProjectDocuments" class="t1" runat="server">
				<tr>
					<td>
						<img src="../images/jpg.gif" alt="View Document" style="CURSOR: hand" onclick="javascript: openDocumentPage('/Timetrax/Upload/Documents/C103J001_doc006.jpg');">
					</td>
				</tr>
			</TABLE>
		</SPAN>
	</td>
</tr>
