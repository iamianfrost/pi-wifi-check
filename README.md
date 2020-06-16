# pi-wifi-check
Small shell script to handle the raspberry pi's sometimes transient grasp of wireless connections.

It tries to ping a configured ip, if this fails, it attempts to restart the interface.  If restarting the interface doesn't solve the issue (within a configured number of times), it reboots the machine.  

All the steps should be logged into a file of your choosing along with the wifi link quality should you ever want to identify issues.

The script itself should be chmod +x, then I suggest scheduling this to run every x mins via your crontab.  This runs every 5 mins on my home server.

Possible desired extensions will be rotation of the logfile (logrotate?) or trimming of the logfile based on size.
