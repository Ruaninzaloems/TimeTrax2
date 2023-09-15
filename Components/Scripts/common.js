// Common scripts for the Intermap Agtrack version 2 application
//---------------------------------------------------------------------------------------------------------------------------------------------			

function getDDLselectedIndex_Text(obj, value)
	{       
		var i, a;
		i = 0;
		while (i < obj.length)
		{
			if (obj.options[i].text == value)
			{        
								return i;
			}
			i+=1;
		}
		return 0;
	}

function getDDLselectedIndex(obj, value)
	{       
		var i, a;
		i = 0;
		while (i < obj.length)
		{
			if (obj.options[i].value == value)
			{        
								return i;
			}
			i+=1;
		}
		return 0;
	}

function setTimerStatus() {
	var appPath = document.all['ucHeader_hidAppPath'].value;
 // this function checks if there is a timepopup cookie for the user or not
 // and sets the timer button colour and text accordingly
	userid = document.all['ucHeader_hidUserID'].value;
	var cookiename = 'TimePopUp' + userid;
	var cookievals = GetCookie(cookiename);
	if(cookievals != null){
		if(GetCrumb(cookievals,"Case")=='')
		{
			// Cookie exists but value is blank
			document.all.btnTimer.src = appPath + '/Images/Start.gif';
		} else {
			document.all.btnTimer.src = appPath + '/Images/Stop.gif';
		}
	} else {
		document.all.btnTimer.src = appPath + '/Images/Start.gif';
	}
}
function openTimePopup() {
	// This function will only open the Time Popp window if
	// the CasePlanId or EventId has changed
	var appPath = document.all['ucHeader_hidAppPath'].value;
	var url, userid, caseid, ckcase, eventid, ckevent;
	userid = document.all['ucHeader_hidUserID'].value;
	caseid = document.all['ucHeader_hidCurrCaseID'].value;
	eventid = document.all['ucHeader_hidCurrEventID'].value;
	url = appPath + "/Timesheet/PopUp.aspx";
	var cookiename = 'TimePopUp' + userid;
	var cookievals = GetCookie(cookiename);
	var scrnmidtop = ((screen.availHeight / 2) - 75);
	var scrnmidleft = ((screen.availWidth / 2) - 235);
	if(cookievals != null){
		ckcase = GetCrumb(cookievals,"Case");
		ckevent = GetCrumb(cookievals,"Event");
		if(caseid!=ckcase||eventid!=ckevent){
			window.open(url,"PopUp","toolbar=0,location=0,status=1,menubar=0,scrollbars=0,width=470,height=150,top=" + scrnmidtop + ",left=" + scrnmidleft + ",resizable=0");
		}
	} else {
			window.open(url,"PopUp","toolbar=0,location=0,status=1,menubar=0,scrollbars=0,width=470,height=150,top=" + scrnmidtop + ",left=" + scrnmidleft + ",resizable=0");
	}
}

function generateDoc(DocID) {
	var appPath = document.all['ucHeader_hidAppPath'].value;
	var url;
	url = appPath + "/Actions/DocGenerate.aspx?DocID=" + DocID;
	window.open(url,"Action","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=600,top=50,left=50,resizable=0");
}

// ButtonBar functions
function NewConApt() {
	generateDoc(58);
}
	
function Docs(DocID) {
	var appPath = document.all['ucHeader_hidAppPath'].value;
	var url, Ref;
	Ref = document.Form1.txtRef.value;
	//alert('Ref: ' + Ref);
	// This is to ensure that a case is currently loaded
	if(Ref != undefined) {
		url = appPath + "/Actions/Communication.aspx";
		window.open(url,"Action","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=600,top=50,left=50,resizable=0");
	}
}
	
function ChangeConsultant() {
	var appPath = document.all['ucHeader_hidAppPath'].value;
	var url, Ref;
	Ref = document.Form1.txtRef.value;
	//alert('Ref: ' + Ref);
	// This is to ensure that a case is currently loaded
	if(Ref != undefined) {
		url = appPath + "/Actions/ConsultantChange.aspx";
		window.open(url,"Action","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=350,top=50,left=50,resizable=0");
	}
}
	
function Uploads() {
	var appPath = document.all['ucHeader_hidAppPath'].value;
	var url, Ref;
	Ref = document.Form1.txtRef.value;
	//alert('Ref: ' + Ref);
	// This is to ensure that a case is currently loaded
	if(Ref != undefined) {
		url = appPath + "/Actions/DocUploads.aspx";
		window.open(url,"Action","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=350,top=50,left=50,resizable=0");
	}
}

