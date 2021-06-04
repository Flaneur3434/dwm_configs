#! /usr/bin/bash
feh --bg-scale ~/Pictures/Wallpapers/buildings/hongkongAirplane.jpg &
xrandr --output eDP1 --mode 1920x1080 --pos 0x1079 --rotate normal --output DP1 --off --output DP1-1 --off --output DP1-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1-3 --off --output DP2 --off --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off &
start-pulseaudio-x11 &
compton --config ~/.config/compton.conf &

