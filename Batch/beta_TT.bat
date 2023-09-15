xcopy "C:\Inetpub\wwwroot\Intermap\TimeTrax\Web" "\\imasp\Web Sites\TimeTrax\Web" /EIY /EXCLUDE:C:\Inetpub\wwwroot\Intermap\TimeTrax\Web\Batch\TT.excl
pause
xcopy "C:\Inetpub\wwwroot\Intermap\TimeTrax\Web\WebService" "\\imasp\Web Sites\TimeTrax\WebService" /EIY /EXCLUDE:C:\Inetpub\wwwroot\Intermap\TimeTrax\Web\Batch\TT_WS.excl
pause
xcopy "C:\Inetpub\wwwroot\Intermap\TimeTrax\NotificationService" "\\imasp\Web Sites\TimeTrax\NotificationService" /EIY
Pause