//---------------------------------------------------------------------------------------------------------------------------------------------			
// Function used to move elements between two listboxes.
// On Error Resume Next
function MoveElement(oObjSource, oObjDestination){
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
				nodX = oObjSource.options[i];
				sValue = nodX.value;
				sText = nodX.text;
				oObjSource.removeChild(nodX);
				nodX = document.createElement("Option");
				nodX.text = sText;
				nodX.value = sValue;
				nPos = (oObjDestination.children.length+1);
				oObjDestination.add(nodX, nPos);
			}
		}
		if ((idx == 0) && (oObjSource.length > 0)){
			oObjSource.selectedIndex = 0;
			oObjSource.focus; 
		} else if ((oObjSource.length-1) >= idx){
			oObjSource.selectedIndex = idx;
			oObjSource.focus; 
		} else if (oObjSource.length >= 1){
			oObjSource.selectedIndex = idx-1;
			oObjSource.focus; 
		}
	}
}

//---------------------------------------------------------------------------------------------------------------------------------------------			
/*function Calendar(thisval)
{
	// Your image tag must be called the same as the textbox without the txt,
	// and your div tag must be the textbox name without the txt, and with div in the front
	var txtName, divName;
	txtName = eval("document.Form1.txt"+thisval.name);
	divName = "div"+thisval.name
	imcalendar.select(txtName, divName, 'dd/MM/yyyy'); 
	return false;
}*/
//---------------------------------------------------------------------------------------------------------------------------------------------			
function checkKey() {
	if (event.keyCode == 13){
		//alert('enter key pressed');
    // cancel the default submit
    event.returnValue=false;
    event.cancel = true;
    // press the Go button automatically
		document.all.ucMainTop_btnGo.click();
	}
}
//---------------------------------------------------------------------------------------------------------------------------------------------			
function search(typ)
{
// Used for Upload and Delete Project Search
	if(typ == "D") {
		var ProjName = document.Form1.txtProjName.value, ProjNo = document.Form1.txtProjNo.value, URL;
	}
// Used for Withdraw Project Search
	if(typ == "W") {
		var ProjName = document.Form1.txtProjName.value, ProjNo = document.Form1.txtProjNo.value, URL;
	}
// Used for Project Search
	if(typ == undefined) {
		var ProjNo = document.Form1.textfield.value, URL,ProjName;
	}
	URL = "/Regions/Search.aspx?ProjCode="+ProjNo+"&ProjName="+ProjName+"&Typ="+typ;
	window.open(URL,"Search","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,width=500,height=300,top=150,left=200,resizable=1");
}
//**********************************************************************************************************************************
function searchDel()
{
	var ProjName = document.Form1.txtProjName.value, ProjNo = document.Form1.txtProjNo.value, URL;
	URL = "/Regions/Search.aspx?ProjCode="+ProjNo+"&ProjName="+ProjName+"&Typ=D";
	window.open(URL,"Search","toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=500,height=300,top=150,left=200,resizable=1");
}

//---------------------------------------------------------------------------------------------------------------------------------------------			
			function openMe(typ)
			{
				var URL;
			//	alert('typ: ' + typ);
				if (typ == "support")
				{
					URL = "http://www.intermap.co.za/IMASP/Suggestions.asp?system=Agtrack2";
					window.open(URL,"Support","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,width=850,height=550,top=100,left=100,resizable=1");
				}
				if (typ == "comment")
				{
					URL = "http://www.intermap.co.za/IMASP/Suggestions.asp?system=Agtrack2";
					window.open(URL,"Comment","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,width=850,height=550,top=100,left=100,resizable=1");
				}
			}
//---------------------------------------------------------------------------------------------------------------------------------------------			
function ToggleDisplay(oButton, oItems) //, oHeader)
{
	var appPath = document.all['ucHeader_hidAppPath'].value;
    if ((oItems.style.display == "") || (oItems.style.display == "none"))
    {
//              Temp = oHeader + '.className="th2";'
//              eval(Temp);
        oItems.style.display = "block";
        oButton.src = appPath + "/Images/up.gif";
    }  else {
//              Temp = oHeader + '.className="th4";'
//              eval(Temp);
        oItems.style.display = "none";
        oButton.src = appPath + "/Images/down.gif";
    }
    return false;
}
//---------------------------------------------------------------------------------------------------------------------------------------------			
	    function ToggleHide(str)
      {
      var obj;
      obj = document.all[str];
     
          if ((obj.style.display == "") || (obj.style.display == "none"))
          {
              obj.style.display = "block";
          }  else {
              obj.style.display = "none";
          }
          return false;
      }
      
