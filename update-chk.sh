#!/bin/bash
mkdir -p /var/tmp/update-chk/                                               
LOG_FILE="/var/tmp/update-chk/$(date +"%Y_%m_%d_%I_%M_%p").log"
STATIC_LOG_FILE="/var/tmp/update-chk/lt_script_raw.log"
exec 3>&1 1>>${LOG_FILE} 2>&1
apt list --upgradable | column -s "/" -t| column -s "[" -t | tee /dev/fd/3
sed -i '/WARNING: apt does not have a stable CLI interface. Use with caution in scripts./d' $LOG_FILE 
sed -i '/Listing.../d' $LOG_FILE 
echo $LOG_FILE | tee /dev/fd/3

#Static needed for Automate. Leaving original for history. 
exec 3>&1 1>>${STATIC_LOG_FILE} 2>&1
apt list --upgradable | column -s "/" -t| column -s "[" -t | tee /dev/fd/3
sed -i '/WARNING: apt does not have a stable CLI interface. Use with caution in scripts./d' $STATIC_LOG_FILE
sed -i '/Listing.../d' $STATIC_LOG_FILE
echo $STATIC_LOG_FILE | tee /dev/fd/3
