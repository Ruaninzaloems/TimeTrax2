function LoadDynamics() {
	calc_total()
	// clear the Comment Edit textbox
	document.Form1['txtComment'].value = "";
}

// This function calculates (1) Total hours for the week, (2)Billable hours for the week and (3) NonBillable hours for the week
function calc_total() {
	var Day1 = 0;
	var Day2 = 0;
	var Day3 = 0;
	var Day4 = 0;
	var Day5 = 0;
	var Day6 = 0;
	var Day7 = 0;
	var Day1Tot = 0;
	var Day2Tot = 0;
	var Day3Tot = 0;
	var Day4Tot = 0;
	var Day5Tot = 0;
	var Day6Tot = 0;
	var Day7Tot = 0;
	var TaskWeekTot = 0;
	var ProjDay1Tot = 0;
	var ProjDay2Tot = 0;
	var ProjDay3Tot = 0;
	var ProjDay4Tot = 0;
	var ProjDay5Tot = 0;
	var ProjDay6Tot = 0;
	var ProjDay7Tot = 0;
	var ProjectWeekTot = 0;
	var WeekTot = 0;
	var field, tfield, pfield, wfield, savProj;
	// Get the number of tasks
	var arrlist, arrData, arrlen = 0, Proj, Task, Row;
	if ((document.all['hidBoxtasks'] != undefined) && (document.all['hidBoxtasks'] != null)) {

		arrlist = document.all['hidBoxtasks'].value;
		arrlist = arrlist.split(",");
		if (arrlist.length > 1) {
			arrlen = arrlist.length - 1;
		}

		if (arrlen > 0) {
			for (var i = 1; i <= arrlen; i++) {
				// For each task (row)
				TaskWeekTot = 0
				// Get the Project and Task
				arrData = arrlist[i].split(";");
				Proj = arrData[0];
				Task = arrData[1];
				Row = eval('document.all["tr_' + Task + '"]');
				if (savProj == '' || savProj == undefined) {
					savProj = Proj;
				}
				// Check If the Project has changed
				if (savProj != Proj) {
					// load the project totals to the form and
					pfield = eval('document.Form1["txtDay1Tot_' + savProj + '"]');
					pfield.value = ConvertToHrs(ProjDay1Tot, 1); //.toFixed(2);
					pfield = eval('document.Form1["txtDay2Tot_' + savProj + '"]');
					pfield.value = ConvertToHrs(ProjDay2Tot, 1); //.toFixed(2);
					pfield = eval('document.Form1["txtDay3Tot_' + savProj + '"]');
					pfield.value = ConvertToHrs(ProjDay3Tot, 1); //.toFixed(2);
					pfield = eval('document.Form1["txtDay4Tot_' + savProj + '"]');
					pfield.value = ConvertToHrs(ProjDay4Tot, 1); //.toFixed(2);
					pfield = eval('document.Form1["txtDay5Tot_' + savProj + '"]');
					pfield.value = ConvertToHrs(ProjDay5Tot, 1); //.toFixed(2);
					pfield = eval('document.Form1["txtDay6Tot_' + savProj + '"]');
					pfield.value = ConvertToHrs(ProjDay6Tot, 1); //.toFixed(2);
					pfield = eval('document.Form1["txtDay7Tot_' + savProj + '"]');
					pfield.value = ConvertToHrs(ProjDay7Tot, 1); //.toFixed(2);
					// Not sure this must be done here, currently calculating twice
					//	// Calculate Project Week Total
					//	alert('Proj Changed \nProjWeek Tots \n1 ' + ProjDay1Tot + '\n2 ' + ProjDay2Tot + '\n3 ' + ProjDay3Tot + '\n4 ' + ProjDay4Tot + '\n5 ' + ProjDay5Tot + '\n6 ' + ProjDay6Tot + '\n7 ' + ProjDay7Tot);
					//	ProjectWeekTot += ProjDay1Tot + ProjDay2Tot + ProjDay3Tot + ProjDay4Tot + ProjDay5Tot + ProjDay6Tot + ProjDay7Tot;
					//	alert('Proj Changed \nProjectWeekTot ' + ProjectWeekTot);
					pfield = eval('document.Form1["txtTotProj_' + savProj + '"]');
					pfield.value = ConvertToHrs(ProjectWeekTot, 0); //.toFixed(2);
					// clear the values for the next project
					ProjDay1Tot = 0;
					ProjDay2Tot = 0;
					ProjDay3Tot = 0;
					ProjDay4Tot = 0;
					ProjDay5Tot = 0;
					ProjDay6Tot = 0;
					ProjDay7Tot = 0;
					ProjectWeekTot = 0;
					// and update savProj
					savProj = Proj;
				}
				field = eval('document.Form1["' + Proj + '_' + Task + '_Day1"]');
				if (field.value > 0) {
					Day1 = ConvertToMins(parseFloat(field.value))
					Day1Tot += Day1
				} else {
					Day1Tot += 0
				}
				field = eval('document.Form1["' + Proj + '_' + Task + '_Day2"]');
				if (field.value > 0) {
					Day2 = ConvertToMins(parseFloat(field.value))
					Day2Tot += Day2
				} else {
					Day2Tot += 0
				}
				field = eval('document.Form1["' + Proj + '_' + Task + '_Day3"]');
				if (field.value > 0) {
					Day3 = ConvertToMins(parseFloat(field.value))
					Day3Tot += Day3
				} else {
					Day3Tot += 0
				}
				field = eval('document.Form1["' + Proj + '_' + Task + '_Day4"]');
				if (field.value > 0) {
					Day4 = ConvertToMins(parseFloat(field.value))
					Day4Tot += Day4
				} else {
					Day4Tot += 0
				}
				field = eval('document.Form1["' + Proj + '_' + Task + '_Day5"]');
				if (field.value > 0) {
					Day5 = ConvertToMins(parseFloat(field.value))
					Day5Tot += Day5
				} else {
					Day5Tot += 0
				}
				field = eval('document.Form1["' + Proj + '_' + Task + '_Day6"]');
				if (field.value > 0) {
					Day6 = ConvertToMins(parseFloat(field.value))
					Day6Tot += Day6
				} else {
					Day6Tot += 0
				}
				field = eval('document.Form1["' + Proj + '_' + Task + '_Day7"]');
				if (field.value > 0) {
					Day7 = ConvertToMins(parseFloat(field.value))
					Day7Tot += Day7
				} else {
					Day7Tot += 0
				}
				// Accumulate the Project Totals
				ProjDay1Tot += Day1;
				ProjDay2Tot += Day2;
				ProjDay3Tot += Day3;
				ProjDay4Tot += Day4;
				ProjDay5Tot += Day5;
				ProjDay6Tot += Day6;
				ProjDay7Tot += Day7;
				// Calculate the Task Total
				TaskWeekTot += Day1 + Day2 + Day3 + Day4 + Day5 + Day6 + Day7;
				// Clear the Daily totals
				Day1 = 0;
				Day2 = 0;
				Day3 = 0;
				Day4 = 0;
				Day5 = 0;
				Day6 = 0;
				Day7 = 0;

				//Load Task Total onto form
				tfield = eval('document.Form1["txtTotTask_' + Task + '"]');
				tfield.value = ConvertToHrs(TaskWeekTot, 0); //.toFixed(2);

				// load the project totals to the form and
				pfield = eval('document.Form1["txtDay1Tot_' + savProj + '"]');
				pfield.value = ConvertToHrs(ProjDay1Tot, 1); //.toFixed(2);
				pfield = eval('document.Form1["txtDay2Tot_' + savProj + '"]');
				pfield.value = ConvertToHrs(ProjDay2Tot, 1); //.toFixed(2);
				pfield = eval('document.Form1["txtDay3Tot_' + savProj + '"]');
				pfield.value = ConvertToHrs(ProjDay3Tot, 1); //.toFixed(2);
				pfield = eval('document.Form1["txtDay4Tot_' + savProj + '"]');
				pfield.value = ConvertToHrs(ProjDay4Tot, 1); //.toFixed(2);
				pfield = eval('document.Form1["txtDay5Tot_' + savProj + '"]');
				pfield.value = ConvertToHrs(ProjDay5Tot, 1); //.toFixed(2);
				pfield = eval('document.Form1["txtDay6Tot_' + savProj + '"]');
				pfield.value = ConvertToHrs(ProjDay6Tot, 1); //.toFixed(2);
				pfield = eval('document.Form1["txtDay7Tot_' + savProj + '"]');
				pfield.value = ConvertToHrs(ProjDay7Tot, 1); //.toFixed(2);

				// Calculate Project Week Total
				//alert('ProjWeek Tots \n1 ' + ProjDay1Tot + '\n2 ' + ProjDay2Tot + '\n3 ' + ProjDay3Tot + '\n4 ' + ProjDay4Tot + '\n5 ' + ProjDay5Tot + '\n6 ' + ProjDay6Tot + '\n7 ' + ProjDay7Tot);
				//SD: 06/09/2005 - Remove the += and just to a ProjectWeekTot = as it was causing the totals to be incorrect on load
				ProjectWeekTot = ProjDay1Tot + ProjDay2Tot + ProjDay3Tot + ProjDay4Tot + ProjDay5Tot + ProjDay6Tot + ProjDay7Tot;
				//alert('ProjectWeekTot ' + ProjectWeekTot);
				pfield = eval('document.Form1["txtTotProj_' + Proj + '"]');
				pfield.value = ConvertToHrs(ProjectWeekTot, 0); //.toFixed(2);

				//Calculate the Overall Weekly Total
				//alert('Week Day Tots \n1 ' + Day1Tot + '\n2 ' + Day2Tot + '\n3 ' + Day3Tot + '\n4 ' + Day4Tot + '\n5 ' + Day5Tot + '\n6 ' + Day6Tot + '\n7 ' + Day7Tot);
				// Week Tot does not accumulate as DayxTot has already been accumulated accross Projects and Tasks
				WeekTot = Day1Tot + Day2Tot + Day3Tot + Day4Tot + Day5Tot + Day6Tot + Day7Tot
				//alert('WeekTot ' + WeekTot);
			}
			//Load the Grand Total values onto form
			document.Form1['txtDay1Tot'].value = ConvertToHrs(Day1Tot, 0); //.toFixed(2);
			document.Form1['txtDay2Tot'].value = ConvertToHrs(Day2Tot, 0); //.toFixed(2);
			document.Form1['txtDay3Tot'].value = ConvertToHrs(Day3Tot, 0); //.toFixed(2);
			document.Form1['txtDay4Tot'].value = ConvertToHrs(Day4Tot, 0); //.toFixed(2);
			document.Form1['txtDay5Tot'].value = ConvertToHrs(Day5Tot, 0); //.toFixed(2);
			document.Form1['txtDay6Tot'].value = ConvertToHrs(Day6Tot, 0); //.toFixed(2);
			document.Form1['txtDay7Tot'].value = ConvertToHrs(Day7Tot, 0); //.toFixed(2);
			document.Form1['txtTotal'].value = ConvertToHrs(WeekTot); //.toFixed(2);
		}
	}
}

