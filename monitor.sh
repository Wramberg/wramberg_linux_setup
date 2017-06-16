#!/bin/bash

work_screen_res="--mode 2560x1440"
laptop="--output eDP-1"
dp1="--output DP-2-1"
dp2="--output DP-2-2"

case "$1" in
    "docked") xrandr $dp1 $work_screen_res $dp2 $work_screen_res --right-of $dp1 $laptop --off ;;
    *) xrandr --auto
esac

~/.fehbg
