function Fixed(obj,dec) {
// returns the value with dec decimal places
alert(obj.value);
	var test = isNaN(obj.value);
	alert(test);
	if (test)
	{
		obj.value = 0;
	}
	var test = isNaN(dec);
	
	if (test)
	{
		dec = 2;
	}
	
	var a = parseFloat(obj.value);
	obj.value = a.toFixed(dec);
}
