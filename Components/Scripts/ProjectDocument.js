function uploadDocument() {
	var appPath = document.all['ucHeader_hidAppPath'].value;
	var projid = document.all['hidProjID'].value;
	if(projid=='') {
 		alert('The Form must be saved before you can upload a Document')
 	} else {
		var scrnmidtop = ((screen.availHeight / 2) - 175);
		var scrnmidleft = ((screen.availWidth / 2) - 275);
 		window.open(appPath + "/Project/Upload.aspx?ProjID=" + projid ,"Upload","toolbar=0,location=0,status=1,menubar=0,scrollbars=0,width=550,height=350,top=" + scrnmidtop + ",left=" + scrnmidleft + ",resizable=0");
 	}
}
