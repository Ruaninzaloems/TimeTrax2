// Function to initialise TTX webservice before use, Called on page load
function ws1_init()	{		
		iCallID = 0;
		var appPath = document.all['hidAppPath'].value;
		var hostName = window.location.hostname;
		//alert("http://" + hostName + appPath + "/WebService/TTX.asmx?WSDL");
		ws1.useService("http://" + hostName + appPath + "/WebService/TTX.asmx?WSDL","Resource");
}

// This function is called when a resource is selected from a droplist
// The function determines if this user already exists as a project resource
function ws_CheckIfProjectResource(obj,ProjectID) {
	var UserID = obj.value;
	var iCallID;
	if(UserID!=0) 
	{
		iCallID = ws1.Resource.callService(ResourceResult,"CheckIfProjectResource",UserID,ProjectID);
	}
}

// This function is called to handle the webservice call result
function ResourceResult(result) {
	if((result.error))
	{
		//var xfaultcode = result.errorDetail.code;
		//var xfaultstring = result.errorDetail.string;
		//var xfaultsoap = result.errorDetail.raw;
		//var ID = result.id;
		// Add code to output error information here
		alert("There was an error determining if this Resource is already a Resource on the Project or \nthe webservice is currently unavailable ");
	}	
	else
	{
		// If the user is already a resource on the project - notify the user and reset the combo box
		if (result.value == true)
		{
			alert('This resource has already been allocated for this project and may not be selected again');
			document.all.ddlResource.value = 0;
		}
	}
}