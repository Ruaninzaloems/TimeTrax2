/*
This file allows you to add dynamic rows and to add and  delete Groups of rows to both the top and bottom of a collection
*/
function swapVisibility(objectVisSwap, testString, testValue)
{
	objectVisSwap.style.display = ((testString == testValue) ? '' : 'none');
}
	
//*************************************************************************************************************
function deleteFormSection(sourceKeyName, deleteButton, formObj, altFieldToStore)
{	
	var strImgBtnName = deleteButton.name;
		if(strImgBtnName.indexOf('imgDelete' + sourceKeyName + '_') == -1)
		{
			return false;
		}
	
	var vntSectionID;
	var intSectionID = 0;
		vntSectionID = strImgBtnName.substring(('imgDelete' + sourceKeyName + '_').length);
		intSectionID = parseInt(vntSectionID);
		vntSectionID = '#' + vntSectionID + '#';  //SD: 19/10/2005 - Change dymanic adds from , to #
	var strSectionIDs = formObj[sourceKeyName.toLowerCase() + '_list'].value;
		strSectionIDs = strSectionIDs.replace(vntSectionID, '#');	//SD: 19/10/2005 - Change dymanic adds from , to #
		formObj[sourceKeyName.toLowerCase() + '_list'].value = strSectionIDs;
		
		if(typeof(altFieldToStore) != 'undefined')
		{
			if(altFieldToStore.indexOf('_') > -1)
			{
				if(typeof(formObj[sourceKeyName.toLowerCase() + '_deletes']) != 'undefined' && typeof(formObj[altFieldToStore + intSectionID]) != 'undefined')
				{
					formObj[sourceKeyName.toLowerCase() + '_deletes'].value += intSectionID + '=' + formObj[altFieldToStore + intSectionID].value + ';';
				}
			}
		}
		
	var objTable = eval('tbl' + sourceKeyName);
	var objRow;
	var strAlpha = 'ZYXWVUTSRQPONMLKJIHGFEDCBA';
	var intAlphaLoc = 0;
	var intCNT = 0;
	
		for(intAlphaLoc = 0; intAlphaLoc < strAlpha.length; intAlphaLoc++)
		{
			objRow = objTable.rows['row' + sourceKeyName + intSectionID + strAlpha.charAt(intAlphaLoc).toLowerCase()];
			if(typeof(objRow) == 'object')
			{
				intCNT = 0;
				while(intCNT < objTable.rows.length && intCNT > -1)
				{
					if(objTable.rows[intCNT].id == objRow.id)
					{
						objTable.deleteRow(intCNT);
						intCNT = -100;
					}
					else
					{
						intCNT++
					}
				}
			}
		}
		
		if(rowItemCount(objTable, sourceKeyName) == 0)
		{
			swapVisibility(objTable.rows[0], objTable.rows[0].id, 'row' + sourceKeyName + 'DefaultNone')
		}
		
		return true;
		
		
}
//*************************************************************************************************************************
function addFormSection(sourceKeyName, formObj, tblPos)
{
	var objTable = eval('tbl' + sourceKeyName);
	var objDefaultRow, idCurrentRow;
	var objRow;
	var iRowCount = rowItemCount(objTable, sourceKeyName, tblPos);
	var strAlpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var intAlphaLoc = 0;
	var i = 0;
		if(iRowCount == 0)
		{
			if(objTable.rows[0].id == 'row' + sourceKeyName + 'DefaultNone')
			{
				objTable.rows[0].style.display = 'none';
			}
		}
		
			//Check for position, and if top, then rowcount is before the first
			if(typeof(tblPos) != 'undefined')
			{
				if (tblPos == "top")
				{
				iRowCount --;
				}
				else
				{
				iRowCount ++;
				}
			}
			else
			{
			iRowCount ++;
			}
			
		objDefaultRow = objTable.rows['row' + sourceKeyName + 'Default' + strAlpha.charAt(intAlphaLoc)];
		while(typeof(objDefaultRow) == 'object')
		{
			//Check for position, and if top, then add to top, else to bottom
			if(typeof(tblPos) != 'undefined')
			{
				if (tblPos == "top")
				{
					if (idCurrentRow == objDefaultRow.id)
					{
					}
					else
					{
					idCurrentRow = objTable.rows['row' + sourceKeyName + 'Default' + strAlpha.charAt(intAlphaLoc)].id;
					i+=1
					}
					objRow = objDefaultRow.cloneNode(true);
					objRow = objTable.rows[0 + i].insertAdjacentElement("afterEnd", objRow);
				}
				else
				{
					objRow = objDefaultRow.cloneNode(true);
					objRow = objTable.rows[objTable.rows.length - 1].insertAdjacentElement("afterEnd", objRow);
				}
			}
			else
			{
				objRow = objDefaultRow.cloneNode(true);
				objRow = objTable.rows[objTable.rows.length - 1].insertAdjacentElement("afterEnd", objRow);
			}
			
			objRow.id = 'row' + sourceKeyName + iRowCount + strAlpha.charAt(intAlphaLoc).toLowerCase();
			objRow.style.display = '';

			if(intAlphaLoc == 0 && iRowCount > 1)
			{
				if(objRow.hasChildNodes())
				{
					for(var intCNT = 0; intCNT < objRow.children.length; intCNT++)
					{
						objRow.children[intCNT].style.borderTop = 0;
						objRow.children[intCNT].style.borderTopColor = '#000000';
						objRow.children[intCNT].style.borderTopStyle = 'inset';
					}
				}
			}

			reIdentifyChildren(objRow, iRowCount, 0);

			intAlphaLoc++;
			objDefaultRow = objTable.rows['row' + sourceKeyName + 'Default' + strAlpha.charAt(intAlphaLoc)];
		}
		
		if(formObj[sourceKeyName.toLowerCase() + '_list'].value.length == 0)
		{
			formObj[sourceKeyName.toLowerCase() + '_list'].value += '#';  //SD: 19/10/2005 - Change dymanic adds from , to #
		}
		formObj[sourceKeyName.toLowerCase() + '_list'].value += iRowCount + '#'; //SD: 19/10/2005 - Change dymanic adds from , to #
}

