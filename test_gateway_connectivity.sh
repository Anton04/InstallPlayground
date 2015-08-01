#!/bin/bash

IP="192.168.1.1"

ping -c 1 $IP &> /dev/null

code=$?

#echo $code

if [ $code -eq 0 ] ; then
  echo  "Everythin OK"  
else
  echo "No connection to local network!"
  sleep 1 
  echo "Testing again in 120 sec"
  sleep 120
  
  ping -c 1 $IP &> /dev/null
  code=$?
  if [ $code -eq 0 ] ; then
    reboot
  fi
fi
