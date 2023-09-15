function PTOApprove() {
	document.Form1.btnApprove.click();
}

function PTOReject() {
	// Check that there is a reason for rejecting
	if(document.Form1.hidApproval.value==1) {
		if(document.Form1.txtApprove1Comment.value=='') {
			alert('Please enter the reason for rejecting this Project !');
			return;
		}
	} else {
		if(document.Form1.txtApprove2Comment.value=='') {
			alert('Please enter the reason for rejecting this Project !');
			return;
		}
	}
	document.Form1.btnReject.click();
}

// This function checks that there is a comment for rejected items
// loop thru items in hidBoxtimesheetids to check if any are rejected,
// if rejected then check that a reject comment has been entered for that item
function checkReject(typ,level) {
	var arrlist, arrlen=0, Row, symbol;
	if(typ=='time') {
		if (level=='TeamLeader')
		{
			arrlist = document.all['hidBoxtimesheetids'].value;
		}
		else 
		{
			if (level=='Manager')
			{
				arrlist = document.all['hidBoxtimesheetidsManager'].value;
			}
			else 
			{
				if (level=='ManagerMonitor')
				{
					arrlist = document.all['hidBoxtimesheetidsManagerMonitor'].value;
				}
				else
				{
					arrlist = document.all['hidBoxtimesheetidsMD'].value;	
				}
			}			
		}
	} 
	else 
	{	//expenses
		
		if (level=='TeamLeader')
		{
			arrlist = document.all['hidBoxexpenseids'].value;
		}
		else 
		{
			if (level=='Manager')
			{
				arrlist = document.all['hidBoxexpenseidsManager'].value;
			}
			else 
			{
				if (level=='ManagerMonitor')
				{
					arrlist = document.all['hidBoxexpenseidsManagerMonitor'].value;
				}
				else
				{
					arrlist = document.all['hidBoxexpenseidsMD'].value;	
				}
			}			
		}		
	}

	Page_IsValid=true;
	arrlist = arrlist.split(",");
	if(arrlist.length > 1){
		arrlen = arrlist.length - 1;
	}
	for(var i = 1; i <= arrlen; i++)
	{
		arrData = arrlist[i].split("_");
		key = arrData[0];
		if (level=='TeamLeader')
		{
			timesheet = arrData[1];
			field = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_1"]');
		}
		else
		{  //For Manager and Monitor there is either an M or MM so we need to take the next element up
			timesheet = arrData[2];
			symbol = arrData[1];
			field = eval('document.Form1["rdoApprove_' + key + '_' + symbol + '_' + timesheet + '_1"]');
		}		
		// Check if item has been rejected			
		if(field.checked==true) {
			// rejected so check that rejected reason is entered
			field2 = eval('document.Form1["hidComment_' + timesheet + '"]');
			if(field2.value=='') {
				alert('Please enter the reason for rejecting for all rejected items');
				Page_IsValid=false;
				break;
			}
		}
	}
	
	if(Page_IsValid==true) 
	{
		//Set which type of approval is being done
		document.Form1.hidApprovalTypeSubmited.value = level;
		//Submit the page
		document.Form1.btnSubmit.click();
	}

}

// This function checks that there is a comment for rejected Financial Document
function checkFinancialDocReject(level) {
	var strComment,field;

	if (level=='TeamLeader')
	{
		strComment = document.all['txtComment'].value;
	}
	else 
	{
		strComment = document.all['txtManagerMonitorComment'].value;		
	}


	Page_IsValid=true;
	
	field = eval('document.Form1["rdoApprove_1"]');
				
	// Check if item has been rejected			
	if(field.checked==true) 
	{
		// rejected so check that rejected reason is entered
		if(strComment=='') 
		{
			alert('Please enter the reason for rejecting the Financial Document');
			Page_IsValid=false;
		}
	}
	
	if(Page_IsValid==true) 
	{
		//Set which type of approval is being done
		document.Form1.hidApprovalTypeSubmited.value = level;
		//Submit the page
		document.Form1.btnSubmit.click();
	}

}

// This function loads the selected items comment into the Comment Edit box and 
// saves the id of the comment being edited
//Modified:
//SD on 15/02/2010 - Catered for the 3 types of approval
function loadComment(obj,type) {
	var arrData = obj.id;
	var timesheet, key;
	
	arrData = arrData.split("_");
	key = arrData[1];
	
	if (type == 1)
	{
		timesheet = arrData[2];
	}
	else
	{  //For Manager and Monitor there is either an M or MM so we need to take the next element up
		timesheet = arrData[3];
	}
	
	CommentID = "hidComment_" + timesheet;
	
	if (type == 1)  //Teamleader Timesheet approval
	{
		document.Form1['txtComment'].value = document.Form1[CommentID].value;
	}
	else
	{
		if (type == 2) //Manager Timesheet approval
		{
			document.Form1['txtManagerComment'].value = document.Form1[CommentID].value;
		}
		else
		{
			if (type == 3)	//Manager Monitor Timesheet Approval
			{	
				document.Form1['txtManagerMonitorComment'].value = document.Form1[CommentID].value;
			}
			else	//MD
			{
				document.Form1['txtMDComment'].value = document.Form1[CommentID].value;
			}
		}
	}
	
	//SD: 12/10/2005 - If you are rejecting, set focus on the comment box so that it is apparent
	//that the rejection is for this line item
	if (document.Form1[obj.id + '_0'].checked == false)
	{
		if (type == 1)  //Teamleader Timesheet approval
		{
			document.Form1['txtComment'].focus();
		}
		else
		{
			if (type == 2) //Manager Timesheet approval
			{
				document.Form1['txtManagerComment'].focus();
			}
			else	
			{
				if (type == 3) //Manager Monitor Timesheet Approval
				{	
					document.Form1['txtManagerMonitorComment'].focus();
				}
				else
				{
					document.Form1['txtMDComment'].focus();
				}
			}
		}
	}	
}
// This function saves the text from the comment edit box to the comment being edited
//SD on 15/02/2010 - Catered for the 3 types of approval
function saveComment(type) {
	try 
	{
		
		if (type == 1)  //Teamleader Timesheet approval
		{
			document.Form1[CommentID].value = document.Form1['txtComment'].value;
		}
		else
		{
			if (type == 2) //Manager Timesheet approval
			{
				document.Form1[CommentID].value = document.Form1['txtManagerComment'].value;
			}
			else
			{	
				if (type == 3) //Manager Monitor Timesheet Approval
				{	
					document.Form1[CommentID].value = document.Form1['txtManagerMonitorComment'].value;
				}
				else //MD Timesheet approval
				{
					document.Form1[CommentID].value = document.Form1['txtMDComment'].value;
				}
			}
		}
	}
	catch(ex) {}
}

