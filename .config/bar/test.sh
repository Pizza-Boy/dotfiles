#!/bin/bash
## information bar
## colors and  fonts
. ~/.config/bar/barconf
## glyphs
  glymem=""
  glycpu=""
 # glybat=""
  glypkg=""
  glyclock=""
  glycal=""
  glyint=""
## extras
  SEPS=" - "
  SEP=" "
  SEP2="  "
  SEP4="    "
  SEP6="       "
  SEP8="        "
  SEP24="                        "
  ## information section
  status() {
      cpuld() {
          cpuload=$(echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')])
	  cpuload+="%"
          echo %{F$GRN}$glycpu$SEP$cpuload$SEP%{F-}
      }
      memory() {
          mem=$(free -m | awk 'NR==2 {print $3}')
          mem+="MB"
          echo %{F$RED}$glymem$SEP$mem$SEP%{F-}
      }
      battery() {
	        bat=$(cat /sys/class/power_supply/BAT0/capacity)
	        batper="%"
		rem=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "time\ to\ empty" | awk '{ print $4, $5}')
		disc=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state" | awk '{ print $2}')
		if [ $disc = "charging" ]; then
			glybat=""
		elif [ "$bat" -gt 75 ]; then
			glybat=""
		elif [ "$bat" -gt 50 ]; then
			glybat=""
		elif [ "$bat" -gt 25 ]; then
			glybat=""
		else
			glybat=""
		fi
	        echo %{F$YLW}$glybat$SEP2$bat$batper$SEP$rem$SEP%{F-t}
      }
      #    pkman() {
      #        pkr=$(pacman -Qu | wc -l)
      #        echo %{F$WHT}$glypkg$SEP$pkr$SEP${F-}
      #    }
      wireless() {
	        wl=$(ping -c 1 8.8.8.8 >/dev/null 2>&1 && 
		echo ":)" || echo ":(")
	        echo %{F$BBLK}$glyint$SEP$wl$SEP${F-}
      }	
      vol() {
	        mut=$(pamixer --get-mute)
	        if [ $mut = "true" ]; then
		          vlm="0"
		          glyvol=""
	        else
        	    vlm=$(pamixer --get-volume)
        	    glyvol=""
	        fi
          echo %{F$MAG}$glyvol$SEP$vlm$SEP${F-}
      }
       music() {
	check=$(ps aux | grep "mopidy" | grep -v grep)
	stat=$(mpc -f %artist% | sed -n 2p | cut -d "[" -f2 | cut -d "]" -f1)
	if [[ -z "$check" ]]; then
		mus="No Music Playing"
		glymus=""
		echo %{F$DCN}$glymus$SEP$mus$SEP${F-}
	elif [ "$stat" = "" ]; then
		mus="No Music Playing"
		glymus=""
		echo %{F$DCN}$glymus$SEP$mus${F-}
	elif [ ""$stat"" = "paused" ]; then
		glymus=""
		curr=$(mpc current)
		echo %{F$DCN}$glymus$SEP$curr${F-}
		#echo $curr
	elif [ "$stat" = "playing" ]; then
		glymus=""
		curr=$(mpc current)	
		echo %{F$DCN}$glymus$SEP$curr${F-}
		#echo $curr
	fi
      }

      workspaces() {
          all=($(bspc query --desktops))
          length=$(bspc query -D | wc -l)
          active=$(bspc query --desktops --desktop focused)
          c=0
          tops=""
          while [ $c -lt $length ]
          do
              if [ $active = ${all[c]} ]; then
                  tops[c]=%{F$BBLK}${all[c]}${F-}
              else
                  tops[c]=%{F$RED}${all[c]}${F-}
              fi
              c=$[$c+1]
          done
          echo ${tops[@]}
      }
      clockdate() {
	        clockd=%{F$GRN}$glycal$(date +%{F$GRN}' %d   %b')%{F-}
          clockt=%{F$CYN}$glyclock$(date +' %R')%{F-}
          echo $clockd
      }
      clocktime() {
          clockt=%{F$CYN}$glyclock$(date +' %R')%{F-}
          echo $clockt
      }
      echo "%{l}$SEP2$(workspaces)%{c}$SEP2$(cpuld)$SEP2$(memory)$SEP2$(battery)$SEP2$(wireless)$SEP2$(music)$SEP2$(vol)$SEP2%{r}$(clockdate)$SEP2$(clocktime)$SEP2"
  }

  ## populate and display
  #sleep 2 && popup "   :: dmtwm 1.0 ::   " 3 &
  pamixer --get-volume # resolves no text at start bug
  while true
  do
      echo "$(status)"
      sleep 1
  done | lemonbar -g $notifybar_g -u 3 -f "Terminus (TTF):size=9" -f "FontAwesome:size=9" -B $BG -F $WHT
