#!/bin/bash
mkdir -p /var/tmp/update-chk/
LOG_FILE="/var/tmp/update-chk/$(date +"%Y_%m_%d_%I_%M_%p").log"
exec 3>&1 1>>${LOG_FILE} 2>&1
apt list --upgradable | column -s "/" -t| column -s "[" -t | tee /dev/fd/3
sed -i '/WARNING: apt does not have a stable CLI interface. Use with caution in scripts./d' $LOG_FILE 
sed -i '/Listing.../d' $LOG_FILE 
echo $LOG_FILE | tee /dev/fd/3
