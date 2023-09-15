var FieldArr = new Array();

function LoadDynamics() {
	LoadOrderDynamics();
	loadResources();
}

function loadResources()
{
var arrData, itemcount;
//Get the number of rows to add
itemcount = document.Form1.resourceLoadCount.value;
for (var i = 1; i <= itemcount; i++)
	{
		//Add a new line in the dynamic add
		arrData = document.Form1["hidBoxresource_"+i].value.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
		addFormSection('resource', document.Form1);
		document.Form1["ddlResource_"+i].value = arrData[1];
		document.Form1["txtResource_"+i].value = arrData[3];
		if (typeof document.Form1["chkEnabled_"+i] != 'undefined')
		{
			document.Form1["chkEnabled_"+i].checked = (arrData[4]=="True");
		}
	}
}

function checkResourceDuplicates(obj, type) {
  // check that a resource does not appear more than once in the resources list
  // SB: 08/08/2005 - Added type, so that we can check that we don't have the same person as teamleader and admin manager
  // Type:	1 = This is an Approver1
  //		2 = This is an Approver2
  //		3 = This is an TSApprover1
  //		4 = This is an TSApprover2
  //		5 = This is a Teamleader
  //		6 = This is a team member
  if(obj.value!=0) {
		// Only check if something is selected
		
		if (type != 1)
		{
		// Check PTO Approver1
			var FieldName = "ddlApprover1";
			if(document.Form1[FieldName].options[document.Form1[FieldName].selectedIndex].value == obj.value) {
				alert('This resource has already been allocated for this project and may not be selected again');
				obj.selectedIndex = 0;
				return;
			}
		}
		
		if (type != 2)
		{
		// Check PTO Approver2
			var FieldName = "ddlApprover2";
			try {
				if(document.Form1[FieldName].options[document.Form1[FieldName].selectedIndex].value == obj.value) {
					alert('This resource has already been allocated for this project and may not be selected again');
					obj.selectedIndex = 0;
					return;
				}
			}
			catch (ex) {}
			
		}
		
		
		if ((type != 3) && (type != 5))  //Team leader and Manager can be the same person
		{
		// Check TS Approver1
			var FieldName = "ddlManager";
			try {
				if(document.Form1[FieldName].options[document.Form1[FieldName].selectedIndex].value == obj.value) {
					alert('This resource has already been allocated for this project and may not be selected again');
					obj.selectedIndex = 0;
					return;
				}
			}
			catch (ex) {}
		}
				
		if ((type != 5) && (type != 3)) //Team leader and Manager can be the same person
		{
		// Check TeamLeader
			var FieldName = "ddlTeamLeader";
			if(document.Form1[FieldName].options[document.Form1[FieldName].selectedIndex].value == obj.value) {
				alert('This resource has already been allocated for this project and may not be selected again');
				obj.selectedIndex = 0;
				return;
			}
		}
		
	
		
		// Check Team Members
		var row = 0;
		var rowArr = obj.id;
		rowArr = rowArr.split("_");
		row = rowArr[1];
		var arrlist = document.Form1['resource_list'].value, arrlen=0;
		arrlist = arrlist.split("#");		//SD: 19/10/2005 - Change dymanic adds from , to #
		if(arrlist.length > 2){
			arrlen = arrlist.length - 2;
		}
		for (var k=1; k<=arrlen; k++)
		{
			var FieldName = "ddlResource_"+arrlist[k];
			if(document.Form1[FieldName].options[document.Form1[FieldName].selectedIndex].value == obj.value) {
				if(arrlist[k]!= row) {
					// the row is not the selected row
					alert('This resource has already been allocated for this project and may not be selected again');
					obj.selectedIndex = 0;
					return;
				}
			}
		}
	}
}

