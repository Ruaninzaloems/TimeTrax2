<%@ Page Language="vb" AutoEventWireup="false" Codebehind="timeout.aspx.vb" Inherits="TimeTrax.timeout" %>

<HTML>
  <HEAD>
		<title>Application Timeout</title>
		<LINK REL="StyleSheet" href=<%=Request.ApplicationPath & StyleSheet%> TYPE="text/css" MEDIA="screen,print">
		<script language="JavaScript" type="text/JavaScript">
			var timerID = null;
			var timerRunning = false;

			//FUNCTION TO COUNTDOWN SO WINDOW CLOSES AUTOMATICALLY IF NOT DISMISSED
			function bodyload()
			{
				if (document.Form1.txttime.value=="5")
				{var StayAlive1 = 4;}
				else
				{var StayAlive1 = 1;}
				setTimeout("closewin();",StayAlive1 * (1000 * 60));
			}

			//CLOSE WINDOW FUNCTION IF PAGE HAS NOT BEEN DISMISSED
			function closewin()
			{
				if (document.Form1.txttime.value!="0")
				{window.close();}
			}

			//TIME FUNCTION - ALWAYS CHANGING
			function stopclock (){
			if(timerRunning)
			clearTimeout(timerID);
			timerRunning = false;
			}
			function showtime () {
			var now = new Date();
			var hours = now.getHours();
			var minutes = now.getMinutes();
			var seconds = now.getSeconds()
			var timeValue = "" + ((hours >12) ? hours -12 :hours)
			if (timeValue == "0") timeValue = 12;
			timeValue += ((minutes < 10) ? ":0" : ":") + minutes
			timeValue += ((seconds < 10) ? ":0" : ":") + seconds
			timeValue += (hours >= 12) ? " pm" : " am"
			document.all.clock.innerHTML = timeValue;
			timerID = setTimeout("showtime()",1000);
			timerRunning = true;
			}
			function startclock() {
			stopclock();
			showtime();
			}

			//TIME FUNCTION - PAGE LOAD
			function currenttime(){
			var now = new Date();
			var hours = now.getHours();
			var minutes = now.getMinutes();
			var seconds = now.getSeconds()
			var timeValue = "" + ((hours >12) ? hours -12 :hours)
			if (timeValue == "0") timeValue = 12;
			timeValue += ((minutes < 10) ? ":0" : ":") + minutes
			timeValue += ((seconds < 10) ? ":0" : ":") + seconds
			timeValue += (hours >= 12) ? " pm" : " am"
			document.all.time.innerHTML = timeValue;
			}

			function exitApp() {
				if (document.Form1.txttime.value=="0")
				{
					//alert('return something');
					//window.returnValue = 1;
					//document.all.btnLogout.click();
				}
				window.close();
			}
		</script>
</HEAD>
	<body onload="currenttime();startclock();bodyload();">
		<form id="Form1" method="post" runat="server">
			<table width="100%" border="0">
				<tr>
					<th class="th" align="center">
						Application Timeout</th>
				</tr>
				<tr>
					<td class="td"><b>Please Note:</b><br>
						<asp:label id="lbltimeleft" runat="server">Label</asp:label><br>
						<br>
						This dialog was opened at: <font color="red"><span id="time"></span></font>&nbsp;(Current 
						Time: <font color="navy"><span id="clock"></span></font>)</td>
				</tr>
				<tr>
					<td class="td"><br>
						<i><font color="gray">A session timeout is used to decrease server resources, as 
								well as improve security to the application. If the application is not used for 
								a pre-defined time period the session will timeout, and the application 
								redirects to the login page</font></i></td>
				</tr>
				<tr>
					<td align="center"><br>
						<INPUT class="button" type="button" value=" OK " onclick="exitApp();"></td>
						<asp:button ID="btnLogout" name="btnLogout" Runat="server" CssClass="inputhidden"></asp:button>
				</tr>
			</table>
			<asp:textbox id="txttime" runat="server" CssClass="inputhidden" name="txttime"></asp:textbox>
		</form>
	</body>
</HTML>
