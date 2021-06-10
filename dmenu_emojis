#!/bin/bash
# Prompt with dmenu to copy emoji
# Dependencies: dmenu, xclip

user_selection=$(cat $HOME/.scripts/emojis | dmenu -i -l 20 | awk '{ print $(NF) }')

if [[ ! -z $user_selection ]]
then
    $user_selection | xclip -selection clipboard
    notify-send '${$(xclip -o)} copied to clipboard'
fi
