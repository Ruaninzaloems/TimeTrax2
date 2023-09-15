function LoadDynamics() {
	loadRates();
}

function loadRates()
{
	var arrData, itemcount;
	if(document.Form1.itemLoadCount != null)
	{
	//Get the number of rows to add
	itemcount = document.Form1.itemLoadCount.value;
	for (var i = 1; i <= itemcount; i++)
		{
			//Add a new line in the dynamic add
			arrData = document.Form1["hidBoxitem_"+i].value.split("#");		//SD: 19/10/2005 - Change dymanic adds from , to #
			addFormSection('Item', document.Form1);
			document.Form1["ddlCostCentre_"+i].value = arrData[2];
			document.Form1["txtrate_"+i].value = arrData[3];
		}
	}
}

function checkDuplicates(obj) {
  // check that an order item does not appear more than once in the orders list
  if(obj.value!=0) {
  // Only check if greater than 0
		var row = 0;
		var rowArr = obj.id;
		rowArr = rowArr.split("_");
		row = rowArr[1];
		var arrlist = document.Form1['item_list'].value, arrlen=0;
		arrlist = arrlist.split("#");		//SD: 19/10/2005 - Change dymanic adds from , to #
		if(arrlist.length > 2){
			arrlen = arrlist.length - 2;
		}
		for (var k=1; k<=arrlen; k++)
		{
			var FieldName = "ddlCostCentre_"+arrlist[k];
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

//**********************************************************************************************************************************
// VALIDATE  DUPLICATE PASSWORD
//**********************************************************************************************************************************
function ValidatePassword(oSrc,args)
{
	if(document.Form1.txtuserid.value=="0")
	{
		if(document.Form1.txtpass1.value=="")
		{
			args.IsValid = false;
			oSrc.errormessage = "Please enter a password";
			return;
		}
		else
		{
			if(document.Form1.txtpass1.value!= document.Form1.txtpass2.value)
			{
				args.IsValid = false;
				oSrc.errormessage = "Passwords do not match";
				return;
			}
			else
			{
				args.IsValid = true;
				return;
			}
		}
	}
	else
	{
		if((document.Form1.txtpass1.value=="")&&(document.Form1.txtpass2.value==""))
		{
			args.IsValid = true;
			return;
		}
		else
		{
			if(document.Form1.txtpass1.value!= document.Form1.txtpass2.value)
			{
				args.IsValid = false;
				oSrc.errormessage = "Passwords do not match";
				return;
			}
			else
			{
				args.IsValid = true;
				return;
			}
		}
	}
}

//Created by SB on 01/09/2005
//This function checks that for each cost centre item, there is a valid entry
function validateCostCentreItems(oSrc, args) {

	args.IsValid = true;
	var arrlist = document.Form1['item_list'].value
	var arrlen=0;
	
	arrlist = arrlist.split("#");	//"SD: 19/10/2005 - Change dymanic adds from , to #
	if(arrlist.length > 2){
		arrlen = arrlist.length - 2;
	}
	var FieldName;
	oSrc.errormessage = '';
	var msg = '';
	var linebreak = '<br>'
	
	//Check that the correct data is entered for each row.
	for (var i=1; i<=arrlen; i++)
	{
		// Check that a cost centre has been selected for each row
		FieldName = "ddlCostCentre_"+arrlist[i];
		if(document.Form1[FieldName].selectedIndex == 0) 
		{
			msg= msg + 'Please enter a Cost Centre for row ' + arrlist[i] + linebreak;
			args.IsValid = false;
		}
		
		// Check that a rate has been selected for each row
		FieldName = "txtrate_"+arrlist[i];
		if(document.Form1[FieldName].value == '') 
		{
			msg = msg + 'Please enter a Rate for row ' + arrlist[i] + linebreak;
			args.IsValid = false;
		}
		
	}	

	oSrc.errormessage =msg;
	return;
}