//This function is called on load of the form and loads all the expenses, calculates their totals and disables
//approved items
function LoadDynamics() 
{
	var Proj;
	var i;
	var ProjNo = 0;   
	
	//SD: 12/10/2005 - Change to load all expenses here instead of on load of each image so ...
	
	//Determine the number of projects
	var arrlist = document.all['hidBoxexpense'].value, arrData, arrlen=0, Proj, Client, Row;
	arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 1)
	{
		ProjNo = arrlist.length - 1;
	}
		
	if(ProjNo > 0)
	{
		for(var i = 1; i <= ProjNo; i++)
		{			
			// For each Item - Get the Project
			arrData = arrlist[i].split(";");
			Proj = arrData[1];
			
			//Load all the times for that project
			if (typeof Proj != 'undefined')
			{
				cashlist('a' + Proj)
			}
			
		}
	}

	calc_total();
	DisableControls();
}

function calendar(obj) {
	// This calls imcalendar
	//alert(obj.id);
	var txtobj;
	txtobj = document.Form1['txt' + obj.id];
	div = 'div' + obj.id;
	//alert(txtobj.value);
	imcalendar.select(txtobj,div,'dd/MM/yyyy');
	return false;
}

function cashlist(No)
{
	var cash_list, i, k, Option, Name;
	i = 1;
	//Name = "Expense_" + No;
	Name = No;
	// check if there are items to be loaded
	try {cash_list = document.all[No + '_listload'].value;}
	catch(ex) {}
	for (i = 1; i <= cash_list; i++)
	{
		addFormSection(No, document.Form1);
		document.Form1["hidExpID"+No+"_"+i].value = document.Form1["hidExpense_"+No+"ExpID_a"+i].value;
		document.Form1["txtDate"+No+"_"+i].value = document.Form1["txtExpense_"+No+"Date_a"+i].value;
		document.Form1["txtComment"+No+"_"+i].value = document.Form1["txtExpense_"+No+"Comment_a"+i].value;
		document.Form1["ddlExpenseType"+No+"_"+i].selectedIndex = getDDLselectedIndex_Text(document.Form1["ddlExpenseType"+No+"_"+i],document.Form1["txtExpense_"+No+"ExpenseType_a"+i].value);
		document.Form1["txtQty"+No+"_"+i].value = document.Form1["txtExpense_"+No+"Quantity_a"+i].value;
		document.Form1["txtCost"+No+"_"+i].value = document.Form1["txtExpense_"+No+"Cost_a"+i].value;
		document.Form1["txtRowTot"+No+"_"+i].value = (parseFloat(document.Form1["txtCost"+No+"_"+i].value) * parseFloat(document.Form1["txtQty"+No+"_"+i].value));
		document.Form1["hidExpSubmit"+No+"_"+i].value = document.Form1["hidExpense_"+No+"Submit_a"+i].value;
	}	
}

function checkIfFixed(obj) {
 var projrow = obj.id.substr(14);
 var arrData;
 arrData = obj.value;
 arrData = arrData.split('#');
 
 if(arrData[1]==1) {
	// Item has fixed cost so insert Cost and disble
	document.Form1["txtCost"+projrow].value = arrData[2];
	document.Form1["txtCost"+projrow].readOnly = true;
	document.Form1["txtCost"+projrow].className = "inputROR";
	calc_total();
 } else {
	 if(document.Form1["txtCost"+projrow].className == "inputROR") {
		document.Form1["txtCost"+projrow].className = "inputR";
		document.Form1["txtCost"+projrow].readOnly = false;
	 }
 }
}

function loadDeleted(obj) {
	var hidobj;
	 var arrData, projID;
	// Get the ProjectID
	arrData = obj.id.substr(10);
	arrData = arrData.split('_');
	projID = arrData[0];
	hidobj = document.Form1['hidExpID' + obj.id.substr(9)];
	//alert('val ' + hidobj.value);
	if(hidobj.value!='') {
		document.Form1['deleted_list'].value += '#' + projID + ';' + hidobj.value;  //SD: 19/10/2005 - Change dymanic adds from , to #
	}
}

