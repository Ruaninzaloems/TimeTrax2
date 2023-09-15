<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Footer.ascx.vb" Inherits="TimeTrax.Portal.Web.Footer" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
					</td>
				</tr>
			</table> <!-- End tblTopTabs -->
			</td>
		</tr>
	</table> <!-- End tblPage -->
	<table border="0" align="left" cellpadding="0" cellspacing="0" width="760">
		<tr><td colspan=2><br></td></tr>
		<tr>
			<td class="td" align=left valign=top style="COLOR: 848484">
				Your session will expire in <span align="right" id="countdown" name="countdown"></span>&nbsp;sec
				<br>
				Best Viewed with Internet Explorer 5.x & @800 x 600</td>
			<td class="td" align="right" valign=top>
				<!--<a href="http://www.intermap.co.za" target="_blank"><img src="http://www.intermap.co.za/App_Common/WebImages/supportedby.gif" border="0"></a>
				<a href="http://www.intermap.co.za/Products/etrack.asp"><IMG src="http://www.intermap.co.za/App_Common/WebImages/poweredby_etrack.gif" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>-->
			</td>
		</tr>
	</table>
<script language="javascript">
  AlertLoad(); //SD: 15/09/2005 - Ensure that the Count down timer works
  function DivSetVisible(state)
  {
   var DivRef,IfrRef;
//   if(state)
//   {
			//alert('1');
			DivRef = document.getElementById('divMenu');
			//alert(DivRef);
			//alert('2');
			IfrRef = document.getElementById('divShim');
			//alert(IfrRef);
			//alert('3');
			DivRef.style.display = "block";
		// alert('4');
			IfrRef.style.width = DivRef.offsetWidth;
		// alert('a' + DivRef.offsetWidth);
			IfrRef.style.height = DivRef.offsetHeight;
		// alert('b' + DivRef.offsetHeight);
			IfrRef.style.top = DivRef.style.top;
			//alert('c');
			IfrRef.style.left = DivRef.style.left;
			//alert('d');
			IfrRef.style.zIndex = DivRef.style.zIndex - 1;
		 //alert('e' + IfrRef.style.zIndex);
			IfrRef.style.filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';
			//alert('f');
			IfrRef.style.display = "block";
			//alert('g');
//   } else {
   //alert('h');
	//		DivRef.style.display = "none";
			IfrRef.style.display = "none";
//   }
  }
</script>
