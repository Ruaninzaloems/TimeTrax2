function LoadOrderDynamics() {
	loadOrders();
	loadTasks();
}

function loadOrders()
{
	var arrData, itemcount;
	//Get the number of rows to add
		itemcount = document.Form1.ucOrders_orderLoadCount.value;
		for (var i = 1; i <= itemcount; i++)
			{
				//Add a new line in the dynamic add
				arrData = document.Form1["ucOrders_hidBoxorder_"+i].value.split("#");  //SD: 19/10/2005 - Change dymanic adds from , to #
				addFormSection('order', document.Form1);
				document.Form1["ucOrders_txtItemID_"+i].value = arrData[0];
				document.Form1["ucOrders_ddlOrderItem_"+i].value = arrData[1];
				document.Form1["ucOrders_txtOrderAmount_"+i].value = arrData[2];
			}
			calcBudget();
}

function loadTasks()
{
	var arrData, itemcount;
	//Get the number of rows to add
	try {
		itemcount = document.Form1.ucOrders_taskLoadCount.value;
		for (var i = 1; i <= itemcount; i++)
		{
			//Add a new line in the dynamic add
			arrData = document.Form1["ucOrders_hidBoxtask_"+i].value.split("#");  //SD: 19/10/2005 - Change dymanic adds from , to #
			addFormSection('task', document.Form1);
			document.Form1["ucOrders_txtTask_"+i].value = arrData[1];
			document.Form1["ucOrders_txtTaskAmount_"+i].value = arrData[2];
			document.Form1["ucOrders_txtHours_"+i].value = arrData[3];
			if(arrData[4]=='True') {
			document.Form1["ucOrders_chkBillable_"+i].checked = 1;
			} else {
			document.Form1["ucOrders_chkBillable_"+i].checked = 0;
			}
		}
		calcTasks();
	}
	catch (ex) {}
}

// This function calculates the Total Project Budget
function calcBudget() {
	var arrlist = document.Form1['order_list'].value, arrlen=0;
	arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 2){
		arrlen = arrlist.length - 2;
	}
	
	var totBudget;
	totBudget = 0;
	for (var k=1; k<=arrlen; k++)
	{
		var FieldName = "ucOrders_ddlOrderItem_"+arrlist[k];
			if(document.Form1[FieldName].options[document.Form1[FieldName].selectedIndex].value == document.Form1['ucOrders_task_orderitem'].value) {
			// the selected item is the task order item
				if(document.Form1["ucOrders_txtOrderAmount_"+arrlist[k]].value != document.Form1['ucOrders_task_maxbudget'].value) {
					// Update the max Task budget value if it has been changed
					document.Form1['ucOrders_task_maxbudget'].value = document.Form1["ucOrders_txtOrderAmount_"+arrlist[k]].value;
					//calcTasks(); 
				}
			}
	
		if(document.Form1['ucOrders_txtOrderAmount_'+arrlist[k]].value > 0)
		{
			totBudget = parseFloat(totBudget) +	parseFloat(document.Form1['ucOrders_txtOrderAmount_'+arrlist[k]].value);
		}
	}
	document.Form1.ucOrders_txtProjBudget.value = totBudget.toFixed(2)
}

// This function calculates the Total Project Tasks Budget, Hours
// and ensures the budget does not exceed the task_maxbudget amount
function calcTasks() {
	var taskBudget, totTasks, totHrs;
	var arrlist = document.Form1['task_list'].value, arrlen=0;
	arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 2){
		arrlen = arrlist.length - 2;
	}

	if(document.Form1['ucOrders_task_maxbudget'].value > 0)
	{
		taskBudget = parseFloat(document.Form1['ucOrders_task_maxbudget'].value);
	} else {
		taskBudget = 0;
	}
	totTasks = 0;
	totHrs = 0;
	for (var k=1; k<=arrlen; k++)
	{
		// Calculate Total Task Budget
		if(document.Form1['ucOrders_txtTaskAmount_'+arrlist[k]].value > 0)
		{
			totTasks = parseFloat(totTasks) +	parseFloat(document.Form1['ucOrders_txtTaskAmount_'+arrlist[k]].value);
		}
		// Calculate Total Task Hours
		if(document.Form1['ucOrders_txtHours_'+arrlist[k]].value > 0)
		{
			totHrs = parseFloat(totHrs) +	parseFloat(document.Form1['ucOrders_txtHours_'+arrlist[k]].value);
		}
	}	
		document.Form1.ucOrders_txtTotBudget.value = totTasks.toFixed(2)
		document.Form1.ucOrders_txtTotHrs.value = totHrs.toFixed(0)

}


