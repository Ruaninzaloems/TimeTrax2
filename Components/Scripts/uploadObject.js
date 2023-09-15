//***********************************************************************
//                     This script was developed by:                    *
//                             VINCE FRIDAY								*
//                          ©Intermap (PTY) Ltd							*
//                           www.intermap.co.za							*
//                             Version 1.1								*
//***********************************************************************
function validateUpload(objFile,max,arrTypes)
{
	try 
	{
		var oas = new ActiveXObject("Scripting.FileSystemObject");
		var d = objFile.value;
		var f = oas.getFile(d);
		var s = f.size;
		var e = f.shortname.substr((f.shortname.length-4));
		// Check if file has valid extension
		var t = InArray(arrTypes,e);
		if(s>max||!t)
		{
			//incorrect file size
			if(s>max)
			{
				alert("Error:File may not exceed " + max + " bytes");
			} else {
				//incorrect file type
				alert('Error:File may not be of type ' + f.type);
			}
		} else	{
			//Submit form
			document.all.btnSubmit.click();
		}
	}
	catch(ex)
	{
		switch(ex.description)
		{
			case "Automation server can't create object":
				var URL;
				//URL = "http://beta.intermap.co.za/App_Common/ActiveXErrorPage.htm";
				URL = "http://localhost/App_Common/ActiveXErrorPage.htm";
				window.open(URL,"Popup","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=600,top=300,left=300,resizable=1");
				break;
			case "Invalid procedure call or argument":
				alert('Please select a Document to Upload.');
				break;
			case "File not found":
				alert('Please select a valid Document to Upload.');
				break;
			default:
				alert('ActiveX Error (' + ex.description + ')\nPlease Notify Intermap Customer Care');
				break;
		}
	}
}

function InArray(arr,val)
{
	for(var i=0;i<arr.length;i++)
	{
		if(arr[i].toLowerCase()==val.toLowerCase()) 
		{
			return true;
		}
	}
	return false;
}


function window.onbeforeunload() 
{
	//Load the document details on the calling page if there is a document
	if (document.all.hidFinDoc.value == '1')
	{		
		if ((document.all.hidTitle.value != '') && (document.all.hidError.value != 1))
		{
			opener.document.getElementById('tdInvoiceAmtWarning').innerHTML = '<font color="red">Please note: The invoiced amounts will only be updated once the invoice has been approved</font>';
		}
	}
	else
	{
		LoadDoc();
	}
}

function LoadDoc()
{
			
	if ((document.all.hidTitle.value != '') && (document.all.hidError.value != 1))
	{

		var objTable = opener.document.getElementById('ucProjInfo_ucProjectDocuments_tblProjectDocuments');
		var oRow, oCell;
		var strFileHRef;
		var strImg, strSrc, strExt;
		
		if (objTable == undefined)
		{
			objTable = opener.document.getElementById('ucProjectDocuments_tblProjectDocuments');
		}
		oRow = objTable.insertRow();
				
		//Set the Href		
		strFileHRef = document.all.hidAppPath.value + '/' + document.all.hidUploadsPath.value + '/Documents/' + document.all.hidFileName.value;
		
		//Set the image HTML
		//1. First determine the source
		strExt = document.all.hidFileName.value.substr(document.all.hidFileName.value.length - 4, 4);
		
		switch (strExt.toUpperCase()) 
		{ 
			case ".JPG" : 
				strSrc = '../images/jpg.gif';
				break; 
			case ".PDF" : 
				strSrc = '../images/pdf.gif';
				break; 
			case ".ZIP" : 
				strSrc = '../images/zip.gif';
				break; 
			case ".DOC" : 
				strSrc = '../images/doc.gif';
				break; 
			case ".TIF" : 
				strSrc = '../images/tif.gif';
				break; 
			case ".BMP" : 
				strSrc = '../images/bmp.gif';
				break; 
			case ".XLS" : 
				strSrc = '../images/xls.gif';
				break; 
			default : 
				strSrc = '../images/detail.gif';
		} 
		//2. Determine the text to create the string
		strImg = '<img src="' + strSrc + '" alt="View Document" style="CURSOR: hand" onclick=javascript:openDocumentPage("' + strFileHRef + '"); />';
		
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.innerHTML = strImg;
		
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.innerHTML = '<a href="' + strFileHRef + '" Target="_blank">' + document.all.hidTitle.value + '</a>'; 
		
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.innerText = document.all.hidDate.value;
					
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.align = 'right';
		oCell.innerText = Math.round(document.all.hidSize.value / 1000);

	}

}

function LoadFinancialDoc()
{
			
	if ((document.all.hidTitle.value != '') && (document.all.hidError.value != 1))
	{

		var objTable = opener.document.getElementById('ucProjInfo_ucFinancialDocuments_tblFinancialDocuments');
		var oRow, oCell;
		var strFileHRef,strViewFileHRef;
		var strImg, strSrc, strExt;
		
		if (objTable == undefined)
		{
			objTable = opener.document.getElementById('ucFinancialDocuments_tblFinancialDocuments');
		}
		oRow = objTable.insertRow();
				
			
		//Set the image HTML
		//1. First determine the source
		strExt = document.all.hidFileName.value.substr(document.all.hidFileName.value.length - 4, 4);
		
		switch (strExt.toUpperCase()) 
		{ 
			case ".JPG" : 
				strSrc = '../images/jpg.gif';
				break; 
			case ".PDF" : 
				strSrc = '../images/pdf.gif';
				break; 
			case ".ZIP" : 
				strSrc = '../images/zip.gif';
				break; 
			case ".DOC" : 
				strSrc = '../images/doc.gif';
				break; 
			case ".TIF" : 
				strSrc = '../images/tif.gif';
				break; 
			case ".BMP" : 
				strSrc = '../images/bmp.gif';
				break; 
			case ".XLS" : 
				strSrc = '../images/xls.gif';
				break; 
			default : 
				strSrc = '../images/detail.gif';
		} 
		//2. Determine the text to create the string
		strFileHRef = document.all.hidAppPath.value + '/' + document.all.hidUploadsPath.value + '/Documents/' + document.all.hidFileName.value;
		strImg = '<img src="' + strSrc + '" alt="View Financial Document" style="CURSOR: hand" onclick=javascript:openDocumentPage("' + strFileHRef + '"); />';
		
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.innerHTML = strImg;
		
		strViewFileHRef = document.all.hidAppPath.value + '/Project/ViewFinancialDocument.aspx?ProjectID=' + document.all.hidProjectID.value + '&FinancialDocumentID=' + document.all.hidFinDocID.value;
		strImg = '<img src="../images/order.gif" alt="View Financial Document Details" style="CURSOR: hand" onclick=javascript:openDocumentPage("' + strViewFileHRef + '"); />';
		
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.innerHTML = strImg;
		
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.innerHTML = '<a href="' + strFileHRef + '" Target="_blank">' + document.all.hidTitle.value + '</a>'; 
		
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.innerText = document.all.hidDate.value;
		
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.align = 'right';
		oCell.innerText = 'R ' + document.all.hidAmount.value;
					
		oCell = oRow.insertCell();
		oCell.className = 'td1';
		oCell.align = 'right';
		oCell.innerText = Math.round(document.all.hidSize.value / 1000);

	}

}