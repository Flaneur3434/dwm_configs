#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

sxhkd &

#dwm status bar

feh --bg-scale ~/Pictures/Wallpapers/random/calvin_and_hobbes_stars.jpeg &
xrandr --output eDP1 --mode 1920x1080 --pos 0x1079 --rotate normal --output DP1 --off --output DP1-1 --off --output DP1-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1-3 --off --output DP2 --off --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off &
start-pulseaudio-x11 &
picom &
slstatus &
flameshot &
nm-applet &
xscreensaver &

ibus
 export GTK_IM_MODULE=ibus
 export XMODIFIERS=@im=ibus
 export QT_IM_MODULE=ibus
 ibus-daemon -drx &
# while true; do
#    /usr/local/bin/dwm 2> /dev/null
#  done

xset s off # Disable screen saver blinking
xset -dpms # Turns on display power management signaling (+dpms to turn on)

exec dwm
# exec rio -term termite




