//This function disables the drop down filter if the Awaiting Closeout checkbox is ticked
function DisableDropDowns(obj)
{
	if (document.all.chkPassedCloseDate.checked == true)
	{
		document.all.ddlTeamLeader.disabled = true;
		document.all.ddlTeamLeader.value = 0;
		document.all.ddlClient.disabled = true;
		document.all.ddlClient.value = 0;
	}
	else
	{
		document.all.ddlTeamLeader.disabled = false;
		document.all.ddlClient.disabled = false;
	}
}