function checkOrderDuplicates(obj) {
  // check that an order item does not appear more than once in the orders list
  if(obj.value!=0) {
  // Only check if greater than 0
		var row = 0;
		var rowArr = obj.id;
		rowArr = rowArr.split("_");
		row = rowArr[2];
		var arrlist = document.Form1['order_list'].value, arrlen=0;
		arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
		if(arrlist.length > 2){
			arrlen = arrlist.length - 2;
		}
		for (var k=1; k<=arrlen; k++)
		{
			var FieldName = "ucOrders_ddlOrderItem_"+arrlist[k];
			if(document.Form1[FieldName].options[document.Form1[FieldName].selectedIndex].value == obj.value) {
				if(arrlist[k]!= row) {
					// the row is not the selected row
					alert('This item has already been selected and may not be selected again!');
					obj.selectedIndex = 0;
					return;
				}
			}
		}
	}
}

// Custom validator functions
function validateEndDate(oSrc, args) {
	// check that the End Date is not earlier than the Start Date
	// This is done when btnSubmit is clicked
	// Convert String to Date
	var StartDate, EndDate;
	StartDate = Date.parse(document.all.lblStart.innerHTML);
	EndDate = Date.parse(document.Form1.ucOrders_txtEndDate.value);
	alert('start ' + StartDate + ' end ' + EndDate);

 if(EndDate < StartDate) {
		args.IsValid = false;
		try { 
			document.Form1.ucOrders_txtEndDate.focus();
		}	
		catch (ex) {}
 }
 return;
}

function validateTaskBudget(oSrc, args) {
 // check that the Total task budget does not exceed the TaskOrderItem amount
 if(parseFloat(document.Form1.ucOrders_txtTotBudget.value) > parseFloat(document.Form1['ucOrders_task_maxbudget'].value)) {
  		oSrc.errormessage = 'The total Task budget of ' + document.Form1.ucOrders_txtTotBudget.value + ' may not exceed ' + document.Form1['ucOrders_task_maxbudget'].value + ' !';
		args.IsValid = false;
		SetFocusTaskList();
 		return;
 }
 //SB: 01/08/2005 - check that the all of the budget is allocated to tasks
 if(parseFloat(document.Form1.ucOrders_txtTotBudget.value) < parseFloat(document.Form1['ucOrders_task_maxbudget'].value)) 
 {
  		oSrc.errormessage = 'The ' + document.all.ucOrders_txtHidTaskOrderItemDesc.value + ' budget of ' + document.Form1['ucOrders_task_maxbudget'].value + ' has not been fully allocated';
		args.IsValid = false;
		SetFocusTaskList();
		return;
 } 
 
 //Now check that for each task, there is money allocated
 validateTaskItems(oSrc, args);
 
}
//SB: 01/08/2005 - Code moved into a function as it's now called more than once.  
//Function tries to set focus on the task list
function SetFocusTaskList()
{
	try {
		var arrlist = document.Form1['task_list'].value, arrlen=0;
		arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
		if(arrlist.length > 2){
			arrlen = arrlist.length - 2;
		}
		document.Form1['ucOrders_txtTaskAmount_'+arrlen].focus();
	}	
	catch (ex) {}
}