function calc_totals() {
}
// This function calculates (1) Total hours for the week, (2)Billable hours for the week and (3) NonBillable hours for the week
function calc_total() {
	var RowTot = 0;
	var ProjectTot = 0;
	var ClientTot = 0;
	var GTot = 0;
	var qty = 0;
	var cost = 0;
	var field, gfield, pfield, cfield, qtyfield, costfield, savProj, savClient;

  // Get the number of Projects
	var arrlist = document.all['hidBoxexpense'].value, arrData, arrlen=0, Proj, Client, Row;
	arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 1){
		arrlen = arrlist.length - 1;
	}
	
	if(arrlen > 0)
	{
		for(var i = 1; i <= arrlen; i++)
		{
			// For each Item
			// Get the Client and Project
			arrData = arrlist[i].split(";");
			Client = arrData[0];
			Proj = arrData[1];
			if(savClient==''||savClient==undefined) {
				savClient = Client;
			}
			if(savProj==''||savProj==undefined) {
				savProj = Proj;
			}
			// Check If the Project has changed
			if(savProj!=Proj) {
				// load the project totals to the form and
				pfield = eval('document.Form1["txtTotProj_' + savProj + '"]');
				pfield.value = ProjectTot.toFixed(2);
				// Calculate Client Total
				ClientTot += ProjectTot;
				// clear the values for the next project
				ProjectTot = 0;
				// and update savProj
				savProj = Proj;
			}
			// Check If the Client has changed
			if(savClient!=Client) {
				// load the Client totals to the form and
				cfield = eval('document.Form1["txtTotClient_' + savClient + '"]');
				cfield.value = ClientTot.toFixed(2);
				// clear the values for the next Client
				GTot += ClientTot;
				ClientTot = 0;
				// and update savProj
				savClient = Client;
			}
			// Get the projects current rows from the aProjID_list
			var projlist = document.Form1['a' + Proj + '_list'].value, projlen=0;
			projlist = projlist.split("#");		//SD: 19/10/2005 - Change dymanic adds from , to #
			if(projlist.length > 2){
				projlen = projlist.length - 2;
			}
			for (var k=1; k<=projlen; k++)
			{
				// Get the row Total
				qtyfield = eval('document.Form1["txtQtya' + Proj + '_' + projlist[k] + '"]');
				if(qtyfield.value > 0) {
					qty = parseFloat(qtyfield.value);
				} else {
					qty = 0;
				}
				costfield = eval('document.Form1["txtCosta' + Proj + '_' + projlist[k] + '"]');
				if(costfield.value > 0) {
					cost = parseFloat(costfield.value);
				} else {
					cost = 0;
				}
				field = eval('document.Form1["txtRowTota' + Proj + '_' + projlist[k] + '"]');
				field.value = parseFloat(qty) * parseFloat(cost);
				if(field.value > 0) {
					RowTot = parseFloat(field.value)
					field.value = RowTot.toFixed(2);
				} else {
					RowTot = 0
					field.value = RowTot.toFixed(2);
				}
				// Accumulate the Project Totals
				ProjectTot += RowTot;
			}
		}
		// load the project totals to the form and
		pfield = eval('document.Form1["txtTotProj_' + savProj + '"]');
		pfield.value = ProjectTot.toFixed(2);
		// Calculate Client Total
		ClientTot += ProjectTot;
		//Load the Client Total values onto form
		cfield = eval('document.Form1["txtTotClient_' + savClient + '"]');
		cfield.value = ClientTot.toFixed(2);
		//Load the Grand Total values onto form
		GTot += ClientTot;
		gfield = eval('document.Form1["txtTotal"]');
		gfield.value = GTot.toFixed(2);
	}
}

function projDelete(obj) {
	var arrData = obj.id;
	var project;
	var fieldName;
	arrData = arrData.split("_");
	project = arrData[1];
	
	fieldName = 'a' + project + '_list';
	
	//Check if there are expenses entered for the project
	if (document.all[fieldName].value == '' || document.all[fieldName].value == ',')
	{
		// save the task id to hidden box to be processed when page is submitted
		document.Form1['deletedproj_list'].value += project + ',';
		
		//hide the project
		fieldName = 'trProj_' + project;
		document.all[fieldName].style.display = "none";
	}
	else
	{
		alert('You are unable to delete this project as it contains expenses for this month.');
	}
	
}

function deleteItem(obj) {
	var arrData = obj.id;
	var task, project, field, x;
	arrData = arrData.split("_");
	project = arrData[1];
	task = arrData[2];
	// save the task id to hidden box to be processed when page is submitted
	document.Form1['deleted_list'].value += obj.id + '#';	//SD: 19/10/2005 - Change dymanic adds from , to #
	// And hide the 'deleted' task on the page
	// set each cell value to 0
	for (x = 1; x < 8; x++)
	{
		field = eval('document.Form1["' + project + '_' + task + '_Day' + x + '"]');
		field.value = 0;
	}	
	// set the display to none
	field = eval('document.all["tr_' + task + '"]');
	field.style.display='none';
	
}
function openAddProject() {
	// Adds a new Project to the users profile (TT_ProfileProject)
	if (confirm("Please note, Any unsaved data will be lost!")) {
		url = "AddProject.aspx?ExpenseDate=" + document.all.hidExpenseDate.value;
		window.open(url,"AddProject","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=350,top=50,left=50,resizable=0");
     }
}

function tryAdd(obj,form) {
	// If the submit button is disabled then expenses can no longer be added
	if(document.all.btnSubmit.disabled==false) 
	{
		addFormSection(obj,form);
	} else {
		alert('You cannot add further Expenses \nExpenses for this month have already been submitted ! ');
	}
}

//Validation