//---------------------------------------------------------------------------------------------------------------------------------------------			
// Ensure that at least one budget year exists
        function ToggleAlerts(oButton, oItems)
        {
			var appPath = document.all['ucHeader_hidAppPath'].value;
            if ((oItems.style.display == "") || (oItems.style.display == "none"))
            {
                oItems.style.display = "block";
                oButton.src = appPath + "/Images/up.gif";
            }  else {
                oItems.style.display = "none";
                oButton.src = appPath + "/Images/down.gif";
            }
            return false;
        }

//#################################################################
//#####     Set/Retrieve javascript cookie  on client machine   ###
//#################################################################
/*
NOTES: 
1) The value is passed to the JScript <B>escape</B> function to ensure that the 
value only contains valid characters
2) When the cookie is retrieved, the JScript <B>unescape</B> function should be 
used to translate the value back to its original form.
*/

function SetCookie(sName, sValue)
{

	// the format of the date is YYYY/MM/DD
	var today = new Date();
	var ExpiresDate = new Date(today.getFullYear(),today.getMonth(),today.getDate() +1);
	 document.cookie = sName + "=" + escape(sValue) + "; expires=" + ExpiresDate.toGMTString() + "; path=" + appPath;
	 // this cookie expires tomorrow
}


// _________________ obtaining the value of a cookie, given a name ________________
function GetCookie(sName)
{
  // cookies are separated by semicolons
  var aCookie = document.cookie.split("; ");
  for (var i=0; i < aCookie.length; i++)
  {
    // a name/value pair (a crumb) is separated by an equal sign
    var aCrumb = aCookie[i].split("=");
    if (sName == aCrumb[0]) 
      return unescape(aCrumb[1]);
  }
  // a cookie with the requested name does not exist
  return null;
}

// _________________ obtaining the value of a cookie crumb, given the crumb key name ________________
function GetCrumb(scook,sName)
{
  // cookies are separated by semicolons, so remove semicolon from scook
  var scook = scook.split(";")[0]
  // crumbs are separated by &
  var aCookie = scook.split("&");
  for (var i=0; i < aCookie.length; i++)
  {
    // a name/value pair (a crumb) is separated by an equal sign
    var aCrumb = aCookie[i].split("=");
    if (sName == aCrumb[0]) 
      return unescape(aCrumb[1]);
  }
  // a cookie with the requested name does not exist
  return null;
}

//######################################################
//########        WEB SERVICE CALLS	       #############
//######################################################
	//__________________________ Web service reference __________________________
		
	// this function is called on application logon
	// and is used to prepare the webservice for use
	function ws_init()
	{		
		var appPath = document.all['ucHeader_hidAppPath'].value;
		iCallID = 0;
		var hostName = window.location.hostname;
		service.useService("http://" + hostName + appPath + "/Webservice/Alerts.asmx?WSDL","Alerts");					
	}

	//__________________________ Web service method call results __________________________

	// this retrieves the results of the closealert web method, done asynchronous
	function closealertresult()
	{
		if((event.result.error)&&(iCallID==event.result.id))
		{
			var xfaultcode = event.result.errorDetail.code;
			var xfaultstring = event.result.errorDetail.string;
			var xfaultsoap = event.result.errorDetail.raw;

			// Add code to output error information here
			alert("Unable to update last request, please try again ");
		}
		else
		{
			//alert("Updated ");
		}
	}


	//__________________________ Web service method calls __________________________

	// This function calls an asynchronous web service to Toggle the AlertClosed field value in the CaseAlerts Table
	// see AVMS_SelectCurrentAlerts Stored Procedure for function call
	function awshideAlert(obj){
	var Closed;
	var UserID = document.Form1.hidUserID.value;
	var CasePlanID = document.Form1.hidCasePlanID.value;
	if(obj.checked == true) {
		Closed = 1;
	} else {
		Closed = 0;
	} 
		service.Alerts.callService("CloseAlert",obj.id,Closed,CasePlanID,UserID);
}
