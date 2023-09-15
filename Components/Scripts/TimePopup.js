  // on submit overwrite the existing user cookie as it has already been saved
	// Save the UserID, CasePlanID, EventID, DateTime to clientcookie
	function savetimecookie()
	{
		var appPath = document.Form1.hidAppPath.value;
		if(document.Form1.ddlCases.value==''){
			alert('Please Select a Case!');
			return;
		}
		if(document.Form1.ddlEvent.value==''){
		document.Form1.ddlEvent.value='0';
		}
		var today = new Date();
		var cookiename = 'TimePopUp' + document.Form1.wsUserID.value;
		var cookieval = 'UserID=' + document.Form1.wsUserID.value + '&Case=' + document.Form1.wsCasePlanID.value + '&Event=' + document.Form1.wsEventID.value + '&StartTime=' + today + ';';
		SetCookie(cookiename,cookieval);
		opener.document.all.btnTimer.src = appPath + '/Images/Stop.gif';
		window.close();
	}

	// Save the UserID, CasePlanID, EventID, DateTime to clientcookie
	function check4cookie()
	{
		//var appPath = document.Form1.hidAppPath.value;
		var cookiename = 'TimePopUp' + document.Form1.wsUserID.value;
		var cookievals = GetCookie(cookiename);
		if(cookievals=='undefined'||cookievals==null){
			document.Form1.btnSubmit.style.display='none';
			document.Form1.btnStart.style.display='block';
		} else {
			if(GetCrumb(cookievals,"Case")=='')
			{
				// Cookie exists but value is blank
			document.Form1.btnSubmit.style.display='none';
			document.Form1.btnStart.style.display='block';
			} else {
				document.Form1.btnSubmit.style.display='block';
				document.Form1.btnStart.style.display='none';
				document.Form1.ddlCases.value=GetCrumb(cookievals,"Case");
				document.Form1.wsCasePlanID.value=document.Form1.ddlCases.value;
				document.Form1.ddlEvent.value=GetCrumb(cookievals,"Event");
				document.Form1.wsEventID.value=document.Form1.ddlEvent.value;
				var basedate = new Date(GetCrumb(cookievals,"StartTime"));
				var nowdate = new Date();
				var mins = ((nowdate.valueOf() - basedate.valueOf()) / 60000);
				document.Form1.txttime.value=ConvertToHrs(document.Form1.wsTimeBase.value,mins.toFixed(0));
				document.Form1.wsHrs.value=document.Form1.txttime.value;
			}
		}
	}

	function ConvertToHrs(timebase,val) {
		var hrs = 0;
		var hrsinmin = 0;
		if(timebase.value == 100 ) {
			// 30 mins = 0.5
			hrs = val / 60;
		} else {
			// 30 mins = 0.3
			hrsinmin = parseInt((val / 60));
			hrs = hrsinmin + ((val - (hrsinmin * 60))/100)
		}
		return hrs;
	}

	function timews_init()
	{		
		var appPath = document.Form1.hidAppPath.value;
		iCallID = 0;
		var hostName = window.location.hostname;
		timeservice.useService("http://" + hostName + appPath + "/Webservice/Alerts.asmx?WSDL","Time");
	}

	// this retrieves the results of the inserttime web method, done asynchronous
	function inserttimeresult()
	{
		//alert('inserttimeresult');
		//alert('iCallID ' + iCallID + ' resultID ' + event.result.id);
		if((event.result.error)&&(iCallID==event.result.id))
		{
			var xfaultcode = event.result.errorDetail.code;
			var xfaultstring = event.result.errorDetail.string;
			var xfaultsoap = event.result.errorDetail.raw;
			alert('error ' + xfaultstring);

			// Add code to output error information here
			alert("Unable to update last request, please try again ");
		}
		else
		{
			alert("Updated ");
		}
	}

	function timeresult(result)
	{
		var appPath = document.Form1.hidAppPath.value;
		//alert('timeresult');
		//alert('iCallID ' + iCallID + ' resultID ' + result.id);
		if((result.error)&&(iCallID==result.id))
		{
			var xfaultcode = result.errorDetail.code;
			var xfaultstring = result.errorDetail.string;
			var xfaultsoap = result.errorDetail.raw;

			// Add code to output error information here
			alert("Unable to update last request, please try again ");
		}
		else
		{
			// Hide the Submit button, Show the Start button and Clear the CasePlanID, EventID and Duration fields
			document.Form1.btnSubmit.style.display='none';
			document.Form1.btnStart.style.display='block';
			document.Form1.ddlCases.value='';
			document.Form1.wsCasePlanID.value='';
			document.Form1.ddlEvent.value='0';
			document.Form1.wsEventID.value='0';
			document.Form1.txttime.value='';
			document.Form1.wsHrs.value='';
			// Clear Time cookie as it cant be deleted
			//var appPath = document.Form1.hidAppPath.value;
			var today = new Date();
			var cookiename = 'TimePopUp' + document.Form1.wsUserID.value;
			var cookieval = 'UserID=' + document.Form1.wsUserID.value + '&Case=' + document.Form1.wsCasePlanID.value + '&Event=' + document.Form1.wsEventID.value + '&StartTime=;';
			SetCookie(cookiename,cookieval);
			opener.document.all.btnTimer.src = appPath + '/Images/Start.gif';
			
		}
	}
	// this function is called when the submit button on the TimePopup page is pressed
	// and is used to submit time captured from TimePopup window 
	function ws_submittime(obj){
	var appPath = document.Form1.hidAppPath.value;
	var UserID = document.Form1.wsUserID.value;
	var CasePlanID = document.Form1.wsCasePlanID.value;
	var EventID = document.Form1.wsEventID.value;
	var Hrs = document.Form1.wsHrs.value;
	var TimeBase = document.Form1.wsTimeBase.value;

//	alert('UserId ' + UserID + '\nCasePlanID ' + CasePlanID + '\nEventID ' + EventID + '\nHrs ' + Hrs + '\nTimeBase ' + TimeBase);
	iCallID = timeservice.Time.callService(timeresult,"InsertTime",UserID,CasePlanID,EventID,Hrs,TimeBase);
	//timeservice.Time.callService("InsertTime",obj.id,UserID,CasePlanID,EventID,Hrs,TimeBase);
	opener.document.all.btnTimer.src = appPath + '/Images/Start.gif';
}

// this function loads the value from the page into the hidden fields used by the webservice
function ws_load(obj) {
	switch(obj.id)
	{
		case 'ddlCases': document.Form1['wsCasePlanID'].value = obj.value; break;
		case 'ddlEvent': document.Form1['wsEventID'].value = obj.value; break;
		case 'txttime': document.Form1['wsHrs'].value = obj.value; break;
	}
}