<%@ Control Language="vb" AutoEventWireup="false" Codebehind="header.ascx.vb" Inherits="TimeTrax.header" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<script language="javascript">
//SB: 12/08/2005 - Code removed as this doesn't work for an environment which is not like DIMS ie.
//Pressing the back button, CTRL F5, or entering on the navigation bar - cause this to pop up as well
//function window.onbeforeunload() 
//{
//	if ((event.clientX < 0) || (event.clientY < 0))
//	{
//		event.returnValue = 'By closing this window, you will be closing Timetrax™. \nPlease ensure that you have saved your information before you leave.';
//	}
//}

//VF: 23/01/2007 Code for handling png images
function correctPNG() // correctly handle PNG transparency in Win IE 5.5 & 6.
{
   var arVersion = navigator.appVersion.split("MSIE")
   var version = parseFloat(arVersion[1])
   if ((version >= 5.5) && (document.body.filters)) 
   {
      for(var i=0; i<document.images.length; i++)
      {
         var img = document.images[i]
         var imgName = img.src.toUpperCase()
         if (imgName.substring(imgName.length-3, imgName.length) == "PNG")
         {
            var imgID = (img.id) ? "id='" + img.id + "' " : ""
            var imgClass = (img.className) ? "class='" + img.className + "' " : ""
            var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' "
            var imgStyle = "display:inline-block;" + img.style.cssText 
            if (img.align == "left") imgStyle = "float:left;" + imgStyle
            if (img.align == "right") imgStyle = "float:right;" + imgStyle
            if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle
            var strNewHTML = "<span " + imgID + imgClass + imgTitle
            + " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
            + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
            + "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>" 
            img.outerHTML = strNewHTML
            i = i-1
         }
      }
   }    
}

window.attachEvent("onload", correctPNG);
</script>
<HTML>
  <HEAD><TITLE><%= Session("PageTitle") %></TITLE>
	    
	      <meta http-equiv="Cache-control" content="no-cache">
          <meta http-equiv="Cache-control" content="no-store">
		<link href=<%=Request.ApplicationPath & StyleSheet%> type="text/css" rel="stylesheet">
			<script language="javascript" src="<%=Request.ApplicationPath%>/Components/Scripts/countdown.js"></script>
			<script language="javascript" src="<%=Request.ApplicationPath%>/Components/Scripts/common.js"></script>

			<%= Session("PageScripts") %>
	</HEAD>
	<%= Session("PageBody") %>
	<!-- Hidden fields used for timepopup page and openTimePopUp function -->
	<input type="hidden" id="hidAppPath" name="hidAppPath" runat="server" />
	<input type="hidden" id="hidUserID" name="hidUserID" runat="server" />
	<asp:placeholder id="phError" runat="server"></asp:placeholder>		
	<table id="tblPage" class="PageFrame">
		<tr>
			<td>
				<table id="tblHeader">
					<tr>
						<td colspan=2><img src="<%=Request.ApplicationPath%>/images/banner.jpg"></td>
					</tr>
					<tr>
						<td class="td" vAlign="top" align="left">Welcome <%= Session("usrName") %>
						</td>
						<td class="td" vAlign="top" align="right"><asp:Label ID="lblSupportNumber" Runat=server></asp:Label>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
			<table id="tblTopTabs" width="100%">
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
					