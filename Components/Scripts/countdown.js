/*#######################################
Function to show countdown to timeout on a page
developed by Intermap (Pty) Ltd
#######################################

<!--<SCRIPT language="JavaScript" src="../Scripts/countdown.js"></SCRIPT>-->
Place the following function in the page:
		function window.onload(){			
				document.all.countdown.innerHTML = "30 min 0"; //number reflects timeout in web config
				ID=window.setTimeout("countdown();", 1000);
		}

You will need the following items in the html:
	<b><font color="gray">Your session will expire in </font></b><span align="right" id="countdown" name="countdown"></span>&nbsp;sec

*/

function countdown() {
var arrtemp = document.all.countdown.innerHTML;
arrtemp = arrtemp.split(" min ",-1);
var min = arrtemp[0];
var sec = arrtemp[1];
	if(parseInt(sec) == 0)
	{
		if(parseInt(min)!=0)
		{
			min = parseInt(min) -1;
			sec = "59";
		}
	}
	else
	{
		sec = parseInt(sec) - 1;
	}
	document.all.countdown.innerHTML=min+" min "+sec;
	setTimeout("countdown();",1000);
}

/*#######################################
//FOR SESSION TIMEOUT DIALOG
#######################################*/
function AlertLoad(){
	// As this happens on each page load, set the Timer button colour here
	//setTimerStatus();	
	var StayAlive1 = 55; // Number of minutes before the first alert will appear
	setTimeout("SessionAlert(5)",StayAlive1 * (1000 * 60)); // Minutes left before timeout
	var StayAlive2 = 59; // Number of minutes before the second alert will appear
	setTimeout("SessionAlert(1)",StayAlive2 * (1000 * 60)); // Minutes left before timeout
	var StayAlive3 = 60; // Number of minutes before the last alert will appear
	setTimeout("SessionAlert(0)",StayAlive3 * (1000 * 60)); // Minutes left before timeout
	document.all.countdown.innerHTML = "60 min 0"; //number reflects timeout in web config
	setTimeout("countdown();", 1000);
}
			
function SessionAlert(timeout){
		window.focus( );
		var appPath = document.all['ucHeader_hidAppPath'].value;
		var WinSettings = "center:yes;resizable:no;dialogWidth:450px;dialogheight:300px;status:no;help:no;scroll:no;unadorned:no;edge:raised"
		var MyArgs = window.showModelessDialog(appPath + "/timeout.aspx?time=" + timeout,"",WinSettings);
		//alert('MyArgs ' + MyArgs.value);
}