function validateProjBudget(oSrc, args) {
 // check that at least 1 Budget Item exists and that a valid entry is selected
	args.IsValid = true;
	var arrlist = document.Form1['order_list'].value, arrlen=0, TotOrder=0;
	arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 2){
		arrlen = arrlist.length - 2;
	}
	if(arrlen==0){
	  	oSrc.errormessage = 'Please Add at least 1 Budget Item';
		args.IsValid = false;
		return;
	}
	for (var i=1; i<=arrlen; i++)
	{
		// Check that all budget items have a valid selection
		var FieldName = "ucOrders_ddlOrderItem_"+arrlist[i];
		if(document.Form1[FieldName].value == 0) {
			oSrc.errormessage = 'Please select a Budget Item for row ' + arrlist[i];
			args.IsValid = false;
			return;
		}
		// Check The budget amount is greater than Zero
		var AmtField = "ucOrders_txtOrderAmount_"+arrlist[i];
		if(document.Form1[AmtField].value == 0||document.Form1[AmtField].value == '') {
			oSrc.errormessage = 'Please enter a Budget amount for row ' + arrlist[i];
			args.IsValid = false;
			return;
		}
	}
	
	//Now check if budget is allocated to the Task Order Item
	validateBudgetAllocated(oSrc, args);
	
	return;
}

//Created by SB on 01/08/2005
//This function determines if TaskOrderItem from the system table has been added as a budget item
//And also checks that the full budget amount has been allocated
function validateBudgetAllocated(oSrc, args) 
{
	var arrlist = document.Form1['order_list'].value, arrlen=0;
	arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 2)
	{
		arrlen = arrlist.length - 2;
	}
	
	//Retrieve the task order item id
	var TaskOrderItemID;
	TaskOrderItemID = document.all.ucOrders_task_orderitem.value;
	
	if (TaskOrderItemID != 0)  //SD: 07/09/2005 - Only do this check if the TaskOrderItemID has been set
	{
		var TaskTotal = 0;
		var TaskOrderItemIDFound = false;
		
		var FieldName;
		for (var k=1; k<=arrlen; k++)
		{
			FieldName = "ucOrders_ddlOrderItem_"+arrlist[k];
			if(document.Form1[FieldName].options[document.Form1[FieldName].selectedIndex].value == TaskOrderItemID) 
			{
				//Check if there is a value entered for the task order item
				FieldName = "ucOrders_txtOrderAmount_"+arrlist[k];
				if (document.Form1[FieldName].value != '' && document.Form1[FieldName].value > 0)
				{
					TaskOrderItemIDFound = true;		
				}
			}
			//TaskTotal = TaskTotal + 
		}
		if (TaskOrderItemIDFound == false)
		{
			oSrc.errormessage = 'Please enter a budget value for ' + document.all.ucOrders_txtHidTaskOrderItemDesc.value;
			args.IsValid = false;
			return;
		}
	}
}

//Created by SB on 01/08/2005
//This function checks that for each task item, there is a valid entry
function validateTaskItems(oSrc, args) {
	args.IsValid = true;
	var arrlist = document.Form1['task_list'].value, arrlen=0;
	arrlist = arrlist.split("#");	//SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 2){
		arrlen = arrlist.length - 2;
	}
	if(arrlen==0){
	  	oSrc.errormessage = 'Please Add at least 1 Task Item';
		args.IsValid = false;
		return;
	}
	var FieldName;
	for (var i=1; i<=arrlen; i++)
	{
		// Check that a task description has been entered
		FieldName = "ucOrders_txtTask_"+arrlist[i];
		if(document.Form1[FieldName].value == '') 
		{
			oSrc.errormessage = 'Please enter a Task Description for row ' + arrlist[i];
			args.IsValid = false;
			return;
		}
		// Check that something has been entered for task amount.  It doesn't matter if it's zero
		FieldName = "ucOrders_txtTaskAmount_"+arrlist[i];
		if(document.Form1[FieldName].value == '') 
		{
			oSrc.errormessage = 'Please enter a Task amount for row ' + arrlist[i];
			args.IsValid = false;
			return;
		}
		// Check that something has been entered for task hours.  It doesn't matter if it's zero
		FieldName = "ucOrders_txtHours_"+arrlist[i];
		if(document.Form1[FieldName].value == '') 
		{
			oSrc.errormessage = 'Please enter a number of Hours for row ' + arrlist[i];
			args.IsValid = false;
			return;
		}
		
	}

	return;
}
