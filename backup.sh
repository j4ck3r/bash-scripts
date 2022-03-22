#!/bin/bash
# Backup to a drive with rsync

DRIVE_PATH="/mnt/usb1"
CONFIG_PATH="$HOME/.config/"
RSYNC_OPTIONS=" -a --delete --exclude-from='$HOM/.scripts/exclude-file.txt' "

if [ `which rsync` == "" ]
then
    echo "The script needs rsync in order to function..."
    exit 1
fi

rsync $RSYNC_OPTIONS $CONFIG_PATH $DRIVE_PATH 