//SD: 12/10/2005 - pass through the type so that this can be used for timesheets and expenses
//				   type = expense or timesheet
//SD: 19/10/2005 - Remove check to see if checked as no longer a check box - always approving if you've clicked this
//SD: 22/02/2010 - Cater for 2 types of approval
//SD: 07/02/2012 - Cater for 3 types of approval
function ApproveAll(obj, type, ApprovalType) {
  //if(obj.checked==true) {
		var arrData = obj.id;
		var timesheet, level1key, key;
		arrData = arrData.split("_");
		level1key = arrData[1];
		//var arrlist = document.all['hidBox'+ type + 'ids'].value, arrlen=0, Row;
		
		if (ApprovalType==1)
		{
			var arrlist = document.all['hidBox'+ type + 'ids'].value, arrlen=0, Row;
		}
		else 
		{
			if (ApprovalType==2)
			{
				var arrlist = document.all['hidBox'+ type + 'idsManager'].value, arrlen=0, Row;
			}
			else 
			{
				if (ApprovalType==3) //Manager Monitor
				{
					var arrlist = document.all['hidBox'+ type + 'idsManagerMonitor'].value, arrlen=0, Row;
				}
				else
				{
					var arrlist = document.all['hidBox'+ type + 'idsMD'].value, arrlen=0, Row;			
				}
			}
		}
		
		arrlist = arrlist.split(",");
		if(arrlist.length > 1){
			arrlen = arrlist.length - 1;
		}
		for(var i = 1; i <= arrlen; i++)
		{
			arrData = arrlist[i].split("_");
			key = arrData[0];
			timesheet = arrData[1];
			if(key==level1key) {
				// Check if rejected is selected
				//field = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_1"]');
				if (ApprovalType==1)
				{
					field = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_1"]');
				}
				else
				{	//if this is manager or monitor there is 3rd element in the array
					field = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_' + arrData[2] + '_1"]');
				}
				if(field.checked==true) {
					// rejecteded is selected so unselect
					field.checked=false;
					// and select Approved
					//field2 = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_0"]');
					if (ApprovalType==1)
					{
						field2 = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_0"]');
					}
					else
					{	//if this is manager or monitor there is 3rd element in the array
						field2 = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_' + arrData[2] + '_0"]');
					}
					field2.checked=true;
				}
			}
		}
		//obj.checked = false;
//	}
}

//SD: 12/10/2005 - pass through the type so that this can be used for timesheets and expenses
//type = expense or timesheet
//SD: 19/10/2005 - Remove check to see if checked as no longer a check box - always rejecting if you've clicked this
//SD: 22/02/2010 - Cater for 2 types of approval
function RejectAll(obj,type,ApprovalType) {
//  if(obj.checked==true) {

		var arrData = obj.id;
		var timesheet, level1key, key;
		arrData = arrData.split("_");
		level1key = arrData[1];
		//var arrlist = document.all['hidBox' + type + 'ids'].value, arrlen=0, Row;
		if (ApprovalType==1) //Teamleader
		{
			var arrlist = document.all['hidBox'+ type + 'ids'].value, arrlen=0, Row;
		}
		else 
		{
			if (ApprovalType==2) //Manager
			{
				var arrlist = document.all['hidBox'+ type + 'idsManager'].value, arrlen=0, Row;
			}
			else 
			{
				if (ApprovalType==3) //Manager Monitor
				{
					var arrlist = document.all['hidBox'+ type + 'idsManagerMonitor'].value, arrlen=0, Row;
				}
				else	//MD
				{
					var arrlist = document.all['hidBox'+ type + 'idsMD'].value, arrlen=0, Row;
				}
			}
		}
		arrlist = arrlist.split(",");
		if(arrlist.length > 1){
			arrlen = arrlist.length - 1;
		}
		for(var i = 1; i <= arrlen; i++)
		{
			arrData = arrlist[i].split("_");
			key = arrData[0];
			timesheet = arrData[1];
						
			if(key==level1key) {
				// Check if approved is selected
				if (ApprovalType==1)
				{
					field = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_0"]');
				}
				else
				{	//if this is manager or monitor there is 3rd element in the array
					field = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_' + arrData[2] + '_0"]');
				}
				if(field.checked==true) {
					// approved is selected so unselect
					field.checked=false;
					// and select Rejected		
					if (ApprovalType==1)
					{
						field2 =  eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_1"]');
					}
					else
					{	//if this is manager or monitor there is 3rd element in the array
						field2 = eval('document.Form1["rdoApprove_' + key + '_' + timesheet + '_' + arrData[2] + '_1"]');
					}
					field2.checked=true;
				}
			}
		}
//		obj.checked = false;
//	}
}