function ValidateExpense(oSrc, args)
{
	var arrData;
	var Client;
	var Proj;
	var k;
	var ErrorRow = 0;
	var ProjNo = 0;     //SB: 01/09/2005 - Need to declare and default this to a value
						//so that if there is no expense an error is not generated
	
	//Get the number of Projects
	var arrlist = document.all['hidBoxexpense'].value, arrData, arrlen=0, Proj, Client, Row;
	arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 1){
		ProjNo = arrlist.length - 1;
	}
	
	oSrc.errormessage = '';
	
	if(ProjNo > 0)
	{
		for(var i = 1; i <= ProjNo; i++)
		{
			// For each Item
			// Get the Client and Project
			arrData = arrlist[i].split(";");
			Client = arrData[0];
			Proj = arrData[1];
			
			// Get the projects current rows from the aProjID_list
			var projlist = document.Form1['a' + Proj + '_list'].value, projlen=0;
			projlist = projlist.split("#");		//SD: 19/10/2005 - Change dymanic adds from , to #
			if(projlist.length > 2){
				projlen = projlist.length - 2;
			}
					
			for (var k=1; k<=projlen; k++)
			{
				//Set the error row
				ErrorRow = ErrorRow + 1;
				
				//Determine if a date has been entered
				if (document.Form1['txtDatea' + Proj + '_' + projlist[k]].value == '')  //SD: 09/01/2005 - change all values in this validation routine to refer to projlist[k] and not k.  
																						//as a project could have been deleted from higher up the list and thus k will not refer to the correct item
				{
					//Set the error description
					args.IsValid = false;
					oSrc.errormessage += "Row " + ErrorRow + " has no Date\n"; 			
				}

				//Determine if a comment has been entered
				if (document.Form1['txtCommenta' + Proj + '_' + projlist[k]].value == '')
				{
					//Set the error description
					args.IsValid = false;
					oSrc.errormessage += "Row " + ErrorRow + " has no Comment\n"; 			
				}
				
				//Determine if an expense type has been entered
				if (document.Form1['ddlExpenseTypea' + Proj + '_' + projlist[k]].value == '0#0#0')
				{
					//Set the error description
					args.IsValid = false;
					oSrc.errormessage += "Row " + ErrorRow + " has no Expense Type\n"; 			
				}
				
				//Determine if a Quantity has been entered
				if (document.Form1['txtQtya' + Proj + '_' + projlist[k]].value == '')
				{
					//Set the error description
					args.IsValid = false;
					oSrc.errormessage += "Row " + ErrorRow + " has no Quantity\n"; 			
				}
				
				//Determine if a Cost has been entered
				if (document.Form1['txtCosta' + Proj + '_' + projlist[k]].value == '')
				{
					//Set the error description
					args.IsValid = false;
					oSrc.errormessage += "Row " + ErrorRow + " has no Cost\n"; 			
				}				
			}
		}
	}

	if (args.IsValid == false)
	{
		alert(oSrc.errormessage);
	}
	
	return(args.IsValid);

}

//This function disables the controls in the dynamic add if the expense is submitted
function DisableControls()
{
var arrData;
	//var Client;
	var Proj;
	var k;
	var ProjNo = 0;     
	
	//Get the number of Projects
	var arrlist = document.all['hidBoxexpense'].value, arrData, arrlen=0, Proj, Client, Row;
	arrlist = arrlist.split("#");			//SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 1){
		ProjNo = arrlist.length - 1;
	}
		
	if(ProjNo > 0)
	{
		for(var i = 1; i <= ProjNo; i++)
		{
			// For each Item
			// Get the Project
			arrData = arrlist[i].split(";");
			Proj = arrData[1];
			
			// Get the projects current rows from the aProjID_list
			var projlist = document.Form1['a' + Proj + '_list'].value, projlen=0;
			projlist = projlist.split("#");		//SD: 19/10/2005 - Change dymanic adds from , to #
			
			if(projlist.length > 2){
				projlen = projlist.length - 2;
			}
					
			for (var k=1; k<=projlen; k++)
			{
				//Determine if the expense is submitted
				if (document.Form1['hidExpense_a' + Proj + 'Submit_a' + k].value == '1')
				{						
					//Disable all the controls
					document.Form1["txtDatea"+Proj+"_"+k].disabled = true;
					document.Form1["txtCommenta"+Proj+"_"+k].disabled = true;
					document.Form1["ddlExpenseTypea"+Proj+"_"+k].disabled = true;
					document.Form1["txtQtya"+Proj+"_"+k].disabled = true;
					document.Form1["txtCosta"+Proj+"_"+k].disabled = true;
					document.Form1["txtRowTota"+Proj+"_"+k].disabled = true;
					document.Form1["Datea"+Proj+"_"+k].width = 0;
					document.Form1["Datea"+Proj+"_"+k].height = 0;
					document.Form1["imgDeletea"+Proj+"_"+k].width = 0;
					document.Form1["imgDeletea"+Proj+"_"+k].height = 0;
				}		
				
			}
		}
	}

}