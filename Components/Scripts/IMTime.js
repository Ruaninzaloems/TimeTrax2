//***********************************************************************
//This Time convertor was developed by:
//Vince Friay
//ŠIntermap (PTY) Ltd
//www.intermap.co.za
//Version 1.0
//***********************************************************************

//#############################################
//#########     CONVERT DMS TO DD       ##############
//#############################################
function dsetods()
{
}

//#############################################
//######### VALIDATE VALUES ON BLUR ##############
//#############################################

//Check Degrees function for <100 and > 0 and Valid integer
function checkdegrees(Val){
var test = isNaN(Val.value)
if (test){
	alert("Please enter a valid number");
	Val.value="";
	Val.focus();
	}
else
	{
		if ((parseInt(Val.value) / Val.value) == 1 || Val.value ==0)
		{
			if (parseInt(Val.value) > 99)
			{
				alert("Please enter a number < 100 for degrees");
				Val.value = "";
				Val.focus();
			}
			else
			{
				if (parseInt(Val.value) < 0)
				{
					Val.value = parseInt(Val.value) * -1
				}
				else
				{}
			}		
		}
		else
		{
			alert("Please enter a valid integer (no decimal points)");
			Val.value = "";
			Val.focus();
		}
    }
}

//Check Minutes/seconds function for <60 and > 0 and Valid integer
function checkminsec(Val){
var test = isNaN(Val.value)
if (test){
	alert("Please enter a valid number");
	Val.value="";
	Val.focus();
	}
else
	{
		if ((parseInt(Val.value) / Val.value) == 1 || Val.value ==0)
		{
			if (parseInt(Val.value) > 59)
			{
				alert("Please enter a number < 60");
				Val.value = "";
				Val.focus();
			}
			else
			{
				if (parseInt(Val.value) < 0)
				{
					Val.value = parseInt(Val.value) * -1
				}
				else
				{}
			}		
		}
		else
		{
			alert("Please enter a valid integer (no decimal points)");
			Val.value = "";
			Val.focus();
		}
    }
}
//Check degrees decimal function for <100 and > 0 and Valid integer
function checkdd(Val){
var test = isNaN(Val.value)
if (test){
	alert("Please enter a valid number");
	Val.value="";
	Val.focus();
	}
else
	{
			if (parseFloat(Val.value) > 100)
			{
				alert("Please enter a number < 100");
				Val.value = "";
				Val.focus();
			}
			else
			{
				if (parseFloat(Val.value) < 0)
				{
					Val.value = parseFloat(Val.value) * -1
				}
				else
				{}
			}		
    }
}

//#############################################
//######## GREY OUT INACTIVE TEXTBOX #############
//#############################################

function dmsclick()
{
document.all.txtdd.disabled=true;
document.all.txtdd.style.backgroundColor="#f5f5f5";

document.all.txtd.disabled=false;
document.all.txtd.style.backgroundColor="white";
document.all.txtm.disabled=false;
document.all.txtm.style.backgroundColor="white";
document.all.txts.disabled=false;
document.all.txts.style.backgroundColor="white";

}

function ddclick()
{
document.all.txtd.disabled=true;
document.all.txtd.value="";
document.all.txtd.style.backgroundColor="#f5f5f5";
document.all.txtm.disabled=true;
document.all.txtm.value="";
document.all.txtm.style.backgroundColor="#f5f5f5";
document.all.txts.disabled=true;
document.all.txts.value="";
document.all.txts.style.backgroundColor="#f5f5f5";

document.all.txtdd.disabled=false;
document.all.txtdd.style.backgroundColor="white";
}

