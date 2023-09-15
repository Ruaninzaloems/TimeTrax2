var objLevel2;
var objLevel3;
var objLevel1;

function initFilters() {
	// Load the array objects with the initial values
		//try {objLevel1 = new filterObj(Form1.ucReportFilters_ddlClient);}
		//catch(ex) {}
		//try {objLevel2 = new filterObj(Form1.ucReportFilters_ddlProject);}
		//catch(ex) {}
		//try {objLevel3 = new filterObj(Form1.ucReportFilters_ddlTask);}
		//catch(ex) {}
		
		//try {
		//	objLevel2.populate(Form1.ucReportFilters_ddlClient.value,true,false);
		//	if(document.all.ucReportFilters_hidProjectID.value!='') {
		//		Form1.ucReportFilters_ddlProject.value = document.all.ucReportFilters_hidProjectID.value;
		//	}
		//}
		//catch(ex) {}
		//try {
		//	objLevel3.populate(Form1.ucReportFilters_ddlProject.value,true,false);
		//	if(document.all.ucReportFilters_hidTaskID.value!='') {
		//		Form1.ucReportFilters_ddlTask.value = document.all.ucReportFilters_hidTaskID.value;
		//	}
		//}
		//catch(ex) {}

		
	}

function filter(type,obj,allowAll) {
	if(allowAll==undefined) { var allowAll=false; }
	switch(type)
	{
		case '2':
			objLevel2.populate(obj.value,allowAll,false);
			// Repopulate nested levels also
			filter('3',Form1.ucReportFilters_ddlProject,allowAll,false);
			break;
		case '3':
			if (typeof objLevel3 != 'undefined')  //SD: 29/09/2005 - Need to do this check as the task drop down isn't always shown
			{
				objLevel3.populate(obj.value,allowAll,false);
			}
			break;
	}
}

//This function either shows filters for expense date or shows the filters for expense Month
function ShowHideExpenseMonth()
{

	if (document.all['ucReportFilters_optMonthView'].checked == true)
	{
		//Enable the Expense Month controls
		document.all['ucReportFilters_ddlMonth'].disabled = false;
		document.all['ucReportFilters_ddlYear'].disabled = false;
		
		//Disable the Date Filter Controls
		document.all['ucReportFilters_txtEndDate'].disabled = true;
		document.all['EndDate'].src = "../Images/blank.gif";
		document.all['ucReportFilters_txtStartDate'].disabled = true;
		document.all['StartDate'].src = "../Images/blank.gif";
		
	}
	else
	{
		//Disable the Expense Month controls
		document.all['ucReportFilters_ddlMonth'].disabled = true;
		document.all['ucReportFilters_ddlYear'].disabled = true;
		
		//Enable the Date Filter Controls
		document.all['ucReportFilters_txtEndDate'].disabled = false;
		document.all['EndDate'].src = "../Images/CALENDAR.GIF";
		document.all['ucReportFilters_txtStartDate'].disabled = false;
		document.all['StartDate'].src = "../Images/CALENDAR.GIF";
	}

}