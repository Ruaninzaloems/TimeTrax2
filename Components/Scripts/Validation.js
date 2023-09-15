//****************************************************************************************************************************//
//This is the javascript file that contains all the custon validators that are required.
// Written By Shane McCarthy
//****************************************************************************************************************************//
//**  Function List **//
//  ValidateDisplayAlpha			
//  ValidateDisplayAlphaNum
//  ValidateDecimal
//  ValidateDisplayDecimal
//  ValidateInteger
//  ValidateDisplayInteger
//  ValidateDate
//  ValidateDisplayDate
//  ValidateID

//The validation for a Alphabetic value on a dymamic add or were you want the message displayed on change and not on submit
//oMsg is the message you wants to be displayed.
//args is the object name ie pass (this) to the function

function ValidateDisplayAlpha(args)
{
	var Alpha;

		Alpha = new RegExp(/^[a-zA-Z\s]*$/);
			
		if (Alpha.test(args.value)) 
		{
			return true;		
		}
		else
		{
			alert('Please enter alphabetic characters.');
			//Set the value to nothing
			args.value = "";
			return false;
		}	
}
//End Function
//****************************************************************************************************************************//

//The validation for a AlphaNumeric value on a dymamic add or were you want the message displayed on change and not on submit
//oMsg is the message you wants to be displayed.
//args is the object name ie pass (this) to the function

function ValidateDisplayAlphaNum(Msg, args)
{
	var AlphaNum;

		AlphaNum = new RegExp(/^[a-zA-Z0-9\s]*$/);
			
		if (AlphaNum.test(args.value)) 
		{
			return true;		
		}
		else
		{
			alert(Msg);
			//Set the value to nothing
			args.value = "";
			return false;
		}	
}
//End Function
//****************************************************************************************************************************//

//****************************************************************************************************************************//

//The validation for a Project Code were you want the message displayed on change and not on submit
//oMsg is the message you wants to be displayed.
//args is the object name ie pass (this) to the function
// NB!! The \x5F is to allow the underscore character (\x = hexadecimal value, 5F = hex value for Underscore

function ValidateProjCode(Msg, args)
{
	var AlphaNum;

		AlphaNum = new RegExp(/^[a-zA-Z0-9\(\)\\\/\x5F\-]*$/);
			
		if (AlphaNum.test(args.value)) 
		{
			return true;		
		}
		else
		{
			alert(Msg);
			//Set the value to nothing
			args.value = "";
			return false;
		}	
}
//End Function
//****************************************************************************************************************************//

//The validation for a Decimal to use with a custom validator name the function as ValidateDecimal, 
//no parameters needed all are passed through by the .net form.submit function

function ValidateDecimal(oSrc, args)
{
	var test = isNaN(args.Value);
	
	if (test)
	{
		//Set the element to not valid
		args.IsValid = false;
	}
	else
	{
		args.IsValid = true;
  }
}
//End Function
//****************************************************************************************************************************//



//The validation for a Decimal on a dymamic add or were you want the message displayed on change and not on submit
//oMsg is the message you wants to be displayed.
//args is the object name ie pass (this) to the function

function ValidateDisplayDecimal(args)
{
	var test = isNaN(args.value);
	
	if (test)
	{
		alert('Please enter a valid decimal amount.');
		//Set the value to nothing
		args.value = "";
		args.focus();
	}
}
//End Function
//****************************************************************************************************************************//



//The validation for a Integer to use with a custom validator name the function as ValidateDecimal, 
//no parameters needed all are passed through by the .net form.submit function

function ValidateInteger(oSrc, args)
{
	var test = isNaN(args.Value);
	
	if (test)
	{
		//Set the element to not valid
		args.IsValid = false;
	}
	//if the value is a number, then check that it is a whole number
	else
	{
		if ((parseInt(args.Value) / args.Value) == 1 || args.Value == 0)
		{
			args.IsValid = true;
		}
		else
		{
			args.IsValid = false;
		}
    }
}
//End Function
//****************************************************************************************************************************//



//The validation for an Integer on a dymamic add or were you want the message displayed on change and not on submit
//oMsg is the message you wants to be displayed.
//args is the object name ie pass (this) to the function

function ValidateDisplayInteger(args)
{
	var test = isNaN(args.value);
	
	if (test)
	{
		alert('Please enter numeric characters.');
		//Set the value to nothing
		args.value = "";
		args.focus();
	}
	//if the value is a number, then check that it is a whole number
	else
	{
		if ((parseInt(args.value) / args.value) == 1 || args.value == 0)
		{
		}
		else
		{
			alert('Please enter numeric characters.');
			//Set the value to nothing
			args.value = "";
			args.focus();
		}
    }
}
//End Function
//****************************************************************************************************************************//



//The validation for a Date with the format (DD/MM/YYYY) to use with a custom validator name the function as ValidateDecimal, 
//no parameters needed all are passed through by the .net form.submit function

function ValidateDate(oSrc, args)
{
	var test = args.Value;
	//Use the try to catch any eceptions that might be present
	try
	{
		var seperator = test.substr(2, 1)
		var day = test.substr(0, 2)
		var month = test.substr(3, 2)
		var year = test.substr(6, 4)
	}
	catch(e){}
		
	//Check that the day month and year are numbers, then check that they fall inside the valid date parameters and that the total length is 10
	if (test.length > 0)
	{
		if (day > 31 || isNaN(day) || month > 12 || isNaN(month) || year < 1900 || year > 2099 || isNaN(year) || test.length != 10 || seperator != "/")
		{
			//Set the element to not valid
			args.IsValid = false;
		}
		else
		{
			args.IsValid = true;
		}
	}
}
//End Function
//****************************************************************************************************************************//


//The validation for a Date with the format (DD/MM/YYYY)  on a dymamic add or were you want the message displayed on change and not on submit
function ValidateDisplayDate(Msg, args)
//oMsg is the message you wants to be displayed.
//args is the object name ie pass (this) to the function

{
	var test = args.value;
	//Use the try to catch any eceptions that might be present
	try
	{
		var seperator = test.substr(2, 1)
		var day = test.substr(0, 2)
		var month = test.substr(3, 2)
		var year = test.substr(6, 4)
	}
	catch(e){}
		
	//Check that the day month and year are numbers, then check that they fall inside the valid date parameters and that the total length is 10
	if (test.length > 0)
	{
		if (day > 31 || isNaN(day) || month > 12 || isNaN(month) || year < 1900 || year > 2099 || isNaN(year) || test.length != 10 || seperator != "/")
		{
			alert(Msg);
			//Set the value to nothing
			args.value = "";
		}
	}
}
//End Function
//****************************************************************************************************************************//