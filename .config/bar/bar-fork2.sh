#!/bin/bash
## information bar
## colors and  fonts
. ~/.config/bar/barconf
## glyphs
glymem=""
glycpu=""
# glybat=""
glypkg=""
glyclock=""
glycal=""
glyint=""
glyw1=""
glyw2=""
glyw3=""
glyw4=""
glyw5=""
glyw6=""
glyw7=""
glyw=(I II III IV V VI VII)

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
		    echo %{F$FG}$glycpu%{F$MAG}$cpuload%{F-}
	  }
	  memory() {
		    mem=$(free -m | awk 'NR==2 {print $3}')
		    mem+="MB"
		    echo %{F$FG}$glymem$SEP%{F$MAG}$mem%{F-}
	  }
	  battery() {
			  bat=$(cat /sys/class/power_supply/BAT0/capacity)
			  batper="%"
			  rem=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "time\ to\ empty" | awk '{ print $4, $5}')
			  disc=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state" | awk '{ print $2}')
			  if [ $disc = "charging" ]; then
				    glybat=""
			  elif [ "$bat" -gt 75 ]; then
				    glybat=""
			  elif [ "$bat" -gt 50 ]; then
				    glybat=""
			  elif [ "$bat" -gt 25 ]; then
				    glybat=""
			  else
				    glybat=""
			  fi
			  echo %{F$FG}$glybat%{F$MAG}$SEP$bat$batper$SEP$rem$SEP%{F-t}
	  }
	  #    pkman() {
	  #        pkr=$(pacman -Qu | wc -l)
	  #        echo %{F$WHT}$glypkg$pkr$SEP${F-}
	  #    }
	  wireless() {
			  wl=$(ping -c 1 8.8.8.8 >/dev/null 2>&1 && 
			           echo ":)" || echo ":(")
			  echo %{F$FG}$glyint$SEP%{F$MAG}$wl$SEP${F-}
	  }	
	  vol() {
			  mut=$(pactl list sinks | grep Mute | awk '{print $2}')
			  if [ $mut = "yes" ]; then
				    vlm="0%"
				    glyvol=""
			  else
			      vlm=$(pactl list sinks | grep -m 1 Volume | awk '{print $5}')
			      glyvol=""
			  fi
		    echo %{F$FG}$glyvol$SEP%{F$MAG}$vlm$SEP${F-}
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
                tops[c]=%{F$FG}${all[c]}${F-}
            else
                tops[c]=%{F$MAG}${all[c]}${F-}
            fi
            c=$[$c+1]
        done
        echo ${tops[@]}
    }
    
	  music() {
		    check=$(ps aux | grep "mopidy" | grep -v grep)
		    stat=$(mpc -f %artist% | sed -n 2p | cut -d "[" -f2 | cut -d "]" -f1) 
    		if [[ -z "$check" ]]; then
			      mus="No Music Playing"
			      glymus=""
			      echo %{F$FG}$glymus$SEP%{F$MAG}$mus$SEP${F-}
		    elif [ "$stat" = "" ]; then
			      mus="No Music Playing"
			      glymus=""
			      echo %{F$FG}$glymus$SEP%{F$MAG}$mus${F-}
		    elif [ ""$stat"" = "paused" ]; then
			      glymus=""
			      curr=$(mpc current)
            curr+=" - "
            time=$(mpc -f %artist% | grep 2 | sed 's/^.*(//;s/)$//')
			      echo %{F$FG}$glymus$SEP%{F$MAG}$curr$time${F-}
			      #echo $curr
		    elif [ "$stat" = "playing" ]; then
			      glymus=""
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
	  echo "%{l}$SEP2$(workspaces)$SEP%{c}$SEP2$(memory)$SEP2$(battery)$SEP2$(wireless)$SEP2$(music)$SEP2$(vol)$SEP2%{r}$(clockdate)$SEP2$(clocktime)$SEP2"
}

## populate and display
#sleep 2 && popup "   :: dmtwm 1.0 ::   " 3 &
pamixer --get-volume # resolves no text at start bug
while true
do
	  echo "$(status)"
	  sleep 1
done | lemonbar -g $notifybar_g -u 3 -a 10 -f "-*-terminus-medium-*-normal-*-12-*-*-*-c-*-*-*" -f'-*-tamsyn-medium-r-normal-*-12-*-*-*-*-*-*-1' -f '-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1' -B $BG -F $WHT | sh

