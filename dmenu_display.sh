#!/bin/bash
# 
# Dmenu script to controll multiple displays (e.g. second screen of a laptop)
# Dependenices: xrander, dmenu

primary=$(xrandr --current | grep primary | awk '{ print $1 }')
if [[ -z $primary ]]
then
    exit 0
fi

connected=$(xrandr --current | grep \ connected | awk '{ print $1 }')
if [[ -z $connected ]]
then
    exit 0
fi

display=$(echo "$connected" | dmenu -p "Choose output: " -i)
if [[ -z $display ]]
then
    exit 0
fi

command="xrandr --output $display"

options=(
    "position" 
    "rotation"
    "off"
    "on"
)

options=$(for i in ${options[@]}; do echo $i; done | dmenu -i)
case $options in
    "position")
        declare -A positions=(
            [left]="--left-of $primary" 
            [right]="--right-of $primary" 
            [above]="--above $primary" 
            [below]="--below $primary" 
            [same]="--same-as $primary"
        )
        position=$(printf "%s\n" "${!positions[@]}" | dmenu -p "Position: " -i)
        if [[ ! -z $position ]]
        then
            command="$command ${positions[$position]}"
        fi
        $command
        ;;
    "rotation")
        declare -A rotations=(
            [normal]="--rotate normal" 
            [left]="--rotate left" 
            [right]="--rotate right" 
            [invert]="--rotate invert" 
        )
        rotation=$(printf "%s\n" "${!rotations[@]}" | dmenu -p "Position: " -i)
        if [[ ! -z $rotation ]]
        then
            command="$command ${rotations[$rotation]}"
        fi
        $command
        ;;
    "off")
        command="$command --off"
        $command
        ;;
    "on")
        command="$command --auto"
        $command
        ;;
esac
