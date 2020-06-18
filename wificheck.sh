#!/bin/bash

# keep wifi alive through pinging router/external service; if this fails, attempt to restart the interface.  If that fails repeatedly, reboot.

# Settings
loglocation="/home/pi/Scripts/tmp/wifi.log"  # e.g. /home/pi/local/wifi.log
failcount=3 # Number of times before restarting machine
interface="wlan1" # Your wifi interface to use
ip="10.0.0.1" # e.g. 192.168.1.1/pi/Scripts/tmp/wifi.log"

# Script

if [ "$1" != "" ]; then
  case $1 in
        -l | --lastfail )  grep "No network" $loglocation | tail -1; exit;;
        -r | --lastreboot ) grep "restarting machine" $loglocation | tail -1; exit;;
        -h | --help ) echo "Usage: $0 [[-l last network failure] | [-r last machine reboot] | [-h help]] | or without parameter to execute wifi check"; exit;; 
esac
fi

ping -c3 $ip > /dev/null 2>&1

if [ $? != 0 ]
then
  echo "`date '+%d/%m/%Y %H:%M:%S'` No network connection, restarting $interface" >> $loglocation
  sudo ip link set $interface down
  sleep 30
  sudo ip link set $interface up
else
  wifisummary=$(tail -1 /proc/net/wireless)
  echo "`date '+%d/%m/%Y %H:%M:%S'` $interface ok. Quality:`echo $wifisummary | awk '{ print $3 }' | sed 's/\.$//'`, Level:`echo $wifisummary | awk 'END { print $4 }' | sed 's/\.$//'` " >> $loglocation
fi

if [[ $(tail -n $failcount $loglocation | grep "No network" | wc -l) -eq $failcount ]];
then
  echo "`date '+%d/%m/%Y %H:%M:%S'` Last $failcount network restores failed, restarting machine" >> $loglocation
  sleep 1
  reboot
fi

exit
