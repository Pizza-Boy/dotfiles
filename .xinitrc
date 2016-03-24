#exec dbus-launch --exit-with-session gnome-session
#exec xfce4-session
#exec openbox-session
sxhkd &
xsetroot -cursor_name -left_ptr &
exec bspwm
#export _JAVA_AWT_WM_NONREPARENTING=1
#exec awesome
#exec i3
#xrdb merge ~/.Xresources
#xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY &
#nitrogen --restore &
#/home/noah/bar/bar-fork2.sh
#compton &
#exec spectrwm

#Test--I'm fuckin around with 2bwm
#nitrogen --restore #set our background
#xrdb load ~/.Xresources #for urxvt
#2bwm & #WM
#exec urxvt #Don't kill this!
