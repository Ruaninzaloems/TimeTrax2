<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes" />

	<xsl:attribute-set name="optClients">
		<xsl:attribute name="value">
			<xsl:value-of select="@ClientID" />
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="optUsers">
		<xsl:attribute name="value">
			<xsl:value-of select="@UserID" />
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="optProjects">
		<xsl:attribute name="value">
			<xsl:value-of select="@ProjectID" />
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="optTasks">
		<xsl:attribute name="value">
			<xsl:value-of select="@TaskID" />
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:param name="SelectedClientID" select="0" />
	<xsl:param name="SelectedProjectID" select="0" />
	
	<xsl:template match="/">

		<table border="0" width="100%" cellpadding="2" cellspacing="0">
			<tr>
				<td align="right" class="td" width="20%">Client :</td>
				<td align="left" width="30%">
					<select id="pOptionClient" name="pOptionClient" class="select" style="width:90%;" onchange="document.Form1.submit();">
						<option value="0">All</option>
						<xsl:call-template name="Clients" />
					</select>
				</td>
				<td align="right" valign="top" class="td" rowspan="3" width="20%">Users :</td>
				<td  rowspan="3" valign="top" width="30%">
					<select id="_lstUsers" name="_lstUsers" multiple="true" size="9" style="width:90%" class="select">
						<xsl:call-template name="Users" />
					</select>
				</td>
			</tr>
			<tr>
				<td align="right" class="td">Project :</td>
				<td align="left">
					<select id="pOptionProject" name="pOptionProject" class="select" style="width:90%;" onchange="document.Form1.submit();">
						<option value="0">All</option>
						<xsl:call-template name="Projects" />
					</select>
				</td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td align="right" class="td">Task :</td>
				<td align="left">
					<select id="pOptionTask" class="select" style="width:90%;">
						<option selected="selected" value="0">All</option>
						<xsl:call-template name="Tasks" />
					</select>
				</td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td align="right" vAlign="top" class="td">Grouping :</td>
				<td>
					<select id="_lstGroupBy" name="_lstGroupBy" size="2" class="select" style="width:90%;">
						<option value="Task">Task</option>
						<option value="User">User</option>
					</select>
				</td>
				<td width="10">
					<IMG style="CURSOR: hand" onclick="MoveUp(_lstGroupBy);" alt="Click to move the selected item up" src="../images/up.gif" border="0" />
					<IMG style="CURSOR: hand" onclick="MoveDown(_lstGroupBy);" alt="Click to move the selected item down" src="../images/down.gif" border="0" />
				</td>
				<td class="td"><input id="chkTotals" name="chkTotals" type="checkbox" /> Total Project</td>
			</tr>
		</table>
		
		<script>
				<xsl:comment><![CDATA[ 
				document.Form1.pOptionClient.selectedIndex = getDDLselectedIndex(document.Form1.pOptionClient,]]>
			<xsl:value-of select="$SelectedClientID" /><![CDATA[)
				document.Form1.pOptionProject.selectedIndex = getDDLselectedIndex(document.Form1.pOptionProject,]]>
			<xsl:value-of select="$SelectedProjectID" /><![CDATA[)
			]]> </xsl:comment>
		</script>

	</xsl:template>
	
	
	<xsl:template name="Clients">
		<xsl:for-each select="//Client">
			<xsl:sort select="@ClientName" />
			<option xsl:use-attribute-sets="optClients">
				<xsl:value-of select="@ClientName" />
			</option>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="Projects">
		<xsl:choose>
			<xsl:when test="$SelectedClientID = 0">
				<!-- All Clients selected, so show all Projects -->
				<xsl:for-each select="//Project">
					<xsl:sort select="@ProjectName" />
					<option xsl:use-attribute-sets="optProjects">
						<xsl:value-of select="@ProjectName" />
					</option>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<!-- Specific Client selected, so show all Projects for selected Client -->
				<xsl:for-each select="//Project[@ClientID=$SelectedClientID]">
					<xsl:sort select="@ProjectName" />
					<option xsl:use-attribute-sets="optProjects">
						<xsl:value-of select="@ProjectName" />
					</option>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Tasks">
		<xsl:choose>
			<xsl:when test="$SelectedClientID != 0 and $SelectedProjectID = 0">
				<!-- Specific Client selected, so show all Tasks for selected Client Projects -->
				<xsl:for-each select="//Task[@ClientID=$SelectedClientID]">
					<xsl:sort select="@TaskName" />
					<option xsl:use-attribute-sets="optTasks">
						<xsl:value-of select="@TaskName" />
					</option>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$SelectedProjectID = 0">
				<!-- Show all Projects -->
				<xsl:for-each select="//Task">
					<xsl:sort select="@TaskName" />
					<option xsl:use-attribute-sets="optTasks">
						<xsl:value-of select="@TaskName" />
					</option>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<!-- Specific Project selected, so show all Tasks for selected Project -->
				<xsl:for-each select="//Task[@ProjectID=$SelectedProjectID]">
					<xsl:sort select="@TaskName" />
					<option xsl:use-attribute-sets="optTasks">
						<xsl:value-of select="@TaskName" />
					</option>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="Users">
		<xsl:for-each select="//User">
			<xsl:sort select="@UserName"/>
			<xsl:sort select="@UserName" />
			<option xsl:use-attribute-sets="optUsers">
				<xsl:value-of select="@UserName" />
			</option>
		</xsl:for-each>
	</xsl:template>

	

</xsl:stylesheet>
