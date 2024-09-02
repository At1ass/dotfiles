#!/bin/bash

feh --recursive --randomize --bg-fill ~/wallpapers
picom -b
pulseaudio --start
killall -q udiskie
udiskie -a -n --tray
killall -q polybar
~/.config/polybar/launch.sh &
