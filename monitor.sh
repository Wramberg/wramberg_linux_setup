#!/bin/bash

fullhd1="--mode 1920x1200"
laptop="--output eDP-1"

case "$1" in
    "docked") xrandr --output DP-2-1 $fullhd1 --output DP-2-2 $fullhd1 --right-of DP-2-1 $laptop --off ;;
    *) xrandr --auto
esac

~/.fehbg
