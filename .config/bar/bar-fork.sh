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
glyw1=""
glyw2=""
glyw3=""
glyw4=""
glyw5=""
glyw6=""
glyw7=""
## extras
SEP=" - "
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
		    echo %{F$FG}$glycpu$SEP%{F$MAG}$cpuload$SEP%{F-}
	  }
	  memory() {
		    mem=$(free -m | awk 'NR==2 {print $3}')
		    mem+="MB"
		    echo %{F$FG}$glymem$SEP%{F$MAG}$mem$SEP%{F-}
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
			  echo %{F$FG}$glybat$SEP2%{F$MAG}$bat$batper$SEP$rem$SEP%{F-t}
	  }
	  #    pkman() {
	  #        pkr=$(pacman -Qu | wc -l)
	  #        echo %{F$WHT}$glypkg$SEP$pkr$SEP${F-}
	  #    }
	  wireless() {
			  wl=$(ping -c 1 8.8.8.8 >/dev/null 2>&1 && 
			           echo ":)" || echo ":(")
			  echo %{F$FG}$glyint$SEP%{F$MAG}$wl$SEP${F-}
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
		    echo %{F$FG}$glyvol$SEP%{F$MAG}$vlm$SEP${F-}
	  }
	  
	  workspaces () {
		    currentws=$(i3-msg -t get_workspaces | jq -r 'map(select(.focused))[0].num')
		    totalws=$(i3-msg -t get_workspaces | jq -r 'map(.num)' | tail -n2 | head -1)
		    wsstring=""
		    case $currentws in
			      1)
			          echo -e %{F$FG}${SEP24}$glyw1${SEP24}%{F}%{A:i3-msg workspace 2:}${SEP24}$glyw2${SEP24}%{A}%{A:i3-msg workspace 3:}${SEP24}$glyw3${SEP24}%{A}%{A:i3-msg workspace 4:}${SEP24}$glyw4${SEP24}%{A}%{A:i3-msg workspace 5:}${SEP24}$glyw5${SEP24}%{A}%{A:i3-msg workspace 6:}${SEP24}$glyw6${SEP24}%{A}%{A:i3-msg workspace 7:}${SEP24}$glyw7${SEP24}%{A}
			          ;;
			      2) 
			          echo %{A:i3-msg workspace 1:}${SEP24}$glyw1${SEP24}%{A}%{F$FG}${SEP24}$glyw2${SEP24}%{F}%{A:i3-msg workspace 3:}${SEP24}$glyw3${SEP24}%{A}%{A:i3-msg workspace 4:}${SEP24}$glyw4${SEP24}%{A}%{A:i3-msg workspace 5:}${SEP24}$glyw5${SEP24}%{A}%{A:i3-msg workspace 6:}${SEP24}$glyw6${SEP24}%{A}%{A:i3-msg workspace 7:}${SEP24}$glyw7${SEP24}%{A}
			          ;;
			      3)
			          echo %{A:i3-msg workspace 1:}${SEP24}$glyw1${SEP24}%{A}%{A:i3-msg workspace 2:}${SEP24}$glyw2${SEP24}%{A}%{F$FG}${SEP24}$glyw3${SEP24}%{F}%{A:i3-msg workspace 4:}${SEP24}$glyw4${SEP24}%{A}%{A:i3-msg workspace 5:}${SEP24}$glyw5${SEP24}%{A}%{A:i3-msg workspace 6:}${SEP24}$glyw6${SEP24}%{A}%{A:i3-msg workspace 7:}${SEP24}$glyw7${SEP24}%{A}
			          ;;
			      4)
			          echo %{A:i3-msg workspace 1:}${SEP24}$glyw1${SEP24}%{A}%{A:i3-msg workspace 2:}${SEP24}$glyw2${SEP24}%{A}%{A:i3-msg workspace 3:}${SEP24}$glyw3${SEP24}%{A}%{F$FG}${SEP24}$glyw4${SEP24}%{F}%{A:i3-msg workspace 5:}${SEP24}$glyw5${SEP24}%{A}%{A:i3-msg workspace 6:}${SEP24}$glyw6${SEP24}%{A}%{A:i3-msg workspace 7:}${SEP24}$glyw7${SEP24}%{A}
			          ;;
			      5)
			          echo %{A:i3-msg workspace 1:}${SEP24}$glyw1${SEP24}%{A}%{A:i3-msg workspace 2:}${SEP24}$glyw2${SEP24}%{A}%{A:i3-msg workspace${SEP24} 3:}${SEP24}$glyw3${SEP24}%{A}%{A:i3-msg workspace 4:}${SEP24}$glyw4${SEP24}%{A}%{F$FG}${SEP24}$glyw5${SEP24}%{F}%{A:i3-msg workspace 6:}${SEP24}$glyw6${SEP24}%{A}%{A:i3-msg workspace 7:}${SEP24}$glyw7${SEP24}%{A}
			          ;;
			      6)
			          echo %{A:i3-msg workspace 1:}${SEP24}$glyw1${SEP24}%{A}%{A:i3-msg workspace 2:}${SEP24}$glyw2${SEP24}%{A}%{A:i3-msg workspace${SEP24} 3:}${SEP24}$glyw3${SEP24}%{A}%{A:i3-msg workspace 4:}${SEP24}$glyw4${SEP24}%{A}%{A:i3-msg workspace 5:}${SEP24}$glyw5${SEP24}%{A}%{F$FG}${SEP24}$glyw6${SEP24}%{F}%{A:i3-msg workspace 7:}${SEP24}$glyw7${SEP24}%{A}
			          ;;
		        7)
		            echo %{A:i3-msg workspace 1:}${SEP24}$glyw1${SEP24}%{A}%{A:i3-msg workspace 2:}${SEP24}$glyw2${SEP24}%{A}%{A:i3-msg workspace${SEP24} 3:}${SEP24}$glyw3${SEP24}%{A}%{A:i3-msg workspace 4:}${SEP24}$glyw4${SEP24}%{A}%{A:i3-msg workspace 5:}${SEP24}$glyw5${SEP24}%{A}%{A:i3-msg workspace 6:}${SEP24}$glyw6${SEP24}%{A}%{F$FG}${SEP24}$glyw7${SEP24}%{F}
		            ;;
	          #	            8)
	          #	                echo "%{A:i3-msg workspace 1:}${SEP24}$glyw1${SEP24}%{A}%{A:i3-msg workspace 2:}${SEP24}$glyw2${SEP24}%{A}%{A:i3-msg workspace${SEP24} 3:}${SEP24}$glyw3${SEP24}%{A}%{A:i3-msg workspace 4:}${SEP24}$glyw4${SEP24}%{A}%{A:i3-msg workspace 5:}${SEP24}$glyw5${SEP24}%{A}%{A:i3-msg${SEP24}${SEP24}  workspace 6:}${SEP24}$glyw6${SEP24}%{A}%{A:i3-msg workspace 7:}${SEP24}${SEP24}%{A}%{F$FG}${SEP24}${SEP24}%{F}%{A:i3-msg workspace 9:}${SEP24}${SEP24}%{A}%{A:i3-msg workspace 10:}${SEP24}${SEP24}%{A}"
	          #	                ;;
	          #	            9)
	          #	                echo "%{A:i3-msg workspace 1:}${SEP24}$glyw1${SEP24}%{A}%{A:i3-msg workspace 2:}${SEP24}$glyw2${SEP24}%{A}%{A:i3-msg workspace${SEP24} 3:}${SEP24}$glyw3${SEP24}%{A}%{A:i3-msg workspace 4:}${SEP24}$glyw4${SEP24}%{A}%{A:i3-msg workspace 5:}${SEP24}$glyw5${SEP24}%{A}%{A:i3-msg${SEP24}${SEP24}  workspace 6:}${SEP24}$glyw6${SEP24}%{A}%{A:i3-msg workspace 7:}${SEP24}${SEP24}%{A}%{A:i3-msg workspace 8:}${SEP24}${SEP24}%{A}%{F$FG}${SEP24}${SEP24}%{F}%{A:i3-msg workspace 10:}${SEP24}${SEP24}%{A}"
	          #	                ;;
	          #	            10)
	          #	                echo "%{A:i3-msg workspace 1:}${SEP24}$glyw1${SEP24}%{A}%{A:i3-msg workspace 2:}${SEP24}$glyw2${SEP24}%{A}%{A:i3-msg workspace${SEP24} 3:}${SEP24}$glyw3${SEP24}%{A}%{A:i3-msg workspace 4:}${SEP24}$glyw4${SEP24}%{A}%{A:i3-msg workspace 5:}${SEP24}$glyw5${SEP24}%{A}%{A:i3-msg${SEP24}${SEP24}  workspace 6:}${SEP24}$glyw6${SEP24}%{A}%{A:i3-msg workspace 7:}${SEP24}${SEP24}%{A}%{A:i3-msg workspace 8:}${SEP24}${SEP24}%{A}%{A:i3-msg workspace 9:}${SEP24}${SEP24}%{A}%{F$FG}${SEP24}${SEP24}%{F}}"
	          #	                ;;
		    esac
	  }
	  music() {
		    check=$(ps aux | grep "mopidy" | grep -v grep)
		    stat=$(mpc -f %artist% | sed -n 2p | cut -d "[" -f2 | cut -d "]" -f1) 
    		if [[ -z "$check" ]]; then
			      mus="No Music Playing"
			      glymus=""
			      echo %{F$FG}$glymus$SEP%{F$MAG}$mus$SEP${F-}
		    elif [ "$stat" = "" ]; then
			      mus="No Music Playing"
			      glymus=""
			      echo %{F$FG}$glymus$SEP%{F$MAG}$mus${F-}
		    elif [ ""$stat"" = "paused" ]; then
			      glymus=""
			      curr=$(mpc current)
            curr+=" - "
            time=$(mpc -f %artist% | grep 2 | sed 's/^.*(//;s/)$//')
			      echo %{F$FG}$glymus$SEP%{F$MAG}$curr$time${F-}
			      #echo $curr
		    elif [ "$stat" = "playing" ]; then
			      glymus=""
			      curr=$(mpc current)
            curr+=" - "
            time=$(mpc -f %artist% | grep 2 | sed 's/^.*(//;s/)$//')
			      echo %{F$FG}$glymus$SEP%{F$MAG}$curr$time${F-}
			      #echo $curr
		    fi
	  }
	  clockdate() {
			  clockd=%{F$FG}$glycal%{F$MAG}$(date +%{F$MAG}' %d   %b')%{F-}
		    clockt=%{F$FG}$glyclock$%{F$MAG}$(date +' %R')%{F-}
		    echo $clockd
	  }
	  clocktime() {
		    clockt=%{F$FG}$glyclock%{F$MAG}$(date +' %R')%{F-}
		    echo $clockt
	  }
	  echo "%{c}$SEP2$(memory)$SEP2$(battery)$SEP2$(wireless)$SEP2$(music)$SEP2$(vol)$SEP2%{r}$(clockdate)$SEP2$(clocktime)$SEP2"
}

## populate and display
#sleep 2 && popup "   :: dmtwm 1.0 ::   " 3 &
pamixer --get-volume # resolves no text at start bug
while true
do
	  echo "$(status)"
	  sleep 1
done | lemonbar -u 3 -a 10 -f "Roboto Regular:size=10" -o 0 -f "FontAwesome:size=10" -o -2 -B $BG -F $WHT | sh
