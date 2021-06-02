#!/bin/bash
# Dmenu prompt to unmount partitions
# Depndencies: dmenu

mount_points=$(lsblk -lnp | grep " /.*$"  | awk '{ print $7 }')
to_unmount=$(echo "$mount_points" | dmenu -l 10 )
if [[ -z $to_unmount ]]
then
    exit 0
fi
device=$(lsblk -lnp | grep $to_unmount | awk '{ print $1 }')
sudo umount $to_unmount && notify-send "$device unmounted"
