#!/bin/bash
# Simple dmenu prompt to control the screen temperature
# Dependencies: dmenu, redshift

modes=(
"auto" 
"reset" 
"2500K" 
"3000K" 
"4000K" 
"5000K" 
"6000K" 
)
chosen="$(for i in ${modes[@]}; do echo $i; done | dmenu -p 'Screen Temperatur' -l ${#modes[@]})"
case "$chosen" in
	"auto")
		redshift -P -t 5000
		;;
	"reset")
		redshift -x
		;;
	"2500K")
		redshift -P -O 2500
		;;
	"3000K")
		redshift -P -O 3000
		;;
	"4000K")
		redshift -P -O 4000
		;;
	"5000K")
		redshift -P -O 5000
		;;
	"6000K")
		redshift -P -O 6000
		;;
esac
