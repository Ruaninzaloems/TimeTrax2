function struct(text,value) {
 // Set the structure of our object
	this.parentID = null;
	this.itemID = null;
	this.itemName = text || null;
	this.FQN = value || null;
	// function to load parentID and itemID from value
	this.splitVal(value);

}

struct.prototype.splitVal = function(value) {
	// this function is a prototype of struct
	// which means 1 can directly access the items in struct
	var arrTemp = new Array();
	// Check if the value contains Parent and child seperated by #
	// if not then return th value passed in otherwise
	// get the child id as itemID
	if(value.indexOf('#')>0){
		arrTemp = value.split('#');
		this.parentID = arrTemp[0];
		this.itemID = arrTemp[1];
	} else {
		this.itemID = value;
	}
}

function filterObj(selObj) {
	this.selObj = selObj;
	this.arrItem = new Array();
	this.init();
}

//filterObj.prototype.init = function(selObj) {
filterObj.prototype.init = function() {
	// This function will populate the item array with the initial
	// values from selObj
	// Removed VF 05/01/2005
	//var o = new struct('Please select ...','');
	//this.arrItem.push(o);

	for(k=0; k < this.selObj.length; k++)
	{
		//if(k<3) {alert('txt ' + this.selObj.options[k].text + ' val ' + this.selObj.options[k].value); }
		//alert('filterObj Init ' + this.selObj.options[k].value + ' txt ' + this.selObj.options[k].text);
		var o = new struct(this.selObj.options[k].text,this.selObj.options[k].value);
		this.arrItem.push(o);
	}
}

filterObj.prototype.populate = function(parentID,allowAll,useFQN) {
	// This function will populate selObj with the
	// values from item array that match parentID
	// If allowAll is true then add the 'All' text with value 0
	// If useFQN is true then stuffbox will use FQN as value not ItemID (FQN used by IDP Framework Wizard)
	document.body.style.cursor = 'wait';
	this.clearBox();
	if(allowAll) {
		this.stuffBox("All",0);
	}
	for(k = 0; k < this.arrItem.length; k++)
	{
	// Added VF 05/01/2005 to populate All items if parentID = 0
		if(this.arrItem[k].parentID == parentID||parentID == '0') {
			if(useFQN) {
				this.stuffBox(this.arrItem[k].itemName,this.arrItem[k].FQN);
			} else {
				this.stuffBox(this.arrItem[k].itemName,this.arrItem[k].itemID);
			}
		}
	}
	document.body.style.cursor = 'default';
}

filterObj.prototype.populateAll = function(selObj) {
	// This function will populate selObj with the
	// values from item array
	document.body.style.cursor = 'wait';
	for(k = 0; k < this.arrItem.length; k++)
	{
			var oOption = document.createElement("OPTION");
			oOption.text= this.arrItem[k].itemName;
			oOption.value=this.arrItem[k].itemID;
			selObj.options.add(oOption);
	}
	document.body.style.cursor = 'default';
}
filterObj.prototype.clearBox = function() {
	// This function clear selObj
	this.selObj.length = 0;
}

filterObj.prototype.stuffBox = function(text,value) {
	// This function will add text and value
	// into selObj
	var oOption = document.createElement("OPTION");
	oOption.text= text;
	oOption.value=value;
	this.selObj.options.add(oOption);
}

filterObj.prototype.GetParentID = function(childID) {
	// This function gets the corresponding ParentID of the passed in ChildID
	for(k=0; k < this.arrItem.length; k++)
	{
		if(this.arrItem[k].itemID == childID) {
			return this.arrItem[k].parentID;
		}
	}
}

filterObj.prototype.GetText = function(itemID) {
	// This function gets the corresponding text value of the passed in ItemID
	if(itemID==undefined||itemID==null) {
		// No ItemID passed to function
		return '';
	}
	for(k=0; k < this.arrItem.length; k++)
	{
		if(this.arrItem[k].itemID == itemID) {
			return this.arrItem[k].itemName;
		}
	}
}
