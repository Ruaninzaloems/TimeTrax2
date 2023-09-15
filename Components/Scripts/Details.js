//SD: 07/09/2005 - Function to show Client Information
function viewClientDetails(ClientID)
{
	var URL, AppPath;
	AppPath = document.all.ucHeader_hidAppPath.value;
	URL = AppPath + "/Details/ClientDetails.aspx?ClientID=" + ClientID;
	window.open(URL,"Popup","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=500,height=450,top=150,left=200,resizable=1");
}
//SD: 08/09/2005 - Function to show Client Information
function viewContactDetails(ContactID)
{
	var URL, AppPath;
	AppPath = document.all.ucHeader_hidAppPath.value;
	URL = AppPath + "/Details/ContactDetails.aspx?ContactID=" + ContactID;
	window.open(URL,"Popup","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=500,height=350,top=150,left=200,resizable=1");
}

function openDocumentPage(URL)
{
	var win = window.open(URL, 'Request', 'toolbar=0,location=0,status=0,menubar=1,scrollbars=1,width=800,height=600,top=0,left=0,resizable');     
}