//#############################################
//########               GET STYLES               #############
//#############################################
// Get style block needed to display the converter6 correctly
function timeconv_getStyles() {
	var result = "";
	result+="<STYLE>\n";
	result+=".convtable {border-right: #000066 0.1mm solid;border-top: #000066 0.1mm solid;font-size: xx-small;	background-image: none;\n"
	result+="border-left: #000066 0.1mm solid;border-bottom: #000066 0.1mm solid;font-family: Verdana, Tahoma, Helvetica, sans-serif;background-color: white;}\n"
	result+=".convinput {border-right: #dcdcdc 0.1mm solid;	border-top: #dcdcdc 0.1mm solid;	border-left: #dcdcdc 0.1mm solid;\n"
	result+="border-bottom: #dcdcdc 0.1mm solid;font-family: Verdana, Tahoma, Helvetica, sans-serif;font-size: xx-small;}\n"
	result+=".convcell {font-family: Verdana, Tahoma, Helvetica, sans-serif;font-size: xx-small;}\n"
	result+=".convbutton{	border-right: #000066 2px solid;	border-top: #000066 2px solid;font-weight: normal;	font-size: xx-small;border-left: #000066 2px solid;\n"
	result+="width: 100px;color: #000066;border-bottom: #000066 2px solid;font-family: Verdana, Tahoma, Helvetica, sans-serif;height: 18px;\n"
	result+="background-color: #bed4cd;font-variant: small-caps;}\n"
	result+="</style>"
	return result;
	}
//#############################################
//########       GENERATE DROPDOWN       #############
//#############################################

function timeconverter(thediv,outputfield,upperbound, lowerbound)
{
var result ='';
		result+='<TABLE class="convtable" width="200">\n';
		result+='	<tr>\n';
		result+='		<th bgcolor="#191970" align="center" colspan="3">\n';
		result+='			<font color="white" size="1"><b>Time Converter</b></font></th>\n';
		result+='	</tr>\n';
		result+='	<tr>\n';
		result+='		<td class="convcell"><INPUT id="rdods" type="radio" value="0" name="grp1" onclick="ddclick();"></td>\n';
		result+='		<td class="convcell"><INPUT class="convinput" id="txtd" type="text" size="15" name="txtdd" onblur="checkdd(this);"></td>\n';
		result+='		<td class="convcell">mins \n';
		result+='		</td>\n';
		result+='	</tr>\n';
		result+='	<tr>\n';
		result+='		<td class="convcell"><INPUT id="rdose" type="radio" value="1" name="grp1" onclick="dmsclick();"></td>\n';
		result+='		<td class="convcell"><INPUT class="convinput" id="txtds" type="text" size="2" name="txtds" onblur="checkds(this);">Start Time\n';
		result+='			<INPUT class="convinput" id="txtde" type="text" size="2" name="txtde" onblur="checkde(this);">End Time</td>\n';
		result+='		<td class="convcell">HH:MM </td>\n';
		result+='	</tr>\n';
		result+='	<tr>\n';
		result+='		<td class="convcell" colspan="3" align="center">\n';
		result+='			<INPUT type="button" class="convbutton" value="OK" ID="cmdsubmit" NAME="cmdsubmit" style="WIDTH: 44px; HEIGHT: 18px"\n';
		result+='				onclick="populatedd(' + thediv + ',' + outputfield+ ',' + upperbound + ',' + lowerbound +');"> <INPUT type="button" class="convbutton" value="Cancel" ID="cmdcancel" NAME="cmdcancel" style="WIDTH: 44px; HEIGHT: 18px"\n';
		result+='				onclick="hideconverter('+ thediv + ');">\n';
		result+='		</td>\n';
		result+='	</tr>\n';
		result+='</TABLE>';

	document.all[thediv].innerHTML = result;
	document.all[thediv].style.display = 'block';
	
	dmsclick();
	document.all.rdod.checked=true;
	document.all.txtd.focus();

}

//#############################################
//########        CANCEL DROPDOWN	       #############
//#############################################
function hideconverter(thediv)
{
thediv.style.display = 'none';
thediv.innerHTML="";
}

//#############################################
//########                 OK BUTTON	           #############
//#############################################

function populateds(thediv,outputfield1,outputfield2,upperbound,lowerbound)
{
if (document.all.rdods.checked){var result = dmdtodd()}else	{if (document.all.txtdd.value ==""){alert("Please enter a value in the textbox");return;	}else	{result=document.all.txtdd.value}}
if (result > upperbound || result < lowerbound){alert("Please enter a duration > " + lowerbound + " and < " + upperbound + "");return;}
outputfield1.value=result;
if(outputfield2!= "")
{
outputfield2.value=result;
}
thediv.style.display = 'none';
thediv.innerHTML="";
}