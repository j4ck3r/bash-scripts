#!/bin/bash
# Dmenu prompt for performing shutdown options and similar things
# Dependencies: dmenu

# Options: Declare names and the commands to be executed
declare -A options=(
    [Shutdown]="shutdown now"
    [Reboot]="reboot"
    [Cancel]=""
)

user_selection=$(printf "%s\n" "${!options[@]}" | dmenu -l ${#options[*]} -i)
if [[ $user_selection == "" ]] || [[ $user_selection == "Cancel" ]]
then
    exit 0
fi
notify-send "Executing ${user_selection}"
${options[$user_selection]}