// This function calculates (1) The total hours for the week that has changed for the task
//						    (2) Total Hours for the day that has changed for the task
//							(3) The total hours for the week that has changed 
//						    (4) Total Hours for the day that has changed 
function calc_ColumnTotal(obj) {
	var DayValue = 0;
	var DayTot = 0;
	var TaskWeekTot = 0;
	var ProjDayTot = 0;
	var ProjectWeekTot = 0;
	var WeekTot = 0;
	var field, tfield, pfield, wfield, savProj;

	//Retrieve the Task and Day
	var arrData = obj.id;
	var day, task, project;
	arrData = arrData.split("_");
	project = arrData[0];
	task = arrData[1];
	day = arrData[2];

	// Get the number of tasks
	var arrlist = document.all['hidBoxtasks'].value, arrData, arrlen = 0, Proj, Task, Row;
	arrlist = arrlist.split(",");
	if (arrlist.length > 1) {
		arrlen = arrlist.length - 1;
	}

	if (arrlen > 0) {
		for (var i = 1; i <= arrlen; i++) {
			// For each task (row)

			// Get the Project and Task
			arrData = arrlist[i].split(";");
			CurrentProj = arrData[0];
			CurrentTask = arrData[1];

			//Get the day total for each task
			field = eval('document.Form1["' + CurrentProj + '_' + CurrentTask + '_' + day + '"]');

			if (CurrentProj == project) {
				//Calculate the Project Day Total
				//field = eval('document.Form1["' + CurrentProj + '_' + CurrentTask + '_' + day + '"]');
				if (field.value > 0) {
					DayValue = ConvertToMins(parseFloat(field.value))
					ProjDayTot += DayValue
				}

			}//End CurrentProj = project

			//Calculate the Project Day Total
			if (field.value > 0) {
				DayValue = ConvertToMins(parseFloat(field.value))
				DayTot += DayValue
			}

		} //End For Loop

		// load the Project Day Total to the form and
		pfield = eval('document.Form1["txt' + day + 'Tot_' + project + '"]');
		pfield.value = ConvertToHrs(ProjDayTot, 1);

		// load the Day Total to the form and
		pfield = eval('document.Form1["txt' + day + 'Tot"]');
		pfield.value = ConvertToHrs(DayTot, 1);

		// Calculate the Task Total
		for (var i = 1; i <= 7; i++) {
			tfield = eval('document.Form1["' + project + '_' + task + '_Day' + i + '"]');
			if (tfield.value > 0) {
				TaskWeekTot += ConvertToMins(parseFloat(tfield.value));
			}
		}

		//Load Task Total onto form
		tfield = eval('document.Form1["txtTotTask_' + task + '"]');
		tfield.value = ConvertToHrs(TaskWeekTot, 0);

		// Calculate Project Week Total
		for (var i = 1; i <= 7; i++) {
			tfield = eval('document.Form1["txtDay' + i + 'Tot_' + project + '"]');
			if (tfield.value > 0) {
				ProjectWeekTot += ConvertToMins(parseFloat(tfield.value));
			}
		}

		pfield = eval('document.Form1["txtTotProj_' + project + '"]');
		pfield.value = ConvertToHrs(ProjectWeekTot, 0);

		//Load the Grand Total value onto form		
		document.Form1['txt' + day + 'Tot'].value = ConvertToHrs(DayTot, 0);

		//Calculate the grand total for all tasks		
		for (var i = 1; i <= 7; i++) {
			tfield = eval('document.Form1["txtDay' + i + 'Tot"]');
			if (tfield.value > 0) {
				WeekTot += ConvertToMins(parseFloat(tfield.value));
			}
		}

		document.Form1['txtTotal'].value = ConvertToHrs(WeekTot);
	}

	//Check if the user has entered more than 24 hours for the day
	if (ConvertToHrs(DayTot, 1) > 24) {
		alert('The maximum number of hours per day is 24.   Please ensure that total time for each day is less than 24 hours.');
		obj.focus();
	}
}

