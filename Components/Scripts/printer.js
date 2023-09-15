	var gAutoPrint = false; // Flag for whether or not to automatically call the print function

		function printSpecial(pic, AppPath)
		{
			pic.style.display = "none";
			if (document.getElementById != null)
			{
					var html = "<link href='" + AppPath + "/app_style.css' type='text/css' rel='stylesheet'>";
					html += "<Title>Report Printout</Title>"

				//Hide Excel Icon if there
				try
				{
					var ExcelElem = document.getElementById("imgExport");
					ExcelElem.style.display = "none";
				}	
				catch (e) {}
				//Hide Excel Icon if there is one in the expense user control
				try
				{
					var ExcelElem = document.getElementById("ucExpensesReport_imgExport");
					ExcelElem.style.display = "none";
				}	
				catch (e) {}	
				//Hide Excel Icon if there is one in the project summary control
				try
				{
					var ExcelElem = document.getElementById("ucProjectSummary_imgExport");
					ExcelElem.style.display = "none";
				}	
				catch (e) {}		
							
				var printReadyElem = document.getElementById("divReport");
			
				if (printReadyElem != null)
				{
					html += printReadyElem.innerHTML;
				}
				else
				{
					alert("Could not find the printReady section in the HTML");
					return;
				}
				
				html += '\n</BO' + 'DY>\n</HT' + 'ML>';
			
				var printWin = window.open("","printSpecial","height=400, width=600, top=25, left=25, menubar=0, scrollbars=1,location=0, resizable=1, status=1");
				printWin.document.open();
				printWin.document.write(html);
				pic.style.display = "block";
				printWin.document.close();
				//if (gAutoPrint)
				printWin.print();
				
				//Show the Excel icon again
				try
				{
					var ExcelElem = document.getElementById("imgExport");
					ExcelElem.style.display = "block";
				}	
				catch (e) {}
				//Show Excel Icon if there is one in the expense user control
				try
				{
					var ExcelElem = document.getElementById("ucExpensesReport_imgExport");
					ExcelElem.style.display = "block";
				}	
				catch (e) {}	
				//Show Excel Icon if there is one in the project summary control
				try
				{
					var ExcelElem = document.getElementById("ucProjectSummary_imgExport");
					ExcelElem.style.display = "block";
				}	
				catch (e) {}	
				
			}
			else
			{
				alert("Sorry, the print ready feature is only available in modern browsers, ver 5.5 above");
			}
		}