//*************************************************************************************************************
function reIdentifyChildren(sourceRow, rowItemCounter, tblInsetID)
{
	var tblInset = 0, tblInsetID, strTemp, strTMP = '', strStart = '', strEnd = '';
	
		//Use this to have a table in a table and use "Sub1"
		strTemp = sourceRow.id;
		strTemp = strTemp.split("Sub1", -1)
		strStart = new String(strTemp[0])
		strEnd= new String(strTemp[1])
		if (strTemp.length > 1 && strStart.length > 0 && typeof(strStart) != 'undefined' && typeof(strEnd) != 'undefined')
		{
			if (strEnd.substring(0, 7) == 'Default' || strStart.substring(0, 3) == 'tbl' || strStart.substring(0, 6) == 'imgAdd' )
			{
			sourceRow.id = strStart + "_" + rowItemCounter + strEnd;
			sourceRow.name = strStart + "_" + rowItemCounter + strEnd;
			}
			else
			{
			sourceRow.id = strStart + "_" + rowItemCounter + "_" + strEnd;
			sourceRow.name = strStart + "_" + rowItemCounter + "_" + strEnd;
			}
			//alert("1\nID: " +sourceRow.id+"\n Name: "+sourceRow.name);
			tblInset = 1;
		}

		//Use this to have a table in a table in a tableand use  "Sub2"
		strTemp = sourceRow.id;
		strTemp = strTemp.split("Sub2", -1)
		strStart = new String(strTemp[0])
		strEnd= new String(strTemp[1])
		if (strTemp.length > 1 && strStart.length > 0 && typeof(strStart) != 'undefined' && typeof(strEnd) != 'undefined')
		{
			//Set "Sub2 to the tabInset value and Set to "Sub1"
			sourceRow.id = strStart + "_" + tblInsetID + "Sub1" + strEnd;
			sourceRow.name = strStart + "_" + tblInsetID + "Sub1" + strEnd;
			tblInset = 2;
		}
	
		//Only do these if the inset have not been done
		strTMP = new String(sourceRow.id);
		if(strTMP.length > 0 && strTMP.charAt(strTMP.length - 1) == '_' && tblInset == 0)
		{
			sourceRow.id += rowItemCounter;
		}
		
		//Only do these if the inset have not been done
		strTMP = new String(sourceRow.name);
		if(strTMP.length > 0 && strTMP.charAt(strTMP.length - 1) == '_' && tblInset == 0)
		{
			sourceRow.name += rowItemCounter;
		}
	
		if (tblInset == 1)
		{
		tblInsetID = sourceRow.id.split("_", -1);
		tblInsetID = tblInsetID[1];
		tblInsetID = tblInsetID.substring(0, 1);
		}
		
		if(sourceRow.hasChildNodes())
		{
			for(var x=0; x < sourceRow.children.length; x++)
			{
				reIdentifyChildren(sourceRow.children[x], rowItemCounter, tblInsetID);
			}
		}
}

//*************************************************************************************************************
function rowItemCount(sourceTable, sourceKeyName, tblPos)
{
	var iItemCount = 0;
	var objRows = sourceTable.rows;
	var iRowCount = objRows.length;
	var strID = new String('');
	
				for(var intCNT=0; intCNT < iRowCount; intCNT++)
				{
					strID = objRows[intCNT].id;
					if(strID.indexOf('Default') == -1)
					{
						strID = strID.substring(('row' + sourceKeyName).length, (('row' + sourceKeyName).length + strID.length -('row' + sourceKeyName).length + 1));
						if(parseInt(strID))
						{
							//Check for position, and if top, then rowcount is before the first
							if(typeof(tblPos) != 'undefined')
							{
								if (tblPos == "top")
								{
									if(iItemCount > parseInt(strID))
									{
										iItemCount = parseInt(strID);
									}
								}
								else
								{
									if(iItemCount < parseInt(strID))
									{
										iItemCount = parseInt(strID);
									}
								}
							}
							else
							{
								if(iItemCount < parseInt(strID))
								{
									iItemCount = parseInt(strID);
								}
							}
					}
				}
			}
		return iItemCount;
}

//**********************************************************************************************************************************
// VALIDATE  DYNAMIC ADD/DELETE ROWS (See Admin Manage Constants pages)
//**********************************************************************************************************************************

function ValidateConstantDynamic(oSrc,args){

	var itemlist,items,TempR;
	
	itemlist= document.all.item_list.value;
	items = itemlist.split("#");  //SD: 19/10/2005 - Change dynamic adds to use # not ,
	items = items[(items.length - 2)];
	
	if ((itemlist == "")||(itemlist == "#"))
	{args.IsValid = true;}
	else
	{
		var i=0;
		while (i < parseFloat(items))
		{
			i=i+1;
			try 
			{
				//CHECK REMARKS TEXT
				TempR = document.all["Filters1_txtconstant_" + i].value;
				if (TempR == "")
				{
					oSrc.errormessage = "Constant row " + i + " has no value";
					args.IsValid = false;
					return;
				}
			}
			catch(e){}
		}
	}
}

