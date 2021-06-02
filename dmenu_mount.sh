#!/bin/bash
# Dmenu prompt to mount partitions/devices
# Dependencies: dmenu

# Options: Put in folders wich will be searched for possible mounting folders

folder_options=(
    "/mnt"
)
devices_available=$(lsblk -lnp | grep "part $"  | awk '{ print $1 " ("$4")"}')
device=$(echo "$devices_available" | dmenu -l 10 | awk '{ print $1 }')
if [[ -z $device ]]
then
    exit 0
fi
folders=$(find ${folder_options[@]} -maxdepth 2 -empty 2>/dev/null)
mount_point=$(echo "$folders" | dmenu -i)
if [[ ! -d $mount_point ]] 
then
    selection=$(echo -e "Yes \n No" | dmenu -i -p "The folder does not exist. Do you want to create it?")
    if [[ "$selection" == "Yes" ]] || [[ "$selection" == "yes" ]]
    then
        mkdir -p $folder
    else
        echo "Directory not created!"
        exit 1
    fi
fi
sudo mount $device $mount_point && notify-send "$device mounted at $mount_point"