function validatePage(obj) {
	// Enable Client, Contact and Admin Droplists if they have been disabled, 
	//if(Page_IsValid==true) { - SB Remove valid check - always enable
		document.Form1.ddlClient.disabled=false;
		document.Form1.ddlContact.disabled=false;
		document.Form1.ddlAdmin.disabled=false;
	//}
	var App1, App2, Mess, Mess2;
	App1 = document.Form1.txtApprover1.value; //CB: 08/05/2009 - Added code to check that page cannot be save or submitted
	App2 = document.Form1.txtTeamLeader.value;		//without all resources having rates
	Mess = "";
	Mess2 = "";
	if(App1=="")
	{
		Mess = "Admin Manager must have a rate. " + "\n";
	}
	
	if(App2=="")
	{
		Mess = Mess + "Team Leader must have a rate" + "\n";
	}
	
	//SD: 02/02/2010 - Added code to check that the Manager must have a rate if it is visible
	if (typeof(document.Form1.ddlManager) != "undefined")
	{	
		if (document.getElementById('txtManager').value == "")
		{
			Mess = Mess + "Manager must have a rate" + "\n";
		}
	}
	
	var arrlist = document.Form1['resource_list'].value, arrlen=0;
	var arrlen;

	//Get the number of rows added
	arrlist = arrlist.split("#");
	//if(arrlist.length > 2){
		arrlen = arrlist.length - 2;
	//}
	
	for(var i = 1; i <= arrlen; i++)
	{
		
		if(document.Form1['txtResource_' + arrlist[i]].value == "")
		{
			var w = document.Form1['ddlResource_' + arrlist[i]].selectedIndex;
			var resourcename = document.Form1['ddlResource_' + arrlist[i]].options[w].text;
			if(resourcename=='--Select a Team Member--')
			{
				Mess2 = "Please select a Team Member and make sure they have a rate." + "\n";
			} else {
				Mess = Mess + resourcename + " resource must have a rate." + "\n";
			}
		}
	}
		
	if((Mess=="") && (Mess2==""))
	{
		if(obj=='Submit') { 
			document.Form1.btnSubmit.click();
			//alert('submit');
		} else {
			//alert('save');
			document.Form1.btnSave.click();
		}
	} else {
		alert(Mess+ "\n" + Mess2);
	}
}

//function uploadDocument() {
//	var appPath = document.all['ucHeader_hidAppPath'].value;
//	var projid = document.all['hidProjID'].value;
//	if(projid=='') {
// 		alert('The TakeOn form must be saved before you can upload a Purchase order !')
// 	} else {
//		var scrnmidtop = ((screen.availHeight / 2) - 175);
//		var scrnmidleft = ((screen.availWidth / 2) - 275);
// 		window.open(appPath + "/Project/Upload.aspx?ProjID=" + projid ,"Upload","toolbar=0,location=0,status=1,menubar=0,scrollbars=0,width=550,height=350,top=" + scrnmidtop + ",left=" + scrnmidleft + ",resizable=0");
// 	}
//}

function CheckIfNewClient() {
	var appPath = document.all['ucHeader_hidAppPath'].value;
	var scrnmidtop = ((screen.availHeight / 2) - 175);
	var scrnmidleft = ((screen.availWidth / 2) - 225);
	if(document.Form1.ddlClient[1].selected == true && document.Form1.ddlClient.value == 0) {
	 	window.open(appPath + "/Project/AddClient.aspx","NewClient","toolbar=0,location=0,status=1,menubar=0,scrollbars=0,width=800,height=450,top=" + scrnmidtop + ",left=" + scrnmidleft + ",resizable=0");
	}
}

function CheckIfNewContact() {
	var appPath = document.all['ucHeader_hidAppPath'].value;
	var scrnmidtop = ((screen.availHeight / 2) - 175);
	var scrnmidleft = ((screen.availWidth / 2) - 225);
	if(document.Form1.ddlContact[1].selected == true && document.Form1.ddlContact.value == 0) {
	 	window.open(appPath + "/Project/AddContact.aspx?ret=con","NewContact","toolbar=0,location=0,status=1,menubar=0,scrollbars=0,width=450,height=350,top=" + scrnmidtop + ",left=" + scrnmidleft + ",resizable=0");
	}
}

function CheckIfNewAdminContact() {
	var appPath = document.all['ucHeader_hidAppPath'].value;
	var scrnmidtop = ((screen.availHeight / 2) - 175);
	var scrnmidleft = ((screen.availWidth / 2) - 225);
	if(document.Form1.ddlAdmin[1].selected == true && document.Form1.ddlAdmin.value == 0) {
	 	window.open(appPath + "/Project/AddContact.aspx?ret=adm","NewContact","toolbar=0,location=0,status=1,menubar=0,scrollbars=0,width=450,height=350,top=" + scrnmidtop + ",left=" + scrnmidleft + ",resizable=0");
	}
}

