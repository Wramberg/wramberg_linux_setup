#!/bin/bash

laptop="--output eDP-1"
dp1="--output DP-2-1"
dp2="--output DP-2-2"

case "$1" in
    "docked") xrandr $dp1 --auto $dp2 --auto --right-of DP-2-1 $laptop --off ;;
    *) xrandr --auto
esac

~/.fehbg
