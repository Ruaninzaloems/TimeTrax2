var objLevel2;
var objLevel1;

function initFilters() {
	// Load the array objects with the initial values
		try {objLevel2 = new filterObj(Form1.ddlProject);}
		catch(ex) {}
		
		try {
			objLevel2.populate(Form1.ddlClient.value,true,false);
			if(document.all.hidProjectID.value!='') {
				Form1.ddlProject.value = document.all.hidProjectID.value;
			}
		}
		catch(ex) {}
		try {
			objLevel3.populate(Form1.ddlProject.value,true,false);
			if(document.all.hidTaskID.value!='') {
				Form1.ddlTask.value = document.all.hidTaskID.value;
			}
		}
		catch(ex) {}	
	}

function filter(type,obj,allowAll) {
	if(allowAll==undefined) { var allowAll=false; }
	if (type == '2')
	{
			objLevel2.populate(obj.value,allowAll,false);
			// Repopulate nested levels also
			filter('3',Form1.ddlProject,allowAll,false);
	}
}