function loadCurrency() {
	var Currency;
	Currency = document.Form1.ddlCostCentre.options[document.Form1.ddlCostCentre.selectedIndex].value;
	Currency = Currency.split("#",-1);
	Currency = Currency[1];
	document.Form1.txtCurrency.value = Currency;
}

// Check if Resource Rates must be updated with new cost centre rates
function updateRates() {
	if(document.Form1.txtApprover1.value!='') {
		if(window.confirm('Press Ok to update the Resource Rates, or Cancel to leave rates as they are')) {
			var obj;
			// Update Approver1
				obj = document.Form1['ddlApprover1'];
				ws_getrate(obj);
			// Update Approver2 if 2Stage Approval process
			if(document.Form1.Stage2row!=undefined) {
				//alert('b');
				obj = document.Form1['ddlApprover2'];
				ws_getrate(obj);
			}
			// Update TeamLeader
				obj = document.Form1['ddlTeamLeader'];
				ws_getrate(obj);
			// Update dynamically added resources
			var arrlist = document.Form1['resource_list'].value, arrlen=0;
			//Get the number of rows added
			arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
			if(arrlist.length > 2){
				arrlen = arrlist.length - 2;
			}
			for(var i = 1; i <= arrlen; i++)
			{
				obj = document.Form1['ddlResource_'+i];
				ws_getrate(obj);
			}			
		}
	}
}

// Function to initialise TTX webservice before use, Called on page load
// SD: 09/09/2005 - Changed to cater for having app path passed in
function ws1_init(applicPath)	{		
		iCallID = 0;
		var appPath;
		if (typeof(applicPath) == "undefined")
		{
			appPath = document.all['ucHeader_hidAppPath'].value;
		}
		else
		{
			appPath = applicPath;
		}
		var hostName = window.location.hostname;
		//alert("http://" + hostName + appPath + "/WebService/TTX.asmx?WSDL");
		ws1.useService("http://" + hostName + appPath + "/WebService/TTX.asmx?WSDL","Rate");
}

// This function is called when a resource is selected from a droplist
// SD: 09/09/2005 - Changed to cater for having app path and cost centre passed in
function ws_getrate(obj,applicPath,CentreID) {
	var appPath;
	if (typeof(applicPath) == "undefined")
	{
		appPath = document.all['ucHeader_hidAppPath'].value;
	}
	else
	{
		appPath = applicPath;
	}
	var UserID = obj.value;
	var CostCentreID;
	if (typeof(CentreID) == "undefined")
	{
		var CostCentre;
		CostCentre = document.Form1.ddlCostCentre.value;
		CostCentre = CostCentre.split("#",-1);
		CostCentreID = CostCentre[0]
	}
	else
	{
		CostCentreID = CentreID;
	}
	var FieldName = obj.id
	if(CostCentreID==0) {
		alert('Please select a cost centre !');
		obj.value = 0;
		document.Form1.ddlCostCentre.focus();
	} else {
		if(UserID!=0) {
			iCallID = ws1.Rate.callService(rateresult,"GetCostCentreRate",UserID,CostCentreID,FieldName);
			FieldArr[iCallID] = document.Form1[FieldName].options[document.Form1[FieldName].selectedIndex].text;
		}
	}
}

// This function is called to handle the webservice call result
function rateresult(result) {
	//alert('(' + iCallID + ') ' +result.id + ', ' + result.error+ ', ' + result.value);
	if((result.error))
	{
		var xfaultcode = result.errorDetail.code;
		var xfaultstring = result.errorDetail.string;
		var xfaultsoap = result.errorDetail.raw;
		var ID = result.id;
		var FieldName = FieldArr[ID];
		//alert("Error Code: " + result.errorDetail.code);
		//alert("Error: " + result.errorDetail.string);
		//alert("Raw : " + result.errorDetail.raw);

		// Add code to output error information here
		alert("There was an error retreiving the Cost Centre Rate for " + FieldName + " or \nthe webservice is currently unavailable ");
	}	else {
		// Get the fieldname to be updated from the result, FieldName and Value are delimted by #
		Result = result.value;
		Result = Result.split("#",-1);
		var FieldName = Result[1]
		var re
		re = /ddl/g; // Create the regexp containing search string
		FieldName = FieldName.replace(re,"txt");
		document.Form1[FieldName].value=Result[0];
	}
}