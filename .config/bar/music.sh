#!/bin/bash
. ~/.config/bar/barconf
	check=$(ps aux | grep "mopidy" | grep -v grep)	
	stat=$(mpc -f %artist% | sed -n 2p | cut -d "[" -f2 | cut -d "]" -f1)
	while [[ -z "$check" ]]
	do 
		echo "No Music Playing" | lemonbar -g 120x22+632+5  -u 3 -f "Terminus (TTF):size=9" -f "FontAwesome:size=9" -B $BG -F $BBLK
	done
	while [ "$stat" = "" ] 
	do
		echo "No Music Playing" | lemonbar -g 120x22+632+5  -u 3 -f "Terminus (TTF):size=9" -f "FontAwesome:size=9" -B $BG -F $BBLK
	done
	while [ "$stat" = "paused" ]
	do
		echo $(mpc current) | skroll -n20 -d0.5 -r | lemonbar -g 120x22+632+5  -u 3 -f "Terminus (TTF):size=9" -f "FontAwesome:size=9" -B $BG -F $BBLK 
	done
	while [ "$stat" = "playing" ]
	do
		echo $(mpc current) | skroll -n20 -d0.5 -r | lemonbar -g 120x22+632+5  -u 3 -f "Terminus (TTF):size=9" -f "FontAwesome:size=9" -B $BG -F $BBLK 
	done
