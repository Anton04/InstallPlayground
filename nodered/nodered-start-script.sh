#!/bin/bash
# /etc/init.d/nodered
# version 3 2015-05-10 (YYYY-MM-DD)
 
### BEGIN INIT INFO
# Provides:   nodered
# Required-Start: $local_fs $remote_fs screen-cleanup
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network
# Should-Stop:    $network
# Default-Start:  2 3 4 5
# Default-Stop:   0 1 6
# Short-Description:    Start nodered
# Description:    Starts the NodeRED server
### END INIT INFO
 
 #Settings
 SERVICE='red.js'


#Check the amount of memory awalible
MEMORY=`cat /proc/meminfo | grep MemTotal | awk '{ print $2 }'`
LIMIT=350000
OPTIONS=''

if [ `cat /proc/meminfo |grep MemTotal | awk '{ print $2 }'` -lt $LIMIT ]
        then
	OPTIONS=' --max-old-space-size=128'
fi

USERNAME='iot'
APP_PATH="/home/$USERNAME/node_modules/node-red"
HISTORY=1024
NODE_VERSION="0.10.37"
NODE="/home/$USERNAME/.nvm/v$NODE_VERSION/bin/node"
INVOCATION="$NODE $OPTIONS $SERVICE" 
ME=`whoami`
SERVICENAME=" ${0##*/} "
 
 as_user() {
   if [ "$ME" = "$USERNAME" ] ; then
     bash -c "$1"
   else
     su - $USERNAME -c "$1"
   fi
 }
 
 my_start() {
   echo "Starting $SERVICENAME"
   if  pgrep -u $USERNAME -f "$SERVICENAME" > /dev/null
   then
     echo "$SERVICE is already running!"
   else
     echo "Starting $SERVICENAME..."
     cd $APP_PATH
     as_user "cd $APP_PATH && screen -h $HISTORY -dmS $SERVICENAME $INVOCATION"
     sleep 7
     if pgrep -u $USERNAME -f "$SERVICENAME" > /dev/null
     then
       echo "$SERVICENAME is now running."
     else
       echo "Error! Could not start $SERVICENAME!"
     fi
   fi
 }
 
 
 my_stop() {
   if pgrep -u $USERNAME -f "$SERVICENAME" > /dev/null
   then
     echo "Stopping $SERVICENAME"
     #as_user "screen -p 0 -S nodered -X eval 'stuff \"say SERVER SHUTTING DOWN IN 10 SECONDS. Saving map...\"\015'"
     #as_user "screen -p 0 -S nodered -X eval 'stuff \"save-all\"\015'"
     ##sleep 10
     ##as_user "screen -p 0 -S minecraft -X eval 'stuff \"stop\"\015'"
     ##sleep 7
     pkill -u $USERNAME -f "$SERVICENAME"
     sleep 3
   else
     echo "$SERVICENAME was not running."
   fi
   if pgrep -u $USERNAME -f "$SERVICENAME" > /dev/null
   then
     echo "Error! $SERVICENAME could not be stopped."
   else
     echo "$SERVICENAME is stopped."
   fi
 } 
 


 
 #Start-Stop here
 case "$1" in
   start)
     my_start
     ;;
   stop)
     my_stop
     ;;
   restart)
     my_stop
     my_start
     ;;
   status)
     if pgrep -u $USERNAME -f $SERVICENAME > /dev/null
     then
       echo "$SERVICE is running."
     else
       echo "$SERVICE is not running."
     fi
     ;;
 
   *)
   echo "Usage: $0 {start|stop|update|backup|status|restart|command \"server command\"}"
   exit 1
   ;;
 esac
 
 exit 0
 