function ConvertToMins(val) {
	var mins = 0;
	var hrs = 0;
	if (document.Form1['time_base'].value == 100) {
		// 30 mins = 0.5
		mins = val * 60;
	} else {
		// 30 mins = 0.3
		hrs = parseInt(val);
		mins = (val - hrs);
		mins = (mins / 60 * 100);
		mins = (hrs + mins) * 60;
	}
	return parseInt(mins);
}

//SD: 12/09/2005 - Added an extra parameter indicating whether
//to return zero as 0 or an empty string - also format as 2 decimal here
//returnEmptyString = 1 returns '' if Hrs = 0
//returnEmptyString = 0 returns 0 if Hrs = 0
function ConvertToHrs(val, returnEmptyString) {
	var hrs = 0;
	var hrsinmin = 0;
	if (document.Form1['time_base'].value == 100) {
		// 30 mins = 0.5
		hrs = val / 60;
	} else {
		// 30 mins = 0.3
		hrsinmin = parseInt((val / 60));
		hrs = hrsinmin + ((val - (hrsinmin * 60)) / 100);
	}
	hrs = hrs.toFixed(2);
	if (hrs == 0 && returnEmptyString == 1) {
		hrs = '';
	}

	return hrs;
}

// This function loads the selected items comment into the Comment Edit box and 
// saves the id of the comment being edited
function loadComment(obj) {
	var arrData = obj.id;
	var day, task, project;
	arrData = arrData.split("_");
	project = arrData[0];
	task = arrData[1];
	day = arrData[2];
	CommentID = project + "_" + task + "_" + day + "Comment";
	var RejCommentID = project + "_" + task + "_" + day + "RejComment";
	document.Form1['txtComment'].value = document.Form1[CommentID].value;
	if (document.Form1[RejCommentID].value != '') {
		document.Form1['txtRejComment'].value = document.Form1[RejCommentID].value;
	}
	else {
		//SD: 12/09/2005 - Set the rejected comment as nothing
		document.Form1['txtRejComment'].value = '';
	}
}

