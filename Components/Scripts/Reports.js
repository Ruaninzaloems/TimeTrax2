//-------------------------------------------------------------------------------------------------------------------------
function MoveUp(oObjSource)
	{
		var nPos
		var sText
		var sValue
		var nodX
		var i

		if (oObjSource.options != null){
			var idx = oObjSource.options.length;
			i = idx;
			while (i>0) {
				i=(i-1);
				if (oObjSource.options[i].selected == true) {
					if (i > 0) {
						// if < 0 then trying to move past top
						nodX = oObjSource.options[i];
						sValue = nodX.value;
						sText = nodX.text;
						oObjSource.removeChild(nodX);
						nodX = document.createElement("Option");
						nodX.text = sText;
						nodX.value = sValue;
						nPos = (i-1);
						oObjSource.add(nodX, nPos);
					} else {
						alert('You cannot move an item past the top of the list!');
					}
				}
			}
			if (idx == 0 || nPos < 0){
				// No Items in listbox
				oObjSource.selectedIndex = 0;
				oObjSource.focus; 
			} else if (oObjSource.length >= 1){
				// Select the item at new position
				oObjSource.selectedIndex = nPos;
				oObjSource.focus; 
			}
		}
	}
function MoveDown(oObjSource)
	{
		var nPos
		var sText
		var sValue
		var nodX
		var i

		if (oObjSource.options != null){
			var idx = oObjSource.options.length;
			i = idx;
			while (i>0) {
				i=(i-1);
				if (oObjSource.options[i].selected == true) {
					if (i < (idx-1)) {
						// if = idx then trying to move past end of list
						nodX = oObjSource.options[i];
						sValue = nodX.value;
						sText = nodX.text;
						oObjSource.removeChild(nodX);
						nodX = document.createElement("Option");
						nodX.text = sText;
						nodX.value = sValue;
						nPos = (i+1);
						oObjSource.add(nodX, nPos);
					} else {
						alert('You cannot move an item past the end of the list!');
					}	
				}
			}
			if (idx == 0){
				// No Items in listbox
				oObjSource.selectedIndex = 0;
				oObjSource.focus; 
			} else if (nPos==undefined||(nPos > (idx-1))){
				// Trying to move past the end
				oObjSource.selectedIndex = idx-1;
				oObjSource.focus; 
			} else if (oObjSource.length >= 1){
				// Select the item at new position
				oObjSource.selectedIndex = nPos;
				oObjSource.focus; 
			}
		}
	}


// This function creates comma seperated textfields from the grouping select list
function loadGroupList(formObj) {
	var i
	var oObjSource = eval(formObj['ucReportFilters:_lstGroupBy']);
	// ensure that the grouping_list is clear
	formObj['ucReportFilters_grouping_list'].value = '';

	if (typeof oObjSource != 'undefined')
	{
		if (oObjSource.options != null)
		{
			var idx = oObjSource.options.length;
			i = 0;
			while (i<(idx)) 
			{
				addValue(formObj,'grouping',oObjSource.options[i].value);
				i=(i+1);
			}
		}
	}
	formObj['ucReportFilters_btnGenerate'].click();
}

function addValue(formObj,sourceKeyName,iRowCount) {
		if(formObj['ucReportFilters_' + sourceKeyName.toLowerCase() + '_list'].value.length == 0)
		{
			formObj['ucReportFilters_' + sourceKeyName.toLowerCase() + '_list'].value += ',';
		}
		formObj['ucReportFilters_' + sourceKeyName.toLowerCase() + '_list'].value += iRowCount + ',';
}

function addText(formObj,sourceKeyName,iRowCount) {
		if(formObj['ucReportFilters_' + sourceKeyName.toLowerCase() + '_list'].value.length == 0)
		{
			formObj['ucReportFilters_' + sourceKeyName.toLowerCase() + '_list'].value += '#';
		}
		formObj['ucReportFilters_' + sourceKeyName.toLowerCase() + '_list'].value += iRowCount + '#';
}

// This function checks if a project is captured if a project is required
function ValidateProject(oSrc, args) 
{
	oSrc.errormessage = '';
	
	if (document.Form1['ucReportFilters:hidProjRequired'].value == '1')
	{
		if (document.Form1['ucReportFilters:ddlProject'].value == 0)
		{
			//Set the error description
			args.IsValid = false;
			oSrc.errormessage += "Please select a Project"; 			
		}
	}
	
	//if (args.IsValid == false)
	//{
	//	alert(oSrc.errormessage);
	//}
	
	return(args.IsValid);
}