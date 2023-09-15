function showPTOApprovers(obj) {
	if(obj.options[obj.selectedIndex].value==1) {
		document.all.divPTOApprover.style.display='none';
	} else {
		document.all.divPTOApprover.style.display='block';
	}
}

function showTSApprovers(obj) {
	if(obj.options[obj.selectedIndex].value==1) {
		document.all.divTSApprover.style.display='none';
	} else {
		document.all.divTSApprover.style.display='block';
	}
}

function checkApprovals() {
	// This happens on submit,
	// If the droplist is disabled then enable so that value can be sent to DB
	if(document.all.ddlPTOApprovals.disabled==true) {
		document.all.ddlPTOApprovals.disabled = false;
	}
	if(document.all.ddlPTOApprover2Role.disabled==true) {
		document.all.ddlPTOApprover2Role.disabled = false;
	}
	if(document.all.ddlPTOApprover1Role.disabled==true) {
		document.all.ddlPTOApprover1Role.disabled = false;
	}

	if(document.all.ddlTSApprovals.disabled==true) {
		document.all.ddlTSApprovals.disabled = false;
	}
	if(document.all.ddlTSApprover2Role.disabled==true) {
		document.all.ddlTSApprover2Role.disabled = false;
	}
	if(document.all.ddlTSApprover1Role.disabled==true) {
		document.all.ddlTSApprover1Role.disabled = false;
	}
	document.all.btnSubmit.click();
}