// This function saves the text from the comment edit box to the comment being edited
function saveComment() {
	try {
		document.Form1[CommentID].value = document.Form1['txtComment'].value;
	}
	catch (ex) { }
}

// This function check that a comment has been entered or not
// this will only be called if ForceTSComments on the system DB is checked
function checkEmptyComments() {
	var EmptyCommentExists = 0
	var ErrObj, field, comment;
	var arrlist = document.all['hidBoxtasks'].value, arrData, arrlen = 0, Proj, Task, Row;
	var strMissingComments;
	var strInvalidLengthComments = '';
	var strTaskName, strNewTask;

	strMissingComments = '';
	arrlist = arrlist.split(",");

	if (arrlist.length > 1) {
		arrlen = arrlist.length - 1;
	}



	for (var i = 1; i <= arrlen; i++) {
		// For each task (row)
		// Get the Project and Task
		arrData = arrlist[i].split(";");
		Proj = arrData[0];
		Task = arrData[1];
		for (var x = 1; x < 8; x++) {


			// For each Day
			field = eval('document.Form1["' + Proj + '_' + Task + '_Day' + x + '"]');
			if (field.value > 0) {
				comment = eval('document.Form1["' + Proj + '_' + Task + '_Day' + x + 'Comment"]');

				if (comment.value == '') {
					EmptyCommentExists = 1
					ErrObj = field;
					//Retrieve the task name
					strTaskName = document.getElementById('lblTask_' + Task).innerText;
					strNewTask = Proj + ' - ' + strTaskName;

					//If the Project hasn't been listed already.  
					if (strMissingComments.indexOf(strNewTask) < 0) {
						strMissingComments += '- ' + strNewTask + '\n';
					}
				}

				if (comment.value.length < 150 && comment.value.length > 0 && Proj != "TimeOff") {

					EmptyCommentExists = 1
					strTaskName = document.getElementById('lblTask_' + Task).innerText;
					strNewTask = Proj + ' - ' + strTaskName;

					//If the Project hasn't been listed already.  
					if (strInvalidLengthComments.indexOf(strNewTask) < 0) {
						strInvalidLengthComments += '- ' + strNewTask + "(" + comment.value.length + ")" + '\n';
					}
				}
			}
		}
	}

	if (EmptyCommentExists == 1) {

		if (strMissingComments.length > 0) {
			alert('Please enter comments for all items.  The following Tasks are missing comments:\n' + strMissingComments);
			Page_IsValid = false;
			document.Form1.txtComment.value = " ";
			//ErrObj.focus();
			ErrObj.select();
		}

		if (strInvalidLengthComments.length > 0) {
			alert('The following Tasks have comments that need more details (comments must be at least 150 characters) :\n' + strInvalidLengthComments);
			Page_IsValid = false;
			document.Form1.txtComment.value = " ";
		}
	}
	else {
		document.Form1.txtComment.value = "submitting timesheet ...";
	}
}

