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

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd

# xrandr --dpi 96
# xrandr --output eDP1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
# xrandr --output eDP1 --set full_aspect --pos 1920x0 --rotate normal --output DP1-1 --primary --set full_aspect --pos 0x0 --rotate normal

# picom &
sxhkd &
skippy-xd --start-daemon &
galaxybudsclient &
# xscreensaver &
start-pulseaudio-x11 &
nm-applet &
xbanish -s -t 5 &

# while feh --bg-fill --randomize --no-fehbg ~/Pictures/Wallpapers/buildings/*
# do
# 	sleep 360 # 6min
# done &

ibus-daemon --xim --daemonize --replace --desktop=xfce4 --replace &

# ibus
export GTK_IM_MODULE='ibus'
export QT_IM_MODULE='ibus'
export XMODIFIERS=@im='ibus'

# I dont use wayland >:(
export GDK_BACKEND=x11

# disable beeping
xset b off

# DWM
# xset s off # Disable screen saver blinking
# xset -dpms # Turns on display power management signaling (+dpms to turn on)
# slstatus &
# exec dwm
# exec dbus-run-session dwm

# CTWM
#xclock &
#xload &
#stalonetray --geometry 5x1-0+320 -bg "#808080" --window-strut none &
#exec ctwm

# LXDE
# exec startlxde

# XFCE4
exec startxfce4

# Lumina
# exec start-lumina-desktop

# Gnome
# export XDG_SESSION_TYPE=x11
# export GDK_BACKEND=x11
# exec gnome-session
