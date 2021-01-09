#!/bin/bash
#  _   _  ___ _  _ _  __
# | | | |/ __| || | |/ /
# | |_| | (__| __ | ' < 
#  \___/ \___|_||_|_|\_\
# Update-Check     
#                  
# Default Static Log   "/var/tmp/update-chk/lt_script_raw.log"
# Dynamic Log          "/var/tmp/update-chk/date_and_time.log"
#
# Run via Automate     "sh ./home/USERNAME/update-chk.sh"
##
mkdir -p /var/tmp/update-chk/                                                                                 #Make dir non-existent.
LOG_FILE="/var/tmp/update-chk/$(date +"%Y_%m_%d_%I_%M_%p").log"                                               #LOG File.
STATIC_LOG_FILE="/var/tmp/update-chk/lt_script_raw.log"                                                       #Static LOG for Automate.
exec 3>&1 1>>${LOG_FILE} 2>&1                                                                                 #Setting up to pipe output to log.
apt list --upgradable | column -s "/" -t| column -s "[" -t | tee /dev/fd/3                                    #The Meat and Potatos - running apt and parsing.
sed -i '/WARNING: apt does not have a stable CLI interface. Use with caution in scripts./d' $LOG_FILE         #Removing default apt warnings.
sed -i '/Listing.../d' $LOG_FILE                                                                              #Removing default apt msgs.
echo $LOG_FILE | tee /dev/fd/3                                                                                #Final pipe -> log.
#Static log needed for Automate. (Second line for ease of use/editability instead of using pipe method)
> $STATIC_LOG_FILE                                                                                            #Clear file if not overwritten on line 16.
exec 3>&1 1>>${STATIC_LOG_FILE} 2>&1
apt list --upgradable | column -s "/" -t| column -s "[" -t | tee /dev/fd/3
sed -i '/WARNING: apt does not have a stable CLI interface. Use with caution in scripts./d' $STATIC_LOG_FILE
sed -i '/Listing.../d' $STATIC_LOG_FILE
echo $STATIC_LOG_FILE | tee /dev/fd/3
