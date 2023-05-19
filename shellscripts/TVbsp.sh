#!/bin/sh
# Run after start bspwm in the one

bspc monitor eDP-1 --remove
bspc monitor HDMI-2 -d 1 2 3 4 5 6 7 8 9
xrandr --output eDP-1 --off