function deleteItem(obj) {
	var arrData = obj.id;
	var task, project, field, x;
	arrData = arrData.split("_");
	project = arrData[1];
	task = arrData[2];
	// save the task id to hidden box to be processed when page is submitted
	document.Form1['deleted_list'].value += obj.id + ',';
	// And hide the 'deleted' task on the page
	// set each cell value to 0
	for (x = 1; x < 8; x++) {
		field = eval('document.Form1["' + project + '_' + task + '_Day' + x + '"]');
		field.value = 0;
	}
	// set the display to none
	field = eval('document.all["tr_' + task + '"]');
	field.style.display = 'none';

}

function openAddTask() {
	url = "AddTask.aspx?TimesheetDate=" + document.all.hidTimesheetDate.value;
	window.open(url, "AddTask", "toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=350,top=50,left=50,resizable=0");
}

function openAddTimeOff() {
	url = "AddTimeOff.aspx";
	window.open(url, "AddTimeOff", "toolbar=0,location=0,status=1,menubar=0,scrollbars=1,width=800,height=350,top=50,left=50,resizable=0");
}

function validateLength() {
	if (document.all.txtComment.value.length > 1500) {
		alert('The comment you entered is more than 1500 characters.  Data will be lost is you do not shorten your comment.');
	}
}