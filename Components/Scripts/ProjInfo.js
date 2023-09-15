//***********************************************************************
//                     This script was developed by:                    *
//                             VINCE FRIDAY								*
//                          ©Intermap (PTY) Ltd							*
//                           www.intermap.co.za							*
//                             Version 1.1								*
//***********************************************************************
function LoadProjInfoDynamics() {
	loadResources();
}

function loadResources()
{
var arrData, itemcount;
//Get the number of rows to add
itemcount = document.Form1.ucProjInfo_resourceLoadCount.value;
for (var i = 1; i <= itemcount; i++)
	{
		//Add a new line in the dynamic add
		arrData = document.Form1["ucProjInfo_hidBoxresource_"+i].value.split("#");
		addFormSection('resource', document.Form1);
		document.Form1["ucProjInfo_hidResourceID_"+i].value = arrData[0];
		document.Form1["ucProjInfo_txtResource_"+i].value = arrData[1];
		document.Form1["ucProjInfo_chkEnabled_"+i].checked = (arrData[2]=="True");
	}
}
function addResource()
{
	var URL, ProjID, AppPath;
	ProjID = document.Form1["ucProjInfo_hidProjID"].value;
	AppPath = document.all.ucHeader_hidAppPath.value;
	URL = AppPath + "/Project/AddResource.aspx?ProjID=" + ProjID;
	window.open(URL,"Popup","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=500,height=300,top=150,left=200,resizable=1");
}
function viewOrder(OrderID,ProjectID)
{
	var URL, AppPath;
	AppPath = document.all.ucHeader_hidAppPath.value;
	URL = AppPath + "/Project/OrderInfo.aspx?OrderID=" + OrderID + "&ProjectID=" + ProjectID;
	window.open(URL,"Popup","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=600,top=150,left=200,resizable=1");
}
function uploadFinancialDoc(ProjectID,OrderID,FinancialDocumentTypeID)
{
	var URL, AppPath;
	AppPath = document.all.ucHeader_hidAppPath.value;
	URL = AppPath + "/Project/UploadFinancialDoc.aspx?ProjectID=" + ProjectID + "&OrderID=" + OrderID + "&FinancialDocumentTypeID=" + FinancialDocumentTypeID;
	window.open(URL,"PopupFinDoc","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=500,top=150,left=200,resizable=1");
}
function ChangeTeamLeader(ProjectID,blnTeamLeader)
{
	var URL, AppPath;
	AppPath = document.all.ucHeader_hidAppPath.value;
	URL = AppPath + "/Project/ChangeTeamleader.aspx?ProjectID=" + ProjectID + "&blnTeamLeader=" + blnTeamLeader;
	window.open(URL,"Popup","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=500,height=200,top=150,left=200,resizable=1");
}
function DisableResource(obj,ProjectID)
{
	var URL, arrData, ResourceID, pfield, AppPath;
	
	//Retrieve the UserID
	arrData = obj.id.split("_");
	pfield = eval('document.Form1["ucProjInfo_hidResourceID_' + arrData[2] + '"]');
	ResourceID = pfield.value;
	
	AppPath = document.all.ucHeader_hidAppPath.value;
	URL = AppPath + "/Project/UpdateResource.aspx?ProjectID=" + ProjectID + "&ResourceID=" + ResourceID;
	window.open(URL,"Popup","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=500,height=200,top=150,left=200,resizable=1");
}
