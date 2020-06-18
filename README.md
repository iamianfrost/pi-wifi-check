# pi Wifi Check Script
Small shell script to handle the raspberry pi's sometimes transient grasp of wireless connections.

It tries to ping a configured ip, if this fails, it attempts to restart the interface.  If restarting the interface doesn't solve the issue (within a configured number of times), it reboots the machine.  

All the steps should be logged into a file of your choosing along with the wifi link quality should you ever want to identify issues.

The script itself should be chmod +x, then I suggest scheduling this to run every x mins via your crontab.  This runs every 5 mins on my home server.

## Usage
`Execute` the script without parameters to run the basic script; optional parameters are:

`-l` to see last logged reconnect attempt

`-r` to see last reboot attempt

`-h` for the usage help (this)

## Future to-dos
* Possible desired extensions will be rotation of the logfile (logrotate?) or trimming of the logfile based on size.
* Non-Wifi connections?
* ~~Make more efficient; capture /proc/ call and awk data vs two /proc/ calls~~
