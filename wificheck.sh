#!/bin/bash

# keep wifi alive through pinging router/external service; if this fails, attempt to restart the interface.  If that fails repeatedly, reboot.

# Settings
loglocation="<LOCATION OF LOG FILE ON DISK>"  #e.g. /home/pi/local/wifi.log
failcount=3 #number of times before restarting machine  
interface="wlan0" # your wifi interface to use
ip="<IP TO PING>" #e.g. 192.168.1.1

# Script
ping -c3 $ip > /dev/null 2>&1 

 
if [ $? != 0 ] 
then 
  echo "`date '+%d/%m/%Y %H:%M:%S'` No network connection, restarting wlan0" >> $loglocation
  
  sudo ip link set $interface down
  sleep 30
  sudo ip link set $interface up
  
else
 echo "`date '+%d/%m/%Y %H:%M:%S'` All ok. Quality:`cat /proc/net/wireless | awk 'END { print $3 }' | sed 's/\.$//'`, Level:`cat /proc/net/wireless | awk 'END { print $4 }' | sed 's/\.$//'` " >> $loglocation
fi

if [[ $(tail -n $failcount $loglocation | grep "No network" | wc -l) -eq $failcount ]];
then
  echo "`date '+%d/%m/%Y %H:%M:%S'` Last network restores didnt work, restarting " >> $loglocation
  sleep 1 
  reboot
fi

exit
