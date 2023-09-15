function ToggleDisplay(oButton, oItems) //, oHeader)
{
    if ((oItems.style.display == "") || (oItems.style.display == "none"))
    {
        oItems.style.display = "block";
        oButton.src = "../Images/up.gif";
    }  else {
        oItems.style.display = "none";
        oButton.src = "../Images/down.gif";
    }
    return false;
}

function TogglecheckAll(obj) {
	var arrData = obj.id;
	var project, client, ProjClient;
	client = obj.id;

	var arrlist = document.all['hidBoxproj'].value, arrlen=0, Row;
	arrlist = arrlist.split(",");
	if(arrlist.length > 1){
		arrlen = arrlist.length - 1;
	}
	for(var i = 1; i <= arrlen; i++)
	{
		arrData = arrlist[i].split("_");
		ProjClient = arrData[0];
		project = arrData[1];
		if(client==ProjClient) {
			field = eval('document.Form1["chkProj_' + ProjClient + '_' + project + '"]');
			if(field.checked==true) {
				field.checked=false;
			} else {
				field.checked=true;
			}
		}
	}
}